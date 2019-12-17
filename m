Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F33E121F6F
	for <lists+dmaengine@lfdr.de>; Tue, 17 Dec 2019 01:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbfLQATv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 16 Dec 2019 19:19:51 -0500
Received: from muru.com ([72.249.23.125]:48666 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbfLQATv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 16 Dec 2019 19:19:51 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 672418282;
        Tue, 17 Dec 2019 00:20:28 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 04/14] ARM: OMAP2+: Drop unused sdma functions
Date:   Mon, 16 Dec 2019 16:19:15 -0800
Message-Id: <20191217001925.44558-5-tony@atomide.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191217001925.44558-1-tony@atomide.com>
References: <20191217001925.44558-1-tony@atomide.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

We still have lots of legacy code for sdma, but some of it is now unused.
To simplify phasing out the old legacy sdma code, let's first remove all
currently unused functions:

omap_enable_dma_irq
omap_set_dma_write_mode
omap_set_dma_params
omap_dma_link_lch
omap_set_dma_callback
omap_dma_set_global_params

And with this, omap_dma_set_global_params now becomes static.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Russell King <rmk+kernel@armlinux.org.uk>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/dma.c | 149 +--------------------------------------
 include/linux/omap-dma.h |  12 ----
 2 files changed, 1 insertion(+), 160 deletions(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -65,8 +65,6 @@ enum { DMA_CHAIN_STARTED, DMA_CHAIN_NOTSTARTED };
 static struct omap_system_dma_plat_info *p;
 static struct omap_dma_dev_attr *d;
 static void omap_clear_dma(int lch);
-static int omap_dma_set_prio_lch(int lch, unsigned char read_prio,
-				 unsigned char write_prio);
 static int enable_1510_mode;
 static u32 errata;
 
@@ -95,20 +93,6 @@ static struct dma_link_info *dma_linked_lch;
 #ifndef CONFIG_ARCH_OMAP1
 
 /* Chain handling macros */
-#define OMAP_DMA_CHAIN_QINIT(chain_id)					\
-	do {								\
-		dma_linked_lch[chain_id].q_head =			\
-		dma_linked_lch[chain_id].q_tail =			\
-		dma_linked_lch[chain_id].q_count = 0;			\
-	} while (0)
-#define OMAP_DMA_CHAIN_QFULL(chain_id)					\
-		(dma_linked_lch[chain_id].no_of_lchs_linked ==		\
-		dma_linked_lch[chain_id].q_count)
-#define OMAP_DMA_CHAIN_QLAST(chain_id)					\
-	do {								\
-		((dma_linked_lch[chain_id].no_of_lchs_linked-1) ==	\
-		dma_linked_lch[chain_id].q_count)			\
-	} while (0)
 #define OMAP_DMA_CHAIN_QEMPTY(chain_id)					\
 		(0 == dma_linked_lch[chain_id].q_count)
 #define __OMAP_DMA_CHAIN_INCQ(end)					\
@@ -118,12 +102,6 @@ static struct dma_link_info *dma_linked_lch;
 		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_head);	\
 		dma_linked_lch[chain_id].q_count--;			\
 	} while (0)
-
-#define OMAP_DMA_CHAIN_INCQTAIL(chain_id)				\
-	do {								\
-		__OMAP_DMA_CHAIN_INCQ(dma_linked_lch[chain_id].q_tail);	\
-		dma_linked_lch[chain_id].q_count++; \
-	} while (0)
 #endif
 
 static int dma_lch_count;
@@ -137,9 +115,6 @@ static inline void disable_lnk(int lch);
 static void omap_disable_channel_irq(int lch);
 static inline void omap_enable_channel_irq(int lch);
 
-#define REVISIT_24XX()		printk(KERN_ERR "FIXME: no %s on 24xx\n", \
-						__func__);
-
 #ifdef CONFIG_ARCH_OMAP15XX
 /* Returns 1 if the DMA module is in OMAP1510-compatible mode, 0 otherwise */
 static int omap_dma_in_1510_mode(void)
@@ -278,19 +253,6 @@ void omap_set_dma_transfer_params(int lch, int data_type, int elem_count,
 }
 EXPORT_SYMBOL(omap_set_dma_transfer_params);
 
-void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode)
-{
-	if (dma_omap2plus()) {
-		u32 csdp;
-
-		csdp = p->dma_read(CSDP, lch);
-		csdp &= ~(0x3 << 16);
-		csdp |= (mode << 16);
-		p->dma_write(csdp, CSDP, lch);
-	}
-}
-EXPORT_SYMBOL(omap_set_dma_write_mode);
-
 void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode)
 {
 	if (dma_omap1() && !dma_omap15xx()) {
@@ -332,25 +294,6 @@ void omap_set_dma_src_params(int lch, int src_port, int src_amode,
 }
 EXPORT_SYMBOL(omap_set_dma_src_params);
 
-void omap_set_dma_params(int lch, struct omap_dma_channel_params *params)
-{
-	omap_set_dma_transfer_params(lch, params->data_type,
-				     params->elem_count, params->frame_count,
-				     params->sync_mode, params->trigger,
-				     params->src_or_dst_synch);
-	omap_set_dma_src_params(lch, params->src_port,
-				params->src_amode, params->src_start,
-				params->src_ei, params->src_fi);
-
-	omap_set_dma_dest_params(lch, params->dst_port,
-				 params->dst_amode, params->dst_start,
-				 params->dst_ei, params->dst_fi);
-	if (params->read_prio || params->write_prio)
-		omap_dma_set_prio_lch(lch, params->read_prio,
-				      params->write_prio);
-}
-EXPORT_SYMBOL(omap_set_dma_params);
-
 void omap_set_dma_src_data_pack(int lch, int enable)
 {
 	u32 l;
@@ -507,12 +450,6 @@ static inline void omap_disable_channel_irq(int lch)
 		p->dma_write(OMAP2_DMA_CSR_CLEAR_MASK, CSR, lch);
 }
 
-void omap_enable_dma_irq(int lch, u16 bits)
-{
-	dma_chan[lch].enabled_irqs |= bits;
-}
-EXPORT_SYMBOL(omap_enable_dma_irq);
-
 void omap_disable_dma_irq(int lch, u16 bits)
 {
 	dma_chan[lch].enabled_irqs &= ~bits;
@@ -721,7 +658,7 @@ EXPORT_SYMBOL(omap_free_dma);
  * 						   DMA_THREAD_RESERVE_TWOT
  * 						   DMA_THREAD_RESERVE_THREET
  */
-void
+static void
 omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 {
 	u32 reg;
@@ -742,39 +679,6 @@ omap_dma_set_global_params(int arb_rate, int max_fifo_depth, int tparams)
 
 	p->dma_write(reg, GCR, 0);
 }
-EXPORT_SYMBOL(omap_dma_set_global_params);
-
-/**
- * @brief omap_dma_set_prio_lch : Set channel wise priority settings
- *
- * @param lch
- * @param read_prio - Read priority
- * @param write_prio - Write priority
- * Both of the above can be set with one of the following values :
- * 	DMA_CH_PRIO_HIGH/DMA_CH_PRIO_LOW
- */
-static int
-omap_dma_set_prio_lch(int lch, unsigned char read_prio,
-		      unsigned char write_prio)
-{
-	u32 l;
-
-	if (unlikely((lch < 0 || lch >= dma_lch_count))) {
-		printk(KERN_ERR "Invalid channel id\n");
-		return -EINVAL;
-	}
-	l = p->dma_read(CCR, lch);
-	l &= ~((1 << 6) | (1 << 26));
-	if (d->dev_caps & IS_RW_PRIORITY)
-		l |= ((read_prio & 0x1) << 6) | ((write_prio & 0x1) << 26);
-	else
-		l |= ((read_prio & 0x1) << 6);
-
-	p->dma_write(l, CCR, lch);
-
-	return 0;
-}
-
 
 /*
  * Clears any DMA state so the DMA engine is ready to restart with new buffers
@@ -926,29 +830,6 @@ EXPORT_SYMBOL(omap_stop_dma);
  * Allows changing the DMA callback function or data. This may be needed if
  * the driver shares a single DMA channel for multiple dma triggers.
  */
-int omap_set_dma_callback(int lch,
-			  void (*callback)(int lch, u16 ch_status, void *data),
-			  void *data)
-{
-	unsigned long flags;
-
-	if (lch < 0)
-		return -ENODEV;
-
-	spin_lock_irqsave(&dma_chan_lock, flags);
-	if (dma_chan[lch].dev_id == -1) {
-		printk(KERN_ERR "DMA callback for not set for free channel\n");
-		spin_unlock_irqrestore(&dma_chan_lock, flags);
-		return -EINVAL;
-	}
-	dma_chan[lch].callback = callback;
-	dma_chan[lch].data = data;
-	spin_unlock_irqrestore(&dma_chan_lock, flags);
-
-	return 0;
-}
-EXPORT_SYMBOL(omap_set_dma_callback);
-
 /*
  * Returns current physical source address for the given DMA channel.
  * If the channel is running the caller must disable interrupts prior calling
@@ -1048,34 +929,6 @@ int omap_dma_running(void)
 	return 0;
 }
 
-/*
- * lch_queue DMA will start right after lch_head one is finished.
- * For this DMA link to start, you still need to start (see omap_start_dma)
- * the first one. That will fire up the entire queue.
- */
-void omap_dma_link_lch(int lch_head, int lch_queue)
-{
-	if (omap_dma_in_1510_mode()) {
-		if (lch_head == lch_queue) {
-			p->dma_write(p->dma_read(CCR, lch_head) | (3 << 8),
-								CCR, lch_head);
-			return;
-		}
-		printk(KERN_ERR "DMA linking is not supported in 1510 mode\n");
-		BUG();
-		return;
-	}
-
-	if ((dma_chan[lch_head].dev_id == -1) ||
-	    (dma_chan[lch_queue].dev_id == -1)) {
-		pr_err("omap_dma: trying to link non requested channels\n");
-		dump_stack();
-	}
-
-	dma_chan[lch_head].next_lch = lch_queue;
-}
-EXPORT_SYMBOL(omap_dma_link_lch);
-
 /*----------------------------------------------------------------------------*/
 
 #ifdef CONFIG_ARCH_OMAP1
diff --git a/include/linux/omap-dma.h b/include/linux/omap-dma.h
--- a/include/linux/omap-dma.h
+++ b/include/linux/omap-dma.h
@@ -303,7 +303,6 @@ extern void omap_set_dma_priority(int lch, int dst_port, int priority);
 extern int omap_request_dma(int dev_id, const char *dev_name,
 			void (*callback)(int lch, u16 ch_status, void *data),
 			void *data, int *dma_ch);
-extern void omap_enable_dma_irq(int ch, u16 irq_bits);
 extern void omap_disable_dma_irq(int ch, u16 irq_bits);
 extern void omap_free_dma(int ch);
 extern void omap_start_dma(int lch);
@@ -312,7 +311,6 @@ extern void omap_set_dma_transfer_params(int lch, int data_type,
 					 int elem_count, int frame_count,
 					 int sync_mode,
 					 int dma_trigger, int src_or_dst_synch);
-extern void omap_set_dma_write_mode(int lch, enum omap_dma_write_mode mode);
 extern void omap_set_dma_channel_mode(int lch, enum omap_dma_channel_mode mode);
 
 extern void omap_set_dma_src_params(int lch, int src_port, int src_amode,
@@ -329,20 +327,10 @@ extern void omap_set_dma_dest_data_pack(int lch, int enable);
 extern void omap_set_dma_dest_burst_mode(int lch,
 					 enum omap_dma_burst_mode burst_mode);
 
-extern void omap_set_dma_params(int lch,
-				struct omap_dma_channel_params *params);
-
-extern void omap_dma_link_lch(int lch_head, int lch_queue);
-
-extern int omap_set_dma_callback(int lch,
-			void (*callback)(int lch, u16 ch_status, void *data),
-			void *data);
 extern dma_addr_t omap_get_dma_src_pos(int lch);
 extern dma_addr_t omap_get_dma_dst_pos(int lch);
 extern int omap_get_dma_active_status(int lch);
 extern int omap_dma_running(void);
-extern void omap_dma_set_global_params(int arb_rate, int max_fifo_depth,
-				       int tparams);
 void omap_dma_global_context_save(void);
 void omap_dma_global_context_restore(void);
 
-- 
2.24.1
