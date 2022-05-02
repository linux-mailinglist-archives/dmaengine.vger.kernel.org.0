Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24318516CEB
	for <lists+dmaengine@lfdr.de>; Mon,  2 May 2022 11:03:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384059AbiEBJGh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 05:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384058AbiEBJGg (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 05:06:36 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839CA58E70;
        Mon,  2 May 2022 02:03:06 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id CEA984246A;
        Mon,  2 May 2022 09:02:56 +0000 (UTC)
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
Subject: [PATCH 6/7] mailbox: apple: Implement flush() operation
Date:   Mon,  2 May 2022 18:02:24 +0900
Message-Id: <20220502090225.26478-7-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220502090225.26478-1-marcan@marcan.st>
References: <20220502090225.26478-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This allows clients to use the atomic-safe mailbox API style.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mailbox/apple-mailbox.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/mailbox/apple-mailbox.c b/drivers/mailbox/apple-mailbox.c
index 496c4951ccb1..33e7acf71e3e 100644
--- a/drivers/mailbox/apple-mailbox.c
+++ b/drivers/mailbox/apple-mailbox.c
@@ -17,6 +17,7 @@
  */
 
 #include <linux/apple-mailbox.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
 #include <linux/interrupt.h>
@@ -112,6 +113,14 @@ static bool apple_mbox_hw_can_send(struct apple_mbox *apple_mbox)
 	return !(mbox_ctrl & apple_mbox->hw->control_full);
 }
 
+static bool apple_mbox_hw_send_empty(struct apple_mbox *apple_mbox)
+{
+	u32 mbox_ctrl =
+		readl_relaxed(apple_mbox->regs + apple_mbox->hw->a2i_control);
+
+	return mbox_ctrl & apple_mbox->hw->control_empty;
+}
+
 static int apple_mbox_hw_send(struct apple_mbox *apple_mbox,
 			      struct apple_mbox_msg *msg)
 {
@@ -219,6 +228,23 @@ static irqreturn_t apple_mbox_recv_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+static int apple_mbox_chan_flush(struct mbox_chan *chan, unsigned long timeout)
+{
+	struct apple_mbox *apple_mbox = chan->con_priv;
+	unsigned long deadline = jiffies + msecs_to_jiffies(timeout);
+
+	while (time_before(jiffies, deadline)) {
+		if (apple_mbox_hw_send_empty(apple_mbox)) {
+			mbox_chan_txdone(&apple_mbox->chan, 0);
+			return 0;
+		}
+
+		udelay(1);
+	}
+
+	return -ETIME;
+}
+
 static int apple_mbox_chan_startup(struct mbox_chan *chan)
 {
 	struct apple_mbox *apple_mbox = chan->con_priv;
@@ -250,6 +276,7 @@ static void apple_mbox_chan_shutdown(struct mbox_chan *chan)
 
 static const struct mbox_chan_ops apple_mbox_ops = {
 	.send_data = apple_mbox_chan_send_data,
+	.flush = apple_mbox_chan_flush,
 	.startup = apple_mbox_chan_startup,
 	.shutdown = apple_mbox_chan_shutdown,
 };
-- 
2.35.1

