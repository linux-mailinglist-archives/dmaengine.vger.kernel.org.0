Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4713E2EEC
	for <lists+dmaengine@lfdr.de>; Fri,  6 Aug 2021 19:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhHFRjK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 6 Aug 2021 13:39:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:61744 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235701AbhHFRjJ (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 6 Aug 2021 13:39:09 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10068"; a="214399151"
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="214399151"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 10:38:38 -0700
X-IronPort-AV: E=Sophos;i="5.84,301,1620716400"; 
   d="scan'208";a="467949492"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 10:38:38 -0700
Subject: [PATCH] dmaengine: idxd: set descriptor allocation size to threshold
 for swq
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Fri, 06 Aug 2021 10:38:37 -0700
Message-ID: <162827151733.3459223.3829837172226042408.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Since submission is sent to limited portal, the actual wq size for shared
wq is set by the threshold rather than the wq size. When the wq type is
shared, set the allocated descriptors to the threshold.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/device.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 21f0d732b76e..e093cf225a5c 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -141,8 +141,8 @@ int idxd_wq_alloc_resources(struct idxd_wq *wq)
 	if (wq->type != IDXD_WQT_KERNEL)
 		return 0;
 
-	wq->num_descs = wq->size;
-	num_descs = wq->size;
+	num_descs = wq_dedicated(wq) ? wq->size : wq->threshold;
+	wq->num_descs = num_descs;
 
 	rc = alloc_hw_descs(wq, num_descs);
 	if (rc < 0)


