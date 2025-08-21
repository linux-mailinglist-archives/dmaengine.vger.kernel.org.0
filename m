Return-Path: <dmaengine+bounces-6111-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64880B309BF
	for <lists+dmaengine@lfdr.de>; Fri, 22 Aug 2025 01:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22AF4620FBA
	for <lists+dmaengine@lfdr.de>; Thu, 21 Aug 2025 23:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ECF2D9EE6;
	Thu, 21 Aug 2025 23:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YinmHyeV"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFB42EB5D9;
	Thu, 21 Aug 2025 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755817215; cv=none; b=piFMcE+AHrBNb+c7gQpTy3ebJWX7XqZx/2ooqq3JrBGZgs9BWqNlS2EqKWE76lmr9immoHGU29OKj4cSHI0iTOgF5HD9Il9u8t4KySY17ECb80CzH7ma/4/O3Q+dkzwVGdxx508QYPZJPezVCF4avaAVzKMpNPVkJbmEh9Pr+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755817215; c=relaxed/simple;
	bh=i0VF6j4XNf3wZ5mLiaW6rvuHr0vTYui7v7+GTstbbYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UBen3yEXsCi/w5xWxhc0tSQ9gwVkQ/R1sBS1S33D9eS4UaOuf1PsEG/QHF55LxY3OAd3UyCA1Z1mDUy7VbWqsTvlDbpl4UaGn5AuK3PSkU4Ca+R4w6ii7NKz8O114lBFPSG+7M4pUipeDn8IMX3a789AUGFe8sFHqk0pSvSukrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YinmHyeV; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755817214; x=1787353214;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=i0VF6j4XNf3wZ5mLiaW6rvuHr0vTYui7v7+GTstbbYs=;
  b=YinmHyeVKD5vN0UQGSjNF1aR5In4crttdrAbBD6dnRSwgGDDFoyjTurd
   KMStmgEgWIJrrXgI+KZfFU7xQA0wVIRzSslejIJixJvyrS1RZFucdEY0Y
   s21Vg/dBONNBN4YlOsGbEJKjhSjJ4+4l2MjWwDUkeh4J3wrfQpfF6b8S+
   bF7esz4nsUoXF33ildyiNTsVmcPRaOtEaTf1J0SjjEeLW+D/gvQ1d2xS8
   v/wQOIsUQ64F4EFD05pMCkFXpZim9Cm7DSSQdaHIapYfyKsEqdYknYAJi
   sGFluOd8YGQi1MbX2W3ehimKv/25G/uYQZS/9UwjwWlph6U3MGEozLfFu
   w==;
X-CSE-ConnectionGUID: 9hWbAM2PQiaS+/mPJHQi6w==
X-CSE-MsgGUID: ev04fdEoQdq5IpBRb9Mkcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="60748495"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="60748495"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
X-CSE-ConnectionGUID: SBmvqYo6QdGuDqgwOC/yBg==
X-CSE-MsgGUID: GdgmGPxCR+uOZ45X1iAodQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168444360"
Received: from vcostago-mobl3.jf.intel.com (HELO [10.98.24.157]) ([10.98.24.157])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 16:00:10 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date: Thu, 21 Aug 2025 15:59:40 -0700
Subject: [PATCH v2 06/10] dmaengine: idxd: Wait for submitted operations on
 .device_synchronize()
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-6-595d48fa065c@intel.com>
References: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
In-Reply-To: <20250821-idxd-fix-flr-on-kernel-queues-v3-v2-0-595d48fa065c@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, 
 Fenghua Yu <fenghua.yu@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
X-Mailer: b4 0.15-dev-2e5ae
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755817209; l=1195;
 i=vinicius.gomes@intel.com; s=20230921; h=from:subject:message-id;
 bh=i0VF6j4XNf3wZ5mLiaW6rvuHr0vTYui7v7+GTstbbYs=;
 b=D+RZZmlsyRbt3038TyUQpm9R6EvNB5UvGkr/IhV04njEpk9QF4RbpW7a0h1NuGp+eiI8o6SqI
 waeztjMyHcYAezU6kss+r1EWiETI5KWsXzrxmSofH+gkY0wVFY+BOb5
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
2.50.1


