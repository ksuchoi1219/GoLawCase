using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SQLCLASS;

namespace Directory
{
    public partial class Directory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            SQLConnClass loadData = new SQLConnClass();
            loadData.retrieveData("select * from directory;");

            if(loadData.SQLTable.Rows.Count > 0)
            {
                //lb_id.Text = loadData.SQLTable.Rows[0][0].ToString() + " " + loadData.SQLTable.Rows[0][1].ToString();
                 
                id_table.DataSource = loadData.SQLTable;
                id_table.DataBind();
            }
        }

        protected void btn_save_Click(object sender, EventArgs e)
        {


        }
    }
}