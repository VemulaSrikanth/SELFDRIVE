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
    public class MastersController : ApiController
    {
        DbAccess ObjDBAccess1 = new DbAccess();
        [HttpGet]
        public IEnumerable<branch> GetAllBranchNames(string companyid,string slid)
        {
            List<branch> BrInfo = new List<branch>();
            try
            {
                DataTable dtrecords = ObjDBAccess1.GetAllActiveBranches(companyid, slid);
                if (dtrecords != null && dtrecords.Rows.Count > 0)
                {
                    foreach (DataRow dr in dtrecords.Rows)
                    {
                        BrInfo.Add(new branch { branchName = dr["brname"].ToString(), brId = dr["brid"].ToString() });
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
            return BrInfo;
        }
    }
}
