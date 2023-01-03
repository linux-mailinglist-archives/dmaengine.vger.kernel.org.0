Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7988F65C40C
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238127AbjACQfc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238129AbjACQfT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:35:19 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DB3E0F0
        for <dmaengine@vger.kernel.org>; Tue,  3 Jan 2023 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672763719; x=1704299719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tyCc7wPptMaqt29Tg7AeBDFdWw6VzI8ZCfMLb6669gk=;
  b=NUlAC1a0qjNwF4u8YxewuOH1c1fssYDapC21vh9JC+fOepIclT4O9u73
   1HknNH0fLDJFnF5Z2pXQq9hNh0DhpskEesUJA+egr/Uy+1s4RzhsIml/I
   92sXxP57QNW5g5cd3N9qNBobrAsO0LjTyW+Sq3PrJKtHJ99IYEcFr7YTe
   53EKBpKLJiBjRaKJwwkdpVQGw+Z6BAAiy5V+fdV58DYI+FCACVVquuOJ+
   Mh8PULSe4W8sUohdIgtYMICqA7idc+bZFJUZGdg2F4AHlqTY62r6i16NZ
   eOToByunJQMLOY+MQpfpzr+W+l78vuw/+Ij2Ube1PJtNwTnxW+iILAXOC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="302072335"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="302072335"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:35:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="604858541"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="604858541"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga003.jf.intel.com with ESMTP; 03 Jan 2023 08:35:15 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        Tony Zhu <tony.zhu@intel.com>
Subject: [PATCH 11/17] dmaengine: idxd: add descs_completed field for completion record
Date:   Tue,  3 Jan 2023 08:34:59 -0800
Message-Id: <20230103163505.1569356-12-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230103163505.1569356-1-fenghua.yu@intel.com>
References: <20230103163505.1569356-1-fenghua.yu@intel.com>
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

From: Dave Jiang <dave.jiang@intel.com>

The descs_completed field for a completion record is part of a batch
descriptor completion record. It takes the same location as bytes_completed
in a normal descriptor field. Add to expose to user.

Tested-by: Tony Zhu <tony.zhu@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 include/uapi/linux/idxd.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 685440a2c4bc..37732016f3b0 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -289,7 +289,10 @@ struct dsa_completion_record {
 	};
 	uint8_t			fault_info;
 	uint8_t			rsvd;
-	uint32_t		bytes_completed;
+	union {
+		uint32_t		bytes_completed;
+		uint32_t		descs_completed;
+	};
 	uint64_t		fault_addr;
 	union {
 		/* common record */
-- 
2.32.0

