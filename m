Return-Path: <dmaengine+bounces-7319-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AB809C8068F
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 13:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C1F2F346F81
	for <lists+dmaengine@lfdr.de>; Mon, 24 Nov 2025 12:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE158302CA2;
	Mon, 24 Nov 2025 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eR5geAez"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4427301461;
	Mon, 24 Nov 2025 12:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763986347; cv=none; b=js8NP1ploLKdrVvBcNxMsTuZMQGy1UsOtm02/DnSh9/ySSWCcuqGdAusIYIcd2RQ3z06UUVSQ2qp3NGCuFSbHzVisoPCLeTuNLFqlv+bZyZ2SCSUjIkQZYAPmWDPKRMVdx6i/IYldzwbDD4K82kPsC9XJ2UEN61/3fiuBgiMTAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763986347; c=relaxed/simple;
	bh=3FTR/BGUP+Jif1zotbkvzWhNiBsBN/SOnlvS3OB5AC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEwQDBfLVefyBJLahY4V8RrZropYNR4sG0XcKkXtE8UuTNb6KvWXwSYI6k0m3IlDMFK3OELnSusBI/9b4Q/+Z2T34brU4SDKwW8VZKl1hPxPPf8FPbcRcP//36j0Xqw0tZVFHZ71oMy1EWq3VoTZFqANdOgEMPwYSUAT4/FaQRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eR5geAez; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763986344; x=1795522344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3FTR/BGUP+Jif1zotbkvzWhNiBsBN/SOnlvS3OB5AC0=;
  b=eR5geAeziyW5kk+zUmueGfGCDrPnXPLxn96kWRkJ+rtHs2RtyKDHuR6P
   ZCUyLNhNNfcqNWv2YVx6DHTh21e3fu1Qnvv0A8oidSZeYt1iCoKIr4j40
   XxZEWyz1uxyPrnfVx1tV4Cq/NaQJrkRyKmx9mHIVuH9WMLpZjPWoJdPQE
   HdV+8yaEt81xm7JkqeHqaz65NPhWWA1EnwULBwtBTgaxek5FsKa1+QmkU
   +ZxBqyJa4xLX4p22zix06RZADi9MWaBq4ZtK70DMe0cL0gdA9ADP3jiEp
   RuHzv7a+n8f+ugursT1chWsjVMtKKg/EGE57AoirhtEtrYZ108chfW7NP
   w==;
X-CSE-ConnectionGUID: IdqESwU2TyeOJ0J6Ge13OQ==
X-CSE-MsgGUID: tNhWYUcDT0KrQuzOs92xrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11622"; a="69847624"
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="69847624"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2025 04:12:16 -0800
X-CSE-ConnectionGUID: wKDEV3l3QqGEpZZVjkvI1A==
X-CSE-MsgGUID: 1/09amQaRCCXpqw5buivZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,222,1758610800"; 
   d="scan'208";a="222970347"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa002.jf.intel.com with ESMTP; 24 Nov 2025 04:12:11 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 7D9A2AC; Mon, 24 Nov 2025 13:12:03 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
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
Subject: [PATCH v4 12/13] dmaengine: sh: use sg_nents_for_dma() helper
Date: Mon, 24 Nov 2025 13:09:30 +0100
Message-ID: <20251124121202.424072-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
References: <20251124121202.424072-1-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/sh/shdma-base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 834741adadaa..1e1b65e46668 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -577,12 +577,11 @@ static struct dma_async_tx_descriptor *shdma_prep_sg(struct shdma_chan *schan,
 	struct scatterlist *sg;
 	struct shdma_desc *first = NULL, *new = NULL /* compiler... */;
 	LIST_HEAD(tx_list);
-	int chunks = 0;
+	int chunks;
 	unsigned long irq_flags;
 	int i;
 
-	for_each_sg(sgl, sg, sg_len, i)
-		chunks += DIV_ROUND_UP(sg_dma_len(sg), schan->max_xfer_len);
+	chunks = sg_nents_for_dma(sgl, sg_len, schan->max_xfer_len);
 
 	/* Have to lock the whole loop to protect against concurrent release */
 	spin_lock_irqsave(&schan->chan_lock, irq_flags);
-- 
2.50.1


