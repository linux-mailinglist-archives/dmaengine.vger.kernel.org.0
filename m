Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFAC72F2C6F
	for <lists+dmaengine@lfdr.de>; Tue, 12 Jan 2021 11:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404515AbhALKRZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Jan 2021 05:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbhALKRY (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Jan 2021 05:17:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0016922CA1;
        Tue, 12 Jan 2021 10:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610446603;
        bh=ZKhCWFHvRP+DSfuwSZQvm38nXxRI1BXdQpZP7mIHYjQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hHSEo5oErju2MXdYupAQn0DSWi2PTkCx9X9MGq/+KsoAl8Ww7wpnA7yzyf8ZaXi3V
         i6+FAdlIqzv2h3xcU85IGSbQJfxVyu4XoZ9IDds+6aTxCSGEY3BM29rgWsKR1F0tOt
         fGL7j1X3T8IB4q3IsRWNpCvCkxakUqnHm3wCHYhsrFrFjckj15ia6c1kWkxKL2b7ll
         ciG9yJEPzI3q4K3OzDFdXcSYbxb3ywDdH2eXNC7Wnk0ZFYl/CWpt4x50LaW8sih/6s
         M6yqkWRmdSH19uVDX0365BOh0eX2AxrxuM5dIR9DFNlg8LVtNPNe+hZrQ9ecOubtyu
         HSFX2+D/IiQKw==
Date:   Tue, 12 Jan 2021 15:46:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        dmaengine@vger.kernel.org, vigneshr@ti.com,
        grygorii.strashko@ti.com, kishon@ti.com
Subject: Re: [PATCH 2/2] dmaengine: ti: k3-udma: Add support for burst_size
 configuration for mem2mem
Message-ID: <20210112101637.GJ2771@vkoul-mobl>
References: <20201214081310.10746-1-peter.ujfalusi@ti.com>
 <20201214081310.10746-3-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214081310.10746-3-peter.ujfalusi@ti.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 14-12-20, 10:13, Peter Ujfalusi wrote:
> The UDMA and BCDMA can provide higher throughput if the burst_size of the
> channel is changed from it's default (which is 64 bytes) for Ultra-high
> and high capacity channels.
> 
> This performance benefit is even more visible when the buffers are aligned
> with the burst_size configuration.
> 
> The am654 does not have a way to change the burst size, but it is using
> 64 bytes burst, so increasing the copy_align from 8 bytes to 64 (and
> clients taking that into account) can increase the throughput as well.
> 
> Numbers gathered on j721e:
> echo 8000000 > /sys/module/dmatest/parameters/test_buf_size
> echo 2000 > /sys/module/dmatest/parameters/timeout
> echo 50 > /sys/module/dmatest/parameters/iterations
> echo 1 > /sys/module/dmatest/parameters/max_channels
> 
> Prior this patch:       ~1.3 GB/s
> After this patch:       ~1.8 GB/s
>  with 1 byte alignment: ~1.7 GB/s
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 115 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 110 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 87157cbae1b8..54e4ccb1b37e 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -121,6 +121,11 @@ struct udma_oes_offsets {
>  #define UDMA_FLAG_PDMA_ACC32		BIT(0)
>  #define UDMA_FLAG_PDMA_BURST		BIT(1)
>  #define UDMA_FLAG_TDTYPE		BIT(2)
> +#define UDMA_FLAG_BURST_SIZE		BIT(3)
> +#define UDMA_FLAGS_J7_CLASS		(UDMA_FLAG_PDMA_ACC32 | \
> +					 UDMA_FLAG_PDMA_BURST | \
> +					 UDMA_FLAG_TDTYPE | \
> +					 UDMA_FLAG_BURST_SIZE)
>  
>  struct udma_match_data {
>  	enum k3_dma_type type;
> @@ -128,6 +133,7 @@ struct udma_match_data {
>  	bool enable_memcpy_support;
>  	u32 flags;
>  	u32 statictr_z_mask;
> +	u8 burst_size[3];
>  };
>  
>  struct udma_soc_data {
> @@ -436,6 +442,18 @@ static void k3_configure_chan_coherency(struct dma_chan *chan, u32 asel)
>  	}
>  }
>  
> +static u8 udma_get_chan_tpl_index(struct udma_tpl *tpl_map, int chan_id)
> +{
> +	int i;
> +
> +	for (i = 0; i < tpl_map->levels; i++) {
> +		if (chan_id >= tpl_map->start_idx[i])
> +			return i;
> +	}

Braces seem not required

> +
> +	return 0;
> +}
> +
>  static void udma_reset_uchan(struct udma_chan *uc)
>  {
>  	memset(&uc->config, 0, sizeof(uc->config));
> @@ -1811,6 +1829,7 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
>  	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
>  	struct udma_tchan *tchan = uc->tchan;
>  	struct udma_rchan *rchan = uc->rchan;
> +	u8 burst_size = 0;
>  	int ret = 0;
>  
>  	/* Non synchronized - mem to mem type of transfer */
> @@ -1818,6 +1837,12 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
>  	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
>  	struct ti_sci_msg_rm_udmap_rx_ch_cfg req_rx = { 0 };
>  
> +	if (ud->match_data->flags & UDMA_FLAG_BURST_SIZE) {
> +		u8 tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, tchan->id);

Can we define variable at function start please

> +
> +		burst_size = ud->match_data->burst_size[tpl];
> +	}
> +
>  	req_tx.valid_params = TISCI_UDMA_TCHAN_VALID_PARAMS;
>  	req_tx.nav_id = tisci_rm->tisci_dev_id;
>  	req_tx.index = tchan->id;
> @@ -1825,6 +1850,10 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
>  	req_tx.tx_fetch_size = sizeof(struct cppi5_desc_hdr_t) >> 2;
>  	req_tx.txcq_qnum = tc_ring;
>  	req_tx.tx_atype = ud->atype;
> +	if (burst_size) {
> +		req_tx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_BURST_SIZE_VALID;
> +		req_tx.tx_burst_size = burst_size;
> +	}
>  
>  	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
>  	if (ret) {
> @@ -1839,6 +1868,10 @@ static int udma_tisci_m2m_channel_config(struct udma_chan *uc)
>  	req_rx.rxcq_qnum = tc_ring;
>  	req_rx.rx_chan_type = TI_SCI_RM_UDMAP_CHAN_TYPE_3RDP_BCOPY_PBRR;
>  	req_rx.rx_atype = ud->atype;
> +	if (burst_size) {
> +		req_rx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_BURST_SIZE_VALID;
> +		req_rx.rx_burst_size = burst_size;
> +	}
>  
>  	ret = tisci_ops->rx_ch_cfg(tisci_rm->tisci, &req_rx);
>  	if (ret)
> @@ -1854,12 +1887,23 @@ static int bcdma_tisci_m2m_channel_config(struct udma_chan *uc)
>  	const struct ti_sci_rm_udmap_ops *tisci_ops = tisci_rm->tisci_udmap_ops;
>  	struct ti_sci_msg_rm_udmap_tx_ch_cfg req_tx = { 0 };
>  	struct udma_bchan *bchan = uc->bchan;
> +	u8 burst_size = 0;
>  	int ret = 0;
>  
> +	if (ud->match_data->flags & UDMA_FLAG_BURST_SIZE) {
> +		u8 tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, bchan->id);

here as well

> +
> +		burst_size = ud->match_data->burst_size[tpl];
> +	}
> +
>  	req_tx.valid_params = TISCI_BCDMA_BCHAN_VALID_PARAMS;
>  	req_tx.nav_id = tisci_rm->tisci_dev_id;
>  	req_tx.extended_ch_type = TI_SCI_RM_BCDMA_EXTENDED_CH_TYPE_BCHAN;
>  	req_tx.index = bchan->id;
> +	if (burst_size) {
> +		req_tx.valid_params |= TI_SCI_MSG_VALUE_RM_UDMAP_CH_BURST_SIZE_VALID;
> +		req_tx.tx_burst_size = burst_size;
> +	}
>  
>  	ret = tisci_ops->tx_ch_cfg(tisci_rm->tisci, &req_tx);
>  	if (ret)
> @@ -4167,6 +4211,11 @@ static struct udma_match_data am654_main_data = {
>  	.psil_base = 0x1000,
>  	.enable_memcpy_support = true,
>  	.statictr_z_mask = GENMASK(11, 0),
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* H Channels */
> +		0, /* No UH Channels */
> +	},
>  };
>  
>  static struct udma_match_data am654_mcu_data = {
> @@ -4174,38 +4223,63 @@ static struct udma_match_data am654_mcu_data = {
>  	.psil_base = 0x6000,
>  	.enable_memcpy_support = false,
>  	.statictr_z_mask = GENMASK(11, 0),
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* H Channels */
> +		0, /* No UH Channels */
> +	},
>  };
>  
>  static struct udma_match_data j721e_main_data = {
>  	.type = DMA_TYPE_UDMA,
>  	.psil_base = 0x1000,
>  	.enable_memcpy_support = true,
> -	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
> +	.flags = UDMA_FLAGS_J7_CLASS,
>  	.statictr_z_mask = GENMASK(23, 0),
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES, /* H Channels */
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES, /* UH Channels */
> +	},
>  };
>  
>  static struct udma_match_data j721e_mcu_data = {
>  	.type = DMA_TYPE_UDMA,
>  	.psil_base = 0x6000,
>  	.enable_memcpy_support = false, /* MEM_TO_MEM is slow via MCU UDMA */
> -	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
> +	.flags = UDMA_FLAGS_J7_CLASS,
>  	.statictr_z_mask = GENMASK(23, 0),
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES, /* H Channels */
> +		0, /* No UH Channels */
> +	},
>  };
>  
>  static struct udma_match_data am64_bcdma_data = {
>  	.type = DMA_TYPE_BCDMA,
>  	.psil_base = 0x2000, /* for tchan and rchan, not applicable to bchan */
>  	.enable_memcpy_support = true, /* Supported via bchan */
> -	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
> +	.flags = UDMA_FLAGS_J7_CLASS,
>  	.statictr_z_mask = GENMASK(23, 0),
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		0, /* No H Channels */
> +		0, /* No UH Channels */
> +	},
>  };
>  
>  static struct udma_match_data am64_pktdma_data = {
>  	.type = DMA_TYPE_PKTDMA,
>  	.psil_base = 0x1000,
>  	.enable_memcpy_support = false, /* PKTDMA does not support MEM_TO_MEM */
> -	.flags = UDMA_FLAG_PDMA_ACC32 | UDMA_FLAG_PDMA_BURST | UDMA_FLAG_TDTYPE,
> +	.flags = UDMA_FLAGS_J7_CLASS,
>  	.statictr_z_mask = GENMASK(23, 0),
> +	.burst_size = {
> +		TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES, /* Normal Channels */
> +		0, /* No H Channels */
> +		0, /* No UH Channels */
> +	},
>  };
>  
>  static const struct of_device_id udma_of_match[] = {
> @@ -5045,6 +5119,35 @@ static void udma_dbg_summary_show(struct seq_file *s,
>  }
>  #endif /* CONFIG_DEBUG_FS */
>  
> +static enum dmaengine_alignment udma_get_copy_align(struct udma_dev *ud)
> +{
> +	const struct udma_match_data *match_data = ud->match_data;
> +	u8 tpl;
> +
> +	if (!match_data->enable_memcpy_support)
> +		return DMAENGINE_ALIGN_8_BYTES;
> +
> +	/* Get the highest TPL level the device supports for memcpy */
> +	if (ud->bchan_cnt) {
> +		tpl = udma_get_chan_tpl_index(&ud->bchan_tpl, 0);
> +	} else if (ud->tchan_cnt) {
> +		tpl = udma_get_chan_tpl_index(&ud->tchan_tpl, 0);
> +	} else {
> +		return DMAENGINE_ALIGN_8_BYTES;
> +	}

Braces seem not required

> +
> +	switch (match_data->burst_size[tpl]) {
> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_256_BYTES:
> +			return DMAENGINE_ALIGN_256_BYTES;
> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_128_BYTES:
> +			return DMAENGINE_ALIGN_128_BYTES;
> +		case TI_SCI_RM_UDMAP_CHAN_BURST_SIZE_64_BYTES:
> +		fallthrough;
> +		default:
> +			return DMAENGINE_ALIGN_64_BYTES;

ah, we are supposed to have case at same indent as switch, pls run
checkpatch to have these flagged off

-- 
~Vinod
