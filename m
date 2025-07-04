Return-Path: <dmaengine+bounces-5737-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24BFAF8A5D
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 09:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5652A5A17D2
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 07:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F709293C4F;
	Fri,  4 Jul 2025 07:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dWzM/nVM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168CB28D828;
	Fri,  4 Jul 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615653; cv=none; b=C0Jf7oJxBomwCuYqwKtaWzxB1qfWpoWrxvfo7HacIzIKGWyzAlK51gRiolsF/wTcw+q4MsBzZWiShog2HdQAhyXmBrSH4Z4txg0J4DCcnPcWHmH78oRH/sWptILJlkUKMyhp3vHLCc2rZ4Ksu4u/xibAJVoQXY/jbW60RJbTz0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615653; c=relaxed/simple;
	bh=SwA04YuHfWus8Oxzal44FMeOvDW0ynNWLHU3HfszPns=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptd/sjQbdIaOivUDMiWuiFB+VZwmDegDEvBoL16cuBzPXJxSO3X+JMj74Gf5+sn+NW+dB+jADAB0NziySTO0d7J3TlasiYwyWk/ZHgbokmMc0K7mSSP7xpBg4RUpdQGCH2RwXkosUMQU7wVl+AU67c301RYeKUVsuIV4T0QsDnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dWzM/nVM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615651; x=1783151651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SwA04YuHfWus8Oxzal44FMeOvDW0ynNWLHU3HfszPns=;
  b=dWzM/nVMjhk52QC1M8NF50BrAhfsZiZAhExnJb2Ig2gJ4YnOasdamyEV
   nXO5vQMEjWQqkuMo/39Be9jM0SgVxfOvIPN0REZ9a3wwIs+xao8C8Uy9D
   zszUkumQaq/agqgW/oMwbCIOP77i3vxj/5HmPQ6ZoKtBF7CaiGJNSfDdO
   Fvm8qNj5L4Te8kimbGrnyh+06bDCDW/EylYYfcG42e+8UVv42wL9tnHRv
   LzSpLoSnnyStmuVRfHnM2Cg4x9QN9Ui2YvdcarnXgHJqqU9jSs4bwr8o0
   UsyumyLrJFxdhX8nN3Sz6RrMEnmBkUtDiSSKCZhVLRmsD5LDsHrRfpI4f
   w==;
X-CSE-ConnectionGUID: 7nyrrPVMTleRcEFJkb2TQQ==
X-CSE-MsgGUID: RlAzjCvnSW2Mf9WJNoVUpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494497"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:10 -0700
X-CSE-ConnectionGUID: bJgNRm1OQAaHdiPuqBupcQ==
X-CSE-MsgGUID: buF3RBOsQzOoL3A+8dOOYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924192"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:08 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 270E44488D;
	Fri,  4 Jul 2025 10:54:06 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/80] dmaengine: ste_dma40: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:05 +0300
Message-Id: <20250704075405.3217535-1-sakari.ailus@linux.intel.com>
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

 drivers/dma/ste_dma40.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index d52e1685aed5..13d91d369be2 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1452,7 +1452,6 @@ static int d40_pause(struct dma_chan *chan)
 
 	res = d40_channel_execute_command(d40c, D40_DMA_SUSPEND_REQ);
 
-	pm_runtime_mark_last_busy(d40c->base->dev);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	spin_unlock_irqrestore(&d40c->lock, flags);
 	return res;
@@ -1479,7 +1478,6 @@ static int d40_resume(struct dma_chan *chan)
 	if (d40_residue(d40c) || d40_tx_is_linked(d40c))
 		res = d40_channel_execute_command(d40c, D40_DMA_RUN);
 
-	pm_runtime_mark_last_busy(d40c->base->dev);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	spin_unlock_irqrestore(&d40c->lock, flags);
 	return res;
@@ -1581,7 +1579,6 @@ static void dma_tc_handle(struct d40_chan *d40c)
 		if (d40_queue_start(d40c) == NULL) {
 			d40c->busy = false;
 
-			pm_runtime_mark_last_busy(d40c->base->dev);
 			pm_runtime_put_autosuspend(d40c->base->dev);
 		}
 
@@ -2055,7 +2052,6 @@ static int d40_free_dma(struct d40_chan *d40c)
 		d40c->base->lookup_phy_chans[phy->num] = NULL;
 
 	if (d40c->busy) {
-		pm_runtime_mark_last_busy(d40c->base->dev);
 		pm_runtime_put_autosuspend(d40c->base->dev);
 	}
 
@@ -2063,7 +2059,6 @@ static int d40_free_dma(struct d40_chan *d40c)
 	d40c->phy_chan = NULL;
 	d40c->configured = false;
  mark_last_busy:
-	pm_runtime_mark_last_busy(d40c->base->dev);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	return res;
 }
@@ -2466,7 +2461,6 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 	if (is_free_phy)
 		d40_config_write(d40c);
  mark_last_busy:
-	pm_runtime_mark_last_busy(d40c->base->dev);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	spin_unlock_irqrestore(&d40c->lock, flags);
 	return err;
@@ -2618,10 +2612,8 @@ static int d40_terminate_all(struct dma_chan *chan)
 		chan_err(d40c, "Failed to stop channel\n");
 
 	d40_term_all(d40c);
-	pm_runtime_mark_last_busy(d40c->base->dev);
 	pm_runtime_put_autosuspend(d40c->base->dev);
 	if (d40c->busy) {
-		pm_runtime_mark_last_busy(d40c->base->dev);
 		pm_runtime_put_autosuspend(d40c->base->dev);
 	}
 	d40c->busy = false;
-- 
2.39.5


