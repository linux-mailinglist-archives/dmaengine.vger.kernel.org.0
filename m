Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5974554E2D4
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:02:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377356AbiFPOCD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377371AbiFPOCC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:02:02 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF7D49CB9;
        Thu, 16 Jun 2022 07:02:01 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id c2so2416099lfk.0;
        Thu, 16 Jun 2022 07:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RpXBllkKBSmc4WrWUXnDWZNWWq87PEoM7MRmdoGil+c=;
        b=O99vMMGtYyzYLB082b8mVNU1rkrBrNJLbTDP3LDoesqgejS37V9hRG5I3zr9j7U7A/
         tVDtYuWOPqznukZlFpNLymdFzt6QiFHpex/wK0IjV75AlCuDa3TNvis604go4EzTCD6n
         EjWdBxJ2T4xlMHL+qcIdDfEisy4NOAsvmOkj0afhBoaNe+szoyD8qG6VcCpZq/UNvYXK
         7D43VBpeCH7P9e6yfzCi2eyk1bMPCCflKPIaNrXLdYhZbgZbr8QjeiC7VRq1WTHwhmvf
         nwrc/vN7Yky1KvSVUKsoNnMTBysbyxIuOxtF/PakEEK+TRH2t5HZ8djfQPU78JJ01gEZ
         8fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpXBllkKBSmc4WrWUXnDWZNWWq87PEoM7MRmdoGil+c=;
        b=1UayB6pu0bzEe9/exrlsPNhNZQSYhxBt1xSK/j4KiBu38fvFdZAjOPKVi9vNF7CqEL
         RVJKw0ePZgeHWDovZDKyXQ6XtTQwegDSARy03BK3EyD1baKsn4VmHJsx4kcUhg4XOITi
         vosDHrTONEF/J/7dwyuC/7kmccYYWbvYg/jASotH5kPtTZmKF9Fd6BYnq2127DinXejg
         g9hJ75UbLsGhwRW+5gFi7iI6+Zvm5RU3ylWRDiE3WM+W+dZAQmGbnX+xuTwtsqfqy04P
         PAx6Zm/eGYb539k8vRbmoe/G4pRLJxKmIghV4rIJ2FnwFp//Jasa8Hzo7rk0Hq16GS1Z
         xh9Q==
X-Gm-Message-State: AJIora/DMeWSY2oyII+qqppIZuV0yMUVevfIh5fVe2T9DLXbtpnKZFle
        hLtZhUaZgbSByDtayu4VjeI=
X-Google-Smtp-Source: AGRyM1svX9VKJ+BulwwcsSb4uivq+cWsz6TLKo4LWeVZOR0+nvL3fwCF4RrxhbZLTrLvcbpkE6tEEg==
X-Received: by 2002:a19:5015:0:b0:479:916:ee18 with SMTP id e21-20020a195015000000b004790916ee18mr2658391lfb.466.1655388119842;
        Thu, 16 Jun 2022 07:01:59 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id u13-20020a2ea16d000000b002557b83c563sm259085ljl.1.2022.06.16.07.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:01:59 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:01:57 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, l.stach@pengutronix.de, linux-imx@nxp.com,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        lznuaa@gmail.com, helgaas@kernel.org, kishon@ti.com,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, manivannan.sadhasivam@linaro.org,
        Sergey.Semin@baikalelectronics.ru
Subject: Re: [PATCH v12 0/8] Enable designware PCI EP EDMA locally
Message-ID: <20220616140157.dghcapsf7i7ccyo2@mobilestation>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
 <Yqs1e4RMpc6ynVDN@matsya>
 <20220616135413.a4jmljwgzgpkp2uc@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616135413.a4jmljwgzgpkp2uc@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 16, 2022 at 04:54:13PM +0300, Serge Semin wrote:
> On Thu, Jun 16, 2022 at 06:51:55AM -0700, Vinod Koul wrote:
> > On 24-05-22, 10:21, Frank Li wrote:
> > > Default Designware EDMA just probe remotely at host side.
> > > This patch allow EDMA driver can probe at EP side.
> > > 
> > > 1. Clean up patch
> > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > 
> > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > >    dmaengine: dw-edma: Add support for chip specific flags
> > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > flags (this patch removed at v11 because dma tree already have fixed
> > > patch)
> > > 
> > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > ep
> > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > > 
> > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > >    PCI: endpoint: Add embedded DMA controller test
> > > 
> > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > upstream yet. So below patch show how probe eDMA driver at EP
> > > controller driver.
> > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > 
> 
> > Applied to dmaengine-next, thanks
> 

> Vinod, this was supposed to be merged in through PCIe repo.( I asked
> many times of that. Bjorn also agreed to merge it in. Could drop it
> from yout repo?

I asked it several time including in the framework of this thread:
https://lore.kernel.org/dmaengine/20220525092306.wuansog6fe2ika3b@mobilestation/
There are dependencies of my patchsets from this one. Please consider
dropping it from your dmaengine-next repo while it's still possible
since taking DW eDMA and PCie patches through the PCie repo would be
more natural.

-Sergey

> 
> -Sergey
> 
> > 
> > -- 
> > ~Vinod
