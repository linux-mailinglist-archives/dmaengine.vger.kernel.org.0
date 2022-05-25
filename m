Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669975339DA
	for <lists+dmaengine@lfdr.de>; Wed, 25 May 2022 11:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiEYJXN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 May 2022 05:23:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiEYJXM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 May 2022 05:23:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610268A302;
        Wed, 25 May 2022 02:23:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id l13so28381332lfp.11;
        Wed, 25 May 2022 02:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4RxfjJGzZIGlTYKUTNPy7iJJf13WJP4M7ctgJzA/Pz8=;
        b=FSnZgxNEKP8qzxhKhKrktDCmD29VXv5ub9L3amMtvRuQrNImuF4YXPa2QzYB/A9Tca
         ciSQw1CvX89DqYoEilJ8PGDANx44v0ffdC2LW/oumuNMO8sxnOcv90A7Hgy6ibgOvgU3
         ixrKQEH14h6Fa9OH/Lwy4liy6NHnPCXw3lM9vZUYQ3vwdIYvzvGq3ahKgzOoXu0iKhWB
         OWEpqFlxPgFwTsBEKiy0EYv/l1FkN1n+wg0khCHgr83+xBbm9Hy9on5BixwTLIGP9r0R
         sD8yNX2yG1j2+mXL30z6XuGPzfGTVA7j5nWvIXMcHYRRr/RFK2cOv3yFDlX8dIS0yKAB
         6DCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4RxfjJGzZIGlTYKUTNPy7iJJf13WJP4M7ctgJzA/Pz8=;
        b=tksoXZUp02MZRg14MCi5IywKqZjZvBtzRNVqrLXNhHGjjvPFf557bodsgrYSKJ2HF6
         KWnAiqnJnZ/G3fcF+gmDgg+gZuaxnw+/nVm25hgBisGqWxoVdLyv/FaaoJvxjU0zBIDA
         RKJQ8w8sXmq3JQwbHdTaW6RQHiDeoB7w0tsg+RimgiAnN+1EizGWnI5n6iaIyVIOuzKM
         xwOGF7/OHgFuDFMzqiHGUvesCyfhFQvQBWci7S3ZNSxLCf00K19Ak9D0mnwYNTTCkMzM
         mu/rgiiS/P/0lPGdXMVPEtPPTaqncQdR7VGNOWFDFkAm0Two7u5IGuROyX57je4mPVHw
         82nw==
X-Gm-Message-State: AOAM533Wx7J9M6CSFsvg8FM+5+SM0gxOooV3Tr7HlT4MkGXC7sLBxoQ0
        DnZVNGmwYY4Gv9gmcBLfAWI=
X-Google-Smtp-Source: ABdhPJxfqi2D8oKI3+5MaHV+wcdwj/5RYoa8OhD6XqA3WbNZuui11onhhFEN+S8L6yTpuh4VNiydDQ==
X-Received: by 2002:a05:6512:398e:b0:477:bcc6:f45d with SMTP id j14-20020a056512398e00b00477bcc6f45dmr10392095lfu.216.1653470589729;
        Wed, 25 May 2022 02:23:09 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id a4-20020ac25e64000000b00477ccad3dcfsm2764792lfr.287.2022.05.25.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 02:23:08 -0700 (PDT)
Date:   Wed, 25 May 2022 12:23:06 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Frank Li <Frank.Li@nxp.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        gustavo.pimentel@synopsys.com, hongxing.zhu@nxp.com,
        l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kishon@ti.com,
        vkoul@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, bhelgaas@google.com, manivannan.sadhasivam@linaro.org
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220525092306.wuansog6fe2ika3b@mobilestation>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524152159.2370739-1-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hello Vinod

On Tue, May 24, 2022 at 10:21:51AM -0500, Frank Li wrote:
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

This series has been on review for over three months now. It has got
several acks, rb and tb tags from me, Manivannan and Kishon (the last
patch in the series). Seeing Gustavo hasn't been active for all that time
at all and hasn't performed any review for more than a year the
probability of getting his attention soon enough is almost zero. Thus
could you please give your acks if you are ok with the series content. Due
to having several more patchsets dependent on this one, Bjorn has agreed
to merge this series in through the PCI tree:
https://lore.kernel.org/linux-pci/20220524155201.GA247821@bhelgaas/
So the only thing we need is your ack tags.

@Frank. Should there be a new patchset revision could you please add a
request to merge the series in to the PCI tree? I am a bit tired repeating
the same messages each time the new mailing review lap.)

-Sergey

> 
> Frank Li (6):
>   dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
>   dmaengine: dw-edma: Detach the private data and chip info structures
>   dmaengine: dw-edma: Change rg_region to reg_base in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
>     dw_edma_chip
>   dmaengine: dw-edma: Add support for chip specific flags
>   PCI: endpoint: Enable DMA tests for endpoints with DMA capabilities
> 
> Serge Semin (2):
>   dmaengine: dw-edma: Drop dma_slave_config.direction field usage
>   dmaengine: dw-edma: Fix eDMA Rd/Wr-channels and DMA-direction
>     semantics
> 
>  drivers/dma/dw-edma/dw-edma-core.c            | 141 +++++++++++-------
>  drivers/dma/dw-edma/dw-edma-core.h            |  31 +---
>  drivers/dma/dw-edma/dw-edma-pcie.c            |  83 +++++------
>  drivers/dma/dw-edma/dw-edma-v0-core.c         |  41 ++---
>  drivers/dma/dw-edma/dw-edma-v0-core.h         |   4 +-
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.c      |  18 +--
>  drivers/dma/dw-edma/dw-edma-v0-debugfs.h      |   8 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 112 ++++++++++++--
>  include/linux/dma/edma.h                      |  59 +++++++-
>  9 files changed, 317 insertions(+), 180 deletions(-)
> 
> -- 
> 2.35.1
> 
