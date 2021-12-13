Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8F472042
	for <lists+dmaengine@lfdr.de>; Mon, 13 Dec 2021 06:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbhLMFOe (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 13 Dec 2021 00:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbhLMFOd (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 13 Dec 2021 00:14:33 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928B2C06173F;
        Sun, 12 Dec 2021 21:14:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 500C7CE0DC7;
        Mon, 13 Dec 2021 05:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F64C00446;
        Mon, 13 Dec 2021 05:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639372469;
        bh=m+MbzkCsPCJNXsBFySexaUdkbI+fIAKWZPiq+A6GBck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pcDQjwCHOz6BSONU5joUW6e60Mu1jAbxQzts0EfFaFm5JmSfwPYHyrXe+as4aLjeM
         eFJH1OLum6J0MwbxxotL5Ynx/Wl9FSzFLuVcZ/MiaFGyolmZeXYP0aRrzCZjW5ZdJq
         Yt5fu6OtnruTRf7YSvoSO+XnwngnSyHnpkVidlaQ4C6iMZ9tlspBmToBaYm7+u5kTp
         56ZJujbc1BVH7oROt6l/x3asZi1J9mKWjGd5xEZzFFEQ0GglJh+ze5/cFl0ltz5OnT
         HkJi0GnpAKgWw3QDQFyUKxAUiibgYJ1iBPJwPobSVKG5xk0d9X3x2zWgArHsKu4K1+
         TCjLAS6Yk203w==
Date:   Mon, 13 Dec 2021 10:44:25 +0530
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
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [patch V3 29/35] dmaengine: mv_xor_v2: Get rid of msi_desc abuse
Message-ID: <YbbWsUO6o5ccU5ai@matsya>
References: <20211210221642.869015045@linutronix.de>
 <20211210221814.970099984@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210221814.970099984@linutronix.de>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On 10-12-21, 23:19, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Storing a pointer to the MSI descriptor just to keep track of the Linux
> interrupt number is daft. Use msi_get_virq() instead.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
