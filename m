Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8403D2B88
	for <lists+dmaengine@lfdr.de>; Thu, 22 Jul 2021 19:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhGVRNi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 22 Jul 2021 13:13:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:5282 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230210AbhGVRNi (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Thu, 22 Jul 2021 13:13:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="209810417"
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="209810417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 10:54:11 -0700
X-IronPort-AV: E=Sophos;i="5.84,261,1620716400"; 
   d="scan'208";a="433387640"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 10:54:11 -0700
Subject: [PATCH] dmaengine: idxd: fix wq slot allocation index check
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Thu, 22 Jul 2021 10:54:10 -0700
Message-ID: <162697645067.3478714.506720687816951762.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The sbitmap wait and allocate routine checks the index that is returned
from sbitmap_queue_get(). It should be idxd >= 0 as 0 is also a valid
index. This fixes issue where submission path hangs when WQ size is 1.

Fixes: 0705107fcc80 ("dmaengine: idxd: move submission to sbitmap_queue")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/submit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/idxd/submit.c b/drivers/dma/idxd/submit.c
index 36c9c1a89b7e..196d6cf11965 100644
--- a/drivers/dma/idxd/submit.c
+++ b/drivers/dma/idxd/submit.c
@@ -67,7 +67,7 @@ struct idxd_desc *idxd_alloc_desc(struct idxd_wq *wq, enum idxd_op_type optype)
 		if (signal_pending_state(TASK_INTERRUPTIBLE, current))
 			break;
 		idx = sbitmap_queue_get(sbq, &cpu);
-		if (idx > 0)
+		if (idx >= 0)
 			break;
 		schedule();
 	}


