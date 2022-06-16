Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C819554E2D9
	for <lists+dmaengine@lfdr.de>; Thu, 16 Jun 2022 16:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbiFPODb (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Jun 2022 10:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377527AbiFPODX (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Jun 2022 10:03:23 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2D730568;
        Thu, 16 Jun 2022 07:03:20 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id i29so2395075lfp.3;
        Thu, 16 Jun 2022 07:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s7byWTFLJaOufliWWPTPN2R/9TQgD/ZCAl1+0sxwhMc=;
        b=F1FoLfdSmTooeEEx0ZM0uLj1x+4hWTNdec5fbMO69xSjL+M8+HFi9bAWyGvCxZpAdy
         GWDpcT242q6wdjfPeB0RBeEHUpb595BdztuYmMpkZhcKPGv/Rfk8ddLhi+3P96qJd0Ps
         4YzLyfZAdycWaNmt6k61ktUoM500rbg5aldyUSHONNwRfiYhVSAVOcE3LHP8qlz65Z3Z
         P5RljJIaQkm8hxxL47zrZhA7E6f4yYcs2igWnaKxQhaxIfovY7jHAIYTy9io9latlLJT
         ocFwM7p6eiMKBwBBJ5fbvsBeeorGVv+eCxmkOGZNqgixKegqGm3U70GCo9YMusw4SxZ3
         MFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s7byWTFLJaOufliWWPTPN2R/9TQgD/ZCAl1+0sxwhMc=;
        b=XtfHxa+ieN6jw2BaYL35SH8ygBsLwrtzje1Y4RGAd0oW2pg4fNCA4l2ONtI18vtuIS
         ++qJZCBsPYIRuH0AG0uB1HRkux46MjPSFSa6i03uvE1CogTZEZvIJJhe0TpxNrA6sbaL
         mMnRpz/DOaH7gVKzidE341PwTdqyutHS0K2FcfC2J9q0obVz7RTKQjLqia2PY5N87OwO
         xhf9Y65wytwGZg/LRARAd6k1kc4EkfFuzJVE0lbi3JO3/H8SxfCYhMI9ZQj7gGyDoBuf
         Fs/maddf7UNJBxWIymsfijy57MKaiWVCUVuI+Nd2UqBANCBLgXvcFLNlJj2Gx7hUDwYX
         HJ1g==
X-Gm-Message-State: AJIora/TZCufqEecRXh8kk2lqG5yntZbkRPa7YT8WbLlUmHxCLi4R3Eg
        6Agt/CL0bCDsST8+IWUtI5Y=
X-Google-Smtp-Source: AGRyM1tZwc2lRlF4rwmqZz//7Jm5gWl2JmNSTsKI1nLse+SC4hyZC/rVbyjRD58dCzR4fUspETuW7Q==
X-Received: by 2002:a05:6512:c18:b0:479:36c1:207a with SMTP id z24-20020a0565120c1800b0047936c1207amr2857686lfu.260.1655388197761;
        Thu, 16 Jun 2022 07:03:17 -0700 (PDT)
Received: from mobilestation ([95.79.189.214])
        by smtp.gmail.com with ESMTPSA id 25-20020ac24d59000000b004794a78bfe7sm253560lfp.6.2022.06.16.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:03:17 -0700 (PDT)
Date:   Thu, 16 Jun 2022 17:03:14 +0300
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
Message-ID: <20220616140314.nyr4owq2m2z4xtcm@mobilestation>
References: <20220524152159.2370739-1-Frank.Li@nxp.com>
 <Yqs1e4RMpc6ynVDN@matsya>
 <20220616135413.a4jmljwgzgpkp2uc@mobilestation>
 <20220616140157.dghcapsf7i7ccyo2@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616140157.dghcapsf7i7ccyo2@mobilestation>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Jun 16, 2022 at 05:02:00PM +0300, Serge Semin wrote:
> On Thu, Jun 16, 2022 at 04:54:13PM +0300, Serge Semin wrote:
> > On Thu, Jun 16, 2022 at 06:51:55AM -0700, Vinod Koul wrote:
> > > On 24-05-22, 10:21, Frank Li wrote:
> > > > Default Designware EDMA just probe remotely at host side.
> > > > This patch allow EDMA driver can probe at EP side.
> > > > 
> > > > 1. Clean up patch
> > > >    dmaengine: dw-edma: Detach the private data and chip info structures
> > > >    dmaengine: dw-edma: Remove unused field irq in struct dw_edma_chip
> > > >    dmaengine: dw-edma: Change rg_region to reg_base in struct
> > > >    dmaengine: dw-edma: rename wr(rd)_ch_cnt to ll_wr(rd)_cnt in struct
> > > > 
> > > > 2. Enhance EDMA driver to allow prode eDMA at EP side
> > > >    dmaengine: dw-edma: Add support for chip specific flags
> > > >    dmaengine: dw-edma: Add DW_EDMA_CHIP_32BIT_DBI for chip specific
> > > > flags (this patch removed at v11 because dma tree already have fixed
> > > > patch)
> > > > 
> > > > 3. Bugs fix at EDMA driver when probe eDMA at EP side
> > > >    dmaengine: dw-edma: Fix programming the source & dest addresses for
> > > > ep
> > > >    dmaengine: dw-edma: Don't rely on the deprecated "direction" member
> > > > 
> > > > 4. change pci-epf-test to use EDMA driver to transfer data.
> > > >    PCI: endpoint: Add embedded DMA controller test
> > > > 
> > > > 5. Using imx8dxl to do test, but some EP functions still have not
> > > > upstream yet. So below patch show how probe eDMA driver at EP
> > > > controller driver.
> > > > https://lore.kernel.org/linux-pci/20220309120149.GB134091@thinkpad/T/#m979eb506c73ab3cfca2e7a43635ecdaec18d8097
> > > 
> > 
> > > Applied to dmaengine-next, thanks
> > 
> 
> > Vinod, this was supposed to be merged in through PCIe repo.( I asked
> > many times of that. Bjorn also agreed to merge it in. Could drop it
> > from yout repo?
> 

> I asked it several time including in the framework of this thread:
> https://lore.kernel.org/dmaengine/20220525092306.wuansog6fe2ika3b@mobilestation/
> There are dependencies of my patchsets from this one. Please consider
> dropping it from your dmaengine-next repo while it's still possible
> since taking DW eDMA and PCie patches through the PCie repo would be
> more natural.

The only thing we were waiting for was you ack tag...

-Sergey

> 
> -Sergey
> 
> > 
> > -Sergey
> > 
> > > 
> > > -- 
> > > ~Vinod
