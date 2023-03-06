Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB2B6AC87D
	for <lists+dmaengine@lfdr.de>; Mon,  6 Mar 2023 17:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCFQpz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 6 Mar 2023 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCFQoX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 6 Mar 2023 11:44:23 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72C046A3;
        Mon,  6 Mar 2023 08:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678121041; x=1709657041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/s7XMoaD0305pZc+v+dkPi6sAXzjOyWDTcLsZDgBP0=;
  b=XR3eX01GpdKJKbRdFmwg/64mBPA9PGUdu573tkfhqJUKqCGoRGaWzTPI
   kwP7bKQwRL8VDL8A39XlfbTMe+BHmjKtoY5PpVgrLrNiPHKxjkKOC0bem
   eOV/Joj0K5wDL2LJzCweHY1AaKKt2zgvGPWbuOLjiUDsKrkYFch4jqZCn
   wFjmwIsVr8MIhJTdN/alQ/RmtDXEVzMWBq6WjO/CzylUjPVkEUNTFPW7M
   ShkYvmFb+Npi8ryPyB6aNRRVE1usLi8AcjHPwi73w3lwTawrqaQafI6i9
   Fosus+p3yz59H6829ATbfTTdHF2O9jBYMXVY+fvscwM/SBJEIAtCSQJIV
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="398181175"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="398181175"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 08:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10641"; a="669504538"
X-IronPort-AV: E=Sophos;i="5.98,238,1673942400"; 
   d="scan'208";a="669504538"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Mar 2023 08:31:58 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 10/16] dmaengine: idxd: add descs_completed field for completion record
Date:   Mon,  6 Mar 2023 08:31:32 -0800
Message-Id: <20230306163138.587484-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230306163138.587484-1-fenghua.yu@intel.com>
References: <20230306163138.587484-1-fenghua.yu@intel.com>
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
index 4b584d5afd87..76ad71bf751e 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -314,7 +314,10 @@ struct dsa_completion_record {
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

