Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 200143DDF71
	for <lists+dmaengine@lfdr.de>; Mon,  2 Aug 2021 20:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhHBSnm (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 2 Aug 2021 14:43:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:17779 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229537AbhHBSnm (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 2 Aug 2021 14:43:42 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="193107199"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="193107199"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 11:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="500524389"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2021 11:43:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6D58FB9; Mon,  2 Aug 2021 21:44:00 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Viresh Kumar <vireshk@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH v1 1/3] dmaengine: dw: Remove error message from DT parsing code
Date:   Mon,  2 Aug 2021 21:43:53 +0300
Message-Id: <20210802184355.49879-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Users are a bit frightened of the harmless message that tells that
DT is missed on ACPI-based platforms. Remove it for good, it will
simplify the future conversion to fwnode and device property APIs.

Fixes: a9ddb575d6d6 ("dmaengine: dw_dmac: Enhance device tree support")
Depends-on: f5e84eae7956 ("dmaengine: dw: platform: Split OF helpers to separate module")
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=199379
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dw/of.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/dma/dw/of.c b/drivers/dma/dw/of.c
index c1cf7675b9d1..4d2b89142721 100644
--- a/drivers/dma/dw/of.c
+++ b/drivers/dma/dw/of.c
@@ -54,11 +54,6 @@ struct dw_dma_platform_data *dw_dma_parse_dt(struct platform_device *pdev)
 	u32 nr_masters;
 	u32 nr_channels;
 
-	if (!np) {
-		dev_err(&pdev->dev, "Missing DT data\n");
-		return NULL;
-	}
-
 	if (of_property_read_u32(np, "dma-masters", &nr_masters))
 		return NULL;
 	if (nr_masters < 1 || nr_masters > DW_DMA_MAX_NR_MASTERS)
-- 
2.30.2

