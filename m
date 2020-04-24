Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5E91B7B2F
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2020 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgDXQL4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Apr 2020 12:11:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:10015 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXQLz (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Apr 2020 12:11:55 -0400
IronPort-SDR: JreUixNLAS3NsaCjG186s3K4f6W4eCQHCIf7B51Kgin7dDjnSclNp8FYYOEquS7a534w7414a7
 IJTRACtd9YeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:11:50 -0700
IronPort-SDR: tP3OvNfXItYlPTvK38pngLShS6qc9YLZXrQWjrt1YEvkyEhhRt/GhqBQGe8TRJY/I9W6HzL3wR
 xKbtRRx0UNoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="259861796"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 24 Apr 2020 09:11:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C2546252; Fri, 24 Apr 2020 19:11:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gary Hook <Gary.Hook@amd.com>
Subject: [PATCH v1 4/6] dmaengine: dmatest: Allow negative timeout value to specify infinite wait
Date:   Fri, 24 Apr 2020 19:11:45 +0300
Message-Id: <20200424161147.16895-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The dmatest module parameter 'timeout' is documented as accepting a -1 to mean
"infinite timeout". However, an infinite timeout is not advised, nor possible
since the module parameter is an unsigned int, which won't accept a negative
value. Change the parameter type to be signed integer.

Cc: Gary Hook <Gary.Hook@amd.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a521067751651..123b4bd41a085 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -60,7 +60,7 @@ MODULE_PARM_DESC(pq_sources,
 		"Number of p+q source buffers (default: 3)");
 
 static int timeout = 3000;
-module_param(timeout, uint, S_IRUGO | S_IWUSR);
+module_param(timeout, int, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(timeout, "Transfer Timeout in msec (default: 3000), "
 		 "Pass -1 for infinite timeout");
 
-- 
2.26.2

