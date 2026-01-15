Return-Path: <dmaengine+bounces-8299-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6343D291AF
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED5DC302C399
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A30C233507B;
	Thu, 15 Jan 2026 22:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CmPMpHZd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDDD332EC5;
	Thu, 15 Jan 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517274; cv=none; b=GrgTIVLmGp8UE02fyXu3kUUWg8S2N34notUqoOEi0EAKhczAo7vo6miIlcX2Kx1H+/5oM+kSnZRyAZfz0WAAoHzwVvxPGlp1tv/g1jjjhnem2tmeE0ixyekZnP+0Fmu4JBnhjhrdgWqcF6aXpQolUPh9APVlYUI4bQwOiZX83mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517274; c=relaxed/simple;
	bh=RxNM18srddSP28EYbn1kqrE9vIrJUCYN5TX9llVtj+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MLyXDUmkHrRTSWlWiNCDbxr88nFDhwhdFZ/O8uX3/hCnXaTEtjgfZCAVaiBSZaLoPqi2tNtBUCEbxkZlDjuRTL36N9FSPA3z08+aI9429AwYtGSMVbuik7M3E1Uoy8tHILDRkRcqlBn3gFHMZ8O/tZByT5VxqwnPFoMqc23noRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CmPMpHZd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517273; x=1800053273;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=RxNM18srddSP28EYbn1kqrE9vIrJUCYN5TX9llVtj+g=;
  b=CmPMpHZdqCMQtEPsV17kI/AN2dfYHvXchsxM4zUGill578bPC1PzMesa
   ly7bbRTMm/9NfvSwESdEQ/ihzfU7rQT9F+pnb4IPR6XB08iy6tHy/jvPv
   FO80BH8ODPxn6lNKOov6yrlHH5ou3iQZ5GiiuFPyzy3bmhOBd7Ou1reaM
   4+p8fWq5a02NW8sB97saTU62EBB02B9jF+ThBLBm/OxpYNlG0uhshtoMf
   LWyvW4CWAqQWVFQoHBx7FyjqYIjuC9j+RUsrLOglr8VOT4i41Qlk8quS9
   JOnQDaD6ajNOFyAnEf99kpksvrQ2c6pn+7ljXhB3MrExdh8zCSbIMD3TK
   Q==;
X-CSE-ConnectionGUID: tZY0K3XrRtOoY98IweAvJQ==
X-CSE-MsgGUID: gViNG0GmQ3C4RQlEh5UVJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744641"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744641"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:49 -0800
X-CSE-ConnectionGUID: Gu9PPzXOSQS7zMsO7G925A==
X-CSE-MsgGUID: 6gwmj6nIRJq5xDdM26U+Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965462"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:48 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:27 -0800
Subject: [PATCH RESEND v2 09/10] dmaengine: idxd: Fix freeing the allocated
 ida too late
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-9-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=1533;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=RxNM18srddSP28EYbn1kqrE9vIrJUCYN5TX9llVtj+g=;
 b=hNczthOYzRh3UUvir4qSA225qd2hXRyyXq02aJsm0ZznM1LrtPhwkxP5x3kRZDAFqe63bgq7s
 /xnc1XVG+GgC3bNraWCXiou12m94ji8SGooI9SHrSdiWAhiEIhQFLaH
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

It can happen that when the cdev .release() is called, the driver
already called ida_destroy(). Move ida_free() to the _del() path.

We see with DEBUG_KOBJECT_RELEASE enabled and forcing an early PCI
unbind.

Fixes: 04922b7445a1 ("dmaengine: idxd: fix cdev setup and free device lifetime issues")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/cdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/cdev.c b/drivers/dma/idxd/cdev.c
index 7e4715f92773..4105688cf3f0 100644
--- a/drivers/dma/idxd/cdev.c
+++ b/drivers/dma/idxd/cdev.c
@@ -158,11 +158,7 @@ static const struct device_type idxd_cdev_file_type = {
 static void idxd_cdev_dev_release(struct device *dev)
 {
 	struct idxd_cdev *idxd_cdev = dev_to_cdev(dev);
-	struct idxd_cdev_context *cdev_ctx;
-	struct idxd_wq *wq = idxd_cdev->wq;
 
-	cdev_ctx = &ictx[wq->idxd->data->type];
-	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	kfree(idxd_cdev);
 }
 
@@ -582,11 +578,15 @@ int idxd_wq_add_cdev(struct idxd_wq *wq)
 
 void idxd_wq_del_cdev(struct idxd_wq *wq)
 {
+	struct idxd_cdev_context *cdev_ctx;
 	struct idxd_cdev *idxd_cdev;
 
 	idxd_cdev = wq->idxd_cdev;
 	wq->idxd_cdev = NULL;
 	cdev_device_del(&idxd_cdev->cdev, cdev_dev(idxd_cdev));
+
+	cdev_ctx = &ictx[wq->idxd->data->type];
+	ida_free(&cdev_ctx->minor_ida, idxd_cdev->minor);
 	put_device(cdev_dev(idxd_cdev));
 }
 

-- 
2.52.0


