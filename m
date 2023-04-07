Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09286DB542
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 22:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbjDGUbh (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 7 Apr 2023 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbjDGUbc (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 7 Apr 2023 16:31:32 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E11C66A;
        Fri,  7 Apr 2023 13:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680899490; x=1712435490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jp/PybrMffAfow6ihMX7Hz9cmducw1hINqAcylgIBU8=;
  b=Kx+s9fer8PkqFkBSqmf5EDmIt4OQlJxZaklkejFALP+eI3BG6TCuueAb
   p3s8dQZKv49FTpFvv3pg5wRM+T79NQOhKLYcCUdMM+OrynDzzaipJkIgS
   cS4fWlOY384ixGmeRNNuisGlRNC58G4yO6PlHUmDslTGS7l7bDbBrmCp6
   ScCSa+3ZNXTzL3W/3fDpLxJ5PW/5dr6ozOTd4Eb2/UHSWAS4fFdfs0twf
   /HM9FV4vGhfXXHasn2xq0yBTTROO8kqe3pN/uxXiMlgSY8CHvTJMH8CZj
   XvLyvTFJZhNcxZGId/RmAruE82rUC2CUnBva8Ul0iEH4uj5sZpCysWtP5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="408196871"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="408196871"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2023 13:31:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10673"; a="681125891"
X-IronPort-AV: E=Sophos;i="5.98,327,1673942400"; 
   d="scan'208";a="681125891"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 07 Apr 2023 13:31:27 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v4 10/16] dmaengine: idxd: add descs_completed field for completion record
Date:   Fri,  7 Apr 2023 13:31:37 -0700
Message-Id: <20230407203143.2189681-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230407203143.2189681-1-fenghua.yu@intel.com>
References: <20230407203143.2189681-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
2.37.1

