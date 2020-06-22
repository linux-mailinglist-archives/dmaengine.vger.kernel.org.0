Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 578E9203EDC
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2020 20:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730148AbgFVSNP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 22 Jun 2020 14:13:15 -0400
Received: from mga12.intel.com ([192.55.52.136]:48363 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730099AbgFVSNO (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 22 Jun 2020 14:13:14 -0400
IronPort-SDR: 5wDWRDXIeRmFErbcGiwa2AP8Qwmq43VU4rtUMhGA2jDAxAWvvb/si9vcitx8Sjfq2XM3Zl7/D4
 9zG5j584zJOQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123490120"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="123490120"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 11:13:14 -0700
IronPort-SDR: 51sqBjulrGQe9g+d2LH60NP3JGTxfVAJSDm4sR8i98QoyH2rKywBOD/zUpVDVWSq+vQdJgPfwj
 AWgNfrjDsMFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="scan'208";a="478565947"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 22 Jun 2020 11:13:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5CACD11C; Mon, 22 Jun 2020 21:13:12 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] dmaengine: acpi: Drop double check for ACPI companion device
Date:   Mon, 22 Jun 2020 21:13:11 +0300
Message-Id: <20200622181311.67649-1-andriy.shevchenko@linux.intel.com>
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
v2: fixed sparse and compiler warning (kbuild bot)
 drivers/dma/acpi-dma.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/dma/acpi-dma.c b/drivers/dma/acpi-dma.c
index 8a05db3343d3..35f4804ea4af 100644
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
+		return ERR_PTR(ret);
 
 	if (dma_spec->slave_id < 0 || dma_spec->chan_id < 0)
 		return ERR_PTR(-ENODEV);
-- 
2.27.0

