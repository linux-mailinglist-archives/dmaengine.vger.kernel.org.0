Return-Path: <dmaengine+bounces-8300-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 761C7D291CE
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 47F5F30918F3
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2D03358A3;
	Thu, 15 Jan 2026 22:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XoCdJUiO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBB5332EB5;
	Thu, 15 Jan 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517275; cv=none; b=FLtQwQk2K9HHNkuLmA2jP+dmBcDuiNi2iqL18XJciUuCz/E89VRx+1ARzK3EeCInaKXpuRRVpLd7Wm3dSK0aBu0WzZc/LxgU1snekkNQokjWoTEajOIuKXRItL+Q7h86/5UaRTD8nj2Qf7SAwzK3DyB10eFtwQqUq7pYLZKXNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517275; c=relaxed/simple;
	bh=KpLXdRoaik/x7bR3CGxKS3JXx10JphxEOhx8AoLyI2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rbU6a1g2wBvNNE5ft0A3n4XzwKjCkOlgDGqSmB9aoFjjb2o6h+6EIo7nAfQ0anZwnsrwBC6TIPiU1PspiRf+evdqSmwS0E8Qg+zb9oV+1t/kXIwHCwALmmym4mLyGOsIHHGpxyNr7irCVtu30GzxsETGe4h5ePE9Tya/P//zg+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XoCdJUiO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517273; x=1800053273;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KpLXdRoaik/x7bR3CGxKS3JXx10JphxEOhx8AoLyI2s=;
  b=XoCdJUiOQ7dzkXmB6+a3Bj3hW7KaRK5TiMUYJBfyP8xkmhdkDhAuhH5I
   e7xTI8XC6as/i7379eGnwjgcRf5bnJSkzlVsuBwIJkF9obznn3HyIGwtM
   bIn0FBjrGeUHMRsxEuMcg8PgjmmfHOwpVY0H8LrI8Ubv7cHhGahhvg0gE
   TQdtQAPDQOqSDvES3GZ8stMktTGJ2f65Z/BXnXlca6RiKoaDe2Si1xo1q
   HzYKo1GlFrsB9Mw6M7JftX5yukxkA3VYxLwddTbGY9i6abz6rfm2NUyYh
   V0RsVW6wyyAo2CYIN6IGG/mXePVMkYcOWw+R16Beer7uO9E+G1hUU4sWT
   A==;
X-CSE-ConnectionGUID: VwN+Y+hMQYa7jsR6S5wJZA==
X-CSE-MsgGUID: ljSD+GMQRuybWqxOvcoA6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744643"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744643"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:49 -0800
X-CSE-ConnectionGUID: S7qidUV/ReeciY5JYjLkbg==
X-CSE-MsgGUID: zCsEdskNShCKtlwdsCQy6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965465"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:49 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:28 -0800
Subject: [PATCH RESEND v2 10/10] dmaengine: idxd: Fix leaking event log
 memory
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-10-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=1193;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=KpLXdRoaik/x7bR3CGxKS3JXx10JphxEOhx8AoLyI2s=;
 b=s7fgvYfnIIDYr2zT366r6NX8wvVDfhN9bsSmmokoPym6TpTNimB4DAO8Sud2C2AhvqF2K4CuT
 67CfF1CFd0UB8wskfSzTva7aJF/ZtasRae3ftqcQ3aNhU7nqIfFfYZt
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

During the device remove process, the device is reset, causing the
configuration registers to go back to their default state, which is
zero. As the driver is checking if the event log support was enabled
before deallocating, it will fail if a reset happened before.

Do not check if the support was enabled, the check for 'idxd->evl'
being valid (only allocated if the HW capability is available) is
enough.

Fixes: 244da66cda35 ("dmaengine: idxd: setup event log configuration")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 6de61f0d486f..be6ba88d1577 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -834,10 +834,6 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	if (!evl)
 		return;
 
-	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
-	if (!gencfg.evl_en)
-		return;
-
 	mutex_lock(&evl->lock);
 	gencfg.evl_en = 0;
 	iowrite32(gencfg.bits, idxd->reg_base + IDXD_GENCFG_OFFSET);

-- 
2.52.0


