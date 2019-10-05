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
    public class VehMakeController : ApiController
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        [HttpGet]
        public IEnumerable<VehMakeMaster> GetAllVehMakes(string companyid, string VehSegId)
        {
            List<VehMakeMaster> VehMakeInfo = new List<VehMakeMaster>();
            try
            {
                DataTable dtrecords = ObjDBAccess1.GetAllActiveVehMakes(companyid, VehSegId);
                if (dtrecords != null && dtrecords.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtrecords.Rows)
                    {
                        VehMakeInfo.Add(new VehMakeMaster { VehMake = dr["vehmake"].ToString(), VehMakeId = dr["vehmakeid"].ToString() });
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
            return VehMakeInfo;
        }
    }
}
