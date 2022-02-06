Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8622B4AAEA7
	for <lists+dmaengine@lfdr.de>; Sun,  6 Feb 2022 10:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiBFJrx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 6 Feb 2022 04:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232006AbiBFJrw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 6 Feb 2022 04:47:52 -0500
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B9BC06173B
        for <dmaengine@vger.kernel.org>; Sun,  6 Feb 2022 01:47:51 -0800 (PST)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id Ge96nocwc41cbGe97nhcYF; Sun, 06 Feb 2022 10:47:49 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Sun, 06 Feb 2022 10:47:49 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        dmaengine@vger.kernel.org
Subject: [PATCH] dmaengine: Remove a useless mutex
Date:   Sun,  6 Feb 2022 10:47:45 +0100
Message-Id: <7180452c1d77b039e27b6f9418e0e7d9dd33c431.1644140845.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

According to lib/idr.c,
   The IDA handles its own locking.  It is safe to call any of the IDA
   functions without synchronisation in your code.

so the 'chan_mutex' mutex can just be removed.
It is here only to protect some ida_alloc()/ida_free() calls.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Un-tested
---
 drivers/dma/dmaengine.c   | 7 -------
 include/linux/dmaengine.h | 1 -
 2 files changed, 8 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2cfa8458b51b..e80feeea0e01 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1053,9 +1053,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	 * When the chan_id is a negative value, we are dynamically adding
 	 * the channel. Otherwise we are static enumerating.
 	 */
-	mutex_lock(&device->chan_mutex);
 	chan->chan_id = ida_alloc(&device->chan_ida, GFP_KERNEL);
-	mutex_unlock(&device->chan_mutex);
 	if (chan->chan_id < 0) {
 		pr_err("%s: unable to alloc ida for chan: %d\n",
 		       __func__, chan->chan_id);
@@ -1078,9 +1076,7 @@ static int __dma_async_device_channel_register(struct dma_device *device,
 	return 0;
 
  err_out_ida:
-	mutex_lock(&device->chan_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
-	mutex_unlock(&device->chan_mutex);
  err_free_dev:
 	kfree(chan->dev);
  err_free_local:
@@ -1113,9 +1109,7 @@ static void __dma_async_device_channel_unregister(struct dma_device *device,
 	device->chancnt--;
 	chan->dev->chan = NULL;
 	mutex_unlock(&dma_list_mutex);
-	mutex_lock(&device->chan_mutex);
 	ida_free(&device->chan_ida, chan->chan_id);
-	mutex_unlock(&device->chan_mutex);
 	device_unregister(&chan->dev->device);
 	free_percpu(chan->local);
 }
@@ -1250,7 +1244,6 @@ int dma_async_device_register(struct dma_device *device)
 	if (rc != 0)
 		return rc;
 
-	mutex_init(&device->chan_mutex);
 	ida_init(&device->chan_ida);
 
 	/* represent channels in sysfs. Probably want devs too */
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 842d4f7ca752..6db9e03afd0b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -870,7 +870,6 @@ struct dma_device {
 	struct device *dev;
 	struct module *owner;
 	struct ida chan_ida;
-	struct mutex chan_mutex;	/* to protect chan_ida */
 
 	u32 src_addr_widths;
 	u32 dst_addr_widths;
-- 
2.32.0

