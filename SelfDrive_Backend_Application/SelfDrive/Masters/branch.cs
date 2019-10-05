using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SelfDrive.Masters
{
    public class branch
    {
        public string branchName { get; set; }
        public string brId { get; set; }
    }
    public class VehMakeMaster
    {
        public string VehMake { get; set; }
        public string VehMakeId { get; set; }
    }
    public class PackageInfo
    {
        public string Tariffid { get; set; }
        public string PackageName { get; set; }
        public string allowedKms { get; set; }
        public string allowedHrs { get; set; }
        public string basicrate { get; set; }
        public string SecurityDeposit { get; set; }
    }

    public class AccessoriesInfo
    {
        public string Accsid { get; set; }
        public string AccsName { get; set; }
        public string AccsDescription { get; set; }
    }
}