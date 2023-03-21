Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1FE6C3AD3
	for <lists+dmaengine@lfdr.de>; Tue, 21 Mar 2023 20:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjCUTk1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Mar 2023 15:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjCUTkE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Mar 2023 15:40:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1402A9B1;
        Tue, 21 Mar 2023 12:39:39 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id g18so16710870ljl.3;
        Tue, 21 Mar 2023 12:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679427576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=38UUmK+a8srL5/S/qgYnYErIVIOrqwMhPrwp/fVYqb8=;
        b=XsxUZeJ4RA77K5K/7CsRanhirut2lOLu9ZY8k7l1ilF7QrblYBDpPfEwcwamXXofl5
         wJfpAbu3r6jzhw/nEJAdM91C3Um5s8LSVimMj043gDLdIZ8/C8C2q7qaF45Qux0cCkXy
         ZE5smFlSe4kLahs7jX/RHDs75Dv/3IZ9hb2Bfvljd7IUC+dtNbzqB+XGli2QGFrypWE9
         Mpj9Boya3yg9OPk4Po+3x8jIOoR/R7C4VhMHa3kMpQLUcPBlXOvL4P3IKnKALUM2kcwU
         /uqGBTPHte8bZBuwHhYzM0fVOOamJhEII078uBiz32hPErrhcFtZGJP3qCoO6+tGuRGy
         vv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679427576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=38UUmK+a8srL5/S/qgYnYErIVIOrqwMhPrwp/fVYqb8=;
        b=fTqi05Ux6Ugcz+2KBNpFdIGlTn++7QqLt4dP2YR0VdHebWMhiBvoTTWBv4J7KG09ZS
         +F2M7S2V3U2bf1tLUz7NHNyeqNrAyES32JSC38T0jyeURu+y4EubARZitpEw7OXeSJom
         Uj3/CH4rtLntmcNvjoXEZTAV6YkRtSZHeqqAY8jXFiJAom+DnY1ivP4vuL2Ud8Gyaa7D
         yWXrLWDHIdvmgaPtK17w2x+A8qyMGLV51UrA3U+sJiF2/whcJkdz03SXnbSd1CkcXcGn
         HqU6DTMfdXFsFuX2lXlYzO20nEQSdxblLNfQp90beJKNvJf32l8EovG3A+SsWEArVKYF
         KXlQ==
X-Gm-Message-State: AO0yUKVxMCgkesuKy+mdZ55uYCX5u0yaSaM8582MZczne2OYMHT+vVuz
        y8TTLJbfVzT7mRB1aEs96Ul7xY/Z/Go=
X-Google-Smtp-Source: AK7set+mcDSP8AtMr8B1IAnEW8DFStaFZL+KpXtgV9GZ41alnbG3OMscIEVIiMJLLb7wFCfMP/lmIA==
X-Received: by 2002:a05:651c:2d1:b0:298:9e31:f27a with SMTP id f17-20020a05651c02d100b002989e31f27amr1278224ljo.10.1679427576423;
        Tue, 21 Mar 2023 12:39:36 -0700 (PDT)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e9902000000b002986ff63c64sm2369857lji.47.2023.03.21.12.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 12:39:35 -0700 (PDT)
Date:   Tue, 21 Mar 2023 22:39:33 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 0/5] dmaengine: dw-edma: Add support for native HDMA
Message-ID: <20230321193933.iccqqlg5mgegcsed@mobilestation>
References: <20230315012840.6986-1-cai.huoqing@linux.dev>
 <20230320121401.zkcjbqmghzacpffh@mobilestation>
 <ZBkXEzoZZlIy18xB@chq-MS-7D45>
 <20230321083407.5gc432ttjhwbi2um@mobilestation>
 <ZBmhTch4d2CG4TtH@chq-MS-7D45>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBmhTch4d2CG4TtH@chq-MS-7D45>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Mar 21, 2023 at 08:21:33PM +0800, Cai Huoqing wrote:
> On 21 3月 23 11:34:07, Serge Semin wrote:
> > On Tue, Mar 21, 2023 at 10:31:47AM +0800, Cai Huoqing wrote:
> > > On 20 3月 23 15:14:01, Serge Semin wrote:
> > > > Hi Cai
> > > > 
> > > > On Wed, Mar 15, 2023 at 09:28:31AM +0800, Cai Huoqing wrote:
> > > > > Add support for HDMA NATIVE, as long the IP design has set
> > > > > the compatible register map parameter-HDMA_NATIVE,
> > > > > which allows compatibility for native HDMA register configuration.
> > > > > 
> > > > > The HDMA Hyper-DMA IP is an enhancement of the eDMA embedded-DMA IP.
> > > > > And the native HDMA registers are different from eDMA,
> > > > > so this patch add support for HDMA NATIVE mode.
> > > > > 
> > > > > HDMA write and read channels operate independently to maximize
> > > > > the performance of the HDMA read and write data transfer over
> > > > > the link When you configure the HDMA with multiple read channels,
> > > > > then it uses a round robin (RR) arbitration scheme to select
> > > > > the next read channel to be serviced.The same applies when
> > > > > youhave multiple write channels.
> > > > > 
> > > > > The native HDMA driver also supports a maximum of 16 independent
> > > > > channels (8 write + 8 read), which can run simultaneously.
> > > > > Both SAR (Source Address Register) and DAR (Destination Address Register)
> > > > > are aligned to byte.
> > > > 
> > > > It seems like we are getting towards the series finalization. I'll
> > > > test it out on my HW after v8 is submitted. Meanwhile could you please
> > > > clarify whether you have a real device with DW HDMA engine on board?
> > > 
> > 
> > > Our hardware is an AI Accelerartor(PCIE Card).
> > > 
> > > The device pci.ids is 1d22:3864
> > > in https://github.com/pciutils/pciids/blob/master/pci.ids
> > > line 24737,
> > > 
> > > "1d22  Baidu Technology
> > >         3684  Kunlun AI Accelerator
> > >         3685  Kunlun2 AI Accelerator [VF]"
> > > 
> > > And our device driver is not ready to upstream(will cost serveral
> > > 
> > > months to port DRM etc.),
> > 
> > Ok. Thanks for clarification. Could you please add me to the Cc-list of
> > the AI-accelerator patch when it's ready to be submitted for review. I am
> > not that familiar with the DRM-part, but would like to have a look at
> > the DMA-related code.

> Sure, I'll Cc you if I send the patches.

Great! Thanks in advance.

> 
> By the way, Why use native hdma:
> 
> Our device v1 also use dw-edma. But we find that navtive HDMA work better
> 
> in SRIOV on, channel CSR can be map to every VF instead of some global
> 
> regiter must in PF. So v2 use native hdma.

Good to know. Thanks.

-Serge(y)

> 
> Thanks,
> -Cai
> 
> > 
> > -Serge(y)
> > 
> > > 
> > > but I have taken this DW eDMA core into our driver test.
> > > 
> > > Thanks
> > > Cai-
> > > 
> > > > You keep submitting the DW eDMA driver core update, but there is no
> > > > glue-driver or low-level device driver patch for a real device which
> > > > would set the EDMA_MF_HDMA_NATIVE mapping.
> > > > 
> > > > -Serge(y)
> > > > 
> > > > > 
> > > > > Cai Huoqing (2):
> > > > >   dmaengine: dw-edma: Add support for native HDMA
> > > > >   dmaengine: dw-edma: Optimization in dw_edma_v0_core_handle_int
> > > > > 
> > > > > Cai huoqing (3):
> > > > >   dmaengine: dw-edma: Rename dw_edma_core_ops structure to
> > > > >     dw_edma_plat_ops
> > > > >   dmaengine: dw-edma: Create a new dw_edma_core_ops structure to
> > > > >     abstract controller operation
> > > > >   dmaengine: dw-edma: Add HDMA DebugFS support
> > > > > 
> > > > > v6->v7:
> > > > >   [1/5]
> > > > >   1.Update the commit log.
> > > > >   [2/5]
> > > > >   2.Revert dw_edma_core_handle_int back to dw-edma-core.h.
> > > > >   3.Fix code style.
> > > > >   [3/5]
> > > > >   4.Move the change of register file from patch[4/5] to patch[3/5].
> > > > >   5.Fix code style.
> > > > > 
> > > > > v6 link:
> > > > >   https://lore.kernel.org/lkml/20230310032342.17395-1-cai.huoqing@linux.dev/
> > > > > 
> > > > >  drivers/dma/dw-edma/Makefile                 |   8 +-
> > > > >  drivers/dma/dw-edma/dw-edma-core.c           |  86 ++----
> > > > >  drivers/dma/dw-edma/dw-edma-core.h           |  58 ++++
> > > > >  drivers/dma/dw-edma/dw-edma-pcie.c           |   4 +-
> > > > >  drivers/dma/dw-edma/dw-edma-v0-core.c        |  91 ++++--
> > > > >  drivers/dma/dw-edma/dw-edma-v0-core.h        |  14 +-
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.c        | 277 +++++++++++++++++++
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-core.h        |  17 ++
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.c     | 176 ++++++++++++
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-debugfs.h     |  22 ++
> > > > >  drivers/dma/dw-edma/dw-hdma-v0-regs.h        | 130 +++++++++
> > > > >  drivers/pci/controller/dwc/pcie-designware.c |   2 +-
> > > > >  include/linux/dma/edma.h                     |   7 +-
> > > > >  13 files changed, 785 insertions(+), 107 deletions(-)
> > > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-core.h
> > > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.c
> > > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-debugfs.h
> > > > >  create mode 100644 drivers/dma/dw-edma/dw-hdma-v0-regs.h
> > > > > 
> > > > > -- 
> > > > > 2.34.1
> > > > > 
