using Asi;
using Asi.Web.UI.WebControls;
using Asi.Soa.ClientServices;
using Asi.Soa.Core.DataContracts;
using Asi.Soa.Membership.DataContracts;
using BA.IMIS.Common;
using BA.IMIS.Common.Data;
using BA.IMIS.Common.Extensions;
using BA.iParts.Crypto;
using log4net;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
[assembly: log4net.Config.XmlConfigurator(Watch = true)]

namespace BA.iParts.CompanyRoster
{
    public class CompanyRosterShared
    {
        private static readonly ushort maxEmails = 5;
        
        private static readonly log4net.ILog logger = log4net.LogManager.GetLogger(MethodBase.GetCurrentMethod().DeclaringType);

        public static string SendRosterEmail(string SentByLoginID, string FromEmail, string ToEmailAddresses, string IMIS_ID, string CompanyName)
        {
            StringBuilder sbResults = new StringBuilder();
            try
            {
                ToEmailAddresses = ToEmailAddresses.Replace(" ", String.Empty); //MIKE: Trimming email addresses here because spaces are causing issues
                if (ToEmailAddresses.Trim() == String.Empty)
                {
                    sbResults.Append("Please specify one or more email addresses to search for, separating each by a semi-colon.");
                }
                else if (IMIS_ID.Trim() == String.Empty)
                {
                    sbResults.Append("Could not find IMIS ID.");
                }
                else if (CompanyName.Trim() == String.Empty)
                {
                    sbResults.Append("Could not find Company Name.");
                }
                else
                {
                    string[] toEmails = ToEmailAddresses.Split(';').Where(e => e.Trim().Length > 0).ToArray(); //Only get the non-zero-length emails (after the Split operation).
                    if (toEmails.Count() <= maxEmails)
                    {
                        List<string> emailLines = new List<string>();
                        emailLines.Add("You are invited to establish (or reassociate) an account with Brewers Association on behalf of {0}.");
                        emailLines.Add("Please click the link below to proceed with the registration process:");
                        List<string> validEmails = new List<string>();
                        List<InvalidEmail> invalidEmails = new List<InvalidEmail>();
                        foreach (string toEmail in toEmails)
                        {
                            string invalidReason = String.Empty;
                            GenericEntityData result = SOA.GetIQAResults("$/JoinNow/FindParentCompanyByEmail", toEmail).FirstOrDefault();
                            if (result != null && result.GetEntityProperty("CompanyID") == IMIS_ID)
                            {
                                invalidEmails.Add(new InvalidEmail { Email = toEmail, Reason = String.Format("This email is already associated with {0}.", CompanyName) });
                            }
                            else if (!RegexUtilities.IsValidEmail(toEmail))
                            {
                                invalidEmails.Add(new InvalidEmail { Email = toEmail, Reason = "The format of this email address is invalid." });
                            }
                            else if (validEmails.Contains(toEmail))
                            {
                                invalidEmails.Add(new InvalidEmail { Email = toEmail, Reason = "Cannot send to the same email address more than once." });
                            }
                            else
                            {
                                //Valid emails are here
                                string decryptedMessage = String.Empty;
                                BACrypto bac = new BACrypto(Shared.rosterRegRootURL);
                                string encryptedLink = bac.GetAuthenticationLink(IMIS_ID, toEmail, out decryptedMessage);
                                SQL.InsertUpdateInvitation(SentByLoginID: SentByLoginID,
                                                            IMIS_ID: IMIS_ID,
                                                            Email: toEmail,
                                                            EncryptedLink: encryptedLink,
                                                            DecryptedLink: decryptedMessage);
                                if (Shared.SendEmail("Invitation from Brewers Association - Join Now",
                                            FromEmail,
                                            toEmail,
                                            GetPlainTextEmailBody(emailLines, toEmail, IMIS_ID, CompanyName, encryptedLink),
                                            GetHTMLEmailBody(emailLines, toEmail, IMIS_ID, CompanyName, encryptedLink)))
                                {
                                    validEmails.Add(toEmail);
                                }
                                else 
                                {
                                    sbResults.Append("An error occurred in ").Append(MethodInfo.GetCurrentMethod().Name).Append(". Could not process request.");
                                }
                            }
                        }
                        if (validEmails.Any())
                        {
                            sbResults.Append("<strong>An invitation was sent to the following email address")
                                     .Append(validEmails.Count() > 1 ? "es" : String.Empty)
                                     .Append(":</strong><br/><ul>");
                            foreach (string e in validEmails)
                            {
                                sbResults.Append(e.ToListItem());
                            }
                            sbResults.Append("</ul>");
                        }
                        if (invalidEmails.Any())
                        {
                            if (sbResults.Length > 0) sbResults.Append("<br/>");
                            sbResults.Append("<strong>Could not send email to the following invalid address")
                                     .Append(invalidEmails.Count() > 1 ? "es" : String.Empty)
                                     .Append(":</strong><br/><ul>");
                            foreach (InvalidEmail e in invalidEmails)
                            {
                                sbResults.Append("<li>").Append(e.Email).Append(" (").Append(e.Reason).Append(")</li>");
                            }
                            sbResults.Append("</ul>");
                        }
                    }
                    else
                    {
                        sbResults.Append("Cannot send invitation to more than ").Append(maxEmails).Append(" email addresses at one time.");
                    }
                }
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
                sbResults.Append("An error occurred in ").Append(MethodInfo.GetCurrentMethod().Name).Append(". Could not process request.");
            }
            return sbResults.ToString();
        }

        private static string GetPlainTextEmailBody(List<string> EmailLines, string EmailAddress, string IMIS_ID, string CompanyName, string AuthLink)
        {
            string body = String.Empty;
            try
            {
                for (int x = 0; x < EmailLines.Count(); x++)
                {
                    if (x == 0)
                    {
                        body += String.Format(EmailLines[x], CompanyName);
                    }
                    else
                    {
                        body += EmailLines[x];
                    }
                    body += Environment.NewLine;
                }
                body += AuthLink;
                body += Environment.NewLine + Constants.BA_TEXT_FOOTER;
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
            }
            return body;
        }

        private static string GetHTMLEmailBody(List<string> EmailLines, string EmailAddress, string IMIS_ID, string CompanyName, string AuthLink)
        {
            string body = "<html><body>";
            try
            {
                for (int x = 0; x < EmailLines.Count(); x++)
                {
                    body += "<p>";
                    if (x == 0)
                    {
                        body += String.Format(EmailLines[x], CompanyName);
                    }
                    else
                    {
                        body += EmailLines[x];
                    }
                    body += "</p>";
                }
                body += "<a href='" + AuthLink + "' target='_blank'>" + Shared.rosterRegRootURL + "</a>";
                body += "<footer><p>" + Constants.BA_HTML_FOOTER + "</p></footer>";
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
            }
            body += "</body></html>";
            return body;
        }

        public static DataTable GetRosterRelationships(string IMIS_ID, string CO_IMIS_ID)
        {

            SqlCommand cmd = new SqlCommand("spba_GetRosterRelationships");
            cmd.CommandType = CommandType.StoredProcedure;
            //DataTable dt = SQL.ExecuteSPTable(cmd);
            cmd.Parameters.AddWithValue("@ID", IMIS_ID);
            cmd.Parameters.AddWithValue("@CO_ID", CO_IMIS_ID);
            return SQL.ExecuteSPTable(cmd);

        }

        public static string SaveRosterRelationships(string IMIS_ID, string CO_IMIS_ID, string[] Relationships, string LoginID)
        {
            string result = "Relationships Saved";
            DataTable dt = new DataTable();
            dt.Columns.Add("RELATION_TYPE");
            foreach (string s in Relationships)
            {
                dt.Rows.Add(s);
            }
            SqlCommand cmd = new SqlCommand("spba_UpdateRosterRelationships");
            cmd.CommandType = CommandType.StoredProcedure;
            //DataTable dt = SQL.ExecuteSPTable(cmd);
            cmd.Parameters.AddWithValue("@TARGET_ID", IMIS_ID);
            cmd.Parameters.AddWithValue("@ID", CO_IMIS_ID);
            cmd.Parameters.AddWithValue("@Relationships", dt);
            cmd.Parameters.AddWithValue("@LoginID", LoginID);
            result = SQL.ExecuteSPScalar(cmd).ToString();

            int number;
            if (Int32.TryParse(result, out number))
                result = "Save Successful";
            return result;
        }

        public static string GetRosterCount(string IMIS_ID)
        {
            SqlCommand cmd = new SqlCommand("spba_GetRosterCount");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMIS_ID", IMIS_ID);
            return SQL.ExecuteSPScalar(cmd);
        }

        public static DataTable GetCompanyRoster(string IMIS_ID)
        {
            SqlCommand cmd = new SqlCommand("spba_GetCompanyRoster");
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@IMIS_ID", IMIS_ID);
            return SQL.ExecuteSPTable(cmd);
        }

        public static ArrayList GetCompanyRoster(Company company, bool IsCoAdmin)
        {
            /* PURPOSE: To return a hierarchical ArrayList datasource that is specific to Telerik's RadTreeList control. */
            ArrayList employees = new ArrayList();
            try
            {
                if (!IsCoAdmin)
                {
                    return employees;
                }
                else if (company.IMIS_ID != null && company.Name != null)
                {
                    int itemID = 1;
                    int childCompanyID = 0;
                    int parentIMIS_ID = 0;
                    int HQ_IMIS_ID = Convert.ToInt32(company.IMIS_ID);
                    int intChildIMIS_ID = -1;
                    string empIMIS_ID = null;
                    string memberType = String.Empty;
                    string emailAddress = String.Empty;
                    bool getParentFullName = false;
                    bool optOutTNB = false;
                    DataTable results = GetCompanyRoster(company.IMIS_ID);
                    List<int> childCompanyIDs = new List<int>();
                    //Add top-most parent company tree node here
                    employees.Add(new Employee(null, HQ_IMIS_ID, HQ_IMIS_ID.ToString(), company.Name.ToBold(), String.Empty, company.MemberType, false, true));
                    //Loop through the IQA results and assign to various tree nodes
                    foreach (DataRow row in results.Rows)
                    {
                        bool isCompany = Convert.ToBoolean(row["IsCompany"].ToString());
                        childCompanyID = Convert.ToInt32(row["IMIS_ID"].ToString());

                        //if this is a company and we haven't added a tree node for it yet
                        if (isCompany && !childCompanyIDs.Contains(childCompanyID))
                        {
                            childCompanyIDs.Add(childCompanyID);
                            employees.Add(
                                new Employee(null, childCompanyID,
                                    childCompanyID.ToString(),
                                    row["Company"].ToString().ToBold(),
                                    row["Email"].ToString(),
                                    row["ParentMemberType"].ToString(),
                                    null,
                                    isCompany
                                )
                            );
                            //reset itemID, which only has to be unique for each parentID (in the tree list)
                            itemID = 0;
                            //if this record has a ChildIMIS_ID, then it is also an employee (or other subordinate member) of the child company, so add a child item to the same node we just added 
                            empIMIS_ID = row["ChildIMIS_ID"].ToString();
                            if (Int32.TryParse(empIMIS_ID, out intChildIMIS_ID))
                            {
                                employees.Add(
                                    new Employee(childCompanyID, ++itemID,
                                        empIMIS_ID,
                                        GetFullName(row, false),
                                        row["ChildEmail"].ToString(),
                                        row["ChildMemberType"].ToString(),
                                    Convert.ToBoolean(row["ChildOptOutTNB"].ToString()), false
                                    )
                                );
                            }
                        }
                        else
                        {
                            if (isCompany)
                            {
                                parentIMIS_ID = childCompanyID;
                                empIMIS_ID = row["ChildIMIS_ID"].ToString();
                                getParentFullName = false;
                                emailAddress = row["ChildEmail"].ToString();
                                memberType = row["ChildMemberType"].ToString();
                                optOutTNB = Convert.ToBoolean(row["ChildOptOutTNB"].ToString());
                            }
                            else
                            {
                                parentIMIS_ID = HQ_IMIS_ID;
                                empIMIS_ID = row["IMIS_ID"].ToString();
                                getParentFullName = true;
                                emailAddress = row["Email"].ToString();
                                memberType = row["ParentMemberType"].ToString();
                                optOutTNB = Convert.ToBoolean(row["ParentOptOutTNB"].ToString());
                            }
                            employees.Add(
                                new Employee(parentIMIS_ID, ++itemID,
                                    empIMIS_ID,
                                    GetFullName(row, getParentFullName),
                                    emailAddress,
                                    memberType,
                                    optOutTNB,
                                    false
                                )
                            );
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
            }
            return employees;
        }

        private static string GetFullName(DataRow data, bool Parent)
        {
            try
            {
                string prefix = (Parent) ? "Parent" : "Child";
                return data[prefix + "LastName"].ToString() + ", " + data[prefix + "FirstName"].ToString();
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
            }
            return String.Empty;
        }

        public static DataTable GetInvitees(string IMIS_ID, bool IsCompanyAdmin)
        {
            if (IsCompanyAdmin)
            {
                SqlCommand cmd = new SqlCommand("spba_GetCompanyRosterInvitees");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IMIS_ID", IMIS_ID);
                return SQL.ExecuteSPTable(cmd);
            }
            else
            {
                return new DataTable();
            }
        }

        public static EmployeeInfo GetEmployeeInfo(string IMIS_ID)
        {
            try
            {
                GenericEntityData result = Shared.GetEmployeeInfo(IMIS_ID);
                if (result != null)
                {
                    return new EmployeeInfo
                    {
                        FullAddress = result.GetEntityProperty("FullAddress").Replace("\r", "<br/>"),
                        Title = result.GetEntityProperty("Title")
                    };
                }
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
            }
            return new EmployeeInfo();
        }

        public static void DeleteFromRoster(string IMIS_ID, string SentByLoginID)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("spba_DeleteFromRoster");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@IMIS_ID", IMIS_ID);
                cmd.Parameters.AddWithValue("@SentByLoginID", SentByLoginID);
                SQL.ExecuteSPNonQuery(cmd); 
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
            }
        }

        public static int GetRelationshipCount(string IMIS_ID, string RELATION_TYPE)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("spba_GetRelationshipCount");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", IMIS_ID);
                cmd.Parameters.AddWithValue("@RELATION_TYPE", RELATION_TYPE);

                return Convert.ToInt32(SQL.ExecuteSPScalar(cmd));
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
            }
            return 0;
        }

        public static RelationshipCount GetRelationshipCount(string IMIS_ID)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("spba_GetRelationshipCount");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", IMIS_ID);
                cmd.Parameters.AddWithValue("@RELATION_TYPE", "");
                return SQL.Modelize<RelationshipCount>(SQL.ExecuteSPTable(cmd)).FirstOrDefault();
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
                return new RelationshipCount();
            }
        }

        public static List<Relationship> GetCompanyRelationships(string IMIS_ID)
        {
            try
            {
                SqlCommand cmd = new SqlCommand("spba_GetCompanyRelationships");
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@ID", IMIS_ID);
                return SQL.Modelize<Relationship>(SQL.ExecuteSPTable(cmd));
            }
            catch (Exception ex)
            {
                Shared.LogError(ex);
                return new List<Relationship>();
            }
        }

        public static string MoveEmployee(string IMIS_ID, string CO_IMIS_ID, string LoginID, int Move)
        {
            string result = "Relationships Saved";
            SqlCommand cmd = new SqlCommand("spba_MoveEmployee");
            cmd.CommandType = CommandType.StoredProcedure;
            //DataTable dt = SQL.ExecuteSPTable(cmd); //Test
            cmd.Parameters.AddWithValue("@TARGET_ID", IMIS_ID);
            cmd.Parameters.AddWithValue("@ID", CO_IMIS_ID);
            cmd.Parameters.AddWithValue("@LoginID", LoginID);
            cmd.Parameters.AddWithValue("@MoveRelationships", Move);
            result = SQL.ExecuteSPScalar(cmd).ToString();

            int number;
            if (Int32.TryParse(result, out number))
                result = "Success!";
            return result;
        }
    }
}