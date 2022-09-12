using System;
using System.Web.UI.WebControls;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class adminMedicationsPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                btnAppointmentsTable.BackColor = Color.LightGray;
                btnOwnersTable.BackColor = Color.LightGray;
                btnPetsTable.BackColor = Color.LightGray;
                btnVetsTable.BackColor = Color.LightGray;
                btnMedicationsTable.BackColor = Color.Gold;
            }

            lblErrorMessage.Visible = false;
            adminMedicationsGridView.BottomPagerRow.Visible = true;
        }

        protected void AdminMedicationsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            adminMedicationsGridView.PageIndex = e.NewPageIndex;
        }

        protected void AdminMedicationsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "EDIT button to modify Medication details.";

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

            if ((e.Row.RowState & DataControlRowState.Edit) == DataControlRowState.Edit)
            {
                // DISPLAY TOOLTIP FOR EDIT-ROW
                e.Row.ToolTip = "UPDATE button to save Medication details. \nCANCEL button to stop modifying";
            }

            if (e.Row.RowType == DataControlRowType.Footer)
            {
                // DISPLAY TOOLTIP FOR FOOTER-ROW
                e.Row.ToolTip = "ADD button to create new Medication record.";

                // HIGHLIGHT CURRENT ROW ON MOUSE-OVER
                e.Row.Attributes["onmouseover"] = "this.style.backgroundColor='LightCyan';";

                // CHANGE BACKGROUND COLOR OF FOOTER-ROW BACK TO ORIGINAL COLOUR AFTER MOUSE-OVER
                if (adminMedicationsGridView.Rows.Count % 2 == 0)
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
                e.Row.ToolTip = "Current Page: " + (adminMedicationsGridView.PageIndex + 1).ToString();
            }
        }

        protected void AdminMedicationsGridView_RowUpdated(object sender, GridViewUpdatedEventArgs e)
        {
            if (e.AffectedRows < 1)
            {
                e.KeepInEditMode = true;
                lblErrorMessage.Text = "Drug #" + e.Keys[0].ToString() + " has not been updated due to data conflict.";
                lblErrorMessage.ForeColor = Color.Red;
                lblErrorMessage.Visible = true;
            }

            else
            {
                lblErrorMessage.Text = "Drug #" + e.Keys[0].ToString() + " has been successfully updated.";
                lblErrorMessage.ForeColor = Color.Blue;
                lblErrorMessage.Visible = true;
            }
        }
        protected void BtnNewMedication_Clicked(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                sqlGetAllDrugs.InsertParameters["DrugName"].DefaultValue = ((TextBox)adminMedicationsGridView.FooterRow.FindControl("txtNewDrugName")).Text;
                sqlGetAllDrugs.InsertParameters["DrugSupplier"].DefaultValue = ((TextBox)adminMedicationsGridView.FooterRow.FindControl("txtNewSupplier")).Text;
                sqlGetAllDrugs.InsertParameters["DrugCostPrice"].DefaultValue = ((TextBox)adminMedicationsGridView.FooterRow.FindControl("txtNewCostPrice")).Text;
                sqlGetAllDrugs.InsertParameters["DrugSalePrice"].DefaultValue = ((TextBox)adminMedicationsGridView.FooterRow.FindControl("txtNewSalePrice")).Text;
                sqlGetAllDrugs.InsertParameters["DrugQuantity"].DefaultValue = ((TextBox)adminMedicationsGridView.FooterRow.FindControl("txtNewQuantity")).Text;
                sqlGetAllDrugs.Insert();
            }
        }

        protected void SqlGetAllDrugs_Inserted(object sender, SqlDataSourceStatusEventArgs e)
        {
            int newDrugNumber = Convert.ToInt32(e.Command.Parameters["@newDrugID"].Value);
            lblErrorMessage.Text = "New Medication #" + newDrugNumber + " has been added.";
            lblErrorMessage.ForeColor = Color.Blue;
            lblErrorMessage.Visible = true;
        }

        protected void TbxDrugSearch_TextChanged(object sender, EventArgs e)
        {
            btnClearSearch.Visible = true;

            adminMedicationsGridView.DataSource = null;
            adminMedicationsGridView.DataBind();

            if (String.IsNullOrEmpty(tbxDrugSearch.Text))
            {
                adminMedicationsGridView.DataSourceID = "sqlGetAllDrugs";
            }

            else
            {
                adminMedicationsGridView.DataSourceID = "sqlDrugSearch";
            }

            adminMedicationsGridView.DataBind();
            adminMedicationsGridView.BottomPagerRow.Visible = true;
        }

        protected void BtnClearSearch(object sender, EventArgs e)
        {
            lblErrorMessage.Visible = false;
            tbxDrugSearch.Text = "";
            adminMedicationsGridView.DataSourceID = "sqlGetAllDrugs";
            adminMedicationsGridView.DataBind();
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
