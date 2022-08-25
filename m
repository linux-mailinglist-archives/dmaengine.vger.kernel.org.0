Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884D55A0844
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 07:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiHYFFG (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 01:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiHYFFF (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 01:05:05 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6154177564;
        Wed, 24 Aug 2022 22:05:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id m3so21039604lfg.10;
        Wed, 24 Aug 2022 22:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=/mJwD5WqfZqUGmaCZaV4F1wgF4MO3MeJcEiyND1peTg=;
        b=R9B+hhI1H3JsWGcUHy6ei5sATKEMjeIlH7yiVrgqlfOqDkLszxF+km9HvFqtnlYw+7
         QYVXH9pudTEWKS7VKHt9RqzfFR9o+cgE5LxcCn+XDtfGIlqyaYLi5V2/2Rekfx9HYGn4
         o6w15HDXtiqN4KN+m56loTvEL6nmfAqBMttu7OvuGeaVMf6okXCQdNQFeuNg4KH9FCPB
         Sl8GfOB3WTcMxe9vU2BJL/bHwofhooQdqd76icvv/7ixaknsAlD9R7SRlwgF9AQ0fizS
         cfwxO+V+08g/eoSywGT/SDGyxO+dAN9V9jyiD/bXKpIyfq0kEinQunvS7jHomY2QF9ac
         Xylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=/mJwD5WqfZqUGmaCZaV4F1wgF4MO3MeJcEiyND1peTg=;
        b=yPTAXL0t8NN2gfwh5yANdSbUCyyS4w1r0eL5KXyQJNtAwhwF//n+6CvjEQ7jnJGw/C
         EUP34skHcMX5zM6L6+trDP7qt2+VnZJ7814daPao+ARVsnYWTNnhx6zl14uW8008YJmw
         tuibXyUJnlB0Y5Iud6KJEFujYV/O+GlaBkly42a+jGAra4m6BWpsTxoPRawCeGgcj/9u
         E7DijYZBAFIUp55fvaRdbHZIM7g1WlCgYQCUVpeb2JupalVyaW3O4quWyM4YFkG0wStN
         j50W7yGI2Gp4WJcNSRF9U/e0hSFUZL4uh5CRI72cNwe7uioaglZbiPJVf3Sy+8H/LyRC
         qbrg==
X-Gm-Message-State: ACgBeo3ZEXrKrz/Pnr9CkHJwFh+XNC5VVFURKTUvBUYY2Z3KqBTQI4Ef
        vrJ3DqhbobfNDA+JQ108ZHc=
X-Google-Smtp-Source: AA6agR67TyWeVZguGNjURw0aL2LSVIVjory5+koRoM4N2AK9JO5iQp8GTkwrE3EvxkPxJAAmqEbl7A==
X-Received: by 2002:a05:6512:b12:b0:492:8943:c813 with SMTP id w18-20020a0565120b1200b004928943c813mr555845lfu.143.1661403901706;
        Wed, 24 Aug 2022 22:05:01 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id v12-20020a05651203ac00b0048b086f4fb0sm292124lfp.109.2022.08.24.22.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 22:05:00 -0700 (PDT)
Date:   Thu, 25 Aug 2022 08:04:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220825050457.esxb4oc6yht5kw6o@mobilestation>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220823154526.GB6371@thinkpad>
 <20220824140759.7gg7t53z2xi7jxaj@mobilestation>
 <Ywb9r3f+wSkpk7gY@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywb9r3f+wSkpk7gY@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 25, 2022 at 10:12:23AM +0530, Vinod Koul wrote:
> On 24-08-22, 17:07, Serge Semin wrote:
> > On Tue, Aug 23, 2022 at 09:15:26PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Aug 22, 2022 at 09:53:08PM +0300, Serge Semin wrote:
> 
> > > I've tested this series on Qualcomm SM8450 SoC based dev board. So,
> > > 
> > > Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > 
> > Thanks.
> > 
> > > Not sure what is the merging strategy for this one but this series should get
> > > merged into a single tree. Since the PCI patch is touching the designware
> > > driver, merging the series into dmaengine tree might result in conflict later.
> > 
> > Right, the series
> > [PATCH v5 00/20] PCI: dwc: Add generic resources and Baikal-T1 support
> > is supposed to be merged in first. Then this one will get to be
> > applied with no conflicts. That's what I imply in the head of the
> > cover-letter.
> 

> I dont see a dependency of dma patches with PCIe patches? I guess they
> could go thru the respective trees now..?

There is a backward dependency: the PCIe patch in this series depends
on the eDMA patches and the patches in the patchset #3. So should you
merge the eDMA patches via your tree, the later patch in this series
and the patchset #3 would have needed to be applied in there too. So
the patches can't be split up between different branches. Seeing all
the changes (including the DW eDMA part) concern the PCIe device (DW
eDMA is a part of either DW PCIe End-point or Root Port) and we
already agreed to merge all the changes via the PCIe tree, I would
stick to the previous settled agreement.

-Sergey

> 
> -- 
> ~Vinod
