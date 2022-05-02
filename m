Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C918D516CE0
	for <lists+dmaengine@lfdr.de>; Mon,  2 May 2022 11:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350627AbiEBJGP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384016AbiEBJGJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 05:06:09 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F33583AD;
        Mon,  2 May 2022 02:02:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 218CE419C2;
        Mon,  2 May 2022 09:02:32 +0000 (UTC)
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
Subject: [PATCH 1/7] mailbox: zynq: Remove unused zynqmp_ipi_peek_data
Date:   Mon,  2 May 2022 18:02:19 +0900
Message-Id: <20220502090225.26478-2-marcan@marcan.st>
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

This op was ambiguously specified, and the way it was interpreted for
this implementation is not useful. It has no users, so remove it.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 41 ----------------------------
 1 file changed, 41 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 31a0fa914274..7c3ef7c8078e 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -177,46 +177,6 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
 	return IRQ_NONE;
 }
 
-/**
- * zynqmp_ipi_peek_data - Peek to see if there are any rx messages.
- *
- * @chan: Channel Pointer
- *
- * Return: 'true' if there is pending rx data, 'false' if there is none.
- */
-static bool zynqmp_ipi_peek_data(struct mbox_chan *chan)
-{
-	struct device *dev = chan->mbox->dev;
-	struct zynqmp_ipi_mbox *ipi_mbox = dev_get_drvdata(dev);
-	struct zynqmp_ipi_mchan *mchan = chan->con_priv;
-	int ret;
-	u64 arg0;
-	struct arm_smccc_res res;
-
-	if (WARN_ON(!ipi_mbox)) {
-		dev_err(dev, "no platform drv data??\n");
-		return false;
-	}
-
-	arg0 = SMC_IPI_MAILBOX_STATUS_ENQUIRY;
-	zynqmp_ipi_fw_call(ipi_mbox, arg0, 0, &res);
-	ret = (int)(res.a0 & 0xFFFFFFFF);
-
-	if (mchan->chan_type == IPI_MB_CHNL_TX) {
-		/* TX channel, check if the message has been acked
-		 * by the remote, if yes, response is available.
-		 */
-		if (ret < 0 || ret & IPI_MB_STATUS_SEND_PENDING)
-			return false;
-		else
-			return true;
-	} else if (ret > 0 && ret & IPI_MB_STATUS_RECV_PENDING) {
-		/* RX channel, check if there is message arrived. */
-		return true;
-	}
-	return false;
-}
-
 /**
  * zynqmp_ipi_last_tx_done - See if the last tx message is sent
  *
@@ -387,7 +347,6 @@ static void zynqmp_ipi_shutdown(struct mbox_chan *chan)
 static const struct mbox_chan_ops zynqmp_ipi_chan_ops = {
 	.startup = zynqmp_ipi_startup,
 	.shutdown = zynqmp_ipi_shutdown,
-	.peek_data = zynqmp_ipi_peek_data,
 	.last_tx_done = zynqmp_ipi_last_tx_done,
 	.send_data = zynqmp_ipi_send_data,
 };
-- 
2.35.1

