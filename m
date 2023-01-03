Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A45C65C3FC
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237905AbjACQfR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjACQfQ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95ACD2C9
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763715; x=1704299715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jHLK+PPvGaCxn2nKM+xKjyzKNUyncQGSUCX61KwEUgo=;
  b=InZZA6L5NL/Wo7OZDWmB+ezUz5XhfAQHMJcu8gnahCAytdDRLe5vsPuH
   xGfGJELSuDM7Z3m6cjB7bHaO0iv1BExXP+cHkcoTc0OckIYH/rvv2A/8Q
   EdvD5d9nUvsUgmXKois11p9BeQ0xsqZYft3ZuljseEDDWilscq6Wdz7K+
   h2R1schG5ek5kwF+AxE80lh7xaQcWuD45PoyKXSoAfooVxdwCdnsZuLD3
   TlmJ57AZ+unupKGaN96j8FQdAIAwjRiHNs0R690AwRFr+gYhg6oNiJ5FH
   6xIwK4K2qCowNNKtXmw4dzcm7oGLiequl6mqDkHdp2U0EwYwT+7WBypIg
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072290"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072290"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858453"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858453"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 01/17] dmaengine: idxd: make misc interrupt one shot
Date:   Tue,  3 Jan 2023 08:34:49 -0800
Message-Id: <20230103163505.1569356-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103163505.1569356-1-fenghua.yu@intel.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Current code continuously processes the interrupt as long as the hardware
is setting the status bit. There's no reason to do that since the threaded
handler will get called again if another interrupt is asserted.

Also through testing, it has shown that if a misprogrammed (or malicious)
agent can continuously submit descriptors with bad completion record and
causes errors to be reported via the misc interrupt. Continuous processing
by the thread can cause software hang watchdog to kick off since the thread
isn't giving up the CPU.

Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/irq.c | 38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index aa314ebec587..0d639303b515 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -217,13 +217,22 @@ static void idxd_int_handle_revoke(struct work_struct *work)
 	kfree(revoke);
 }
 
-static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
+irqreturn_t idxd_misc_thread(int vec, void *data)
 {
+	struct idxd_irq_entry *irq_entry = data;
+	struct idxd_device *idxd = ie_to_idxd(irq_entry);
 	struct device *dev = &idxd->pdev->dev;
 	union gensts_reg gensts;
 	u32 val = 0;
 	int i;
 	bool err = false;
+	u32 cause;
+
+	cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
+	if (!cause)
+		return IRQ_NONE;
+
+	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
 
 	if (cause & IDXD_INTC_HALT_STATE)
 		goto halt;
@@ -301,7 +310,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			      val);
 
 	if (!err)
-		return 0;
+		goto out;
 
 halt:
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
@@ -324,33 +333,10 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 				"idxd halted, need %s.\n",
 				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
 				"FLR" : "system reset");
-			return -ENXIO;
 		}
 	}
 
-	return 0;
-}
-
-irqreturn_t idxd_misc_thread(int vec, void *data)
-{
-	struct idxd_irq_entry *irq_entry = data;
-	struct idxd_device *idxd = ie_to_idxd(irq_entry);
-	int rc;
-	u32 cause;
-
-	cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
-	if (cause)
-		iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
-
-	while (cause) {
-		rc = process_misc_interrupts(idxd, cause);
-		if (rc < 0)
-			break;
-		cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
-		if (cause)
-			iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
-	}
-
+out:
 	return IRQ_HANDLED;
 }
 
-- 
2.32.0

