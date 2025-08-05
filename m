Return-Path: <dmaengine+bounces-5946-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17326B1AC07
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 03:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE93718A100D
	for <lists+dmaengine@lfdr.de>; Tue,  5 Aug 2025 01:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A2191D8DFB;
	Tue,  5 Aug 2025 01:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l6sGuweE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79551B043C;
	Tue,  5 Aug 2025 01:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754357297; cv=none; b=HdQoHse9vd/TkpZ9ld4RVezZErKE+OHmYU/ygPOQ37ZspKvtPVh2nVGOcVidDdEl8+JGpwJHqF8iGjQ0VY4cQ+DO2wLNQs5CnWtSK2k42hCCDfBVMi6ionezv+wjVwFCcNRleJkf4/2E3ksmTGDD2I8VYZU+KT2X0oxTmVVdAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754357297; c=relaxed/simple;
	bh=JMS2LYeIWmEtqp+NnkcPw0v2TmLdu2lQE4ttQDJh8EA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIjdK6ZbSaB1vRGDWYUx3rE90oaqJv56F3Y9I6mqJynyQb5w1nvRhueUk5Q9//kyzpAckY2/GRVu8bcZaMqmAYl4mSWL65eNfEzeOzfyOlKoXf1glX55+OtLWpHRtIUf45EHkIQZpdhzYDGw130SNpSm2AnCj3Se+5sVVRPvxmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l6sGuweE; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754357295; x=1785893295;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=JMS2LYeIWmEtqp+NnkcPw0v2TmLdu2lQE4ttQDJh8EA=;
  b=l6sGuweE1Ti3+kIVhfVZEKPO9+1cp0tzrDlJrN+h+7QU9mssz3tA/0DU
   h+KbwtGYruW76DESVyGWx8bNrTVsUCn45i5KdCvKeS9dC9X1gvdRP+acl
   Sj6AK+Oa3LKpP9Zt3P7xhxcGCTbGQ6E225RI0fBR5E/h0ibuK7QcbsRWg
   QvQEFGsU3nyDvpLorlpocOy1Vfx51IXuHateqketI6vt+OjQTAmytM7tE
   UU+MY8F0J/RGXA4XshxcLHZSXXSzTLZmBPHnhjUlP8z9PSOIanwda3e2x
   C1xGY4GptVP3pw2CV7NUqjLIIT6igwyCyPqlOnysJgSP/xGtCbWrJF5Nh
   w==;
X-CSE-ConnectionGUID: U1av+XVoROCqbJGOdA+XCw==
X-CSE-MsgGUID: m8qyL/41Sv6QGitgAdRlYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11512"; a="68085359"
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="68085359"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
X-CSE-ConnectionGUID: TWmqdfBgRWKkZZ12fTEzlQ==
X-CSE-MsgGUID: a/wrVA3WRfmvMZ0ZvsOkfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,265,1747724400"; 
   d="scan'208";a="169699554"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.32.147]) ([10.98.32.147])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2025 18:28:11 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Mon, 04 Aug 2025 18:27:56 -0700
Subject: [PATCH 5/9] dmaengine: idxd: Allow DMA clients to empty the
 pending queue
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-5-4e020fbf52c1@intel.com>
References: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
In-Reply-To: <20250804-idxd-fix-flr-on-kernel-queues-v3-v1-0-4e020fbf52c1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754357291; l=1213;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=JMS2LYeIWmEtqp+NnkcPw0v2TmLdu2lQE4ttQDJh8EA=;
 b=6ZE7bcWpAuRpU+WG0zkCLCzOVH4nmAQUOwkvctGJihtale7M2ep3SLvUeVdRhxHeiPGqwWz8e
 tSzaGiQl0FiDxxjKR1NPbj9bqFeUhSqpv7NJaOdcdDgdvA8zDtfyeu3
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=

Send a request to drain all pending commands from the hardware queue
when the DMA clients request.

Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
 drivers/dma/idxd/dma.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index dbecd699237e3ac5a73b49ed2097a897abc9a043..10356a00cbdfc2ddfeea629aa749c40e7eec0a56 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -194,6 +194,15 @@ static void idxd_dma_release(struct dma_device *device)
 	kfree(idxd_dma);
 }
 
+static int idxd_dma_terminate_all(struct dma_chan *c)
+{
+	struct idxd_wq *wq = to_idxd_wq(c);
+
+	idxd_wq_drain(wq);
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


