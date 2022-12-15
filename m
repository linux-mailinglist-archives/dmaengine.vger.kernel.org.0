Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC92B64E4D1
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 00:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiLOXwc (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Dec 2022 18:52:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiLOXw2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Dec 2022 18:52:28 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E3562EB2;
        Thu, 15 Dec 2022 15:52:23 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id g7so945324lfv.5;
        Thu, 15 Dec 2022 15:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5dW+qE3K4WxtDVef0E/p9l1mmLjZkDc4bP16tw6sUOI=;
        b=IUymvE++JRvF7a7y/097BLBaWDnTlO0F7EWl4HkArCUI7N+w/aoAlDcEcovR1oaCEt
         mVG5DiQTkoCcsy1AmmEfxb20ZF772QtQ6nVn2qGEsO5/kliQiz/KJBTYa2CcCESe4210
         Bm0PJvN3VCFaatRhbjJ+jdUW+UzVUxxDOoWCO4BAJkfwBO0aIbxvqXVx6cDaHcsibS1B
         X5W+ttylCrQzRJrZ9C4o1RbNlQGZLwD9xIHXqVrV53K60yOZ8aft6fhjb8pUz3Wd0RzG
         NR1TQdIHd7KIj5tL1Xr4eQK4Z3ADGf0BYThfppLwjsotlPmI7OwqDreI7m8pWAZ/kQLx
         BFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dW+qE3K4WxtDVef0E/p9l1mmLjZkDc4bP16tw6sUOI=;
        b=SwvpUzqslJ2ITGbr4Hj0SBi3KXEyns6CF5u3ULhqY23gB+1SAPWboW4ZAIa8wKZAhC
         psqTeiHB1K2nBJ4a4+11LwPabT3XKI2TPrMtmmFEZHxZDWWgvvY0aBHkBJIO2omTPHzo
         tISKWmve3qYbX2xAD3HJUkpxzz+EeOs3QjMauUvnESFmL3y47pvkmAF8L82ofbxcA82Y
         7gIRSgYUayKr9by6C0FWKaim8axF3rOJZogBSk/1sy7Co+fr1ZV/4ereAoUEZdaQu/nH
         jHm7qPTTHIv3Xop42R4N8He3LHbuVTk4Er5f9rEJ6wI3/6J+A2cC/+8PlKuXQ6SZ9kNb
         QWWA==
X-Gm-Message-State: ANoB5pkJFbwhUGCPqpgKAyr0a16GhwvgXiPy1V3KP/SZ8eMxbV9d8FLo
        HHrH917+pMsqxr8O5b78fr0=
X-Google-Smtp-Source: AA0mqf5lcT3SvSHdWwM8ocywqQux+phHblPhKs2Ii2OGWPgRABCYCw0q9U2xvnjyqr7gOBWqskzglg==
X-Received: by 2002:a05:6512:6ca:b0:4a4:68b8:f4da with SMTP id u10-20020a05651206ca00b004a468b8f4damr10047600lff.32.1671148341873;
        Thu, 15 Dec 2022 15:52:21 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id m18-20020a056512359200b004b523766c23sm45661lfr.202.2022.12.15.15.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 15:52:21 -0800 (PST)
Date:   Fri, 16 Dec 2022 02:52:18 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 23/25] PCI: dwc: Restore DMA-mask after MSI-data
 allocation
Message-ID: <20221215235218.wsuwy5uckqfxjnb6@mobilestation>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
 <Y5rJJfZeVqliA5Rg@infradead.org>
 <20221215092721.tvz3hpaql3kotgnu@mobilestation>
 <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Dec 15, 2022 at 10:26:08AM +0000, Robin Murphy wrote:
> On 2022-12-15 09:27, Serge Semin wrote:
> > Hi Christoph
> > 
> > On Wed, Dec 14, 2022 at 11:13:41PM -0800, Christoph Hellwig wrote:
> > > On Thu, Dec 15, 2022 at 02:53:03AM +0300, Serge Semin wrote:
> > > > DW PCIe Root Ports and End-points can be equipped with the DW eDMA engine.
> > > > In that case it is critical to have the platform device pre-initialized
> > > > with a valid DMA-mask so the drivers using the eDMA-engine would be able
> > > > to allocate the DMA-able buffers. The MSI-capable data requires to be
> > > > allocated from the lowest 4GB region. Since that procedure implies the
> > > > DMA-mask change we need to restore the mask set by the low-level drivers
> > > > after the MSI-data allocation is done.
> > > 
> > > You can't change the DMA mask when there are existing allocations.
> > 
> > Em, what do you guys suggest for the DW PCIe devices with the embedded
> > DMA-engine then? To live forever with the SWIOTLBs? I can't drop the
> > DMA-mask update due to this commit 423511ec23e2 ("PCI: dwc: Drop
> > dependency on ZONE_DMA32") and I can't change the mask after it's
> > updated. Note it's updated for the memory allocation to which actually
> > no DMA will be performed, see
> > https://lore.kernel.org/linux-pci/20220825185026.3816331-2-willmcvicker@google.com/.
> > My patches imply adding the real DMA operations support.
> > 
> > We've discussed this a lot with Robin in various threads and I thought
> > a workable solution was found. I was going to update the mask in
> > another place, but basically it would still mean to have first setting
> > the 32-bit mask here, and then change it to 64-bit one in the
> > framework of the DW eDMA driver.
> > 
> > So to speak I don't see a proper way out from the situation. Nothing I
> > suggested was accepted and now we'll have to live with the SWIOTLBs
> > used for the memory above 4GB. So please suggest a workable solution
> > then. We need the next things:
> > 1. Somehow preserve a single DWORD of the PCIe bus memory for the
> > iMSI-RX engine. (That's what is currently done the
> > dw_pcie_msi_host_init() method by allocating the coherent memory.)
> > 2. Set the actual DMA-mask to the DW PCIe platform device so the
> > DMA-engine clients would be able to allocate actually DMA-able memory.
> > 
> > @Robin, please join the discussion.
> 

> Basically just don't touch the coherent mask. The eDMA drivers can still set
> the streaming mask to something larger, and that's the one that's going to
> matter for most dmaengine clients anyway. Even if someone does call
> dma_alloc_coherent() for their eDMA channel, it's not going to make much
> practical difference if that has to come from a DMA zone, unless the system
> is under severe memory pressure anyway.

Got it. Thanks for clarification. I'll resubmit the series with only
the streaming DMA mask restoration.

-Serge(y)

> 
> Thanks,
> Robin.
