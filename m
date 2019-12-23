Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34FEE129363
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 09:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726007AbfLWI7E (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 03:59:04 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:52888 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfLWI7E (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 Dec 2019 03:59:04 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBN8wpFi122519;
        Mon, 23 Dec 2019 02:58:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577091531;
        bh=V3X161XHepZvvFiG+2ureTT5AB/uev5oOnL93dHeVeY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=xEt+mPkvNQmKzhkZqRjksBDqlYXmKQdaX7aB2/2GQvKSRQtv1+f93qxalSHoXgQFf
         J8R56GvQeEeLCvATEfTWxAcXfn8T6JzSDH0nD/JcCyZ+Yky1Ixohz1xMSjl+Ky/BDl
         LXAD56cVFlTOIvhZvOJpPq7TwXKzfufsoZL2JJKM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBN8wpBg045591
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 23 Dec 2019 02:58:51 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 23
 Dec 2019 02:58:51 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 23 Dec 2019 02:58:51 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBN8wlOi032299;
        Mon, 23 Dec 2019 02:58:48 -0600
Subject: Re: [PATCH v7 09/12] dmaengine: ti: New driver for K3 UDMA
To:     Vinod Koul <vkoul@kernel.org>
CC:     <robh+dt@kernel.org>, <nm@ti.com>, <ssantosh@kernel.org>,
        <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>, <lokeshvutla@ti.com>,
        <t-kristo@ti.com>, <tony@atomide.com>, <j-keerthy@ti.com>,
        <vigneshr@ti.com>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-10-peter.ujfalusi@ti.com>
 <20191223073425.GV2536@vkoul-mobl>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <ea473fed-276f-6b71-070b-02ab1f51ed89@ti.com>
Date:   Mon, 23 Dec 2019 10:59:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191223073425.GV2536@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 23/12/2019 9.34, Vinod Koul wrote:
> On 09-12-19, 11:43, Peter Ujfalusi wrote:
> 
>> +#include <linux/kernel.h>
>> +#include <linux/dmaengine.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/dmapool.h>
>> +#include <linux/err.h>
>> +#include <linux/init.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/list.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/spinlock.h>
>> +#include <linux/of.h>
>> +#include <linux/of_dma.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_irq.h>
> 
> to many of headers, do we need all!

I'll try to cut them back.

>> +static char *udma_get_dir_text(enum dma_transfer_direction dir)
>> +{
>> +	switch (dir) {
>> +	case DMA_DEV_TO_MEM:
>> +		return "DEV_TO_MEM";
>> +	case DMA_MEM_TO_DEV:
>> +		return "MEM_TO_DEV";
>> +	case DMA_MEM_TO_MEM:
>> +		return "MEM_TO_MEM";
>> +	case DMA_DEV_TO_DEV:
>> +		return "DEV_TO_DEV";
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return "invalid";
>> +}
> 
> this seems generic which other ppl may need, can we move it to core.

dmaengine_get_direction_text() to include/linux/dmaengine.h
This way client drivers can use it if they need it?

>> +static void udma_reset_uchan(struct udma_chan *uc)
>> +{
>> +	uc->state = UDMA_CHAN_IS_IDLE;
>> +	uc->remote_thread_id = -1;
>> +	uc->dir = DMA_MEM_TO_MEM;
>> +	uc->pkt_mode = false;
>> +	uc->ep_type = PSIL_EP_NATIVE;
>> +	uc->enable_acc32 = 0;
>> +	uc->enable_burst = 0;
>> +	uc->channel_tpl = 0;
>> +	uc->psd_size = 0;
>> +	uc->metadata_size = 0;
>> +	uc->hdesc_size = 0;
>> +	uc->notdpkt = 0;
> 
> rather than do setting zero, why note memset and then set the nonzero
> members only?

I have lots of other things in udma_chan which can not be memset, vchan
struct, tasklet, name (for irq), etc.

to use memset, I think I could move parameters under a new struct
(udma_chan_params) keeping only the state in udma_chan.


>> +static void udma_reset_counters(struct udma_chan *uc)
>> +{
>> +	u32 val;
>> +
>> +	if (uc->tchan) {
>> +		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_BCNT_REG);
>> +		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_BCNT_REG, val);
> 
> so you read back from UDMA_TCHAN_RT_BCNT_REG and write same value to
> it??

Yes, that's correct. This is how we can reset it. The counter is
decremented with the value you have written to the register.

>> +
>> +		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_SBCNT_REG);
>> +		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_SBCNT_REG, val);
>> +
>> +		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PCNT_REG);
>> +		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_PCNT_REG, val);
>> +
>> +		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG);
>> +		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_PEER_BCNT_REG, val);
>> +	}
>> +
>> +	if (uc->rchan) {
>> +		val = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_BCNT_REG);
>> +		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_BCNT_REG, val);
>> +
>> +		val = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_SBCNT_REG);
>> +		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_SBCNT_REG, val);
>> +
>> +		val = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_PCNT_REG);
>> +		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_PCNT_REG, val);
>> +
>> +		val = udma_rchanrt_read(uc->rchan, UDMA_RCHAN_RT_PEER_BCNT_REG);
>> +		udma_rchanrt_write(uc->rchan, UDMA_RCHAN_RT_PEER_BCNT_REG, val);
> 
> True for all of these, what am I missing :)

Decrement on write.

> 
>> +static int udma_start(struct udma_chan *uc)
>> +{
>> +	struct virt_dma_desc *vd = vchan_next_desc(&uc->vc);
>> +
>> +	if (!vd) {
>> +		uc->desc = NULL;
>> +		return -ENOENT;
>> +	}
>> +
>> +	list_del(&vd->node);
>> +
>> +	uc->desc = to_udma_desc(&vd->tx);
>> +
>> +	/* Channel is already running and does not need reconfiguration */
>> +	if (udma_is_chan_running(uc) && !udma_chan_needs_reconfiguration(uc)) {
>> +		udma_start_desc(uc);
>> +		goto out;
> 
> How about the case where settings are different than the current one?

udma_chan_needs_reconfiguration() is checking that. I only need to
reconfigure UDMAP/PDMA if the settings have changed.

>> +static struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
>> +					    size_t tr_size, int tr_count,
>> +					    enum dma_transfer_direction dir)
>> +{
>> +	struct udma_hwdesc *hwdesc;
>> +	struct cppi5_desc_hdr_t *tr_desc;
>> +	struct udma_desc *d;
>> +	u32 reload_count = 0;
>> +	u32 ring_id;
>> +
>> +	switch (tr_size) {
>> +	case 16:
>> +	case 32:
>> +	case 64:
>> +	case 128:
>> +		break;
>> +	default:
>> +		dev_err(uc->ud->dev, "Unsupported TR size of %zu\n", tr_size);
>> +		return NULL;
>> +	}
>> +
>> +	/* We have only one descriptor containing multiple TRs */
>> +	d = kzalloc(sizeof(*d) + sizeof(d->hwdesc[0]), GFP_ATOMIC);
> 
> this is invoked from prep_ so should use GFP_NOWAIT, we dont use
> GFP_ATOMIC :)

Ok. btw: EDMA and sDMA driver is using GFP_ATOMIC :o

> 
>> +static struct udma_desc *
>> +udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
>> +		      unsigned int sglen, enum dma_transfer_direction dir,
>> +		      unsigned long tx_flags, void *context)
>> +{
>> +	enum dma_slave_buswidth dev_width;
>> +	struct scatterlist *sgent;
>> +	struct udma_desc *d;
>> +	size_t tr_size;
>> +	struct cppi5_tr_type1_t *tr_req = NULL;
>> +	unsigned int i;
>> +	u32 burst;
>> +
>> +	if (dir == DMA_DEV_TO_MEM) {
>> +		dev_width = uc->cfg.src_addr_width;
>> +		burst = uc->cfg.src_maxburst;
>> +	} else if (dir == DMA_MEM_TO_DEV) {
>> +		dev_width = uc->cfg.dst_addr_width;
>> +		burst = uc->cfg.dst_maxburst;
>> +	} else {
>> +		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
>> +		return NULL;
>> +	}
>> +
>> +	if (!burst)
>> +		burst = 1;
>> +
>> +	/* Now allocate and setup the descriptor. */
>> +	tr_size = sizeof(struct cppi5_tr_type1_t);
>> +	d = udma_alloc_tr_desc(uc, tr_size, sglen, dir);
>> +	if (!d)
>> +		return NULL;
>> +
>> +	d->sglen = sglen;
>> +
>> +	tr_req = (struct cppi5_tr_type1_t *)d->hwdesc[0].tr_req_base;
> 
> cast away from void *?

True, it is not needed.

>> +static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
>> +				   enum dma_slave_buswidth dev_width,
>> +				   u16 elcnt)
>> +{
>> +	if (uc->ep_type != PSIL_EP_PDMA_XY)
>> +		return 0;
>> +
>> +	/* Bus width translates to the element size (ES) */
>> +	switch (dev_width) {
>> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
>> +		d->static_tr.elsize = 0;
>> +		break;
>> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
>> +		d->static_tr.elsize = 1;
>> +		break;
>> +	case DMA_SLAVE_BUSWIDTH_3_BYTES:
>> +		d->static_tr.elsize = 2;
>> +		break;
>> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
>> +		d->static_tr.elsize = 3;
>> +		break;
>> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
>> +		d->static_tr.elsize = 4;
> 
> seems like ffs(dev_width) to me?

Not really:
ffs(DMA_SLAVE_BUSWIDTH_1_BYTE) = 1
ffs(DMA_SLAVE_BUSWIDTH_2_BYTES) = 2
ffs(DMA_SLAVE_BUSWIDTH_3_BYTES) = 1
ffs(DMA_SLAVE_BUSWIDTH_4_BYTES) = 3
ffs(DMA_SLAVE_BUSWIDTH_8_BYTES) = 4

> 
>> +static struct udma_desc *
>> +udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
>> +		       unsigned int sglen, enum dma_transfer_direction dir,
>> +		       unsigned long tx_flags, void *context)
>> +{
>> +	struct scatterlist *sgent;
>> +	struct cppi5_host_desc_t *h_desc = NULL;
>> +	struct udma_desc *d;
>> +	u32 ring_id;
>> +	unsigned int i;
>> +
>> +	d = kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_ATOMIC);
> 
> GFP_NOWAIT here and few other places

Yes, I have fixed them up by this time.

> 
>> +static struct udma_desc *
>> +udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
>> +			 size_t buf_len, size_t period_len,
>> +			 enum dma_transfer_direction dir, unsigned long flags)
>> +{
>> +	struct udma_desc *d;
>> +	u32 ring_id;
>> +	int i;
>> +	int periods = buf_len / period_len;
>> +
>> +	if (periods > (K3_UDMA_DEFAULT_RING_SIZE - 1))
>> +		return NULL;
>> +
>> +	if (period_len > 0x3FFFFF)
> 
> Magic?

I'll add a define to cppi5. It is the packet length limit.

> 
>> +static enum dma_status udma_tx_status(struct dma_chan *chan,
>> +				      dma_cookie_t cookie,
>> +				      struct dma_tx_state *txstate)
>> +{
>> +	struct udma_chan *uc = to_udma_chan(chan);
>> +	enum dma_status ret;
>> +	unsigned long flags;
>> +
>> +	spin_lock_irqsave(&uc->vc.lock, flags);
>> +
>> +	ret = dma_cookie_status(chan, cookie, txstate);
>> +
>> +	if (!udma_is_chan_running(uc))
>> +		ret = DMA_COMPLETE;
> 
> Even for paused, not started channel? Not sure what will be return on those cases

Hrm, if the channel is not started yet, then I think it should be still
DMA_IN_PROGRESS, right?
The udma_is_chan_running() can be dropped from here.
I did missed the DMA_PAUSED state.

-	if (!udma_is_chan_running(uc))
-		ret = DMA_COMPLETE;
+	if (ret == DMA_IN_PROGRESS && udma_is_chan_paused(uc))
+		ret = DMA_PAUSED;


- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
