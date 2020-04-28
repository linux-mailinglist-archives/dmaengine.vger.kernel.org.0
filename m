Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A78431BBC84
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2020 13:35:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgD1Lf1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 28 Apr 2020 07:35:27 -0400
Received: from mga09.intel.com ([134.134.136.24]:8816 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgD1Lf0 (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 28 Apr 2020 07:35:26 -0400
IronPort-SDR: MxY4RT7/FcwEywfPdqQMXVGa9La85Ih7bc4JaLjoR42KfsKFw+qR8uy+3TOrCBkxLAcB7pLUiq
 /B2h28ff7EYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2020 04:35:26 -0700
IronPort-SDR: vqd7A0G8vK8mq0roworeDxRyUkmfvUvMTto7mFlgMeIqaXfKmPREMV/kfaXRv188usUCczM+5B
 x2DljGswclwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,327,1583222400"; 
   d="scan'208";a="249150372"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 28 Apr 2020 04:35:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4376311D; Tue, 28 Apr 2020 14:35:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Seraj Alijan <seraj.alijan@sondrel.com>
Subject: [PATCH v2] dmaengine: dmatest: Fix process hang when reading 'wait' parameter
Date:   Tue, 28 Apr 2020 14:35:18 +0300
Message-Id: <20200428113518.70620-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
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
v2: Drop unrelated hunk (Vinod)
 drivers/dma/dmatest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 659d6daa2db9a..c1ebc538404d2 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -248,7 +248,7 @@ static bool is_threaded_test_run(struct dmatest_info *info)
 		struct dmatest_thread *thread;
 
 		list_for_each_entry(thread, &dtc->threads, node) {
-			if (!thread->done)
+			if (!thread->done && !thread->pending)
 				return true;
 		}
 	}
-- 
2.26.2

