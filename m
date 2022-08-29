Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47F25A55A5
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 22:36:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiH2UgP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 16:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiH2UgO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 16:36:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B297478BD0;
        Mon, 29 Aug 2022 13:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661805373; x=1693341373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SsDUgyJnKFU1wjSCmT6NcnZ6nhHM03n8RmHcmSLP/IU=;
  b=X353sxB1AMVI0xzqPWwoi5W02ais5m9sqnuRTkpBlAILtn8FJ6cq9Z35
   pLJoEeYjcVQb1v4phlAh0nYvmPmNT0CA3HIELYe8gQQIEik/BdzjbSFWv
   VDQ0FGBGQSoRz/1TsPtblh/JEFjlCd+lylqgeXt2OiorHane6UxvmzFsC
   msD5DhlromLeOA/5jzDzthobMDEglI8zDo5th2whXuv3U3X85en9+fd9D
   mZtyABxAzYy/0CsAOqxBLO8o7ppAlDzCamj4+bZ49uZNoCPVHtE8Hj+Lq
   HxxdYpYEFTHsDhaJ76K/2XvEpA4QxwhWEVwGlURysDpVnBzc18u4ew2JP
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="358958437"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="358958437"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:36:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="614344344"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2022 13:36:13 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 5/7] dmaengine: idxd: idxd_desc.id is now a u16
Date:   Mon, 29 Aug 2022 13:35:35 -0700
Message-Id: <20220829203537.30676-6-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220829203537.30676-1-benjamin.walker@intel.com>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
 <20220829203537.30676-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is going to be packed into the cookie. It does not need to be
negative or larger than u16.

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/idxd/idxd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index fed0dfc1eaa83..bd93ada32c89d 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -325,7 +325,7 @@ struct idxd_desc {
 	struct dma_async_tx_descriptor txd;
 	struct llist_node llnode;
 	struct list_head list;
-	int id;
+	u16 id;
 	int cpu;
 	struct idxd_wq *wq;
 };
-- 
2.37.1

