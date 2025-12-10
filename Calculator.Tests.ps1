# Pester Unit Tests for Calculator.ps1

# Dot-source the calculator script to import functions
# We need to extract just the function definitions, not the main loop
$scriptContent = Get-Content "$PSScriptRoot\Calculator.ps1" -Raw
$functionsOnly = $scriptContent -replace '(?s)# Main calculator loop.*', ''
Invoke-Expression $functionsOnly

# Load test data from CSV file
$testData = Import-Csv "$PSScriptRoot\TestData.csv"

# Group test data by operation
$additionTests = $testData | Where-Object { $_.Operation -eq 'Addition' }
$subtractionTests = $testData | Where-Object { $_.Operation -eq 'Subtraction' }
$multiplicationTests = $testData | Where-Object { $_.Operation -eq 'Multiplication' }
$divisionTests = $testData | Where-Object { $_.Operation -eq 'Division' }

Describe "Invoke-Addition" {
    foreach ($test in $additionTests) {
        It $test.TestDescription {
            $result = Invoke-Addition -FirstNumber ([double]$test.FirstNumber) -SecondNumber ([double]$test.SecondNumber)
            $result | Should Be ([double]$test.ExpectedResult)
        }
    }
}

Describe "Invoke-Subtraction" {
    foreach ($test in $subtractionTests) {
        It $test.TestDescription {
            $result = Invoke-Subtraction -FirstNumber ([double]$test.FirstNumber) -SecondNumber ([double]$test.SecondNumber)
            $result | Should Be ([double]$test.ExpectedResult)
        }
    }
}

Describe "Invoke-Multiplication" {
    foreach ($test in $multiplicationTests) {
        It $test.TestDescription {
            $result = Invoke-Multiplication -FirstNumber ([double]$test.FirstNumber) -SecondNumber ([double]$test.SecondNumber)
            $result | Should Be ([double]$test.ExpectedResult)
        }
    }
}

Describe "Invoke-Division" {
    foreach ($test in $divisionTests) {
        It $test.TestDescription {
            $result = Invoke-Division -FirstNumber ([double]$test.FirstNumber) -SecondNumber ([double]$test.SecondNumber)
            if ([string]::IsNullOrEmpty($test.ExpectedResult)) {
                $result | Should BeNullOrEmpty
            }
            else {
                $result | Should Be ([double]$test.ExpectedResult)
            }
        }
    }
}
