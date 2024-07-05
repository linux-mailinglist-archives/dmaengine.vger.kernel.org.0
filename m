Return-Path: <dmaengine+bounces-2641-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D126928D64
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 20:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8125B223C0
	for <lists+dmaengine@lfdr.de>; Fri,  5 Jul 2024 18:15:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E8B16EB74;
	Fri,  5 Jul 2024 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIn4JjCe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ED216CD0B;
	Fri,  5 Jul 2024 18:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720203326; cv=none; b=pMvZw4aMSOaJ/OyFEYvpk1zkPnti9Z6866dkEM1d0qGn9fV+7zs5E2GY5mx5nZ9fV4J7pK40/9zUyY2YUfaew5XvAcLMPXY0EQsz0vvJiYc4VZC6LiDSYGiTp9hxNMTvN2NuciEM6ZQKtiAttcrh9TjLthk4psf/slfR8MIoycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720203326; c=relaxed/simple;
	bh=lKegD691mBFS3bQxcyUvsTDpQBfCiZd+eZcTdkQier0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yr7JTZI6UU5V6XOzPHTAtN/RS4ZbzCDixBZ7s+B3tK/JW9WjDCVAIAz97ZqkQO38kLeohQJPenuFJGUb5IRBWRxEAfShBOkNan28Za2C7fev6gOvSxjULdtl3fZoXRymH+xq3STq+Ck+IBM2oU4Z6a/Ndnj2qsmFDTJ9C6pGKPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIn4JjCe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720203324; x=1751739324;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKegD691mBFS3bQxcyUvsTDpQBfCiZd+eZcTdkQier0=;
  b=kIn4JjCehgHwWyqTUphldpuQ0pkKqCX5zKTTqnJaK3JLrqElzj6j/T7e
   3l0ndpob8+BXbF8cQl4bvoH2lDkcoHK+X6o5RD97sOai+EhOu4ZRgkM1L
   BuGLYisrJ3g68gKI1CBQe4in2ckR8euwb27NiwWTl4s1mGH9xOSfS96KS
   SHKqe/TyY1yz66eTXHQekZlaax5b1Nn78z2Tp14fbTKlowNNcNJ3Hapl+
   w4UqOXNn7810Qghp1Y9WS7mw8IccrnygYId/pgCUReQ+rI1Ooyk05qrHg
   dJVAjLiqHZTS2xbuop6aNWksEnlyzQ9aqeSCNshYWF9LeV6Mkl+c9F/sS
   Q==;
X-CSE-ConnectionGUID: O3qyOHlDS926HCe1WlZXTA==
X-CSE-MsgGUID: dpw+tnN3T+SLbeT46iylaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="12410723"
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="12410723"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 11:15:20 -0700
X-CSE-ConnectionGUID: VtjISuNQQm2wGiL1j+/GdA==
X-CSE-MsgGUID: c9uLm8LlTR+flCT38n4YXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,185,1716274800"; 
   d="scan'208";a="47672704"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orviesa008.jf.intel.com with ESMTP; 05 Jul 2024 11:15:20 -0700
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 4/5] dmaengine: idxd: Refactor halt handler
Date: Fri,  5 Jul 2024 11:15:17 -0700
Message-Id: <20240705181519.4067507-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240705181519.4067507-1-fenghua.yu@intel.com>
References: <20240705181519.4067507-1-fenghua.yu@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define a halt handling helper idxd_halt(). Refactor the halt interrupt
handler to call the helper. This will simplify the Function Level
Reset (FLR) code.

No functional change.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/irq.c | 63 +++++++++++++++++++++---------------------
 1 file changed, 31 insertions(+), 32 deletions(-)

diff --git a/drivers/dma/idxd/irq.c b/drivers/dma/idxd/irq.c
index fc049c9c9892..a46e58b756a5 100644
--- a/drivers/dma/idxd/irq.c
+++ b/drivers/dma/idxd/irq.c
@@ -383,15 +383,43 @@ static void process_evl_entries(struct idxd_device *idxd)
 	mutex_unlock(&evl->lock);
 }
 
+static irqreturn_t idxd_halt(struct idxd_device *idxd)
+{
+	union gensts_reg gensts;
+
+	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
+	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
+		idxd->state = IDXD_DEV_HALTED;
+		if (gensts.reset_type == IDXD_DEVICE_RESET_SOFTWARE) {
+			/*
+			 * If we need a software reset, we will throw the work
+			 * on a system workqueue in order to allow interrupts
+			 * for the device command completions.
+			 */
+			INIT_WORK(&idxd->work, idxd_device_reinit);
+			queue_work(idxd->wq, &idxd->work);
+		} else {
+			idxd->state = IDXD_DEV_HALTED;
+			idxd_wqs_quiesce(idxd);
+			idxd_wqs_unmap_portal(idxd);
+			idxd_device_clear_state(idxd);
+			dev_err(&idxd->pdev->dev,
+				"idxd halted, need %s.\n",
+				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
+				"FLR" : "system reset");
+		}
+	}
+
+	return IRQ_HANDLED;
+}
+
 irqreturn_t idxd_misc_thread(int vec, void *data)
 {
 	struct idxd_irq_entry *irq_entry = data;
 	struct idxd_device *idxd = ie_to_idxd(irq_entry);
 	struct device *dev = &idxd->pdev->dev;
-	union gensts_reg gensts;
 	u32 val = 0;
 	int i;
-	bool err = false;
 	u32 cause;
 
 	cause = ioread32(idxd->reg_base + IDXD_INTCAUSE_OFFSET);
@@ -401,7 +429,7 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 	iowrite32(cause, idxd->reg_base + IDXD_INTCAUSE_OFFSET);
 
 	if (cause & IDXD_INTC_HALT_STATE)
-		goto halt;
+		return idxd_halt(idxd);
 
 	if (cause & IDXD_INTC_ERR) {
 		spin_lock(&idxd->dev_lock);
@@ -435,7 +463,6 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 		for (i = 0; i < 4; i++)
 			dev_warn_ratelimited(dev, "err[%d]: %#16.16llx\n",
 					     i, idxd->sw_err.bits[i]);
-		err = true;
 	}
 
 	if (cause & IDXD_INTC_INT_HANDLE_REVOKED) {
@@ -480,34 +507,6 @@ irqreturn_t idxd_misc_thread(int vec, void *data)
 		dev_warn_once(dev, "Unexpected interrupt cause bits set: %#x\n",
 			      val);
 
-	if (!err)
-		goto out;
-
-halt:
-	gensts.bits = ioread32(idxd->reg_base + IDXD_GENSTATS_OFFSET);
-	if (gensts.state == IDXD_DEVICE_STATE_HALT) {
-		idxd->state = IDXD_DEV_HALTED;
-		if (gensts.reset_type == IDXD_DEVICE_RESET_SOFTWARE) {
-			/*
-			 * If we need a software reset, we will throw the work
-			 * on a system workqueue in order to allow interrupts
-			 * for the device command completions.
-			 */
-			INIT_WORK(&idxd->work, idxd_device_reinit);
-			queue_work(idxd->wq, &idxd->work);
-		} else {
-			idxd->state = IDXD_DEV_HALTED;
-			idxd_wqs_quiesce(idxd);
-			idxd_wqs_unmap_portal(idxd);
-			idxd_device_clear_state(idxd);
-			dev_err(&idxd->pdev->dev,
-				"idxd halted, need %s.\n",
-				gensts.reset_type == IDXD_DEVICE_RESET_FLR ?
-				"FLR" : "system reset");
-		}
-	}
-
-out:
 	return IRQ_HANDLED;
 }
 
-- 
2.37.1


