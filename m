Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0BB65C44B
	for <lists+dmaengine@lfdr.de>; Tue,  3 Jan 2023 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjACQyC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 Jan 2023 11:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbjACQxw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 Jan 2023 11:53:52 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0683F60EE;
        Tue,  3 Jan 2023 08:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672764832; x=1704300832;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SxqXzYZpbeusJES64OyVpTrkW6/cjaXs8lHH5sD87EI=;
  b=EDmBXF6oCkfagQel6P1ZQqkGwonDKZvDDktrCfIz0Vii7sizTX/G5Rdd
   5sV529J+6gd2KFvJEdv6VBptcuBKX/mNdrGo3NE4Ig8Kl/Hu9NdvLpRk4
   OkhZeersyx05VDnshEHWYxj01m5KUu2RObphm2NoGCBtcYQf2Pwb7sbqf
   Ckl3y8CF6hsJgUpL2V8Bh5qP4LnGy1ciTz4SXfDKYJn6IAzjr/MQpRnHx
   xCL6cIWJ3mzR0Kgc/4BTU8x3zIQVx2T5AvuI0nmabfLPc57GQ0ZWzkq0c
   ArfEN9UENVuSG7OV7EpRW0YKezY8aJqNVn2/bovQUdczVT0fvL1NrJWHt
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="322932864"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="322932864"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2023 08:53:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10579"; a="828896807"
X-IronPort-AV: E=Sophos;i="5.96,297,1665471600"; 
   d="scan'208";a="828896807"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by orsmga005.jf.intel.com with ESMTP; 03 Jan 2023 08:53:51 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "Fenghua Yu" <fenghua.yu@intel.com>, dmaengine@vger.kernel.org,
        "linux-kernel" <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Expose IAA 2.0 device capabilities
Date:   Tue,  3 Jan 2023 08:53:35 -0800
Message-Id: <20230103165337.1570238-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
2.32.0

