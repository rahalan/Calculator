# Simple Calculator in PowerShell

function Show-Menu {
    Write-Host "`n=== Simple Calculator ===" -ForegroundColor Cyan
    Write-Host "1. Addition (+)"
    Write-Host "2. Subtraction (-)"
    Write-Host "3. Multiplication (*)"
    Write-Host "4. Division (/)"
    Write-Host "5. Exit"
    Write-Host "=========================" -ForegroundColor Cyan
}

function Get-Numbers {
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

function Add-Numbers {
    param([double]$a, [double]$b)
    return $a + $b
}

function Subtract-Numbers {
    param([double]$a, [double]$b)
    return $a - $b
}

function Multiply-Numbers {
    param([double]$a, [double]$b)
    return $a * $b
}

function Divide-Numbers {
    param([double]$a, [double]$b)
    if ($b -eq 0) {
        Write-Host "Error: Cannot divide by zero!" -ForegroundColor Red
        return $null
    }
    return $a / $b
}

# Main loop
do {
    Show-Menu
    $choice = Read-Host "`nSelect an operation (1-5)"
    
    if ($choice -eq "5") {
        Write-Host "Goodbye!" -ForegroundColor Green
        break
    }
    
    if ($choice -in @("1", "2", "3", "4")) {
        $numbers = Get-Numbers
        
        if ($null -ne $numbers) {
            $num1 = $numbers[0]
            $num2 = $numbers[1]
            
            switch ($choice) {
                "1" {
                    $result = Add-Numbers -a $num1 -b $num2
                    Write-Host "`nResult: $num1 + $num2 = $result" -ForegroundColor Green
                }
                "2" {
                    $result = Subtract-Numbers -a $num1 -b $num2
                    Write-Host "`nResult: $num1 - $num2 = $result" -ForegroundColor Green
                }
                "3" {
                    $result = Multiply-Numbers -a $num1 -b $num2
                    Write-Host "`nResult: $num1 * $num2 = $result" -ForegroundColor Green
                }
                "4" {
                    $result = Divide-Numbers -a $num1 -b $num2
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
