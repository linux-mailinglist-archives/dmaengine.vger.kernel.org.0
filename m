Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8E2475FB0
	for <lists+dmaengine@lfdr.de>; Wed, 15 Dec 2021 18:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235476AbhLORqx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 15 Dec 2021 12:46:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53612 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbhLORqu (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 15 Dec 2021 12:46:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 32466B8204E;
        Wed, 15 Dec 2021 17:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3895EC36AE0;
        Wed, 15 Dec 2021 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639590408;
        bh=oVAWRtkVhyLVewrr96Eqb3xtvZVqpmLF7lafQtqO6io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RDn0d3Wgo9MrkKkAlhFp4clsP7kYBq6OP2oGHpB+ZI+/t6B5qJsnoCzurjsB46fWy
         AoK6Or0D4ayB4bHwvQH/ebEEdMkczC3evphKuABc44ElX4jTf+p1dRuhuUK9c1usOI
         gwGgUwjsoCjjzpzu2MRgkv/yDC8qQwbLbyooW/C4=
Date:   Wed, 15 Dec 2021 18:46:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
        Bjorn Helgaas <bhelgaas@google.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Stuart Yoder <stuyoder@gmail.com>,
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
Subject: Re: [patch V4 09-02/35] PCI/MSI: Allocate MSI device data on first
 use
Message-ID: <YboqBZuwu5qDwxKS@kroah.com>
References: <20211210221642.869015045@linutronix.de>
 <20211210221813.740644351@linutronix.de>
 <87tuf9rdoj.ffs@tglx>
 <87r1adrdje.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1adrdje.ffs@tglx>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Wed, Dec 15, 2021 at 06:19:49PM +0100, Thomas Gleixner wrote:
> Allocate MSI device data on first use, i.e. when a PCI driver invokes one
> of the PCI/MSI enablement functions.
> 
> Add a wrapper function to ensure that the ordering vs. pcim_msi_release()
> is correct.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
