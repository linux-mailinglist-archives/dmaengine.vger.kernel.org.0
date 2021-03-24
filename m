Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0655B347A7A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Mar 2021 15:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhCXOST (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Mar 2021 10:18:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:64067 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236117AbhCXORy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 24 Mar 2021 10:17:54 -0400
IronPort-SDR: oYCh2+r8tbbPEdSVa0ZJ0newkjB21e2RPWIC+o4Bga9Jbr7BqPkKf1CwNHX/0O5QZWRCMZKi9h
 nXTzP56H9+Cw==
X-IronPort-AV: E=McAfee;i="6000,8403,9933"; a="177829118"
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="177829118"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2021 07:17:52 -0700
IronPort-SDR: UC/PuvDCvSmJ2CltK+NBPNt2sbjyBpEXAes+h1D1ND1eWwCvcHn8OOgWLhW9y19645bGFcRJ55
 /eLpCnv+Pmdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,274,1610438400"; 
   d="scan'208";a="604709033"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 24 Mar 2021 07:17:50 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D911516A; Wed, 24 Mar 2021 16:18:03 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2 1/1] dmaengine: dw: Make it dependent to HAS_IOMEM
Date:   Wed, 24 Mar 2021 16:17:57 +0200
Message-Id: <20210324141757.24710-1-andriy.shevchenko@linux.intel.com>
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
v2: used proper option (Serge)
 drivers/dma/dw/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw/Kconfig b/drivers/dma/dw/Kconfig
index e5162690de8f..db25f9b7778c 100644
--- a/drivers/dma/dw/Kconfig
+++ b/drivers/dma/dw/Kconfig
@@ -10,6 +10,7 @@ config DW_DMAC_CORE
 
 config DW_DMAC
 	tristate "Synopsys DesignWare AHB DMA platform driver"
+	depends on HAS_IOMEM
 	select DW_DMAC_CORE
 	help
 	  Support the Synopsys DesignWare AHB DMA controller. This
@@ -18,6 +19,7 @@ config DW_DMAC
 config DW_DMAC_PCI
 	tristate "Synopsys DesignWare AHB DMA PCI driver"
 	depends on PCI
+	depends on HAS_IOMEM
 	select DW_DMAC_CORE
 	help
 	  Support the Synopsys DesignWare AHB DMA controller on the
-- 
2.30.2

