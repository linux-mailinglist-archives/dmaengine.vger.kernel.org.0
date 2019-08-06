Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20D782EDE
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2019 11:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732290AbfHFJk7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Aug 2019 05:40:59 -0400
Received: from mga02.intel.com ([134.134.136.20]:42750 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFJk7 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Aug 2019 05:40:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="373364474"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 06 Aug 2019 02:40:56 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9A062124; Tue,  6 Aug 2019 12:40:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 03/12] dmaengine: acpi: Provide consumer device to ->acpi_dma_xlate()
Date:   Tue,  6 Aug 2019 12:40:45 +0300
Message-Id: <20190806094054.64871-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
References: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the future ->acpi_dma_xlate() callback function may use the consumer
device pointer to be utilized for DMA crossbar programming.

As a preparation step provide consumer device pointer to ->acpi_dma_xlate().

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/acpi-dma.c   | 1 +
 include/linux/acpi_dma.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index b17373ee7ce0..1f35239e3ca2 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -373,6 +373,7 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 	memset(&pdata, 0, sizeof(pdata));
 
 	/* Initial values for the request line and channel */
+	dma_spec->consumer = dev;
 	dma_spec->index = index;
 	dma_spec->chan_id = -1;
 	dma_spec->slave_id = -1;
diff --git a/include/linux/acpi_dma.h b/include/linux/acpi_dma.h
index 2caebb8fb158..3b97d0b702af 100644
--- a/include/linux/acpi_dma.h
+++ b/include/linux/acpi_dma.h
@@ -18,6 +18,7 @@
 
 /**
  * struct acpi_dma_spec - slave device DMA resources
+ * @consumer:	struct device of the DMA resources consumer
  * @index:	index of FixedDMA() resource
  * @chan_id:	channel unique id
  * @slave_id:	request line unique id
@@ -25,6 +26,7 @@
  *		function
  */
 struct acpi_dma_spec {
+	struct device	*consumer;
 	size_t		index;
 	int		chan_id;
 	int		slave_id;
-- 
2.20.1

