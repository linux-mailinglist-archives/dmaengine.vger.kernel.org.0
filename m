Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B04825F771
	for <lists+dmaengine@lfdr.de>; Mon,  7 Sep 2020 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgIGKNa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Sep 2020 06:13:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:24024 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728544AbgIGKNL (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Mon, 7 Sep 2020 06:13:11 -0400
IronPort-SDR: uTcr8iKsPmHjCA2sApkoTRMpDiYkpkYaEgP14YLh7cOqt5RCrk4fPYMN4qwhS9IzwE1kdfZwIa
 Y3HWZcAtyw/g==
X-IronPort-AV: E=McAfee;i="6000,8403,9736"; a="145692000"
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="145692000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2020 03:13:09 -0700
IronPort-SDR: +wFzoS+AtXQWZ5c8PWdnNYjRAKY/u/Ttp3uOxcmuKyIJ+WjK/EIAUL3nvS3JZZbPqYlNeYeOkA
 ffxZxXjxNNRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,401,1592895600"; 
   d="scan'208";a="285516216"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 07 Sep 2020 03:13:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id C3229E7; Mon,  7 Sep 2020 13:13:06 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: dmatest: Print error codes as signed value
Date:   Mon,  7 Sep 2020 13:13:06 +0300
Message-Id: <20200907101306.61824-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When we got an error from DMA mapping API we convert a negative value
to unsigned long type and hence make user confused:

  result #1: 'src mapping error' with src_off=0x19a72 dst_off=0xea len=0xccf4 (18446744073709551604)

Change this to print error codes as signed values.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 45d4d92e91db..8bd1a25ad3e3 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -7,6 +7,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/err.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
@@ -452,8 +453,13 @@ static unsigned int min_odd(unsigned int x, unsigned int y)
 static void result(const char *err, unsigned int n, unsigned int src_off,
 		   unsigned int dst_off, unsigned int len, unsigned long data)
 {
-	pr_info("%s: result #%u: '%s' with src_off=0x%x dst_off=0x%x len=0x%x (%lu)\n",
-		current->comm, n, err, src_off, dst_off, len, data);
+	if (IS_ERR_VALUE(data)) {
+		pr_info("%s: result #%u: '%s' with src_off=0x%x dst_off=0x%x len=0x%x (%ld)\n",
+			current->comm, n, err, src_off, dst_off, len, data);
+	} else {
+		pr_info("%s: result #%u: '%s' with src_off=0x%x dst_off=0x%x len=0x%x (%lu)\n",
+			current->comm, n, err, src_off, dst_off, len, data);
+	}
 }
 
 static void dbg_result(const char *err, unsigned int n, unsigned int src_off,
-- 
2.28.0

