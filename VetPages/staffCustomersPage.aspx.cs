using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class staffCustomersPage : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector="Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";
        DataSet ownerDetails = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                btnAppointmentsTable.BackColor = Color.LightGray;
                btnPetsTable.BackColor = Color.LightGray;
                btnOwnersTable.BackColor = Color.Gold;
                btnMedicationsTable.BackColor = Color.LightGray;
                LoadStaffCustomersGridView();
            }

            staffCustomersGridView.BottomPagerRow.Visible = true;
        }

        protected void LoadStaffCustomersGridView()
        {
            String customerListQuery = "SELECT [OwnerID]," +
                                       "[FirstName], " +
                                       "[LastName], " +
                                       "[Address1], " +
                                       "[Address2], " +
                                       "[State], " +
                                       "[PostCode], " +
                                       "[PhoneNumber], " +
                                       "[EmailAddress] " +
                                       "FROM [DrDoolittleVet].[dbo].PetOwners";

            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter ownerAdapter = new SqlDataAdapter(customerListQuery, vetConnector);
                ownerAdapter.Fill(ownerDetails);
                staffCustomersGridView.DataSource = ownerDetails.Tables[0];
                staffCustomersGridView.DataBind();
                ViewState["sortExpression"] = ownerDetails.Tables[0];
                ViewState["sortDirection"] = "ASC";
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Customer details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }

        protected void StaffCustomersGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            String nameString = "";
            String addressLine2 = "";
            tbxTitle1.Text = "Details";
            tbxTitle2.Text = "Pets :";
            lstOwnedPets.Visible = true;
            lstOwnedPets.Items.Clear();
            lstOwnedPets.BackColor = Color.LightGoldenrodYellow;

            GridViewRow currentRow = staffCustomersGridView.SelectedRow;

            DataTable currentOwner = new DataTable();
            currentOwner.Columns.Add("Cust # :");
            currentOwner.Columns.Add("Cust Name :");
            currentOwner.Columns.Add("Address :");
            currentOwner.Columns.Add("        ");
            currentOwner.Columns.Add("Phone :");
            currentOwner.Columns.Add("E-Mail :");

            nameString = currentRow.Cells[2].Text + " " + currentRow.Cells[3].Text;
            addressLine2 = currentRow.Cells[5].Text + " " + currentRow.Cells[6].Text + " " + currentRow.Cells[7].Text;

            currentOwner.Rows.Add(currentRow.Cells[1].Text, nameString, currentRow.Cells[4].Text, addressLine2, currentRow.Cells[8].Text, currentRow.Cells[9].Text);

            ownerDetails.Tables.Add(currentOwner);
            staffCustomersDetailsView.DataSource = ownerDetails.Tables[0];
            staffCustomersDetailsView.DataBind();

            String petNameString = "";
            String petListQuery = "SELECT [PetName] " +
                                  "FROM [dbo].Pets WHERE [OwnerID] = " + Int32.Parse(currentRow.Cells[1].Text);

            try
            {
                using (var vetConnector = new SqlConnection(vetDatabaseConnector))
                {
                    vetConnector.Open();

                    using (SqlCommand petCommand = new SqlCommand(petListQuery, vetConnector))
                    {
                        SqlDataReader petReader = petCommand.ExecuteReader();
                        while (petReader.Read())
                        {
                            petNameString = petReader["PetName"].ToString();
                            lstOwnedPets.Items.Add(petNameString);
                        }

                        petReader.Close();
                    }

                    vetConnector.Close();
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Pet details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }

        protected void StaffCustomersGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            staffCustomersGridView.PageIndex = e.NewPageIndex;
            LoadStaffCustomersGridView();
        }

        protected void StaffCustomersGridView_Sorting(object sender, GridViewSortEventArgs e)
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
                staffCustomersGridView.DataSource = sortResult;
                staffCustomersGridView.DataBind();
            }
        }

        protected void StaffCustomersGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "SELECT button to view Pet-Owner details.";

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
            }

            if (e.Row.RowType == DataControlRowType.Pager)
            {
                // DISPLAY TOOLTIP FOR PAGER-ROW
                e.Row.ToolTip = "Current Page: " + (staffCustomersGridView.PageIndex + 1).ToString();
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
            String customerListQuery = "SELECT * FROM [DrDoolittleVet].[dbo].PetOwners " +
                                       "WHERE [FirstName] LIKE '" + tbxCustomerSearch.Text + "%'" +
                                       "OR [LastName] LIKE '" + tbxCustomerSearch.Text + "%'";

            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter drugAdapter = new SqlDataAdapter(customerListQuery, vetConnector);
                drugAdapter.Fill(ownerDetails);
                staffCustomersGridView.DataSource = ownerDetails.Tables[0];
                staffCustomersGridView.DataBind();
                staffCustomersGridView.BottomPagerRow.Visible = true;
                ViewState["sortExpression"] = ownerDetails.Tables[0];
                ViewState["sortDirection"] = "ASC";
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem searching Pet-Owners details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            finally
            {
                tbxCustomerSearch.Text = "";
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