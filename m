Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2245B1B7B2C
	for <lists+dmaengine@lfdr.de>; Fri, 24 Apr 2020 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgDXQLu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 24 Apr 2020 12:11:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:59187 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726813AbgDXQLu (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 24 Apr 2020 12:11:50 -0400
IronPort-SDR: Wz2fyliwQrq8nH8/ldAE0hZsjl9iP4fr1qYtr4QpOtBuZtRbAskqBjxGkHvAd2+M0mwjG9rIPT
 N6wtJJ1WlxlA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2020 09:11:49 -0700
IronPort-SDR: BvfU4qCNtqaE4TeohZcNTp1GDzMgCro2c56e9nTettaTnP6zqM0igIr5GaRDGmg6/P8IFEwUGm
 ++g4avYto+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,311,1583222400"; 
   d="scan'208";a="280845456"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 24 Apr 2020 09:11:48 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5EA411D; Fri, 24 Apr 2020 19:11:47 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH v1 1/6] dmaengine: dmatest: Fix iteration non-stop logic
Date:   Fri, 24 Apr 2020 19:11:42 +0300
Message-Id: <20200424161147.16895-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Under some circumstances, i.e. when test is still running and about to
time out and user runs, for example,

	grep -H . /sys/module/dmatest/parameters/*

the iterations parameter is not respected and test is going on and on until
user gives

	echo 0 > /sys/module/dmatest/parameters/run

This is not what expected.

The history of this bug is interesting. I though that the commit
  2d88ce76eb98 ("dmatest: add a 'wait' parameter")
is a culprit, but looking closer to the code I think it simple revealed the
broken logic from the day one, i.e. in the commit
  0a2ff57d6fba ("dmaengine: dmatest: add a maximum number of test iterations")
which adds iterations parameter.

So, to the point, the conditional of checking the thread to be stopped being
first part of conjunction logic prevents to check iterations. Thus, we have to
always check both conditions to be able to stop after given iterations.

Since it wasn't visible before second commit appeared, I add a respective
Fixes tag.

Fixes: 2d88ce76eb98 ("dmatest: add a 'wait' parameter")
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index a2cadfa2e6d78..4993e3e5c5b01 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -662,8 +662,8 @@ static int dmatest_func(void *data)
 		flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 
 	ktime = ktime_get();
-	while (!kthread_should_stop()
-	       && !(params->iterations && total_tests >= params->iterations)) {
+	while (!(kthread_should_stop() ||
+	       (params->iterations && total_tests >= params->iterations))) {
 		struct dma_async_tx_descriptor *tx = NULL;
 		struct dmaengine_unmap_data *um;
 		dma_addr_t *dsts;
-- 
2.26.2

