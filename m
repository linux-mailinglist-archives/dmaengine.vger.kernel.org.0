Return-Path: <dmaengine+bounces-2433-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5D290FB68
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 04:54:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 427361F21E53
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 02:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F7618EB1;
	Thu, 20 Jun 2024 02:54:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B105518026;
	Thu, 20 Jun 2024 02:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718852092; cv=none; b=HCA9v9jyd9l4T/VXx64BXgOjLBrm3zNujFQwGAL0QlPJK7gWLp0LsK57AlLGex/TMu7ULeu2Tj4pQxBs8CZzuklUKFvWrAhrrKlPgKeF4MWBGdmZ+Y7dtdEHyVWt4EdtxEurqdDC/4M6exsixcwNakXLAp1C5aGwn1xdBt6SK4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718852092; c=relaxed/simple;
	bh=tLnc3zwvRxPEXY5tUvxS5XisSdYkV41lDjfIikHHj5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hMpA1qA2njyJFWWK0tYWyia2jLhcd3/FI4ya+W9Sz+Ey3awZSFYfOFX/HLlZ5NKVqUN43ampoFy0Sw5NTGalFfyBoo8bxPDbwsj17Sfh1z0RiG8AZ/7agyBQLLuPFioD1KSMtGKewLkxadY2+K+ZVnDqcVSRAfqwC4DAU5DASqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4W4Q620lr1z1xsSP;
	Thu, 20 Jun 2024 10:53:14 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id C254E1A0188;
	Thu, 20 Jun 2024 10:54:40 +0800 (CST)
Received: from localhost.huawei.com (10.90.30.45) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Jun 2024 10:54:40 +0800
From: Jie Hai <haijie1@huawei.com>
To: <vkoul@kernel.org>, Frank Li <Frank.Li@nxp.com>, Paul Walmsley
	<paul.walmsley@sifive.com>, Samuel Holland <samuel.holland@sifive.com>, Li
 Zetao <lizetao1@huawei.com>, Guanhua Gao <guanhua.gao@nxp.com>, "open
 list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>, "open list:FREESCALE eDMA DRIVER"
	<imx@lists.linux.dev>, "open list:SIFIVE DRIVERS"
	<linux-riscv@lists.infradead.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] dmaegine: virt-dma : Fix multi-user with vchan
Date: Thu, 20 Jun 2024 10:53:53 +0800
Message-ID: <20240620025400.3300641-1-haijie1@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230720114212.51224-1-haijie1@huawei.com>
References: <20230720114212.51224-1-haijie1@huawei.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500004.china.huawei.com (7.202.181.242)

List desc_allocated was introduced for the case of a transfer
submitted multiple times. But elegating descriptors on the list
causes other problems.

For example, in the multi-thread scenario, which tasks are
continuously created and submitted by each thread. If one of
the threads calls dmaengine_terminate_all, for dirvers using
vchan_get_all_descriptors, all descriptors will be freed. If
there's another thread submitting a transfer A by
vchan_tx_submit, the following results may be generated:
1. desc A is freeing -> visit wrong address of node prep/next.
2. desc A is freed -> visit invalid address of A.

In the above case, calltrace is generated and the system is
suspended. This can be tested by dmatest.

This patch removes desc_allocated from vchan_get_all_descriptors,
and add new function 'vchan_get_all_allocated_descs' to get all
descriptors ever allocated.

And apply vchan_get_all_allocated_descs to free chan resource and
vchan_get_all_descriptors to terminate all transfers, respectively.
This avoids freeing up descriptors in use by other threads.

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c |  2 +-
 drivers/dma/fsl-edma-common.c           |  2 +-
 drivers/dma/fsl-qdma.c                  |  2 +-
 drivers/dma/sf-pdma/sf-pdma.c           |  2 +-
 drivers/dma/virt-dma.h                  | 20 ++++++++++++++++++--
 5 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
index 36384d019263..efdecf15e1b3 100644
--- a/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
+++ b/drivers/dma/fsl-dpaa2-qdma/dpaa2-qdma.c
@@ -71,7 +71,7 @@ static void dpaa2_qdma_free_chan_resources(struct dma_chan *chan)
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&dpaa2_chan->vchan.lock, flags);
-	vchan_get_all_descriptors(&dpaa2_chan->vchan, &head);
+	vchan_get_all_allocated_descs(&dpaa2_chan->vchan, &head);
 	spin_unlock_irqrestore(&dpaa2_chan->vchan.lock, flags);
 
 	vchan_dma_desc_free_list(&dpaa2_chan->vchan, &head);
diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
index 3af430787315..1e0ad87eb7fa 100644
--- a/drivers/dma/fsl-edma-common.c
+++ b/drivers/dma/fsl-edma-common.c
@@ -828,7 +828,7 @@ void fsl_edma_free_chan_resources(struct dma_chan *chan)
 	if (edma->drvdata->dmamuxs)
 		fsl_edma_chan_mux(fsl_chan, 0, false);
 	fsl_chan->edesc = NULL;
-	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
+	vchan_get_all_allocated_descs(&fsl_chan->vchan, &head);
 	fsl_edma_unprep_slave_dma(fsl_chan);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 
diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index 5005e138fc23..7af428db404e 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -316,7 +316,7 @@ static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
-	vchan_get_all_descriptors(&fsl_chan->vchan, &head);
+	vchan_get_all_allocated_descs(&fsl_chan->vchan, &head);
 	spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
 
 	vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 428473611115..4dc8a8c8ad80 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -147,7 +147,7 @@ static void sf_pdma_free_chan_resources(struct dma_chan *dchan)
 	sf_pdma_disable_request(chan);
 	kfree(chan->desc);
 	chan->desc = NULL;
-	vchan_get_all_descriptors(&chan->vchan, &head);
+	vchan_get_all_allocated_descs(&chan->vchan, &head);
 	sf_pdma_disclaim_chan(chan);
 	spin_unlock_irqrestore(&chan->vchan.lock, flags);
 	vchan_dma_desc_free_list(&chan->vchan, &head);
diff --git a/drivers/dma/virt-dma.h b/drivers/dma/virt-dma.h
index 59d9eabc8b67..4492641b79f6 100644
--- a/drivers/dma/virt-dma.h
+++ b/drivers/dma/virt-dma.h
@@ -187,13 +187,29 @@ static inline void vchan_get_all_descriptors(struct virt_dma_chan *vc,
 {
 	lockdep_assert_held(&vc->lock);
 
-	list_splice_tail_init(&vc->desc_allocated, head);
 	list_splice_tail_init(&vc->desc_submitted, head);
 	list_splice_tail_init(&vc->desc_issued, head);
 	list_splice_tail_init(&vc->desc_completed, head);
 	list_splice_tail_init(&vc->desc_terminated, head);
 }
 
+/**
+ * vchan_get_all_allocated_descs - obtain all descriptors
+ * @vc: virtual channel to get descriptors from
+ * @head: list of descriptors found
+ *
+ * vc.lock must be held by caller
+ *
+ * Removes all descriptors from internal lists, and provides a list of all
+ * descriptors found
+ */
+static inline void vchan_get_all_allocated_descs(struct virt_dma_chan *vc,
+	struct list_head *head)
+{
+	list_splice_tail_init(&vc->desc_allocated, head);
+	vchan_get_all_descriptors(vc, head);
+}
+
 static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
 {
 	struct virt_dma_desc *vd;
@@ -201,7 +217,7 @@ static inline void vchan_free_chan_resources(struct virt_dma_chan *vc)
 	LIST_HEAD(head);
 
 	spin_lock_irqsave(&vc->lock, flags);
-	vchan_get_all_descriptors(vc, &head);
+	vchan_get_all_allocated_descs(vc, &head);
 	list_for_each_entry(vd, &head, node)
 		dmaengine_desc_clear_reuse(&vd->tx);
 	spin_unlock_irqrestore(&vc->lock, flags);
-- 
2.33.0


