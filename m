Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2979583D82
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 13:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiG1LeK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 07:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbiG1LeG (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 07:34:06 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444B552DEB;
        Thu, 28 Jul 2022 04:34:04 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id w18so1669772lje.1;
        Thu, 28 Jul 2022 04:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HfACmmu/WJgo1mk4K/rzsVT0AxWfJtSpPaF3SKzLGLI=;
        b=gzYexW6lUSJ03upiXlBn3tIRD0L2Q+LxVp3V+Pem5crGGvKosB1TQh2q5Ny+DaaBY2
         vDf+gXV823cU/4MAJ/6FhmLBM8JotSDGE3e6ym28GOwtWLF/XGn+zXDItrsxgAGnnUsM
         UorLoujNBr/PwJftnHT9jMkNi3apFu/X7BZKAfjuEUODjBJgbM+Q+cOsw/JrhWb0JbHS
         ViN/S6o8C0FjQRPxi384FF7Ky/KxdSp5dtGFzp0q0C9wxaTM1Nw9QHjdU9t1bxE9cL4+
         G8QY53OdZ/ohoTPgH7GyCuTMgCkpcd3hn7mCIBtuR1eRljkJJ/YPhVehyFqeMZj6tP14
         moUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HfACmmu/WJgo1mk4K/rzsVT0AxWfJtSpPaF3SKzLGLI=;
        b=ICVoJT3jCGL6l5K3r6y3qngViNDWNLyt+5ppjTX1aRxJYsuG8kKfubmY1Jg+Y9kBd0
         73KmWuOD+r6L4RffN4/DUhjSchLsQgM1VWgKHx79o2Yj/udKnrw7ePM57HlcYvCUTXie
         v8/5egtTPVtme2MANrq/kPGlA88QrNEtVaQEBb3BQ6kkbA+6ZR8S5Eq//1qgOS/MVU/b
         a4f8G+BJ3NNRpulTSI0MLXql+nKN/axnFPYis32N7jVgfvq7swf54WMSZNHfgm/ukop7
         asua2mZz9E6vY6VLfAJ+9Y+XpfJ5589Vb0PWRCp4PF8YrJGf47fBPVUQhGdD4vtfZhyb
         cLpA==
X-Gm-Message-State: AJIora+bgDiqwhYeXyqgQT8y6UKZOy2P1fBzJf87wrPhB8OtA2BbE3DN
        s7Xs5Ppym2UTvNqe4fLDTLY=
X-Google-Smtp-Source: AGRyM1u+eD9QE71hQzsQuy7GLBcHDxFSGrPAsF2pwgha/qekGbrBqW+yxU/SifnqfHohvKiamNo+nw==
X-Received: by 2002:a2e:894f:0:b0:25e:56f:9ca4 with SMTP id b15-20020a2e894f000000b0025e056f9ca4mr6590634ljk.94.1659008042405;
        Thu, 28 Jul 2022 04:34:02 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651220d100b0048759bc6c1asm157415lfr.203.2022.07.28.04.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:34:01 -0700 (PDT)
Date:   Thu, 28 Jul 2022 14:33:59 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220728113359.hs54apv22bo5bnyr@mobilestation>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
 <YtlDivjaXfSEK1Xg@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtlDivjaXfSEK1Xg@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 21, 2022 at 05:46:10PM +0530, Vinod Koul wrote:
> On 10-06-22, 12:14, Serge Semin wrote:
> > This is a final patchset in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: In-progress v4] PCI: dwc: Various fixes and cleanups
> > Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
> > [2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
> > Link: https://lore.kernel.org/linux-pci/20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru/
> > [3: In-progress v3] PCI: dwc: Add generic resources and Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> > [4: In-progress v3] dmaengine: dw-edma: Add RP/EP local DMA support
> > Link: ---you are looking at it---
> > 
> > Note it is very recommended to merge the patchsets in the same order as
> > they are listed in the set above in order to have them applied smoothly.
> > Nothing prevents them from being reviewed synchronously though.
> > 
> > Please note originally this series was self content, but due to Frank
> > being a bit faster in his work submission I had to rebase my patchset onto
> > his one. So now this patchset turns to be dependent on the Frank' work:
> > 
> > Link: https://lore.kernel.org/linux-pci/20220524152159.2370739-1-Frank.Li@nxp.com/
> > 
> > So please merge Frank' series first before applying this one.
> > 
> > Here is a short summary regarding this patchset. The series starts with
> > fixes patches. We discovered that the dw-edma-pcie.c driver incorrectly
> > initializes the LL/DT base addresses for the platforms with not matching
> > CPU and PCIe memory spaces. It is fixed by using the pci_bus_address()
> > method to get a correct base address. After that you can find a series of
> > the interleaved xfers fixes. It turned out the interleaved transfers
> > implementation didn't work quite correctly from the very beginning for
> > instance missing src/dst addresses initialization, etc. In the framework
> > of the next two patches we suggest to add a new platform-specific
> > callback - pci_address() and use it to convert the CPU address to the PCIe
> > space address. It is at least required for the DW eDMA remote End-point
> > setup on the platforms with not-matching CPU/PCIe address spaces. In case
> > of the DW eDMA local RP/EP setup the conversion will be done automatically
> > by the outbound iATU (if no DMA-bypass flag is specified for the
> > corresponding iATU window). Then we introduce a set of the patches to make
> > the DebugFS part of the code supporting the multi-eDMA controllers
> > platforms. It starts with several cleanup patches and is closed joining
> > the Read/Write channels into a single DMA-device as they originally should
> > have been. After that you can find the patches with adding the non-atomic
> > io-64 methods usage, dropping DT-region descriptors allocation, replacing
> > chip IDs with the device name. In addition to that in order to have the
> > eDMA embedded into the DW PCIe RP/EP supported we need to bypass the
> > dma-ranges-based memory ranges mapping since in case of the root port DT
> > node it's applicable for the peripheral PCIe devices only. Finally at the
> > series closure we introduce a generic DW eDMA controller support being
> > available in the DW PCIe Root Port/Endpoint driver.
> 

> Acked-By: Vinod Koul <vkoul@kernel.org>

Thanks, Vinod! The series will be merged in after the patchset
[PATCH vX 00/17] PCI: dwc: Add generic resources and Baikal-T1 support
Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
is done with Rob' review (I failed to reach him with a few issues
lately). I'll add your ab-tag to this one on the next patchset re-spin
(rebase will be likely needed).

-Sergey

> 
> -- 
> ~Vinod
