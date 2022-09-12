using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class staffMedicationsPage : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector="Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";        
        DataSet drugDetails = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                btnAppointmentsTable.BackColor = Color.LightGray;
                btnPetsTable.BackColor = Color.LightGray;
                btnOwnersTable.BackColor = Color.LightGray;
                btnMedicationsTable.BackColor = Color.Gold;
                LoadStaffMedicationsGridView();
            }

            staffMedicationsGridView.BottomPagerRow.Visible = true;
        }

        protected void LoadStaffMedicationsGridView()
        {
            String medicationListQuery = "SELECT * FROM [DrDoolittleVet].[dbo].Medications";

            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter drugAdapter = new SqlDataAdapter(medicationListQuery, vetConnector);
                drugAdapter.Fill(drugDetails);
                staffMedicationsGridView.DataSource = drugDetails.Tables[0];
                staffMedicationsGridView.DataBind();
                ViewState["sortExpression"] = drugDetails.Tables[0];
                ViewState["sortDirection"] = "ASC";
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Medication details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }

        protected void StaffMedicationsGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            String priceString = "";
            tbxTitle1.Text = "Details";

            GridViewRow currentRow = staffMedicationsGridView.SelectedRow;

            DataTable currentDrug = new DataTable();
            currentDrug.Columns.Add("Drug # :");
            currentDrug.Columns.Add("Medication :");
            currentDrug.Columns.Add("Supplier :");
            currentDrug.Columns.Add("Price :"); //4
            currentDrug.Columns.Add("Stock :");

            priceString = Math.Round(Double.Parse(currentRow.Cells[4].Text), 2).ToString("C");

            currentDrug.Rows.Add(currentRow.Cells[1].Text, currentRow.Cells[2].Text, currentRow.Cells[3].Text, priceString, currentRow.Cells[5].Text);

            drugDetails.Tables.Add(currentDrug);
            staffMedicationsDetailsView.DataSource = drugDetails.Tables[0];
            staffMedicationsDetailsView.DataBind();
        }

        protected void StaffMedicationsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            staffMedicationsGridView.PageIndex = e.NewPageIndex;
            LoadStaffMedicationsGridView();
        }

        protected void StaffMedicationsGridView_Sorting(object sender, GridViewSortEventArgs e)
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
                staffMedicationsGridView.DataSource = sortResult;
                staffMedicationsGridView.DataBind();
            }
        }

        protected void StaffMedicationsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "SELECT button to view Medication details.";

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
                e.Row.ToolTip = "Current Page: " + (staffMedicationsGridView.PageIndex + 1).ToString();
            }
        }

        protected void BtnAppointmentsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffAppointmentsPage.aspx");
        }

        protected void BtnOwnerTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffCustomersPage.aspx");
        }

        protected void BtnPetsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffPetsPage.aspx");
        }

        protected void BtnMedicationsTable_Clicked(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffMedicationsPage.aspx");
        }

        protected void BtnSearch_Click(object sender, EventArgs e)
        {
            String medicationListQuery = "SELECT * FROM [DrDoolittleVet].[dbo].Medications " +
                                         "WHERE [DrugName] LIKE '" + tbxDrugSearch.Text + "%'";

            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter drugAdapter = new SqlDataAdapter(medicationListQuery, vetConnector);
                drugAdapter.Fill(drugDetails);
                staffMedicationsGridView.DataSource = drugDetails.Tables[0];
                staffMedicationsGridView.DataBind();
                staffMedicationsGridView.BottomPagerRow.Visible = true;
                ViewState["sortExpression"] = drugDetails.Tables[0];
                ViewState["sortDirection"] = "ASC";
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem searching Medications details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            finally
            {
                tbxDrugSearch.Text = "";
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