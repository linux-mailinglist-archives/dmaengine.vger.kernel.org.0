Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465AC624F84
	for <lists+dmaengine@lfdr.de>; Fri, 11 Nov 2022 02:27:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiKKB1j (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Nov 2022 20:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKB1i (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Nov 2022 20:27:38 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C6B445ED4;
        Thu, 10 Nov 2022 17:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668130057; x=1699666057;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/kM31rx5oqdFU+jyiipv1YnAwhJ5eiTKAf0Y5CGyT0U=;
  b=MW0LRX09lRMQeQElj4RK2GFqdxe8SFT8AH5BpK3fG+BUdQ4GRLdrx6z8
   j1O6mJZFRRGjXUAmM8oYKMaRtVMNbvLyBFGMnprTE91GQ56vHaAEg3KC7
   VROcx5ZTECa75QyhrAAnILQGCowSBF4i4KQO58LyLVPsTZsT2ZTMKiaLQ
   qWqDptSUYU6vaj9daAkGbLx/NDvCjgVIAJ9r2nBmqqfaw9skoIIuP2uCX
   6b2mZ6Nm5VJn3zIiRIyVN2+/VVc6bOBCkE2WG26dCdgHlZgG7cy/FsOWE
   Yhex2jIev8cASMv7GvXlHAYvzVdwd5fzpJyb7DkE9s+Er/GP6WfkLxMLz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="375750638"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="375750638"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 17:27:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="639839719"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="639839719"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga007.fm.intel.com with ESMTP; 10 Nov 2022 17:27:36 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        Nirav N Shah <nirav.n.shah@intel.com>
Subject: [PATCH] dmaengine: idxd: Fix crc_val field for completion record
Date:   Thu, 10 Nov 2022 17:27:15 -0800
Message-Id: <20221111012715.2031481-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The crc_val in the completion record should be 64 bits and not 32 bits.

Fixes: 4ac823e9cd85 ("dmaengine: idxd: fix delta_rec and crc size field for completion record")

Reported-by: Nirav N Shah <nirav.n.shah@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 include/uapi/linux/idxd.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 61ee43823622..09947ae61663 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -329,7 +329,7 @@ struct dsa_completion_record {
 		};
 
 		uint32_t	delta_rec_size;
-		uint32_t	crc_val;
+		uint64_t	crc_val;
 
 		/* DIF check & strip */
 		struct {
-- 
2.32.0

