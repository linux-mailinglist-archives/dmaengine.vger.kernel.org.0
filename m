Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 872CA46B49B
	for <lists+dmaengine@lfdr.de>; Tue,  7 Dec 2021 08:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbhLGHzt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 7 Dec 2021 02:55:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52306 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbhLGHzt (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 7 Dec 2021 02:55:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4FDD6B816E4;
        Tue,  7 Dec 2021 07:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780C2C341C3;
        Tue,  7 Dec 2021 07:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638863537;
        bh=YYyYDqi7BKUMM2VLzZGPdlwcQYloLbHu+PMAAmx4vhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lrf2b5VSroC8kPE/EiMROJoVWuZNxt44LjP49Y2om8BhI+BBXM8o24IwyEFOVAbJ9
         6DDZrdJtryDpOkn0TScv95xjBYKuAaQom3T6s67hk1FezNRypOhHKdh/ZpWaMaCohx
         8uO6pfgsd8KtuoUxhX/hHicEdoYvaTBX5V3Rkp40=
Date:   Tue, 7 Dec 2021 08:52:14 +0100
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
Subject: Re: [patch V2 23/36] powerpc/cell/axon_msi: Use MSI device properties
Message-ID: <Ya8SrlbeCdsN7ujX@kroah.com>
References: <20211206210307.625116253@linutronix.de>
 <20211206210438.913603962@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206210438.913603962@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Dec 06, 2021 at 11:39:33PM +0100, Thomas Gleixner wrote:
> instead of fiddling with MSI descriptors.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

