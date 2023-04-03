Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91E306D512F
	for <lists+dmaengine@lfdr.de>; Mon,  3 Apr 2023 21:19:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbjDCTTu (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 3 Apr 2023 15:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjDCTTu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 3 Apr 2023 15:19:50 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5A35A0;
        Mon,  3 Apr 2023 12:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680549571; x=1712085571;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ePxHK6Wg0z1QpCTAloo+BxX7YWBgmbRVAuDqJf/Q7Mc=;
  b=ixKTztLSaxK+b9tR30Xs9J2IwKQZAp7UjG/ym8LBQ1i3bWvH0kQXeE17
   rQqAS0dC9jSl5auYlnNMNwzYu2C+ZVdJOJ6kWQAjb/JSnZdHIEoowGnXf
   luKfQdI7o8hs8PXgcOmDkHDDPSAhIvU63dfk7AGkeSBknDUp9QsNIOWqm
   k36SSmEvFe0X1uIeZqaArGLgB8FW+tgUDW++AAaQ60x+8yMZK446jEdZM
   Kneybkqo5JwRXGxAYigUl0bmWw7ewmMmkagLxPf3MD+eijgSzSUk6HlHy
   NCPb+LmCMEos23W5S0939SsaYKYQMcXQgsqsAelYQZviVBQ+iiY5UFBnJ
   g==;
X-IronPort-AV: E=Sophos;i="5.98,315,1673938800"; 
   d="scan'208";a="208642192"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Apr 2023 12:19:17 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 12:19:17 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 3 Apr 2023 12:19:17 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <logang@deltatee.com>, <george.ge@microchip.com>
Subject: [PATCH v2 0/1] Switchtec Switch DMA Engine Driver
Date:   Mon, 3 Apr 2023 11:06:27 -0700
Message-ID: <20230403180630.4186061-1-kelvin.cao@microchip.com>
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

