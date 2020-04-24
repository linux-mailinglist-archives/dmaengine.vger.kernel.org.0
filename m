Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD941B7B2E
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2020 18:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgDXQLx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Apr 2020 12:11:53 -0400
Received: from mga02.intel.com ([134.134.136.20]:58722 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXQLx (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Apr 2020 12:11:53 -0400
IronPort-SDR: 7SqnwB2JYpXwykm8ZB6pQBEqU1om32aVc3mejZjTGiCFYVyV+hDwCjvjWcyhzm29lfnOmQH66a
 4fuy9Ow9kF4Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:11:53 -0700
IronPort-SDR: 62H6VqYgzaLL3FR8rewhMKfS1RYoUSUSeLx/8bT2VzYoUsbEX6ar2McYC9GSRTJa3mNXX5eedi
 Hi+Rkyaq3HJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="274639286"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 24 Apr 2020 09:11:51 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D5113402; Fri, 24 Apr 2020 19:11:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 6/6] dmaengine: dmatest: Describe members of struct dmatest_info
Date:   Fri, 24 Apr 2020 19:11:47 +0300
Message-Id: <20200424161147.16895-6-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Kernel documentation validator complains that not all members of
struct dmatest_info are being described. Describe them all.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 946b03859cdec..31ba5d7b6ae8c 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -125,7 +125,10 @@ struct dmatest_params {
 /**
  * struct dmatest_info - test information.
  * @params:		test parameters
+ * @channels:		channels under test
+ * @nr_channels:	number of channels under test
  * @lock:		access protection to the fields of this structure
+ * @did_init:		module has been initialized completely
  */
 static struct dmatest_info {
 	/* Test parameters */
-- 
2.26.2

