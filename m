Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7856B5554A8
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359490AbiFVTjG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359854AbiFVTih (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:37 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD4517E0E;
        Wed, 22 Jun 2022 12:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926714; x=1687462714;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b2jYdUokYSrhLLJ65hnYCKypoanrr8xEmX1WraLh+kI=;
  b=XhWTImSyKzEAZGaufTfISFbQHCzPjilYzwtGxHs900QtUjUVMODUUHeG
   1PUiqDCtUIy24S4z57oVkFEIoqrRRLKUjmXaEAGgf4m7X92VRLvGXXfAF
   Tztqkdd4usw9EBtqTULzA9SECMux5CzDoKZYQFkkr3rXNDm2ra1cLcGOb
   vTBG5/gqpeXV9iVzobqAPjeS2bNIwBFI9+frz/YH/l3fuNzcxEHvQ+68U
   zhB8+xDXVFuMcgSEELWEEb8wmCJtItXCiazFU//eLywKbHUCS9xTM/+kp
   jQPtG8nbIkUZ7EFt7HOcJnyyyfp9wlznBm1+qdh+LPYVXmZHG4gw5ZBef
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="305983112"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="305983112"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542104"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:33 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/15] dmaengine: idxd: idxd_desc.id is now a u16
Date:   Wed, 22 Jun 2022 12:37:51 -0700
Message-Id: <20220622193753.3044206-14-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622193753.3044206-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
 <20220622193753.3044206-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is going to be packed into the cookie. It does not need to be
negative or larger than u16.

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
2.35.1

