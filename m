Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570D61E29FD
	for <lists+dmaengine@lfdr.de>; Tue, 26 May 2020 20:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgEZSYU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 26 May 2020 14:24:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:37437 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728838AbgEZSYU (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 26 May 2020 14:24:20 -0400
IronPort-SDR: LLDejtoFeuYCp54p7Zi25F/pPJKaZyKrsmGUNXYZRpxIHqiBlFxIJso5BzJpuoeKUVEER3ZNKd
 hp0LEmgHy0GA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2020 11:24:19 -0700
IronPort-SDR: Z5eexcTJHi2qZtt+Z7llvUTg+8WXISrv8jhUfUjwriMT3TvEMJm1tZMTMFxX9Ul1JPc6yusV2F
 GwsuudSVYCSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; 
   d="scan'208";a="255234922"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 26 May 2020 11:24:17 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E70C976; Tue, 26 May 2020 21:24:16 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Viresh Kumar <vireshk@kernel.org>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] dmaengine: dw: Replace 'objs' by 'y'
Date:   Tue, 26 May 2020 21:24:16 +0300
Message-Id: <20200526182416.52805-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526182416.52805-1-andriy.shevchenko@linux.intel.com>
References: <20200526182416.52805-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

`-objs` is fitted for building host programs, change to `-y`,
more straightforward for device drivers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw/Makefile b/drivers/dma/dw/Makefile
index 9e949f13e1b5..a6f358ad8591 100644
--- a/drivers/dma/dw/Makefile
+++ b/drivers/dma/dw/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DW_DMAC_CORE)	+= dw_dmac_core.o
-dw_dmac_core-objs	:= core.o dw.o idma32.o
+dw_dmac_core-y			:= core.o dw.o idma32.o
 dw_dmac_core-$(CONFIG_ACPI)	+= acpi.o
 
 obj-$(CONFIG_DW_DMAC)		+= dw_dmac.o
@@ -8,4 +8,4 @@ dw_dmac-y			:= platform.o
 dw_dmac-$(CONFIG_OF)		+= of.o
 
 obj-$(CONFIG_DW_DMAC_PCI)	+= dw_dmac_pci.o
-dw_dmac_pci-objs	:= pci.o
+dw_dmac_pci-y			:= pci.o
-- 
2.26.2

