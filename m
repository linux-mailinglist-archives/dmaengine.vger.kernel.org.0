Return-Path: <dmaengine+bounces-7164-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B53C586C5
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 16:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B46A4FBE6C
	for <lists+dmaengine@lfdr.de>; Thu, 13 Nov 2025 15:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A34357728;
	Thu, 13 Nov 2025 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nOdH7VTE"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCBB3559F4;
	Thu, 13 Nov 2025 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763046982; cv=none; b=sZD1JZcsaE8mtvn/on8VZWhg6tlKyMPElgBwmTF/6Z86ueNOxL4R15otAv5wMOouXwBrtPdGWN0QfQTy9VuPLu/2isgNArp3GYPa1950sfjKmnE8FdCkdH1ssZTRVVqUQYR4nN3ZR052gOX+4rfW4LtEMrc7QfqlVb005dZ+Gbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763046982; c=relaxed/simple;
	bh=nUvI1SoM4FGg3QQHNwgNidRdOH1tF5MQSJvXCQ4IzUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C8zPe87nTqHaCuWTLeDDifetsDlGCb8Juu7Ju/L1Tj/gqj3Lfs9SQ9VQrQZTafcFOlTU3oYetP/gJ6HBWX0aKwrwNv1XVSjYJ3LY7sFvzjOgIqaPNkYaGmW6auOcIBcQtakQnLVgvDXw/bP/5YcsLK6pRyF3UynJ1wK7BzF7By8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nOdH7VTE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763046980; x=1794582980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nUvI1SoM4FGg3QQHNwgNidRdOH1tF5MQSJvXCQ4IzUg=;
  b=nOdH7VTErT5PDkcv62qonBteiwRnNpW1nIq34x8C4ip1GITAzABkzAHM
   R+dTOOa+z8cuIkMpuWkAPSjoEqi7aa8q0BY8f2jZEOF5Y3j1qJ8vizUH8
   szZGlkahCbCbauCj9Kz3FICgjzPP4SpTpQ+8HdtJQkWK+H0QeoumaGmC7
   tADAfaPeprtHXmJc+SxoOZLkeN5C/82f510GXB1/Rr4TmzezWZdU71L7O
   18wndiOzKNV854tNbrHgIGIGo563PyKri5YMvlf9+QJiqb0CjYYuPml2W
   AG5P8zqwjzRdWc4wu2ehGqSWKx2VgC417upLUrAh9khEVRh21u7/CBwip
   w==;
X-CSE-ConnectionGUID: NC36JqM9T0S9BPY8s0naXQ==
X-CSE-MsgGUID: XhW6m3ASTL6Eljz63akmRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="75809649"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="75809649"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 07:16:11 -0800
X-CSE-ConnectionGUID: +LVNA3BcQcullz1ZF1JcFw==
X-CSE-MsgGUID: zoy9/u+GRxq9Z4N09/HWJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194684642"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 13 Nov 2025 07:16:05 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id BD96599; Thu, 13 Nov 2025 16:16:04 +0100 (CET)
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
Subject: [PATCH v3 03/13] dmaengine: axi-dmac: use sg_nents_for_dma() helper
Date: Thu, 13 Nov 2025 16:12:59 +0100
Message-ID: <20251113151603.3031717-4-andriy.shevchenko@linux.intel.com>
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
 drivers/dma/dma-axi-dmac.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5b06b0dc67ee..5d4436e7d2ee 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -674,10 +674,7 @@ static struct dma_async_tx_descriptor *axi_dmac_prep_slave_sg(
 	if (direction != chan->direction)
 		return NULL;
 
-	num_sgs = 0;
-	for_each_sg(sgl, sg, sg_len, i)
-		num_sgs += DIV_ROUND_UP(sg_dma_len(sg), chan->max_length);
-
+	num_sgs = sg_nents_for_dma(sgl, sg_len, chan->max_length);
 	desc = axi_dmac_alloc_desc(chan, num_sgs);
 	if (!desc)
 		return NULL;
-- 
2.50.1


