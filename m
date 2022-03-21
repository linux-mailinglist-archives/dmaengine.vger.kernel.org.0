Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423414E31F9
	for <lists+dmaengine@lfdr.de>; Mon, 21 Mar 2022 21:40:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345887AbiCUUmS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 21 Mar 2022 16:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345385AbiCUUmR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 21 Mar 2022 16:42:17 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC99F4F46D
        for <dmaengine@vger.kernel.org>; Mon, 21 Mar 2022 13:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647895251; x=1679431251;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RVIOdI5IXTfwiCw0dAqspH/u9A9zZz6BhKao8DXE/Xc=;
  b=Z7mW2Trt7WTJjpdkQlytlqfRwopXyB/1x0L4eQLcyu48hvBinnm5BUt0
   ciZjneDiZZULUT+3zDa7XrH/LNH1nvPhD2PgnIkJvJs8gS0yWCuc7ekWp
   vTTzBk1I2OMhhlCtRk0cFN8E5xChxV1Z07+g7yf7wH0j9Itv2Q1aslhRC
   hkQs+rQnRB0wfQ3zWt5pSkqd/I3JwG4N8CR1O4wGnno+SBOb3V2Xzxy3B
   Gpolao00MC47w7XX5oB5HRbZnSnQPNpLLVRm5864QMSCAFL4uZ8HOjOQX
   5eJr5Vp5Geu6iUMtl9IZx73tUCl4ZnnQsB18s0HhUHuBvk+6gBAs7VJSO
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="237586275"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="237586275"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 13:40:51 -0700
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="785120389"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 13:40:51 -0700
Subject: [PATCH] dmaengine: idxd: remove trailing white space on input str for
 wq name
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 21 Mar 2022 13:40:51 -0700
Message-ID: <164789525123.2799661.13795829125221129132.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add string processing with strim() in order to remove trailing white spaces
that may be input by user for the wq->name.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index dbc7f9af11d3..08ceee801e4b 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -832,6 +832,7 @@ static ssize_t wq_name_store(struct device *dev,
 			     size_t count)
 {
 	struct idxd_wq *wq = confdev_to_wq(dev);
+	char *input, *pos;
 
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
@@ -846,9 +847,14 @@ static ssize_t wq_name_store(struct device *dev,
 	if (wq->type == IDXD_WQT_KERNEL && device_pasid_enabled(wq->idxd))
 		return -EOPNOTSUPP;
 
+	input = kstrndup(buf, count, GFP_KERNEL);
+	if (!input)
+		return -ENOMEM;
+
+	pos = strim(input);
 	memset(wq->name, 0, WQ_NAME_SIZE + 1);
-	strncpy(wq->name, buf, WQ_NAME_SIZE);
-	strreplace(wq->name, '\n', '\0');
+	sprintf(wq->name, "%s", pos);
+	kfree(input);
 	return count;
 }
 


