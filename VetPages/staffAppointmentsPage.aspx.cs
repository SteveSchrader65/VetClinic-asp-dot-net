using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class staffAppointmentsPage : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector="Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";
        DataSet appointDetails = new DataSet();

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
                LoadStaffAppointmentsGridView();
            }

            staffAppointmentsGridView.BottomPagerRow.Visible = true;
        }

        protected void LoadStaffAppointmentsGridView()
        {
            String appointListQuery = "SELECT * FROM (" +
                                      "SELECT TOP(500) table1.[AppointID], " +
	                                  "CONVERT(varchar(10), table1.[AppointDate], 111) AS 'Date', " +
                                      "FORMAT(CAST(table1.[AppointTime] AS datetime), 'hh:mm tt') AS 'Time', " +
                                      "table2.[PetName] AS 'Pet', " +
                                      "table3.[FirstName] + ' ' + table3.[LastName] AS 'Owner', " +
                                      "table4.[Title] + ' ' + table4.[FirstName] + ' ' + table4.[LastName] AS 'Vet', " +
                                      "table1.[AppointComment], " +
                                      "table1.[AppointPrice] " +
                                      "FROM[DrDoolittleVet].[dbo].Appointments AS table1 INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].Pets AS table2 ON table1.[PetID] = table2.[PetID] INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].PetOwners AS table3 ON table2.[OwnerID] = table3.[OwnerID] INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].Vets AS table4 ON table1.[VetID] = table4.[VetID] " +
                                      "WHERE table1.[VetID] = '" + Session["vetID"] + "' " +
                                      "AND table1.[AppointDate] = CAST(GETDATE() AS DATE) " +
                                      "ORDER BY 'Time' ASC " +
	                                  ") AS tbl1 " +
                                      "UNION ALL " +
                                      "SELECT * FROM(" +
                                      "SELECT TOP (500) table1.[AppointID], " +
                                      "CONVERT(varchar(10), table1.[AppointDate], 111) AS 'Date', " +
                                      "FORMAT(CAST(table1.[AppointTime] AS datetime), 'hh:mm tt') AS 'Time', " +
                                      "table2.[PetName] AS 'Pet', " +
                                      "table3.[FirstName] + ' ' + table3.[LastName] AS 'Owner', " +
                                      "table4.[Title] + ' ' + table4.[FirstName] + ' ' + table4.[LastName] AS 'Vet', " +
                                      "table1.[AppointComment], " +
                                      "table1.[AppointPrice] " +
                                      "FROM[DrDoolittleVet].[dbo].Appointments AS table1 INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].Pets AS table2 ON table1.[PetID] = table2.[PetID] INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].PetOwners AS table3 ON table2.[OwnerID] = table3.[OwnerID] INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].Vets AS table4 ON table1.[VetID] = table4.[VetID] " +
                                      "WHERE table1.[VetID] = '" + Session["vetID"] + "' " +
                                      "AND table1.[AppointDate] != CAST(GETDATE() AS DATE) " +
                                      "ORDER BY 'Date' DESC, 'Time' ASC " +
	                                  ") AS tbl2 " +
                                      "UNION ALL " + 
                                      "SELECT * FROM(" +
                                      "SELECT TOP (500) table1.[AppointID], " +
                                      "CONVERT(varchar(10), table1.[AppointDate], 111) AS 'Date', " +
                                      "FORMAT(CAST(table1.[AppointTime] AS datetime), 'hh:mm tt') AS 'Time', " +
                                      "table2.[PetName] AS 'Pet', " +
                                      "table3.[FirstName] + ' ' + table3.[LastName] AS 'Owner', " +
                                      "table4.[Title] + ' ' + table4.[FirstName] + ' ' + table4.[LastName] AS 'Vet', " +
                                      "table1.[AppointComment], " +
                                      "table1.[AppointPrice] " +
                                      "FROM[DrDoolittleVet].[dbo].Appointments AS table1 INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].Pets AS table2 ON table1.[PetID] = table2.[PetID] INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].PetOwners AS table3 ON table2.[OwnerID] = table3.[OwnerID] INNER JOIN " +
                                      "[DrDoolittleVet].[dbo].Vets AS table4 ON table1.[VetID] = table4.[VetID] " +
                                      "AND table1.[VetID] != '" + Session["vetID"] + "' " +
                                      "ORDER BY 'Date' DESC, 'Time' ASC" +
                                      ") AS tbl3";

            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter appointAdapter = new SqlDataAdapter(appointListQuery, vetConnector);
                appointAdapter.Fill(appointDetails);
                staffAppointmentsGridView.DataSource = appointDetails.Tables[0];
                staffAppointmentsGridView.DataBind();
                ViewState["sortExpression"] = appointDetails.Tables[0];
                ViewState["sortDirection"] = "ASC";
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Appointment details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }

        protected void StaffAppointmentsGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow currentRow = staffAppointmentsGridView.SelectedRow;
            DataTable currentAppointment = new DataTable();
            
            tbxTitle1.Text = "Details";
            tbxTitle2.Text = "Appointment Comments";
            staffAppointmentDetailsView.Visible = true;
            tbxAppointComment.Visible = true;
            tbxAppointComment.BackColor = Color.LightGoldenrodYellow;

            currentAppointment.Columns.Add("Appoint # :");
            currentAppointment.Columns.Add("Date :");
            currentAppointment.Columns.Add("Time :");
            currentAppointment.Columns.Add("Pet :");
            currentAppointment.Columns.Add("Owner :");

            currentAppointment.Rows.Add((currentRow.FindControl("lblAppointID") as Label).Text, currentRow.Cells[2].Text, currentRow.Cells[3].Text,
                (currentRow.FindControl("lblPetName") as Label).Text,
                (currentRow.FindControl("lblOwnerName") as Label).Text);

            appointDetails.Tables.Add(currentAppointment);
            staffAppointmentDetailsView.DataSource = appointDetails.Tables[0];
            staffAppointmentDetailsView.DataBind();

            tbxAppointComment.Text = (currentRow.FindControl("lblAppointComment") as Label).Text;
        }

        protected void StaffAppointmentsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            staffAppointmentsGridView.PageIndex = e.NewPageIndex;
            LoadStaffAppointmentsGridView();
        }

        protected void StaffAppointmentsGridView_Sorting(object sender, GridViewSortEventArgs e)
        {
            DataTable sortResult = (DataTable)ViewState["sortExpression"];
            if (sortResult.Rows.Count > 0)
            {
                if (Convert.ToString(ViewState["sortDirection"]) == "ASC")
                {
                    sortResult.DefaultView.Sort = e.SortExpression + " DESC";
                    ViewState["sortDirection"] = "DESC";
                }
                else
                {
                    sortResult.DefaultView.Sort = e.SortExpression + " ASC";
                    ViewState["sortDirection"] = "ASC";
                }
                staffAppointmentsGridView.DataSource = sortResult;
                staffAppointmentsGridView.DataBind();
            }
        }

        protected void StaffAppointmentsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {            
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "DETAILS button to view Appointment details";

                // HIGHLIGHT CURRENT ROW ON MOUSE-OVER
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='LightCyan';";
                
                // CHECK IF SESSION VET HAS BEEN ASSIGNED TO THIS APPOINTMENT
                Label thisVetName = e.Row.FindControl("lblVetName") as Label;

                if (thisVetName.Text == (Session["vetTitle"] + " " + Session["vetName"] + " " + Session["vetLastName"]))
                {

                    Label lblCost = (Label)e.Row.FindControl("lblAppointCost");
                    Double appointmentCost = Convert.ToDouble(lblCost.Text);
                    
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='LightGreen'";
                    e.Row.BackColor = Color.LightGreen;

                    if (appointmentCost == 0.00 && e.Row.Cells[2].Text == DateTime.Today.ToString("yyyy/MM/dd"))
                    {
                        Button btnMyAppointment = e.Row.FindControl("btnTreatPet") as Button;
                        btnMyAppointment.Visible = true;
                        e.Row.ToolTip = "DETAILS button to view Appointment details \nTREAT PET button to conduct Appointment.";
                    }
                }

                // CHANGE BACKGROUND COLOR OF DATA-ROW BACK TO ORIGINAL COLOUR AFTER MOUSE-OVER
                else if (e.Row.RowIndex % 2 == 0)
                {
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='LightGoldenrodYellow';";
                }

                else
                {
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='PaleGoldenrod';";
                }
            }

            if (e.Row.RowType == DataControlRowType.Pager)
            {
                // DISPLAY TOOLTIP FOR PAGER-ROW
                e.Row.ToolTip = "Current Page: " + (staffAppointmentsGridView.PageIndex + 1).ToString();
            }
        }

        protected void StaffAppointmentsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "TreatPet")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument.ToString()) % ((GridView)sender).PageSize;
                Session["thisAppointment"] = (staffAppointmentsGridView.Rows[rowIndex].FindControl("lblAppointID") as Label).Text;

                Response.Redirect("~/VetPages/treatPetPage.aspx");
            }
        }

        protected void BtnAppointmentsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffAppointmentsPage.aspx");
        }

        protected void BtnPetsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffPetsPage.aspx");
        }

        protected void BtnOwnerTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffCustomersPage.aspx");
        }

        protected void BtnMedicationsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffMedicationsPage.aspx");
        }
       
        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            String appointSearchQuery = "SELECT table1.[AppointID]," +
                                        "CONVERT(varchar(10), table1.[AppointDate], 111) AS 'Date', " +
                                        "FORMAT(CAST(table1.[AppointTime] AS datetime), 'hh:mm tt') AS 'Time'," +
                                        "table2.[PetName] AS 'Pet', " +
                                        "table3.[FirstName] + ' ' + table3.[LastName] AS 'Owner', " +
                                        "table4.[Title] + ' ' + table4.[FirstName] + ' ' + table4.[LastName] AS 'Vet', " +
                                        "table1.[AppointComment], " +                                        
                                        "table1.[AppointPrice] " +                                        
                                        "FROM [DrDoolittleVet].[dbo].Appointments AS table1 INNER JOIN " +
                                        "[DrDoolittleVet].[dbo].Pets AS table2 ON table1.[PetID] = table2.[PetID] INNER JOIN " +
                                        "[DrDoolittleVet].[dbo].PetOwners AS table3 ON table2.[OwnerID] = table3.[OwnerID] INNER JOIN " +
                                        "[DrDoolittleVet].[dbo].Vets AS table4 ON table1.[VetID] = table4.[VetID] " +
                                        "WHERE table1.[AppointDate] BETWEEN '" + tbxDateSearch1.Text + "' AND '" + tbxDateSearch2.Text + "'" +
                                        "ORDER BY 'Date' ASC, 'Time' ASC";

            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter appointAdapter = new SqlDataAdapter(appointSearchQuery, vetConnector);
                appointAdapter.Fill(appointDetails);
                staffAppointmentsGridView.DataSource = appointDetails.Tables[0];
                staffAppointmentsGridView.DataBind();
                staffAppointmentsGridView.BottomPagerRow.Visible = true;
                ViewState["sortExpression"] = appointDetails.Tables[0];
                ViewState["sortDirection"] = "ASC";
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem searching Appointment details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }            
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