Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA307680BF1
	for <lists+dmaengine@lfdr.de>; Mon, 30 Jan 2023 12:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbjA3L17 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Jan 2023 06:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235265AbjA3L16 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Jan 2023 06:27:58 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C509EE1;
        Mon, 30 Jan 2023 03:27:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675078076; x=1706614076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vdNHzjVwpUhv3cIQFJNLv9Gws07gis6aqn++ilBt4pg=;
  b=BC2ULidCI9Z7kPer6Mrk3GHjTajxfJ6oqIiy5PzJqnsOgohaTuD/tOh8
   2FrsFADg99cDGMfD9b0LiV/KdEqfX80ngbKxQpMZ+Comwsct1C3XNQqmk
   bf4A4VpCQJNng1nDPY640vNEd6DIZRfvMrEvpsoo44H7K47FrZbR507jV
   iTqipaTWSsmQXCi7z3WAAv89FcKCVRNBE/d1JAfKm1n89wrFGS7dX/62o
   lGLviPO4cCfozOk5suRdaKv905vE8xqc38bulZq7fCJBfRDEp1e7fbpB7
   tw6A4cZ3rk1yjxKtu7GfpGKbPgVM5iN2ptKLGmiiHISpjLdT/NBjti4K4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="327551447"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="327551447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 03:27:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10605"; a="694530373"
X-IronPort-AV: E=Sophos;i="5.97,257,1669104000"; 
   d="scan'208";a="694530373"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 30 Jan 2023 03:27:54 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C733F358; Mon, 30 Jan 2023 13:28:31 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] dmaengine: Simplify dmaenginem_async_device_register() function
Date:   Mon, 30 Jan 2023 13:28:30 +0200
Message-Id: <20230130112830.52353-1-andriy.shevchenko@linux.intel.com>
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

Use devm_add_action_or_reset() instead of devres_alloc() and
devres_add(), which works the same. This will simplify the
code. There is no functional changes.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 4957f811d390..c24bca210104 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1323,11 +1323,8 @@ void dma_async_device_unregister(struct dma_device *device)
 }
 EXPORT_SYMBOL(dma_async_device_unregister);
 
-static void dmam_device_release(struct device *dev, void *res)
+static void dmaenginem_async_device_unregister(void *device)
 {
-	struct dma_device *device;
-
-	device = *(struct dma_device **)res;
 	dma_async_device_unregister(device);
 }
 
@@ -1339,22 +1336,13 @@ static void dmam_device_release(struct device *dev, void *res)
  */
 int dmaenginem_async_device_register(struct dma_device *device)
 {
-	void *p;
 	int ret;
 
-	p = devres_alloc(dmam_device_release, sizeof(void *), GFP_KERNEL);
-	if (!p)
-		return -ENOMEM;
-
 	ret = dma_async_device_register(device);
-	if (!ret) {
-		*(struct dma_device **)p = device;
-		devres_add(device->dev, p);
-	} else {
-		devres_free(p);
-	}
+	if (ret)
+		return ret;
 
-	return ret;
+	return devm_add_action(device->dev, dmaenginem_async_device_unregister, device);
 }
 EXPORT_SYMBOL(dmaenginem_async_device_register);
 
-- 
2.39.0

