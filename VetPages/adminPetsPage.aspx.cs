using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class adminPetsPage : System.Web.UI.Page
    {
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
            }

            lblErrorMessage.Visible = false;
            lblMedicalHistory.Visible = false;
            tbxMedicalHistory.Visible = false;
            adminPetsGridView.BottomPagerRow.Visible = true;
        }

        protected void AdminPetsGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow currentRow = adminPetsGridView.SelectedRow;

            lblMedicalHistory.Visible = true;
            tbxMedicalHistory.Visible = true;
            tbxMedicalHistory.Text = currentRow.Cells[8].Text;
            tbxMedicalHistory.BackColor = Color.LightGoldenrodYellow;
        }

        protected void AdminPetsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            adminPetsGridView.PageIndex = e.NewPageIndex;
        }

        protected void AdminPetsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "EDIT button to modify Pet details.\nSELECT button to view Medical History.";

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
                    e.Row.ToolTip = "UPDATE button to save Pet details. \nCANCEL button to stop modifying";

                    DropDownList ddlEditOwnerName = (DropDownList)e.Row.FindControl("ddlEditOwnerName");
                    TextBox thisOwnerID = e.Row.FindControl("txtOwnerID") as TextBox;

                    if (ddlEditOwnerName != null)
                    {
                        ddlEditOwnerName.DataSource = CreateOwnerNamesTable();
                        ddlEditOwnerName.DataBind();
                    }

                    int thisOwnerNumber = Convert.ToInt32(thisOwnerID.Text);
                    ddlEditOwnerName.SelectedValue = thisOwnerNumber.ToString();
                }
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                // DISPLAY TOOLTIP FOR FOOTER-ROW
                e.Row.ToolTip = "ADD button to create new Pet record.";

                // HIGHLIGHT CURRENT ROW ON MOUSE-OVER
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='LightCyan';";

                // CHANGE BACKGROUND COLOR OF FOOTER-ROW BACK TO ORIGINAL COLOUR AFTER MOUSE-OVER
                if (adminPetsGridView.Rows.Count % 2 == 0)
                {
                    e.Row.BackColor = Color.LightGoldenrodYellow;
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='LightGoldenrodYellow';";
                }

                else
                {
                    e.Row.BackColor = Color.PaleGoldenrod;
                    e.Row.Attributes["onmouseout"] = "this.style.backgroundColor='PaleGoldenrod';";
                }

                // SET DATASOURCE FOR DROP-DOWN LIST (ddlNewOwnerName)
                DropDownList ddlNewOwnerName = (DropDownList)e.Row.FindControl("ddlNewOwnerName");

                if (ddlNewOwnerName != null)
                {
                    ddlNewOwnerName.DataSource = CreateOwnerNamesTable();
                    ddlNewOwnerName.DataBind();
                }
            }

            if (e.Row.RowType == DataControlRowType.Pager)
            {
                // DISPLAY TOOLTIP FOR PAGER-ROW
                e.Row.ToolTip = "Current Page: " + (adminPetsGridView.PageIndex + 1).ToString();
            }
        }

        protected void AdminPetsGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Update")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow currentRow = adminPetsGridView.Rows[rowIndex];
                TextBox thisOwnerID = currentRow.FindControl("txtOwnerID") as TextBox;
                DropDownList ownerList = currentRow.FindControl("ddlEditOwnerName") as DropDownList;

                if (ownerList != null && thisOwnerID != null)
                {
                    thisOwnerID.Text = ownerList.SelectedValue;
                }
            }

            if (e.CommandName == "Insert")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                GridViewRow currentRow = adminPetsGridView.Rows[rowIndex];
                TextBox thisOwnerID = currentRow.FindControl("txtOwnerID") as TextBox;
                DropDownList ownerList = currentRow.FindControl("ddlEditOwnerName") as DropDownList;

                if (ownerList != null && thisOwnerID != null)
                {
                    thisOwnerID.Text = ownerList.SelectedValue;
                }
            }
        }

        protected void AdminPetsGridView_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow currentRow = adminPetsGridView.Rows[e.RowIndex];
            TextBox thisOwnerID = currentRow.FindControl("txtOwnerID") as TextBox;
            DropDownList ddlEditOwnerNameList = currentRow.FindControl("ddlEditOwnerName") as DropDownList;

            if (thisOwnerID != null && ddlEditOwnerNameList != null)
            {
                thisOwnerID.Text = ddlEditOwnerNameList.SelectedValue;
            }
        }

        protected void AdminPetsGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                e.KeepInEditMode = true;
                lblErrorMessage.Text = "Pet #" + e.Keys[0].ToString() + " has not been updated due to data conflict.";
                lblErrorMessage.ForeColor = Color.Red;
                lblErrorMessage.Visible = true;
            }

            else
            {
                lblErrorMessage.Text = "Pet #" + e.Keys[0].ToString() + " has been successfully updated.";
                lblErrorMessage.ForeColor = Color.Blue;
                lblErrorMessage.Visible = true;
            }
        }

        protected DataTable CreateOwnerNamesTable()
        {
            DataTable ownersTable = new DataTable();

            String vetDatabaseConnector = "Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";

            String namesListQuery = "SELECT [OwnerID], " +
                                    "[FirstName], " +
                                    "[LastName] " +
                                    "FROM [DrDoolittleVet].[dbo].PetOwners " +
                                    "ORDER BY [LastName] ASC";

            ownersTable.Columns.Add("ownerNumber", typeof(int));
            ownersTable.Columns.Add("ownerName", typeof(String));
            ownersTable.Rows.Add(0, "(Select Owner)");

            try
            {
                using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                {
                    vetConnector.Open();
                    SqlCommand nameCommand = new SqlCommand(namesListQuery, vetConnector);
                    SqlDataReader ownerReader = nameCommand.ExecuteReader();

                    while (ownerReader.Read())
                    {
                        ownersTable.Rows.Add(Convert.ToInt32(ownerReader["OwnerID"]), ownerReader["FirstName"] + " " + ownerReader["LastName"]);
                    }
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Owner details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            return ownersTable;
        }

        protected void BtnNewPet_Clicked(object sender, EventArgs e)
        {
            sqlGetAllPets.InsertParameters["PetName"].DefaultValue = ((TextBox)adminPetsGridView.FooterRow.FindControl("txtNewPetName")).Text;
            sqlGetAllPets.InsertParameters["OwnerID"].DefaultValue = ((DropDownList)adminPetsGridView.FooterRow.FindControl("ddlNewOwnerName")).SelectedValue;
            sqlGetAllPets.InsertParameters["PetBreed"].DefaultValue = ((TextBox)adminPetsGridView.FooterRow.FindControl("txtNewPetBreed")).Text;
            sqlGetAllPets.InsertParameters["PetGender"].DefaultValue = ((DropDownList)adminPetsGridView.FooterRow.FindControl("ddlNewPetGender")).SelectedValue;
            sqlGetAllPets.InsertParameters["PetBirthDate"].DefaultValue = ((TextBox)adminPetsGridView.FooterRow.FindControl("txtNewPetBirthDate")).Text;
            sqlGetAllPets.InsertParameters["PetMedicalHistory"].DefaultValue = null;
            sqlGetAllPets.Insert();
        }

        protected void SqlGetAllPets_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int newPetNumber = Convert.ToInt32(e.Command.Parameters["@newPetID"].Value);
            lblErrorMessage.Text = "New Pet #" + newPetNumber + " has been added.";
            lblErrorMessage.ForeColor = Color.Blue;
            lblErrorMessage.Visible = true;
        }

        protected void TbxPetSearch_TextChanged(object sender, EventArgs e)
        {
            btnClearSearch.Visible = true;
            adminPetsGridView.DataSource = null;
            adminPetsGridView.DataBind();

            if (String.IsNullOrEmpty(tbxPetSearch.Text))
            {
                adminPetsGridView.DataSourceID = "sqlGetAllPets";
            }

            else
            {
                adminPetsGridView.DataSourceID = "sqlPetSearch";
            }

            adminPetsGridView.DataBind();
            adminPetsGridView.BottomPagerRow.Visible = true;
        }

        protected void BtnClearSearch(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
            tbxPetSearch.Text = "";
            adminPetsGridView.DataSourceID = "sqlGetAllPets";
            adminPetsGridView.DataBind();
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