Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01341643C59
	for <lists+dmaengine@lfdr.de>; Tue,  6 Dec 2022 05:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbiLFEgX (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 5 Dec 2022 23:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbiLFEgP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 5 Dec 2022 23:36:15 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6521CFF7;
        Mon,  5 Dec 2022 20:36:12 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2B64a23H037124;
        Mon, 5 Dec 2022 22:36:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670301362;
        bh=WdRbdqRAo0QqVUYfbtG3Z9RWkhGzkz+pgokpkEP4bvg=;
        h=From:To:CC:Subject:Date;
        b=SaC54PlqFb3rWM+J6m911ZUUf+VAd6NPWp2Hz+i5z/xCbwWsfIaQK9HM7mo97c0VJ
         RsvJ1W3bIDgMOKXT31fvPmW0h+0NIi4VDvMAsP0uEjStJQYJMdm5dfLc4JyVRUnVVe
         5XDdJ4kGvo+pLK0/HXod+zGmTw9cr0GmIGgP8UnA=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2B64a215019297
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 5 Dec 2022 22:36:02 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 5
 Dec 2022 22:36:02 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 5 Dec 2022 22:36:01 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2B64Zx2Y097382;
        Mon, 5 Dec 2022 22:35:59 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: [PATCH 0/5] dmaengine: Add support for AM62A SoC DMAs
Date:   Tue, 6 Dec 2022 10:05:49 +0530
Message-ID: <20221206043554.1521522-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

This series introduces support for various DMAs on TI's AM62A SoC under
K3 family of devices.

Apart from usual BCDMA and PKTDMA thats present on K3 family, AM62A has
a dedicated BCDMA for camera (CSI) with only RX DMA Channels.

Patch 1 adds bindings for this new DMA instance
Patch 2 fixes a bug that gets exposed due to RX only DMA
Patch 3 and 4 add base support for AM62A DMA
Patch 5 does BCDMA CSI RX specific enhancements.

Jai Luthra (1):
  dmaengine: ti: k3-psil-am62a: Add AM62Ax PSIL and PDMA data

Vignesh Raghavendra (4):
  dt-bindings: dma: ti: k3-bcdma: Add bindings for BCDMA CSI RX
  dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
  dmaengine: ti: k3-udma: Add support for DMAs on AM62A SoC
  dmaengine: ti: k3-udma: Add support for BCDMA CSI RX

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  |  87 +++++---
 drivers/dma/ti/Makefile                       |   3 +-
 drivers/dma/ti/k3-psil-am62a.c                | 196 ++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h                 |   1 +
 drivers/dma/ti/k3-psil.c                      |   1 +
 drivers/dma/ti/k3-udma.c                      |  39 +++-
 6 files changed, 297 insertions(+), 30 deletions(-)
 create mode 100644 drivers/dma/ti/k3-psil-am62a.c

-- 
2.38.1

