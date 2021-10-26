Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9257443BC83
	for <lists+dmaengine@lfdr.de>; Tue, 26 Oct 2021 23:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239674AbhJZVit (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 Oct 2021 17:38:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:52969 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239669AbhJZVit (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 Oct 2021 17:38:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="253563059"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="253563059"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:36:24 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="722686540"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 14:36:24 -0700
Subject: [PATCH v2 4/7] dmaengine: idxd: add helper for per interrupt handle
 drain
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Tue, 26 Oct 2021 14:36:23 -0700
Message-ID: <163528418315.3925689.7944718440052849626.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163528412413.3925689.7831987824972063153.stgit@djiang5-desk3.ch.intel.com>
References: <163528412413.3925689.7831987824972063153.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The helper is called at the completion of the interrupt handle refresh
event. It issues drain descriptors to each of the wq with associated
interrupt handle. The drain descriptor will have interrupt request set but
without completion record. This will ensure all descriptors with incorrect
interrupt completion handle get drained and a completion interrupt is
triggered for the guest driver to process them.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/irq.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index d9c4fc22536d..5434f702901a 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -55,6 +55,45 @@ static void idxd_device_reinit(struct work_struct *work)
 	idxd_device_clear_state(idxd);
 }
 
+/*
+ * The function sends a drain descriptor for the interrupt handle. The drain ensures
+ * all descriptors with this interrupt handle is flushed and the interrupt
+ * will allow the cleanup of the outstanding descriptors.
+ */
+static void idxd_int_handle_revoke_drain(struct idxd_irq_entry *ie)
+{
+	struct idxd_wq *wq = ie->wq;
+	struct idxd_device *idxd = ie->idxd;
+	struct device *dev = &idxd->pdev->dev;
+	struct dsa_hw_desc desc = {};
+	void __iomem *portal;
+	int rc;
+
+	/* Issue a simple drain operation with interrupt but no completion record */
+	desc.flags = IDXD_OP_FLAG_RCI;
+	desc.opcode = DSA_OPCODE_DRAIN;
+	desc.priv = 1;
+
+	if (ie->pasid != INVALID_IOASID)
+		desc.pasid = ie->pasid;
+	desc.int_handle = ie->int_handle;
+	portal = idxd_wq_portal_addr(wq);
+
+	/*
+	 * The wmb() makes sure that the descriptor is all there before we
+	 * issue.
+	 */
+	wmb();
+	if (wq_dedicated(wq)) {
+		iosubmit_cmds512(portal, &desc, 1);
+	} else {
+		rc = enqcmds(portal, &desc);
+		/* This should not fail unless hardware failed. */
+		if (rc < 0)
+			dev_warn(dev, "Failed to submit drain desc on wq %d\n", wq->id);
+	}
+}
+
 static int process_misc_interrupts(struct idxd_device *idxd, u32 cause)
 {
 	struct device *dev = &idxd->pdev->dev;


