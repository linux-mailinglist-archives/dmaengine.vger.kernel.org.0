Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D87ABF10E
	for <lists+dmaengine@lfdr.de>; Thu, 26 Sep 2019 13:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfIZLTU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 26 Sep 2019 07:19:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51616 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbfIZLTU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 26 Sep 2019 07:19:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x8QBJDnb013031;
        Thu, 26 Sep 2019 06:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1569496753;
        bh=x5UNff13Ux7e75VM9yw2ZEuh6YPd/12K8z+lzDEZtnA=;
        h=From:To:CC:Subject:Date;
        b=MNJe0ACf2KI4Nv0TdzevMrfzask0HtZvWupd4cta+vmiHp9S5QFEgAs86Lj9ToXL7
         TPnMfGhKJ4TTH2LoiBM+AfrWrlIfIWht/eN9+GmngRw7CVqFE7PPRj13CMTfO717Eg
         guhzi3Mujh0orYf+iZpzDHNlOnBCK1ge7zPt1mrs=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x8QBJDma038340
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 26 Sep 2019 06:19:13 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Thu, 26
 Sep 2019 06:19:12 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Thu, 26 Sep 2019 06:19:05 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id x8QBJAdr013885;
        Thu, 26 Sep 2019 06:19:11 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dan.j.williams@intel.com>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 0/3] dmaengine: bindings/edma: dma-channel-mask to array
Date:   Thu, 26 Sep 2019 14:19:51 +0300
Message-ID: <20190926111954.9184-1-peter.ujfalusi@ti.com>
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

