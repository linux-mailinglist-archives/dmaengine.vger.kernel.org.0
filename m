Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988042AFB7C
	for <lists+dmaengine@lfdr.de>; Wed, 11 Nov 2020 23:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgKKWid (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 11 Nov 2020 17:38:33 -0500
Received: from mga02.intel.com ([134.134.136.20]:3574 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726112AbgKKWgU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 11 Nov 2020 17:36:20 -0500
IronPort-SDR: ZSQY4wFCmfyI+QaRcmYjTnwizoE6R+2FJvQJbICvmRZzJ/qqEeOr+rNiKdl+TURDB5vpl+77V1
 6Oog8jvyb18Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="157243173"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="157243173"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 14:23:47 -0800
IronPort-SDR: WvsEISXJETRPqMuW18luXH/eI5djZ+K5ujxHsw6p7znPHnpbG9sANUSI60yasoNmrAbDirrG3W
 R1avjKVm89Jg==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="541980945"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 14:23:46 -0800
Subject: [PATCH] dmaengine: idxd: fix mapping of portal size
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Wed, 11 Nov 2020 15:23:46 -0700
Message-ID: <160513342642.510187.16450549281618747065.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Portal size is 4k. Current code is mapping all 4 portals in a single chunk.
Restrict the mapped portal size to a single portal to ensure that submission
only goes to the intended portal address.

Fixes: c52ca478233c ("dmaengine: idxd: add configuration component of driver")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c    |    2 +-
 drivers/dma/idxd/registers.h |    2 +-
 drivers/dma/idxd/submit.c    |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 506ac85c4a7f..663344987e3f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -271,7 +271,7 @@ int idxd_wq_map_portal(struct idxd_wq *wq)
 	resource_size_t start;
 
 	start = pci_resource_start(pdev, IDXD_WQ_BAR);
-	start = start + wq->id * IDXD_PORTAL_SIZE;
+	start += idxd_get_wq_portal_full_offset(wq->id, IDXD_PORTAL_LIMITED);
 
 	wq->dportal = devm_ioremap(dev, start, IDXD_PORTAL_SIZE);
 	if (!wq->dportal)
diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index aef5a902829e..54390334c243 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -8,7 +8,7 @@
 
 #define IDXD_MMIO_BAR		0
 #define IDXD_WQ_BAR		2
-#define IDXD_PORTAL_SIZE	0x4000
+#define IDXD_PORTAL_SIZE	PAGE_SIZE
 
 /* MMIO Device BAR0 Registers */
 #define IDXD_VER_OFFSET			0x00
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 156a1ee233aa..417048e3c42a 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -74,7 +74,7 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	if (idxd->state != IDXD_DEV_ENABLED)
 		return -EIO;
 
-	portal = wq->dportal + idxd_get_wq_portal_offset(IDXD_PORTAL_UNLIMITED);
+	portal = wq->dportal;
 	/*
 	 * The wmb() flushes writes to coherent DMA data before possibly
 	 * triggering a DMA read. The wmb() is necessary even on UP because


