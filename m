Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5841BAE96F
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731626AbfIJLuM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 07:50:12 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59530 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727120AbfIJLuM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 07:50:12 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8ABo9EP050408;
        Tue, 10 Sep 2019 06:50:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568116209;
        bh=JcH26n/D7DAN+euHsWczUuhZTWYKCDEdx+p+sNANUYU=;
        h=From:To:CC:Subject:Date;
        b=RjPBdJugaAKGMYFepjUPRbGHeFB/245pfBHjOaKDeWdDXyNd45dx9mKVtKgWn5CNR
         +1XJ6ozLmioURFZxlZ3m+CFhHqzKs6bHQ/nztXmEBkGpK3JJXVVG3dea3itYxeJ3Z/
         7vq0ggSVnncuaqdaQ6G+WteZihk5AnnKZFnyABgs=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8ABo9cO092200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Sep 2019 06:50:09 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 06:50:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 06:50:07 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ABo5cF028909;
        Tue, 10 Sep 2019 06:50:06 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH 0/3] dmaengine: Support for DMA domain controllers
Date:   Tue, 10 Sep 2019 14:50:34 +0300
Message-ID: <20190910115037.23539-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

Changes since RFC:
- Extended the binding document's example
- Changed the API to dma_request_chan_by_domain(dev, mask)
 - Fixed certain crash if the dev parameter would be NULL
- Add missing parenthesis in of_dma.c
- typo fix.

More and more SoC have more than one DMA controller integrated.

If a device needs none slave DMA channel for operation (block copy from/to
memory mapped regions for example) at the moment when they request a channel it
is going to be taken from the first DMA controller which was registered, but
this might be not optimal for the device.

For example on AM654 we have two DMAs: main_udmap and mcu_udmap.
DDR to DDR memcpy is twice as fast on main_udmap compared to mcu_udmap, while
devices on MCU domain (OSPI for example) are more than twice as fast on
mcu_udmap than with main_udmap.

Because of probing order (mcu_udmap is probing first) modules would use
mcu_udmap instead of the better main_udmap. Currently the only solution is to
make a choice and disable the MEM_TO_MEM functionality on one of them which is
not a great solution.

With the introduction of DMA domain controllers we can utilize the best DMA
controller for the job around the SoC without the need to degrade performance.

If the dma-domain-controller is not present in DT or booted w/o DT the none
slave channel request will work as it does today.

Regards,
Peter
---
Peter Ujfalusi (3):
  dt-bindings: dma: Add documentation for DMA domains
  dmaengine: of_dma: Function to look up the DMA domain of a client
  dmaengine: Support for requesting channels preferring DMA domain
    controller

 .../devicetree/bindings/dma/dma-domain.yaml   | 88 +++++++++++++++++++
 drivers/dma/dmaengine.c                       | 21 +++--
 drivers/dma/of-dma.c                          | 42 +++++++++
 include/linux/dmaengine.h                     |  9 +-
 include/linux/of_dma.h                        |  7 ++
 5 files changed, 159 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/dma/dma-domain.yaml

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

