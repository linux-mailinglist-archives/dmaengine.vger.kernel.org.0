Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266AD6D5130
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 21:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232607AbjDCTTv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 15:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjDCTTu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 15:19:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E751A3C05;
        Mon,  3 Apr 2023 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680549570; x=1712085570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ePxHK6Wg0z1QpCTAloo+BxX7YWBgmbRVAuDqJf/Q7Mc=;
  b=Qr65gGq91nSc1Cvq250MQxf/EdM7qS/rj5xeWmtcRlNUXjzTcJ8130NZ
   l0UMg4KoJyBBhlFgqtAca+Z0qcoUvhdV20z6w0lljKECX+0hVuVhZXAWT
   HPNOAkVj5sivIySgiK8SbfuuwT6oEEivpa3PYSFDJVkP+CYQUfywUABDN
   bJ1evxVIemnySWpF2QLyubF7Hx29pN+MZnpANy8LjUsb+hcrVM3Nf5vWP
   sFpQ2je0050zV6JbYSX3zAyyfGdIctm+G4ucKpPdXuY/wocEg70Ddp6rv
   6+MP4o7uRH2q2yHPpqoEbdmU0jaBcAYhzRK3wBmLRKVU8zl7s2NeKndmn
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,315,1673938800"; 
   d="scan'208";a="207550039"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2023 12:19:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 12:19:18 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Apr 2023 12:19:18 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <logang@deltatee.com>, <george.ge@microchip.com>
Subject: [PATCH v2 0/1] Switchtec Switch DMA Engine Driver
Date:   Mon, 3 Apr 2023 11:06:29 -0700
Message-ID: <20230403180630.4186061-3-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230403180630.4186061-1-kelvin.cao@microchip.com>
References: <20230403180630.4186061-1-kelvin.cao@microchip.com>
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

This is v2 of the Switchtec Switch DMA Engine Driver, incorporating
changes for the review comments of the initial post.

Changes in v2:
  - Move put_device(dma_dev->dev) before kfree(swdma_dev) as dma_dev is
    part of swdma_dev.
  - Convert dev_ print calls to pci_ print calls to make the use of
    print functions consistent within switchtec_dma_create().
  - Remove some dev_ print calls, which use device pointer as handles,
    to ensure there's no reference issue when the device is unbound.
  - Remove unused .driver_data from pci_device_id structure.

Kelvin Cao (1):
  dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver

 MAINTAINERS                 |    5 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1734 +++++++++++++++++++++++++++++++++++
 4 files changed, 1749 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c

-- 
2.25.1

