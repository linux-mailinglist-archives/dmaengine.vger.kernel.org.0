Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4772D3D037A
	for <lists+dmaengine@lfdr.de>; Tue, 20 Jul 2021 22:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhGTULv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Jul 2021 16:11:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:59798 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234651AbhGTUBi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Jul 2021 16:01:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="208207247"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="208207247"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:42:05 -0700
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="510910103"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:42:04 -0700
Subject: [PATCH] dmaengine: idxd: rotate portal address for better performance
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 20 Jul 2021 13:42:04 -0700
Message-ID: <162681372446.1968485.10634280461681015569.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The device submission portal is on a 4k page and any of those 64bit aligned
address on the page can be used for descriptor submission. By rotating the
offset through the 4k range and prevent successive writes to the same MMIO
address, performance improvement is observed through testing.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    1 +
 drivers/dma/idxd/idxd.h   |   20 ++++++++++++++++++++
 drivers/dma/idxd/submit.c |    2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 99350ac9a292..41f67a195eb6 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -320,6 +320,7 @@ void idxd_wq_unmap_portal(struct idxd_wq *wq)
 
 	devm_iounmap(dev, wq->portal);
 	wq->portal = NULL;
+	wq->portal_offset = 0;
 }
 
 void idxd_wqs_unmap_portal(struct idxd_device *idxd)
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index d0874d8877d9..34d4f43bfedc 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -11,6 +11,7 @@
 #include <linux/idr.h>
 #include <linux/pci.h>
 #include <linux/perf_event.h>
+#include <uapi/linux/idxd.h>
 #include "registers.h"
 
 #define IDXD_DRIVER_VERSION	"1.00"
@@ -161,6 +162,7 @@ struct idxd_dma_chan {
 
 struct idxd_wq {
 	void __iomem *portal;
+	u32 portal_offset;
 	struct percpu_ref wq_active;
 	struct completion wq_dead;
 	struct idxd_dev idxd_dev;
@@ -467,6 +469,24 @@ static inline int idxd_get_wq_portal_full_offset(int wq_id,
 	return ((wq_id * 4) << PAGE_SHIFT) + idxd_get_wq_portal_offset(prot);
 }
 
+#define IDXD_PORTAL_MASK	(PAGE_SIZE - 1)
+
+/*
+ * Even though this function can be accessed by multiple threads, it is safe to use.
+ * At worst the address gets used more than once before it gets incremented. We don't
+ * hit a threshold until iops becomes many million times a second. So the occasional
+ * reuse of the same address is tolerable compare to using an atomic variable. This is
+ * safe on a system that has atomic load/store for 32bit integers. Given that this is an
+ * Intel iEP device, that should not be a problem.
+ */
+static inline void __iomem *idxd_wq_portal_addr(struct idxd_wq *wq)
+{
+	int ofs = wq->portal_offset;
+
+	wq->portal_offset = (ofs + sizeof(struct dsa_raw_desc)) & IDXD_PORTAL_MASK;
+	return wq->portal + ofs;
+}
+
 static inline void idxd_wq_get(struct idxd_wq *wq)
 {
 	wq->client_count++;
diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 6ef704dd4d0b..43efbde696b5 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -146,7 +146,7 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 	if (!percpu_ref_tryget_live(&wq->wq_active))
 		return -ENXIO;
 
-	portal = wq->portal;
+	portal = idxd_wq_portal_addr(wq);
 
 	/*
 	 * The wmb() flushes writes to coherent DMA data before


