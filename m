Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 620C13DD0EA
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 09:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbhHBHD6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 03:03:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:32804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229500AbhHBHD5 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 03:03:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF7A60D07;
        Mon,  2 Aug 2021 07:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627887828;
        bh=NKl+nkYf7lr7H2SbcBdWTsOdU4qUqQPTa+Dss6PlQoY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k+DEhCOtrl64l4nIYok+2yIiDF72qLlrpKouaCv4j7Nl5psQeJebwM5h8Dtdilzdl
         b953+/umtsr3qraFzSECT/AH1+saKm7NqCLuR0lS/DCdVPvQ5fLU094jDlW8woKmOp
         tTdpvo5hVt1qc/agzvqxfUkMF9tRAk/daA/qthBSUvCftu5LPNAllv1ajTarEzRXs2
         wpPtyJLpGm+9lreW4JRBijk8PpivFkc8SDhPgH2kJ6jDJcTZBi4tUD+YSYN2F+ECsN
         OXB4XroHWfSC3v3f9OV6ZaT9pCJ5CGVYj9vQ9dcAyMQVrFTafFTV65/ckDtKCEe3fO
         lyCaq5l+ERcKw==
Date:   Mon, 2 Aug 2021 12:33:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Juergen Borleis <jbe@pengutronix.de>
Cc:     dmaengine@vger.kernel.org, linux-imx@nxp.com, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] dma: imx-dma: configure the generic DMA type to make it
 work
Message-ID: <YQeY0E5oRHXkT+TO@matsya>
References: <20210729071821.9857-1-jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729071821.9857-1-jbe@pengutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 29-07-21, 09:18, Juergen Borleis wrote:
> Commit dea7a9f

you should use 12+ chars for sha1 
>   dmaengine: imx-dma: remove dma_slave_config direction usage

even with this is commit log, you made the patch tile dma: ....!
> 
> changes the method from a "configuration when called" to an "configuration
> when used". Due to this, only the cyclic DMA type gets configured
> correctly, while the generic DMA type is left non-configured.
> 
> Without this additional call, the struct imxdma_channel::word_size member
> is stuck at DMA_SLAVE_BUSWIDTH_UNDEFINED and imxdma_prep_slave_sg() always
> returns NULL.

I ahve fixed the subsystem name, updated commit in 12 chars and format
expected, added it as Fixes line and applied.

Please take care of these things!

> 
> Signed-off-by: Juergen Borleis <jbe@pengutronix.de>
> ---
>  drivers/dma/imx-dma.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index 7f116bb..2ddc31e 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -812,6 +812,8 @@ static struct dma_async_tx_descriptor *imxdma_prep_slave_sg(
>  		dma_length += sg_dma_len(sg);
>  	}
>  
> +	imxdma_config_write(chan, &imxdmac->config, direction);
> +
>  	switch (imxdmac->word_size) {
>  	case DMA_SLAVE_BUSWIDTH_4_BYTES:
>  		if (sg_dma_len(sgl) & 3 || sgl->dma_address & 3)
> -- 
> 2.20.1

-- 
~Vinod
