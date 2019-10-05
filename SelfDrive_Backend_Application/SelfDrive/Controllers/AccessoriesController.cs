using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Data;
using SelfDrive.Masters;

namespace SelfDrive.Controllers
{
    public class AccessoriesController : ApiController
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        [HttpGet]
        public IEnumerable<AccessoriesInfo> GetAllAccessories(string companyid, string VehSegId)
        {
            List<AccessoriesInfo> AccsInfo = new List<AccessoriesInfo>();
            try
            {
                DataTable dtrecords = ObjDBAccess1.GetAllAccessories(companyid, VehSegId);
                if (dtrecords != null && dtrecords.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtrecords.Rows)
                    {
                        AccsInfo.Add(new AccessoriesInfo { Accsid = dr["accsid"].ToString(), AccsName = dr["accsName"].ToString(), AccsDescription = dr["accsdescription"].ToString() });
                    }
                }
                else
                {
                    var error = new HttpError("No Details found") { { "status", -1 }, { "substatus", 3 } };
                    throw new HttpResponseException(Request.CreateErrorResponse(HttpStatusCode.NotFound, error));
                }
            }
            catch (Exception ex)
            {
                AppLog.Error(ex);
            }
            return AccsInfo;
        }
    }
}
