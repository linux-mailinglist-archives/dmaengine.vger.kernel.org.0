Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A81347826
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 13:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbhCXMSV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 08:18:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:36467 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229839AbhCXMSQ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 08:18:16 -0400
IronPort-SDR: fK3VJ+aFWz767aYid5EaetlpkCDLv6ckisuIcQSEpCkyAlZju5dGt6Htpd84tBQRebLqtEHUQp
 UwETwvPkI/Yg==
X-IronPort-AV: E=McAfee;i="6000,8403,9932"; a="187380810"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="187380810"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 05:18:15 -0700
IronPort-SDR: Ojdi5hVSSLTcAOZMovBGpJm8SLdWNNQaaewWdTJWtAlBmFqWMP0dMmozSJV1wqnFU5cvXAYuO6
 RQI395SWm0cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="525223873"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Mar 2021 05:18:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 32DB2195; Wed, 24 Mar 2021 14:18:27 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v1 1/1] dmaengine: dw: Make it dependent to HAVE_IOMEM
Date:   Wed, 24 Mar 2021 14:18:22 +0200
Message-Id: <20210324121822.18092-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some architectures do not provide devm_*() APIs. Hence make the driver
dependent on HAVE_IOMEM.

Fixes: dbde5c2934d1 ("dw_dmac: use devm_* functions to simplify code")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
index e5162690de8f..dd4b56669d9f 100644
--- a/drivers/dma/dw/Kconfig
+++ b/drivers/dma/dw/Kconfig
@@ -10,6 +10,7 @@ config DW_DMAC_CORE
 
 config DW_DMAC
 	tristate "Synopsys DesignWare AHB DMA platform driver"
+	depends on HAVE_IOMEM
 	select DW_DMAC_CORE
 	help
 	  Support the Synopsys DesignWare AHB DMA controller. This
@@ -18,6 +19,7 @@ config DW_DMAC
 config DW_DMAC_PCI
 	tristate "Synopsys DesignWare AHB DMA PCI driver"
 	depends on PCI
+	depends on HAVE_IOMEM
 	select DW_DMAC_CORE
 	help
 	  Support the Synopsys DesignWare AHB DMA controller on the
-- 
2.30.2

