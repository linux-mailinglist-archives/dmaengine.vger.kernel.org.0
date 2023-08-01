Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D50576BCB5
	for <lists+dmaengine@lfdr.de>; Tue,  1 Aug 2023 20:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHASn0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Aug 2023 14:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjHASnJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 1 Aug 2023 14:43:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B4E02737;
        Tue,  1 Aug 2023 11:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2EC856166E;
        Tue,  1 Aug 2023 18:42:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE930C433C7;
        Tue,  1 Aug 2023 18:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690915378;
        bh=6PFKkRqjWmjoHdrNoCnl+wqdEjXa2vclCYRnm6juXQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ARILUEv6KP46NW+lHwT0C1GwhZIuqTtVz+62TEYSVy9/qD1tsUZFqh9l7xQnFhvtG
         2+2FPl8j1k5nInHMVXqCBwCht6GN4Dk26G4/KvkYK4gBCoN7R9GhlTB1gSD0m5BK6m
         UKGsJw+cfUfwEOdSikmj88nWAQBOR0row/hwlvFqNRP1NJrJ+wMFaC51u6QGHJSkXu
         Bf2Vs7mQc9sKx+CRKI5wY2ujOEYyRRdOuLp5ovEjxpRRx5Bv/Dlz1bAS22Mrcaqd9A
         OwMTv20eRK3sX8uJ1qO+r2ppwjuaTjJyl5mKHmKqiaco1HNDL2yQ9Ope8sU6IiDYRe
         PUakGoL3pGuRQ==
Date:   Wed, 2 Aug 2023 00:12:53 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kelvin Cao <kelvin.cao@microchip.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        logang@deltatee.com, George.Ge@microchip.com,
        christophe.jaillet@wanadoo.fr, hch@infradead.org
Subject: Re: [PATCH v6 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZMlSLXaYaMry7ioA@matsya>
References: <20230728200327.96496-1-kelvin.cao@microchip.com>
 <20230728200327.96496-2-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728200327.96496-2-kelvin.cao@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 28-07-23, 13:03, Kelvin Cao wrote:

> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_memcpy(struct dma_chan *c, dma_addr_t dma_dst,
> +			  dma_addr_t dma_src, size_t len, unsigned long flags)
> +	__acquires(swdma_chan->submit_lock)
> +{
> +	if (len > SWITCHTEC_DESC_MAX_SIZE) {
> +		/*
> +		 * Keep sparse happy by restoring an even lock count on
> +		 * this lock.
> +		 */
> +		__acquire(swdma_chan->submit_lock);
> +		return NULL;
> +	}
> +
> +	return switchtec_dma_prep_desc(c, MEMCPY, SWITCHTEC_INVALID_HFID,
> +				       dma_dst, SWITCHTEC_INVALID_HFID, dma_src,
> +				       0, len, flags);
> +}
> +
> +static struct dma_async_tx_descriptor *
> +switchtec_dma_prep_wimm_data(struct dma_chan *c, dma_addr_t dma_dst, u64 data,
> +			     unsigned long flags)

can you please explain what this wimm data refers to...

I think adding imm callback was a mistake, we need a better
justification for another user for this, who programs this, what gets
programmed here

> +	__acquires(swdma_chan->submit_lock)
> +{
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(c);
> +	struct device *chan_dev = to_chan_dev(swdma_chan);
> +	size_t len = sizeof(data);
> +
> +	if (len == 8 && (dma_dst & ((1 << DMAENGINE_ALIGN_8_BYTES) - 1))) {
> +		dev_err(chan_dev,
> +			"QW WIMM dst addr 0x%08x_%08x not QW aligned!\n",
> +			upper_32_bits(dma_dst), lower_32_bits(dma_dst));
> +		/*
> +		 * Keep sparse happy by restoring an even lock count on
> +		 * this lock.
> +		 */
> +		__acquire(swdma_chan->submit_lock);
> +		return NULL;
> +	}
> +
> +	return switchtec_dma_prep_desc(c, WIMM, SWITCHTEC_INVALID_HFID, dma_dst,
> +				       SWITCHTEC_INVALID_HFID, 0, data, len,
> +				       flags);
> +}
> +

...

> +static int switchtec_dma_alloc_desc(struct switchtec_dma_chan *swdma_chan)
> +{
> +	struct switchtec_dma_dev *swdma_dev = swdma_chan->swdma_dev;
> +	struct chan_fw_regs __iomem *chan_fw = swdma_chan->mmio_chan_fw;
> +	struct pci_dev *pdev;
> +	struct switchtec_dma_desc *desc;
> +	size_t size;
> +	int rc;
> +	int i;
> +
> +	swdma_chan->head = 0;
> +	swdma_chan->tail = 0;
> +	swdma_chan->cq_tail = 0;
> +
> +	size = SWITCHTEC_DMA_SQ_SIZE * sizeof(*swdma_chan->hw_sq);
> +	swdma_chan->hw_sq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_sq,
> +					       GFP_NOWAIT);
> +	if (!swdma_chan->hw_sq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	size = SWITCHTEC_DMA_CQ_SIZE * sizeof(*swdma_chan->hw_cq);
> +	swdma_chan->hw_cq = dma_alloc_coherent(swdma_dev->dma_dev.dev, size,
> +					       &swdma_chan->dma_addr_cq,
> +					       GFP_NOWAIT);
> +	if (!swdma_chan->hw_cq) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	/* reset host phase tag */
> +	swdma_chan->phase_tag = 0;
> +
> +	size = sizeof(*swdma_chan->desc_ring);
> +	swdma_chan->desc_ring = kcalloc(SWITCHTEC_DMA_RING_SIZE, size,
> +					GFP_NOWAIT);
> +	if (!swdma_chan->desc_ring) {
> +		rc = -ENOMEM;
> +		goto free_and_exit;
> +	}
> +
> +	for (i = 0; i < SWITCHTEC_DMA_RING_SIZE; i++) {
> +		desc = kzalloc(sizeof(*desc), GFP_NOWAIT);
> +		if (!desc) {
> +			rc = -ENOMEM;
> +			goto free_and_exit;
> +		}
> +
> +		dma_async_tx_descriptor_init(&desc->txd, &swdma_chan->dma_chan);
> +		desc->txd.tx_submit = switchtec_dma_tx_submit;
> +		desc->hw = &swdma_chan->hw_sq[i];
> +		desc->completed = true;
> +
> +		swdma_chan->desc_ring[i] = desc;
> +	}
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_dev->pdev);
> +	if (!pdev) {
> +		rcu_read_unlock();
> +		rc = -ENODEV;
> +		goto free_and_exit;
> +	}
> +
> +	/* set sq/cq */
> +	writel(lower_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_lo);
> +	writel(upper_32_bits(swdma_chan->dma_addr_sq), &chan_fw->sq_base_hi);
> +	writel(lower_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_lo);
> +	writel(upper_32_bits(swdma_chan->dma_addr_cq), &chan_fw->cq_base_hi);
> +
> +	writew(SWITCHTEC_DMA_SQ_SIZE, &swdma_chan->mmio_chan_fw->sq_size);
> +	writew(SWITCHTEC_DMA_CQ_SIZE, &swdma_chan->mmio_chan_fw->cq_size);

what is write happening in the descriptor alloc callback, that does not
sound correct to me
-- 
~Vinod
