Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFEC6204BA
	for <lists+dmaengine@lfdr.de>; Tue,  8 Nov 2022 01:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiKHAjw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 7 Nov 2022 19:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiKHAjv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 7 Nov 2022 19:39:51 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18813F69;
        Mon,  7 Nov 2022 16:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667867991; x=1699403991;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/yQ7tI6As+AA4/4W6HOGm+hcqlGPbq4f0NJQU6ueOZs=;
  b=Htsyqtzs9H/L2GdT1NY6g/9Qa/0vfUfY++YLnYTZtre8cWh651PBAfzm
   DfI1gS740uMBYwJcvFlDzABmNeHwCgvacBiT4R95YKPiPt/lqUm8vd8Zh
   rgIeETP/APwvWFerAG5l8D29MOK6cSPMy2YF4D52O7HHmSx8coCCjQp4p
   mmCIWoB8qvVyD5wRm4FkRexU3R4h8/xdR2V+lyINbdWXCQj3D9sRgrnK3
   m6R61EyggwgdBjMN1hY0oyx+YLqjV0vuLmdRSHtvaifS4wRIjVUxe3IvK
   N5mcUCgD42Yc6Kgt7tQoYAw+wbrMMtr8ctRsG5jOtOFiLmMxu03CKOFic
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="374833333"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="374833333"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 16:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="811041347"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="811041347"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2022 16:39:50 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/3] Add descriptor definitions for a few new DSA operations
Date:   Mon,  7 Nov 2022 16:39:41 -0800
Message-Id: <20221108003944.2095567-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
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

A few new DSA operations are introduced [1]:
1. Memory fill with 16 bytes of pattern.
2. Translation fetch.
3. Data Integrity Extension (DIX) generate.

This series adds descriptor definitions for the new DSA operations.
With the definitions, user can issue the DSA operations to optimize
corresponding transactions.

Reference:
1. DSA 2.0 spec: https://software.intel.com/content/www/us/en/develop/articles/intel-data-streaming-accelerator-architecture-specification.html

Fenghua Yu (3):
  dmaengine: idxd: Add descriptor definitions for 16 bytes of pattern in
    memory fill operation
  dmaengine: idxd: Add descriptor definitions for DIX generate operation
  dmaengine: idxd: Add descriptor definitions for translation fetch
    operation

 include/uapi/linux/idxd.h | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

-- 
2.32.0

