Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9449616FBD8
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 11:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgBZKSp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 05:18:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:6532 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgBZKSp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 26 Feb 2020 05:18:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 02:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,487,1574150400"; 
   d="scan'208";a="237985362"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2020 02:18:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 96361411; Wed, 26 Feb 2020 12:18:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 3/4] dmaengine: Drop redundant 'else' keyword
Date:   Wed, 26 Feb 2020 12:18:40 +0200
Message-Id: <20200226101842.29426-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
References: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

It's obvious that 'else' keyword is redundant in the code like

	if (foo)
		return bar;
	else if (baz)
		...

Drop it for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index ae56a91c2a05..1bb5477ef7ec 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1230,9 +1230,9 @@ static inline int dma_maxpq(struct dma_device *dma, enum dma_ctrl_flags flags)
 {
 	if (dma_dev_has_pq_continue(dma) || !dmaf_continue(flags))
 		return dma_dev_to_maxpq(dma);
-	else if (dmaf_p_disabled_continue(flags))
+	if (dmaf_p_disabled_continue(flags))
 		return dma_dev_to_maxpq(dma) - 1;
-	else if (dmaf_continue(flags))
+	if (dmaf_continue(flags))
 		return dma_dev_to_maxpq(dma) - 3;
 	BUG();
 }
@@ -1243,7 +1243,7 @@ static inline size_t dmaengine_get_icg(bool inc, bool sgl, size_t icg,
 	if (inc) {
 		if (dir_icg)
 			return dir_icg;
-		else if (sgl)
+		if (sgl)
 			return icg;
 	}
 
-- 
2.25.0

