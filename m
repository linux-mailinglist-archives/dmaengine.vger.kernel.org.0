Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2068977C881
	for <lists+dmaengine@lfdr.de>; Tue, 15 Aug 2023 09:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjHOHZH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Aug 2023 03:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbjHOHYF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Aug 2023 03:24:05 -0400
X-Greylist: delayed 167044 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 15 Aug 2023 00:24:02 PDT
Received: from out-126.mta0.migadu.com (out-126.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE0D1E5B
        for <dmaengine@vger.kernel.org>; Tue, 15 Aug 2023 00:24:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692084239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ahfl1ptR4jsXR4HU9mMdKqws9LH8cXPWldHFhNBW70k=;
        b=QdoEJah9/mvPZhFaQ6Y4AatJFvpMXCLh8In5a7BUUhReU9Gfl4ej77IqwGTIrXemLstsbl
        2TyfUbz2enbEbmvRcl/+aVYM3b5pcvjzF3rMXwjkEM3eu57NF9bmRxGHBwcSxNcq3B2K/T
        HGnSq1n1LnoGnv7Iixzzm7c6SgCDWcY=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] dmaengine: Simplify dma_async_device_register()
Date:   Tue, 15 Aug 2023 15:23:46 +0800
Message-Id: <20230815072346.2798927-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There are a lot of duplicate codes for checking if the dma has some
capability.

Define a temporary macro that is used to check if the dma claims some
capability and if the corresponding function is implemented.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 drivers/dma/dmaengine.c | 82 ++++++++++-------------------------------
 1 file changed, 20 insertions(+), 62 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 826b98284fa1..b7388ae62d7f 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1147,69 +1147,27 @@ int dma_async_device_register(struct dma_device *device)
 
 	device->owner = device->dev->driver->owner;
 
-	if (dma_has_cap(DMA_MEMCPY, device->cap_mask) && !device->device_prep_dma_memcpy) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_MEMCPY");
-		return -EIO;
-	}
-
-	if (dma_has_cap(DMA_XOR, device->cap_mask) && !device->device_prep_dma_xor) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_XOR");
-		return -EIO;
-	}
-
-	if (dma_has_cap(DMA_XOR_VAL, device->cap_mask) && !device->device_prep_dma_xor_val) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_XOR_VAL");
-		return -EIO;
-	}
-
-	if (dma_has_cap(DMA_PQ, device->cap_mask) && !device->device_prep_dma_pq) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_PQ");
-		return -EIO;
-	}
-
-	if (dma_has_cap(DMA_PQ_VAL, device->cap_mask) && !device->device_prep_dma_pq_val) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_PQ_VAL");
-		return -EIO;
-	}
-
-	if (dma_has_cap(DMA_MEMSET, device->cap_mask) && !device->device_prep_dma_memset) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_MEMSET");
-		return -EIO;
-	}
-
-	if (dma_has_cap(DMA_INTERRUPT, device->cap_mask) && !device->device_prep_dma_interrupt) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_INTERRUPT");
-		return -EIO;
-	}
-
-	if (dma_has_cap(DMA_CYCLIC, device->cap_mask) && !device->device_prep_dma_cyclic) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_CYCLIC");
-		return -EIO;
-	}
-
-	if (dma_has_cap(DMA_INTERLEAVE, device->cap_mask) && !device->device_prep_interleaved_dma) {
-		dev_err(device->dev,
-			"Device claims capability %s, but op is not defined\n",
-			"DMA_INTERLEAVE");
-		return -EIO;
-	}
+#define CHECK_CAP(_name, _type)								\
+{											\
+	if (dma_has_cap(_type, device->cap_mask) && !device->device_prep_##_name) {	\
+		dev_err(device->dev,							\
+			"Device claims capability %s, but op is not defined\n",		\
+			__stringify(_type));						\
+		return -EIO;								\
+	}										\
+}
 
+	CHECK_CAP(dma_memcpy,      DMA_MEMCPY);
+	CHECK_CAP(dma_xor,         DMA_XOR);
+	CHECK_CAP(dma_xor_val,     DMA_XOR_VAL);
+	CHECK_CAP(dma_pq,          DMA_PQ);
+	CHECK_CAP(dma_pq_val,      DMA_PQ_VAL);
+	CHECK_CAP(dma_memset,      DMA_MEMSET);
+	CHECK_CAP(dma_interrupt,   DMA_INTERRUPT);
+	CHECK_CAP(dma_cyclic,      DMA_CYCLIC);
+	CHECK_CAP(interleaved_dma, DMA_INTERLEAVE);
+
+#undef CHECK_CAP
 
 	if (!device->device_tx_status) {
 		dev_err(device->dev, "Device tx_status is not defined\n");
-- 
2.25.1

