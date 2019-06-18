Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95C5A4A1CF
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2019 15:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbfFRNOS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 18 Jun 2019 09:14:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:37796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbfFRNOS (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 18 Jun 2019 09:14:18 -0400
Received: from dragon (li1322-146.members.linode.com [45.79.223.146])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3168E2070B;
        Tue, 18 Jun 2019 13:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560863657;
        bh=/l30FOU0AryVpc5HW+1cx+d4B+hv8HqciAB/OIoARr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M7aWkd2lU4lW1/75YEvMN623tYFX4RQhAA/Nr/6vUzS0Oz0yixi/ufY9+mub+PaYf
         e8yxEXUh9NWL3J6PghN/BvQgrRHILFT5L+grP6f1m1gwrUR3Ugd9gCcc1KR246ihis
         oqgfX8ShPxP+oPUa3p4VgBgnxmOGDfuOxDzvRvYM=
Date:   Tue, 18 Jun 2019 21:13:20 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        leoyang.li@nxp.com, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/4] arm64: dts: fsl: ls1028a: Add eDMA node
Message-ID: <20190618131319.GC1959@dragon>
References: <20190506090344.37784-1-peng.ma@nxp.com>
 <20190506090344.37784-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190506090344.37784-2-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 06, 2019 at 09:03:42AM +0000, Peng Ma wrote:
> Add the eDMA device tree nodes for LS1028A devices
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 8116fb3..71b87cb 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -235,6 +235,21 @@
>  			status = "disabled";
>  		};
>  
> +		edma0: edma@22c0000 {
> +			#dma-cells = <2>;
> +			compatible = "fsl,vf610-edma";
> +			reg = <0x0 0x22c0000 0x0 0x10000>,
> +			      <0x0 0x22d0000 0x0 0x10000>,
> +			      <0x0 0x22e0000 0x0 0x10000>;
> +			interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
> +				     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-names = "edma-tx", "edma-err";
> +			dma-channels = <32>;
> +			clock-names = "dmamux0", "dmamux1";
> +			clocks = <&clockgen 4 1>,
> +				 <&clockgen 4 1>;
> +		};
> +

The edma@22c0000 node had already been added by commit below:

  f54f7be5c5ac ("arm64: dts: ls1028a: Add Audio DT nodes")

Shawn

>  		gpio1: gpio@2300000 {
>  			compatible = "fsl,qoriq-gpio";
>  			reg = <0x0 0x2300000 0x0 0x10000>;
> -- 
> 1.7.1
> 
