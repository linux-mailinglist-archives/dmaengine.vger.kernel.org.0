Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F8A6AA147
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjCCVe0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231808AbjCCVeY (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:34:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD8C1A485;
        Fri,  3 Mar 2023 13:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879263; x=1709415263;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yD3JIRnWO3O5QD2FW9PbHdj50CTjoVy/ibSII+27rM0=;
  b=AU/FbYYhH2mrcPY6INgLkUyDiKAMhClRfiuthwSH6LCU45Ll07NLm/fQ
   26uY+UX+nHP6OnZtPH2PlaZYpMuEaO3KX80rgH0QYRQ1KNSkYn51dUwN2
   hsi4xDPhaQpLiuY3ybqjx03v8l7VFPJGXg6FsM336cZXlSR4m5aImdr+s
   GsB8dROS7URRvGoWN2hKIqPtNJvxHx8Z9nFSULTmakaWd6AEoWgjOrTN7
   IYzCszvfv3Ol6gJ74kxmf2LB59QDECnL0Mxv1evHCLfx8u7Ma8WKPo+Vl
   eaWBFzXFR5xMRD5pbvyXyRucwxkiMXA2DH0CH+gPBJUzfNO8ktDyi7CTJ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399976472"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="399976472"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:34:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="675508706"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="675508706"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2023 13:34:20 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 3/3] dmaengine: idxd: Add descriptor definitions for translation fetch operation
Date:   Fri,  3 Mar 2023 13:34:13 -0800
Message-Id: <20230303213413.3357431-4-fenghua.yu@intel.com>
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

The translation fetch operation (0x0A) fetches address translations for the
address range specified in the descriptor by issuing address translation
(ATS) requests to the IOMMU.

Add descriptor definitions for the operation so that user can use DSA
to accelerate translation fetch.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 include/uapi/linux/idxd.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 4c12e93a6aa6..fc47635b57dc 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -72,6 +72,7 @@ enum dsa_opcode {
 	DSA_OPCODE_CR_DELTA,
 	DSA_OPCODE_AP_DELTA,
 	DSA_OPCODE_DUALCAST,
+	DSA_OPCODE_TRANSL_FETCH,
 	DSA_OPCODE_CRCGEN = 0x10,
 	DSA_OPCODE_COPY_CRC,
 	DSA_OPCODE_DIF_CHECK,
@@ -182,6 +183,7 @@ struct dsa_hw_desc {
 		uint64_t	pattern;
 		uint64_t	desc_list_addr;
 		uint64_t	pattern_lower;
+		uint64_t	transl_fetch_addr;
 	};
 	union {
 		uint64_t	dst_addr;
@@ -192,6 +194,7 @@ struct dsa_hw_desc {
 	union {
 		uint32_t	xfer_size;
 		uint32_t	desc_count;
+		uint32_t	region_size;
 	};
 	uint16_t	int_handle;
 	uint16_t	rsvd1;
@@ -249,6 +252,12 @@ struct dsa_hw_desc {
 		/* Fill */
 		uint64_t	pattern_upper;
 
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
2.37.1

