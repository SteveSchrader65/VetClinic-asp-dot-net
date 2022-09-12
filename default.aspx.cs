using System;
using System.Data.SqlClient;
using System.Text;

namespace DrDoolittleVetClinic
{ 
    public partial class _default : System.Web.UI.Page
    {
        readonly String databaseConnector="Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            if (CheckVetLogin())
            {
                if ((String)Session["isAdmin"] == "True")
                {
                    Response.Redirect("~/VetPages/adminAppointmentsPage.aspx");
                }

                else
                {
                    Response.Redirect("~/VetPages/staffAppointmentsPage.aspx");
                }
            }            
        }

        protected Boolean CheckVetLogin()
        {
            int count = 0;
            int vetID = 0;
            Boolean isLoginOK = false;
            String messageString;
            String vetTitle = "";
            String vetFirstName = "";
            String vetLastName = "";

            String vetExistsQuery = "SELECT count(VetID) " +
                                    "FROM dbo.Vets " +
                                    "WHERE EmailAddress = '" + tbxEMailAddress.Text + "'";

            String vetPasswordQuery = "SELECT VetID, " +
                                      "Title, " +
                                      "FirstName, " +
                                      "LastName " +
                                      "FROM dbo.Vets " +
                                      "WHERE EmailAddress = '" + tbxEMailAddress.Text + "' AND Password = '" + tbxPasswordEntry.Text + "'";

            try
            {
                using (var vetConnection = new SqlConnection(databaseConnector))
                using (SqlCommand vetCommand = new SqlCommand(vetExistsQuery, vetConnection))
                {
                    vetConnection.Open();
                    using (var vetExistsReader = vetCommand.ExecuteReader())
                    {
                        if (vetExistsReader.Read())
                        {
                            count = vetExistsReader.GetInt32(0);
                        }

                        vetExistsReader.Close();

                        if (count == 0)
                        {
                            isLoginOK = false;
                            messageString = "That e-mail address does not exist in the Vet database";
                            DisplayPopupMessage(messageString);
                            tbxEMailAddress.Text = "";
                            tbxEMailAddress.Focus();
                        }

                        else
                        {
                            using (SqlCommand vetCommand2 = new SqlCommand(vetPasswordQuery, vetConnection))
                            {
                                SqlDataReader vetDataReader = vetCommand2.ExecuteReader();
                                if (vetDataReader.HasRows)
                                {
                                    while (vetDataReader.Read())
                                    {
                                        vetID = Int32.Parse(vetDataReader["VetID"].ToString());
                                        vetTitle = vetDataReader["Title"].ToString();
                                        vetFirstName = vetDataReader["FirstName"].ToString();
                                        vetLastName = vetDataReader["LastName"].ToString();
                                     }

                                    isLoginOK = true;
                                    Session["vetID"] = vetID;
                                    Session["vetTitle"] = vetTitle;
                                    Session["vetName"] = vetFirstName;
                                    Session["vetLastName"] = vetLastName;

                                    if (vetID == 1)
                                    {
                                        Session["isAdmin"] = "True";
                                    }

                                    else
                                    {
                                        Session["isAdmin"] = "False";
                                    }
                                }

                                vetDataReader.Close();
                            }

                            vetConnection.Close();

                            if (isLoginOK)
                            {
                                tbxEMailAddress.Text = "";
                            }

                            else
                            {
                                messageString = "Your password is incorrect";
                                DisplayPopupMessage(messageString);
                                tbxPasswordEntry.Focus();
                            }
                        }
                    }
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing Vet details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            return isLoginOK;
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
