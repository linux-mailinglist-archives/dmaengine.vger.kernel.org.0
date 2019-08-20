Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4080995FB4
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfHTNPu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:15:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:13976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728595AbfHTNPu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="202674801"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2019 06:15:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 15B28FC; Tue, 20 Aug 2019 16:15:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 01/10] dmaengine: acpi: Set up DMA mask based on CSRT
Date:   Tue, 20 Aug 2019 16:15:37 +0300
Message-Id: <20190820131546.75744-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
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
2.23.0.rc1

