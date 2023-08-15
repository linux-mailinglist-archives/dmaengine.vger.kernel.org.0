Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9FA77C789
	for <lists+dmaengine@lfdr.de>; Tue, 15 Aug 2023 08:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234885AbjHOGMn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Aug 2023 02:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbjHOGMN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Aug 2023 02:12:13 -0400
Received: from out-94.mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180F410F4
        for <dmaengine@vger.kernel.org>; Mon, 14 Aug 2023 23:12:07 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692079925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=87BafcYHTECroCFlPdcmpeMw+ZEtXfVG5SDX5ZX7vng=;
        b=SaSvNJI87JqpANRZ51JR8umiT3wah4COBIVfxNOITxv/Lg12FLBqHqfeHPAoNaxuqAA75+
        2+oLt29lwDyujY9SHnOHUCrU+QaCmpqSP7oJSx/5mSVRVtmnYti6gylM1/eRzHR66SqsEJ
        Blv8MAbBTTfKeKLaIOLEK4wXzok3qEg=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     vkoul@kernel.org, dave.jiang@intel.com, dan.j.williams@intel.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v2] dmaengine: ioat: fixing the wrong dma_dev->chancnt
Date:   Tue, 15 Aug 2023 14:11:51 +0800
Message-Id: <20230815061151.2724474-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The chancnt would be updated in __dma_async_device_channel_register(),
but it was assigned in ioat_enumerate_channels(). Therefore chancnt has
the wrong value.

Add chancnt member to the struct ioatdma_device, ioat_dma->chancnt
is used in ioat, dma_dev->chancnt is used in dmaengine.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
V1 -> V2: add chancnt member to the struct ioatdma_device.
---
 drivers/dma/ioat/dma.h  |  1 +
 drivers/dma/ioat/init.c | 19 ++++++++++---------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ioat/dma.h b/drivers/dma/ioat/dma.h
index 35e06b382603..a180171087a8 100644
--- a/drivers/dma/ioat/dma.h
+++ b/drivers/dma/ioat/dma.h
@@ -74,6 +74,7 @@ struct ioatdma_device {
 	struct dca_provider *dca;
 	enum ioat_irq_mode irq_mode;
 	u32 cap;
+	int chancnt;
 
 	/* shadow version for CB3.3 chan reset errata workaround */
 	u64 msixtba0;
diff --git a/drivers/dma/ioat/init.c b/drivers/dma/ioat/init.c
index c4602bfc9c74..9c364e92cb82 100644
--- a/drivers/dma/ioat/init.c
+++ b/drivers/dma/ioat/init.c
@@ -420,7 +420,7 @@ int ioat_dma_setup_interrupts(struct ioatdma_device *ioat_dma)
 
 msix:
 	/* The number of MSI-X vectors should equal the number of channels */
-	msixcnt = ioat_dma->dma_dev.chancnt;
+	msixcnt = ioat_dma->chancnt;
 	for (i = 0; i < msixcnt; i++)
 		ioat_dma->msix_entries[i].entry = i;
 
@@ -511,7 +511,7 @@ static int ioat_probe(struct ioatdma_device *ioat_dma)
 	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
 	dma->dev = &pdev->dev;
 
-	if (!dma->chancnt) {
+	if (!ioat_dma->chancnt) {
 		dev_err(dev, "channel enumeration error\n");
 		goto err_setup_interrupts;
 	}
@@ -567,15 +567,16 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 	struct device *dev = &ioat_dma->pdev->dev;
 	struct dma_device *dma = &ioat_dma->dma_dev;
 	u8 xfercap_log;
+	int chancnt;
 	int i;
 
 	INIT_LIST_HEAD(&dma->channels);
-	dma->chancnt = readb(ioat_dma->reg_base + IOAT_CHANCNT_OFFSET);
-	dma->chancnt &= 0x1f; /* bits [4:0] valid */
-	if (dma->chancnt > ARRAY_SIZE(ioat_dma->idx)) {
+	chancnt = readb(ioat_dma->reg_base + IOAT_CHANCNT_OFFSET);
+	chancnt &= 0x1f; /* bits [4:0] valid */
+	if (chancnt > ARRAY_SIZE(ioat_dma->idx)) {
 		dev_warn(dev, "(%d) exceeds max supported channels (%zu)\n",
-			 dma->chancnt, ARRAY_SIZE(ioat_dma->idx));
-		dma->chancnt = ARRAY_SIZE(ioat_dma->idx);
+			 chancnt, ARRAY_SIZE(ioat_dma->idx));
+		chancnt = ARRAY_SIZE(ioat_dma->idx);
 	}
 	xfercap_log = readb(ioat_dma->reg_base + IOAT_XFERCAP_OFFSET);
 	xfercap_log &= 0x1f; /* bits [4:0] valid */
@@ -583,7 +584,7 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 		return;
 	dev_dbg(dev, "%s: xfercap = %d\n", __func__, 1 << xfercap_log);
 
-	for (i = 0; i < dma->chancnt; i++) {
+	for (i = 0; i < chancnt; i++) {
 		ioat_chan = kzalloc(sizeof(*ioat_chan), GFP_KERNEL);
 		if (!ioat_chan)
 			break;
@@ -596,7 +597,7 @@ static void ioat_enumerate_channels(struct ioatdma_device *ioat_dma)
 			break;
 		}
 	}
-	dma->chancnt = i;
+	ioat_dma->chancnt = i;
 }
 
 /**
-- 
2.25.1

