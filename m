Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF0D2BD175
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391713AbfIXSNg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 14:13:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:44010 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505058AbfIXSNC (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 14:13:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D4F0DAF03;
        Tue, 24 Sep 2019 18:12:59 +0000 (UTC)
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
Subject: [PATCH 07/11] dts: arm64: layerscape: add dma-ranges property to qoric-mc node
Date:   Tue, 24 Sep 2019 20:12:38 +0200
Message-Id: <20190924181244.7159-8-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

qoriq-mc's dpmacs DMA configuration is inherited from their parent node,
which acts a bus in this regard. So far it maked all devices as
dma-coherent but no dma-ranges recommendation is made.

The truth is that the underlying interconnect has DMA constraints, so
add an empty dma-ranges in qoriq-mc's node in order for DT's DMA
configuration code to get the DMA constraints from it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 1 +
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index c676d0771762..f0d0b6145b72 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -698,6 +698,7 @@
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent = <&its>;
 			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
+			dma-ranges;
 			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 7a0be8eaa84a..fd6036b7865c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -340,6 +340,7 @@
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent = <&its>;
 			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
+			dma-ranges;
 			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 408e0ecdce6a..3735bb139cb2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -868,6 +868,7 @@
 			msi-parent = <&its>;
 			/* iommu-map property is fixed up by u-boot */
 			iommu-map = <0 &smmu 0 0>;
+			dma-ranges;
 			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
-- 
2.23.0

