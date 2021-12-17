Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A68947972A
	for <lists+dmaengine@lfdr.de>; Fri, 17 Dec 2021 23:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhLQWaM (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 17 Dec 2021 17:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhLQWaM (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 17 Dec 2021 17:30:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C6AC061574;
        Fri, 17 Dec 2021 14:30:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 946F0B82A9B;
        Fri, 17 Dec 2021 22:30:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E46BC36AE2;
        Fri, 17 Dec 2021 22:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639780209;
        bh=8wwtNzd+gqMtJWZe56YrMEoqcAh58nCen38oaJYWaO8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iEDPDsKO98XO/jvJbm+yFgRmQxDl4CmwNCCZ9O7HpbCSEXJA25pw5YHPwb3s5TQNN
         i9BY1ubFlnf5uG9DhdB1upZgn3wBZ2U7zEKoZbzzSqONfP1iWr0lR/mc6vKNukUu4Y
         v3rmzZ7PuTCgGnrM38gn5DW9gYtmVN5J+BeNUM4EZYyS4A+dHs/rlpxPuADA19S0dn
         neVNoMO0dY5ql14VUQ62/P1PHlq3AtDvEc5p5JSO8vS0wwfJA0S0NhJ71hctL2lZr6
         u+JH0mJiYdoKOw4PkNyE8E1OMgv4ObOm4BwqrAiECJ8clDjSowxx7LeV6ApqW7P8A6
         w01dCRvRkkngQ==
Date:   Fri, 17 Dec 2021 15:30:00 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Cedric Le Goater <clg@kaod.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
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
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
Message-ID: <Yb0PaCyo/6z3XOlf@archlinux-ax161>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.900929381@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210221814.900929381@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Thomas,

On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Replace open coded MSI descriptor chasing and use the proper accessor
> functions instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Apologies if this has already been reported somewhere else or already
fixed, I did a search of all of lore and did not see anything similar to
it and I did not see any new commits in -tip around this.

I just bisected a boot failure on my AMD test desktop to this patch as
commit f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()") in
-next. It looks like there is a problem with the NVMe drive after this
change according to the logs. Given that the hard drive is not getting
mounted for journald to write logs to, I am not really sure how to get
them from the machine so I have at least taken a picture of what I see
on my screen; open to ideas on that front!

https://github.com/nathanchance/bug-files/blob/0d25d78b5bc1d5e9c15192b3bc80676364de8287/f48235900182/crash.jpg

Please let me know what information I can provide to make debugging this
easier and I am more than happy to apply and test patches as needed.

Cheers,
Nathan
