Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C136AA144
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231812AbjCCVeY (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:34:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbjCCVeX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:34:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D83471027A;
        Fri,  3 Mar 2023 13:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879261; x=1709415261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UJz0pCiqK7oMKPy2pp6vBg4X2Osf4pLe4Lvm2wE5zaA=;
  b=J7pP2euV83o+8BV2QpNzhbRLhOUGLdRZDgyWFZfVwfBKbySHAbnSVDYZ
   FWozGu08KrvdK3TPxHx/0v7Aj1IqS9itYC36B2kFs/f0H5ppWa7JCFKTk
   7GIGcDXqD+t106fd3ytNm7F/LZKF+aO5wSNKygAxodJ72cF05jqVx3U9o
   9r8guOy12CvFjXwiU4Zj0s+9gcWsUMNBzDOrjAkr5NOovzpWhiTwCuOoD
   M+xzTrG9HFNg998N6l89sFp9h7MCHKoA+TIjfOlLVOyKVuAe36pooIgjm
   QBM9qtp0CQFuNzc9SICNsrEWJOsFaZ4xxMzCBTipQlYjBdhXwmyvlELxF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399976469"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="399976469"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="675508701"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="675508701"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2023 13:34:19 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 2/3] dmaengine: idxd: Add descriptor definitions for DIX generate operation
Date:   Fri,  3 Mar 2023 13:34:12 -0800
Message-Id: <20230303213413.3357431-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230303213413.3357431-1-fenghua.yu@intel.com>
References: <20230303213413.3357431-1-fenghua.yu@intel.com>
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

The Data Integrity Extension (DIX) generate operation (0x17) computes
the Data Integrity Field (DIF) on the source data and writes only the
computed DIF for each source block to the PI destination address.

Add descriptor definitions for this operation so that user can use
DSA to accelerate DIX generate operation.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 include/uapi/linux/idxd.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index c43d7df5fc15..4c12e93a6aa6 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -78,6 +78,7 @@ enum dsa_opcode {
 	DSA_OPCODE_DIF_INS,
 	DSA_OPCODE_DIF_STRP,
 	DSA_OPCODE_DIF_UPDT,
+	DSA_OPCODE_DIX_GEN = 0x17,
 	DSA_OPCODE_CFLUSH = 0x20,
 };
 
@@ -248,6 +249,17 @@ struct dsa_hw_desc {
 		/* Fill */
 		uint64_t	pattern_upper;
 
+		/* DIX generate */
+		struct {
+			uint8_t		dix_gen_res;
+			uint8_t		dest_dif_flags;
+			uint8_t		dif_flags;
+			uint8_t		dix_gen_res2[13];
+			uint32_t	ref_tag_seed;
+			uint16_t	app_tag_mask;
+			uint16_t	app_tag_seed;
+		};
+
 		uint8_t		op_specific[24];
 	};
 } __attribute__((packed));
@@ -326,6 +338,14 @@ struct dsa_completion_record {
 			uint16_t	dif_upd_dest_app_tag;
 		};
 
+		/* DIX generate */
+		struct {
+			uint64_t	dix_gen_res;
+			uint32_t	dix_ref_tag;
+			uint16_t	dix_app_tag_mask;
+			uint16_t	dix_app_tag;
+		};
+
 		uint8_t		op_specific[16];
 	};
 } __attribute__((packed));
-- 
2.37.1

