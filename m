Return-Path: <dmaengine+bounces-8291-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7F1D2917D
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F93130389BE
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F5E31A7FD;
	Thu, 15 Jan 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mElcAp5+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA3150094C;
	Thu, 15 Jan 2026 22:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517269; cv=none; b=h2Oeb719qReVGGrtEKqTsLLvTbjWvEo7woiJ1cR5MCEZJhJ5c+L0BV3Zy6Z7mhq0xYuQe5chUZzf/OvlCkaSVY2axGk7QzJUFAreuwAZCkO2QCc+gInAXfVl2kAymj0VQ0ySxRFOoxVhSkLzABH2hrk9iXEfWweYQNAyqnnvrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517269; c=relaxed/simple;
	bh=EqY+KQZRvX9sO7EOaoaSOiJxezrgX+A/PifeBN3VL1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6gIZf6OpD7/ekic3DdAtEck7peYFnw2TB8BhbqL9ctUBHvK3SWUUbXy1yX2h04cYWWCjglGvOSJUK+PBs8Yp3u2wV2lhkf6fYQDvB2gxu0nJUYD+5jvUNBsQJ8dMcRX14fIvO+UYLE0/J7Vey4ezs8MuyPcHQzF1Cgl+w49Pn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mElcAp5+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517268; x=1800053268;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=EqY+KQZRvX9sO7EOaoaSOiJxezrgX+A/PifeBN3VL1w=;
  b=mElcAp5+kNWBPtT/Ln99KP0gKhc/GUiZQwWrmRgPIC2oHwLCE6Us8Iky
   zqK87q39luOLjOfEsonWusG123hnW4z/Ea/WIlIOQ5tz2VBlHeUZjyIQ5
   SRMYqNQb8d7SmlWG8KI2qHhGudI52DaITCOpzN6cCPqvbd5YKswwT+USU
   X9adcWVORRBtU34THxhxwMWpHKyxfUh0X+2BovFR2ai6UqPjEQQ+iVtLO
   LQjY/HdttBL4QzGvDlG8IbPrpRnoQUCrWj95ljj7ihCKM70b5VO/GHTdp
   jtlQ9v5H18EZbukO1J5W6yy9fe7iPCNlo4eO4nBFOoxmiJSEoG/GoGkdm
   w==;
X-CSE-ConnectionGUID: DZBpAEuuRR6umnGul3vetQ==
X-CSE-MsgGUID: KqIMPLI5Sjqq+TwNcsdYhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744626"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744626"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:46 -0800
X-CSE-ConnectionGUID: MLxKiL1MSYefl1U3BJ4X1w==
X-CSE-MsgGUID: GQ/6KFCwQ8u5y4ctnuHxUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965427"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:46 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:19 -0800
Subject: [PATCH RESEND v2 01/10] dmaengine: idxd: Fix lockdep warnings when
 calling idxd_device_config()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-1-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=2407;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=EqY+KQZRvX9sO7EOaoaSOiJxezrgX+A/PifeBN3VL1w=;
 b=jFS5D7tCSyzY8n/alaRQ7wZ/ZNIAX81d321AleqOARZ5QFVkRiczjff8bNlBAVrdexcKfKV2N
 qQ8bZKi4OraDTHTPhxWW1MCYbHesdkEojLXS3WTtD4MejooesIhymIi
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

Move the check for IDXD_FLAG_CONFIGURABLE and the locking to "inside"
idxd_device_config(), as this is common to all callers, and the one
that wasn't holding the lock was an error (that was causing the
lockdep warning).

Suggested-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 17 +++++++----------
 drivers/dma/idxd/init.c   | 10 ++++------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index c26128529ff4..a704475d87b3 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -1125,7 +1125,11 @@ int idxd_device_config(struct idxd_device *idxd)
 {
 	int rc;
 
-	lockdep_assert_held(&idxd->dev_lock);
+	guard(spinlock)(&idxd->dev_lock);
+
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return 0;
+
 	rc = idxd_wqs_setup(idxd);
 	if (rc < 0)
 		return rc;
@@ -1454,11 +1458,7 @@ int idxd_drv_enable_wq(struct idxd_wq *wq)
 		}
 	}
 
-	rc = 0;
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0) {
 		dev_dbg(dev, "Writing wq %d config failed: %d\n", wq->id, rc);
 		goto err;
@@ -1554,10 +1554,7 @@ int idxd_device_drv_probe(struct idxd_dev *idxd_dev)
 	}
 
 	/* Device configuration */
-	spin_lock(&idxd->dev_lock);
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
-		rc = idxd_device_config(idxd);
-	spin_unlock(&idxd->dev_lock);
+	rc = idxd_device_config(idxd);
 	if (rc < 0)
 		return -ENXIO;
 
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index fb80803d5b57..dd32b81a3108 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -1104,12 +1104,10 @@ static void idxd_reset_done(struct pci_dev *pdev)
 	idxd_device_config_restore(idxd, idxd->idxd_saved);
 
 	/* Re-configure IDXD device if allowed. */
-	if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags)) {
-		rc = idxd_device_config(idxd);
-		if (rc < 0) {
-			dev_err(dev, "HALT: %s config fails\n", idxd_name);
-			goto out;
-		}
+	rc = idxd_device_config(idxd);
+	if (rc < 0) {
+		dev_err(dev, "HALT: %s config fails\n", idxd_name);
+		goto out;
 	}
 
 	/* Bind IDXD device to driver. */

-- 
2.52.0


