Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15B226DE23E
	for <lists+dmaengine@lfdr.de>; Tue, 11 Apr 2023 19:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDKRQp (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 11 Apr 2023 13:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDKRQn (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 11 Apr 2023 13:16:43 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7973D5598;
        Tue, 11 Apr 2023 10:16:20 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id o1so11366825lfc.2;
        Tue, 11 Apr 2023 10:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681233379; x=1683825379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zRtwsRyVIGqbkmiCnDqCsYdQjOk1l7EH31DIMvx2aYo=;
        b=QN4AgX1vG6TwvXQ6XOCqMVOZuOC4Ru5G1vKdR5L6LPPsHkM3tGW+XPrXX09zkc6j2S
         +xPSm2znuJ8gvEhplWMtooiJusbJB8ZpA6EYHagHeNKic56w9GWMbEhPoRNVAHGOEGnL
         k0iQXP0rBybo/qdK0qWNDK44bEFMFG4Bwf9NSpCLrM92JxDag+WDEqXV2JjxKhYa64zW
         fhqxfu4SZFj5CbRY6YGcuuDEDHr+71ucCWLzWEyFdLgRKxLvl3Ez8ttMic61YQcBuV0e
         EEmuH7oVQ2ZZgRaldisW9NB8vZIy42tZruIrYNdtKnGXjo1u31WFxV5gKncgZP8Ne9Bs
         sA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681233379; x=1683825379;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRtwsRyVIGqbkmiCnDqCsYdQjOk1l7EH31DIMvx2aYo=;
        b=jYnD2W4pgmih8T4R+8T7+Mrf3+2fXkwQ+zOKFAwTjleOWHAyttmdW0sBrHJ+Y9twJA
         UjZKtZBFSKQ4SOlWZEMEo8wvFw6ruVdGeR3MwoYRft4VAUuR3Vd+r/oAKr1A+YHWDnIx
         22qE6f6WxQgAzzOfghSen6rWuH7QzqSq45QsPL4O6NOHjUIedAbuWmy9MEwCWfikBLth
         iqdRp6yRPY8KAdD1WYmpxNpQdl4uRFz6OkJ3ssFOz+m8scbacu+7X5aenSaTvaul/MYR
         TxUWFKenN30Nh+hAX28UiAhrykHw/mZYemShAwklBIUhtM+P8spSuzVjkJPO8e5U7MAA
         DHEA==
X-Gm-Message-State: AAQBX9eiTWPMTtLcRkwrwlSPqvzrKGPfrukf2g0KYavfDcfcsHBFwkzA
        For1+fcDdndlIGyA9bY0pIA=
X-Google-Smtp-Source: AKy350aU2RyTu7csMgtptLshnV8XaxjcWlEXI5Nbb6vLFCW/PoKY/nJF++O4isukO/xLPd/Ba3Xn1g==
X-Received: by 2002:a05:6512:244:b0:4e9:c327:dd81 with SMTP id b4-20020a056512024400b004e9c327dd81mr3582478lfo.63.1681233378577;
        Tue, 11 Apr 2023 10:16:18 -0700 (PDT)
Received: from mobilestation ([95.79.140.35])
        by smtp.gmail.com with ESMTPSA id x4-20020a19f604000000b004ebae99cc1dsm2614134lfe.159.2023.04.11.10.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 10:16:17 -0700 (PDT)
Date:   Tue, 11 Apr 2023 20:16:15 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 09/10] MAINTAINERS: Add myself as the DW PCIe
 core reviewer
Message-ID: <20230411171615.gezxhjcndpkrts2b@mobilestation>
References: <20230411033928.30397-1-Sergey.Semin@baikalelectronics.ru>
 <20230411033928.30397-10-Sergey.Semin@baikalelectronics.ru>
 <20230411112416.GK5333@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411112416.GK5333@thinkpad>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 11, 2023 at 04:54:16PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 11, 2023 at 06:39:27AM +0300, Serge Semin wrote:
> > No actions have been spotted from the driver maintainers for almost two
> > years now. It significantly delays the review process of the relatively
> > often incoming updates. Since that IP-core has been used in several our
> > SoCs adding myself to the list of reviewers will help in the evolving the
> > driver faster and in catching any potential problem as early as possible.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> If the Maintainers were not responding for these long years, then it implies
> that they are not maintaining at all. So I'm inclined to remove their entries
> too but I'll defer that decision to Lorenzo.

To be completely honest @Jingoo responded to a few patches with minor
comments lately meanwhile @Gustavo has been completely silent for
about two years now.

> 
> For this patch,
> 
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks.

-Serge(y)

> 
> - Mani
> 
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 489fd4b4c7ae..51adcafa0f0c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16061,6 +16061,7 @@ F:	drivers/pci/controller/dwc/pci-exynos.c
> >  PCI DRIVER FOR SYNOPSYS DESIGNWARE
> >  M:	Jingoo Han <jingoohan1@gmail.com>
> >  M:	Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> > +R:	Serge Semin <fancer.lancer@gmail.com>
> >  L:	linux-pci@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/snps,dw-pcie*.yaml
> > -- 
> > 2.40.0
> > 
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
