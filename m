Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3645FE6B
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 13:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354211AbhK0MRI (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Nov 2021 07:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238890AbhK0MPH (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 Nov 2021 07:15:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7641C061756;
        Sat, 27 Nov 2021 04:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BA40B812A7;
        Sat, 27 Nov 2021 12:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DB7C53FBF;
        Sat, 27 Nov 2021 12:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638015110;
        bh=/XPeQ1hFhyBOZd/fOEzJpKNA/3j261q99S9wRv9Ei2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vJEmWjyfKy/Ykqefyq5ESJyVx4tFUS8o7AaDPBdBP68fLuKNHf42fJrbUbJ4DcVWC
         wtdw1zd30d8uY3crZt8GTJbaP3VXRVKOhuJsD/BEANJ7wuZiJYWl/w2fltiVBxKcHV
         z4HAxvDW7WvmuYc8vd724ImvHTKbnxH/tRBogIHc=
Date:   Sat, 27 Nov 2021 13:11:47 +0100
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
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch 01/37] device: Move MSI related data into a struct
Message-ID: <YaIgg0tpnuGG6oda@kroah.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230523.982881381@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126230523.982881381@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 27, 2021 at 02:20:08AM +0100, Thomas Gleixner wrote:
> The only unconditional part of MSI data in struct device is the irqdomain
> pointer. Everything else can be allocated on demand. Create a data
> structure and move the irqdomain pointer into it. The other MSI specific
> parts are going to be removed from struct device in later steps.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Will Deacon <will@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: iommu@lists.linux-foundation.org
> Cc: dmaengine@vger.kernel.org
> ---
>  drivers/base/platform-msi.c                 |   12 ++++++------
>  drivers/dma/ti/k3-udma.c                    |    4 ++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |    2 +-
>  drivers/irqchip/irq-mvebu-icu.c             |    6 +++---
>  drivers/soc/ti/k3-ringacc.c                 |    4 ++--
>  drivers/soc/ti/ti_sci_inta_msi.c            |    2 +-
>  include/linux/device.h                      |   19 +++++++++++++------
>  7 files changed, 28 insertions(+), 21 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
