Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B283354D543
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 01:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346965AbiFOX0t (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Jun 2022 19:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbiFOX0t (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Jun 2022 19:26:49 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4981711458
        for <dmaengine@vger.kernel.org>; Wed, 15 Jun 2022 16:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655335608; x=1686871608;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=b2V4mXLWo5Fl+lRouNbeZlAOW5oknAH0aeXHuzxISz4=;
  b=l4Zdkjq/miWKLQCQDMIYjYmtYEicJmm6nWwVTOJhe+mfLI5sj4idcWJn
   /DOhuz3mDUdcsxkdsVFDxCrazkQhMDfIY1dEm6kxdmJatrVvE+zlqWEhD
   W8K4Vit/hE7NcVh7qzDcOZQ//jLuYXxsZ1a6AkShxp3UDoIrGemW3LWW0
   u2+raJ6UIQAmU5RCWC0Pykxd26f8Ts3NvtJffUKyGrqYJ2EFpbqxw4k8G
   md5k+GWXpwvyGsLgAkTt7qxeyUX022EQvOcRJ+OUn1LOpnqHoo77pPuYk
   6cAdLu66HqIPL0XKxPHekB8Vs+j1nwbLx/JY+OK3AQ0lQwAGmGL0d9vHv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="365475726"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="365475726"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 16:26:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="618677144"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2022 16:26:47 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>
Cc:     "Dave Jiang" <dave.jiang@intel.com>, dmaengine@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] MAINTAINERS: idxd driver maintainer update
Date:   Wed, 15 Jun 2022 16:26:51 -0700
Message-Id: <20220615232651.177098-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

Add Fenghua as maintainer of the idxd driver.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2a..f3c679ed144b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9940,7 +9940,8 @@ S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-dmaengine/list/
 F:	drivers/dma/ioat*
 
-INTEL IADX DRIVER
+INTEL IDXD DRIVER
+M:	Fenghua Yu <fenghua.yu@intel.com>
 M:	Dave Jiang <dave.jiang@intel.com>
 L:	dmaengine@vger.kernel.org
 S:	Supported
-- 
2.32.0

