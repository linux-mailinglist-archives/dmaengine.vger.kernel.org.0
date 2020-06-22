Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33C52032EC
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 11:08:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgFVJIM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 05:08:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:45026 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725907AbgFVJIM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 05:08:12 -0400
IronPort-SDR: pFzyayz1N3qKbB3XIFy+C5NuOlXi1ljroqVC2031H2x7G3JUk7Jej95Yv+lKkqiPyrVXUIvRSJ
 cjtTeMp01iDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="143668639"
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="143668639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 02:08:10 -0700
IronPort-SDR: xeIRaqaE8txbF/dnaAxDinJ/I5sSsF8R9f8bKwT/ypmj7gS6yIsdJc4PUzR0WZp+aGehLxktKe
 R43VM+msBfaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,266,1589266800"; 
   d="scan'208";a="422564715"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2020 02:08:09 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4EF90130; Mon, 22 Jun 2020 12:08:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: acpi: Drop double check for ACPI companion device
Date:   Mon, 22 Jun 2020 12:08:07 +0300
Message-Id: <20200622090807.28533-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

acpi_dev_get_resources() does perform the NULL pointer check against
ACPI companion device which is given as function parameter. Thus,
there is no need to duplicate this check in the caller.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/acpi-dma.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 8a05db3343d3..4aee511578ad 100644
--- a/drivers/dma/acpi-dma.c
+++ b/drivers/dma/acpi-dma.c
@@ -358,19 +358,12 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 {
 	struct acpi_dma_parser_data pdata;
 	struct acpi_dma_spec *dma_spec = &pdata.dma_spec;
+	struct acpi_device *adev = ACPI_COMPANION(dev);
 	struct list_head resource_list;
-	struct acpi_device *adev;
 	struct acpi_dma *adma;
 	struct dma_chan *chan = NULL;
 	int found;
-
-	/* Check if the device was enumerated by ACPI */
-	if (!dev)
-		return ERR_PTR(-ENODEV);
-
-	adev = ACPI_COMPANION(dev);
-	if (!adev)
-		return ERR_PTR(-ENODEV);
+	int ret;
 
 	memset(&pdata, 0, sizeof(pdata));
 	pdata.index = index;
@@ -380,9 +373,11 @@ struct dma_chan *acpi_dma_request_slave_chan_by_index(struct device *dev,
 	dma_spec->slave_id = -1;
 
 	INIT_LIST_HEAD(&resource_list);
-	acpi_dev_get_resources(adev, &resource_list,
-			acpi_dma_parse_fixed_dma, &pdata);
+	ret = acpi_dev_get_resources(adev, &resource_list,
+				     acpi_dma_parse_fixed_dma, &pdata);
 	acpi_dev_free_resource_list(&resource_list);
+	if (ret < 0)
+		return ret;
 
 	if (dma_spec->slave_id < 0 || dma_spec->chan_id < 0)
 		return ERR_PTR(-ENODEV);
-- 
2.27.0

