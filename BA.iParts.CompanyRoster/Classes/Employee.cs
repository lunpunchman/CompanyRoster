using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BA.iParts.CompanyRoster
{
    public class Employee
    {
        private int? _parentID;
        private int _itemID;
        private string _childIMIS_ID;
        private string _fullName;
        private string _email;
        private string _memberType;
        private bool? _optOutTNB;
        private bool? _isCompany;


        public Employee(int? ParentID, int ItemID, string ChildIMIS_ID, string FullName, string Email, string MemberType, bool? OptOutTNB, bool? isCompany)
        {
            _parentID = ParentID;
            _itemID = ItemID;
            _childIMIS_ID = ChildIMIS_ID;
            _fullName = FullName;
            _email = Email;
            _memberType = MemberType;
            _optOutTNB = OptOutTNB;
            _isCompany = isCompany;
        }

        public int? ParentID { 
            get { return this._parentID; }
        }

        public int ItemID { 
            get { return this._itemID; } 
        }

        public string ChildIMIS_ID
        {
            get
            {
                return this._childIMIS_ID;
            }
            set
            {
                this._childIMIS_ID = value;
            }
        }

        public string FullName
        {
            get
            {
                return this._fullName;
            }
            set
            {
                this._fullName = value;
            }
        }

        public string Email
        {
            get
            {
                return this._email;
            }
            set
            {
                this._email = value;
            }
        }

        public string MemberType
        {
            get
            {
                return this._memberType;
            }
            set
            {
                this._memberType = value;
            }
        }

        public bool? OptOutTNB
        {
            get
            {
                return this._optOutTNB;
            }
            set
            {
                this._optOutTNB = value;
            }
        }

        public bool? isCompany
        {
            get
            {
                return this._isCompany;
            }
            set
            {
                this._isCompany = value;
            }
        }

    }
}
