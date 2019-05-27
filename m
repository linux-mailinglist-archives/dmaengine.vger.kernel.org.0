Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957632B1DC
	for <lists+dmaengine@lfdr.de>; Mon, 27 May 2019 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726365AbfE0KKK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 May 2019 06:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbfE0KKK (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 27 May 2019 06:10:10 -0400
Received: from localhost (unknown [171.61.91.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C5A720859;
        Mon, 27 May 2019 10:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558951809;
        bh=NnmgDy5FptWpQILTDsZ4Xve8h2sTF+iS5fFSlh0fjz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=snA0dl2mB3eN9j8L1PY7p2ImPCLljwBsCVF8fJeqljCDdbesF3LbLdyOe75n8a2z8
         f32m7VKpFBVs7jddUxx3JqgKvQZZ/buVB4YACB+a1aQTmg9JppJEtRwBHD6Dfy/0jN
         lcLjftgbaX+k6lMoi03cdD+5IzaPbD/ICHlimVMc=
Date:   Mon, 27 May 2019 15:40:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     yibin.gong@nxp.com, robh@kernel.org, shawnguo@kernel.org,
        festevam@gmail.com, mark.rutland@arm.com, dan.j.williams@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 6/7] dmaengine: fsl-edma: add i.mx7ulp edma2 version
 support
Message-ID: <20190527101003.GI15118@vkoul-mobl>
References: <20190527085118.40423-1-yibin.gong@nxp.com>
 <20190527085118.40423-7-yibin.gong@nxp.com>
 <20190527090553.lek7tm3lyst3bhrd@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190527090553.lek7tm3lyst3bhrd@pengutronix.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-05-19, 11:05, Sascha Hauer wrote:
> On Mon, May 27, 2019 at 04:51:17PM +0800, yibin.gong@nxp.com wrote:
> > From: Robin Gong <yibin.gong@nxp.com>
> > 
> > +static const struct of_device_id fsl_edma_dt_ids[] = {
> > +	{ .compatible = "fsl,vf610-edma", .data = (void *)v1 },
> > +	{ .compatible = "fsl,imx7ulp-edma", .data = (void *)v3 },
> > +	{ /* sentinel */ }
> 
> Please put a struct type behind the .data pointer so that you can
> configure...

Yeah that was the idea behind the suggestion in previous version.

Something like 

struct fsl_edma_driver_data {
        unsigned int channels;
        ...
};

and then you have

const struct fsl_edma_driver_data v1_data {
        .channels = 1;
        ...
};

> 
> > +};
> > +MODULE_DEVICE_TABLE(of, fsl_edma_dt_ids);
> > +
> > @@ -218,6 +272,22 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  	fsl_edma_setup_regs(fsl_edma);
> >  	regs = &fsl_edma->regs;
> >  
> > +	if (fsl_edma->version == v3) {
> > +		fsl_edma->dmamux_nr = 1;

You can store the struct in driver context or store the values, so here
it becomes

        driver->data->channel;

and so on for other data, you can also point function pointers (hint
edma/2_irq_init)

> 
> ...things like this...
> 
> > @@ -264,7 +334,11 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  	}
> >  
> >  	edma_writel(fsl_edma, ~0, regs->intl);
> > -	ret = fsl_edma_irq_init(pdev, fsl_edma);
> > +
> > +	if (fsl_edma->version == v3)
> > +		ret = fsl_edma2_irq_init(pdev, fsl_edma);
> > +	else
> > +		ret = fsl_edma_irq_init(pdev, fsl_edma);
> 
> ...and this one in that struct rather than littering the code more and
> more with such version tests.
> 
> Sascha
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

-- 
~Vinod
