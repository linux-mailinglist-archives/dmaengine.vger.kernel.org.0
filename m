Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F705526A4
	for <lists+dmaengine@lfdr.de>; Mon, 20 Jun 2022 23:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245139AbiFTViD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 20 Jun 2022 17:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiFTViC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 20 Jun 2022 17:38:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B874917E06;
        Mon, 20 Jun 2022 14:38:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id j21so6136396lfe.1;
        Mon, 20 Jun 2022 14:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EgAnwP4MqXgu0q0d6eXWE8mU2Kiz+p4e1fpGeFSH/Y8=;
        b=o2pZhsbnmZB/hPYNsAdRYKSGEUThCWUrSiKDope47O0Hc6y1Ie/Uhr9vlzSWLA7VnO
         6lN78P1MVEepVV3liDs+f/UB+HrgEgGkF966GYg6fLnqq8wNHYQe6N3JVso5Fyy44o6y
         MTQQwOrei2MX3mKbp2o5cf+Ro3YqXr9BSPZ5sDofxPvIy+Jve8CIopY4koLos6Miyhim
         HbI7xS8hrxSimFq+buz+51JhYFW3Umf1FryhoF2UDYiuUfKl62C81eqe/XBlIMtqb1Un
         gQyf5QE3lnyE367qbAyXYc4b7q6kAK5See9cks50Cphd4BQMI3b++pGIJWMs08WbeyvQ
         Qelg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EgAnwP4MqXgu0q0d6eXWE8mU2Kiz+p4e1fpGeFSH/Y8=;
        b=7RiOEA/bzBRath7sC7zWrFcuenBQGUwlcGUlmBrYYf2/bVUJVEMUlSkJFt82hxSpDK
         jaMHk23RDo784UrVglD76cdP/x3CTw+sps4u3JGqxjgjlwbenKnTn1TGrwuuO0r45tyQ
         lDzmy7sOioELHgrK2K0JT4sTVV8YJKh3sc27bkt7Cc45BxQAcY96NFR/SKjramP+3BO3
         g2d2nMlwRFscd9EhR6jSF47Cc0G2jR7RZNtfnwFA0Sd31aCHJsSNsMzkzfLf10PLhdq3
         RNESImdLMu3Hz8W7BSeKoWks2jqPXuxnuMbaQPLNNtWpwQ45tbmdWDJhaVThBwmNUDp6
         BR2Q==
X-Gm-Message-State: AJIora/cPLw00Ly/TAOP0b36pw4ysBN97ReNMWq0mK0qXJzKh/e/phif
        wDNj4YeT8pQISdPIhHLieN4=
X-Google-Smtp-Source: AGRyM1s0d2VrYvy3auZpZcZEHLNE88miIB37xA3w0baRw5oXY3mn7ZteuCobzjV8K7l5aFMU1SrfTQ==
X-Received: by 2002:a05:6512:b1c:b0:47d:df52:b5a9 with SMTP id w28-20020a0565120b1c00b0047ddf52b5a9mr13983505lfu.293.1655761079086;
        Mon, 20 Jun 2022 14:37:59 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id m3-20020a05651202e300b0047f647414eesm992667lfq.229.2022.06.20.14.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 14:37:58 -0700 (PDT)
Date:   Tue, 21 Jun 2022 00:37:55 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Srujana Challa <schalla@marvell.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-crypto@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        dmaengine@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        linux-renesas-soc@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
        linux-arm-msm@vger.kernel.org,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, ntb@lists.linux.dev,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-direct: take dma-ranges/offsets into account in
 resource mapping
Message-ID: <20220620213755.kczuriyildoublzi@mobilestation>
References: <20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220610080802.11147-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Folks,

On Fri, Jun 10, 2022 at 11:08:02AM +0300, Serge Semin wrote:
> A basic device-specific linear memory mapping was introduced back in
> commit ("dma: Take into account dma_pfn_offset") as a single-valued offset
> preserved in the device.dma_pfn_offset field, which was initialized for
> instance by means of the "dma-ranges" DT property. Afterwards the
> functionality was extended to support more than one device-specific region
> defined in the device.dma_range_map list of maps. But all of these
> improvements concerned a single pointer, page or sg DMA-mapping methods,
> while the system resource mapping function turned to miss the
> corresponding modification. Thus the dma_direct_map_resource() method now
> just casts the CPU physical address to the device DMA address with no
> dma-ranges-based mapping taking into account, which is obviously wrong.
> Let's fix it by using the phys_to_dma_direct() method to get the
> device-specific bus address from the passed memory resource for the case
> of the directly mapped DMA.

So any comment on the suggest modification? Any notes against or for?

-Sergey

> 
> Fixes: 25f1e1887088 ("dma: Take into account dma_pfn_offset")
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> ---
> 
> After a long discussion with Christoph and Robin regarding this patch
> here:
> https://lore.kernel.org/lkml/20220324014836.19149-4-Sergey.Semin@baikalelectronics.ru
> and here
> https://lore.kernel.org/linux-pci/20220503225104.12108-2-Sergey.Semin@baikalelectronics.ru/
> It was decided to consult with wider maintainers audience whether it's ok
> to accept the change as is or a more sophisticated solution needs to be
> found for the non-linear direct MMIO mapping.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> file: arch/arm/mach-orion5x/board-dt.c
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>
> Cc: linux-arm-kernel@lists.infradead.org
> 
> file: drivers/crypto/marvell/cesa/cesa.c
> Cc: Srujana Challa <schalla@marvell.com>
> Cc: Arnaud Ebalard <arno@natisbad.org>
> Cc: Boris Brezillon <bbrezillon@kernel.org>
> Cc: linux-crypto@vger.kernel.org
> 
> file: drivers/dma/{fsl-edma-common.c,pl330.c,sh/rcar-dmac.c}
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org
> 
> file: arch/arm/boot/dts/{vfxxx.dtsi,ls1021a.dtsi,imx7ulp.dtsi,fsl-ls1043a.dtsi}
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Li Yang <leoyang.li@nxp.com>
> Cc: linux-arm-kernel@lists.infradead.org
> 
> file: arch/arm/boot/dts/r8a77*.dtsi, arch/arm64/boot/dts/renesas/r8a77*.dtsi
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: linux-renesas-soc@vger.kernel.org
> 
> file: drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> 
> file: drivers/gpu/drm/virtio/virtgpu_vram.c
> Cc: David Airlie <airlied@linux.ie>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> 
> file: drivers/media/common/videobuf2/videobuf2-dma-contig.c
> Cc: Tomasz Figa <tfiga@chromium.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> 
> file: drivers/misc/habanalabs/common/memory.c
> Cc: Oded Gabbay <ogabbay@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> file: drivers/mtd/nand/raw/qcom_nandc.c
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> 
> file: arch/arm64/boot/dts/qcom/{ipq8074.dtsi,ipq6018.dtsi,qcom-sdx55.dtsi,qcom-ipq4019.dtsi,qcom-ipq8064.dtsi}
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: linux-arm-msm@vger.kernel.org
> 
> file: drivers/net/ethernet/marvell/octeontx2/af/rvu.c
> Cc: Sunil Goutham <sgoutham@marvell.com>
> Cc: Linu Cherian <lcherian@marvell.com>
> Cc: Geetha sowjanya <gakula@marvell.com>
> 
> file: drivers/ntb/ntb_transport.c
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: ntb@lists.linux.dev
> ---
>  kernel/dma/direct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 9743c6ccce1a..bc06db74dfdb 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -497,7 +497,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
>  		size_t size, enum dma_data_direction dir, unsigned long attrs)
>  {
> -	dma_addr_t dma_addr = paddr;
> +	dma_addr_t dma_addr = phys_to_dma_direct(dev, paddr);
>  
>  	if (unlikely(!dma_capable(dev, dma_addr, size, false))) {
>  		dev_err_once(dev,
> -- 
> 2.35.1
> 
