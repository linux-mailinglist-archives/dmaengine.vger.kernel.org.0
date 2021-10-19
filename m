Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C424433FE2
	for <lists+dmaengine@lfdr.de>; Tue, 19 Oct 2021 22:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhJSUnw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 19 Oct 2021 16:43:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:1523 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230147AbhJSUnv (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 19 Oct 2021 16:43:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10142"; a="215788501"
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="215788501"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 13:41:37 -0700
X-IronPort-AV: E=Sophos;i="5.87,164,1631602800"; 
   d="scan'208";a="462906593"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2021 13:41:36 -0700
Subject: [PATCH] dmaengine: idxd: cleanup completion record allocation
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org
Date:   Tue, 19 Oct 2021 13:41:36 -0700
Message-ID: <163467609628.2417190.1040580236639010770.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

According to core-api/dma-api-howto.rst, the address from
dma_alloc_coherent is gauranteed to align to the smallest PAGE_SIZE order.
That supercedes the 64B/32B alignment requirement of the completion record.
Remove alignment adjustment code.

Tested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |   22 +++++-----------------
 drivers/dma/idxd/idxd.h   |    2 --
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 1e153725432e..d9fae447b8bb 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -135,8 +135,6 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	struct idxd_device *idxd = wq->idxd;
 	struct device *dev = &idxd->pdev->dev;
 	int rc, num_descs, i;
-	int align;
-	u64 tmp;
 
 	if (wq->type != IDXD_WQT_KERNEL)
 		return 0;
@@ -148,21 +146,13 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	if (rc < 0)
 		return rc;
 
-	align = idxd->data->align;
-	wq->compls_size = num_descs * idxd->data->compl_size + align;
-	wq->compls_raw = dma_alloc_coherent(dev, wq->compls_size,
-					    &wq->compls_addr_raw, GFP_KERNEL);
-	if (!wq->compls_raw) {
+	wq->compls_size = num_descs * idxd->data->compl_size;
+	wq->compls = dma_alloc_coherent(dev, wq->compls_size, &wq->compls_addr, GFP_KERNEL);
+	if (!wq->compls) {
 		rc = -ENOMEM;
 		goto fail_alloc_compls;
 	}
 
-	/* Adjust alignment */
-	wq->compls_addr = (wq->compls_addr_raw + (align - 1)) & ~(align - 1);
-	tmp = (u64)wq->compls_raw;
-	tmp = (tmp + (align - 1)) & ~(align - 1);
-	wq->compls = (struct dsa_completion_record *)tmp;
-
 	rc = alloc_descs(wq, num_descs);
 	if (rc < 0)
 		goto fail_alloc_descs;
@@ -191,8 +181,7 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
  fail_sbitmap_init:
 	free_descs(wq);
  fail_alloc_descs:
-	dma_free_coherent(dev, wq->compls_size, wq->compls_raw,
-			  wq->compls_addr_raw);
+	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
  fail_alloc_compls:
 	free_hw_descs(wq);
 	return rc;
@@ -207,8 +196,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 
 	free_hw_descs(wq);
 	free_descs(wq);
-	dma_free_coherent(dev, wq->compls_size, wq->compls_raw,
-			  wq->compls_addr_raw);
+	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
 	sbitmap_queue_free(&wq->sbq);
 }
 
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index bfcb03329f77..0cf8d3145870 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -187,9 +187,7 @@ struct idxd_wq {
 		struct dsa_completion_record *compls;
 		struct iax_completion_record *iax_compls;
 	};
-	void *compls_raw;
 	dma_addr_t compls_addr;
-	dma_addr_t compls_addr_raw;
 	int compls_size;
 	struct idxd_desc **descs;
 	struct sbitmap_queue sbq;


