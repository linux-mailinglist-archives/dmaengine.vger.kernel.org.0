Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5BD4D4F5A
	for <lists+dmaengine@lfdr.de>; Thu, 10 Mar 2022 17:33:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbiCJQdU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 10 Mar 2022 11:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238790AbiCJQdT (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 10 Mar 2022 11:33:19 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5CA190C38;
        Thu, 10 Mar 2022 08:32:17 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u7so8463627ljk.13;
        Thu, 10 Mar 2022 08:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NWDdeLrbeCqsnmEn/iLg2ZwaG6zMmRBymTE/gjpf0Ls=;
        b=BKj9KfmqaqWK0qTjwNaGYcR8XA4lHP5G2pa6a0VYePqeuq2neQNxIYYOSHxJFXNFFw
         O7nrqtAqNsaUwaTf3yRXQCjnFIUFNeITnIElXpsqHr1G7LB16G+o2KSWdhfHkeAmUgHR
         1sp4LK9FNKK/HbM2x9cu29bMvbsmuGzqGtg6hz957mi2bl0kct9AbD4YUo1aQohOzz8F
         oShyG5RScZ8kN1wzmZHzlWoogIF90Wkmj6dUf1Rtx/wJGU2YnCGrWBaZY58OP571BCut
         TC9P7NMxHEkGGmOfwixJIzL9TRk/NRczjc9dnuVkMIT2VrsYuvVP5ukw3FmYYfVtDEdj
         2DjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NWDdeLrbeCqsnmEn/iLg2ZwaG6zMmRBymTE/gjpf0Ls=;
        b=XN0kgILfR+Ss0kRfXU18dHJe5ZqT+zsUO+fDnjpZwuSuGEh166iKGb0SDy8zY7Rz8q
         fhxO7qHD33pYL25PVIoZTMr6K4a6AdYZ6Uax9vjVIw2O0R2mLbwXeeqJG/Ci/+sw1aaM
         CiQjZkMw5Vow9ytFM2TIjoSZXpTE92vgvLsj9yTBwi2QjIKd8zEblPWoDMvGjmkNySdw
         xoZjuCNhRScmOVOqGt+jCvxSr50Fy8M3e9sR+jQRV2W3i/lkTC38VBuFv7cVvu/Z4WSX
         QwIqzk0QTtCUfprgqgjHswPVShrl7m7w0iRKrgfJldXF53YDUE9YZThFECN1qAiBfYE4
         o27Q==
X-Gm-Message-State: AOAM532RqIxTkCnXDYq0gic06+W1jaiyEROqw1IkRpLNon5ycpPr2nz+
        +nuJOq8VpZ3FgSxzCyzZ2D4=
X-Google-Smtp-Source: ABdhPJxjBuS6ZRuM+0CVMR3sT0oM7tbXNWYbIuQdMoan7tZqYl9eXTKP2oZJMQiLDDAMwo6OYTocQw==
X-Received: by 2002:a05:651c:b10:b0:247:f37f:f595 with SMTP id b16-20020a05651c0b1000b00247f37ff595mr3495293ljr.444.1646929933929;
        Thu, 10 Mar 2022 08:32:13 -0800 (PST)
Received: from mobilestation ([95.79.188.22])
        by smtp.gmail.com with ESMTPSA id w17-20020a05651204d100b0044828a5ed22sm1055144lfq.68.2022.03.10.08.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 08:31:47 -0800 (PST)
Date:   Thu, 10 Mar 2022 19:31:23 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, vkoul@kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        shawnguo@kernel.org, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v4 5/8] dmaengine: dw-edma: Fix programming the source &
 dest addresses for ep
Message-ID: <20220310163123.h2zqdx5tkn2czmbm@mobilestation>
References: <20220309211204.26050-1-Frank.Li@nxp.com>
 <20220309211204.26050-6-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309211204.26050-6-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Mar 09, 2022 at 03:12:01PM -0600, Frank Li wrote:
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> When eDMA is controlled by the Endpoint (EP), the current logic incorrectly
> programs the source and destination addresses for read and write. Since the
> Root complex and Endpoint uses the opposite channels for read/write, fix the
> issue by finding out the read operation first and program the eDMA accordingly.
> 
> Cc: stable@vger.kernel.org
> Fixes: bd96f1b2f43a ("dmaengine: dw-edma: support local dma device transfer semantics")
> Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> No change between v1 to v4
> 
>  drivers/dma/dw-edma/dw-edma-core.c | 32 +++++++++++++++++++++++++++++-
>  1 file changed, 31 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 66dc650577919..507f08db1aad3 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -334,6 +334,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  	struct dw_edma_chunk *chunk;
>  	struct dw_edma_burst *burst;
>  	struct dw_edma_desc *desc;
> +	bool read = false;
>  	u32 cnt = 0;
>  	int i;
>  
> @@ -424,7 +425,36 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
>  		chunk->ll_region.sz += burst->sz;
>  		desc->alloc_sz += burst->sz;
>  
> -		if (chan->dir == EDMA_DIR_WRITE) {
> +		/****************************************************************
> +		 *

> +		 *        Root Complex                           Endpoint
> +		 * +-----------------------+             +----------------------+
> +		 * |                       |    TX CH    |                      |
> +		 * |                       |             |                      |
> +		 * |      DEV_TO_MEM       <-------------+     MEM_TO_DEV       |
> +		 * |                       |             |                      |
> +		 * |                       |             |                      |
> +		 * |      MEM_TO_DEV       +------------->     DEV_TO_MEM       |
> +		 * |                       |             |                      |
> +		 * |                       |    RX CH    |                      |
> +		 * +-----------------------+             +----------------------+
> +		 *
> +		 * If eDMA is controlled by the Root complex, TX channel
> +		 * (EDMA_DIR_WRITE) is used for memory read (DEV_TO_MEM) and RX
> +		 * channel (EDMA_DIR_READ) is used for memory write (MEM_TO_DEV).
> +		 *
> +		 * If eDMA is controlled by the endpoint, RX channel
> +		 * (EDMA_DIR_READ) is used for memory read (DEV_TO_MEM) and TX
> +		 * channel (EDMA_DIR_WRITE) is used for memory write (MEM_TO_DEV).

Either I have some wrong notion about this issue, or something wrong
with the explanation above and with this fix below.

From my understanding of the possible DW eDMA IP-core setups the
scatch above and the text below it are incorrect. Here is the way the
DW eDMA can be used:
1) Embedded into the DW PCIe Host/EP controller. In this case
CPU/Application Memory is the memory of the CPU attached to the
host/EP controller, while the remote (link partner) memory is the PCIe
bus memory. In this case MEM_TO_DEV operation is supposed to be
performed by the Tx/Write channels, while the DEV_TO_MEM operation -
by the Rx/Read channels.

Note it's applicable for both Host and End-point case, when Linux is
running on the CPU-side of the eDMA controller. So if it's DW PCIe
end-point, then MEM_TO_DEV means copying data from the local CPU
memory into the remote memory. In general the remote memory can be
either some PCIe device on the bus or the Root Complex' CPU memory,
each of which is some remote device anyway from the Local CPU
perspective.

2) Embedded into the PCIe EP. This case is implemented in the
drivers/dma/dw-edma/dw-edma-pcie.c driver. AFAICS from the commits log
and from the driver code, that device is a Synopsys PCIe EndPoint IP
prototype kit. It is a normal PCIe peripheral device with eDMA
embedded, which CPU/Application interface is connected to some
embedded SRAM while remote (link partner) interface is directed
towards the PCIe bus. At the same time the device is setup and handled
by the code running on a CPU connected to the PCIe Host controller.  I
think that in order to preserve the normal DMA operations semantics we
still need to consider the MEM_TO_DEV/DEV_TO_MEM operations from the
host CPU perspective, since that's the side the DMA controller is
supposed to be setup from.  In this MEM_TO_DEV is supposed to be used
to copy data from the host CPU memory into the remote device memory.
It means to allocate Rx/Read channel on the eDMA controller, so one
would be read data from the Local CPU memory and copied it to the PCIe
device SRAM. The logic of the DEV_TO_MEM direction would be just
flipped. The eDMA PCIe device shall use Tx/Write channel to copy data
from it's SRAM into the Host CPU memory.

Please note as I understand the case 2) describes the Synopsys PCIe
EndPoint IP prototype kit, which is based on some FPGA code. It's just
a test setup with no real application, while the case 1) is a real setup
available on our SoC and I guess on yours.

So what I suggest in the framework of this patch is just to implement
the case 1) only. While the case 2) as it's an artificial one can be
manually handled by the DMA client drivers. BTW There aren't ones available
in the kernel anyway. The only exception is an old-time attempt to get
an eDMA IP test-driver mainlined into the kernel:
https://patchwork.kernel.org/project/linux-pci/patch/cc195ac53839b318764c8f6502002cd6d933a923.1547230339.git.gustavo.pimentel@synopsys.com/
But it was long time ago. So it's unlikely to be accepted at all.

What do you think?

-Sergey

> +		 *
> +		 ****************************************************************/
> +

> +		if ((dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ) ||
> +		    (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE))
> +			read = true;

Seeing the driver support only two directions DMA_DEV_TO_MEM/DMA_DEV_TO_MEM
and EDMA_DIR_READ/EDMA_DIR_WRITE, this conditional statement seems
redundant.

> +
> +		/* Program the source and destination addresses for DMA read/write */
> +		if (read) {
>  			burst->sar = src_addr;
>  			if (xfer->type == EDMA_XFER_CYCLIC) {
>  				burst->dar = xfer->xfer.cyclic.paddr;
> -- 
> 2.24.0.rc1
> 
