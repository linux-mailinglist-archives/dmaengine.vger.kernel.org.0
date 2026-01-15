Return-Path: <dmaengine+bounces-8295-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0D26D2918B
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 23:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A9A673022CA0
	for <lists+dmaengine@lfdr.de>; Thu, 15 Jan 2026 22:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7D033121D;
	Thu, 15 Jan 2026 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHz3AeVi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89BE32F74B;
	Thu, 15 Jan 2026 22:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768517271; cv=none; b=H8ko19EPj+wIdSIEe7CgkaPOoZ0ngCX1o41el4jL+Adhq/fM3vGdY3F3lXGb57yklxrn2UXLD76NCo/vZWqb5B0FuNzbyrXKwvsnWP1ntkKlCC22C3lKLMaKAzg8VKZ0LWi26ljpZi28bQJGReyUrtgU17T32aEh/30Y961tK5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768517271; c=relaxed/simple;
	bh=BV7lMSrUhko16pgH7KI3ki6fwDPKZHhE02VtGVOee/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nBstwc3xZ3voF9HHzDLEL77U3Br7OChupGL9N6dQsBARxnNveGC00JZZ3FaU6NS8aZ5geb4qRBqZzvRU7W6suvT5FU5JAfNm4+bAplPf/jW12Gnj7/RYCAtUgQIUSnUUKwkd3PhSwIVG0a0TuCEcLtWtLLRssQfkOHqGLqhfjbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHz3AeVi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768517270; x=1800053270;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BV7lMSrUhko16pgH7KI3ki6fwDPKZHhE02VtGVOee/w=;
  b=AHz3AeVi8UYtt1TTYAcGSWHXlrEh88hNEcdIqzV9tYZwvij1nB8Mnyuw
   iJ5KisQfYKI2vLP1GamAmRhk+wKpHkKIPiUGLYImxArC1l96ZjNZQDeFW
   YnAYKfGE6o6zUk1zIAySNpOTZeZSDEL8YExQfjLKqXsRMFWfDZuErd154
   oK8tnLJrzndlqcJSytLpEXR/B5gYbMH1zg7oIUiGXXXLRpvQ8sW4kcFv2
   pbN4GZSKwONUeWoqfTVutNsqAZ2nBLsuNuM87oJYmA93wQjYzC+DMJFAk
   wDj1O0L9y+czUCTKtlt+aKQDDfN5AOsHMstuYtIAs42YcskCOvLcBnEZG
   w==;
X-CSE-ConnectionGUID: ytuTPdTmRcWf5C56eDGTVQ==
X-CSE-MsgGUID: Mvqos7bhSzezjct9eey+Sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="69744633"
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="69744633"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:47 -0800
X-CSE-ConnectionGUID: U6RRwWitRYW0jw3Kq25Dww==
X-CSE-MsgGUID: BSZRh1G1R5iWwMfRFgGSCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,229,1763452800"; 
   d="scan'208";a="204965444"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 14:47:47 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 15 Jan 2026 14:47:23 -0800
Subject: [PATCH RESEND v2 05/10] dmaengine: idxd: Flush all pending
 descriptors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-5-59e106115a3e@intel.com>
References: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
In-Reply-To: <20260115-idxd-fix-flr-on-kernel-queues-v3-v2-0-59e106115a3e@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768517265; l=1354;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=BV7lMSrUhko16pgH7KI3ki6fwDPKZHhE02VtGVOee/w=;
 b=Ks5nshQkRkJesxtTr7YbD6kRKp0naQc08LX8lPjCZra+dWOa50V5P1rTbgLVqxTHOmG+u/oHd
 eFQYFHCh85KBCxMUtpWxO1yW+gHtVEimYC/FXtKDBeT/XgCQKAa7P9s
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

When used as a dmaengine, the DMA "core" might ask the driver to
terminate all pending requests, when that happens, flush all pending
descriptors.

In this context, flush means removing the requests from the pending
lists, so even if they are completed after, the user is not notified.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index dbecd699237e..e4f9788aa635 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -194,6 +194,15 @@ static void idxd_dma_release(struct dma_device *device)
 	kfree(idxd_dma);
 }
 
+static int idxd_dma_terminate_all(struct dma_chan *c)
+{
+	struct idxd_wq *wq = to_idxd_wq(c);
+
+	idxd_wq_flush_descs(wq);
+
+	return 0;
+}
+
 int idxd_register_dma_device(struct idxd_device *idxd)
 {
 	struct idxd_dma_dev *idxd_dma;
@@ -224,6 +233,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	dma->device_issue_pending = idxd_dma_issue_pending;
 	dma->device_alloc_chan_resources = idxd_dma_alloc_chan_resources;
 	dma->device_free_chan_resources = idxd_dma_free_chan_resources;
+	dma->device_terminate_all = idxd_dma_terminate_all;
 
 	rc = dma_async_device_register(dma);
 	if (rc < 0) {

-- 
2.52.0


