import 'package:companiesranks/feature/company/ui/company_page.dart';
import 'package:companiesranks/feature/company_rank/model/company_rank.dart';
import 'package:flutter/material.dart';

class CompanyRankItem extends StatelessWidget {
  const CompanyRankItem({
    Key key,
    this.companyRank,
  }) : super(key: key);

  final CompanyRank companyRank;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              trailing: IconButton(
                padding: new EdgeInsets.all(0.0),
                icon: Icon(
                  Icons.info,
                  size: 28.0,
                  color: Colors.purple,
                ),
                onPressed: () => {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => new CompanyPage(this.companyRank)))
                },
              ),
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Chip(
                    backgroundColor: Colors.purple,
                    label: Text(
                      this.companyRank.companyName,
                      style: TextStyle(color: Colors.white, fontSize: 26),
                    ),
                  ),
                  this.companyRank.companyRank > 74 ? Text("  😃", style: TextStyle(fontSize: 28)) :
                  this.companyRank.companyRank > 49 ? Text("  🙂", style: TextStyle(fontSize: 28)) :
                  this.companyRank.companyRank > 24 ? Text("  😐", style: TextStyle(fontSize: 28)) :
                  Text("  🙁", style: TextStyle(fontSize: 28))
                ],
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            "Total créditos: ",
                            style: TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                          Text(
                            "${companyRank.companyInvoices}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            "Total débitos: ",
                            style: TextStyle(fontSize: 18, color: Colors.black54),
                          ),
                          Text(
                            "${companyRank.companyDebts}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Pontuação",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        "${companyRank.companyRank}%",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.purple,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
