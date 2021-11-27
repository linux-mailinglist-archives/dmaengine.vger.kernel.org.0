Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C74D45FE74
	for <lists+dmaengine@lfdr.de>; Sat, 27 Nov 2021 13:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354524AbhK0MSv (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 27 Nov 2021 07:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354084AbhK0MQv (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 27 Nov 2021 07:16:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02F9CC061757;
        Sat, 27 Nov 2021 04:13:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC9DEB81B2C;
        Sat, 27 Nov 2021 12:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEFA7C53FC7;
        Sat, 27 Nov 2021 12:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638015214;
        bh=XtSbO4k+vMobFsdi5tmd+EqIlOAeUB4z3bp8mHbf/Es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t371DqErpIj7MtVmLv6hkkc1ialioBukKn0NsTCIZvvbmQoMJHLuODLDpIb5vXZu/
         bR3Fqokrv02lGje8m9hgtgstjTFUYIQvPjFIeMO5jprV1dHL8zpm5NwOaxX/lnXLrt
         1VmQt29aoMVKH1F9fURiIpv172oLWcmf/hiPLSL0=
Date:   Sat, 27 Nov 2021 13:13:32 +0100
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
Subject: Re: [patch 04/37] PCI/MSI: Use lock from msi_device_data
Message-ID: <YaIg7LRGAJl3+OO8@kroah.com>
References: <20211126224100.303046749@linutronix.de>
 <20211126230524.173951799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126230524.173951799@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Sat, Nov 27, 2021 at 02:20:13AM +0100, Thomas Gleixner wrote:
> Remove the register lock from struct device and use the one in
> struct msi_device_data.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/base/core.c    |    1 -
>  drivers/pci/msi/msi.c  |    2 +-
>  include/linux/device.h |    2 --
>  3 files changed, 1 insertion(+), 4 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
