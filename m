Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872C9750FC9
	for <lists+dmaengine@lfdr.de>; Wed, 12 Jul 2023 19:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGLRiO (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 12 Jul 2023 13:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbjGLRiN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 12 Jul 2023 13:38:13 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22041991;
        Wed, 12 Jul 2023 10:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689183492; x=1720719492;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TYhvma2gE7Mw095OVFE2jPkIF+FVK3/H6Q8d48I3RxM=;
  b=kGZl6dRHMITCv5MyeAikFBF9FAsmXM8vDG19MKVvxYR9NuopxGdI5eCa
   cVd+1KkFHJBHwVesbcpad+nLkp+7s4KBv+fJbrT/aRv5qROMK8Y+fpinS
   ybiKrx07L0F0n3Y+DTQYbBYZrjuDJGGz2WY2WO2OnTYTd++ZozDSP+P0j
   AS/Lty1+CB52/AySXZfqBEDcowoQpiRl8WLXw2kOU0tgZoGUjE9e3ZYGh
   HgF9zr5cuADL73Rq8+aBppAsXadTGMO3moUkRAzN1UfLgXi4BAlY8okLY
   JlDtt7zqx1APZwoB3IFrYSPTmLLvKWfVKsD8u5ITvrVnp0tSn+VAiUmlm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="345270611"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="345270611"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 10:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="671949466"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="671949466"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 12 Jul 2023 10:38:02 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Zhu <tongy.zhu@intel.com>
Subject: [PATCH] dmaengine: idxd: Clear PRS disable flag when disabling IDXD device
Date:   Wed, 12 Jul 2023 10:37:56 -0700
Message-Id: <20230712173756.3434925-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

Tested-by: Tony Zhu <tongy.zhu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
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

