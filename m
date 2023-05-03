Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144DF6F5026
	for <lists+dmaengine@lfdr.de>; Wed,  3 May 2023 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjECGbn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 3 May 2023 02:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjECGbl (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 3 May 2023 02:31:41 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF58D1FF6;
        Tue,  2 May 2023 23:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BUuae1WmeUS+YcTLuLq8+anuiHArLRlt25IljJxQbVg=; b=HdOeeTl6sskV/oCc3qva1Bzu9M
        USA/QmyZurxM9Eouk3FqgL0fPaY/HdLJhTR/IPPkxdu8/o9gaaZx0qZCq9B274xLvBE30SAyxxVDD
        jQfVpTFhZuePIQw46/m2LwDBPfNeIemUkelRTqW64koVTA9F2JYdE+3l+9zasH1AWqdCgFaEVKefr
        OSbYWCoTRYSPceG6qg2GsRiFYCTyLcu/3qUVJ9LH2rb3HzaDM5sukHl5BQL8U/cUlv1zc6tDkVb9j
        9RnHcfKCF0Smz7OsjmsvmxMJ8NWMp9hvUqVgy/HwnpCmIXk2KPbF+skxeGCma1gpnRDs68rgPsFdi
        a1/0R7PQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pu61W-003VE1-2J;
        Wed, 03 May 2023 06:31:34 +0000
Date:   Tue, 2 May 2023 23:31:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Kelvin Cao <kelvin.cao@microchip.com>
Cc:     vkoul@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, logang@deltatee.com,
        george.ge@microchip.com, christophe.jaillet@wanadoo.fr,
        hch@infradead.org
Subject: Re: [PATCH v4 1/1] dmaengine: switchtec-dma: Introduce Switchtec DMA
 engine PCI driver
Message-ID: <ZFH/xhyjm9VTZolE@infradead.org>
References: <20230423213717.318655-1-kelvin.cao@microchip.com>
 <20230423213717.318655-2-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423213717.318655-2-kelvin.cao@microchip.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Apr 23, 2023 at 02:37:17PM -0700, Kelvin Cao wrote:
> Implement core PCI driver skeleton and register DMA engine callbacks.

I only noticed this now, but this sentence reads a bit odd.  What does
it try to say?

> +struct chan_fw_regs {
> +	u32 valid_en_se;

...

> +	u16 cq_phase;
> +} __packed;

Everything here seems nicely naturally aligned, what is the reason
for the __packed attribute?

> +struct switchtec_dma_hw_se_desc {
> +	u8 opc;
> +	u8 ctrl;
> +	__le16 tlp_setting;
> +	__le16 rsvd1;
> +	__le16 cid;
> +	__le32 byte_cnt;
> +	union {
> +		__le32 saddr_lo;
> +		__le32 widata_lo;
> +	};
> +	union {
> +		__le32 saddr_hi;
> +		__le32 widata_hi;
> +	};

What is the point for unions of identical data types?

> +			p = (int *)ce;
> +			for (i = 0; i < sizeof(*ce)/4; i++) {
> +				dev_err(chan_dev, "CE DW%d: 0x%08x\n", i,
> +					le32_to_cpu((__force __le32)*p));
> +				p++;
> +			}

Why is this casting to an int that is never used and the back to CE?
Maybe a function that actually dumps the registers with names and
is type safe might be a better idea?  If not just using
print_hex_dump would be a simpler, although that would always printk
in little endian representation (which might be easier to read anyway).

> +	struct pci_dev *pdev;
> +	struct switchtec_dma_chan *swdma_chan = to_switchtec_dma_chan(chan);
> +	int rc;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_chan->swdma_dev->pdev);
> +	rcu_read_unlock();
> +
> +	if (pdev)
> +		synchronize_irq(swdma_chan->irq);

At this point pdev might be freed as you're outside the RCU critical
section, and the irq number could have been reused.

> +	switch (type) {
> +	case MEMCPY:
> +		if (len > SWITCHTEC_DESC_MAX_SIZE)
> +			goto err_unlock;
> +		break;
> +	case WIMM:
> +		if (len != 8)
> +			break;
> +
> +		if (dma_dst & ((1 << DMAENGINE_ALIGN_8_BYTES) - 1)) {
> +			dev_err(chan_dev,
> +				"QW WIMM dst addr 0x%08x_%08x not QW aligned!\n",
> +				upper_32_bits(dma_dst), lower_32_bits(dma_dst));
> +			goto err_unlock;
> +		}
> +		break;
> +	default:
> +		goto err_unlock;
> +	}

IT looks like these checks could easily be done without the lock,
and in the respective callers.

> +	if (type == MEMCPY) {
> +		desc->hw->opc = SWITCHTEC_DMA_OPC_MEMCPY;
> +		desc->hw->saddr_lo = cpu_to_le32(lower_32_bits(dma_src));
> +		desc->hw->saddr_hi = cpu_to_le32(upper_32_bits(dma_src));
> +	} else {
> +		desc->hw->opc = SWITCHTEC_DMA_OPC_WRIMM;
> +		desc->hw->widata_lo = cpu_to_le32(lower_32_bits(data));
> +		desc->hw->widata_hi = cpu_to_le32(upper_32_bits(data));
> +	}

... and then instead of the type I'd just pass the opcode directly,
simplifying the logic quite a bit.

> +static irqreturn_t switchtec_dma_isr(int irq, void *chan)
> +{
> +	struct switchtec_dma_chan *swdma_chan = chan;
> +
> +	if (swdma_chan->comp_ring_active)
> +		tasklet_schedule(&swdma_chan->desc_task);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t switchtec_dma_chan_status_isr(int irq, void *dma)
> +{
> +	struct switchtec_dma_dev *swdma_dev = dma;
> +
> +	tasklet_schedule(&swdma_dev->chan_status_task);
> +
> +	return IRQ_HANDLED;
> +}

Same comment as last time - irq + tasklet seems quite hack and
inefficient over just using threaded interrupts.  I'd like to see
a really good rationale for using it, and a Cc to the interrupt
maintainers that would love to kill off tasklets

> +	addr = swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET;
> +	addr +=  i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;
> +	chan_fw = (struct chan_fw_regs __iomem *)addr;
> +
> +	addr = swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET;
> +	addr +=  i * SWITCHTEC_DMA_CHAN_HW_REGS_SIZE;
> +	chan_hw = (struct chan_hw_regs __iomem *)addr;
> +
> +	swdma_dev->swdma_chans[i] = swdma_chan;
> +	swdma_chan->mmio_chan_fw = chan_fw;
> +	swdma_chan->mmio_chan_hw = chan_hw;

No need for the casts above.  This could simply become:

	swdma_chan->mmio_chan_fw =
		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CFG_STS_OFFSET +
		i * SWITCHTEC_DMA_CHAN_FW_REGS_SIZE;
	swdma_chan->mmio_chan_hw =
		swdma_dev->bar + SWITCHTEC_DMAC_CHAN_CTRL_OFFSET +
		i * SWITCHTEC_DMA_CHAN_HW_REGS_SIZE;

> +	rc = pause_reset_channel(swdma_chan);
> +	if (rc)
> +		goto free_and_exit;
> +
> +	rcu_read_lock();
> +	pdev = rcu_dereference(swdma_dev->pdev);
> +	if (!pdev) {
> +		rc = -ENODEV;
> +		goto unlock_and_free;
> +	}

The pdev can't go away while you're in ->probe as that is synchronized
vs ->remove and ->shutdown.

> +	irq = pci_irq_vector(pdev, irq);
> +	if (irq < 0) {
> +		rc = irq;
> +		goto unlock_and_free;
> +	}
> +
> +	rcu_read_unlock();
> +
> +	rc = request_irq(irq, switchtec_dma_isr, 0, KBUILD_MODNAME, swdma_chan);
> +	if (rc)
> +		goto free_and_exit;

I'd just use pci_request_irq here.

> +#define SWITCHTEC_DMA_DEVICE(device_id) \
> +	{ \
> +		.vendor     = PCI_VENDOR_ID_MICROSEMI, \
> +		.device     = device_id, \
> +		.subvendor  = PCI_ANY_ID, \
> +		.subdevice  = PCI_ANY_ID, \
> +		.class      = PCI_CLASS_SYSTEM_OTHER << 8, \
> +		.class_mask = 0xFFFFFFFF, \
> +	}
> +
> +static const struct pci_device_id switchtec_dma_pci_tbl[] = {
> +	SWITCHTEC_DMA_DEVICE(0x4000), /* PFX 100XG4 */

This should use the common PCI_DEVICE() macro instead, i.e.

	PCI_DEVICE(PCI_VENDOR_ID_MICROSEMI, 0x4000), /* PFX 100XG4 */
	...
