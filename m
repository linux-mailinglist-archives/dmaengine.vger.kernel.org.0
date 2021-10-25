Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE95B43997D
	for <lists+dmaengine@lfdr.de>; Mon, 25 Oct 2021 16:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbhJYPCN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Oct 2021 11:02:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:47175 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233520AbhJYPCM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 25 Oct 2021 11:02:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="209767794"
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="209767794"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 07:59:50 -0700
X-IronPort-AV: E=Sophos;i="5.87,180,1631602800"; 
   d="scan'208";a="464909085"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 07:59:49 -0700
Subject: [PATCH v2] dmaengine: idxd: cleanup completion record allocation
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        dmaengine@vger.kernel.org
Date:   Mon, 25 Oct 2021 07:59:49 -0700
Message-ID: <163517396063.3484297.7494385225280705372.stgit@djiang5-desk3.ch.intel.com>
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

v2: rebase against latest dmaengine/next

 drivers/dma/idxd/device.c |   22 +++++-----------------
 drivers/dma/idxd/idxd.h   |    2 --
 2 files changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index b1407465d5c4..fab412349f7f 100644
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


