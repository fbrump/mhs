using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.DAL.Interface
{
    public interface IRepository<T> where T : class
    {
        IEnumerable<T> GetAll();

        IEnumerable<T> GetAll(Func<T, bool> pFilter);

        T GetById(Func<T, bool> pId);

        void Insert(T pEntity);

        T Update(T pEntity);

        void Delete(T pEntity);
    }
}
