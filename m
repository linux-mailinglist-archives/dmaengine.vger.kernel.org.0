Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5AFE4468
	for <lists+dmaengine@lfdr.de>; Fri, 25 Oct 2019 09:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725775AbfJYHaD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 25 Oct 2019 03:30:03 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41784 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393141AbfJYHaD (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 25 Oct 2019 03:30:03 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9P7TuEW083485;
        Fri, 25 Oct 2019 02:29:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1571988596;
        bh=1cUSfoEykjjueYG50S/BGu6RsBmbXbVHtUUcLABJHMI=;
        h=From:To:CC:Subject:Date;
        b=uwRBtnrtb3CFRjtSl0++4rf3rnturX1wqc1+D9oes00aGejogJ7GbOKKslvkEwjjV
         I19AB807gOyTl43CB3aaKU3+cqj9tPekh9xEGcOm4Neu3Fxr5ZNPZI5wvP4SoIy8fi
         HUJdRg1i7p0Xh/lnJgDVLAQIOr7UifrA2flW/vfU=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9P7TuIY094281
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 25 Oct 2019 02:29:56 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 02:29:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 02:29:44 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9P7Tr4F103329;
        Fri, 25 Oct 2019 02:29:53 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v5 0/3] dmaengine: bindings/edma: dma-channel-mask to array
Date:   Fri, 25 Oct 2019 10:30:53 +0300
Message-ID: <20191025073056.25450-1-peter.ujfalusi@ti.com>
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

Changes since v4:
- Rebased on next to make it apply cleanly
- Added Reviewed-by from Rob for the DT documentation patches

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

