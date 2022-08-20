Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F8A59AE3D
	for <lists+dmaengine@lfdr.de>; Sat, 20 Aug 2022 15:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbiHTM50 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 20 Aug 2022 08:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiHTM5Z (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 20 Aug 2022 08:57:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32670E48;
        Sat, 20 Aug 2022 05:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661000243; x=1692536243;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OCV3OM/a3X2mfO+t0BGgOheZWzie85uQFCEZzowl7JE=;
  b=elrjl84UMBfdQlcv18vUfKpmrvPVvk3p1ndq0FjoJpZaMS1jiytxBmvC
   0t+znX7TOmPVXiGPlz99jlVOx17SMif0DN0x7os3EfbhwDmpRBVri2wku
   dmrVHdo9ucJKYh87jllcykyeT8n4GArdP+WyqLjnOo7eOQfl0mgLYpS5k
   5RG/FrYpidJIPgxZKx5lizuvBa2HetywWpU+LzqOkYuIl4sAOTYtcQpAN
   3+RtSlBTn0KzDVjknnpUT4ENO66RwfYIX2dkZl+KG4MSEJ3ECmn9klFch
   XBOyPLgrOrufjUYvk6Fbxrb1JU+xCJaYtIkKHjPAh/PaE7hNhLjYiZy51
   A==;
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="177187997"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Aug 2022 05:57:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 20 Aug 2022 05:57:22 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Sat, 20 Aug 2022 05:57:19 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <vkoul@kernel.org>, <peda@axentia.se>, <du@axentia.se>,
        <regressions@leemhuis.info>
CC:     <ludovic.desroches@microchip.com>, <maciej.sosnowski@intel.com>,
        <tudor.ambarus@microchip.com>, <dan.j.williams@intel.com>,
        <nicolas.ferre@microchip.com>, <mripard@kernel.org>,
        <torfl6749@gmail.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 00/33] dmaengine: at_hdmac: Fix concurrency bugs and then convert to virt-dma
Date:   Sat, 20 Aug 2022 15:56:44 +0300
Message-ID: <20220820125717.588722-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Peter Rosin reported a memory corryption bug on Atmel SAMA5D31 that
happened under high CPU load and low memory resources. See:
https://lore.kernel.org/lkml/13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se/

The problem was two fold:
1/ The atmel nand driver uses dma_map_single() but failed to call its
dma_unmap_single() counterpart. As the DMA address space is a shared
resource, one could render the machine unusable by consuming all DMA
addresses. Also, failing to call dma_unmap_single translated to failing
to invalidate the data cache withing that specific region. Since SAMA5D3
uses VIPT (Virtually Indexed Physically Tagged) cache model, cache aliases
occured. The issue occurs when a physical memory page is mapped twice (or
more) in the virtual memory space. With VIPT models, the choice of the
cache line depends on the virtual address so even if two different virtual
addresses are mapped to point to the very same physical address, they may
use two different cache lines. Then dma_map_single() or dma_map_sg()
functions, only cleans / invalidates the data cache lines associated to
their virtual address argument. The cache lines used by the second virtual
memory address won't be cleaned / invalidated hence cache coherency issues
may occur. This was fixed at:
https://lore.kernel.org/linux-mtd/20220728074014.145406-1-tudor.ambarus@microchip.com/

2/ at_hdmac driver had poor list handling and concurrency bugs. We
experienced calling of the completion call twice for the same descriptor.

Fix all the concurrency bugs in at_hdmac driver and then convert the driver
to use virt-dma.

The series was tested with NAND (prep_dma_memcpy), MMC (prep_dma_slave_sg),
usart (cyclic mode), dmatest (memcpy, memset). All went fine. With the
conversion to virt-dma I replaced the election of a new transfer in the
tasklet with the election of the new transfer in the interrupt handler. We
should have a shorter idle window as we remove the scheduling latency of
the tasklet. Using mtd_speedtest showed similar performances when using
NAND with DMA.

There are other some cosmetic patches that could facelift this 13 years old
driver, but I'll let those for another series.

Tudor Ambarus (33):
  dmaengine: at_hdmac: Keep register definitions and structures private
    to at_hdmac.c
  dmaengine: at_hdmac: Use bitfield access macros
  dmaengine: at_hdmac: Rename "dma_common" to "dma_device"
  dmaengine: at_hdmac: Rename "chan_common" to "dma_chan"
  dmaengine: at_hdmac: Remove unused member of at_dma_chan
  dmaengine: at_hdmac: Return dma_cookie_status()'s ret code when
    txstate is NULL
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
  dmaengine: at_hdmac: Do not print messages on console while holding
    the lock
  dmaengine: at_hdmac: Fix impossible condition
  dmaengine: at_hdmac: Pass residue by address to avoid unneccessary
    implicit casts
  dmaengine: at_hdmac: s/atc_get_bytes_left/atc_get_residue
  dmaengine: at_hdmac: Introduce atc_get_llis_residue()
  dmaengine: at_hdmac: Remove superfluous cast
  dmaengine: at_hdmac: Use devm_kzalloc() and struct_size()
  dmaengine: at_hdmac: Use devm_platform_ioremap_resource
  dmaengine: at_hdmac: Use devm_request_irq()
  dmaengine: at_hdmac: Use devm_clk_get()
  dmaengine: at_hdmac: Check return code of dma_async_device_register
  dmaengine: at_hdmac: Use pm_ptr()
  dmaengine: at_hdmac: Set include entries in alphabetic order
  dmaengine: at_hdmac: Convert driver to use virt-dma

 MAINTAINERS                 |    1 -
 drivers/dma/Kconfig         |    1 +
 drivers/dma/at_hdmac.c      | 1901 ++++++++++++++++++-----------------
 drivers/dma/at_hdmac_regs.h |  478 ---------
 4 files changed, 985 insertions(+), 1396 deletions(-)
 delete mode 100644 drivers/dma/at_hdmac_regs.h

-- 
2.25.1

