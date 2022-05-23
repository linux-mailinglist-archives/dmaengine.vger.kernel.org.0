Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7992153108C
	for <lists+dmaengine@lfdr.de>; Mon, 23 May 2022 15:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiEWLGz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 07:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiEWLGy (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 07:06:54 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44ED248E6;
        Mon, 23 May 2022 04:06:52 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id br17so12625513lfb.2;
        Mon, 23 May 2022 04:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jsy4mAgZhGmvO2e1F6vd27JF9COzA3o3JEt2jxRswBk=;
        b=HYJxXxD2mc4rz7bUxx0a72s4o8XQzS+bpQ6tFTLS9arEQHg5J+7A+zk9GVOuCW7Wmy
         ueQnG0VX5n2xduPj9M8BaI3vcuc988zIErw3FySk3jjElQ/HtHnE/rcLzuTKh0O6GIat
         0133NbEeiUCbzWR+ixhFpS+IfoeEvJy0PvYOjNwTctJbNFnA51U66kv1xjoD+kzEryv3
         NXj6Ok5akS3Qv3VI1kHHAaC8prLrmGoWD37a1RvNnp1lltBwr22P5RQu2yBqo9K5lYrp
         nBEzkPhgbkjVILPoQ+pzlDeq2/TBDzZuIBL2NMeL23L+hKltfipBpNNvLP0e21czH2qH
         19dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jsy4mAgZhGmvO2e1F6vd27JF9COzA3o3JEt2jxRswBk=;
        b=r5/gXCG5rBP/Ba1In3J/5BQ1e10NTavgOwGkZUI0+6kG4siUjB4x6hD0uj6T+PxjwC
         6TK7aKDaIblkO8EG/2ybehvjHauGrOeCEWEic8y2g8NcuqW8lNrCBFfmiJZw7qw5Zl6j
         VsN37c8P1ARvC2sAN9eEJBkWXG6WMfr8Tyo8w5xhrjp2FP+ghypnvlQi90ULmDV7r7QX
         cEKMoZh6GG1QnZ7gJ2/rsKKfgC0eoRDVrjhpX+6QyhxPhdB+3Cj2Emcdx2ld3ijgu7ZJ
         xAY9/DCLOZ+bD8c8nHB8h+4YD0SQSmiD3iCvBw65TruiAQmNLObdcKAmMAoFRvAcLUR0
         k6mg==
X-Gm-Message-State: AOAM533dWUK/s46ca5Oypc/H71xykwCbpLVXm1sip/Y/4BNef6KWXagi
        3Hzi6Xz9BEzqRwLze6D+v/U=
X-Google-Smtp-Source: ABdhPJwzr7j//CefeblT0s2YSmDOXbceMrzPkqf/qbDFrGJ1jXxKwWlTYMbSaQdC+j2CHxoLM4QXfQ==
X-Received: by 2002:a05:6512:4019:b0:478:79ba:f94e with SMTP id br25-20020a056512401900b0047879baf94emr1817977lfb.260.1653304010885;
        Mon, 23 May 2022 04:06:50 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id p20-20020ac24ed4000000b0047255d210easm1919220lfr.25.2022.05.23.04.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 04:06:50 -0700 (PDT)
Date:   Mon, 23 May 2022 14:06:47 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v11 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220523110647.ndhijpwgtaf2rkar@mobilestation>
References: <20220517151915.2212838-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517151915.2212838-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Vinod,

On Tue, May 17, 2022 at 10:19:07AM -0500, Frank Li wrote:
> Default Designware EDMA just probe remotely at host side.
> This patch allow EDMA driver can probe at EP side.
> 
> 1. Clean up patch
>    dmaengine: dw-edma: Detach the private data and chip info structures
>    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
>    dmaengine: dw-edma: Change rg_region to reg_base in struct
>    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> 
> 2. Enhance EDMA driver to allow prode eDMA at EP side
>    dmaengine: dw-edma: Add support for chip specific flags
>    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> flags (this patch removed at v11 because dma tree already have fixed
> patch)
> 
> 3. Bugs fix at EDMA driver when probe eDMA at EP side
>    dmaengine: dw-edma: Fix programming the source & dest addresses for
> ep
>    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> 
> 4. change pci-epf-test to use EDMA driver to transfer data.
>    PCI: endpoint: Add embedded DMA controller test
> 
> 5. Using imx8dxl to do test, but some EP functions still have not
> upstream yet. So below patch show how probe eDMA driver at EP
> controller driver.
> https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097

The series has been hanging out on review for over three months now.
It has got to v11 and has been tested on at least two platforms. The
original driver maintainer has been silent for all that time (most
likely Gustavo dropped the driver maintaining role). Could you please
merge it in seeing no comments have been posted for the last several
weeks? The PCI Host/EP controller drivers maintainer suggested to get
this series via the DMA-engine tree:
https://lore.kernel.org/linux-pci/YnqlRShJzvma2SKM@lpieralisi/
which is obviously right seeing it mainly concerns the DW eDMA driver.
Though after that Lorenzo disappeared as quickly as popped up.)

There is one more series depending on the changes in this
patchset:
https://lore.kernel.org/linux-pci/20220503225104.12108-1-Sergey.Semin@baikalelectronics.ru/
Me and Frank already settled all the conflicts and inter-dependencies,
so at least his series is more than ready to be merged in into the
kernel repo. It would be very good to get it accepted on this merge
window so to have the kernel v5.19 with all this changes available.

-Sergey

> 
> -- 
> 2.35.1
> 
