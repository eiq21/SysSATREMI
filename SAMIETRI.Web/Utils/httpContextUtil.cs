using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;

namespace SAMIETRI.Web.Utils
{
    namespace httpContextUtil
    {

        public static class HttpContextHelper
        {

            public static int? GetInt(this HttpContext obj, string name)
            {
                int? result = null;
                try
                {
                    result = Int32.Parse(obj.Request[name]);
                }
                catch (FormatException ex) { }
                return result;
            }

            public static string GetString(this HttpContext obj, string name)
            {
                return obj.Request[name];
            }

            public static DateTime? GetDateTime(this HttpContext obj, string name)
            {
                DateTime? result = null;
                string text = obj.Request[name];
                try
                {
                    result = parseDateFromClient(text);
                }
                catch (FormatException ex) { }
                return result;
            }

            public static DateTime? parseDateFromClient(string strdate)
            {
                DateTime? resultdate = null;
                if (!String.IsNullOrWhiteSpace(strdate))
                {
                    resultdate = DateTime.ParseExact(strdate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
                }
                return resultdate;
            }
        }
    }
}