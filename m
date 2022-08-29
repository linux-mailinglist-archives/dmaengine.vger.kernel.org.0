Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C745F5A559F
	for <lists+dmaengine@lfdr.de>; Mon, 29 Aug 2022 22:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbiH2Ufp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Aug 2022 16:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiH2Ufp (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Aug 2022 16:35:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5158673E;
        Mon, 29 Aug 2022 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661805343; x=1693341343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u78vf3+yw8iuvykX95lam1SmkodjWhgRBHj574HntNg=;
  b=AeHTVBf9+0ifTacC09BJe0NpmFdoV9o3+MN8Nle/LZuPBbTw4tanTdjN
   xzmrD4BYpw8ofgL0vFUhQJ7eF/kEr7GKyYQxnGjymGdzkb/IG2pZwBA/+
   NpUT9ruYF7geQBmWStbaVRQOmI0mo01P2BqJjHKwUU+dGi42+4o+Ytc3a
   pTGmCXH8Q/XfBkgRuDSFrHHzO38uewiLz+5ANfdJq1IZNwC4jq2+7TTEA
   UkMQvLuR2AnpH38A78QX8bCXUqnZ0NUTRlIsjIw7kVgh4T0LW2QFHFZ+v
   XLcMOphwjnIGsqu771O/Ch6/BQkHIvm80/HsCcCbKeimSGpzMIZl7LlA2
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="381291959"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="381291959"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 13:35:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="614344238"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga007.fm.intel.com with ESMTP; 29 Aug 2022 13:35:43 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/7] dmaengine: Support polling for out of order completions
Date:   Mon, 29 Aug 2022 13:35:30 -0700
Message-Id: <20220829203537.30676-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220622193753.3044206-1-benjamin.walker@intel.com>
References: <20220622193753.3044206-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series adds support for polling async transactions for completion
even if interrupts are disabled and transactions can complete out of
order.

Prior to this series, dma_cookie_t was a monotonically increasing integer and
cookies could be compared to one another to determine if earlier operations had
completed (up until the cookie wraps around, then it would break). Now, cookies
are treated as opaque handles. The series also does some API clean up and
documents how dma_cookie_t should behave.

This closes out by adding support for .device_tx_status() to the idxd
driver and then reverting the DMA_OUT_OF_ORDER patch that previously
allowed idxd to opt-out of support for polling, which I think is a nice
overall simplification to the dmaengine API.

Changes since version 4:
 - Rebased
 - Removed updates to the various drivers that call dma_async_is_tx_complete.
   These clean ups will be spun off into a separate patch series since they need
   acks from other maintainers.

Changes since version 3:
 - Fixed Message-Id in emails. Sorry they were all stripped! Won't
   happen again.

Changes since version 2:
 - None. Rebased as requested without conflict.

Changes since version 1:
 - Broke up the change to remove dma_async_is_tx_complete into a single
   patch for each driver
 - Renamed dma_async_is_tx_complete to dmaengine_async_is_tx_complete.

Ben Walker (7):
  dmaengine: Remove dma_async_is_complete from client API
  dmaengine: Move dma_set_tx_state to the provider API header
  dmaengine: Add dmaengine_async_is_tx_complete
  dmaengine: Add provider documentation on cookie assignment
  dmaengine: idxd: idxd_desc.id is now a u16
  dmaengine: idxd: Support device_tx_status
  dmaengine: Revert "cookie bypass for out of order completion"

 Documentation/driver-api/dmaengine/client.rst | 24 ++----
 .../driver-api/dmaengine/provider.rst         | 64 ++++++++------
 drivers/dma/dmaengine.c                       |  2 +-
 drivers/dma/dmaengine.h                       | 21 ++++-
 drivers/dma/dmatest.c                         | 14 +--
 drivers/dma/idxd/device.c                     |  1 +
 drivers/dma/idxd/dma.c                        | 86 ++++++++++++++++++-
 drivers/dma/idxd/idxd.h                       |  3 +-
 include/linux/dmaengine.h                     | 43 +++-------
 9 files changed, 164 insertions(+), 94 deletions(-)

-- 
2.37.1

