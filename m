Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B345474D27
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 22:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhLNVUC (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 16:20:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhLNVUC (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Dec 2021 16:20:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72FCC061574;
        Tue, 14 Dec 2021 13:20:01 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639516798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY5SIbLiQJhNf3IcwLAaYT3af81CnBCUSA3qSWP4dj0=;
        b=EzQFCHRvraOq6euqkQn1B+tUeoQ1uw1bo4mwk9Q+vKSF8S8PO4nMGeLKZ/WNHEDZ5eJhpq
        mjggZFTuoIKEO/OrzzxxfitzasNIFFxeDKcRyrdk7DdmUaNmMFC1unLIMtUfaK38TWwXYn
        h2orgm5VCZyrGWnjQirGszYr8438eZQal4q/1iuBvD2zWg9nOeapYD6mAyJQRKxCWoQSAd
        enz2/bCSy9StMuvCnU8bbCEhKsc+iX17V3lbzwiD4WPpGEDgVUswHFbLH8z54QbwfbJl42
        iPxl/XpXV7+3L/A3q2mlzAY6VVHUHz35mnJZ8s3Ze10jfDmKSXRCDaOkhFkkdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639516798;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UY5SIbLiQJhNf3IcwLAaYT3af81CnBCUSA3qSWP4dj0=;
        b=lDR2zL85oMI4BdOLKEJ1Arl/dti0X9kWdevk0BKKPLGWBqf9hwgLOpBluOuP1fE4iBCR8Y
        5fOFMFfQxW57zEAA==
To:     Nishanth Menon <nm@ti.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>, linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [patch V3 00/35] genirq/msi, PCI/MSI: Spring cleaning - Part 2
In-Reply-To: <20211214205626.lrnddha6bd6d6es5@possibly>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider> <87wnk7rvnz.ffs@tglx>
 <87tufbrudl.ffs@tglx> <87mtl3rli1.ffs@tglx>
 <20211214205626.lrnddha6bd6d6es5@possibly>
Date:   Tue, 14 Dec 2021 22:19:57 +0100
Message-ID: <87h7basx36.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nishanth,

On Tue, Dec 14 2021 at 14:56, Nishanth Menon wrote:
> On 21:15-20211214, Thomas Gleixner wrote:
>> I think I managed to distangle this. Can you please give:
>> 
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v4-part-2
>
>
> Umm.. I am not entirely sure what is going on.. but all kinds of weird
> corruption seems to occur with msi-v4-part-2 that does'nt seem to be
> present in v5.16-rc5. (I use NFS since ethernet in K3 platforms use
> inta/intr and dma that is impacted by this series).
>
> I will try and rebase your patches on v5.16-rc4 to be sure as well and
> report back later today once i get some time.
>
> [1] https://gist.github.com/nmenon/a66e022926c4c15313c45d44313d860c msi-v4-part-2
> [2] https://gist.github.com/nmenon/43085664d69ad846d596e76a06ed0656  v5.16-rc5

thanks for trying. I'll have a look again with brain awake tomorrow
morning.

Thanks,

        tglx
