Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75D42121F72
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727728AbfLQATy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:19:54 -0500
Received: from muru.com ([72.249.23.125]:48682 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfLQATx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:19:53 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 82BDF829D;
        Tue, 17 Dec 2019 00:20:30 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 05/14] ARM: OMAP2+: Drop sdma interrupt handling for mach-omap2
Date:   Mon, 16 Dec 2019 16:19:16 -0800
Message-Id: <20191217001925.44558-6-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

All device tree probing omap SoCs only have device drivers that are using
Linux dmaengine API with the IRQENABLE_L1 interrupts. Only omap1 is still
using old legacy dma.

This means we can remove the legacy sdma interrupt handling for
IRQENABLE_L0, and only rely on the dmaengine driver using IRQENABLE_L1.

The legacy code still allocates the channels, but that will be deal with
in the following patches.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/dma.c |   3 -
 arch/arm/plat-omap/dma.c  | 245 ++------------------------------------
 include/linux/omap-dma.h  |   4 -
 3 files changed, 8 insertions(+), 244 deletions(-)

diff --git a/arch/arm/mach-omap2/dma.c b/arch/arm/mach-omap2/dma.c
--- a/arch/arm/mach-omap2/dma.c
+++ b/arch/arm/mach-omap2/dma.c
@@ -272,9 +272,6 @@ static int __init omap2_system_dma_init_dev(struct omap_hwmod *oh, void *unused)
 	if (cpu_is_omap34xx() && (omap_type() != OMAP2_DEVICE_TYPE_GP))
 		d->dev_caps |= HS_CHANNELS_RESERVED;
 
-	if (platform_get_irq_byname(pdev, "0") < 0)
-		d->dev_caps |= DMA_ENGINE_HANDLE_IRQ;
-
 	/* Check the capabilities register for descriptor loading feature */
 	if (dma_read(CAPS_0, 0) & DMA_HAS_DESCRIPTOR_CAPS)
 		dma_common_ch_end = CCDN;
diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -88,22 +88,6 @@ struct dma_link_info {
 
 };
 
-static struct dma_link_info *dma_linked_lch;
-
-#ifndef CONFIG_ARCH_OMAP1
-
-/* Chain handling macros */
-#define OMAP_DMA_CHAIN_QEMPTY(chain_id)					\
-		(0 == dma_linked_lch[chain_id].q_count)
-#define __OMAP_DMA_CHAIN_INCQ(end)					\
-	((end) = ((end)+1) % dma_linked_lch[chain_id].no_of_lchs_linked)
-#define OMAP_DMA_CHAIN_INCQHEAD(chain_id)				\
-	do {								\
-		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_head);	\
-		dma_linked_lch[chain_id].q_count--;			\
-	} while (0)
-#endif
-
 static int dma_lch_count;
 static int dma_chan_count;
 static int omap_dma_reserve_channels;
@@ -469,12 +453,6 @@ static inline void enable_lnk(int lch)
 	if (dma_chan[lch].next_lch != -1)
 		l = dma_chan[lch].next_lch | (1 << 15);
 
-#ifndef CONFIG_ARCH_OMAP1
-	if (dma_omap2plus())
-		if (dma_chan[lch].next_linked_ch != -1)
-			l = dma_chan[lch].next_linked_ch | (1 << 15);
-#endif
-
 	p->dma_write(l, CLNK_CTRL, lch);
 }
 
@@ -501,42 +479,6 @@ static inline void disable_lnk(int lch)
 	dma_chan[lch].flags &= ~OMAP_DMA_ACTIVE;
 }
 
-static inline void omap2_enable_irq_lch(int lch)
-{
-	u32 val;
-	unsigned long flags;
-
-	if (dma_omap1())
-		return;
-
-	spin_lock_irqsave(&dma_chan_lock, flags);
-	/* clear IRQ STATUS */
-	p->dma_write(1 << lch, IRQSTATUS_L0, lch);
-	/* Enable interrupt */
-	val = p->dma_read(IRQENABLE_L0, lch);
-	val |= 1 << lch;
-	p->dma_write(val, IRQENABLE_L0, lch);
-	spin_unlock_irqrestore(&dma_chan_lock, flags);
-}
-
-static inline void omap2_disable_irq_lch(int lch)
-{
-	u32 val;
-	unsigned long flags;
-
-	if (dma_omap1())
-		return;
-
-	spin_lock_irqsave(&dma_chan_lock, flags);
-	/* Disable interrupt */
-	val = p->dma_read(IRQENABLE_L0, lch);
-	val &= ~(1 << lch);
-	p->dma_write(val, IRQENABLE_L0, lch);
-	/* clear IRQ STATUS */
-	p->dma_write(1 << lch, IRQSTATUS_L0, lch);
-	spin_unlock_irqrestore(&dma_chan_lock, flags);
-}
-
 int omap_request_dma(int dev_id, const char *dev_name,
 		     void (*callback)(int lch, u16 ch_status, void *data),
 		     void *data, int *dma_ch_out)
@@ -565,9 +507,6 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	if (p->clear_lch_regs)
 		p->clear_lch_regs(free_ch);
 
-	if (dma_omap2plus())
-		omap_clear_dma(free_ch);
-
 	spin_unlock_irqrestore(&dma_chan_lock, flags);
 
 	chan->dev_name = dev_name;
@@ -575,20 +514,10 @@ int omap_request_dma(int dev_id, const char *dev_name,
 	chan->data = data;
 	chan->flags = 0;
 
-#ifndef CONFIG_ARCH_OMAP1
-	if (dma_omap2plus()) {
-		chan->chain_id = -1;
-		chan->next_linked_ch = -1;
-	}
-#endif
-
 	chan->enabled_irqs = OMAP_DMA_DROP_IRQ | OMAP_DMA_BLOCK_IRQ;
 
 	if (dma_omap1())
 		chan->enabled_irqs |= OMAP1_DMA_TOUT_IRQ;
-	else if (dma_omap2plus())
-		chan->enabled_irqs |= OMAP2_DMA_MISALIGNED_ERR_IRQ |
-			OMAP2_DMA_TRANS_ERR_IRQ;
 
 	if (dma_omap16xx()) {
 		/* If the sync device is set, configure it dynamically. */
@@ -605,11 +534,6 @@ int omap_request_dma(int dev_id, const char *dev_name,
 		p->dma_write(dev_id, CCR, free_ch);
 	}
 
-	if (dma_omap2plus()) {
-		omap_enable_channel_irq(free_ch);
-		omap2_enable_irq_lch(free_ch);
-	}
-
 	*dma_ch_out = free_ch;
 
 	return 0;
@@ -626,20 +550,12 @@ void omap_free_dma(int lch)
 		return;
 	}
 
-	/* Disable interrupt for logical channel */
-	if (dma_omap2plus())
-		omap2_disable_irq_lch(lch);
-
 	/* Disable all DMA interrupts for the channel. */
 	omap_disable_channel_irq(lch);
 
 	/* Make sure the DMA transfer is stopped. */
 	p->dma_write(0, CCR, lch);
 
-	/* Clear registers */
-	if (dma_omap2plus())
-		omap_clear_dma(lch);
-
 	spin_lock_irqsave(&dma_chan_lock, flags);
 	dma_chan[lch].dev_id = -1;
 	dma_chan[lch].next_lch = -1;
@@ -989,109 +905,6 @@ static irqreturn_t omap1_dma_irq_handler(int irq, void *dev_id)
 #define omap1_dma_irq_handler	NULL
 #endif
 
-#ifdef CONFIG_ARCH_OMAP2PLUS
-
-static int omap2_dma_handle_ch(int ch)
-{
-	u32 status = p->dma_read(CSR, ch);
-
-	if (!status) {
-		if (printk_ratelimit())
-			pr_warn("Spurious DMA IRQ for lch %d\n", ch);
-		p->dma_write(1 << ch, IRQSTATUS_L0, ch);
-		return 0;
-	}
-	if (unlikely(dma_chan[ch].dev_id == -1)) {
-		if (printk_ratelimit())
-			pr_warn("IRQ %04x for non-allocated DMA channel %d\n",
-				status, ch);
-		return 0;
-	}
-	if (unlikely(status & OMAP_DMA_DROP_IRQ))
-		pr_info("DMA synchronization event drop occurred with device %d\n",
-			dma_chan[ch].dev_id);
-	if (unlikely(status & OMAP2_DMA_TRANS_ERR_IRQ)) {
-		printk(KERN_INFO "DMA transaction error with device %d\n",
-		       dma_chan[ch].dev_id);
-		if (IS_DMA_ERRATA(DMA_ERRATA_i378)) {
-			u32 ccr;
-
-			ccr = p->dma_read(CCR, ch);
-			ccr &= ~OMAP_DMA_CCR_EN;
-			p->dma_write(ccr, CCR, ch);
-			dma_chan[ch].flags &= ~OMAP_DMA_ACTIVE;
-		}
-	}
-	if (unlikely(status & OMAP2_DMA_SECURE_ERR_IRQ))
-		printk(KERN_INFO "DMA secure error with device %d\n",
-		       dma_chan[ch].dev_id);
-	if (unlikely(status & OMAP2_DMA_MISALIGNED_ERR_IRQ))
-		printk(KERN_INFO "DMA misaligned error with device %d\n",
-		       dma_chan[ch].dev_id);
-
-	p->dma_write(status, CSR, ch);
-	p->dma_write(1 << ch, IRQSTATUS_L0, ch);
-	/* read back the register to flush the write */
-	p->dma_read(IRQSTATUS_L0, ch);
-
-	/* If the ch is not chained then chain_id will be -1 */
-	if (dma_chan[ch].chain_id != -1) {
-		int chain_id = dma_chan[ch].chain_id;
-		dma_chan[ch].state = DMA_CH_NOTSTARTED;
-		if (p->dma_read(CLNK_CTRL, ch) & (1 << 15))
-			dma_chan[dma_chan[ch].next_linked_ch].state =
-							DMA_CH_STARTED;
-		if (dma_linked_lch[chain_id].chain_mode ==
-						OMAP_DMA_DYNAMIC_CHAIN)
-			disable_lnk(ch);
-
-		if (!OMAP_DMA_CHAIN_QEMPTY(chain_id))
-			OMAP_DMA_CHAIN_INCQHEAD(chain_id);
-
-		status = p->dma_read(CSR, ch);
-		p->dma_write(status, CSR, ch);
-	}
-
-	if (likely(dma_chan[ch].callback != NULL))
-		dma_chan[ch].callback(ch, status, dma_chan[ch].data);
-
-	return 0;
-}
-
-/* STATUS register count is from 1-32 while our is 0-31 */
-static irqreturn_t omap2_dma_irq_handler(int irq, void *dev_id)
-{
-	u32 val, enable_reg;
-	int i;
-
-	val = p->dma_read(IRQSTATUS_L0, 0);
-	if (val == 0) {
-		if (printk_ratelimit())
-			printk(KERN_WARNING "Spurious DMA IRQ\n");
-		return IRQ_HANDLED;
-	}
-	enable_reg = p->dma_read(IRQENABLE_L0, 0);
-	val &= enable_reg; /* Dispatch only relevant interrupts */
-	for (i = 0; i < dma_lch_count && val != 0; i++) {
-		if (val & 1)
-			omap2_dma_handle_ch(i);
-		val >>= 1;
-	}
-
-	return IRQ_HANDLED;
-}
-
-static struct irqaction omap24xx_dma_irq = {
-	.name = "DMA",
-	.handler = omap2_dma_irq_handler,
-};
-
-#else
-static struct irqaction omap24xx_dma_irq;
-#endif
-
-/*----------------------------------------------------------------------------*/
-
 /*
  * Note that we are currently using only IRQENABLE_L0 and L1.
  * As the DSP may be using IRQENABLE_L2 and L3, let's not
@@ -1139,7 +952,6 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	int ch, ret = 0;
 	int dma_irq;
 	char irq_name[4];
-	int irq_rel;
 
 	p = pdev->dev.platform_data;
 	if (!p) {
@@ -1165,21 +977,9 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	if (!dma_chan)
 		return -ENOMEM;
 
-	if (dma_omap2plus()) {
-		dma_linked_lch = kcalloc(dma_lch_count,
-					 sizeof(*dma_linked_lch),
-					 GFP_KERNEL);
-		if (!dma_linked_lch) {
-			ret = -ENOMEM;
-			goto exit_dma_lch_fail;
-		}
-	}
-
 	spin_lock_init(&dma_chan_lock);
 	for (ch = 0; ch < dma_chan_count; ch++) {
 		omap_clear_dma(ch);
-		if (dma_omap2plus())
-			omap2_disable_irq_lch(ch);
 
 		dma_chan[ch].dev_id = -1;
 		dma_chan[ch].next_lch = -1;
@@ -1216,22 +1016,6 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 		omap_dma_set_global_params(DMA_DEFAULT_ARB_RATE,
 				DMA_DEFAULT_FIFO_DEPTH, 0);
 
-	if (dma_omap2plus() && !(d->dev_caps & DMA_ENGINE_HANDLE_IRQ)) {
-		strcpy(irq_name, "0");
-		dma_irq = platform_get_irq_byname(pdev, irq_name);
-		if (dma_irq < 0) {
-			dev_err(&pdev->dev, "failed: request IRQ %d", dma_irq);
-			ret = dma_irq;
-			goto exit_dma_lch_fail;
-		}
-		ret = setup_irq(dma_irq, &omap24xx_dma_irq);
-		if (ret) {
-			dev_err(&pdev->dev, "set_up failed for IRQ %d for DMA (error %d)\n",
-				dma_irq, ret);
-			goto exit_dma_lch_fail;
-		}
-	}
-
 	/* reserve dma channels 0 and 1 in high security devices on 34xx */
 	if (d->dev_caps & HS_CHANNELS_RESERVED) {
 		pr_info("Reserving DMA channels 0 and 1 for HS ROM code\n");
@@ -1242,34 +1026,21 @@ static int omap_system_dma_probe(struct platform_device *pdev)
 	return 0;
 
 exit_dma_irq_fail:
-	dev_err(&pdev->dev, "unable to request IRQ %d for DMA (error %d)\n",
-		dma_irq, ret);
-	for (irq_rel = 0; irq_rel < ch;	irq_rel++) {
-		dma_irq = platform_get_irq(pdev, irq_rel);
-		free_irq(dma_irq, (void *)(irq_rel + 1));
-	}
-
-exit_dma_lch_fail:
 	return ret;
 }
 
 static int omap_system_dma_remove(struct platform_device *pdev)
 {
-	int dma_irq;
+	int dma_irq, irq_rel = 0;
 
-	if (dma_omap2plus()) {
-		char irq_name[4];
-		strcpy(irq_name, "0");
-		dma_irq = platform_get_irq_byname(pdev, irq_name);
-		if (dma_irq >= 0)
-			remove_irq(dma_irq, &omap24xx_dma_irq);
-	} else {
-		int irq_rel = 0;
-		for ( ; irq_rel < dma_chan_count; irq_rel++) {
-			dma_irq = platform_get_irq(pdev, irq_rel);
-			free_irq(dma_irq, (void *)(irq_rel + 1));
-		}
+	if (dma_omap2plus())
+		return 0;
+
+	for ( ; irq_rel < dma_chan_count; irq_rel++) {
+		dma_irq = platform_get_irq(pdev, irq_rel);
+		free_irq(dma_irq, (void *)(irq_rel + 1));
 	}
+
 	return 0;
 }
 
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -129,7 +129,6 @@
 #define IS_WORD_16			BIT(0xd)
 #define ENABLE_16XX_MODE		BIT(0xe)
 #define HS_CHANNELS_RESERVED		BIT(0xf)
-#define DMA_ENGINE_HANDLE_IRQ		BIT(0x10)
 
 /* Defines for DMA Capabilities */
 #define DMA_HAS_TRANSPARENT_CAPS	(0x1 << 18)
@@ -239,9 +238,6 @@ struct omap_dma_lch {
 	void (*callback)(int lch, u16 ch_status, void *data);
 	void *data;
 	long flags;
-	/* required for Dynamic chaining */
-	int prev_linked_ch;
-	int next_linked_ch;
 	int state;
 	int chain_id;
 	int status;
-- 
2.24.1
