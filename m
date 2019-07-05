Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF9D060657
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2019 15:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfGENIm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 5 Jul 2019 09:08:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727926AbfGENIm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 5 Jul 2019 09:08:42 -0400
Received: from localhost (unknown [49.207.59.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8040221850;
        Fri,  5 Jul 2019 13:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562332121;
        bh=c7ZjospZn7C+9IObyG5+YgtRu1rpbIjGxKOyHxzfJs4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OsF6ydViPQHicAOKb52FuUmF7jBh+WPj7cwglF6ot89NBIZtOZrmvKxEwLeO3bREW
         L4V1ZkJE/m51bihUTx22/XZff/rfsBeX/4FuiY1OCZ7/WNwda2lR2QOH19h+TWmMOJ
         3sST//+pzopplNgcOzC26TSaOsmZe9XsaJ0CndHU=
Date:   Fri, 5 Jul 2019 18:35:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
        Sameer Pujar <spujar@nvidia.com>
Subject: Re: [RESEND PATCH] dmaengine: tegra210-adma: Don't program FIFO
 threshold
Message-ID: <20190705130531.GE2911@vkoul-mobl>
References: <20190705091557.726-1-jonathanh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190705091557.726-1-jonathanh@nvidia.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 05-07-19, 10:15, Jon Hunter wrote:
> From: Jonathan Hunter <jonathanh@nvidia.com>
> 
> The Tegra210 ADMA supports two modes for transferring data to a FIFO
> which are ...
> 
> 1. Transfer data to/from the FIFO as soon as a single burst can be
>    transferred.
> 2. Transfer data to/from the FIFO based upon FIFO thresholds, where
>    the FIFO threshold is specified in terms on multiple bursts.
> 
> Currently, the ADMA driver programs the FIFO threshold values in the
> FIFO_CTRL register, but never enables the transfer mode that uses
> these threshold values. Given that these have never been used so far,
> simplify the ADMA driver by removing the programming of these threshold
> values.
> 
> Signed-off-by: Jonathan Hunter <jonathanh@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> 
> Resending the patch rebased on top next-20190704. I have added Thierry's
> ACK as well.

Thanks but this fails as well. I had applied few tegra patches so I
suspect that is causing issues now. It would have been nice to have them
in series.

Would you rebase on
git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next (yeah
this is different location, i dont see to push to infradead today)

Thanks 

> 
>  drivers/dma/tegra210-adma.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/dma/tegra210-adma.c b/drivers/dma/tegra210-adma.c
> index 2805853e963f..d8646a49ba5b 100644
> --- a/drivers/dma/tegra210-adma.c
> +++ b/drivers/dma/tegra210-adma.c
> @@ -42,12 +42,8 @@
>  #define ADMA_CH_CONFIG_MAX_BUFS				8
>  
>  #define ADMA_CH_FIFO_CTRL				0x2c
> -#define TEGRA210_ADMA_CH_FIFO_CTRL_OFLWTHRES(val)	(((val) & 0xf) << 24)
> -#define TEGRA210_ADMA_CH_FIFO_CTRL_STRVTHRES(val)	(((val) & 0xf) << 16)
>  #define TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0xf) << 8)
>  #define TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0xf)
> -#define TEGRA186_ADMA_CH_FIFO_CTRL_OFLWTHRES(val)	(((val) & 0x1f) << 24)
> -#define TEGRA186_ADMA_CH_FIFO_CTRL_STRVTHRES(val)	(((val) & 0x1f) << 16)
>  #define TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(val)		(((val) & 0x1f) << 8)
>  #define TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(val)		((val) & 0x1f)
>  
> @@ -64,14 +60,10 @@
>  
>  #define TEGRA_ADMA_BURST_COMPLETE_TIME			20
>  
> -#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_OFLWTHRES(1) | \
> -				    TEGRA210_ADMA_CH_FIFO_CTRL_STRVTHRES(1) | \
> -				    TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
> +#define TEGRA210_FIFO_CTRL_DEFAULT (TEGRA210_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
>  				    TEGRA210_ADMA_CH_FIFO_CTRL_RXSIZE(3))
>  
> -#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_OFLWTHRES(1) | \
> -				    TEGRA186_ADMA_CH_FIFO_CTRL_STRVTHRES(1) | \
> -				    TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3)    | \
> +#define TEGRA186_FIFO_CTRL_DEFAULT (TEGRA186_ADMA_CH_FIFO_CTRL_TXSIZE(3) | \
>  				    TEGRA186_ADMA_CH_FIFO_CTRL_RXSIZE(3))
>  
>  #define ADMA_CH_REG_FIELD_VAL(val, mask, shift)	(((val) & mask) << shift)
> -- 
> 2.17.1

-- 
~Vinod
