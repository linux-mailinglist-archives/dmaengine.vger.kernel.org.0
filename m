Return-Path: <dmaengine+bounces-7101-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9164CC4492D
	for <lists+dmaengine@lfdr.de>; Sun, 09 Nov 2025 23:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D79F94E5BBA
	for <lists+dmaengine@lfdr.de>; Sun,  9 Nov 2025 22:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE5A1FC8;
	Sun,  9 Nov 2025 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dM5zJBaJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3C8271448;
	Sun,  9 Nov 2025 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762727392; cv=none; b=cGuIhA1Aa0GVadUC66mXBIFGvRVg8nBvTyOv9H8ATllO846gAIAgGepLQbHbDIuSyy36ooNQUwtKPHovh3oP6wd031Nc6/RnN4TCkoocRJ3VwUPgSnpi5GWMxbjU8GPWocNyaDKPKiFUC92sRbDu/v7kRRwUQa/9/5EoRLJB/7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762727392; c=relaxed/simple;
	bh=OOcyA6MzS3mnCh1v7ScRGXoB2axaRCgpdnfhK7p1Dwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5rE2oHaUgQ9BfEyjlnobjH1CxT9NE9BNlVZlup5cSiJSva29oGH3/ScCdbVk5RoG46P8uV1CEmyU1pPbZsA9dUdP0pehGq0HdcGsePN2RP3G5L16h/xVTP6okhwOV60pkfgzgte9nHF72BemhdLkXHUp32A7TM6Uy0wldGTVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dM5zJBaJ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762727391; x=1794263391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OOcyA6MzS3mnCh1v7ScRGXoB2axaRCgpdnfhK7p1Dwc=;
  b=dM5zJBaJN4w7I0zr9HB1dp6RQ3Pv5dnO3dG6x+WFyQM2GDBkdTgp+Vzz
   HVXnYElvdrQ8OgB4eUwjd3Oqy/+8Oj2ILfdRz35d2jLXQdmUY/4Pa/z8+
   uTJEL4VKR6LINP6wuM807EBSoiPrjNTLX1pDBCfNM/d4fTBZnk/ns3g5H
   KTfbg1dd3i95O0R6Mr+i7YhanBUlIxFvq5QXOvkniINXpiRBnsYYU+1Cs
   hXYgNNXS44RK74oMSAtKR3cfHyEo70x1wbtHLio7UuMUhep9ngh/b1btF
   OcMFRDBfef4h6zRghIxIh53+imswNFpVY4d+rVI/8CyWFP70fYSHDl5El
   Q==;
X-CSE-ConnectionGUID: 4nBbVAKoQ2a92NQTCGfXjQ==
X-CSE-MsgGUID: 8KzggeDKTr2JpgR+h/8bxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="63990502"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="63990502"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 14:29:47 -0800
X-CSE-ConnectionGUID: xqK7MV7pSrKroEAlVrUpKQ==
X-CSE-MsgGUID: NITo4l0bTtiDR+9tAC9CFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="188269543"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 09 Nov 2025 14:29:46 -0800
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 4B97F98; Sun, 09 Nov 2025 23:29:45 +0100 (CET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 3/4] dmaengine: Use device_match_of_node() helper
Date: Sun,  9 Nov 2025 23:28:36 +0100
Message-ID: <20251109222944.3222436-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251109222944.3222436-1-andriy.shevchenko@linux.intel.com>
References: <20251109222944.3222436-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of open coding, use device_match_of_node() helper.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 620c5bcff3bf..9e2ce7054e8a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -765,7 +765,7 @@ struct dma_chan *__dma_request_channel(const dma_cap_mask_t *mask,
 	mutex_lock(&dma_list_mutex);
 	list_for_each_entry_safe(device, _d, &dma_device_list, global_node) {
 		/* Finds a DMA controller with matching device node */
-		if (np && device->dev->of_node && np != device->dev->of_node)
+		if (np && !device_match_of_node(device->dev, np))
 			continue;
 
 		chan = find_candidate(device, mask, fn, fn_param);
-- 
2.50.1


