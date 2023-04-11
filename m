Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6B6DD8BD
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 13:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjDKLDf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 07:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKLD2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 07:03:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90BB1982
        for <dmaengine@vger.kernel.org>; Tue, 11 Apr 2023 04:02:52 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id px4so5422571pjb.3
        for <dmaengine@vger.kernel.org>; Tue, 11 Apr 2023 04:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681210968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8NdaDMR88s+1WtvRZzFseNEUErd04u8W3GHHaAxJqcs=;
        b=PcARvOGxXSQhEYhGNs5SJ4lcR/LE0utoGKPBYI+EgKQh+DGinmFPhN5kt43TQ2JyDd
         dKLFtiOqLxKExs6YBGTsPI+kjuI1bSJXgCsoaceJ8gTo2vCVMNwY+9MNxohlTR1KlurA
         ejPL/IfoGTmi99OxNcnJ73DXjqOBgU6/cZlBOKc2BccUlyhHcRUxYZ1t+2tiXT9rope9
         Udup0Y2bP9bDgsRt8kX6kiSz3iUXFwhpMl7Y1oFOHuJF8orX/9f1Qp+qXPFN2SRJ4taQ
         yW/TRxBSYfIyfeWR5l89vB7eQVuWohHz98m0UBLXiWpWMXvatYw+LkFnlYO3oWketJqC
         YUNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681210968;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8NdaDMR88s+1WtvRZzFseNEUErd04u8W3GHHaAxJqcs=;
        b=DXuo2TttNi506s9nvlnFE/6chw49rIMGFtB94/PnumSB24srhi7FzA3Zf/oDih1Zas
         MDhfIHix23b8CmnxHHnBRIiy/GC+ldE4KlRoVYqlLJRyAc5m96zrQ0AvO33s9CVXx6XI
         KKrp+zKAFL4xajqVeDKxdndvvZ68pbzKshL4Ffl5JRDKIjC8S338VgYNyIiEJjnx1eiz
         Nu3rozZrmM9wU6W7WrHRqP4HC85gV/38xXuE2TpwHKc52zwxOGN+mXw2sLAkG1kbQuk8
         BC7d/BBYynS+0xzKGJbOlY37mvAoPVRqyRG48l/AZTQ5PnTTmWASxBY5ov2jCTTh/nKl
         xDlA==
X-Gm-Message-State: AAQBX9dQVlFpEFJmdQoXBy/Oc2pUuO6NyPZqutTVFFDlU8gOTiEh2W+0
        WViBsFS0/nCX0rCrzWU6zFDU
X-Google-Smtp-Source: AKy350YrgJ+yCoYpqvWMVoHJqr9R84fHbxO/QbzkuGhgDRXGWXXcdoOGiDeCw4wvWJg+mz30I1j3aA==
X-Received: by 2002:a17:90b:1c8e:b0:234:e3f:f53b with SMTP id oo14-20020a17090b1c8e00b002340e3ff53bmr13789406pjb.21.1681210967895;
        Tue, 11 Apr 2023 04:02:47 -0700 (PDT)
Received: from thinkpad ([117.216.120.128])
        by smtp.gmail.com with ESMTPSA id i6-20020a170902c28600b0019c92f56983sm9416236pld.120.2023.04.11.04.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 04:02:47 -0700 (PDT)
Date:   Tue, 11 Apr 2023 16:32:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 00/10] PCI: dwc: Relatively simple fixes and
 cleanups
Message-ID: <20230411110240.GB5333@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 11, 2023 at 06:39:18AM +0300, Serge Semin wrote:
> It turns out the recent DW PCIe-related patchset was merged in with
> several relatively trivial issues left unsettled (noted by Bjorn and
> Manivannan). All of these lefovers have been fixed in this patchset.
> Namely the series starts with two bug-fixes. The first one concerns the
> improper link-mode initialization in case if the CDM-check is enabled. The
> second unfortunate mistake I made in the IP-core version type helper. In
> particular instead of testing the IP-core version type the macro function
> referred to the just IP-core version which obviously wasn't what I
> intended.
> 
> Afterwards two @Mani-noted fixes follow. Firstly the dma-ranges related warning
> message is fixed to start with "DMA-ranges" word instead of "Dma-ranges".
> Secondly the Baikal-T1 PCIe Host driver is converted to perform the
> asynchronous probe type which saved us of about 15% of bootup time if no any
> PCIe peripheral device attached to the port.
> 
> Then the patchset contains the Baikal-T1 PCIe driver fix. The
> corresponding patch removes the false error message printed during the
> controller probe procedure. I accidentally added the unconditional
> dev_err_probe() method invocation. It was obviously wrong.
> 
> Then two trivial cleanups are introduced. The first one concerns the
> duplicated fast-link-mode flag unsetting. The second one implies
> dropping a redundant empty line from the dw_pcie_link_set_max_speed()
> function.
> 
> The series continues with a patch inspired by the last @Bjorn note
> regarding the generic resources request interface. As @Bjorn correctly
> said it would be nice to have the new interface used wider in the DW PCIe
> subsystem. Aside with the Baikal-T1 PCIe Host driver the Toshiba Visconti
> PCIe driver can be easily converted to using the generic clock names.
> That's what is done in the noted patch.
> 
> The patchset is closed with a series of MAINTAINERS-list related patches.
> Firstly after getting the DW PCIe RP/EP DT-schemas refactored I forgot to
> update the MAINTAINER-list with the new files added in the framework of
> that procedure. All the snps,dw-pcie* schemas shall be maintained by the
> DW PCIe core driver maintainers. Secondly seeing how long it took for my
> patchsets to review and not having any comments from the original driver
> maintainers I'd suggest to add myself as the reviewer to the DW PCIe and
> eDMA drivers. Thus hopefully the new updates review process will be
> performed with much less latencies. For the same reason I would also like
> to suggest to add @Manivannan as the DW PCIe/eDMA drivers maintainer if
> he isn't against that idea. What do you think about the last suggestion?
> 

I'm willing to co-maintain the drivers.

- Mani

> Link: https://lore.kernel.org/linux-pci/20230217093956.27126-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v2:
> - Rebase onto the kernel 6.3-rc2.
> 
> Link: https://lore.kernel.org/linux-pci/20230313200816.30105-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v3:
> - Drop the patch:
>   [PATCH v2 01/11] PCI: dwc: Fix port link CSR improper init if CDM check enabled
>   and rebase onto the already submitted by @Yoshihiro fix:
>   commit cdce67099117 ("PCI: dwc: Fix PORT_LINK_CONTROL update when CDM check enabled")
> - Just resend.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: linux-pci@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (10):
>   PCI: dwc: Fix erroneous version type test helper
>   PCI: dwc: Fix inbound iATU entries out-of-bounds warning message
>   PCI: bt1: Enable async probe type
>   PCI: bt1: Fix printing false error message
>   PCI: dwc: Drop duplicated fast-link-mode flag unsetting
>   PCI: dwc: Drop empty line from dw_pcie_link_set_max_speed()
>   PCI: visconti: Convert to using generic resources getter
>   MAINTAINERS: Add all generic DW PCIe RP/EP DT-schemas
>   MAINTAINERS: Add myself as the DW PCIe core reviewer
>   MAINTAINERS: Add myself as the DW eDMA driver reviewer
> 
>  MAINTAINERS                                   |  5 ++-
>  drivers/pci/controller/dwc/pcie-bt1.c         |  5 ++-
>  .../pci/controller/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  2 -
>  drivers/pci/controller/dwc/pcie-designware.h  |  7 +++-
>  drivers/pci/controller/dwc/pcie-visconti.c    | 37 +++++++++----------
>  6 files changed, 30 insertions(+), 28 deletions(-)
> 
> -- 
> 2.40.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்
