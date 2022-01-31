Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC384A5261
	for <lists+dmaengine@lfdr.de>; Mon, 31 Jan 2022 23:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbiAaW3w (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 31 Jan 2022 17:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbiAaW3v (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 31 Jan 2022 17:29:51 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF4C061714;
        Mon, 31 Jan 2022 14:29:51 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso1184584oon.5;
        Mon, 31 Jan 2022 14:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HIrK/ll1TuZEnp2gfWjGUr6nhrl/RDbWrtbWrrFF7+Q=;
        b=FWRJLJWX37blE6SLGzHmlsU0MZaU9sC2V0CKgL2guyKi7ulFdCvCxfSgomLcISQkgy
         Ghq8SQIK4GU/McVbpX2lJ7OYShY6Lw5N7YDemT7S61dxt4UkLuWkbDmiWtLV762XImzN
         iPIwaCk0oidTkqG5YTSOx1D94ZX/cJ8UT38VexR809vDAIRCTgiUw9WdmH8i4zF4TaOY
         sjkQKwFCacqbbThjmKuhVAZ23rOdKjSaGbe/NcrwAPbrDF4+HCEGEKm+QiAzCwCa95P5
         wn42EJBxoXEh5EO4PWRYI2RctRR7vXFMjMJ7lAfqUaFIvg6vDktEasPwIfoCZezXf5fQ
         Un3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=HIrK/ll1TuZEnp2gfWjGUr6nhrl/RDbWrtbWrrFF7+Q=;
        b=LZydyWNLzjjrXekEBEDMi+1DtqWEz46mcIuliURlIbxfOFs7Gfq+X0aTLiWUqQcIMV
         l8vMOTHFYjhhvC5d+h4U176fFGeKS3uLp+nqlDuSgfsknO6wCADQnTTUaRjEoJ9BfTYK
         gDjOmJCzGinivtuzsbxA3xdm9sY+B0qaqTBjaDpWcxLuXOBgU7kxH27KkqVspEA3D5K7
         0GkzT9Y/aQoi5XLOJCzCf0zJk0asPlql3dXN/+k5LBvrjjt2Urdr6qbyhlJoIYa7cQjJ
         F5tyWKSlRQ0Bx6z43MkqWeiEnkfpRwmzmYZwdo5g+kvZTuKBsueN7XN9zXg2vHX5L9PS
         8UzA==
X-Gm-Message-State: AOAM531Q8s21KAFttdmLg9VSfBCSwn97vFquogY4f1O/88rwhyqhEONg
        POKbweP91bFBpLYhPxxG9Qg=
X-Google-Smtp-Source: ABdhPJx+o1YTpwbEBbSj59Y5iWO00V4GxVy7uT2QJWPM1Z04rC1/i4P0mk8FIqDSuUFbw+Zw9FPkQg==
X-Received: by 2002:a4a:7656:: with SMTP id w22mr11304612ooe.79.1643668190906;
        Mon, 31 Jan 2022 14:29:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4sm9441095otg.61.2022.01.31.14.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:29:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Mon, 31 Jan 2022 14:29:49 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Thomas Gleixner <tglx@linutronix.de>
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
Message-ID: <20220131222949.GA3467472@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Mon, Jan 31, 2022 at 10:16:41PM +0100, Thomas Gleixner wrote:
> Guenter,
> 
> On Mon, Jan 31 2022 at 07:21, Guenter Roeck wrote:
> > Sure. Please see http://server.roeck-us.net/qemu/x86/.
> > The logs are generated with with v5.16.4.
> 
> thanks for providing the data. It definitely helped me to leave the
> state of not seeing the wood for the trees. Fix below.
> 
> Thanks,
> 
>         tglx
> ---
> Subject: PCI/MSI: Remove bogus warning in pci_irq_get_affinity()
> From: Thomas Gleixner <tglx@linutronix.de>
> Date: Mon, 31 Jan 2022 22:02:46 +0100
> 
> The recent overhaul of pci_irq_get_affinity() introduced a regression when
> pci_irq_get_affinity() is called for an MSI-X interrupt which was not
> allocated with affinity descriptor information.
> 
> The original code just returned a NULL pointer in that case, but the rework
> added a WARN_ON() under the assumption that the corresponding WARN_ON() in
> the MSI case can be applied to MSI-X as well.
> 
> In fact the MSI warning in the original code does not make sense either
> because it's legitimate to invoke pci_irq_get_affinity() for a MSI
> interrupt which was not allocated with affinity descriptor information.
> 
> Remove it and just return NULL as the original code did.
> 
> Fixes: f48235900182 ("PCI/MSI: Simplify pci_irq_get_affinity()")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  drivers/pci/msi/msi.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -1111,7 +1111,8 @@ const struct cpumask *pci_irq_get_affini
>  	if (!desc)
>  		return cpu_possible_mask;
>  
> -	if (WARN_ON_ONCE(!desc->affinity))
> +	/* MSI[X] interrupts can be allocated without affinity descriptor */
> +	if (!desc->affinity)
>  		return NULL;
>  
>  	/*
