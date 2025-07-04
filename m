Return-Path: <dmaengine+bounces-5739-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E90B0AF8A4E
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 09:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F381CA15D5
	for <lists+dmaengine@lfdr.de>; Fri,  4 Jul 2025 07:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03529299AAF;
	Fri,  4 Jul 2025 07:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AKKJw4gu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC8C28B41D;
	Fri,  4 Jul 2025 07:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615653; cv=none; b=JlorShNQSgzVZg11iNelUamRDrPwkPeTObZhaYgSeVA3rvVVg/32SF+jlpjKyzoDe12MOnVEMxAiSENU91iPo/AwuyVQnHMPRmuiZjd0vxFQ27XsBPjijALOxVc8nny4lbG2MImcqr2qwunyyiRtb3jSCQQ9ytxKnkq2SUFMrog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615653; c=relaxed/simple;
	bh=TKaWU9wHcesffH7yU2Bgh0fMlpDg7JRl+pUzHVYytWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kuSrhZPWzl6vv+s2o1oeT9VdME7prSexUQ5GvAoJvE3FzSKSjvjHPcZQjvVdVw9B5t8O6OcrHT2G69hHXwrKNtpQupWz+LAPnLPz3V8DKJz0KcyHHBko5jlEcyU3IodLVZpwAG5d9tnj+tSMaAYYQ1x2Ol8aVK+3nprTcPO97qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AKKJw4gu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615652; x=1783151652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKaWU9wHcesffH7yU2Bgh0fMlpDg7JRl+pUzHVYytWk=;
  b=AKKJw4guLMhD0Gyqs/dl4t+6TieXPSynU9HLCf8tYqHSdw4FL9km5vM9
   kzWeOd879FFMXkLvxTcXyKdfToCaDY+vyRMam5+LQNyjq9vMP64AL/mVE
   9af37ccDlPvs6hAx3qPi3vTTEHmEkJ1MpLnE+4GsPka6g2MQr5Udorlrd
   sXCLUigVIRHORRYj3s+cXtDDA6NcRtyzNCZG0JaxWwXlE6LmitGkbHA7r
   PVTaMgeRGBIEkpV7hhxEbcnUIf6S0kTUaeCNGfLDrwXRubEqkMD/hc6nS
   ZedEszF6ulBgx2BwB5sArapD2D+VmqpEl//UP6RwYwpqKyIEupR9LTHoK
   g==;
X-CSE-ConnectionGUID: 1eoNV4g8TCWP+7gFzrB45w==
X-CSE-MsgGUID: 2HSTM3uITY6wpLhpHRb6KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="76494505"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="76494505"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:11 -0700
X-CSE-ConnectionGUID: sTvQMPl5RuODWcA7j2/V8w==
X-CSE-MsgGUID: yf8ICMQNQIyWACxGNAWhRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158924202"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:07 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id 5D66B44433;
	Fri,  4 Jul 2025 10:54:05 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Vinod Koul <vkoul@kernel.org>,
	Sinan Kaya <okaya@kernel.org>,
	Md Sadre Alam <quic_mdalam@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Amit Vadhavana <av2082000@gmail.com>,
	Casey Connolly <casey.connolly@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 11/80] dmaengine: qcom: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:05 +0300
Message-Id: <20250704075405.3217439-1-sakari.ailus@linux.intel.com>
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

 drivers/dma/qcom/bam_dma.c    | 5 -----
 drivers/dma/qcom/hidma.c      | 9 ---------
 drivers/dma/qcom/hidma_dbg.c  | 1 -
 drivers/dma/qcom/hidma_mgmt.c | 2 --
 4 files changed, 17 deletions(-)

diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
index bbc3276992bb..e6f642e8c731 100644
--- a/drivers/dma/qcom/bam_dma.c
+++ b/drivers/dma/qcom/bam_dma.c
@@ -608,7 +608,6 @@ static void bam_free_chan(struct dma_chan *chan)
 	}
 
 err:
-	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
 }
 
@@ -784,7 +783,6 @@ static int bam_pause(struct dma_chan *chan)
 	writel_relaxed(1, bam_addr(bdev, bchan->id, BAM_P_HALT));
 	bchan->paused = 1;
 	spin_unlock_irqrestore(&bchan->vc.lock, flag);
-	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
 
 	return 0;
@@ -810,7 +808,6 @@ static int bam_resume(struct dma_chan *chan)
 	writel_relaxed(0, bam_addr(bdev, bchan->id, BAM_P_HALT));
 	bchan->paused = 0;
 	spin_unlock_irqrestore(&bchan->vc.lock, flag);
-	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
 
 	return 0;
@@ -927,7 +924,6 @@ static irqreturn_t bam_dma_irq(int irq, void *data)
 		writel_relaxed(clr_mask, bam_addr(bdev, 0, BAM_IRQ_CLR));
 	}
 
-	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
 
 	return IRQ_HANDLED;
@@ -1102,7 +1098,6 @@ static void bam_start_dma(struct bam_chan *bchan)
 	writel_relaxed(bchan->tail * sizeof(struct bam_desc_hw),
 			bam_addr(bdev, bchan->id, BAM_P_EVNT_REG));
 
-	pm_runtime_mark_last_busy(bdev->dev);
 	pm_runtime_put_autosuspend(bdev->dev);
 }
 
diff --git a/drivers/dma/qcom/hidma.c b/drivers/dma/qcom/hidma.c
index c2b3e4452e71..ded27a674e5f 100644
--- a/drivers/dma/qcom/hidma.c
+++ b/drivers/dma/qcom/hidma.c
@@ -185,7 +185,6 @@ static void hidma_callback(void *data)
 	hidma_process_completed(mchan);
 
 	if (queued) {
-		pm_runtime_mark_last_busy(dmadev->ddev.dev);
 		pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	}
 }
@@ -316,11 +315,9 @@ static dma_cookie_t hidma_tx_submit(struct dma_async_tx_descriptor *txd)
 
 	pm_runtime_get_sync(dmadev->ddev.dev);
 	if (!hidma_ll_isenabled(dmadev->lldev)) {
-		pm_runtime_mark_last_busy(dmadev->ddev.dev);
 		pm_runtime_put_autosuspend(dmadev->ddev.dev);
 		return -ENODEV;
 	}
-	pm_runtime_mark_last_busy(dmadev->ddev.dev);
 	pm_runtime_put_autosuspend(dmadev->ddev.dev);
 
 	mdesc = container_of(txd, struct hidma_desc, desc);
@@ -507,7 +504,6 @@ static int hidma_terminate_channel(struct dma_chan *chan)
 
 	rc = hidma_ll_enable(dmadev->lldev);
 out:
-	pm_runtime_mark_last_busy(dmadev->ddev.dev);
 	pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return rc;
 }
@@ -525,7 +521,6 @@ static int hidma_terminate_all(struct dma_chan *chan)
 	/* reinitialize the hardware */
 	pm_runtime_get_sync(dmadev->ddev.dev);
 	rc = hidma_ll_setup(dmadev->lldev);
-	pm_runtime_mark_last_busy(dmadev->ddev.dev);
 	pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return rc;
 }
@@ -569,7 +564,6 @@ static int hidma_pause(struct dma_chan *chan)
 		if (hidma_ll_disable(dmadev->lldev))
 			dev_warn(dmadev->ddev.dev, "channel did not stop\n");
 		mchan->paused = true;
-		pm_runtime_mark_last_busy(dmadev->ddev.dev);
 		pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	}
 	return 0;
@@ -591,7 +585,6 @@ static int hidma_resume(struct dma_chan *chan)
 		else
 			dev_err(dmadev->ddev.dev,
 				"failed to resume the channel");
-		pm_runtime_mark_last_busy(dmadev->ddev.dev);
 		pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	}
 	return rc;
@@ -882,7 +875,6 @@ static int hidma_probe(struct platform_device *pdev)
 	hidma_debug_init(dmadev);
 	hidma_sysfs_init(dmadev);
 	dev_info(&pdev->dev, "HI-DMA engine driver registration complete\n");
-	pm_runtime_mark_last_busy(dmadev->ddev.dev);
 	pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return 0;
 
@@ -909,7 +901,6 @@ static void hidma_shutdown(struct platform_device *pdev)
 	pm_runtime_get_sync(dmadev->ddev.dev);
 	if (hidma_ll_disable(dmadev->lldev))
 		dev_warn(dmadev->ddev.dev, "channel did not stop\n");
-	pm_runtime_mark_last_busy(dmadev->ddev.dev);
 	pm_runtime_put_autosuspend(dmadev->ddev.dev);
 
 }
diff --git a/drivers/dma/qcom/hidma_dbg.c b/drivers/dma/qcom/hidma_dbg.c
index ce87c7937a0e..7d7594da084c 100644
--- a/drivers/dma/qcom/hidma_dbg.c
+++ b/drivers/dma/qcom/hidma_dbg.c
@@ -103,7 +103,6 @@ static int hidma_chan_show(struct seq_file *s, void *unused)
 		hidma_ll_chstats(s, mchan->dmadev->lldev, mdesc->tre_ch);
 
 	hidma_ll_devstats(s, mchan->dmadev->lldev);
-	pm_runtime_mark_last_busy(dmadev->ddev.dev);
 	pm_runtime_put_autosuspend(dmadev->ddev.dev);
 	return 0;
 }
diff --git a/drivers/dma/qcom/hidma_mgmt.c b/drivers/dma/qcom/hidma_mgmt.c
index 4805ce390ffa..8442082bde23 100644
--- a/drivers/dma/qcom/hidma_mgmt.c
+++ b/drivers/dma/qcom/hidma_mgmt.c
@@ -150,7 +150,6 @@ int hidma_mgmt_setup(struct hidma_mgmt_dev *mgmtdev)
 	val |= mgmtdev->chreset_timeout_cycles & HIDMA_CHRESET_TIMEOUT_MASK;
 	writel(val, mgmtdev->virtaddr + HIDMA_CHRESET_TIMEOUT_OFFSET);
 
-	pm_runtime_mark_last_busy(&mgmtdev->pdev->dev);
 	pm_runtime_put_autosuspend(&mgmtdev->pdev->dev);
 	return 0;
 }
@@ -305,7 +304,6 @@ static int hidma_mgmt_probe(struct platform_device *pdev)
 		 &res->start, mgmtdev->dma_channels);
 
 	platform_set_drvdata(pdev, mgmtdev);
-	pm_runtime_mark_last_busy(&pdev->dev);
 	pm_runtime_put_autosuspend(&pdev->dev);
 	return 0;
 out:
-- 
2.39.5


