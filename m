Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944DE5553B5
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 20:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359847AbiFVSy0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 14:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376585AbiFVSyE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 14:54:04 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602BF3A735;
        Wed, 22 Jun 2022 11:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655924040; x=1687460040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=x05dcZfiGIHrcQ8Qy7jUQiCF+0Y+ROMG13iEPHFLY5o=;
  b=QOom+w97cTPPdVl75s4c646wZxc+EYyyoRI+AHEwZo3d5Qn8aaSnsUir
   t0dW6NlKq8z2YyRzOIuWHuOex8bayC5matOnuKABh7gMvKzNPbPvECsBP
   YiyFdeDJwR4LtrRVMCa4raJ6yJqEqBjWW3Fj23gC8WpKfwpC5z6Y3eLPU
   dvMU8cBCSIhrkEK3V9LFBYzpXdcsDhCn6OlpkXHbw3/jMCYlBvCN4ehq7
   dWje0lTBvFN7bDef9NEe2hkgiQLzfyjCvoy6P6+H70UDhCsSxOAhfjXis
   ITn8eqYhIZmLkvWQ2DmKzp8lwEg8SFbaHXJ26TGQqIvc45RQJD3V4NnRY
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260334474"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260334474"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 11:54:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="615287620"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2022 11:53:59 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/15] dmaengine: Providers should prefer dma_set_residue over dma_set_tx_state
Date:   Wed, 22 Jun 2022 11:53:55 -0700
Message-Id: <20220622185355.3043614-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 8535018ee7a2e..f2de1836dbd34 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1816,8 +1816,7 @@ static enum dma_status sdma_tx_status(struct dma_chan *chan,
 
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
2.35.1

