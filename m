Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2E364E942
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 11:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLPKSf (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 05:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLPKSd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 05:18:33 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A06132BAB;
        Fri, 16 Dec 2022 02:18:32 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p36so2725684lfa.12;
        Fri, 16 Dec 2022 02:18:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=d1igdSOtUouIGen/HpbtAViaw0EJJfv4JYj0+NTM01k=;
        b=ROLtX1krmQo+dkS/Nr+TmfLJyCAku038Btlhf9OkeTugSsfHEOFv89pxIypz/nOoYz
         RbiywK2PhC8VsInGr7MvQvPkBkilq5lkRKjErXrOGZe9rt0riNO92LZX8uZEUhftO17k
         kr50uW7W/uNn68CPKX9PyGDOKruLWbG0J6JMjrYV/d85utpFvHnk1u+LgDk3rywFaAd5
         oYGEygYdxUfw47/8lAQdLMsVO+stHrZGXsp5mftad1L60VFq/97oGjSizdNuz+oZxTYD
         2LKOSiEUYv61KniFHHNzlNn6edwLb+t6/iIL0naWYYZIyQCuHNiypc8P1xS+PoTYf52Z
         WCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1igdSOtUouIGen/HpbtAViaw0EJJfv4JYj0+NTM01k=;
        b=yHf+hbBAuBeKGX85jMZ+mw9YNiJdjjYLZs6MoehvIYA6L84uBnw0r3+ch7p96iMgSu
         aRrLl6Nqv8unTvIUvKg9FccECSEd0AZofCQq78JXJsvVNvZDIedTRyMTksEywe18iQmo
         VSZYYb6Wnn4FRN9OjWA2eiha3s2GvGUrxi+9xE3kDU8hTwd2ocBfX/AtpGr6wz0Mqae5
         ll17CI5wyaJCH3Vr0nsm8B8aCiFQgnv51rEDIfhAkBHxVF7Qi0HDwbun/0tfsiZBqTC0
         kli3CLXv7S9mmq26dovXf98ln4UpvPqnwYH4HHeO9nZKzgMEbp1esiGY6S/bNOM8c8jb
         GyRw==
X-Gm-Message-State: ANoB5pkq2ayTvP4HJ2OS9z8huppzPS8YlcFUc3kRmx5TqkOQZ9vxB69/
        EXF8+WEIGv4CKk4eiiik3JY=
X-Google-Smtp-Source: AA0mqf68eI3DrksOg2kRKgLIBZKXzRe3rlqmcZeVcP5jDtA1uj4KcmjjMsD4lu0pO24gs5dkKqwI5g==
X-Received: by 2002:a05:6512:23a0:b0:4b6:f22c:800e with SMTP id c32-20020a05651223a000b004b6f22c800emr7075968lfv.10.1671185910814;
        Fri, 16 Dec 2022 02:18:30 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id u2-20020ac24c22000000b004979db5aa5bsm179192lfq.223.2022.12.16.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 02:18:30 -0800 (PST)
Date:   Fri, 16 Dec 2022 13:18:27 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <20221216101827.owq7qpakjduf3rit@mobilestation>
References: <20221214235305.31744-1-Sergey.Semin@baikalelectronics.ru>
 <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
 <Y5rJJfZeVqliA5Rg@infradead.org>
 <20221215092721.tvz3hpaql3kotgnu@mobilestation>
 <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
 <20221215235218.wsuwy5uckqfxjnb6@mobilestation>
 <Y5wgvdnMWQDxkUd+@infradead.org>
 <20221216093423.4bettdxisserdzsh@mobilestation>
 <Y5w/MkA4N857+AWQ@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5w/MkA4N857+AWQ@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 16, 2022 at 01:49:38AM -0800, Christoph Hellwig wrote:
> On Fri, Dec 16, 2022 at 12:34:23PM +0300, Serge Semin wrote:
> > What about instead of save/restore pattern I'll just change the
> > dma_set_mask_and_coherent() method with the dma_set_coherent_mask()
> > function call? It seems cleaner. Like this:
> 
> > Thus the platform-specific streaming DMA mask would be preserved.
> > Since it's PCIe then having the streaming DMA-mask less than 32-bits
> > wide is very much improbable. Moreover DW PCIe AXI-interface can be
> > synthesize only with one out of two address bus widths: 32 and 64.
> 

> Where platform-specific means the dwc subdriver? 

Right. I meant the streaming DMA-mask set by the low-level DWC PCIe drivers
(like pcie-qcom(-ep)?.c, pcie-bt1.c, etc). It's very much important to
have the real DMA-mask (at least the streaming one) set for the eDMA-capable
controllers so the DMA-engine clients would work with the best performance.

> Yes, that seems to work. 

Ok. I'll just use the direct dma_set_coherent_mask() method here then.

> Alternatively have a flag that says which streaming mask
> to set.

I'd prefer to have more flexibility here relying on the low-level
drivers to set the mask(s) instead of adding the new flag, just in case
if there is vendor-specific IP-core/platform changes in the address
bus width.

-Serge(y)
