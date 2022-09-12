using System;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text;
using System.Text.RegularExpressions;

namespace DrDoolittleVetClinic.VetPages
{
    public partial class adminReportsPage : System.Web.UI.Page
    {
        readonly String vetDatabaseConnector = "Data Source = localhost\\MSSQLSERVER02; Initial Catalog = DrDoolittleVet; Integrated Security = true";

        int reportOneTotalAppts = 0;
        Double reportOneTotalFees = 0.00;
        public static String[] monthNames = new String[13];

        private enum MonthName
        {
            NULL, Jan, Feb, Mar, Apr, May, Jun, July, Aug, Sept, Oct, Nov, Dec
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                rblReportType.SelectedIndex = 0;
                rblReportLayout.SelectedIndex = 0;
                btnReportsPage.BackColor = Color.Gold;
                BuildMonthNameArray();
            }

            BtnCollate_Click(sender, e);
        }

        private protected void BuildMonthNameArray()
        {
            monthNames = Enum.GetNames(typeof(MonthName));
        }

        protected void GrdReportDisplay_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
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
                
                if (rblReportLayout.SelectedIndex == 1)
                {
                    String thisCell = e.Row.Cells[1].Text;
                    if (Regex.IsMatch(thisCell.Substring(0,1), @"^[0-9]+$"))
                    {
                        int monthNumber = Convert.ToInt32(e.Row.Cells[1].Text);
                        e.Row.Cells[1].Text = monthNames[monthNumber];
                    }
                }

                switch (rblReportType.SelectedIndex)
                {
                    case 0: // Report: #1
                        e.Row.Cells[3].Text = Convert.ToDouble(e.Row.Cells[3].Text).ToString("N2");
                        reportOneTotalAppts += Convert.ToInt32(e.Row.Cells[2].Text);
                        reportOneTotalFees += Convert.ToDouble(e.Row.Cells[3].Text);

                        if (e.Row.Cells[0].Text == "0")
                        {
                            e.Row.Cells[0].Text = "";
                            e.Row.Cells[1].Text = "Totals:";
                            e.Row.Cells[2].Text = reportOneTotalAppts.ToString();
                            e.Row.Cells[3].Text = reportOneTotalFees.ToString("C2");
                        }
                        break;

                    case 1: // Report: #2
                        if (e.Row.Cells[4].Text == "Week Total" || e.Row.Cells[4].Text == "Month Total" || e.Row.Cells[4].Text == "Quarter Total")
                        {
                            e.Row.Cells[1].Text = "#Appts";
                            e.Row.Cells[5].Text = Convert.ToDouble(e.Row.Cells[5].Text).ToString("C2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
                        }

                        else if (e.Row.Cells[4].Text == "Grand Total")
                        {
                            e.Row.Cells[1].Text = "Total Appts";
                            e.Row.Cells[5].Text = Convert.ToDouble(e.Row.Cells[5].Text).ToString("C2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
                        }

                        else
                        {
                            e.Row.Cells[5].Text = Math.Round(Convert.ToDouble(e.Row.Cells[5].Text), 2).ToString("N2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                        }
                        break;

                    case 2: // Report: #3
                        if (e.Row.Cells[4].Text == "Week Total" || e.Row.Cells[4].Text == "Month Total" || e.Row.Cells[4].Text == "Quarter Total")
                        {
                            e.Row.Cells[1].Text = "#Appts";
                            e.Row.Cells[5].Text = Convert.ToDouble(e.Row.Cells[5].Text).ToString("C2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
                        }

                        else if (e.Row.Cells[4].Text == "Grand Total")
                        {
                            e.Row.Cells[1].Text = "Total Appts";
                            e.Row.Cells[5].Text = Convert.ToDouble(e.Row.Cells[5].Text).ToString("C2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
                        }

                        else
                        {
                            e.Row.Cells[5].Text = Math.Round(Convert.ToDouble(e.Row.Cells[5].Text), 2).ToString("N2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                        }

                        break;

                    case 3: // Report: #4
                        if (e.Row.Cells[3].Text == "Week Total" || e.Row.Cells[3].Text == "Month Total" || e.Row.Cells[3].Text == "Quarter Total")
                        {
                            e.Row.Cells[1].Text = "";
                            e.Row.Cells[5].Text = Convert.ToDouble(e.Row.Cells[5].Text).ToString("C2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
                            e.Row.Cells[6].Text = Convert.ToDouble(e.Row.Cells[6].Text).ToString("C2");
                            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Center;
                        }

                        else if (e.Row.Cells[3].Text == "Grand Total")
                        {
                            e.Row.Cells[5].Text = Convert.ToDouble(e.Row.Cells[5].Text).ToString("C2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
                            e.Row.Cells[6].Text = Convert.ToDouble(e.Row.Cells[6].Text).ToString("C2");
                            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Right;
                        }

                        else
                        {
                            e.Row.Cells[5].Text = Math.Round(Convert.ToDouble(e.Row.Cells[5].Text), 2).ToString("N2");
                            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Left;
                            e.Row.Cells[6].Text = Math.Round(Convert.ToDouble(e.Row.Cells[6].Text), 2).ToString("N2");
                            e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Left;
                        }

                        break;
                }
            }

            if (e.Row.RowType == DataControlRowType.Pager)
            {
                // DISPLAY TOOLTIP FOR PAGER-ROW
                e.Row.ToolTip = "Current Page: " + (grdReportDisplay.PageIndex + 1).ToString();
            }
        }

        protected void GrdReportDisplay_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            grdReportDisplay.PageIndex = e.NewPageIndex;
        }

        protected void BtnCollate_Click(object sender, EventArgs e)
        {
            String[] reportQuery = new String[11];
            String reportFrom;
            String reportTo;
            String queryString = "SELECT [Year]=year(AppointDate), ";
            DataTable reportTable = new DataTable();

            reportOneTotalAppts = 0;
            reportOneTotalFees = 0.00;

            switch (rblReportLayout.SelectedIndex)
            {
                case 0:
                    reportQuery[0] = "Week#=datepart(week, AppointDate), ";
                    reportQuery[8] = "datepart(week, AppointDate) ";
                    reportQuery[9] = "Week#";
                    reportQuery[10] = "Week";
                    break;
                case 1:
                    reportQuery[0] = "Month=datepart(month, AppointDate), ";
                    reportQuery[8] = "datepart(month, AppointDate) ";
                    reportQuery[9] = "Month";
                    reportQuery[10] = "Month";
                    break;
                case 2:
                    reportQuery[0] = "Quart#=datepart(quarter, AppointDate), ";
                    reportQuery[8] = "datepart(quarter, AppointDate) ";
                    reportQuery[9] = "Quart#";
                    reportQuery[10] = "Quarter";
                    break;
            }

            reportFrom = tbxReportDate1.Text;
            reportTo = tbxReportDate2.Text;

            if (reportFrom == "")
            {
                reportFrom = "2019-09-01";
            }

            if (reportTo == "")
            {
                reportTo = "2030-12-31";
            }

            switch (rblReportType.SelectedIndex)
            {
                case 0: // Report #1                    
                    grdReportDisplay.Width = 450;
                    reportQuery[1] = "COUNT(*) AS '#Appts', ";
                    reportQuery[2] = "SUM(AppointPrice) AS 'Revenue'";
                    reportQuery[3] = "FROM [DrDoolittleVet].[dbo].[Appointments] AS table1 ";
                    reportQuery[4] = "WHERE (table1.[AppointDate] >= '" + reportFrom + "' AND table1.[AppointDate] <= '" + reportTo + "') ";
                    reportQuery[5] = "GROUP BY rollup (year(AppointDate), " + reportQuery[8] + ") ";
                    reportQuery[6] = "HAVING (datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NOT NULL) ";
                    reportQuery[7] = "ORDER BY [Year], " + reportQuery[9];
                    break;

                case 1: // Report #2
                    grdReportDisplay.Width = 700;
                    reportQuery[1] = "COUNT (*) AS '#Appts', table2.[VetID] AS 'Vet#', CASE WHEN(year(table1.[AppointDate]) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[VetID] is NULL) THEN '" + reportQuery[10] + " Total'";
                    reportQuery[2] = "WHEN (table2.[VetID] is NULL AND table2.[LastName] is NULL) THEN 'Grand Total' ELSE(table2.[Title] + ' ' + table2.[FirstName] + ' ' + table2.[LastName]) END AS 'Vet', SUM(table1.[AppointPrice]) AS 'Total Fees'";
                    reportQuery[3] = "FROM [DrDoolittleVet].[dbo].[Appointments] AS table1, [DrDoolittleVet].[dbo].[Vets] AS table2 WHERE table1.[VetID] = table2.[VetID]";
                    reportQuery[4] = "AND (table1.[AppointDate] >= '" + reportFrom + "' AND table1.[AppointDate] <= '" + reportTo + "') ";
                    reportQuery[5] = "GROUP BY ROLLUP (year(AppointDate), " + reportQuery[8];
                    reportQuery[6] = ", table2.[VetID], table2.[Title], table2.[FirstName], table2.[LastName]) HAVING(datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[VetID] is NOT NULL AND table2.[LastName] is NOT NULL) OR(datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[VetID] is NULL AND table2.[LastName] is NULL) OR(datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NULL and table2.[VetID] is NULL and table2.[LastName] is NULL)";
                    reportQuery[7] = "ORDER BY (CASE WHEN table2.[LastName] is null THEN table2.[VetID] END)";
                    break;

                case 2: // Report #3
                    grdReportDisplay.Width = 700;
                    reportQuery[1] = "COUNT(*) AS '#Appts', table2.[OwnerID] AS 'Cust#', CASE WHEN(year(table1.[AppointDate]) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[OwnerID] is NULL) THEN '" + reportQuery[10] + " Total'";
                    reportQuery[2] = "WHEN (table2.[OwnerID] is NULL AND (table2.[FirstName] is NULL OR table2.[LastName] is NULL)) THEN 'Grand Total' ELSE(table2.[FirstName] + ' ' + table2.[LastName]) END AS 'Customer', SUM(table1.[AppointPrice]) AS 'Total Fees'";
                    reportQuery[3] = "FROM [DrDoolittleVet].[dbo].[Appointments] AS table1, [DrDoolittleVet].[dbo].[PetOwners] AS table2, [DrDoolittleVet].[dbo].[Pets] AS table3 WHERE table2.[OwnerID] = table3.[OwnerID] AND table1.[PetID] = table3.[PetID] ";
                    reportQuery[4] = "AND (table1.[AppointDate] >= '" + reportFrom + "' AND table1.[AppointDate] <= '" + reportTo + "') ";
                    reportQuery[5] = "GROUP BY ROLLUP (year(AppointDate), " + reportQuery[8];
                    reportQuery[6] = ", table2.[OwnerID], table2.[FirstName], table2.[LastName]) HAVING(datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[OwnerID] is NOT NULL AND table2.[LastName] is NOT NULL) OR(datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[OwnerID] is NULL AND table2.[LastName] is NULL) OR(datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NULL and table2.[OwnerID] is NULL and table2.[LastName] is NULL)";
                    reportQuery[7] = "ORDER BY (CASE WHEN (table2.[FirstName] is NULL OR table2.[LastName] is NULL) THEN table2.[OwnerID] END)";
                    break;

                case 3: // Report #4
                    grdReportDisplay.Width = 750;
                    reportQuery[1] = "table2.[DrugID] AS 'Drug#', CASE WHEN(year(table1.[AppointDate]) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[DrugID] is NULL) THEN '" + reportQuery[10] + " Total'";
                    reportQuery[2] = "WHEN (table2.[DrugID] is NULL AND table2.[DrugName] is NULL) THEN 'Grand Total' ELSE table2.[DrugName] END AS 'Drug Name', COUNT(*) AS 'Scripts', SUM(table2.[DrugSalePrice]) AS 'Sales', SUM(table2.[DrugCostPrice]) AS 'Cost' ";
                    reportQuery[3] = "FROM [DrDoolittleVet].[dbo].[Appointments] AS table1, [DrDoolittleVet].[dbo].[Medications] AS table2, [DrDoolittleVet].[dbo].[PrescribedMedications] AS table3 WHERE table1.[AppointID] = table3.[AppointmentID] AND table2.[DrugID] = table3.[DrugID]";
                    reportQuery[4] = "AND (table1.[AppointDate] >= '" + reportFrom + "' AND table1.[AppointDate] <= '" + reportTo + "') ";
                    reportQuery[5] = "GROUP BY ROLLUP (year(AppointDate), " + reportQuery[8];
                    reportQuery[6] = ", table2.[DrugID], table2.[DrugName]) HAVING (datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[DrugID] is NOT NULL AND table2.[DrugName] is NOT NULL) OR(datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NOT NULL AND table2.[DrugID] is NULL) OR(datepart(year, AppointDate) is NOT NULL AND " + reportQuery[8] + " is NULL and table2.[DrugID] is NULL)";
                    reportQuery[7] = "ORDER BY (CASE WHEN table2.[DrugName] is null THEN table2.[DrugID] END)";
                    break;
            }

            for (int counter = 0; counter < 8; counter++)
            {
                queryString += reportQuery[counter];
            }

            try
            {
                using (SqlConnection vetConnector = new SqlConnection(vetDatabaseConnector))
                {
                    vetConnector.Open();
                    SqlCommand reportCommand = new SqlCommand(queryString, vetConnector);
                    SqlDataReader reportReader = reportCommand.ExecuteReader(CommandBehavior.CloseConnection);
                    reportTable.Load(reportReader);
                }

                if (rblReportType.SelectedIndex == 0)
                {
                    // ADD TOTALS ROW FOR REPORT#1
                    reportTable.Rows.Add(0, 0, 0, 0.00);
                }

                if (rblReportType.SelectedIndex == 2)
                {
                    // REMOVE EMPTY ROWS FROM REPORT#3
                    for (int counter = reportTable.Rows.Count - 1; counter >= 0; counter--)
                    {
                        DataRow report3row = reportTable.Rows[counter];

                        if (report3row.ItemArray[4].ToString() == "")
                        {
                            report3row.Delete();
                        }
                    }

                    reportTable.AcceptChanges();
                }
            }

            catch (Exception error)
            {
                String errorMessage = "There was a problem collating Report details: " + error.Message;
                DisplayPopupMessage(errorMessage);
            }

            finally
            {
                grdReportDisplay.DataSource = reportTable;
                grdReportDisplay.DataBind();
                grdReportDisplay.PageIndex = 0;
                grdReportDisplay.BottomPagerRow.Visible = true;
            }
        }

        protected void TbxReportDate1_TextChanged(object sender, EventArgs e)
        {
            btnClearSearch.Visible = true;
        }

        protected void TbxReportDate2_TextChanged(object sender, EventArgs e)
        {
            btnClearSearch.Visible = true;
        }

        protected void BtnClearSearch(object sender, EventArgs e)
        {
            tbxReportDate1.Text = "";
            tbxReportDate2.Text = "";
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