Return-Path: <dmaengine+bounces-3262-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C160798FFF5
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 11:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7A4F1C23277
	for <lists+dmaengine@lfdr.de>; Fri,  4 Oct 2024 09:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E4F14A0AA;
	Fri,  4 Oct 2024 09:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="liAQ1SZL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE56B148FF6
	for <dmaengine@vger.kernel.org>; Fri,  4 Oct 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034882; cv=none; b=oRG4dlCk2i9H2iWkhFnlXqmjYcU/x1wimV0nEQ1m7QzjT6AV2k+1ClGuLQBEd1J4+uijpbcm6S+oAvTIFMtX8G1DQzLcuetskc3SxHStNcpNpmALJFKThH36IUOPN74lPBU72/tI/R0v8+1Tzv8/1KD5qW05aOTe7KIff65zxJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034882; c=relaxed/simple;
	bh=EuN6uJP1tVqYOdyr5XuD9Gn7QZNaHphK7ZP8Q5ECJqI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k6eTl06eIz+F4hDZnBxZyg8nLtoHLZkMnUdAWLoClJGaubzUt3C8iRTTz184pO8jB/2uXsj/fF/KwdTsMWTOTcphCClBvePQdlYeik/YIGjO2J4EKnK55rABlh1xP3xR1WRiArPLoqO00+MxIUzOK27yMBBT1pyCuSVglRg6q2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=liAQ1SZL; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034881; x=1759570881;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EuN6uJP1tVqYOdyr5XuD9Gn7QZNaHphK7ZP8Q5ECJqI=;
  b=liAQ1SZL2lCngs024lS9n2I8PzHGorJX7H57ZMy3L8plpPsqIPqX1dEW
   LzWUm1kIgH6fNZgnv8zlERpgRDns//BNT4usLjS99IkuGwTD71wTHXyTA
   I3raWXbWTjzSBtQPlz+0pdiKLDjR9n8IJ6qro7KKaBD9nrYrwFx8BXwpm
   fV1ke+RPaQFDysXD35zf7vxihisfKG/anpVd9E5svq5IglWWHd1p8tpO8
   tOrebHeJEEGKhxZWUEab3D1JSzm+jrt7ndO5NiBN1XCSKQ3vD00nDH+zw
   1XuDKeErlECXdxpw7+dloAaXzJDm3v4/4geK3EVcvoZwn8uv5YmOJ1sTO
   Q==;
X-CSE-ConnectionGUID: t+QPCDgjTdKKbQvzzr7haw==
X-CSE-MsgGUID: f4wOvQS5SPuCTCPleJWv0A==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="37856189"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="37856189"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:18 -0700
X-CSE-ConnectionGUID: c+iCsMIzQaiwv8izSK//5A==
X-CSE-MsgGUID: 4ZV7NjMCTu2H7HgX3ng6XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74331923"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:17 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id 1E9B3120D8D;
	Fri,  4 Oct 2024 12:41:12 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoC-000TWO-0M;
	Fri, 04 Oct 2024 12:41:12 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org
Subject: [PATCH 07/51] dmaengine: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:12 +0300
Message-Id: <20241004094112.113470-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/dma/at_xdmac.c          | 24 ++++++++++++------------
 drivers/dma/pl330.c             | 14 +++++++-------
 drivers/dma/qcom/bam_dma.c      | 10 +++++-----
 drivers/dma/qcom/hidma.c        | 18 +++++++++---------
 drivers/dma/qcom/hidma_dbg.c    |  2 +-
 drivers/dma/qcom/hidma_mgmt.c   |  4 ++--
 drivers/dma/ste_dma40.c         | 16 ++++++++--------
 drivers/dma/ti/cppi41.c         | 10 +++++-----
 drivers/dma/xilinx/zynqmp_dma.c |  2 +-
 9 files changed, 50 insertions(+), 50 deletions(-)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index 299396121e6d..88637bcfb760 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -380,7 +380,7 @@ static void at_xdmac_runtime_suspend_descriptors(struct at_xdmac_chan *atchan)
 			continue;
 
 		pm_runtime_mark_last_busy(atxdmac->dev);
-		pm_runtime_put_autosuspend(atxdmac->dev);
+		__pm_runtime_put_autosuspend(atxdmac->dev);
 	}
 }
 
@@ -414,7 +414,7 @@ static bool at_xdmac_chan_is_enabled(struct at_xdmac_chan *atchan)
 	ret = !!(at_xdmac_chan_read(atchan, AT_XDMAC_GS) & atchan->mask);
 
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return ret;
 }
@@ -447,7 +447,7 @@ static void at_xdmac_off(struct at_xdmac *atxdmac, bool suspend_descriptors)
 	}
 
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 }
 
 /* Call with lock hold. */
@@ -1675,7 +1675,7 @@ at_xdmac_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 spin_unlock:
 	spin_unlock_irqrestore(&atchan->lock, flags);
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 	return ret;
 }
 
@@ -1757,7 +1757,7 @@ static void at_xdmac_handle_error(struct at_xdmac_chan *atchan)
 		bad_desc->lld.mbr_ubc);
 
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 
 	/* Then continue with usual descriptor management */
 }
@@ -1821,7 +1821,7 @@ static void at_xdmac_tasklet(struct tasklet_struct *t)
 	 * at_xdmac_start_xfer().
 	 */
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 }
 
 static irqreturn_t at_xdmac_interrupt(int irq, void *dev_id)
@@ -1953,7 +1953,7 @@ static int at_xdmac_device_pause(struct dma_chan *chan)
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return 0;
 }
@@ -1997,7 +1997,7 @@ static int at_xdmac_device_resume(struct dma_chan *chan)
 unlock:
 	spin_unlock_irqrestore(&atchan->lock, flags);
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return ret;
 }
@@ -2032,7 +2032,7 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 		 * to release it.
 		 */
 		if (desc->active_xfer) {
-			pm_runtime_put_autosuspend(atxdmac->dev);
+			__pm_runtime_put_autosuspend(atxdmac->dev);
 			pm_runtime_mark_last_busy(atxdmac->dev);
 		}
 	}
@@ -2042,7 +2042,7 @@ static int at_xdmac_device_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&atchan->lock, flags);
 
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return 0;
 }
@@ -2236,7 +2236,7 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 	}
 
 	pm_runtime_mark_last_busy(atxdmac->dev);
-	pm_runtime_put_autosuspend(atxdmac->dev);
+	__pm_runtime_put_autosuspend(atxdmac->dev);
 
 	return 0;
 }
@@ -2413,7 +2413,7 @@ static int at_xdmac_probe(struct platform_device *pdev)
 	at_xdmac_axi_config(pdev);
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 82a9fe88ad54..614cc0bcacd1 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2135,7 +2135,7 @@ static void pl330_tasklet(struct tasklet_struct *t)
 	/* If work list empty, power down */
 	if (power_down) {
 		pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-		pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
+		__pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
 	}
 }
 
@@ -2315,8 +2315,8 @@ static int pl330_terminate_all(struct dma_chan *chan)
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
 	if (power_down)
-		pm_runtime_put_autosuspend(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
+		__pm_runtime_put_autosuspend(pl330->ddma.dev);
+	__pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
 }
@@ -2348,7 +2348,7 @@ static int pl330_pause(struct dma_chan *chan)
 	}
 	spin_unlock_irqrestore(&pch->lock, flags);
 	pm_runtime_mark_last_busy(pl330->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
+	__pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	return 0;
 }
@@ -2372,7 +2372,7 @@ static void pl330_free_chan_resources(struct dma_chan *chan)
 
 	spin_unlock_irqrestore(&pl330->lock, flags);
 	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-	pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
+	__pm_runtime_put_autosuspend(pch->dmac->ddma.dev);
 	pl330_unprep_slave_fifo(pch);
 }
 
@@ -2394,7 +2394,7 @@ static int pl330_get_current_xferred_count(struct dma_pl330_chan *pch,
 		addr = desc->px.dst_addr;
 	}
 	pm_runtime_mark_last_busy(pch->dmac->ddma.dev);
-	pm_runtime_put_autosuspend(pl330->ddma.dev);
+	__pm_runtime_put_autosuspend(pl330->ddma.dev);
 
 	/* If DMAMOV hasn't finished yet, SAR/DAR can be zero */
 	if (!val)
@@ -3177,7 +3177,7 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pm_runtime_use_autosuspend(&adev->dev);
 	pm_runtime_set_autosuspend_delay(&adev->dev, PL330_AUTOSUSPEND_DELAY);
 	pm_runtime_mark_last_busy(&adev->dev);
-	pm_runtime_put_autosuspend(&adev->dev);
+	__pm_runtime_put_autosuspend(&adev->dev);
 
 	return 0;
 probe_err3:
diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index d43a881e43b9..39e174ffc47e 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -609,7 +609,7 @@ static void bam_free_chan(struct dma_chan *chan)
 
 err:
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	__pm_runtime_put_autosuspend(bdev->dev);
 }
 
 /**
@@ -785,7 +785,7 @@ static int bam_pause(struct dma_chan *chan)
 	bchan->paused = 1;
 	spin_unlock_irqrestore(&bchan->vc.lock, flag);
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	__pm_runtime_put_autosuspend(bdev->dev);
 
 	return 0;
 }
@@ -811,7 +811,7 @@ static int bam_resume(struct dma_chan *chan)
 	bchan->paused = 0;
 	spin_unlock_irqrestore(&bchan->vc.lock, flag);
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	__pm_runtime_put_autosuspend(bdev->dev);
 
 	return 0;
 }
@@ -928,7 +928,7 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 	}
 
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	__pm_runtime_put_autosuspend(bdev->dev);
 
 	return IRQ_HANDLED;
 }
@@ -1103,7 +1103,7 @@ static void bam_start_dma(struct bam_chan *bchan)
 			bam_addr(bdev, bchan->id, BAM_P_EVNT_REG));
 
 	pm_runtime_mark_last_busy(bdev->dev);
-	pm_runtime_put_autosuspend(bdev->dev);
+	__pm_runtime_put_autosuspend(bdev->dev);
 }
 
 /**
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index 4d2cd8d9ec74..2f0da730003e 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -186,7 +186,7 @@ static void hidma_callback(void *data)
 
 	if (queued) {
 		pm_runtime_mark_last_busy(dmadev->ddev.dev);
-		pm_runtime_put_autosuspend(dmadev->ddev.dev);
+		__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	}
 }
 
@@ -317,11 +317,11 @@ static dma_cookie_t hidma_tx_submit(struct dma_async_tx_descriptor *txd)
 	pm_runtime_get_sync(dmadev->ddev.dev);
 	if (!hidma_ll_isenabled(dmadev->lldev)) {
 		pm_runtime_mark_last_busy(dmadev->ddev.dev);
-		pm_runtime_put_autosuspend(dmadev->ddev.dev);
+		__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 		return -ENODEV;
 	}
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
-	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 
 	mdesc = container_of(txd, struct hidma_desc, desc);
 	spin_lock_irqsave(&mchan->lock, irqflags);
@@ -508,7 +508,7 @@ static int hidma_terminate_channel(struct dma_chan *chan)
 	rc = hidma_ll_enable(dmadev->lldev);
 out:
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
-	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return rc;
 }
 
@@ -526,7 +526,7 @@ static int hidma_terminate_all(struct dma_chan *chan)
 	pm_runtime_get_sync(dmadev->ddev.dev);
 	rc = hidma_ll_setup(dmadev->lldev);
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
-	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return rc;
 }
 
@@ -570,7 +570,7 @@ static int hidma_pause(struct dma_chan *chan)
 			dev_warn(dmadev->ddev.dev, "channel did not stop\n");
 		mchan->paused = true;
 		pm_runtime_mark_last_busy(dmadev->ddev.dev);
-		pm_runtime_put_autosuspend(dmadev->ddev.dev);
+		__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	}
 	return 0;
 }
@@ -592,7 +592,7 @@ static int hidma_resume(struct dma_chan *chan)
 			dev_err(dmadev->ddev.dev,
 				"failed to resume the channel");
 		pm_runtime_mark_last_busy(dmadev->ddev.dev);
-		pm_runtime_put_autosuspend(dmadev->ddev.dev);
+		__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	}
 	return rc;
 }
@@ -883,7 +883,7 @@ static int hidma_probe(struct platform_device *pdev)
 	hidma_sysfs_init(dmadev);
 	dev_info(&pdev->dev, "HI-DMA engine driver registration complete\n");
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
-	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return 0;
 
 uninit:
@@ -910,7 +910,7 @@ static void hidma_shutdown(struct platform_device *pdev)
 	if (hidma_ll_disable(dmadev->lldev))
 		dev_warn(dmadev->ddev.dev, "channel did not stop\n");
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
-	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 
 }
 
diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
index ce87c7937a0e..90e758193feb 100644
--- a/drivers/dma/qcom/hidma_dbg.c
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -104,7 +104,7 @@ static int hidma_chan_show(struct seq_file *s, void *unused)
 
 	hidma_ll_devstats(s, mchan->dmadev->lldev);
 	pm_runtime_mark_last_busy(dmadev->ddev.dev);
-	pm_runtime_put_autosuspend(dmadev->ddev.dev);
+	__pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return 0;
 }
 
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 4805ce390ffa..f99a9f45c18f 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -151,7 +151,7 @@ int hidma_mgmt_setup(struct hidma_mgmt_dev *mgmtdev)
 	writel(val, mgmtdev->virtaddr + HIDMA_CHRESET_TIMEOUT_OFFSET);
 
 	pm_runtime_mark_last_busy(&mgmtdev->pdev->dev);
-	pm_runtime_put_autosuspend(&mgmtdev->pdev->dev);
+	__pm_runtime_put_autosuspend(&mgmtdev->pdev->dev);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(hidma_mgmt_setup);
@@ -306,7 +306,7 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, mgmtdev);
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 	return 0;
 out:
 	pm_runtime_put_sync_suspend(&pdev->dev);
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index d52e1685aed5..58793d81448b 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1453,7 +1453,7 @@ static int d40_pause(struct dma_chan *chan)
 	res = d40_channel_execute_command(d40c, D40_DMA_SUSPEND_REQ);
 
 	pm_runtime_mark_last_busy(d40c->base->dev);
-	pm_runtime_put_autosuspend(d40c->base->dev);
+	__pm_runtime_put_autosuspend(d40c->base->dev);
 	spin_unlock_irqrestore(&d40c->lock, flags);
 	return res;
 }
@@ -1480,7 +1480,7 @@ static int d40_resume(struct dma_chan *chan)
 		res = d40_channel_execute_command(d40c, D40_DMA_RUN);
 
 	pm_runtime_mark_last_busy(d40c->base->dev);
-	pm_runtime_put_autosuspend(d40c->base->dev);
+	__pm_runtime_put_autosuspend(d40c->base->dev);
 	spin_unlock_irqrestore(&d40c->lock, flags);
 	return res;
 }
@@ -1582,7 +1582,7 @@ static void dma_tc_handle(struct d40_chan *d40c)
 			d40c->busy = false;
 
 			pm_runtime_mark_last_busy(d40c->base->dev);
-			pm_runtime_put_autosuspend(d40c->base->dev);
+			__pm_runtime_put_autosuspend(d40c->base->dev);
 		}
 
 		d40_desc_remove(d40d);
@@ -2056,7 +2056,7 @@ static int d40_free_dma(struct d40_chan *d40c)
 
 	if (d40c->busy) {
 		pm_runtime_mark_last_busy(d40c->base->dev);
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		__pm_runtime_put_autosuspend(d40c->base->dev);
 	}
 
 	d40c->busy = false;
@@ -2064,7 +2064,7 @@ static int d40_free_dma(struct d40_chan *d40c)
 	d40c->configured = false;
  mark_last_busy:
 	pm_runtime_mark_last_busy(d40c->base->dev);
-	pm_runtime_put_autosuspend(d40c->base->dev);
+	__pm_runtime_put_autosuspend(d40c->base->dev);
 	return res;
 }
 
@@ -2467,7 +2467,7 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 		d40_config_write(d40c);
  mark_last_busy:
 	pm_runtime_mark_last_busy(d40c->base->dev);
-	pm_runtime_put_autosuspend(d40c->base->dev);
+	__pm_runtime_put_autosuspend(d40c->base->dev);
 	spin_unlock_irqrestore(&d40c->lock, flags);
 	return err;
 }
@@ -2619,10 +2619,10 @@ static int d40_terminate_all(struct dma_chan *chan)
 
 	d40_term_all(d40c);
 	pm_runtime_mark_last_busy(d40c->base->dev);
-	pm_runtime_put_autosuspend(d40c->base->dev);
+	__pm_runtime_put_autosuspend(d40c->base->dev);
 	if (d40c->busy) {
 		pm_runtime_mark_last_busy(d40c->base->dev);
-		pm_runtime_put_autosuspend(d40c->base->dev);
+		__pm_runtime_put_autosuspend(d40c->base->dev);
 	}
 	d40c->busy = false;
 
diff --git a/drivers/dma/ti/cppi41.c b/drivers/dma/ti/cppi41.c
index a8bb70c2d109..ebdc7fd9df84 100644
--- a/drivers/dma/ti/cppi41.c
+++ b/drivers/dma/ti/cppi41.c
@@ -391,7 +391,7 @@ static int cppi41_dma_alloc_chan_resources(struct dma_chan *chan)
 		cppi_writel(c->q_num, c->gcr_reg + RXHPCRA0);
 
 	pm_runtime_mark_last_busy(cdd->ddev.dev);
-	pm_runtime_put_autosuspend(cdd->ddev.dev);
+	__pm_runtime_put_autosuspend(cdd->ddev.dev);
 
 	return 0;
 }
@@ -412,7 +412,7 @@ static void cppi41_dma_free_chan_resources(struct dma_chan *chan)
 	WARN_ON(!list_empty(&cdd->pending));
 
 	pm_runtime_mark_last_busy(cdd->ddev.dev);
-	pm_runtime_put_autosuspend(cdd->ddev.dev);
+	__pm_runtime_put_autosuspend(cdd->ddev.dev);
 }
 
 static enum dma_status cppi41_dma_tx_status(struct dma_chan *chan,
@@ -510,7 +510,7 @@ static void cppi41_dma_issue_pending(struct dma_chan *chan)
 	spin_unlock_irqrestore(&cdd->lock, flags);
 
 	pm_runtime_mark_last_busy(cdd->ddev.dev);
-	pm_runtime_put_autosuspend(cdd->ddev.dev);
+	__pm_runtime_put_autosuspend(cdd->ddev.dev);
 }
 
 static u32 get_host_pd0(u32 length)
@@ -628,7 +628,7 @@ static struct dma_async_tx_descriptor *cppi41_dma_prep_slave_sg(
 
 err_out_not_ready:
 	pm_runtime_mark_last_busy(cdd->ddev.dev);
-	pm_runtime_put_autosuspend(cdd->ddev.dev);
+	__pm_runtime_put_autosuspend(cdd->ddev.dev);
 
 	return txd;
 }
@@ -1140,7 +1140,7 @@ static int cppi41_dma_probe(struct platform_device *pdev)
 		goto err_of;
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 err_of:
diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 9ae46f1198fe..4664858f5a1c 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -696,7 +696,7 @@ static void zynqmp_dma_free_chan_resources(struct dma_chan *dchan)
 		chan->desc_pool_v, chan->desc_pool_p);
 	kfree(chan->sw_desc_pool);
 	pm_runtime_mark_last_busy(chan->dev);
-	pm_runtime_put_autosuspend(chan->dev);
+	__pm_runtime_put_autosuspend(chan->dev);
 }
 
 /**
-- 
2.39.5


