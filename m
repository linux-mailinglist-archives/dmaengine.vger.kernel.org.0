Return-Path: <dmaengine+bounces-6107-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69AB309B8
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 840E11CE6DDE
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C232EAD01;
	Thu, 21 Aug 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOV6KYca"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32C2D97AA;
	Thu, 21 Aug 2025 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817213; cv=none; b=sp76eskbEZZ+6ghert3lzzp6mpkyCnJ7iG3AdZkhFZ39cDWOJpeoV7vrMaDfqITVFpisu4q94kHazK5OJy4Bvf4xnZ3z+iGMofEop1Yt3lMzAuekSgTYJ7n5BBiDF95hhEWMG+JFyWC/5rQtuN8DptON755eWSXNPXjPY4YYKmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817213; c=relaxed/simple;
	bh=LiR6UiEa6acPjfQGxMqC+K0UeXnvHSJT9NIh4YbeZ30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFPtra8xnI+TgAotRDPnJCmvcM2W6MXqUQljf9c3lzBMBa1g37lP0JQ5BiDqeT5CMKWt0yxX1wUEAfJXhMvVuzbL4jsI+8gGFLgGkBpGoRqqb8Sr+z5B1Km9j8/lBZKD6tbWy+49Gg/s+vkFxtFyDNqXhfcc76WUCGJSnmCoPSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOV6KYca; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817212; x=1787353212;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=LiR6UiEa6acPjfQGxMqC+K0UeXnvHSJT9NIh4YbeZ30=;
  b=ZOV6KYca5oIKX9wPWCEJ2vs6BXRy0VjrXNZlZAyBVm/9dXmbiSfmPVFU
   p3vHSZzgcQ4pOq0YjhBWYIeF3R7obbQ254Bh68FcjC51UA1KSb1BBKixq
   NuVUL+BJvHU3tTWg4KJHuGfPMaXS0QW78K9j1Ifs6E1FPcRXkLwwpqXyN
   Wb6M/NRlQ/dR1+gWyfj+gXF4ANNRn6Mw9XX3aEMFVHiooOSG3TRfwlxT8
   wcWfT9GxGnGbQC7r2IG68I2IY6/yE3xKwHntjZLs7V2P91P38WDhRaWLM
   3WN4ZF6NcCtlBcUPx3KgTqSKcAUt9u6g3eUoxrduCVJyGYurjh7SX8zBR
   A==;
X-CSE-ConnectionGUID: pcEXy5utSta4+K1L0eXhZQ==
X-CSE-MsgGUID: YS1Y3a0lT6+minK4tcs34g==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748486"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748486"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
X-CSE-ConnectionGUID: oWxBUYvoS2abppPH2MeupA==
X-CSE-MsgGUID: K5WnBS57RV+nCquSKDP7WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444345"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:36 -0700
Subject: [PATCH v2 02/10] dmaengine: idxd: Fix crash when the event log is
 disabled
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-2-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=1623;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=LiR6UiEa6acPjfQGxMqC+K0UeXnvHSJT9NIh4YbeZ30=;
 b=e/b/icctIIed9YVVOP6pe6vv3mxqZtqaQX336MfijQeOTCvfyD5nvd1ZVUeY+Za1t7Zezf0zw
 D+swy58AYSTAIg/fdDkoAyLyfwozM6E43vcos3OmelP8C7mIvW8fZez
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
index ac41889e4fe1..02bda8868e24 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -815,6 +815,9 @@ static void idxd_device_evl_free(struct idxd_device *idxd)
 	struct device *dev = &idxd->pdev->dev;
 	struct idxd_evl *evl = idxd->evl;
 
+	if (!evl)
+		return;
+
 	gencfg.bits = ioread32(idxd->reg_base + IDXD_GENCFG_OFFSET);
 	if (!gencfg.evl_en)
 		return;
diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
index c25bd0595561..e9fe5471f722 100644
--- a/drivers/dma/idxd/init.c
+++ b/drivers/dma/idxd/init.c
@@ -961,7 +961,8 @@ static void idxd_device_config_restore(struct idxd_device *idxd,
 
 	idxd->rdbuf_limit = idxd_saved->saved_idxd.rdbuf_limit;
 
-	idxd->evl->size = saved_evl->size;
+	if (idxd->evl)
+		idxd->evl->size = saved_evl->size;
 
 	for (i = 0; i < idxd->max_groups; i++) {
 		struct idxd_group *saved_group, *group;

-- 
2.50.1


