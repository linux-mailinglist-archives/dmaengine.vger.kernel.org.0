Return-Path: <dmaengine+bounces-7155-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C239C5866E
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB2C94FA944
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0603354ACB;
	Thu, 13 Nov 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5gNGNzt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED70B2EB876;
	Thu, 13 Nov 2025 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046974; cv=none; b=FgZvlg2nrNWWZ9ODsqjrPk6wVaj1n9/0uoBdtyPtRxlKi+ezBDTpz2zY4zT1OJRNacyXr8Ys1r+jhW4syEWMrRdkUaPt3J8m5AgS8TkL+6ugguJ0W6L3Mcjz0Z5QJXgkZ7vCJK0KpQ3U344YChvW63f9cNk2T2ZzX0VrXe5lLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046974; c=relaxed/simple;
	bh=trxP5p0DPdBeRi5vhwLDZx5PvWwqNzPStkGF5be32MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R6k9mcNbxOFlSy0ZZEm4XvNE+zdBSUSjsRX2+kWCIvnfLwEKeD5IyjYkMatA1PbZG2Pxv70BRcfz5O1ZPSmiU2LPSRjLGr1AFCabwzKJZetPPz//Bsq6d7YeBQlB9KCIESzeINdtmJuTKgqq98A61fEigAyf5lsx5bcV8GYKykw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5gNGNzt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046973; x=1794582973;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=trxP5p0DPdBeRi5vhwLDZx5PvWwqNzPStkGF5be32MQ=;
  b=j5gNGNzt0epPivKGs4hkmtXiGphzaBi6ciVmCiEke9HzW2hP+vsjK9D3
   KvOFkJdsCSE2eKxdifWX09yCHx15KABegmUNxj7d9Hfc0Ge7uTtdzrCYX
   UHEoCQgBkujeOdpOoq+kKOH70IeI2R3ZTeWkHbAI+ECx5zmP3FH5nk7rN
   uC78hpbcQIpSp4buLygqdjVv0eOgi19Gv1EJtHCTxgwu9oGHPYopDgw92
   FPcbXnOZZRY01JR+XpIR0X+0of6zKrl7ZXrPdrH2Em2fiPnwiWJmVeU/d
   rHO4XGPgyNR8Iv18q8zi3hp032EmFBYr/4vpqmrjdmUjNhW/lAT7StLzl
   A==;
X-CSE-ConnectionGUID: GllNvyjPRsGGFAuENOIgGw==
X-CSE-MsgGUID: Qht5bAWhQjyK/qw5KKTZhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75740482"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75740482"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:16:11 -0800
X-CSE-ConnectionGUID: w0cr6k1/QO+srTa8OYa/HA==
X-CSE-MsgGUID: /sAcqCjpSReCodHWqF8EqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189792116"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2025 07:16:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id B755298; Thu, 13 Nov 2025 16:16:04 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Vinod Koul <vkoul@kernel.org>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Brian Xu <brian.xu@amd.com>,
	Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 02/13] dmaengine: altera-msgdma: use sg_nents_for_dma() helper
Date: Thu, 13 Nov 2025 16:12:58 +0100
Message-ID: <20251113151603.3031717-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
References: <20251113151603.3031717-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open coded variant let's use recently introduced helper.

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/altera-msgdma.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
index a203fdd84950..48d2a0e638bb 100644
--- a/drivers/dma/altera-msgdma.c
+++ b/drivers/dma/altera-msgdma.c
@@ -396,13 +396,12 @@ msgdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 	void *desc = NULL;
 	size_t len, avail;
 	dma_addr_t dma_dst, dma_src;
-	u32 desc_cnt = 0, i;
 	struct scatterlist *sg;
+	u32 desc_cnt;
 	u32 stride;
 	unsigned long irqflags;
 
-	for_each_sg(sgl, sg, sg_len, i)
-		desc_cnt += DIV_ROUND_UP(sg_dma_len(sg), MSGDMA_MAX_TRANS_LEN);
+	desc_cnt = sg_nents_for_dma(sgl, sg_len, MSGDMA_MAX_TRANS_LEN);
 
 	spin_lock_irqsave(&mdev->lock, irqflags);
 	if (desc_cnt > mdev->desc_free_cnt) {
-- 
2.50.1


