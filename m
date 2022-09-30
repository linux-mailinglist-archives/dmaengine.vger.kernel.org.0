Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9291B5F125D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Sep 2022 21:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231759AbiI3T0y (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 30 Sep 2022 15:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiI3T0w (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 30 Sep 2022 15:26:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437A4BF1CE
        for <dmaengine@vger.kernel.org>; Fri, 30 Sep 2022 12:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664566012; x=1696102012;
  h=from:to:cc:subject:date:message-id;
  bh=o/rp4Bi/xO8K1t1qZzMsFeBAG381rCqfkmBep9o8tR8=;
  b=Timlz5MePuDRiN/KpNakOYa0HO/eMmFqmSKtq+Xk64ieVqrPd7QTPw0g
   Ypyshu4WzCztbWp9eSmj/DorUm/Mesw5muub+/6fih8RA0xBh9z0+oUs3
   CZXXDii+b2s6RxR5Td84nMY1tbPvquXIMJrcviSeduPs9uNmgQpJT3zrR
   HRi2ajKPxiyjn4qJg0qqw60bxo8cu0zzrT656OjC+vUQ2Et7iqEPp39Yp
   l7VEMoWWjn5WLzNGXDLtmsz+xXz8hMo7cmFR1V5JGKtxM1YWyQ9rYdA/H
   yWF/e6NT0csJ5JTmVBkwHP02b5PzpLrm8lMlWuB+XtxgseUzLaqgveb3N
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="364119838"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="364119838"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2022 12:26:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10486"; a="625099119"
X-IronPort-AV: E=Sophos;i="5.93,358,1654585200"; 
   d="scan'208";a="625099119"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by fmsmga007.fm.intel.com with ESMTP; 30 Sep 2022 12:26:49 -0700
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     vkoul@kernel.org, fenghua.yu@intel.com, dave.jiang@intel.com,
        dmaengine@vger.kernel.org
Cc:     ramesh.thomas@intel.com, tony.luck@intel.com, tony.zhu@intel.com,
        pei.p.jia@intel.com, xiaochen.shen@intel.com
Subject: [PATCH v2 0/2] dmaengine: idxd: Fix max batch size issues for Intel IAA
Date:   Sat,  1 Oct 2022 04:15:26 +0800
Message-Id: <20220930201528.18621-1-xiaochen.shen@intel.com>
X-Mailer: git-send-email 2.18.4
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix max batch size related issues for Intel IAA:
1. Fix max batch size default values.
2. Make max batch size attributes in sysfs invisible.

Changelog:
v2:
- Rebase on -next branch (Vinod).
- Use wrapper function idxd_{device|wq}_attr_max_batch_size_invisible()
  to make the code more readable.

Xiaochen Shen (2):
  dmaengine: idxd: Fix max batch size for Intel IAA
  dmaengine: idxd: Make max batch size attributes in sysfs invisible for
    Intel IAA

 .../ABI/stable/sysfs-driver-dma-idxd          |  2 ++
 drivers/dma/idxd/device.c                     |  6 ++--
 drivers/dma/idxd/idxd.h                       | 32 +++++++++++++++++
 drivers/dma/idxd/init.c                       |  4 +--
 drivers/dma/idxd/sysfs.c                      | 34 ++++++++++++++++++-
 5 files changed, 72 insertions(+), 6 deletions(-)

-- 
2.18.4

