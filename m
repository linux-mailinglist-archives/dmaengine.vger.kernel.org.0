Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38337477A7A
	for <lists+dmaengine@lfdr.de>; Thu, 16 Dec 2021 18:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240233AbhLPRXt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 16 Dec 2021 12:23:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55632 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbhLPRXo (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 16 Dec 2021 12:23:44 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639675422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih3MOpW/yCW+x5F+uZuuVRHaDZ9exo66WfrPCFsrhAY=;
        b=OMVjennJ3dIFrwVfMs8MzDcb41Xr30oKty6fkqZ9/dg2KPX2j01Itd6kvCYu1225sOnYuo
        IeaHw/JoJkXrtGr3oWwJMzzEwGmbkJFG3vgu9mNytV1jkcv4dag6oBGHon+mbf9Ogyak6J
        JF0hQ4F7JA1yDzHNDLmTJM8en1l9nh0l4RtyKkhJNdGp1qF+PkIKoY49IEUHTkOsVif77X
        EDZmJYVvTSc9g7y9TRGoIHjKz9B63drgsnnIlXTKDk1IKqeYDrXtl+Qq6LpiQy1hqLdDie
        mG/yWvrQXdNGXa7j6B8oNi6M8Sbe5B02MnwHdqWu6fekNoxcotWWNW+EPmJPkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639675422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ih3MOpW/yCW+x5F+uZuuVRHaDZ9exo66WfrPCFsrhAY=;
        b=KLmanqyVLTn1a9p7GzpJVoRlRAGdDGqehRu/zZHojbSx8/zpp5uAkFxpqxeluTK3IDEpyQ
        hmWFXp91ZBiOKlBQ==
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
In-Reply-To: <20211216014527.5d3sqs2klrqjmm2k@lunacy>
References: <20211213182958.ytj4m6gsg35u77cv@detonator>
 <87fsqvttfv.ffs@tglx> <20211214162247.ocjm7ihg5oi7uiuv@slider>
 <87wnk7rvnz.ffs@tglx> <87tufbrudl.ffs@tglx> <87mtl3rli1.ffs@tglx>
 <20211214205626.lrnddha6bd6d6es5@possibly> <87h7basx36.ffs@tglx>
 <87zgp1rge4.ffs@tglx> <87wnk5rfkt.ffs@tglx>
 <20211216014527.5d3sqs2klrqjmm2k@lunacy>
Date:   Thu, 16 Dec 2021 18:23:41 +0100
Message-ID: <87wnk4cvky.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Nishanth,

On Wed, Dec 15 2021 at 19:45, Nishanth Menon wrote:
> On 17:35-20211215, Thomas Gleixner wrote:
> Thanks once again for your help. Hope we can roll in the fixes for
> part3.

Sure, it's only the one-liner for ti sci. Got it folded already.

Thanks for your help and testing!

       tglx
