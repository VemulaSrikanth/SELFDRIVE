using System;
using System.Data;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using log4net;
using System.Collections.Generic;
using System.Text;
//[assembly: log4net.Config.XmlConfigurator(Watch = true)]


namespace SelfDrive
{
    public class AppLog
    {
        //private AppLogNew()
        //{

        //}

        private static string Seperator1 = "####################################################################################";
        private static string Seperator2 = "------------------------------------------------------------------------------------";

        private static log4net.ILog Log = GetLogger(typeof(AppLog));
        public static bool LogInfoMessages = Convert.ToBoolean(Convert.ToString(System.Configuration.ConfigurationSettings.AppSettings["LogInfoMessages"]));
        public static bool LogDebugMessages = Convert.ToBoolean(Convert.ToString(System.Configuration.ConfigurationSettings.AppSettings["LogDebugMessages"]));

        public static string FilePath
        {
            get
            {
                string filepath = ((log4net.Appender.FileAppender)Log.Logger.Repository.GetAppenders()[0]).File;
                if (!System.IO.File.Exists(filepath)) Log.Info("");
                System.IO.FileInfo f = new System.IO.FileInfo(filepath);
                return f.Directory.FullName;
            }
        }
        public static void Debug(object message, Exception exception)
        {
            if (exception.GetType().ToString() != "System.Threading.ThreadAbortException")
            {
                Log = GetLogger(typeof(AppLog));
                if (LogDebugMessages) Log.Debug(message, exception);
            }
        }

        public static void Debug(object message)
        {

            Log = GetLogger(typeof(AppLog));
            if (LogDebugMessages) Log.Debug(message);
        }

        public static void Info(object message, Exception exception)
        {
            if (exception.GetType().ToString() != "System.Threading.ThreadAbortException")
            {
                Log = GetLogger(typeof(AppLog));
                if (LogInfoMessages) Log.Info(message, exception);
            }
        }
        public static void Info(object message)
        {
            Log = GetLogger(typeof(AppLog));
            if (LogInfoMessages) Log.Info(message);
        }
        public static void Error(Exception exception, object message)
        {
            if (exception.GetType().ToString() != "System.Threading.ThreadAbortException")
            {
                Log = GetLogger(typeof(AppLog));
                Log.Error(message, exception);
            }
        }

        public static void Error(object message)
        {
            if (message.GetType().ToString() != "System.Threading.ThreadAbortException")
            {
                Log = GetLogger(typeof(AppLog));
                Log.Error(message);
            }

        }
        public static ILog GetLogger(Type type)
        {
            LogManager.ResetConfiguration();
            Configure();
            return LogManager.GetLogger(type);
        }

        private static void Configure()
        {
            string ConfigFilePath = System.IO.Path.Combine(System.Web.HttpContext.Current.Server.MapPath("~"), "web.config");
            System.IO.FileInfo fInfo = new System.IO.FileInfo(ConfigFilePath);
            log4net.Config.XmlConfigurator.ConfigureAndWatch(fInfo);
        }
        public static void Request(object message)
        {
            Log.Info(Seperator1);
            Log.Info("Request " + DateTime.Now.ToString());
            Log.Info(Seperator2);
            Log.Info(message);
            Log.Info(Seperator1);
        }
        public static void Request(object message, object MethodName)
        {
            Log.Info(Seperator1);
            Log.Info(MethodName.ToString() + " Request " + DateTime.Now.ToString());
            Log.Info(Seperator2);
            Log.Info(message);
            Log.Info(Seperator1);
        }
        public static void Response(object message)
        {
            Log.Info(Seperator1);
            Log.Info("Response " + DateTime.Now.ToString());
            Log.Info(Seperator2);
            Log.Info(message);
            Log.Info(Seperator1);
        }
        public static void Response(object message, object MethodName)
        {
            Log.Info(Seperator1);
            Log.Info(MethodName.ToString() + " Response " + DateTime.Now.ToString());
            Log.Info(Seperator2);
            Log.Info(message);
            Log.Info(Seperator1);
        }    

    }
}
