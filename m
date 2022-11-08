Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02406204BD
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 01:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233064AbiKHAjy (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 19:39:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233035AbiKHAjx (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 19:39:53 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB56713F9B;
        Mon,  7 Nov 2022 16:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667867992; x=1699403992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t1uyAqwWGXeZJUcrnlaYpAGlOx/Hw9U2FxLGaHAypWw=;
  b=RX8Il+PBao4YtLS6+/FKZvboYM74UGCa0P1lWu5zOeLzNMsSTaGeC+ty
   747vajoqW9iLe0vvgPd1jJ4Lopa0P3LKJO0W94oM6kEs5MYVczsIkG/Kc
   qhIJV5DRE8uRCH4Gyx3ryJ2qdXTkxAzDOn045VS8TH3Y5r5Cp37sIywXm
   nGn7EGccNVSKkaBsEUo8/Mz77AMdDE9+K5amQ1ZlphtVCtHUz1ztgoNiV
   zDgBvgBjB6aSmiqIDYQxF4mekjp2JXS1VHEJhtqYnujQNQ2cbf/bLsyZG
   Q+GhaopjKIJNzr/LXyunLYt6vtthTPTgsdzKHdFQ/yYmYKaqQSnIetiLc
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374833337"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374833337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 16:39:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811041357"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811041357"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2022 16:39:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 3/3] dmaengine: idxd: Add descriptor definitions for translation fetch operation
Date:   Mon,  7 Nov 2022 16:39:44 -0800
Message-Id: <20221108003944.2095567-4-fenghua.yu@intel.com>
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

The translation fetch operation (0x0A) fetches address translations for the
address range specified in the decriptor by issuing address translation
(ATS) requests to the IOMMU.

Add descriptor definitions for the operation so that user can use DSA
to accelerate translation fetch.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 include/uapi/linux/idxd.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 34294d99c1cb..9de48c561452 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -71,6 +71,7 @@ enum dsa_opcode {
 	DSA_OPCODE_CR_DELTA,
 	DSA_OPCODE_AP_DELTA,
 	DSA_OPCODE_DUALCAST,
+	DSA_OPCODE_TRANSL_FETCH,
 	DSA_OPCODE_CRCGEN = 0x10,
 	DSA_OPCODE_COPY_CRC,
 	DSA_OPCODE_DIF_CHECK,
@@ -181,6 +182,7 @@ struct dsa_hw_desc {
 		uint64_t	pattern;
 		uint64_t	desc_list_addr;
 		uint64_t	pattern_lower;
+		uint64_t	transl_fetch_addr;
 	};
 	union {
 		uint64_t	dst_addr;
@@ -191,6 +193,7 @@ struct dsa_hw_desc {
 	union {
 		uint32_t	xfer_size;
 		uint32_t	desc_count;
+		uint32_t	region_size;
 	};
 	uint16_t	int_handle;
 	uint16_t	rsvd1;
@@ -250,6 +253,12 @@ struct dsa_hw_desc {
 			uint64_t	pattern_upper;
 		};
 
+		/* Translation fetch */
+		struct {
+			uint64_t	transl_fetch_res;
+			uint32_t	region_stride;
+		};
+
 		/* DIX generate */
 		struct {
 			uint8_t		dix_gen_res;
-- 
2.32.0

