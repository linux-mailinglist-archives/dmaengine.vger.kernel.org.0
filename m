Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E84A4A662C
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 21:41:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240465AbiBAUlk (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 15:41:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:16566 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240439AbiBAUkg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 15:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643748036; x=1675284036;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iTc5mDiVIyTtXyKqZXlqooJ5zq6HWkc9znR0Wmnnqsk=;
  b=SD4Acik6jGEMqkbMryXvf2GZWWL6cqORPU2zqiSQhKvmzi4XxBP1M2Ki
   PyF5SpYdueo03CUPKwCyXUSflT3AFwUC4TjoiEr1Pvw9nN/+eXVcmHcfU
   zXMUGHeY15aYprjS4/He7MYF5L6HfHEr0SxJ6rQBVUwcU1MiKhq7ehOmT
   QjToEkZYKWaj+pne2ppChp7zhEphp2CorqT/Lye3LUDI3N96/5LBlURWY
   04qD4+DJqtnOBJBgmER8j5C6YnPxXDZfqNdADpxj5jFBxxEa5LffZww5F
   3/hMEIoYWQInFsMWHLlNpFtG16x3c1+Y2IK6Nv51PSLCHjpkuKF005NlX
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334143889"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334143889"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:39:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479820789"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 12:39:12 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RESEND 05/10] dmaengine: Providers should prefer dma_set_residue over dma_set_tx_state
Date:   Tue,  1 Feb 2022 13:38:08 -0700
Message-Id: <20220201203813.3951461-6-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201203813.3951461-1-benjamin.walker@intel.com>
References: <20220201203813.3951461-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dma_set_tx_state function will go away shortly. The two functions
are functionally equivalent.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/imx-sdma.c | 3 +--
 drivers/dma/mmp_tdma.c | 3 +--
 drivers/dma/mxs-dma.c  | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 75ec0754d4ad4..efb218221ba81 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1734,8 +1734,7 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 
 	spin_unlock_irqrestore(&sdmac->vc.lock, flags);
 
-	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
-			 residue);
+	dma_set_residue(txstate, residue);
 
 	return sdmac->status;
 }
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index a262e0eb4cc94..753b431ca206b 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -539,8 +539,7 @@ static enum dma_status mmp_tdma_tx_status(struct dma_chan *chan,
 	struct mmp_tdma_chan *tdmac = to_mmp_tdma_chan(chan);
 
 	tdmac->pos = mmp_tdma_get_pos(tdmac);
-	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
-			 tdmac->buf_len - tdmac->pos);
+	dma_set_residue(txstate, tdmac->buf_len - tdmac->pos);
 
 	return tdmac->status;
 }
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 994fc4d2aca42..ab9eca6d682dc 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -664,8 +664,7 @@ static enum dma_status mxs_dma_tx_status(struct dma_chan *chan,
 		residue -= bar;
 	}
 
-	dma_set_tx_state(txstate, chan->completed_cookie, chan->cookie,
-			residue);
+	dma_set_residue(txstate, residue);
 
 	return mxs_chan->status;
 }
-- 
2.33.1

