Return-Path: <dmaengine+bounces-5736-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EA0AF8A53
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 09:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D4A5A0BA7
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 07:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751BE28D8CE;
	Fri,  4 Jul 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8iXIV1e"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DEA28B511;
	Fri,  4 Jul 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615651; cv=none; b=fHw3tA4mqluW2C8NwBgP5rZkzJPQXeiFZta/FUjNnjG7usNFHau4IL0Rc7JGzWIpcr5Px3kG4L4W34Dv7T33e3ObdlorXOFbT5pi2JlyT//kO2Yy47CbqmIr/t1jsPX++vkGgVbqiyvXRcBk0sEfEz3jpqQz9QKYzo4rH3tJqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615651; c=relaxed/simple;
	bh=7fNlyfehAX6Hv6KxB0TQNkNnrIRoj0DQRCnHapvWfsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d26/erSmkSQ+cDuzJD3VUbQkQu0HoKd9SMBavVc1G7fEe34qaK30hyzCO2J1Pdd3KCVoCPcUYvQrgrREnpMAouGVUkJzriUAwqqkZsC4s367CPNUzWuj1BGyuTqeBe1ekLRSstPv2Xbo3Bvz7ZmRwCD155uIOPKR1vqNxmVGd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8iXIV1e; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615649; x=1783151649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7fNlyfehAX6Hv6KxB0TQNkNnrIRoj0DQRCnHapvWfsw=;
  b=P8iXIV1eiV+bns4QrQPwNGlhiKQPNW2N7Sx5mUHONl56nbOcgQOvtj0d
   5Erw8uhL07WQeXzBh7I+alBQtxwTjM10k7tDgY3OivaS0imXKipIrYgAw
   f0wu+pmd+758zSB9YYpLfkOiVyqHZXFZeAm+BS1e2K3sShUy78223ctLN
   QAFx9iCoMoyCU6YrlFokAAqzFjc+mE8rsb/CdZ62M21UC2geOD+INWQzi
   pJPz2ms/1BUPDiD1QQnQ7VjxufEG8f9Qg/opEBGtcuUGz9YDm7YwZ/z5f
   bKGxgAhcjEzW/9tOkwO2hZi0QuuyIc6Khkp2ARbxWIK3RUFR9IiyVRCD8
   Q==;
X-CSE-ConnectionGUID: GqfELuzBRIiH3WFqRYXZgA==
X-CSE-MsgGUID: xY1nNIIkTbORRo6Gd1Vk9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494484"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494484"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:08 -0700
X-CSE-ConnectionGUID: LdIu/9HuTTC2yJaNcMZl2A==
X-CSE-MsgGUID: pv0MS9vXT3+PYMyqXvg98Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924186"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:06 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 8B02344843;
	Fri,  4 Jul 2025 10:54:04 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/80] dmaengine: pl330: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:04 +0300
Message-Id: <20250704075404.3217372-1-sakari.ailus@linux.intel.com>
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

 drivers/dma/pl330.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 82a9fe88ad54..472cb6fe126d 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2134,7 +2134,6 @@ static void pl330_tasklet(struct tasklet_struct *t)
 
 	/* If work list empty, power down */
 	if (power_down) {
-		pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
 		pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
 	}
 }
@@ -2313,7 +2312,6 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	list_splice_tail_init(&pch->work_list, &pl330->desc_pool);
 	list_splice_tail_init(&pch->completed_list, &pl330->desc_pool);
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	if (power_down)
 		pm_runtime_put_autosuspend(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
@@ -2347,7 +2345,6 @@ static int pl330_pause(struct dma_chan *chan)
 			desc->status = PAUSED;
 	}
 	spin_unlock_irqrestore(&pch->lock, flags);
-	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
@@ -2371,7 +2368,6 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 		list_splice_tail_init(&pch->work_list, &pch->dmac->desc_pool);
 
 	spin_unlock_irqrestore(&pl330->lock, flags);
-	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
 	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
 	pl330_unprep_slave_fifo(pch);
 }
@@ -3176,7 +3172,6 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pm_runtime_irq_safe(&adev->dev);
 	pm_runtime_use_autosuspend(&adev->dev);
 	pm_runtime_set_autosuspend_delay(&adev->dev, PL330_AUTOSUSPEND_DELAY);
-	pm_runtime_mark_last_busy(&adev->dev);
 	pm_runtime_put_autosuspend(&adev->dev);
 
 	return 0;
-- 
2.39.5


