Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 366E37563D4
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jul 2023 15:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGQNIr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 17 Jul 2023 09:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjGQNIq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 17 Jul 2023 09:08:46 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C13BF;
        Mon, 17 Jul 2023 06:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689599325;
  x=1721135325;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=m47Nyp4j7qnNrjFm6981seetXlV8yIDNlRQsU477N3c=;
  b=fMDmRyle3htILtf+wv0ad5vIyTHVAowyZhhlA34Js3D50hRwhKa4YRQC
   xmoE7LxncxlkkN4O5uGsBIQrdnFC21gVFceVjhhVQLGeSjG2k7qDEvJb+
   ghCnpWpw/wkIsXjmrXW6hdN1V69MEQ6LE1Ob+fgu/xFgTFZjIGfpxZCvw
   //CHhERKwCONPdkBwi0MbXKZ07adEXyQbz+rgn1uQgfnTbLPYe5c1o4XV
   oJ0Hbb6o+t7kOQHybzDZu6vTjfRZESGKfJ5Alu7CBpnnAytiqDYsSEyGm
   NSG1ObEeazeYwUn/qzNaCn7jU1xCX17n7MEcumEew10ZEUSRKGV1Y+PhS
   g==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Mon, 17 Jul 2023 15:08:40 +0200
Subject: [PATCH 1/2] dmaengine: Fix use-after-free on release
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230717-dummy-dmac-v1-1-24348b6fb56b@axis.com>
References: <20230717-dummy-dmac-v1-0-24348b6fb56b@axis.com>
In-Reply-To: <20230717-dummy-dmac-v1-0-24348b6fb56b@axis.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Many dmaengine drivers cannot be safely unbound while being used since
they free their device structures in their platform driver ->remove()
callbacks or with devm.  In order to avoid this, the framework allows
drivers to implement ->device_release() and free these structures there
instead.  However, there are use-after-frees in the framework even when
->device_release() is implemented.

For example, the following sequence of commands with the upcoming
dummy-dmac driver triggers a KASAN splat without this patch:

 # insmod dummy-dmac.ko
 # insmod dmatest.ko iterations=1 wait=1 run=1
 # echo dummy-dmac > /sys/bus/platform/drivers/dummy-dmac/unbind
 # rmmod dmatest

 ==================================================================
 BUG: KASAN: slab-use-after-free in dma_chan_put (drivers/dma/dmaengine.c:517)
 Read of size 8 at addr ffff888008b00c78 by task rmmod/1063

 Call Trace:
  dma_chan_put (drivers/dma/dmaengine.c:517)
  dma_release_channel (drivers/dma/dmaengine.c:910)
  cleanup_module (drivers/dma/dmatest.c:1184) dmatest
  ...

 Allocated by task 859:
  kmalloc_trace (mm/slab_common.c:1082)
  dummy_dmac_probe (drivers/dma/dummy-dmac.c:171) dummy_dmac
  platform_probe (drivers/base/platform.c:1405)
  ...

 Freed by task 1063:
  kfree (mm/slab_common.c:1035)
  dummy_dmac_release (drivers/dma/dummy-dmac.c:160) dummy_dmac
  dma_device_put (include/linux/kref.h:65 drivers/dma/dmaengine.c:437)
  dma_chan_put (drivers/dma/dmaengine.c:517)
  dma_release_channel (drivers/dma/dmaengine.c:910)
  cleanup_module (drivers/dma/dmatest.c:1184) dmatest
  ...
 ==================================================================

Fix this by making the framework not touch the dev and client structures
after the last call to dma_device_put().

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/dma/dmaengine.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 826b98284fa1..86b892df8ea1 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -485,13 +485,7 @@ static int dma_chan_get(struct dma_chan *chan)
 	return ret;
 }
 
-/**
- * dma_chan_put - drop a reference to a DMA channel's parent driver module
- * @chan:	channel to release
- *
- * Must be called under dma_list_mutex.
- */
-static void dma_chan_put(struct dma_chan *chan)
+static void __dma_chan_put(struct dma_chan *chan)
 {
 	/* This channel is not in use, bail out */
 	if (!chan->client_count)
@@ -512,9 +506,22 @@ static void dma_chan_put(struct dma_chan *chan)
 		chan->router = NULL;
 		chan->route_data = NULL;
 	}
+}
+
+/**
+ * dma_chan_put - drop a reference to a DMA channel's parent driver module
+ * @chan:	channel to release
+ *
+ * Must be called under dma_list_mutex.
+ */
+static void dma_chan_put(struct dma_chan *chan)
+{
+	struct module *owner = dma_chan_to_owner(chan);
+
+	__dma_chan_put(chan);
 
 	dma_device_put(chan->device);
-	module_put(dma_chan_to_owner(chan));
+	module_put(owner);
 }
 
 enum dma_status dma_sync_wait(struct dma_chan *chan, dma_cookie_t cookie)
@@ -902,10 +909,12 @@ EXPORT_SYMBOL_GPL(dma_request_chan_by_mask);
 
 void dma_release_channel(struct dma_chan *chan)
 {
+	struct module *owner = dma_chan_to_owner(chan);
+
 	mutex_lock(&dma_list_mutex);
 	WARN_ONCE(chan->client_count != 1,
 		  "chan reference count %d != 1\n", chan->client_count);
-	dma_chan_put(chan);
+	__dma_chan_put(chan);
 	/* drop PRIVATE cap enabled by __dma_request_channel() */
 	if (--chan->device->privatecnt == 0)
 		dma_cap_clear(DMA_PRIVATE, chan->device->cap_mask);
@@ -922,6 +931,9 @@ void dma_release_channel(struct dma_chan *chan)
 	kfree(chan->dbg_client_name);
 	chan->dbg_client_name = NULL;
 #endif
+
+	dma_device_put(chan->device);
+	module_put(owner);
 	mutex_unlock(&dma_list_mutex);
 }
 EXPORT_SYMBOL_GPL(dma_release_channel);

-- 
2.34.1

