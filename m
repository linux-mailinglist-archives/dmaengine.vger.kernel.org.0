Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D369F5A012B
	for <lists+dmaengine@lfdr.de>; Wed, 24 Aug 2022 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbiHXSN1 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 24 Aug 2022 14:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239717AbiHXSN0 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 24 Aug 2022 14:13:26 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCE86D57D;
        Wed, 24 Aug 2022 11:13:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id bn9so9629728ljb.6;
        Wed, 24 Aug 2022 11:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0lbGMmFuLLALNWNwg1IFLsjuEsYjoBL8hbke8mOWVoI=;
        b=Aofr0GgWtsbO+tksHCUzbtLNRJML9u9bqdG1Q/NKZHzU2wpBZVi53bbaV2j8B2n+cd
         jYV8RwOFAtTzcotGJLVc2rM8x9xAsK+NBzfbQhrPJQD9U88qDGWY9URxnZ4pc6HPEkj+
         ZB/oZn0OcB9GDiABotSVaIPA56PZny2gjpsD3tH3GtvO3fBxm2QB3AjmhoRCCTaZjENk
         6w9c3to/qfJueaxivE0IYILzyLjAezRwccVbMyec4PFC/nayKsdmAKnj0dUH76gTai66
         L3Td55qhlBs/lFvhf8LR7/QQhKWiXkoQ8vidIdn1hZ8gNqNVxeu2gWcoVlPkOsBHvXIN
         c78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0lbGMmFuLLALNWNwg1IFLsjuEsYjoBL8hbke8mOWVoI=;
        b=rvugMedwu3mWn7ok+4hpQ/fAEYhcfFIEPUsVXspWTVekxYD1zFFltNZmIkNkqjWgOz
         pe1QJ5FifuBw4ZqW2nCcwEYNTfyiMWqkg4tKmmjQAkGyPFH+HYq5vPLZ5tsdibHrFJLc
         mDVEDii29ScP8yZ1exc08I1JbOAabDV47BgUHe3u+kibpPeU85jZ2a4XzFs8PGnKAwdT
         Ix7OUDJJ6kea7xb7hmdOhI6ouO0C/AdAuaD41YoP4qMqQqRaNgsXrORSJBMu7GyPJXWo
         yZkkSL+Tx5WwfXu2XXAv+E5BykccmC20cGh52T55lId4Z2p0T+9IuXvvF4mcUWbt+09S
         wQLQ==
X-Gm-Message-State: ACgBeo1Xly0W76d5X1NgrDqDPy+7EPyA2qIjzfoqqq6LWCUrYQhlCkHp
        VFkKkTmlBnYorczBWIvD9nA=
X-Google-Smtp-Source: AA6agR6uuSX5p/1AMJ2xGzDZ9ew8C7pezBI/KpjLKg7RFpww0yD6Ulr63mnPVzqrTcqdf0aciKeE1w==
X-Received: by 2002:a2e:a78f:0:b0:25f:dedf:efb8 with SMTP id c15-20020a2ea78f000000b0025fdedfefb8mr93629ljf.317.1661364802678;
        Wed, 24 Aug 2022 11:13:22 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24e8d000000b00492f37e428asm31397lfr.172.2022.08.24.11.13.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Aug 2022 11:13:22 -0700 (PDT)
Date:   Wed, 24 Aug 2022 21:13:19 +0300
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
Message-ID: <20220824181319.wkj4256a5jp2xjlp@mobilestation>
References: <20220822185332.26149-25-Sergey.Semin@baikalelectronics.ru>
 <20220824165118.GA2785269@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824165118.GA2785269@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Aug 24, 2022 at 11:51:18AM -0500, Bjorn Helgaas wrote:
> On Mon, Aug 22, 2022 at 09:53:32PM +0300, Serge Semin wrote:
> > Since the DW eDMA driver now supports eDMA controllers embedded into the
> > locally accessible DW PCIe Root Ports and Endpoints, we can use the
> > updated interface to register DW eDMA as DMA engine device if it's
> > available. In order to successfully do that the DW PCIe core driver need
> > to perform some preparations first. First of all it needs to find out the
> > eDMA controller CSRs base address, whether they are accessible over the
> > Port Logic or iATU unrolled space. Afterwards it can try to auto-detect
> > the eDMA controller availability and number of it's read/write channels.
> 

> s/it's//

Ok.

> 
> > If none was found the procedure will just silently halt with no error
> > returned. Secondly the platform is supposed to provide either combined or
> > per-channel IRQ signals. If no valid IRQs set is found the procedure will
> > also halt with no error returned so to be backward compatible with the
> > platforms where DW PCIe controllers have eDMA embedded but lack of the
> > IRQs defined for them. Finally before actually probing the eDMA device we
> > need to allocate LLP items buffers. After that the DW eDMA can be
> > registered. If registration is successful the info-message regarding the
> > number of detected Read/Write eDMA channels will be printed to the system
> > log in the similar way as it's done for the iATU settings.
> 

> s/in the similar way as it's done/as is done/

Ok

> 
> > +static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> > +{
> > +	u32 val;
> > +
> > +	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > +	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > +
> > +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > +	} else if (val != 0xFFFFFFFF) {
> 

> Consider PCI_POSSIBLE_ERROR() as an annotation about the meaning of
> 0xFFFFFFFF and something to grep for.

In this case FFs don't mean an error but a special value, which
indicates that the eDMA is mapped via the unrolled CSRs space. The
similar approach has been implemented for the iATU legacy/unroll setup
auto-detection. So I don't see much reasons to have it grepped, so as
to have a macro-based parametrization since the special value will
unluckily change while having the explicit literal utilized gives a
better understanding of the way the algorithm works.

> 
> > +		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
> > +
> > +		pci->edma.reg_base = pci->dbi_base + PCIE_DMA_VIEWPORT_BASE;
> > +	} else {
> > +		return -ENODEV;
> > +	}
> 
> > + * eDMA CSRs. DW PCIe IP-core v4.70a and older had the eDMA registers accessible
> > + * over the Port Logic registers space. Afterwords the unrolled mapping was
> 

> s/Afterwords/Afterwards/

Ok.

-Sergey

> 
> > + * introduced so eDMA and iATU could be accessed via a dedicated registers
> > + * space.
