Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1380F4A6616
	for <lists+dmaengine@lfdr.de>; Tue,  1 Feb 2022 21:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiBAUjK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 1 Feb 2022 15:39:10 -0500
Received: from mga11.intel.com ([192.55.52.93]:18579 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242399AbiBAUif (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 1 Feb 2022 15:38:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643747916; x=1675283916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k1M+HlB5WGSWvZCSpYvL+GxpGPsqlGityudGO5dBAn8=;
  b=gYHMjrREQS3yyVOysnFFt+9SIGEFZYS1gbV0ZL5jjKnFDc5NZGUn5y9z
   uEOayfoJMoAgF8YgB2j+Pl984NeiwgFPS9Z0xgEVT7wiWs4LXBOfLlUrq
   34RyCqmKbooWUwwytbdusVxU7uQB4/SK5l3ths2smKhS+MpBUQfgP5sS8
   QGxdBrbmCn8aoF2niz4LJTLypf8mRHBoYTLyqA2P2UstoDF//3GRMjKsQ
   2NBAeqK48JmBUfYAhbJcVdgF/UOlQHeJfaDPT6ZmniqssTdM+fco6Og/9
   6k7/sccPa1Wu2JTvurv+xWOFilxYN2YslykDCy6MxjH0QzL1hxZSmp3Dr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="245379835"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="245379835"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 12:38:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="479820512"
Received: from bwalker-desk.ch.intel.com ([143.182.137.151])
  by orsmga003.jf.intel.com with ESMTP; 01 Feb 2022 12:38:34 -0800
From:   Ben Walker <benjamin.walker@intel.com>
To:     vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, dave.jiang@intel.com,
        Ben Walker <benjamin.walker@intel.com>
Subject: [RESEND 00/10] Support polling for out of order completions
Date:   Tue,  1 Feb 2022 13:38:03 -0700
Message-Id: <20220201203813.3951461-1-benjamin.walker@intel.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
This is the pxa_camera driver and it is dealt with in patch 3 of this
series. Please take an extra critical look at that change.

The series also does some API clean up and documents how dma_cookie_t
should behave (i.e. there are no rules, it's just a handle).

This closes out by adding support for .device_tx_status() to the idxd
driver and then reverting the DMA_OUT_OF_ORDER patch that previously
allowed idxd to opt-out of support for polling, which I think is a nice
overall simplification to the dmaengine API.

Ben Walker (10):
  dmaengine: Remove dma_async_is_complete from client API
  dmaengine: Move dma_set_tx_state to the provider API header
  dmaengine: Remove the last, used parameters in
    dma_async_is_tx_complete
  dmaengine: Remove last, used from dma_tx_state
  dmaengine: Providers should prefer dma_set_residue over
    dma_set_tx_state
  dmaengine: Remove dma_set_tx_state
  dmaengine: Add provider documentation on cookie assignment
  dmaengine: idxd: idxd_desc.id is now a u16
  dmaengine: idxd: Support device_tx_status
  dmaengine: Revert "cookie bypass for out of order completion"

 Documentation/driver-api/dmaengine/client.rst | 22 ++---
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
 drivers/media/platform/pxa_camera.c           | 13 ++-
 drivers/rapidio/devices/rio_mport_cdev.c      |  3 +-
 include/linux/dmaengine.h                     | 55 +-----------
 18 files changed, 160 insertions(+), 133 deletions(-)

-- 
2.33.1

