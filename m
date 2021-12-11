Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145194714B3
	for <lists+dmaengine@lfdr.de>; Sat, 11 Dec 2021 17:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbhLKQWa (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Dec 2021 11:22:30 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:49419 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhLKQW3 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Dec 2021 11:22:29 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N4R4i-1mUy7G0RlO-011T56; Sat, 11 Dec 2021 17:22:28 +0100
Received: by mail-wm1-f50.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso11135796wml.1;
        Sat, 11 Dec 2021 08:22:28 -0800 (PST)
X-Gm-Message-State: AOAM532W7oAgpowdD+dMc62mggNuovwyl+A8DeVlRSDABx1a89vDZvNs
        ti9uZexhIyfLisQ7xAmo6xCbCD6Z7nTlaR/og1A=
X-Google-Smtp-Source: ABdhPJz9JqWJLeTUfS5IahRcetLl+JbMiIvXpgsv1eGAXoUb1XDPjjtJEfoNcEXB+cjjosPGuUvpUWQic5X/F+X6I8s=
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr24672882wmb.1.1639236184421;
 Sat, 11 Dec 2021 07:23:04 -0800 (PST)
MIME-Version: 1.0
References: <20211210221642.869015045@linutronix.de> <20211210221813.928842960@linutronix.de>
In-Reply-To: <20211210221813.928842960@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 11 Dec 2021 16:22:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a00M1MGPEwMQpgGJ9-g9-P6e9wo8G1frfVMqJ4bRp1Okg@mail.gmail.com>
Message-ID: <CAK8P3a00M1MGPEwMQpgGJ9-g9-P6e9wo8G1frfVMqJ4bRp1Okg@mail.gmail.com>
Subject: Re: [patch V3 12/35] soc: ti: ti_sci_inta_msi: Allocate MSI device
 data on first use
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Cedric Le Goater <clg@kaod.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:zzex+FP14ARewDiSBOGij1VMXhVq96DuU1CzMgTGwsHN9tguKjv
 T7MhQQEpIb9mlE+Hw8eqwDgf1vd4u8YePTIvxEQX5OVI5adZGSNmrHbJoK2JK+1NQtoGZTl
 QyUd9dvE4rs8x/3Shw3qc59DsDdSSI/ChRQd+0xEKHIfS+YwkHDkly2EekQDojnI9ETTohI
 pCgGAKTQNqGceqpGf7hqQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dTP/5A9xFns=:9gHfoklVBY9swp8nKHrR2k
 Z+64CGWF6HKTSdYOinoSUt8rP8R2xtGj1P+gqOkVTeagAhfjjglPkk7GdjtLsbyDuk501AZK6
 CdCjCIHV9WCgCMRva9OKxOFsfwHoMksZvq7pO6H3MC45/6VdO8SmsdpG56m+rf6TA3T4ZknaM
 33XrJr/NvXJcnRIDEuRbisRR6RR/wOahZn4AL/WKdpT88PByqFbbHiCxQxoVAI3tXZzJFKNXV
 pst4bTJYRk5svv53gyKB6P/cWPW+hubQ2Tj0QjmrRN/1g1gN1nN2Q8lcgb5Aa69NEMNoZEwDd
 HlLrS1xheB4KKTGqb1W8eCCsmPAQg8SDwoNydwmxec5XyYAMxavty75m2ahjVIVRWfUbi0Wl1
 WGu9ATdfkLNituZoh/p8O4MfPQAUcDx49uLWkJt/66W4bKrmkZPUx6kMdQeh2bGQl7cD0FP4/
 xker3oU3n1IKa4Sc1U0M+C6kFxTJiTy4ifh7ssZbPBUsGNzh1mt8KgC3XjDy6E82gLoijY7Ni
 uRRGDf2rhGQTnLeheEHrBPNNAzuT5oB2OLIrdpu6PT13+YSk+ELybjbBc2ETBdrmx+u+Hqk0n
 iS6TUJmdHv997F5dOmMTa31pFGOvLJ0UW1n+nukRnNf15H+tWfQdWVUq3yS7tguaGnCTKlTkW
 vPCuWHlyJvTlawMsGw0QZqRmCPlxK2e5kRXL6E2Tt6O2UisP0V6h4zG+YwtTkGuvzfyIoo/rY
 8QwEiUtpoN1LIJMly1ria01CnOHJBp2VJqXGHV9sopnlsL9Kslnr0gg9Gb7r/nB76oQnWuLkH
 s4rKN/A2ivtTgP89e+rqU59+oQdCSku1+esTQuPgTkbbeV+9yM=
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 10, 2021 at 11:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Allocate the MSI device data on first invocation of the allocation function.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
