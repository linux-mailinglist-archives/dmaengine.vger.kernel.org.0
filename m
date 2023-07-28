Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576B0767784
	for <lists+dmaengine@lfdr.de>; Fri, 28 Jul 2023 23:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjG1VT7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 28 Jul 2023 17:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjG1VT6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 28 Jul 2023 17:19:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3285D2115;
        Fri, 28 Jul 2023 14:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690579198; x=1722115198;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dLjpD3bE9gRk5B8RPBWyRrv/flxLyycbEPLgr8Q7zrw=;
  b=kp+PfIMWSrKiNmPvllUcWOk/QB5krqBIycjxmwm5DqG/Y9CQoSwUV66i
   fZs0jdPIo7BC46b+K+NP541zYkaaug42HmVXRVZ6DqF1QgkAsFdSXkA0X
   r+7o0Qau6lD7PIZkwvagKvctOFxSt5wTd3bF24fXi2Nc9Ps2gEZEwh8LG
   mUrJ/oNBgOeH/01B+kFis27F/jelQVsfWTXx+RgIii43RSKRnwOUp1oQl
   iNXp8X4XidlIHf4AoXoT7o0rPE5+rrZ1ym/qyEt70BSRlwQUwpiEKYGpi
   Arxnrl0CzZc6+i6Y6m2tBZi7FlghRSJPEoya/7WnSZ1mb18QxBZGUnedt
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="226729478"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2023 14:19:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 28 Jul 2023 14:19:56 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Fri, 28 Jul 2023 14:19:56 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <logang@deltatee.com>, <George.Ge@microchip.com>,
        <christophe.jaillet@wanadoo.fr>, <hch@infradead.org>
Subject: [PATCH v6 0/1] Switchtec Switch DMA Engine Driver
Date:   Fri, 28 Jul 2023 13:03:26 -0700
Message-ID: <20230728200327.96496-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,
 
This is v6 of the Switchtec Switch DMA Engine Driver, incorporating
changes for the v2/v3/v4/v5 review comments.
 
v6 changes:
  - Fix './scripts/checkpatch.pl --strict' warnings
  - Use readl_poll_timeout_atomic for status checking with timeout
  - Wrap enable_channel/disable_channel over channel_op
  - Use flag GFP_NOWAIT for mem allocation in switchtec_dma_alloc_desc
  - Use proper comment for macro SWITCHTEC_DMA_DEVICE

v5 changes:
  - Remove unnecessary structure modifier '__packed'
  - Remove the use of union of identical data types in a structure
  - Remove unnecessary call sites of synchronize_irq
  - Remove unnecessary rcu lock for pdev during device initialization
  - Use pci_request_irq/pci_free_irq to replace request_irq/free_irq
  - Add mailing list info in file MAINTAINERS
  - Miscellaneous cleanups

v4 changes:
  - Sort driver entry in drivers/dma/Kconfig and drivers/dma/Makefile
    alphabetically 
  - Fix miscellaneous style issues
  - Correct year in copyright
  - Add function and call sites to flush PCIe MMIO Write
  - Add a helper to wait for status register update
  - Move synchronize_irq out of RCU critical section
  - Remove unnecessary endianness conversion for register access
  - Remove some unused code
  - Use pci_enable_device/pci_request_mem_regions instead of
    pcim_enable_device/pcim_iomap_regions to make the resource lifetime
    management more understandable
  - Use offset macros instead of memory mapped structures when accessing
    some registers
  - Remove the attempt to set DMA mask with smaller number as it would 
    never succeed if the first attempt with bigger number fails
  - Use PCI_VENDOR_ID_MICROSEMI in include/linux/pci_ids.h as device ID

v3 changes:
  - Remove some unnecessary memory/variable zeroing
 
v2 changes:
  - Move put_device(dma_dev->dev) before kfree(swdma_dev) as dma_dev is
    part of swdma_dev.
  - Convert dev_ print calls to pci_ print calls to make the use of
    print functions consistent within switchtec_dma_create().
  - Remove some dev_ print calls, which use device pointer as handles,
    to ensure there's no reference issue when the device is unbound.
  - Remove unused .driver_data from pci_device_id structure.
 
v1:
The following patch implements a DMAEngine driver to use the DMA
controller in Switchtec PSX/PFX switchtes. The DMA controller appears as
a PCI function on the switch upstream port. The DMA function can include
one or more DMA channels.
 
This patchset is based off of 6.5.0-rc3.

Kelvin Cao (1):
  dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver

 MAINTAINERS                 |    6 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1570 +++++++++++++++++++++++++++++++++++
 4 files changed, 1586 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c

-- 
2.25.1

