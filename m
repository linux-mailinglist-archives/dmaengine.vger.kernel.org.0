Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD8246AC
	for <lists+dmaengine@lfdr.de>; Tue, 21 May 2019 06:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbfEUESc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 May 2019 00:18:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbfEUESc (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 21 May 2019 00:18:32 -0400
Received: from localhost (unknown [106.201.107.13])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DBFE2054F;
        Tue, 21 May 2019 04:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558412311;
        bh=fZXYRkAeFGnA+NIcHyTm3OTAcMXVrInGSq8PaIKCbfU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gX6Ml98y6y0nRsMKLAHlU0I3dsJDEzjTVwyPtbbi3XRSvNeXbVqEiOUIm88LhtgJ9
         sBZGVJZwG1HRd01ExEXA55n4aGYPZg6QQ8BS4JFT63ckZ3VRTz5URCjwpSuJU489ta
         gP9Ce2v5NGuNUcsmEWbptEeJnstmc+czndaqlrLo=
Date:   Tue, 21 May 2019 09:48:28 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 11/14] dmaengine: imx-sdma: fix ecspi1 rx dma not work
 on i.mx8mm
Message-ID: <20190521041828.GG15118@vkoul-mobl>
References: <1557249513-4903-1-git-send-email-yibin.gong@nxp.com>
 <1557249513-4903-12-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1557249513-4903-12-git-send-email-yibin.gong@nxp.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-05-19, 09:16, Robin Gong wrote:
> Because the number of ecspi1 rx event on i.mx8mm is 0, the condition
> check ignore such special case without dma channel enabled, which caused
> ecspi1 rx works failed. Actually, no need to check event_id0, checking
> event_id1 is enough for DEV_2_DEV case because it's so lucky that event_id1
> never be 0.

Well is that by chance or design that event_id1 will be never 0?

> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/imx-sdma.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index a495c7f..86594fc 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1370,8 +1370,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
>  
>  	sdma_channel_synchronize(chan);
>  
> -	if (sdmac->event_id0)
> -		sdma_event_disable(sdmac, sdmac->event_id0);
> +	sdma_event_disable(sdmac, sdmac->event_id0);
> +
>  	if (sdmac->event_id1)
>  		sdma_event_disable(sdmac, sdmac->event_id1);
>  
> @@ -1670,11 +1670,9 @@ static int sdma_config(struct dma_chan *chan,
>  	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
>  
>  	/* Set ENBLn earlier to make sure dma request triggered after that */
> -	if (sdmac->event_id0) {
> -		if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
> -			return -EINVAL;
> -		sdma_event_enable(sdmac, sdmac->event_id0);
> -	}
> +	if (sdmac->event_id0 >= sdmac->sdma->drvdata->num_events)
> +		return -EINVAL;
> +	sdma_event_enable(sdmac, sdmac->event_id0);
>  
>  	if (sdmac->event_id1) {
>  		if (sdmac->event_id1 >= sdmac->sdma->drvdata->num_events)
> -- 
> 2.7.4
> 

-- 
~Vinod
