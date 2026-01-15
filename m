Return-Path: <dmaengine+bounces-8296-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A989D291A8
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC1623074D74
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7A8332EAF;
	Thu, 15 Jan 2026 22:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BWzomA+N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9C3330D29;
	Thu, 15 Jan 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517273; cv=none; b=NjYGbfmSbIlc6HVB+IUU0B3O559XjxsrMOPJk+01mDiW2sQlrLpeXKxQS8qwpT4EA2isYNbXzOLyrjT855EWaGY3YAxztJsYWXuujZ2JdrK0KlL7kHiM1oCBmXOVCgVQeFKBWnl0PNu1M8B2qw9421+j6oQFyXOqeCQaWbYTiTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517273; c=relaxed/simple;
	bh=PupvgR8RmYXOn4O6I8PE4/ridnLMAk1et8YKJIT3bcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tV3/B/ky8/MWbeyl4Qkc8+wvmo3Qurt9+Rlucyho6aCrgupnEl/Vus1CBkSGBFoMHDm3DOzNU0l60a8CSJQm7DFmulGF/NvuV5wpqo/n3bk+iZrP6pUmtayAt9AUmVgWdTEZeiQGK3TvBW8LvQ2bB4E6vfdOUDDC9tMWk782JSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BWzomA+N; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517271; x=1800053271;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=PupvgR8RmYXOn4O6I8PE4/ridnLMAk1et8YKJIT3bcA=;
  b=BWzomA+NJe5KlC8dmfvRH0WSu9Y1ZRA/reip+r3DGM+2vxQYUSlXE3bR
   KgIbHmgkLqsH5h8Iq1/CUm8sEFx5RTA7f4Z0nwZgeDmUy+oi0C47g657F
   55khfCQ97+RtueLfcbqwlaHS9a1Eyt+cXX3WprGLsBoiiuda18b8RQhM3
   krE7Z1tX4YQU2AUXzfR/2qJq95sN2PzD0yHHdsx18NN7htmoYeS7BI9JI
   iyi1f+VURqYhepfg0sDlAfo7O1urKxEcncxplITkVnIhc3lW1V9KAN1GI
   2XABRLLQkd9uEpKImYVg8/nYMHYp+dpWoK2S/qokbGdmHNZpGbC9HOdST
   g==;
X-CSE-ConnectionGUID: XcduCf88QEGRTyEZ5DcJ1Q==
X-CSE-MsgGUID: fACXQs/SQpOKS0UJ4k5z6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744635"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744635"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:48 -0800
X-CSE-ConnectionGUID: KCUJV66wR0ypFhl8nacIUQ==
X-CSE-MsgGUID: XCVSDmBcQEuPuLLD25Ixjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965451"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:47 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:24 -0800
Subject: [PATCH RESEND v2 06/10] dmaengine: idxd: Wait for submitted
 operations on .device_synchronize()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-6-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=1195;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=PupvgR8RmYXOn4O6I8PE4/ridnLMAk1et8YKJIT3bcA=;
 b=z3qZfzyyXDWZ5zXiVXX1TSXEUufGcbIs/iab7C1hm1lcDFMrRIIeA7xHAf0O/KX7bjkfWF8WQ
 nTCkp197LWGCMgsGOxYP0ehEFNGpo1f4WFX2EaXhXgO+cTpKij5+jSH
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

When the dmaengine "core" asks the driver to synchronize, send a Drain
operation to the device workqueue, which will wait for the already
submitted operations to finish.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/dma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index e4f9788aa635..9937b671f637 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -203,6 +203,13 @@ static int idxd_dma_terminate_all(struct dma_chan *c)
 	return 0;
 }
 
+static void idxd_dma_synchronize(struct dma_chan *c)
+{
+	struct idxd_wq *wq = to_idxd_wq(c);
+
+	idxd_wq_drain(wq);
+}
+
 int idxd_register_dma_device(struct idxd_device *idxd)
 {
 	struct idxd_dma_dev *idxd_dma;
@@ -234,6 +241,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
 	dma->device_terminate_all = idxd_dma_terminate_all;
+	dma->device_synchronize = idxd_dma_synchronize;
 
 	rc = dma_async_device_register(dma);
 	if (rc < 0) {

-- 
2.52.0


