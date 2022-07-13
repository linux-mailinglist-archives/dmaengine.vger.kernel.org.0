Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9837E573BEA
	for <lists+dmaengine@lfdr.de>; Wed, 13 Jul 2022 19:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbiGMRWf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 13 Jul 2022 13:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiGMRWd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 13 Jul 2022 13:22:33 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5643B2;
        Wed, 13 Jul 2022 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657732952; x=1689268952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1jAH0JC2h59ZDuy2BkbW4V+e7vzjrMyqWlxPevPebtc=;
  b=LQbJm1g6ie4neAru6we3O1qYFay2spjn170YbssRFxa2E36Defok7xcX
   NBGZWTHcz62Otr23U2ekU4pJUApDVPTXPOyNr6FqjxpXoRUjRbmXhHgF1
   NQ98Dj5eyCSLwxmurbfvp6IBeuQduBK8iZwPyTuxh9gSA6XueGycBRAkc
   z7YjW6VklWK1NX6H4WxE9aHqYqsbCToz6xYjFObHxmeEmxCZhsFwAjblt
   MGDuNvhi3IQd4fmi3OH/Zoa7RPOH8/2dhJ0iWHCrkdUuadWErpZy4cqe3
   SOhgivbdjiHxFkBQ0MEIVj2wjmlh7c++TVblmblmkbWEQNBkbxxCFZ6Hp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="349262519"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="349262519"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 10:22:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="698507453"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2022 10:22:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 569DF366; Wed, 13 Jul 2022 20:22:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 4/4] dmaengine: hsu: Include headers we are direct user of
Date:   Wed, 13 Jul 2022 20:22:35 +0300
Message-Id: <20220713172235.22611-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
References: <20220713172235.22611-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

For the sake of integrity, include headers we are direct user of.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/hsu/hsu.c                 | 8 ++++++++
 drivers/dma/hsu/hsu.h                 | 5 ++++-
 drivers/dma/hsu/pci.c                 | 1 +
 include/linux/dma/hsu.h               | 6 ++++--
 include/linux/platform_data/dma-hsu.h | 2 +-
 5 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/hsu/hsu.c b/drivers/dma/hsu/hsu.c
index 92caae55aece..af5a2e252c25 100644
--- a/drivers/dma/hsu/hsu.c
+++ b/drivers/dma/hsu/hsu.c
@@ -16,12 +16,20 @@
  *    port 3, and so on.
  */
 
+#include <linux/bits.h>
 #include <linux/delay.h>
+#include <linux/device.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
 #include <linux/module.h>
+#include <linux/percpu-defs.h>
+#include <linux/scatterlist.h>
 #include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
 
 #include "hsu.h"
 
diff --git a/drivers/dma/hsu/hsu.h b/drivers/dma/hsu/hsu.h
index 1c1195709c2f..3bca577b98a1 100644
--- a/drivers/dma/hsu/hsu.h
+++ b/drivers/dma/hsu/hsu.h
@@ -11,7 +11,10 @@
 #define __DMA_HSU_H__
 
 #include <linux/bits.h>
-#include <linux/spinlock.h>
+#include <linux/container_of.h>
+#include <linux/io.h>
+#include <linux/types.h>
+
 #include <linux/dma/hsu.h>
 
 #include "../virt-dma.h"
diff --git a/drivers/dma/hsu/pci.c b/drivers/dma/hsu/pci.c
index 8cdf715a7e9e..0fcc0c0c22fc 100644
--- a/drivers/dma/hsu/pci.c
+++ b/drivers/dma/hsu/pci.c
@@ -10,6 +10,7 @@
 
 #include <linux/bitops.h>
 #include <linux/device.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 
diff --git a/include/linux/dma/hsu.h b/include/linux/dma/hsu.h
index a6b7bc707356..77ea602c287c 100644
--- a/include/linux/dma/hsu.h
+++ b/include/linux/dma/hsu.h
@@ -8,11 +8,13 @@
 #ifndef _DMA_HSU_H
 #define _DMA_HSU_H
 
-#include <linux/device.h>
-#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/kconfig.h>
+#include <linux/types.h>
 
 #include <linux/platform_data/dma-hsu.h>
 
+struct device;
 struct hsu_dma;
 
 /**
diff --git a/include/linux/platform_data/dma-hsu.h b/include/linux/platform_data/dma-hsu.h
index c65b412b2b33..611bae193c1c 100644
--- a/include/linux/platform_data/dma-hsu.h
+++ b/include/linux/platform_data/dma-hsu.h
@@ -8,7 +8,7 @@
 #ifndef _PLATFORM_DATA_DMA_HSU_H
 #define _PLATFORM_DATA_DMA_HSU_H
 
-#include <linux/device.h>
+struct device;
 
 struct hsu_dma_slave {
 	struct device	*dma_dev;
-- 
2.35.1

