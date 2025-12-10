# Simple Calculator in PowerShell

<#
.SYNOPSIS
    Displays the calculator menu options.
.DESCRIPTION
    Shows a formatted menu with available calculator operations including
    addition, subtraction, multiplication, division, and exit options.
#>
function Show-CalculatorMenu {
    Write-Host "`n=== Simple Calculator ===" -ForegroundColor Cyan
    Write-Host "1. Addition (+)"
    Write-Host "2. Subtraction (-)"
    Write-Host "3. Multiplication (*)"
    Write-Host "4. Division (/)"
    Write-Host "5. Exit"
    Write-Host "=========================" -ForegroundColor Cyan
}

<#
.SYNOPSIS
    Prompts the user to enter two numbers.
.DESCRIPTION
    Reads two numbers from user input and validates that they are valid numeric values.
    Returns an array containing both numbers if successful, or $null if validation fails.
.OUTPUTS
    System.Double[] - An array containing two double values, or $null on error.
#>
function Get-CalculatorInput {
    $num1 = Read-Host "Enter first number"
    $num2 = Read-Host "Enter second number"
    
    try {
        $number1 = [double]$num1
        $number2 = [double]$num2
        return @($number1, $number2)
    }
    catch {
        Write-Host "Invalid input. Please enter valid numbers." -ForegroundColor Red
        return $null
    }
}

<#
.SYNOPSIS
    Adds two numbers together.
.DESCRIPTION
    Performs addition of two double-precision floating-point numbers.
.PARAMETER FirstNumber
    The first number to add.
.PARAMETER SecondNumber
    The second number to add.
.OUTPUTS
    System.Double - The sum of the two numbers.
#>
function Invoke-Addition {
    param(
        [double]$FirstNumber,
        [double]$SecondNumber
    )
    return $FirstNumber + $SecondNumber
}

<#
.SYNOPSIS
    Subtracts the second number from the first.
.DESCRIPTION
    Performs subtraction of two double-precision floating-point numbers.
.PARAMETER FirstNumber
    The number to subtract from (minuend).
.PARAMETER SecondNumber
    The number to subtract (subtrahend).
.OUTPUTS
    System.Double - The difference of the two numbers.
#>
function Invoke-Subtraction {
    param(
        [double]$FirstNumber,
        [double]$SecondNumber
    )
    return $FirstNumber - $SecondNumber
}

<#
.SYNOPSIS
    Multiplies two numbers together.
.DESCRIPTION
    Performs multiplication of two double-precision floating-point numbers.
.PARAMETER FirstNumber
    The first number to multiply.
.PARAMETER SecondNumber
    The second number to multiply.
.OUTPUTS
    System.Double - The product of the two numbers.
#>
function Invoke-Multiplication {
    param(
        [double]$FirstNumber,
        [double]$SecondNumber
    )
    return $FirstNumber * $SecondNumber
}

<#
.SYNOPSIS
    Divides the first number by the second.
.DESCRIPTION
    Performs division of two double-precision floating-point numbers.
    Includes validation to prevent division by zero.
.PARAMETER FirstNumber
    The number to be divided (dividend).
.PARAMETER SecondNumber
    The number to divide by (divisor).
.OUTPUTS
    System.Double - The quotient of the two numbers, or $null if division by zero is attempted.
#>
function Invoke-Division {
    param(
        [double]$FirstNumber,
        [double]$SecondNumber
    )
    if ($SecondNumber -eq 0) {
        Write-Host "Error: Cannot divide by zero!" -ForegroundColor Red
        return $null
    }
    return $FirstNumber / $SecondNumber
}

# Main calculator loop
do {
    Show-CalculatorMenu
    $choice = Read-Host "`nSelect an operation (1-5)"
    
    if ($choice -eq "5") {
        Write-Host "Goodbye!" -ForegroundColor Green
        break
    }
    
    if ($choice -in @("1", "2", "3", "4")) {
        $numbers = Get-CalculatorInput
        
        if ($null -ne $numbers) {
            $num1 = $numbers[0]
            $num2 = $numbers[1]
            
            switch ($choice) {
                "1" {
                    $result = Invoke-Addition -FirstNumber $num1 -SecondNumber $num2
                    Write-Host "`nResult: $num1 + $num2 = $result" -ForegroundColor Green
                }
                "2" {
                    $result = Invoke-Subtraction -FirstNumber $num1 -SecondNumber $num2
                    Write-Host "`nResult: $num1 - $num2 = $result" -ForegroundColor Green
                }
                "3" {
                    $result = Invoke-Multiplication -FirstNumber $num1 -SecondNumber $num2
                    Write-Host "`nResult: $num1 * $num2 = $result" -ForegroundColor Green
                }
                "4" {
                    $result = Invoke-Division -FirstNumber $num1 -SecondNumber $num2
                    if ($null -ne $result) {
                        Write-Host "`nResult: $num1 / $num2 = $result" -ForegroundColor Green
                    }
                }
            }
        }
    }
    else {
        Write-Host "Invalid choice. Please select 1-5." -ForegroundColor Yellow
    }
} while ($true)
