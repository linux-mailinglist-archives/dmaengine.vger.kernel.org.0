Return-Path: <dmaengine+bounces-3778-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC99C9D665D
	for <lists+dmaengine@lfdr.de>; Sat, 23 Nov 2024 00:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92B7D28235C
	for <lists+dmaengine@lfdr.de>; Fri, 22 Nov 2024 23:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4711DEFF5;
	Fri, 22 Nov 2024 23:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BDRKxVw2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561D31C9DCB;
	Fri, 22 Nov 2024 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732318241; cv=none; b=YLUn5Kvgi2wgGFE8W7w/6xWEcx/8Oz0UpFoVT6M/+GqGwzSNZnUIo4y7ODhc3VDWk2eOLIQ72ohHaSmAJ154/a0q4X5rGtn+bkv16IBf3uoQ/mzfePrTRriT7F0NWB0eORU0TuS/5iDI0AYk6pm81b5ThqUWz+D9uvVkSYHnRM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732318241; c=relaxed/simple;
	bh=lKegD691mBFS3bQxcyUvsTDpQBfCiZd+eZcTdkQier0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgz3ffkfwAHbutw9Q26oLEPYwNNIiKrC7Iu8jii3IlG7+mtPm6BUDd4qhCqBbOZb13kolvkNiuH6wVlhm/M3TwAME26hGNRKnBVw+jxqpWQld3rjwJqj1kVo80IlsJl4nDx2Je6+kmR1GJTSYupE/c1EsWgCr4uwz51q2VnVqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BDRKxVw2; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732318237; x=1763854237;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lKegD691mBFS3bQxcyUvsTDpQBfCiZd+eZcTdkQier0=;
  b=BDRKxVw28ioN4DBwNvP8X5R1vVXIm2yJbluOUtxqUtw9s8yh57vDDUGW
   0CBj8FkB7xUSmDmusqSpABzrdG6rw6YKZeHI3TmF/+YwwOth7vhpud0qu
   eEVzg2hZfXatRjGBVNZQ5qICfrmc1lLAzV6Tq3R6X/D4Z5CxkcGpggJuk
   rxeNlwlYCBpWOZHk7Opi7/J+r2UliFboQAV7zKJrXTw6gSns/D3BmWU1y
   FLXl5x/jyBqs/rvsxXYwN6cWXARyvNWhmifhHDeyjL5DupryOHISXvO33
   Kvl5IRJjC3vkgqU4tcHh2lEA+zEsWzYvhnIroXLl3joTO2PVR5F5ETYDl
   g==;
X-CSE-ConnectionGUID: Cew2i9RFT8Wa4qvysAaXyA==
X-CSE-MsgGUID: PEYfV/vBQmqDRIU8uH4Ukw==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="43134425"
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="43134425"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 15:30:35 -0800
X-CSE-ConnectionGUID: NS/4vwCUTou5SDHTT0uQag==
X-CSE-MsgGUID: N7CxQGoWQ76ACypRl/9n7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,177,1728975600"; 
   d="scan'208";a="95127801"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmviesa005.fm.intel.com with ESMTP; 22 Nov 2024 15:30:35 -0800
From: Fenghua Yu <fenghua.yu@intel.com>
To: "Vinod Koul" <vkoul@kernel.org>,
	"Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org,
	"linux-kernel" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 4/5] dmaengine: idxd: Refactor halt handler
Date: Fri, 22 Nov 2024 15:30:27 -0800
Message-Id: <20241122233028.2762809-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241122233028.2762809-1-fenghua.yu@intel.com>
References: <20241122233028.2762809-1-fenghua.yu@intel.com>
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


