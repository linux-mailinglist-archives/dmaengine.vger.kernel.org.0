Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0CB3DDEC7
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 19:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbhHBRzW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 13:55:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:6654 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229640AbhHBRzW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 13:55:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="213492160"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="213492160"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 10:55:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="510338261"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2021 10:55:06 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 053A2142; Mon,  2 Aug 2021 20:55:35 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 1/1] dmaengine: acpi: Check for errors from acpi_register_gsi() separately
Date:   Mon,  2 Aug 2021 20:55:32 +0300
Message-Id: <20210802175532.54311-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

While IRQ test agaist the returned variable in practice is a good enough
there is still a room for theoretical mistake in case the vIRQ of the
device contains the same error code that acpi_register_gsi() may return.
Due to this, check for error code separately from matching the vIRQs.

Besides that, append documentation to tell why acpi_gsi_to_irq() can't
be used and we call acpi_register_gsi() instead.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/acpi-dma.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 52768dc8ce12..5906eae26e2a 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -75,8 +75,16 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
 	    si->mmio_base_high != upper_32_bits(mem))
 		return 0;
 
-	/* Match device by Linux vIRQ */
+	/*
+	 * acpi_gsi_to_irq() can't be used because some platforms do not save
+	 * registered IRQs in the MP table. Instead we just try to register
+	 * the GSI, which is the core part of the above mentioned function.
+	 */
 	ret = acpi_register_gsi(NULL, si->gsi_interrupt, si->interrupt_mode, si->interrupt_polarity);
+	if (ret < 0)
+		return 0;
+
+	/* Match device by Linux vIRQ */
 	if (ret != irq)
 		return 0;
 
-- 
2.30.2

