Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A455A6AA168
	for <lists+dmaengine@lfdr.de>; Fri,  3 Mar 2023 22:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjCCVhr (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 3 Mar 2023 16:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjCCVhq (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 3 Mar 2023 16:37:46 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAB162D9E;
        Fri,  3 Mar 2023 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677879465; x=1709415465;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VwG7ZZohEf0svVvNC9st5b7NqZLiJfhjCrP/gsGWpPY=;
  b=UO1g1Ngz9o6KNKvxfgIUC+52zvWDxiLm424KvHXFHKsGW7iO3hj8nUvo
   NeYx8e690bss9ObeaQiF2bbdHVuU8N4Ksm6EHzmLd9ey+16UloTjzEYX3
   vAJJbs13VX6lUPCrDXA2ZaXknfxEWClkG7c9M3bdA2pA7k/nESXwfNomG
   ssxlqDVNvewxIH8BdFZlIge4GxfVt8BW2hzB4xIDm1v0MYQw59HxSApU5
   1Wlj4SdxcwmOSV4jfSdktXQ6Cy6HWDOk7KbU9ZxXx3xnTuwmovWL+V3lB
   U8cT+FR0hLhHfCr2KhAMnE+7G+d74pVvR1p7TKXOztlA9pJfsg15Gvnrg
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="332643548"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="332643548"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 13:37:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="818650489"
X-IronPort-AV: E=Sophos;i="5.98,231,1673942400"; 
   d="scan'208";a="818650489"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga001.fm.intel.com with ESMTP; 03 Mar 2023 13:37:45 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 0/2] Expose IAA 2.0 device capabilities
Date:   Fri,  3 Mar 2023 13:37:30 -0800
Message-Id: <20230303213732.3357494-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.37.1
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

In-memory Analytics Accelerator (IAA) 2.0 [1] introduces General
Capabilities Register (GENCAP). Add a sysfs attribute to expose the
register to applications.

This series is applied cleanly on top of DSA 2.0 Event Log and Completion
Record Faulting series: 
https://lore.kernel.org/dmaengine/20230103163505.1569356-1-fenghua.yu@intel.com/T/#m13ba6167994f3add6446d2d7e242ecb637c54426

Change log:
v2:
- Fix a typo in commit message of patch 1 (Vinod)
- Rebased to 6.2. No functionality change.

v1:
https://lore.kernel.org/dmaengine/20230103165337.1570238-1-fenghua.yu@intel.com/

[1] IAA 2.0 spec: https://cdrdv2-public.intel.com/721858/350295-iaa-specification.pdf

Dave Jiang (2):
  dmaengine: idxd: reformat swerror output to standard Linux bitmap
    output
  dmaengine: idxd: expose IAA CAP register via sysfs knob

 .../ABI/stable/sysfs-driver-dma-idxd          |  8 +++++
 drivers/dma/idxd/idxd.h                       |  2 ++
 drivers/dma/idxd/init.c                       |  6 +++-
 drivers/dma/idxd/registers.h                  | 21 ++++++++++++
 drivers/dma/idxd/sysfs.c                      | 34 +++++++++++++++----
 5 files changed, 64 insertions(+), 7 deletions(-)

-- 
2.37.1

