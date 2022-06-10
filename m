Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F380545E4D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jun 2022 10:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343996AbiFJIOx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jun 2022 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346746AbiFJIOv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jun 2022 04:14:51 -0400
X-Greylist: delayed 393 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 01:14:49 PDT
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C10D3A5AAA;
        Fri, 10 Jun 2022 01:14:49 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id 9473516A0;
        Fri, 10 Jun 2022 11:08:57 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com 9473516A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1654848540;
        bh=P0epdiQ2UfkKeER5KtOFqFsZ8/0xaqJ7ab4vUUQPTCw=;
        h=From:To:CC:Subject:Date:From;
        b=FES/RpZBcFEtKNYzfj2ZM1TKH3v4j1D1srCu1QFX0yo+vxrndl74dC/lOEO0AROoD
         E9WiAns/InODAMwuQ3yGDm0SYSUjNGDlAku4e4gJHtto+ZKLwtUZuRhTH6qiwi2G8o
         Wx1WzoKWULlo6KhIEebDed0WI8cU+7OfayCvYSmE=
Received: from localhost (192.168.53.207) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 10 Jun 2022 11:08:05 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Srujana Challa <schalla@marvell.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        <linux-crypto@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>,
        <dmaengine@vger.kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        <linux-renesas-soc@vger.kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Oded Gabbay <ogabbay@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        <linux-arm-msm@vger.kernel.org>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, <ntb@lists.linux.dev>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] dma-direct: take dma-ranges/offsets into account in resource mapping
Date:   Fri, 10 Jun 2022 11:08:02 +0300
Message-ID: <20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

A basic device-specific linear memory mapping was introduced back in
commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
preserved in the device.dma_pfn_offset field, which was initialized for
instance by means of the "dma-ranges" DT property. Afterwards the
functionality was extended to support more than one device-specific region
defined in the device.dma_range_map list of maps. But all of these
improvements concerned a single pointer, page or sg DMA-mapping methods,
while the system resource mapping function turned to miss the
corresponding modification. Thus the dma_direct_map_resource() method now
just casts the CPU physical address to the device DMA address with no
dma-ranges-based mapping taking into account, which is obviously wrong.
Let's fix it by using the phys_to_dma_direct() method to get the
device-specific bus address from the passed memory resource for the case
of the directly mapped DMA.

Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

---

After a long discussion with Christoph and Robin regarding this patch
here:
https://lore.kernel.org/lkml/20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru
and here
https://lore.kernel.org/linux-pci/20220503225104.12108-2-Sergey.Semin@baikalelectronics.ru/
It was decided to consult with wider maintainers audience whether it's ok
to accept the change as is or a more sophisticated solution needs to be
found for the non-linear direct MMIO mapping.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

file: arch/arm/mach-orion5x/board-dt.c
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: linux-arm-kernel@lists.infradead.org

file: drivers/crypto/marvell/cesa/cesa.c
Cc: Srujana Challa <schalla@marvell.com>
Cc: Arnaud Ebalard <arno@natisbad.org>
Cc: Boris Brezillon <bbrezillon@kernel.org>
Cc: linux-crypto@vger.kernel.org

file: drivers/dma/{fsl-edma-common.c,pl330.c,sh/rcar-dmac.c}
Cc: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org

file: arch/arm/boot/dts/{vfxxx.dtsi,ls1021a.dtsi,imx7ulp.dtsi,fsl-ls1043a.dtsi}
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org

file: arch/arm/boot/dts/r8a77*.dtsi, arch/arm64/boot/dts/renesas/r8a77*.dtsi
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org

file: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>

file: drivers/gpu/drm/virtio/virtgpu_vram.c
Cc: David Airlie <airlied@linux.ie>
Cc: Gerd Hoffmann <kraxel@redhat.com>

file: drivers/media/common/videobuf2/videobuf2-dma-contig.c
Cc: Tomasz Figa <tfiga@chromium.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>

file: drivers/misc/habanalabs/common/memory.c
Cc: Oded Gabbay <ogabbay@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

file: drivers/mtd/nand/raw/qcom_nandc.c
Cc: Manivannan Sadhasivam <mani@kernel.org>

file: arch/arm64/boot/dts/qcom/{ipq8074.dtsi,ipq6018.dtsi,qcom-sdx55.dtsi,qcom-ipq4019.dtsi,qcom-ipq8064.dtsi}
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org

file: drivers/net/ethernet/marvell/octeontx2/af/rvu.c
Cc: Sunil Goutham <sgoutham@marvell.com>
Cc: Linu Cherian <lcherian@marvell.com>
Cc: Geetha sowjanya <gakula@marvell.com>

file: drivers/ntb/ntb_transport.c
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9743c6ccce1a..bc06db74dfdb 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -497,7 +497,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir, unsigned long attrs)
 {
-	dma_addr_t dma_addr = paddr;
+	dma_addr_t dma_addr = phys_to_dma_direct(dev, paddr);
 
 	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
 		dev_err_once(dev,
-- 
2.35.1

