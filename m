Return-Path: <dmaengine+bounces-6109-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4F56B309BC
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66BDAB64ED8
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 22:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187E82EBB80;
	Thu, 21 Aug 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YflNOWUP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC32EAB84;
	Thu, 21 Aug 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817215; cv=none; b=Reink5AYM8jKtGk0pufTxolwwGieJT9Y3DK4enpKTmrSM0K0iLfAIa5wCJB/YzKOdei3y3vKIfFcJtSIyOkWaTtfC3HvguD+QkXcL/ogIktW7eYBJH1dp2qaJq1Z63TXVe9TfMu+LiExeh4No15rr+m+XvYmHw6LG/U+u/VoZyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817215; c=relaxed/simple;
	bh=1rsBcE9VpQ7SBF4zvv4WFKkDlb1Z7pK2vW4cbeyBbSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9iy0iYaBfFgtQ/xWxr8TjLS5rveeVN6PdCdrFjex/tvzQKFSX2b4IpJE4xqxnAZogIvKA8dqlxZFp3SBYVhFM6wCVRmQvKRsNLpul+piSHRQ0Re0HFHMZaAiLqOZvTU+BnzjsjNB+b3a2sMvShWVWsENnSQBs7uDYOyKl4hick=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YflNOWUP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817213; x=1787353213;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=1rsBcE9VpQ7SBF4zvv4WFKkDlb1Z7pK2vW4cbeyBbSo=;
  b=YflNOWUPIJCTq4FxNDCl5NC84w1OHSeDHqaOHxWYaTyPFCbc1SckRKEY
   +TYgBWEfU/8A5D2xi1GRMPS9UR0qLHcaYBikRxSDwVtRiTu50fwY38gKn
   eJ4GghY2yAcvWcoJFgHxK1nAyUr/1Wvd936kuhuPszn4rY+3euWR/yT35
   4J4taBysS5gNHkcHk14JdhLFfrO8jLyuz4u5tvFtZDKM7+u+rUqduc5q2
   WFngC4NDZFAnZE3c0AbYqRTehzmubW/Fb6koDzC8+SFQ18t2squ0wE/ji
   XwS9PezXZ4XKcQmVH5lLUbdmUurfupxc+6H548bbL9v6ox3CN8MjMDd7c
   w==;
X-CSE-ConnectionGUID: 9BBRUgjJQwyukPtxG6zbgA==
X-CSE-MsgGUID: uAaVa6ScTvq2vNALCGGOKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748490"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748490"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
X-CSE-ConnectionGUID: NwuQRM3lRwWgawzKTrdlfg==
X-CSE-MsgGUID: QSQtNPCkT9eburAQIj3FGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444354"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:38 -0700
Subject: [PATCH v2 04/10] dmaengine: idxd: Flush kernel workqueues on
 Function Level Reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-4-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=3438;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=1rsBcE9VpQ7SBF4zvv4WFKkDlb1Z7pK2vW4cbeyBbSo=;
 b=YyIl5d254g1vwD9QdQQ4ozm+UxA721DiFOMtzj14xvo/D1DmGSaFLf/jWoGoMpSk6RHOMlYGy
 NRulHKT6bAXB7+dXxlkJi1nTI1aHNLEraGIIpdo1lp2FuRqqVqvT0MC
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

When a Function Level Reset (FLR) happens, terminate the pending
descriptors that were issued by in-kernel users and disable the
interrupts associated with those. They will be re-enabled after FLR
finishes.

idxd_wq_flush_desc() is declared on idxd.h because it's going to be
used in by the DMA backend in a future patch.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 20 ++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 02bda8868e24..c62808e30417 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1319,6 +1319,11 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 
 	free_irq(ie->vector, ie);
 	idxd_flush_pending_descs(ie);
+
+	/* The interrupt might have been already released by FLR */
+	if (ie->int_handle == INVALID_INT_HANDLE)
+		return;
+
 	if (idxd->request_int_handles)
 		idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
 	idxd_device_clear_perm_entry(idxd, ie);
@@ -1327,6 +1332,21 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 	ie->pasid = IOMMU_PASID_INVALID;
 }
 
+void idxd_wq_flush_descs(struct idxd_wq *wq)
+{
+	struct idxd_irq_entry *ie = &wq->ie;
+	struct idxd_device *idxd = wq->idxd;
+
+	if (wq->state != IDXD_WQ_ENABLED || wq->type != IDXD_WQT_KERNEL)
+		return;
+
+	idxd_flush_pending_descs(ie);
+	if (idxd->request_int_handles)
+		idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
+	idxd_device_clear_perm_entry(idxd, ie);
+	ie->int_handle = INVALID_INT_HANDLE;
+}
+
 int idxd_wq_request_irq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 74e6695881e6..fb7f570e002b 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -784,6 +784,7 @@ void idxd_wq_quiesce(struct idxd_wq *wq);
 int idxd_wq_init_percpu_ref(struct idxd_wq *wq);
 void idxd_wq_free_irq(struct idxd_wq *wq);
 int idxd_wq_request_irq(struct idxd_wq *wq);
+void idxd_wq_flush_descs(struct idxd_wq *wq);
 
 /* submission */
 int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 1107db3ce0a3..8d0eaf5029fa 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -397,6 +397,17 @@ static void idxd_device_flr(struct work_struct *work)
 		dev_err(&idxd->pdev->dev, "FLR failed\n");
 }
 
+static void idxd_wqs_flush_descs(struct idxd_device *idxd)
+{
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		struct idxd_wq *wq = idxd->wqs[i];
+
+		idxd_wq_flush_descs(wq);
+	}
+}
+
 static irqreturn_t idxd_halt(struct idxd_device *idxd)
 {
 	union gensts_reg gensts;
@@ -415,6 +426,11 @@ static irqreturn_t idxd_halt(struct idxd_device *idxd)
 		} else if (gensts.reset_type == IDXD_DEVICE_RESET_FLR) {
 			idxd->state = IDXD_DEV_HALTED;
 			idxd_mask_error_interrupts(idxd);
+			/* Flush all pending descriptors, and disable
+			 * interrupts, they will be re-enabled when FLR
+			 * concludes.
+			 */
+			idxd_wqs_flush_descs(idxd);
 			dev_dbg(&idxd->pdev->dev,
 				"idxd halted, doing FLR. After FLR, configs are restored\n");
 			INIT_WORK(&idxd->work, idxd_device_flr);

-- 
2.50.1


