Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5C826CBCD
	for <lists+dmaengine@lfdr.de>; Wed, 16 Sep 2020 22:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgIPUfK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 16 Sep 2020 16:35:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:18480 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726901AbgIPRMy (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 16 Sep 2020 13:12:54 -0400
IronPort-SDR: c29paDL3xnb/xiJg2wNG0e5D3Boo3kmO2cSxkT0kcueqxSpNXvL0lIuX9xhtX0mR+G4Kc65xPE
 peZ+tDeFqV5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9745"; a="244296443"
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="244296443"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2020 06:34:59 -0700
IronPort-SDR: yd7ldFaLa1khZrsvdCfN5gzu/BkiRi0IEruFAoO/TCjvQOpXXZLgZQ9nZ4X90dk7qANNr/YfXu
 rM3046Z1S0Qw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,432,1592895600"; 
   d="scan'208";a="451855525"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 16 Sep 2020 06:34:57 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AABDB2E0; Wed, 16 Sep 2020 16:34:56 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH v1 3/3] dmaengine: dmatest: Return boolean result directly in filter()
Date:   Wed, 16 Sep 2020 16:34:56 +0300
Message-Id: <20200916133456.79280-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
References: <20200916133456.79280-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to have a conditional for boolean expression when
function returns bool. Drop unnecessary code and return boolean
result directly.

While at it, drop unneeded casting from void *.

Cc: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/dma/dmatest.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/dma/dmatest.c b/drivers/dma/dmatest.c
index 757eb1727a04..cf1379189316 100644
--- a/drivers/dma/dmatest.c
+++ b/drivers/dma/dmatest.c
@@ -1070,13 +1070,7 @@ static int dmatest_add_channel(struct dmatest_info *info,
 
 static bool filter(struct dma_chan *chan, void *param)
 {
-	struct dmatest_params *params = param;
-
-	if (!dmatest_match_channel(params, chan) ||
-	    !dmatest_match_device(params, chan->device))
-		return false;
-	else
-		return true;
+	return dmatest_match_channel(param, chan) && dmatest_match_device(param, chan->device);
 }
 
 static void request_channels(struct dmatest_info *info,
-- 
2.28.0

