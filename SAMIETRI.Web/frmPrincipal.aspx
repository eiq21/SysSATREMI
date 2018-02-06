<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="frmPrincipal.aspx.cs" Inherits="SAMIETRI.Web.frmPrincipal" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <script src="Scripts/jquery-1.9.1.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <link href="Content/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <script src="js/Reporte/Reporte.js"></script>
    <link rel="shortcut icon" href="~/images/iconreport.ico"/>
    <title>Generador de Reporte</title>

    <script>

        $(document).ready(function () {
            Reporte.Config();
            Reporte.setEvent();


        });
    </script>

</head>
<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="">
                    <div class="">
                        <h3 class="text-center">Generador de Reporte</h3>

                    </div>
                    <div class="panel-body">
                        <div id="divAlert" class="alert alert-danger fade in" style="display: none">
                            <%-- <div id="divAlert" class="alert alert-danger">--%>
                        </div>
                        <fieldset>
                            <div class="form-group">
                                <label class="radio-inline">
                                    <input type="radio" name="TipoReporte" id="rboArea" checked="checked" value="1" />
                                    <label for="reporteArea" class="control-label">Reporte por Área</label>

                                </label>
                                <label class="radio-inline">
                                    <input type="radio" name="TipoReporte" id="rboResumen" value="2" />
                                    <label for="ReporteResumen" class="control-label">Reporte Resumen</label>
                                </label>

                            </div>
                            <div class="form-group">
                                <label for="area" class="control-label">Area:</label>
                                <select id="cmbArea" class="form-control input-sm">
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="dni" class="control-label">DNI:</label>
                                <input id="txtDNI" class="form-control input-sm" name="dni" type="text" />
                            </div>
                            <div class="form-group">
                                <label for="desde" class="control-label">Desde:</label>
                                <input id="txtDesde" class="form-control input-sm" name="desde" type="date" />
                            </div>

                            <div class="form-group">
                                <label for="hasta" class="control-label">Hasta</label>
                                <input id="txtHasta" class="form-control input-sm" name="hasta" type="date" />
                            </div>

                            <input id="btnGenerar" class="btn btn-lg btn-primary btn-block" value="Generar" type="submit" />
                        </fieldset>
                    </div>
            </div>
        </div>
    </div>
    </div>


</body>
</html>
