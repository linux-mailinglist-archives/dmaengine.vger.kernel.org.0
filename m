Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BADE1B7B30
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2020 18:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgDXQMA (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Apr 2020 12:12:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:16772 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXQMA (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Apr 2020 12:12:00 -0400
IronPort-SDR: 2mNv7eCwoRFOh6e2ll618jgbjI8MYlKUWmDwrmVLkPmmyavFF2GJTB0lwABkrLEtXYz+7O2aAt
 eTnESG2XyXUA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:11:49 -0700
IronPort-SDR: 8sI4YBKU/ObRl8UYsbg4K4vGNuciL3ChjUhbCOd284kb4zsY+GpoaxMx4YkkubuTnKoaKr1H7B
 oXNvRb8O1rlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="291607275"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2020 09:11:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C6D7D130; Fri, 24 Apr 2020 19:11:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 5/6] dmaengine: dmatest: Describe members of struct dmatest_params
Date:   Fri, 24 Apr 2020 19:11:46 +0300
Message-Id: <20200424161147.16895-5-andriy.shevchenko@linux.intel.com>
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
struct dmatest_params are being described. Describe them all.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 123b4bd41a085..946b03859cdec 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -72,10 +72,6 @@ static bool norandom;
 module_param(norandom, bool, 0644);
 MODULE_PARM_DESC(norandom, "Disable random offset setup (default: random)");
 
-static bool polled;
-module_param(polled, bool, S_IRUGO | S_IWUSR);
-MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
-
 static bool verbose;
 module_param(verbose, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(verbose, "Enable \"success\" result messages (default: off)");
@@ -88,6 +84,10 @@ static unsigned int transfer_size;
 module_param(transfer_size, uint, 0644);
 MODULE_PARM_DESC(transfer_size, "Optional custom transfer size in bytes (default: not used (0))");
 
+static bool polled;
+module_param(polled, bool, S_IRUGO | S_IWUSR);
+MODULE_PARM_DESC(polled, "Use polling for completion instead of interrupts");
+
 /**
  * struct dmatest_params - test parameters.
  * @buf_size:		size of the memcpy test buffer
@@ -99,6 +99,11 @@ MODULE_PARM_DESC(transfer_size, "Optional custom transfer size in bytes (default
  * @xor_sources:	number of xor source buffers
  * @pq_sources:		number of p+q source buffers
  * @timeout:		transfer timeout in msec, -1 for infinite timeout
+ * @noverify:		disable data verification
+ * @norandom:		disable random offset setup
+ * @alignment:		custom data address alignment taken as 2^alignment
+ * @transfer_size:	custom transfer size in bytes
+ * @polled:		use polling for completion instead of interrupts
  */
 struct dmatest_params {
 	unsigned int	buf_size;
-- 
2.26.2

