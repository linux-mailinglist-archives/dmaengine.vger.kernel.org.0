Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE4AB516CE2
	for <lists+dmaengine@lfdr.de>; Mon,  2 May 2022 11:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384069AbiEBJGZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 05:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384055AbiEBJGQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 05:06:16 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ABDA583AD;
        Mon,  2 May 2022 02:02:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 90BE54206F;
        Mon,  2 May 2022 09:02:42 +0000 (UTC)
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
Subject: [PATCH 3/7] mailbox: ti-msgmgr Remove unused ti_msgmgr_queue_peek_data
Date:   Mon,  2 May 2022 18:02:21 +0900
Message-Id: <20220502090225.26478-4-marcan@marcan.st>
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

This op was ambiguously specified, and the way it was interpreted for
this implementation is not useful. It has no users, so remove it.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mailbox/ti-msgmgr.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/mailbox/ti-msgmgr.c b/drivers/mailbox/ti-msgmgr.c
index ddac423ac1a9..10881b812df2 100644
--- a/drivers/mailbox/ti-msgmgr.c
+++ b/drivers/mailbox/ti-msgmgr.c
@@ -309,33 +309,6 @@ static irqreturn_t ti_msgmgr_queue_rx_interrupt(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
-/**
- * ti_msgmgr_queue_peek_data() - Peek to see if there are any rx messages.
- * @chan:	Channel Pointer
- *
- * Return: 'true' if there is pending rx data, 'false' if there is none.
- */
-static bool ti_msgmgr_queue_peek_data(struct mbox_chan *chan)
-{
-	struct ti_queue_inst *qinst = chan->con_priv;
-	struct device *dev = chan->mbox->dev;
-	struct ti_msgmgr_inst *inst = dev_get_drvdata(dev);
-	const struct ti_msgmgr_desc *desc = inst->desc;
-	int msg_count;
-
-	if (qinst->is_tx)
-		return false;
-
-	if (ti_msgmgr_queue_is_error(desc, qinst)) {
-		dev_err(dev, "Error on channel %s\n", qinst->name);
-		return false;
-	}
-
-	msg_count = ti_msgmgr_queue_get_num_messages(desc, qinst);
-
-	return msg_count ? true : false;
-}
-
 /**
  * ti_msgmgr_last_tx_done() - See if all the tx messages are sent
  * @chan:	Channel pointer
@@ -744,7 +717,6 @@ static DEFINE_SIMPLE_DEV_PM_OPS(ti_msgmgr_pm_ops, ti_msgmgr_suspend, ti_msgmgr_r
 static const struct mbox_chan_ops ti_msgmgr_chan_ops = {
 	.startup = ti_msgmgr_queue_startup,
 	.shutdown = ti_msgmgr_queue_shutdown,
-	.peek_data = ti_msgmgr_queue_peek_data,
 	.last_tx_done = ti_msgmgr_last_tx_done,
 	.send_data = ti_msgmgr_send_data,
 };
-- 
2.35.1

