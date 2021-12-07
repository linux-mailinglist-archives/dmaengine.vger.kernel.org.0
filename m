Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C8D46B4A9
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 08:52:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhLGH4W (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 02:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhLGH4V (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 02:56:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D04C061746;
        Mon,  6 Dec 2021 23:52:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D14DDCE19C0;
        Tue,  7 Dec 2021 07:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6456CC341C1;
        Tue,  7 Dec 2021 07:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638863568;
        bh=vCZmCfds9fGR8KSqYGfBdedJROQkJKaIyrhFh2LFF/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HtoyV3RRzvoi0PrEYpfpDPeITXhIwQvbjxWqx411JpOHn7PGizTjybev6iCzICEYY
         x7Ns6xV/QcCyjvP8JXB3nGwo7wrEGnRfcS9iW3/uqjpuUAP24nFL5MSwkRYf5HSMjP
         n2TcEjgXaACoJgRlEa1cjKloYE1WcawlchFz/aAA=
Date:   Tue, 7 Dec 2021 08:52:45 +0100
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
        xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
        Will Deacon <will@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V2 28/36] PCI/MSI: Use __msi_get_virq() in
 pci_get_vector()
Message-ID: <Ya8SzYpOcsbItjkU@kroah.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210439.181331216@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210439.181331216@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:41PM +0100, Thomas Gleixner wrote:
> Use msi_get_vector() and handle the return value to be compatible.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

