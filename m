Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214817784E2
	for <lists+dmaengine@lfdr.de>; Fri, 11 Aug 2023 03:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjHKB0t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 21:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHKB0t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 21:26:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2028B2D54;
        Thu, 10 Aug 2023 18:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691717208; x=1723253208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6eOxzjNSdJ9xLoQ+f6WYB+DPCDQFuAVd8R3aCELZr7o=;
  b=U6QcTb0skvEprv6uezuukKXguxQq4x8Ipu7uH+4gW9AHBwF/nRD5aXOV
   aLHXJG3zE6+Mzg7IHrnj3Zm21Xags3fypsgxPLC2GH45w9FEW/Oqw38sq
   oGIBHH6MsLJRa2ygfFhg/6Bmu6DoJI+I/dtczpNNZDzGu8JRXO6RTR35P
   nEraomYh+NYXrJ9ORpQlTmntcTxOriOFJciBZNlTFrKEVGIqB5CqlSs+4
   Ez/XmBHTyEWFWWdRWV7W9XWfJXre1/nnldUpKkmbk/KHOTQ0FmPZ0CKlK
   F4aRQfxxBK0ZIP2qfvIk2gVTfWcUImYMczq3e73co3Gy9omELPt54XiR0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="351884241"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="351884241"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 18:26:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="726060720"
X-IronPort-AV: E=Sophos;i="6.01,164,1684825200"; 
   d="scan'208";a="726060720"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 10 Aug 2023 18:26:44 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/2] dmaengine: idxd: Allow ATS disable update only for configurable devices
Date:   Thu, 10 Aug 2023 18:26:34 -0700
Message-Id: <20230811012635.535413-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

ATS disable status in a WQ is read-only if the device is not configurable.
This change ensures that the ATS disable attribute can be modified via
sysfs only on configurable devices.

Fixes: 92de5fa2dc39 ("dmaengine: idxd: add ATS disable knob for work queues")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
Applied cleanly to
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine next

 drivers/dma/idxd/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index d16c16445c4f..66c89b07b3f7 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -1088,12 +1088,16 @@ static ssize_t wq_ats_disable_store(struct device *dev, struct device_attribute
 				    const char *buf, size_t count)
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
+	struct idxd_device *idxd = wq->idxd;
 	bool ats_dis;
 	int rc;
 
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
 	rc = kstrtobool(buf, &ats_dis);
 	if (rc < 0)
 		return rc;
-- 
2.37.1

