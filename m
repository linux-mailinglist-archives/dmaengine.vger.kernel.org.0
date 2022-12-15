Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A20064D88A
	for <lists+dmaengine@lfdr.de>; Thu, 15 Dec 2022 10:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLOJ13 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 15 Dec 2022 04:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLOJ11 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 15 Dec 2022 04:27:27 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596FF379E3;
        Thu, 15 Dec 2022 01:27:26 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p8so14688298lfu.11;
        Thu, 15 Dec 2022 01:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9La9jgaHqp+Q53gndZnYuaYp/FEo1ZcWn9yC9YZSwDo=;
        b=Fumi66JD44K/pXFyuPaz/HTOflj5ks8FW9NiVI1BEg4N+TvgTdqkXQSxdCNrsbLEmC
         C1mn4WiHR5rA3vXwFc+8Uya/SVtMBjx8Po8Bq490fTf5Gx0c1M5Rj5kxMCdaS31FOn7K
         LxJq+V4unPjE+frXELKlijVktxr7AKsKNxG2uwJ9r0osfdgxcnaaNklAt9Z/Hpy/FkVK
         qyB+eudWjrD0cFmhYRePsD1/UQnUTACos6VjSspQ9KdHX7M091lD3eDWSSYvIp556w29
         S0gMyLF4zuiRb+DfuUSmVO3gVLp72C9qlaGoM0Iu83ePYM9k8fPz6lO09gCeXcD9pUEZ
         qXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9La9jgaHqp+Q53gndZnYuaYp/FEo1ZcWn9yC9YZSwDo=;
        b=G0olSsu8Jru5y1RAz8nfA8K+TWcnMGMZ2anJWKqvPRFsQPmXQkx0mNja6xyfdmdhLL
         SXyu/GeO1fhn4q4vg0SO4NsQHMImjBCt6lH8QBhmob2BcejnmBhmh3wkiDGGzAU/9DGK
         Nq465MUzvaTuTXUN/K5FsTce4X64yAKQdgAxvXqhWrWshL2rNyJZCZr/knba8J2la8My
         FCUbX4GEi3AVr4WNfj4QEuYgrF6TonOFshP/I+JP8CGZiOz9mMQomCGUc/3HR0fVGH0L
         m2DlcFjPPDtgKgdTn0+tWXh/l4Or2VAzkwq8aXZMzoyCUci1DGy395MOFxTAqHL4WoUy
         PyKg==
X-Gm-Message-State: ANoB5plZ10EqdiAT6AeBu1qozZ4e4Bwi2fit2wabCmRK3LquMaTXnold
        eCptFPiEk77p72H2sE7xjR0=
X-Google-Smtp-Source: AA0mqf7fxh68zYgpFRncw4LL6gC4QXNqRfUNgapYJVjDjlahSZxTAKTmsXG5jW9b07okP9WSNCFtxw==
X-Received: by 2002:ac2:443c:0:b0:4b5:5bc1:678c with SMTP id w28-20020ac2443c000000b004b55bc1678cmr7374717lfl.21.1671096444511;
        Thu, 15 Dec 2022 01:27:24 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id q24-20020ac24a78000000b004a05767bc07sm1112526lfp.28.2022.12.15.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 01:27:23 -0800 (PST)
Date:   Thu, 15 Dec 2022 12:27:21 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
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
Message-ID: <20221215092721.tvz3hpaql3kotgnu@mobilestation>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
 <Y5rJJfZeVqliA5Rg@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5rJJfZeVqliA5Rg@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Christoph

On Wed, Dec 14, 2022 at 11:13:41PM -0800, Christoph Hellwig wrote:
> On Thu, Dec 15, 2022 at 02:53:03AM +0300, Serge Semin wrote:
> > DW PCIe Root Ports and End-points can be equipped with the DW eDMA engine.
> > In that case it is critical to have the platform device pre-initialized
> > with a valid DMA-mask so the drivers using the eDMA-engine would be able
> > to allocate the DMA-able buffers. The MSI-capable data requires to be
> > allocated from the lowest 4GB region. Since that procedure implies the
> > DMA-mask change we need to restore the mask set by the low-level drivers
> > after the MSI-data allocation is done.
> 
> You can't change the DMA mask when there are existing allocations.

Em, what do you guys suggest for the DW PCIe devices with the embedded
DMA-engine then? To live forever with the SWIOTLBs? I can't drop the
DMA-mask update due to this commit 423511ec23e2 ("PCI: dwc: Drop
dependency on ZONE_DMA32") and I can't change the mask after it's
updated. Note it's updated for the memory allocation to which actually
no DMA will be performed, see
https://lore.kernel.org/linux-pci/20220825185026.3816331-2-willmcvicker@google.com/.
My patches imply adding the real DMA operations support.

We've discussed this a lot with Robin in various threads and I thought
a workable solution was found. I was going to update the mask in
another place, but basically it would still mean to have first setting
the 32-bit mask here, and then change it to 64-bit one in the
framework of the DW eDMA driver.

So to speak I don't see a proper way out from the situation. Nothing I
suggested was accepted and now we'll have to live with the SWIOTLBs
used for the memory above 4GB. So please suggest a workable solution
then. We need the next things:
1. Somehow preserve a single DWORD of the PCIe bus memory for the
iMSI-RX engine. (That's what is currently done the
dw_pcie_msi_host_init() method by allocating the coherent memory.)
2. Set the actual DMA-mask to the DW PCIe platform device so the
DMA-engine clients would be able to allocate actually DMA-able memory.

@Robin, please join the discussion.

-Serge(y)
