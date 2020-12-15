Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77342DADD2
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 14:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728501AbgLONNj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 08:13:39 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:37526 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgLONNj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Dec 2020 08:13:39 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BFDCnIS038054;
        Tue, 15 Dec 2020 07:12:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1608037969;
        bh=EWmVCvimxrwVI8v589mVNvUA9U7qN+JGJthzwW6Yrs8=;
        h=From:To:CC:Subject:Date;
        b=zWF2Ucxvvcoi1P7BdYFMRLVLbSYlOMnvXI28cAD6PfLo5NMve+vr/1oV0ph88jTTC
         xKaLfNGuVnezO4YDsoNqocecqcZQ/0nOIA26jRNjQoXE84LbZVpiUZzaKLdRcYnwze
         U5SaLh6TtDTiXiqD25Hchjt9ijW24tHijc1Dya40=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BFDCneO099628
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Dec 2020 07:12:49 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Dec 2020 07:12:49 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Dec 2020 07:12:49 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BFDCjkt037808;
        Tue, 15 Dec 2020 07:12:46 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <peter.ujfalusi@gmail.com>
CC:     <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <vigneshr@ti.com>,
        <grygorii.strashko@ti.com>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <tony@atomide.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/2] dmaengine: ti: Maintainer mail address change
Date:   Tue, 15 Dec 2020 15:13:46 +0200
Message-ID: <20201215131348.11282-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi,

My TI address is going to bounce after Friday (18.12.2020), switch my address to
my private one for now.

Regards,
Peter
---
Peter Ujfalusi (2):
  MAINTAINERS: Add entry for Texas Instruments DMA drivers
  dt-bindings: dma: ti: Update maintainer and author information

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml        |  4 +++-
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml       |  4 +++-
 .../devicetree/bindings/dma/ti/k3-udma.yaml         |  4 +++-
 MAINTAINERS                                         | 13 +++++++++++++
 4 files changed, 22 insertions(+), 3 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

