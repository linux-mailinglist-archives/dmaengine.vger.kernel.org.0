Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1849C6DA5A2
	for <lists+dmaengine@lfdr.de>; Fri,  7 Apr 2023 00:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjDFWQV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 6 Apr 2023 18:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDFWQU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 6 Apr 2023 18:16:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1545DE46;
        Thu,  6 Apr 2023 15:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680819378; x=1712355378;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HEn8cWigHG4poqzmFeTugeaK71IYmmHqaJBZ1COZvc8=;
  b=ampNyzzMre2RFzSBRJQMhxFUxhZFJQ8qFw18BBRyZ8ZYQfTC+GGc7VIs
   o1SIUedWrHURxefTJ2eL/BwIeOOXmfie+6VujNnQDmK01fenrCRT8NZ3z
   9IB/tAr2gabXZ7Ew4d2fN+NRPxF52qdzMP88FATAfL8QOQQ9juz9OxUeJ
   Kp8Fm+6ITIaVM//Uv6DbePi9daBXTajIGiMaT/fhaj0i35IaY/G4UyQTQ
   jy4gSiJu8lpeet6LiLHXaZBJCGYIWKuP+D7x3EReU8HXU5TIZFYt7OwYf
   k/ISxetb8E37ukHt+r5AY3WOy3z+Q477yhO2Q+hzmkooGvBRZJjJpMzbV
   A==;
X-IronPort-AV: E=Sophos;i="5.98,323,1673938800"; 
   d="scan'208";a="145937248"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2023 15:16:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 6 Apr 2023 15:16:13 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Thu, 6 Apr 2023 15:16:13 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <logang@deltatee.com>, <george.ge@microchip.com>,
        <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v3 0/1] Switchtec Switch DMA Engine Driver
Date:   Thu, 6 Apr 2023 14:03:22 -0700
Message-ID: <20230406210323.1018163-1-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

This is v3 of the Switchtec Switch DMA Engine Driver, incorporating
changes for the v2 review comments.

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

This patchset is based off of v6.3-rc1.

Kelvin Cao (1):
  dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver

 MAINTAINERS                 |    5 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1730 +++++++++++++++++++++++++++++++++++
 4 files changed, 1745 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c

-- 
2.25.1

