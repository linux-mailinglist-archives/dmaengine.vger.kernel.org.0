Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 880DE155A65
	for <lists+dmaengine@lfdr.de>; Fri,  7 Feb 2020 16:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBGPK2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Feb 2020 10:10:28 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39934 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgBGPK2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Feb 2020 10:10:28 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 017FAOeA099790;
        Fri, 7 Feb 2020 09:10:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581088224;
        bh=FWCsQ1bHbnOLiHiGcLjm5xkgDGwTlbJvPmVGtfA/qE8=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=SdSeG0vKPY6aMFZ8I965yc3yw/lz6zDD6MF8rKbyFHlZM+9RxjmxkoALd/cB7N8nx
         subRT9mSIrXzQ8k9W114+YpiQBDKq5iNgvzcdysPXXwNPM255+Rfm/avAbKcx5ynfk
         dkLV75O3j4V5rWeILaEm42HZ3H2+1sGdKKokA+Kk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 017FAN1d125773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 7 Feb 2020 09:10:24 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 7 Feb
 2020 09:10:23 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 7 Feb 2020 09:10:23 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 017FAMvl082283;
        Fri, 7 Feb 2020 09:10:22 -0600
Subject: Re: [PATCH] dmaengine: ti: edma: Support for interleaved mem to mem
 transfer
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>
References: <20200207142000.14605-1-peter.ujfalusi@ti.com>
Message-ID: <32b3cc79-f808-a3b6-608f-993f0e4774fa@ti.com>
Date:   Fri, 7 Feb 2020 17:10:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200207142000.14605-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

On 07/02/2020 16.20, Peter Ujfalusi wrote:
> Add basic interleaved support via EDMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/edma.c | 80 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
> index 03a7f647f7b2..c291e72260bd 100644
> --- a/drivers/dma/ti/edma.c
> +++ b/drivers/dma/ti/edma.c
> @@ -1275,6 +1275,82 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
>  	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
>  }
>  
> +static struct dma_async_tx_descriptor *
> +edma_prep_dma_interleaved(struct dma_chan *chan,
> +			  struct dma_interleaved_template *xt,
> +			  unsigned long tx_flags)
> +{
> +	struct device *dev = chan->device->dev;
> +	struct edma_chan *echan = to_edma_chan(chan);
> +	struct edmacc_param *param;
> +	struct edma_desc *edesc;
> +	size_t src_icg, dst_icg;
> +	int src_bidx, dst_bidx;
> +
> +	/* Slave mode is not supported */
> +	if (is_slave_direction(xt->dir))
> +		return NULL;
> +
> +	if (xt->frame_size != 1 || xt->numf == 0)
> +		return NULL;
> +
> +	if (xt->sgl[0].size > SZ_64K || xt->numf > SZ_64K)
> +		return NULL;
> +
> +	src_icg = dmaengine_get_src_icg(xt, &xt->sgl[0]);
> +	if (src_icg) {
> +		src_bidx = src_icg + xt->sgl[0].size;
> +	} else if (xt->src_inc) {
> +		src_bidx = xt->sgl[0].size;
> +	} else {
> +		dev_err(dev, "%s: SRC constant addressing is not supported\n",
> +			__func__);
> +		return NULL;
> +	}
> +
> +	dst_icg = dmaengine_get_dst_icg(xt, &xt->sgl[0]);
> +	if (dst_icg) {
> +		dst_bidx = dst_icg + xt->sgl[0].size;
> +	} else if (xt->dst_inc) {
> +		dst_bidx = xt->sgl[0].size;
> +	} else {
> +		dev_err(dev, "%s: DST constant addressing is not supported\n",
> +			__func__);
> +		return NULL;
> +	}
> +
> +	if (src_bidx > SZ_64K || dst_bidx > SZ_64K)
> +		return NULL;
> +
> +	edesc = kzalloc(struct_size(edesc, pset, 1), GFP_ATOMIC);
> +	if (!edesc)
> +		return NULL;
> +
> +	edesc->direction = DMA_MEM_TO_MEM;
> +	edesc->echan = echan;
> +	edesc->pset_nr = 1;
> +
> +	param = &edesc->pset[0].param;
> +
> +	param->src = xt->src_start;
> +	param->dst = xt->dst_start;
> +	param->a_b_cnt = xt->numf << 16 | xt->sgl[0].size;
> +	param->ccnt = 1;
> +	param->src_dst_bidx = (dst_bidx << 16) | src_bidx;
> +	param->src_dst_cidx = 0;
> +	param->link_bcntrld = 0xffffffff;

The BCNTRLD should be 0 and only the link needs to be 0xffff.
BCNTRLD basically a don't care in this setup as CCNT is 1, but to be
precise it is better to leave it as 0.

I'll resend the patch on Monday.

> +
> +	param->opt = EDMA_TCC(EDMA_CHAN_SLOT(echan->ch_num));
> +	param->opt |= ITCCHEN;
> +	/* Enable transfer complete interrupt if requested */
> +	if (tx_flags & DMA_PREP_INTERRUPT)
> +		param->opt |= TCINTEN;
> +	else
> +		edesc->polled = true;
> +
> +	return vchan_tx_prep(&echan->vchan, &edesc->vdesc, tx_flags);
> +}
> +
>  static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
>  	struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
>  	size_t period_len, enum dma_transfer_direction direction,
> @@ -1917,7 +1993,9 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
>  			 "Legacy memcpy is enabled, things might not work\n");
>  
>  		dma_cap_set(DMA_MEMCPY, s_ddev->cap_mask);
> +		dma_cap_set(DMA_INTERLEAVE, m_ddev->cap_mask);
>  		s_ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
> +		s_ddev->device_prep_interleaved_dma = edma_prep_dma_interleaved;
>  		s_ddev->directions = BIT(DMA_MEM_TO_MEM);
>  	}
>  
> @@ -1953,8 +2031,10 @@ static void edma_dma_init(struct edma_cc *ecc, bool legacy_mode)
>  
>  		dma_cap_zero(m_ddev->cap_mask);
>  		dma_cap_set(DMA_MEMCPY, m_ddev->cap_mask);
> +		dma_cap_set(DMA_INTERLEAVE, m_ddev->cap_mask);
>  
>  		m_ddev->device_prep_dma_memcpy = edma_prep_dma_memcpy;
> +		m_ddev->device_prep_interleaved_dma = edma_prep_dma_interleaved;
>  		m_ddev->device_alloc_chan_resources = edma_alloc_chan_resources;
>  		m_ddev->device_free_chan_resources = edma_free_chan_resources;
>  		m_ddev->device_issue_pending = edma_issue_pending;
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
