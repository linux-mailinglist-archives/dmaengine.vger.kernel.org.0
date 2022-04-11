Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E32934FC75C
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 00:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241939AbiDKWKf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 18:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236068AbiDKWKf (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 18:10:35 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C385205DA
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 15:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649714900; x=1681250900;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mNlHctxSGUR7WBN3L+m8QOAeacCI7bd8wHGpolpThcE=;
  b=lkflUM6/nW2mshE+7NIsDE7F9sNC0LhnmeToK7JdWB0tOHhW96rTPp47
   KUw9zU+lqdUBaRu6WTGpFQFlgztGr2Zfoguu4twxc2ohd0KFv8j7GBgef
   sxiGflUqnKN0pKBDTUBFobxRVbcx724olO8bv7zR/JnJq1RL7IXFdTC1s
   GLByIajsdY27NahGo+6Ks6ImtvZC7BOZ3+3VerJywO6ZW03BPwu+H+yXi
   9zWlSgWwEXLpYB/+349ob4pmHdy/sHJDlwGxQsuHGawqPdR8PRuWjQ3q7
   N9QoFWlQhxc6rG1HJH6wDRH0FEBnVqVcsmGlnIfeC4EJ9ZpXfN2E5Zv1V
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261971549"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261971549"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:08:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="526171278"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:08:16 -0700
Subject: [PATCH] dmaengine: idxd: add RO check for wq max_transfer_size write
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 11 Apr 2022 15:08:01 -0700
Message-ID: <164971488154.2200913.10706665404118545941.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Block wq_max_transfer_size_store() when the device is configured as
read-only and not configurable.

Fixes: d7aad5550eca ("dmaengine: idxd: add support for configurable max wq xfer size")
Reported-by: Bernice Zhang <bernice.zhang@intel.com>
Tested-by: Bernice Zhang <bernice.zhang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index 7e19ab92b61a..ec13ca4808f9 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -905,6 +905,9 @@ static ssize_t wq_max_transfer_size_store(struct device *dev, struct device_attr
 	u64 xfer_size;
 	int rc;
 
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 


