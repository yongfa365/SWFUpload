using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;

namespace SWFUploadDemo
{
    public class UploadHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            HttpPostedFile postFile = context.Request.Files["Filedata"];
            postFile.SaveAs(string.Format("{0}/{1}.{2}", context.Server.MapPath("~"), DateTime.Now.Ticks, postFile.FileName));
            context.Response.Write("Upload Success!");
            context.Response.End();
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