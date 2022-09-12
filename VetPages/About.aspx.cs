using System;
using System.Web.UI;

namespace DrDoolittleVetClinic
{
    public partial class About : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadTextBlocks();
        }

        protected void LoadTextBlocks()
        {
            tbxOverview.Text = "This application handles the on-line bookings, job allocations and medication stock control for DrDoolittle’s Veterinary Clinic. Customer, Pet, Vet & Medication records can be added and modified. Appointments can be booked, modified and, if uncompleted, cancelled as required.";

            tbxAdminPages.Text = "On the Appointments page, the veterinary administrator will see all appointments. Bookings for the current date are listed first, in time order, followed by all others ordered by booking date, and then by booking time. Appointments that have been completed will show " +
                                 "as COMPLETED in the Appointment Comment column. Selecting the View button for any such appointment will display a textbox detailing treatment notes entered by the assigned staff vet. The fee for these bookings will show a non-zero amount. Select the EDIT button to modify " +
                                 "the Appointment fee. Uncompleted appointment bookings will display the reason for treatment, as entered at time of booking, and will have Edit and Cancel buttons enabled.\n(NOTE: Because this application uses the Appointment Fee to determine the completed status, Appointment " +
                                 "Fee cannot be set lower than $0.01).\n\nEditing a booking allows the administrator to update an appointment, such as changing the reason for the booking, or re-assigning the treating vet. A calendar pop-up is used to enter the booking date for an appointment, and drop-down " +
                                 "lists allow selection of pets and vets, with the vet drop-down list only allowing vets that are rostered for the appointment date to be selected and allocated.\n(NOTE: Where the time and/or date of an appointment is modified, it may be necessary to change the selected vet. " +
                                 "If the vet column now reads '{Assign Vet}', this will be necessary.) \n\nCancelling an appointment will display a pop-up to ensure the selected booking deletion is to proceed. A new booking can be made by entering the required information into textboxes and drop-down lists " +
                                 "located in the footer row. Pressing the Book button will create a new appointment.\n\nOn the Customers page, the administrator can view all details of customers in the Pet-Owners database table. A drop-down list in the Pets column will display all pets owned by the currently " +
                                 "high-lighted customer (where only a single pet is owned, that pet name will be displayed). Pressing the Edit button on a selected row allows the user to modify the details of a pet-owner. New customers can be added to the database by entering the required information into " +
                                 "textboxes in the footer row and pressing the Add button.\n(NOTE: Newly created customers will display (None) in the Pets column until they are assigned a Pet)\n\nThe Pets page allows the administrator to view details of all pets in the Pets database table, and shows a Select " + 
                                 "button on each row that will display a textbox detailing the Medical History for the currently high-lighted pet.\nPressing the Edit button on a selected row lets the administrator modify the details of the current pet, including setting the pet’s owner and gender from drop-" +
                                 "down lists.\nNew pets can be added to the database by entering the required details into textboxes and drop-down lists in the footer row, and pressing the Add button.\n(NOTE: The new pet's owner must exist in the Customers database first, as this is a required field)\n\nThe " +
                                 "Medications page operates much the same as for the Customers and Pets tables above. The administrator can modify details by pressing the Edit button on a selected row, entering the required details, and pressing the Update button. New medications can be added to the database " +
                                 "by completing the textboxes in the footer row, and pressing the Add button.\n\nOn the Vets page, the administrator user can view, edit and create staff vet records in the same manner as the tables above. Pressing the Roster button for a selected vet takes the user to another " +
                                 "page. This page displays details of the selected vet, and a list of seven checkboxes, which can be ticked to indicate that this vet is available for work allocations on that day of the week. This information is used to create the list of available vets when modifying or " +
                                 "creating appointment bookings.\nPressing the Update Roster button saves the selected days in the VetRoster database table, and changes the colour of the Exit button to green. Pressing this button returns the user to the Vets page.\n(NOTE: Pressing Exit before pressing the " +
                                 "Update Roster button will leave the roster unchanged).\n\nThe Reports page allows the veterinary administrator to collate and view various reports. The user can enter start and finish dates to generate reports which can be displayed based on a weekly, monthly or quarterly " +
                                 "break-down selection. If no start date is entered, the chosen report will show records from the beginning of all records. Likewise, if no finish date is entered, the report will display all records to the end of the database.";

            tbxStaffPages.Text = "On the Appointments page, staff vets will see all appointments. Bookings for the current session Vet are listed first, high-lighted in green, first in date and then time order, with all other Bookings listed next, again ordered by booking date and then by booking time. The " +
                                 "vet can view information on all appointments by selecting the Details button. Upcoming appointments will show the complaint that requires treatment; completed appointments will include diagnostic notes made by the assigned vet, as well as the type of consultation and any " +
                                 "medications prescribed.\n\nAny appointments for the current date that have been assigned to the session vet for the current date will enable the Treat Pet button. Selecting this button takes the user to another page, which displays the details of this appointment, as well as " +
                                 "the patient pet’s Medical History record. Here the assigned vet enters diagnostic notes into the textbox below the medical history; they select the consultation type from a drop-down on the left, and can optionally add a procedure from the list of radio-buttons below the " +
                                 "drop-down menu. Any medications that are required to treat the patient can be prescribed from the table on the right.\n\nOnce all information has been entered and selected, the assigned vet presses the Update Medical History button to update the record. This action will " +
                                 "also update the PrescribedMedications database table, as well as deduct one unit of each prescribed medication from the stock levels in the Medications database. The fee for this appointment is then calculated, based upon selected consultation type and optional procedure " +
                                 "performed, as well as the sale price of any medications that were prescribed. The Appointment database table is updated with the fee for the consultation, and any treatment notes. The Exit button, now highlighted in green, will take the vet user back to the Appointments " +
                                 "page.\n(NOTE: Selecting this button before pressing the Update Medical History button will cancel the treatment and leave the current appointment untreated.)\n\nOn the Customers page, staff vets can view details of all DrDoolittle’s customers. Pressing the Select button " +
                                 "on any row in the table will display a detailed view with additional information including a list of all pets owned by the selected customer.\n\nThe Pets page operates mostly the same as for Customers. Staff vets can Select a pet to view additional information, including " +
                                 "the name of their owner, as well as the complete Medical History.\n\nThe Medications page displays a similar table as for Customers and Pets. Pressing the Select button on a highlighted row in this table will display a textbox, which includes the sale price for the " +
                                 "selected medication.";

            tbxCommonControls.Text = "All users log-in to the application using their e-mail address and password. Once verified, the user is taken to the appropriate Appointments table. On every table, the currently selected row is always high-lighted in light blue. Buttons can be used to access any " +
                                     "currently applicable commands. Tool tips have been included to indicate any available functions. Field validators throughout will high-light any data-entry errors. Pagination is done using the pager row at the bottom of all tables. The tool-tip will display the current page " +
                                     "number. All tables can be sorted by data column (although not every column has sort capability).\n\nThe search facility on each page is used to select records beginning with an entered name string or, in the case of the Appointments tables, a second search facility operates " +
                                     "on entered start and finish dates. On Staff pages, pressing the Search button initiates this action, whereas Admin pages only require the user to click outside the Search textboxes.";

            tbxCredits.Text = "Many thanks to Brett Mitchell, Steve Price (Perth Open Source Hackers) and Vinnie Willats for their assistance on the many technical issues I encountered on this project. Thanks also to Venkat of Pragim Technologies (https://www.pragimtech.com) for the excellent series of " +
                              "videos specific to SQL, C# and ASP.Net programming techniques. Also, www.stackoverflow.com for assistance on syntax in many cases.";
        }
    }
}