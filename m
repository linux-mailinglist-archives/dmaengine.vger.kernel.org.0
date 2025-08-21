Return-Path: <dmaengine+bounces-6110-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90323B309C4
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30A31CC8529
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8459A2EBBA8;
	Thu, 21 Aug 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bNhcEYvP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCC62C0299;
	Thu, 21 Aug 2025 23:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817215; cv=none; b=H0tLL0n9iFjc14GcN4RkoZt0xE0iM/fpyVc7PsuQEc6O2FD2UVp5xBTTT9UwVr3AL1+ZsT9VI09RKGCV2z1P3+gaydfVpCBRfZk4Llq1j1esF0RfFtRmxZjYru2rtfmfGtDxGPt3zpYDU6AYJtCkIT67bUURKiMehQJw/Jw+Eu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817215; c=relaxed/simple;
	bh=UiRVDRNElmnuQn1IkTxW0cyZ8FQfjc/JQob2A2ENmEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c4FaWVAGJqHeB+O1DBZXs0RlrvCLh7kwv18ZShdXHn0RRwGm4C6MmEu/smsEapCy4r6pfEaq4/92JJ1WgwNqUNocDo3Iy121MljeUCAn85L3arVHqhBgCwV6Vz9CCHL+uwFxiSucTjzNEvHw1P8zTeu66LP96dusQGtvsj18Fq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bNhcEYvP; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817214; x=1787353214;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UiRVDRNElmnuQn1IkTxW0cyZ8FQfjc/JQob2A2ENmEA=;
  b=bNhcEYvPMdrn+cg1uIiW0+mvJcYhba8RL7zdtNnD7wVsv609Q8l5YkGi
   zv/aarJQPhSBMx/TA9zZnl0YQxXSpTL8FNWoeHt14QheGmPi23XtX6axd
   Dw4P+rZgRTr2Sslfk0d2Ms3Yt5lOLcOBKW9xnbDvEc+crBV+r+UMYGtu0
   tKBSz1YP50Ccp8himzrEYk3HvFcfUP9i7UFCdh6NLmeRDv4G1I5I0yl6L
   jcrHPekzsOI9yGN2AvuuT7kqitn2HdsnhpPXfC/gAi5cRLr1PhtuojhC5
   IyrF0eDMqkMeaH8757d52CUSsrI17tlLyZRYD3CA7t8buRIYJKUmpTbsI
   w==;
X-CSE-ConnectionGUID: 7JlRy67+QduGup+rwqXF5w==
X-CSE-MsgGUID: Ly0dsp6tTPGLYaQ+vHGJ+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748492"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748492"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
X-CSE-ConnectionGUID: W8GVwglcQHq1unJAm91HKw==
X-CSE-MsgGUID: fz+B0CjmSxaLfrEvS6FP5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444357"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:39 -0700
Subject: [PATCH v2 05/10] dmaengine: idxd: Flush all pending descriptors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-5-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=1354;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=UiRVDRNElmnuQn1IkTxW0cyZ8FQfjc/JQob2A2ENmEA=;
 b=kr9R2HdXi7gDAmARzLB0AJNwLAJeh/+SGIFQEkWYTcAHeYClWCiODuwBRBz3B7/sio44POSH+
 M38AJAmXjI9BtdC0pYYSdDSsFcS68IzgBQqPE87ilCrsG2WiGZPL091
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
2.50.1


