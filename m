Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C495696D7
	for <lists+dmaengine@lfdr.de>; Thu,  7 Jul 2022 02:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiGGAVH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 6 Jul 2022 20:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiGGAVF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 6 Jul 2022 20:21:05 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832882DA9B;
        Wed,  6 Jul 2022 17:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657153263; x=1688689263;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=n2hBIUYpeufe02FvmaKIU+Y+/Mnkwvn+I8Si5FEbDeQ=;
  b=Ecg+Lb3DHfvo24tF6GYUVnlQRnzI0gxaJWMlCwyo8t/45+wjMvSLAihG
   HDjy8obOtW4wB5N3LJcO70As8sVJ4VuwAjye7PXkZOl2syQtI06dwPCJ+
   gvIXCK00OyM1T75Q3K4bx3yjJmZupgZO4UyqaeCKRw4CDlGgNLSKjUKGp
   lnnAyiPNseVU5gmnUYDKUeAoDbZuPJJrzDnenhxDlN05jG4WjBH+cGa2H
   oKPmWhXkg0fw+VNrZ1wuM/svI4siozP7dr+2GLNRF69t1+6ouN7qkdreY
   6Uqqp7TqZJssd0Cwh/0gNSoMq2HNkxfpQEatrvQypqxMoYm6fn5qEq/tq
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="345585512"
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="345585512"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 17:21:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,251,1650956400"; 
   d="scan'208";a="591008400"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga007.jf.intel.com with ESMTP; 06 Jul 2022 17:21:01 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Tony Zhu" <tony.zhu@intel.com>, dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Li Zhang <li4.zhang@intel.com>
Subject: [PATCH] dmaengine: idxd: Correct IAX operation code names
Date:   Wed,  6 Jul 2022 17:20:52 -0700
Message-Id: <20220707002052.1546361-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Some IAX operation code nomenclatures are misleading or don't match with
others:

1. Operation code 0x4c is Zero Compress 32. IAX_OPCODE_DECOMP_32 is a
   misleading name. Change it to IAX_OPCODE_ZERO_COMP_32.
2. Operation code 0x4d is Zero Compress 16. IAX_OPCODE_DECOMP_16 is a
   misleading name. Change it to IAX_OPCODE_ZERO_COMP_16.
3. IAX_OPCDE_FIND_UNIQUE is corrected to match with other nomenclatures.

Co-developed-by: Li Zhang <li4.zhang@intel.com>
Signed-off-by: Li Zhang <li4.zhang@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
---
 include/uapi/linux/idxd.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/idxd.h b/include/uapi/linux/idxd.h
index bce7c43657d5..095299c75828 100644
--- a/include/uapi/linux/idxd.h
+++ b/include/uapi/linux/idxd.h
@@ -89,14 +89,14 @@ enum iax_opcode {
 	IAX_OPCODE_CRC64,
 	IAX_OPCODE_ZERO_DECOMP_32 = 0x48,
 	IAX_OPCODE_ZERO_DECOMP_16,
-	IAX_OPCODE_DECOMP_32 = 0x4c,
-	IAX_OPCODE_DECOMP_16,
+	IAX_OPCODE_ZERO_COMP_32 = 0x4c,
+	IAX_OPCODE_ZERO_COMP_16,
 	IAX_OPCODE_SCAN = 0x50,
 	IAX_OPCODE_SET_MEMBER,
 	IAX_OPCODE_EXTRACT,
 	IAX_OPCODE_SELECT,
 	IAX_OPCODE_RLE_BURST,
-	IAX_OPCDE_FIND_UNIQUE,
+	IAX_OPCODE_FIND_UNIQUE,
 	IAX_OPCODE_EXPAND,
 };
 
-- 
2.32.0

