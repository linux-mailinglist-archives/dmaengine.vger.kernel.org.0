Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A4567B4FB
	for <lists+dmaengine@lfdr.de>; Wed, 25 Jan 2023 15:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235907AbjAYOlV (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 25 Jan 2023 09:41:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbjAYOlP (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 25 Jan 2023 09:41:15 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2307C3597;
        Wed, 25 Jan 2023 06:40:47 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id f34so29275459lfv.10;
        Wed, 25 Jan 2023 06:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QELdzY3NIYjY7OwghVfrJTNG0cf8qKkTucoZEOCtl2E=;
        b=c3zlEUO9WYifl0n0mN6SSlWRaXAVNGM3DUOIN5BZgmF9Rq7tXLfm9TAC2Lbc+StC+o
         +h9hrfagVu4lfTJ1tawAncGERjvlmxuUzrJqDPKpmIlHE5RzHvr7UfieUftnPrLdfQwk
         ZhD2PWrH0UV6xUmgpn1Qcxl0mEaghKywIDwf4LeQ+NkfXrCSPdD2noqN/8gJ4Gz0QbBq
         kbdgXqxSBptvW4E4mtsD9BP6olb/731YzOzmJiSevg/9wuXSTtYyXwiADqvWnWn/Nub2
         MJVLy+/oZFGe8RnUGR9VxctcfedMlw+NdgCpacVYyMBjD0l+2nc4YVDs8Gu5ndAmKAAl
         0/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QELdzY3NIYjY7OwghVfrJTNG0cf8qKkTucoZEOCtl2E=;
        b=UjxUZbz0MwQR1Unu4ZQdIVtPkn1keYbVV3lKCfeDWgtSKrJeo4lSpWioLKAyLlUeiD
         y/r/1vuKnPrHblgSV3mAgNHdHyMTDVHfdPba69CP8UreEnbJ76YkPfeAik+kWmXMEkHz
         4WSQiuk3hGg0qFgqK4G6G2GUMpqIHxC+l/ow3JMe1K8DXqJ4KJJgHoUAPLCRJItyy1Wx
         2e5LvfH8o3uT8wJwIhe0mxeogpKQSWGSMU/6H2GGCsU6TBpfzkuVg+iUCFO+V3I9R0WR
         y4EtRETnUWro9pH2TGC6yjU3/xoueCflLtvlRgr5KrskHu9Nc27DZW3Ij7oczhAu8u6F
         0pAQ==
X-Gm-Message-State: AFqh2kpvUwvsI7uQhHTDjc7nEagc50SFEdVLPguQPg5DOtv8wscimrFb
        p7RyLw0mSwLU6GpdvwIBD2U=
X-Google-Smtp-Source: AMrXdXvFwvxwlCoo5ZWFsDiCHyOfQmG36pJybKKqX5u2m3URe5MhETEiO3uJa7MrRpD5z3vreu/Vrw==
X-Received: by 2002:ac2:4834:0:b0:4d5:7b89:7b62 with SMTP id 20-20020ac24834000000b004d57b897b62mr6587177lft.40.1674657624222;
        Wed, 25 Jan 2023 06:40:24 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id k18-20020ac24f12000000b004a764f9d653sm502594lfr.242.2023.01.25.06.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 06:40:23 -0800 (PST)
Date:   Wed, 25 Jan 2023 17:40:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 24/27] dmaengine: dw-edma: Relax driver config settings
Message-ID: <20230125144019.sn7kliw3qlwgtwzs@mobilestation>
References: <20230124144941.42zpgj2p53nvfz36@mobilestation>
 <20230124234744.GA1062727@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124234744.GA1062727@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Jan 24, 2023 at 05:47:44PM -0600, Bjorn Helgaas wrote:
> On Tue, Jan 24, 2023 at 05:49:41PM +0300, Serge Semin wrote:
> > On Mon, Jan 23, 2023 at 10:43:39AM -0600, Bjorn Helgaas wrote:
> > > On Sun, Jan 22, 2023 at 03:11:16AM +0300, Serge Semin wrote:
> > > > On Fri, Jan 20, 2023 at 04:50:36PM -0600, Bjorn Helgaas wrote:
> > > > > On Fri, Jan 13, 2023 at 08:14:06PM +0300, Serge Semin wrote:
> > > > > > Since the DW PCIe RP/EP driver is about to be updated to register the DW
> > > > > > eDMA-based DMA-engine the drivers build modes must be synchronized.
> > > > > > Currently the DW PCIe RP/EP driver is always built as a builtin module.
> > > > > > Meanwhile the DW eDMA driver can be built as a loadable module. Thus in
> > > > > > the later case the kernel with DW PCIe controllers support will fail to be
> > > > > > linked due to lacking the DW eDMA probe/remove symbols. At the same time
> > > > > > forcibly selecting the DW eDMA driver from the DW PCIe RP/EP kconfig will
> > > > > > effectively eliminate the tristate type of the former driver fixing it to
> > > > > > just the builtin kernel module.
> > > > > > 
> > > > > > Seeing the DW eDMA engine isn't that often met built into the DW PCIe
> > > > > > Root-ports and End-points let's convert the DW eDMA driver config to being
> > > > > > more flexible instead of just forcibly selecting the DW eDMA kconfig. In
> > > > > > order to do that first the DW eDMA PCIe driver config should be converted
> > > > > > to being depended from the DW eDMA core config instead of selecting the
> > > > > > one. Second the DW eDMA probe and remove symbols should be referenced only
> > > > > > if they are reachable by the caller. Thus the user will be able to build
> > > > > > the DW eDMA core driver with any type, meanwhile the dependent code will
> > > > > > be either restricted to the same build type (e.g. DW eDMA PCIe driver if
> > > > > > DW eDMA driver is built as a loadable module) or just won't be able to use
> > > > > > the eDMA engine registration/de-registration functionality (e.g. DW PCIe
> > > > > > RP/EP driver if DW eDMA driver is built as a loadable module).
> > > > > 
> > > > > I'm trying to write the merge commit log, and I understand the linking
> > > > > issue, but I'm having a hard time figuring out what the user-visible
> > > > > scenarios are here.
> > > > > 
> > > > > I assume there's something that works when CONFIG_PCIE_DW=y and
> > > > > CONFIG_DW_EDMA_PCIE=y but does *not* work when CONFIG_PCIE_DW=y and
> > > > > CONFIG_DW_EDMA_PCIE=m?
> > > > 
> > > > No. The DW eDMA code availability (in other words the CONFIG_DW_EDMA
> > > > config value) determines whether the corresponding driver (DW PCIe
> > > > RP/EP or DW eDMA PCI) is capable to perform the eDMA engine probe
> > > > procedure. Additionally both drivers has the opposite dependency from
> > > > the DW eDMA code.
> > > > |                |     DW PCIe RP/EP    |     DW eDMA PCIe     |
> > > > | CONFIG_DW_EDMA +----------------------+----------------------+
> > > > |                | Probe eDMA | KConfig | Probe eDMA | Kconfig |
> > > > +----------------+------------+---------+------------+---------+
> > > > |        y       |     YES    |   y,n   |     YES    |  y,m,n  |
> > > > |        m       |     NO     |   y,n   |     YES    |    m,n  |
> > > > |        n       |     NO     |   y,n   |     NO     |      n  |
> > > > +--------------------------------------------------------------+
> > > > 
> > > > Basically it means the DW PCIe RP/EP driver will be able to probe the
> > > > DW eDMA engine only if the corresponding driver is built into the
> > > > kernel. At the same time the DW PCIe RP/EP driver doesn't depend on
> > > > the DW eDMA core module config state. The DW eDMA PCIe driver in
> > > > opposite depends on the DW eDMA code config state, but will always be
> > > > able to probe the DW eDMA engine as long as the corresponding code is
> > > > loaded as either a part of the kernel or as a loadable module.
> > > > 
> > > > > If both scenarios worked the same, I would think the existing
> > > > > dw_edma_pcie_probe() would be enough, and you wouldn't need to call
> > > > > dw_pcie_edma_detect() from dw_pcie_host_init() and dw_pcie_ep_init().
> > > > 
> > > > No. These methods have been implemented for the absolutely different
> > > > drivers.
> > > > dw_edma_pcie_probe() is called for an end-point PCIe-device found on a
> > > > PCIe-bus.
> > > > dw_pcie_host_init()/dw_pcie_ep_init() and dw_pcie_edma_detect() are
> > > > called for a platform-device representing a DW PCIe RP/EP controller.
> > > > In other words dw_pcie_edma_detect() and dw_edma_pcie_probe() are in
> > > > no means interchangeable.
> > > 
> > > The question is what the user-visible difference between
> > > CONFIG_DW_EDMA_PCIE=y and CONFIG_DW_EDMA_PCIE=m is. 
> > 
> > There will be no difference between them after this commit is applied
> > from the DW eDMA core driver point of view. CONFIG_DW_EDMA_PCIE now
> > depends on the CONFIG_DW_EDMA config state (see it's surrounded by
> > if/endif in the Kconfig file). Without this patch the
> > CONFIG_DW_EDMA_PCIE config determines the CONFIG_DW_EDMA config state
> > by forcibly selecting the one. Using the similar approach for the
> > CONFIG_PCIE_DW driver I found less attractive because it would have
> > effectively converted the CONFIG_DW_EDMA config tristate to boolean.
> > 
> > That's why instead I decided to convert the CONFIG_DW_EDMA config to
> > being independent from any other config value. (See the table in the
> > my previous email message.)
> > 
> > > If there were no
> > > difference, dw_pcie_host_init() would not need to call
> > > dw_pcie_edma_detect().
> > 
> > Even if CONFIG_DW_EDMA (not CONFIG_DW_EDMA_PCIE) is set to m or n I
> > would have still recommended to call dw_pcie_edma_detect() because the
> > method performs the DW eDMA engine auto-detection independently from the DW
> > eDMA driver availability. As a result the system log will have a
> > number of eDMA detected channels if the engine was really found. It's
> > up to the system administrator to make sure that the eDMA driver is
> > properly built/loaded then for the engine to be actually available in
> > the kernel/system.
> >
> > > Can you give me a one- or two-sentence merge commit comment that
> > > explains why we want to merge this?  "Relax driver config settings"
> > > doesn't tell us that.
> > 
> > "Convert the DW eDMA kconfig to being independently selected by the
> > user in order to preserve the module build options flexibility and fix
> > the "undefined reference to" error on DW PCIe driver build."
> 

> In the commit log, I think "forcibly selecting the DW eDMA driver from
> the DW PCIe RP/EP kconfig" actually refers to just the "DW eDMA PCIe"
> driver" not the "DW PCIe RP/EP driver," right?

Right.

> 
> The undefined reference to dw_edma_probe() doesn't actually happen
> unless we merge 27/27 without *this* patch, right? 

Right.

> If so, I wouldn't
> call this a "fix" because nobody has ever seen the link failure.
> 
> OK.  I think this would be much simpler if it were split into two
> patches:
> 
>   1) Prepare dw_edma_probe() for builtin callers
> 
>      When CONFIG_DW_EDMA=m, dw_edma_probe() is built as a module.
>      Previously edma.h declared it as extern, which meant that
>      builtin callers like dw_pcie_host_init() and dw_pcie_ep_init()
>      caused link errors.
> 
>      Make it safe for builtin callers to call dw_edma_probe() by using
>      IS_REACHABLE() to define a stub when CONFIG_DW_EDMA=m.
> 
>      Builtin callers will fail to detect and register eDMA devices
>      when CONFIG_DW_EDMA=m but will otherwise work as before.
> 
>   2) Make DW_EDMA_PCIE depend on DW_EDMA
> 
>      This seems like a good idea and is much nicer than "select
>      DW_EDMA", but I think it should be a separate patch since it
>      really only relates to dw-edma-pcie.c.  

> I would use "depends on
>      DW_EDMA" instead of adding if/endif around DW_EDMA_PCIE.

Could you explain why is the "depends on" operator more preferable
than if/endif? In this case since we have a single core kconfig from
which all the eDMA LLDD config(s) (except PCIE_DW for the reason
previously described) will surely depend on, using if/endif would
cause the possible new eDMA-capable LLDD(s) adding their kconfig
entries within the if-endif clause without need to copy the same
"depends on DW_EDMA" pattern over and over. That seems to look a bit
more maintainable than the alternative you suggest. Do you think
otherwise?

> 
> Am I still missing something?

No, you aren't.

> What do you think? 

What you described was the second option I had in mind for the update
to look like, but after all I decided to take a shorter path and
combine the modifications into a single patch. If you think that
splitting it up would make the update looking simpler then I'll do as
you suggest. But in that case Lorenzo will need to re-merge the
updated patchset v10.

-Serge(y)

> 
> Bjorn
