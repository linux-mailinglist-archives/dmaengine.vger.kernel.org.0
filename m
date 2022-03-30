Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A1E4ECA18
	for <lists+dmaengine@lfdr.de>; Wed, 30 Mar 2022 18:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349085AbiC3Q4O (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 30 Mar 2022 12:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349078AbiC3Q4N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 30 Mar 2022 12:56:13 -0400
X-Greylist: delayed 544 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 09:54:24 PDT
Received: from hutie.ust.cz (unknown [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F8335AB8;
        Wed, 30 Mar 2022 09:54:21 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648658716; bh=NmppNrMLK45qogHTSU7xLfTr2hjkNxVKbkHtWd69NIM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JtFs1Ns5Gl7njBF9q1xinSW7khmJT5pyuDP19ab4bpTdLfW4cc/n12i9Y/TfFZPpq
         Ie/80rMPV13HH3h/yMqvp90Vcbtd8hd4H6qrzi7T6iJ3+7GKiyhSKJ7EKLgU6ldUiD
         UF6SwcenCx9hAj9W/euUI8fQXFue2s/YO/vGt+fY=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Kettenis <kettenis@openbsd.org>,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
Subject: [PATCH 2/2] dmaengine: apple-admac: Add Apple ADMAC driver
Date:   Wed, 30 Mar 2022 18:44:58 +0200
Message-Id: <20220330164458.93055-3-povik+lin@cutebit.org>
In-Reply-To: <20220330164458.93055-1-povik+lin@cutebit.org>
References: <20220330164458.93055-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_FAIL,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add driver for Audio DMA Controller present on Apple SoCs from the
"Apple Silicon" family.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 MAINTAINERS               |   2 +
 drivers/dma/Kconfig       |   8 +
 drivers/dma/Makefile      |   1 +
 drivers/dma/apple-admac.c | 799 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 810 insertions(+)
 create mode 100644 drivers/dma/apple-admac.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d9812b70c322..c6311a921190 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1837,6 +1837,7 @@ T:	git https://github.com/AsahiLinux/linux.git
 F:	Documentation/devicetree/bindings/arm/apple.yaml
 F:	Documentation/devicetree/bindings/arm/apple/*
 F:	Documentation/devicetree/bindings/clock/apple,nco.yaml
+F:	Documentation/devicetree/bindings/dma/apple,admac.yaml
 F:	Documentation/devicetree/bindings/i2c/apple,i2c.yaml
 F:	Documentation/devicetree/bindings/interrupt-controller/apple,*
 F:	Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -1846,6 +1847,7 @@ F:	Documentation/devicetree/bindings/power/apple*
 F:	Documentation/devicetree/bindings/watchdog/apple,wdt.yaml
 F:	arch/arm64/boot/dts/apple/
 F:	drivers/clk/clk-apple-nco.c
+F:	drivers/dma/apple-admac.c
 F:	drivers/i2c/busses/i2c-pasemi-core.c
 F:	drivers/i2c/busses/i2c-pasemi-platform.c
 F:	drivers/irqchip/irq-apple-aic.c
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d5de3f77d3aa..dd13bc47eb06 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -85,6 +85,14 @@ config AMCC_PPC440SPE_ADMA
 	help
 	  Enable support for the AMCC PPC440SPe RAID engines.
 
+config APPLE_ADMAC
+	tristate "Apple ADMAC support"
+	depends on ARCH_APPLE || COMPILE_TEST
+	select DMA_ENGINE
+	default ARCH_APPLE
+	help
+	  Enable support for Audio DMA Controller found on Apple Silicon SoCs.
+
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
 	depends on ARCH_AT91
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 616d926cf2a5..28e743c7d86f 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
 obj-$(CONFIG_AMD_PTDMA) += ptdma/
+obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
 obj-$(CONFIG_AXI_DMAC) += dma-axi-dmac.o
diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
new file mode 100644
index 000000000000..e7fd9856474e
--- /dev/null
+++ b/drivers/dma/apple-admac.c
@@ -0,0 +1,799 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Driver for Audio DMA Controller (ADMAC) on t8103 (M1) and other Apple chips
+ *
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/interrupt.h>
+#include <linux/spinlock.h>
+
+#include "dmaengine.h"
+
+#define NCHANNELS_MAX	64
+#define IRQ_NINDICES	4
+
+#define RING_WRITE_SLOT		GENMASK(1, 0)
+#define RING_READ_SLOT		GENMASK(5, 4)
+#define RING_FULL		BIT(9)
+#define RING_EMPTY		BIT(8)
+#define RING_ERR		BIT(10)
+
+#define STATUS_DESC_DONE	BIT(0)
+#define STATUS_ERR		BIT(6)
+
+#define FLAG_DESC_NOTIFY	BIT(16)
+
+#define REG_TX_START		0x0000
+#define REG_TX_STOP		0x0004
+#define REG_RX_START		0x0008
+#define REG_RX_STOP		0x000c
+
+#define REG_CHAN_CTL(ch)	(0x8000 + (ch) * 0x200)
+#define REG_CHAN_CTL_RST_RINGS	BIT(0)
+
+#define REG_DESC_RING(ch)	(0x8070 + (ch) * 0x200)
+#define REG_REPORT_RING(ch)	(0x8074 + (ch) * 0x200)
+
+#define REG_RESIDUE(ch)		(0x8064 + (ch) * 0x200)
+
+#define REG_BUS_WIDTH(ch)	(0x8040 + (ch) * 0x200)
+
+#define BUS_WIDTH_8BIT		0x00
+#define BUS_WIDTH_16BIT		0x01
+#define BUS_WIDTH_32BIT		0x02
+#define BUS_WIDTH_FRAME_2_WORDS	0x10
+#define BUS_WIDTH_FRAME_4_WORDS	0x20
+
+#define CHAN_BUFSIZE		0x8000
+
+#define REG_CHAN_FIFOCTL(ch)	(0x8054 + (ch) * 0x200)
+#define CHAN_FIFOCTL_LIMIT	GENMASK(31, 16)
+#define CHAN_FIFOCTL_THRESHOLD	GENMASK(15, 0)
+
+#define REG_DESC_WRITE(ch)	(0x10000 + ((ch) / 2) * 0x4 + ((ch) & 1) * 0x4000)
+#define REG_REPORT_READ(ch)	(0x10100 + ((ch) / 2) * 0x4 + ((ch) & 1) * 0x4000)
+
+#define REG_TX_INTSTATE(idx)		(0x0030 + (idx) * 4)
+#define REG_RX_INTSTATE(idx)		(0x0040 + (idx) * 4)
+#define REG_CHAN_INTSTATUS(ch, idx)	(0x8010 + (ch) * 0x200 + (idx) * 4)
+#define REG_CHAN_INTMASK(ch, idx)	(0x8020 + (ch) * 0x200 + (idx) * 4)
+
+struct admac_data;
+struct admac_tx;
+
+struct admac_chan {
+	int no;
+	struct admac_data *host;
+	struct dma_chan chan;
+	struct tasklet_struct tasklet;
+
+	spinlock_t lock;
+	struct admac_tx *current_tx;
+	int nperiod_acks;
+
+	struct list_head submitted;
+	struct list_head issued;
+};
+
+struct admac_data {
+	struct dma_device dma;
+	struct device *dev;
+	__iomem void *base;
+
+	int irq_index;
+	int nchannels;
+	struct admac_chan channels[];
+};
+
+struct admac_tx {
+	struct dma_async_tx_descriptor tx;
+	bool cyclic;
+	dma_addr_t buf_addr;
+	dma_addr_t buf_end;
+	size_t buf_len;
+	size_t period_len;
+
+	size_t submitted_pos;
+	size_t reclaimed_pos;
+
+	struct list_head node;
+};
+
+static void admac_poke(struct admac_data *ad, int reg, u32 val)
+{
+	writel_relaxed(val, ad->base + reg);
+}
+
+static u32 admac_peek(struct admac_data *ad, int reg)
+{
+	return readl_relaxed(ad->base + reg);
+}
+
+static void admac_modify(struct admac_data *ad, int reg, u32 mask, u32 val)
+{
+	void __iomem *addr = ad->base + reg;
+	u32 curr = readl_relaxed(addr);
+
+	writel_relaxed((curr & ~mask) | (val & mask), addr);
+}
+
+static struct admac_chan *to_admac_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct admac_chan, chan);
+}
+
+static struct admac_tx *to_admac_tx(struct dma_async_tx_descriptor *tx)
+{
+	return container_of(tx, struct admac_tx, tx);
+}
+
+static enum dma_transfer_direction admac_chan_direction(int channo)
+{
+	return (channo & 1) ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
+}
+
+static dma_cookie_t admac_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct admac_tx *adtx = to_admac_tx(tx);
+	struct admac_chan *adchan = to_admac_chan(tx->chan);
+	unsigned long flags;
+	dma_cookie_t cookie;
+
+	spin_lock_irqsave(&adchan->lock, flags);
+	cookie = dma_cookie_assign(tx);
+	list_add_tail(&adtx->node, &adchan->submitted);
+	spin_unlock_irqrestore(&adchan->lock, flags);
+
+	return cookie;
+}
+
+static int admac_desc_free(struct dma_async_tx_descriptor *tx)
+{
+	struct admac_tx *adtx = to_admac_tx(tx);
+
+	devm_kfree(to_admac_chan(tx->chan)->host->dev, adtx);
+	return 0;
+}
+
+static struct dma_async_tx_descriptor *admac_prep_dma_cyclic(
+		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+		size_t period_len, enum dma_transfer_direction direction,
+		unsigned long flags)
+{
+	struct admac_chan *adchan = container_of(chan, struct admac_chan, chan);
+	struct admac_tx *adtx;
+
+	if (direction != admac_chan_direction(adchan->no))
+		return NULL;
+
+	adtx = devm_kzalloc(adchan->host->dev, sizeof(*adtx), GFP_NOWAIT);
+	if (!adtx)
+		return NULL;
+
+	adtx->cyclic = true;
+
+	adtx->buf_addr = buf_addr;
+	adtx->buf_len = buf_len;
+	adtx->buf_end = buf_addr + buf_len;
+	adtx->period_len = period_len;
+
+	adtx->submitted_pos = 0;
+	adtx->reclaimed_pos = 0;
+
+	dma_async_tx_descriptor_init(&adtx->tx, chan);
+	adtx->tx.tx_submit = admac_tx_submit;
+	adtx->tx.desc_free = admac_desc_free;
+
+	return &adtx->tx;
+}
+
+/*
+ * Write one hardware descriptor for a dmaengine cyclic transaction.
+ */
+static void admac_cyclic_write_one_desc(struct admac_data *ad, int channo,
+					struct admac_tx *tx)
+{
+	dma_addr_t addr;
+
+	if (WARN_ON(!tx->cyclic))
+		return;
+
+	addr = tx->buf_addr + (tx->submitted_pos % tx->buf_len);
+	WARN_ON(addr + tx->period_len > tx->buf_end);
+
+	dev_dbg(ad->dev, "ch%d descriptor: addr=0x%pad len=0x%zx flags=0x%x\n",
+		channo, addr, tx->period_len, FLAG_DESC_NOTIFY);
+
+	admac_poke(ad, REG_DESC_WRITE(channo), addr);
+	admac_poke(ad, REG_DESC_WRITE(channo), addr >> 32);
+	admac_poke(ad, REG_DESC_WRITE(channo), tx->period_len);
+	admac_poke(ad, REG_DESC_WRITE(channo), FLAG_DESC_NOTIFY);
+
+	tx->submitted_pos += tx->period_len;
+	tx->submitted_pos %= 2 * tx->buf_len;
+}
+
+/*
+ * Write all the hardware descriptors for a cyclic transaction
+ * there is space for.
+ */
+static void admac_cyclic_write_desc(struct admac_data *ad, int channo,
+					struct admac_tx *tx)
+{
+	int i;
+
+	for (i = 0; i < 4; i++) {
+		if (admac_peek(ad, REG_DESC_RING(channo)) & RING_FULL)
+			break;
+		admac_cyclic_write_one_desc(ad, channo, tx);
+	}
+}
+
+static int admac_ring_noccupied_slots(int ringval)
+{
+	int wrslot = FIELD_GET(RING_WRITE_SLOT, ringval);
+	int rdslot = FIELD_GET(RING_READ_SLOT, ringval);
+
+	if (wrslot != rdslot) {
+		return (wrslot + 4 - rdslot) % 4;
+	} else {
+		WARN_ON((ringval & (RING_FULL | RING_EMPTY)) == 0);
+
+		if (ringval & RING_FULL)
+			return 4;
+		else
+			return 0;
+	}
+}
+
+/*
+ * Read from hardware the residue of a cyclic dmaengine transaction.
+ */
+static u32 admac_cyclic_read_residue(struct admac_data *ad, int channo,
+					struct admac_tx *adtx)
+{
+	u32 ring1, ring2;
+	u32 residue1, residue2;
+	int nreports;
+	size_t pos;
+
+	ring1 =    admac_peek(ad, REG_REPORT_RING(channo));
+	residue1 = admac_peek(ad, REG_RESIDUE(channo));
+	ring2 =    admac_peek(ad, REG_REPORT_RING(channo));
+	residue2 = admac_peek(ad, REG_RESIDUE(channo));
+
+	if (residue2 > residue1) {
+		/*
+		 * Controller must have loaded next descriptor between
+		 * the two residue reads
+		 */
+		nreports = admac_ring_noccupied_slots(ring1) + 1;
+	} else {
+		/* No descriptor load between the two reads, ring2 is safe to use */
+		nreports = admac_ring_noccupied_slots(ring2);
+	}
+
+	pos = adtx->reclaimed_pos + adtx->period_len * (nreports + 1) - residue2;
+
+	return adtx->buf_len - pos % adtx->buf_len;
+}
+
+static enum dma_status admac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
+				struct dma_tx_state *txstate)
+{
+	struct admac_chan *adchan = to_admac_chan(chan);
+	struct admac_data *ad = adchan->host;
+	struct admac_tx *adtx;
+
+	enum dma_status ret;
+	size_t residue;
+	unsigned long flags;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&adchan->lock, flags);
+	adtx = adchan->current_tx;
+
+	if (adtx && adtx->tx.cookie == cookie) {
+		ret = DMA_IN_PROGRESS;
+		residue = admac_cyclic_read_residue(ad, adchan->no, adtx);
+	} else {
+		ret = DMA_IN_PROGRESS;
+		residue = 0;
+		list_for_each_entry(adtx, &adchan->issued, node) {
+			if (adtx->tx.cookie == cookie) {
+				residue = adtx->buf_len;
+				break;
+			}
+		}
+	}
+	spin_unlock_irqrestore(&adchan->lock, flags);
+
+	dma_set_residue(txstate, residue);
+	return ret;
+}
+
+static void admac_start_chan(struct admac_chan *adchan)
+{
+	u32 startbit = 1 << (adchan->no / 2);
+
+	switch (admac_chan_direction(adchan->no)) {
+	case DMA_MEM_TO_DEV:
+		admac_poke(adchan->host, REG_TX_START, startbit);
+		break;
+	case DMA_DEV_TO_MEM:
+		admac_poke(adchan->host, REG_RX_START, startbit);
+		break;
+	default:
+		break;
+	}
+	dev_dbg(adchan->host->dev, "ch%d start\n", adchan->no);
+}
+
+static void admac_stop_chan(struct admac_chan *adchan)
+{
+	u32 stopbit = 1 << (adchan->no / 2);
+
+	switch (admac_chan_direction(adchan->no)) {
+	case DMA_MEM_TO_DEV:
+		admac_poke(adchan->host, REG_TX_STOP, stopbit);
+		break;
+	case DMA_DEV_TO_MEM:
+		admac_poke(adchan->host, REG_RX_STOP, stopbit);
+		break;
+	default:
+		break;
+	}
+	dev_dbg(adchan->host->dev, "ch%d stop\n", adchan->no);
+}
+
+static void admac_start_current_tx(struct admac_chan *adchan)
+{
+	struct admac_data *ad = adchan->host;
+	int ch = adchan->no;
+
+	admac_poke(ad, REG_CHAN_INTSTATUS(ch, ad->irq_index),
+			STATUS_DESC_DONE | STATUS_ERR);
+	admac_poke(ad, REG_CHAN_CTL(ch), REG_CHAN_CTL_RST_RINGS);
+	admac_poke(ad, REG_CHAN_CTL(ch), 0);
+
+	admac_cyclic_write_one_desc(ad, ch, adchan->current_tx);
+	admac_start_chan(adchan);
+	admac_cyclic_write_desc(ad, ch, adchan->current_tx);
+}
+
+static void admac_issue_pending(struct dma_chan *chan)
+{
+	struct admac_chan *adchan = to_admac_chan(chan);
+	struct admac_tx *tx;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adchan->lock, flags);
+	list_splice_tail_init(&adchan->submitted, &adchan->issued);
+	if (!list_empty(&adchan->issued) && !adchan->current_tx) {
+		tx = list_first_entry(&adchan->issued, struct admac_tx, node);
+		list_del(&tx->node);
+
+		adchan->current_tx = tx;
+		adchan->nperiod_acks = 0;
+		admac_start_current_tx(adchan);
+	}
+	spin_unlock_irqrestore(&adchan->lock, flags);
+}
+
+static int admac_pause(struct dma_chan *chan)
+{
+	struct admac_chan *adchan = to_admac_chan(chan);
+
+	admac_stop_chan(adchan);
+
+	return 0;
+}
+
+static int admac_resume(struct dma_chan *chan)
+{
+	struct admac_chan *adchan = to_admac_chan(chan);
+
+	admac_start_chan(adchan);
+
+	return 0;
+}
+
+static int admac_terminate_all(struct dma_chan *chan)
+{
+	struct admac_chan *adchan = to_admac_chan(chan);
+	struct admac_tx *adtx, *_adtx;
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&adchan->lock, flags);
+	admac_stop_chan(adchan);
+	adchan->current_tx = NULL;
+	list_splice_tail_init(&adchan->submitted, &head);
+	list_splice_tail_init(&adchan->issued, &head);
+	spin_unlock_irqrestore(&adchan->lock, flags);
+
+	list_for_each_entry_safe(adtx, _adtx, &head, node) {
+		list_del(&adtx->node);
+		admac_desc_free(&adtx->tx);
+	}
+
+	return 0;
+}
+
+static int admac_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct admac_chan *adchan = to_admac_chan(chan);
+	struct admac_data *ad = adchan->host;
+
+	dma_cookie_init(&adchan->chan);
+	admac_poke(ad, REG_CHAN_INTSTATUS(adchan->no, ad->irq_index),
+			STATUS_DESC_DONE | STATUS_ERR);
+	admac_poke(ad, REG_CHAN_INTMASK(adchan->no, ad->irq_index),
+			STATUS_DESC_DONE | STATUS_ERR);
+	return 0;
+}
+
+static void admac_free_chan_resources(struct dma_chan *chan)
+{
+	struct admac_chan *adchan = to_admac_chan(chan);
+
+	admac_terminate_all(chan);
+	tasklet_kill(&adchan->tasklet);
+}
+
+static struct dma_chan *admac_dma_of_xlate(struct of_phandle_args *dma_spec,
+						struct of_dma *ofdma)
+{
+	struct admac_data *ad = (struct admac_data *) ofdma->of_dma_data;
+	unsigned int index;
+
+	if (dma_spec->args_count != 1)
+		return NULL;
+
+	index = dma_spec->args[0];
+
+	if (index >= ad->nchannels) {
+		dev_err(ad->dev, "channel index %u out of bounds\n", index);
+		return NULL;
+	}
+
+	return &ad->channels[index].chan;
+}
+
+static int admac_drain_reports(struct admac_data *ad, int channo)
+{
+	int count;
+
+	for (count = 0; count < 4; count++) {
+		u32 countval_hi, countval_lo, unk1, flags;
+
+		if (admac_peek(ad, REG_REPORT_RING(channo)) & RING_EMPTY)
+			break;
+
+		countval_lo = admac_peek(ad, REG_REPORT_READ(channo));
+		countval_hi = admac_peek(ad, REG_REPORT_READ(channo));
+		unk1 =        admac_peek(ad, REG_REPORT_READ(channo));
+		flags =       admac_peek(ad, REG_REPORT_READ(channo));
+
+		dev_dbg(ad->dev, "ch%d report: countval=0x%llx unk1=0x%x flags=0x%x\n",
+			channo, ((u64) countval_hi) << 32 | countval_lo, unk1, flags);
+	}
+
+	return count;
+}
+
+static void admac_handle_status_err(struct admac_data *ad, int channo)
+{
+	bool handled = false;
+
+	if (admac_peek(ad, REG_DESC_RING(channo) & RING_ERR)) {
+		admac_poke(ad, REG_DESC_RING(channo), RING_ERR);
+		dev_err(ad->dev, "ch%d descriptor ring error\n", channo);
+		handled = true;
+	}
+
+	if (admac_peek(ad, REG_REPORT_RING(channo)) & RING_ERR) {
+		admac_poke(ad, REG_REPORT_RING(channo), RING_ERR);
+		dev_err(ad->dev, "ch%d report ring error\n", channo);
+		handled = true;
+	}
+
+	if (unlikely(!handled)) {
+		dev_err(ad->dev, "ch%d unknown error, masking errors as cause of IRQs\n", channo);
+		admac_modify(ad, REG_CHAN_INTMASK(channo, ad->irq_index),
+				STATUS_ERR, 0);
+	}
+}
+
+static void admac_handle_status_desc_done(struct admac_data *ad, int channo)
+{
+	struct admac_chan *adchan = &ad->channels[channo];
+	unsigned long flags;
+	int nreports;
+
+	admac_poke(ad, REG_CHAN_INTSTATUS(channo, ad->irq_index),
+				STATUS_DESC_DONE);
+
+	spin_lock_irqsave(&adchan->lock, flags);
+	nreports = admac_drain_reports(ad, channo);
+
+	if (adchan->current_tx) {
+		struct admac_tx *tx = adchan->current_tx;
+
+		adchan->nperiod_acks += nreports;
+		tx->reclaimed_pos += nreports * tx->period_len;
+		tx->reclaimed_pos %= 2 * tx->buf_len;
+
+		admac_cyclic_write_desc(ad, channo, tx);
+		tasklet_schedule(&adchan->tasklet);
+	}
+	spin_unlock_irqrestore(&adchan->lock, flags);
+}
+
+static void admac_handle_chan_int(struct admac_data *ad, int no)
+{
+	u32 cause = admac_peek(ad, REG_CHAN_INTSTATUS(no, ad->irq_index));
+
+	if (cause & STATUS_ERR)
+		admac_handle_status_err(ad, no);
+
+	if (cause & STATUS_DESC_DONE)
+		admac_handle_status_desc_done(ad, no);
+}
+
+static irqreturn_t admac_interrupt(int irq, void *devid)
+{
+	struct admac_data *ad = devid;
+	u32 rx_intstate, tx_intstate;
+	int i;
+
+	rx_intstate = admac_peek(ad, REG_RX_INTSTATE(ad->irq_index));
+	tx_intstate = admac_peek(ad, REG_TX_INTSTATE(ad->irq_index));
+
+	if (!tx_intstate && !rx_intstate)
+		return IRQ_NONE;
+
+	for (i = 0; i < ad->nchannels; i += 2) {
+		if (tx_intstate & 1)
+			admac_handle_chan_int(ad, i);
+		tx_intstate >>= 1;
+	}
+
+	for (i = 1; i < ad->nchannels; i += 2) {
+		if (rx_intstate & 1)
+			admac_handle_chan_int(ad, i);
+		rx_intstate >>= 1;
+	}
+
+	return IRQ_HANDLED;
+}
+
+static void admac_chan_tasklet(struct tasklet_struct *t)
+{
+	struct admac_chan *adchan = from_tasklet(adchan, t, tasklet);
+	struct admac_tx *adtx;
+	struct dmaengine_desc_callback cb;
+	struct dmaengine_result tx_result;
+	int nacks;
+
+	spin_lock_irq(&adchan->lock);
+	adtx = adchan->current_tx;
+	nacks = adchan->nperiod_acks;
+	adchan->nperiod_acks = 0;
+	spin_unlock_irq(&adchan->lock);
+
+	if (!adtx || !nacks)
+		return;
+
+	tx_result.result = DMA_TRANS_NOERROR;
+	tx_result.residue = 0;
+
+	dmaengine_desc_get_callback(&adtx->tx, &cb);
+	while (nacks--)
+		dmaengine_desc_callback_invoke(&cb, &tx_result);
+}
+
+static int admac_device_config(struct dma_chan *chan,
+				 struct dma_slave_config *config)
+{
+	struct admac_chan *adchan = to_admac_chan(chan);
+	struct admac_data *ad = adchan->host;
+	bool is_tx = admac_chan_direction(adchan->no) == DMA_MEM_TO_DEV;
+	int wordsize = 0;
+	u32 bus_width = 0;
+
+	switch (is_tx ? config->dst_addr_width : config->src_addr_width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		wordsize = 1;
+		bus_width |= BUS_WIDTH_8BIT;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		wordsize = 2;
+		bus_width |= BUS_WIDTH_16BIT;
+		break;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		wordsize = 4;
+		bus_width |= BUS_WIDTH_32BIT;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/*
+	 * We take port_window_size to be the number of words in a frame.
+	 *
+	 * The controller has some means of out-of-band signalling, to the peripheral,
+	 * of words position in a frame. That's where the importance of this control
+	 * comes from.
+	 */
+	switch (is_tx ? config->dst_port_window_size : config->src_port_window_size) {
+	case 0 ... 1:
+		break;
+	case 2:
+		bus_width |= BUS_WIDTH_FRAME_2_WORDS;
+		break;
+	case 4:
+		bus_width |= BUS_WIDTH_FRAME_4_WORDS;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	admac_poke(ad, REG_BUS_WIDTH(adchan->no), bus_width);
+
+	/*
+	 * By FIFOCTL_LIMIT we seem to set the maximal number of bytes allowed to be
+	 * held in controller's per-channel FIFO. Transfers seem to be triggered
+	 * around the time FIFO occupancy touches FIFOCTL_THRESHOLD.
+	 *
+	 * The numbers we set are more or less arbitrary.
+	 */
+	admac_poke(ad, REG_CHAN_FIFOCTL(adchan->no),
+			FIELD_PREP(CHAN_FIFOCTL_LIMIT, 0x30 * wordsize)
+			| FIELD_PREP(CHAN_FIFOCTL_THRESHOLD, 0x18 * wordsize));
+
+	return 0;
+}
+
+static int admac_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct admac_data *ad;
+	struct dma_device *dma;
+	int nchannels;
+	int err, irq, i;
+
+	err = of_property_read_u32(np, "dma-channels", &nchannels);
+	if (err || nchannels > NCHANNELS_MAX) {
+		dev_err(&pdev->dev, "missing or invalid dma-channels property\n");
+		return -EINVAL;
+	}
+
+	ad = devm_kzalloc(&pdev->dev, struct_size(ad, channels, nchannels), GFP_KERNEL);
+	if (!ad)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ad);
+	ad->dev = &pdev->dev;
+	ad->nchannels = nchannels;
+
+	err = of_property_read_u32(np, "apple,internal-irq-destination",
+					&ad->irq_index);
+	if (err || ad->irq_index >= IRQ_NINDICES) {
+		dev_err(&pdev->dev, "missing or invalid apple,internal-irq-destination property\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0) {
+		dev_err(&pdev->dev, "unable to obtain interrupt resource\n");
+		return irq;
+	}
+
+	err = devm_request_irq(&pdev->dev, irq, admac_interrupt,
+					0, dev_name(&pdev->dev), ad);
+	if (err) {
+		dev_err(&pdev->dev, "unable to register interrupt: %d\n", err);
+		return err;
+	}
+
+	ad->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(ad->base)) {
+		dev_err(&pdev->dev, "unable to obtain MMIO resource\n");
+		return PTR_ERR(ad->base);
+	}
+
+	dma = &ad->dma;
+
+	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
+	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
+
+	dma->dev = &pdev->dev;
+	dma->device_alloc_chan_resources = admac_alloc_chan_resources;
+	dma->device_free_chan_resources = admac_free_chan_resources;
+	dma->device_tx_status = admac_tx_status;
+	dma->device_issue_pending = admac_issue_pending;
+	dma->device_terminate_all = admac_terminate_all;
+	dma->device_prep_dma_cyclic = admac_prep_dma_cyclic;
+	dma->device_config = admac_device_config;
+	dma->device_pause = admac_pause;
+	dma->device_resume = admac_resume;
+
+	dma->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
+	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+
+	INIT_LIST_HEAD(&dma->channels);
+	for (i = 0; i < nchannels; i++) {
+		struct admac_chan *adchan = &ad->channels[i];
+
+		adchan->host = ad;
+		adchan->no = i;
+		adchan->chan.device = &ad->dma;
+		spin_lock_init(&adchan->lock);
+		INIT_LIST_HEAD(&adchan->submitted);
+		INIT_LIST_HEAD(&adchan->issued);
+		list_add_tail(&adchan->chan.device_node, &dma->channels);
+		tasklet_setup(&adchan->tasklet, admac_chan_tasklet);
+	}
+
+	err = dma_async_device_register(&ad->dma);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register DMA device: %d\n", err);
+		return err;
+	}
+
+	err = of_dma_controller_register(pdev->dev.of_node, admac_dma_of_xlate, ad);
+	if (err) {
+		dev_err(&pdev->dev, "failed to register with OF: %d\n", err);
+		dma_async_device_unregister(&ad->dma);
+		return err;
+	}
+
+	dev_dbg(&pdev->dev, "all good, ready to go!\n");
+
+	return 0;
+}
+
+static int admac_remove(struct platform_device *pdev)
+{
+	struct admac_data *ad = platform_get_drvdata(pdev);
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&ad->dma);
+
+	return 0;
+}
+
+static const struct of_device_id admac_of_match[] = {
+	{ .compatible = "apple,admac", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, admac_of_match);
+
+static struct platform_driver apple_admac_driver = {
+	.driver = {
+		.name = "apple-admac",
+		.of_match_table = admac_of_match,
+	},
+	.probe = admac_probe,
+	.remove = admac_remove,
+};
+module_platform_driver(apple_admac_driver);
+
+MODULE_AUTHOR("Martin Povišer <povik+lin@cutebit.org>");
+MODULE_DESCRIPTION("Driver for Audio DMA Controller (ADMAC) on Apple SoCs");
+MODULE_LICENSE("GPL");
-- 
2.33.0

