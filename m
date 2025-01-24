Return-Path: <dmaengine+bounces-4181-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70ADAA1B109
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 08:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A2316C2B2
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 07:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2431DB151;
	Fri, 24 Jan 2025 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IobD++/k"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8A513AC1;
	Fri, 24 Jan 2025 07:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737704514; cv=none; b=BVSbB+8WTvnF4jPHW1ogSjyWx/oWNiJhwgLfUOutm6stEqYLfQUcEJrNgcE/eB/j3RYggRFNZ8KZpteXVCrlB080fDK2uJlHZ82IetfrI6HyDxy+V7xkxkCx4mGQ5oxt4WvT2JIbgun5tm+C+rRRjUYJUj59jLZOUjeIfhpUAc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737704514; c=relaxed/simple;
	bh=LtGQ9GcNCChAuCNN8eFZIdvn5KWY2sYQU1DJBy1zg8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oq9O5SUtALxNG4aRMLj2TNxYvXDCHF8dCGSexsZpqwlfexJ/scRCyCbOBdK9nQ6nVd3AayTfhtBhVibSel/T9Xab0UbfT2VA+fREYBwUEBuzTERGFfDu6hVNo08fdAwZiKk+9fMuYgoZzBAbkISVyaRl1nd4y4xosroYhdeDMU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IobD++/k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1A40C4CED2;
	Fri, 24 Jan 2025 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737704514;
	bh=LtGQ9GcNCChAuCNN8eFZIdvn5KWY2sYQU1DJBy1zg8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IobD++/kJMHhE4BEWOcV0oTBgxhJE9JMVGJHCK+3qARoBDFr3qSYJORtpGSeql49g
	 peGjHQsJ7el/raIFAAcJzggnye8Nc65BIT7bRQT1O/dqSmS3cmiudzmRmmXPQ6h+HE
	 x5DLaD13QlPAWgbpNI0gNI2+cpinWM6Fr1rNXl/0YWfRH5TTSwMArj/bCdjFbrOtVP
	 SqM7JCcdkps27loG94kMnokBOh6acXhFla7jA6CnoLPF7gDMfakKXfU0uMHrBP/4Q+
	 UuPf+fmo3CaNgbulAlZLGjEcK4jyxaWerl8jgXLJ+EFy9h1VCMuVcyJV32KrhXdfyR
	 gyxT+ZCttLfsw==
Date: Fri, 24 Jan 2025 13:11:39 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Michal Simek <michal.simek@amd.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v2 1/2] dmaengine: Use str_enable_disable-like helpers
Message-ID: <20250124074139.oa3zvdehgi5366nn@thinkpad>
References: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250114191021.854080-1-krzysztof.kozlowski@linaro.org>

On Tue, Jan 14, 2025 at 08:10:20PM +0100, Krzysztof Kozlowski wrote:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> #dw-edma

- Mani

> 
> ---
> 
> Changes in v2:
> 1. Also drivers/dma/dw-edma/dw-edma-core.c and drivers/dma/sun6i-dma.c
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 6 ++++--
>  drivers/dma/imx-dma.c              | 3 ++-
>  drivers/dma/pxa_dma.c              | 4 ++--
>  drivers/dma/sun6i-dma.c            | 3 ++-
>  drivers/dma/ti/edma.c              | 3 ++-
>  drivers/dma/xilinx/xilinx_dma.c    | 3 ++-
>  6 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 68236247059d..c2b88cc99e5d 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -15,6 +15,7 @@
>  #include <linux/irq.h>
>  #include <linux/dma/edma.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/string_choices.h>
>  
>  #include "dw-edma-core.h"
>  #include "dw-edma-v0-core.h"
> @@ -746,7 +747,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		chan->ll_max -= 1;
>  
>  		dev_vdbg(dev, "L. List:\tChannel %s[%u] max_cnt=%u\n",
> -			 chan->dir == EDMA_DIR_WRITE ? "write" : "read",
> +			 str_write_read(chan->dir == EDMA_DIR_WRITE),
>  			 chan->id, chan->ll_max);
>  
>  		if (dw->nr_irqs == 1)
> @@ -767,7 +768,8 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>  		memcpy(&chan->msi, &irq->msi, sizeof(chan->msi));
>  
>  		dev_vdbg(dev, "MSI:\t\tChannel %s[%u] addr=0x%.8x%.8x, data=0x%.8x\n",
> -			 chan->dir == EDMA_DIR_WRITE  ? "write" : "read", chan->id,
> +			 str_write_read(chan->dir == EDMA_DIR_WRITE),
> +			 chan->id,
>  			 chan->msi.address_hi, chan->msi.address_lo,
>  			 chan->msi.data);
>  
> diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
> index a651e0995ce8..de8d7070904e 100644
> --- a/drivers/dma/imx-dma.c
> +++ b/drivers/dma/imx-dma.c
> @@ -17,6 +17,7 @@
>  #include <linux/device.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  #include <linux/platform_device.h>
>  #include <linux/clk.h>
>  #include <linux/dmaengine.h>
> @@ -942,7 +943,7 @@ static struct dma_async_tx_descriptor *imxdma_prep_dma_interleaved(
>  		"   src_sgl=%s dst_sgl=%s numf=%zu frame_size=%zu\n", __func__,
>  		imxdmac->channel, (unsigned long long)xt->src_start,
>  		(unsigned long long) xt->dst_start,
> -		xt->src_sgl ? "true" : "false", xt->dst_sgl ? "true" : "false",
> +		str_true_false(xt->src_sgl), str_true_false(xt->dst_sgl),
>  		xt->numf, xt->frame_size);
>  
>  	if (list_empty(&imxdmac->ld_free) ||
> diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
> index e50cf3357e5e..249296389771 100644
> --- a/drivers/dma/pxa_dma.c
> +++ b/drivers/dma/pxa_dma.c
> @@ -10,6 +10,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  #include <linux/dmaengine.h>
>  #include <linux/platform_device.h>
>  #include <linux/device.h>
> @@ -277,8 +278,7 @@ static int chan_state_show(struct seq_file *s, void *p)
>  	seq_printf(s, "\tPriority : %s\n",
>  			  str_prio[(phy->idx & 0xf) / 4]);
>  	seq_printf(s, "\tUnaligned transfer bit: %s\n",
> -			  _phy_readl_relaxed(phy, DALGN) & BIT(phy->idx) ?
> -			  "yes" : "no");
> +			  str_yes_no(_phy_readl_relaxed(phy, DALGN) & BIT(phy->idx)));
>  	seq_printf(s, "\tDCSR  = %08x (%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s)\n",
>  		   dcsr, PXA_DCSR_STR(RUN), PXA_DCSR_STR(NODESC),
>  		   PXA_DCSR_STR(STOPIRQEN), PXA_DCSR_STR(EORIRQEN),
> diff --git a/drivers/dma/sun6i-dma.c b/drivers/dma/sun6i-dma.c
> index 95ecb12caaa5..2215ff877bf7 100644
> --- a/drivers/dma/sun6i-dma.c
> +++ b/drivers/dma/sun6i-dma.c
> @@ -19,6 +19,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  #include <linux/types.h>
>  
>  #include "virt-dma.h"
> @@ -553,7 +554,7 @@ static irqreturn_t sun6i_dma_interrupt(int irq, void *dev_id)
>  			continue;
>  
>  		dev_dbg(sdev->slave.dev, "DMA irq status %s: 0x%x\n",
> -			i ? "high" : "low", status);
> +			str_high_low(i), status);
>  
>  		writel(status, sdev->base + DMA_IRQ_STAT(i));
>  
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 4ece125b2ae7..b1a54655e6ce 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -16,6 +16,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/string_choices.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
>  #include <linux/of_irq.h>
> @@ -2047,7 +2048,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
>  	dev_dbg(dev, "num_qchannels: %u\n", ecc->num_qchannels);
>  	dev_dbg(dev, "num_slots: %u\n", ecc->num_slots);
>  	dev_dbg(dev, "num_tc: %u\n", ecc->num_tc);
> -	dev_dbg(dev, "chmap_exist: %s\n", ecc->chmap_exist ? "yes" : "no");
> +	dev_dbg(dev, "chmap_exist: %s\n", str_yes_no(ecc->chmap_exist));
>  
>  	/* Nothing need to be done if queue priority is provided */
>  	if (pdata->queue_priority_mapping)
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 108a7287f4cd..3ad44afd0e74 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -46,6 +46,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> +#include <linux/string_choices.h>
>  #include <linux/clk.h>
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  
> @@ -2940,7 +2941,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
>  			    XILINX_DMA_DMASR_SG_MASK)
>  			chan->has_sg = true;
>  		dev_dbg(chan->dev, "ch %d: SG %s\n", chan->id,
> -			chan->has_sg ? "enabled" : "disabled");
> +			str_enabled_disabled(chan->has_sg));
>  	}
>  
>  	/* Initialize the tasklet */
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

