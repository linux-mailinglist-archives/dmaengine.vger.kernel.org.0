Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD356C4E87
	for <lists+dmaengine@lfdr.de>; Wed, 22 Mar 2023 15:52:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCVOwd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Mar 2023 10:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCVOwN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Mar 2023 10:52:13 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E49B664F3;
        Wed, 22 Mar 2023 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1679496639;
  x=1711032639;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Y8cEMk+xHf0dXxZXxCsRBUDEAJjt0BP553Xavc3rKbk=;
  b=KE2oYPnV0PdaO845x+fE32lE2DK6wxp57M4jTLbMqPqTvKhY1NG+++nd
   eCPWwPDRwjSFHSy9XhDllrIzB3W/AiFTfH3pB1GAuVk5sMpdHqA5K6zrd
   RYdmy2KhjcScMHQ4FoGLIuM3w9CbSyykU63lKhgIs4oGWw//rgaGIe8IK
   SIzwODMpTbAVTYZ0S+UKkC3AFoCWfyAPhTpdRZSGR4XgJ/j9AIAoSSPoW
   C6Qj1I2mTE4ZVA14kGi1YT9IF/Zj8ZQZA1kO4Od3Ss+e2GpDixvNLBYhh
   Kg9OgPPZQhF0Kxnee40tUbQGAKkAfonZDauuLmBs4SkSX6T7bXFKhygOG
   A==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Wed, 22 Mar 2023 15:50:23 +0100
Subject: [PATCH] dmaengine: dmatest: Add option to exercise transfer
 termination
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230322-dmatest-terminate-v1-1-2dc6bfaa018b@axis.com>
X-B4-Tracking: v=1; b=H4sIAK4VG2QC/x2NwQrDMAxDf6X4vECW9jD2K6MHN3EaH5IVO4xB6
 b/X7U3Sk9AOSsKk8B52EPqx8reZeT4GiAXbSo6TeQg+jH4MwaWKnbS7TlK5mXYLpsmQf2GOYLs
 F1ULBFsu1rKjWvcAmlPl/n33m4zgBvkv+bHwAAAA=
To:     Vinod Koul <vkoul@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a module parameter to allow tests to terminate transfers after a
random delay.  This can be used to try to provoke races in the handling
of ongoing transfers in drivers' implementations of
->device_terminate_all().

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/dma/dmatest.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index ffe621695e47..c3a7681efea8 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -88,6 +88,12 @@ static bool polled;
 module_param(polled, bool, 0644);
 MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
 
+/* Note that throughput stats can be misleading when this is used. */
+static unsigned int terminate_delay_us;
+module_param(terminate_delay_us, uint, 0644);
+MODULE_PARM_DESC(terminate_delay_us,
+		 "Terminate transfers after randomly delaying up to the specified time in microseconds (default: no termination)");
+
 /**
  * struct dmatest_params - test parameters.
  * @buf_size:		size of the memcpy test buffer
@@ -684,6 +690,7 @@ static int dmatest_func(void *data)
 	       (params->iterations && total_tests >= params->iterations))) {
 		struct dma_async_tx_descriptor *tx = NULL;
 		struct dmaengine_unmap_data *um;
+		bool terminated = false;
 		dma_addr_t *dsts;
 		unsigned int len;
 
@@ -827,19 +834,27 @@ static int dmatest_func(void *data)
 		} else {
 			dma_async_issue_pending(chan);
 
-			wait_event_freezable_timeout(thread->done_wait,
-					done->done,
-					msecs_to_jiffies(params->timeout));
+			if (terminate_delay_us) {
+				fsleep(dmatest_random() % terminate_delay_us);
+
+				dmaengine_terminate_sync(chan);
+				terminated = true;
+			}
+
+			if (!terminated)
+				wait_event_freezable_timeout(thread->done_wait,
+						done->done,
+						msecs_to_jiffies(params->timeout));
 
 			status = dma_async_is_tx_complete(chan, cookie, NULL,
 							  NULL);
 		}
 
-		if (!done->done) {
+		if (!terminated && !done->done) {
 			result("test timed out", total_tests, src->off, dst->off,
 			       len, 0);
 			goto error_unmap_continue;
-		} else if (status != DMA_COMPLETE &&
+		} else if (!terminated && status != DMA_COMPLETE &&
 			   !(dma_has_cap(DMA_COMPLETION_NO_ORDER,
 					 dev->cap_mask) &&
 			     status == DMA_OUT_OF_ORDER)) {
@@ -852,9 +867,11 @@ static int dmatest_func(void *data)
 
 		dmaengine_unmap_put(um);
 
-		if (params->noverify) {
-			verbose_result("test passed", total_tests, src->off,
-				       dst->off, len, 0);
+		if (params->noverify || terminated) {
+			const char *msg = terminated ? "test terminated" : "test passed";
+
+			verbose_result(msg, total_tests, src->off, dst->off,
+					len, 0);
 			continue;
 		}
 

---
base-commit: e8d018dd0257f744ca50a729e3d042cf2ec9da65
change-id: 20230322-dmatest-terminate-bad403208afc

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

