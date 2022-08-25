Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DE665A085F
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 07:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiHYFQW (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 01:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiHYFQV (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 01:16:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C3E9E699;
        Wed, 24 Aug 2022 22:16:19 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id w22so3378143ljg.7;
        Wed, 24 Aug 2022 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=73A3PA1tNcUNvJjHON3380nOXGx0PNBXSH7q3EuDDnc=;
        b=MSOUpNVA4XHFH69NPXNfDD+PzQipjFZJrr6m+fuMun0+uboEjchC3kOVMlWTsy+Nil
         99XY2GTd+zwb27lqrzHWlzYlmHTXNzk21iUcvhPVqnwPCViwBwrV3a6jUC1GJlmYeluo
         8LFr4j/Npd1AoQ6uzX5NbyMnq5bVkotv/FW4+2Q2SV0WbS7H7f3PfvYvz2ZKW2jqwWZ6
         wNz+KFldLjcTQzrkQZN785gLo32i9kdf6RLCPxlQh/2XNBLB7JHwEnRRwaNjctvBNLFE
         cprJEue28HKS9YftmFVyU63/LukdVWVoi1O/bKwdh2C5GCxruiN20iB1X7FXknXryKco
         tAhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=73A3PA1tNcUNvJjHON3380nOXGx0PNBXSH7q3EuDDnc=;
        b=ou28Sgf3O9CMrWL9TO54TS0Pr4jbc5bakVafEok+LCO+TzyLmrWlHpVBfu4ULesE4E
         nLkUYfx8/2CKhqh8JqVWGC0BWqsZM3hP5IlLmv9ZvUw+GQ1N9JFzTUswbP9AknVNHSpS
         7TuAFsSgm+g6IUSSKe0yImYrbbPmgAL+fAw+kHP9wy0AkT5ibKYIqNThKna8C8+KldHP
         KfYDMQScFyyLh5Tb8RhVDsinW/KmIUHNEAmgnkWAg1W8SsAhV81d8ph4kQL0f/IcAKMw
         EtuSouuacSd7RpA4oo0DcDc531C5sZB0whkHXmSP7+GU54HzLVzUsB1G53kolzGUOtQ2
         4GDw==
X-Gm-Message-State: ACgBeo3qwA1w+T8qqcqwtQSvz7sVHD8NsMxYeP4S6Q/fnyqcQfkBY9Cl
        tFU96YwncP5trrsr7s7zeMw=
X-Google-Smtp-Source: AA6agR4WRI0UJiBuMep34NFqjfH/hvCWrJ7Fr7Y1Rn+iMfWxh60aGcJMk8I9GiGN2sPUGumxU5TD/w==
X-Received: by 2002:a2e:a587:0:b0:25f:e6ac:c287 with SMTP id m7-20020a2ea587000000b0025fe6acc287mr548687ljp.416.1661404577724;
        Wed, 24 Aug 2022 22:16:17 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id s9-20020ac24649000000b0048b03d1ca4asm292529lfo.161.2022.08.24.22.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 22:16:17 -0700 (PDT)
Date:   Thu, 25 Aug 2022 08:16:14 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        linux-pci@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 24/24] PCI: dwc: Add DW eDMA engine support
Message-ID: <20220825051614.kfify5fbqlhurvdn@mobilestation>
References: <20220824181319.wkj4256a5jp2xjlp@mobilestation>
 <20220824181754.GA2794837@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824181754.GA2794837@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 24, 2022 at 01:17:54PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 24, 2022 at 09:13:19PM +0300, Serge Semin wrote:
> > On Wed, Aug 24, 2022 at 11:51:18AM -0500, Bjorn Helgaas wrote:
> > > On Mon, Aug 22, 2022 at 09:53:32PM +0300, Serge Semin wrote:
> 
> > > > +	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > > +	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > > > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > > +
> > > > +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > > +	} else if (val != 0xFFFFFFFF) {
> > > 
> > 
> > > Consider PCI_POSSIBLE_ERROR() as an annotation about the meaning of
> > > 0xFFFFFFFF and something to grep for.
> > 
> > In this case FFs don't mean an error but a special value, which
> > indicates that the eDMA is mapped via the unrolled CSRs space. The
> > similar approach has been implemented for the iATU legacy/unroll setup
> > auto-detection. So I don't see much reasons to have it grepped, so as
> > to have a macro-based parametrization since the special value will
> > unluckily change while having the explicit literal utilized gives a
> > better understanding of the way the algorithm works.
> 

> If 0xFFFFFFFF is the result of a successful PCIe Memory Read,

Right. It is.

> and not
> something synthesized by the host bridge when it handles an
> Unsupported Request completion,

No it isn't. To be clear 0xFFs don't indicate some PCIe bus/controller
malfunction, but they are a result of reading the
DMA_CTRL_VIEWPORT_OFF register which doesn't exist. The manual
explicitly says: "Note - When register does not exist, value is fixed
to 32'hFFFF_FFFF". The register doesn't exist if either eDMA is
unavailable or the eDMA CSRs are mapped via the unrolled state. That
logic is used to auto-detect the eDMA availability and the way of it's
CSRs mapping.

> I'm fine with keeping it as is.

Ok. Thanks.

-Sergey
