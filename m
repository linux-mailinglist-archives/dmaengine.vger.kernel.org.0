Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2C84BA82E
	for <lists+dmaengine@lfdr.de>; Thu, 17 Feb 2022 19:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiBQS0Q (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 17 Feb 2022 13:26:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiBQS0P (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 17 Feb 2022 13:26:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C9D533351
        for <dmaengine@vger.kernel.org>; Thu, 17 Feb 2022 10:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645122359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e0k61bWKoEdgCZKiT1/ArMJBvBOZzkgfosoEUmRiXDo=;
        b=GinFhDlWlw+j7X1ctcvC1ioDc0hH2PBzkJ48PY0LeUv5YPYB/P6fmlMAXxskmx/RbHrLaG
        QqA4AnvVlYSTHBZ+8dISBxbkdlZ4/BsJhNmH9NzIgeVrSOjih5uTrGCXbkReRan9uS1Nzt
        vu3Pf7gnDT51ycUamEX4zMZpb3K47vQ=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-HxjCJnRxN62ZVbWNAA7H3Q-1; Thu, 17 Feb 2022 13:25:58 -0500
X-MC-Unique: HxjCJnRxN62ZVbWNAA7H3Q-1
Received: by mail-ot1-f72.google.com with SMTP id h7-20020a9d5547000000b005ad0f5e4271so210619oti.19
        for <dmaengine@vger.kernel.org>; Thu, 17 Feb 2022 10:25:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e0k61bWKoEdgCZKiT1/ArMJBvBOZzkgfosoEUmRiXDo=;
        b=xMxZaWO8TLtS05ZfPoSJqjwTVBDE+/X0beKp8nNaWA4IdNzrKWMVzn/5bM8R++Vgir
         +ldeGlxLUGFUCCrndfsSaIMPJy6Km/SlkGoQDQONzNYdajEulBBTUazzYdtnLSluIwiY
         qyQ8c26Apg9ldiFnmxKrltk/8+JgIsR6T01r1WETu6/St4PgeI4bjIyBLan3TJDJ8w+W
         G393XfgDJ1EmPiTrA5NQ6EGI5UMvLqFN0wH48LH06p11z5OYmrlrbVQIBYegXoduwkdz
         coCTIdPlWGPGEqnuUGI3NTZv+oEwkarhXwfDP+b5KAYkGfdBSgm/Mt9QnQBSi68Ifun/
         XbtQ==
X-Gm-Message-State: AOAM533K6Gk0WMsdlO604QoIX7QxhgP8XWyFMWykOg37aSb2+5O15MV7
        y+DsuyFUYldW6CI9yqOJMBx8qhMSrx3PFr/YSOJghB3+JmMvOFwn6eNjsLSUTdmTlXwaV8IQTR/
        haE+PsbjmUngWyjYnNvvy
X-Received: by 2002:a9d:4d98:0:b0:5ac:e4ba:27a6 with SMTP id u24-20020a9d4d98000000b005ace4ba27a6mr1351161otk.334.1645122357556;
        Thu, 17 Feb 2022 10:25:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyCwbZbDciz2AYCTeRHeNW502dpeRN+vDb4rWM50eiSxkFPNnA38L0B5o4I9cXETuQE3tb77g==
X-Received: by 2002:a9d:4d98:0:b0:5ac:e4ba:27a6 with SMTP id u24-20020a9d4d98000000b005ace4ba27a6mr1351152otk.334.1645122357293;
        Thu, 17 Feb 2022 10:25:57 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w7sm320674oiv.8.2022.02.17.10.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:25:56 -0800 (PST)
From:   trix@redhat.com
To:     vkoul@kernel.org, peter.ujfalusi@gmail.com
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dma: ti: cleanup comments
Date:   Thu, 17 Feb 2022 10:25:46 -0800
Message-Id: <20220217182546.3266909-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Remove the second 'the'

Replacements
completetion to completion
seens to seen
pendling to pending
atleast to at least
tranfer to transfer
multibple to a multiple
transfering to transferring

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/ti/cppi41.c   |  6 +++---
 drivers/dma/ti/edma.c     | 10 +++++-----
 drivers/dma/ti/omap-dma.c |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index 8c2f7ebe998c..062bd9bd4de0 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -315,7 +315,7 @@ static irqreturn_t cppi41_irq(int irq, void *data)
 		val = cppi_readl(cdd->qmgr_mem + QMGR_PEND(i));
 		if (i == QMGR_PENDING_SLOT_Q(first_completion_queue) && val) {
 			u32 mask;
-			/* set corresponding bit for completetion Q 93 */
+			/* set corresponding bit for completion Q 93 */
 			mask = 1 << QMGR_PENDING_BIT_Q(first_completion_queue);
 			/* not set all bits for queues less than Q 93 */
 			mask--;
@@ -703,7 +703,7 @@ static int cppi41_tear_down_chan(struct cppi41_channel *c)
 	 * transfer descriptor followed by TD descriptor. Waiting seems not to
 	 * cause any difference.
 	 * RX seems to be thrown out right away. However once the TearDown
-	 * descriptor gets through we are done. If we have seens the transfer
+	 * descriptor gets through we are done. If we have seen the transfer
 	 * descriptor before the TD we fetch it from enqueue, it has to be
 	 * there waiting for us.
 	 */
@@ -747,7 +747,7 @@ static int cppi41_stop_chan(struct dma_chan *chan)
 		struct cppi41_channel *cc, *_ct;
 
 		/*
-		 * channels might still be in the pendling list if
+		 * channels might still be in the pending list if
 		 * cppi41_dma_issue_pending() is called after
 		 * cppi41_runtime_suspend() is called
 		 */
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 08e47f44d325..3ea8ef7f57df 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -118,10 +118,10 @@
 
 /*
  * Max of 20 segments per channel to conserve PaRAM slots
- * Also note that MAX_NR_SG should be atleast the no.of periods
+ * Also note that MAX_NR_SG should be at least the no.of periods
  * that are required for ASoC, otherwise DMA prep calls will
  * fail. Today davinci-pcm is the only user of this driver and
- * requires atleast 17 slots, so we setup the default to 20.
+ * requires at least 17 slots, so we setup the default to 20.
  */
 #define MAX_NR_SG		20
 #define EDMA_MAX_SLOTS		MAX_NR_SG
@@ -976,7 +976,7 @@ static int edma_config_pset(struct dma_chan *chan, struct edma_pset *epset,
 		 * and quotient respectively of the division of:
 		 * (dma_length / acnt) by (SZ_64K -1). This is so
 		 * that in case bcnt over flows, we have ccnt to use.
-		 * Note: In A-sync tranfer only, bcntrld is used, but it
+		 * Note: In A-sync transfer only, bcntrld is used, but it
 		 * only applies for sg_dma_len(sg) >= SZ_64K.
 		 * In this case, the best way adopted is- bccnt for the
 		 * first frame will be the remainder below. Then for
@@ -1203,7 +1203,7 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 		 * slot2: the remaining amount of data after slot1.
 		 *	  ACNT = full_length - length1, length2 = ACNT
 		 *
-		 * When the full_length is multibple of 32767 one slot can be
+		 * When the full_length is a multiple of 32767 one slot can be
 		 * used to complete the transfer.
 		 */
 		width = array_size;
@@ -1814,7 +1814,7 @@ static void edma_issue_pending(struct dma_chan *chan)
  * This limit exists to avoid a possible infinite loop when waiting for proof
  * that a particular transfer is completed. This limit can be hit if there
  * are large bursts to/from slow devices or the CPU is never able to catch
- * the DMA hardware idle. On an AM335x transfering 48 bytes from the UART
+ * the DMA hardware idle. On an AM335x transferring 48 bytes from the UART
  * RX-FIFO, as many as 55 loops have been seen.
  */
 #define EDMA_MAX_TR_WAIT_LOOPS 1000
diff --git a/drivers/dma/ti/omap-dma.c b/drivers/dma/ti/omap-dma.c
index 7cb577e6587b..8e52a0dc1f78 100644
--- a/drivers/dma/ti/omap-dma.c
+++ b/drivers/dma/ti/omap-dma.c
@@ -1442,7 +1442,7 @@ static int omap_dma_pause(struct dma_chan *chan)
 	 * A source-synchronised channel is one where the fetching of data is
 	 * under control of the device. In other words, a device-to-memory
 	 * transfer. So, a destination-synchronised channel (which would be a
-	 * memory-to-device transfer) undergoes an abort if the the CCR_ENABLE
+	 * memory-to-device transfer) undergoes an abort if the CCR_ENABLE
 	 * bit is cleared.
 	 * From 16.1.4.20.4.6.2 Abort: "If an abort trigger occurs, the channel
 	 * aborts immediately after completion of current read/write
-- 
2.26.3

