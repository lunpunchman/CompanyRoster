using BA.IMIS.Common;
using BA.IMIS.Common.Data;
using BA.iParts.CompanyRoster;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Services;

namespace BA.iParts.CompanyRoster.WebServices
{
    [WebService(Namespace = "BA.iParts.CompanyRoster")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class wsCompanyRoster : System.Web.Services.WebService
    {
        [WebMethod]
        public string SendInvitation(string SentByLoginID, string FromEmail, string ToEmailAddresses, string IMIS_ID, string CompanyName)
        {
            try
            {
                return JsonConvert.SerializeObject(CompanyRosterShared.SendRosterEmail(SentByLoginID, FromEmail, ToEmailAddresses, IMIS_ID, CompanyName));
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }

        [WebMethod]
        public string DeleteInvitation(int InvitationID)
        {
            try
            {
                SQL.InsertUpdateInvitation(InvitationID: InvitationID, Disabled: true);
                return JsonConvert.SerializeObject("Deleted invitation successfully.");
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }

        [WebMethod]
        public string GetEmployeeInfo(string IMIS_ID)
        {
            try
            {
                return JsonConvert.SerializeObject(CompanyRosterShared.GetEmployeeInfo(IMIS_ID));
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }

        [WebMethod]
        public string GetRelationshipInfo(string IMIS_ID, string CO_IMIS_ID)
        {
            try
            {
                return JsonConvert.SerializeObject(CompanyRosterShared.GetRosterRelationships(IMIS_ID, CO_IMIS_ID));
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }

        [WebMethod]
        public string SaveRelationshipInfo(string IMIS_ID, string CO_IMIS_ID, string[] Relationships, string LoginID)
        {
            try
            {
                return JsonConvert.SerializeObject(CompanyRosterShared.SaveRosterRelationships(IMIS_ID, CO_IMIS_ID, Relationships, LoginID));
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }

        [WebMethod]
        public string GetRelationshipCount(string IMIS_ID, string RELATION_TYPE)
        {
            try
            {
                return JsonConvert.SerializeObject(CompanyRosterShared.GetRelationshipCount(IMIS_ID, RELATION_TYPE));
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }

        [WebMethod]
        public string GetRelationshipCount(string IMIS_ID)
        {
            try
            {
                return JsonConvert.SerializeObject(CompanyRosterShared.GetRelationshipCount(IMIS_ID));
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }

        [WebMethod]
        public string MoveEmployee(string IMIS_ID, string CO_IMIS_ID, string LoginID, int Move)
        {
            try
            {
                return JsonConvert.SerializeObject(CompanyRosterShared.MoveEmployee(IMIS_ID, CO_IMIS_ID, LoginID, Move));
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }

        [WebMethod]
        public string GetCompanyRelationships(string IMIS_ID)
        {
            try
            {
                return JsonConvert.SerializeObject(CompanyRosterShared.GetCompanyRelationships(IMIS_ID));
            }
            catch (Exception ex)
            {
                return JsonConvert.SerializeObject(ex.Message);
            }
        }
    }
}
