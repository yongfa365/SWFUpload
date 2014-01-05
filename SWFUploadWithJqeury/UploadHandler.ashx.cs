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
            var filename = DateTime.Now.Ticks + postFile.FileName;
            postFile.SaveAs(string.Format("{0}/{1}", context.Server.MapPath("~"), filename));
            context.Response.Write(filename);
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