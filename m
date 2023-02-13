Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5738F69444E
	for <lists+dmaengine@lfdr.de>; Mon, 13 Feb 2023 12:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbjBMLVD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Feb 2023 06:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbjBMLVC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Feb 2023 06:21:02 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCF7D51C;
        Mon, 13 Feb 2023 03:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676287262; x=1707823262;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7i71Eh5IzRSdA12Ik77HuAuq/qyXaEBU/8lqRmjidz4=;
  b=XuQa6s1nqBzuQtzonCOnsbzcdvp3sLRhGf2xb7Mev4xfOwLSlDt/ype2
   yY3tKhJFlNStlnJYV10uZI45Oc5D6t8u8DqO3pdnQczyGwsAIuPGsSn7D
   6oo9dktxVxrytbfi+uVYs56FzugaF5G+0KEB0a3UQdrVGSbuFtaBvEjrm
   1bRUW5ZSfxSWsH551FTuebuVByCfu2RyxFbu7q5dM/PTLANAeY2Nw6iVZ
   BmnNOSDZsZZ99ouMf0xHoOYsd1gF2r85tmx56BqjVV8kzRi4wRjXb4KDo
   MZWKic+yj3WwNP0pnyA0vtO+qqFN/FCM6yuBZEUkTx5AjEpde5uSfySTV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="318893677"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="318893677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2023 03:21:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10619"; a="618615213"
X-IronPort-AV: E=Sophos;i="5.97,293,1669104000"; 
   d="scan'208";a="618615213"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 Feb 2023 03:21:00 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D4D611A6; Mon, 13 Feb 2023 13:21:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] dmaengine: Actually use devm_add_action_or_reset()
Date:   Mon, 13 Feb 2023 13:21:38 +0200
Message-Id: <20230213112138.32118-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It appears that the commit a1beaa50b583 ("dmaengine: Simplify
dmaenginem_async_device_register() function") mentions
devm_add_action_or_reset() the actual change utilised devm_add_action()
call by mistake.

Fix the issue by switching to devm_add_action_or_reset().

Fixes: a1beaa50b583 ("dmaengine: Simplify dmaenginem_async_device_register() function")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index c24bca210104..826b98284fa1 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -1342,7 +1342,7 @@ int dmaenginem_async_device_register(struct dma_device *device)
 	if (ret)
 		return ret;
 
-	return devm_add_action(device->dev, dmaenginem_async_device_unregister, device);
+	return devm_add_action_or_reset(device->dev, dmaenginem_async_device_unregister, device);
 }
 EXPORT_SYMBOL(dmaenginem_async_device_register);
 
-- 
2.39.1

