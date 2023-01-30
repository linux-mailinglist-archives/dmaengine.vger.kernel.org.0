Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6760680BA5
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 12:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjA3LLM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 06:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA3LLL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 06:11:11 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492C17689;
        Mon, 30 Jan 2023 03:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675077070; x=1706613070;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pWqQ949dIxnsZ4zku56Ho22cRPtDfa5qSpWcF2btHIo=;
  b=YSe5zbljS0QkOm3iHVmWDu/zW+C5Pn/OeqVWzycipiJ++Ivq5XOyR+Ws
   1Her8SgACWdjurdV2Jn9h2a/IzeKgc+HhLE11Ri8NkwPk8LV/uwgvoGpC
   zno7jVfJdhxA6l32Qv+oPhZvjvu2/RcreJVAuZkmgHK0ElsaAHi+Qn/ZU
   Grk++HRPtmz64fSM2YHXAVcMJuwG0wq8OUBn3uWx2ZSP+MHYfeDC3vmNv
   abw6DVufUFba1OruW7A2dEiPcod2+1QYGW6MlyORSSWJez8Uesa8b2zu8
   W+lfsIOwVVqnltQ9v8+jYPqnR/yea0o0xQpTktiy2EvQiV1MvAdo/rV6y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="326198749"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="326198749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 03:11:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="752784984"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="752784984"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Jan 2023 03:11:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id B4704337; Mon, 30 Jan 2023 13:11:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] dmaengine: use sysfs_emit() to instead of scnprintf()
Date:   Mon, 30 Jan 2023 13:11:41 +0200
Message-Id: <20230130111141.59627-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Follow the advice of the Documentation/filesystems/sysfs.rst and show()
should only use sysfs_emit() or sysfs_emit_at() when formatting the
value to be returned to user space.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 8a6e6b60d66f..4957f811d390 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -172,7 +172,7 @@ static ssize_t memcpy_count_show(struct device *dev,
 	if (chan) {
 		for_each_possible_cpu(i)
 			count += per_cpu_ptr(chan->local, i)->memcpy_count;
-		err = sprintf(buf, "%lu\n", count);
+		err = sysfs_emit(buf, "%lu\n", count);
 	} else
 		err = -ENODEV;
 	mutex_unlock(&dma_list_mutex);
@@ -194,7 +194,7 @@ static ssize_t bytes_transferred_show(struct device *dev,
 	if (chan) {
 		for_each_possible_cpu(i)
 			count += per_cpu_ptr(chan->local, i)->bytes_transferred;
-		err = sprintf(buf, "%lu\n", count);
+		err = sysfs_emit(buf, "%lu\n", count);
 	} else
 		err = -ENODEV;
 	mutex_unlock(&dma_list_mutex);
@@ -212,7 +212,7 @@ static ssize_t in_use_show(struct device *dev, struct device_attribute *attr,
 	mutex_lock(&dma_list_mutex);
 	chan = dev_to_dma_chan(dev);
 	if (chan)
-		err = sprintf(buf, "%d\n", chan->client_count);
+		err = sysfs_emit(buf, "%d\n", chan->client_count);
 	else
 		err = -ENODEV;
 	mutex_unlock(&dma_list_mutex);
-- 
2.39.0

