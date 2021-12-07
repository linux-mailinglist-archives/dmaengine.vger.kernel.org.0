Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD9646B49F
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 08:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231582AbhLGHz7 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 02:55:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52516 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231583AbhLGHz7 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 02:55:59 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51609B816D2;
        Tue,  7 Dec 2021 07:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FDEC341C6;
        Tue,  7 Dec 2021 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638863547;
        bh=nCz2eprBDDZQ3hphsrTchcKKsptlZR6ElROa48+S3D0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THSlYZzdDomIjyopvU5UfNwTG47lpNK4jXGRHhOoFNXwX5+imnG0HcAyKtwYLRR5x
         nrrwNNGJQmDJIgRHihmrMpGobufnGW2QTi+2XkoTvxG8s0uo8t2HjLG/kOjX2Oo5zw
         Z8t/Sg2MiIE1W7osNN65DigsH0oO3jivQutxb2t4=
Date:   Tue, 7 Dec 2021 08:52:24 +0100
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
Subject: Re: [patch V2 19/36] PCI/MSI: Store properties in device::msi::data
Message-ID: <Ya8SuMnuZ4I64xLh@kroah.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.688216619@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210438.688216619@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:26PM +0100, Thomas Gleixner wrote:
> Store the properties which are interesting for various places so the MSI
> descriptor fiddling can be removed.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


