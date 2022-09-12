using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class adminCustomersPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                btnAppointmentsTable.BackColor = Color.LightGray;
                btnOwnersTable.BackColor = Color.Gold;
                btnPetsTable.BackColor = Color.LightGray;
                btnVetsTable.BackColor = Color.LightGray;
                btnMedicationsTable.BackColor = Color.LightGray;
            }

            lblErrorMessage.Visible = false;
            adminCustomersGridView.BottomPagerRow.Visible = true;
        }

        protected void AdminCustomersGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            adminCustomersGridView.PageIndex = e.NewPageIndex;
        }

        protected void AdminCustomersGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "EDIT button to modify Customer details.";

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
                    e.Row.ToolTip = "UPDATE button to save Customer details. \nCANCEL button to stop modifying";
                }
            }

            if (e.Row.RowType == DataControlRowType.DataRow && (e.Row.RowState & DataControlRowState.Edit) != DataControlRowState.Edit && (e.Row.RowState & DataControlRowState.Insert) != DataControlRowState.Insert)
            {
                // SET DATASOURCE FOR DROP-DOWN LIST (ddlPetsOwnedList)                
                int custNumber;
                DropDownList ddlPetsOwnedList = (DropDownList)e.Row.FindControl("ddlPetsOwnedList");
                custNumber = Convert.ToInt32(((Label)e.Row.FindControl("lblCustID2")).Text);
                ddlPetsOwnedList.DataSource = CreatePetsOwnedTable(custNumber);
                ddlPetsOwnedList.DataBind();
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                // DISPLAY TOOLTIP FOR FOOTER-ROW
                e.Row.ToolTip = "ADD button to create new Customer record.";

                // HIGHLIGHT CURRENT ROW ON MOUSE-OVER
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='LightCyan';";

                // CHANGE BACKGROUND COLOR OF FOOTER-ROW BACK TO ORIGINAL COLOUR AFTER MOUSE-OVER
                if (adminCustomersGridView.Rows.Count % 2 == 0)
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
                e.Row.ToolTip = "Current Page: " + (adminCustomersGridView.PageIndex + 1).ToString();
            }
        }

        protected void AdminCustomersGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                e.KeepInEditMode = true;
                lblErrorMessage.Text = "Cust #" + e.Keys[0].ToString() + " has not been updated due to data conflict.";
                lblErrorMessage.ForeColor = Color.Red;
                lblErrorMessage.Visible = true;
            }

            else
            {
                lblErrorMessage.Text = "Cust #" + e.Keys[0].ToString() + " has been successfully updated.";
                lblErrorMessage.ForeColor = Color.Blue;
                lblErrorMessage.Visible = true;
            }
        }

        protected DataTable CreatePetsOwnedTable(int customer)
        {
            String vetDatabaseConnector = "Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";

            String petListQuery = "SELECT [PetName] " +
                                  "FROM [dbo].Pets WHERE [OwnerID] = " + customer;

            String thisPetName = "";

            DataTable petsTable = new DataTable();

            petsTable.Columns.Add("petName", typeof(String));
            petsTable.Rows.Add("(Pets)");

            try
            {
                using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                {
                    vetConnector.Open();
                    SqlCommand petCommand = new SqlCommand(petListQuery, vetConnector);
                    SqlDataReader petReader = petCommand.ExecuteReader();

                    while (petReader.Read())
                    {
                        thisPetName = petReader["PetName"].ToString();
                        petsTable.Rows.Add(thisPetName);
                    }

                    if (petsTable.Rows.Count == 1)
                    {
                        DataRow noPetHeader = petsTable.Rows[0];
                        petsTable.Rows.Remove(noPetHeader);
                        petsTable.Rows.Add("(None)");
                    }

                    else if (petsTable.Rows.Count == 2)
                    {
                        DataRow singlePetHeader1 = petsTable.Rows[0];
                        DataRow singlePetHeader2 = petsTable.Rows[1];
                        petsTable.Rows.Remove(singlePetHeader1);
                        petsTable.Rows.Remove(singlePetHeader2);
                        petsTable.Rows.Add(thisPetName);
                    }
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Pet details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            return petsTable;
        }

        protected void BtnNewCustomer_Clicked(object sender, EventArgs e)
        {
            sqlGetAllCustomers.InsertParameters["FirstName"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustFirstName")).Text;
            sqlGetAllCustomers.InsertParameters["LastName"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustLastName")).Text;
            sqlGetAllCustomers.InsertParameters["Address1"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustAddress1")).Text;
            sqlGetAllCustomers.InsertParameters["Address2"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustAddress2")).Text;
            sqlGetAllCustomers.InsertParameters["State"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustState")).Text;
            sqlGetAllCustomers.InsertParameters["Postcode"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustPostcode")).Text;
            sqlGetAllCustomers.InsertParameters["PhoneNumber"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustPhoneNumber")).Text;
            sqlGetAllCustomers.InsertParameters["EmailAddress"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustEmail")).Text;
            sqlGetAllCustomers.InsertParameters["ProofType"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustProofType")).Text;
            sqlGetAllCustomers.InsertParameters["ProofNumber"].DefaultValue = ((TextBox)adminCustomersGridView.FooterRow.FindControl("txtNewCustProofNumber")).Text;
            sqlGetAllCustomers.Insert();            
        }

        protected void SqlGetAllCustomers_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int newCustNumber = Convert.ToInt32(e.Command.Parameters["@newOwnerID"].Value);
            lblErrorMessage.Text = "New Customer #" + newCustNumber + " has been added.";
            lblErrorMessage.ForeColor = Color.Blue;
            lblErrorMessage.Visible = true;
        }

        protected void TbxCustomerSearch_TextChanged(object sender, EventArgs e)
        {
            btnClearSearch.Visible = true;
            adminCustomersGridView.DataSource = null;
            adminCustomersGridView.DataBind();

            if (String.IsNullOrEmpty(tbxCustomerSearch.Text))
            {
                adminCustomersGridView.DataSourceID = "sqlGetAllCustomers";
            }

            else
            {
                adminCustomersGridView.DataSourceID = "sqlCustomerSearch";
            }

            adminCustomersGridView.DataBind();
            adminCustomersGridView.BottomPagerRow.Visible = true;
        }

        protected void BtnClearSearch(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
            tbxCustomerSearch.Text = "";
            adminCustomersGridView.DataSourceID = "sqlGetAllCustomers";
            adminCustomersGridView.DataBind();
            btnClearSearch.Visible = false;

            adminCustomersGridView.BottomPagerRow.Visible = true;

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
 