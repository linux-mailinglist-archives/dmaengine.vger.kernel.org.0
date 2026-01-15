Return-Path: <dmaengine+bounces-8290-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 287EDD29175
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7FAC83010510
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A75729DB6C;
	Thu, 15 Jan 2026 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrnMGieU"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FB0215055;
	Thu, 15 Jan 2026 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517268; cv=none; b=gPpq0Fyqp/m1fqeZZ/Wlly7zH9P5YDaLm5GeLYLiZ37KDQiLV90a84zKXlZ9zMj9Kqv1bIAd2tnaSGpWEeiuTWFtQ5AWKs75Y/QKeots12t2sK1CRgXurfoXElsylfgyMB6ZY1emfL0hrNsvAYdzMHtHyXRGgNVNSnAT975H/HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517268; c=relaxed/simple;
	bh=g6IWX2XetpylJK4fyRnEati4+Qz9GR1IshBok4lVQVw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=taUCBnsPO5/Ho3f85JrlW6XbL5jTWjJeJhdSmpjWymq8Mfh33GyZoiLH1Gh8oTmNqDcq4BpJN3OhF8G9dgSmLb9HaazJfKyYCAnIAH18sI0iypljFGIDTVkOR74y6qRhu4EsgGMm7jTz8XOGH884bcnL+tz47OcZ1qU8Jztbx2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrnMGieU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517267; x=1800053267;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=g6IWX2XetpylJK4fyRnEati4+Qz9GR1IshBok4lVQVw=;
  b=JrnMGieUtB7oB8s24f/47Z+ISOAguBThj7g7y5ZIRH4L28TccVKW3GKT
   VCa04qzjTA7Kz0Yl/JSdGO48AtChqCafEAIhRjua7tup79ICYOAZm5gIi
   8+Gn0VRo6BNj96AQP9YX4XVuAHvuTdL2q5hYkzR90ww7a+tqopMCMkDUh
   o6QoBOiiMGyzWKxcJRjYqL0znRtfxS9LcmsGZ8JD42HDtpxtajCR7UBan
   s5fFW9p0DgrmeR3TG2a30Q5YIrX+1VAiZXt2K90qhZS5+C08ty35egYRa
   47x8SWUUYGdQeTtnDweCye6KQ4yTfvkLW2LPeHpOGjSyEKFshJABBV4Zh
   g==;
X-CSE-ConnectionGUID: W5yGQZOyTTOdBsX6nYU+iw==
X-CSE-MsgGUID: 5X3Glpl7SUOwrJVDNz/n9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744623"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744623"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:46 -0800
X-CSE-ConnectionGUID: oqyIzf9HQ0GUvNbEdRrA2g==
X-CSE-MsgGUID: dX1r+ZbzTNSLvhUQn6jjHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965424"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:46 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: [PATCH RESEND v2 00/10] dmaengine: idxd: Memory leak and FLR fixes
Date: Thu, 15 Jan 2026 14:47:18 -0800
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHduaWkC/42NMQ+CMBBG/4rp7Jm2UEEnB1kddDQOUK7SiEVba
 DCE/27TiZHx3X15byIOrUZHjpuJWPTa6c4E4NsNkU1pngi6Dkw45YLmNA041qD0CKq10Bl4oTX
 YwnfAAR34BFiikqys6oxlOQmaj8Uwj4k7uRa34nImj3BvtOs7+4tlz+J3fcQzoJAi5VRVSnDJT
 tr02O5k945yzxdCzlYIeRCKg6jTXJV0L+RSOM/zH78ECWgpAQAA
X-Change-ID: 20250804-idxd-fix-flr-on-kernel-queues-v3-13f37abd7178
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=2104;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=g6IWX2XetpylJK4fyRnEati4+Qz9GR1IshBok4lVQVw=;
 b=zz8nHH79+9+7IlH2NjgFW5W4ZdJrqttW2YG+GHAx4mkjNWfRutd4fV1FRUuvADllxPZu3V3nF
 TM98Q/5y1nQBq7Ayne4w5hfCb6ln69LjUDGzCSamCuZxa5Iu+0RYY75
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

Hi,

During testing some not so happy code paths in a debugging (lockdep,
kmemleak, etc) kernel, found a few issues.

No code changes, just rebased against 'dmaengine/next'. The cover
letter was edited to remove not helpful text.

Cheers,

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
Changes in v2:
- Fixed messing up the definition of FLR (Function Level
  Reset) (Nathan Lynch)
- Simplified callers of idxd_device_config(), moved a common check,
  and locking to inside the function (Dave Jiang);
- For idxd DMA backend, ->terminate_all() now flushes all pending
  descriptors (Dave Jiang);
- For idxd DMA backend, ->device_synchronize() now waits for submitted
  operations to finish (Dave Jiang);
- Link to v1: https://lore.kernel.org/r/20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com

---
Vinicius Costa Gomes (10):
      dmaengine: idxd: Fix lockdep warnings when calling idxd_device_config()
      dmaengine: idxd: Fix crash when the event log is disabled
      dmaengine: idxd: Fix possible invalid memory access after FLR
      dmaengine: idxd: Flush kernel workqueues on Function Level Reset
      dmaengine: idxd: Flush all pending descriptors
      dmaengine: idxd: Wait for submitted operations on .device_synchronize()
      dmaengine: idxd: Fix not releasing workqueue on .release()
      dmaengine: idxd: Fix memory leak when a wq is reset
      dmaengine: idxd: Fix freeing the allocated ida too late
      dmaengine: idxd: Fix leaking event log memory

 drivers/dma/idxd/cdev.c   |  8 ++++----
 drivers/dma/idxd/device.c | 43 +++++++++++++++++++++++++++++--------------
 drivers/dma/idxd/dma.c    | 18 ++++++++++++++++++
 drivers/dma/idxd/idxd.h   |  1 +
 drivers/dma/idxd/init.c   | 14 +++++++-------
 drivers/dma/idxd/irq.c    | 16 ++++++++++++++++
 drivers/dma/idxd/sysfs.c  |  1 +
 7 files changed, 76 insertions(+), 25 deletions(-)
---
base-commit: 3c8a86ed002ab8fb287ee4ec92f0fd6ac5b291d2
change-id: 20250804-idxd-fix-flr-on-kernel-queues-v3-13f37abd7178

Best regards,
--  
Vinicius


