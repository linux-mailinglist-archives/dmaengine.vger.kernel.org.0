Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAFC64A6628
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 21:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiBAUkj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 15:40:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:16572 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242666AbiBAUjM (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 15:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643747952; x=1675283952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YCcOVqkaTE+wIKqt/6MWpXPK+wO7rEJmNI0uOOpvj8g=;
  b=QVWMtyvL+7tm4hb90C3jrC0sFuWcPVPKguK/BJ/XISG40z78Do/da3OF
   j6DO+JVTAINl7TpvO9PLcD0d4sICdoNHZ0HjZ4C5j+G4MugZybmDYvzuc
   NkuzBuC1AUDKHTGHYzDWJ09YOsnjvgi6OwHRJ+OJK3qMP2+vGEmChmfW4
   zND+T6lqAFuK/JSWoCfuXc8/LtO2gLcu9pcr9eAx2z5Xc0XKf0o8Igtqn
   G48ifatHKaw5xPJfJbumQlenTwoviVEKIff0EJmCnB8T/Y2CeVNRnaZny
   FbN4ohXLrZloy/37HloLHculYPRwuJaBjTRdKaZAkSSbLtU+EXmeWrS7D
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334143878"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="334143878"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:39:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479820758"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 12:39:10 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RESEND 01/10] dmaengine: Remove dma_async_is_complete from client API
Date:   Tue,  1 Feb 2022 13:38:04 -0700
Message-Id: <20220201203813.3951461-2-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220201203813.3951461-1-benjamin.walker@intel.com>
References: <20220201203813.3951461-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This is never actually used by any existing DMA clients. It is only
used, via dma_cookie_status, by providers.

Signed-off-by: Ben Walker <benjamin.walker@intel.com>
---
 Documentation/driver-api/dmaengine/client.rst |  5 ++--
 drivers/dma/amba-pl08x.c                      |  1 -
 drivers/dma/at_hdmac.c                        |  3 +-
 drivers/dma/dmaengine.h                       | 10 ++++++-
 include/linux/dmaengine.h                     | 28 ++-----------------
 5 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/Documentation/driver-api/dmaengine/client.rst b/Documentation/driver-api/dmaengine/client.rst
index bfd057b21a000..85ecec2c40005 100644
--- a/Documentation/driver-api/dmaengine/client.rst
+++ b/Documentation/driver-api/dmaengine/client.rst
@@ -346,9 +346,8 @@ Further APIs
    the documentation in include/linux/dmaengine.h for a more complete
    description of this API.
 
-   This can be used in conjunction with dma_async_is_complete() and
-   the cookie returned from dmaengine_submit() to check for
-   completion of a specific DMA transaction.
+   This can be used with the cookie returned from dmaengine_submit()
+   to check for completion of a specific DMA transaction.
 
    .. note::
 
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index a24882ba37643..fd52556c3edb4 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1544,7 +1544,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_interrupt(
 }
 
 /*
- * Code accessing dma_async_is_complete() in a tight loop may give problems.
  * If slaves are relying on interrupts to signal completion this function
  * must not be called with interrupts disabled.
  */
diff --git a/drivers/dma/at_hdmac.c b/drivers/dma/at_hdmac.c
index 30ae36124b1db..bc0e1af2296c9 100644
--- a/drivers/dma/at_hdmac.c
+++ b/drivers/dma/at_hdmac.c
@@ -1483,8 +1483,7 @@ static int atc_terminate_all(struct dma_chan *chan)
  * @txstate: if not %NULL updated with transaction state
  *
  * If @txstate is passed in, upon return it reflect the driver
- * internal state and can be used with dma_async_is_complete() to check
- * the status of multiple cookies without re-checking hardware state.
+ * internal state.
  */
 static enum dma_status
 atc_tx_status(struct dma_chan *chan,
diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 53f16d3f00294..a2ce377e9ed0f 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -79,7 +79,15 @@ static inline enum dma_status dma_cookie_status(struct dma_chan *chan,
 		state->residue = 0;
 		state->in_flight_bytes = 0;
 	}
-	return dma_async_is_complete(cookie, complete, used);
+
+	if (complete <= used) {
+		if ((cookie <= complete) || (cookie > used))
+			return DMA_COMPLETE;
+	} else {
+		if ((cookie <= complete) && (cookie > used))
+			return DMA_COMPLETE;
+	}
+	return DMA_IN_PROGRESS;
 }
 
 static inline void dma_set_residue(struct dma_tx_state *state, u32 residue)
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 842d4f7ca752d..194e334b33bbc 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1439,9 +1439,9 @@ static inline void dma_async_issue_pending(struct dma_chan *chan)
  * @last: returns last completed cookie, can be NULL
  * @used: returns last issued cookie, can be NULL
  *
- * If @last and @used are passed in, upon return they reflect the driver
- * internal state and can be used with dma_async_is_complete() to check
- * the status of multiple cookies without re-checking hardware state.
+ * If @last and @used are passed in, upon return they reflect the most
+ * recently submitted (used) cookie and the most recently completed
+ * cookie.
  */
 static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
@@ -1457,28 +1457,6 @@ static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	return status;
 }
 
-/**
- * dma_async_is_complete - test a cookie against chan state
- * @cookie: transaction identifier to test status of
- * @last_complete: last know completed transaction
- * @last_used: last cookie value handed out
- *
- * dma_async_is_complete() is used in dma_async_is_tx_complete()
- * the test logic is separated for lightweight testing of multiple cookies
- */
-static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
-			dma_cookie_t last_complete, dma_cookie_t last_used)
-{
-	if (last_complete <= last_used) {
-		if ((cookie <= last_complete) || (cookie > last_used))
-			return DMA_COMPLETE;
-	} else {
-		if ((cookie <= last_complete) && (cookie > last_used))
-			return DMA_COMPLETE;
-	}
-	return DMA_IN_PROGRESS;
-}
-
 static inline void
 dma_set_tx_state(struct dma_tx_state *st, dma_cookie_t last, dma_cookie_t used, u32 residue)
 {
-- 
2.33.1

