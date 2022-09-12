using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class staffPetsPage : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector="Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";
        DataSet petDetails = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                btnAppointmentsTable.BackColor = Color.LightGray;
                btnPetsTable.BackColor = Color.Gold;
                btnOwnersTable.BackColor = Color.LightGray;
                btnMedicationsTable.BackColor = Color.LightGray;
                LoadStaffPetsGridView();
            }

            staffPetsGridView.BottomPagerRow.Visible = true;
        }

        protected void LoadStaffPetsGridView()
        {
            String petListQuery = "SELECT table1.[PetID], " +
                                  "(table2.[FirstName] + ' ' + table2.[LastName]) AS 'Owner', " +
                                  "table1.[PetName] AS 'Pet Name', " +
                                  "table1.[PetBreed] AS 'Breed', " +
                                  "table1.[PetGender] AS 'Gender', " +
                                  "CONVERT(varchar(10), [PetBirthDate], 111) AS 'Birth Date', " +
                                  "table1.[PetMedicalHistory] " +
                                  "FROM [DrDoolittleVet].[dbo].Pets AS table1, [DrDoolittleVet].[dbo].PetOwners AS table2 " +
                                  "WHERE table1.[OwnerID] = table2.[OwnerID]";
 
            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter petAdapter = new SqlDataAdapter(petListQuery, vetConnector);
                petAdapter.Fill(petDetails);
                staffPetsGridView.DataSource = petDetails.Tables[0];
                staffPetsGridView.DataBind();
                ViewState["sortExpression"] = petDetails.Tables[0];
                ViewState["sortDirection"] = "ASC";
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Pet details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }

        protected void StaffPetsGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable currentPet = new DataTable();
            GridViewRow currentRow = staffPetsGridView.SelectedRow;
            tbxTitle1.Text = "Details";
            tbxTitle2.Text = "Medical History";
            tbxMedicalHistory.Visible = true;
            tbxMedicalHistory.BackColor = Color.LightGoldenrodYellow;

            currentPet.Columns.Add("Pet # :");
            currentPet.Columns.Add("Pet Name :");
            currentPet.Columns.Add("Pet Owner :");
            currentPet.Columns.Add("Breed :");
            currentPet.Columns.Add("Gender :");
            currentPet.Columns.Add("Birth Date :");

            currentPet.Rows.Add(currentRow.Cells[1].Text, currentRow.Cells[3].Text, currentRow.Cells[2].Text, currentRow.Cells[4].Text, currentRow.Cells[5].Text, currentRow.Cells[6].Text);

            petDetails.Tables.Add(currentPet);
            staffPetDetailsView.DataSource = petDetails.Tables[0];
            staffPetDetailsView.DataBind();

            tbxMedicalHistory.Text = currentRow.Cells[7].Text;
        }

        protected void StaffPetsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            staffPetsGridView.PageIndex = e.NewPageIndex;
            LoadStaffPetsGridView();
        }

        protected void StaffPetsGridView_Sorting(object sender, GridViewSortEventArgs e)
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
                staffPetsGridView.DataSource = sortResult;
                staffPetsGridView.DataBind();
            }
        }

        protected void StaffPetsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "SELECT button to view Pet details.";

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
                e.Row.ToolTip = "Current Page: " + (staffPetsGridView.PageIndex + 1).ToString();
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
            String petListQuery = "SELECT table1.[PetID], " +
                                  "(table2.[FirstName] + ' ' + table2.[LastName]) AS 'Owner', " +
                                  "table1.[PetName] AS 'Pet Name', " +
                                  "table1.[PetBreed] AS 'Breed', " +
                                  "table1.[PetGender] AS 'Gender', " +
                                  "CONVERT(varchar(10), [PetBirthDate], 111) AS 'Birth Date', " +
                                  "table1.[PetMedicalHistory] " +
                                  "FROM [DrDoolittleVet].[dbo].Pets AS table1, [DrDoolittleVet].[dbo].PetOwners AS table2 " +
                                  "WHERE table1.[OwnerID] = table2.[OwnerID]" +
                                  "AND table1.[PetName] LIKE '" + tbxPetSearch.Text + "%'";

            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter petAdapter = new SqlDataAdapter(petListQuery, vetConnector);
                petAdapter.Fill(petDetails);
                staffPetsGridView.DataSource = petDetails.Tables[0];
                staffPetsGridView.DataBind();
                staffPetsGridView.BottomPagerRow.Visible = true;
                ViewState["sortExpression"] = petDetails.Tables[0];
                ViewState["sortDirection"] = "ASC";
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem searching Pet details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            finally
            {
                tbxPetSearch.Text = "";
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