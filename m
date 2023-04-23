Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17556EC2FA
	for <lists+dmaengine@lfdr.de>; Mon, 24 Apr 2023 00:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjDWWu6 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 23 Apr 2023 18:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDWWu6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 23 Apr 2023 18:50:58 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1962DE7C;
        Sun, 23 Apr 2023 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1682290258; x=1713826258;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Xc3o1uO68JRIveClRtu9Hxqc+/zuwrIFLZTLDPGRT3Y=;
  b=Bf6DoMDI5MgDX47mjf4JS5dkfLLJp7U82Gvg34YUk9P73T21cuhA2m2B
   bBq2m20eLm+XzyBb49AVyPWMcp1WmmXinoLWE9PFafFA9BymWqYl72nyK
   oQZMSr3G56WqXJP4faJ36l4ErgwFa1Beqcr3+T9t5HTzCkLduYYVIEaAZ
   cJo2DtMAiKi7FyEJ+6oChM3Zb0l+g7R8IDg6XvTp2SwWrIG9V+gvghFSo
   dq4YLzTWDv3fqSGv1lKwGqGM+PPxKQraCTX978G1xyJZzNqSwYM1pDdTh
   EMZJvkw5IGc3NmnIhoE08sI1e8FPAZfjdPhkwwZtnIbt+W5o8cFI6eWfz
   A==;
X-IronPort-AV: E=Sophos;i="5.99,221,1677567600"; 
   d="scan'208";a="210816259"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2023 15:50:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sun, 23 Apr 2023 15:50:55 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Sun, 23 Apr 2023 15:50:55 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <logang@deltatee.com>, <george.ge@microchip.com>,
        <christophe.jaillet@wanadoo.fr>, <hch@infradead.org>
Subject: [PATCH v4 0/1] Switchtec Switch DMA Engine Driver
Date:   Sun, 23 Apr 2023 14:37:16 -0700
Message-ID: <20230423213717.318655-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,
 
This is v4 of the Switchtec Switch DMA Engine Driver, incorporating
changes for the v2/v3 review comments.
 
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
 
This patchset is based off of v6.3-rc7.

Kelvin Cao (1):
  dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver

 MAINTAINERS                 |    5 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1614 +++++++++++++++++++++++++++++++++++
 4 files changed, 1629 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c

-- 
2.25.1

