Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11395554A1
	for <lists+dmaengine@lfdr.de>; Wed, 22 Jun 2022 21:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356638AbiFVTiH (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 22 Jun 2022 15:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiFVTiH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 22 Jun 2022 15:38:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA6612A9E;
        Wed, 22 Jun 2022 12:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655926686; x=1687462686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cHrCL4JWXzk2Mz/dlOWv5+b6kPn7/ZVdLbQR+KDXk7s=;
  b=fMCfAhSh6jyLtYKaX6TqqDdhfK/mKRSbL/qkXDHf32jW99Tx/5mtHUjW
   aaehpN3ERXsvONttCsg24Xg01eleA6ibPJ0H1j0bIDkTjo5ilGkJel5/N
   unwazKjTu4+mWT+aF3WzIfxh4X65iHqMEAiIjbdcdiTTJt7RZNd/M5dcj
   7gCymBrQlFuQLm456szPl5uDi7ikRtvipeWeJVcyL4m7Eo5bXa4sCfy7c
   sg4hry+lVlj0IrooMXSRQ16nSOvUfPPHHMbg3t57Z7gV6c2P1bEud4pVc
   MVERq7GCpOuSkHoOP6KpcLY630biH+A/ECI2+Shk0On+8JyySW87dYfnB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281255445"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="281255445"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 12:38:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="715542046"
Received: from bwalker-desk.ch.intel.com ([143.182.136.162])
  by orsmga004.jf.intel.com with ESMTP; 22 Jun 2022 12:38:05 -0700
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/15] dmaengine: Support polling for out of order completions
Date:   Wed, 22 Jun 2022 12:37:38 -0700
Message-Id: <20220622193753.3044206-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503200728.2321188-1-benjamin.walker@intel.com>
References: <20220503200728.2321188-1-benjamin.walker@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series adds support for polling async transactions for completion
even if interrupts are disabled and transactions can complete out of
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
overall simplification to the dmaengine API.

Changes since version 3:
 - Fixed Message-Id in emails. Sorry they were all stripped! Won't
   happen again.

Changes since version 2:
 - None. Rebased as requested without conflict.

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
 drivers/media/platform/intel/pxa_camera.c     | 15 +++-
 .../media/platform/ti/omap/omap_vout_vrfb.c   |  2 +-
 drivers/rapidio/devices/rio_mport_cdev.c      |  3 +-
 include/linux/dmaengine.h                     | 58 +------------
 18 files changed, 164 insertions(+), 136 deletions(-)

Cc:linux-crypto@vger.kernel.org
Cc:linux-stm32@st-md-mailman.stormreply.com
Cc:linux-media@vger.kernel.org
Cc:mporter@kernel.crashing.org
-- 
2.35.1

