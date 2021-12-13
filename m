Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B57B47204C
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhLMFPN (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhLMFPN (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:15:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE69FC06173F;
        Sun, 12 Dec 2021 21:15:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 27051CE0DE5;
        Mon, 13 Dec 2021 05:15:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EBFC341C5;
        Mon, 13 Dec 2021 05:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639372509;
        bh=twArdFoN7hptxwDxuCRLPZ8D1bdEpmpF3bPhs8kTAGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l5Fm5uAniw55hjSdbzftitrFAWWz32Vx3VgWE+btKlO63m2/tFA3/bv1QYeZIG+LW
         vUJdax7Yw6F/Ajk03jA6N9MxJNQFQPNdccFHfKQ4s7/7I4jY8J0ztiEoz3lwDMSrMj
         Au+niCjhEXCCZiWnPCwZ+FSb9gwqJGQ9s4QAZQG78Tdq3X5hjrvbvRvVE9t2b/uMjy
         2j0lKrOYwiYfKHJYq9myUv2AWh/KF9zOY6r3L9C4J/YMy2cBf6e8SdfVI0w4eYZVFM
         ZP39KPOOIDsA+jVKZbJqEWZD1EDrG6T2dKX4uRjCOz2n42IAMyNd4ZGry200oP740A
         5/0yla012xpJQ==
Date:   Mon, 13 Dec 2021 10:45:05 +0530
From:   Vinod Koul <vkoul@kernel.org>
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
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        dmaengine@vger.kernel.org, Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org, Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V3 34/35] soc: ti: ti_sci_inta_msi: Get rid of
 ti_sci_inta_msi_get_virq()
Message-ID: <YbbW2Ui22OeohXKE@matsya>
References: <20211210221642.869015045@linutronix.de>
 <20211210221815.269468319@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210221815.269468319@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-12-21, 23:19, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Just use the core function msi_get_virq().

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
