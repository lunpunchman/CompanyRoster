using BA.IMIS.Common;
using BA.IMIS.Common.Data;
using BA.iParts.CompanyRoster;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Threading;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data.SqlClient;

namespace BA.iParts.TestHarness
{
    public partial class WebForm1 : System.Web.UI.Page
    {

        #region "BA:ModularVariables"
        private Company company = new Company();
        private string CoAdmin = null;
        private bool isCoAdmin = false;
        private string LoginId = null;
        #endregion "BA:ModularVariables"

        #region "BA Custom Code"

        protected void Page_Load(object sender, EventArgs e)
        {
            Shared.LogError(new Exception("Hello World"));
            /* BEW IMPORTANT! MANUALLY COPY anything from iPart{xxx}Display.PageLoad() into the Page_Load event of TestHarness.aspx.cs
             * You will also have to make some other manual modifications such as: 
             * Replace the FindControl("ControlID") routines from the iPart{xxx}Display.ascx.cs with GetControl(Page, "ControlID") in TestHarness.aspx.cs.
             * Replace the AppContext.CurrentIdentity.xxx properties with debug values in TestHarness.aspx.cs.
             * Replace the FilePathRoot argument of LoadStylesAndScripts(FilePathRoot). Usually this should be "~/" in TestHarness and "~/AsiCommon" in iPart{xxx}Display.ascx.cs
             */

            /* BEW Note that ConfigScriptManagerAndWebService() is unnecessary in TestHarness because TestHarness knows where its ScriptManager/wsCompanyRoster.asmx are. */
            txtWSPath.Text = ResolveClientUrl("~/wsCompanyRoster.asmx");

            //Mike - Using "000000000" to just get all of the relationship types on load
            //DataTable dt = CompanyRosterShared.GetRosterRelationships("000000000", "000000000");
            //foreach (DataRow row in dt.Rows)
            //{
            //    ListItem newItem = new ListItem(row["DESCRIPTION"].ToString(), row["RELATION_TYPE"].ToString());
            //    ((CheckBoxList)GetControl(Page, "chklRoles")).Items.Add(newItem);


            //}

            //TODO: Pass your IMIS_ID to GetParentCompany. Do not pass the HQ IMIS_ID because you are supposed to be an EMP that is a Company Admin.
            //company = Shared.GetParentCompany("900128128"); //Mashed
            //company = Shared.GetParentCompany("000185299"); //Mashed Gabej
            company = SQL.GetParentCompany("900198647"); //BikeBun
            ((TextBox)GetControl(Page, "txtRosterCount")).Text = CompanyRosterShared.GetRosterCount("900045200");
            //company = SQL.GetParentCompany("900203419"); //DESIHALL/brewer for Shop type
            //((TextBox)GetControl(Page, "txtRosterCount")).Text = CompanyRosterShared.GetRosterCount("900204077");
            //company = Shared.GetParentCompany("900097963"); //Mashtun

            company.Email = "info@brewersassociation.org"; //This is a lame shortcut in naming. We're always sending the email FROM info@brewersassociation.org instead of the company itself
            //TODO: Pass your login ID
            ((TextBox)GetControl(Page, "txtLoginID")).Text = "bikebun"; //Mashed
            LoginId = "bikebun";
            //((TextBox)GetControl(Page, "txtLoginID")).Text = "babrentw";
            //((TextBox)GetControl(Page, "txtEmail")).Text = "brentw@brewersassociation.org"; //BEW DEBUG Set this if you get tired of typing your "TO" email address when testing
            ((TextBox)GetControl(Page, "txtCompany")).Text = JsonConvert.SerializeObject(company);

            //CoAdmin string to bool: Yeah this sucks, but I need the string for JS
            //TODO: CoAdmin comes from AppContext in iMIS, but in TestHarness, you decide. Only set false if you want to test the "No Company Roster" message
            CoAdmin = "true"; 
            ((TextBox)GetControl(Page, "txtIsCompanyAdmin")).Text = CoAdmin;
            isCoAdmin = Convert.ToBoolean(CoAdmin);
            
            //Load custom styles and scripts here
            LoadStylesAndScripts("~/");

            //SqlCommand cmd = new SqlCommand("spba_GetRosterRelationships");
            //cmd.CommandType = CommandType.StoredProcedure;
            //DataTable dt = SQL.ExecuteSPTable(cmd);
            ////((TextBox)GetControl(Page, "txtIsCompanyAdmin")).Text = CoAdmin;
            //foreach (DataRow row in dt.Rows)
            //{
            //    ListItem newItem = new ListItem(row["DESCRIPTION"].ToString(), row["RELATION_TYPE"].ToString());
            //    ((CheckBoxList)GetControl(Page, "chklRoles")).Items.Add(newItem);
            //}


            //RadTreeList will remember the view state of its expanded items if you store in a Session variable
            if (!Page.IsPostBack)
            {
                var expandedIndexes = Session["ExpandedIndexes"] as TreeListExpandedIndexesCollection;
                if (expandedIndexes != null)
                {
                    rtlRoster.ExpandedIndexes.AddRange(expandedIndexes);
                }
            }
        }

        private Control GetControl(Control Parent, string ControlID)
        {
            foreach (Control ctl in Parent.Controls)
            {
                Debug.Print(ctl.ID);
                if (ctl.ID == ControlID)
                {
                    return ctl;
                }
                Control innerCtl = GetControl(ctl, ControlID);
                if (innerCtl != null) return innerCtl;
            }
            return null;
        }

        #endregion

        #region "BA:ReplaceiPartCSEvents"

        /* Page events */
        protected void Page_PreRender(object sender, EventArgs e)
        {
            try
            {
                HttpContext.Current.Session["ExpandedIndexes"] = rtlRoster.ExpandedIndexes;
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        /* Page events - technically LoadStylesAndScripts is not an event but it is a required method that gets called from PageLoad, which is a page event. */
        private void LoadStylesAndScripts(string FilePathRoot)
        {
            try
            {
                //Get the topmost Parent control
                Control parentControl = Page;
                while (parentControl.Parent != null && parentControl.Parent.Page != null)
                {
                    parentControl = parentControl.Parent;
                }

                //CSS
                Dictionary<string, string> links = new Dictionary<string, string>();
                //BEW 20160502 Do not load bootstrap.min.css here because there is a conflict with various classes (e.g., panel-title, h2) that causes things like the AspenSprite.png to look wrong...that is, if you continue to use the Aspen theme....so I created a derivative theme called AspenBA, which has its own copy of the bootstrap.min.css with special overrides at the bottom! ARGH!)
                //links.Add("CompanyRosterCSS", FilePathRoot + "/StyleSheets/bootstrap.min.css");
                //links.Add("SomeOtherCSS", FilePathRoot + "/StyleSheets/someOther.min.css");
                foreach (var link in links)
                {
                    HtmlLink objLink = new HtmlLink();
                    objLink.ID = link.Key;
                    objLink.Attributes["rel"] = "stylesheet";
                    objLink.Attributes["type"] = "text/css";
                    objLink.Href = link.Value;
                    parentControl.Page.Header.Controls.Add(objLink);
                }

                //JS
                Dictionary<string, string> js = new Dictionary<string, string>();
                js.Add("bootstrap", FilePathRoot + "/Scripts/bootstrap.min.js"); 
                //js.Add("SomeOtherJS", FilePathRoot + "/Scripts/someOther.min.js");
                foreach (var j in js)
                {
                    if (!parentControl.Page.ClientScript.IsClientScriptIncludeRegistered(j.Key))
                        parentControl.Page.ClientScript.RegisterClientScriptInclude(j.Key,
                            parentControl.Page.ResolveUrl(j.Value));
                }
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }



        /* Control events (e.g., Telerik) */
        protected void grdInvitations_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
        {
            try {
                (sender as RadGrid).DataSource = CompanyRosterShared.GetInvitees(company.IMIS_ID, isCoAdmin);
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }

        }

        protected void grdInvitations_PreRender(object sender, EventArgs e)
        {
            try {
                RadGrid grdInvitations = sender as RadGrid;
                if (grdInvitations.MasterTableView.Items.Count > 0)
                {
                    grdInvitations.MasterTableView.GetColumn("InvitationID").Visible = false;
                    grdInvitations.Rebind();
                }
                //BEW FIX THIS - Was trying to improve the "You do not have a Company Roster" functionality when item count == 0, but this didn't work.
                //If we do proceed with this, I will have to alter CopyASCX to automatically replace FindControl with GetControl, while avoiding replacement the GridDataItem.FindControl as in ItemDataBound() below.
                //((TextBox)FindControl("txtItemCount")).Text = grdInvitations.MasterTableView.Items.Count.ToString();
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        protected void grdInvitations_ItemDataBound(object sender, GridItemEventArgs e)
        {
            try {
                if (e.Item is GridDataItem)
                {
                    GridDataItem item = (GridDataItem)e.Item;
                    string invitationID = DataBinder.Eval(item.DataItem, "InvitationID").ToString() ?? String.Empty;
                    HiddenField hf = (HiddenField)item.FindControl("hfInvitationID");
                    if (hf != null)
                    {
                        hf.Value = invitationID;
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        protected void rtlRoster_NeedDataSource(object sender, TreeListNeedDataSourceEventArgs e)
        {
            try {
                rtlRoster.DataSource = CompanyRosterShared.GetCompanyRoster(company, isCoAdmin);
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        protected void rtlRoster_ItemDataBound(object sender, TreeListItemDataBoundEventArgs e)
        {
            try
            {
                if (e.Item is TreeListDataItem)
                {
                    TreeListDataItem item = (TreeListDataItem)e.Item;
                    var parentID = DataBinder.Eval(item.DataItem, "ParentID");
                    if (parentID == null) //null parentID means this is a company
                    {
                        //so hide the edit & delete controls
                        ((CheckBox)item["OptOutTNB"].Controls[0]).Visible = false;
                        foreach (LinkButton lnk in item["TNBEditor"].Controls)
                        {
                            lnk.Visible = false;
                        }
                        ((ImageButton)item["DeleteRoster"].Controls[0]).Visible = false;
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }

        }

        protected void rtlRoster_Load(object sender, EventArgs e)
        {
            try 
            {
                if (!Page.IsPostBack)
                {
                    var rtlRoster = (sender as RadTreeList);
                    if (rtlRoster.Items.Count > 0)
                    {
                        if (HttpContext.Current.Session["PageInitialized"] == null)
                        {
                            HttpContext.Current.Session["PageInitialized"] = true;
                            rtlRoster.ExpandAllItems();
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        protected void rtlRoster_UpdateCommand(object sender, TreeListCommandEventArgs e)
        {
            try 
            {
                OrderedDictionary newValues = new OrderedDictionary();
                TreeListEditableItem editedItem = e.Item as TreeListEditableItem;
                e.Item.OwnerTreeList.ExtractValuesFromItem(newValues, editedItem, true);
                byte optOutTNB = Convert.ToByte(newValues["OptOutTNB"]);
                string childIMIS_ID = GetChildIMIS_ID(e.Item as TreeListDataItem);
                //Perform the update via SQL stored procedure
                SQL.UpdateTNBOptOut(childIMIS_ID, optOutTNB);
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        protected void rtlRoster_EditCommand(object sender, TreeListCommandEventArgs e)
        {
            //BEW FIX THIS? - Maybe it would be nice to change backcolor of the OptOutTNB column for the row being edited
            //rtlRoster.Items[2].Cells[3].BackColor = System.Drawing.Color.DarkGreen;
            
        }

        protected void rtlRoster_DeleteCommand(object sender, TreeListCommandEventArgs e)
        {
            CompanyRosterShared.DeleteFromRoster(GetChildIMIS_ID(e.Item as TreeListDataItem), LoginId);
        }

        private string GetChildIMIS_ID(TreeListDataItem item)
        {
            try {
                //BEW FIX THIS? ChildIMIS_ID COLUMN It's LAME that telerik doesn't make it easy to find a way to access the DataRow's Cell values by name, so we have to access it by numeric index. 
                //Fortunately this is easy as long as it is always the LAST column in the grid.
                return item.Cells[item.Cells.Count - 1].Text;
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
            return String.Empty;
        }

        //protected void btnRole_Click(object sender, EventArgs e)
        //{

        //    TreeListDataItem item = rtlRoster.SelectedItems[0];
        //    DataTable dt = CompanyRosterShared.GetRosterRelationships("900045199", company.IMIS_ID);
        //    foreach (DataRow row in dt.Rows)
        //    {
        //        ListItem newItem = new ListItem(row["DESCRIPTION"].ToString(), row["RELATION_TYPE"].ToString());
        //        ((CheckBoxList)FindControl("chklRoles")).Items.Add(newItem);


        //    }
        //}

        //BEW DEBUG ONLY
        private void DisplayError(string MethodName, string Message)
        {
            TextBox txtErrors = (TextBox)FindControl("txtErrors");
            if (MethodName != String.Empty)
            {
                txtErrors.Text = "An error occurred in " + MethodName + ": " + Message;
            }
            else
            {
                txtErrors.Text = String.Empty;
            }
        }

        #endregion "BA:ReplaceiPartCSEvents"

    }
}