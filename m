Return-Path: <dmaengine+bounces-8292-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE81D29183
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 326313014EA5
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E885832ED5C;
	Thu, 15 Jan 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CEv6jeBj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6E627A91D;
	Thu, 15 Jan 2026 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517269; cv=none; b=FHmuTSRIWajRIUXC8baBNCMvGzNA2U9TU4rUFvfxgf4NMW3N4mmLUTwzNgVRt9W62aRRUK5jjEDCl1M6dDZycuDpFtLODXrM5O5gF2As0twUoM7Lmlzx3vbC16l2l3aiQZb5+XagDeKWbkHHqEHnpkfPMOlu7HpYszOjpJXkxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517269; c=relaxed/simple;
	bh=iLD6dAIQdTx0q9g8zeHSLNaFu3s5+AYcoK5gKpCmhiM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPzu9/MrK+rRdL7cpqM9gKsNUzU0OjikkID+9/6uw/m6h9Z3GWh1yU/Es7UsN5dBTG+aNt7/ODadK/+eYiyrnIdrk+sHN6xTtp13IU4FdlLBG0hO5VfdjWCbCRL/4YBgn10keZaTJKWf6xTyBBwQXFOy65j8BaIMxm7MjKWQjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CEv6jeBj; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517268; x=1800053268;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=iLD6dAIQdTx0q9g8zeHSLNaFu3s5+AYcoK5gKpCmhiM=;
  b=CEv6jeBjmUqefW8E0P2rXLy9bwoGxf+JifQZXs/wSMFcQtePuTmDlsEk
   zqJRCcPeK4LHWL+d2leOpfyP8canUrANxjqyuUovbdHUcIsSXiJkphFEh
   SJuAPTBDYI1mHWe/cmKCFMgCdGqDibj4JYdo5ESJBhFOJlTvCCYKXwGiN
   U4iUONY1B5nxYORbsJqXqBXRxhh7G8VlCsbELCh/Hz8x2eegBB0+pKQ88
   Key3ETuTh2p96F65rLnw3F4e9sSrPlvObs16LPoj3qEutGPxRa1A1AP9Q
   2+rtGvzTaouMmV1Dn6X0nhnvY3YhrGtcN9Dmb1JFk+8oI/c1JI2Ac3LQs
   g==;
X-CSE-ConnectionGUID: g4RMiuNFQtGXM3c3lT1ouA==
X-CSE-MsgGUID: lIjotBJtQFmFN88ziA38+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744627"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744627"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:46 -0800
X-CSE-ConnectionGUID: DZDxfnUpRSGoXgybz7M5FA==
X-CSE-MsgGUID: /tCMMSteS+yjITvDKhh9Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965431"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:46 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:20 -0800
Subject: [PATCH RESEND v2 02/10] dmaengine: idxd: Fix crash when the event
 log is disabled
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-2-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=1623;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=iLD6dAIQdTx0q9g8zeHSLNaFu3s5+AYcoK5gKpCmhiM=;
 b=Moxnt1dJ5N+BHUDL3Xquf7ZOOy5/6aPHi9KFCvAulzL/V/P4mB2XlZdL0dnte/OmTgollTj5/
 BdSfmL1iNP/Bhy/OtMXLrSen+T3pJ5Q2nPQ7+7ZjuLTHHbTJTuFqknq
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

If reporting errors to the event log is not supported by the hardware,
and an error that causes Function Level Reset (FLR) is received, the
driver will try to restore the event log even if it was not allocated.

Also, only try to free the event log if it was properly allocated.

Fixes: 6078a315aec1 ("dmaengine: idxd: Add idxd_device_config_save() and idxd_device_config_restore() helpers")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 3 +++
 drivers/dma/idxd/init.c   | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index a704475d87b3..5265925f3076 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -831,6 +831,9 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_evl *evl = idxd->evl;
 
+	if (!evl)
+		return;
+
 	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
 	if (!gencfg.evl_en)
 		return;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index dd32b81a3108..1c3f9bc7364b 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -973,7 +973,8 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
 
 	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
 
-	idxd->evl->size = saved_evl->size;
+	if (idxd->evl)
+		idxd->evl->size = saved_evl->size;
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *saved_group, *group;

-- 
2.52.0


