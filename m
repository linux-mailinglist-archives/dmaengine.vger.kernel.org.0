Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C57426CBCC
	for <lists+dmaengine@lfdr.de>; Wed, 16 Sep 2020 22:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgIPUeD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Sep 2020 16:34:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:6031 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726900AbgIPRMy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Sep 2020 13:12:54 -0400
IronPort-SDR: dK4pn6I6l80sleAiyOCJKEm4sxk7rOvb2rIY9cZvyixr/QgWFNtTxkxQb/LpG4dWuYsYhCPAJt
 5vLvR6b7RM+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="160390001"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="160390001"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:34:59 -0700
IronPort-SDR: 3JJFnI70kQiYyeypnqq1TpKKMdJAP8B8LRsBX/ot/I1YGYbnmzLwN/4dUd7OTjAZGD++SLqqxZ
 5BiCTPFzOJ7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="331680617"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 16 Sep 2020 06:34:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A138F277; Wed, 16 Sep 2020 16:34:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH v1 2/3] dmaengine: dmatest: Check list for emptiness before access its last entry
Date:   Wed, 16 Sep 2020 16:34:55 +0300
Message-Id: <20200916133456.79280-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
References: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

After writing a garbage to the channel we get an Oops in dmatest_chan_set()
due to access to last entry in the empty list.

[  212.670672] BUG: unable to handle page fault for address: fffffff000000020
[  212.677562] #PF: supervisor read access in kernel mode
[  212.682702] #PF: error_code(0x0000) - not-present page
...
[  212.710074] RIP: 0010:dmatest_chan_set+0x149/0x2d0 [dmatest]
[  212.715739] Code: e8 cc f9 ff ff 48 8b 1d 0d 55 00 00 48 83 7b 10 00 0f 84 63 01 00 00 48 c7 c7 d0 65 4d c0 e8 ee 4a f5 e1 48 89 c6 48 8b 43 10 <48> 8b 40 20 48 8b 78 58 48 85 ff 0f 84 f5 00 00 00 e8 b1 41 f5 e1

Fix this by checking list for emptiness before accessing its last entry.

Fixes: d53513d5dc28 ("dmaengine: dmatest: Add support for multi channel testing")
Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 4c9a9d7b48bb..757eb1727a04 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -1267,15 +1267,14 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
 	add_threaded_test(info);
 
 	/* Check if channel was added successfully */
-	dtc = list_last_entry(&info->channels, struct dmatest_chan, node);
-
-	if (dtc->chan) {
+	if (!list_empty(&info->channels)) {
 		/*
 		 * if new channel was not successfully added, revert the
 		 * "test_channel" string to the name of the last successfully
 		 * added channel. exception for when users issues empty string
 		 * to channel parameter.
 		 */
+		dtc = list_last_entry(&info->channels, struct dmatest_chan, node);
 		if ((strcmp(dma_chan_name(dtc->chan), strim(test_channel)) != 0)
 		    && (strcmp("", strim(test_channel)) != 0)) {
 			ret = -EINVAL;
-- 
2.28.0

