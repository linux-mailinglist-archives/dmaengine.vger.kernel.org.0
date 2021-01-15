Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5C42F87F6
	for <lists+dmaengine@lfdr.de>; Fri, 15 Jan 2021 22:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbhAOVxz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 15 Jan 2021 16:53:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:4422 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725918AbhAOVxz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 15 Jan 2021 16:53:55 -0500
IronPort-SDR: 2H+zH7thtJkpNSIOe68B9sK7I6MlFJDcZN039CPlus2P0HeA3gYvDhu5Wks92SotGbVKY304ks
 dBSxI5akSFNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="157791421"
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="157791421"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:53:08 -0800
IronPort-SDR: bvRLnOgoGY2YSAq9g3Ne6KkDXKrajGl5tiTFxx2PLBVkVOdC4CrhH8v1JUnn3FY32x/fOL7B7E
 /nmg5VFNNzlw==
X-IronPort-AV: E=Sophos;i="5.79,350,1602572400"; 
   d="scan'208";a="382812999"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 13:53:08 -0800
Subject: [PATCH] dmaengine: idxd: set DMA channel to be private
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     Srinijia Kambham <srinija.kambham@intel.com>,
        Srinijia Kambham <srinija.kambham@intel.com>,
        dmaengine@vger.kernel.org
Date:   Fri, 15 Jan 2021 14:53:07 -0700
Message-ID: <161074758743.2184057.3388557138816350980.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add DMA_PRIVATE attribute flag to idxd DMA channels. The dedicated WQs are
expected to be used by a single client and not shared. While doing NTB
testing this mistake was discovered, which prevented ntb_transport from
requesting DSA wqs as DMA channels via dma_request_channel().

Reported-by: Srinijia Kambham <srinija.kambham@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Srinijia Kambham <srinija.kambham@intel.com>
Fixes: 8f47d1a5e545 ("dmaengine: idxd: connect idxd to dmaengine subsystem")
---
 drivers/dma/idxd/dma.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index 8ed2773d8285..90d19d06783a 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -165,6 +165,7 @@ int idxd_register_dma_device(struct idxd_device *idxd)
 	INIT_LIST_HEAD(&dma->channels);
 	dma->dev = &idxd->pdev->dev;
 
+	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
 	dma_cap_set(DMA_COMPLETION_NO_ORDER, dma->cap_mask);
 	dma->device_release = idxd_dma_release;
 


