Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F41B7B2D
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2020 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbgDXQLu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Apr 2020 12:11:50 -0400
Received: from mga01.intel.com ([192.55.52.88]:26126 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXQLu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Apr 2020 12:11:50 -0400
IronPort-SDR: lHl1s5QO7xCGnq2Xp84o3jQPNKnJ0QLIa6+0OZgAZ4L4In8zyWZM3BtJSHqAeH6cwtln+s1hlV
 3fNn/Arv7+8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:11:50 -0700
IronPort-SDR: 6hB6MIylSEhZBCVvJ8NjxiQdd5hFlUdZW59GfMP+lxQP45a/l2O9aPyrSYe/cmqIvGDAW+GCxs
 xbxqS3EwhOEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="403347984"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 24 Apr 2020 09:11:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AECDEBD; Fri, 24 Apr 2020 19:11:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Seraj Alijan <seraj.alijan@sondrel.com>
Subject: [PATCH v1 2/6] dmaengine: dmatest: Fix process hang when reading 'wait' parameter
Date:   Fri, 24 Apr 2020 19:11:43 +0300
Message-Id: <20200424161147.16895-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
References: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

If we do

  % echo 1 > /sys/module/dmatest/parameters/run
  [  115.851124] dmatest: Could not start test, no channels configured

  % echo dma8chan7 > /sys/module/dmatest/parameters/channel
  [  127.563872] dmatest: Added 1 threads using dma8chan7

  % cat /sys/module/dmatest/parameters/wait
  ... !!! HANG !!! ...

The culprit is the commit 6138f967bccc

  ("dmaengine: dmatest: Use fixed point div to calculate iops")

which makes threads not to run, but pending and being kicked off by writing
to the 'run' node. However, it forgot to consider 'wait' routine to avoid
above mentioned case.

In order to fix this, check for really running threads, i.e. with pending
and done flags unset.

It's pity the culprit commit hadn't updated documentation and tested all
possible scenarios.

Fixes: 6138f967bccc ("dmaengine: dmatest: Use fixed point div to calculate iops")
Cc: Seraj Alijan <seraj.alijan@sondrel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 4993e3e5c5b01..307622e765996 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -240,7 +240,7 @@ static bool is_threaded_test_run(struct dmatest_info *info)
 		struct dmatest_thread *thread;
 
 		list_for_each_entry(thread, &dtc->threads, node) {
-			if (!thread->done)
+			if (!thread->done && !thread->pending)
 				return true;
 		}
 	}
@@ -1192,7 +1192,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
 		mutex_unlock(&info->lock);
 		return ret;
 	}
-	/*Clear any previously run threads */
+	/* Clear any previously run threads */
 	if (!is_threaded_test_run(info) && !is_threaded_test_pending(info))
 		stop_threaded_test(info);
 	/* Reject channels that are already registered */
-- 
2.26.2

