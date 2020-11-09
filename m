Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364862AB3C8
	for <lists+dmaengine@lfdr.de>; Mon,  9 Nov 2020 10:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgKIJm0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 9 Nov 2020 04:42:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:57962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726176AbgKIJm0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 9 Nov 2020 04:42:26 -0500
Received: from localhost (unknown [122.171.147.34])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31AD6206ED;
        Mon,  9 Nov 2020 09:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604914945;
        bh=fGiC/wbOBVU/AIOKWAxFLakzSHrWCDlxgTiGvnuZ/TI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eN1hCtJW2VkfLcUCkPpeMKwdskJycrGuHy0CVHKmtxoTE3JHotoSw2A8ztqfb095D
         w6c/R++kyzARnscqdJgWfaYcGc4pl+0AJiGustQhCa0GY5lffoXvmjkPWhvtDfVC1J
         Kpx0QcUoBFtEDj1S1iZCGq8Zc1uOolPq+azaAUlg=
Date:   Mon, 9 Nov 2020 15:12:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sia Jee Heng <jee.heng.sia@intel.com>
Cc:     Eugeniy.Paltsev@synopsys.com, andriy.shevchenko@linux.intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 07/15] dmaegine: dw-axi-dmac: Support
 device_prep_dma_cyclic()
Message-ID: <20201109094216.GC3171@vkoul-mobl>
References: <20201027063858.4877-1-jee.heng.sia@intel.com>
 <20201027063858.4877-8-jee.heng.sia@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027063858.4877-8-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 27-10-20, 14:38, Sia Jee Heng wrote:
> Add support for device_prep_dma_cyclic() callback function to benefit
> DMA cyclic client, for example ALSA.
> 
> Existing AxiDMA driver only support data transfer between memory to memory.
> Data transfer between device to memory and memory to device in cyclic mode
> would failed if this interface is not supported by the AxiDMA driver.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
> ---
>  .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 182 +++++++++++++++++-
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |   2 +
>  2 files changed, 177 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 1124c97025f2..9e574753aaf0 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -15,6 +15,8 @@
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> @@ -575,6 +577,135 @@ dma_chan_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst_adr,
>  	return NULL;
>  }
>  
> +static struct dma_async_tx_descriptor *
> +dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
> +			    size_t buf_len, size_t period_len,
> +			    enum dma_transfer_direction direction,
> +			    unsigned long flags)
> +{
> +	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> +	u32 data_width = BIT(chan->chip->dw->hdata->m_data_width);
> +	struct axi_dma_hw_desc *hw_desc = NULL;
> +	struct axi_dma_desc *desc = NULL;
> +	dma_addr_t src_addr = dma_addr;
> +	u32 num_periods = buf_len / period_len;
> +	unsigned int reg_width;
> +	unsigned int mem_width;
> +	dma_addr_t reg;
> +	unsigned int i;
> +	u32 ctllo, ctlhi;
> +	size_t block_ts;
> +	u64 llp = 0;
> +	u8 lms = 0; /* Select AXI0 master for LLI fetching */
> +
> +	block_ts = chan->chip->dw->hdata->block_size[chan->id];
> +
> +	mem_width = __ffs(data_width | dma_addr | period_len);
> +	if (mem_width > DWAXIDMAC_TRANS_WIDTH_32)
> +		mem_width = DWAXIDMAC_TRANS_WIDTH_32;
> +
> +	desc = axi_desc_alloc(num_periods);
> +	if (unlikely(!desc))
> +		goto err_desc_get;
> +
> +	chan->direction = direction;
> +	desc->chan = chan;
> +	chan->cyclic = true;
> +
> +	switch (direction) {
> +	case DMA_MEM_TO_DEV:
> +		reg_width = __ffs(chan->config.dst_addr_width);
> +		reg = chan->config.dst_addr;
> +		ctllo = reg_width << CH_CTL_L_DST_WIDTH_POS |
> +			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_DST_INC_POS |
> +			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS;
> +		break;
> +	case DMA_DEV_TO_MEM:
> +		reg_width = __ffs(chan->config.src_addr_width);
> +		reg = chan->config.src_addr;
> +		ctllo = reg_width << CH_CTL_L_SRC_WIDTH_POS |
> +			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
> +			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_SRC_INC_POS;
> +		break;
> +	default:
> +		return NULL;
> +	}
> +
> +	for (i = 0; i < num_periods; i++) {
> +		hw_desc = &desc->hw_desc[i];
> +
> +		hw_desc->lli = axi_desc_get(chan, &hw_desc->llp);
> +		if (unlikely(!hw_desc->lli))
> +			goto err_desc_get;
> +
> +		if (direction == DMA_MEM_TO_DEV)
> +			block_ts = period_len >> mem_width;
> +		else
> +			block_ts = period_len >> reg_width;
> +
> +		ctlhi = CH_CTL_H_LLI_VALID;
> +		if (chan->chip->dw->hdata->restrict_axi_burst_len) {
> +			u32 burst_len = chan->chip->dw->hdata->axi_rw_burst_len;
> +
> +			ctlhi |= (CH_CTL_H_ARLEN_EN |
> +				burst_len << CH_CTL_H_ARLEN_POS |
> +				CH_CTL_H_AWLEN_EN |
> +				burst_len << CH_CTL_H_AWLEN_POS);
> +		}
> +
> +		hw_desc->lli->ctl_hi = cpu_to_le32(ctlhi);
> +
> +		if (direction == DMA_MEM_TO_DEV)
> +			ctllo |= mem_width << CH_CTL_L_SRC_WIDTH_POS;
> +		else
> +			ctllo |= mem_width << CH_CTL_L_DST_WIDTH_POS;
> +
> +		if (direction == DMA_MEM_TO_DEV) {
> +			write_desc_sar(hw_desc, src_addr);
> +			write_desc_dar(hw_desc, reg);
> +		} else {
> +			write_desc_sar(hw_desc, reg);
> +			write_desc_dar(hw_desc, src_addr);
> +		}
> +
> +		hw_desc->lli->block_ts_lo = cpu_to_le32(block_ts - 1);
> +
> +		ctllo |= (DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_DST_MSIZE_POS |
> +			  DWAXIDMAC_BURST_TRANS_LEN_4 << CH_CTL_L_SRC_MSIZE_POS);
> +		hw_desc->lli->ctl_lo = cpu_to_le32(ctllo);
> +
> +		set_desc_src_master(hw_desc);
> +
> +		/*
> +		 * Set end-of-link to the linked descriptor, so that cyclic
> +		 * callback function can be triggered during interrupt.
> +		 */
> +		set_desc_last(hw_desc);
> +
> +		src_addr += period_len;
> +	}

apart from this bit and use of periods instead of sg_list this seems
very similar to slave handler, so can you please move common bits to
helpers and remove/reduce duplicate code

-- 
~Vinod
