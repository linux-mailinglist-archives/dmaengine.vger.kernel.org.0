Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF4016FBD9
	for <lists+dmaengine@lfdr.de>; Wed, 26 Feb 2020 11:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBZKSp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 26 Feb 2020 05:18:45 -0500
Received: from mga09.intel.com ([134.134.136.24]:55567 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbgBZKSp (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Wed, 26 Feb 2020 05:18:45 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 02:18:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,487,1574150400"; 
   d="scan'208";a="350356714"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 26 Feb 2020 02:18:43 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A47B044B; Wed, 26 Feb 2020 12:18:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 4/4] dmaengine: consistently return string literal from switch-case
Date:   Wed, 26 Feb 2020 12:18:41 +0200
Message-Id: <20200226101842.29426-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
References: <20200226101842.29426-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

There is no need to have 'break;' statement in the default case followed by
return certain string literal when all other cases have returned the string
literals. So, refactor it accordingly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/dmaengine.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 1bb5477ef7ec..d3672f065a64 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1560,9 +1560,7 @@ dmaengine_get_direction_text(enum dma_transfer_direction dir)
 	case DMA_DEV_TO_DEV:
 		return "DEV_TO_DEV";
 	default:
-		break;
+		return "invalid";
 	}
-
-	return "invalid";
 }
 #endif /* DMAENGINE_H */
-- 
2.25.0

