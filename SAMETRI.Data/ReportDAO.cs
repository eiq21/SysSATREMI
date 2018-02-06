using SATREMI.Model;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace SAMETRI.Data
{
    public class ReportDAO
    {
        string strConn = ConfigurationManager.ConnectionStrings["CnxSQL"].ToString();

        public DataTable GetAllServiceItems(FilterReport filter)
        {
            DataTable dt = new DataTable();

            try
            {
                SqlConnection cnn = new SqlConnection(strConn);
                SqlCommand cmd = new SqlCommand("sp_report_dinamic_by_area", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                filter.strNumberDocument = string.IsNullOrEmpty(filter.strNumberDocument) ? null : filter.strNumberDocument;
                filter.Id = string.IsNullOrEmpty(filter.Id) ? null : filter.Id;

                cmd.Parameters.Add("@AreaId", SqlDbType.NVarChar, 10).Value = filter.Id;
                cmd.Parameters.Add("@Dni", SqlDbType.NVarChar, 11).Value = filter.strNumberDocument;
                cmd.Parameters.Add("@startDate", SqlDbType.DateTime).Value = filter.startDate;
                cmd.Parameters.Add("@endDate", SqlDbType.DateTime).Value = filter.endDate;



                cnn.Open();
                dt.Load(cmd.ExecuteReader());
                cnn.Close();


            }
            catch (Exception ex)
            {

                throw ex;
            }

            return dt;
        }


        public DataTable GetAllServiceItemsSummary(FilterReport filter)
        {
            DataTable dt = new DataTable();

            try
            {
                SqlConnection cnn = new SqlConnection(strConn);
                SqlCommand cmd = new SqlCommand("sp_report_dinamic_summary", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                filter.strNumberDocument = string.IsNullOrEmpty(filter.strNumberDocument) ? null : filter.strNumberDocument;
                filter.Id = string.IsNullOrEmpty(filter.Id) ? null : filter.Id;
                cmd.Parameters.Add("@startDate", SqlDbType.DateTime).Value = filter.startDate;
                cmd.Parameters.Add("@endDate", SqlDbType.DateTime).Value = filter.endDate;



                cnn.Open();
                dt.Load(cmd.ExecuteReader());
                cnn.Close();


            }
            catch (Exception ex)
            {

                throw ex;
            }

            return dt;
        }

        public DataTable GellAllArea()
        {
            DataTable dt = new DataTable();

            try
            {
                SqlConnection cnn = new SqlConnection(strConn);
                SqlCommand cmd = new SqlCommand("sp_get_all_area", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;
                cnn.Open();

                dt.Load(cmd.ExecuteReader());


                //SqlDataAdapter da = new SqlDataAdapter(cmd);
                //da.Fill(dt);

                cnn.Close();

            }
            catch (Exception)
            {

                throw;
            }
            return dt;
        }


        public string GetNameAreaById(int id)
        {
            string Name = null;

            try
            {
                SqlConnection cnn = new SqlConnection(strConn);
                SqlCommand cmd = new SqlCommand("sp_get_name_area_by_id", cnn);
                cmd.CommandType = System.Data.CommandType.StoredProcedure;

                cmd.Parameters.Add("@Id", SqlDbType.Int).Value = id;
                cnn.Open();

                Name = Convert.ToString(cmd.ExecuteScalar());

                cnn.Close();

            }
            catch (Exception)
            {

                throw;
            }
            return Name;
        }


    }
}
