Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06F951E24E
	for <lists+dmaengine@lfdr.de>; Sat,  7 May 2022 01:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378002AbiEFW1j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 May 2022 18:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377711AbiEFW1i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 6 May 2022 18:27:38 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E8146B3D
        for <dmaengine@vger.kernel.org>; Fri,  6 May 2022 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651875833; x=1683411833;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lmXXMIpzBb1Znv2gOO/jN9MYyrCjzNOPki1NG3/XKzc=;
  b=n5dzyt+41eseDEQRV0sCAL/1iHnGeDwtG0h9WRqDJNl6lWS4bxNwhihy
   Chrwzgd/OZMtrTKtrzAebUhtXWZ3kzDNiZXD0/g0a3CgGLln8GimFq6TS
   TlzLsMT642Z2x81s6EtAobb2ZNjz41uGqxcahq7ddwV8EKcoz82sYJQLw
   KSr42VOEZzjOVUSKvopoS4veTUNl3Ml9VCzzKS4O1H292ENjYqHNR8hXP
   vQ0bZUgYG61zbUGs0L5E6hDKUiIlm5DevP7aYSYbvJzURbjQ1SKMg28RW
   +tJfK5B1avDTUtSuEPWby2pCWJ92vcJP928TaGIR+IypUiHfBVT9q6dqs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="329135003"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="329135003"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:23:52 -0700
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="538082471"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 15:23:52 -0700
Subject: [PATCH] dmaengine: idxd: make idxd_register/unregister_dma_channel()
 static
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 06 May 2022 15:23:52 -0700
Message-ID: <165187583222.3287435.12882651040433040246.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since idxd_register/unregister_dma_channel() are only called locally, make
them static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/dma.c  |    4 ++--
 drivers/dma/idxd/idxd.h |    2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/idxd/dma.c b/drivers/dma/idxd/dma.c
index d66cef5a918e..e0874cb4721c 100644
--- a/drivers/dma/idxd/dma.c
+++ b/drivers/dma/idxd/dma.c
@@ -250,7 +250,7 @@ void idxd_unregister_dma_device(struct idxd_device *idxd)
 	dma_async_device_unregister(&idxd->idxd_dma->dma);
 }
 
-int idxd_register_dma_channel(struct idxd_wq *wq)
+static int idxd_register_dma_channel(struct idxd_wq *wq)
 {
 	struct idxd_device *idxd = wq->idxd;
 	struct dma_device *dma = &idxd->idxd_dma->dma;
@@ -287,7 +287,7 @@ int idxd_register_dma_channel(struct idxd_wq *wq)
 	return 0;
 }
 
-void idxd_unregister_dma_channel(struct idxd_wq *wq)
+static void idxd_unregister_dma_channel(struct idxd_wq *wq)
 {
 	struct idxd_dma_chan *idxd_chan = wq->idxd_chan;
 	struct dma_chan *chan = &idxd_chan->chan;
diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index 8e03fb548d13..24e6a0824c64 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -600,8 +600,6 @@ int idxd_enqcmds(struct idxd_wq *wq, void __iomem *portal, const void *desc);
 /* dmaengine */
 int idxd_register_dma_device(struct idxd_device *idxd);
 void idxd_unregister_dma_device(struct idxd_device *idxd);
-int idxd_register_dma_channel(struct idxd_wq *wq);
-void idxd_unregister_dma_channel(struct idxd_wq *wq);
 void idxd_parse_completion_status(u8 status, enum dmaengine_tx_result *res);
 void idxd_dma_complete_txd(struct idxd_desc *desc,
 			   enum idxd_complete_type comp_type, bool free_desc);


