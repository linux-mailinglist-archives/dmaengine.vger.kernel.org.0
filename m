Return-Path: <dmaengine+bounces-7847-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD4CD1D3B
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 21:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DFDA30919BA
	for <lists+dmaengine@lfdr.de>; Fri, 19 Dec 2025 20:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952C2C237C;
	Fri, 19 Dec 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltf9RS8L"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B002285050;
	Fri, 19 Dec 2025 20:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177211; cv=none; b=dOVmdrt00C1H/UDDJt8TN5CiL/YDym8uGNtaYqTfO0UXhc0hngS46otF8Xsr9luhFAvyHx4hko+U637WEUdv3QnygEwbSZq0XrPGmmjo/iBO6KigMdmOOe5oEWt0TcEtVpqf+ZDAp39ofxjP6opXgcyihkSUK6rjc6Gym6ao/PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177211; c=relaxed/simple;
	bh=0Y5COcOrBLsb3bpkPGzZ6E8rXuCIi8bvW5iM5MYgSFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1xwqoZ7EB4PtZqv8guzNwL23o3SwKQTPczIB5uwrs7iCto4p7omYvStb7UbxT+1NOM8MRmxQ+0tkYTz/JWNYtOsalXe7pboSG3Hpwj1dNl9n1zbAvXov8QhIVepcvs00V9V3ZW60bGIM3atVVPManYfw1Pr+yKWf9YTVjCgHNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltf9RS8L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3982C4CEF1;
	Fri, 19 Dec 2025 20:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766177211;
	bh=0Y5COcOrBLsb3bpkPGzZ6E8rXuCIi8bvW5iM5MYgSFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ltf9RS8LUmYwWhqphRhmzUxBA4KUYqXHxiO+Zj3zyY736SI3x57xvcSHW2lmA4pOa
	 TbthJcCOc/NO4kP8fJyh9VVFDTbxlpmjrLZZox3uJn3W8c4I4SRkOsDkLEMXujJMFg
	 /aYKuydIra0gI7JdzsrYJCcjdYbQbpO/6VIxbZRTQwaC9kTtzVON/yht++ih5cHu+2
	 9hB1vWLKnr/PztXWjqGLNSJa7wiFrdhFj9xDZsZlBZu0/6CZ12nIjWPM+hgYBrMQBe
	 GrHimrOxZZ4dysyUUCq+PNPtSgV25jeFk5QIeVeQvVMMuZn6YgWkT677HxBDcYZhMN
	 BnwVb7ACfkGyQ==
Date: Fri, 19 Dec 2025 14:46:49 -0600
From: Rob Herring <robh@kernel.org>
To: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] dma: dw-axi-dmac: Add support for Agilex5 and
 dynamic bus width
Message-ID: <20251219204649.GA3902569-robh@kernel.org>
References: <cover.1765845252.git.khairul.anuar.romli@altera.com>
 <bce96511426a3c63d32530e359c7d966a7321679.1765845252.git.khairul.anuar.romli@altera.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bce96511426a3c63d32530e359c7d966a7321679.1765845252.git.khairul.anuar.romli@altera.com>

On Wed, Dec 17, 2025 at 07:26:18AM +0800, Khairul Anuar Romli wrote:
> Add device tree compatible string support for the Altera Agilex5 AXI DMA
> controller.
> 
> Use common get "dma-ranges" property and calculate the actual number of
> addressable bits (bus width) for the DMA engine. This calculated value is
> then used to set the coherent mask via 'dma_set_mask_and_coherent()',
> allowing the driver to correctly handle devices with bus widths less than
> 64 bits. Initialize the addressable bits default to 64 if 'dma-ranges' is
> not specified or cannot be parsed.
> 
> Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
> ---
> Changes in v4:
> 	- Simplify the code to use common code to get dma ranges.
> 	- Narrow the code changes on hw_init.
> Changes in v3:
> 	- Refactor the code to align with dma controller device node move
> 	  to 1 level down.
> Changes in v2:
> 	- Add driver implementation to set the DMA BIT MAST to 40 based on
> 	  dma-ranges defined in DT.
> 	- Add glue for driver and DT.
> ---
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 16 +++++++++++++++-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index b23536645ff7..ac67c18a05c0 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -12,6 +12,7 @@
>  #include <linux/device.h>
>  #include <linux/dmaengine.h>
>  #include <linux/dmapool.h>
> +#include <linux/dma-direct.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> @@ -264,14 +265,25 @@ static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
>  
>  static void axi_dma_hw_init(struct axi_dma_chip *chip)
>  {
> +	const struct bus_dma_region *map = NULL;
> +	unsigned int addressable_bits = 64;
>  	int ret;
> +	u64 max_bus;
>  	u32 i;
>  
>  	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
>  		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
>  		axi_chan_disable(&chip->dw->chan[i]);
>  	}
> -	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
> +
> +	ret = of_dma_get_range(chip->dev->of_node, &map);
> +	if (!ret) {
> +		max_bus = map->dma_start + map->size - 1;
> +		addressable_bits = fls64(max_bus);
> +	}
> +
> +	dev_dbg(chip->dev, "Addressable bus width: %u\n", addressable_bits);
> +	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(addressable_bits));

I'm pretty sure you don't need to do any of this. The core will merge 
the device's mask with the bus ranges.

Rob

