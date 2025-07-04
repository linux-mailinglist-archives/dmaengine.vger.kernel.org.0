Return-Path: <dmaengine+bounces-5740-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64E7AF8A5E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 09:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 810BE6E4642
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 07:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDEE29B77A;
	Fri,  4 Jul 2025 07:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NG9StyAI"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D4299ABF;
	Fri,  4 Jul 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615655; cv=none; b=heDr3mcAybZIXsVSk2v+EQ9D0f4TEemKez4gUnJGhcP/9k7SPn4v4UN9iHuzjByTZemYVz8NEh8UEetuEDktG2jXggC4D/zNza7/BWuHQtgtl8UOvz0LA0GBj18gMuARSzCwvHhKFF0nJfaSPNyo8z5JUyIQ7NQ27Y6p2HfZOs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615655; c=relaxed/simple;
	bh=yOZfd0doZbXNg800IlwSq25+2rcm+my/SjHfpGQtN7o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BJzFkO+q/ry4snv5dGDxuFfeg5TzUQ2UcKz45Mw6naNrR7XjZVrL5bNyPTiV3ueYP4E6ZnT5dc49VpSvpujTFQmNXLRAYEHLNA2G26W+J86/AlWLOI6uTh1Sfk6GeTl+y0OY+3IN1zoGmAswOr/h/XbOMQaOd+7ccOUl5sJcmjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NG9StyAI; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615654; x=1783151654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yOZfd0doZbXNg800IlwSq25+2rcm+my/SjHfpGQtN7o=;
  b=NG9StyAILx59gox1SdfFPAFZFG+ahk4LKN0iebV01PkanOJMMk0gwSK4
   PUa/Mvmu6R7s5KU+Cnml0UpGAOMvYSDWEcwG7JDJSCFUsEB9BLDxJmYjd
   kd0plzW2N9n39XeDbsn+Nj++MaWO16UG/C4x6gfwJrBJp4TX3pit0xKJd
   EIe8lqttqVmjvQo7Fe5ScK9AI2XVBHXwTN6F0W7oRvAYqZP/UtafEB78s
   scRWK3dXxjWhmSAvz0htju5dSQnPxezwMXH6jZSo/rv4iu084Z5paATnX
   4oKzN3mIhHGbm6wQu0Gxw3yW0ZjcbnMshXYqefy7stf8QgyjT82HwIfvF
   w==;
X-CSE-ConnectionGUID: ng8U1VzqRXy4PcBm3z5M9Q==
X-CSE-MsgGUID: VnaoP7PGTImDf+HngUaTEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494535"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494535"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:12 -0700
X-CSE-ConnectionGUID: 7LRH1JZBRZa36akWsFoezQ==
X-CSE-MsgGUID: Zfiru8UkStqJOwODVPppxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924195"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:09 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id B5F5044394;
	Fri,  4 Jul 2025 10:54:07 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Yan Zhen <yanzhen@vivo.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	Abin Joseph <abin.joseph@amd.com>
Cc: dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/80] dmaengine: zynqmp_dma: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:07 +0300
Message-Id: <20250704075407.3217630-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 drivers/dma/xilinx/zynqmp_dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index d05fc5fcc77d..1e2b9f37fd40 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -695,7 +695,6 @@ static void zynqmp_dma_free_chan_resources(struct dma_chan *dchan)
 		(2 * ZYNQMP_DMA_DESC_SIZE(chan) * ZYNQMP_DMA_NUM_DESCS),
 		chan->desc_pool_v, chan->desc_pool_p);
 	kfree(chan->sw_desc_pool);
-	pm_runtime_mark_last_busy(chan->dev);
 	pm_runtime_put_autosuspend(chan->dev);
 }
 
@@ -1145,7 +1144,6 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 		goto free_chan_resources;
 	}
 
-	pm_runtime_mark_last_busy(zdev->dev);
 	pm_runtime_put_sync_autosuspend(zdev->dev);
 
 	return 0;
-- 
2.39.5


