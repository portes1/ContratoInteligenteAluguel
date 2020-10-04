pragma solidity >=0.4.22 <0.7.0;
import "./ERC20.sol";

    contract Aluguel {
        address payable proprietario; //  proprietario e locatario, pagáveis para o pagamento e posiveis reembolsos;
        address payable locatario;
   
   struct Propriedade{ //struct defindo os atributos referentes a propriedade, pode ser casa ou ap;
        uint256 preco;
        address locatarioAtual;
        bool disponivel;
   }
    Propriedade casa; //inicializando uma casa do tipo propriedade, sendo uma struct, caso o proprietario possua mais de uma propriedade, poderiamos fazer um array;
    
    modifier proprietarioOnly() { //modificador que definira alguns itens somente acessados pelo proprietario;
        require(msg.sender == proprietarioAddress);
        _;
    }
    
    // construtor do nosso contrato, definindo a casa como disponivel e o preço como 500;
    constructor() public {
        proprietarioAddress = msg.sender;
        casa.disponivel = true;
        casa.preco = 500;
       
    }
    //definicao dos getters a seguir:
    
    //retorna se a propriedade esta ou nao disponivel;
    function getDisponibilidadeCasa() view public returns(bool) {
        return casa.disponivel;
    }
    
    function getPreco() view public returns(uint256) {
        return casa.preco;
    }
    
    function getLocatarioAtual() view public returns(address) {
        return casa.locatarioAtual;
    }
    
}