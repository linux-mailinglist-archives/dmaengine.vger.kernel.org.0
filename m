Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6406DE1AE
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 18:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDKQ7i (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 12:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjDKQ7e (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 12:59:34 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3353A91;
        Tue, 11 Apr 2023 09:59:29 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id t14so11146816lft.7;
        Tue, 11 Apr 2023 09:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681232368; x=1683824368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OctVQvFbU9oze7hYKe9EfozqJRmkksWEaRU+8Dg37n0=;
        b=l7O+jsbtcP1fFso3XlyXUSrEcMckaU49TMJ51Unngk2rziF+KR5obJAu8aXmIkNgNW
         bdhGAQUsZW5OjrJZf2eFOQrzp46QPJJwf56gQOIhCIvGQd43eRw7rtlOb99vYB5uBcg8
         GQadtZQ7dydy9ily8E3qo6HgfHNe6+xw+Kj+MmhkHD6guXJFhyd70ai7LcP5GvuIE9Zk
         OPDgLw7niJR0eEjhlJdbv82sA8Cd5aIB9TP3dL0ZRlcYPtHflNFtU+bn7s2C64uxsC3p
         z7dRPR8F0G6tx/tCxmP3EBWgoRTmNPsYDpfqwMhxz4bpMTP2noPLd0l7nbNGP72sMFwf
         j3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681232368; x=1683824368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OctVQvFbU9oze7hYKe9EfozqJRmkksWEaRU+8Dg37n0=;
        b=c9Iq/c0Qq+ZkCyx4j6dX6XkYkbJ5ZHEx0F6tIUt6Jppj06RbsermaeQ/OnXVcVK1+D
         EEeGK7G6aINDoSdaTpTomc3n1r2+k2doyWBvmKZf0Arkw68B9nh3E+0yvDgR9lFHS2yS
         qYqzgp88jrmQl/V64dyMMBoHwW0l/UD5akwlKKPuA9WGfV3SFhYxlVkrvjIXK6Bc0fWf
         L53UszR+MMVIQK/aWOernYMn/LUoWDw5CnGapmIlhwqOlg45jpHAU4V/2hKVV2/dmCfV
         1zoFRj7SfExAgkt1TjpLNmk9MwBv4BipXjHwqcAUtvXziOKCgPzJMjHTsv+3Roox7asO
         9h4A==
X-Gm-Message-State: AAQBX9evrHMpwYLdqKd0myXuGQScQC+fpJF5akMJ4gJkvQu9VYEKTTp6
        xysYT2r1aQx0d5xjf3WSrTg=
X-Google-Smtp-Source: AKy350ZsoiQq4jkFBsuPohIz9moRVdC2XpP3dGKirkCK8Y9ZK+S+jeXou926CCZWIIWj0wVzy8bihg==
X-Received: by 2002:a05:6512:38cc:b0:4e8:49ff:8df8 with SMTP id p12-20020a05651238cc00b004e849ff8df8mr3561004lft.61.1681232367472;
        Tue, 11 Apr 2023 09:59:27 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id p12-20020a05651238cc00b004ec4f3810ddsm2608021lft.219.2023.04.11.09.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 09:59:26 -0700 (PDT)
Date:   Tue, 11 Apr 2023 19:59:24 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 00/10] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230411165924.4zfwhwxacxxeg7rk@mobilestation>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411110240.GB5333@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411110240.GB5333@thinkpad>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 11, 2023 at 04:32:40PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 11, 2023 at 06:39:18AM +0300, Serge Semin wrote:
> > It turns out the recent DW PCIe-related patchset was merged in with
> > several relatively trivial issues left unsettled (noted by Bjorn and
> > Manivannan). All of these lefovers have been fixed in this patchset.
> > Namely the series starts with two bug-fixes. The first one concerns the
> > improper link-mode initialization in case if the CDM-check is enabled. The
> > second unfortunate mistake I made in the IP-core version type helper. In
> > particular instead of testing the IP-core version type the macro function
> > referred to the just IP-core version which obviously wasn't what I
> > intended.
> > 
> > Afterwards two @Mani-noted fixes follow. Firstly the dma-ranges related warning
> > message is fixed to start with "DMA-ranges" word instead of "Dma-ranges".
> > Secondly the Baikal-T1 PCIe Host driver is converted to perform the
> > asynchronous probe type which saved us of about 15% of bootup time if no any
> > PCIe peripheral device attached to the port.
> > 
> > Then the patchset contains the Baikal-T1 PCIe driver fix. The
> > corresponding patch removes the false error message printed during the
> > controller probe procedure. I accidentally added the unconditional
> > dev_err_probe() method invocation. It was obviously wrong.
> > 
> > Then two trivial cleanups are introduced. The first one concerns the
> > duplicated fast-link-mode flag unsetting. The second one implies
> > dropping a redundant empty line from the dw_pcie_link_set_max_speed()
> > function.
> > 
> > The series continues with a patch inspired by the last @Bjorn note
> > regarding the generic resources request interface. As @Bjorn correctly
> > said it would be nice to have the new interface used wider in the DW PCIe
> > subsystem. Aside with the Baikal-T1 PCIe Host driver the Toshiba Visconti
> > PCIe driver can be easily converted to using the generic clock names.
> > That's what is done in the noted patch.
> > 
> > The patchset is closed with a series of MAINTAINERS-list related patches.
> > Firstly after getting the DW PCIe RP/EP DT-schemas refactored I forgot to
> > update the MAINTAINER-list with the new files added in the framework of
> > that procedure. All the snps,dw-pcie* schemas shall be maintained by the
> > DW PCIe core driver maintainers. Secondly seeing how long it took for my
> > patchsets to review and not having any comments from the original driver
> > maintainers I'd suggest to add myself as the reviewer to the DW PCIe and
> > eDMA drivers. Thus hopefully the new updates review process will be
> > performed with much less latencies. For the same reason I would also like
> > to suggest to add @Manivannan as the DW PCIe/eDMA drivers maintainer if
> > he isn't against that idea. What do you think about the last suggestion?
> > 
> 
> I'm willing to co-maintain the drivers.

Awesome! @Bjorn, @Lorenzo, @Vinod what do you think about this? If you
are ok with that shall I resubmit the series with @Mani added to the
DW PCIe/eDMA maintainers list or will you create the respective
patches yourself?

-Serge(y)

> 
> - Mani
> 
> > Link: https://lore.kernel.org/linux-pci/20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v2:
> > - Rebase onto the kernel 6.3-rc2.
> > 
> > Link: https://lore.kernel.org/linux-pci/20230313200816.30105-1-Sergey.Semin@baikalelectronics.ru/
> > Changelog v3:
> > - Drop the patch:
> >   [PATCH v2 01/11] PCI: dwc: Fix port link CSR improper init if CDM check enabled
> >   and rebase onto the already submitted by @Yoshihiro fix:
> >   commit cdce67099117 ("PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled")
> > - Just resend.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> > Cc: linux-pci@vger.kernel.org
> > Cc: dmaengine@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > 
> > Serge Semin (10):
> >   PCI: dwc: Fix erroneous version type test helper
> >   PCI: dwc: Fix inbound iATU entries out-of-bounds warning message
> >   PCI: bt1: Enable async probe type
> >   PCI: bt1: Fix printing false error message
> >   PCI: dwc: Drop duplicated fast-link-mode flag unsetting
> >   PCI: dwc: Drop empty line from dw_pcie_link_set_max_speed()
> >   PCI: visconti: Convert to using generic resources getter
> >   MAINTAINERS: Add all generic DW PCIe RP/EP DT-schemas
> >   MAINTAINERS: Add myself as the DW PCIe core reviewer
> >   MAINTAINERS: Add myself as the DW eDMA driver reviewer
> > 
> >  MAINTAINERS                                   |  5 ++-
> >  drivers/pci/controller/dwc/pcie-bt1.c         |  5 ++-
> >  .../pci/controller/dwc/pcie-designware-host.c |  2 +-
> >  drivers/pci/controller/dwc/pcie-designware.c  |  2 -
> >  drivers/pci/controller/dwc/pcie-designware.h  |  7 +++-
> >  drivers/pci/controller/dwc/pcie-visconti.c    | 37 +++++++++----------
> >  6 files changed, 30 insertions(+), 28 deletions(-)
> > 
> > -- 
> > 2.40.0
> > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
