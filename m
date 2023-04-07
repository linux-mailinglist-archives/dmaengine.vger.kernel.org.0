Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDC56DB536
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDGUb2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjDGUb1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143FB7AB8;
        Fri,  7 Apr 2023 13:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899487; x=1712435487;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MwbXdVdXHEET8kRfN+0wwJVjHIBrLAgznNDkutHFUxs=;
  b=Ne0a72L+ckihFrVYAY0CWX5vFRqPjmTqjiFurNFs3riA8UZvDnw8ICyk
   hZJPWya2lufL3tEVdD+oIalmiQAOG8cLVwpBque7/j2WUEkdRYJ8RB8ED
   3AWb18I0X9IOz01VaQE1bCTnGwgqVnEEts6TmtAN8Cf5bua2HpuHw8KjA
   TfFP1n26B6cvkLZtVwLQ8ZOPWnh8CZjEMajzrjAmEsU4MuR2vw6kpSuwD
   bjvvqhAHR1aKrm8nWZ9ruOsh3XGYAdEKzvlgDR/RGlf4bpQ7ybZsiW3P1
   vGkwqa3an5uPYe2G1EP/rMaw/5n1xLOpDRwGXLcWmGNepXTjPDD7tm7xO
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196846"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196846"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125864"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125864"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:25 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Sanjay Kumar <sanjay.k.kumar@intel.com>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 01/16] dmaengine: idxd: make misc interrupt one shot
Date:   Fri,  7 Apr 2023 13:31:28 -0700
Message-Id: <20230407203143.2189681-2-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.37.1

