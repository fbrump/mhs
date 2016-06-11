using Project.MSH.DAL.Interface;
using Project.MSH.DAL.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.DAL.Factory
{
    /// <summary>
    /// Repository factory.
    /// </summary>
    /// <typeparam name="TReturn">Interface of the repository.</typeparam>
    public class FactoryRepository<TReturn>
    {
        #region [ Variables ]

        /// <summary>
        /// Dictionary of the associations of the interface by repository that implement.
        /// </summary>
        private IDictionary<Type, object> _dic;

        /// <summary>
        /// Type of the interface of repository.
        /// </summary>
        private Type _interfaceRepository;

        #endregion

        #region [ Constructor ]

        /// <summary>
        /// Constructory of the repository.
        /// </summary>
        public FactoryRepository(){
            StartDictionary();
            CreateDictionary();
        }

        #endregion

        #region [ Public Method ]

        /// <summary>
        /// This public method return the one instante of the repository that implementation interface you passed on the instance.
        /// </summary>
        /// <returns>Repository instance.</returns>
        public TReturn Get()
        {
            if (_dic.ContainsKey(_interfaceRepository)){
                return (TReturn)_dic[_interfaceRepository];
            }
            
            return (TReturn)new object(); 
        }

        /// <summary>
        /// Add new repository to repository for you will use this later.
        /// </summary>
        /// <param name="typeInterface">Type of the interface repository.</param>
        /// <param name="repository">Instance of the repository associated.</param>
        public void Add(Type typeInterface, object repository)
        {
            _dic.Add(typeInterface, repository);
        }

        #endregion

        #region [ Private Method ]

        private void StartDictionary()
        {
            _dic = new Dictionary<Type, object>();
            _interfaceRepository = typeof(TReturn);
        }

        private void CreateDictionary()
        {
            _dic.Add(typeof(IPessoaRepository), new PessoaRepository());
        }

        #endregion
    }
}
