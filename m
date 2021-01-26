Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA6430509B
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 05:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238424AbhA0ERw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Jan 2021 23:17:52 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:57594 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbhAZWBx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 26 Jan 2021 17:01:53 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 68B952C1;
        Tue, 26 Jan 2021 23:01:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1611698469;
        bh=BHmdZYv8ApW4Hf+sURWB/QQiokPoXSvuXZA2UdxlKPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mnE6mk3z0HeahmaHus4994p1XTBWRXS1xkTSLPO8TYlpYt8lcA85Lg2Mn3RZkiGaT
         seKVNeO9oKMjfv+u+SB3Wub6Fgf/APLaeW5svtwREj5Do4Rbn4Crjzs7qcJVbzWwws
         MDvzmALLU4q2UGrhlKOu7N8Hb5IvExQv9iIS43RQ=
Date:   Wed, 27 Jan 2021 00:00:49 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dmaengine: rcar-dmac: Add support for R-Car V3U
Message-ID: <YBCREUMJ0/LgxDlJ@pendragon.ideasonboard.com>
References: <20210125142431.1049668-1-geert+renesas@glider.be>
 <20210125142431.1049668-5-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210125142431.1049668-5-geert+renesas@glider.be>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

Thank you for the patch.

On Mon, Jan 25, 2021 at 03:24:31PM +0100, Geert Uytterhoeven wrote:
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
> v2:
>   - Use two separate named regions instead of an iomem[] array,
>   - Drop rcar_dmac_of_data.chan_reg_block, check for
>     !rcar_dmac_of_data.chan_offset_base instead,
>   - Precalculate chan_base in rcar_dmac_probe().
> ---
>  drivers/dma/sh/rcar-dmac.c | 74 ++++++++++++++++++++++++++++----------
>  1 file changed, 55 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/dma/sh/rcar-dmac.c b/drivers/dma/sh/rcar-dmac.c
> index 7a0f802c61e5152d..d9589eea98083215 100644
> --- a/drivers/dma/sh/rcar-dmac.c
> +++ b/drivers/dma/sh/rcar-dmac.c
> @@ -189,7 +189,8 @@ struct rcar_dmac_chan {
>   * struct rcar_dmac - R-Car Gen2 DMA Controller
>   * @engine: base DMA engine object
>   * @dev: the hardware device
> - * @iomem: remapped I/O memory base
> + * @dmac_base: remapped base register block
> + * @chan_base: remapped channel register block (optional)
>   * @n_channels: number of available channels
>   * @channels: array of DMAC channels
>   * @channels_mask: bitfield of which DMA channels are managed by this driver
> @@ -198,7 +199,8 @@ struct rcar_dmac_chan {
>  struct rcar_dmac {
>  	struct dma_device engine;
>  	struct device *dev;
> -	void __iomem *iomem;
> +	void __iomem *dmac_base;
> +	void __iomem *chan_base;
>  
>  	unsigned int n_channels;
>  	struct rcar_dmac_chan *channels;
> @@ -234,7 +236,7 @@ struct rcar_dmac_of_data {
>  #define RCAR_DMAOR_PRI_ROUND_ROBIN	(3 << 8)
>  #define RCAR_DMAOR_AE			(1 << 2)
>  #define RCAR_DMAOR_DME			(1 << 0)
> -#define RCAR_DMACHCLR			0x0080
> +#define RCAR_DMACHCLR			0x0080	/* Not on R-Car V3U */
>  #define RCAR_DMADPSEC			0x00a0
>  
>  #define RCAR_DMASAR			0x0000
> @@ -297,6 +299,9 @@ struct rcar_dmac_of_data {
>  #define RCAR_DMAFIXDAR			0x0014
>  #define RCAR_DMAFIXDPBASE		0x0060
>  
> +/* For R-Car V3U */
> +#define RCAR_V3U_DMACHCLR		0x0100
> +
>  /* Hardcode the MEMCPY transfer size to 4 bytes. */
>  #define RCAR_DMAC_MEMCPY_XFER_SIZE	4
>  
> @@ -307,17 +312,17 @@ struct rcar_dmac_of_data {
>  static void rcar_dmac_write(struct rcar_dmac *dmac, u32 reg, u32 data)
>  {
>  	if (reg == RCAR_DMAOR)
> -		writew(data, dmac->iomem + reg);
> +		writew(data, dmac->dmac_base + reg);
>  	else
> -		writel(data, dmac->iomem + reg);
> +		writel(data, dmac->dmac_base + reg);
>  }
>  
>  static u32 rcar_dmac_read(struct rcar_dmac *dmac, u32 reg)
>  {
>  	if (reg == RCAR_DMAOR)
> -		return readw(dmac->iomem + reg);
> +		return readw(dmac->dmac_base + reg);
>  	else
> -		return readl(dmac->iomem + reg);
> +		return readl(dmac->dmac_base + reg);
>  }
>  
>  static u32 rcar_dmac_chan_read(struct rcar_dmac_chan *chan, u32 reg)
> @@ -339,12 +344,23 @@ static void rcar_dmac_chan_write(struct rcar_dmac_chan *chan, u32 reg, u32 data)
>  static void rcar_dmac_chan_clear(struct rcar_dmac *dmac,
>  				 struct rcar_dmac_chan *chan)
>  {
> -	rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
> +	if (dmac->chan_base)

Using dmac->chan_base to check if the device is a V3U seems a bit of a
hack (especially given that the field is otherwise unused). I'd prefer
adding a model field to struct rcar_dmac_of_data and struct rcar_dmac.

> +		rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
> +	else
> +		rcar_dmac_write(dmac, RCAR_DMACHCLR, BIT(chan->index));
>  }
>  
>  static void rcar_dmac_chan_clear_all(struct rcar_dmac *dmac)
>  {
> -	rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
> +	struct rcar_dmac_chan *chan;
> +	unsigned int i;
> +
> +	if (dmac->chan_base) {
> +		for_each_rcar_dmac_chan(i, chan, dmac)
> +			rcar_dmac_chan_write(chan, RCAR_V3U_DMACHCLR, 1);
> +	} else {
> +		rcar_dmac_write(dmac, RCAR_DMACHCLR, dmac->channels_mask);
> +	}
>  }
>  
>  /* -----------------------------------------------------------------------------
> @@ -1744,7 +1760,6 @@ static const struct dev_pm_ops rcar_dmac_pm = {
>  
>  static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
>  				struct rcar_dmac_chan *rchan,
> -				const struct rcar_dmac_of_data *data,
>  				unsigned int index)
>  {
>  	struct platform_device *pdev = to_platform_device(dmac->dev);
> @@ -1753,9 +1768,6 @@ static int rcar_dmac_chan_probe(struct rcar_dmac *dmac,
>  	char *irqname;
>  	int ret;
>  
> -	rchan->index = index;
> -	rchan->iomem = dmac->iomem + data->chan_offset_base +
> -		       data->chan_offset_stride * index;
>  	rchan->mid_rid = -EINVAL;
>  
>  	spin_lock_init(&rchan->lock);
> @@ -1842,6 +1854,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  	const struct rcar_dmac_of_data *data;
>  	struct rcar_dmac_chan *chan;
>  	struct dma_device *engine;
> +	void __iomem *chan_base;
>  	struct rcar_dmac *dmac;
>  	unsigned int i;
>  	int ret;
> @@ -1880,9 +1893,24 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	/* Request resources. */
> -	dmac->iomem = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(dmac->iomem))
> -		return PTR_ERR(dmac->iomem);
> +	dmac->dmac_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(dmac->dmac_base))
> +		return PTR_ERR(dmac->dmac_base);
> +
> +	if (!data->chan_offset_base) {
> +		dmac->chan_base = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(dmac->chan_base))
> +			return PTR_ERR(dmac->chan_base);
> +
> +		chan_base = dmac->chan_base;
> +	} else {
> +		chan_base = dmac->dmac_base + data->chan_offset_base;
> +	}
> +
> +	for_each_rcar_dmac_chan(i, chan, dmac) {
> +		chan->index = i;

Now that chan->indew is set before calling rcar_dmac_chan_probe(), you
don't have to pass the index to rcar_dmac_chan_probe() anymore.

> +		chan->iomem = chan_base + i * data->chan_offset_stride;
> +	}
>  
>  	/* Enable runtime PM and initialize the device. */
>  	pm_runtime_enable(&pdev->dev);
> @@ -1929,7 +1957,7 @@ static int rcar_dmac_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&engine->channels);
>  
>  	for_each_rcar_dmac_chan(i, chan, dmac) {
> -		ret = rcar_dmac_chan_probe(dmac, chan, data, i);
> +		ret = rcar_dmac_chan_probe(dmac, chan, i);
>  		if (ret < 0)
>  			goto error;
>  	}
> @@ -1977,14 +2005,22 @@ static void rcar_dmac_shutdown(struct platform_device *pdev)
>  }
>  
>  static const struct rcar_dmac_of_data rcar_dmac_data = {
> -	.chan_offset_base = 0x8000,
> -	.chan_offset_stride = 0x80,
> +	.chan_offset_base	= 0x8000,
> +	.chan_offset_stride	= 0x80,
> +};
> +
> +static const struct rcar_dmac_of_data rcar_v3u_dmac_data = {
> +	.chan_offset_base	= 0x0,
> +	.chan_offset_stride	= 0x1000,
>  };
>  
>  static const struct of_device_id rcar_dmac_of_ids[] = {
>  	{
>  		.compatible = "renesas,rcar-dmac",
>  		.data = &rcar_dmac_data,
> +	}, {
> +		.compatible = "renesas,dmac-r8a779a0",
> +		.data = &rcar_v3u_dmac_data,
>  	},
>  	{ /* Sentinel */ }
>  };

-- 
Regards,

Laurent Pinchart
