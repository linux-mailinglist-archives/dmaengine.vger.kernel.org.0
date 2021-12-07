Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5913D46B48E
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 08:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhLGHza (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 02:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhLGHz3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 02:55:29 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5740C061746;
        Mon,  6 Dec 2021 23:51:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F26BCE1A05;
        Tue,  7 Dec 2021 07:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6A69C341C3;
        Tue,  7 Dec 2021 07:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638863516;
        bh=jJB7V/1FDjCODHYTLlFlS5enXptOdG8ZYS3VC4cWcVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRE24ncYXDsRhhK2eQiUlxP7Y8oQsTsshV3hfVEv8bGtSxchPZ8/SkzPNYE1E38An
         aOvrifHb/I9rQaWzQ07/d2NwtcfBxBO7tW7Ohdsq63Q2QKH1LNL+bVYpuGXJT676qi
         Uz/SbFs2qPx/iZd1dSkcACeZlmJJNSFCfEQlT6xo=
Date:   Tue, 7 Dec 2021 08:51:53 +0100
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
Subject: Re: [patch V2 27/36] genirq/msi: Provide interface to retrieve Linux
 interrupt number
Message-ID: <Ya8SmWGiCnt4xTmC@kroah.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210439.128089025@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210439.128089025@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:39PM +0100, Thomas Gleixner wrote:
> This allows drivers to retrieve the Linux interrupt number instead of
> fiddling with MSI descriptors.
> 
> msi_get_virq() returns the Linux interrupt number or 0 in case that there
> is no entry for the given MSI index.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

