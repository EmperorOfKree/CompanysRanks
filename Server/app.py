from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from flask import Flask, request

import datetime, csv, math, os

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "postgres://postgres:postgres@localhost:5432/companiesranks"
db = SQLAlchemy(app)
migrate = Migrate(app, db)

class CompanyModel(db.Model):
    __tablename__ = 'company'

    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String())
    score = db.Column(db.Integer())
    total_receipts = db.Column(db.Integer())
    total_debts = db.Column(db.Integer())

    def __init__(self, name, score, total_receipts, total_debts):
        self.name = name
        self.score = score
        self.total_receipts = total_receipts
        self.total_debts = total_debts

    def __repr__(self):
        return f"<Company {self.name}>"

class MontlyRecordModel(db.Model):
    __tablename__ = 'monthly_record'

    id = db.Column(db.Integer(), primary_key=True)
    company_id = db.Column(db.Integer())
    score = db.Column(db.Integer())
    receipts = db.Column(db.Integer())
    debts = db.Column(db.Integer())

    def __init__(self, company_id, score, receipts, debts):
        self.company_id = company_id
        self.score = score
        self.receipts = receipts
        self.debts = debts

    def __repr__(self):
        return f"<MontlyRecord {self.month}>"

@app.route('/companies', methods=['GET'])
def handle_companies():
    if request.method == 'GET':
        companies = CompanyModel.query.order_by(CompanyModel.score.desc()).all()

        results = [
            {
                "companyId": company.id,
                "companyName": company.name,
                "companyRank": company.score,
                "companyInvoices": company.total_receipts,
                "companyDebts": company.total_debts
            } for company in companies]

        return { "data": results }

@app.route('/company_reports/<company_id>', methods=['GET'])
def handle_company_reports(company_id):
    if request.method == 'GET':
        company_reports = MontlyRecordModel.query.filter(MontlyRecordModel.company_id==company_id).all()

        results = [
            {
                "reportId": company.id,
                "companyId": company.company_id,
                "score": company.score,
                "invoices": company.receipts,
                "debts": company.debts
            } for company in company_reports]

        return { "data": results }

@app.route('/companiesNames', methods=['GET'])
def handle_companiesNames():
    if request.method == 'GET':
        companies = CompanyModel.query.order_by(CompanyModel.name).all()

        results = [
            {
                "companyId": company.id,
                "companyName": company.name
            } for company in companies]

        return { "data": results }

@app.route('/importData', methods=['POST'])
def handle_importData():
    if request.method == 'POST':
        if request.files and request.form:
            try:
                company = CompanyModel.query.get_or_404(request.form["company_id"])

                receipts = company.total_receipts
                debts = company.total_debts
                msg_error = ""

                receipts, debts, score, msg_error = get_infos_file(request, company.id, company.score, company.total_receipts, company.total_debts)

                if not msg_error:
                    company.score =  score
                    company.total_receipts = receipts 
                    company.total_debts = debts

                    db.session.add(company)
                    db.session.commit()

                    return { "message": "Arquivo importado com sucesso!" }

                return { "erro": msg_error }

            except Exception as e:
                return { "erro": e }
            
        else:
            return { "erro": "Arquivo não informado" }

def calulate_score(receipts, debts, score):
    newScore = score

    for x in range(receipts):
        percentScore = math.floor(newScore * 0.02)
        newScore += percentScore

    for x in range(debts):
        percentScore = math.ceil(newScore * 0.04)
        newScore -= percentScore

    if newScore < 1:
        return 1

    if newScore > 100:
        return 100

    return newScore

def get_infos_file(request, company_id, company_score, company_receipts, company_debts):
    receipts = 0
    debts = 0
    error = ""

    file_name = "./temp/temp_file_" + datetime.datetime.today().strftime('%Y%m%d%H%M%S') + ".csv"

    try:
        request.files["file"].save(file_name)

        with open(file_name) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter=';')
            line_count = 0

            for row in csv_reader:
                if line_count > 0:
                    receipts = int(row[0])
                    debts = int(row[1])
                    company_receipts += receipts
                    company_debts += debts

                    company_score = calulate_score(receipts, debts, company_score)

                    montly_record = MontlyRecordModel(company_id=company_id, score=company_score, receipts=receipts, debts=debts)
                    db.session.add(montly_record)
                
                line_count += 1

    except Exception:
        error = "Arquivo enviado fora do padrão aceitável" 

    finally:
        if os.path.exists(file_name):
            os.remove(file_name)
        
    return company_receipts, company_debts, company_score, error

if __name__ == '__main__':
    app.run(debug=False, port=5000)