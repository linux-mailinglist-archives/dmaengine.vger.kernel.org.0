Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC77ACAC3
	for <lists+dmaengine@lfdr.de>; Sun, 24 Sep 2023 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjIXQW4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Sep 2023 12:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXQWx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 24 Sep 2023 12:22:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBA983;
        Sun, 24 Sep 2023 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695572567; x=1727108567;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DUrY6tSBOGske6jp8+x7dYv9XL1Dlwpcfsix6g79S4k=;
  b=UIP707D+n/3r6eYPTmbc7eTJhe+kjDe0O4NylZYvurT8ukW3o2MHRSBY
   GsuxVQMCQ8hgF9UsyAVI29tlvtDIZWaFii6ojhQb9DFrd9VG1zarv/1Hw
   8/ympHgRh3UhAlfD3DG39ElyHNeSn16U+7dO32dM7UB5cowGKwfA+Vt1l
   GTsvetbeRFfUbEVYfQj8oe9JV3ISGMumO06uK/G7mbdOid4OuGAZy6w9X
   MuzE7BAgr8jzxA3RoAe2Vb2bPQgMw0vNRiRiJE6yRUvhvURZiRJnuPlhQ
   mA19hh2zA3Qh6EzRVXcFGvGFLOqIqCfKCN8XU95vLORU1tv5o30mRfnnF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447594101"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="447594101"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 09:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="921732331"
X-IronPort-AV: E=Sophos;i="6.03,173,1694761200"; 
   d="scan'208";a="921732331"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga005.jf.intel.com with ESMTP; 24 Sep 2023 09:22:46 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Michael Prinke <michael.prinke@intel.com>
Subject: [PATCH] dmaengine: idxd: Register dsa_bus_type before registering idxd sub-drivers
Date:   Sun, 24 Sep 2023 09:22:32 -0700
Message-Id: <20230924162232.1409454-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

idxd sub-drivers belong to bus dsa_bus_type. Thus, dsa_bus_type must be
registered in dsa bus init before idxd drivers can be registered.

But the order is wrong when both idxd and idxd_bus are builtin drivers.
In this case, idxd driver is compiled and linked before idxd_bus driver.
Since the initcall order is determined by the link order, idxd sub-drivers
are registered in idxd initcall before dsa_bus_type is registered
in idxd_bus initcall. idxd initcall fails:

[   21.562803] calling  idxd_init_module+0x0/0x110 @ 1
[   21.570761] Driver 'idxd' was unable to register with bus_type 'dsa' because the bus was not initialized.
[   21.586475] initcall idxd_init_module+0x0/0x110 returned -22 after 15717 usecs
[   21.597178] calling  dsa_bus_init+0x0/0x20 @ 1

To fix the issue, compile and link idxd_bus driver before idxd driver
to ensure the right registration order.

Fixes: d9e5481fca74 ("dmaengine: dsa: move dsa_bus_type out of idxd driver to standalone")
Reported-by: Michael Prinke <michael.prinke@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 drivers/dma/idxd/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/idxd/Makefile b/drivers/dma/idxd/Makefile
index dc096839ac63..c5e679070e46 100644
--- a/drivers/dma/idxd/Makefile
+++ b/drivers/dma/idxd/Makefile
@@ -1,12 +1,12 @@
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=IDXD
 
+obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
+idxd_bus-y := bus.o
+
 obj-$(CONFIG_INTEL_IDXD) += idxd.o
 idxd-y := init.o irq.o device.o sysfs.o submit.o dma.o cdev.o debugfs.o
 
 idxd-$(CONFIG_INTEL_IDXD_PERFMON) += perfmon.o
 
-obj-$(CONFIG_INTEL_IDXD_BUS) += idxd_bus.o
-idxd_bus-y := bus.o
-
 obj-$(CONFIG_INTEL_IDXD_COMPAT) += idxd_compat.o
 idxd_compat-y := compat.o
-- 
2.37.1

