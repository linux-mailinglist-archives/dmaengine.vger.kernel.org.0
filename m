Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0866A3BE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Jul 2019 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730972AbfGPIYU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 16 Jul 2019 04:24:20 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43040 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbfGPIYU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 16 Jul 2019 04:24:20 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x6G8O5Zh113419;
        Tue, 16 Jul 2019 03:24:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1563265445;
        bh=KMXHtI3sKuhmBB8FFbgYzVJP9JhJyNEHQ+sOiwAQro0=;
        h=From:To:CC:Subject:Date;
        b=OIyhkG9qcRpBHqryRlLXbDKzbiHhcNe2+xpz8SCnfWbzHYNVEma3RATO9WqkffHHj
         c4Q5bvGzyL9NUdny2sMJvH8mPh0IWYvUULsXY0u4dplwO+Ua/ipaq+ShBLZc3IBYrk
         qs0BkosjHiK6L+L+zkrBpA7vZ3FfnDJYKIKAOUNI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x6G8O4uf051393
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Jul 2019 03:24:05 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 16
 Jul 2019 03:24:02 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 16 Jul 2019 03:24:02 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x6G8O0lf033709;
        Tue, 16 Jul 2019 03:24:01 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>
CC:     <dan.j.williams@intel.com>, <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-omap@vger.kernel.org>
Subject: [PATCH v2 0/2] dmaengine: ti: omap-dma: Improved polling support
Date:   Tue, 16 Jul 2019 11:24:57 +0300
Message-ID: <20190716082459.1222-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

changes since v1:
- New preparation cleanup patch
- Simplified code for the main patch to be easier to read

This series fine-tunes the omap-dma polled memcpy support to be inline with how
the EDMA driver is handling it.

The polled completion can be tested by applying:
https://patchwork.kernel.org/patch/10966499/

and run the dmatest with polled = 1 on boards where sDMA is used.

Or boot up any dra7 family device with display enabled. The workaround for DMM
errata i878 uses polled DMA memcpy.

Regards,
Peter
---
Peter Ujfalusi (2):
  dmaengine: ti: omap-dma: Readability cleanup in omap_dma_tx_status()
  dmaengine: ti: omap-dma: Improved memcpy polling support

 drivers/dma/ti/omap-dma.c | 52 +++++++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 19 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

