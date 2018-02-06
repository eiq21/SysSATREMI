using SAMETRI.Data;
using SATREMI.Model;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SAMIETRI.Web
{
    public partial class frmPrincipal : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

            }

        }

        protected void btnGenerar_Click(object sender, EventArgs e)
        {

        }
        [WebMethod]
        public static IList LoadComboArea()
        {
            try
            {

                DataTable dt = new DataTable();
                dt = new ReportDAO().GellAllArea();
                IList lista = dt.AsEnumerable()
                    .Select(row => new
                    {
                        Id = row["Id"],
                        Name = row["Name"]
                    })
                    .ToList();
                return lista;
            }
            catch (Exception ex)
            {

                throw ex;
            }

        }

    }
}