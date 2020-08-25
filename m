Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F242251700
	for <lists+dmaengine@lfdr.de>; Tue, 25 Aug 2020 13:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbgHYLDq (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 25 Aug 2020 07:03:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:55120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYLDk (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 25 Aug 2020 07:03:40 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3288E2068F;
        Tue, 25 Aug 2020 11:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598353415;
        bh=HD4MMVOGgY8JXSjj7Iost304s75Jb2AgemF7ANQnUiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xuoJ6oVW/GOChybNh2GNP7yM3OlaZTn5V0WZWY+TQ89PNF0Kg1SavcMzGBQAsFoJU
         AmwM4k7QiVKfQoY6g/efWAtSfVX2KEZum1NDim5l3IKvpv0VhFfv7wEEDPUneX7dBR
         tAp4AllgWg4FO/X7gY0pyx9W0nvoVJA97ANA7bwA=
Date:   Tue, 25 Aug 2020 16:33:31 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Allen Pais <allen.lkml@gmail.com>
Cc:     linus.walleij@linaro.org, vireshk@kernel.org, leoyang.li@nxp.com,
        zw@zh-kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        matthias.bgg@gmail.com, agross@kernel.org,
        bjorn.andersson@linaro.org, baohua@kernel.org, wens@csie.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH 00/35] dma: convert tasklets to use new tasklet_setup()
Message-ID: <20200825110331.GG2639@vkoul-mobl>
References: <20200818090638.26362-1-allen.lkml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818090638.26362-1-allen.lkml@gmail.com>
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Allen,

On 18-08-20, 14:36, Allen Pais wrote:
> Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
> introduced a new tasklet initialization API. This series converts
> all the dma drivers to use the new tasklet_setup() API
> 
> This is based on 5.9-rc1.
> 
> Please pick this series, as I missed updating a couple of fixes and marking
> the correct mailing list.

The patches should have been tagged "dmaengine: ...".

What is the status of this API conversion, I think I saw some
discussions on API change, what is the conclusion?

Thanks

> 
> Allen Pais (35):
>   dma: altera-msgdma: convert tasklets to use new tasklet_setup() API
>   dma: at_hdmac: convert tasklets to use new tasklet_setup() API
>   dma: at_xdmac: convert tasklets to use new tasklet_setup() API
>   dma: coh901318: convert tasklets to use new tasklet_setup() API
>   dma: dw: convert tasklets to use new tasklet_setup() API
>   dma: ep93xx: convert tasklets to use new tasklet_setup() API
>   dma: fsl: convert tasklets to use new tasklet_setup() API
>   dma: imx-dma: convert tasklets to use new tasklet_setup() API
>   dma: ioat: convert tasklets to use new tasklet_setup() API
>   dma: iop_adma: convert tasklets to use new tasklet_setup() API
>   dma: ipu: convert tasklets to use new tasklet_setup() API
>   dma: k3dma: convert tasklets to use new tasklet_setup() API
>   dma: mediatek: convert tasklets to use new tasklet_setup() API
>   dma: mmp: convert tasklets to use new tasklet_setup() API
>   dma: mpc512x: convert tasklets to use new tasklet_setup() API
>   dma: mv_xor: convert tasklets to use new tasklet_setup() API
>   dma: mxs-dma: convert tasklets to use new tasklet_setup() API
>   dma: nbpfaxi: convert tasklets to use new tasklet_setup() API
>   dma: pch_dma: convert tasklets to use new tasklet_setup() API
>   dma: pl330: convert tasklets to use new tasklet_setup() API
>   dma: ppc4xx: convert tasklets to use new tasklet_setup() API
>   dma: qcom: convert tasklets to use new tasklet_setup() API
>   dma: sa11x0: convert tasklets to use new tasklet_setup() API
>   dma: sirf-dma: convert tasklets to use new tasklet_setup() API
>   dma: ste_dma40: convert tasklets to use new tasklet_setup() API
>   dma: sun6i: convert tasklets to use new tasklet_setup() API
>   dma: tegra20: convert tasklets to use new tasklet_setup() API
>   dma: timb_dma: convert tasklets to use new tasklet_setup() API
>   dma: txx9dmac: convert tasklets to use new tasklet_setup() API
>   dma: virt-dma: convert tasklets to use new tasklet_setup() API
>   dma: xgene: convert tasklets to use new tasklet_setup() API
>   dma: xilinx: convert tasklets to use new tasklet_setup() API
>   dma: plx_dma: convert tasklets to use new tasklet_setup() API
>   dma: sf-pdma: convert tasklets to use new tasklet_setup() API
>   dma: k3-udma: convert tasklets to use new tasklet_setup() API
> 
>  drivers/dma/altera-msgdma.c      |  6 +++---
>  drivers/dma/at_hdmac.c           |  7 +++----
>  drivers/dma/at_xdmac.c           |  7 +++----
>  drivers/dma/coh901318.c          |  7 +++----
>  drivers/dma/dw/core.c            |  6 +++---
>  drivers/dma/ep93xx_dma.c         |  7 +++----
>  drivers/dma/fsl_raid.c           |  6 +++---
>  drivers/dma/fsldma.c             |  6 +++---
>  drivers/dma/imx-dma.c            |  7 +++----
>  drivers/dma/ioat/dma.c           |  6 +++---
>  drivers/dma/ioat/dma.h           |  2 +-
>  drivers/dma/ioat/init.c          |  4 +---
>  drivers/dma/iop-adma.c           |  8 ++++----
>  drivers/dma/ipu/ipu_idmac.c      |  6 +++---
>  drivers/dma/k3dma.c              |  6 +++---
>  drivers/dma/mediatek/mtk-cqdma.c |  7 +++----
>  drivers/dma/mmp_pdma.c           |  6 +++---
>  drivers/dma/mmp_tdma.c           |  6 +++---
>  drivers/dma/mpc512x_dma.c        |  6 +++---
>  drivers/dma/mv_xor.c             |  7 +++----
>  drivers/dma/mv_xor_v2.c          |  8 ++++----
>  drivers/dma/mxs-dma.c            |  7 +++----
>  drivers/dma/nbpfaxi.c            |  6 +++---
>  drivers/dma/pch_dma.c            |  7 +++----
>  drivers/dma/pl330.c              | 12 ++++++------
>  drivers/dma/plx_dma.c            |  7 +++----
>  drivers/dma/ppc4xx/adma.c        |  7 +++----
>  drivers/dma/qcom/bam_dma.c       |  6 +++---
>  drivers/dma/qcom/hidma.c         |  6 +++---
>  drivers/dma/qcom/hidma_ll.c      |  6 +++---
>  drivers/dma/sa11x0-dma.c         |  6 +++---
>  drivers/dma/sf-pdma/sf-pdma.c    | 14 ++++++--------
>  drivers/dma/sirf-dma.c           |  6 +++---
>  drivers/dma/ste_dma40.c          |  7 +++----
>  drivers/dma/sun6i-dma.c          |  6 +++---
>  drivers/dma/tegra20-apb-dma.c    |  7 +++----
>  drivers/dma/ti/k3-udma.c         |  7 +++----
>  drivers/dma/timb_dma.c           |  6 +++---
>  drivers/dma/txx9dmac.c           | 14 ++++++--------
>  drivers/dma/virt-dma.c           |  6 +++---
>  drivers/dma/xgene-dma.c          |  7 +++----
>  drivers/dma/xilinx/xilinx_dma.c  |  7 +++----
>  drivers/dma/xilinx/zynqmp_dma.c  |  6 +++---
>  43 files changed, 136 insertions(+), 158 deletions(-)
> 
> -- 
> 2.17.1

-- 
~Vinod
