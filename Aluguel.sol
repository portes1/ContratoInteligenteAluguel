pragma solidity >=0.4.22 <0.7.0;
// import "./ERC20.sol";

    contract Aluguel {
        address payable proprietario; //  proprietario e locatario, pagáveis para o pagamento e posiveis reembolsos;
        address payable locatario;
   
   struct Propriedade{ //struct defindo os atributos referentes a propriedade, pode ser casa ou ap;
        uint256 preco;
        address payable locatarioAtual;
        bool disponivel;
   }
    Propriedade[5] casa; //inicializando uma casa do tipo propriedade, sendo uma struct, caso o proprietario possua mais de uma propriedade, poderiamos fazer um array;
    
    modifier proprietarioOnly() { //modificador que definira alguns itens somente acessados pelo proprietario;
        require(msg.sender == proprietario);
        _;
    }
    
    // construtor do nosso contrato, definindo a casa como disponivel e o preço como 500;
    constructor() public {
    proprietario = msg.sender;
    for (uint i=0; i<8; i++) {
        casa[i].disponivel = true;
        casa[i].preco = 500;
    }
}
    //definicao dos getters a seguir:
    
    //retorna se a propriedade esta ou nao disponivel;
    function getDisponibilidadeCasa(uint _casa) view public returns(bool) {
        return casa[_casa].disponivel;
    }
    
    function getPreco(uint _casa) view public returns(uint256) {
        return casa[_casa].preco;
    }
    
    function getLocatarioAtual(uint _casa) view public returns(address) { 
        return casa[_casa].locatarioAtual;
    }
    
    function setDisponibilidadeCasa(uint _casa, bool _novaDisponibilidade) proprietarioOnly public //caso tenha ficado disponível o endereco do locatario atual é zerado
    {
    casa[_casa].disponivel = _novaDisponibilidade;
    if (_novaDisponibilidade) {
        casa[_casa].locatarioAtual = address(0);
        }
    }
 
    function setPriceOfFlat(uint _casa, uint256 _preco) proprietarioOnly public // definicao do preco da Propriedade casa
    {
    casa[_casa].preco = _preco; 
    }
    
   function alugaCasa(uint _casa) public payable returns(uint256) {
    locatario = msg.sender;
    if (msg.value % casa[_casa].preco == 0 && msg.value > 0 && casa[_casa].disponivel == true) {
        uint256 mesesPagos = msg.value / casa[_casa].preco;
        casa[_casa].disponivel = false;
        casa[_casa].locatarioAtual = locatario;
        proprietario.transfer(msg.value);
        return mesesPagos;
    } else {
        locatario.transfer(msg.value);
        return 0;
        }
}   

    
    
}
