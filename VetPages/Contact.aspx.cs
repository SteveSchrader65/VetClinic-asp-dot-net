using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DrDoolittleVetClinic
{
    public partial class Contact : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadDetailsTextBox();
        }

        protected void LoadDetailsTextBox()
        {
            String txtDetails = "Name     : Steve Schrader\n" +
                                "Student# : J294862\n" +
                                "Project  : Dr Doolittle Vet Clinic\n" +
                                "Start    : Wed 20th May, 2020\n" +
                                "Finish   : Wed 30th September, 2020\n" +
                                "E-mail   : steve36lives@hotmail.com";

            tbxDetails.Text = txtDetails;
        }
    }
}