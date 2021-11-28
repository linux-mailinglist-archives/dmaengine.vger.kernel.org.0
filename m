Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B44609AC
	for <lists+dmaengine@lfdr.de>; Sun, 28 Nov 2021 21:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbhK1Ucj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sun, 28 Nov 2021 15:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231527AbhK1Uaj (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sun, 28 Nov 2021 15:30:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B63C061748;
        Sun, 28 Nov 2021 12:27:22 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638131240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34cEonPYoHn2wOD4iyX9ID5tmiVh/WyoVyXwqDXryy0=;
        b=oPRc3eq0k+Tw8NUVD33WjmT1yTwdDLqkvp0k8L0fhSlgI1D7uqHcq0GMPi3xW2KkValqF4
        f5+puEWtkAmZQdWC59ouxHon7GH94O2JlbvCxRQE9FC0LWhmJpHAbFNeQ3DsfMLG+EixpT
        hZSGFuc3YgBIjuAqAs5dcF3jT9Jqg1fD8TVHhI2W7B6NwkElYoFJ/x3rfoBW9TCXYktSB/
        7JCQiSAnY6v16Mi6SX4hF9iVphpSdW7rzPWmj9h3jzBE1irCfw+8iZ1z8Ba0yvELN0tdUE
        jvbgs+JgRTKN87ldu+pCs8ssio7C6Aj2xXaDx576hfi5qFT2JGCWpokNJEKoGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638131240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=34cEonPYoHn2wOD4iyX9ID5tmiVh/WyoVyXwqDXryy0=;
        b=qYh8H7dUzo5GOUV8STynfR6skQ9RyXxzWobJRhhOvRzBoMIDa6HMBwwWiZzqU46S2s7nZL
        1Dk2qEe1TKRHefAQ==
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch 00/37] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <20211128003905.GU4670@nvidia.com>
References: <20211126224100.303046749@linutronix.de>
 <20211128003905.GU4670@nvidia.com>
Date:   Sun, 28 Nov 2021 21:27:19 +0100
Message-ID: <87y258do0o.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 27 2021 at 20:39, Jason Gunthorpe wrote:
> On Sat, Nov 27, 2021 at 02:21:17AM +0100, Thomas Gleixner wrote:
>>    4) Provide a function to retrieve the Linux interrupt number for a given
>>       MSI index similar to pci_irq_vector() and cleanup all open coded
>>       variants.
>
> The msi_get_virq() sure does make a big difference.. Though it does
> highlight there is some asymmetry with how platform and PCI works here
> where PCI fills some 'struct msix_entry *'. Many drivers would be
> quite happy to just call msi_get_virq() and avoid the extra memory, so
> I think the msi_get_virq() version is good.

struct msix_entry should just go away.

90+% of the use cases fill it with a linear index range 0...N and then
use the virq entry for request_irq(). So they can just use
pci_alloc_irs_vectors_affinity() and retrieve the interrupt number via
pci_irq_vector().

The few drivers which actually use it to allocate a sparse populated MSI
index, e.g. 0, 12, 14 can be converted over to alloc vector 0 and then
use the dynamic extenstion for the rest.

Thanks,

        tglx
