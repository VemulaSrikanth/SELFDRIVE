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
    public class PackageController : ApiController
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        [HttpGet]
        public IEnumerable<PackageInfo> GetAllPackages(string companyid,string SerLocid, string VehSegId)
        {
            List<PackageInfo> PInfo = new List<PackageInfo>();
            try
            {
                DataTable dtrecords = ObjDBAccess1.GetAllActivePackages(companyid, SerLocid,VehSegId);
                if (dtrecords != null && dtrecords.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtrecords.Rows)
                    {
                        PInfo.Add(new PackageInfo { Tariffid = dr["tariffid"].ToString(), PackageName = dr["packagename"].ToString(), allowedKms = dr["allowedKms"].ToString(), allowedHrs = dr["allowedHrs"].ToString(), basicrate = dr["basicrate"].ToString(), SecurityDeposit = dr["securitydeposit"].ToString() });
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
            return PInfo;
        }
    }
}
