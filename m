Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2899A5BB945
	for <lists+dmaengine@lfdr.de>; Sat, 17 Sep 2022 18:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIQQNS (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 17 Sep 2022 12:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQQNR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 17 Sep 2022 12:13:17 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0277D2ED7B;
        Sat, 17 Sep 2022 09:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663431195; x=1694967195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pVY+VePgjT1nYybsi5804DjB/AyRwQq4Jjc22Vd2rDU=;
  b=ZXbapwWpUwg+jl6KkkSQZPAXDI9b018mCzG7nTIcWar65zGBAJuP2Sxb
   fKXH1IBEaEwQA7dvWZ8SIqFgy+U7AByX4rSqBU3R72vOZHnjexQ3+Fhgl
   foRTMvpsdh7quoAQ2ddJa1jhx1oGgWg6HRbO3StjxlmT/jw6TIw3NVZxA
   wlJgQiimKzbbWlUmdnddWYOvQHXDdMdw8TheUdYUkSxn5/zptMT2u4LU9
   +4MxzC0fP4QmD2O+T7fuNk9wpEMCaHsUGUt9f56wISlaUXQhNLItyDQSf
   jgzfk1wGfwHrpbRrmbfIkP2yYhNgYTmyKdvI1DnsuB1o9PxdlQvY00ntP
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10473"; a="286206510"
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="286206510"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2022 09:13:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,323,1654585200"; 
   d="scan'208";a="686472595"
Received: from fyu1.sc.intel.com ([172.25.103.126])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2022 09:13:14 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Vinod Koul" <vkoul@kernel.org>,
        "Dave Jiang" <dave.jiang@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        dmaengine@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH 0/5] Enable a few DSA 2.0 features
Date:   Sat, 17 Sep 2022 09:12:17 -0700
Message-Id: <20220917161222.2835172-1-fenghua.yu@intel.com>
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

Data Streaming Accelerator (DSA) 2.0 [1] introduces a few new features.
This series enables the new features:

- Work Queue (WQ) operation cap restriction: patch 3 with patch 1 and 2
  as preparation.
- Configuration for concurrent work descriptor: patch 4.
- Configuration for concurrent batch descriptor: patch 5.

Reference:
1. https://software.intel.com/content/www/us/en/develop/articles/intel-data-streaming-accelerator-architecture-specification.html

Dave Jiang (5):
  dmaengine: idxd: convert ats_dis to a wq flag
  dmanegine: idxd: reformat opcap output to match bitmap_parse() input
  dmaengine: idxd: add WQ operation cap restriction support
  dmaengine: idxd: add configuration for concurrent work descriptor
    processing
  dmaengine: idxd: add configuration for concurrent batch descriptor
    processing

 .../ABI/stable/sysfs-driver-dma-idxd          |  35 ++++
 drivers/dma/idxd/device.c                     |  34 +++-
 drivers/dma/idxd/idxd.h                       |   8 +-
 drivers/dma/idxd/init.c                       |  30 +++
 drivers/dma/idxd/registers.h                  |  35 ++--
 drivers/dma/idxd/sysfs.c                      | 186 +++++++++++++++++-
 6 files changed, 298 insertions(+), 30 deletions(-)

-- 
2.32.0

