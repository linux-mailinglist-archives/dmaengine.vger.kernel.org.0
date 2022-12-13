Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840F464BA07
	for <lists+dmaengine@lfdr.de>; Tue, 13 Dec 2022 17:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236220AbiLMQnf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 13 Dec 2022 11:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbiLMQn1 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 13 Dec 2022 11:43:27 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3C2F5F67;
        Tue, 13 Dec 2022 08:43:26 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BDGh9AI114127;
        Tue, 13 Dec 2022 10:43:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1670949789;
        bh=mBw15N1zGIeTu7aStLUIDCtD0xQUNTofzGQqICOF8xk=;
        h=From:To:CC:Subject:Date;
        b=gILm9gWOY2FZ36w97vWEOZuvl95h4KyAFpUdWVjJYT/a7U9vAVP8NWOmv4/hw/qGl
         6jFY2w8Fx2O7HaoxBsKMG2rmm6QkpTE2mA6r4BAQqfVQQUsX/xNg3ut0uo1yw8SXxl
         kE4TydLj0NViCK6GrFz1k2WRqm6d5yGeXoQCVcZ4=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BDGh91x130126
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Dec 2022 10:43:09 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 13
 Dec 2022 10:43:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 13 Dec 2022 10:43:09 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BDGh6gI034997;
        Tue, 13 Dec 2022 10:43:06 -0600
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v3 0/5] dmaengine: Add support for AM62A SoC DMAs
Date:   Tue, 13 Dec 2022 22:12:59 +0530
Message-ID: <20221213164304.1126945-1-vigneshr@ti.com>
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

v3:
Fix yaml bindings to constraint regs and reg-names per compatible

v2:
Fix k3-bcdma.yaml as per Krzysztof 's comments
Address's Peter's comment on 2/5
https://lore.kernel.org/r/20221212105416.3628442-1-vigneshr@ti.com

v1:
https://lore.kernel.org/dmaengine/20221206043554.1521522-1-vigneshr@ti.com/

Jai Luthra (1):
  dmaengine: ti: k3-psil-am62a: Add AM62Ax PSIL and PDMA data

Vignesh Raghavendra (4):
  dt-bindings: dma: ti: k3-bcdma: Add bindings for BCDMA CSI RX
  dmaengine: ti: k3-udma: Fix BCDMA for case w/o BCHAN
  dmaengine: ti: k3-udma: Add support for DMAs on AM62A SoC
  dmaengine: ti: k3-udma: Add support for BCDMA CSI RX

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  |  77 +++++--
 drivers/dma/ti/Makefile                       |   3 +-
 drivers/dma/ti/k3-psil-am62a.c                | 196 ++++++++++++++++++
 drivers/dma/ti/k3-psil-priv.h                 |   1 +
 drivers/dma/ti/k3-psil.c                      |   1 +
 drivers/dma/ti/k3-udma.c                      |  41 +++-
 6 files changed, 295 insertions(+), 24 deletions(-)
 create mode 100644 drivers/dma/ti/k3-psil-am62a.c

-- 
2.38.1

