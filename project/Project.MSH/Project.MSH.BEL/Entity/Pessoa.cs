using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Project.MSH.BEL.Entity
{
    public class Pessoa
    {
        public int id { get; set; }
        public string nome { get; set; }
        public string sobrenome { get; set; }
        public DateTime dataNascimento { get; set; }
    }
}
