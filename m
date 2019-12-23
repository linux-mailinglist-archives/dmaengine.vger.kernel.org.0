Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA71294F9
	for <lists+dmaengine@lfdr.de>; Mon, 23 Dec 2019 12:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfLWL03 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 Dec 2019 06:26:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfLWL02 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 23 Dec 2019 06:26:28 -0500
Received: from localhost (unknown [223.226.34.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83040207FF;
        Mon, 23 Dec 2019 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577100387;
        bh=U674jlYACjQhhGCy4e3+CzEaPgiSjsEmvjKCwhbFzqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eroF/x42FAFqJKFuiVMDn5gYmfp+YgrmPRGgnjhd4c9dKvwJB7A1iMuS5bamcLlIk
         HL+DKo0W06Yey+iPDZ+l97Ca4a9P+7vi679IhZ4hpHK7VfFnZH0qIxJFFHZ0ydILBj
         9puTCrdym62yreuoQBN3bvWGm7HublXnyBDANolg=
Date:   Mon, 23 Dec 2019 16:56:23 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     robh+dt@kernel.org, nm@ti.com, ssantosh@kernel.org,
        dan.j.williams@intel.com, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com,
        lokeshvutla@ti.com, t-kristo@ti.com, tony@atomide.com,
        j-keerthy@ti.com, vigneshr@ti.com
Subject: Re: [PATCH v7 09/12] dmaengine: ti: New driver for K3 UDMA
Message-ID: <20191223112623.GF2536@vkoul-mobl>
References: <20191209094332.4047-1-peter.ujfalusi@ti.com>
 <20191209094332.4047-10-peter.ujfalusi@ti.com>
 <20191223073425.GV2536@vkoul-mobl>
 <ea473fed-276f-6b71-070b-02ab1f51ed89@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea473fed-276f-6b71-070b-02ab1f51ed89@ti.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 23-12-19, 10:59, Peter Ujfalusi wrote:

> >> +static void udma_reset_counters(struct udma_chan *uc)
> >> +{
> >> +	u32 val;
> >> +
> >> +	if (uc->tchan) {
> >> +		val = udma_tchanrt_read(uc->tchan, UDMA_TCHAN_RT_BCNT_REG);
> >> +		udma_tchanrt_write(uc->tchan, UDMA_TCHAN_RT_BCNT_REG, val);
> > 
> > so you read back from UDMA_TCHAN_RT_BCNT_REG and write same value to
> > it??
> 
> Yes, that's correct. This is how we can reset it. The counter is
> decremented with the value you have written to the register.

aha, with so many read+write back I would have added a helper.. Not a
big deal though can be updated later

> >> +static struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
> >> +					    size_t tr_size, int tr_count,
> >> +					    enum dma_transfer_direction dir)
> >> +{
> >> +	struct udma_hwdesc *hwdesc;
> >> +	struct cppi5_desc_hdr_t *tr_desc;
> >> +	struct udma_desc *d;
> >> +	u32 reload_count = 0;
> >> +	u32 ring_id;
> >> +
> >> +	switch (tr_size) {
> >> +	case 16:
> >> +	case 32:
> >> +	case 64:
> >> +	case 128:
> >> +		break;
> >> +	default:
> >> +		dev_err(uc->ud->dev, "Unsupported TR size of %zu\n", tr_size);
> >> +		return NULL;
> >> +	}
> >> +
> >> +	/* We have only one descriptor containing multiple TRs */
> >> +	d = kzalloc(sizeof(*d) + sizeof(d->hwdesc[0]), GFP_ATOMIC);
> > 
> > this is invoked from prep_ so should use GFP_NOWAIT, we dont use
> > GFP_ATOMIC :)
> 
> Ok. btw: EDMA and sDMA driver is using GFP_ATOMIC :o

heh, we made sure to document this bit :)

> >> +static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
> >> +				   enum dma_slave_buswidth dev_width,
> >> +				   u16 elcnt)
> >> +{
> >> +	if (uc->ep_type != PSIL_EP_PDMA_XY)
> >> +		return 0;
> >> +
> >> +	/* Bus width translates to the element size (ES) */
> >> +	switch (dev_width) {
> >> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> >> +		d->static_tr.elsize = 0;
> >> +		break;
> >> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> >> +		d->static_tr.elsize = 1;
> >> +		break;
> >> +	case DMA_SLAVE_BUSWIDTH_3_BYTES:
> >> +		d->static_tr.elsize = 2;
> >> +		break;
> >> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> >> +		d->static_tr.elsize = 3;
> >> +		break;
> >> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> >> +		d->static_tr.elsize = 4;
> > 
> > seems like ffs(dev_width) to me?
> 
> Not really:
> ffs(DMA_SLAVE_BUSWIDTH_1_BYTE) = 1
> ffs(DMA_SLAVE_BUSWIDTH_2_BYTES) = 2
> ffs(DMA_SLAVE_BUSWIDTH_3_BYTES) = 1

I missed this!

> ffs(DMA_SLAVE_BUSWIDTH_4_BYTES) = 3
> ffs(DMA_SLAVE_BUSWIDTH_8_BYTES) = 4

Otherwise you are ffs() - 1

-- 
~Vinod
