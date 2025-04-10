Return-Path: <dmaengine+bounces-4866-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3125CA83A0C
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 08:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0101F1B80875
	for <lists+dmaengine@lfdr.de>; Thu, 10 Apr 2025 06:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD1120409F;
	Thu, 10 Apr 2025 06:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrNr6vdd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E020468C
	for <dmaengine@vger.kernel.org>; Thu, 10 Apr 2025 06:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744268301; cv=none; b=Vb3Xc8seFp0zxHZlyXNBhWp+Cghr8TsQI5mCzYe6g/xeLZm/JFKt3y8TqKcu6OeHA7sEUt9qUs9cm5xZf+La9XytBSo+8kEqzWC3FnNtYwtAqxbC1OHhrvP96d9vbUJkVigy2ZSLhVm6H3tvmKugxd23B8Lr14ULPI7ZxySYyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744268301; c=relaxed/simple;
	bh=yRup8yibl6uLLdPCoiEJjhkU8noSkNl6uy6KgrPhJRk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gDdAPQKQGu2UvHJkqmJnLzpkDXnelZerueQVkHeNd1eRGRTnaySjCoBeFlYIsGuZQJ6bkV0WP2qfcqbKCbAhuCLSy+9SCmSQyUXItJNmMt7D99FCJoRpwRkEzjZs9uwMAYxPqXJB4KgZXaO8tHOruSjtFGu2xoQ8Rous+QAPwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrNr6vdd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744268299; x=1775804299;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=yRup8yibl6uLLdPCoiEJjhkU8noSkNl6uy6KgrPhJRk=;
  b=PrNr6vdd2RcMzmogJZEdEubNeSaOCiKWMUYKCgX/Ge6wvzMoFmSbML2Q
   PlGyLVE5e3zNpQr/ERuCCCj7AIvEm7+fCx6gfcUhtPDo9A3QSFxI0yvFA
   eHM3Mj1PZK8XzVRfdniA0QS6jXQO8eQ47tm27g9aLX2981MUvPgi73GNB
   APXk9jr2/Qz/PlI0SEzIsz4oSvZeitl3fs1Sc/DeAXRjsLw1FOke4YJUW
   dVUcFXHpOyVc0LKLsG3hdOvzMU4Za+KBeCQOv5/bAyzacTljYN8Rja1vL
   1bMoqKwm2PtKl2e6yJBtlBgsA5hH7+FMY5ywL3A3rwC8K9V2v5Q429ksk
   A==;
X-CSE-ConnectionGUID: j+U7qXY8TA+dqissscRbaA==
X-CSE-MsgGUID: /4SiT9vMSmy6wGYe0V+Vxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="63162732"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="63162732"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 23:58:18 -0700
X-CSE-ConnectionGUID: JJFylNiyScO3cB55fAI/0w==
X-CSE-MsgGUID: GShB2DsDRPa5EBIKUCnejQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="133928762"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 23:58:17 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id DBC9711FA2C;
	Thu, 10 Apr 2025 09:58:14 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1u2lra-00FQRu-2k;
	Thu, 10 Apr 2025 09:58:14 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org
Subject: [PATCH 1/1] dmaengine: at_xdmac: Use pm_runtime_put_noidle() with many usage_counts
Date: Thu, 10 Apr 2025 09:58:04 +0300
Message-Id: <20250410065804.3676582-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're holding more than one Runtime PM usage_counts in
at_xdmac_device_terminate_all(). This makes pm_runtime_mark_last_busy()
redundant and pm_runtime_put_autosuspend() misleading. Drop
pm_runtime_mark_last_busy() and use pm_runtime_put_noidle() to decrement
the usage_count, except in the case it may be the last.

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/dma/at_xdmac.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index ba25c23164e7..3fbc74710a13 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2033,10 +2033,8 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 		 * at_xdmac_start_xfer() for this descriptor. Now it's time
 		 * to release it.
 		 */
-		if (desc->active_xfer) {
-			pm_runtime_put_autosuspend(atxdmac->dev);
-			pm_runtime_mark_last_busy(atxdmac->dev);
-		}
+		if (desc->active_xfer)
+			pm_runtime_put_noidle(atxdmac->dev);
 	}
 
 	clear_bit(AT_XDMAC_CHAN_IS_PAUSED, &atchan->status);
-- 
2.39.5


