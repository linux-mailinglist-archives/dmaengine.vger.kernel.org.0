Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCB724617C6
	for <lists+dmaengine@lfdr.de>; Mon, 29 Nov 2021 15:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhK2OSt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 29 Nov 2021 09:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348983AbhK2OQd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 29 Nov 2021 09:16:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6274C08EAED;
        Mon, 29 Nov 2021 04:52:49 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638190367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YfGqtKfqcg/VBb4scc+UNPvXNHJqUnbrO9jfKPdvNc=;
        b=HplVWLUyXX2hGBuDuAzepO9k9vKo4+aigansIMG5A6PgvComp9g/A8szrWNGO+DISdY1cO
        HzmwbYFzpO7Q/2IoKG933FYvlI+iakLvkkI3MW676OVlnc7A8MPybqGncMhSM56B+JB5UN
        PWbU+6wCNcKBNO1A+j34akq/xZ3+3aX1ItXbhwlzVpIdbOCrNj9jP2pah7Z/DMh8iXi0vY
        WQ4WxZl0EvS+kKrLf6K04nLtKxRo+NFQ3CXHYtdg12/OZVLnw9TMiwzne+FekVyS17Msmp
        St+PtqpCeGz+AJ4jXwZIiSDeE/g+SbXuSG9NDgfDEF4UJQ+4uLGw3cZ+2GnJcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638190367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4YfGqtKfqcg/VBb4scc+UNPvXNHJqUnbrO9jfKPdvNc=;
        b=/vtVlvS+jCeXqOvFdJKQpUuqX073/P52p4KqQKu8Yr9vhveVqL5kazEV6dmh03ToVmk41R
        neyuByPAuatkkHDQ==
To:     Will Deacon <will@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch 33/37] iommu/arm-smmu-v3: Use msi_get_virq()
In-Reply-To: <20211129105506.GA22761@willie-the-truck>
References: <20211126224100.303046749@linutronix.de>
 <20211126230525.885757679@linutronix.de>
 <20211129105506.GA22761@willie-the-truck>
Date:   Mon, 29 Nov 2021 13:52:46 +0100
Message-ID: <87lf17dsyp.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Will,

On Mon, Nov 29 2021 at 10:55, Will Deacon wrote:
> On Sat, Nov 27, 2021 at 02:20:59AM +0100, Thomas Gleixner wrote:
>> +	smmu->evtq.q.irq = msi_get_virq(dev, EVTQ_MSI_INDEX);
>> +	smmu->gerr_irq = msi_get_virq(dev, GERROR_MSI_INDEX);
>> +	smmu->priq.q.irq = msi_get_virq(dev, PRIQ_MSI_INDEX);
>
> Prviously, if retrieval of the MSI failed then we'd fall back to wired
> interrupts. Now, I think we'll clobber the interrupt with 0 instead. Can
> we make the assignments to smmu->*irq here conditional on the MSI being
> valid, please?

So the wired irq number is in ->irq already and MSI does an override
if available. Not really obvious...

Thanks,

        tglx
