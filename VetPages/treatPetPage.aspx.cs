using System;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Web.UI.WebControls;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class treatPetPage : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector = "Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";

        int thisPet;
        int thisAppointment;
        public static String thisAppointmentReason;
        DataSet appointmentDetails = new DataSet();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["thisPet"] != null)
            {
                if (!int.TryParse(Session["thisPet"].ToString(), out thisPet))
                {
                    String message = "There was a problem getting the Vet Rosters";
                    DisplayPopupMessage(message);
                }
            }
            
            if (!IsPostBack)
            {                
                tbxWelcome.Text = "Hello, " + Session["vetTitle"] + " " + Session["vetName"].ToString() + " ...";
                tbxCurrentDate.Text = DateTime.Today.ToLongDateString();
                DisplayCurrentAppointment();
                ddlConsultationList.SelectedIndex = 0;
                rdoProceduresList.SelectedIndex = -1;
            }
        }

        protected void DisplayCurrentAppointment()
        {
            DataTable currentAppointment = new DataTable();
            String currentAppointmentQuery = "spTreatPetDetails";
            thisAppointment = Convert.ToInt32(Session["thisAppointment"]);

            currentAppointment.Columns.Add("Appoint# : ");
            currentAppointment.Columns.Add("Date : ");
            currentAppointment.Columns.Add("Time : ");
            currentAppointment.Columns.Add("Pet Owner : ");
            currentAppointment.Columns.Add("Pet Name : ");
            currentAppointment.Columns.Add("Breed : ");
            currentAppointment.Columns.Add("Gender : ");
            currentAppointment.Columns.Add("Birth Date : ");
            currentAppointment.Columns.Add("Comments : ");

            try
            {
                using (var vetConnector = new SqlConnection(vetDatabaseConnector))
                {
                    vetConnector.Open();
                    using (SqlCommand appointCommand = new SqlCommand(currentAppointmentQuery, vetConnector))
                    {
                        appointCommand.CommandType = CommandType.StoredProcedure;
                        appointCommand.Parameters.Add(new SqlParameter("AppointID", thisAppointment));
                        SqlDataReader appointDataReader = appointCommand.ExecuteReader();

                        while (appointDataReader.Read())
                        {
                            thisPet = Convert.ToInt32(appointDataReader["PetID"]);
                            Session["thisPet"] = thisPet;
                            currentAppointment.Rows.Add(thisAppointment,
                                appointDataReader["Date"].ToString(),
                                appointDataReader["Time"].ToString(),
                                appointDataReader["Owner"].ToString(),
                                appointDataReader["Pet"].ToString(),
                                appointDataReader["Breed"].ToString(),
                                appointDataReader["Gender"].ToString(),
                                appointDataReader["Birth Date"].ToString(),
                                appointDataReader["AppointComment"].ToString());

                            tbxMedicalHistory.Text = appointDataReader["PetMedicalHistory"].ToString();
                        }

                        appointDataReader.Close();
                        appointmentDetails.Tables.Add(currentAppointment);
                    }

                    vetConnector.Close();
                    dvAppointmentDetails.DataSource = appointmentDetails.Tables[0];
                    dvAppointmentDetails.DataBind();
                }

                lblMedicalHistory.Text = "Medical History of: " + appointmentDetails.Tables[0].Rows[0].ItemArray[4] + " the " + appointmentDetails.Tables[0].Rows[0].ItemArray[5];
                tbxMedicalHistory.Font.Bold = true;             
                thisAppointmentReason = "-----: " + appointmentDetails.Tables[0].Rows[0].ItemArray[8].ToString();
                tbxMedicalHistory.Font.Bold = true;
                tbxMedicalHistory.Text += "Appt#:" + thisAppointment + " " + System.DateTime.Now.ToString("yyyy-MM-dd") + System.Environment.NewLine;
                tbxMedicalHistory.Font.Bold = false;
                tbxMedicalHistory.Text += thisAppointmentReason + System.Environment.NewLine;
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem accessing this Appointment details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }
        }
        protected void PrescriptionsGridView_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            prescriptionsGridView.PageIndex = e.NewPageIndex;
        
        }

        protected void PrescriptionsGridView_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // DISPLAY TOOLTIP FOR DATA-ROW
                e.Row.ToolTip = "CHECK Medication to prescribe";

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
                e.Row.ToolTip = "Current Page: " + (prescriptionsGridView.PageIndex + 1).ToString();
            }
        }

        protected void BtnUpdateMedicalHistory_Click(object sender, EventArgs e)
        {
            Double appointmentCost = 0;
            Boolean drugsPrescribed = false;
            String thisAppointComment = "";
            thisAppointment = Convert.ToInt32(Session["thisAppointment"]);

            thisAppointComment = "\bAppt#" + thisAppointment + " " + DateTime.Now.ToString("yyyy-MM-dd") + "\n";
            thisAppointComment += thisAppointmentReason + "\n";
            thisAppointComment += tbxConsultationNotes.Text + "\n";
            thisAppointComment += "Prescribed: ";
            tbxMedicalHistory.Text += tbxConsultationNotes.Text + "\n";
            tbxMedicalHistory.Text += "Prescribed: ";

            SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector);
            vetConnector.Open();

            foreach (GridViewRow drug in prescriptionsGridView.Rows)
            {
                CheckBox prescribed = (CheckBox)drug.FindControl("chkPrescribed");

                // EXAMINE EACH CHECKBOX ...
                if (prescribed.Checked)
                {
                    drugsPrescribed = true;

                    // GET DETAILS OF THIS SELECTED MEDICATION
                    Label thisDrugNumberString = (Label)drug.FindControl("lblDrugID");
                    Label thisDrugNameString = (Label)drug.FindControl("lblDrugName");
                    Label thisDrugPriceString = (Label)drug.FindControl("lblDrugSalePrice");
                    Label thisDrugQuantityString = (Label)drug.FindControl("lblDrugQuantity");
                    int thisDrugNumber = Convert.ToInt32(thisDrugNumberString.Text);
                    Decimal thisDrugSalePrice = Convert.ToDecimal(thisDrugPriceString.Text);
                    int thisDrugQuantity = Convert.ToInt32(thisDrugQuantityString.Text);

                    // CREATE RECORD IN PRESCRIBED MEDICATIONS TABLE FOR THIS SELECTED MEDICATION
                    String prescriptionInsert = "INSERT INTO [DrDoolittleVet].[dbo].[PrescribedMedications] " +
                                                "([AppointmentID], [DrugID]) " +
                                                "VALUES ('" +
                                                @thisAppointment + "', '" +
                                                @thisDrugNumber + "');";

                    try
                    {
                        using (SqlCommand updatePrescribedMedications = new SqlCommand(prescriptionInsert, vetConnector))
                        {
                            updatePrescribedMedications.Parameters.AddWithValue("@thisAppointment", thisAppointment);
                            updatePrescribedMedications.Parameters.AddWithValue("@thisDrugNumber", thisDrugNumber);
                            updatePrescribedMedications.ExecuteNonQuery();
                        }
                    }

                    catch (Exception error)
                    {
                        String errorMessage = "There was a problem updating Prescription details: " + error.Message;
                        DisplayPopupMessage(errorMessage);
                    }

                    // DEDUCT ONE UNIT FROM THIS DRUG QUANTITY AND UPDATE MEDICATIONS TABLE
                    --thisDrugQuantity;

                    String drugQuantityUpdate = "UPDATE [DrDoolittleVet].[dbo].[Medications] " +
                                                "SET [DrugQuantity] = @DrugQuantity " +
                                                "WHERE [DrugID] = @thisDrug";

                    try
                    {
                        using (SqlCommand updateMedicationQuantity = new SqlCommand(drugQuantityUpdate, vetConnector))
                        {
                            updateMedicationQuantity.Parameters.AddWithValue("@DrugQuantity", thisDrugQuantity);
                            updateMedicationQuantity.Parameters.AddWithValue("@thisDrug", thisDrugNumber);
                            updateMedicationQuantity.ExecuteNonQuery();
                        }
                    }

                    catch (Exception error)
                    {
                        String errorMessage = "There was a problem updating Medication quantities: " + error.Message;
                        DisplayPopupMessage(errorMessage);
                    }

                    thisAppointComment += thisDrugNameString.Text + ", ";
                    tbxMedicalHistory.Text += thisDrugNameString.Text + ", ";
                    appointmentCost += Convert.ToDouble(thisDrugSalePrice);
                }
            }

            if (drugsPrescribed)
            {
                thisAppointComment = thisAppointComment.Remove(thisAppointComment.Length - 2, 2);
                tbxMedicalHistory.Text = tbxMedicalHistory.Text.Remove(tbxMedicalHistory.Text.Length - 2, 2);
            }

            else
            {
                thisAppointComment += "(None)";
                tbxMedicalHistory.Text += "(None)";
            }

            thisAppointComment += "\n";
            tbxMedicalHistory.Text += "\n\n";

            // WRITE PET MEDICAL HISTORY BACK TO PETS TABLE
            String medicalHistoryUpdate = "UPDATE [DrDoolittleVet].[dbo].[Pets] " +
                                          "SET [PetMedicalHistory] = @PetMedicalHistory " +
                                          "WHERE [PetID] = @thisPet";

            try
            {
                using (SqlCommand updateMedicalHistory = new SqlCommand(medicalHistoryUpdate, vetConnector))
                {
                    updateMedicalHistory.Parameters.AddWithValue("@PetMedicalHistory", tbxMedicalHistory.Text);
                    updateMedicalHistory.Parameters.AddWithValue("@thisPet", thisPet);
                    updateMedicalHistory.ExecuteNonQuery();
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem updating Pet Medical History: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            // ADD COST OF CONSULTATION TO APPOINTMENT COST
            switch (ddlConsultationList.SelectedIndex)
            {
                case 0:
                    appointmentCost += 50.00;
                    break;
                case 1:
                    appointmentCost += 75.00;
                    break;
                case 2:
                    appointmentCost += 85.00;
                    break;
            }

            // ADD COST OF PROCEDURE TO APPOINTMENT COST
            switch (rdoProceduresList.SelectedIndex)
            {
                case 0:
                    appointmentCost += 15.00;
                    break;
                case 1:
                    appointmentCost += 18.00;
                    break;
                case 2:
                    appointmentCost += 20.00;
                    break;
                case 3:
                    appointmentCost += 15.00;
                    break;
                case 4:
                    appointmentCost += 20.00;
                    break;
                case 5:
                    appointmentCost += 25.00;
                    break;
            }

            // UPDATE APPOINTMENT COST AND APPOINT COMMENT
            thisAppointComment += ddlConsultationList.SelectedValue.ToString() + "\n" + rdoProceduresList.SelectedValue.ToString() + "\n";
            String appointmentUpdate = "UPDATE [DrDoolittleVet].[dbo].[Appointments] " +
                                       "SET [AppointPrice] = @appointCost, " +
                                       "[AppointComment] = @thisAppointComment " +
                                       "WHERE [AppointID] = @thisAppointment";

            try
            {
                using (SqlCommand updateCompletedAppointment = new SqlCommand(appointmentUpdate, vetConnector))
                {
                    updateCompletedAppointment.Parameters.AddWithValue("@appointCost", appointmentCost);
                    updateCompletedAppointment.Parameters.AddWithValue("@thisAppointment", thisAppointment);
                    updateCompletedAppointment.Parameters.AddWithValue("@thisAppointComment", thisAppointComment);
                    updateCompletedAppointment.ExecuteNonQuery();
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem updating Completed Appointment: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            btnUpdateMedicalHistory.Visible = false;
            btnExit.BackColor = Color.LightGreen;            
        }

        protected void BtnExit_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/VetPages/staffAppointmentsPage.aspx");
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