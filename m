Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76CF5A17AB
	for <lists+dmaengine@lfdr.de>; Thu, 25 Aug 2022 19:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242093AbiHYRGg (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 25 Aug 2022 13:06:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241798AbiHYRGd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 25 Aug 2022 13:06:33 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE18AE9EE;
        Thu, 25 Aug 2022 10:06:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id l1so28539284lfk.8;
        Thu, 25 Aug 2022 10:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=R5iHqEtZr00erkxX3NB+2OL0weXC8cEtJ06yqZDqDa0=;
        b=WD8YxMU9hiV91Sw7idRjtjgBMWjDgN0X0lwPAf6/1qCaZoEQDnU2+YhQ6belvwFPE6
         UmvjxOuhr6N4++sVYaKkc/bsfk5Ef3MLg8DHpO4s/xRns8nzwqI9fO4kuQJnkNQt1oTV
         SzWy55K8pRC6jjccpYH6OeP8/LWyZ5Z4Ynr2nU/5lQkgypbLyZfSfY67ShcwBCQs1rad
         xUQXd480pOYMuW1nbPH+LgMCCqk4x9Nw6Ac1I8QnxgTpMDF2a5L0hJNSJT3ThaFG6RJ7
         9IWxrqharq6KkF6/qL5/qapwlUovJGeKzT8w5TiSFsffbrbs554q76QmPKPw2D0X6YJ8
         y1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=R5iHqEtZr00erkxX3NB+2OL0weXC8cEtJ06yqZDqDa0=;
        b=mBjoO3cJJYcGbAGTi/YxY9DKSbS1AEishB29+dsljMAyFbkWEea2zqWsczyB5HeLFg
         1aoBZ7ev9JVXcRZ9qhyEi3NZ1wCgCamlpoSURYrsfBdeD9EwTdvUKRZU2InZDuIRQwWp
         8HX9mR0atSFqls5lOc0bXATPkUsbtlOJbEU4LviNaAFoRo+MZG2GFNLP+Nb8CEOQ3qPJ
         GZC5UuRs0hHhxQYLwnx4we35SNzX5+FRwm30Ar6FFEpK5cfs4xT7qegtG067LxWfTL13
         XDjjzwmusedJw1RuFkpGf191ERZdZG07J/KFlbXqvGwskP67KkF+Eo9Q7lHS1DrZ/zUa
         /5fA==
X-Gm-Message-State: ACgBeo280WspulAuLIpk2macXWrGWXLbB6tcmh14mH1pNvWtKihOJTG4
        FHoZKL8VZIiQsLBVFwCGAI8=
X-Google-Smtp-Source: AA6agR5V/OoZyKFWfn0mqWqYNTWrkAZEQLeBy+FOZPvZlRdGy4gUOqmqIRSabWb8hdBkEzy79Kw6ag==
X-Received: by 2002:a05:6512:2609:b0:491:10ba:31f0 with SMTP id bt9-20020a056512260900b0049110ba31f0mr1361412lfb.334.1661447189542;
        Thu, 25 Aug 2022 10:06:29 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id l20-20020ac24314000000b00492dbb3b74fsm586761lfh.145.2022.08.25.10.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 10:06:28 -0700 (PDT)
Date:   Thu, 25 Aug 2022 20:06:26 +0300
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
Message-ID: <20220825170626.fnqmw636tqgrqdqc@mobilestation>
References: <20220825051614.kfify5fbqlhurvdn@mobilestation>
 <20220825160443.GA2854084@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825160443.GA2854084@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Thu, Aug 25, 2022 at 11:04:43AM -0500, Bjorn Helgaas wrote:
> On Thu, Aug 25, 2022 at 08:16:14AM +0300, Serge Semin wrote:
> > On Wed, Aug 24, 2022 at 01:17:54PM -0500, Bjorn Helgaas wrote:
> > > On Wed, Aug 24, 2022 at 09:13:19PM +0300, Serge Semin wrote:
> > > > On Wed, Aug 24, 2022 at 11:51:18AM -0500, Bjorn Helgaas wrote:
> > > > > On Mon, Aug 22, 2022 at 09:53:32PM +0300, Serge Semin wrote:
> > > 
> > > > > > +	val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
> > > > > > +	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
> > > > > > +		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> > > > > > +
> > > > > > +		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
> > > > > > +	} else if (val != 0xFFFFFFFF) {
> > > > > 
> > > > 
> > > > > Consider PCI_POSSIBLE_ERROR() as an annotation about the meaning of
> > > > > 0xFFFFFFFF and something to grep for.
> > > > 
> > > > In this case FFs don't mean an error but a special value, which
> > > > indicates that the eDMA is mapped via the unrolled CSRs space. The
> > > > similar approach has been implemented for the iATU legacy/unroll setup
> > > > auto-detection. So I don't see much reasons to have it grepped, so as
> > > > to have a macro-based parametrization since the special value will
> > > > unluckily change while having the explicit literal utilized gives a
> > > > better understanding of the way the algorithm works.
> > 
> > > If 0xFFFFFFFF is the result of a successful PCIe Memory Read,
> > 
> > Right. It is.
> > 
> > > and not
> > > something synthesized by the host bridge when it handles an
> > > Unsupported Request completion,
> > 
> > No it isn't. To be clear 0xFFs don't indicate some PCIe bus/controller
> > malfunction, but they are a result of reading the
> > DMA_CTRL_VIEWPORT_OFF register which doesn't exist. The manual
> > explicitly says: "Note - When register does not exist, value is fixed
> > to 32'hFFFF_FFFF". The register doesn't exist if either eDMA is
> > unavailable or the eDMA CSRs are mapped via the unrolled state.
> 

> OK.  I don't think that's worded very well in the manual.  A register
> that does not exist does not have a value, and attempts to read it
> should fail.

No. The manual explicitly says that this particular CSR
(DMA_CTRL_VIEWPORT_OFF) value is tied to 32'hFFFF_FFFF if the register
doesn't exist. There is no such text mentioned for any other
non-existing CSR.

> If they want to say the register always exists and
> contains 0xFFFFFFFF for versions earlier than X, that would make
> sense.  Wouldn't be the first time a manual is ambiguous ;)

They say, that the register doesn't exist if either eDMA isn't
available or it's mapped via the unrolled CSR space. There is no
reference to the IP-core version.

Anyway basically you are right they indeed imply that the register
always exists.

> 
> If the device itself, i.e., not the Root Complex, is fabricating this
> 0xFFFFFFFF value, reading it should not cause any AER or other error
> status bits to be set.
> 
> If the Root Complex fabricates 0xFFFFFFFF upon receipt of a Completion
> with Unsupported Request status, I would expect bits like Received
> Master Abort to be set in the Root Port's Secondary Status register.

The device CSRs are accessed by means of the controller DBI-interface.
Even though the whole CSRs space do look as the extended PCIe config
space, the DBI-based access isn't tracked by the standard PCIe
capabilities like AER. So in case of the eDMA auto-detection procedure
introduced in this patch (and iATU auto-detection, which is already
available in the DW PCIe driver ) we won't have any bus error status
raised.

-Sergey
