Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42BFA2B0F4
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 11:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfE0JGH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 05:06:07 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55253 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfE0JGF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 May 2019 05:06:05 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hVBZr-0004GD-6D; Mon, 27 May 2019 11:05:55 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1hVBZp-0001YR-Ic; Mon, 27 May 2019 11:05:53 +0200
Date:   Mon, 27 May 2019 11:05:53 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     yibin.gong@nxp.com
Cc:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com,
        mark.rutland@arm.com, vkoul@kernel.org, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/7] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Message-ID: <20190527090553.lek7tm3lyst3bhrd@pengutronix.de>
References: <20190527085118.40423-1-yibin.gong@nxp.com>
 <20190527085118.40423-7-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527085118.40423-7-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:01:40 up 9 days, 15:19, 72 users,  load average: 0.51, 0.30, 0.17
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 27, 2019 at 04:51:17PM +0800, yibin.gong@nxp.com wrote:
> From: Robin Gong <yibin.gong@nxp.com>
> 
> +static const struct of_device_id fsl_edma_dt_ids[] = {
> +	{ .compatible = "fsl,vf610-edma", .data = (void *)v1 },
> +	{ .compatible = "fsl,imx7ulp-edma", .data = (void *)v3 },
> +	{ /* sentinel */ }

Please put a struct type behind the .data pointer so that you can
configure...

> +};
> +MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
> +
> @@ -218,6 +272,22 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	fsl_edma_setup_regs(fsl_edma);
>  	regs = &fsl_edma->regs;
>  
> +	if (fsl_edma->version == v3) {
> +		fsl_edma->dmamux_nr = 1;

...things like this...

> @@ -264,7 +334,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
>  	}
>  
>  	edma_writel(fsl_edma, ~0, regs->intl);
> -	ret = fsl_edma_irq_init(pdev, fsl_edma);
> +
> +	if (fsl_edma->version == v3)
> +		ret = fsl_edma2_irq_init(pdev, fsl_edma);
> +	else
> +		ret = fsl_edma_irq_init(pdev, fsl_edma);

...and this one in that struct rather than littering the code more and
more with such version tests.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
