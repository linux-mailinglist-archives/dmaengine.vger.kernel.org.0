Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD9B516CE9
	for <lists+dmaengine@lfdr.de>; Mon,  2 May 2022 11:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384038AbiEBJGf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 May 2022 05:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384071AbiEBJGZ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 2 May 2022 05:06:25 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88C25931E;
        Mon,  2 May 2022 02:02:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 1D9A0422CC;
        Mon,  2 May 2022 09:02:51 +0000 (UTC)
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
Subject: [PATCH 5/7] mailbox: Rename peek_data to poll_data and fix documentation
Date:   Mon,  2 May 2022 18:02:23 +0900
Message-Id: <20220502090225.26478-6-marcan@marcan.st>
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

peek_data was poorly specified and the documentation implied it should
just check for whether there are messages available to be received.
The intent is for this function to be usable in atomic context. Just
checking for available data is not useful; the subsystem needs to
provide some way to poll for (and actually receive) data in atomic
context for this to make sense.

As one might expect, all existing drivers that implemented the "peek"
semantics had zero actual users, since that interpretation of the
feature doesn't lend itself to a useful purpose. There is only one
driver implementing peek_data as a proper poll: flexrm. That also
happens to be the only one with a user.

So, rename peek_data to poll_data and fix the documentation to actually
describe it properly as a synchronous poll for data. Previous patches
already removed the useless implementations, so this only has to fix the
bcm driver and client besides the subsystem.

Signed-off-by: Hector Martin <marcan@marcan.st>
---
 Documentation/driver-api/mailbox.rst |  2 +-
 drivers/dma/bcm-sba-raid.c           |  4 ++--
 drivers/mailbox/bcm-flexrm-mailbox.c |  4 ++--
 drivers/mailbox/mailbox.c            | 25 +++++++++++--------------
 include/linux/mailbox_client.h       |  2 +-
 include/linux/mailbox_controller.h   |  6 +++---
 6 files changed, 20 insertions(+), 23 deletions(-)

diff --git a/Documentation/driver-api/mailbox.rst b/Documentation/driver-api/mailbox.rst
index 0ed95009cc30..e4ccafdb1e00 100644
--- a/Documentation/driver-api/mailbox.rst
+++ b/Documentation/driver-api/mailbox.rst
@@ -27,7 +27,7 @@ Controller Driver (See include/linux/mailbox_controller.h)
 
 
 Allocate mbox_controller and the array of mbox_chan.
-Populate mbox_chan_ops, except peek_data() all are mandatory.
+Populate mbox_chan_ops, except poll_data() all are mandatory.
 The controller driver might know a message has been consumed
 by the remote by getting an IRQ or polling some hardware flag
 or it can never know (the client knows by way of the protocol).
diff --git a/drivers/dma/bcm-sba-raid.c b/drivers/dma/bcm-sba-raid.c
index 64239da02e74..841045ecc449 100644
--- a/drivers/dma/bcm-sba-raid.c
+++ b/drivers/dma/bcm-sba-raid.c
@@ -223,7 +223,7 @@ static struct sba_request *sba_alloc_request(struct sba_device *sba)
 		 * would have completed which will create more
 		 * room for new requests.
 		 */
-		mbox_client_peek_data(sba->mchan);
+		mbox_client_poll_data(sba->mchan);
 		return NULL;
 	}
 
@@ -555,7 +555,7 @@ static enum dma_status sba_tx_status(struct dma_chan *dchan,
 	if (ret == DMA_COMPLETE)
 		return ret;
 
-	mbox_client_peek_data(sba->mchan);
+	mbox_client_poll_data(sba->mchan);
 
 	return dma_cookie_status(dchan, cookie, txstate);
 }
diff --git a/drivers/mailbox/bcm-flexrm-mailbox.c b/drivers/mailbox/bcm-flexrm-mailbox.c
index 22acb51531cb..9decb844eff8 100644
--- a/drivers/mailbox/bcm-flexrm-mailbox.c
+++ b/drivers/mailbox/bcm-flexrm-mailbox.c
@@ -1223,7 +1223,7 @@ static int flexrm_send_data(struct mbox_chan *chan, void *data)
 	return flexrm_new_request(ring, NULL, data);
 }
 
-static bool flexrm_peek_data(struct mbox_chan *chan)
+static bool flexrm_poll_data(struct mbox_chan *chan)
 {
 	int cnt = flexrm_process_completions(chan->con_priv);
 
@@ -1449,7 +1449,7 @@ static const struct mbox_chan_ops flexrm_mbox_chan_ops = {
 	.send_data	= flexrm_send_data,
 	.startup	= flexrm_startup,
 	.shutdown	= flexrm_shutdown,
-	.peek_data	= flexrm_peek_data,
+	.poll_data	= flexrm_poll_data,
 };
 
 static struct mbox_chan *flexrm_mbox_of_xlate(struct mbox_controller *cntlr,
diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
index 3e7d4b20ab34..6b13a7047c64 100644
--- a/drivers/mailbox/mailbox.c
+++ b/drivers/mailbox/mailbox.c
@@ -200,28 +200,25 @@ void mbox_client_txdone(struct mbox_chan *chan, int r)
 EXPORT_SYMBOL_GPL(mbox_client_txdone);
 
 /**
- * mbox_client_peek_data - A way for client driver to pull data
- *			received from remote by the controller.
+ * mbox_client_poll_data - Poll for pending messages from the remote.
  * @chan: Mailbox channel assigned to this client.
  *
- * A poke to controller driver for any received data.
- * The data is actually passed onto client via the
- * mbox_chan_received_data()
- * The call can be made from atomic context, so the controller's
- * implementation of peek_data() must not sleep.
+ * Asks the controller driver to poll for any available data from the remote.
+ * The data will be synchronously delivered via mbox_chan_received_data().
+ * This call can be made from atomic context, so the controller's
+ * implementation of poll_data() must not sleep.
  *
- * Return: True, if controller has, and is going to push after this,
- *          some data.
- *         False, if controller doesn't have any data to be read.
+ * Return: True if the controller received and has processed some data.
+ *         False if controller didn't have any pending data to read.
  */
-bool mbox_client_peek_data(struct mbox_chan *chan)
+bool mbox_client_poll_data(struct mbox_chan *chan)
 {
-	if (chan->mbox->ops->peek_data)
-		return chan->mbox->ops->peek_data(chan);
+	if (chan->mbox->ops->poll_data)
+		return chan->mbox->ops->poll_data(chan);
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(mbox_client_peek_data);
+EXPORT_SYMBOL_GPL(mbox_client_poll_data);
 
 /**
  * mbox_send_message -	For client to submit a message to be
diff --git a/include/linux/mailbox_client.h b/include/linux/mailbox_client.h
index 65229a45590f..ccfc81748295 100644
--- a/include/linux/mailbox_client.h
+++ b/include/linux/mailbox_client.h
@@ -43,7 +43,7 @@ struct mbox_chan *mbox_request_channel(struct mbox_client *cl, int index);
 int mbox_send_message(struct mbox_chan *chan, void *mssg);
 int mbox_flush(struct mbox_chan *chan, unsigned long timeout);
 void mbox_client_txdone(struct mbox_chan *chan, int r); /* atomic */
-bool mbox_client_peek_data(struct mbox_chan *chan); /* atomic */
+bool mbox_client_poll_data(struct mbox_chan *chan); /* atomic */
 void mbox_free_channel(struct mbox_chan *chan); /* may sleep */
 
 #endif /* __MAILBOX_CLIENT_H */
diff --git a/include/linux/mailbox_controller.h b/include/linux/mailbox_controller.h
index 36d6ce673503..70d766e623ac 100644
--- a/include/linux/mailbox_controller.h
+++ b/include/linux/mailbox_controller.h
@@ -40,8 +40,8 @@ struct mbox_chan;
  *		  mode 'send_data' is expected to return -EBUSY.
  *		  The controller may do stuff that need to sleep/block.
  *		  Used only if txdone_poll:=true && txdone_irq:=false
- * @peek_data: Atomic check for any received data. Return true if controller
- *		  has some data to push to the client. False otherwise.
+ * @poll_data:  Poll atomically for received data. Return true if there
+ *		was data available that has been processed. False otherwise.
  */
 struct mbox_chan_ops {
 	int (*send_data)(struct mbox_chan *chan, void *data);
@@ -49,7 +49,7 @@ struct mbox_chan_ops {
 	int (*startup)(struct mbox_chan *chan);
 	void (*shutdown)(struct mbox_chan *chan);
 	bool (*last_tx_done)(struct mbox_chan *chan);
-	bool (*peek_data)(struct mbox_chan *chan);
+	bool (*poll_data)(struct mbox_chan *chan);
 };
 
 /**
-- 
2.35.1

