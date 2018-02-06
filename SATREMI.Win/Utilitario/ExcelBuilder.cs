using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.IO;

namespace SATREMI.Win.Utilitario
{
    class ExcelBuilder
    {
        public string Plantilla { get; set; }
        public string Titulo { get; set; }

       
        public string[] Cabeceras { get; set; }
        public string HojaContenido { get; set; }
        public object[][] DatosAdicionales { get; set; }

        private Posicion PosicionContenido;
        private Posicion PosicionDatosAdicionales;

       

        public int[] ColumnasOcultas { get; set; }
        private Posicion PosicionTitulo;
        private List<Contenido> Contenidos { get; set; }
        private string HojaTitulo { get; set; }

        public ExcelBuilder()
        {
            Plantilla = null;
            Titulo = null;

           
            Cabeceras = null;
            HojaContenido = null;
            PosicionContenido = null;
            PosicionDatosAdicionales = null;
           

            PosicionTitulo = null;
            ColumnasOcultas = null;
            Contenidos = new List<Contenido>();
            HojaTitulo = null;
        }

        public void agregarContenido(DataTable datos, string hoja, int x, int y)
        {
            Contenidos.Add(new Contenido()
            {
                Datos = datos,
                HojaExcel = hoja,
                X = x,
                Y = y
            });
        }

        public void agregarContenido(object[][] datos, string hoja, int x, int y, string sColor = "")
        {
            Contenidos.Add(new Contenido()
            {
                Datos = datos,
                HojaExcel = hoja,
                X = x,
                Y = y,
                Color = sColor//PROY-ABSA-2015-001 JZAMUDIO   
            });
        }

        public void SetTitulo(string hojatitulo, string titulo, int x, int y)
        {
            this.HojaTitulo = hojatitulo;
            this.Titulo = titulo;
            this.PosicionTitulo = new Posicion() { X = x, Y = y };
        }


        //INI PROY-AB-2015-001 CUS_PARTICULAR EINCA 18022016
        public void SetDatosAdicionales(object[][] datos, int x, int y)
        {
            this.DatosAdicionales = datos;
            this.PosicionDatosAdicionales = new Posicion() { X = x, Y = y };
        }

        public void SetTitulo(string titulo, int x, int y)
        {
            this.Titulo = titulo;
            this.PosicionTitulo = new Posicion() { X = x, Y = y };
        }

        public void SetHojaContenido(string hoja, int x, int y)
        {
            this.HojaContenido = hoja;
            this.PosicionContenido = new Posicion() { X = x, Y = y };
        }

        public byte[] Crear(DataTable dt)
        {
            byte[] buffer = null;
            ExcelPackage pck = null;
            ExcelWorksheet sheet = null;

            try
            {
                if (String.IsNullOrEmpty(this.Plantilla))
                {
                    pck = new ExcelPackage();
                    sheet = pck.Workbook.Worksheets.Add("datos");
                }
                else
                {
                    FileInfo template = new FileInfo(this.Plantilla);
                    pck = new ExcelPackage(template, true);
                }

                if (!string.IsNullOrEmpty(this.HojaContenido))
                {
                    sheet = pck.Workbook.Worksheets[this.HojaContenido];
                }

                if (!String.IsNullOrEmpty(this.Titulo))
                {
                    sheet.Cells[PosicionTitulo.X, PosicionTitulo.Y].Value = this.Titulo;
                }

                //TODO: falta implementar la funcionalidad de la cabecera

                int row = PosicionContenido == null ? 1 : PosicionContenido.X;
                int col = PosicionContenido == null ? 1 : PosicionContenido.Y;
                sheet.Cells[row, col].LoadFromDataTable(dt, false);

                if (DatosAdicionales != null)
                {
                    sheet.Cells[PosicionDatosAdicionales.X, PosicionDatosAdicionales.Y]
                            .LoadFromArrays(DatosAdicionales);
                }

                if (ColumnasOcultas != null)
                {
                    foreach (int indexCol in ColumnasOcultas)
                    {
                        sheet.Column(indexCol).Hidden = true;
                    }
                }

                buffer = pck.GetAsByteArray();
            }
            finally
            {
                if (pck != null) { pck.Dispose(); }
            }
            return buffer;
        }

      

        public byte[] Crear()
        {

            byte[] buffer = null;
            ExcelPackage pck = null;
            ExcelWorksheet sheet = null;

            try
            {
                if (String.IsNullOrEmpty(this.Plantilla))
                {
                    pck = new ExcelPackage();

                }
                else
                {
                    FileInfo template = new FileInfo(this.Plantilla);
                    template.IsReadOnly = false;
                    pck = new ExcelPackage(template, true);
                }

                if (!(String.IsNullOrEmpty(this.HojaTitulo)))
                {
                    if (String.IsNullOrEmpty(this.Plantilla))
                    {
                        sheet = pck.Workbook.Worksheets.Add(this.HojaTitulo);
                    }
                    else
                    {
                        sheet = pck.Workbook.Worksheets[this.HojaTitulo];
                    }

                    sheet.Cells[this.PosicionTitulo.X, this.PosicionTitulo.Y].Value = this.Titulo;
                }


                if (!String.IsNullOrEmpty(this.Titulo))
                {
                    sheet.Cells[PosicionTitulo.X, PosicionTitulo.Y].Value = this.Titulo;
                }


                foreach (Contenido contenido in this.Contenidos)
                {
                    if (String.IsNullOrEmpty(this.Plantilla))
                    {
                        sheet = pck.Workbook.Worksheets.Add(contenido.HojaExcel);
                    }
                    else
                    {
                        sheet = pck.Workbook.Worksheets[contenido.HojaExcel];
                    }


                    int row = contenido.X;
                    int col = contenido.Y;

                    if (contenido.Datos is DataTable)
                    {
                        var aux = (DataTable)contenido.Datos;
                        sheet.Cells[row, col].LoadFromDataTable(aux, false);
                    }
                    else if (contenido.Datos is Array)
                    {
                        var aux = (object[][])contenido.Datos;
                        sheet.Cells[row, col].LoadFromArrays(aux);

                     
                        if (contenido.Color.Trim().Length > 0)
                        {

                            Color colFromHex = System.Drawing.ColorTranslator.FromHtml(contenido.Color.Trim());
                            sheet.Cells[row + 1, col].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            sheet.Cells[row + 1, col].Style.Fill.BackgroundColor.SetColor(colFromHex);
                        }
                     
                    }


                    if (ColumnasOcultas != null)
                    {
                        foreach (int indexCol in ColumnasOcultas)
                        {
                            sheet.Column(indexCol).Hidden = true;
                        }
                    }
                }

                buffer = pck.GetAsByteArray();
            }
            finally
            {
                if (sheet != null) { sheet.Dispose(); }
                if (pck != null) { pck.Dispose(); }

            }
            return buffer;
        }




        public class Posicion
        {
            public int X { get; set; }
            public int Y { get; set; }
        }

        private class Contenido
        {
            public object Datos { get; set; }
            public String HojaExcel { get; set; }
            public int X { get; set; }
            public int Y { get; set; }
            public string Color { get; set; }
        }
    }
}
