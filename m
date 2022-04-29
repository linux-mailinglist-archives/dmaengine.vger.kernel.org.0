Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1844A515283
	for <lists+dmaengine@lfdr.de>; Fri, 29 Apr 2022 19:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356678AbiD2RqY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 29 Apr 2022 13:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379559AbiD2RqX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 29 Apr 2022 13:46:23 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC53AD3470
        for <dmaengine@vger.kernel.org>; Fri, 29 Apr 2022 10:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651254183; x=1682790183;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mEVfHwfHzoP0nhWsDUcMZAHPDWCtIk21beYSkCCQrXM=;
  b=O9IqfthW9NsTrQw5XmdCqBLTcC/u2soA08FwT1kkwbvGBU4dEvKqE3Lt
   vxI8Oa7h658ih8tj+7DqbPY/ErthmYxmggoEOZfpu/fjg2vrD384d4cKd
   1r54vZQWUSEVUK5G5GPohUjooIVTlTfnIoUoqDdRPkb8Cg8ruoJzk9x8G
   Vl0hp2+GgvdWWrApqVzkaBalmdN67KXmywj/U0Ntq73giW0Ma4ehy85mg
   sJTq3JSBxrE5totG/pbIZsGK0MUBaEuhD7seuB1aQ+rHPUpaoY01Md5YB
   p05ddpP3PmLTXMHkUDARBYOarFkYqg2DIqZsBcDs2+h/UeobVylp5yukj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="329664409"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="329664409"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:35:47 -0700
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="534595039"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 10:35:47 -0700
Subject: [PATCH] dmaengine: idxd: make misc interrupt one shot
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Sanjay Kumar <sanjay.k.kumar@intel.com>, dmaengine@vger.kernel.org
Date:   Fri, 29 Apr 2022 10:35:46 -0700
Message-ID: <165125374675.311834.10460196228320964350.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Current code continuously proccesses the interrupt as long as the hardware
is setting the status bit. There's no reason to do that since the threaded
handler will get called again if another interrupt is asserted.

Also through testing, it has shown that if a misprogrammed (or malicious)
agent can continuously submit descriptors with bad completion record and
causes errors to be reported via the misc interrupt. Continuous processing
by the thread can cause software hang watchdog to kick off since the thread
isn't giving up the CPU.

Reported-by: Sanjay Kumar <sanjay.k.kumar@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |   38 ++++++++++++--------------------------
 1 file changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 743ead5ebc57..98aad8a9ed2c 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -222,13 +222,22 @@ static void idxd_int_handle_revoke(struct work_struct *work)
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
@@ -306,7 +315,7 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 			      val);
 
 	if (!err)
-		return 0;
+		goto out;
 
 halt:
 	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
@@ -331,33 +340,10 @@ static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
 				"FLR" : "system reset");
 			spin_unlock(&idxd->dev_lock);
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
 


