const mysql = require('mysql2/promise');
async function run() {
  const connection = await mysql.createConnection("mysql://root:@localhost:3306/weber_procuracao");
  const [users] = await connection.query("SELECT id, name, email, passwordHash, role FROM users");
  console.log("Users in weber_procuracao:", users);
  await connection.end();
}
run().catch(console.error);
