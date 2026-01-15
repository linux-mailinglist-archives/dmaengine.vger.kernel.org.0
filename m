Return-Path: <dmaengine+bounces-8297-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D072D291AB
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 088F130751E8
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB21332EB1;
	Thu, 15 Jan 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f5xAWyu4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A96933121E;
	Thu, 15 Jan 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517273; cv=none; b=QdgUoo2OOZYf7N4SoXq4IEHs1Hx08WmYwc9Z2OUa+p9xLyrCchXvrGsg1TwZt13wp2qHHYS8Uj8z2UK3U7/37k1LY8eAgCAj8VV9M6RhW2qz3eaIxQ+yM6UNDWpCPnVl8VxVqThlT+k9sr3CgPblPiSrnasBERWlR6SvgQgfAQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517273; c=relaxed/simple;
	bh=E6r10Vjgp+Cb+VrpjpK4E2zB/lECRR5DHSeVUSGCkHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L88shwFjcZA23HkdumpDvJUHGWhAlxfC6Cr9y/2IcNBQPmJRKSVFTVXhkowyY7Bs4/SxKTi/Yub8GnWfbCcAJGRkzfOcmtUhLYiE37Wc6j7t3yhRWn/H4deCU8X2wj9RsOKVNZMeizGSxk6Xb1ZsKaNt1QGvzCuZHhSZHzLin0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f5xAWyu4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517271; x=1800053271;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=E6r10Vjgp+Cb+VrpjpK4E2zB/lECRR5DHSeVUSGCkHQ=;
  b=f5xAWyu4g/pKxYUpbXfjHVQjlASkJfC1/jr8GIVeV5fOJ5o3KKmj4GCQ
   vueIhXjSv05JIQIqiV5tVRgWc3vjv0f+BcMubL7HHow9xiUIvL5rkU2mm
   HbTuaRkYDkeQ2iBTdvhtj+Hn4gNvsHdYSaD1ZPx8ZKKMcpcRnFny1xV41
   OJca0UG6Pzs7kcS7oEkf59cjbY0rtsguHJmXD1Jphg+AKIuwUuNdT1Tu3
   HtY0PJIO9R0j1nhkUZ62vqGlpPeDO+StOFH2AJegj/pUdozvhzpYhsV1F
   0J9wmDIk5aiMRO+Di8b95PmQWDPTgcfRoSgg9lIQ8e63/8HmBnLPEGE8F
   A==;
X-CSE-ConnectionGUID: i+o/T1SbRVuLoVgJ0/uKkQ==
X-CSE-MsgGUID: +iunSySwQne7CrLeLRL1GQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744639"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744639"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:48 -0800
X-CSE-ConnectionGUID: eLoMXfkMQWihKh4NlRYYKg==
X-CSE-MsgGUID: 59lMaDfbTvig76EMi6h8BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965459"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:48 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:26 -0800
Subject: [PATCH RESEND v2 08/10] dmaengine: idxd: Fix memory leak when a wq
 is reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-8-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=1614;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=E6r10Vjgp+Cb+VrpjpK4E2zB/lECRR5DHSeVUSGCkHQ=;
 b=GNFLQ+zY5HMpRrab3sX43uULogUkShaQmwb2BXQ/e/ri3eKr75cbdHiJF1gbPptcoS+RT8J1E
 JoYvSaEi5I/ARIkK9/z5xC0NePwZ9eAcI8YC7LzQnQEnxgqT265icsk
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

idxd_wq_disable_cleanup() which is called from the reset path for a
workqueue, sets the wq type to NONE, which for other parts of the
driver mean that the wq is empty (all its resources were released).

Only set the wq type to NONE after its resources are released.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index b8422dc7d2ca..6de61f0d486f 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -175,6 +175,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 	free_descs(wq);
 	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
 	sbitmap_queue_free(&wq->sbq);
+	wq->type = IDXD_WQT_NONE;
 }
 EXPORT_SYMBOL_NS_GPL(idxd_wq_free_resources, "IDXD");
 
@@ -382,7 +383,6 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	lockdep_assert_held(&wq->wq_lock);
 	wq->state = IDXD_WQ_DISABLED;
 	memset(wq->wqcfg, 0, idxd->wqcfg_size);
-	wq->type = IDXD_WQT_NONE;
 	wq->threshold = 0;
 	wq->priority = 0;
 	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
@@ -1556,7 +1556,6 @@ void idxd_drv_disable_wq(struct idxd_wq *wq)
 	idxd_wq_reset(wq);
 	idxd_wq_free_resources(wq);
 	percpu_ref_exit(&wq->wq_active);
-	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
 EXPORT_SYMBOL_NS_GPL(idxd_drv_disable_wq, "IDXD");

-- 
2.52.0


