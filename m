Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7927A516CEA
	for <lists+dmaengine@lfdr.de>; Mon,  2 May 2022 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384036AbiEBJGi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 05:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384064AbiEBJGg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 05:06:36 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747258E76;
        Mon,  2 May 2022 02:03:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 8D5DF419B4;
        Mon,  2 May 2022 09:03:01 +0000 (UTC)
From:   Hector Martin <marcan@marcan.st>
Cc:     Hector Martin <marcan@marcan.st>,
        Anup Patel <anup.patel@broadcom.com>,
        Vinod Koul <vkoul@kernel.org>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 7/7] mailbox: apple: Implement poll_data() operation
Date:   Mon,  2 May 2022 18:02:25 +0900
Message-Id: <20220502090225.26478-8-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502090225.26478-1-marcan@marcan.st>
References: <20220502090225.26478-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This allows clients running in atomic context to poll for messages to
arrive.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mailbox/apple-mailbox.c | 37 ++++++++++++++++++++++++++++++---
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/mailbox/apple-mailbox.c b/drivers/mailbox/apple-mailbox.c
index 33e7acf71e3e..e0c2bf7c6338 100644
--- a/drivers/mailbox/apple-mailbox.c
+++ b/drivers/mailbox/apple-mailbox.c
@@ -26,6 +26,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/spinlock.h>
 #include <linux/types.h>
 
 #define APPLE_ASC_MBOX_CONTROL_FULL  BIT(16)
@@ -101,6 +102,7 @@ struct apple_mbox {
 
 	struct device *dev;
 	struct mbox_controller controller;
+	spinlock_t rx_lock;
 };
 
 static const struct of_device_id apple_mbox_of_match[];
@@ -204,13 +206,16 @@ static irqreturn_t apple_mbox_send_empty_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
+static int apple_mbox_poll_data(struct apple_mbox *apple_mbox)
 {
-	struct apple_mbox *apple_mbox = data;
+
 	struct apple_mbox_msg msg;
+	int ret = 0;
 
-	while (apple_mbox_hw_recv(apple_mbox, &msg) == 0)
+	while (apple_mbox_hw_recv(apple_mbox, &msg) == 0) {
 		mbox_chan_received_data(&apple_mbox->chan, (void *)&msg);
+		ret++;
+	}
 
 	/*
 	 * The interrupt will keep firing even if there are no more messages
@@ -225,9 +230,33 @@ static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
 			       apple_mbox->regs + apple_mbox->hw->irq_ack);
 	}
 
+	return ret;
+}
+
+static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
+{
+	struct apple_mbox *apple_mbox = data;
+
+	spin_lock(&apple_mbox->rx_lock);
+	apple_mbox_poll_data(apple_mbox);
+	spin_unlock(&apple_mbox->rx_lock);
+
 	return IRQ_HANDLED;
 }
 
+static bool apple_mbox_chan_poll_data(struct mbox_chan *chan)
+{
+	struct apple_mbox *apple_mbox = chan->con_priv;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&apple_mbox->rx_lock, flags);
+	ret = apple_mbox_poll_data(apple_mbox);
+	spin_unlock_irqrestore(&apple_mbox->rx_lock, flags);
+
+	return ret > 0;
+}
+
 static int apple_mbox_chan_flush(struct mbox_chan *chan, unsigned long timeout)
 {
 	struct apple_mbox *apple_mbox = chan->con_priv;
@@ -276,6 +305,7 @@ static void apple_mbox_chan_shutdown(struct mbox_chan *chan)
 
 static const struct mbox_chan_ops apple_mbox_ops = {
 	.send_data = apple_mbox_chan_send_data,
+	.poll_data = apple_mbox_chan_poll_data,
 	.flush = apple_mbox_chan_flush,
 	.startup = apple_mbox_chan_startup,
 	.shutdown = apple_mbox_chan_shutdown,
@@ -331,6 +361,7 @@ static int apple_mbox_probe(struct platform_device *pdev)
 	mbox->controller.txdone_irq = true;
 	mbox->controller.of_xlate = apple_mbox_of_xlate;
 	mbox->chan.con_priv = mbox;
+	spin_lock_init(&mbox->rx_lock);
 
 	irqname = devm_kasprintf(dev, GFP_KERNEL, "%s-recv", dev_name(dev));
 	if (!irqname)
-- 
2.35.1

