Return-Path: <dmaengine+bounces-7570-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA5DCB65EC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 16:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5617B3009FAC
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 15:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 033FF309DC4;
	Thu, 11 Dec 2025 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8/XOWW0"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9A9156C6A;
	Thu, 11 Dec 2025 15:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765467927; cv=none; b=anZ5htEx4N3lBeZT3U1SKgcOWzBAXVOEDKCxWl7aQH+iqZbUYDU3ZlpII/RDgmfa2TG7Y4wysqmOlQTsw6ERx8iIfo7jK0J3hBeFlolWACQAYDyW8X2wmMRtkSE9Hsw/jxLFeVVqhdNHXmKJJVjJ6yUOzZJ/aMESUTLRVBzomAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765467927; c=relaxed/simple;
	bh=ys69TbqqLGQvb/QhtpVnlWfeIEiZPZpLfhH2yduie/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CZs3diqD6NhRr8eoj71e2vyPQxHyX4OjT1/ABJgD1zCtiot7XtcAXRaQDeM+UnrC9/tPB1sJRPaEQy9cNWxsHyBkDGFW6dYveBFDye07hQhVgjkrZIVYGYCMIqDByvVRGhU5ionT18tBPr8b2aX7eLqwoDHz4Us4t4RUoLGkHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8/XOWW0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E18C4CEF7;
	Thu, 11 Dec 2025 15:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765467927;
	bh=ys69TbqqLGQvb/QhtpVnlWfeIEiZPZpLfhH2yduie/A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8/XOWW0eNFfCNv2XSfvainqYChu6S6VKQnNPD1v0Lmkdnhtb87PYEwHe/fVG7XxW
	 6gorputLCoFAqA1BNNHeEw0LIaLwwPg32z6WDOVpN1Rg3p6k8XW5jjUKQV4XfE+YGa
	 yTlIfv1xYdO7ee7vdRe4XGX53Gvqal0EZ11phUDZmGkXdm1pq5Lw/iEU1cMDR3SBi9
	 hrmutyyIx9FMUG2oAUebkALTyGSkayUyjmjmSpd2GyrY82PG5ECgKeZYnaojPptFNE
	 uthl+PSuNxFaQeLz7NAWSPmfzf87WcZzuvjPqN+N37Ie+g3WvI1EmBfLYz38SJ9oXq
	 gEXU5nE1UCSeg==
Date: Thu, 11 Dec 2025 09:45:24 -0600
From: Rob Herring <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
Message-ID: <20251211154524.GA1464056-robh@kernel.org>
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
 <646113c742278626c8796d8553cdb251a4daf737.1765425415.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646113c742278626c8796d8553cdb251a4daf737.1765425415.git.khairul.anuar.romli@altera.com>

On Thu, Dec 11, 2025 at 12:40:38PM +0800, Khairul Anuar Romli wrote:
> Add device tree compatible string support for the Altera Agilex5 AXI DMA
> controller.
> 
> Introduces logic to parse the "dma-ranges" property and calculate the
> actual number of addressable bits (bus width) for the DMA engine. This
> calculated value is then used to set the coherent mask via
> 'dma_set_mask_and_coherent()', allowing the driver to correctly handle
> devices with bus widths less than 64 bits. The addressable bits default to
> 64 if 'dma-ranges' is not specified or cannot be parsed.
> 
> Introduce 'addressable_bits' to 'struct axi_dma_chip' to store this value.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v3:
> 	- Refactor the code to align with dma controller device node move
> 	  to 1 level down.
> Changes in v2:
> 	- Add driver implementation to set the DMA BIT MAST to 40 based on
> 	  dma-ranges defined in DT.
> 	- Add glue for driver and DT.
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 69 ++++++++++++++++++-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  1 +
>  2 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index b23536645ff7..96b0a0842ff5 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -271,7 +271,9 @@ static void axi_dma_hw_init(struct axi_dma_chip *chip)
>  		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
>  		axi_chan_disable(&chip->dw->chan[i]);
>  	}
> -	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
> +
> +	dev_dbg(chip->dev, "Adressable bus width: %u\n", chip->addressable_bits);
> +	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(chip->addressable_bits));
>  	if (ret)
>  		dev_warn(chip->dev, "Unable to set coherent mask\n");
>  }
> @@ -1461,13 +1463,24 @@ static int axi_req_irqs(struct platform_device *pdev, struct axi_dma_chip *chip)
>  	return 0;
>  }
>  
> +/* Forward declaration (no size required) */
> +static const struct of_device_id dw_dma_of_id_table[];
> +
>  static int dw_probe(struct platform_device *pdev)
>  {
>  	struct axi_dma_chip *chip;
>  	struct dw_axi_dma *dw;
>  	struct dw_axi_dma_hcfg *hdata;
>  	struct reset_control *resets;
> +	struct device_node *parent;
> +	const struct of_device_id *match;
>  	unsigned int flags;
> +	unsigned int addressable_bits = 64;
> +	unsigned int len_bytes;
> +	unsigned int num_cells;
> +	const __be32 *prop;
> +	u64 bus_width;
> +	u32 *cells;
>  	u32 i;
>  	int ret;
>  
> @@ -1483,9 +1496,61 @@ static int dw_probe(struct platform_device *pdev)
>  	if (!hdata)
>  		return -ENOMEM;
>  
> +	match = of_match_node(dw_dma_of_id_table, pdev->dev.of_node);
> +	if (!match) {
> +		dev_err(&pdev->dev, "Unsupported AXI DMA device\n");
> +		return -ENODEV;
> +	}
> +
> +	parent = of_get_parent(pdev->dev.of_node);
> +	if (parent) {
> +		prop = of_get_property(parent, "dma-ranges", &len_bytes);
> +		if (prop) {
> +			num_cells = len_bytes / sizeof(__be32);
> +			cells = kcalloc(num_cells, sizeof(*cells), GFP_KERNEL);
> +			if (!cells)
> +				return -ENOMEM;
> +
> +			ret = of_property_read_u32(parent, "#address-cells", &i);
> +			if (ret) {
> +				dev_err(&pdev->dev, "missing #address-cells property\n");
> +				return ret;
> +			}
> +
> +			ret = of_property_read_u32(parent, "#size-cells", &i);
> +			if (ret) {
> +				dev_err(&pdev->dev, "missing #size-cells property\n");
> +				return ret;
> +			}
> +
> +			if (!of_property_read_u32_array(parent, "dma-ranges",
> +							cells, num_cells)) {

We have common code to parse dma-ranges. Use it and don't implement your 
own.

Rob

