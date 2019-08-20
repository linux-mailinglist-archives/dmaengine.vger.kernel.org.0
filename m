Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9B0095FB5
	for <lists+dmaengine@lfdr.de>; Tue, 20 Aug 2019 15:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbfHTNPu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 20 Aug 2019 09:15:50 -0400
Received: from mga09.intel.com ([134.134.136.24]:13976 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729024AbfHTNPu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 20 Aug 2019 09:15:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2019 06:15:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,408,1559545200"; 
   d="scan'208";a="172446732"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 20 Aug 2019 06:15:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1F02C1A1; Tue, 20 Aug 2019 16:15:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 02/10] dmaengine: acpi: Add kernel doc parameter descriptions
Date:   Tue, 20 Aug 2019 16:15:38 +0300
Message-Id: <20190820131546.75744-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
References: <20190820131546.75744-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Kernel documentation script is not happy about absence of function parameter
descriptions:

drivers/dma/acpi-dma.c:163: warning: Function parameter or member 'data' not described in 'acpi_dma_controller_register'
drivers/dma/acpi-dma.c:247: warning: Function parameter or member 'data' not described in 'devm_acpi_dma_controller_register'
drivers/dma/acpi-dma.c:274: warning: Function parameter or member 'dev' not described in 'devm_acpi_dma_controller_free'

Append the descriptions of above mentioned function parameters.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/acpi-dma.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 4d66ee059808..8a05db3343d3 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -147,7 +147,7 @@ static void acpi_dma_parse_csrt(struct acpi_device *adev, struct acpi_dma *adma)
  * @dev:		struct device of DMA controller
  * @acpi_dma_xlate:	translation function which converts a dma specifier
  *			into a dma_chan structure
- * @data		pointer to controller specific data to be used by
+ * @data:		pointer to controller specific data to be used by
  *			translation function
  *
  * Allocated memory should be freed with appropriate acpi_dma_controller_free()
@@ -231,7 +231,7 @@ static void devm_acpi_dma_release(struct device *dev, void *res)
  * devm_acpi_dma_controller_register - resource managed acpi_dma_controller_register()
  * @dev:		device that is registering this DMA controller
  * @acpi_dma_xlate:	translation function
- * @data		pointer to controller specific data
+ * @data:		pointer to controller specific data
  *
  * Managed acpi_dma_controller_register(). DMA controller registered by this
  * function are automatically freed on driver detach. See
@@ -264,6 +264,7 @@ EXPORT_SYMBOL_GPL(devm_acpi_dma_controller_register);
 
 /**
  * devm_acpi_dma_controller_free - resource managed acpi_dma_controller_free()
+ * @dev:	device that is unregistering as DMA controller
  *
  * Unregister a DMA controller registered with
  * devm_acpi_dma_controller_register(). Normally this function will not need to
-- 
2.23.0.rc1

