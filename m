Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251416E18F0
	for <lists+dmaengine@lfdr.de>; Fri, 14 Apr 2023 02:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjDNAZo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 20:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDNAZn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 20:25:43 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE98BB7;
        Thu, 13 Apr 2023 17:25:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id o1so21418476lfc.2;
        Thu, 13 Apr 2023 17:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681431940; x=1684023940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yImyeG5ZxqGz4x0G0VPUdchtzunzdj+0SM9hBCkgnyg=;
        b=Mv4xq2QsrYjJgA811eWnvVImUuOV8yAqj66zXVSdL5nfEqlMrzRX3lxbNITcggvyB2
         hHqs3sNKmFMp4elA+jeNj0VRoDfKrFWQWUwBjFsPyeAgB7QJiqzqZ7hn7IFUehlyJtOv
         HvrxuC4dx8qClWvWPzlwqwCu5vZPuXO0TpDpv7F2Alc402slBpfLfjBP0PkQ3mML3ruO
         M6EA2JV9IWwUeJU3N0/UQxrHAs2OvwfQQsnfNazcy5jK7DRsi/75gRkZHXOLYm5T7sKX
         pACW7c2gcszTC4eQwGoJUzgRznikrznv7ilQxPRDDKT3Csx7kBxhCZC1Ly3p5RWM8rE3
         gwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681431940; x=1684023940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yImyeG5ZxqGz4x0G0VPUdchtzunzdj+0SM9hBCkgnyg=;
        b=GF0fHz8NkZdeBUfX+6YCoLvvKDcs7l9emuuS1VME0mVFcMe52a2opcv1I+RUBVPq4a
         s35BpBfKV6NskZLuF86DhwnJropsf/lEa7wtk0M8AH9d3w7wUdkT+54bxuzneX7RY1xK
         Gb0xGLa3bD3JQpPbsg6L86M551nwLhHQkUttgj7qKkAu2VK1Ro5HQMYDUQrHrB+KWCTi
         KF7+D0RR9eifF7ogsc07PDmIjGZrTpaBYWp4qQDklV17mGyQSbqj1PAP0MJ4SxKE1vAI
         3Cj6q9hA8uqJbdCnA034qhLLFs8jAE/H7iK4vb7a7RMdq4Cbp1juBKV1fj1vgkwTkXkL
         Cukw==
X-Gm-Message-State: AAQBX9c1Q9CMFqzzNG+NuyAzrTN9FcATsROJLsvk8wrD+8vTovLJ6pPU
        uXngKcnakDP6+QW3Ya9c2jk=
X-Google-Smtp-Source: AKy350YA6vyufvtq/6uKoGm4dYs9Gz/KECvQicem/fbRJeNTqzz6GKU+7JPL1tNbi4GS/57PRhud6g==
X-Received: by 2002:a19:f00b:0:b0:4db:4fe8:fd0f with SMTP id p11-20020a19f00b000000b004db4fe8fd0fmr1210449lfc.25.1681431940097;
        Thu, 13 Apr 2023 17:25:40 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id k4-20020ac24564000000b004ec9361e3c5sm523253lfm.142.2023.04.13.17.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 17:25:39 -0700 (PDT)
Date:   Fri, 14 Apr 2023 03:25:37 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <20230414002537.3y553iferlqkubfo@mobilestation>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411110240.GB5333@thinkpad>
 <20230411165924.4zfwhwxacxxeg7rk@mobilestation>
 <ZDbjHTenZMxfziZD@matsya>
 <20230413133454.ef7f5s34ysyequfz@mobilestation>
 <20230413140024.GA13020@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230413140024.GA13020@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 13, 2023 at 07:30:24PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Apr 13, 2023 at 04:34:54PM +0300, Serge Semin wrote:
> > On Wed, Apr 12, 2023 at 10:28:05PM +0530, Vinod Koul wrote:
> > > On 11-04-23, 19:59, Serge Semin wrote:
> > > > On Tue, Apr 11, 2023 at 04:32:40PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Apr 11, 2023 at 06:39:18AM +0300, Serge Semin wrote:
> > > > > > It turns out the recent DW PCIe-related patchset was merged in with
> > > > > > several relatively trivial issues left unsettled (noted by Bjorn and
> > > > > > Manivannan). All of these lefovers have been fixed in this patchset.
> > > > > > Namely the series starts with two bug-fixes. The first one concerns the
> > > > > > improper link-mode initialization in case if the CDM-check is enabled. The
> > > > > > second unfortunate mistake I made in the IP-core version type helper. In
> > > > > > particular instead of testing the IP-core version type the macro function
> > > > > > referred to the just IP-core version which obviously wasn't what I
> > > > > > intended.
> > > > > > 
> > > > > > Afterwards two @Mani-noted fixes follow. Firstly the dma-ranges related warning
> > > > > > message is fixed to start with "DMA-ranges" word instead of "Dma-ranges".
> > > > > > Secondly the Baikal-T1 PCIe Host driver is converted to perform the
> > > > > > asynchronous probe type which saved us of about 15% of bootup time if no any
> > > > > > PCIe peripheral device attached to the port.
> > > > > > 
> > > > > > Then the patchset contains the Baikal-T1 PCIe driver fix. The
> > > > > > corresponding patch removes the false error message printed during the
> > > > > > controller probe procedure. I accidentally added the unconditional
> > > > > > dev_err_probe() method invocation. It was obviously wrong.
> > > > > > 
> > > > > > Then two trivial cleanups are introduced. The first one concerns the
> > > > > > duplicated fast-link-mode flag unsetting. The second one implies
> > > > > > dropping a redundant empty line from the dw_pcie_link_set_max_speed()
> > > > > > function.
> > > > > > 
> > > > > > The series continues with a patch inspired by the last @Bjorn note
> > > > > > regarding the generic resources request interface. As @Bjorn correctly
> > > > > > said it would be nice to have the new interface used wider in the DW PCIe
> > > > > > subsystem. Aside with the Baikal-T1 PCIe Host driver the Toshiba Visconti
> > > > > > PCIe driver can be easily converted to using the generic clock names.
> > > > > > That's what is done in the noted patch.
> > > > > > 
> > > > > > The patchset is closed with a series of MAINTAINERS-list related patches.
> > > > > > Firstly after getting the DW PCIe RP/EP DT-schemas refactored I forgot to
> > > > > > update the MAINTAINER-list with the new files added in the framework of
> > > > > > that procedure. All the snps,dw-pcie* schemas shall be maintained by the
> > > > > > DW PCIe core driver maintainers. Secondly seeing how long it took for my
> > > > > > patchsets to review and not having any comments from the original driver
> > > > > > maintainers I'd suggest to add myself as the reviewer to the DW PCIe and
> > > > > > eDMA drivers. Thus hopefully the new updates review process will be
> > > > > > performed with much less latencies. For the same reason I would also like
> > > > > > to suggest to add @Manivannan as the DW PCIe/eDMA drivers maintainer if
> > > > > > he isn't against that idea. What do you think about the last suggestion?
> > > > > > 
> > > > > 
> > > > > I'm willing to co-maintain the drivers.
> > > > 
> > > > Awesome! @Bjorn, @Lorenzo, @Vinod what do you think about this? If you
> > > > are ok with that shall I resubmit the series with @Mani added to the
> > > > DW PCIe/eDMA maintainers list or will you create the respective
> > > > patches yourself?
> > > 
> > 
> > > Pls send the patch, that is preferred.
> > 
> > Ok. I'll resubmit the series with the new patches replacing @Gustavo with
> > @Mani as the DW PCIe/eDMA drivers maintainer.
> > 
> 
> I talked to Vinod about the non-responsive maintainers and he suggested first
> demoting them as Reviewers instead of dropping altogether. So you can move
> Gustavo as a Reviewer.

Got it. Thanks for the note.

-Serge(y)

> 
> - Mani
> 
> > -Serge(y)
> > 
> > > 
> > > -- 
> > > ~Vinod
> 
> -- 
> மணிவண்ணன் சதாசிவம்
