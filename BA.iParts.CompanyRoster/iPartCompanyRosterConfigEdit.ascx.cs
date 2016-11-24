using Asi.Web.UI.WebControls;

//TODO: The "ConfigEdit" control is the one that satisfies the following RiSE > Maintenance > Content Type > Advanced Properties setup:
//URL to the control or page that is used to collect the properties of a new item of this type.
//URL to the control or page that is used to edit the properties of an existing item of this type. This is often the same as the NewLink.
namespace BA.iParts.CompanyRoster
{
    public partial class iPartCompanyRosterConfigEdit : iPartEditBase
    {
        /// <summary>
        /// Name of atom component that this control will bind to.
        /// </summary>
        public override string AtomComponentName
        {
            get
            {
                // TODO: This must match the 'Name of the Content Type' defined on the Content Type in
                // TODO: 'Content Manager->Maintenance->Content types'
                return "CompanyRoster";
            }
        }

    }
}