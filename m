Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFA76CB3F9
	for <lists+dmaengine@lfdr.de>; Tue, 28 Mar 2023 04:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjC1CYa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 27 Mar 2023 22:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjC1CY2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 27 Mar 2023 22:24:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C572110E4;
        Mon, 27 Mar 2023 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679970266; x=1711506266;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pVRgqA5pRubAG7O4LrERjHSzvI+FZslxiWIeMUC4ucU=;
  b=FW8Zd4g2kkr7cPnkPe/ZL0v1fsQCUDyPWEhiJ9X/CnH22jQz3Wsi1Sjn
   RBBZ98Bz1rAuGW/jBhLz4pwiZ6oZxU6i8ylTqXlEaQVv0ZEj/QxMh+Csx
   cZ/zCeiCTy/qG+cy90s857y3F14YoMpT4erH4W9Lctd05rNQDIrPpFpxV
   xG7KUzOTZd2tcUoyoKPiM1HyK5kXt6pjt/9h6g9u5KysZ1Mf9UYnn2JD9
   NJeu92a2mqKBILJmoiY98tX9a0FDShIkGsHUd3hT86JK0HodV0EbtLqzE
   Rg/ivbJDDQPg5mGjPxJBq7p9c5uO+Szqa3KigkC+3yJQZovFZEUdTwvCt
   w==;
X-IronPort-AV: E=Sophos;i="5.98,295,1673938800"; 
   d="scan'208";a="144189560"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 19:24:25 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 19:24:24 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Mar 2023 19:24:23 -0700
From:   Kelvin Cao <kelvin.cao@microchip.com>
To:     <vkoul@kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <kelvin.cao@microchip.com>, <logang@deltatee.com>
Subject: [PATCH 0/1] Switchtec Switch DMA Engine Driver
Date:   Mon, 27 Mar 2023 18:11:41 -0700
Message-ID: <20230328011142.2107129-3-kelvin.cao@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328011142.2107129-1-kelvin.cao@microchip.com>
References: <20230328011142.2107129-1-kelvin.cao@microchip.com>
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

