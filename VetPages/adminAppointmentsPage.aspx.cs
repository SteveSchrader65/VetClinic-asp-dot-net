using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Linq;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class adminAppointmentsPage : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector = "Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";
        public static Boolean isApptDateValid;
        public static Boolean isApptTimeValid;

        // WORK AROUND: Array size must be greater than total number of appointments.
        public static String[] thisAppointmentComment = new string[500];

        DataTable petsTable = new DataTable();
        DataTable vetsTable = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                btnAppointmentsTable.BackColor = Color.Gold;
                btnPetsTable.BackColor = Color.LightGray;
                btnOwnersTable.BackColor = Color.LightGray;
                btnMedicationsTable.BackColor = Color.LightGray;
                btnReportsPage.BackColor = Color.LightGray;
            }

            lblErrorMessage.Visible = false;
            lblCompletedAppointDetails.Visible = false;
            tbxCompletedAppointDetails.Visible = false;
            adminAppointmentsGridView.BottomPagerRow.Visible = true;
        }

        protected void AdminAppointmentsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            adminAppointmentsGridView.PageIndex = e.NewPageIndex;
        }

        protected void AdminAppointmentsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DECLARE ADDITIONAL BUTTONS
                Button btnEdit = e.Row.FindControl("btnEdit") as Button;
                Button btnCancel = e.Row.FindControl("btnCancel") as Button;
                Button btnView = e.Row.FindControl("btnView") as Button;

                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "EDIT button to modify Appointment details. \nCANCEL button to cancel this Appointment";

                // HIGHLIGHT CURRENT ROW ON MOUSE-OVER
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='LightCyan';";

                // CHANGE BACKGROUND COLOR OF DATA-ROW BACK TO ORIGINAL COLOUR AFTER MOUSE-OVER
                if (e.Row.RowIndex % 2 == 0)
                {
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='LightGoldenrodYellow';";
                }

                else
                {
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='PaleGoldenrod';";
                }

                if ((e.Row.RowState & DataControlRowState.Edit) != DataControlRowState.Edit)
                {
                    // SET APPOINT COMMENT TO 'COMPLETE' IF FEE HAS BEEN ENTERED
                    if (((Label)e.Row.FindControl("lblAppointFee") as Label).Text.ToString() != "$0.00")
                    {
                        thisAppointmentComment[e.Row.RowIndex] = ((Label)e.Row.FindControl("lblAppointComment") as Label).Text.ToString();
                        e.Row.Cells[10].Text = "COMPLETED";

                        // DISPLAY VIEW BUTTON IF APPOINTMENT HAS BEEN COMPLETED
                        btnView.Visible = true;
                        btnEdit.Visible = true;
                        btnCancel.Visible = false;
                        e.Row.ToolTip = "EDIT button to modify Appointment Fee.\nVIEW button to see details of completed Appointment";
                    }

                    else
                    {
                        // DISPLAY EDIT AND CANCEL BUTTONS IF APPOINTMENT HAS NOT BEEN COMPLETED
                        lblCompletedAppointDetails.Visible = false;
                        tbxCompletedAppointDetails.Visible = false;
                        btnView.Visible = false;
                        btnEdit.Visible = true;
                        btnCancel.Visible = true;
                        e.Row.ToolTip = "EDIT button to modify Appointment details.\nCANCEL button to cancel this Appointment";
                    }
                }

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    // DISPLAY TOOLTIP FOR EDIT-ROW
                    e.Row.ToolTip = "UPDATE button to save Appointment details. \nEXIT button to stop modifying";

                    // SET DATASOURCE FOR DROP-DOWN LIST (ddlEditPet)
                    DropDownList ddlEditPet = (DropDownList)e.Row.FindControl("ddlEditPetName");
                    TextBox thisPetID = e.Row.FindControl("txtPetID") as TextBox;

                    if (ddlEditPet != null)
                    {
                        ddlEditPet.DataSource = CreatePetsTable();
                        ddlEditPet.DataBind();
                    }

                    // SET SELECTED INDEX FOR PET NAME (ddlEditPet)
                    int thisPetNumber = Convert.ToInt32(thisPetID.Text);
                    ddlEditPet.SelectedIndex = thisPetNumber;

                    // SET DATASOURCE FOR DROP-DOWN LIST (ddlEditVet)
                    DropDownList ddlEditVet = (DropDownList)e.Row.FindControl("ddlEditVet");
                    TextBox thisVetID = e.Row.FindControl("txtVetID") as TextBox;

                    if (ddlEditVet != null)
                    {
                        TextBox dateLabel = e.Row.FindControl("tbxEditAppointDate") as TextBox;
                        TextBox timeLabel = e.Row.FindControl("tbxEditAppointTime") as TextBox;

                        if (dateLabel != null && timeLabel != null)
                        {
                            ddlEditVet.DataSource = CreateAvailableVetsTable(dateLabel.Text, timeLabel.Text, thisVetID.Text);
                        }

                        else
                        {
                            ddlEditVet.DataSource = CreateTodaysVetsTable();
                        }

                        ddlEditVet.DataBind();
                    }

                    // SET SELECTED VALUE FOR VET NAME (ddlEditVet)
                    int thisVetNumber = Convert.ToInt32(thisVetID.Text);
                    ddlEditVet.SelectedValue = thisVetNumber.ToString();

                    // SET NON-EDITABLE FIELDS AS READ-ONLY
                    if (((TextBox)e.Row.FindControl("tbxEditAppointFee") as TextBox).Text.ToString() != "0.00")
                    {
                        ((TextBox)e.Row.FindControl("tbxEditAppointDate") as TextBox).BorderStyle = BorderStyle.None;
                        ((TextBox)e.Row.FindControl("tbxEditAppointDate") as TextBox).BackColor = Color.Transparent;
                        ((TextBox)e.Row.FindControl("tbxEditAppointDate") as TextBox).ReadOnly = true;
                        ((TextBox)e.Row.FindControl("tbxEditAppointTime") as TextBox).BorderStyle = BorderStyle.None;
                        ((TextBox)e.Row.FindControl("tbxEditAppointTime") as TextBox).BackColor = Color.Transparent;
                        ((TextBox)e.Row.FindControl("tbxEditAppointTime") as TextBox).ReadOnly = true;
                        ((DropDownList)e.Row.FindControl("ddlEditPetName") as DropDownList).BorderStyle = BorderStyle.None;
                        ((DropDownList)e.Row.FindControl("ddlEditPetName") as DropDownList).BackColor = Color.Transparent;
                        ((DropDownList)e.Row.FindControl("ddlEditPetName") as DropDownList).Enabled = false;
                        ((DropDownList)e.Row.FindControl("ddlEditVet") as DropDownList).BorderStyle = BorderStyle.None;
                        ((DropDownList)e.Row.FindControl("ddlEditVet") as DropDownList).BackColor = Color.Transparent;
                        ((DropDownList)e.Row.FindControl("ddlEditVet") as DropDownList).Enabled = false;
                        ((TextBox)e.Row.FindControl("tbxEditAppointComment") as TextBox).BorderStyle = BorderStyle.None;
                        ((TextBox)e.Row.FindControl("tbxEditAppointComment") as TextBox).BackColor = Color.Transparent;
                        ((TextBox)e.Row.FindControl("tbxEditAppointComment") as TextBox).ReadOnly = true;
                    }

                    else
                    {
                        ((TextBox)e.Row.FindControl("tbxEditAppointFee") as TextBox).BorderStyle = BorderStyle.None;
                        ((TextBox)e.Row.FindControl("tbxEditAppointFee") as TextBox).BackColor = Color.Transparent;
                        ((TextBox)e.Row.FindControl("tbxEditAppointFee") as TextBox).ReadOnly = true;
                        ((TextBox)e.Row.FindControl("tbxEditAppointFee") as TextBox).Text = "$" + ((TextBox)e.Row.FindControl("tbxEditAppointFee") as TextBox).Text;
                    }
                }
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                // DISPLAY TOOLTIP FOR FOOTER-ROW
                e.Row.ToolTip = "BOOK button to make new Appointment.";

                // HIGHLIGHT CURRENT ROW ON MOUSE-OVER
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='LightCyan';";

                // CHANGE BACKGROUND COLOR OF FOOTER-ROW BACK TO ORIGINAL COLOUR AFTER MOUSE-OVER
                if (adminAppointmentsGridView.Rows.Count % 2 == 0)
                {
                    e.Row.BackColor = Color.LightGoldenrodYellow;
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='LightGoldenrodYellow';";
                }

                else
                {
                    e.Row.BackColor = Color.PaleGoldenrod;
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='PaleGoldenrod';";
                }

                // SET DATASOURCE FOR DROP-DOWN LIST (ddlNewPet)
                DropDownList ddlNewPet = (DropDownList)e.Row.FindControl("ddlNewPetName");

                if (ddlNewPet != null)
                {
                    ddlNewPet.DataSource = CreatePetsTable();
                    ddlNewPet.DataBind();
                }

                // SET DATASOURCE FOR DROP-DOWN LIST (ddlNewVet)
                DropDownList ddlNewVet = (DropDownList)e.Row.FindControl("ddlNewVet");

                if (ddlNewVet != null)
                {
                    TextBox dateLabel = e.Row.FindControl("tbxNewAppointDate") as TextBox;
                    TextBox timeLabel = e.Row.FindControl("tbxNewAppointTime") as TextBox;

                    if (isApptDateValid && isApptTimeValid)
                    {
                        ddlNewVet.DataSource = CreateAvailableVetsTable(dateLabel.Text, timeLabel.Text, "0");
                        isApptDateValid = false;
                        isApptTimeValid = false;
                    }

                    else
                    {
                        ddlNewVet.DataSource = CreateTodaysVetsTable();
                    }

                    ddlNewVet.DataBind();
                }
            }

            if (e.Row.RowType == DataControlRowType.Pager)
            {
                // DISPLAY TOOLTIP FOR PAGER-ROW
                e.Row.ToolTip = "Current Page: " + (adminAppointmentsGridView.PageIndex + 1).ToString();
            }
        }

        protected void AdminAppointmentsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "View")
            {
                // DISPLAY DETAILS OF COMPLETED APPOINTMENT IN TEXTBOX
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString()) % ((GridView)sender).PageSize;
                GridViewRow currentRow = adminAppointmentsGridView.Rows[rowIndex];
                tbxCompletedAppointDetails.Text = thisAppointmentComment[rowIndex];

                lblCompletedAppointDetails.Visible = true;
                tbxCompletedAppointDetails.Visible = true;

                // RE-DISPLAY "COMPLETED" LABEL FOR ALL COMPLETED APPOINTMENTS
                foreach (GridViewRow appointment in adminAppointmentsGridView.Rows)
                {
                    if (((Label)appointment.FindControl("lblAppointFee") as Label).Text.ToString() != "$0.00")
                    {
                        appointment.Cells[10].Text = "COMPLETED";
                    }
                }
            }

            if (e.CommandName == "Edit")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString()) % ((GridView)sender).PageSize;
                GridViewRow currentRow = adminAppointmentsGridView.Rows[rowIndex];
                TextBox thisVetID = currentRow.FindControl("txtVetID") as TextBox;
                DropDownList ddlPetList = currentRow.FindControl("ddlEditPetName") as DropDownList;
                DropDownList ddlVetList = currentRow.FindControl("ddlEditVet") as DropDownList;
                TextBox dateLabel = currentRow.FindControl("tbxEditAppointDate") as TextBox;
                TextBox timeLabel = currentRow.FindControl("tbxEditAppointTime") as TextBox;

                if (ddlPetList != null)
                {
                    ddlPetList.DataSource = CreatePetsTable();
                    ddlPetList.DataBind();
                }

                if (ddlVetList != null)
                {
                    if (dateLabel.Text != null && timeLabel.Text != null)
                    {
                        ddlVetList.DataSource = CreateAvailableVetsTable(dateLabel.Text, timeLabel.Text, thisVetID.Text);
                    }

                    else
                    {
                        ddlVetList.DataSource = CreateTodaysVetsTable();
                    }

                    ddlVetList.DataBind();
                    ddlVetList.SelectedValue = thisVetID.Text;
                }
            }

            if (e.CommandName == "Update")
            {
                Page.Validate("EditFee");
                if (Page.IsValid)
                {
                    int rowIndex = Convert.ToInt32(e.CommandArgument.ToString()) % ((GridView)sender).PageSize;
                    GridViewRow currentRow = adminAppointmentsGridView.Rows[rowIndex];
                    TextBox thisPetID = currentRow.FindControl("txtPetID") as TextBox;
                    TextBox thisVetID = currentRow.FindControl("txtVetID") as TextBox;
                    DropDownList ddlPetList = currentRow.FindControl("ddlEditPetName") as DropDownList;
                    DropDownList ddlVetList = currentRow.FindControl("ddlEditVet") as DropDownList;

                    if (ddlPetList != null && thisPetID != null)
                    {
                        thisPetID.Text = ddlPetList.SelectedValue;
                        ddlPetList.SelectedValue = thisPetID.Text;
                    }

                    if (ddlVetList != null && thisVetID != null)
                    {
                        thisVetID.Text = ddlVetList.SelectedValue;
                        ddlVetList.SelectedValue = thisVetID.Text;
                    }
                }
            }
            
            if (e.CommandName == "Book")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString()) % ((GridView)sender).PageSize;
                GridViewRow currentRow = adminAppointmentsGridView.Rows[rowIndex];
                TextBox thisPetID = currentRow.FindControl("txtPetID") as TextBox;
                TextBox thisVetID = currentRow.FindControl("txtVetID") as TextBox;
                DropDownList ddlPetList = currentRow.FindControl("ddlNewPetName") as DropDownList;
                DropDownList ddlVetList = currentRow.FindControl("ddlNewVet") as DropDownList;

                if (ddlPetList != null && thisPetID != null)
                {
                    thisPetID.Text = ddlPetList.SelectedValue;
                    ddlPetList.SelectedValue = thisPetID.Text;
                }

                if (ddlVetList != null && thisVetID != null)
                {
                    thisVetID.Text = ddlVetList.SelectedValue;
                    ddlVetList.SelectedValue = thisVetID.Text;
                }
            }
        }

        protected void AdminAppointmentsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow currentRow = adminAppointmentsGridView.Rows[e.RowIndex];
            TextBox thisPetID = currentRow.FindControl("txtPetID") as TextBox;
            TextBox thisVetID = currentRow.FindControl("txtVetID") as TextBox;
            DropDownList ddlEditPetList = currentRow.FindControl("ddlEditPetName") as DropDownList;
            DropDownList ddlEditVetList = currentRow.FindControl("ddlEditVet") as DropDownList;

            if (thisPetID != null && ddlEditPetList != null)
            {
                thisPetID.Text = ddlEditPetList.SelectedValue;
            }

            if (thisVetID != null && ddlEditVetList != null)
            {
                thisVetID.Text = ddlEditVetList.SelectedValue;
            }
        }

        protected void TbxEditAppointDate_TextChanged(object sender, EventArgs e)
        {
            isApptTimeValid = false;
            TextBox dateLabel = (sender as TextBox);
            GridViewRow currentRow = (GridViewRow)dateLabel.Parent.Parent;
            TextBox assignedVet = currentRow.FindControl("txtVetID") as TextBox;
            TextBox timeLabel = currentRow.FindControl("tbxEditAppointTime") as TextBox;

            if (timeLabel.Text != null)
            {
                isApptTimeValid = true;
            }

            if (Convert.ToDateTime(dateLabel.Text) >= DateTime.Today)
            {
                isApptDateValid = true;
            }

            if (isApptDateValid && isApptTimeValid)
            {
                DropDownList ddlEditVet = (DropDownList)currentRow.FindControl("ddlEditVet");
                ddlEditVet.DataSource = CreateAvailableVetsTable(dateLabel.Text, timeLabel.Text, assignedVet.Text);
                ddlEditVet.DataBind();
                isApptDateValid = false;
                isApptTimeValid = false;
            }
        }

        protected void TbxEditAppointTime_TextChanged(object sender, EventArgs e)
        {
            TextBox timeLabel = (sender as TextBox);
            String[] meridianArray = { "am", "pm", "AM", "PM" };
            String inputTime = timeLabel.Text;
            isApptTimeValid = false;
            String hoursString = "";
            String minsString = "";
            String meridianString = "";
            String newTimeString = "";
            int hoursValue = 0;
            int minsValue = 0;
            Boolean hoursCheck = false;
            Boolean minsCheck = false;

            // CHECK FOR VALID INPUT (FULL INPUT) ie: 12:45 PM, AS WELL AS 01:45 pm
            // ALSO WITHOUT SPACE BEFORE MERIDIAN ie: 12:45pm, 09:30AM
            if ((inputTime.Length == 8 && String.IsNullOrWhiteSpace(inputTime.Substring(inputTime.Length - 3, 1)))
                    || (inputTime.Length == 7 && !String.IsNullOrWhiteSpace(inputTime.Substring(inputTime.Length - 3, 1))))
            {
                hoursString = inputTime.Substring(0, 2);
                minsString = inputTime.Substring(3, 2);
                meridianString = inputTime.Substring((inputTime.Length - 2), 2);

                hoursCheck = int.TryParse(hoursString, out hoursValue);
                minsCheck = int.TryParse(minsString, out minsValue);

                if (meridianArray.Any(meridianString.Contains))
                {
                    if (hoursCheck && minsCheck)
                    {
                        if (((hoursValue >= 6 && hoursValue <= 11) || (hoursValue == 12 && minsValue <= 59)) && (meridianString == "am" || meridianString == "AM"))
                        {
                            meridianString = "AM";
                            isApptTimeValid = true;
                        }

                        else if (((hoursValue >= 13 && hoursValue <= 21) || (hoursValue == 21 && minsValue <= 59)) && (meridianString == "pm" || meridianString == "PM"))
                        {
                            meridianString = "PM";
                            isApptTimeValid = true;
                        }

                        else if ((hoursValue <= 9 || (hoursValue == 9 && minsValue <= 59)) && (meridianString == "pm" || meridianString == "PM"))
                        {
                            hoursString = (hoursValue + 12).ToString();
                            meridianString = "PM";
                            isApptTimeValid = true;
                        }
                    }
                }
            }

            // CHECK FOR VALID INPUT (SINGLE DIGIT HOURS) ie: 2:45PM, AS WELL AS 7:45am
            // ALSO WITHOUT SPACE BEFORE MERIDIAN ie: 3:45pm, 09:30AM
            if ((inputTime.Length == 7 && String.IsNullOrWhiteSpace(inputTime.Substring(inputTime.Length - 3, 1)))
                    || (inputTime.Length == 6 && !String.IsNullOrWhiteSpace(inputTime.Substring(inputTime.Length - 3, 1))))
            {
                hoursString = inputTime.Substring(0, 1);
                minsString = inputTime.Substring(2, 2);
                meridianString = inputTime.Substring((inputTime.Length - 2), 2);

                hoursCheck = int.TryParse(hoursString, out hoursValue);
                minsCheck = int.TryParse(minsString, out minsValue);

                if (meridianArray.Any(meridianString.Contains))
                {
                    if (hoursCheck && minsCheck)
                    {
                        if (((hoursValue >= 6 && hoursValue <= 11) || (hoursValue == 12 && minsValue <= 59)) && (meridianString == "am" || meridianString == "AM"))
                        {
                            meridianString = "AM";
                            isApptTimeValid = true;
                        }

                        else if (((hoursValue >= 13 && hoursValue <= 21) || (hoursValue == 21 && minsValue <= 59)) && (meridianString == "pm" || meridianString == "PM"))
                        {
                            meridianString = "PM";
                            isApptTimeValid = true;
                        }

                        else if ((hoursValue <= 9 || (hoursValue == 9 && minsValue <= 59)) && (meridianString == "pm" || meridianString == "PM"))
                        {
                            hoursString = (hoursValue + 12).ToString();
                            meridianString = "PM";
                            isApptTimeValid = true;
                        }
                    }
                }
            }

            // CHECK FOR VALID INPUT (WITHOUT MERIDIAN) ie: 06:45, 17:30 (NOTE: 24 HOUR TIME)
            else if (inputTime.Length == 5)
            {
                hoursString = inputTime.Substring(0, 2);
                minsString = inputTime.Substring(3, 2);

                hoursCheck = int.TryParse(hoursString, out hoursValue);
                minsCheck = int.TryParse(minsString, out minsValue);

                if (hoursCheck && minsCheck)
                {
                    if ((hoursValue >= 6 && hoursValue <= 11) || (hoursValue == 12 && minsValue <= 59))
                    {
                        meridianString = "AM";
                        isApptTimeValid = true;
                    }

                    else if ((hoursValue >= 13 && hoursValue <= 21) || (hoursValue == 21 && minsValue <= 59))
                    {
                        meridianString = "PM";
                        isApptTimeValid = true;
                    }

                    else if (hoursValue < 6)
                    {
                        hoursString = (hoursValue + 12).ToString();
                        meridianString = "PM";
                        isApptTimeValid = true;
                    }
                }
            }

            // CHECK FOR VALID INPUT (WITHOUT MERIDIAN) ie: 6:45, 9:55, 2:45
            else if (inputTime.Length == 4)
            {
                hoursString = inputTime.Substring(0, 1);
                minsString = inputTime.Substring(2, 2);

                hoursCheck = int.TryParse(hoursString, out hoursValue);
                minsCheck = int.TryParse(minsString, out minsValue);

                if (hoursCheck && minsCheck)
                {
                    if ((hoursValue >= 6 && hoursValue <= 11) || (hoursValue == 12 && minsValue <= 59))
                    {
                        meridianString = "AM";
                        isApptTimeValid = true;
                    }

                    else if (hoursValue < 6)
                    {
                        hoursString = (hoursValue + 12).ToString();
                        meridianString = "PM";
                        isApptTimeValid = true;
                    }
                }
            }

            if (!isApptTimeValid)
            {
                GridViewRow currentRow = (GridViewRow)timeLabel.Parent.Parent;
                ((TextBox)currentRow.FindControl("tbxEditAppointTime") as TextBox).Text = "";
            }


            if (isApptTimeValid)
            {
                GridViewRow currentRow = (GridViewRow)timeLabel.Parent.Parent;
                TextBox dateLabel = currentRow.FindControl("tbxEditAppointDate") as TextBox;

                newTimeString = hoursString + ":" + minsString + " " + meridianString;

                if (dateLabel != null)
                {
                    TextBox assignedVet = currentRow.FindControl("txtVetID") as TextBox;
                    DropDownList ddlEditVet = (DropDownList)currentRow.FindControl("ddlEditVet");
                    ddlEditVet.DataSource = CreateAvailableVetsTable(dateLabel.Text, newTimeString, assignedVet.Text);
                    ddlEditVet.DataBind();
                }
            }
        }

        protected void TbxNewAppointDate_TextChanged(object sender, EventArgs e)
        {
            isApptDateValid = false;
            TextBox dateLabel = adminAppointmentsGridView.FooterRow.FindControl("tbxNewAppointDate") as TextBox;
            TextBox timeLabel = adminAppointmentsGridView.FooterRow.FindControl("tbxNewAppointTime") as TextBox;

            if (Convert.ToDateTime(dateLabel.Text) >= DateTime.Today)
            {
                isApptDateValid = true;
            }

            if (isApptDateValid && isApptTimeValid)
            {
                TextBox thisVetID = (TextBox)adminAppointmentsGridView.FooterRow.FindControl("txtVetID");                
                DropDownList ddlNewVet = (DropDownList)adminAppointmentsGridView.FooterRow.FindControl("ddlNewVet");
                ddlNewVet.DataSource = CreateAvailableVetsTable(dateLabel.Text, timeLabel.Text, "0");
                ddlNewVet.DataBind();
                isApptDateValid = false;
                isApptTimeValid = false;
            }

            // RE-DISPLAY "COMPLETED" LABEL FOR ALL COMPLETED APPOINTMENTS
            foreach (GridViewRow appointment in adminAppointmentsGridView.Rows)
            {
                if (((Label)appointment.FindControl("lblAppointFee") as Label).Text.ToString() != "$0.00")
                {
                    appointment.Cells[10].Text = "COMPLETED";
                }
            }
        }

        protected void TbxNewAppointTime_TextChanged(object sender, EventArgs e)
        {
            TextBox dateLabel = adminAppointmentsGridView.FooterRow.FindControl("tbxNewAppointDate") as TextBox;
            TextBox timeLabel = adminAppointmentsGridView.FooterRow.FindControl("tbxNewAppointTime") as TextBox;
            isApptTimeValid = true;
            String hoursString = timeLabel.Text.Substring(0, 2);
            String minsString = timeLabel.Text.Substring(3, 2);
            int hoursValue;
            int minsValue;
            Boolean hoursCheck = int.TryParse(hoursString, out hoursValue);
            Boolean minsCheck = int.TryParse(minsString, out minsValue);

            // BOOKING TIME BETWEEN 6am AND 10pm
            if (hoursCheck && minsCheck)
            {
                if (hoursValue < 6 || hoursValue > 22 || (hoursValue == 22 && minsValue > 0))
                {
                    ((TextBox)adminAppointmentsGridView.FooterRow.FindControl("tbxNewAppointTime") as TextBox).Text = "";
                    lblErrorMessage.Text = "Business hours are 6am to 10pm";
                    lblErrorMessage.ForeColor = Color.Red;
                    lblErrorMessage.Visible = true;
                    isApptTimeValid = false;
                }
            }

            if (isApptDateValid && isApptTimeValid)
            {
                isApptDateValid = false;
                isApptTimeValid = false;
                TextBox thisVetID = (TextBox)adminAppointmentsGridView.FooterRow.FindControl("txtVetID");
                DropDownList ddlNewVet = (DropDownList)adminAppointmentsGridView.FooterRow.FindControl("ddlNewVet");
                ddlNewVet.DataSource = CreateAvailableVetsTable(dateLabel.Text, timeLabel.Text, "0");
                ddlNewVet.DataBind();
            }

            // RE-DISPLAY "COMPLETED" LABEL FOR ALL COMPLETED APPOINTMENTS
            foreach (GridViewRow appointment in adminAppointmentsGridView.Rows)
            {
                if (((Label)appointment.FindControl("lblAppointFee") as Label).Text.ToString() != "$0.00")
                {
                    appointment.Cells[10].Text = "COMPLETED";
                }
            }
        }

        protected void EditAppointDate_ServerValidate(object source, ServerValidateEventArgs args)
        {
            CustomValidator dateCheck = ((CustomValidator)source);
            TextBox dateLabel = (TextBox)dateCheck.NamingContainer.FindControl("tbxEditAppointDate");

            if (dateLabel.ReadOnly == false)
            {
                // CHECK IF DATE IS VALID (NOT EARLIER THAN TODAY) ie: DateTime.Today.ToShortDateString()
                if (Convert.ToDateTime(dateLabel.Text) < Convert.ToDateTime(DateTime.Today.ToShortDateString()))
                {
                    dateCheck.ErrorMessage = "Appointment Date cannot be earlier than Today";
                    args.IsValid = false;
                }

                else
                {
                    args.IsValid = true;
                }
            }
        }

        protected void EditAppointFee_ServerValidate(object source, ServerValidateEventArgs args)
        {
            CustomValidator feeCheck = ((CustomValidator)source);
            TextBox feeLabel = (TextBox)feeCheck.NamingContainer.FindControl("tbxEditAppointFee");
            String tempFeeString;
            Double tempFee;

            if (feeLabel.ReadOnly == false)
            {        
                // CHECK IF FEE IS NUMERIC (STRIP DOLLAR SIGN)
                if (feeLabel.Text.Substring(0, 1).Equals("$"))
                {
                    tempFeeString = feeLabel.Text.Substring(1);   
                }

                else
                {
                    tempFeeString = feeLabel.Text.Substring(0);
                }

                if (!Double.TryParse(tempFeeString, out tempFee))
                {
                    feeCheck.ErrorMessage = "Appoint Fee input needs to be numeric";
                    args.IsValid = false;
                }

                // CHECK THAT FEE IS GREATER THAN ZERO AMOUNT
                else if (feeLabel.Text == "0.00" || feeLabel.Text == "$0.00")
                {
                    feeCheck.ErrorMessage = "Fee cannot be set to zero (Min: 0.01)";
                    args.IsValid = false;
                }

                // CHECK THAT AMOUNT IS NOT NEGATIVE
                else if (tempFee < 0.00)
                {
                    feeCheck.ErrorMessage = "Fee cannot be a negative amount (Min: 0.01)";
                    args.IsValid = false;
                }

                else
                {
                    args.IsValid = true;
                }
            }
        }

        protected void AdminAppointmentsGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                e.KeepInEditMode = true;
                lblErrorMessage.Text = "Appointment #" + e.Keys[0].ToString() + " has not been updated due to data conflict.";
                lblErrorMessage.ForeColor = Color.Red;
                lblErrorMessage.Visible = true;
            }

            else
            {
                lblErrorMessage.Text = "Appointment #" + e.Keys[0].ToString() + " has been successfully updated.";
                lblErrorMessage.ForeColor = Color.Blue;
                lblErrorMessage.Visible = true;
            }
        }

        protected DataTable CreatePetsTable()
        {
            if (petsTable.Rows.Count == 0)
            {
                String namesListQuery = "SELECT [PetID], " +
                                        "[PetName] " +
                                        "FROM [DrDoolittleVet].[dbo].Pets";

                petsTable.Columns.Add("petNumber", typeof(int));
                petsTable.Columns.Add("petName", typeof(String));
                petsTable.Rows.Add(0, "(Select Pet)");

                try
                {
                    using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                    {
                        vetConnector.Open();
                        SqlCommand nameCommand = new SqlCommand(namesListQuery, vetConnector);
                        SqlDataReader petReader = nameCommand.ExecuteReader();

                        while (petReader.Read())
                        {
                            petsTable.Rows.Add(Convert.ToInt32(petReader["PetID"]), petReader["PetName"]);
                        }
                    }
                }

                catch (Exception error)
                {
                    String errorMessage = "There was a problem accessing Pet details: " + error.Message;
                    DisplayPopupMessage(errorMessage);
                }
            }

            return petsTable;
        }

        protected DataTable CreateAvailableVetsTable(String apptDate, String apptTime, String assignedVet)
        {            
            if (vetsTable.Rows.Count == 0)
            {
                int bookedMins;
                int bookedHours;
                int spanStartMins;
                int spanStartHours;
                int spanEndMins;
                int spanEndHours;
                String thisDayNumber = "";
                String spanStartString = "";
                String spanEndString = "";

                // GET DAY OF THE WEEK FOR THIS APPOINTMENT TO CHECK AGAINST VET ROSTER
                thisDayNumber = (((int)DateTime.ParseExact(apptDate, "yyyy-MM-dd", System.Globalization.CultureInfo.InvariantCulture).DayOfWeek) + 1).ToString();

                // CHECK IF ASSIGNED VET IS ROSTERED FOR APPOINTMENT DAY
                if (assignedVet != "0")
                {
                    String vetRosterQuery = "SELECT [VetID] " +
                                            "FROM [DrDoolittleVet].[dbo].[VetRoster] " +
                                            "WHERE [VetID] = '" + @assignedVet + "' " +
                                            "AND [roster" + @thisDayNumber + "] = 'True'";

                    try
                    {
                        using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                        {
                            vetConnector.Open();
                            SqlCommand vetRosterCommand = new SqlCommand(vetRosterQuery, vetConnector);

                            // ADD PARAMETERS FOR ROSTER CHECK
                            vetRosterCommand.Parameters.AddWithValue("@assignedVet", assignedVet);
                            vetRosterCommand.Parameters.AddWithValue("@thisDayNumber", thisDayNumber);
                            SqlDataReader vetReader = vetRosterCommand.ExecuteReader();

                            if (vetReader.Read())
                            {
                                assignedVet = vetReader["VetID"].ToString();
                            }

                            else
                            {
                                assignedVet = "0";
                            }
                        }
                    }

                    catch (Exception error)
                    {
                        String errorMessage = "There was a problem confirming rostered Vet: " + error.Message;
                        DisplayPopupMessage(errorMessage);
                    }
                }

                // CREATE START SPAN STRING (15mins before booking time) AND END SPAN STRING (15mins after booking time)
                bookedMins = Convert.ToInt32(apptTime.Substring(3, 2));
                bookedHours = Convert.ToInt32(apptTime.Substring(0, 2));

                if (bookedMins < 15)
                {
                    spanStartMins = Math.Abs(15 - 60 - bookedMins);
                    
                    if (spanStartMins == 60)
                    {
                        spanStartMins = 0;
                    }

                    spanEndMins = bookedMins + 15;
                    spanStartHours = bookedHours - 1;
                    spanEndHours = bookedHours;
                }

                else if (bookedMins >= 45)
                {
                    spanStartMins = bookedMins - 15;
                    spanEndMins = Math.Abs(60 - (bookedMins + 15));
                    spanStartHours = bookedHours;
                    spanEndHours = bookedHours + 1;
                }

                else
                {
                    spanStartMins = bookedMins - 15;
                    spanEndMins = bookedMins + 15;
                    spanStartHours = bookedHours;
                    spanEndHours = bookedHours;
                }

                if (spanStartHours < 10)
                {
                    spanStartString = "0";
                }

                if (spanEndHours < 10)
                {
                    spanEndString = "0";
                }

                spanStartString += spanStartHours.ToString() + ":";
                spanEndString += spanEndHours.ToString() + ":";

                if (spanStartMins < 10)
                {
                    spanStartString += "0";
                }

                if (spanEndMins < 10)
                {
                    spanEndString += "0";
                }

                spanStartString += spanStartMins.ToString();
                spanEndString += spanEndMins.ToString();


                Boolean isAssignedPresent = false;

                String vetListQuery = "SELECT TOP(500) table1.[VetID], " +
                                      "table1.[Title], " +
                                      "table1.[FirstName], " +
                                      "table1.[LastName] " +
                                      "FROM [DrDoolittleVet].[dbo].[Vets] AS table1, [DrDoolittleVet].[dbo].[VetRoster] as table2 " +
                                      "WHERE table1.[VetID] = table2.[VetID] " +
                                      "AND table2.[roster" + @thisDayNumber + "] = 'True' " +
                                      "AND table1.[VetID] NOT IN " +
                                      "(SELECT table3.[VetID] FROM [DrDoolittleVet].[dbo].[Appointments] AS table3 " +
                                      "WHERE table3.[AppointDate] = '" + @apptDate + "' " +
                                      "AND table3.[AppointTime] > '" + @spanStartString + "' AND (table3.[AppointTime] < '" + @spanEndString + "')) " +
                                      "ORDER BY table1.[LastName] ASC";

                vetsTable.Columns.Add("vetNumber", typeof(int));
                vetsTable.Columns.Add("vetName", typeof(String));
                vetsTable.Rows.Add(0, "(Assign Vet)");

                try
                {
                    using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                    {
                        vetConnector.Open();
                        SqlCommand vetListCommand = new SqlCommand(vetListQuery, vetConnector);

                        // ADD PARAMETERS FOR THIS BOOKING
                        vetListCommand.Parameters.AddWithValue("@thisDayNumber", thisDayNumber);
                        vetListCommand.Parameters.AddWithValue("@apptDate", apptDate);
                        vetListCommand.Parameters.AddWithValue("@spanStartString", spanStartString);
                        vetListCommand.Parameters.AddWithValue("@spanEndString", spanEndString);

                        SqlDataReader vetReader = vetListCommand.ExecuteReader();

                        while (vetReader.Read())
                        {
                            vetsTable.Rows.Add(Convert.ToInt32(vetReader["VetID"]), vetReader["Title"] + " " + vetReader["FirstName"] + " " + vetReader["LastName"]);

                            if (vetReader["VetID"].ToString() == assignedVet)
                            {
                                isAssignedPresent = true;
                            }
                        }
                    }

                    using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                    {
                        vetConnector.Open();

                        if (isAssignedPresent == false && assignedVet != "0")
                        {
                            String assignedVetQuery = "SELECT [Title], " +
                                                      "[FirstName], " +
                                                      "[LastName] " +
                                                      "FROM [DrDoolittleVet].[dbo].[Vets] " +
                                                      "WHERE [VetID] = '" + assignedVet + "'";

                            SqlCommand assignedVetCommand = new SqlCommand(assignedVetQuery, vetConnector);
                            SqlDataReader vetReader = assignedVetCommand.ExecuteReader();

                            while (vetReader.Read())
                            {
                                vetsTable.Rows.Add(Convert.ToInt32(assignedVet), vetReader["Title"] + " " + vetReader["FirstName"] + " " + vetReader["LastName"]);
                            }
                        }
                    }
                }

                catch (Exception error)
                {
                    String errorMessage = "There was a problem accessing Vet Roster details: " + error.Message;
                    DisplayPopupMessage(errorMessage);
                }
            }

            return vetsTable;
        }

        protected DataTable CreateTodaysVetsTable()
        {
            // GET DAY OF THE WEEK FOR THIS APPOINTMENT TO CHECK AGAINST VET ROSTER
            String thisDayNumber = "roster" + (((int)DateTime.Now.DayOfWeek) + 1).ToString();

            if (vetsTable.Rows.Count == 0)
            {
                String vetListQuery = "SELECT table1.[VetID], " +
                                      "table1.[Title], " +
                                      "table1.[FirstName], " +
                                      "table1.[LastName] " +
                                      "FROM [DrDoolittleVet].[dbo].[Vets] AS table1, [DrDoolittleVet].[dbo].[VetRoster] as table2 " +
                                      "WHERE table1.[VetID] = table2.[VetID] " +
                                      "AND table2.[" + @thisDayNumber + "] = 'True' " +
                                      "ORDER BY [LastName] ASC";

                vetsTable.Columns.Add("vetNumber", typeof(int));
                vetsTable.Columns.Add("vetName", typeof(String));
                vetsTable.Rows.Add(0, "(Assign Vet)");

                try
                {
                    using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                    {
                        vetConnector.Open();
                        SqlCommand vetListCommand = new SqlCommand(vetListQuery, vetConnector);
                        vetListCommand.Parameters.AddWithValue("@thisDay", thisDayNumber);

                        SqlDataReader vetReader = vetListCommand.ExecuteReader();

                        while (vetReader.Read())
                        {
                            vetsTable.Rows.Add(Convert.ToInt32(vetReader["VetID"]), vetReader["Title"] + " " + vetReader["FirstName"] + " " + vetReader["LastName"]);
                        }
                    }
                }

                catch (Exception error)
                {
                    String errorMessage = "There was a problem accessing Vet Roster details: " + error.Message;
                    DisplayPopupMessage(errorMessage);
                }
            }

            return vetsTable;
        }

        protected void BtnNewAppointment_Clicked(object sender, EventArgs e)
        {
            sqlGetAllAppointments.InsertParameters["PetID"].DefaultValue = ((DropDownList)adminAppointmentsGridView.FooterRow.FindControl("ddlNewPetName")).SelectedIndex.ToString();          
            sqlGetAllAppointments.InsertParameters["VetID"].DefaultValue = ((DropDownList)adminAppointmentsGridView.FooterRow.FindControl("ddlNewVet")).SelectedValue;
            sqlGetAllAppointments.InsertParameters["AppointDate"].DefaultValue = ((TextBox)adminAppointmentsGridView.FooterRow.FindControl("tbxNewAppointDate")).Text;
            sqlGetAllAppointments.InsertParameters["AppointTime"].DefaultValue = ((TextBox)adminAppointmentsGridView.FooterRow.FindControl("tbxNewAppointTime")).Text;
            sqlGetAllAppointments.InsertParameters["AppointPrice"].DefaultValue = "0.00";
            sqlGetAllAppointments.InsertParameters["AppointComment"].DefaultValue = ((TextBox)adminAppointmentsGridView.FooterRow.FindControl("tbxNewAppointComment")).Text;
            sqlGetAllAppointments.Insert();
        }

        protected void SqlGetAllAppointments_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int newAppointmentNumber = Convert.ToInt32(e.Command.Parameters["@newAppointID"].Value);
            lblErrorMessage.Text = "New Appointment #" + newAppointmentNumber + " has been booked.";
            lblErrorMessage.ForeColor = Color.Blue;
            lblErrorMessage.Visible = true;
        }

        protected void TbxDateSearch2_TextChanged(object sender, EventArgs e)
        {
            btnClearSearch.Visible = true;
            adminAppointmentsGridView.DataSource = null;
            adminAppointmentsGridView.DataBind();

            if (String.IsNullOrEmpty(tbxDateSearch1.Text) || String.IsNullOrEmpty(tbxDateSearch2.Text))
            {
                adminAppointmentsGridView.DataSourceID = "sqlGetAllAppointments";
            }

            else
            {
                adminAppointmentsGridView.DataSourceID = "sqlAppointSearch";
            }

            adminAppointmentsGridView.DataBind();
            adminAppointmentsGridView.BottomPagerRow.Visible = true;
        }

        protected void TbxSearch3_TextChanged(object sender, EventArgs e)
        {
            btnClearSearch.Visible = true;
            adminAppointmentsGridView.DataSource = null;
            adminAppointmentsGridView.DataBind();

            if (String.IsNullOrEmpty(tbxSearch3.Text))
            {
                adminAppointmentsGridView.DataSourceID = "sqlGetAllAppointments";
            }

            else
            {
                adminAppointmentsGridView.DataSourceID = "sqlPetSearch";
            }

            adminAppointmentsGridView.DataBind();
            adminAppointmentsGridView.BottomPagerRow.Visible = true;
        }

        protected void BtnClearSearch(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
            tbxDateSearch1.Text = "";
            tbxDateSearch2.Text = "";
            tbxSearch3.Text = "";
            adminAppointmentsGridView.DataSourceID = "sqlGetAllAppointments";
            adminAppointmentsGridView.DataBind();
            btnClearSearch.Visible = false;
        }

        protected void BtnAppointmentsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/adminAppointmentsPage.aspx");
        }

        protected void BtnOwnersTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/adminCustomersPage.aspx");
        }

        protected void BtnPetsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/adminPetsPage.aspx");
        }

        protected void BtnVetsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/adminVetsPage.aspx");
        }

        protected void BtnMedicationsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/adminMedicationsPage.aspx");
        }

        protected void BtnReportsPage_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/adminReportsPage.aspx");
        }

        protected void DisplayPopupMessage(String messageString)
        {
            StringBuilder popupMessage = new StringBuilder();
            popupMessage.Append("<script type = 'text/javascript'>");
            popupMessage.Append("window.onload = function(){alert('" + Server.HtmlEncode(messageString) + "')};");
            popupMessage.Append("</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", popupMessage.ToString());
        }
    }
}