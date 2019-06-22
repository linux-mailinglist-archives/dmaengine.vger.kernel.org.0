Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55B954F7EC
	for <lists+dmaengine@lfdr.de>; Sat, 22 Jun 2019 21:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbfFVT1H (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 22 Jun 2019 15:27:07 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34118 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFVT1H (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 22 Jun 2019 15:27:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LyjzJSypZSrIB4Um/wy3TWsRfkzG5jtre8HrjxOuMmc=; b=cQJtPj83FJrt7MWpdASNDv19D
        EDY4KAle68RyDG8rwkMAuWUZvJb3unIz93Iis8oPIB6/oYRPu0u0nUO9/8SV6eRMopuiQXQQETqIa
        PjrJo0c8cPNcNtMfRtyQVNbAcfq+FME7EwyytHp+uhzVbz6piLUmoSN+R+Br2WZzAnSbVd6y49I4f
        I89rL9sOtU5/3MlTKbqjJf1VRxGmjbnqKxRvczCm0Gsp1Hg5gEAkphPoIVj1zS1KPPXhrsQ2oXZ66
        K9pYhFYbFnq6SN59+zZVtdlfpHCAiUCmLsipsgOTVVbrfK3fNnQaPbYGHIUq2/D8inaqYB1v7dClf
        J7z0D2Vuw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:58904)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1helf9-0005Xi-E7; Sat, 22 Jun 2019 20:26:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1helf3-0004Ou-S9; Sat, 22 Jun 2019 20:26:53 +0100
Date:   Sat, 22 Jun 2019 20:26:53 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Michael Olbrich <m.olbrich@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2] dmaengine: imx-sdma: fix incorrect conversion to
 readl_relaxed_poll_timeout_atomic()
Message-ID: <20190622192653.puxds354sx5v3jg7@shell.armlinux.org.uk>
References: <20190622165318.bgyun52hssqmdv4n@shell.armlinux.org.uk>
 <E1helB3-0005d6-7m@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1helB3-0005d6-7m@rmk-PC.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Well, this doesn't appear to completely solve the problem either -
one out of four of my platforms still spat out the error (because
the SDMA initialisation can run on a different CPU to that which
receives the interrupt.)

I've thought about using a completion, but that doesn't work either,
because in the case of a single CPU, the interrupts will be masked,
so we can't wait for completion.  I think we need to eliminate that
spinlock around this code.

On Sat, Jun 22, 2019 at 07:55:53PM +0100, Russell King wrote:
> When imx-sdma was converted to use readl_relaxed_poll_timeout_atomic(),
> the termination condition was inverted.  Fix this.
> 
> Fixes: 1d069bfa3c78 ("dmaengine: imx-sdma: ack channel 0 IRQ in the interrupt handler")
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/dma/imx-sdma.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 5f3c1378b90e..c45cbdb09714 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -655,15 +655,21 @@ static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
>  static int sdma_run_channel0(struct sdma_engine *sdma)
>  {
>  	int ret;
> -	u32 reg;
> +	u32 reg, mask;
> +
> +	// Disable channel 0 interrupt
> +	mask = readl_relaxed(sdma->regs + SDMA_H_INTRMSK);
> +	writel_relaxed(mask & ~1, sdma->regs + SDMA_H_INTRMSK);
>  
>  	sdma_enable_channel(sdma, 0);
>  
> -	ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_STATSTOP,
> -						reg, !(reg & 1), 1, 500);
> +	ret = readl_relaxed_poll_timeout_atomic(sdma->regs + SDMA_H_INTR,
> +						reg, reg & 1, 1, 500);
>  	if (ret)
>  		dev_err(sdma->dev, "Timeout waiting for CH0 ready\n");
>  
> +	writel_relaxed(mask, sdma->regs + SDMA_H_INTRMSK);
> +
>  	/* Set bits of CONFIG register with dynamic context switching */
>  	reg = readl(sdma->regs + SDMA_H_CONFIG);
>  	if ((reg & SDMA_H_CONFIG_CSM) == 0) {
> -- 
> 2.7.4
> 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
