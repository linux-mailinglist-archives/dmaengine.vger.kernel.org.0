Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DA8518E07
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiECUM1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242259AbiECUMV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:12:21 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 114AB40A38
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608512; x=1683144512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pRf/mFVLi8zRLZl/MF8/vdPKSW7aMtpTIvfW+QX4Rco=;
  b=Hytse5QR8GYOkp9GjU7X8b21gyuB805pWvcwRgYkYw7jT7wxvS5qJFWZ
   3VsrTOIabY+tuxSmrQb4kjWpfYbnVOPdMExlT46BUNa6lePGxWMQDvw7y
   hhycSPNM7KCdBYbyjo3hGesLKEmuO7gbgvA7O9iG3Dm+gJeUkhOhB6Aiz
   jNvV5JBlK+CfmLfA/wHl5T29ttFAWKLUQ3VA9uhNJTqQO9kSWNC2eyKPZ
   RpUfsF2rthbXS1VwkKSL48XrEOR5twVttY27XlMpPnNE4UpkVud+iRtp3
   4Kvj4A3wd5m38MGQU/iuWspJwMbChPVZPGOXNKDJZ6JwqvtlPQ/kdI6GG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="248118270"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="248118270"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705392"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:08:31 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 13/15] dmaengine: idxd: idxd_desc.id is now a u16
Date:   Tue,  3 May 2022 13:07:26 -0700
Message-Id: <20220503200728.2321188-14-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200728.2321188-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 drivers/dma/idxd/idxd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/idxd.h b/drivers/dma/idxd/idxd.h
index a9021e332a5b4..40835160ef883 100644
--- a/drivers/dma/idxd/idxd.h
+++ b/drivers/dma/idxd/idxd.h
@@ -328,7 +328,7 @@ struct idxd_desc {
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

