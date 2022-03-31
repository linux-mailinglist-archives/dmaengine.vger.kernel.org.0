Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD7FD4ED354
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 07:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiCaFkB (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 01:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiCaFkA (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 01:40:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4C41BA;
        Wed, 30 Mar 2022 22:38:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51890B81EA0;
        Thu, 31 Mar 2022 05:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F5DC340EE;
        Thu, 31 Mar 2022 05:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648705091;
        bh=7JZQq/va1IKsjwnSXNaMEXzPnn7GhYKlHIDaDrZywec=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ph/RPkIqP/MFV2BuvH9xCqoVv7wYKpi0rtfQrbKtMDgCNph8NOMJC4IT49QJyKjRl
         40Hb7PTQ+17zerYdfqIL8KGUsbslYIHEeYpNdEKvDpSh1LqoWHfC8yqDvNgi1U1gBh
         9dGzF5kA05CBO+TCGs+S03qzxv6WDJ82NxyQDx0uXZZexlnD11WdRkZsLvx13BcAle
         atj6Rqf0iwt6q2QcR/Ckh7GzFhXtkwf7KYGuS3XbZfg8MZ+OxIQ1ElxPewuMYnYnI3
         0KRWM/R6/8yjz8gMaUTRzHiOn4PTPjFQl86h+mzOzni/PmSMLACsesqMMlBGh1wN4B
         VRGRKq0GgzC0w==
Date:   Thu, 31 Mar 2022 11:08:06 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/25] dmaengine: Fix dma_slave_config.dst_addr
 description
Message-ID: <YkU+PupmoR/zkHxn@matsya>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-5-Sergey.Semin@baikalelectronics.ru>
 <20220324140806.GN2854@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324140806.GN2854@thinkpad>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 24-03-22, 19:38, Manivannan Sadhasivam wrote:
> On Thu, Mar 24, 2022 at 04:48:15AM +0300, Serge Semin wrote:
> > Most likely due to a copy-paste mistake the dst_addr member of the
> > dma_slave_config structure has been marked as ignored if the !source!
> > address belong to the memory. That is relevant to the src_addr field of
> > the structure while the dst_addr field as containing a destination device
> > address is supposed to be ignored if the destination is the CPU memory.
> > Let's fix the field description accordingly.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> One suggestion below.
> 
> > ---
> >  include/linux/dmaengine.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > index 842d4f7ca752..f204ea16ac1c 100644
> > --- a/include/linux/dmaengine.h
> > +++ b/include/linux/dmaengine.h
> > @@ -395,7 +395,7 @@ enum dma_slave_buswidth {
> >   * should be read (RX), if the source is memory this argument is
> >   * ignored.
> >   * @dst_addr: this is the physical address where DMA slave data
> > - * should be written (TX), if the source is memory this argument
> > + * should be written (TX), if the destination is memory this argument
> 
> Should we rename "memory" to "local memory" or something similar?

what do you mean by local memory :)

-- 
~Vinod
