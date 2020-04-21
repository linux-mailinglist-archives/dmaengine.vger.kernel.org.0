Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26A41B339C
	for <lists+dmaengine@lfdr.de>; Wed, 22 Apr 2020 01:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDUXof (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 21 Apr 2020 19:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgDUXof (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 21 Apr 2020 19:44:35 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD66C0610D6
        for <dmaengine@vger.kernel.org>; Tue, 21 Apr 2020 16:44:34 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id h6so157171lfc.0
        for <dmaengine@vger.kernel.org>; Tue, 21 Apr 2020 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LQhtlsw1+T6reMAEhFyYFr2m8Qv3jouQUXJ8R8StFM8=;
        b=S4jVdIKlRsEiRGbtdIe4araEhiFTR6d+6KJqowgAjs2Aw6i7qWq9+rhzeWPW20Lwyv
         JhvwC5N0zDc010k/ZQ+WQZZcJc/egZZBd/t6Y4mO8M8oWzOIXkF4OQfuGBD1CUnwuMRh
         WNQD8NykXmqQHrYCtadUapSWEhcTe8FKW9ISCfS9PMxycykPibhwsI+BAq5OCxBcfoA/
         BDaLL2qwtILN6XtP3yNpbDfpYwbZAR7KxfkG2tpluOBDpHiHbgo3jtNFD4cQDT8DQ/BP
         2hSEMCAkRz9D49XieNfmFuymeONKUhx54J56YEwvhksgchmHLUUYrKXFeCcwmqD/lex6
         z63w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LQhtlsw1+T6reMAEhFyYFr2m8Qv3jouQUXJ8R8StFM8=;
        b=nHqYoFvCVrFKFColwyLe5PUMOtL1vM3meVcnYbU/TN70ApNOAfr87n/TCrMZ3TYCm8
         8BI9eXhHA8djhO4VVHU7XDF3yKb/5bsxxDwb3vL9UKV2e+M2uKl8OsbupHPe2rwoLTeR
         esc7iV8yZNZw8k2p3I1PR0vfwOCcEdc6AqSCIU3xw7wB19nNijdDHq4Qh7arUhY/oNj5
         w64umF9X4uVr0/Dfr7UxN7aolFf+oENmDLulHMRDLVh+viN8Eks+uBQcio/kysH6T+4b
         jlG9+9LsyTmE6kmM1TcDois8JcBCfKFt/tyHIcKL5lfUo4LIf3T7dpiuM0nJ9cMWTwHn
         gWYA==
X-Gm-Message-State: AGi0Pub/nRVgbLqNtRujvt+yllIG4C9dx2Ip5lU6sQDg/sYpzGEwyb9U
        ziGjA/G98XdnkpRaAii0iWPZAYMbSn3/QHMTfJoEuQ==
X-Google-Smtp-Source: APiQypKb2BXKLr6nvOOiLiS7ib4bgDZHP5d7Dp+7WeRvGIhSc1y5feKb+/KNTb10Rd1TBtBcLrXe2xWQhq1x5j95PIQ=
X-Received: by 2002:ac2:5e26:: with SMTP id o6mr14712374lfg.49.1587512672917;
 Tue, 21 Apr 2020 16:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <1587149322-28104-1-git-send-email-alan.mikhak@sifive.com>
 <20200418122123.10157ddd@why> <CY4PR12MB1271277CEE4F1FE06B71DDE8DAD60@CY4PR12MB1271.namprd12.prod.outlook.com>
 <8a03b55223b118c6fc605d7204e01460@kernel.org> <CABEDWGxLKB68iknXtK8-4ke3wGW-6RKBnDEh6rFbBekLyawVOw@mail.gmail.com>
 <20200421093928.4a600662@why>
In-Reply-To: <20200421093928.4a600662@why>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Tue, 21 Apr 2020 16:44:21 -0700
Message-ID: <CABEDWGxkn-rSnbjugWDPiOH1J_H9gen97CQ=NXFf44dFbFEyxQ@mail.gmail.com>
Subject: Re: [PATCH] genirq/msi: Check null pointer before copying struct msi_msg
To:     Marc Zyngier <maz@kernel.org>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-pci <linux-pci@vger.kernel.org>, tglx@linutronix.de,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Apr 21, 2020 at 1:39 AM Marc Zyngier <maz@kernel.org> wrote:
>
> On Mon, 20 Apr 2020 09:08:27 -0700
> Alan Mikhak <alan.mikhak@sifive.com> wrote:
>
> Alan,
>
> > On Mon, Apr 20, 2020 at 2:14 AM Marc Zyngier <maz@kernel.org> wrote:
> > >
> > > On 2020-04-18 16:19, Gustavo Pimentel wrote:
> > > > Hi Marc and Alan,
> > > >
> > > >> I'm not convinced by this. If you know that, by construction, these
> > > >> interrupts are not associated with an underlying MSI, why calling
> > > >> get_cached_msi_msg() the first place?
> > > >>
> > > >> There seem to be some assumptions in the DW EDMA driver that the
> > > >> signaling would be MSI based, so maybe someone from Synopsys
> > > >> (Gustavo?)
> > > >> could clarify that. From my own perspective, running on an endpoint
> > > >> device means that it is *generating* interrupts, and I'm not sure what
> > > >> the MSIs represent here.
> > > >
> > > > Giving a little context to this topic.
> > > >
> > > > The eDMA IP present on the Synopsys DesignWare PCIe Endpoints can be
> > > > configured and triggered *remotely* as well *locally*.
> > > > For the sake of simplicity let's assume for now the eDMA was
> > > > implemented
> > > > on the EP and that is the IP that we want to configure and use.
> > > >
> > > > When I say *remotely* I mean that this IP can be configurable through
> > > > the
> > > > RC/CPU side, however, for that, it requires the eDMA registers to be
> > > > exposed through a PCIe BAR on the EP. This will allow setting the SAR,
> > > > DAR and other settings, also need(s) the interrupt(s) address(es) to be
> > > > set as well (MSI or MSI-X only) so that it can signal through PCIe (to
> > > > the RC and consecutively the associated EP driver) if the data transfer
> > > > has been completed, aborted or if the Linked List consumer algorithm
> > > > has
> > > > passed in some linked element marked with a watermark.
> > > >
> > > > It was based on this case that the eDMA driver was exclusively
> > > > developed.
> > > >
> > > > However, Alan, wants to expand a little more this, by being able to use
> > > > this driver on the EP side (through
> > > > pcitest/pci_endpoint_test/pci_epf_test) so that he can configure this
> > > > IP
> > > > *locally*.
> > > > In fact, when doing this, he doesn't need to configure the interrupt
> > > > address (MSI or MSI-X), because this IP provides a local interrupt line
> > > > so that be connected to other blocks on the EP side.
> > >
> > > Right, so this confirms my hunch that the driver is being used in
> > > a way that doesn't reflect the expected use case. Rather than
> > > papering over the problem by hacking the core code, I'd rather see
> > > the eDMA driver be updated to support both host and endpoint cases.
> > > This probably boils down to a PCI vs non-PCI set of helpers.
> > >
> > > Alan, could you confirm whether we got it right?
> >
> > Thanks Marc and Gustavo. I appreciate all your comments and feedback.
> >
> > You both got it right. As Gustavo mentioned, I am trying to expand dw-edma
> > for additional use cases.
> >
> > First new use case is for integration of dw-edma with pci-epf-test so the latter
> > can initiate dma transfers locally from endpoint memory to host memory over the
> > PCIe bus in response to a user command issued from the host-side command
> > prompt using the pcitest utility. When the locally-initiated dma
> > transfer completes
> > in this use case on the endpoint side, dw-edma issues an interrupt to the local
> > CPU on the endpoint side by way of a legacy interrupt and pci-epf-test issues
> > an interrupt toward the remote host CPU across the PCIe bus by way of legacy,
> > MSI, or possibly MSI-X interrupt.
> >
> > Second new use case is for integration of dw-edma with pci_endpoint_test
> > running on the host CPU so the latter can initiate dma transfers locally from
> > host-side in response to a user command issued from the host-side command
> > prompt using the pcitest utility. This use case is for host systems that have
> > Synopsys DesignWare PCI eDMA hardware on the host side. When the
> > locally-initiated dma transfer completes in this use case on the host-side,
> > dw-edma issues a legacy interrupt to its local host CPU and pci-epf-test running
> > on the endpoint side issues a legacy, MSI, or possibly MSI-X interrupt
> > across the
> > PCIe bus toward the host CPU.
> >
> > When both the host and endpoint sides have the Synopsys DesignWare PCI
> > eDMA hardware, more use cases become possible in which eDMA controllers
> > from both systems can be engaged to move data. Embedded DMA controllers
> > from other PCIe IP vendors may also be supported with additional dmaengine
> > drivers under the Linux PCI Endpoint Framework with pci-epf-test, pcitest, and
> > pci_endpoint_test suite as well as new PCI endpoint function drivers for such
> > applications that require dma, for example nvme or virtio_net endpoint function
> > drivers.
> >
> > I submitted a recent patch [1] and [2] which Gustavo ACk'd to decouple dw-edma
> > from struct pci_dev. This enabled me to exercise dw-edma on some riscv host
> > and endpoint systems that I work with.
> >
> > I will submit another patch to decouple dw-edma from struct msi_msg such
> > that it would only call get_cached_msi_msg() on the host-side in its
> > original use case with remotely initiated dma transfers using the BAR
> > access method.
> >
> > The crash that I reported in __get_cached_msi_msg() is probably worth
> > fixing too. It seems to be low impact since get_cached_msi_msg()
> > seems to be called infrequently by a few callers.
>
> It isn't about the frequency of the calls, nor the overhead of this
> function. It is about the fundamental difference between a wired
> interrupt (in most case a level triggered one) and a MSI (edge by
> definition on PCI). By making get_cached_msi_msg() "safe" to be called
> for non-MSI IRQs, you hide a variety of design bugs which would
> otherwise be obvious, like the one you are currently dealing with.
>
> Your eDMA driver uses MSI by construction, and is likely to use the MSI
> semantics (edge triggering, coalescing, memory barrier). On the other
> hand, your use case is likely to have interrupts with very different
> semantics (level triggered, no barrier effect). Papering over these
> differences is not the way to go, I'm afraid.
>
> I would recommend that you adapt the driver to have a separate
> interrupt management for the non-MSI case, or at least not blindly use
> MSI-specific APIs when not using them.

Thanks Marc,

I understand that the crash I reported here is to be kept to catch such
issues. The design of dw-edma was correct for its original use case.
Since I am the one trying to expand its use cases, I accept your
recommendation and will see if I can offer patches that would be
acceptable there.

Regards,
Alan

>
> Thanks,
>
>         M.
> --
> Jazz is not dead. It just smells funny...
