Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5172D2C7211
	for <lists+dmaengine@lfdr.de>; Sat, 28 Nov 2020 23:05:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732596AbgK1Vum (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 28 Nov 2020 16:50:42 -0500
Received: from foss.arm.com ([217.140.110.172]:37658 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387707AbgK1Ucz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sat, 28 Nov 2020 15:32:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6043730E;
        Sat, 28 Nov 2020 12:32:09 -0800 (PST)
Received: from [192.168.2.22] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D7793F23F;
        Sat, 28 Nov 2020 12:32:07 -0800 (PST)
Subject: Re: [RESEND PATCH 05/19] dmaengine: sun6i: Add support for A100 DMA
To:     Frank Lee <frank@allwinnertech.com>, tiny.windzz@gmail.com
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org,
        Jernej Skrabec <jernej.skrabec@siol.net>
References: <cover.1604988979.git.frank@allwinnertech.com>
 <719852c6a9a597bd2e82d01a268ca02b9dee826c.1604988979.git.frank@allwinnertech.com>
From:   =?UTF-8?Q?Andr=c3=a9_Przywara?= <andre.przywara@arm.com>
Organization: ARM Ltd.
Message-ID: <29e575b6-14cb-73f1-512d-9f0f934490ea@arm.com>
Date:   Sat, 28 Nov 2020 20:31:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <719852c6a9a597bd2e82d01a268ca02b9dee826c.1604988979.git.frank@allwinnertech.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10/11/2020 06:28, Frank Lee wrote:

Hi,

> From: Yangtao Li <frank@allwinnertech.com>
> 
> The dma of a100 is similar to h6, with some minor changes to
> support greater addressing capabilities.

So apparently those changes are backwards compatible, right?
Why do we need then a new struct now, when this is actually identical to
the existing H6 one?

So as this seems to work with the same settings as the H6, I think we
don't need any change in the driver at the moment, just using the H6
compatible as a fallback in the .dtsi.

Cheers,
Andre

P.S. I understand that Vinod already applied it, and it doesn't hurt to
have that in at the moment, if we fix the compatible usage.

> 
> Add support for it.>
> Signed-off-by: Yangtao Li <frank@allwinnertech.com>
> ---
>  drivers/dma/sun6i-dma.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index f5f9c86c50bc..5cadd4d2b824 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -1173,6 +1173,30 @@ static struct sun6i_dma_config sun50i_a64_dma_cfg = {
>  			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
>  };
>  
> +/*
> + * TODO: Add support for more than 4g physical addressing.
> + *
> + * The A100 binding uses the number of dma channels from the
> + * device tree node.
> + */
> +static struct sun6i_dma_config sun50i_a100_dma_cfg = {
> +	.clock_autogate_enable = sun6i_enable_clock_autogate_h3,
> +	.set_burst_length = sun6i_set_burst_length_h3,
> +	.set_drq          = sun6i_set_drq_h6,
> +	.set_mode         = sun6i_set_mode_h6,
> +	.src_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.dst_burst_lengths = BIT(1) | BIT(4) | BIT(8) | BIT(16),
> +	.src_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.dst_addr_widths   = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> +			     BIT(DMA_SLAVE_BUSWIDTH_8_BYTES),
> +	.has_mbus_clk = true,
> +};
> +
>  /*
>   * The H6 binding uses the number of dma channels from the
>   * device tree node.
> @@ -1225,6 +1249,7 @@ static const struct of_device_id sun6i_dma_match[] = {
>  	{ .compatible = "allwinner,sun8i-h3-dma", .data = &sun8i_h3_dma_cfg },
>  	{ .compatible = "allwinner,sun8i-v3s-dma", .data = &sun8i_v3s_dma_cfg },
>  	{ .compatible = "allwinner,sun50i-a64-dma", .data = &sun50i_a64_dma_cfg },
> +	{ .compatible = "allwinner,sun50i-a100-dma", .data = &sun50i_a100_dma_cfg },
>  	{ .compatible = "allwinner,sun50i-h6-dma", .data = &sun50i_h6_dma_cfg },
>  	{ /* sentinel */ }
>  };
> 

