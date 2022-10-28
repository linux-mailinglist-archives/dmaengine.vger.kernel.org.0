Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3AC611BBD
	for <lists+dmaengine@lfdr.de>; Fri, 28 Oct 2022 22:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ1UsT (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Oct 2022 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJ1UsS (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Oct 2022 16:48:18 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915B523AB5E;
        Fri, 28 Oct 2022 13:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666990097; x=1698526097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0VvBMb8HOrsGjv14X6zMqZCqDSjuN88qxERiFzhxSKo=;
  b=N7B7aJFcAPyL7TuG6cv/ofCD3UwOe5mSEx7x+Pexk6DiNhSkwHMHkBg7
   IS9hzjZY9AUtoXTxN80ScLQsh+EpoDbTF8B7vP+hLKIzu2GPSYdeYtEql
   GXRC9WS4hljrg5n7ei0CZYA5ktZLjB49bbSsmGBFTL8X8AZZac/aqt+q/
   Vwz4tVSfnDQ6wBWzWLT9lfMxFiIxQ6IO1/Qp92VN400tIV8TXM1cwsQgS
   yi1KugWU/+/qlLGxM7ZCPgA6SUiqo/o/RPdyljY2E8ayrQVMUguTkGtZF
   b86OFJTiEOILr1g0BkCRuJxuSFbtRGCe0KAT4u05Oor+m8sP2vb9Vqlg0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="291885085"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="291885085"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2022 13:48:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10514"; a="962159787"
X-IronPort-AV: E=Sophos;i="5.95,222,1661842800"; 
   d="scan'208";a="962159787"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by fmsmga005.fm.intel.com with ESMTP; 28 Oct 2022 13:48:16 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/7] dmaengine: Support polling for out of order completions
Date:   Fri, 28 Oct 2022 13:48:05 -0700
Message-Id: <20221028204812.1772736-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220829203537.30676-1-benjamin.walker@intel.com>
References: <20220829203537.30676-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Changes since version 5:
 - Rebased to 6.1
 - Renamed dmaengine_async_is_tx_complete to dmaengine_is_tx_complete
 - Fixed stray blank line above idxd_dma_tx_status
 - Added Reviewed-by from Dave Jiang

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

