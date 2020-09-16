Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9796A26C721
	for <lists+dmaengine@lfdr.de>; Wed, 16 Sep 2020 20:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbgIPSTn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Sep 2020 14:19:43 -0400
Received: from mga04.intel.com ([192.55.52.120]:22384 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727737AbgIPSTb (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Sep 2020 14:19:31 -0400
IronPort-SDR: inwCnAckeQHGiYDTUJMXwHP7UeAXFszsATdIjyYMH4GfDnZ1MPdSGaOAHwHfI5nUwjK5grXUD6
 Lk1m1mmqr0SQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="156849605"
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="156849605"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:34:58 -0700
IronPort-SDR: 3AIm6u1nQJbdDwFt84EoeRt955wZ/bxlwbgSOMDsvLDChO2GAaozdApeR1tjVOFUFwmJ4lIYoX
 m8TV0Yh0wzJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,433,1592895600"; 
   d="scan'208";a="508005234"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 16 Sep 2020 06:34:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 95FCE2D0; Wed, 16 Sep 2020 16:34:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Vladimir Murzin <vladimir.murzin@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] dmaengine: dmatest: Fix regression when run command on misconfigured channel
Date:   Wed, 16 Sep 2020 16:34:54 +0300
Message-Id: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

From: Vladimir Murzin <vladimir.murzin@arm.com>

Andy reported that commit 6b41030fdc79 ("dmaengine: dmatest:
Restore default for channel") broke his scripts for the case
where "busy" channel is used for configuration with expectation
that run command would do nothing (and return 0). Instead,
behavior was (unintentionally) changed to treat such case as
under-configuration and progress with defaults, i.e. run command
would start a test with default setting for channel (which would
use all channels).

Restore original behavior with tracking status of channel setter
so we can distinguish between misconfigured and under-configured
cases in run command and act accordingly.

Fixes: 6b41030fdc79 ("dmaengine: dmatest: Restore default for channel")
Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Tested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index b2790641370a..4c9a9d7b48bb 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -129,6 +129,7 @@ struct dmatest_params {
  * @nr_channels:	number of channels under test
  * @lock:		access protection to the fields of this structure
  * @did_init:		module has been initialized completely
+ * @last_error:		test has faced configuration issues
  */
 static struct dmatest_info {
 	/* Test parameters */
@@ -137,6 +138,7 @@ static struct dmatest_info {
 	/* Internal state */
 	struct list_head	channels;
 	unsigned int		nr_channels;
+	int			last_error;
 	struct mutex		lock;
 	bool			did_init;
 } test_info = {
@@ -1202,10 +1204,22 @@ static int dmatest_run_set(const char *val, const struct kernel_param *kp)
 		return ret;
 	} else if (dmatest_run) {
 		if (!is_threaded_test_pending(info)) {
-			pr_info("No channels configured, continue with any\n");
-			if (!is_threaded_test_run(info))
-				stop_threaded_test(info);
-			add_threaded_test(info);
+			/*
+			 * We have nothing to run. This can be due to:
+			 */
+			ret = info->last_error;
+			if (ret) {
+				/* 1) Mis-configuration */
+				pr_warn("Channel misconfigured, can't continue\n");
+				mutex_unlock(&info->lock);
+				return ret;
+			} else {
+				/* 2) We rely on defaults */
+				pr_info("No channels configured, continue with any\n");
+				if (!is_threaded_test_run(info))
+					stop_threaded_test(info);
+				add_threaded_test(info);
+			}
 		}
 		start_threaded_tests(info);
 	} else {
@@ -1222,7 +1236,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
 	struct dmatest_info *info = &test_info;
 	struct dmatest_chan *dtc;
 	char chan_reset_val[20];
-	int ret = 0;
+	int ret;
 
 	mutex_lock(&info->lock);
 	ret = param_set_copystring(val, kp);
@@ -1230,7 +1244,7 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
 		mutex_unlock(&info->lock);
 		return ret;
 	}
-	/*Clear any previously run threads */
+	/* Clear any previously run threads */
 	if (!is_threaded_test_run(info) && !is_threaded_test_pending(info))
 		stop_threaded_test(info);
 	/* Reject channels that are already registered */
@@ -1277,12 +1291,14 @@ static int dmatest_chan_set(const char *val, const struct kernel_param *kp)
 		goto add_chan_err;
 	}
 
+	info->last_error = ret;
 	mutex_unlock(&info->lock);
 
 	return ret;
 
 add_chan_err:
 	param_set_copystring(chan_reset_val, kp);
+	info->last_error = ret;
 	mutex_unlock(&info->lock);
 
 	return ret;
-- 
2.28.0

