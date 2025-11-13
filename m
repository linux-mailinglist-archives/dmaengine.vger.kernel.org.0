Return-Path: <dmaengine+bounces-7161-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7DCEC58764
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4ACA04F60AE
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E4F3563F9;
	Thu, 13 Nov 2025 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SSM63Ifq"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7A13559CA;
	Thu, 13 Nov 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046981; cv=none; b=f3RU49xjuIDTcWKog9NAJHjJi89tcuAS2ZeMfvnGuRUYdE4NVLMl+JRq6Z3N17/BAPID+dNTvPsNU5wRr82EkyZMuVcEPY5KGG+PROldIByJ0wd7VSgFvAU3pRpfsQJ02tbQaotuyNJY1nIW2n53F6nLRuzUmEntL6+o5CY36xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046981; c=relaxed/simple;
	bh=JkZzb5FMsjRx+/pIEY8nwVKtWJam+umuXTVqJZGjOp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WUuuflqhl1VWuM8q+nphnwa5ZY5pah9yYL2rPhGuV0d2a2zwjLcCsk+BpPPMFvXC7UKK4S6RLAnrCNCoh4FVzCIMsTOkqBs90WFebA9rLqO4QwbJQ04m9SJ72Fig7Ksy9CA1lClP0h8abxvfN2S+HlNpGs8avmHuh6SmKLLewaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SSM63Ifq; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046979; x=1794582979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JkZzb5FMsjRx+/pIEY8nwVKtWJam+umuXTVqJZGjOp8=;
  b=SSM63IfqdpeIV+0InvCVvi09GjkaY9MHV/qpxb/d0BXW11cDgE1VjoeS
   Gw2Af/QQ8oqB83kr+20LiZQgfsG7QaVE220nRutAJBZaZq6iiTaJhuRw5
   PqGBpbfVAoLIjrKB69mPp2M2w4r8zMc8d7GSg0EQYREeT4cxRIsV16e7T
   UgZ4FsQjlti0R3HUC5V+UpYnvJC8+ZZeQIo1UAyCvh3xmiRU40aOB9oD5
   ISwrlkNkKYUGYjmIP62nb4dUd186hTm/ZXo29tItfogwFtcFfUHqII4gj
   Y+DK+kLfvqAFh0KcSca8i9sA89WPw+DnL3FFlbkx3uo2ifw2ZkPPwV9k2
   Q==;
X-CSE-ConnectionGUID: 5L0JEUo4TVybx0lzWjl5UQ==
X-CSE-MsgGUID: UzG5qtk8SJCbA+hL0YHz2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75740562"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75740562"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:16:17 -0800
X-CSE-ConnectionGUID: NB1OMkpYSeiUxBj2Cn79iQ==
X-CSE-MsgGUID: Ml1DjtRNS+aC1JPL6nSnOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189792124"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa008.fm.intel.com with ESMTP; 13 Nov 2025 07:16:12 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id D96909F; Thu, 13 Nov 2025 16:16:04 +0100 (CET)
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
Subject: [PATCH v3 09/13] dmaengine: qcom: adm: use sg_nents_for_dma() helper
Date: Thu, 13 Nov 2025 16:13:05 +0100
Message-ID: <20251113151603.3031717-10-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/qcom/qcom_adm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/qcom/qcom_adm.c b/drivers/dma/qcom/qcom_adm.c
index 6be54fddcee1..490edad20ae6 100644
--- a/drivers/dma/qcom/qcom_adm.c
+++ b/drivers/dma/qcom/qcom_adm.c
@@ -390,16 +390,15 @@ static struct dma_async_tx_descriptor *adm_prep_slave_sg(struct dma_chan *chan,
 	}
 
 	/* iterate through sgs and compute allocation size of structures */
-	for_each_sg(sgl, sg, sg_len, i) {
-		if (achan->slave.device_fc) {
+	if (achan->slave.device_fc) {
+		for_each_sg(sgl, sg, sg_len, i) {
 			box_count += DIV_ROUND_UP(sg_dma_len(sg) / burst,
 						  ADM_MAX_ROWS);
 			if (sg_dma_len(sg) % burst)
 				single_count++;
-		} else {
-			single_count += DIV_ROUND_UP(sg_dma_len(sg),
-						     ADM_MAX_XFER);
 		}
+	} else {
+		single_count = sg_nents_for_dma(sgl, sg_len, ADM_MAX_XFER);
 	}
 
 	async_desc = kzalloc(sizeof(*async_desc), GFP_NOWAIT);
-- 
2.50.1


