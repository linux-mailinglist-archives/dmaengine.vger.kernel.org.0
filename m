Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17D76698F1F
	for <lists+dmaengine@lfdr.de>; Thu, 16 Feb 2023 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBPI4U (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Feb 2023 03:56:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjBPI4N (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Feb 2023 03:56:13 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7333B654;
        Thu, 16 Feb 2023 00:56:09 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id a9so1163237ljr.13;
        Thu, 16 Feb 2023 00:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NfCtVHnWntV5JSpdIXfsBMSNM2BpIltYXG1KJiuplvw=;
        b=fdZ//BncOC6HnkEpA28mgzeARL4fjsh8algAznLlQ8cuGKgAbFquRQVdU1wBVWEJHN
         TDvUuFDGVAARnRe4CpLnnxp52PIheCz5NWljYGpATn/7g61UbycK2/xPwrzKn4ncYfKP
         5zisptU5SLv7GC7amgsEUfne0OjAN+mxT0TkVzbWNCJSj51vhKj4MAwm6XLYqLyEgIFa
         y9inwP6stMPuu7JbVQfQawh0X7aGb/SaNWtyuMqIwmmTk3Qveqmz++AnfSbnSuALn4UI
         /mFsnIezJcqwaT2liBHFesrX3XFjKp3P5shYSyqaAlzl2nqvB+/cYGHC0s7arQOWXk/+
         +D2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NfCtVHnWntV5JSpdIXfsBMSNM2BpIltYXG1KJiuplvw=;
        b=ZedaCE7j6pYDqV10DLlixDNhDOFE7/ZegdWASwLVeby1Hz/IZdn67TsdON7SFzRV0S
         LzY7czH6QwRjpPmccxQLZNZsI/t0Zx7s2YdNZI/+1Rh6UiHVCE7hg50KTn7nosFjSnV2
         1dNDAqhY4O71GWjd9/AhpKrjYO+Ct9EVo6km1crzUHTrscB3+U4Sc9nsF01nWq+eYH3i
         xSCY0smxkvQo2Sz+iCHCZ/Es9ceSdV9KYQsLOqBPKP6vUSz8pHeE4c2BMP0NuZN27LRr
         nq1RhflDkVxcYj3vzdAdHhU+3B4u1v2MXbugXcXudJNhR8L1Sjdhx1RswFEbVdeUppDX
         rpDQ==
X-Gm-Message-State: AO0yUKVPvYvwHfB2X92ozGHK0rAe/u7GLvngLiIPvxHHv0boQmvcsoZ5
        42sMck+qrnpy16CBFZEztp0=
X-Google-Smtp-Source: AK7set8WsrdXQik9YVzkdtfAe50G7asMHPmerIr8yMkZO+O5tX85TD6TrmUD1Leppppa0gML3MFRRQ==
X-Received: by 2002:a2e:9949:0:b0:293:5007:75b7 with SMTP id r9-20020a2e9949000000b00293500775b7mr1580608ljj.23.1676537768157;
        Thu, 16 Feb 2023 00:56:08 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id m13-20020a2e97cd000000b002936022605dsm104398ljj.23.2023.02.16.00.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Feb 2023 00:56:07 -0800 (PST)
Date:   Thu, 16 Feb 2023 11:56:05 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Sergey.Semin@baikalelectronics.ru,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 0/4] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230216085605.smffk2b3xig34eqr@mobilestation>
References: <20230213132411.65524-1-cai.huoqing@linux.dev>
 <Y+2QOAsk6qFm56E3@chq-MS-7D45>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+2QOAsk6qFm56E3@chq-MS-7D45>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Cai

On Thu, Feb 16, 2023 at 10:08:56AM +0800, Cai Huoqing wrote:
> On 13 2月 23 21:24:05, Cai Huoqing wrote:
> > From: Cai huoqing <cai.huoqing@linux.dev>
> > 
> > Add support for HDMA NATIVE, as long the IP design has set
> > the compatible register map parameter-HDMA_NATIVE,
> > which allows compatibility for native HDMA register configuration.
> > 
> > The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> > And the native HDMA registers are different from eDMA,
> > so this patch add support for HDMA NATIVE mode.
> > 
> > HDMA write and read channels operate independently to maximize
> > the performance of the HDMA read and write data transfer over
> > the link When you configure the HDMA with multiple read channels,
> > then it uses a round robin (RR) arbitration scheme to select
> > the next read channel to be serviced.
> > The same applies when you have multiple write channels.
> > 
> > The native HDMA driver also supports a maximum of 16 independent
> > channels (8 write + 8 read), which can run simultaneously.
> > Both SAR (Source Address Register) and DAR (Destination Address Register)
> > are alignmented to byte.dmaengine: dw-edma: Add support for native HDMA
> > 
> > Cai huoqing (4):
> >   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
> >     dw_edma_plat_ops
> >   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
> >     abstract controller operation
> >   dmaengine: dw-edma: Add support for native HDMA
> >   dmaengine: dw-edma: Add HDMA DebugFS support
> > 
> >   v2->v3:
> >     [1/4]
> >     1.Add more commit log to explain why use dw_edma_plat_ops.
> >     2.Update the structure name in the DW PCIe driver.
> >     [2/4]
> >     3.Use the reverse xmas tree vars definition order.
> >     4.Add edma core ops wrapper.
> >     5.Add dw_edma_done_interrupt() and dw_edma_abort_interrupt()
> >       global methods.
> >     6.Fix some indentation.
> >     7.Fix some typo
> >     8.Make use off dw_edma_core prefix instead of dw_xdma_core_.
> >     [3/4]
> >     9.Remove unnecessary include: dw-edma-v0-regs.h and dw-edma-v0-regs.h
> >     10.HDMA supports the LL descriptors placed on the CPU memory.
> >     [4/4]
> >     11.Split DebugFS to be a separate patch.
> >     12.Refactor HDMA DebugFS like the series in @Bjorn tree.
> > 
> >   v2 link:
> >   https://lore.kernel.org/lkml/20220925173412.u2ez6rbmfc5fupdn@mobilestation/

> Hi Sergey,
> 
>   Could you please give some comments for this patch v3

The series has landed in my inbox. I'll give you some comments shortly
today or tomorrow.

-Serge(y)

> 
> Thanks,
> Cai
> > 
> >  drivers/dma/dw-edma/Makefile                 |   8 +-
> >  drivers/dma/dw-edma/dw-edma-core.c           |  63 ++--
> >  drivers/dma/dw-edma/dw-edma-core.h           |  92 ++++++
> >  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
> >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  88 ++++-
> >  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
> >  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 317 +++++++++++++++++++
> >  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 +
> >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 175 ++++++++++
> >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
> >  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 129 ++++++++
> >  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
> >  include/linux/dma/edma.h                     |   7 +-
> >  13 files changed, 860 insertions(+), 78 deletions(-)
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > 
> > -- 
> > 2.34.1
> > 
