Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37D6016FBDA
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 11:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727339AbgBZKSq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 05:18:46 -0500
Received: from mga14.intel.com ([192.55.52.115]:4280 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgBZKSp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 26 Feb 2020 05:18:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 02:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,487,1574150400"; 
   d="scan'208";a="231351574"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 26 Feb 2020 02:18:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 82605252; Wed, 26 Feb 2020 12:18:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/4] dmaengine: Refactor dmaengine_check_align() to be bit operations only
Date:   Wed, 26 Feb 2020 12:18:38 +0200
Message-Id: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to have branch and temporary variable in the function.
Simple convert it to be a set of bit and arithmetic operations.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 64461fc64e1b..9f3f5582816a 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1155,14 +1155,7 @@ static inline dma_cookie_t dmaengine_submit(struct dma_async_tx_descriptor *desc
 static inline bool dmaengine_check_align(enum dmaengine_alignment align,
 					 size_t off1, size_t off2, size_t len)
 {
-	size_t mask;
-
-	if (!align)
-		return true;
-	mask = (1 << align) - 1;
-	if (mask & (off1 | off2 | len))
-		return false;
-	return true;
+	return !(((1 << align) - 1) & (off1 | off2 | len));
 }
 
 static inline bool is_dma_copy_aligned(struct dma_device *dev, size_t off1,
-- 
2.25.0

