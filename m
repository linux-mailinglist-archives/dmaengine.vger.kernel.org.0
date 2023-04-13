Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A086E0F75
	for <lists+dmaengine@lfdr.de>; Thu, 13 Apr 2023 16:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbjDMOAo (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 13 Apr 2023 10:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbjDMOAn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 13 Apr 2023 10:00:43 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BB911A
        for <dmaengine@vger.kernel.org>; Thu, 13 Apr 2023 07:00:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id f2so6623903pjs.3
        for <dmaengine@vger.kernel.org>; Thu, 13 Apr 2023 07:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681394439; x=1683986439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eU7u0EkiQfnb6V3VFY3Ec1E3n975+Yez3QLaf1ODnhY=;
        b=WQ71X16q30n1tfqSkTXLlQP4ewh0QXuSldlKGsgCOLGrpfK1U+iWXINSZ41KbS696t
         IJLy7kBz6Koc+UIges8Fe2I5IRoERd7DiuEEVRsLfMxMwqrCRKDOG9qx3l9OVWUYsMg/
         uysCWsUliRa3GCRm4vAiZzx5Wlt6MSdmyGqXBs8vOAry5UTX1xBj9uG/S1NcRoXweGkM
         Ujv02Pxyiz94IX2mLjsVQdtXbY17BJX1+CnjROuH9dkI2w1mg+tPZPSfiXEOr444x3lh
         8xV5MSlznYobKS/ii7vMwF/SR9nF1wviAWzACQTCbviOWEVuW5MZJtLVUfY6q/ts8tyg
         VY5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681394439; x=1683986439;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eU7u0EkiQfnb6V3VFY3Ec1E3n975+Yez3QLaf1ODnhY=;
        b=i9lBmO+L/GxDNBXAzGn/7q6VftTVE/C0NrEFrEQo1X6maX7k8pMTvsGk4ICDgM6u/u
         xJwjiA3wxU/313hDdninRw43NT1Qu//vZ1++vRNPA4bzeqj8qYND36iZFYj7r9kpfp/5
         d8Ta239mUC55xujIffRjCA55G2M1jsHZsbDeaWLbyBvAvWW+9qvAnX0o4qeTcf2CcsAu
         wd3oNQMr6wIoQcirv6MEcEf1S79rmA6ID5HefAJ0/zqWbAeqiYO3sBVLu1BZswpD8pVr
         m+EIGaiuoU4G11QCZXsdDJgKzx0Cf0m1ElOGh9UMECh/F4uxP1L5/liCFFUXbCSnY/mo
         tHzQ==
X-Gm-Message-State: AAQBX9ev4DfTLalvm2xYcqzgJaMzIiRoyTkmR8rC56TlYSMGWLMbeCqk
        byRyIqNCZ4uK2xMhL/koFNQ3rNIzcOdpfyWfMw==
X-Google-Smtp-Source: AKy350a+RE5Hskp2Ss1xXf+Z4HSXMhew7c9wbH+dJHlwg2B0agWdmevsupoTrImu8QKwix9q4MHvZA==
X-Received: by 2002:a17:903:90d:b0:1a1:e93c:8937 with SMTP id ll13-20020a170903090d00b001a1e93c8937mr2606863plb.35.1681394439278;
        Thu, 13 Apr 2023 07:00:39 -0700 (PDT)
Received: from thinkpad ([59.97.52.67])
        by smtp.gmail.com with ESMTPSA id a1-20020a170902900100b001a6756a36f6sm1524223plp.101.2023.04.13.07.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 07:00:38 -0700 (PDT)
Date:   Thu, 13 Apr 2023 19:30:24 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Serge Semin <fancer.lancer@gmail.com>
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
Message-ID: <20230413140024.GA13020@thinkpad>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411110240.GB5333@thinkpad>
 <20230411165924.4zfwhwxacxxeg7rk@mobilestation>
 <ZDbjHTenZMxfziZD@matsya>
 <20230413133454.ef7f5s34ysyequfz@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230413133454.ef7f5s34ysyequfz@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Apr 13, 2023 at 04:34:54PM +0300, Serge Semin wrote:
> On Wed, Apr 12, 2023 at 10:28:05PM +0530, Vinod Koul wrote:
> > On 11-04-23, 19:59, Serge Semin wrote:
> > > On Tue, Apr 11, 2023 at 04:32:40PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Apr 11, 2023 at 06:39:18AM +0300, Serge Semin wrote:
> > > > > It turns out the recent DW PCIe-related patchset was merged in with
> > > > > several relatively trivial issues left unsettled (noted by Bjorn and
> > > > > Manivannan). All of these lefovers have been fixed in this patchset.
> > > > > Namely the series starts with two bug-fixes. The first one concerns the
> > > > > improper link-mode initialization in case if the CDM-check is enabled. The
> > > > > second unfortunate mistake I made in the IP-core version type helper. In
> > > > > particular instead of testing the IP-core version type the macro function
> > > > > referred to the just IP-core version which obviously wasn't what I
> > > > > intended.
> > > > > 
> > > > > Afterwards two @Mani-noted fixes follow. Firstly the dma-ranges related warning
> > > > > message is fixed to start with "DMA-ranges" word instead of "Dma-ranges".
> > > > > Secondly the Baikal-T1 PCIe Host driver is converted to perform the
> > > > > asynchronous probe type which saved us of about 15% of bootup time if no any
> > > > > PCIe peripheral device attached to the port.
> > > > > 
> > > > > Then the patchset contains the Baikal-T1 PCIe driver fix. The
> > > > > corresponding patch removes the false error message printed during the
> > > > > controller probe procedure. I accidentally added the unconditional
> > > > > dev_err_probe() method invocation. It was obviously wrong.
> > > > > 
> > > > > Then two trivial cleanups are introduced. The first one concerns the
> > > > > duplicated fast-link-mode flag unsetting. The second one implies
> > > > > dropping a redundant empty line from the dw_pcie_link_set_max_speed()
> > > > > function.
> > > > > 
> > > > > The series continues with a patch inspired by the last @Bjorn note
> > > > > regarding the generic resources request interface. As @Bjorn correctly
> > > > > said it would be nice to have the new interface used wider in the DW PCIe
> > > > > subsystem. Aside with the Baikal-T1 PCIe Host driver the Toshiba Visconti
> > > > > PCIe driver can be easily converted to using the generic clock names.
> > > > > That's what is done in the noted patch.
> > > > > 
> > > > > The patchset is closed with a series of MAINTAINERS-list related patches.
> > > > > Firstly after getting the DW PCIe RP/EP DT-schemas refactored I forgot to
> > > > > update the MAINTAINER-list with the new files added in the framework of
> > > > > that procedure. All the snps,dw-pcie* schemas shall be maintained by the
> > > > > DW PCIe core driver maintainers. Secondly seeing how long it took for my
> > > > > patchsets to review and not having any comments from the original driver
> > > > > maintainers I'd suggest to add myself as the reviewer to the DW PCIe and
> > > > > eDMA drivers. Thus hopefully the new updates review process will be
> > > > > performed with much less latencies. For the same reason I would also like
> > > > > to suggest to add @Manivannan as the DW PCIe/eDMA drivers maintainer if
> > > > > he isn't against that idea. What do you think about the last suggestion?
> > > > > 
> > > > 
> > > > I'm willing to co-maintain the drivers.
> > > 
> > > Awesome! @Bjorn, @Lorenzo, @Vinod what do you think about this? If you
> > > are ok with that shall I resubmit the series with @Mani added to the
> > > DW PCIe/eDMA maintainers list or will you create the respective
> > > patches yourself?
> > 
> 
> > Pls send the patch, that is preferred.
> 
> Ok. I'll resubmit the series with the new patches replacing @Gustavo with
> @Mani as the DW PCIe/eDMA drivers maintainer.
> 

I talked to Vinod about the non-responsive maintainers and he suggested first
demoting them as Reviewers instead of dropping altogether. So you can move
Gustavo as a Reviewer.

- Mani

> -Serge(y)
> 
> > 
> > -- 
> > ~Vinod

-- 
மணிவண்ணன் சதாசிவம்
