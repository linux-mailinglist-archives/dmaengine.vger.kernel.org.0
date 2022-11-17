Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9599A62DC56
	for <lists+dmaengine@lfdr.de>; Thu, 17 Nov 2022 14:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239679AbiKQNLG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Nov 2022 08:11:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiKQNLF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Nov 2022 08:11:05 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8F60682;
        Thu, 17 Nov 2022 05:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1668690663; x=1700226663;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eijp8jtUVCS5o4wty6d/uAB9Z0N5KQjN40oWUlZWLt8=;
  b=W7QjsOrr9vtS4GfKMkQqWmO4I+bUllt+m/MAOHUOA4qjcvUaSmF9+sLg
   BWrRVqm5IpSzoS/161FxASpsamZJqWcXf/n0cmCM82WVhvidYgHZZE4WN
   8NQoQSInKks5oykXN0vx/6wKyAXWFw5p2ycOWDODLiBM341wqAwhNuyAx
   KhkEnFjjePC7fZ1U/MdbvgTQe1cdS9mF6Bx1Jg52KEu3EZB5Bz/Mbublp
   yAOx4QgUFhAzmT8gp68VWVF/ornp8iM3a95Or61Q+ARpDRV3NsIvd2MvQ
   MzbMSaYnWOjZ4H5zglWw750T0Ce7es9OTiqrDMVpvFSJYvkaSAEblvOJO
   w==;
X-IronPort-AV: E=Sophos;i="5.96,171,1665471600"; 
   d="scan'208";a="200217657"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Nov 2022 06:11:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 17 Nov 2022 06:11:02 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Thu, 17 Nov 2022 06:11:00 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <tudor.ambarus@microchip.com>, <vkoul@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND][PATCH 1/3] dmaengine: at_xdmac: add runtime pm support
Date:   Thu, 17 Nov 2022 15:15:45 +0200
Message-ID: <20221117131547.293044-2-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20221117131547.293044-1-claudiu.beznea@microchip.com>
References: <20221117131547.293044-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add runtime PM support which involves disabling/enabling controller's
clocks on runtime PM suspend/resume ops. The runtime suspend/resume is
done based on the work submitted to the controller: runtime resume is
happening on at_xdmac_start_xfer() and runtime suspend on
at_xdmac_tasklet().

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/dma/at_xdmac.c | 217 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 202 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index d6c9781cd46a..090bab2196ab 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -21,6 +21,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm.h>
+#include <linux/pm_runtime.h>
 
 #include "dmaengine.h"
 
@@ -240,6 +241,7 @@ struct at_xdmac_chan {
 struct at_xdmac {
 	struct dma_device	dma;
 	void __iomem		*regs;
+	struct device		*dev;
 	int			irq;
 	struct clk		*clk;
 	u32			save_gim;
@@ -361,13 +363,65 @@ MODULE_PARM_DESC(init_nr_desc_per_channel,
 		 "initial descriptors per channel (default: 64)");
 
 
+static void at_xdmac_runtime_suspend_descriptors(struct at_xdmac_chan *atchan)
+{
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
+	struct at_xdmac_desc	*desc, *_desc;
+
+	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
+		if (!desc->active_xfer)
+			continue;
+
+		pm_runtime_mark_last_busy(atxdmac->dev);
+		pm_runtime_put_autosuspend(atxdmac->dev);
+	}
+}
+
+static int at_xdmac_runtime_resume_descriptors(struct at_xdmac_chan *atchan)
+{
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
+	struct at_xdmac_desc	*desc, *_desc;
+	int			ret;
+
+	list_for_each_entry_safe(desc, _desc, &atchan->xfers_list, xfer_node) {
+		if (!desc->active_xfer)
+			continue;
+
+		ret = pm_runtime_resume_and_get(atxdmac->dev);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
 static bool at_xdmac_chan_is_enabled(struct at_xdmac_chan *atchan)
 {
-	return at_xdmac_chan_read(atchan, AT_XDMAC_GS) & atchan->mask;
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(atxdmac->dev);
+	if (ret < 0)
+		return false;
+
+	ret = !!(at_xdmac_chan_read(atchan, AT_XDMAC_GS) & atchan->mask);
+
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
+
+	return ret;
 }
 
 static void at_xdmac_off(struct at_xdmac *atxdmac)
 {
+	struct dma_chan		*chan, *_chan;
+	struct at_xdmac_chan	*atchan;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(atxdmac->dev);
+	if (ret < 0)
+		return;
+
 	at_xdmac_write(atxdmac, AT_XDMAC_GD, -1L);
 
 	/* Wait that all chans are disabled. */
@@ -375,6 +429,18 @@ static void at_xdmac_off(struct at_xdmac *atxdmac)
 		cpu_relax();
 
 	at_xdmac_write(atxdmac, AT_XDMAC_GID, -1L);
+
+	/* Decrement runtime PM ref counter for each active descriptor. */
+	if (!list_empty(&atxdmac->dma.channels)) {
+		list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels,
+					 device_node) {
+			atchan = to_at_xdmac_chan(chan);
+			at_xdmac_runtime_suspend_descriptors(atchan);
+		}
+	}
+
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
 }
 
 /* Call with lock hold. */
@@ -383,6 +449,11 @@ static void at_xdmac_start_xfer(struct at_xdmac_chan *atchan,
 {
 	struct at_xdmac	*atxdmac = to_at_xdmac(atchan->chan.device);
 	u32		reg;
+	int		ret;
+
+	ret = pm_runtime_resume_and_get(atxdmac->dev);
+	if (ret < 0)
+		return;
 
 	dev_vdbg(chan2dev(&atchan->chan), "%s: desc 0x%p\n", __func__, first);
 
@@ -1463,7 +1534,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	struct at_xdmac_desc	*desc, *_desc, *iter;
 	struct list_head	*descs_list;
 	enum dma_status		ret;
-	int			residue, retry;
+	int			residue, retry, pm_status;
 	u32			cur_nda, check_nda, cur_ubc, mask, value;
 	u8			dwidth = 0;
 	unsigned long		flags;
@@ -1473,6 +1544,10 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 	if (ret == DMA_COMPLETE || !txstate)
 		return ret;
 
+	pm_status = pm_runtime_resume_and_get(atxdmac->dev);
+	if (pm_status < 0)
+		return DMA_ERROR;
+
 	spin_lock_irqsave(&atchan->lock, flags);
 
 	desc = list_first_entry(&atchan->xfers_list, struct at_xdmac_desc, xfer_node);
@@ -1590,6 +1665,8 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 spin_unlock:
 	spin_unlock_irqrestore(&atchan->lock, flags);
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
 	return ret;
 }
 
@@ -1636,6 +1713,11 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 {
 	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	struct at_xdmac_desc	*bad_desc;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(atxdmac->dev);
+	if (ret < 0)
+		return;
 
 	/*
 	 * The descriptor currently at the head of the active list is
@@ -1665,12 +1747,16 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 		__func__, &bad_desc->lld.mbr_sa, &bad_desc->lld.mbr_da,
 		bad_desc->lld.mbr_ubc);
 
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
+
 	/* Then continue with usual descriptor management */
 }
 
 static void at_xdmac_tasklet(struct tasklet_struct *t)
 {
 	struct at_xdmac_chan	*atchan = from_tasklet(atchan, t, tasklet);
+	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	struct at_xdmac_desc	*desc;
 	struct dma_async_tx_descriptor *txd;
 	u32			error_mask;
@@ -1720,6 +1806,13 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 	list_splice_tail_init(&desc->descs_list, &atchan->free_descs_list);
 	at_xdmac_advance_work(atchan);
 	spin_unlock_irq(&atchan->lock);
+
+	/*
+	 * Decrement runtime PM ref counter incremented in
+	 * at_xdmac_start_xfer().
+	 */
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
 }
 
 static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
@@ -1811,19 +1904,31 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	unsigned long		flags;
+	int			ret;
 
 	dev_dbg(chan2dev(chan), "%s\n", __func__);
 
 	if (test_and_set_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status))
 		return 0;
 
+	ret = pm_runtime_resume_and_get(atxdmac->dev);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_irqsave(&atchan->lock, flags);
 	at_xdmac_write(atxdmac, atxdmac->layout->grws, atchan->mask);
 	while (at_xdmac_chan_read(atchan, AT_XDMAC_CC)
 	       & (AT_XDMAC_CC_WRIP | AT_XDMAC_CC_RDIP))
 		cpu_relax();
+
+	/* Decrement runtime PM ref counter for each active descriptor. */
+	at_xdmac_runtime_suspend_descriptors(atchan);
+
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
+
 	return 0;
 }
 
@@ -1832,20 +1937,32 @@ static int at_xdmac_device_resume(struct dma_chan *chan)
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	unsigned long		flags;
+	int			ret;
 
 	dev_dbg(chan2dev(chan), "%s\n", __func__);
 
+	ret = pm_runtime_resume_and_get(atxdmac->dev);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_irqsave(&atchan->lock, flags);
-	if (!at_xdmac_chan_is_paused(atchan)) {
-		spin_unlock_irqrestore(&atchan->lock, flags);
-		return 0;
-	}
+	if (!at_xdmac_chan_is_paused(atchan))
+		goto unlock;
+
+	/* Increment runtime PM ref counter for each active descriptor. */
+	ret = at_xdmac_runtime_resume_descriptors(atchan);
+	if (ret < 0)
+		goto unlock;
 
 	at_xdmac_write(atxdmac, atxdmac->layout->grwr, atchan->mask);
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
+
+unlock:
 	spin_unlock_irqrestore(&atchan->lock, flags);
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
 
-	return 0;
+	return ret;
 }
 
 static int at_xdmac_device_terminate_all(struct dma_chan *chan)
@@ -1854,9 +1971,14 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 	struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
 	struct at_xdmac		*atxdmac = to_at_xdmac(atchan->chan.device);
 	unsigned long		flags;
+	int			ret;
 
 	dev_dbg(chan2dev(chan), "%s\n", __func__);
 
+	ret = pm_runtime_resume_and_get(atxdmac->dev);
+	if (ret < 0)
+		return ret;
+
 	spin_lock_irqsave(&atchan->lock, flags);
 	at_xdmac_write(atxdmac, AT_XDMAC_GD, atchan->mask);
 	while (at_xdmac_read(atxdmac, AT_XDMAC_GS) & atchan->mask)
@@ -1867,12 +1989,24 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 		list_del(&desc->xfer_node);
 		list_splice_tail_init(&desc->descs_list,
 				      &atchan->free_descs_list);
+		/*
+		 * We incremented the runtime PM reference count on
+		 * at_xdmac_start_xfer() for this descriptor. Now it's time
+		 * to release it.
+		 */
+		if (desc->active_xfer) {
+			pm_runtime_put_autosuspend(atxdmac->dev);
+			pm_runtime_mark_last_busy(atxdmac->dev);
+		}
 	}
 
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
 	clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
+
 	return 0;
 }
 
@@ -1974,6 +2108,11 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 {
 	struct at_xdmac		*atxdmac = dev_get_drvdata(dev);
 	struct dma_chan		*chan, *_chan;
+	int			ret;
+
+	ret = pm_runtime_resume_and_get(atxdmac->dev);
+	if (ret < 0)
+		return ret;
 
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
 		struct at_xdmac_chan	*atchan = to_at_xdmac_chan(chan);
@@ -1986,12 +2125,13 @@ static int __maybe_unused atmel_xdmac_suspend(struct device *dev)
 			atchan->save_cnda = at_xdmac_chan_read(atchan, AT_XDMAC_CNDA);
 			atchan->save_cndc = at_xdmac_chan_read(atchan, AT_XDMAC_CNDC);
 		}
+
+		at_xdmac_runtime_suspend_descriptors(atchan);
 	}
 	atxdmac->save_gim = at_xdmac_read(atxdmac, AT_XDMAC_GIM);
 
 	at_xdmac_off(atxdmac);
-	clk_disable_unprepare(atxdmac->clk);
-	return 0;
+	return pm_runtime_force_suspend(atxdmac->dev);
 }
 
 static int __maybe_unused atmel_xdmac_resume(struct device *dev)
@@ -2003,8 +2143,8 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 	int			i;
 	int ret;
 
-	ret = clk_prepare_enable(atxdmac->clk);
-	if (ret)
+	ret = pm_runtime_force_resume(atxdmac->dev);
+	if (ret < 0)
 		return ret;
 
 	at_xdmac_axi_config(pdev);
@@ -2019,6 +2159,11 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 	at_xdmac_write(atxdmac, AT_XDMAC_GIE, atxdmac->save_gim);
 	list_for_each_entry_safe(chan, _chan, &atxdmac->dma.channels, device_node) {
 		atchan = to_at_xdmac_chan(chan);
+
+		ret = at_xdmac_runtime_resume_descriptors(atchan);
+		if (ret < 0)
+			return ret;
+
 		at_xdmac_chan_write(atchan, AT_XDMAC_CC, atchan->save_cc);
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			if (at_xdmac_chan_is_paused(atchan))
@@ -2030,9 +2175,29 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 			at_xdmac_write(atxdmac, AT_XDMAC_GE, atchan->mask);
 		}
 	}
+
+	pm_runtime_mark_last_busy(atxdmac->dev);
+	pm_runtime_put_autosuspend(atxdmac->dev);
+
+	return 0;
+}
+
+static int __maybe_unused atmel_xdmac_runtime_suspend(struct device *dev)
+{
+	struct at_xdmac *atxdmac = dev_get_drvdata(dev);
+
+	clk_disable(atxdmac->clk);
+
 	return 0;
 }
 
+static int __maybe_unused atmel_xdmac_runtime_resume(struct device *dev)
+{
+	struct at_xdmac *atxdmac = dev_get_drvdata(dev);
+
+	return clk_enable(atxdmac->clk);
+}
+
 static int at_xdmac_probe(struct platform_device *pdev)
 {
 	struct at_xdmac	*atxdmac;
@@ -2071,6 +2236,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 
 	atxdmac->regs = base;
 	atxdmac->irq = irq;
+	atxdmac->dev = &pdev->dev;
 
 	atxdmac->layout = of_device_get_match_data(&pdev->dev);
 	if (!atxdmac->layout)
@@ -2135,11 +2301,20 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	atxdmac->dma.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	atxdmac->dma.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 
-	/* Disable all chans and interrupts. */
-	at_xdmac_off(atxdmac);
+	platform_set_drvdata(pdev, atxdmac);
+
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
 
 	/* Init channels. */
 	INIT_LIST_HEAD(&atxdmac->dma.channels);
+
+	/* Disable all chans and interrupts. */
+	at_xdmac_off(atxdmac);
+
 	for (i = 0; i < nr_channels; i++) {
 		struct at_xdmac_chan *atchan = &atxdmac->chan[i];
 
@@ -2159,12 +2334,11 @@ static int at_xdmac_probe(struct platform_device *pdev)
 		while (at_xdmac_chan_read(atchan, AT_XDMAC_CIS))
 			cpu_relax();
 	}
-	platform_set_drvdata(pdev, atxdmac);
 
 	ret = dma_async_device_register(&atxdmac->dma);
 	if (ret) {
 		dev_err(&pdev->dev, "fail to register DMA engine device\n");
-		goto err_clk_disable;
+		goto err_pm_disable;
 	}
 
 	ret = of_dma_controller_register(pdev->dev.of_node,
@@ -2179,10 +2353,18 @@ static int at_xdmac_probe(struct platform_device *pdev)
 
 	at_xdmac_axi_config(pdev);
 
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_put_autosuspend(&pdev->dev);
+
 	return 0;
 
 err_dma_unregister:
 	dma_async_device_unregister(&atxdmac->dma);
+err_pm_disable:
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 err_clk_disable:
 	clk_disable_unprepare(atxdmac->clk);
 err_free_irq:
@@ -2198,6 +2380,9 @@ static int at_xdmac_remove(struct platform_device *pdev)
 	at_xdmac_off(atxdmac);
 	of_dma_controller_free(pdev->dev.of_node);
 	dma_async_device_unregister(&atxdmac->dma);
+	pm_runtime_disable(atxdmac->dev);
+	pm_runtime_set_suspended(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	clk_disable_unprepare(atxdmac->clk);
 
 	free_irq(atxdmac->irq, atxdmac);
@@ -2215,6 +2400,8 @@ static int at_xdmac_remove(struct platform_device *pdev)
 static const struct dev_pm_ops __maybe_unused atmel_xdmac_dev_pm_ops = {
 	.prepare	= atmel_xdmac_prepare,
 	SET_LATE_SYSTEM_SLEEP_PM_OPS(atmel_xdmac_suspend, atmel_xdmac_resume)
+	SET_RUNTIME_PM_OPS(atmel_xdmac_runtime_suspend,
+			   atmel_xdmac_runtime_resume, NULL)
 };
 
 static const struct of_device_id atmel_xdmac_dt_ids[] = {
-- 
2.34.1

