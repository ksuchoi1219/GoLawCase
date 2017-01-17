using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SQLCLASS;

namespace Directory
{
    public partial class Directory : System.Web.UI.Page
    {
        public string lat;
        public string lng;
        protected void Page_Load(object sender, EventArgs e)
        {

            string uCat = Request.Form["category"];
            SQLConnClass loadData = new SQLConnClass();
            SQLConnClass loadData1 = new SQLConnClass();
            loadData.retrieveData("select directory.name, directory.company, directory.phone, directory.email, directory.address, directory.website, directory.contact from directory inner join category on directory.ID = category.ID where category.category = '" + uCat + "';");
            loadData1.retrieveData("select directory.lat, directory.lng from directory inner join category on directory.ID = category.ID where category.category = '" + uCat + "';");
            if (loadData.SQLTable.Rows.Count > 0)
            {
                position.DataSource = loadData1.SQLTable;
                position.DataBind();
                directory_table.DataSource = loadData.SQLTable;
                directory_table.DataBind();
            }
        }

    }
}