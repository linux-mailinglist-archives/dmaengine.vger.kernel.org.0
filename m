Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E18F2BD15C
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439789AbfIXSNE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:13:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:44168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2439739AbfIXSNE (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:13:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4A5C4ABBD;
        Tue, 24 Sep 2019 18:13:01 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        frowand.list@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        linux-media@vger.kernel.org, linux-pci@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     mbrugger@suse.com, robin.murphy@arm.com, f.fainelli@gmail.com,
        james.quinlan@broadcom.com, wahrenst@gmx.net,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 08/11] dts: arm64: layerscape: add dma-ranges property to pcie nodes
Date:   Tue, 24 Sep 2019 20:12:39 +0200
Message-Id: <20190924181244.7159-9-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The bus behind the board's PCIe core has DMA addressing limitations. Add
an empty 'dma-ranges' property on all PCIe bus descriptions to inform
the OF core that a translation is due further down the line.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index fd6036b7865c..2c41cfc66bb9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -640,6 +640,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			dma-ranges;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			msi-parent = <&its>;
@@ -661,6 +662,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			dma-ranges;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			msi-parent = <&its>;
@@ -682,6 +684,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			dma-ranges;
 			num-viewport = <256>;
 			bus-range = <0x0 0xff>;
 			msi-parent = <&its>;
@@ -703,6 +706,7 @@
 			#size-cells = <2>;
 			device_type = "pci";
 			dma-coherent;
+			dma-ranges;
 			num-viewport = <6>;
 			bus-range = <0x0 0xff>;
 			msi-parent = <&its>;
-- 
2.23.0

