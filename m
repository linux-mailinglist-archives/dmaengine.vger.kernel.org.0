Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82A41C2006
	for <lists+dmaengine@lfdr.de>; Mon, 30 Sep 2019 13:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728340AbfI3LkR (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 30 Sep 2019 07:40:17 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37756 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfI3LkR (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 30 Sep 2019 07:40:17 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8UBeBHB090257;
        Mon, 30 Sep 2019 06:40:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569843611;
        bh=lUB5WqJVTYD6E06Lxl92UVAjjafZqxtLBUngwkhtgEA=;
        h=From:To:CC:Subject:Date;
        b=D/jZla5v1yKwJW+guOw4QjKXsCT8xPY2s2FaBlwoImzdqg5dl4Xd7zYqilowG5z5l
         6iJwCuZQcOuX1VmAsM/3VBuL2sYHoeEfWcM3k11OnFb1jG4EYcgpVy/N2o3RNLnsLa
         lX0YjDkVsHxOECTRV5JxUFOsc3yZZmfHSCL7cDM0=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8UBeBOX013480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Sep 2019 06:40:11 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Mon, 30
 Sep 2019 06:40:01 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Mon, 30 Sep 2019 06:40:11 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8UBe8Xo096764;
        Mon, 30 Sep 2019 06:40:09 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 0/3] dmaengine: bindings/edma: dma-channel-mask to array
Date:   Mon, 30 Sep 2019 14:40:52 +0300
Message-ID: <20190930114055.29315-1-peter.ujfalusi@ti.com>
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

Changes since v3:
- Update the dma-common.yaml and edma binding documentation according to Rob's
  suggestion

Changes since v2:
- Fix dma-common.yaml documentation patch and extend the description of the
  dma-channel-mask array
- The edma documentation now includes information on the dma-channel-mask array
  size for EDMAs with 32 or 64 channels

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

 .../devicetree/bindings/dma/dma-common.yaml   |  9 ++-
 .../devicetree/bindings/dma/ti-edma.txt       |  8 +++
 drivers/dma/ti/edma.c                         | 59 +++++++++++++++++--
 3 files changed, 69 insertions(+), 7 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

