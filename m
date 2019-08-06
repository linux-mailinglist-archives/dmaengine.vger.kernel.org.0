Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBFC282EDA
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2019 11:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbfHFJk6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Aug 2019 05:40:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:49741 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732262AbfHFJk6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Aug 2019 05:40:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="202756367"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 06 Aug 2019 02:40:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7E879FF; Tue,  6 Aug 2019 12:40:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 01/12] dmaengine: acpi: Set up DMA mask based on CSRT
Date:   Tue,  6 Aug 2019 12:40:43 +0300
Message-Id: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

CSRT has an information about address width, which is supported by
the certain DMA controller.

Use information from CSRT to set up DMA mask for shared controller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/acpi-dma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 30243f5c0710..4d66ee059808 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -10,6 +10,7 @@
  */
 
 #include <linux/device.h>
+#include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -82,6 +83,12 @@ static int acpi_dma_parse_resource_group(const struct acpi_csrt_group *grp,
 	if (si->base_request_line == 0 && si->num_handshake_signals == 0)
 		return 0;
 
+	/* Set up DMA mask based on value from CSRT */
+	ret = dma_coerce_mask_and_coherent(&adev->dev,
+					   DMA_BIT_MASK(si->dma_address_width));
+	if (ret)
+		return 0;
+
 	adma->base_request_line = si->base_request_line;
 	adma->end_request_line = si->base_request_line +
 				 si->num_handshake_signals - 1;
-- 
2.20.1

