Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 518902F2D03
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 11:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbhALKhf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 05:37:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbhALKhf (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 05:37:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FFB3222B3;
        Tue, 12 Jan 2021 10:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610447814;
        bh=me4VfGevELMQ1wDfalFTk9vfIzyJP8ihe4XFq/deiiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hTeCcZWpMjgUUWmh27lAfMaApy1y5vIkzINXhL9py33nYqs2xFaO212lc1zPknXyi
         LbiA04wX8XtKWw6/R1FQbweGMJlzTzUg6vSqrN9kDEAGk3mIZLd+E/z2or+LlrpVNh
         RFM3jDCztHNUkYaM3qAIty5OHFLfzmeWV7b4F9AlW279xR77Np8n7pUTjZV7l8ItWA
         fjnBjbfqCwa0KYqWNg7RrgOuz5TdFiGJs6S60DNJU6fM/RD+But/47aTc/BXGJAVI7
         cJSL2cbmUiEPZzQrJxkNMheSkrsPXzVccm/Ifb80PANMqjjv9OFgO0e19FD9Vs51g3
         hdEidid3tG9YQ==
Date:   Tue, 12 Jan 2021 16:06:48 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Phong Hoang <phong.hoang.wz@renesas.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Message-ID: <20210112103648.GL2771@vkoul-mobl>
References: <20210107181524.1947173-1-geert+renesas@glider.be>
 <20210107181524.1947173-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107181524.1947173-5-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 07-01-21, 19:15, Geert Uytterhoeven wrote:
> The DMACs (both SYS-DMAC and RT-DMAC) on R-Car V3U differ slightly from
> the DMACs on R-Car Gen2 and other R-Car Gen3 SoCs:
>   1. The per-channel registers are located in a second register block.
>      Add support for mapping the second block, using the appropriate
>      offsets and stride.
>   2. The common Channel Clear Register (DMACHCLR) was replaced by a
>      per-channel register.
>      Update rcar_dmac_chan_clear{,_all}() to handle this.
>      As rcar_dmac_init() needs to clear the status before the individual
>      channels are probed, channel index and base address initialization
>      are moved forward.
> 
> Inspired by a patch in the BSP by Phong Hoang
> <phong.hoang.wz@renesas.com>.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/dma/sh/rcar-dmac.c | 68 +++++++++++++++++++++++++++-----------
>  1 file changed, 49 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 990d78849a7de704..c11e6255eba1fc6b 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -189,7 +189,7 @@ struct rcar_dmac_chan {
>   * struct rcar_dmac - R-Car Gen2 DMA Controller
>   * @engine: base DMA engine object
>   * @dev: the hardware device
> - * @iomem: remapped I/O memory base
> + * @iomem: remapped I/O memory bases (second is optional)
>   * @n_channels: number of available channels
>   * @channels: array of DMAC channels
>   * @channels_mask: bitfield of which DMA channels are managed by this driver
> @@ -198,7 +198,7 @@ struct rcar_dmac_chan {
>  struct rcar_dmac {
>  	struct dma_device engine;
>  	struct device *dev;
> -	void __iomem *iomem;
> +	void __iomem *iomem[2];

do you forsee many more memory regions, if not then why not add second
region, that way changes in this patch will be lesser..?

and it would be better to refer to a region by its name rather than
iomem[1]..

-- 
~Vinod
