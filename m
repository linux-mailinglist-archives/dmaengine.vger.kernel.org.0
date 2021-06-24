Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71B03B369E
	for <lists+dmaengine@lfdr.de>; Thu, 24 Jun 2021 21:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232502AbhFXTKn (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 24 Jun 2021 15:10:43 -0400
Received: from mga06.intel.com ([134.134.136.31]:23748 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhFXTKn (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 24 Jun 2021 15:10:43 -0400
IronPort-SDR: nAY8+LdvGf9fPSuCnofinLgCBIOvPg8hE6qvnC0UxN0NINc4ms1mZXUV6XZlPISQdrfFdT88eO
 UgB8KF1TLYnw==
X-IronPort-AV: E=McAfee;i="6200,9189,10025"; a="268674794"
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="268674794"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 12:08:23 -0700
IronPort-SDR: DgPj+x28b16XQxu86r4tPnyT2u+cVd/uqfXIuACr0f+zUQyCdu0yReKIWggxikY0rpSPLYQiMG
 6ew1fppRKpTw==
X-IronPort-AV: E=Sophos;i="5.83,297,1616482800"; 
   d="scan'208";a="556593897"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2021 12:08:22 -0700
Subject: [PATCH] dmaengine: idxd: add missing percpu ref put on failure
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 24 Jun 2021 12:08:21 -0700
Message-ID: <162456170168.1121236.7240941044089212312.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

When enqcmds() fails, exit path is missing a percpu_ref_put(). This can
cause failure on shutdown path when the driver is attempting to quiesce the
wq. Add missing percpu_ref_put() call on the error exit path.

Fixes: 93a40a6d7428 ("dmaengine: idxd: add percpu_ref to descriptor submission path")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/submit.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 19afb62abaff..b0f1ddf75d31 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -118,8 +118,10 @@ int idxd_submit_desc(struct idxd_wq *wq, struct idxd_desc *desc)
 		 * device is not accepting descriptor at all.
 		 */
 		rc = enqcmds(portal, desc->hw);
-		if (rc < 0)
+		if (rc < 0) {
+			percpu_ref_put(&wq->wq_active);
 			return rc;
+		}
 	}
 
 	percpu_ref_put(&wq->wq_active);


