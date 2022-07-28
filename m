Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9881F5840E3
	for <lists+dmaengine@lfdr.de>; Thu, 28 Jul 2022 16:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiG1OR4 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 28 Jul 2022 10:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiG1ORz (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 28 Jul 2022 10:17:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E448751A07;
        Thu, 28 Jul 2022 07:17:53 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id s14so2123538ljh.0;
        Thu, 28 Jul 2022 07:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XrrrW4++UP8Z1/g4RPl+VWHxRE3xR4vShEJqGT7s7ks=;
        b=jFPW+/cAzl1wgsBZ+OnwY61OHhJWd86DKN+6Hj9sDgImdFglHPnhs8rGRYKMopLwh2
         PP5m5jW/eyQ0JXNxDROJXZx7bseJaqd3LlrUXK4kJGpdqZO/fkoyYSnMl50GLitzHHGj
         B5v7Xxvi1oliv6t4WEAeXjfTuyl05VDDBsH5rzIZV5N8JREMhgAoPL2tqoz77xNc9eZK
         KDTP7GmuURxC+8nJEnbcPpAAoCqTq8Czcy2280q3ecj0jpzMX4hKqTLvMYsUYM1ucobf
         gt/wk0eEjIAMz0bve1vIIpIeDVso6bhJrYeJjdPWqIfYk7IidBlwbKS/9x7P9DJsh6KY
         FHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XrrrW4++UP8Z1/g4RPl+VWHxRE3xR4vShEJqGT7s7ks=;
        b=eNiuYQEzBLeZDhspLo3ADltqQ/bC1kWVfar/xHdUL31MGh6ZS9hkLhkUYfR0vFswNc
         /dMayzSxkERYZ4j/IOyqy7bdnH4HJh/H1xE9vhAUFnF5b5u4kZtWptfFaYQketRJFRuk
         NJNlZZ+lm2JiSKRUmFvp2MfoDe0+yGSgbvrkj2y0iqT5H9HSYOHuhI+GZ0T9WVd4G8zT
         eZMIH4A31hwiFink4DBzGf4jR+5T9+scCBkSZywcwEd1Vy7xypdxFqmoWaeP8Uh7IaQ/
         T6P6yBnbtImPs1Rno4aIc3HuH1hLMzqzAhWkQRjYdkxvw57jT/Tmu/7OPuCEbYVSRNyy
         ERvA==
X-Gm-Message-State: AJIora+3HyBfh6BYw4RU7jy1bY/19GVSqWAoQjy5PCoBBOyqTZfTrNsV
        GbLxlxai85NKaIQZyYWKB9c=
X-Google-Smtp-Source: AGRyM1vmDbf/D2wQN66Ua5khxvctUPoy/TITsmzPW0Qi+P0RywPFWU/UBLOkF7DR/IYtB5I2dT/ZbQ==
X-Received: by 2002:a2e:6a18:0:b0:25e:2f3f:ba71 with SMTP id f24-20020a2e6a18000000b0025e2f3fba71mr786247ljc.352.1659017871652;
        Thu, 28 Jul 2022 07:17:51 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id e14-20020a2e500e000000b0025df04af0f0sm168583ljb.51.2022.07.28.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 07:17:51 -0700 (PDT)
Date:   Thu, 28 Jul 2022 17:17:48 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220728141748.karft7dflr5e3vlp@mobilestation>
References: <20220610091459.17612-1-Sergey.Semin@baikalelectronics.ru>
 <YtlDivjaXfSEK1Xg@matsya>
 <20220728113359.hs54apv22bo5bnyr@mobilestation>
 <YuKFnjrxnyNa+98X@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuKFnjrxnyNa+98X@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jul 28, 2022 at 06:18:30PM +0530, Vinod Koul wrote:
> On 28-07-22, 14:33, Serge Semin wrote:
> > On Thu, Jul 21, 2022 at 05:46:10PM +0530, Vinod Koul wrote:
> > > On 10-06-22, 12:14, Serge Semin wrote:
> > > > This is a final patchset in the series created in the framework of
> > > > my Baikal-T1 PCIe/eDMA-related work:
> > > > 
> > > > [1: In-progress v4] PCI: dwc: Various fixes and cleanups
> > > > Link: https://lore.kernel.org/linux-pci/20220610082535.12802-1-Sergey.Semin@baikalelectronics.ru/
> > > > [2: In-progress v3] PCI: dwc: Add hw version and dma-ranges support
> > > > Link: https://lore.kernel.org/linux-pci/20220610084444.14549-1-Sergey.Semin@baikalelectronics.ru/
> > > > [3: In-progress v3] PCI: dwc: Add generic resources and Baikal-T1 support
> > > > Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> > > > [4: In-progress v3] dmaengine: dw-edma: Add RP/EP local DMA support
> > > > Link: ---you are looking at it---
> > > > 
> > > > Note it is very recommended to merge the patchsets in the same order as
> > > > they are listed in the set above in order to have them applied smoothly.
> > > > Nothing prevents them from being reviewed synchronously though.
> > > > 
> > > > Please note originally this series was self content, but due to Frank
> > > > being a bit faster in his work submission I had to rebase my patchset onto
> > > > his one. So now this patchset turns to be dependent on the Frank' work:
> > > > 
> > > > Link: https://lore.kernel.org/linux-pci/20220524152159.2370739-1-Frank.Li@nxp.com/
> > > > 
> > > > So please merge Frank' series first before applying this one.
> > > > 
> > > > Here is a short summary regarding this patchset. The series starts with
> > > > fixes patches. We discovered that the dw-edma-pcie.c driver incorrectly
> > > > initializes the LL/DT base addresses for the platforms with not matching
> > > > CPU and PCIe memory spaces. It is fixed by using the pci_bus_address()
> > > > method to get a correct base address. After that you can find a series of
> > > > the interleaved xfers fixes. It turned out the interleaved transfers
> > > > implementation didn't work quite correctly from the very beginning for
> > > > instance missing src/dst addresses initialization, etc. In the framework
> > > > of the next two patches we suggest to add a new platform-specific
> > > > callback - pci_address() and use it to convert the CPU address to the PCIe
> > > > space address. It is at least required for the DW eDMA remote End-point
> > > > setup on the platforms with not-matching CPU/PCIe address spaces. In case
> > > > of the DW eDMA local RP/EP setup the conversion will be done automatically
> > > > by the outbound iATU (if no DMA-bypass flag is specified for the
> > > > corresponding iATU window). Then we introduce a set of the patches to make
> > > > the DebugFS part of the code supporting the multi-eDMA controllers
> > > > platforms. It starts with several cleanup patches and is closed joining
> > > > the Read/Write channels into a single DMA-device as they originally should
> > > > have been. After that you can find the patches with adding the non-atomic
> > > > io-64 methods usage, dropping DT-region descriptors allocation, replacing
> > > > chip IDs with the device name. In addition to that in order to have the
> > > > eDMA embedded into the DW PCIe RP/EP supported we need to bypass the
> > > > dma-ranges-based memory ranges mapping since in case of the root port DT
> > > > node it's applicable for the peripheral PCIe devices only. Finally at the
> > > > series closure we introduce a generic DW eDMA controller support being
> > > > available in the DW PCIe Root Port/Endpoint driver.
> > > 
> > 
> > > Acked-By: Vinod Koul <vkoul@kernel.org>
> > 
> > Thanks, Vinod! The series will be merged in after the patchset
> > [PATCH vX 00/17] PCI: dwc: Add generic resources and Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220610085706.15741-1-Sergey.Semin@baikalelectronics.ru/
> > is done with Rob' review (I failed to reach him with a few issues
> > lately). I'll add your ab-tag to this one on the next patchset re-spin
> > (rebase will be likely needed).
> 

> You can cc Krzysztof (cced him0, maybe he can help with review of DT
> parts

Thanks for the suggestion. I'll Cc him in the next series re-spin.

-Sergey

> 
> thanks
> -- 
> ~Vinod
