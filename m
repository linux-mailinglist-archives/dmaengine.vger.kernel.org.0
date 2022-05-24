Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9965A53206E
	for <lists+dmaengine@lfdr.de>; Tue, 24 May 2022 03:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiEXBy7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 23 May 2022 21:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiEXBy6 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 23 May 2022 21:54:58 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E070F880E1;
        Mon, 23 May 2022 18:54:56 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id z25so2504196pfr.1;
        Mon, 23 May 2022 18:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=urZq8CWh3BOjE9lYQXe4d34VcKBCQu69QtSqwjYP5RM=;
        b=VpHLYvOsFxD/sLqswxegCPA61TbB9+NF0rWIGrtm0+/lln/MIpKvbeT2jy328VM9e8
         GbRnHBE5vjLaNF9s/Vxd4KG/kNms6AXEOfUEVx2McBQjdytz3SlSkfV8Ig8z2vxgRx7r
         +HMyABEDPPVQ02VxlSubrArACyJD+NmEVSKqrkterB7XjJT4z1VNDIkPkpCOM8ImQRzl
         tL57MxsxCfwmcCOVf/BI7XPZ7h7egJHbOJWm6JtAZUnFenB9hBwwx0y2gIjMLeIU/4Ip
         Fu2prH1mfUibR2zz8IfeTzOCH4DS1sk+uh1/+PPHnBD1+4zrnFPxGC2AqzmNiomPoTEK
         e73g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=urZq8CWh3BOjE9lYQXe4d34VcKBCQu69QtSqwjYP5RM=;
        b=1T1rg8N33ZeJRSXa5GteZ1MQKm/d+tbn7vc9SZOUySk7413/nBtMW9aAog6YzRz7ws
         KigOvLcN0xKwG59Syuzzj7f2qeptd07GvIwx6pXP0mls1WMOeROj1Ho5nkMpJ1yWdZnN
         LelA9//83Fl43grHx6Dv55q6do8NP2xZgJIkuh//6D25+SzXKq68mQ+/Ju2HGpouizuI
         CMtjhZjLnIppnPRrCS2p3cLu/W3qYMuyogv6LQNlEST/FV5a1Qlgdi6mBIQRAvgA/UCz
         gGKehl0fZopaFKX3Pp6pFxF2DVvml0I4q4fFAewlG4UG8qhnDMB1pNYBQ5QbfCoeW5wC
         85zA==
X-Gm-Message-State: AOAM532EpuhX+Pfokvnn8z/hHKToaaJDGX09oAYIADwbtPSuZzGoAskh
        w1bNmLhPA07Cd4K6K1OJiZXkvdSPdQBXbeS0t/w=
X-Google-Smtp-Source: ABdhPJyrvu4PskaGYfANpiAXJnvTrvBKTTzbF6xh2ZItb7Owk+b4z5LM5HDZ5AqByKd5XpdOximC249ADzL/5Q0sR40=
X-Received: by 2002:a05:6a00:22c3:b0:518:6a98:b06 with SMTP id
 f3-20020a056a0022c300b005186a980b06mr20079672pfj.3.1653357296247; Mon, 23 May
 2022 18:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAHrpEqSuojypCKdueN-G9c=GQ0zHnPqLb3S6e28V8cchA=qyfA@mail.gmail.com>
 <20220523221842.GA221538@bhelgaas>
In-Reply-To: <20220523221842.GA221538@bhelgaas>
From:   Zhi Li <lznuaa@gmail.com>
Date:   Mon, 23 May 2022 20:54:45 -0500
Message-ID: <CAHrpEqRnaqSxbiK6-6R+uaBVNKqbAoHZHd+LtG0_1EL+OagTeg@mail.gmail.com>
Subject: Re: [PATCH v11 8/8] PCI: endpoint: Enable DMA tests for endpoints
 with DMA capabilities
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        hongxing.zhu@nxp.com, Lucas Stach <l.stach@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>, linux-pci@vger.kernel.org,
        dmaengine@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, May 23, 2022 at 5:18 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Mon, May 23, 2022 at 02:19:34PM -0500, Zhi Li wrote:
>
> > Bjorn:  Are you satisfied with the below message?  I will fix the
> > other code in the next version.
>
> Looks good, minor questions and tweaks below:
>
> > Some PCI Endpoint controllers integrate an eDMA (embedded DMA).
> > The eDMA controller issues a single bus command per data transfer.
>
> Still not sure why this sentence is here.  Is it something the patch
> relies on?  Why does it matter how many bus commands there are?

Okay, let me remove this line in the next version.

>
> > eDMA can bypass the outbound memory address translation unit to
> > access all RC memory space.
> >
> > Add eDMA support for pci-epf-test.
> >
> > EPF test can use, depending on HW availability, eDMA or general system
> > DMA controllers to perform DMA. The test probes the EPF DMA channel
> > capabilities.
>
>   Depending on HW availability, the EPF test can use either eDMA or
>   general system DMA controllers to perform DMA. The test tries to use
>   eDMA first and falls back to general system DMA controllers if
>   there's no eDMA.
>
> > Separate dma_chan to dma_chan_tx and dma_chan_rx. Search eDMA channel
> > firstly, then search memory to memory DMA channel if eDMA does not exist.
> > If general memory to memory channels are used, dma_chan_rx = dma_chan_tx.
>
>   Search for an eDMA channel first, then search for a memory-to-memory
>   DMA channel ...
>
> > Add dma_addr_t dma_remote in pci_epf_test_data_transfer()
> > because eDMA uses remote RC physical address directly.
> >
> > Add enum dma_transfer_direction dir in pci_epf_test_data_transfer()
> > because eDMA chooses the correct RX/TX channel by dir.
> >
> > The overall steps are
> >
> > 1. Execute dma_request_channel() and filter function to find correct
> > eDMA RX and TX Channel. If a channel does not exist, fallback to try to
> > allocate general memory to memory DMA channel.
> > 2. Execute dmaengine_slave_config() to configure remote side physical
> > address.
> > 3. Execute dmaengine_prep_slave_single() to create transfer descriptor.
> > 4. Execute tx_submit().
> > 5. Execute dma_async_issue_pending()
