using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class adminVetsPage : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector = "Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                btnAppointmentsTable.BackColor = Color.LightGray;
                btnOwnersTable.BackColor = Color.LightGray;
                btnPetsTable.BackColor = Color.LightGray;
                btnVetsTable.BackColor = Color.Gold;
                btnMedicationsTable.BackColor = Color.LightGray;
                DisplayStaffRoster();
            }

            lblErrorMessage.Visible = false;
            adminVetsGridView.BottomPagerRow.Visible = true;
        }

        protected void DisplayStaffRoster()
        {
            using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
            {
                DataTable rosterTable = new DataTable();

                String staffRosterQueryString = "SELECT table1.[VetID], " +
                                                "(table1.[Title] + ' ' + table1.[FirstName] + ' ' + table1.[LastName]) AS 'Vet', " +
                                                "table2.[roster1] AS 'Sun', " +
                                                "table2.[roster2] AS 'Mon', " +
                                                "table2.[roster3] AS 'Tue', " +
                                                "table2.[roster4] AS 'Wed', " +
                                                "table2.[roster5] AS 'Thu', " +
                                                "table2.[roster6] AS 'Fri', " +
                                                "table2.[roster7] AS 'Sat' " +
                                                "FROM[DrDoolittleVet].[dbo].[Vets] as table1, [DrDoolittleVet].[dbo].[VetRoster] as table2 " +
                                                "WHERE table1.[VetID] = table2.[VetID]";

                try
                {
                    vetConnector.Open();
                    SqlCommand rosterCommand = new SqlCommand(staffRosterQueryString, vetConnector);
                    SqlDataReader rosterReader = rosterCommand.ExecuteReader(CommandBehavior.CloseConnection);
                    rosterTable.Load(rosterReader);
                    grdRosterDisplay.DataSource = rosterTable;
                    grdRosterDisplay.DataBind();
                }

                catch (Exception error)
                {
                    String errorMessage = "There was a problem collating Roster details: " + error.Message;
                    DisplayPopupMessage(errorMessage);
                }
            }
        }

        protected void AdminVetsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            adminVetsGridView.PageIndex = e.NewPageIndex;
        }

        protected void AdminVetsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "EDIT button to modify Vet details.\nROSTER button to set Vet Roster";

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

                if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
                {
                    // DISPLAY TOOLTIP FOR EDIT-ROW
                    e.Row.ToolTip = "UPDATE button to save Vet details. \nCANCEL button to stop modifying";
                }

                // DISPLAY ROSTER BUTTON IF CURRENT VET IS NOT 
                if ((e.Row.RowState & DataControlRowState.Edit) != DataControlRowState.Edit)
                {
                    Label thisVet = (Label)e.Row.FindControl("lblVetID2");

                    if (thisVet.Text != "1")
                    {
                        Button btnVetRoster = e.Row.FindControl("btnVetRoster") as Button;
                        btnVetRoster.Visible = true;
                        e.Row.ToolTip = "EDIT button to modify Vet details.\nROSTER button to set Vet Roster";
                    }
                }
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                // DISPLAY TOOLTIP FOR FOOTER-ROW
                e.Row.ToolTip = "ADD button to create new Vet record.";

                // HIGHLIGHT CURRENT ROW ON MOUSE-OVER
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='LightCyan';";

                // CHANGE BACKGROUND COLOR OF FOOTER-ROW BACK TO ORIGINAL COLOUR AFTER MOUSE-OVER
                if (adminVetsGridView.Rows.Count % 2 == 0)
                {
                    e.Row.BackColor = Color.LightGoldenrodYellow;
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='LightGoldenrodYellow';";
                }

                else
                {
                    e.Row.BackColor = Color.PaleGoldenrod;
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='PaleGoldenrod';";
                }
            }

            if (e.Row.RowType == DataControlRowType.Pager)
            {
                // DISPLAY TOOLTIP FOR PAGER-ROW
                e.Row.ToolTip = "Current Page: " + (adminVetsGridView.PageIndex + 1).ToString();
            }
        }

        protected void AdminVetsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Edit")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString()) % ((GridView)sender).PageSize;
                GridViewRow currentRow = adminVetsGridView.Rows[rowIndex];
                Label thisVetTitle = currentRow.FindControl("lblVetTitle") as Label;
                DropDownList ddlEditTitle = currentRow.FindControl("ddlEditVetTitle") as DropDownList;

                if (thisVetTitle != null && ddlEditTitle != null)
                {
                    thisVetTitle.Text = ddlEditTitle.SelectedValue;
                }
            }

            if (e.CommandName == "Roster")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString()) % ((GridView)sender).PageSize;
                GridViewRow currentRow = adminVetsGridView.Rows[rowIndex];
                Session["thisVet"] = (adminVetsGridView.Rows[rowIndex].FindControl("lblVetID2") as Label).Text;
                Response.Redirect("~/VetPages/vetRosterPage.aspx");
            }
        }

        protected void AdminVetsGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                e.KeepInEditMode = true;
                lblErrorMessage.Text = "Vet #" + e.Keys[0].ToString() + " has not been updated due to data conflict.";
                lblErrorMessage.ForeColor = Color.Red;
                lblErrorMessage.Visible = true;
            }

            else
            {
                lblErrorMessage.Text = "Vet #" + e.Keys[0].ToString() + " has been successfully updated.";
                lblErrorMessage.ForeColor = Color.Blue;
                lblErrorMessage.Visible = true;
            }
        }

        // LOAD EXISTING VETROSTER (FOR THIS VET) INTO TABLE
        protected void LoadCurrentAvailability()
        {
            CheckBox roster1 = null;
            CheckBox roster2 = null;
            CheckBox roster3 = null;
            CheckBox roster4 = null;
            CheckBox roster5 = null;
            CheckBox roster6 = null;
            CheckBox roster7 = null;

            String currentVetRosterQuery = "SELECT [roster1], " +
                                           "[roster2], " +
                                           "[roster3], " +
                                           "[roster4], " +
                                           "[roster5], " +
                                           "[roster6], " +
                                           "[roster7] " +
                                           "FROM [DrDoolittleVet].[dbo].[VetRoster] " +
                                           "WHERE [VetID] = " + Session["thisVet"];

            try
            {
                using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                {
                    vetConnector.Open();
                    SqlCommand rosterCommand = new SqlCommand(currentVetRosterQuery, vetConnector);
                    SqlDataReader rosterReader = rosterCommand.ExecuteReader();

                    while (rosterReader.Read())
                    {
                        roster1 = (CheckBox)this.Master.FindControl("MainContent").FindControl("chkDay1");
                        roster2 = (CheckBox)this.Master.FindControl("MainContent").FindControl("chkDay2");
                        roster3 = (CheckBox)this.Master.FindControl("MainContent").FindControl("chkDay3");
                        roster4 = (CheckBox)this.Master.FindControl("MainContent").FindControl("chkDay4");
                        roster5 = (CheckBox)this.Master.FindControl("MainContent").FindControl("chkDay5");
                        roster6 = (CheckBox)this.Master.FindControl("MainContent").FindControl("chkDay6");
                        roster7 = (CheckBox)this.Master.FindControl("MainContent").FindControl("chkDay7");
                        roster1.Checked = (Boolean)rosterReader["roster1"];
                        roster2.Checked = (Boolean)rosterReader["roster2"];
                        roster3.Checked = (Boolean)rosterReader["roster3"];
                        roster4.Checked = (Boolean)rosterReader["roster4"];
                        roster5.Checked = (Boolean)rosterReader["roster5"];
                        roster6.Checked = (Boolean)rosterReader["roster6"];
                        roster7.Checked = (Boolean)rosterReader["roster7"];
                    }

                    vetConnector.Close();
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Vet Roster details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }

        protected void BtnNewVet_Clicked(object sender, EventArgs e)
        {
            sqlGetAllVets.InsertParameters["Title"].DefaultValue = ((DropDownList)adminVetsGridView.FooterRow.FindControl("ddlNewVetTitle")).SelectedValue;
            sqlGetAllVets.InsertParameters["FirstName"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetFirstName")).Text;
            sqlGetAllVets.InsertParameters["LastName"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetLastName")).Text;
            sqlGetAllVets.InsertParameters["Address1"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetAddress1")).Text;
            sqlGetAllVets.InsertParameters["Address2"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetAddress2")).Text;
            sqlGetAllVets.InsertParameters["State"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetState")).Text;
            sqlGetAllVets.InsertParameters["PostCode"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetPostcode")).Text;
            sqlGetAllVets.InsertParameters["PhoneNumber"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetPhoneNumber")).Text;
            sqlGetAllVets.InsertParameters["Qualification"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetQualification")).Text;
            sqlGetAllVets.InsertParameters["EmailAddress"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetEmail")).Text;
            sqlGetAllVets.InsertParameters["Password"].DefaultValue = ((TextBox)adminVetsGridView.FooterRow.FindControl("txtNewVetPassword")).Text;
            sqlGetAllVets.Insert();
        }

        protected void SqlGetAllVets_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int newVetNumber = Convert.ToInt32(e.Command.Parameters["@newVetID"].Value);
            lblErrorMessage.Text = "New Vet #" + newVetNumber + " has been added.";
            lblErrorMessage.ForeColor = Color.Blue;
            lblErrorMessage.Visible = true;
            CreateNewVetRosterRecord(newVetNumber);
        }

        protected void CreateNewVetRosterRecord(int vetNumber)
        {
            String createRosterRecord = "spNewVetRosterRecord";
            SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
            vetConnector.Open();

            try
            {
                using (SqlCommand newVetRosterCommand = new SqlCommand(createRosterRecord, vetConnector))
                {
                    newVetRosterCommand.CommandType = CommandType.StoredProcedure;
                    newVetRosterCommand.Parameters.AddWithValue("@VetID", vetNumber);
                    newVetRosterCommand.ExecuteNonQuery();
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem creating Vet Roster record: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }

        protected void TbxVetSearch_TextChanged(object sender, EventArgs e)
        {
            btnClearSearch.Visible = true;
            adminVetsGridView.DataSource = null;
            adminVetsGridView.DataBind();

            if (String.IsNullOrEmpty(tbxVetSearch.Text))
            {
                adminVetsGridView.DataSourceID = "sqlGetAllVets";
            }

            else
            {
                adminVetsGridView.DataSourceID = "sqlVetSearch";
            }

            adminVetsGridView.DataBind();
            adminVetsGridView.BottomPagerRow.Visible = true;
        }

        protected void BtnClearSearch(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
            tbxVetSearch.Text = "";
            adminVetsGridView.DataSourceID = "sqlGetAllVets";
            adminVetsGridView.DataBind();
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