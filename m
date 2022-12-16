Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5266264EFF3
	for <lists+dmaengine@lfdr.de>; Fri, 16 Dec 2022 18:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiLPRCe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 16 Dec 2022 12:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiLPRC2 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 16 Dec 2022 12:02:28 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6848D69AB3;
        Fri, 16 Dec 2022 09:02:27 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so4401886lfv.2;
        Fri, 16 Dec 2022 09:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YvIfsISoMi61fZIHo8kJ4vyzTDQDCae9rjQPs2pxnSo=;
        b=V0jRl/QcELRmFTTg86syErEuttrQ6ycEZqcexQUv12q32Y19nQWELh+WzFHaPaAIEU
         aqPVBNvIklnYA5FQU0BhVPCaa53X4QwxH2Y2nVEdtZwuN4Ix25fT+3UtED2S14dHUmmG
         z4YvmXu67bl7JkK+XgrikH/lD1rEzXi+loun6dK0ZvE9FCgXsXu3Pb+wJFeGTGUekZB/
         +33IY6zg5lbtaOFNn8BK2SWKa8NGqprJXlPnj0n98EH2PYsRGxiH0qoxZgIO3/BSrWww
         eC1fEJ9hCJ9RhlkwFmaonVb9v0J9vAhcfrthcKyQXIz2t4hr4ZnozqkSK0ZGRUCgbb+U
         58XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvIfsISoMi61fZIHo8kJ4vyzTDQDCae9rjQPs2pxnSo=;
        b=ZRxGIZ5SLZ6F7hkoddEduTUqVHMA2EBoMax7F9XQtAotaexsW+ofxZppEi26uLKc5Q
         6V3yT6xVwTWLJun75/nOFZ/eDJX7F6TLCN1qL3D9BOXTY7NFUzXahvOufnjiEUu6ffuY
         Yj8NW9XOr9Wy5KzLISCkA4mTEiFWrXTRgRc4nxLtg0pEcJEQ6ODuP/1Ft0QAWsI9Spm3
         6MIE/SaH2pMTrGH5p6wPodzVaNxkbyVli6wnCJNkQocHPXLTkLTVbJslpDcGxTUur86c
         wHgVAuP4vZDBtQzZ3F5xZmd8WneR9Z4ROhkFKiVLLUDrAyM+YWUHgpsDSIfid4CcEaUh
         CfmA==
X-Gm-Message-State: ANoB5pkeTq3nq4AkW+KLKE9l1Iz3gFzksyH8AjbHg+7daERZyOtd9pgn
        tcMrTaUZbeEEtRJh84Lq+4c=
X-Google-Smtp-Source: AA0mqf6SobV6R2EEDo2I2nbAzIa37w0+8FgbaQiSSK9pfgqgJk4H05rlJZtTb0zl6xUr0jD+4tSdyg==
X-Received: by 2002:a05:6512:3e20:b0:4b6:e64c:aec1 with SMTP id i32-20020a0565123e2000b004b6e64caec1mr8671896lfv.53.1671210145688;
        Fri, 16 Dec 2022 09:02:25 -0800 (PST)
Received: from mobilestation ([95.79.133.202])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651234cc00b00498f23c249dsm262057lfr.74.2022.12.16.09.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 09:02:25 -0800 (PST)
Date:   Fri, 16 Dec 2022 20:02:22 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20221216170222.5vv6bdfrejesbvs5@mobilestation>
References: <20221214235305.31744-24-Sergey.Semin@baikalelectronics.ru>
 <Y5rJJfZeVqliA5Rg@infradead.org>
 <20221215092721.tvz3hpaql3kotgnu@mobilestation>
 <07ec7610-f1be-9b5c-416d-17781a22427d@arm.com>
 <20221215235218.wsuwy5uckqfxjnb6@mobilestation>
 <Y5wgvdnMWQDxkUd+@infradead.org>
 <20221216093423.4bettdxisserdzsh@mobilestation>
 <Y5w/MkA4N857+AWQ@infradead.org>
 <20221216101827.owq7qpakjduf3rit@mobilestation>
 <22bae859-58ee-80cd-f31b-2313c2e47531@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22bae859-58ee-80cd-f31b-2313c2e47531@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 16, 2022 at 02:01:20PM +0000, Robin Murphy wrote:
> On 2022-12-16 10:18, Serge Semin wrote:
> > On Fri, Dec 16, 2022 at 01:49:38AM -0800, Christoph Hellwig wrote:
> > > On Fri, Dec 16, 2022 at 12:34:23PM +0300, Serge Semin wrote:
> > > > What about instead of save/restore pattern I'll just change the
> > > > dma_set_mask_and_coherent() method with the dma_set_coherent_mask()
> > > > function call? It seems cleaner. Like this:
> > > 
> > > > Thus the platform-specific streaming DMA mask would be preserved.
> > > > Since it's PCIe then having the streaming DMA-mask less than 32-bits
> > > > wide is very much improbable. Moreover DW PCIe AXI-interface can be
> > > > synthesize only with one out of two address bus widths: 32 and 64.
> > > 
> > 
> > > Where platform-specific means the dwc subdriver?
> > 
> > Right. I meant the streaming DMA-mask set by the low-level DWC PCIe drivers
> > (like pcie-qcom(-ep)?.c, pcie-bt1.c, etc). It's very much important to
> > have the real DMA-mask (at least the streaming one) set for the eDMA-capable
> > controllers so the DMA-engine clients would work with the best performance.
> > 
> > > Yes, that seems to work.
> > 
> > Ok. I'll just use the direct dma_set_coherent_mask() method here then.
> > 
> > > Alternatively have a flag that says which streaming mask
> > > to set.
> > 
> > I'd prefer to have more flexibility here relying on the low-level
> > drivers to set the mask(s) instead of adding the new flag, just in case
> > if there is vendor-specific IP-core/platform changes in the address
> > bus width.
> 

> Presumably the low-level glue drivers could pass a bus size or mask value in
> struct dw_pcie_rp/dw_pcie, so the actual dma_set_mask() call itself could be
> centralised? I guess there's also an argument that only glue drivers which
> care about eDMA need to care about setting a mask at all, so I don't have a
> string preference either way.

There is another peculiarity here due to which the centralized
approach turns to be less suitable. The dw_pcie_msi_host_init()
method, which currently updates the mask, isn't always executed. It's
run only if pci_msi_enabled() returns true and there is no
platform-specific dw_pci_rp.msi_host_init callback specified. Thus if
we got to implement the centralized DMA-mask setting up procedure then
it should have been done in the always executed place. That code would
have also implied the 32-bit coherent DMA-mask if the generic iMSI-RX
config is required. Thus the iMSI-RX-specific setups (data allocation
and the mask settings) would have been split up into different places
which would be less maintainable.

Moreover as you correctly noted the real DMA-mask setting up is only
needed for the eDMA-capable controllers. Meanwhile in the most of the
cases there is no eDMA embedded in the PCIe controller, but due to the
centralized approach we would need to set some mask anyway. Since I
don't know the real address bus width of all the already available DW
PCIe platforms  we'll have to fallback to using some default mask
value, which might incorrectly describe the actual device capability
(and possible cause some side-effects/regressions).

To sum up weighing up pros and cons the centralized approach seems to
me more complex, less maintainable and less flexible. In my opinion
relying on the glue-drivers to set the mask if it's needed to be set
(that is there is the embedded eDMA) is the best and the simplest
choice.

> If you'd rather stick with that approach then
> it might be worth a brief comment at each site to clarify why the other mask
> is being set from an entirely different place, just in case anyone comes
> along and tries to "fix" it.

Exactly what I was going to do. I'll add a brief comment why the
coherent DMA-mask is updated in the dw_pcie_msi_host_init() method.

-Serge(y)
> 
> Cheers,
> Robin.
