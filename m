Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 888836CB3F5
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 04:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjC1CY1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 22:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjC1CY0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 22:24:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F28AE1;
        Mon, 27 Mar 2023 19:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679970264; x=1711506264;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pVRgqA5pRubAG7O4LrERjHSzvI+FZslxiWIeMUC4ucU=;
  b=gd7jaEW5JmIqAvl7g6Q2LXmWNXFjA158eU8AZ0MGiwIC21/Z4ye0ric9
   3Zkg0zMiQcTfS3ZAqAgAPctnTyAWNHDwbXgojMiugtPvIP0C2PWhQhk57
   vb9UCXL188K5WVHdhuVHSS0Aw7JjxM73ZT3Yxb3IpSOo7niDdvwcvCbgy
   Lt9xYBNK1QvVf7u4ff0Q5BVnnHMHFfGnWzDBf3RZ4IprKn35HuyZy/gPF
   I5eAoDVEZ+uTTC+P1npeoQxvHU2ln/OACFkQeVdGYpDaYu60BNj9Z38Pn
   wilttcYBLZrYWCFOYRBjR3+J3uLrLROqKIn8JA4jEypT665OMrZJ5cpUH
   w==;
X-IronPort-AV: E=Sophos;i="5.98,295,1673938800"; 
   d="scan'208";a="144189550"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 19:24:23 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:24:23 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Mar 2023 19:24:23 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <logang@deltatee.com>
Subject: [PATCH 0/1] Switchtec Switch DMA Engine Driver
Date:   Mon, 27 Mar 2023 18:11:39 -0700
Message-ID: <20230328011142.2107129-1-kelvin.cao@microchip.com>
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

The following patch implements a DMAEngine driver to use the DMA
controller in Switchtec PSX/PFX switchtes. The DMA controller appears as
a PCI function on the switch upstream port. The DMA function can include
one or more DMA channels.

This patchset is based off of v6.3-rc1.

Thanks,
Kelvin

Kelvin Cao (1):
  dmaengine: switchtec-dma: Introduce Switchtec DMA engine PCI driver

 MAINTAINERS                 |    5 +
 drivers/dma/Kconfig         |    9 +
 drivers/dma/Makefile        |    1 +
 drivers/dma/switchtec_dma.c | 1745 +++++++++++++++++++++++++++++++++++
 4 files changed, 1760 insertions(+)
 create mode 100644 drivers/dma/switchtec_dma.c

-- 
2.25.1

