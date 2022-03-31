Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E894ED4AA
	for <lists+dmaengine@lfdr.de>; Thu, 31 Mar 2022 09:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbiCaHR0 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 31 Mar 2022 03:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiCaHRK (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 31 Mar 2022 03:17:10 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A796A06C;
        Thu, 31 Mar 2022 00:13:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bu29so39940136lfb.0;
        Thu, 31 Mar 2022 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bu41Rz10DBgZx7YMhpBXa2DPWaILQcc2cwXyhQeaZPI=;
        b=dm9ovATINTFEQuu8muUZYcluLEhGeGxlop3UrgvkqiDsJMLIcHyHQRtW+CpFJ+EZmC
         3Vox+RKR1gkSszrRmiO6vMsGIjoqavvdVVDgWq38q1FbzjtkQTMowpYlc2b/n7hSpRoY
         HklvRpKHkNuP/RObcDECUcxN6aFMcnFrZ7PN2/cZmC/lswS2htyI1nfRwHyQ9x6jmcQd
         AN5Ten3nY+7hJ8M79BBXniDJmFYLwexg9h8xxBSvpDlXFPU01hMewr9MJU2Qcg88b1tV
         VyVvphw3CnY9IVkWtQ8xE71ul5lMSuV1Roe4kHYXubhCM+rPUH9hxxSsp/tdkbXPFcET
         4quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bu41Rz10DBgZx7YMhpBXa2DPWaILQcc2cwXyhQeaZPI=;
        b=3BFPlfRndM392HIHarLmyx4UvpswnqtE4wtiT7SDfgVEoSIQPqvmKspnAl8z0gd7zB
         CX2188pd3kD8d2cw/FvlxoVCSucn5k3qb9TCbIk6E2WJEDiiij/lR9EXbPfN8E4eCYOc
         i31eSUrpLS0uP0YTn97H+FA3lq4HCjaJWDjQe+5nX74MwF6f4dAy+w4gjiEBkMywBC79
         PE0ozErtUZ+ViIEZnuLJoC+T6pXU0IpB48g34eyA/j8F3K7EXC5+30gNBD5m3UhNOwQP
         GoJE4oV8x+iORFdpkkmcrsIbHYfseu+skgbhv6hG8Crfw+WqdssZYC3kV0x9O/6lBdvs
         R4sg==
X-Gm-Message-State: AOAM530vZlJMBn/8vb7NHKSIVuuxbwcenjxNb41wEiTaSzSyBaIyjinS
        RciIH5UyZUBSO9duyL/ro/o=
X-Google-Smtp-Source: ABdhPJyqJ4tu5mxNEuPt/j9KI45P3PT/pT1Ws74on+AAfjcf4OxagYaehoYG4WaBWExwJW0hNoTGRQ==
X-Received: by 2002:a05:6512:ba8:b0:44a:3444:4698 with SMTP id b40-20020a0565120ba800b0044a34444698mr9805437lfv.203.1648710825704;
        Thu, 31 Mar 2022 00:13:45 -0700 (PDT)
Received: from mobilestation ([95.79.227.109])
        by smtp.gmail.com with ESMTPSA id k18-20020a192d12000000b0044a5ddcf5fcsm2533191lfj.226.2022.03.31.00.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 00:13:45 -0700 (PDT)
Date:   Thu, 31 Mar 2022 10:13:43 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Frank Li <Frank.Li@nxp.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/25] dmaengine: Fix dma_slave_config.dst_addr
 description
Message-ID: <20220331071343.eitijsfuzufh6blc@mobilestation>
References: <20220324014836.19149-1-Sergey.Semin@baikalelectronics.ru>
 <20220324014836.19149-5-Sergey.Semin@baikalelectronics.ru>
 <20220324140806.GN2854@thinkpad>
 <YkU+PupmoR/zkHxn@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkU+PupmoR/zkHxn@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Mar 31, 2022 at 11:08:06AM +0530, Vinod Koul wrote:
> On 24-03-22, 19:38, Manivannan Sadhasivam wrote:
> > On Thu, Mar 24, 2022 at 04:48:15AM +0300, Serge Semin wrote:
> > > Most likely due to a copy-paste mistake the dst_addr member of the
> > > dma_slave_config structure has been marked as ignored if the !source!
> > > address belong to the memory. That is relevant to the src_addr field of
> > > the structure while the dst_addr field as containing a destination device
> > > address is supposed to be ignored if the destination is the CPU memory.
> > > Let's fix the field description accordingly.
> > > 
> > > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > One suggestion below.
> > 
> > > ---
> > >  include/linux/dmaengine.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> > > index 842d4f7ca752..f204ea16ac1c 100644
> > > --- a/include/linux/dmaengine.h
> > > +++ b/include/linux/dmaengine.h
> > > @@ -395,7 +395,7 @@ enum dma_slave_buswidth {
> > >   * should be read (RX), if the source is memory this argument is
> > >   * ignored.
> > >   * @dst_addr: this is the physical address where DMA slave data
> > > - * should be written (TX), if the source is memory this argument
> > > + * should be written (TX), if the destination is memory this argument
> >
 
> > Should we rename "memory" to "local memory" or something similar?
> 
> what do you mean by local memory :)

Most likely Manivannan just confused the whole eDMA device specifics
with this patch purpose. This commit has nothing to do with "local"
and "remote" device memory. Such definitions are relevant to the DW
eDMA setups (whether device is integrated into the PCIe Host/End-point
controller then the CPU memory is a local memory for it, or it's a
remote PCI End-point, then the CPU memory is a remote memory for it).

Guys. Regarding the patchsets review procedure. I notice all the
comments. Just didn't have time to respond so far. Will do that till
the end of the week.

-Sergey

> 
> -- 
> ~Vinod
