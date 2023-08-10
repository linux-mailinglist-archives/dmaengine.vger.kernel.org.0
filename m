Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60133777F5C
	for <lists+dmaengine@lfdr.de>; Thu, 10 Aug 2023 19:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjHJRoM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Aug 2023 13:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjHJRoL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Aug 2023 13:44:11 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDD82705;
        Thu, 10 Aug 2023 10:44:10 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37AHi2fT117069;
        Thu, 10 Aug 2023 12:44:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691689443;
        bh=78+V1xmCMlA74/IzI/mywu3u6xqRMhUuh0iKICDmXWY=;
        h=From:To:CC:Subject:Date;
        b=BFvbMmNxnc2dpmpVxHQ1vrbhRuzPSBqegAhoDziFJoLPlhqeiPNutQoQ+uyROR0QV
         5bQdaoY9NtdQcx9zlz7HXsmdWLxl/Auzbdyh6aP6l3bIgzq60XcR4i22xluWT1fh9Y
         GDjBQ91QXtQRJ1zYV3IBUT8AKBAWOfL5y/8CiUqk=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37AHi2SA046519
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Aug 2023 12:44:02 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 10
 Aug 2023 12:44:02 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 10 Aug 2023 12:44:02 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37AHhxuf084260;
        Thu, 10 Aug 2023 12:43:59 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH 0/3] dt-bindings: dma: ti: k3* : Update optional reg regions
Date:   Thu, 10 Aug 2023 23:13:52 +0530
Message-ID: <20230810174356.3322583-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

DMAs on TI K3 SoCs have channel configuration registers region which are
usually hidden from Linux and configured via Device Manager Firmware
APIs. But certain early SWs like bootloader which run before Device
Manager is fully up would need to directly configure these registers and
thus require to be in DT description.

This add bindings for such configuration regions.  Backward
compatibility is maintained to existing DT by only mandating existing
regions to be present and this new region as optional.

Vignesh Raghavendra (3):
  dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
  dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
  dt-bindings: dma: ti: k3-udma: Describe cfg register regions

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 25 +++++++++++++------
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 18 ++++++++++---
 .../devicetree/bindings/dma/ti/k3-udma.yaml   | 14 ++++++++---
 3 files changed, 43 insertions(+), 14 deletions(-)

-- 
2.41.0

