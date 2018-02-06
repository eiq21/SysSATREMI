using SAMETRI.Data;
using SAMIETRI.Web.Utils.httpContextUtil;
using SATREMI.Model;
using SATREMI.Win.Utils;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.SessionState;

namespace SAMIETRI.Web.Service

{
    /// <summary>
    /// Descripción breve de reporte
    /// </summary>
    public class reporte : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            DataTable dt = null;
            ExcelBuilder exbuilder;
            string rutaPlantilla = "";

            try
            {
                string tipoReporte = context.GetString("rpt") == "null" ? null : context.GetString("rpt");

                byte[] buffer = null;
                FilterReport filter = new FilterReport();
                DateTime start;
                DateTime end;

                string subtitulo = string.Empty;

               
                var days = new List<int>();

                switch (tipoReporte)
                {
                    case "reporte_por_area":
                        filter.Id = context.GetString("Id") == "-1" ? null : context.GetString("Id");
                        filter.strNumberDocument = context.GetString("strNumberDocument") == "null" ? null : context.GetString("strNumberDocument");
                        filter.startDate = context.GetString("startDate") == "null" ? null : context.GetString("startDate");
                        filter.endDate = context.GetString("endDate") == "null" ? null : context.GetString("endDate");



                        dt = new ReportDAO().GetAllServiceItems(filter);
                        start = Convert.ToDateTime(filter.startDate);
                        end = Convert.ToDateTime(filter.endDate);

                        start = Convert.ToDateTime(filter.startDate);
                        end = Convert.ToDateTime(filter.endDate);

                        for (var d = start; d <= end; d = d.AddDays(1))
                        {
                            days.Add(d.Day);
                        };

                        rutaPlantilla = context.Server.MapPath(
                                        @"~/TemplateReport/plantilla_reporte_dinamico.xlsx");
                        exbuilder = new ExcelBuilder();
                        exbuilder.Plantilla = rutaPlantilla;
                        exbuilder.SetHojaContenido("Reporte", 7, 2);

                        subtitulo = string.Format("Del {0} de {1}  al {2} de {3}  del {4}", start.Day, start.ToString("MMMM"), end.Day, end.ToString("MMMM"), end.Year);

                        exbuilder.SetSubTitulo(subtitulo, 2, 35);

                        var datosAdicionales1 = Days(days);
                        exbuilder.SetDatosAdicionales(datosAdicionales1, 5, 4);
                        if (filter.Id != null)
                        {
                            var title = new ReportDAO().GetNameAreaById(Convert.ToInt32(filter.Id));
                            exbuilder.SetTitulo(title, 2, 20);
                        }
                        else
                        {
                            exbuilder.SetTitulo("Todas las Áreas", 2, 20);
                        }

                        buffer = exbuilder.Crear(dt);
                        break;

                    case "reporte_resumen":
                        filter.Id = null;
                        filter.strNumberDocument = null;
                        filter.startDate = context.GetString("startDate") == "null" ? null : context.GetString("startDate");
                        filter.endDate = context.GetString("endDate") == "null" ? null : context.GetString("endDate");

                        dt = new ReportDAO().GetAllServiceItemsSummary(filter);

                        start = Convert.ToDateTime(filter.startDate);
                        end = Convert.ToDateTime(filter.endDate);

                        for (var d = start; d <= end; d = d.AddDays(1))
                        {
                            days.Add(d.Day);
                        };

                        rutaPlantilla = context.Server.MapPath(
                                        @"~/TemplateReport/plantilla_reporte_resumen.xlsx");
                        exbuilder = new ExcelBuilder();
                        exbuilder.Plantilla = rutaPlantilla;
                        exbuilder.SetHojaContenido("Resumen", 7, 2);

                        subtitulo = string.Format("Del {0} de {1}  al {2} de {3}  del {4}", start.Day, start.ToString("MMMM"), end.Day, end.ToString("MMMM"), end.Year);

                        exbuilder.SetSubTitulo(subtitulo, 2, 34);

                        var datosAdicionales2 = Days(days);
                        exbuilder.SetDatosAdicionales(datosAdicionales2, 5, 3);
                        buffer = exbuilder.Crear(dt);
                        break;


                }

                if (buffer == null)
                {
                    context.Response.ContentType = "text/plain";
                    context.Response.Write("No se ha implementado el reporte solicitado");
                }
                else
                {
                    string filename = ObtenerNombreArchivo(tipoReporte);
                    context.Response.ContentType = "application/octet-stream";
                    context.Response.AddHeader("content-disposition", "attachment; filename=\"" + filename + "\"");
                    context.Response.BinaryWrite(buffer);
                    context.Response.Flush();
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
                case "reporte_resumen":
                    name = "reporte_resumen";
                    break;

            }
            return name + ".xlsx";
        }

        public object[][] Days(List<int> lstDays)
        {
            var cantidad = lstDays.Count();
            int i = 0;
            List<string> lst = new List<string>();
            foreach (var d in lstDays)
            {
                lst.Add(d.ToString());
                lst.Add("");
                lst.Add("");
                i++;

            }

            lst.Add("TOTAL");
            object[][] datos = new object[][] {
             lst.ToArray()
          };

            return datos;
        }

        public object[][] DatosAdicionales(string valor)
        {
            object[][] datos = new object[][] { 
                //fila 1
                new object[]{ null}

            };
            return datos;
        }



        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}