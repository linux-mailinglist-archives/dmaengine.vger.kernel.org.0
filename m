Return-Path: <dmaengine+bounces-1120-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6618D868384
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 23:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C391C22F53
	for <lists+dmaengine@lfdr.de>; Mon, 26 Feb 2024 22:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340B6130E3E;
	Mon, 26 Feb 2024 22:17:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE651DFCD
	for <dmaengine@vger.kernel.org>; Mon, 26 Feb 2024 22:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985851; cv=none; b=Q52W5nVNIfJF0kwWJoShOIZ2AIc/trGQOwPuJ24Baef5N/HVrfvl6fr7SVwjHfaCIaATPb1iWSlBVOOpRWNIlNaqo5NwT0B8iYHrpGdPghumPen/XN+5zVdvPI1Y/L8p7ivl8qH5XuaxEmcOEKjBcpcEOzKiCvezGaY41drB+uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985851; c=relaxed/simple;
	bh=aLv4WktZkn96ms4u4GvFX2+e3tEfzxPE+7i1i6ObU2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=f5VWfJKq/iVIkoRSBz1EwojpAoRuYY4qbo0PZSDLM5V9B39tTnAs664L40hZbLgnlfFshoVMZ51Wfso7E2F2fp9Yw5sIVG/6j22pEA0Ih4wmV2famg1qN/IVha9mFWX4Q88u/t3Obf39J3T2EQmy/k8Wyac7QNNI2PquXdT2jGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rejHi-0005pb-NL; Mon, 26 Feb 2024 23:17:18 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rejHh-0034rN-3d; Mon, 26 Feb 2024 23:17:17 +0100
Received: from localhost ([::1] helo=dude04.red.stw.pengutronix.de)
	by dude04.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <m.grzeschik@pengutronix.de>)
	id 1rejHh-00EbQZ-0B;
	Mon, 26 Feb 2024 23:17:17 +0100
From: Michael Grzeschik <m.grzeschik@pengutronix.de>
Date: Mon, 26 Feb 2024 23:17:16 +0100
Subject: [PATCH] dmaengine: zynqmp_dma: rework tasklet to threaded
 interrupt handler
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-zynqmp-dma-tasklet-irqthread-v1-1-2d154d6238fd@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAOsN3WUC/x2NMQ7CMAwAv1J5xlJqFQa+ghjcxCUWaWidgICqf
 ydivBvuNihiKgXO3QYmLy36yA36Qwc+cr4JamgM5GhwRCf8fvI6LxhmxsrlnqSi2lqjCQfsj4P
 zkxD3nqAlRi6Co3H2sUXyM6UmF5NJ3//n5brvP+94EzSDAAAA
To: Vinod Koul <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Michael Grzeschik <m.grzeschik@pengutronix.de>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5012;
 i=m.grzeschik@pengutronix.de; h=from:subject:message-id;
 bh=aLv4WktZkn96ms4u4GvFX2+e3tEfzxPE+7i1i6ObU2k=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBl3Q3sUeiaCcwc0Q/53FOLGNHhLUILuumc1CcGs
 zrRC//TO1yJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCZd0N7AAKCRC/aVhE+XH0
 q/iXD/sGZMnr6rjlkvxOM56Y0lvwvxGZpmYcKqx0Be03p3SFJOnFmxBTx7g2s/S0r00R2qhlTpL
 jlYbk1ml90/RyM0faymAb8MvhTtwSHm5QmZJTx5r8V8cNuqGlFXv/xtLmMebWxodFSof4tO+UJj
 XveT7FRqxWJ8qNbzALDUSjYoXTeVyoAPb0gmvteXdN9rxOhCXYOaCS5BN4aUmlnc9oA62487cca
 2UvbfVW8ncrVLDs2sLdwTThfZH06OzDmkS1gIfgWM0yui1QiW8h6RMpfUFFPGXSwp/ENAGILTu2
 PrOawfESc5ekUN5A0zRxbJ2jUkZIC4Y1iOsU05O0JJ4hokzegT3T2mAvwlTFJ6GYOAwvfqAO9k8
 JSWlsOJPRfvzE73kNvPsey2YhIRGY6jS62M7k4txRkPAsN5exgpVfCmGhVCje8Z5ByDYuAjVt6Z
 z4zbDEeEuBv/r9C4fi7n8Fjb4BiF+5gTZgGEMJ2sxpiLx07N4GbyiI77I8yaFLjhl8n4mcQh8M5
 OvPtwVJPpCgcjBVHHiQ0dbVxjbAl20IFk4eIPON0gCl+Kkmokr8laKJmPbQTY95G62flbSeorCL
 HT0jvBhlIqzq7udMXm9GivFXPVjREF3UCum2xnsPV6sj2uIef5//0nUvD2UR+nucRLy6YO0Lc3s
 HyKMsxlH3mkUlVw==
X-Developer-Key: i=m.grzeschik@pengutronix.de; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: m.grzeschik@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: dmaengine@vger.kernel.org

Since the tasklets are being scheduled with low priority the actual work
will be delayed for unseen time. Also this is a driver that probably
other drivers depend on its work to be done early. So we move the
actual work from an tasklet to an threaded interrupt handler and
therefor increase the priority for the scheduler.

Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
---
 drivers/dma/xilinx/zynqmp_dma.c | 36 +++++++++++-------------------------
 1 file changed, 11 insertions(+), 25 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f31631bef961a..09173ef6d24bc 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -204,7 +204,6 @@ struct zynqmp_dma_desc_sw {
  * @dev: The dma device
  * @irq: Channel IRQ
  * @is_dmacoherent: Tells whether dma operations are coherent or not
- * @tasklet: Cleanup work after irq
  * @idle : Channel status;
  * @desc_size: Size of the low level descriptor
  * @err: Channel has errors
@@ -228,7 +227,6 @@ struct zynqmp_dma_chan {
 	struct device *dev;
 	int irq;
 	bool is_dmacoherent;
-	struct tasklet_struct tasklet;
 	bool idle;
 	size_t desc_size;
 	bool err;
@@ -724,8 +722,7 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 
 	writel(isr, chan->regs + ZYNQMP_DMA_ISR);
 	if (status & ZYNQMP_DMA_INT_DONE) {
-		tasklet_schedule(&chan->tasklet);
-		ret = IRQ_HANDLED;
+		ret = IRQ_WAKE_THREAD;
 	}
 
 	if (status & ZYNQMP_DMA_DONE)
@@ -733,9 +730,8 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 
 	if (status & ZYNQMP_DMA_INT_ERR) {
 		chan->err = true;
-		tasklet_schedule(&chan->tasklet);
 		dev_err(chan->dev, "Channel %p has errors\n", chan);
-		ret = IRQ_HANDLED;
+		ret = IRQ_WAKE_THREAD;
 	}
 
 	if (status & ZYNQMP_DMA_INT_OVRFL) {
@@ -748,19 +744,20 @@ static irqreturn_t zynqmp_dma_irq_handler(int irq, void *data)
 }
 
 /**
- * zynqmp_dma_do_tasklet - Schedule completion tasklet
+ * zynqmp_dma_irq_thread - Interrupt thread function
  * @t: Pointer to the ZynqMP DMA channel structure
  */
-static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
+static irqreturn_t zynqmp_dma_irq_thread(int irq, void *data)
 {
-	struct zynqmp_dma_chan *chan = from_tasklet(chan, t, tasklet);
+	struct zynqmp_dma_chan *chan = (struct zynqmp_dma_chan *)data;
 	u32 count;
 	unsigned long irqflags;
 
 	if (chan->err) {
 		zynqmp_dma_reset(chan);
 		chan->err = false;
-		return;
+
+		return IRQ_HANDLED;
 	}
 
 	spin_lock_irqsave(&chan->lock, irqflags);
@@ -778,6 +775,8 @@ static void zynqmp_dma_do_tasklet(struct tasklet_struct *t)
 		zynqmp_dma_start_transfer(chan);
 		spin_unlock_irqrestore(&chan->lock, irqflags);
 	}
+
+	return IRQ_HANDLED;
 }
 
 /**
@@ -796,17 +795,6 @@ static int zynqmp_dma_device_terminate_all(struct dma_chan *dchan)
 	return 0;
 }
 
-/**
- * zynqmp_dma_synchronize - Synchronizes the termination of a transfers to the current context.
- * @dchan: DMA channel pointer
- */
-static void zynqmp_dma_synchronize(struct dma_chan *dchan)
-{
-	struct zynqmp_dma_chan *chan = to_chan(dchan);
-
-	tasklet_kill(&chan->tasklet);
-}
-
 /**
  * zynqmp_dma_prep_memcpy - prepare descriptors for memcpy transaction
  * @dchan: DMA channel
@@ -876,7 +864,6 @@ static void zynqmp_dma_chan_remove(struct zynqmp_dma_chan *chan)
 
 	if (chan->irq)
 		devm_free_irq(chan->zdev->dev, chan->irq, chan);
-	tasklet_kill(&chan->tasklet);
 	list_del(&chan->common.device_node);
 }
 
@@ -921,7 +908,6 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 
 	chan->is_dmacoherent =  of_property_read_bool(node, "dma-coherent");
 	zdev->chan = chan;
-	tasklet_setup(&chan->tasklet, zynqmp_dma_do_tasklet);
 	spin_lock_init(&chan->lock);
 	INIT_LIST_HEAD(&chan->active_list);
 	INIT_LIST_HEAD(&chan->pending_list);
@@ -936,7 +922,8 @@ static int zynqmp_dma_chan_probe(struct zynqmp_dma_device *zdev,
 	chan->irq = platform_get_irq(pdev, 0);
 	if (chan->irq < 0)
 		return -ENXIO;
-	err = devm_request_irq(&pdev->dev, chan->irq, zynqmp_dma_irq_handler, 0,
+	err = devm_request_threaded_irq(&pdev->dev, chan->irq,
+			       zynqmp_dma_irq_handler, zynqmp_dma_irq_thread, 0,
 			       "zynqmp-dma", chan);
 	if (err)
 		return err;
@@ -1071,7 +1058,6 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	p = &zdev->common;
 	p->device_prep_dma_memcpy = zynqmp_dma_prep_memcpy;
 	p->device_terminate_all = zynqmp_dma_device_terminate_all;
-	p->device_synchronize = zynqmp_dma_synchronize;
 	p->device_issue_pending = zynqmp_dma_issue_pending;
 	p->device_alloc_chan_resources = zynqmp_dma_alloc_chan_resources;
 	p->device_free_chan_resources = zynqmp_dma_free_chan_resources;

---
base-commit: d206a76d7d2726f3b096037f2079ce0bd3ba329b
change-id: 20240226-zynqmp-dma-tasklet-irqthread-1540cfe2a1c2

Best regards,
-- 
Michael Grzeschik <m.grzeschik@pengutronix.de>


