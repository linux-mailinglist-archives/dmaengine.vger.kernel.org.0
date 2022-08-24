Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3755A00F5
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240515AbiHXSB7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 14:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240540AbiHXSBa (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 14:01:30 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116EE3335A;
        Wed, 24 Aug 2022 11:00:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id s6so13821204lfo.11;
        Wed, 24 Aug 2022 11:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=N0TsJICXLt6lhZJlGwrS6fgHuWKVkASuAnCszKy9/5I=;
        b=HPLcovaeo0KkN8cXAJTQK01A70U6hwfn+p4aW9u0supgtOC2rSDnQz472K0BG3RKhF
         kDV+3PquM44PFWQN+7pRbAt1dFj+787Ll/rflFFfSevyDMNf4P/EhsTd3whQsmIW3T7F
         /ag3wJhtYzYFYLdT4XFIsSYidSVrSfH8RTJIcMtBghd6Jf9cv+WH9dVCtPC1bG0KY4Uo
         GQu1ZrFh6OmNkRHX1gAKMiIXmqwXRwra4HQguCoVjwaj6ijsTOQFbopBFsHDTwYXua0C
         r3L3l2iHDzgbqKqQphVD2+aFpJ0JGty8U4e6gZxpVmXAeK8uehFM6Sog69b51ayxqgaq
         NQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=N0TsJICXLt6lhZJlGwrS6fgHuWKVkASuAnCszKy9/5I=;
        b=7A8muozoMgxrKbml81cZ0pL05lQo3YU5d1mWv6sq87XUQ5ZGIgIvATa5uJOZiNdo0u
         g5i8UtJ9CnV5ST5yrBVtNKxcwT96XUQKFeuyyTTv0TfssVvlkWbKxDr/ve2QiAsSY/Ea
         LFMaadVh8bbYsNF5Kb1TCOqf17bFX/Y0jRVBgAdebFqTkWuuhSVM+vHUQzqq30qI1INW
         5p8ATo8brStQbwRBDQVeKwSuE2QiFTrTWL001fXoPumgBRqeQqs8ooZgij2eJq6BuUEe
         kU3TSFFEOkHciDZQhZfIGhhyQapkYlOa4aeyp7Mq6oC+lOBH9Ee25L67qlKm+2xLkvAy
         Yf/A==
X-Gm-Message-State: ACgBeo1CoBIztpvsdxwTmUC+mPNnGzNX5J3eMdiTzzeGnfRicqvsU9lG
        CR9nNxoiQCsXtl4RiBqoZr8=
X-Google-Smtp-Source: AA6agR5iL4qkSLU4Ha6eLHlP1Mc7KxLj8xjA493tylrAViR+UDJHK2LK7IAxbvvD9OKfLzt2vwxmNg==
X-Received: by 2002:a05:6512:c07:b0:493:ae4:aa52 with SMTP id z7-20020a0565120c0700b004930ae4aa52mr39092lfu.550.1661364019572;
        Wed, 24 Aug 2022 11:00:19 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id z17-20020a05651c11d100b0025e0396786dsm19432ljo.93.2022.08.24.11.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 11:00:18 -0700 (PDT)
Date:   Wed, 24 Aug 2022 21:00:16 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 00/24] dmaengine: dw-edma: Add RP/EP local DMA
 controllers support
Message-ID: <20220824180016.ckkf7jugycyai345@mobilestation>
References: <20220822185332.26149-1-Sergey.Semin@baikalelectronics.ru>
 <20220824163916.GA2784109@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824163916.GA2784109@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 24, 2022 at 11:39:16AM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 22, 2022 at 09:53:08PM +0300, Serge Semin wrote:
> > This is a final patchset in the series created in the framework of
> > my Baikal-T1 PCIe/eDMA-related work:
> > 
> > [1: Done v5] PCI: dwc: Various fixes and cleanups
> > Link: https://lore.kernel.org/linux-pci/20220624143428.8334-1-Sergey.Semin@baikalelectronics.ru/
> > Merged: kernel 6.0-rc1
> > [2: Done v4] PCI: dwc: Add hw version and dma-ranges support
> > Link: https://lore.kernel.org/linux-pci/20220624143947.8991-1-Sergey.Semin@baikalelectronics.ru
> > Merged: kernel 6.0-rc1
> > [3: In-review v5] PCI: dwc: Add generic resources and Baikal-T1 support
> > Link: https://lore.kernel.org/linux-pci/20220822184701.25246-1-Sergey.Semin@baikalelectronics.ru/
> > [4: Done v5] dmaengine: dw-edma: Add RP/EP local DMA support
> > Link: ---you are looking at it---
> > ...
> 
> > Please note originally this series was self content, but due to Frank
> > being a bit faster in his work submission I had to rebase my patchset onto
> > his one. So now this patchset turns to be dependent on the Frank' work:
> > 
> > Link: https://lore.kernel.org/linux-pci/20220524152159.2370739-1-Frank.Li@nxp.com/
> 

> I think this paragraph is obsolete, since the "Enable designware PCI
> EP EDMA locally" series you reference is already upstream:
> https://git.kernel.org/linus/94d13317bef3

Right.

> 
> What remains are items 3 and 4.
> 

Right.

> 3 is mostly drivers/pci/ and DT bindings (Lorenzo).  4 is mostly
> drivers/dma/dw-edma/ stuff (Gustavo).  I guess Lorenzo and Gustavo can
> figure out where it makes the most sense to merge it.

As I already said to you two months ago:
Link: https://lore.kernel.org/linux-pci/20220617104143.yj2mlnj4twoxoeld@mobilestation/
Neither Gustavo Pimentel nor Jingoo Han have given any sign of
activity during all the time the patches being on review, discussed,
resubmitted while both of them are the DW PCIe and eDMA drivers
maintainers. Moreover none of them have been active in kernel for more
than a year:
Last Gustavo' tag could be tracked at Apr' 2021.
Last Han' tag could be found at Nov' 2020 commit.
So it's very much unluckily they'll just get back any time soon. We
can't wait for their opinion especially seeing that my patches have
been on review for almost half a year.

So as we already agreed with you the best solution would be to merge
this and the patchset #3 via your repo (or Lorenzo' repo if he is back
from his long-term absence). Vinod already acked the DMA-patches of
this series:
Link: https://lore.kernel.org/linux-pci/YtlDivjaXfSEK1Xg@matsya/

So the only thing left to settle is the DT-related part of the
patchset #3. Which I hope will be done before the next kernel merge
window. After it's done I'll ping you and Lorenzo. Ok?

-Sergey

> 
> Bjorn
