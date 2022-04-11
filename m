Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16F54FC75D
	for <lists+dmaengine@lfdr.de>; Tue, 12 Apr 2022 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbiDKWLM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Apr 2022 18:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiDKWLL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Apr 2022 18:11:11 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A27120F42
        for <dmaengine@vger.kernel.org>; Mon, 11 Apr 2022 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649714936; x=1681250936;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=og+2eZ0aYm34LtfdPyPEIbv4lVbTrapYCUF7Uq+SVeQ=;
  b=mBItPBsuImVPQdn6UE/W15XbYuyrpe/SoxTtdQg+OcoKCt+7TPx96ZuQ
   XMJOQyg+1+oY0bER+VfinHI2ITbhYDJKqG7iUQmB1a+XMu17E0iFeG6R9
   YPyzsNSI2c8+R91JolAHvazJQLpj+/0HNSilWokFdoELGuWLi4DUEe9yp
   fhm+Jf55w2+GqgkB0gjO04JUr3ctRa/JxZU6BzhK5puIbqm2C7Bb/ec4N
   xlWMwJkWdVU7yO2c7sN4n7bkvFt4AcS2iIy9E6vnvC7Jh5oiGuc/7RhdH
   Ce18GC/gpZ+OSJmyJUDzLFAZqE0m0yJHREP0R8ZQxamAmFG+sfZxNlJsi
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="244109815"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="244109815"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:08:56 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="611174066"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:08:55 -0700
Subject: [PATCH] dmaengine: idxd: add RO check for wq max_batch_size write
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Mon, 11 Apr 2022 15:08:55 -0700
Message-ID: <164971493551.2201159.1942042593642155209.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Block wq_max_batch_size_store() when the device is configured as read-only
and not configurable.

Fixes: e7184b159dd3 ("dmaengine: idxd: add support for configurable max wq batch size")
Reported-by: Bernice Zhang <bernice.zhang@intel.com>
Tested-by: Bernice Zhang <bernice.zhang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/sysfs.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/idxd/sysfs.c b/drivers/dma/idxd/sysfs.c
index ec13ca4808f9..dfd549685c46 100644
--- a/drivers/dma/idxd/sysfs.c
+++ b/drivers/dma/idxd/sysfs.c
@@ -942,6 +942,9 @@ static ssize_t wq_max_batch_size_store(struct device *dev, struct device_attribu
 	u64 batch_size;
 	int rc;
 
+	if (!test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+		return -EPERM;
+
 	if (wq->state != IDXD_WQ_DISABLED)
 		return -EPERM;
 


