Return-Path: <dmaengine+bounces-174-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 805417F4B41
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 16:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A850B20C2E
	for <lists+dmaengine@lfdr.de>; Wed, 22 Nov 2023 15:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C94EB34;
	Wed, 22 Nov 2023 15:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mji1BkSe"
X-Original-To: dmaengine@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1FF1722;
	Wed, 22 Nov 2023 07:42:53 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFgkoF031020;
	Wed, 22 Nov 2023 09:42:46 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1700667766;
	bh=DLJe1Pv87UHy4+v/+5Kl00sc0UqsngVKRFxbrZDoRBc=;
	h=From:To:CC:Subject:Date;
	b=mji1BkSeSk8jptEDhZpS9TG7R2mKKMR2VLHw0WFskUBSkNtKuiospkQSzYFuezXWv
	 maYIxJIFzleiV9fuBCC5pEkWrgABRPWkz6qWW7MOcMzn2iRLlZjOJzd3PQs+mA3VPR
	 7xjLF7FsySaoedySQEEVOP/Dizw3LS6+/GpDLbk8=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3AMFgkMn011949
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 22 Nov 2023 09:42:46 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 22
 Nov 2023 09:42:45 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 22 Nov 2023 09:42:45 -0600
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3AMFggJl046973;
	Wed, 22 Nov 2023 09:42:43 -0600
From: Vignesh Raghavendra <vigneshr@ti.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v2 0/4] dt-bindings: dma: ti: k3*: Update optional reg regions
Date: Wed, 22 Nov 2023 21:12:34 +0530
Message-ID: <20231122154238.815781-1-vigneshr@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

DMAs on TI K3 SoCs have channel configuration registers region which are
usually hidden from Linux and configured via Device Manager Firmware
APIs. But certain early SWs like bootloader which run before Device
Manager is fully up would need to directly configure these registers and
thus require to be in DT description.

This add bindings for such configuration regions. Backward
compatibility is maintained to existing DT by only mandating existing
regions to be present and this new region as optional.

This update is mainly to aid SPL/U-Boot to reuse kernel DT as is. And is
applicable to entire K3 family of SoCs.

v2:
Fix issues pointed out by Conor and Peter
* Add new patch 1/4 to describe existing register regions
* Rename cfg region as ring
* Add bchan register space for bcdma
* Include descriptions for new registers
v1: https://lore.kernel.org/all/20230810174356.3322583-1-vigneshr@ti.com/

Vignesh Raghavendra (4):
  dt-bindings: dma: ti: k3-*: Add descriptions for register regions
  dt-bindings: dma: ti: k3-bcdma: Describe cfg register regions
  dt-bindings: dma: ti: k3-pktdma: Describe cfg register regions
  dt-bindings: dma: ti: k3-udma: Describe cfg register regions

 .../devicetree/bindings/dma/ti/k3-bcdma.yaml  | 43 +++++++++++++------
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml | 26 +++++++++--
 .../devicetree/bindings/dma/ti/k3-udma.yaml   | 20 +++++++--
 3 files changed, 71 insertions(+), 18 deletions(-)

-- 
2.42.0


