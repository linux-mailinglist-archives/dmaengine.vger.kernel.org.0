Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D98B61E5436
	for <lists+dmaengine@lfdr.de>; Thu, 28 May 2020 04:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725896AbgE1Cty (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 May 2020 22:49:54 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58300 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgE1Cty (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 May 2020 22:49:54 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 200412A3;
        Thu, 28 May 2020 04:49:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1590634192;
        bh=PW4v3V4tAsruR594p7O8GO6Cx4Xe0SOtEN+sXukUT8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wT41HrwOh9ciDsnNSdIIi8ANDjKe2FUe/CdHlQvO2HNxv//VI23rBQFO3BVqPk54I
         2lyUWCu0AyCetxjQigvFh6VUCD9iz9Smxh1n0fHLwX9nq6XWjKYDxlziKPYfkciOaS
         qu/Nd0umGxevlw5xQeEI3Z117HbGWJY0Vq4IOXAY=
Date:   Thu, 28 May 2020 05:49:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     dmaengine@vger.kernel.org, Hyun Kwon <hyun.kwon@xilinx.com>,
        Tejas Upadhyay <tejasu@xilinx.com>,
        Satish Kumar Nagireddy <SATISHNA@xilinx.com>,
        Vinod Koul <vkoul@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v4 6/6] arm64: dts: zynqmp: Add DPDMA node
Message-ID: <20200528024938.GA31055@pendragon.ideasonboard.com>
References: <20200513165943.25120-1-laurent.pinchart@ideasonboard.com>
 <20200513165943.25120-7-laurent.pinchart@ideasonboard.com>
 <4221cfb8-2193-afb5-dd1f-f0f3ac315ff4@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4221cfb8-2193-afb5-dd1f-f0f3ac315ff4@xilinx.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Michal,

On Thu, May 14, 2020 at 07:56:47AM +0200, Michal Simek wrote:
> On 13. 05. 20 18:59, Laurent Pinchart wrote:
> > Add a DT node for the DisplayPort DMA engine (DPDMA).
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > ---
> >  arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |  4 ++++
> >  arch/arm64/boot/dts/xilinx/zynqmp.dtsi         | 10 ++++++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> > index 9868ca15dfc5..32c4914738d9 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi
> > @@ -57,6 +57,10 @@ &cpu0 {
> >  	clocks = <&zynqmp_clk ACPU>;
> >  };
> >  
> > +&dpdma {
> > +	clocks = <&zynqmp_clk DPDMA_REF>;
> > +};
> > +
> >  &fpd_dma_chan1 {
> >  	clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
> >  };
> > diff --git a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > index 26d926eb1431..2e284eb8d3c1 100644
> > --- a/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > +++ b/arch/arm64/boot/dts/xilinx/zynqmp.dtsi
> > @@ -246,6 +246,16 @@ pmu@9000 {
> >  			};
> >  		};
> >  
> > +		dpdma: dma-controller@fd4c0000 {
> > +			compatible = "xlnx,zynqmp-dpdma";
> > +			status = "disabled";
> > +			reg = <0x0 0xfd4c0000 0x0 0x1000>;
> > +			interrupts = <0 122 4>;
> > +			interrupt-parent = <&gic>;
> > +			clock-names = "axi_clk";
> > +			#dma-cells = <1>;
> > +		};
> > +
> >  		/* GDMA */
> >  		fpd_dma_chan1: dma@fd500000 {
> >  			status = "disabled";
> > 
> 
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> 
> Feel free to take it with this series. Or let me know if you want me to
> take it via my soc tree.

If we ever find an agreement on the DMA engine API :-)

-- 
Regards,

Laurent Pinchart
