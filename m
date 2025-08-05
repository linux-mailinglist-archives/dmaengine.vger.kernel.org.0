Return-Path: <dmaengine+bounces-5947-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DE5B1AC08
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCDCB3BC4F2
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9553D1DE3AC;
	Tue,  5 Aug 2025 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aildRGym"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C091B5EB5;
	Tue,  5 Aug 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357297; cv=none; b=eIF4O+liSTXea4NExadtnheJfjdTOrbfXEzuM+xW9B6+gb/CPJMZtcX+4J+/1Hg6I+akwQeFM2mvfgLFaby9tZk+bl5PjonlTOIbbpPRizt4WfArZG8fegzGpVAgwUq0TdnerPh/ttGfgfc3ltTT/1CIXqjK5Hgi7NJAS+uR0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357297; c=relaxed/simple;
	bh=/0sZPC3NvpgLVkg52MwyQy6CZ79wB7OdOMTS9ZWTHf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IPOdFdhE+G4Zf2pjmiGhw7R2DbMqVJKTAeyt5e08FKO1oRQ74g2RMOfpzTBdu7htUdPh9uH+fTlmOBk6AJssJcr39NOjrIBDmB2oC0/ZCW1jrc5v8vlMh8EkcUYHkcwYXu/rbAZyWdLHMoBxugjE3mx1hdLQhPRF//gVu56Ng+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aildRGym; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357296; x=1785893296;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/0sZPC3NvpgLVkg52MwyQy6CZ79wB7OdOMTS9ZWTHf4=;
  b=aildRGymcXkGvmPoKC+czCkVrBhpF+XMt/wpWOvvcXJtVRFB6Fj2GWH6
   XTA5PqCyStHjAAU/qtWqOrp1tZRG54mFbzhkUjCABMUowIg1ppSBR26sW
   oafsei0wKLTiAMlIXb0wWsqsrXpgXEfuiYpbigUWxfV2Ro+dL1aSncjMW
   GqZy/hOXQsLAlDq02v8EYFW2u/riBNKOpeVhywOcSjrvXG2rjGct0Uako
   3klnRwpmrfhtdcjAvXzWn0lOT4RaKphTpAKNmhdMuHl4O25dVxuT+kr8t
   F1Ght/tpF3xtXfDz8xHPiPwI7vEORnZz0eOc8F0TIfPG2ybL5H20HWlpU
   A==;
X-CSE-ConnectionGUID: 8aBaCEq9SNiEWtc/z6iZzg==
X-CSE-MsgGUID: kC4vUwBsQI6bh53uVtxy9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085357"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085357"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
X-CSE-ConnectionGUID: ar6VPSbpSI6ftHlhRjuPJg==
X-CSE-MsgGUID: zTTs4lx1QweC8B9CGc4avg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699550"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:27:55 -0700
Subject: [PATCH 4/9] dmaengine: idxd: Flush kernel workqueues on Field
 Level Reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-4-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=3286;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=/0sZPC3NvpgLVkg52MwyQy6CZ79wB7OdOMTS9ZWTHf4=;
 b=j4YzlOz6bwdwVPk0wMiHgTZ4fgMUorP6fqRX0JTCSprw+af0UYBnTCSpHlfcWm8yCWXjxCYrY
 +Twpm+6xCkNBa1kZwBR6XGmIqPWGL5dbcf47jw6lud8bxXiobVZHE64
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

When a Field Level Reset (FLR) happens terminate the pending
descriptors that were issued by in-kernel users and disable the
interrupts associated with those. They will be re-enabled after FLR
finishes.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 24 ++++++++++++++++++++++++
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/dma/idxd/irq.c    |  5 +++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index c599a902767ee9904d75a0510a911596e35a259b..287cf3bf1f5a2efdc9037968e9a4eed506e489c3 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1315,6 +1315,11 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 
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
@@ -1323,6 +1328,25 @@ void idxd_wq_free_irq(struct idxd_wq *wq)
 	ie->pasid = IOMMU_PASID_INVALID;
 }
 
+void idxd_wqs_flush_descs(struct idxd_device *idxd)
+{
+	struct idxd_wq *wq;
+	int i;
+
+	for (i = 0; i < idxd->max_wqs; i++) {
+		wq = idxd->wqs[i];
+		if (wq->state == IDXD_WQ_ENABLED && wq->type == IDXD_WQT_KERNEL) {
+			struct idxd_irq_entry *ie = &wq->ie;
+
+			idxd_flush_pending_descs(ie);
+			if (idxd->request_int_handles)
+				idxd_device_release_int_handle(idxd, ie->int_handle, IDXD_IRQ_MSIX);
+			idxd_device_clear_perm_entry(idxd, ie);
+			ie->int_handle = INVALID_INT_HANDLE;
+		}
+	}
+}
+
 int idxd_wq_request_irq(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 74e6695881e6f1684512601ca2c2ee241aaf0a78..6ccca3c56556dbffe0a7c983a2f11f6c73ff2bfd 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -737,6 +737,7 @@ static inline void idxd_desc_complete(struct idxd_desc *desc,
 int idxd_register_devices(struct idxd_device *idxd);
 void idxd_unregister_devices(struct idxd_device *idxd);
 void idxd_wqs_quiesce(struct idxd_device *idxd);
+void idxd_wqs_flush_descs(struct idxd_device *idxd);
 bool idxd_queue_int_handle_resubmit(struct idxd_desc *desc);
 void multi_u64_to_bmap(unsigned long *bmap, u64 *val, int count);
 int idxd_load_iaa_device_defaults(struct idxd_device *idxd);
diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index 74059fe43fafeb930f58db21d3824f62b095b968..26547586fcfaa1b9d244b678bf8e209b7b14d35a 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -417,6 +417,11 @@ static irqreturn_t idxd_halt(struct idxd_device *idxd)
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


