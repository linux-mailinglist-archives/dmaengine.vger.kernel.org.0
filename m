Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679F52F87F4
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 22:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725934AbhAOVxP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 16:53:15 -0500
Received: from mga09.intel.com ([134.134.136.24]:31455 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbhAOVxO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 Jan 2021 16:53:14 -0500
IronPort-SDR: 1JJmyut76Wh6UQ8K0OwHigGQ1tPR0JPiU3LnTfobOrf1SfwLey4wzrw2DGC80D9nqcRfPwzlGD
 2A52P7GIXZaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="178758947"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="178758947"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:52:34 -0800
IronPort-SDR: cf5Him9KMc3KSNEvwJwvvmHnpeIMFJwBmA/Vy2/sp03MBaH2UOPdxyUXbk61LykcNhBmYAl2Rp
 bj96zNS7nBJQ==
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="354457608"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:52:33 -0800
Subject: [PATCH] dmaengine: idxd: fix misc interrupt completion
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Nikhil Rao <nikhil.rao@intel.com>, dmaengine@vger.kernel.org
Date:   Fri, 15 Jan 2021 14:52:33 -0700
Message-ID: <161074755329.2183844.13295528344116907983.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nikhil reported the misc interrupt handler can sometimes miss handling
the command interrupt when an error interrupt happens near the same time.
Have the irq handling thread continue to process the misc interrupts until
all interrupts are processed. This is a low usage interrupt and is not
expected to handle high volume traffic. Therefore there is no concern of
this thread running for a long time.

Fixes: 0d5c10b4c84d ("dmaengine: idxd: add work queue drain support")
Reported-by: Nikhil Rao <nikhil.rao@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |   36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 593a2f6ed16c..5d48f9b1b3aa 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -111,19 +111,14 @@ irqreturn_t idxd_irq_handler(int vec, void *data)
 	return IRQ_WAKE_THREAD;
 }
 
-irqreturn_t idxd_misc_thread(int vec, void *data)
+static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 {
-	struct idxd_irq_entry *irq_entry = data;
-	struct idxd_device *idxd = irq_entry->idxd;
 	struct device *dev = &idxd->pdev->dev;
 	union gensts_reg gensts;
-	u32 cause, val = 0;
+	u32 val = 0;
 	int i;
 	bool err = false;
 
-	cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
-	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
-
 	if (cause & IDXD_INTC_ERR) {
 		spin_lock_bh(&idxd->dev_lock);
 		for (i = 0; i < 4; i++)
@@ -181,7 +176,7 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 			      val);
 
 	if (!err)
-		goto out;
+		return 0;
 
 	/*
 	 * This case should rarely happen and typically is due to software
@@ -211,10 +206,33 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
 				"FLR" : "system reset");
 			spin_unlock_bh(&idxd->dev_lock);
+			return -ENXIO;
 		}
 	}
 
- out:
+	return 0;
+}
+
+irqreturn_t idxd_misc_thread(int vec, void *data)
+{
+	struct idxd_irq_entry *irq_entry = data;
+	struct idxd_device *idxd = irq_entry->idxd;
+	int rc;
+	u32 cause;
+
+	cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
+	if (cause)
+		iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
+
+	while (cause) {
+		rc = process_misc_interrupts(idxd, cause);
+		if (rc < 0)
+			break;
+		cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
+		if (cause)
+			iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
+	}
+
 	idxd_unmask_msix_vector(idxd, irq_entry->id);
 	return IRQ_HANDLED;
 }


