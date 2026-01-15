Return-Path: <dmaengine+bounces-8293-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C2163D29193
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 950503051B59
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C36F330D32;
	Thu, 15 Jan 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B5G6u8Jg"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2634131A80E;
	Thu, 15 Jan 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517271; cv=none; b=X3kk+ZfZJbybALn7aiuHMvHwBoUS8GGG9s4qp4Z2HVLm1Ond0oC914Wl92SEpHgtPVJKoYNEMhkcHfH5Vb9Uv/DEg/5HuMRVzNI8lK05mhQ7Q7oWOCkNLpbIO6kHyGFnblTt2fspDmsYCDreM3wV14ISTIrCc+lJa8kWG4EFH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517271; c=relaxed/simple;
	bh=fQFVrrJvhOcF42eR0C7CrMxagcf0o/IjdULewIHfil8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HA+ObqPzXSnlxzamEeVkDurG8txUeUDael1pcvl2BPjvtKqdwYseQuYaTDycgE5GrMBO+OZ7zkIFENkgLJv7uqbO8IM0hpa7f0BQzaoNg/QJMVVSxyRjVWiHnYA3Zm9xTc3/Dm1ksx8X7+NMJDpJ0Ef8X3eJ3O2hYfuyIOlyB/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B5G6u8Jg; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517269; x=1800053269;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fQFVrrJvhOcF42eR0C7CrMxagcf0o/IjdULewIHfil8=;
  b=B5G6u8JgVNJbBHaUnmY7JVyGo9CJRctuGlcWuqk9fmNKnIAmysf7ul7A
   lLpaQFJPrlzKJfZVXT8zUQcoEvw14zKIpLIkbRsajt9Q6k3dgc/Be4JdK
   mRXgPhP6LunmnPQbLhERirax/FBbuzfy/DA5hcfPLirwgfNqqbhNwjRCB
   72fFF8F+Cw2cxQ2yf0sZ6ceGHyHErb5c+KRv6o9Ok8drAt4VITx69d6tJ
   jD84kHqWnX6fQOPxV3i0NTYwXJU5JEIzhze3NzK9SuHe+U7HadVlA36Mn
   0R+xKhZ39DyCJxkKhzH/BR6iZ+xeyg6bTqE2o9Xt9ATpqwbjgaYisXqbo
   Q==;
X-CSE-ConnectionGUID: rglov05USFucSnjEyS29ow==
X-CSE-MsgGUID: 0PaND2vVQYiv43K2lT+u4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744631"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744631"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:47 -0800
X-CSE-ConnectionGUID: VbqMkWIWTm+OQnJUBQ+zEw==
X-CSE-MsgGUID: gspDh6+kSfydO0YgkzO1Pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965439"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:47 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:22 -0800
Subject: [PATCH RESEND v2 04/10] dmaengine: idxd: Flush kernel workqueues
 on Function Level Reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-4-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=3438;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=fQFVrrJvhOcF42eR0C7CrMxagcf0o/IjdULewIHfil8=;
 b=vkSq/oIgsCaVMqt/Qds3dt8itJj3JZU9gLg2g/2jrf9bGuMVFzFXQbrn8H3FGoOGDZK8I2q9s
 3JAP4Klip2aDEHcOX1hzcUR931WWPdjJJVgE2PO4BV+rRq8NKiRi6d0
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
index 5265925f3076..b8422dc7d2ca 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1339,6 +1339,11 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 
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
@@ -1347,6 +1352,21 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
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
index ea8c4daed38d..ce78b9a7c641 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -803,6 +803,7 @@ void idxd_wq_quiesce(struct idxd_wq *wq);
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
2.52.0


