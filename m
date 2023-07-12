Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426B0750FDA
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 19:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbjGLRmV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 13:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGLRmU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 13:42:20 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B115C119;
        Wed, 12 Jul 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689183740; x=1720719740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wo2LSYIPXTFGEx73v06CYq+6xd1CJp9Oc6efKsK9DW0=;
  b=DkwxAfZWit1KQbMcuZTHJIMffq8sj0dpsL1OiHqzw6FJAud3mXqeO57x
   TJvYOCTlBxtyn1PZST+D41Vv8u4Hu1APNTG4w7UMEjDvLqElL1an/yeaF
   A3op128XCq1WpA9G5zO7y3m+Yo3VV9YhG42WEyjXJLErSXNT+/3JSiZ0W
   yJ2jbEu43cgRrLJhOLSK01TOElt8WMLmXwOinp74vmlPWKpAJVUW4p7WZ
   RMq2ifqqct5N9VL5qd6OwIoPEQVbSEIteOp7slFkEcjwm0L5TL1k40+4X
   /K+O2MFjW/Zxm7b5fFYtQLJ+4E/QhniGRwsD8uDM8B2jiUqcpC63+0h4M
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="367581876"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="367581876"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:42:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="724965910"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="724965910"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jul 2023 10:42:09 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH v2] dmaengine: idxd: Clear PRS disable flag when disabling IDXD device
Date:   Wed, 12 Jul 2023 10:42:20 -0700
Message-Id: <20230712174220.3434989-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Disabling IDXD device doesn't reset Page Request Service (PRS)
disable flag to its initial value 0. This may cause user confusion
because once PRS is disabled user will see PRS still remains the
previous setting (i.e. disabled) via sysfs interface even after the
device is disabled.

To eliminate the confusion, reset PRS disable flag when the device
is disabled.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
v2:
- Fix Tony's email typo

 drivers/dma/idxd/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 5abbcc61c528..71dfb2c13066 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -387,6 +387,7 @@ static void idxd_wq_disable_cleanup(struct idxd_wq *wq)
 	clear_bit(WQ_FLAG_DEDICATED, &wq->flags);
 	clear_bit(WQ_FLAG_BLOCK_ON_FAULT, &wq->flags);
 	clear_bit(WQ_FLAG_ATS_DISABLE, &wq->flags);
+	clear_bit(WQ_FLAG_PRS_DISABLE, &wq->flags);
 	memset(wq->name, 0, WQ_NAME_SIZE);
 	wq->max_xfer_bytes = WQ_DEFAULT_MAX_XFER;
 	idxd_wq_set_max_batch_size(idxd->data->type, wq, WQ_DEFAULT_MAX_BATCH);
-- 
2.37.1

