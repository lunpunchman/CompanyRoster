using System;
using System.Runtime.Serialization;
using Asi;
using Asi.Business.ContentManagement;
using Asi.Business.ContentManagement.ContentType;
using BA.IMIS.Common;

//TODO: Name of the .NET assembly that contains the class that implements this content type.
namespace BA.iParts.CompanyRoster
{    
    /// <summary>
    /// Implements base logic for the CompanyRoster iPart.
    /// </summary>
    [DataContract(Name = "iPartCompanyRosterCommon")]
    [KnownType(typeof(BA.iParts.CompanyRoster.iPartCompanyRosterCommon))] //TODO: Name of the serializable class within the assembly that implements this content type. Fully qualified name with namespace.
    public class iPartCompanyRosterCommon : iPartCommonBase
    {
        private readonly bool mIsNew;

        #region Constructors

        /// <summary>
        /// Creates a new iPartCompanyRosterCommon object.
        /// </summary>
        public iPartCompanyRosterCommon()
        {
            mIsNew = true;

            // TODO: Remove this, and set your property default values here.
            ExampleShowUserId = true;
        }

        /// <summary>
        /// Creates a new iPartCompanyRosterCommon object.
        /// </summary>
        /// <param name="contentKey"></param>
        public iPartCompanyRosterCommon(Guid contentKey) : base(contentKey) { }

        #endregion

        #region Properties

        /// <summary>
        /// Gets the ContentTypeKey for the ContentTypeRegistry object that represents this content type.
        /// </summary>
        public override Guid ContentTypeKey
        {
            get
            {
                // TODO: Define your Content Type in iMIS (Content Manager->Maintenance->Content types)
                // TODO: Once the Content Type is defined, copy and paste its ContentKey value to BA.IMIS.Common in the ContentTypes Dictionary.
                return new Guid(Shared.ContentTypes["CompanyRoster"]);
            }
        }

        /// <summary>
        /// Whether this is a newly created ContentItem or not.
        /// </summary>
        public override bool IsNew
        {
            get
            {
                return mIsNew;
            }
        }

        // TODO: Remove this example property, and add your configuration properties here...

        /// <summary>
        /// Example configuration option. Enables/disables the display of the current user. 
        /// </summary>
        [DataMember(Name = "ExampleShowUserId")]
        public bool ExampleShowUserId { get; set; }



        #endregion Properties

        #region Methods

        /// <summary>
        /// Reads current Property values
        /// </summary>
        /// <returns></returns>
        public override ContentParameterCollection GetCurrentParameterValues()
        {
            ContentParameterCollection collection = base.GetCurrentParameterValues();
            // TODO: Remove this line, and add a line for each of your configuration properties
            collection.Add("ExampleShowUserId", ExampleShowUserId);

            return collection;
        }

        /// <summary>
        /// Configure and set display for CONFIGURATION PAGE
        /// </summary>
        /// <param name="ap"></param>
        public override void ConfigureAtomProperty(Asi.Atom.AtomProperty ap)
        {
            base.ConfigureAtomProperty(ap);

            switch (ap.Name)
            {
                // TODO: Remove this 'case' and add a 'case' for each of your configuration properties.
                case "ExampleShowUserId":
                    ap.Caption = ResourceManager.GetPhrase("Asi.Web.iParts.ExampleShowUserId",
                        "Enable display of the current user ID.");
                    break;
                default:
                    break;

            }
        }

        #endregion

        #region Static Methods

        #endregion

    }

}
