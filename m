Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE1302065
	for <lists+dmaengine@lfdr.de>; Mon, 25 Jan 2021 03:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbhAYC0Z (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 24 Jan 2021 21:26:25 -0500
Received: from mga11.intel.com ([192.55.52.93]:4250 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbhAYBxg (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Sun, 24 Jan 2021 20:53:36 -0500
IronPort-SDR: a58hFA2NlEdr7nQkQo/YNZx4c/l+Hjp4tLkECoBVMR1a+cxSXqHFi0Um2Pi3qJ/Az5fdXuZO77
 u56yO+pW/c7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176137829"
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="176137829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2021 17:50:58 -0800
IronPort-SDR: SA8mOd0otxmRq63dBZwXcXr/psK4yHK01+UAXRx71TgxmcppZIWQBcZZOz+9Y+iL7WDWDwHVJS
 B7h9z7bhTiEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,372,1602572400"; 
   d="scan'208";a="352795980"
Received: from jsia-hp-z620-workstation.png.intel.com ([10.221.118.135])
  by orsmga003.jf.intel.com with ESMTP; 24 Jan 2021 17:50:55 -0800
From:   Sia Jee Heng <jee.heng.sia@intel.com>
To:     vkoul@kernel.org, Eugeniy.Paltsev@synopsys.com, robh+dt@kernel.org
Cc:     andriy.shevchenko@linux.intel.com, jee.heng.sia@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v12 12/17] dmaengine: drivers: Kconfig: add HAS_IOMEM dependency to DW_AXI_DMAC
Date:   Mon, 25 Jan 2021 09:32:50 +0800
Message-Id: <20210125013255.25799-13-jee.heng.sia@intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210125013255.25799-1-jee.heng.sia@intel.com>
References: <20210125013255.25799-1-jee.heng.sia@intel.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If HAS_IOMEM is not defined and DW_AXI_DMAC is enabled under COMPILE_TEST,
the build fails with the following error:
dw-axi-dmac-platform.c:(.text+0xc4): undefined reference to
`devm_ioremap_resource'
Link: https://www.spinics.net/lists/dmaengine/msg25188.html

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Sia Jee Heng <jee.heng.sia@intel.com>
---
 drivers/dma/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index d242c7632621..38eb40ccd5e0 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -179,6 +179,7 @@ config DMA_SUN6I
 config DW_AXI_DMAC
 	tristate "Synopsys DesignWare AXI DMA support"
 	depends on OF || COMPILE_TEST
+	depends on HAS_IOMEM
 	select DMA_ENGINE
 	select DMA_VIRTUAL_CHANNELS
 	help
-- 
2.18.0

