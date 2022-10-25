Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB0760C72E
	for <lists+dmaengine@lfdr.de>; Tue, 25 Oct 2022 11:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiJYJDW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Oct 2022 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbiJYJDU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 25 Oct 2022 05:03:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FA5158D41;
        Tue, 25 Oct 2022 02:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666688598; x=1698224598;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wcNkbfUgqXT7nAfmkdFbESesrvdKH9TGwWLIWOtxlR0=;
  b=ONh1T9tA75KwZBtSgIq3xUguW5QkJaXdInAkheFyii7uf/mHENhD+O8H
   Pl36jvw5gCM1p5NBCl9mFoIzv6GK0qzHJnCQKHAUTFKK3IB1539BgMw0K
   bQbMdnaz3Lin+x1I4RvbpJ9cuacmrlrg/FeuS/VJuV67xgnoJv8KjxQCv
   bVeQWCb6wNgpv/SN/oME3STeq3d3qRF6M08V/xXrpi6pTxlH5OJQFVFUv
   ZOnyGbvIYy04Y1ksfrD/vI4AnkB5+xiGZg4BUwJ6cKf/EwKgTQ8bMMsjn
   +gwtXU9NLULbg/nK6y8hCxhjyecWf+A4f8tQZ+uFObxPzTsNXYsXQVHjX
   w==;
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="183777233"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Oct 2022 02:03:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 25 Oct 2022 02:03:12 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Tue, 25 Oct 2022 02:03:10 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>
CC:     <maciej.sosnowski@intel.com>, <nicolas.ferre@microchip.com>,
        <mripard@kernel.org>, <torfl6749@gmail.com>,
        <linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH v2 00/32] dmaengine: at_hdmac: Fix concurrency bugs and then convert to virt-dma
Date:   Tue, 25 Oct 2022 12:02:34 +0300
Message-ID: <20221025090306.297886-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

v2:
- reorder patches so that fixes come first -> easier to backport to
stable kernels.
- drop the devm_request_irq() patch as we had to disable the irq anyway
in remove() in order to avoid spurios IRQs. Using devm variant brings no
palpable benefit.
- reword pm_ptr commit message


at_hdmac driver had poor list handling and concurrency bugs.
We experienced calling of the completion call twice for the
same descriptor. Peter Rosin encountered the same while
reporting a different bug:
https://lore.kernel.org/lkml/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/

Two sets of tests were performed:
1/ tested just the fixes, to make sure everything is fine and the
concurrency bugs are squashed even without the conversion to virt-dma.
All went fine.
2/ tested the entire series including the conversion the virt-dma
All went fine.

I tested NAND (prep_dma_memcpy), MMC (prep_dma_slave_sg),
usart (cyclic mode), dmatest (memcpy, memset).
With the conversion to virt-dma I replaced the election of a new transfer
in the tasklet with the election of the new transfer in the interrupt
handler. We should have a shorter idle window as we remove the scheduling
latency of the tasklet. Using mtd_speedtest showed similar performances
when using NAND with DMA. That could be because of using a low timming
mode on NAND.


Tudor Ambarus (32):
  dmaengine: at_hdmac: Fix at_lli struct definition
  dmaengine: at_hdmac: Don't start transactions at tx_submit level
  dmaengine: at_hdmac: Start transfer for cyclic channels in
    issue_pending
  dmaengine: at_hdmac: Fix premature completion of desc in issue_pending
  dmaengine: at_hdmac: Do not call the complete callback on
    device_terminate_all
  dmaengine: at_hdmac: Protect atchan->status with the channel lock
  dmaengine: at_hdmac: Fix concurrency problems by removing
    atc_complete_all()
  dmaengine: at_hdmac: Fix concurrency over descriptor
  dmaengine: at_hdmac: Free the memset buf without holding the chan lock
  dmaengine: at_hdmac: Fix concurrency over the active list
  dmaengine: at_hdmac: Fix descriptor handling when issuing it to
    hardware
  dmaengine: at_hdmac: Fix completion of unissued descriptor in case of
    errors
  dmaengine: at_hdmac: Don't allow CPU to reorder channel enable
  dmaengine: at_hdmac: Fix impossible condition
  dmaengine: at_hdmac: Check return code of dma_async_device_register
  dmaengine: at_hdmac: Do not print messages on console while holding
    the lock
  dmaengine: at_hdmac: Return dma_cookie_status()'s ret code when
    txstate is NULL
  dmaengine: at_hdmac: Remove superfluous cast
  dmaengine: at_hdmac: Pass residue by address to avoid unnecessary
    implicit casts
  dmaengine: at_hdmac: s/atc_get_bytes_left/atc_get_residue
  dmaengine: at_hdmac: Introduce atc_get_llis_residue()
  dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
  dmaengine: at_hdmac: Use devm_platform_ioremap_resource
  dmaengine: at_hdmac: Use devm_clk_get()
  dmaengine: at_hdmac: Use pm_ptr()
  dmaengine: at_hdmac: Set include entries in alphabetic order
  dmaengine: at_hdmac: Keep register definitions and structures private
    to at_hdmac.c
  dmaengine: at_hdmac: Use bitfield access macros
  dmaengine: at_hdmac: Rename "dma_common" to "dma_device"
  dmaengine: at_hdmac: Rename "chan_common" to "dma_chan"
  dmaengine: at_hdmac: Remove unused member of at_dma_chan
  dmaengine: at_hdmac: Convert driver to use virt-dma

 MAINTAINERS                 |    1 -
 drivers/dma/Kconfig         |    1 +
 drivers/dma/at_hdmac.c      | 1899 ++++++++++++++++++-----------------
 drivers/dma/at_hdmac_regs.h |  478 ---------
 4 files changed, 990 insertions(+), 1389 deletions(-)
 delete mode 100644 drivers/dma/at_hdmac_regs.h

-- 
2.25.1

