Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E319C50D8C6
	for <lists+dmaengine@lfdr.de>; Mon, 25 Apr 2022 07:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241238AbiDYFZt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 25 Apr 2022 01:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241221AbiDYFZs (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 25 Apr 2022 01:25:48 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39C4ABF50E
        for <dmaengine@vger.kernel.org>; Sun, 24 Apr 2022 22:22:45 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g9so12463116pgc.10
        for <dmaengine@vger.kernel.org>; Sun, 24 Apr 2022 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7UM6DPyHOQq3FgqfTuePB73/Nb2FwKrg0jImby5eM5c=;
        b=DoGMBBcDebYjX7MkBKm4T9g0BwwvOpC3qFrJETTa5OVm92Dv5XUVuona8ulNEZj5BV
         f/ICaRIsdUi63tbWXzWOVqIio3oC/RWDlS5bBDdLTlNyG3UETXWabHcOk2dRny+qnRmP
         KXVma1BtJHvDybsneiVdIBYVjcN5M8O/jWJAdmDHks7tu14YPMaEM2LOSYMX9iLTgo1+
         zHB+jWzGcGDheGtQomNwJ1Y82lz2kYP1xGXooQheqWhWdFIIEvX7UewLm5NpWN1niwae
         tc2s5Ei7g8kq55sU93SLeJeHKaKvS5viOuwhzDiwyHq/eVjc6TtrFYAjgxxZ0TSbsfIY
         MN7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7UM6DPyHOQq3FgqfTuePB73/Nb2FwKrg0jImby5eM5c=;
        b=6krxAJ/5lfXhqObNomO1hYsqjU7g4jfFl8ez0dO+PpLm+4nrGbSc1cSVyucKxJUCjs
         kSW6AXZSrW879I6RVVEI6o0F39qvqcioPe+mSPB09OkAeXBSFELXMb3hn+AqCAaLpYb/
         GMxD2V5VobkFPWNQeLi4ObXso+fDf4DTgRbq56qlRJN54Y2ph+8moWpCFVeE2TxAX9+W
         rzwTjnP42g4G62Beo1ZTtb2R8Bh6Op5oygoxh+WOZtqJxQ7dXfK7cNFXw03Ei6xc0ni7
         5pF0A2uZvOdc94bPugRuhv8BTb7hC51POgiR4X63ufhC2QUYzNQMyMt5Czmqjdl3D5tI
         lrEA==
X-Gm-Message-State: AOAM530nUOsY7c2sn9HzbgLmSwW9jm1YPQBPZPsLt0qC6Th1Bfd6Ddjg
        v7Mf+Vhta+FAgsEv65F3M70h
X-Google-Smtp-Source: ABdhPJwujy4Eu9iaaqDg9ObZQzlv51k9+KSWAQ0IObR7HlLdlWitH02y4OEmLfb1fYc0JSSFi70byw==
X-Received: by 2002:aa7:999e:0:b0:50d:3db0:a3a6 with SMTP id k30-20020aa7999e000000b0050d3db0a3a6mr3919799pfh.7.1650864164510;
        Sun, 24 Apr 2022 22:22:44 -0700 (PDT)
Received: from thinkpad ([117.193.215.110])
        by smtp.gmail.com with ESMTPSA id n20-20020a634d54000000b0039d18bf7864sm8306243pgl.20.2022.04.24.22.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 22:22:43 -0700 (PDT)
Date:   Mon, 25 Apr 2022 10:52:36 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 25/25] PCI: dwc: Add DW eDMA engine support
Message-ID: <20220425052236.GA5587@thinkpad>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-26-Sergey.Semin@baikalelectronics.ru>
 <20220328141521.GA17663@thinkpad>
 <20220419205403.hdtp67mwoyrl6b6q@mobilestation>
 <20220423144055.GR374560@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220423144055.GR374560@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Apr 23, 2022 at 08:10:55PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 19, 2022 at 11:54:03PM +0300, Serge Semin wrote:
> > On Mon, Mar 28, 2022 at 07:45:21PM +0530, Manivannan Sadhasivam wrote:
> > > On Thu, Mar 24, 2022 at 04:48:36AM +0300, Serge Semin wrote:
> > > > Since the DW eDMA driver now supports eDMA controllers embedded into the
> > > > locally accessible DW PCIe Root Ports and End-points, we can use the
> > > > updated interface to register DW eDMA as DMA engine device if it's
> > > > available. In order to successfully do that the DW PCIe core driver need
> > > > to perform some preparations first. First of all it needs to find out the
> > > > eDMA controller CSRs base address, whether they are accessible over the
> > > > Port Logic or iATU unrolled space. Afterwards it can try to auto-detect
> > > > the eDMA controller availability and number of it's read/write channels.
> > > > If none was found the procedure will just silently halt with no error
> > > > returned. Secondly the platform is supposed to provide either combined or
> > > > per-channel IRQ signals. If no valid IRQs set is found the procedure will
> > > > also halt with no error returned so to be backward compatible with
> > > > platforms where DW PCIe controllers have eDMA embedded but lack of the
> > > > IRQs defined for them. Finally before actually probing the eDMA device we
> > > > need to allocate LLP items buffers. After that the DW eDMA can be
> > > > registered. If registration is successful the info-message regarding the
> > > > number of detected Read/Write eDMA channels will be printed to the system
> > > > log in the same way as it's done for iATU settings.
> > > > 
> > > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > > > ---
> > > >  .../pci/controller/dwc/pcie-designware-ep.c   |   4 +
> > > >  .../pci/controller/dwc/pcie-designware-host.c |  13 +-
> > > >  drivers/pci/controller/dwc/pcie-designware.c  | 188 ++++++++++++++++++
> > > >  drivers/pci/controller/dwc/pcie-designware.h  |  23 ++-
> > > >  4 files changed, 225 insertions(+), 3 deletions(-)
> > > > 

[...]

> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > > > index 4a95a7b112e9..dbe39a7ecb71 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware.c

[...]

> > > Should we introduce a new Kconfig option for enabling eDMA? My concern here is,
> > > if eDMA is really needed for an usecase and if the platform support is broken
> > > somehow (DT issues?), then we'll just simply go ahead without probe failure and
> > > it may break somewhere else.
> > > 
> > > And we are returning errors if something wrong happens during eDMA probe. This
> > > might annoy the existing users who don't care about eDMA but turning those
> > > errors to debug will affect the real users of eDMA.
> > > 
> > > For these reasons, I think it'd be better to probe eDMA only if the Kconfig
> > > option is enabled (which would be disabled by default). And properly return the
> > > failure.
> > 
> > I don't see a need in introducing of a new parametrization. Neither
> > there is a point in dropping the eDMA support on all the platforms for
> > the sake of some hypothetically malfunction hardware.
> 
> I'm not talking about "hypothetically malfunction hardware" but real customized
> ones like all Qcom platforms supporting PCIe.

Correction: It is not "all Qcom platforms" but some like SM8250, SM8450 etc...

Thanks,
Mani
