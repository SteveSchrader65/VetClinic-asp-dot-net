using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class UpdateRoster : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector = "Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                DisplayVetDetails();
                LoadCurrentAvailability();
            }
        }

        protected void DisplayVetDetails()
        {
            DataTable currentVet = new DataTable();

            String currentVetQuery = "SELECT [VetID]," +
                                     "([Title] + ' ' + [FirstName] + ' ' + [LastName]) AS 'Vet', " +
                                     "[Address1] AS 'Address', " +
                                     "[Address2] AS ' ', " +
                                     "[State], " +
                                     "[PostCode] AS 'Postcode', " +
                                     "[PhoneNumber] AS 'Phone#', " +
                                     "[EmailAddress] AS 'E-mail' " +
                                     "FROM [DrDoolittleVet].[dbo].Vets " +
                                     "WHERE[VetID] = " + Session["thisVet"];

            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                SqlDataAdapter vetAdapter = new SqlDataAdapter(currentVetQuery, vetConnector);

                vetAdapter.Fill(currentVet);
                vetDetailsView.DataSource = currentVet;
                vetDetailsView.DataBind();
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Vet details: " + error.Message;
                DisplayPopupMessage(errorMessage);
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

        protected void BtnUpdateRoster_Click(object sender, EventArgs e)
        {
            Boolean[] availableArray = new Boolean[7];
            Button updateRoster = sender as Button;

            if (updateRoster != null)
            {
                // EXAMINE EACH CHECKBOX AND ADD TO ARRAY IF IT HAS BEEN SELECTED
                for (int counter = 0; counter < 7; ++counter)
                {
                    String thisDay = "chkDay" + (counter + 1).ToString();
                    CheckBox available = (CheckBox)updateRoster.Parent.FindControl(thisDay);

                    if (available.Checked)
                    {
                        availableArray[counter] = true;
                    }

                    else
                    {
                        availableArray[counter] = false;
                    }
                }
            }
 
            try
            {
                SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
                vetConnector.Open();

                String thisVetRosterUpdate = "spUpdateVetRosterRecord";
                using (SqlCommand updateVetRoster = new SqlCommand(thisVetRosterUpdate, vetConnector))
                {
                    updateVetRoster.CommandType = CommandType.StoredProcedure;
                    updateVetRoster.Parameters.AddWithValue("@VetID", Session["thisVet"]);

                    for (int counter = 0; counter < 7; ++counter)
                    {
                        String thisDay = "day" + (counter + 1).ToString();
                        updateVetRoster.Parameters.AddWithValue("@" + thisDay, availableArray[counter]);
                    }

                    updateVetRoster.ExecuteNonQuery();
                }

                btnExit.BackColor = Color.LightGreen;
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem updating the Vet Roster" + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }

        protected void BtnExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/adminVetsPage.aspx");
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