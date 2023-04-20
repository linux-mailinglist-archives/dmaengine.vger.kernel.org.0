Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AC36E9D53
	for <lists+dmaengine@lfdr.de>; Thu, 20 Apr 2023 22:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjDTUkF (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 20 Apr 2023 16:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbjDTUkE (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 20 Apr 2023 16:40:04 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310A10D8;
        Thu, 20 Apr 2023 13:40:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4ec81245ae1so876855e87.0;
        Thu, 20 Apr 2023 13:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682023201; x=1684615201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AUbQ+MnIhboEjV+/fmnhA5xYvv9W6JDCwMUV4DMmoc=;
        b=NuD9Tf7QOTcnmEjUEJinD5uDjBkNph/F1HQvY4UIBtzt25HuFOyEQ8MZjzCiZKgyIr
         gvdmRL5cmXZ7V9y4PB2iFd9Disf7TCpgcSFODkdxOI7BkS1GQ20s2O9XimOiGo8XYvRR
         InHFCK5MUoXdsbpSpaPhtdfWTNqzkUoSC2A/HFa+Hugsl6dTAK62wODI/yEBWM2HbGXb
         rVHgL1niDyHI46E3BQjkJ1Rr8hTB/+/CK7SKn5hw5PSp1fehYU/vuoXA01rS7jBNQSi+
         B3hf+w9DQ+UKKuIgVY2KNSiMYets+srEIruy6/kOzn4UMxTV0Tsy9zUdRtsCS5+XdybX
         WQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682023201; x=1684615201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AUbQ+MnIhboEjV+/fmnhA5xYvv9W6JDCwMUV4DMmoc=;
        b=VFmC99n5NcETr6CLQX+kfyAZQDwAsmjKIRkQWVW0erYCvfXHt6o7BttVVw5K4Mv00o
         FumEp8X7bitG7cYCO3+tGHWOHNYnSwS9e9e0lCsv3xw6AzrdUQEypdjSl7g0Hoa9svn/
         WCFSxjT+sLXUG4MfTzZz+wUmRpOGTCdyUPwQsa5iz4o0AMikn5Raqu8GR0AjG7WdpLnu
         DGtLkVCFu2z8ur5x4oig8sZH1QFCuzHGBqd0n8FAgJY98D2vkfmUaGrAh+18YJIxyEij
         IASbIwDaE6mCBs0V5uwqPKOQ6CZV5QkLdcntfwcK1gy23d6KX0PTxXkI2ojFcjvI5Zy5
         f3Og==
X-Gm-Message-State: AAQBX9cvYCkzchWlnR8McyQYZDupJ4I5gcYkONMmFhfYPIjAmlySVA8S
        daGB9z420GL8JaFJR0t0qhI=
X-Google-Smtp-Source: AKy350Yg05neSwu4t2MBMCcOjh/n1P7hxNGl3ovJLFfWIAQBo8kYEJM3ks+Xncy5Dg7TSmksqVSW3A==
X-Received: by 2002:ac2:5103:0:b0:4ed:be06:9e9a with SMTP id q3-20020ac25103000000b004edbe069e9amr713354lfb.26.1682023201014;
        Thu, 20 Apr 2023 13:40:01 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id e14-20020ac2546e000000b004eaeb0a984csm326772lfn.88.2023.04.20.13.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:40:00 -0700 (PDT)
Date:   Thu, 20 Apr 2023 23:39:58 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] PCI: dwc: Relatively simple fixes and cleanups
Message-ID: <20230420203958.vozr25hbfx2d7gjt@mobilestation>
References: <20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414021832.13167-1-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Bjorn, Vinod, Mani

On Fri, Apr 14, 2023 at 05:18:18AM +0300, Serge Semin wrote:
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
> performed with much less latencies. For the same reason @Manivannan is
> added to the maintainers list of the DW PCIe/eDMA drivers as he already
> agreed to be in.

@Bjorn, anything to say about this patchset? If you are ok with the
changes please merge in the PCI patches.
@Vinod, as you requested the series has been extended with the patches
based on v3 discussion. Please have a look.
@Mani, the series has been updated with the patches adding you as the
DW PCIe/eDMA maintainer as per your permission retrieved on v3.

-Serge(y)

> 
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
> Link: https://lore.kernel.org/linux-pci/20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru/
> Changelog v4:
> - Demote @Gustavo to being DW PCIe/eDMA drivers reviewer:
>   [PATCH v4 9/14] MAINTAINERS: Demote Gustavo Pimentel to DW PCIe core reviewer
>   [PATCH v4 12/14] MAINTAINERS: Demote Gustavo Pimentel to DW EDMA driver reviewer
> - Add Manivannan to the DW PCIe/eDMA drivers maintainers list:
>   [PATCH v4 10/14] MAINTAINERS: Add Manivannan to DW PCIe core maintainers list
>   [PATCH v4 13/14] MAINTAINERS: Add Manivannan to DW eDMA driver maintainers list
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: linux-pci@vger.kernel.org
> Cc: dmaengine@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (14):
>   PCI: dwc: Fix erroneous version type test helper
>   PCI: dwc: Fix inbound iATU entries out-of-bounds warning message
>   PCI: bt1: Enable async probe type
>   PCI: bt1: Fix printing false error message
>   PCI: dwc: Drop duplicated fast-link-mode flag unsetting
>   PCI: dwc: Drop empty line from dw_pcie_link_set_max_speed()
>   PCI: visconti: Convert to using generic resources getter
>   MAINTAINERS: Add all generic DW PCIe RP/EP DT-schemas
>   MAINTAINERS: Demote Gustavo Pimentel to DW PCIe core reviewer
>   MAINTAINERS: Add Manivannan to DW PCIe core maintainers list
>   MAINTAINERS: Add myself as the DW PCIe core reviewer
>   MAINTAINERS: Demote Gustavo Pimentel to DW EDMA driver reviewer
>   MAINTAINERS: Add Manivannan to DW eDMA driver maintainers list
>   MAINTAINERS: Add myself as the DW eDMA driver reviewer
> 
>  MAINTAINERS                                   | 11 ++++--
>  drivers/pci/controller/dwc/pcie-bt1.c         |  5 ++-
>  .../pci/controller/dwc/pcie-designware-host.c |  2 +-
>  drivers/pci/controller/dwc/pcie-designware.c  |  2 -
>  drivers/pci/controller/dwc/pcie-designware.h  |  7 +++-
>  drivers/pci/controller/dwc/pcie-visconti.c    | 37 +++++++++----------
>  6 files changed, 34 insertions(+), 30 deletions(-)
> 
> -- 
> 2.40.0
> 
> 
