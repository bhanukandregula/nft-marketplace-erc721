const {assert} = require('chai');
const KryptoBird = artifacts.require('./Kryptobird');

// check for chai
require('chai')
    .use(require('chai-as-promised'))
    .should()

contract('KryptoBird', async (accounts) => {
    let contract;
    before( async () => {
         contract = await KryptoBird.deployed();
    });
    
    // make a testing container
    describe('deployment', async () => {

        it('deploys successfully', async () => {
            const address = contract.address;
            // we don't want address to be empty | '' | null | undefined | 0x0
            assert.notEqual(address, null); 
        });

        it('name test is successfull', async() => {
            const name =  await contract.name();
            assert.equal(name, 'Bhanu Kandregula');
        });

        it('symbol test is successfull', async() => {
            const symbol =  await contract.symbol();
            assert.equal(symbol, 'Bhanu Symbol');
        });
    });

    describe('minting', async() => {
        it('creates a new token', async() => {
            const result = await contract.mint('https....01');
            const totalSupply = await contract.totalSupply();
            // Success case
            assert.equal(totalSupply, 1);
            const event = result.logs[0].args;
            assert.equal(event._from, '0x0000000000000000000000000000000000000000', 'from is the contract');
            assert.equal(event._to, accounts[0], 'to is msg.sender');

            //failure
            await contract.mint('https....01').should.be.rejected;
        });
    });

    describe( 'indexing', async () => {
        it('lists KryptoBirdz', async () => {
            //mint three new tokens
            await contract.mint('https...2')
            await contract.mint('https...3')
            await contract.mint('https...4')
            const totalSupply = await contract.totalSupply();
        
            //loop through the list and grab KBirdz from the list
            let result = [];
            let KryptoBird
            for( i = 1; i<= totalSupply; i++) {
                KryptoBird = await contract.kryptoBirdz(i-1);
                result.push(KryptoBird);
            } 
            //assert that our new array result will equal the expected result
            let expected = ['https....01','https...2','https...3','https...4'];
            assert.equal(result.join(','), expected.join(','));
        });

    });

});