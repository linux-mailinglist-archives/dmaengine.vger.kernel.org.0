Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FA42AB68
	for <lists+dmaengine@lfdr.de>; Tue, 12 Oct 2021 20:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhJLSDX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 12 Oct 2021 14:03:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:34185 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhJLSDW (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 12 Oct 2021 14:03:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="288101479"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="288101479"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:01:20 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="524323013"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 11:01:20 -0700
Subject: [PATCH] dmaengine: idxd: remove gen cap field per spec 1.2 update
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org
Date:   Tue, 12 Oct 2021 11:01:19 -0700
Message-ID: <163406167978.1303649.1798682437841822837.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Remove max_descs_per_engine field. The recently released DSA spec 1.2 [1]
has removed this field and made it reserved.

[1]: https://software.intel.com/content/dam/develop/external/us/en/documents-tps/341204-intel-data-streaming-accelerator-spec.pdf

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/idxd/registers.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/idxd/registers.h b/drivers/dma/idxd/registers.h
index 97ffb06de9b0..262c8220adbd 100644
--- a/drivers/dma/idxd/registers.h
+++ b/drivers/dma/idxd/registers.h
@@ -36,8 +36,7 @@ union gen_cap_reg {
 		u64 max_batch_shift:4;
 		u64 max_ims_mult:6;
 		u64 config_en:1;
-		u64 max_descs_per_engine:8;
-		u64 rsvd3:24;
+		u64 rsvd3:32;
 	};
 	u64 bits;
 } __packed;


