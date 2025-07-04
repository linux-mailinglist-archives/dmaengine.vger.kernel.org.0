Return-Path: <dmaengine+bounces-5735-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AFEAF8A3E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 09:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46CF1189F203
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 07:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E4328D822;
	Fri,  4 Jul 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RrFXuGGu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5197D28BA9B;
	Fri,  4 Jul 2025 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615651; cv=none; b=EoQKmOkx0/KPgoNO5Oc6rzHH4chCgGel2TH6AVTGWkkq3w6oO0lhJSxPWcVCfXL39osRMS73Alo/lBjluIhcxtrWAmNI4tofqp9P+vD/tLdyXz7PP/zzeb4vXFxrgnRIzp7jKWh7r+q81ngS/vnkh9gf7x5/QC/Gm+fb0SJCke0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615651; c=relaxed/simple;
	bh=idtG3pDBv5DgyV7D3aigFbrwhSp2laJtAcE/7Pv7P1g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e59cDsn13bkSaRsM5YEPfTixHlVKF2hgpmpOVkxH6EtYLjOSKWeYW7a3C5EU/CpwqAplUs7+Dp42/qqWyRV1//7H7KMQipcyL3bJMNIjZjMzYeWXar16y3mL0lLTRiaaUHdc4BtbnhOE68/ZVQhQQo6w8dpbYVIuRWZlj9EdZkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RrFXuGGu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615649; x=1783151649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=idtG3pDBv5DgyV7D3aigFbrwhSp2laJtAcE/7Pv7P1g=;
  b=RrFXuGGu5/vMqOWxiuOP/KQON5RQx97FsQnYVwaqknrQdmxmUjQxiYZk
   lRQQo8VhKwyHOdC0AODAJwj+nyhiOLcU4G62WCihQ+pZgP/oDnLQCokKI
   nQIkA/SvA6Kqc4ejS2qQ4Si4+RD7TLt7jSIDkCApQtiUnu3ZFxCAdBeWF
   t+FCEHLJSqcvZc6K9Ez2J8StGHw3dt96PnCcYOmnu12vtZDijUgy5LC83
   //P9Apj6fR97MVPyVelNAK5QIW2TpxMmY/rmAVyQGgi1BMmfRaHB4rdbx
   ycQ9R9+8FHYFzHUcDAFm7oMrP/Bkxjjn61DdTBGyquvjajAtaMRz8Y9eP
   g==;
X-CSE-ConnectionGUID: sjoe6soHQpKOc902eLQeAA==
X-CSE-MsgGUID: J9V0idRzTBmtYwIDPb5VGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494479"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494479"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:07 -0700
X-CSE-ConnectionGUID: 00X7z1oiRGqCCXA6+HS3rg==
X-CSE-MsgGUID: kKQmFDQvSoyWf0iOufJ0MQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924183"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:06 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id B64E244424;
	Fri,  4 Jul 2025 10:54:03 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>,
	Vinod Koul <vkoul@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/80] dmaengine: at_xdmac: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:03 +0300
Message-Id: <20250704075403.3217327-1-sakari.ailus@linux.intel.com>
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

 drivers/dma/at_xdmac.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 3fbc74710a13..ada96d490847 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -379,7 +379,6 @@ static void at_xdmac_runtime_suspend_descriptors(struct at_xdmac_chan *atchan)
 		if (!desc->active_xfer)
 			continue;
 
-		pm_runtime_mark_last_busy(atxdmac->dev);
 		pm_runtime_put_autosuspend(atxdmac->dev);
 	}
 }
@@ -413,7 +412,6 @@ static bool at_xdmac_chan_is_enabled(struct at_xdmac_chan *atchan)
 
 	ret = !!(at_xdmac_chan_read(atchan, AT_XDMAC_GS) & atchan->mask);
 
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return ret;
@@ -446,7 +444,6 @@ static void at_xdmac_off(struct at_xdmac *atxdmac, bool suspend_descriptors)
 		}
 	}
 
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 }
 
@@ -1676,7 +1673,6 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 spin_unlock:
 	spin_unlock_irqrestore(&atchan->lock, flags);
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 	return ret;
 }
@@ -1758,7 +1754,6 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 		__func__, &bad_desc->lld.mbr_sa, &bad_desc->lld.mbr_da,
 		bad_desc->lld.mbr_ubc);
 
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 
 	/* Then continue with usual descriptor management */
@@ -1822,7 +1817,6 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 	 * Decrement runtime PM ref counter incremented in
 	 * at_xdmac_start_xfer().
 	 */
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 }
 
@@ -1954,7 +1948,6 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return 0;
@@ -1998,7 +1991,6 @@ static int at_xdmac_device_resume(struct dma_chan *chan)
 
 unlock:
 	spin_unlock_irqrestore(&atchan->lock, flags);
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return ret;
@@ -2041,7 +2033,6 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 	clear_bit(AT_XDMAC_CHAN_IS_CYCLIC, &atchan->status);
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return 0;
@@ -2235,7 +2226,6 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 		}
 	}
 
-	pm_runtime_mark_last_busy(atxdmac->dev);
 	pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return 0;
@@ -2412,7 +2402,6 @@ static int at_xdmac_probe(struct platform_device *pdev)
 
 	at_xdmac_axi_config(pdev);
 
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
-- 
2.39.5


