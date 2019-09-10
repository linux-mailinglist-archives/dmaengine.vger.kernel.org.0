Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8CAAE961
	for <lists+dmaengine@lfdr.de>; Tue, 10 Sep 2019 13:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731207AbfIJLpi (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 10 Sep 2019 07:45:38 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:59058 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731205AbfIJLpi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 10 Sep 2019 07:45:38 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8ABjVRn049469;
        Tue, 10 Sep 2019 06:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1568115931;
        bh=rGQYwREz07lItXpjPOr/Y91fa8TR1naCyoIvgeiuneo=;
        h=From:To:CC:Subject:Date;
        b=DaEKQpD8MFWd9BGXwD5jrtps80mKQVA0DwDLHO21R1JoQTFTDFqqVfxERkMr1Ty2t
         CfX29vb1kWdxmDrRTkhdFdHiHphdnXD8yOPmUKkfMmESmNLZdrwRYlkWFgSYfNEAsq
         X3sn+/mWKoD7YBgS1IrWoLzjjANT1zG5whzQn8Ac=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8ABjVbM088210
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Sep 2019 06:45:31 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 10
 Sep 2019 06:45:30 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 10 Sep 2019 06:45:30 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8ABjRpI119821;
        Tue, 10 Sep 2019 06:45:28 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 0/3] dmaengine: bindings/edma: dma-channel-mask to array
Date:   Tue, 10 Sep 2019 14:45:56 +0300
Message-ID: <20190910114559.22810-1-peter.ujfalusi@ti.com>
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

Changes since v1:
- Extend the common dma-channel-mask to uint32-array to be usable for
  controllers with more than 32 channels
- Use the dma-channel-mask instead custom property for available channels for
  EDMA.

The original patch was part of the EDMA multicore usage series.

Rob: I'm not sure if I got the dma-common.yaml update correctly...

EDMAs can have 32 or 64 channels depending on the SoC, the dma-channel-mask
needs to be an array to be usable for the driver.

Regards,
Peter
---
Peter Ujfalusi (3):
  dt-bindings: dmaengine: dma-common: Change dma-channel-mask to
    uint32-array
  dt-bindings: dma: ti-edma: Document dma-channel-mask for EDMA
  dmaengine: ti: edma: Add support for handling reserved channels

 .../devicetree/bindings/dma/dma-common.yaml   | 10 +++-
 .../devicetree/bindings/dma/ti-edma.txt       |  6 ++
 drivers/dma/ti/edma.c                         | 59 +++++++++++++++++--
 3 files changed, 68 insertions(+), 7 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

