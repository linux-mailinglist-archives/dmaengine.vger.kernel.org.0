Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34506B7ECD
	for <lists+dmaengine@lfdr.de>; Mon, 13 Mar 2023 18:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjCMRGe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Mar 2023 13:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjCMRGU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Mar 2023 13:06:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF207D08C;
        Mon, 13 Mar 2023 10:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678727131; x=1710263131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g/s7XMoaD0305pZc+v+dkPi6sAXzjOyWDTcLsZDgBP0=;
  b=LfZTG8vAr/gN4WOFkSr5S97iC2H5AYJfeFicf4I5QQybmpyRba7W+FPD
   Y21JJxCreE0QbjqrZGhTweG0Y0vbeLgGnYOzyuiiEOjMUzMrt0SDjtukM
   VNLExhHwG+5PpwXB/gEmjgibrkMnkQFm8ojgnXSsCItUhLH3Lo/iaQAFg
   ACySFoPsLC3NDIBIJMlVrQq/GBkH2c71luWUQhKyoqb5c9xUdcQ14SoD/
   wiThRzIPAHZpMd/4B+hpvIkFqUfN3kMlo6xPJrnf5L2OoLIV3AkrPs7TJ
   JsXrEE6YaDU0wtWY2UEyT5zcaHa5klGz27pnPTbLId5KGP0nuEpx1f0f2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="334679668"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="334679668"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2023 10:02:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10648"; a="708950929"
X-IronPort-AV: E=Sophos;i="5.98,257,1673942400"; 
   d="scan'208";a="708950929"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga008.jf.intel.com with ESMTP; 13 Mar 2023 10:02:41 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Tony Zhu <tony.zhu@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 10/16] dmaengine: idxd: add descs_completed field for completion record
Date:   Mon, 13 Mar 2023 10:02:13 -0700
Message-Id: <20230313170219.1956012-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230313170219.1956012-1-fenghua.yu@intel.com>
References: <20230313170219.1956012-1-fenghua.yu@intel.com>
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

