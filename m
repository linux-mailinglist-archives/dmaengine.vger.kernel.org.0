Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E30F7BA65
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2019 09:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbfGaHOj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 31 Jul 2019 03:14:39 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45880 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726134AbfGaHOj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 31 Jul 2019 03:14:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6V7EZBO031515;
        Wed, 31 Jul 2019 02:14:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1564557275;
        bh=MaZMIYdXkxDCgDP9EI+Kc/7R0rCHX48BI2xlZmXTE7g=;
        h=From:To:CC:Subject:Date;
        b=RV3+87i953H45Ui4VxTuxZLblvnkx8GkxYdfwEWrnC1PVKE7f1opl5YadfAdNe4/R
         CKzKAR5/Iv0orEHypxh7bMLq3J+tmKkyQ2o+HLobXm601mzAphNAeegcicJPjXaNzD
         8UpYgJoNztrxDDFcV8zGBI9KtNunBiYnqhXL20os=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6V7EZrn066542
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 31 Jul 2019 02:14:35 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 31
 Jul 2019 02:14:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 31 Jul 2019 02:14:34 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6V7EXtm062043;
        Wed, 31 Jul 2019 02:14:33 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <andriy.shevchenko@linux.intel.com>
Subject: [RESEND] dmaengine: dmatest: Add support for completion polling
Date:   Wed, 31 Jul 2019 10:14:38 +0300
Message-ID: <20190731071438.24075-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

With the polled parameter the DMA drivers can be tested if they can work
correctly when no completion is requested (no DMA_PREP_INTERRUPT and no
callback is provided).

If polled mode is selected then use dma_sync_wait() to execute the test
iteration instead of relying on the completion callback.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Vinod,

no changes since v1, but rebased it on linux-next to make sure it applies
cleanly.

v1: https://patchwork.kernel.org/patch/10966499/

Regards,
Peter

 drivers/dma/dmatest.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 3d22ae8dca72..a2cadfa2e6d7 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -72,6 +72,10 @@ static bool norandom;
 module_param(norandom, bool, 0644);
 MODULE_PARM_DESC(norandom, "Disable random offset setup (default: random)");
 
+static bool polled;
+module_param(polled, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
+
 static bool verbose;
 module_param(verbose, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(verbose, "Enable \"success\" result messages (default: off)");
@@ -110,6 +114,7 @@ struct dmatest_params {
 	bool		norandom;
 	int		alignment;
 	unsigned int	transfer_size;
+	bool		polled;
 };
 
 /**
@@ -651,7 +656,10 @@ static int dmatest_func(void *data)
 	/*
 	 * src and dst buffers are freed by ourselves below
 	 */
-	flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	if (params->polled)
+		flags = DMA_CTRL_ACK;
+	else
+		flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 
 	ktime = ktime_get();
 	while (!kthread_should_stop()
@@ -780,8 +788,10 @@ static int dmatest_func(void *data)
 		}
 
 		done->done = false;
-		tx->callback = dmatest_callback;
-		tx->callback_param = done;
+		if (!params->polled) {
+			tx->callback = dmatest_callback;
+			tx->callback_param = done;
+		}
 		cookie = tx->tx_submit(tx);
 
 		if (dma_submit_error(cookie)) {
@@ -790,12 +800,22 @@ static int dmatest_func(void *data)
 			msleep(100);
 			goto error_unmap_continue;
 		}
-		dma_async_issue_pending(chan);
 
-		wait_event_freezable_timeout(thread->done_wait, done->done,
-					     msecs_to_jiffies(params->timeout));
+		if (params->polled) {
+			status = dma_sync_wait(chan, cookie);
+			dmaengine_terminate_sync(chan);
+			if (status == DMA_COMPLETE)
+				done->done = true;
+		} else {
+			dma_async_issue_pending(chan);
+
+			wait_event_freezable_timeout(thread->done_wait,
+					done->done,
+					msecs_to_jiffies(params->timeout));
 
-		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+			status = dma_async_is_tx_complete(chan, cookie, NULL,
+							  NULL);
+		}
 
 		if (!done->done) {
 			result("test timed out", total_tests, src->off, dst->off,
@@ -1065,6 +1085,7 @@ static void add_threaded_test(struct dmatest_info *info)
 	params->norandom = norandom;
 	params->alignment = alignment;
 	params->transfer_size = transfer_size;
+	params->polled = polled;
 
 	request_channels(info, DMA_MEMCPY);
 	request_channels(info, DMA_MEMSET);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

