Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE794350C6
	for <lists+dmaengine@lfdr.de>; Wed, 20 Oct 2021 18:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhJTQ50 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 20 Oct 2021 12:57:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:48077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230264AbhJTQ5Z (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 20 Oct 2021 12:57:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10143"; a="226292565"
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="226292565"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:59 -0700
X-IronPort-AV: E=Sophos;i="5.87,167,1631602800"; 
   d="scan'208";a="532752534"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2021 09:53:58 -0700
Subject: [PATCH 4/7] dmaengine: idxd: add helper for per interrupt handle
 drain
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>, dmaengine@vger.kernel.org
Date:   Wed, 20 Oct 2021 09:53:58 -0700
Message-ID: <163474883845.2608004.9330596081850512248.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
References: <163474864017.2608004.10983485368237365990.stgit@djiang5-desk3.ch.intel.com>
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
 drivers/dma/idxd/irq.c |   41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 573a2f6d0f7f..8bca0ed2d23c 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -55,6 +55,47 @@ static void idxd_device_reinit(struct work_struct *work)
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
+	struct dsa_hw_desc desc;
+	void __iomem *portal;
+	int rc;
+
+	memset(&desc, 0, sizeof(desc));
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


