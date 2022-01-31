Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C175D4A45BA
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 12:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376631AbiAaLqd (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 06:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379780AbiAaLoO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jan 2022 06:44:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80AC5C034003;
        Mon, 31 Jan 2022 03:27:59 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643628478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=4vunJSw+29nMhKwarhIq3XOACVtrs68uDOcnGTjBogA=;
        b=08+adjG5kvqly9R27r6UQqPVlHuuR0wvg7AraR+yb44p1SYXk6tzK2abtw7IGSi2A3wXfI
        6U1PBy/jkvuCM3fKrPHG2APL7p9nnSGR9rg89/6St5G9+Iod6wSzgG4//1TPbjInXUs8YN
        AwxB3zkSRCSMca4ho01kA/XiGI4WDXwyqGA/Q1QoCwvYXEwS/NWbubISSEMuoN2RNNZk6X
        k+mIQEs2lRbseraKMG1ylwlb9XmMSJiXrB/5Msv2UG1+iYWWGnwuZaVGTtIizxYMk1wpBk
        7RxcI8ct1tXsnuKIrqrBOd4gsj7C5lweoLU2Rx7EKaWcOJBL6ltT48oEiUJlEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643628478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=4vunJSw+29nMhKwarhIq3XOACVtrs68uDOcnGTjBogA=;
        b=F4vMMMS/RR2647UpQl2u4kgknqNjM8y1uiJemITMdVUuEzICexEkSEXuPmcOo4kKXCPGTF
        66aXb64gMDoB5SDg==
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     LKML <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Will Deacon <will@kernel.org>, Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sinan Kaya <okaya@kernel.org>,
        iommu@lists.linux-foundation.org,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jason Gunthorpe <jgg@nvidia.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org, Kevin Tian <kevin.tian@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Cedric Le Goater <clg@kaod.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Megha Dey <megha.dey@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Tero Kristo <kristo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vinod Koul <vkoul@kernel.org>, Marc Zygnier <maz@kernel.org>,
        dmaengine@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V3 28/35] PCI/MSI: Simplify pci_irq_get_affinity()
In-Reply-To: <20220130171210.GA3545402@roeck-us.net>
Date:   Mon, 31 Jan 2022 12:27:57 +0100
Message-ID: <87mtjc2lhe.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sun, Jan 30 2022 at 09:12, Guenter Roeck wrote:
> On Fri, Dec 10, 2021 at 11:19:26PM +0100, Thomas Gleixner wrote:
> This patch results in the following runtime warning when booting x86
> (32 bit) nosmp images from NVME in qemu.
>
> [   14.825482] nvme nvme0: 1/0/0 default/read/poll queues
> ILLOPC: ca7c6d10: 0f 0b
> [   14.826188] ------------[ cut here ]------------
> [   14.826307] WARNING: CPU: 0 PID: 7 at drivers/pci/msi/msi.c:1114 pci_irq_get_affinity+0x80/0x90

This complains about msi_desc->affinity being NULL.

> git bisect bad f48235900182d64537c6e8f8dc0932b57a1a0638
> # first bad commit: [f48235900182d64537c6e8f8dc0932b57a1a0638] PCI/MSI: Simplify pci_irq_get_affinity()

Hrm. Can you please provide dmesg and /proc/interrupts from a
kernel before that commit?

Thanks,

        tglx

