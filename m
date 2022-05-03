Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6026D518DFA
	for <lists+dmaengine@lfdr.de>; Tue,  3 May 2022 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242169AbiECULq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 3 May 2022 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242194AbiECUL1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 3 May 2022 16:11:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE53F4092A
        for <dmaengine@vger.kernel.org>; Tue,  3 May 2022 13:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651608463; x=1683144463;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=roFqZ8ZZr9nrYmSbhQEHKBe93l5C5XbenBNf0waADSs=;
  b=CdFgb4Gkhz4U7z6KFcin85/suqS29rUc2bXyQPjjmN+S7C0pEUqfoJYz
   Fn8crzE5K0bhGhpOOObwUkg+NkKwI76hXLDgAxUKPDckew7Hqi0CZHoWV
   t16qP8f5Bfh/sSc2fUwDzyj+ayK1rCMle85T70bFHbLxm4w/EeM7iqoFT
   9TjsGqKRXm62UqLzguZ2wftZJd8JH+igd2cfmcymA9azNpC9bSuYyWCRa
   VXqaZJLbZ4ZwL2ACt93goEExfu/l0rljXEwJ4TNU6dNgy9qMFfQdgqLf5
   oyeohRPUUOinMXkERWDNaE3DXSJLwprb0sWjt71eubYwXdZmbkcWZypKA
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="249556066"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="249556066"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 13:07:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="516705085"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga003.jf.intel.com with ESMTP; 03 May 2022 13:07:43 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, mchehab@kernel.org,
        mporter@kernel.crashing.org, alex.bou9@gmail.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [PATCH v2 00/15] dmaengine: Support polling for out of order completions
Date:   Tue,  3 May 2022 13:07:13 -0700
Message-Id: <20220503200728.2321188-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series adds support for polling async transactions for completion
even if interrupts are disabled and trasactions can complete out of
order.

To do this, all DMA client assumptions about the behavior of
dma_cookie_t have to be removed. Prior to this series, dma_cookie_t was
a monotonically increasing integer and cookies could be compared to one
another to determine if earlier operations had completed (up until the
cookie wraps around, then it would break).

Fortunately, only one out of the many, many DMA clients had any
dependency on dma_cookie_t being anything more than an opaque handle.
This is the pxa_camera driver and it is dealt with in patch 7 of this
series.

The series also does some API clean up and documents how dma_cookie_t
should behave (i.e. there are no rules, it's just a handle).

This closes out by adding support for .device_tx_status() to the idxd
driver and then reverting the DMA_OUT_OF_ORDER patch that previously
allowed idxd to opt-out of support for polling, which I think is a nice
overall simplification to the damengine API.

Herbert, David - Need an ack on patch 4.

Mauro - Need an ack on patches 5 and 7.

Matt, Alexandre - Need an ack on patch 6.

Changes since version 1:
 - Broke up the change to remove dma_async_is_tx_complete into a single
   patch for each driver
 - Renamed dma_async_is_tx_complete to dmaengine_async_is_tx_complete.

Ben Walker (15):
  dmaengine: Remove dma_async_is_complete from client API
  dmaengine: Move dma_set_tx_state to the provider API header
  dmaengine: Add dmaengine_async_is_tx_complete
  crypto: stm32/hash: Use dmaengine_async_is_tx_complete
  media: omap_vout: Use dmaengine_async_is_tx_complete
  rapidio: Use dmaengine_async_is_tx_complete
  media: pxa_camera: Use dmaengine_async_is_tx_complete
  dmaengine: Remove dma_async_is_tx_complete
  dmaengine: Remove last, used from dma_tx_state
  dmaengine: Providers should prefer dma_set_residue over
    dma_set_tx_state
  dmaengine: Remove dma_set_tx_state
  dmaengine: Add provider documentation on cookie assignment
  dmaengine: idxd: idxd_desc.id is now a u16
  dmaengine: idxd: Support device_tx_status
  dmaengine: Revert "cookie bypass for out of order completion"

 Documentation/driver-api/dmaengine/client.rst | 24 ++----
 .../driver-api/dmaengine/provider.rst         | 64 ++++++++------
 drivers/crypto/stm32/stm32-hash.c             |  3 +-
 drivers/dma/amba-pl08x.c                      |  1 -
 drivers/dma/at_hdmac.c                        |  3 +-
 drivers/dma/dmaengine.c                       |  2 +-
 drivers/dma/dmaengine.h                       | 12 ++-
 drivers/dma/dmatest.c                         | 14 +--
 drivers/dma/idxd/device.c                     |  1 +
 drivers/dma/idxd/dma.c                        | 86 ++++++++++++++++++-
 drivers/dma/idxd/idxd.h                       |  3 +-
 drivers/dma/imx-sdma.c                        |  3 +-
 drivers/dma/mmp_tdma.c                        |  3 +-
 drivers/dma/mxs-dma.c                         |  3 +-
 drivers/media/platform/omap/omap_vout_vrfb.c  |  2 +-
 drivers/media/platform/pxa_camera.c           | 15 +++-
 drivers/rapidio/devices/rio_mport_cdev.c      |  3 +-
 include/linux/dmaengine.h                     | 58 +------------
 18 files changed, 164 insertions(+), 136 deletions(-)

-- 
2.35.1

