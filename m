Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213A91B7B34
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2020 18:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgDXQMG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Apr 2020 12:12:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:1826 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXQMG (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Apr 2020 12:12:06 -0400
IronPort-SDR: xxWzeNxn0kFkJVKsWFEIbgalMiwJnaHO7oZtdVER60DO3bWvXRqtlcJUjJqzJz/JWIazi1CIrr
 X/uTM1OKEoFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:12:06 -0700
IronPort-SDR: fLQxW8RmQdMac9KaQDrdlQjV+6kxih36OunwMAZ5adSOGglXzSY/QlrHH+oQL5JJXdADd8Pybu
 NuZGjUmdqTtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="335386242"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2020 09:11:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id BA7EE1D9; Fri, 24 Apr 2020 19:11:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gary Hook <Gary.Hook@amd.com>
Subject: [PATCH v1 3/6] Revert "dmaengine: dmatest: timeout value of -1 should specify infinite wait"
Date:   Fri, 24 Apr 2020 19:11:44 +0300
Message-Id: <20200424161147.16895-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This reverts commit ed04b7c57c3383ed4573f1d1d1dbdc1108ba0bed.

While it gives a good description what happens, the approach seems too
confusing. Let's fix it in the following patch.

Cc: Gary Hook <Gary.Hook@amd.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 307622e765996..a521067751651 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -62,7 +62,7 @@ MODULE_PARM_DESC(pq_sources,
 static int timeout = 3000;
 module_param(timeout, uint, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(timeout, "Transfer Timeout in msec (default: 3000), "
-		 "Pass 0xFFFFFFFF (4294967295) for maximum timeout");
+		 "Pass -1 for infinite timeout");
 
 static bool noverify;
 module_param(noverify, bool, S_IRUGO | S_IWUSR);
@@ -98,7 +98,7 @@ MODULE_PARM_DESC(transfer_size, "Optional custom transfer size in bytes (default
  * @iterations:		iterations before stopping test
  * @xor_sources:	number of xor source buffers
  * @pq_sources:		number of p+q source buffers
- * @timeout:		transfer timeout in msec, 0 - 0xFFFFFFFF (4294967295)
+ * @timeout:		transfer timeout in msec, -1 for infinite timeout
  */
 struct dmatest_params {
 	unsigned int	buf_size;
@@ -109,7 +109,7 @@ struct dmatest_params {
 	unsigned int	iterations;
 	unsigned int	xor_sources;
 	unsigned int	pq_sources;
-	unsigned int	timeout;
+	int		timeout;
 	bool		noverify;
 	bool		norandom;
 	int		alignment;
-- 
2.26.2

