Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 409696204BE
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 01:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbiKHAjy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 19:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbiKHAjx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 19:39:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8913F69;
        Mon,  7 Nov 2022 16:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667867992; x=1699403992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Cm9CtBgkoGZKBtJj3uuA4OFX4WUziYGRZEOrJwPTybs=;
  b=mGWrUtRzzm/rFPi10c8mAwwKnf0pUpFetNeXcPTXS7ua+qrOzcW2+8f9
   CcK8jtw18ow1XBqF30u9DKBUyQPJMsHd82aiWs7fUdzWEzBtqvCa5u3e7
   /o7ngxVjKyhrNs+vbkHw8KsJA7SUzzDvF87TcB4+WR8YsZJqLWRxE5W+L
   zUhEyO3IwNpAEvGlM7YUdqdXBxzluK6+zy0T3UMo4ckLGRAPzgRFz8i22
   /6HkqDoN2NYDeS0qwei/U5fuFmSwmEpba/YZCX90SUsUNPRpmEmnfRWiY
   OChtyY+2w2K1yJ0W49YO2xJHYKfV0RJMoDcktTIQNgoPPnBA0qcKVCYQq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374833336"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374833336"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 16:39:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811041354"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811041354"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2022 16:39:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 2/3] dmaengine: idxd: Add descriptor definitions for DIX generate operation
Date:   Mon,  7 Nov 2022 16:39:43 -0800
Message-Id: <20221108003944.2095567-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20221108003944.2095567-1-fenghua.yu@intel.com>
References: <20221108003944.2095567-1-fenghua.yu@intel.com>
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
index 04a2f6411820..34294d99c1cb 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -77,6 +77,7 @@ enum dsa_opcode {
 	DSA_OPCODE_DIF_INS,
 	DSA_OPCODE_DIF_STRP,
 	DSA_OPCODE_DIF_UPDT,
+	DSA_OPCODE_DIX_GEN = 0x17,
 	DSA_OPCODE_CFLUSH = 0x20,
 };
 
@@ -249,6 +250,17 @@ struct dsa_hw_desc {
 			uint64_t	pattern_upper;
 		};
 
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
@@ -327,6 +339,14 @@ struct dsa_completion_record {
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
2.32.0

