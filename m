Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66E3082EDB
	for <lists+dmaengine@lfdr.de>; Tue,  6 Aug 2019 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732541AbfHFJk6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 6 Aug 2019 05:40:58 -0400
Received: from mga11.intel.com ([192.55.52.93]:24449 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726713AbfHFJk6 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 6 Aug 2019 05:40:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Aug 2019 02:40:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,353,1559545200"; 
   d="scan'208";a="181928721"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Aug 2019 02:40:54 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8E8AE5B; Tue,  6 Aug 2019 12:40:55 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Viresh Kumar <vireshk@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 02/12] dmaengine: acpi: Move index to struct acpi_dma_spec
Date:   Tue,  6 Aug 2019 12:40:44 +0300
Message-Id: <20190806094054.64871-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
References: <20190806094054.64871-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

In the future ->acpi_dma_xlate() callback function may use the index
of FixedDMA() descriptor to be utilized for channel direction setting.

As a preparation step move index from local data structure to
struct acpi_dma_spec.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/acpi-dma.c   | 5 ++---
 include/linux/acpi_dma.h | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 4d66ee059808..b17373ee7ce0 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -318,7 +318,6 @@ static int acpi_dma_update_dma_spec(struct acpi_dma *adma,
 
 struct acpi_dma_parser_data {
 	struct acpi_dma_spec dma_spec;
-	size_t index;
 	size_t n;
 };
 
@@ -334,7 +333,7 @@ static int acpi_dma_parse_fixed_dma(struct acpi_resource *res, void *data)
 	if (res->type == ACPI_RESOURCE_TYPE_FIXED_DMA) {
 		struct acpi_resource_fixed_dma *dma = &res->data.fixed_dma;
 
-		if (pdata->n++ == pdata->index) {
+		if (pdata->n++ == pdata->dma_spec.index) {
 			pdata->dma_spec.chan_id = dma->channels;
 			pdata->dma_spec.slave_id = dma->request_lines;
 		}
@@ -372,9 +371,9 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 		return ERR_PTR(-ENODEV);
 
 	memset(&pdata, 0, sizeof(pdata));
-	pdata.index = index;
 
 	/* Initial values for the request line and channel */
+	dma_spec->index = index;
 	dma_spec->chan_id = -1;
 	dma_spec->slave_id = -1;
 
diff --git a/include/linux/acpi_dma.h b/include/linux/acpi_dma.h
index 72cedb916a9c..2caebb8fb158 100644
--- a/include/linux/acpi_dma.h
+++ b/include/linux/acpi_dma.h
@@ -18,12 +18,14 @@
 
 /**
  * struct acpi_dma_spec - slave device DMA resources
+ * @index:	index of FixedDMA() resource
  * @chan_id:	channel unique id
  * @slave_id:	request line unique id
  * @dev:	struct device of the DMA controller to be used in the filter
  *		function
  */
 struct acpi_dma_spec {
+	size_t		index;
 	int		chan_id;
 	int		slave_id;
 	struct device	*dev;
-- 
2.20.1

