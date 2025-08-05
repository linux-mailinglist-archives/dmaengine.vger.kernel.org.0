Return-Path: <dmaengine+bounces-5949-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE0B1AC0D
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 654C317EF2B
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2021EEA55;
	Tue,  5 Aug 2025 01:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jg6rzp8d"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492B71D63F3;
	Tue,  5 Aug 2025 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357298; cv=none; b=JwnJigGS7vUKJT6fg/15LDyNwtK4JZtOs0bCZImss5GtqweiFSOffp3oV8CZEkYjKF8GiXiA4WI778a07xmONK2WFCOBirhYih0PWNvFv87mEnpgleqx8xWurnIbBYgxe+nzbn2/IkbGuq1gVxxsE7l2+w2M/fBRzFOXMD7MR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357298; c=relaxed/simple;
	bh=brOAJglmHR2vUYwDHkc6YSZ1b2+Xgali//Fba7NVv5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxbF2nrsskSS/YZ9jV0Z4ZnVCxAwGI2ry9oOvnqSt6ConWcaWTL8HWCdQqmldeBsx1kEnUueeZBfFjkzERbnP/4L+KDhIliK7479L4dURVCoFblM9Tif8abdzAQVn+NFte1ZJOie9Og+eLLvxn32dB8NRYUFrMYWuUe1YFOX1vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jg6rzp8d; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357297; x=1785893297;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=brOAJglmHR2vUYwDHkc6YSZ1b2+Xgali//Fba7NVv5g=;
  b=Jg6rzp8dY1DegcA/lz9lM7qdxCeoN4NVPHnZJBLM4Wj4FbAfDdVI2Sni
   54rCajN5NsRRqiooBj/4MBFemxZk7Aped1ia8Xi7/LYYzBwiHb2qmBGjU
   a/xwhS92aIZ/+w9x+VxDYNslp7PWDZrGcLH9U0jeUckXoDRnelMizi2+k
   VCqmuNAiWsZHypTtFXSVmj+b1QHTQWiboou+7GQszjX7f3OFMJlTLcneL
   b7I6O/i5oPOl5NoYynN5JUSgIj/G+rb14DJCfbIOMM58cjnloQm81dTfF
   CuQLuneT7Q+0KTp6ogGaysCVKsSwrKwB6ymrMIU1KHdVk18zMMU6hfmgN
   w==;
X-CSE-ConnectionGUID: L/HUoLhbRyWtzI2fvmzWAQ==
X-CSE-MsgGUID: V7ZfPhs4QemjUHhS+L2OXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085364"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085364"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
X-CSE-ConnectionGUID: +iCXtbk2Qxq+AYk65qsuuQ==
X-CSE-MsgGUID: pYadlK8GSIa6MF+NeaOiGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699563"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:27:58 -0700
Subject: [PATCH 7/9] dmaengine: idxd: Fix memory leak when a wq is reset
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-7-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=1622;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=brOAJglmHR2vUYwDHkc6YSZ1b2+Xgali//Fba7NVv5g=;
 b=H3FI2D33ylGTw2yc2L0GXa2NQ6h/Oyu/pksnVPCgl33kRU12wPiHBU4mMVjxqeeQkfbvsuWV4
 B5lIkfU2C+kCCDGjY1MwC02MfHgmcvNYs8HRTyWfGiLx2u5gB+dz+1c
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

idxd_wq_disable_cleanup() which is called from the reset path for a
workqueue, sets the wq type to NONE, which for other parts of the
driver mean that the wq is empty (all its resources were released).

Only set the wq type to NONE after its resources are released.

Fixes: da32b28c95a7 ("dmaengine: idxd: cleanup workqueue config after disabling")
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/device.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 287cf3bf1f5a2efdc9037968e9a4eed506e489c3..8f6afcba840ed7128259ad6b58b2fd967b0c151c 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -174,6 +174,7 @@ void idxd_wq_free_resources(struct idxd_wq *wq)
 	free_descs(wq);
 	dma_free_coherent(dev, wq->compls_size, wq->compls, wq->compls_addr);
 	sbitmap_queue_free(&wq->sbq);
+	wq->type = IDXD_WQT_NONE;
 }
 EXPORT_SYMBOL_NS_GPL(idxd_wq_free_resources, "IDXD");
 
@@ -367,7 +368,6 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	lockdep_assert_held(&wq->wq_lock);
 	wq->state = IDXD_WQ_DISABLED;
 	memset(wq->wqcfg, 0, idxd->wqcfg_size);
-	wq->type = IDXD_WQT_NONE;
 	wq->threshold = 0;
 	wq->priority = 0;
 	wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
@@ -1540,7 +1540,6 @@ void idxd_drv_disable_wq(struct idxd_wq *wq)
 	idxd_wq_reset(wq);
 	idxd_wq_free_resources(wq);
 	percpu_ref_exit(&wq->wq_active);
-	wq->type = IDXD_WQT_NONE;
 	wq->client_count = 0;
 }
 EXPORT_SYMBOL_NS_GPL(idxd_drv_disable_wq, "IDXD");

-- 
2.50.1


