Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7546E0EE2
	for <lists+dmaengine@lfdr.de>; Thu, 13 Apr 2023 15:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbjDMNh2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 09:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjDMNhJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 09:37:09 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AFDB748;
        Thu, 13 Apr 2023 06:34:59 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id h37so2361401lfv.0;
        Thu, 13 Apr 2023 06:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681392897; x=1683984897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmyq4oLEbvZOabR5LPmXd0e9aw8CPFOTF9g0Mnw3zQ8=;
        b=fDuwUZeAzLi+d3WGkzskgRw6aBFykNHU6VZk0j2kvhstSqsJ5+JZZIuU521Fa/Uzl1
         YSsNS/atdXZpkA851N1K8ez77pEPyuisxWAW5S/7LIG9y/T14hSBglVrq30cI8pjcEDd
         35xeIhroXJbHr9hZSvMMNEMTw7ZhU5+UUBdmByzRPf3ZqDMPmY62fW3c6GPht5PNAktP
         Sr27jmOHsmn+JcSC/cogDUA+JUyjpHj35CrXIUKr7Q0BpmBgShp93VkF3ngS0BFH3mhD
         EtjgR7vjCayk/KPTyQZiimirFQHqP6O32vZgqGPHMNP2/0MXvzq2qPUPxDlqOkPCeSBa
         IC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681392897; x=1683984897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cmyq4oLEbvZOabR5LPmXd0e9aw8CPFOTF9g0Mnw3zQ8=;
        b=PokdcsPL9/i94ecEIBOLS6LiBLU2wO9jhvdAHWOcmlrnKmrnCulk+6QNBcQ477ZOME
         gNsqgu9c147yYqT0ic3w0lql0x3GKLkrD8wLxF8JBj7X9RQYLbmQ/30HGFYLx8x18njk
         9ofpySg5LEtu0V3XV6NpQVpl9g9IPHVdydjAGiuhBrkZc39yxWpo8DIK4Y9ML7YL52kx
         ikrMFOIxXNIjGh2Ep34QKvynksCe6TU0hMieBvcFlV7Z+nWr3PuZ8KqvK/0nhY3gsw4b
         a4ojjejgrszM6LxT7oEG1kUxtXRiTGNpUifUJ/Oic+WWzVcbaEbs9op96wr7S2KCR4UD
         clJA==
X-Gm-Message-State: AAQBX9dvR/yStZdpx7dlibixyYV4xJ+084rIV4QIJ4yGaMdFYJXoVAQX
        CQhxXCxvC2sB2AmPcpkAoeA=
X-Google-Smtp-Source: AKy350Y0ClOr9efKt6NMyB/FwlTVsKQoR+n+Yg3YAFtd25NhAKi9/lE/9DW+uWAigYTheMD//Dvh2Q==
X-Received: by 2002:ac2:442c:0:b0:4e0:ff8e:bbfe with SMTP id w12-20020ac2442c000000b004e0ff8ebbfemr817572lfl.12.1681392897196;
        Thu, 13 Apr 2023 06:34:57 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id b14-20020ac25e8e000000b004b5979f9ba8sm315586lfq.210.2023.04.13.06.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 06:34:56 -0700 (PDT)
Date:   Thu, 13 Apr 2023 16:34:54 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
Message-ID: <20230413133454.ef7f5s34ysyequfz@mobilestation>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411110240.GB5333@thinkpad>
 <20230411165924.4zfwhwxacxxeg7rk@mobilestation>
 <ZDbjHTenZMxfziZD@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDbjHTenZMxfziZD@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Apr 12, 2023 at 10:28:05PM +0530, Vinod Koul wrote:
> On 11-04-23, 19:59, Serge Semin wrote:
> > On Tue, Apr 11, 2023 at 04:32:40PM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Apr 11, 2023 at 06:39:18AM +0300, Serge Semin wrote:
> > > > It turns out the recent DW PCIe-related patchset was merged in with
> > > > several relatively trivial issues left unsettled (noted by Bjorn and
> > > > Manivannan). All of these lefovers have been fixed in this patchset.
> > > > Namely the series starts with two bug-fixes. The first one concerns the
> > > > improper link-mode initialization in case if the CDM-check is enabled. The
> > > > second unfortunate mistake I made in the IP-core version type helper. In
> > > > particular instead of testing the IP-core version type the macro function
> > > > referred to the just IP-core version which obviously wasn't what I
> > > > intended.
> > > > 
> > > > Afterwards two @Mani-noted fixes follow. Firstly the dma-ranges related warning
> > > > message is fixed to start with "DMA-ranges" word instead of "Dma-ranges".
> > > > Secondly the Baikal-T1 PCIe Host driver is converted to perform the
> > > > asynchronous probe type which saved us of about 15% of bootup time if no any
> > > > PCIe peripheral device attached to the port.
> > > > 
> > > > Then the patchset contains the Baikal-T1 PCIe driver fix. The
> > > > corresponding patch removes the false error message printed during the
> > > > controller probe procedure. I accidentally added the unconditional
> > > > dev_err_probe() method invocation. It was obviously wrong.
> > > > 
> > > > Then two trivial cleanups are introduced. The first one concerns the
> > > > duplicated fast-link-mode flag unsetting. The second one implies
> > > > dropping a redundant empty line from the dw_pcie_link_set_max_speed()
> > > > function.
> > > > 
> > > > The series continues with a patch inspired by the last @Bjorn note
> > > > regarding the generic resources request interface. As @Bjorn correctly
> > > > said it would be nice to have the new interface used wider in the DW PCIe
> > > > subsystem. Aside with the Baikal-T1 PCIe Host driver the Toshiba Visconti
> > > > PCIe driver can be easily converted to using the generic clock names.
> > > > That's what is done in the noted patch.
> > > > 
> > > > The patchset is closed with a series of MAINTAINERS-list related patches.
> > > > Firstly after getting the DW PCIe RP/EP DT-schemas refactored I forgot to
> > > > update the MAINTAINER-list with the new files added in the framework of
> > > > that procedure. All the snps,dw-pcie* schemas shall be maintained by the
> > > > DW PCIe core driver maintainers. Secondly seeing how long it took for my
> > > > patchsets to review and not having any comments from the original driver
> > > > maintainers I'd suggest to add myself as the reviewer to the DW PCIe and
> > > > eDMA drivers. Thus hopefully the new updates review process will be
> > > > performed with much less latencies. For the same reason I would also like
> > > > to suggest to add @Manivannan as the DW PCIe/eDMA drivers maintainer if
> > > > he isn't against that idea. What do you think about the last suggestion?
> > > > 
> > > 
> > > I'm willing to co-maintain the drivers.
> > 
> > Awesome! @Bjorn, @Lorenzo, @Vinod what do you think about this? If you
> > are ok with that shall I resubmit the series with @Mani added to the
> > DW PCIe/eDMA maintainers list or will you create the respective
> > patches yourself?
> 

> Pls send the patch, that is preferred.

Ok. I'll resubmit the series with the new patches replacing @Gustavo with
@Mani as the DW PCIe/eDMA drivers maintainer.

-Serge(y)

> 
> -- 
> ~Vinod
