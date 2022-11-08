Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627696204BB
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 01:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbiKHAjx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 19:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiKHAjw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 19:39:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC2413F6F;
        Mon,  7 Nov 2022 16:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667867991; x=1699403991;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=p/aKgQPwXxZNULQAZONJmKS+Fb81oYGXbZJp0mJgn80=;
  b=iTZsEW51SlMoFbkLQjBuu/OIMmyZlT/VW77R1vyxp/sstt+uBfLfkxyt
   Io50VA/6VP0NlT1b00AIWzXs0Pd3wKY+O8LQnQ1A7/9Qxr6gj7Fcf7rX9
   njxGXk5mN2eNN//AzShJzXexX4dX7ONPNwmQCXUV8OatImINvBx9/UrsT
   YaqG+AutiJq3eufFT9vOdQ0r3Wu7KJBc+p3CnGMzyh8QThLeKaj9NsUo4
   zgPQ4OvqMoEs+4Wsh0wpKWy/jsUy53eQeJWnhWVISOBHL6bjoPotKU64O
   psoUuPWOf2NQhgjhYkp4LyO7DYgGfjmyB19u4Kw81SMhrUjnqWuafF+Mm
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374833334"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374833334"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 16:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811041351"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811041351"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2022 16:39:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 1/3] dmaengine: idxd: Add descriptor definitions for 16 bytes of pattern in memory fill operation
Date:   Mon,  7 Nov 2022 16:39:42 -0800
Message-Id: <20221108003944.2095567-2-fenghua.yu@intel.com>
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
 include/uapi/linux/idxd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index 095299c75828..04a2f6411820 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -179,6 +179,7 @@ struct dsa_hw_desc {
 		uint64_t	rdback_addr;
 		uint64_t	pattern;
 		uint64_t	desc_list_addr;
+		uint64_t	pattern_lower;
 	};
 	union {
 		uint64_t	dst_addr;
@@ -243,6 +244,11 @@ struct dsa_hw_desc {
 			uint16_t	dest_app_tag_seed;
 		};
 
+		/* Fill */
+		struct {
+			uint64_t	pattern_upper;
+		};
+
 		uint8_t		op_specific[24];
 	};
 } __attribute__((packed));
-- 
2.32.0

