Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB75437C3
	for <lists+dmaengine@lfdr.de>; Wed,  8 Jun 2022 17:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244539AbiFHPnE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 8 Jun 2022 11:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244521AbiFHPnD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 8 Jun 2022 11:43:03 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B031E0AFD
        for <dmaengine@vger.kernel.org>; Wed,  8 Jun 2022 08:43:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed30:243a:e14b:d107:1f56])
        by andre.telenet-ops.be with bizsmtp
        id gfj02700J1qF9lr01fj0PT; Wed, 08 Jun 2022 17:43:00 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nyxpj-003E22-Vf; Wed, 08 Jun 2022 17:42:59 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1nyxpj-008kRu-H9; Wed, 08 Jun 2022 17:42:59 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] dmaengine: dmatest: Replace symbolic permissions by octal permissions
Date:   Wed,  8 Jun 2022 17:42:58 +0200
Message-Id: <a745b883288f95e999b71fac677bbc2daa13c22d.1654702928.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Octal permissions are easier to read.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dma/dmatest.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 8ad8e7011d0be913..3253d1da2b3a5fc6 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -22,51 +22,50 @@
 #include <linux/wait.h>
 
 static unsigned int test_buf_size = 16384;
-module_param(test_buf_size, uint, S_IRUGO | S_IWUSR);
+module_param(test_buf_size, uint, 0644);
 MODULE_PARM_DESC(test_buf_size, "Size of the memcpy test buffer");
 
 static char test_device[32];
-module_param_string(device, test_device, sizeof(test_device),
-		S_IRUGO | S_IWUSR);
+module_param_string(device, test_device, sizeof(test_device), 0644);
 MODULE_PARM_DESC(device, "Bus ID of the DMA Engine to test (default: any)");
 
 static unsigned int threads_per_chan = 1;
-module_param(threads_per_chan, uint, S_IRUGO | S_IWUSR);
+module_param(threads_per_chan, uint, 0644);
 MODULE_PARM_DESC(threads_per_chan,
 		"Number of threads to start per channel (default: 1)");
 
 static unsigned int max_channels;
-module_param(max_channels, uint, S_IRUGO | S_IWUSR);
+module_param(max_channels, uint, 0644);
 MODULE_PARM_DESC(max_channels,
 		"Maximum number of channels to use (default: all)");
 
 static unsigned int iterations;
-module_param(iterations, uint, S_IRUGO | S_IWUSR);
+module_param(iterations, uint, 0644);
 MODULE_PARM_DESC(iterations,
 		"Iterations before stopping test (default: infinite)");
 
 static unsigned int dmatest;
-module_param(dmatest, uint, S_IRUGO | S_IWUSR);
+module_param(dmatest, uint, 0644);
 MODULE_PARM_DESC(dmatest,
 		"dmatest 0-memcpy 1-memset (default: 0)");
 
 static unsigned int xor_sources = 3;
-module_param(xor_sources, uint, S_IRUGO | S_IWUSR);
+module_param(xor_sources, uint, 0644);
 MODULE_PARM_DESC(xor_sources,
 		"Number of xor source buffers (default: 3)");
 
 static unsigned int pq_sources = 3;
-module_param(pq_sources, uint, S_IRUGO | S_IWUSR);
+module_param(pq_sources, uint, 0644);
 MODULE_PARM_DESC(pq_sources,
 		"Number of p+q source buffers (default: 3)");
 
 static int timeout = 3000;
-module_param(timeout, int, S_IRUGO | S_IWUSR);
+module_param(timeout, int, 0644);
 MODULE_PARM_DESC(timeout, "Transfer Timeout in msec (default: 3000), "
 		 "Pass -1 for infinite timeout");
 
 static bool noverify;
-module_param(noverify, bool, S_IRUGO | S_IWUSR);
+module_param(noverify, bool, 0644);
 MODULE_PARM_DESC(noverify, "Disable data verification (default: verify)");
 
 static bool norandom;
@@ -74,7 +73,7 @@ module_param(norandom, bool, 0644);
 MODULE_PARM_DESC(norandom, "Disable random offset setup (default: random)");
 
 static bool verbose;
-module_param(verbose, bool, S_IRUGO | S_IWUSR);
+module_param(verbose, bool, 0644);
 MODULE_PARM_DESC(verbose, "Enable \"success\" result messages (default: off)");
 
 static int alignment = -1;
@@ -86,7 +85,7 @@ module_param(transfer_size, uint, 0644);
 MODULE_PARM_DESC(transfer_size, "Optional custom transfer size in bytes (default: not used (0))");
 
 static bool polled;
-module_param(polled, bool, S_IRUGO | S_IWUSR);
+module_param(polled, bool, 0644);
 MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
 
 /**
@@ -154,7 +153,7 @@ static const struct kernel_param_ops run_ops = {
 	.get = dmatest_run_get,
 };
 static bool dmatest_run;
-module_param_cb(run, &run_ops, &dmatest_run, S_IRUGO | S_IWUSR);
+module_param_cb(run, &run_ops, &dmatest_run, 0644);
 MODULE_PARM_DESC(run, "Run the test (default: false)");
 
 static int dmatest_chan_set(const char *val, const struct kernel_param *kp);
@@ -290,7 +289,7 @@ static const struct kernel_param_ops wait_ops = {
 	.get = dmatest_wait_get,
 	.set = param_set_bool,
 };
-module_param_cb(wait, &wait_ops, &wait, S_IRUGO);
+module_param_cb(wait, &wait_ops, &wait, 0444);
 MODULE_PARM_DESC(wait, "Wait for tests to complete (default: false)");
 
 static bool dmatest_match_channel(struct dmatest_params *params,
-- 
2.25.1

