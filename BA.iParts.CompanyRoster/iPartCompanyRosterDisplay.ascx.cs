using Asi;
using Asi.Web.UI.WebControls;
using Asi.Soa.ClientServices;
using Asi.Soa.Core.DataContracts;
using Asi.Soa.Membership.DataContracts;
using BA.IMIS.Common;
using BA.IMIS.Common.Data;
using Newtonsoft.Json;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Diagnostics;
using System.Linq;
using System.Net;
using System.Reflection;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Data;
using System.Data.SqlClient;
namespace BA.iParts.CompanyRoster
{
    public partial class iPartCompanyRosterDisplay : iPartDisplayBase
    {
        #region "BA:ModularVariables"
        private Company company = new Company();
        private string CoAdmin = null;
        private bool isCoAdmin = false;
        private string LoginId = null;
        #endregion "BA:ModularVariables"

        #region Event Handlers

        /* BEW I was never able to use OnLoad() or OnPreRender() and get changes to persist during runtime when published. Use CreateChildControls() instead. */
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);
            if (!IsPostBack)
                OneTimeInitializations();
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);
            if (DoNotRenderInDesignMode && IsContentDesignMode)
                HideContent = true;
            else
                HideContent = false;

            // TODO: Remove this and add your own business logic.
            if (ExampleShowUserId)
            {
                ExampleCurrentUser.Visible = false;
               // ExampleCurrentUser.Text = "Current UserID = " + AppContext.CurrentIdentity.LoginUserId                                                + "\t" + AppContext.CurrentIdentity.LoginIdentity;                
            }
            else
                ExampleCurrentUser.Visible = false;
        }

        protected override void CreateChildControls()
        {
            try 
            {
                base.CreateChildControls();

                if (!IsContentDesignMode)
                {
                    // BEW 20160428 - If you leave the call to InitCommandButtons() uncommented, there will be an edit button and a "more options" dropdown 
                    // that allows the user to edit the design in published mode. Probably NOT what you want....EVER!
                    //InitCommandButtons()

                    /* BEW IMPORTANT! You can treat PageLoad() as the "first available entry point" after which you can expect modifications to control values to persist at runtime. */
                    PageLoad(); 

                }
            }
            catch (Exception ex) {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        private void InitCommandButtons()
        {
            // This is SAMPLE code that shows how to add a command button to the header area, and how to add
            // an OPTIONAL command to the 'Options' dropdown.
            // Initialize command buttons and dropdown commands

            // Create an 'Edit' command button                
            // Note that the button images are specified in a .skin file, with a SkinID that matches the SkinID below     
            var commandItem = new PanelTemplateCommandItem
            {
                SkinID = "PanelCommandButtonEdit",
                ToolTip = "This is a tooltip for the edit command button",
                ClientScriptToExecute = @"javascript:ShowDialog('default.aspx', null, 400, 400, 'Edit', null, 'E', WindowEdit_Callback_" +
                ClientID + @", null, false, true, null, null);",
                ClientScriptToRender = @"
                    function WindowEdit_Callback_" + ClientID + @"(dialogWindow)
                    {                            
                        alert('Callback method for edit button is executing');
                    }"
            };
            PanelTemplateControl.Commands.Add(commandItem);

            var optionalCommandItem = new PanelTemplateOptionalCommandItem
            {
                Text = "Design",
                ToolTip = "This is a tooltip for the design option",
                ClientScriptToExecute = @"javascript:ShowDialog('default.aspx', null, 400, 400, 'Edit', null, 'E', WindowDesign_Callback_" +
                  ClientID + @", null, false, true, null, null);",
                ClientScriptToRender = @"
                    function WindowDesign_Callback_" + ClientID + @"(dialogWindow)
                    {                            
                        alert('Callback method for design option is executing');
                    }"
            };
            PanelTemplateControl.OptionalCommands.Add(optionalCommandItem);

        }

        #endregion

        /* SOME MANUAL COPYING AND MODIFICATION REQUIRED */
        #region "BA Custom Code"

        /* COPY AND MODIFY
         * BEW IMPORTANT! You can treat PageLoad() as the "first available entry point" after which you can expect modifications to control values to persist at runtime. */
        private void PageLoad()
        {
            try
            {
                /* BEW IMPORTANT! MANUALLY COPY anything from iPart{xxx}Display.PageLoad() into the Page_Load event of TestHarness.aspx.cs
                 * You will also have to make some other manual modifications such as: 
                 * Replace the FindControl("ControlID") routines from the iPart{xxx}Display.ascx.cs with GetControl(Page, "ControlID") in TestHarness.aspx.cs.
                 * Replace the AppContext.CurrentIdentity.xxx properties with debug values in TestHarness.aspx.cs.
                 * Replace the FilePathRoot argument of LoadStylesAndScripts(FilePathRoot). Usually this should be "~/" in TestHarness and "~/AsiCommon" in iPart{xxx}Display.ascx.cs
                 */

                /* DO NOT COPY - Note that ConfigScriptManagerAndWebService() is unnecessary in TestHarness because TestHarness knows where its ScriptManager/wsCompanyRoster.asmx are. */
                ConfigScriptManagerAndWebService();

                //Mike - Using "000000000" to just get all of the relationship types on load
                //DataTable dt = CompanyRosterShared.GetRosterRelationships("000000000", "000000000");
                //foreach (DataRow row in dt.Rows)
                //{
                //    ListItem newItem = new ListItem(row["DESCRIPTION"].ToString(), row["RELATION_TYPE"].ToString());
                //    ((CheckBoxList)FindControl("chklRoles")).Items.Add(newItem);


                //}

                company = Shared.GetParentCompany(AppContext.CurrentIdentity.LoginIdentity);
                company.Email = "info@brewersassociation.org"; //This is a lame shortcut in naming. We're always sending the email FROM info@brewersassociation.org instead of the company itself
                ((TextBox)FindControl("txtLoginID")).Text = AppContext.CurrentIdentity.LoginUserId;
                LoginId = AppContext.CurrentIdentity.LoginUserId;
                ((TextBox)FindControl("txtCompany")).Text = JsonConvert.SerializeObject(company);
                //CoAdmin string to bool: Yeah this sucks, but I need the string for JS
               
                EntityManager entityManager = new EntityManager();
                MembershipManager membershipManager = new MembershipManager(entityManager);
                CoAdmin = membershipManager.UpdatePermitted(company.IMIS_ID).ToString().ToLower();   
                //CoAdmin = AppContext.CurrentPrincipal.IsInRole("CompanyAdministrator").ToString().ToLower();

                ((TextBox)FindControl("txtIsCompanyAdmin")).Text = CoAdmin;
                isCoAdmin = Convert.ToBoolean(CoAdmin);
 
                //Load custom styles and scripts here
                LoadStylesAndScripts("~/AsiCommon");

                //RadTreeList will remember the view state of its expanded items if you store in a Session variable
                if (!Page.IsPostBack)
                {
                    var expandedIndexes = HttpContext.Current.Session["ExpandedIndexes"] as TreeListExpandedIndexesCollection;
                    if (expandedIndexes != null)
                    {
                        rtlRoster.ExpandedIndexes.AddRange(expandedIndexes);
                    }
                }                
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        /* DO NOT COPY - Note that ConfigScriptManagerAndWebService() is unnecessary in TestHarness because TestHarness knows where its ScriptManager/wsCompanyRoster.asmx are. */
        private void ConfigScriptManagerAndWebService()
        {
            try {
                /// Find ScriptManager
                Control parent = null;
                ScriptManager sm = null;
                List<ScriptManager> listSM = new List<ScriptManager>();
                int count = 0;
                do
                {
                    if (parent != null)
                    {
                        if (parent.Parent != null)
                        {
                            parent = parent.Parent;
                        }
                    }
                    else if (Parent != null)
                    {
                        parent = Parent;
                    }
                    if (parent != null)
                    {
                        FindControlsByType<ScriptManager>(parent, listSM);
                    }
                    if (listSM.Any()) sm = listSM.First();
                    if (sm != null || Parent == null)
                    {
                        break;
                    }
                    count++;
                } while (count < 100); //don't go forever

                // Add web service reference to ScriptManager
                string webServicePath = Page.ResolveClientUrl("~/iParts/BACustom/CompanyRoster/wsCompanyRoster.asmx");
                ((TextBox)FindControl("txtWSPath")).Text = webServicePath;
                if (sm != null)
                {
                    ServiceReference sr = new ServiceReference(webServicePath);
                    sm.Services.Add(sr);
                }
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        #endregion


        /*************************************************************************************
         * BEW Put all events (page events, control events such as Telerik RadGrid_whatever), 
         * and all common code that gets called from PageLoad() 
         * into this special region so they get copied over to TestHarness.aspx.cs during build.
         VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV*/
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

        protected void btnRole_Click(object sender, EventArgs e)
        {

            TreeListDataItem item = rtlRoster.SelectedItems[0];
            DataTable dt = CompanyRosterShared.GetRosterRelationships("900045199", company.IMIS_ID);
            foreach (DataRow row in dt.Rows)
            {
                ListItem newItem = new ListItem(row["DESCRIPTION"].ToString(), row["RELATION_TYPE"].ToString());
                ((CheckBoxList)FindControl("chklRoles")).Items.Add(newItem);


            }
        }

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
        /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
         ***************************************************************************************/


        #region Properties

        // TODO: Remove this example property, and add your configuration properties here.

        /// <summary>
        /// Enables/disables the display of the current user.
        /// </summary>
        public bool ExampleShowUserId
        {
            get
            {
                if (ViewState["ExampleShowUserId"] == null)
                    return true;

                return (bool)ViewState["ExampleShowUserId"];
            }
            set
            {
                ViewState["ExampleShowUserId"] = value;
            }
        }


        #endregion

        #region Methods

        /// <summary>
        /// Create the appropriate object
        /// </summary>
        /// <returns></returns>
        public override Asi.Business.ContentManagement.ContentItem CreateContentItem()
        {
            var item = new iPartCompanyRosterCommon { ContentItemKey = ContentItemKey };
            return item;
        }

        /// <summary>
        /// Logic that will execute on initial page load
        /// </summary>
        private void OneTimeInitializations()
        {
            try
            {
            }
            catch (Exception ex)
            {
                DisplayError(MethodInfo.GetCurrentMethod().Name, ex.Message);
            }
        }

        #endregion

        #region Method Overrides

        /// <summary>
        /// Called on the connection consumer. This method will act on the object passed in from
        /// the connection provider.
        /// </summary>
        /// <param name="providerObject">Object passed in from the connection provider.</param>
        public override void SetObjectProviderData(Object providerObject)
        {
            // TODO: If this iPart is to be a connection consumer, add code here to act on the
            // object passed in from the connection provider. Note that other connection types 
            // are available, see SetAtomObjectProviderData, SetUniformKeyProviderData, 
            // SetStringKeyProviderData.
        }

        /// <summary>
        /// Called on the connection provider. 
        /// </summary>
        /// <returns>An object that will be acted on by the connection consumer.</returns>
        public override Object GetObjectProviderData()
        {
            // TODO: If this iPart is to be a connection provider, add code here to return
            // an object that will be acted on by the connection consumer. Note that other connection 
            // types are available, see GetAtomObjectProviderData, GetUniformKeyProviderData, 
            // GetStringKeyProviderData.
            return null;
        }

        #endregion Method Overrides

        #region Static Methods

        #endregion


    }
}