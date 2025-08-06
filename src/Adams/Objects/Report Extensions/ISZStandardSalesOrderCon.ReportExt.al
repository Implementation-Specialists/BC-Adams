reportextension 50100 "ISZ Standard Sales - Order Con" extends "Standard Sales - Order Conf."
{
    dataset
    {
        add(Line)
        {
            column(ISZ_NetWeight_Line; "Net Weight")
            {
            }
        }
        add(Totals)
        {
            column(ISZ_Total_Net_Weight; TotalNetWeight)
            {
            }
        }
        modify(Header)
        {
            trigger OnAfterAfterGetRecord()
            begin
                TotalNetWeight := 0;
            end;
        }
        modify(Line)
        {
            trigger OnAfterAfterGetRecord()
            begin
                TotalNetWeight += "Net Weight";
            end;
        }
        modify(ReportTotalsLine)
        {
            trigger OnAfterPreDataItem()
            begin
                AddTotalNetWeightReportTotalsLine(ReportTotalsLine);
            end;
        }
        modify(USReportTotalsLine)
        {
            trigger OnAfterPreDataItem()
            begin
                AddTotalNetWeightReportTotalsLine(ReportTotalsLine);
            end;
        }
    }
    rendering
    {
        layout("ISZStandardSalesOrderConfirmationNetWeight.docx")
        {
            Caption = 'Adams Sales Order Confirmation with Net Weight (Word)';
            LayoutFile = '.\Objects\Report Extensions\Layouts\ISZ Standard Sales Order Confirmation - Net Weight.docx';
            Summary = 'Based on the Standard Sales Order Confirmation (Word) adding Net Weight';
            Type = Word;
        }
    }
    labels
    {
        ISZ_NetWeightLbl = 'Net Weight';
        ISZ_TotalNetWeightLbl = 'Total Net Weight';
    }

    local procedure AddTotalNetWeightReportTotalsLine(var ReportTotalsLine: Record "Report Totals Buffer")
    begin
        ReportTotalsLine.Add(TotalNetWeightLbl, TotalNetWeight, false, false, false);
    end;

    var
        TotalNetWeight: Decimal;
        TotalNetWeightLbl: Label 'Total Net Weight';
}