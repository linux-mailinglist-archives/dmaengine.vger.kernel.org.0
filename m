Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71274255CE6
	for <lists+dmaengine@lfdr.de>; Fri, 28 Aug 2020 16:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgH1OpZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Aug 2020 10:45:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:58836 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgH1OpX (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 28 Aug 2020 10:45:23 -0400
IronPort-SDR: gAq64vX7DcvkzVGy7BcBcwGTl5Tm5cGLMEhHDcXrSh2Lcey3288oa5CTz5L/0td0VcXaOlgjNs
 4ZBgJbtkLn+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="144418950"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="144418950"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 07:45:22 -0700
IronPort-SDR: rIkuO7L9pR/A/Jtx+6sg3xUbsLUiSNVHWRmgGWY52dB1t7AqTqBBVDOp1gYY8qG5yw0RwCmOoI
 SHzfasTVP4Ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="332562609"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 28 Aug 2020 07:45:21 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 3BD48166; Fri, 28 Aug 2020 17:45:19 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] dmaengine: Save few bytes and increase readability of dma_request_chan()
Date:   Fri, 28 Aug 2020 17:45:19 +0300
Message-Id: <20200828144519.14483-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Split IS_ERR_OR_NULL() check followed by additional conditional
to two simple conditionals. This increases readability and saves memory:

Function                                     old     new   delta
dma_request_chan                             700     697      -3
Total: Before=10224, After=10221, chg -0.03%

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmaengine.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index a53e71d2bbd4..adf804aa50a5 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -847,8 +847,10 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name)
 	}
 	mutex_unlock(&dma_list_mutex);
 
-	if (IS_ERR_OR_NULL(chan))
-		return chan ? chan : ERR_PTR(-EPROBE_DEFER);
+	if (IS_ERR(chan))
+		return chan;
+	if (!chan)
+		return ERR_PTR(-EPROBE_DEFER);
 
 found:
 #ifdef CONFIG_DEBUG_FS
-- 
2.28.0

