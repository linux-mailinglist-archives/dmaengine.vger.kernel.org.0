Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9CFC5B3C0
	for <lists+dmaengine@lfdr.de>; Mon,  1 Jul 2019 06:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbfGAE5w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 1 Jul 2019 00:57:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfGAE5w (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 1 Jul 2019 00:57:52 -0400
Received: from localhost (unknown [122.167.76.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 059FD208E4;
        Mon,  1 Jul 2019 04:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561957071;
        bh=Xoo66K/G7tcXAmjXGTmitRGCFyxgVt2d479uVZAiUpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1pOjHruXzLwzMCPIasWt3ujiDoE1q3JURU5+mwfNEZTqecdT0+TkspW//60OUJq1m
         1pN5yUlaCNm71cv6rmBxMFtzhyDNEbcINKK0DzXPztRRr1KfIxfy+L5fKF9ZswnzOe
         NIqXYqNIXB2J2Dt/P77Guw+sjH1KU/xS6cTsXEdY=
Date:   Mon, 1 Jul 2019 10:24:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/87] dma: imx-sdma: Remove call to memset after
 dma_alloc_coherent
Message-ID: <20190701045443.GI2911@vkoul-mobl>
References: <20190627173536.2457-1-huangfq.daxian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190627173536.2457-1-huangfq.daxian@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-06-19, 01:35, Fuqian Huang wrote:
>     In commit af7ddd8a627c
> ("Merge tag 'dma-mapping-4.21' of git://git.infradead.org/users/hch/dma-mapping"),
>     dma_alloc_coherent has already zeroed the memory.
>     So memset is not needed.

Please point to the exact commit and not the merge commit. Hint use git
blame on that file...

> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>
> ---
>  drivers/dma/imx-sdma.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 99d9f431ae2c..54d86359bdf8 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -1886,10 +1886,6 @@ static int sdma_init(struct sdma_engine *sdma)
>  	sdma->context_phys = ccb_phys +
>  		MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control);
>  
> -	/* Zero-out the CCB structures array just allocated */
> -	memset(sdma->channel_control, 0,
> -			MAX_DMA_CHANNELS * sizeof (struct sdma_channel_control));
> -
>  	/* disable all channels */
>  	for (i = 0; i < sdma->drvdata->num_events; i++)
>  		writel_relaxed(0, sdma->regs + chnenbl_ofs(sdma, i));
> -- 
> 2.11.0

-- 
~Vinod
