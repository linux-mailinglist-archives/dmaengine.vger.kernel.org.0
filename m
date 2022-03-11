Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F894D6A75
	for <lists+dmaengine@lfdr.de>; Sat, 12 Mar 2022 00:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbiCKXY2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 11 Mar 2022 18:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiCKXY1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 11 Mar 2022 18:24:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26488189A3A
        for <dmaengine@vger.kernel.org>; Fri, 11 Mar 2022 15:23:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647041003; x=1678577003;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5BuYDwizltiO/EyGjgyvWpjYXVVp4EjmDwQew3JSFLU=;
  b=J6H6Mx7lXgJZsNtjx2uowgyKICJgDPe6p0MprP12fKBtGHYQihFHT2de
   xiqNREqwKPmYWZdEpTd23ImnjLk1F2M4FySevnzmLYre37F+s3OHBNmnn
   MDMNVVGKparsv0cx47Nd45sPzHdQ+HATUEK/63FpY+mB6Jcktk6L5vnpB
   WRfOrstMmeyxTDuCAFcS9yUdO8zahbkbDHG53qQWZYmjyTTL05OaVdv5n
   nQ6QymEFRVOI7KZg6QPagMpuRtJOrRoDMoE8f6zXMcSrdTF1XhoL7XATV
   wDSWmGs2UON2qDNLTsVVxZRX4MwqfBY/DknUjXIZfpCbGWFKq5+kjE4RZ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="318894547"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="318894547"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:23:22 -0800
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="539176388"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 15:23:22 -0800
Subject: [PATCH] dmaengine: idxd: update IAA definitions for user header
From:   Dave Jiang <dave.jiang@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, tom.zanussi@linux.intel.com
Date:   Fri, 11 Mar 2022 16:23:22 -0700
Message-ID: <164704100212.1373038.18362680016033557757.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add additional structure definitions for Intel In-memory Analytics
Accelerator (IAA/IAX). See specification (1) for more details.

1: https://cdrdv2.intel.com/v1/dl/getContent/721858

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/uapi/linux/idxd.h |   31 ++++++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index a8f0ff75c430..bce7c43657d5 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -53,6 +53,11 @@ enum idxd_scmd_stat {
 
 /* IAX */
 #define IDXD_OP_FLAG_RD_SRC2_AECS	0x010000
+#define IDXD_OP_FLAG_RD_SRC2_2ND	0x020000
+#define IDXD_OP_FLAG_WR_SRC2_AECS_COMP	0x040000
+#define IDXD_OP_FLAG_WR_SRC2_AECS_OVFL	0x080000
+#define IDXD_OP_FLAG_SRC2_STS		0x100000
+#define IDXD_OP_FLAG_CRC_RFC3720	0x200000
 
 /* Opcode */
 enum dsa_opcode {
@@ -81,6 +86,18 @@ enum iax_opcode {
 	IAX_OPCODE_MEMMOVE,
 	IAX_OPCODE_DECOMPRESS = 0x42,
 	IAX_OPCODE_COMPRESS,
+	IAX_OPCODE_CRC64,
+	IAX_OPCODE_ZERO_DECOMP_32 = 0x48,
+	IAX_OPCODE_ZERO_DECOMP_16,
+	IAX_OPCODE_DECOMP_32 = 0x4c,
+	IAX_OPCODE_DECOMP_16,
+	IAX_OPCODE_SCAN = 0x50,
+	IAX_OPCODE_SET_MEMBER,
+	IAX_OPCODE_EXTRACT,
+	IAX_OPCODE_SELECT,
+	IAX_OPCODE_RLE_BURST,
+	IAX_OPCDE_FIND_UNIQUE,
+	IAX_OPCODE_EXPAND,
 };
 
 /* Completion record status */
@@ -120,6 +137,7 @@ enum iax_completion_status {
 	IAX_COMP_NONE = 0,
 	IAX_COMP_SUCCESS,
 	IAX_COMP_PAGE_FAULT_IR = 0x04,
+	IAX_COMP_ANALYTICS_ERROR = 0x0a,
 	IAX_COMP_OUTBUF_OVERFLOW,
 	IAX_COMP_BAD_OPCODE = 0x10,
 	IAX_COMP_INVALID_FLAGS,
@@ -140,7 +158,10 @@ enum iax_completion_status {
 	IAX_COMP_WATCHDOG,
 	IAX_COMP_INVALID_COMP_FLAG = 0x30,
 	IAX_COMP_INVALID_FILTER_FLAG,
-	IAX_COMP_INVALID_NUM_ELEMS = 0x33,
+	IAX_COMP_INVALID_INPUT_SIZE,
+	IAX_COMP_INVALID_NUM_ELEMS,
+	IAX_COMP_INVALID_SRC1_WIDTH,
+	IAX_COMP_INVALID_INVERT_OUT,
 };
 
 #define DSA_COMP_STATUS_MASK		0x7f
@@ -319,8 +340,12 @@ struct iax_completion_record {
 	uint32_t                output_size;
 	uint8_t                 output_bits;
 	uint8_t                 rsvd3;
-	uint16_t                rsvd4;
-	uint64_t                rsvd5[4];
+	uint16_t                xor_csum;
+	uint32_t                crc;
+	uint32_t                min;
+	uint32_t                max;
+	uint32_t                sum;
+	uint64_t                rsvd4[2];
 } __attribute__((packed));
 
 struct iax_raw_completion_record {


