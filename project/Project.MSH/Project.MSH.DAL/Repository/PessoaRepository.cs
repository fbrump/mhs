using Project.MSH.BEL.Entity;
using Project.MSH.DAL.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.DAL.Repository
{
    public class PessoaRepository : BaseRepository<Pessoa>, IPessoaRepository
    {
        public PessoaRepository() : base() { }
        public PessoaRepository(Context.DbContextModel pContext) : base(pContext) { }
    }
}
