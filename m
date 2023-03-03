Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A90E6AA145
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjCCVeZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbjCCVeX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:34:23 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAB211140;
        Fri,  3 Mar 2023 13:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879261; x=1709415261;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2RUBN/hdK7Y3M237lPTg27d9QJ3VCdg0r/JSZ5wz68Y=;
  b=cYXU9zYuEw0MKaC5MD9lmUR2jZM+h+FXTl9NUWzJ+olhdTW0N7QZCC7F
   QC+cmNLhdMAPtA0vyUwwvwHINyAIOgnmaRoUZ0QZ3Yuizx+sJY7vvfaHq
   pvK6BhUR2nm1ouifktFkV8u9Ea9+EloIbCqhSgs4cRhpTURVtEFLedACN
   JLx0B0o61IBR9r8rZBVy5chugx8DlyPblvbQG9rGsz3bGiUJxqOy2PBZH
   zSWkgxW3dUoPN8QLXMw6PhZ/ZDK+23/sEFo7adJ2Y+q9C79ZWzULyb/v3
   Y0blJc67GRKIwgdRaNNZumolY5FviGZWKi7DLQh0nWZMac3VYdDn8M4HU
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="399976467"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="399976467"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:34:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="675508698"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="675508698"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga002.jf.intel.com with ESMTP; 03 Mar 2023 13:34:19 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 1/3] dmaengine: idxd: Add descriptor definitions for 16 bytes of pattern in memory fill operation
Date:   Fri,  3 Mar 2023 13:34:11 -0800
Message-Id: <20230303213413.3357431-2-fenghua.yu@intel.com>
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

The memory fill operation (0x04) can fill in memory with either 8 bytes
or 16 bytes of pattern. To fill in memory with 16 bytes of pattern, the
first 8 bytes are provided in pattern lower in bytes 16-23 and the next
8 bytes are in pattern upper in bytes 40-47 in the descriptor. Currently
only 8 bytes of pattern is enabled.

Add descriptor definitions for pattern lower and pattern upper so that
user can use 16 bytes of pattern to fill memory.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Change anonymous struct to uint64_t for pattern_upper (Dave Jiang)

 include/uapi/linux/idxd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 1d553bedbdb5..c43d7df5fc15 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -180,6 +180,7 @@ struct dsa_hw_desc {
 		uint64_t	rdback_addr;
 		uint64_t	pattern;
 		uint64_t	desc_list_addr;
+		uint64_t	pattern_lower;
 	};
 	union {
 		uint64_t	dst_addr;
@@ -244,6 +245,9 @@ struct dsa_hw_desc {
 			uint16_t	dest_app_tag_seed;
 		};
 
+		/* Fill */
+		uint64_t	pattern_upper;
+
 		uint8_t		op_specific[24];
 	};
 } __attribute__((packed));
-- 
2.37.1

