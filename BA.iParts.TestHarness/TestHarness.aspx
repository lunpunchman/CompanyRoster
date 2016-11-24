<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="TestHarness.aspx.cs" Inherits="BA.iParts.TestHarness.WebForm1" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="asiweb" Assembly="Asi.Web" Namespace="Asi.Web.UI.WebControls" %>
<%--<%@ Register TagPrefix="BA" TagName="CompanyRosterCtrl" Src="~/iPartCompanyRosterDisplay.ascx" %>--%>

<asp:Content ID="ContentHeader" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="ContentBody" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- BEW FIX THIS?: 20150724 I got to this point in trying to reverse engineer a test harness that will display an iPart! It ostensibly loads w/o errors but it doesn't show anything where the iPart control should be! -->
    <!--<div style="border: 1px solid black; padding: 10px 10px 10px 10px;">-->
        <%--<BA:CompanyRosterCtrl runat="server" id="CompanyRosterCtl"></BA:CompanyRosterCtrl>--%>
    <!--</div>-->


    <!--WARNING: Do not remove the BA:ReplaceIPartASCX comment/tags or put any code in between them. Markup/script code from the iPart project will be copied into the space between these tags.-->
    <!--<BA:ReplaceIPartASCX>-->
<style>
    .ba-hidden {
        display: none;
    }

    .divStatus {
        margin-top: -10px;
        height: 200px;
        overflow-y: auto;
        border: 1px solid #ccc;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
        box-shadow: inset 0 1px 1px rgba(0,0,0,0.075);
        -webkit-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
        transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
    }

    .full-width {
        width: 100%;
    }

    .divRosterContainer, .divNoRoster {
        padding: 10px 10px 10px 10px;
    }

    .divEmpInfo {
        position: absolute;
        width: 400px;
        height: 200px;
        font-size: 12px;
        text-align: left;
        padding-top: 25px;
        top: 0;
        left: 0;
        display: none;
    }

    .empInfoWell {
        min-height: 20px;
        padding: 19px;
        margin-bottom: 20px;
        background-color: #c5c5c5;
        border: 1px solid #b3b3b3;
        border-radius: 4px;
        -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,0.05);
        box-shadow: inset 0 1px 1px rgba(0,0,0,0.05);
    }

    .divEmpInfo > div {
        width: 100%;
    }

    .txtTitle {
        font-weight: normal;
    }

    .childIMIS_ID {
        display: none; /* Only for IE11. Chrome & FF work just with <telerik:TreeListBoundColumn HeaderStyle-Width="0"> */
    }

    .modal-open .modal {
        outline: none !important; /* Only for Chrome, prevent blue vertical lines on left/right of modal when open */
    }

    td.fullName {
        cursor: pointer;
    }

        td.fullName:hover {
            text-decoration: underline;
        }
</style>

<script>
    //NOTE: As of IMIS20.1, you have to use "jQuery." instead of "$." as the jQuery shortcut

    var empInfoTimer;

    jQuery(document).ready(function () {
        try {
            if (toggleVisibility()) {
                var doc = jQuery(document);
                doc.on("click", ".btnSendInvitation", btnSendInvitationClick);
                //doc.on("click", ".btnAddContact", function () { return showInvitationModal(); });
                doc.on("click", ".btnAddContact", function () { return showInvitationModal(); });
                doc.on("shown.bs.modal", ".invitationModal", initModal);
                doc.on("hidden.bs.modal", ".invitationModal", hideModal);
                doc.on("click", ".btnMangeRole", function () { return getRelationships() });
                doc.on("click", ".btnMoveEmp", function () { return getCompanyList() });
                doc.on("click", ".btnSavleRole", btnSaveRoleClick);
                doc.on("shown.bs.modal", ".roleModal", initModal);
                doc.on("hidden.bs.modal", ".roleModal", hideModal);
                doc.on("shown.bs.modal", ".levelModal", initModal);
                doc.on("hidden.bs.modal", ".levelModal", hideModal)
                doc.on("click", ".fullName", function (e) { getEmployeeInfo(e, jQuery(this)); });
                doc.on("click", ".btnDeleteRoster", function () { return confirmDeleteRoster(jQuery(this)); });
                doc.on("click", ".btnSaveLocation", showLevelConfirmModal);
                doc.on("shown.bs.modal", ".levelConfirmModal", initModal);
               
                doc.on("click", ".btnCancelLevelConfirm", function () { return cancelModal(jQuery(".levelConfirmModal")); });
            }
        }
        catch (err) { displayError(err); }
    });

    function showAlert(msg, modal, success) {
        var alert = (modal == undefined) ? jQuery(".alert-grid") : jQuery(".alert-modal");
        jQuery(".alert").toggleClass("alert-danger", success !== true);
        jQuery(".alert").toggleClass("alert-success", success === true);
        alert.fadeIn();
        alert.html(msg);
    }

    function hideAlert() {
        var alert = jQuery(".alert");
        alert.fadeOut();
        alert.html("");
    }

    function confirmDeleteRoster($this) {
        return confirm("Are you sure you want to delete '" +
                        $this.closest("tr").find(".fullName").prop("innerHTML") +
                        "' from your roster?");
    }

    function showLevelConfirmModal() {
        try {
            // var result = getRelationships(selectedId);

            jQuery(".modal-content").removeClass("ba-hidden");
            var modal = jQuery(".levelConfirmModal");
            modal.appendTo("body").modal("show"); //only for IE11 to work properly in iMIS
            modal.css("overflow-y", "hidden"); //only for IE11 to work properly in iMIS
        }
        catch (err) { displayError(err); }
    }

    function cancelModal(modal) {
        try {
            // var result = getRelationships(selectedId);

            //jQuery(".modal-content").addClass("ba-hidden");
            //var modal = jQuery(".levelConfirmModal");
            modal.modal("hide"); //only for IE11 to work properly in iMIS
        }
        catch (err) { displayError(err); }
    }
    function getDecodedHTML(input) {
        return jQuery("<div/>").html(input).text();
    }

    function getEmployeeInfo(e, $this) {
        try {
            var parent = $this.parent();
            var td = parent.find(".childIMIS_ID");
            if (td.length > 0) {
                var IMIS_ID = getDecodedHTML(td.prop("innerHTML")).trim();
                if (IMIS_ID.length > 0) {
                    var fullNameCell = parent.find(".fullName");
                    var fullName = fullNameCell.prop("innerHTML");
                    jQuery.ajax({
                        url: jQuery(".txtWSPath").val() + "/GetEmployeeInfo",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        data: "{ 'IMIS_ID': '" + IMIS_ID + "' }",
                        success: function (result) {
                            showEmployeeInfo(e, result, fullNameCell, IMIS_ID);
                        },
                        error: function (err) {
                            displayAjaxError(err);
                        }
                    });
                }
            }
        }
        catch (err) { displayError(err); }
    }

    function getRelationships() {
        try {
            if (hasRowsSelected()) {
                //var treeList = $find(jQuery(".rtlRoster")[0].id);
                //var selectedIndex = treeList.get_selectedIndexes();
                //var row = selectedIndex[0];

                //var selectedId = getCellByColumnUniqueName(treeList.getItem(row), "ID").innerText;
                //jQuery(".txtSelectedId").val(selectedId);

                var company = jQuery.parseJSON(jQuery(".txtCompany").val());

                var isCompany = jQuery(".txtIsCompany");

                if (isCompany == "True") {
                    showAlert("Roles can only be assinged to employees");
                    return false;
                }

                var resultData;
                jQuery.ajax({
                    url: jQuery(".txtWSPath").val() + "/GetRelationshipInfo",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    //data: "{ 'IMIS_ID': 900045199, 'CO_IMIS_ID': 900045200 }",
                    data: "{ 'IMIS_ID': '" + jQuery(".txtSelectedId").val() + "', " +
                            "'CO_IMIS_ID': '" + company.IMIS_ID + "' }",
                    success: function (result) {
                        //alert("Got Relaiontships");
                        resultData = JSON.parse(result.d);
                        showRelationshipInfo(resultData);
                        //return result;
                    },
                    error: function (err) {
                        displayAjaxError(err);
                    }
                });
            }
        }
        catch (err) { displayError(err); }
        return false;
    }

    function btnSaveRoleClick() {
        try {
            
            var company = jQuery.parseJSON(jQuery(".txtCompany").val());
            //alert("company");
            var container = jQuery(".cblist");
            //alert("container");
            var values = jQuery('input:checkbox:checked.chkRoles').map(function () {
                return this.id;
            }).get();
            //alert("values");
            var relationships = JSON.stringify(values);
            var dataJson = { IMIS_ID: jQuery(".txtSelectedId").val(), CO_IMIS_ID: company.IMIS_ID, Relationships: values, LoginID: jQuery(".txtLoginID").val() }
            var dataJsonString = JSON.stringify(dataJson);
            //alert(dataJsonString);
            jQuery.ajax({
                url: jQuery(".txtWSPath").val() + "/SaveRelationshipInfo",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                //data: "{ 'IMIS_ID': 900045199, 'CO_IMIS_ID': 900045200 }",
                data: dataJsonString,
                success: function (result) {
                    //alert("Hello World");
                    updateRStatus(result);
                },
                error: function (err) {
                    //alert("Error World");
                    displayAjaxError(err);
                }
            });
            //clear email and status
            jQuery(".divRStatus").html("");
        }
        catch (err) { displayError(err); }
        //alert("Return World");
        return false;
    }
    function showRelationshipInfo(relationships) {
        try {
            var roleModal = jQuery(".roleModal");
            var container = jQuery(".cblist");
            for (var i = 0; i < relationships.length; i++) {
                var cbox = '<input type=checkbox id="' + relationships[i].RELATION_TYPE + '" class="chkRoles" value="' + relationships[i].DESCRIPTION + '" ' + convertToChecked(relationships[i].IsRole) + '> ' + relationships[i].DESCRIPTION + '<br>';
                jQuery(cbox).appendTo(container);
            }
            showRoleModal();
        }
        catch (err) { displayError(err); }
    }

    function convertToChecked(n) {
        return (n == 1) ? 'checked' : '';
    }

    function showEmployeeInfo(e, result, fullNameCell, IMIS_ID) {
        try {
            var divEmpInfo = jQuery(".divEmpInfo");
            divEmpInfo.css("display", "none");
            window.clearTimeout(empInfoTimer);
            var empInfo = jQuery.parseJSON(result.d);
            jQuery("lblIMIS_ID").text(IMIS_ID);
            jQuery(".txtFullName").text(fullNameCell.prop("innerHTML"));
            jQuery(".txtTitle").text(empInfo.Title);
            jQuery(".divAddress").html(empInfo.FullAddress);
            var divRosterContainer = jQuery("#divRosterContainer");
            var containerTop = (divRosterContainer.length > 0) ? divRosterContainer.offset().top : 0;
            var containerLeft = (divRosterContainer.length > 0) ? divRosterContainer.offset().left : 0;
            divEmpInfo.css("top", fullNameCell.offset().top - containerTop);
            divEmpInfo.css("left", fullNameCell.offset().left - containerLeft + fullNameCell.width());
            divEmpInfo.show("fade", null, 1000);
            empInfoTimer = setTimeout(hideEmployeeInfo, 3000);
        }
        catch (err) { displayError(err); }
    }

    function hideEmployeeInfo() {
        try {
            jQuery(".divEmpInfo").hide("fade", null, 1000);
        }
        catch (err) { displayError(err); }
    }

    function showInvitationModal() {
        try {
            jQuery(".modal-content").removeClass("ba-hidden");
            var modal = jQuery(".invitationModal");
            modal.appendTo("body").modal("show"); //only for IE11 to work properly in iMIS
            modal.css("overflow-y", "hidden"); //only for IE11 to work properly in iMIS
        }
        catch (err) { displayError(err); }
        return false;
    }

    function showRoleModal() {
        try {
            // var result = getRelationships(selectedId);

            jQuery(".modal-content").removeClass("ba-hidden");
            var modal = jQuery(".roleModal");
            modal.appendTo("body").modal("show"); //only for IE11 to work properly in iMIS
            modal.css("overflow-y", "hidden"); //only for IE11 to work properly in iMIS
        }
        catch (err) { displayError(err); }
        return false;
    }

    function showLevelModal() {
        try {
            // var result = getRelationships(selectedId);

            jQuery(".modal-content").removeClass("ba-hidden");
            var modal = jQuery(".levelModal");
            modal.appendTo("body").modal("show"); //only for IE11 to work properly in iMIS
            modal.css("overflow-y", "hidden"); //only for IE11 to work properly in iMIS
        }
        catch (err) { displayError(err); }
        return false;
    }

    function hasRowsSelected() {
        var hasSelected = false;

        jQuery.each(jQuery(".chkSelect"), function (i, chk) {
            if (isChecked(jQuery(chk))) {
                hasSelected = true;
                return false;
            }
        });
        if (!hasSelected) showAlert("Please select one employee.");
        return hasSelected;
    }

    function isChecked(chk) {
        try {
            var checkBox = chk.find("input:checkbox");
            return (checkBox != null && checkBox.is(":checked"));
        }
        catch (err) { displayError(err); }
    }

    function hideModal() {
        try {
            jQuery(".modal-content").addClass("ba-hidden");
            location.reload();
        }
        catch (err) { displayError(err); }
    }

    function initModal() {
        try {
            var modal = jQuery("body .modal");
            modal.css("width", jQuery(window).width() / 2); //only for IE11 to work properly in iMIS
            modal.css("left", ((jQuery(window).width() - modal.width()) / 2) + "px");
        }
        catch (err) { displayError(err); }
    }


    function toggleVisibility() {
        try {
            var hasNoInvitations = jQuery(".grdInvitations").find(".rgNoRecords").length > 0;
            jQuery(".divInvitations").toggleClass("ba-hidden", hasNoInvitations);
            var company = jQuery.parseJSON(jQuery(".txtCompany").val());
            var coAdmin = jQuery(".txtIsCompanyAdmin").val();
            var itemCount = jQuery(".txtItemCount").val();
            //if (itemCount == 0 || company == null || company.IMIS_ID == null || coAdmin == "false") { //"itemCount == 0" condition should work but for some reason itemCount is 0 in the document.ready call, even when there are records
            if (company == null || company.IMIS_ID == null) {
                jQuery(".divNoRoster").removeClass("ba-hidden");
                return false;
            }
            else if (coAdmin == "false") {
                jQuery(".divNoAccess").removeClass("ba-hidden");
                return false;
            }
            else {
                jQuery(".divRosterContainer").removeClass("ba-hidden");
                return true;
            }
        }
        catch (err) { displayError(err); }
    }

    function hasChildCompany() {
        var treeList = $find(jQuery(".rtlRoster")[0].id);
        var nodes = treeList.get_allnodes();
        var coCount = 0;
        //for (var i = 0; i < nodes.length; ++i) {
        //    if (nodes[i])
        //}

    }

    function updateStatus(result) {
        try {
            jQuery(".divStatus").html(jQuery.parseJSON(result.d));
        }
        catch (err) { displayError(err); }
    }

    function updateRStatus(result) {
        try {
            jQuery(".divRStatus").html(jQuery.parseJSON(result.d));
        }
        catch (err) { displayError(err); }
    }

    function btnSendInvitationClick() {
        try {
            var company = jQuery.parseJSON(jQuery(".txtCompany").val());
            jQuery.ajax({
                url: jQuery(".txtWSPath").val() + "/SendInvitation",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                data: "{ 'SentByLoginID': '" + jQuery(".txtLoginID").val() + "', " + 
                        "'FromEmail': '" + company.Email + "', " +
                        "'ToEmailAddresses': '" + jQuery(".txtEmail").val() + "', " +
                        "'IMIS_ID': '" + company.IMIS_ID + "', " +
                        "'CompanyName': '" + company.Name.replace("'", "\\u0027") + "' }",
                success: function (result) {
                    updateStatus(result);
                },
                error: function (err) {
                    displayAjaxError(err);
                }
            });
            //clear email and status
            jQuery(".divStatus").html("");
            jQuery(".txtEmail").val("");
        }
        catch (err) { displayError(err); }
        return false;
    }

    //TODO: DEBUG ONLY - This should be disabled for production 
    function displayError(err) {
        if (false) {
            //Unfortunately "arguments.callee.caller.toString()" will show you the whole calling function definition, when all we need is the calling function name.
            var callingFunctionDef = arguments.callee.caller.toString();
            var indexFunction = callingFunctionDef.indexOf("function");
            var indexFunctionParen = callingFunctionDef.indexOf("(");
            var functionName = callingFunctionDef;
            if (indexFunction > -1 && indexFunctionParen > -1) {
                var functionNameTest = callingFunctionDef.substring(indexFunction + 8, indexFunctionParen - indexFunction);
                if (functionNameTest.trim().length > 0) functionName = functionNameTest.trim();
            }
            alert("An error occurred in: " + functionName + "\n:" + err);
        }
    }

    //TODO: DEBUG ONLY - This should be disabled for production
    function displayAjaxError(err) {
        if (false) alert("Ajax Error=\n" + err.responseText);
    }

    function getCellByColumnUniqueName(item, columnName) {
        var treeList = item.get_owner();
        var headerRow = treeList.get_element().getElementsByTagName("thead")[0].rows[0];
        var columnIndex = -1;
        var cellsToSkip = item.get_hierarchicalIndex().NestedLevel + 1;

        for (var i = 0; i < headerRow.cells.length; i++) {
            var cell = headerRow.cells[i];
            var currentColumnName = "";
            var sortLink = cell.getElementsByTagName("a")[0]

            if (sortLink) {
                currentColumnName = sortLink.innerHTML;
            }
            else {
                currentColumnName = cell.innerHTML;
            }

            if (currentColumnName === columnName) {
                columnIndex = i;
                break;
            }
        }

        if (columnIndex > -1) {
            return item.get_element().cells[cellsToSkip + columnIndex];
        }

        return null;
    }

    function itemDragging(sender, args) {
        var isChild;
        var dropClue = $telerik.findElement(args.get_draggedContainer(), "DropClue");
        args.set_dropClueVisible(true);  //drop clue is always visible

        if (!args.get_canDrop()) //trying to drag a parent item onto its own child
        {
            dropClue.className = "dropClue dropDisabled";
            return;
        }

        if (sender == treeList2) //In this demo, RadTreeList2 supports item reordering only
        {
            isChild = $telerik.isDescendant(treeList2.get_element(), get_dropTarget(args.get_domEvent()));
        }
        else //RadTreeList1 supports both reordering and drop over RadTreeList2
        {
            isChild = get_isTreeListChild(get_dropTarget(args.get_domEvent()));   //is child of RadTreeList1 or RadTreeList2
        }

        var className = isChild ? "dropEnabled" : "dropDisabled"; //Change drop clue icon depending on the drop target              
        args.set_canDrop(isChild);
        dropClue.className = "dropClue " + className;
    }

    function OnItemSelected(sender, eventArgs) {
        jQuery(".txtSelectedId").val(getCellByColumnUniqueName(eventArgs.get_item(), "ID").innerHTML);
        jQuery(".txtSelectedParentId").val(getCellByColumnUniqueName(eventArgs.get_item(), "ParentID").innerHTML);
        jQuery(".txtIsCompany").val(getCellByColumnUniqueName(eventArgs.get_item(), "isCompany").innerHTML);
        var hierarchicalIndex = eventArgs.get_item().get_hierarchicalIndex();
        var message = "Item with LevelIndex: " + hierarchicalIndex.LevelIndex + " and NestedLevel: " +
         hierarchicalIndex.NestedLevel + " was selected";
        treeList = eventArgs.get_item().get_owner().get_dataItems();

        if (!isCompanySelected()) {
            jQuery(".btnMangeRole").prop('disabled', false);

            var coCount = 0;
            var isCompany = "False";
            for (var i = 0; i < treeList.length; i++) {
                isCompany = getCellByColumnUniqueName(treeList[i], "isCompany").innerHTML;
                if (isCompany == "True") {
                    coCount++;
                    if (coCount > 1) {
                        jQuery(".btnMoveEmp").prop('disabled', false);
                        //jQuery(".btnMoveEmp").removeClass("ba-hidden");
                        return;
                    }
                }
            }
        }
        return;
    }

    function OnItemDeselected(sender, eventArgs) {
        var hierarchicalIndex = eventArgs.get_item().get_hierarchicalIndex();
        var message = "Item with LevelIndex: " + hierarchicalIndex.LevelIndex + " and NestedLevel: " +
          hierarchicalIndex.NestedLevel + " was deselected";
        jQuery(".btnMangeRole").prop('disabled', true);
        jQuery(".btnMoveEmp").prop('disabled', true);
        //jQuery(".btnMangeRole").addClass("ba-hidden");
        //jQuery(".btnMoveEmp").addClass("ba-hidden");
    }

    function isCompanySelected() {
        var treeList = $find(jQuery(".rtlRoster")[0].id);
        var selectedIndex = treeList.get_selectedIndexes();
        var row = selectedIndex[0];

        var selectedId = getCellByColumnUniqueName(treeList.getItem(row), "ID").innerText;
        jQuery(".txtSelectedId").val(selectedId);

        var company = jQuery.parseJSON(jQuery(".txtCompany").val());

        var isCompany = getCellByColumnUniqueName(treeList.getItem(row), "isCompany").innerHTML;

        if (isCompany == "True") {
            return true;
        }
        else {
            return false;
        }
    }

    function getCompanyList() {
        try {
            var roleModal = jQuery(".levelModal");
            var container = jQuery(".cblLevel");

            var treeList = $find(jQuery(".rtlRoster")[0].id)
            treeList = treeList.get_dataItems();
            //jQuery(".txtErrors").val(getCellByColumnUniqueName(treeList[1], "ID").innerText);
            var err;
            var ddlCompanies = '<select autofocus onchange="changeSelectedLevel()" id="selectLevel" class="selectLevel"> ';
            for (var i = 0; i < treeList.length; i++) {
                //err = '(' + getCellByColumnUniqueName(treeList[i], "ID").innerText + ': ' + getCellByColumnUniqueName(treeList[i], "isCompany").innerHTML + ');'
                //jQuery(".txtErrors").val(jQuery(".txtErrors").val()+err);
                if (getCellByColumnUniqueName(treeList[i], "isCompany").innerHTML == 'True') {
                    if (getCellByColumnUniqueName(treeList[i], "ID").innerText == jQuery(".txtSelectedParentId").val()) {
                        ddlCompanies += '<option selected="selected" value="' + getCellByColumnUniqueName(treeList[i], "ID").innerText + '">' + getCellByColumnUniqueName(treeList[i], "ID").innerText + ": " + getCellByColumnUniqueName(treeList[i], "Full Name").innerText + '</option>';
                    }
                    else {
                        ddlCompanies += '<option value="' + getCellByColumnUniqueName(treeList[i], "ID").innerText + '">' + getCellByColumnUniqueName(treeList[i], "ID").innerText + ": " + getCellByColumnUniqueName(treeList[i], "Full Name").innerText + '</option>';
                    }
                }

            }
            ddlCompanies += '</select>'
            //jQuery(".txtErrors").val(ddlCompanies);
            jQuery(ddlCompanies).appendTo(container);
            showLevelModal();
        }
        catch (err) { displayError(err); }
        return false;
    }

    function changeSelectedLevel() {
        jQuery(".txtSelectedParentId").val(jQuery(".selectLevel")[0].value);
    }
</script>

<!-- TODO: Remove this label, and add your own UI elements. -->
<div id="divRosterContainer" class="divRosterContainer ba-hidden">

    <telerik:RadAjaxManagerProxy ID="RadAjaxManagerProxy1" runat="server">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="grdInvitations"></telerik:AjaxUpdatedControl>
                    <telerik:AjaxUpdatedControl ControlID="rtlRoster"></telerik:AjaxUpdatedControl>
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManagerProxy>

    <div id="divRoster" class="divRoster">
        <div class="alert alert-grid alert-danger" role="alert" style='display: none;'"></div> 
        <telerik:RadAjaxPanel ID="RadAjaxPanel1" LoadingPanelID="RadAjaxLoadingPanel1" runat="server">
            <!-- PageSize="5" is pretty small, but it prevents a problem where iMIS auto scrolls to the bottom of the page and having even "10" makes it look bad. -->
            <telerik:RadTreeList runat="server" ID="rtlRoster" CssClass="rtlRoster" DataKeyNames="ItemID" ParentDataKeyNames="ParentID" AutoGenerateColumns="false"
                OnNeedDataSource="rtlRoster_NeedDataSource" OnUpdateCommand="rtlRoster_UpdateCommand" OnEditCommand="rtlRoster_EditCommand"
                OnDeleteCommand="rtlRoster_DeleteCommand" OnItemDataBound="rtlRoster_ItemDataBound" OnLoad="rtlRoster_Load" ClientSettings-ClientEvents-OnItemSelected="OnItemSelected" ClientSettings-ClientEvents-OnItemDeselected="OnItemDeselected"
                AllowPaging="true" PageSize="15" AllowSorting="true" AllowMultiItemEdit="true" EditMode="InPlace" ClientSettings-Selecting-AllowItemSelection="true">
                <Columns>
                    <telerik:TreeListSelectColumn HeaderStyle-Width="40px" ItemStyle-CssClass="chkSelect" UniqueName="chkSelect">
                    </telerik:TreeListSelectColumn>
                    <telerik:TreeListButtonColumn HeaderText="Delete" CommandName="Delete" ButtonType="ImageButton" 
                        ImageUrl="~/AsiCommon/Images/Workflow/delete.gif" UniqueName="DeleteRoster" ButtonCssClass="btnDeleteRoster">
                        <HeaderStyle Width="52px" />
                    </telerik:TreeListButtonColumn>
                    <telerik:TreeListBoundColumn DataField="FullName" ItemStyle-CssClass="fullName" HeaderText="Full Name" UniqueName="FullName" ReadOnly="true">
                        <HeaderStyle Width="200px" />
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="ChildIMIS_ID"  ItemStyle-CssClass="IMIS_ID" HeaderText="Member Number" UniqueName="IMIS_ID" ReadOnly="true">
                    </telerik:TreeListBoundColumn>
<%--                    <telerik:TreeListBoundColumn DataField="MemberType" HeaderText="Member Type" UniqueName="MemberType" ReadOnly="true">
                    </telerik:TreeListBoundColumn>--%>
                    <telerik:TreeListBoundColumn DataField="Email" HeaderText="Email" UniqueName="Email" ReadOnly="true">
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListCheckBoxColumn DataField="OptOutTNB" HeaderText="TNB Opt Out" UniqueName="OptOutTNB"
                        HeaderTooltip="Opt out of The New Brewer publication" ReadOnly="false">
                    </telerik:TreeListCheckBoxColumn>
                    <telerik:TreeListEditCommandColumn UniqueName="TNBEditor" ShowAddButton="false" EditText="Edit" HeaderText="Edit TNB Opt Out">
                    </telerik:TreeListEditCommandColumn> 

                    <%--BEW IMPORTANT! Apparently we have to put hidden columns on the far right (b/c far left screws up layout, but of course, only when it's published). 
                        Also, if this is ever NOT the last column, please make sure to update rtlRoster_UpdateCommand where we can apparently only access this column by INDEX and not NAME!--%>
                    <telerik:TreeListBoundColumn DataField="isCompany"  ItemStyle-CssClass="isCompany" HeaderText="isCompany" UniqueName="isCompany" ReadOnly="true" HeaderStyle-Width="0">
                        <HeaderStyle Width="0px" />
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="ParentID"  ItemStyle-CssClass="parentID" HeaderText="ParentID" UniqueName="ParentID" ReadOnly="true" HeaderStyle-Width="0">
                        <HeaderStyle Width="0px" />
                    </telerik:TreeListBoundColumn>
                    <telerik:TreeListBoundColumn DataField="ChildIMIS_ID"  ItemStyle-CssClass="childIMIS_ID" HeaderText="ID" UniqueName="ChildIMIS_ID" ReadOnly="true" HeaderStyle-Width="0">
                        <HeaderStyle Width="0px" />
                    </telerik:TreeListBoundColumn>
                </Columns>
            </telerik:RadTreeList>
        </telerik:RadAjaxPanel>
    </div>

    <div id="divInvitations" class="divInvitations">
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
            <script type="text/javascript">
                function confirmDeleteInvitation($this) {
                    var hfInvitation = $this.closest("tr").find("[id$='hfInvitationID']");
                    if (hfInvitation != null) {
                        var invitationID = hfInvitation.val();
                        if (confirm('Are you sure you want to delete the selected invitation?')) {
                            jQuery.ajax({
                                url: jQuery(".txtWSPath").val() + "/DeleteInvitation",
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                data: "{ 'InvitationID': '" + invitationID + "' }",
                                error: function (err) {
                                    displayAjaxError(err);
                                }
                            });
                            //This has to be inside a RadCodeblock because it contains an ASP code block
                            $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest("RebindInvitation");
                            toggleVisibility();
                        }
                    }
                    return false;
                }
            </script>
        </telerik:RadCodeBlock>
        <!--We have to use a RadAjaxManagerProxy because there is already a RadAjaxManager on the iMIS MasterPage and there can only be one RadAjaxManager on a page.-->
        <div id="divInvitationGrid" class="divInvitationGrid">
            <h5>Pending Invitations</h5>
            <telerik:RadGrid runat="server" ID="grdInvitations" CssClass="grdInvitations" AllowPaging="True" PageSize="15" 
                AllowSorting="true" OnNeedDataSource="grdInvitations_NeedDataSource" OnPreRender="grdInvitations_PreRender" OnItemDataBound="grdInvitations_ItemDataBound">
                <MasterTableView>
                    <Columns>
                        <telerik:GridTemplateColumn UniqueName="TemplateColumn" HeaderText="Delete">
                            <ItemTemplate>
                                <asp:ImageButton ID="imgDeleteInvitation" runat="server" AlternateText="Delete"
                                    OnClientClick="javascript:return confirmDeleteInvitation(jQuery(this));"
                                    ImageUrl="~/AsiCommon/Images/Workflow/delete.gif" />
                                <asp:HiddenField ID="hfInvitationID" runat="server" Visible="true" />
                            </ItemTemplate>
                        </telerik:GridTemplateColumn>
                    </Columns>
                </MasterTableView>
                <ClientSettings EnableRowHoverStyle="true">
                    <Selecting AllowRowSelect="True"></Selecting>
                </ClientSettings>
            </telerik:RadGrid>
        </div>
    </div>

    <br />
    <br />
    <button id="btnAddContact" class="btnAddContact TextButton TextButtonWithImage" title="Send an email to invite contacts to join your company roster.">Add Contact</button>
    <button id="btnMangeRole" class="btnMangeRole TextButton TextButtonWithImage" disabled="disabled" title="Add/Remove a role for selected member.">Manage Roles</button>
    <button id="btnMoveEmp" class="btnMoveEmp TextButton TextButtonWithImage" disabled="disabled" title="Move employee to a different company.">Move Employee</button>

    <!-- Invitation Modal -->
    <div id="invitationModal" class="invitationModal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Send Company Roster Invitation</h4>
                </div>
                <div class="modal-body">
                    <div class="well">
                        <p>Please enter up to 5 email addresses (separated by a semi-colon) for an employee you would like to invite to become associated with your company roster. The recipient will be prompted to complete a Brewers Association registration process.</p>
                        <div class="row">
                            <label id="lblEmail" class="lblEmail col-lg-4 control-label" for="txtEmail">Email Addresses:</label>
                            <div class="col-lg-8">
                                <asp:TextBox ID="txtEmail" CssClass="txtEmail full-width form-control" runat="server"></asp:TextBox>
                            </div>
                        </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-12"> 
                                <asp:Button ID="btnSendInvitation" CssClass="btnSendInvitation TextButton TextButtonWithImage" OnClientClick="return false;" Text="Send Invitation" runat="server" />
                            </div>
                        </div>
                        <br />
                        <p><label id="lblStatus" class="lblStatus control-label">Status:</label></p>
                        <div id="divStatus" class="divStatus full-width" runat="server"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Employee Info Popup -->
    <div class="divEmpInfo ba-hidden">
        <div class="empInfoWell">
            <label class="lblIMIS_ID ba-hidden"></label> 
            <div class="row">
                <label id="lblFullName" class="lblFullName control-label col-lg-3">Name:</label>
                <div class="col-lg-9">
                    <label id="txtFullName" class="txtFullName"></label>
                </div>
            </div>
            <div class="row">
                <label id="lblTitle" class="lblTitle control-label col-lg-3">Title:</label>
                <div class="col-lg-9">
                    <label id="txtTitle" class="txtTitle"></label>
                </div>
            </div>
            <div class="row">
                <label id="lblAddress" class="lblAddress control-label col-lg-3">Address:</label>
                <div class="col-lg-9">
                    <div id="divAddress" class="divAddress"></div>
                </div>
            </div>        
        </div>
    </div>
    <p>
        <label ID="ExampleCurrentUser" runat="server" Text="Current UserID:"></label>
    </p>
</div>
<div class="divNoRoster ba-hidden">
    You do not have a Company Roster.
</div>
<div class="divNoAccess ba-hidden">
    You do not have access to this information. Contact a Company Administrator for assitance. 
</div>

 
    <!-- Relationship Modal -->
<%--    <div id="roleModal" class="roleModal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
        <div id="cblist">
            <input type="checkbox" value="first checkbox" id="cb1" /> <label for="cb1">first checkbox</label>
        </div>
    </div>--%>
    <div id="roleModal" class="roleModal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Add/Remove Roles</h4>
                </div>
                <div class="modal-body role-modal-body">
                    <div class="well">

                        <p>Manage roles for selected user below.</p>
                            <div id="cblist" class="cblist">

                            </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-12"> 
                                <asp:Button ID="btnSavleRole" CssClass="btnSavleRole TextButton TextButtonWithImage"  Text="Save" runat="server" />
                            </div>
                        </div>
                        <div id="divRStatus" class="divRStatus full-width" runat="server"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="levelModal" class="levelModal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title">Move Employee</h4>
                </div>
                <div class="modal-body role-modal-body">
                    <div class="well">

                        <p>Select the location where this employee works.</p>
                            <div id="cblLevel" class="cblLevel">

                            </div>
                        <br />
                        <div class="row">
                            <div class="col-lg-12"> 
                                <asp:Button ID="btnSaveLocation" CssClass="btnSaveLocation TextButton TextButtonWithImage" OnClientClick="return false;" Text="Save" runat="server" />
                                <asp:Button ID="btnCancelLevel" CssClass="btnCancelLevel TextButton TextButtonWithImage" OnClientClick="return false;" Text="Cancel" runat="server" />
                            </div>
                        </div>
                        <div id="divLStatus" class="divLStatus full-width" runat="server"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="levelConfirmModal" class="levelConfirmModal modal fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body role-modal-body">
                    <div class="well">
                        <p>Before we move this employee let us know if you want to tranfer his or her roles to the new location or remove them.</p>
                        <div class="row">
                            <div class="col-lg-12"> 
                                <asp:Button ID="btnMoveRelationships" CssClass="btnMoveRelationships TextButton TextButtonWithImage" OnClientClick="return false;" Text="Move Roles" runat="server" />
                                <asp:Button ID="btnDeleteRelationships" CssClass="btnDeleteRelationships TextButton TextButtonWithImage" OnClientClick="return false;" Text="Remove Roles" runat="server" />
                                <asp:Button ID="btnCancelLevelConfirm" CssClass="btnCancelLevelConfirm TextButton TextButtonWithImage" OnClientClick="return false;" Text="Cancel" runat="server" />
                            </div>
                        </div>
                        <div id="div1" class="divLStatus full-width" runat="server"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<asp:TextBox ID="txtWSPath" CssClass="txtWSPath ba-hidden" runat="server"></asp:TextBox>
<asp:TextBox ID="txtCompany" CssClass="txtCompany ba-hidden" runat="server"></asp:TextBox>
<asp:TextBox ID="txtLoginID" CssClass="txtLoginID ba-hidden" runat="server"></asp:TextBox>
<asp:TextBox ID="txtIsCompanyAdmin" CssClass="txtIsCompanyAdmin ba-hidden" runat="server"></asp:TextBox>
<asp:TextBox ID="txtErrors" CssClass="txtErrors ba-hidden" runat="server"></asp:TextBox> <!--BEW DEBUG ONLY (keep it ba-hidden when not in use)-->
<asp:TextBox ID="txtItemCount" CssClass="txtItemCount ba-hidden" runat="server"></asp:TextBox>
<asp:TextBox ID="txtSelectedId" CssClass="txtSelectedId ba-hidden" runat="server"></asp:TextBox>
<asp:TextBox ID="txtSelectedParentId" CssClass="txtSelectedParentId" runat="server"></asp:TextBox>
<asp:TextBox ID="txtIsCompany" CssClass="txtIsCompany ba-hidden" runat="server"></asp:TextBox>
<!--</BA:ReplaceIPartASCX>-->

</asp:Content>
