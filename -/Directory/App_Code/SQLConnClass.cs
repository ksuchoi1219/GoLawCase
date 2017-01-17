using System;
using System.Collections.Generic;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;


namespace SQLCLASS
{
    public class SQLConnClass
    {
        SqlConnection SQLConn = new SqlConnection();
        public DataTable SQLTable = new DataTable();
        
        public SQLConnClass()
        {
            SQLConn.ConnectionString = ConfigurationManager.ConnectionStrings["myConnString"].ConnectionString;
        }

        public void retrieveData(string command)
        {
            try
            {
                SQLConn.Open();
                SqlDataAdapter da = new SqlDataAdapter(command, SQLConn);
                da.Fill(SQLTable);
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("<script>alert('Something is wrong in connection: '" + ex.Message + "');</script>");
            }
            finally
            {
                SQLConn.Close();
            }
        }

        public void commandExec(string command)
        {
            try
            {
                SQLConn.Open();
                SqlCommand sqlcomm = new SqlCommand(command, SQLConn);

                int rowInfected = sqlcomm.ExecuteNonQuery();
                if (rowInfected > 0)
                {
                    HttpContext.Current.Response.Write("<script>alert('Your command is done');</script>");
                }
                else
                {
                    HttpContext.Current.Response.Write("<script>alert('Something went wrong in command.');</script>");
                }
            }
            catch (Exception ex)
            {
                HttpContext.Current.Response.Write("<script>alert('Something is wrong in connection: '" + ex.Message + "');</script>");

            }
            finally
            {
                SQLConn.Close();
            }
        }
    }
}
/// <summary>
/// Summary description for SQLConnClass
/// </summary>
