Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD42411C322
	for <lists+dmaengine@lfdr.de>; Thu, 12 Dec 2019 03:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbfLLCUF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Dec 2019 21:20:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:39080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727592AbfLLCUF (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Dec 2019 21:20:05 -0500
Received: from dragon (98.142.130.235.16clouds.com [98.142.130.235])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C3A7208C3;
        Thu, 12 Dec 2019 02:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576117204;
        bh=WCnzKfA5mZ8iHgw9EUafDcJ6IlFqAjGtxuR1gUjVxto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odb/UIKlx4nrIjmRzmJOiScGwVsZi81CCIvw6Fru+s5tIZo2O5YvqT4A5HdCODp6L
         ts7vr/hsSOCKjh+Iuab/akV9I69OctM0tqmpaGD7owqUw2R1VMu7Us6bzUZ4rcUNPe
         WA75iUe1X4AMTvQn+Xf8iehsTImopA4lCPvYCIcI=
Date:   Thu, 12 Dec 2019 10:19:51 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Peng Ma <peng.ma@nxp.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Leo Li <leoyang.li@nxp.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Robin Gong <yibin.gong@nxp.com>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [v4 2/2] arm64: dts: ls1028a: Update edma compatible to fit eDMA
 driver
Message-ID: <20191212021950.GE15858@dragon>
References: <20191211080749.30751-1-peng.ma@nxp.com>
 <20191211080749.30751-2-peng.ma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211080749.30751-2-peng.ma@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 11, 2019 at 08:09:39AM +0000, Peng Ma wrote:
> The eDMA of LS1028A soc has a little bit different from others, So we
> should distinguish them in driver by compatible.
> 
> Signed-off-by: Peng Ma <peng.ma@nxp.com>
> ---
> Changed for v4
> 	- Add new change patch
> 
>  Documentation/devicetree/bindings/dma/fsl-edma.txt | 1 +

Please have bindings change as a separate patch.

Shawn

>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi     | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/dma/fsl-edma.txt b/Documentation/devicetree/bindings/dma/fsl-edma.txt
> index 29dd3ccb1235..e77b08ebcd06 100644
> --- a/Documentation/devicetree/bindings/dma/fsl-edma.txt
> +++ b/Documentation/devicetree/bindings/dma/fsl-edma.txt
> @@ -10,6 +10,7 @@ Required properties:
>  - compatible :
>  	- "fsl,vf610-edma" for eDMA used similar to that on Vybrid vf610 SoC
>  	- "fsl,imx7ulp-edma" for eDMA2 used similar to that on i.mx7ulp
> +	- "fsl,fsl,ls1028a-edma" for eDMA used similar to that on Vybrid vf610 SoC
>  - reg : Specifies base physical address(s) and size of the eDMA registers.
>  	The 1st region is eDMA control register's address and size.
>  	The 2nd and the 3rd regions are programmable channel multiplexing
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 8e8a77eb596a..b3716a89fa0d 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -316,7 +316,7 @@
>  
>  		edma0: dma-controller@22c0000 {
>  			#dma-cells = <2>;
> -			compatible = "fsl,vf610-edma";
> +			compatible = "fsl,ls1028a-edma";
>  			reg = <0x0 0x22c0000 0x0 0x10000>,
>  			      <0x0 0x22d0000 0x0 0x10000>,
>  			      <0x0 0x22e0000 0x0 0x10000>;
> -- 
> 2.17.1
> 
