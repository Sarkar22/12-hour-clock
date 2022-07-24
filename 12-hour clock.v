module top_module(
    input clk,
    input reset,
    input ena,
    output pm,
    output [7:0] hh,
    output [7:0] mm,
    output [7:0] ss); 
    reg[7:0] temp_hr,temp_min,temp_sec;
	reg temp_pm;

//counting hour
always@(posedge clk)
begin
	if(reset)temp_hr=8'h12;
	else if((temp_min==8'h59)&(temp_sec==8'h59))begin
        case (temp_hr)
				8'h09:temp_hr=8'h10;
				8'h12:temp_hr=8'h01;
				default:temp_hr=temp_hr+1'd1;

			endcase
			end
	end

//counting minute
always@(posedge clk) begin
    if(reset) temp_min=8'h00;
    else if(temp_sec==8'h59) begin
			case (temp_min)
				8'h09:temp_min=8'h10;
				8'h19:temp_min=8'h20;
				8'h29:temp_min=8'h30;
				8'h39:temp_min=8'h40;
				8'h49:temp_min=8'h50;
				8'h59:temp_min=8'h00;
				default:temp_min=temp_min+1'd1;

			endcase;
		   end
	end

//counting second
always@(posedge clk) begin
    if(reset) temp_sec=8'h00;
    else if(ena) begin
			case (temp_sec)
				8'h09:temp_sec=8'h10;
				8'h19:temp_sec=8'h20;
				8'h29:temp_sec=8'h30;
				8'h39:temp_sec=8'h40;
				8'h49:temp_sec=8'h50;
				8'h59:temp_sec=8'h00;
				default:temp_sec=temp_sec+1'd1;

			endcase;
		end
	end

//pm manipulation
always@(posedge clk)begin
    if(reset) temp_pm=1'b0;
	else if((temp_hr==8'h11)&(temp_min==8'h59)&(temp_sec==8'h59))temp_pm = ~temp_pm;
end

// assigning hh,mm,ss,pm
assign hh=temp_hr;
assign mm=temp_min;
assign ss=temp_sec;
assign pm=temp_pm;

endmodule
