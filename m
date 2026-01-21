Return-Path: <dmaengine+bounces-8444-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PlFDmA1cWnKfQAAu9opvQ
	(envelope-from <dmaengine+bounces-8444-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 21:21:52 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D54355D145
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 21:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC8FD822A11
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 18:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B6E9392C44;
	Wed, 21 Jan 2026 18:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/CYQV7A"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DE03D1CAF;
	Wed, 21 Jan 2026 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020502; cv=none; b=NvPA/sVs67PqxhvaW+0yOfnGqVtKXvEylOxGI0MWf979+raSIjZjkv/N9D+ebiCaVFTHnUQV6Ww/MOL1lW2KUrlaCb8ZI1Mm2r0AQRIQou+nUP5vHdPrFwtDKa5FP7E39kVGqR+9r6tZuqbaSdXQaVa9QZy/TBy2/8nKEVwgsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020502; c=relaxed/simple;
	bh=tAQS2VaVQs4OzjvaAkumRVNNh21fccVfyEgiBZ3K+ZE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hYPMHiI8BnKsCMk8+HLkG1sT/86Wdtf5slj3+u3PM/CAq/FDRQmtvnXwZP/+FSGNBK8RoEudKk8fh9OSdRDXGriClwnaZYPgj4Va+JIgkB0Q2JfR8ftF4KxMII4WM2z7yVenPrKERhzTveDs0CMXsp6gDyxP7a0G/ZGgqjwlXa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/CYQV7A; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769020500; x=1800556500;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=tAQS2VaVQs4OzjvaAkumRVNNh21fccVfyEgiBZ3K+ZE=;
  b=k/CYQV7AkmW5CIDETRWLQCu3uKrSRZlZ75YL3N+Om65Byn54v26mrZeM
   KtDuhP1lvtpiPBIW2YTsD5YBb7OVCUF8i/xFBog321XBQ5aU5Gei9odvj
   yDlT+FQYqrCTZv2DtZLc882KvT4y+VRiK0mzRhgA8xHPS0upktX2gCtpG
   /vdfUvIinZWbKvqrIQJdYdBrPJHHNOdgmlJ//gWJ5BQzkqm+7czrfem7p
   f8lyZQZ+CA2VMhQxHJv0T/q662wWC8PGxw96UEfaT4E1054/5O9N7iJMb
   fqULjC3r+OV+qDq3rz30RB9R6MnWbX+W3V0WQCI6ihITZdNoPia3L10d/
   A==;
X-CSE-ConnectionGUID: z3JE1ZaeQ5mAhPPkzz7ZxA==
X-CSE-MsgGUID: JF2QCPngR/StS3X54TcjrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="70349902"
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="70349902"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:56 -0800
X-CSE-ConnectionGUID: YFZ1G1zGQhWOUxi1wil9JA==
X-CSE-MsgGUID: qHPMk3sxQrONk8LvpgsKpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,244,1763452800"; 
   d="scan'208";a="210678467"
Received: from vcostago-desk1.jf.intel.com (HELO [10.88.27.144]) ([10.88.27.144])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 10:34:54 -0800
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Wed, 21 Jan 2026 10:34:31 -0800
Subject: [PATCH v3 05/10] dmaengine: idxd: Flush all pending descriptors
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-5-7ed70658a9d1@intel.com>
References: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
In-Reply-To: <20260121-idxd-fix-flr-on-kernel-queues-v3-v3-0-7ed70658a9d1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=ed25519-sha256; t=1769020494; l=1402;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=tAQS2VaVQs4OzjvaAkumRVNNh21fccVfyEgiBZ3K+ZE=;
 b=ftBVqy0q4o8l0XYn2oRpwa3MVWnWT3S2oP/NtM3trpTEjvwE/SJH3E8kAf88XlrbzCXq8o/KB
 QyqfgkADUA3BME6Dixerwy7s31tmb1DpuyFKei1OaNHMZ9HTsCjR1gn
X-Developer-Key: i=vinicius.gomes@intel.com; a=ed25519;
 pk=aJkrtgqgT6TZ8iIHSG8/rTPsmlYnjMrUjCsMYvCzntk=
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8444-lists,dmaengine=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vinicius.gomes@intel.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: D54355D145
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When used as a dmaengine, the DMA "core" might ask the driver to
terminate all pending requests, when that happens, flush all pending
descriptors.

In this context, flush means removing the requests from the pending
lists, so even if they are completed after, the user is not notified.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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


