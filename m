Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBBC99F5
	for <lists+dmaengine@lfdr.de>; Thu,  3 Oct 2019 10:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfJCIed (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 3 Oct 2019 04:34:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36756 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfJCIec (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 3 Oct 2019 04:34:32 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x938YIS3039241;
        Thu, 3 Oct 2019 03:34:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1570091658;
        bh=wC+n3OENdEJ2IsQgFjMkRTLzwLiPOKYcYONX3Y1jgtU=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=QBspVv8HfOBkUrfWYQCvaNnIy27aioTckz/SMrSDkArh7nK5JMRFhG03E7MF/jiFz
         2s9WYAkoJdLtwYTZrhWv89A5tJcjgsPXH1YaK7nmuaWixskJZksIsJDfdVRrtnW5kl
         osvlF7806n9kY2QdMr4TUHuDiYf8szKYNpx2U6Ws=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id x938YIkE066573;
        Thu, 3 Oct 2019 03:34:18 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 3 Oct
 2019 03:34:17 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 3 Oct 2019 03:34:17 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x938YEqD014611;
        Thu, 3 Oct 2019 03:34:14 -0500
Subject: Re: [PATCH v3 09/14] dmaengine: ti: New driver for K3 UDMA - split#2:
 probe/remove, xlate and filter_fn
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <nm@ti.com>,
        <ssantosh@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>
References: <20191001061704.2399-1-peter.ujfalusi@ti.com>
 <20191001061704.2399-10-peter.ujfalusi@ti.com>
Message-ID: <a183aa24-572f-483d-a60c-1e721b981e65@ti.com>
Date:   Thu, 3 Oct 2019 11:35:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191001061704.2399-10-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 01/10/2019 9.16, Peter Ujfalusi wrote:
> Split patch for review containing: module probe/remove functions, of_xlate
> and filter_fn for slave channel requests.
> 
> DMA driver for
> Texas Instruments K3 NAVSS Unified DMA – Peripheral Root Complex (UDMA-P)
> 
> The UDMA-P is intended to perform similar (but significantly upgraded) functions
> as the packet-oriented DMA used on previous SoC devices. The UDMA-P module
> supports the transmission and reception of various packet types. The UDMA-P is
> architected to facilitate the segmentation and reassembly of SoC DMA data
> structure compliant packets to/from smaller data blocks that are natively
> compatible with the specific requirements of each connected peripheral. Multiple
> Tx and Rx channels are provided within the DMA which allow multiple segmentation
> or reassembly operations to be ongoing. The DMA controller maintains state
> information for each of the channels which allows packet segmentation and
> reassembly operations to be time division multiplexed between channels in order
> to share the underlying DMA hardware. An external DMA scheduler is used to
> control the ordering and rate at which this multiplexing occurs for Transmit
> operations. The ordering and rate of Receive operations is indirectly controlled
> by the order in which blocks are pushed into the DMA on the Rx PSI-L interface.
> 
> The UDMA-P also supports acting as both a UTC and UDMA-C for its internal
> channels. Channels in the UDMA-P can be configured to be either Packet-Based or
> Third-Party channels on a channel by channel basis.
> 
> The initial driver supports:
> - MEM_TO_MEM (TR mode)
> - DEV_TO_MEM (Packet / TR mode)
> - MEM_TO_DEV (Packet / TR mode)
> - Cyclic (Packet / TR mode)
> - Metadata for descriptors
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/dma/ti/k3-udma.c | 617 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 617 insertions(+)
> 
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 628120fffa2f..d40fd268b477 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c

...

> +static int udma_setup_resources(struct udma_dev *ud)
> +{
> +	struct device *dev = ud->dev;
> +	int ch_count, ret, i, j;
> +	u32 cap2, cap3;
> +	struct ti_sci_resource_desc *rm_desc;
> +	struct ti_sci_resource *rm_res, irq_res;
> +	struct udma_tisci_rm *tisci_rm = &ud->tisci_rm;
> +	static const char * const range_names[] = { "ti,sci-rm-range-tchan",
> +						    "ti,sci-rm-range-rchan",
> +						    "ti,sci-rm-range-rflow" };
> +
> +	cap2 = udma_read(ud->mmrs[MMR_GCFG], 0x28);
> +	cap3 = udma_read(ud->mmrs[MMR_GCFG], 0x2c);
> +
> +	ud->rflow_cnt = cap3 & 0x3fff;
> +	ud->tchan_cnt = cap2 & 0x1ff;
> +	ud->echan_cnt = (cap2 >> 9) & 0x1ff;
> +	ud->rchan_cnt = (cap2 >> 18) & 0x1ff;
> +	ch_count  = ud->tchan_cnt + ud->rchan_cnt;
> +
> +	ud->tchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->tchan_cnt),
> +					   sizeof(unsigned long), GFP_KERNEL);
> +	ud->tchans = devm_kcalloc(dev, ud->tchan_cnt, sizeof(*ud->tchans),
> +				  GFP_KERNEL);
> +	ud->rchan_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rchan_cnt),
> +					   sizeof(unsigned long), GFP_KERNEL);
> +	ud->rchans = devm_kcalloc(dev, ud->rchan_cnt, sizeof(*ud->rchans),
> +				  GFP_KERNEL);
> +	ud->rflow_gp_map = devm_kmalloc_array(dev, BITS_TO_LONGS(ud->rflow_cnt),
> +					      sizeof(unsigned long),
> +					      GFP_KERNEL);
> +	ud->rflow_gp_map_allocated = devm_kcalloc(dev,
> +						  BITS_TO_LONGS(ud->rflow_cnt),
> +						  sizeof(unsigned long),
> +						  GFP_KERNEL);
> +	ud->rflow_in_use = devm_kcalloc(dev, BITS_TO_LONGS(ud->rflow_cnt),
> +					sizeof(unsigned long),
> +					GFP_KERNEL);
> +	ud->rflows = devm_kcalloc(dev, ud->rflow_cnt, sizeof(*ud->rflows),
> +				  GFP_KERNEL);
> +
> +	if (!ud->tchan_map || !ud->rchan_map || !ud->rflow_gp_map ||
> +	    !ud->rflow_gp_map_allocated || !ud->tchans || !ud->rchans ||
> +	    !ud->rflows || !ud->rflow_in_use)
> +		return -ENOMEM;
> +
> +	/*
> +	 * RX flows with the same Ids as RX channels are reserved to be used
> +	 * as default flows if remote HW can't generate flow_ids. Those
> +	 * RX flows can be requested only explicitly by id.
> +	 */
> +	bitmap_set(ud->rflow_gp_map_allocated, 0, ud->rchan_cnt);
> +
> +	/* by default no GP rflows are assigned to Linux */
> +	bitmap_set(ud->rflow_gp_map, 0, ud->rflow_cnt);
> +
> +	/* Get resource ranges from tisci */
> +	for (i = 0; i < RM_RANGE_LAST; i++)
> +		tisci_rm->rm_ranges[i] =
> +			devm_ti_sci_get_of_resource(tisci_rm->tisci, dev,
> +						    tisci_rm->tisci_dev_id,
> +						    (char *)range_names[i]);
> +
> +	/* tchan ranges */
> +	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
> +	if (IS_ERR(rm_res)) {
> +		bitmap_zero(ud->tchan_map, ud->tchan_cnt);
> +	} else {
> +		bitmap_fill(ud->tchan_map, ud->tchan_cnt);
> +		for (i = 0; i < rm_res->sets; i++) {
> +			rm_desc = &rm_res->desc[i];
> +			bitmap_clear(ud->tchan_map, rm_desc->start,
> +				     rm_desc->num);
> +			dev_dbg(dev, "ti-sci-res: tchan: %d:%d\n",
> +				rm_desc->start, rm_desc->num);
> +		}
> +	}
> +	irq_res.sets = rm_res->sets;
> +
> +	/* rchan and matching default flow ranges */
> +	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
> +	if (IS_ERR(rm_res)) {
> +		bitmap_zero(ud->rchan_map, ud->rchan_cnt);
> +	} else {
> +		bitmap_fill(ud->rchan_map, ud->rchan_cnt);
> +		for (i = 0; i < rm_res->sets; i++) {
> +			rm_desc = &rm_res->desc[i];
> +			bitmap_clear(ud->rchan_map, rm_desc->start,
> +				     rm_desc->num);
> +			dev_dbg(dev, "ti-sci-res: rchan: %d:%d\n",
> +				rm_desc->start, rm_desc->num);
> +		}
> +	}
> +
> +	irq_res.sets += rm_res->sets;
> +	irq_res.desc = kcalloc(irq_res.sets, sizeof(*irq_res.desc), GFP_KERNEL);
> +	rm_res = tisci_rm->rm_ranges[RM_RANGE_TCHAN];
> +	for (i = 0; i < rm_res->sets; i++) {
> +		irq_res.desc[i].start = rm_res->desc[i].start;
> +		irq_res.desc[i].num = rm_res->desc[i].num;
> +	}
> +	rm_res = tisci_rm->rm_ranges[RM_RANGE_RCHAN];
> +	for (j = 0; j < rm_res->sets; j++, i++) {
> +		irq_res.desc[i].start = rm_res->desc[j].start + 0x2000;

s/0x2000/ud->match_data->rchan_oes_offset

since the rchan oes offset is also needed to be used when allocating the
MSI domain.

> +		irq_res.desc[i].num = rm_res->desc[j].num;
> +	}
> +	ret = ti_sci_inta_msi_domain_alloc_irqs(ud->dev, &irq_res);
> +	kfree(irq_res.desc);
> +	if (ret) {
> +		dev_err(ud->dev, "Failed to allocate MSI interrupts\n");
> +		return ret;
> +	}

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
