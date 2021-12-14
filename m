Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65065474C84
	for <lists+dmaengine@lfdr.de>; Tue, 14 Dec 2021 21:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237584AbhLNUPj (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 14 Dec 2021 15:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbhLNUPi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 14 Dec 2021 15:15:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796D9C061574;
        Tue, 14 Dec 2021 12:15:38 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639512936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4wqcXY+MET+Bv0FcRzIRIc5XGvbPUI2bHV9pxD9Ydo=;
        b=moChZUSho9BA78Zeq1WI5tu/U00oT82AtvfenvZ7wj4+/rbRuMvnEvgp06APrkesXoQIzl
        7RPpBe3m0oONdQpdS7DAAUNLaW0sDBUgC0jenFPjG7Wr9CEB6Oy4B9l4Iuq/IfEVofBt4t
        vnaGOWsnREceAU8uxY8NAKpNhml+AgXrJsZ6gKqMSiQL7bA9CFgw8w2TYZeEYT8V3NhbQ8
        JAqpROxGWfe9cCXptM9xGI/fDzxgqMZx8ZITW8fq90knUugjlJY38p2e8sp+HmqqufWXbS
        n3mRyaNC3MmjNNomr7JUos4qRao6JylFxbVwVGdREF91hazpGg2c9oB6BzqE4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639512936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d4wqcXY+MET+Bv0FcRzIRIc5XGvbPUI2bHV9pxD9Ydo=;
        b=+ecmdjzCvUtoz/ixJ5pxFaVr7F21Ajeaa5ilYhIAuSfZy+n3tm1NOnNdHltlRFCs+3G/Mc
        B5RpqeVcmdLBkuDA==
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
In-Reply-To: <87tufbrudl.ffs@tglx>
References: <20211210221642.869015045@linutronix.de>
 <20211213182958.ytj4m6gsg35u77cv@detonator> <87fsqvttfv.ffs@tglx>
 <20211214162247.ocjm7ihg5oi7uiuv@slider> <87wnk7rvnz.ffs@tglx>
 <87tufbrudl.ffs@tglx>
Date:   Tue, 14 Dec 2021 21:15:34 +0100
Message-ID: <87mtl3rli1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nishanth,

On Tue, Dec 14 2021 at 18:03, Thomas Gleixner wrote:
>     msi_device_data_release()
>     ...
>     pcim_release()
>        pci_disable_msi[x]()
>
> Groan....

I think I managed to distangle this. Can you please give:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v4-part-2

and/or the full pile:

   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v4-part-3

a test ride?

Thanks,

        tglx
