using SAMETRI.Data;
using SATREMI.Model;
using SATREMI.Win.Utilitario;
using System;
using System.Data;
using System.IO;
using System.Windows.Forms;

namespace SATREMI.Win
{
    public partial class frmPrincipal : Form
    {
        public frmPrincipal()
        {
            InitializeComponent();

        }

        private void btnGenerar_Click(object sender, EventArgs e)
        {
            int id = cmdArea.SelectedIndex + 1;
            string dni = txtDNI.Text;
            DateTime start = Convert.ToDateTime(txtDesde.Text);
            DateTime end = Convert.ToDateTime(txtHasta.Text);

            DataTable dt = null;


            ExcelBuilder exbuilder;
            string rutaPlantilla = "";

            try
            {
                string tipoReporte = "reporte_por_area";

                byte[] buffer = null;

                switch (tipoReporte)
                {
                    case "reporte_por_area":
                        FilterReport filter = new FilterReport();

                        filter.Id = id;
                        filter.strNumberDocument = dni;
                        filter.startDate = start;
                        filter.endDate = end;

                        dt = new ReportDAO().GetAllServiceItems(filter);


                        string RutaApp = Application.StartupPath;
                        string RutaPlantilla = @"\PlantillaReporte\plantilla_reporte_dinamico.xls";

                        rutaPlantilla = Path.Combine(RutaApp, RutaPlantilla);

                        exbuilder = new ExcelBuilder();
                        exbuilder.Plantilla = rutaPlantilla;
                        exbuilder.SetHojaContenido("ENDOSO", 9, 1);
                        exbuilder.SetDatosAdicionales(datosAdicionalesEndoso, 5, 4);
                        exbuilder.SetTitulo("REPORTE DE ENDODOS DE POLIZA", 2, 3);
                        buffer = exbuilder.Crear(dt);
                        break;


                }

                if (buffer == null)
                {
                    Response.ContentType = "text/plain";
                    Response.Write("No se ha implementado el reporte solicitado");
                }
                else
                {
                    string filename = ObtenerNombreArchivo(tipoReporte);
                    Response.ContentType = "application/octet-stream";
                    Response.AddHeader("content-disposition", "attachment; filename=\"" + filename + "\"");
                    Response.BinaryWrite(buffer);
                    Response.Flush();
                }
            }
            catch (Exception ex)
            {
                //Logging.LogException(ex);
                context.Response.ContentType = "text/plain";
                context.Response.Write("No fue posible generar el archivo");
            }



        }

        public string ObtenerNombreArchivo(string tipoReporte)
        {
            string name = "desconocido";
            switch (tipoReporte)
            {
                case "reporte_por_area":
                    name = "reporte_por_area";
                    break;

            }
            return name + ".xls";
        }
        private void frmPrincipal_Load(object sender, EventArgs e)
        {

            ReportDAO rptDAO = new ReportDAO();
            cmdArea.DataSource = rptDAO.GellAllArea();
            cmdArea.DisplayMember = "Name";
            cmdArea.ValueMember = "Id";
        }


    }

}
