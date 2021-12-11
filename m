Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A294714B0
	for <lists+dmaengine@lfdr.de>; Sat, 11 Dec 2021 17:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhLKQWK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Sat, 11 Dec 2021 11:22:10 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:52717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhLKQWJ (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Sat, 11 Dec 2021 11:22:09 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7iGi-1mReDE4Bj0-014ntP; Sat, 11 Dec 2021 17:22:07 +0100
Received: by mail-ed1-f48.google.com with SMTP id y13so38545423edd.13;
        Sat, 11 Dec 2021 08:22:06 -0800 (PST)
X-Gm-Message-State: AOAM5322t6Wp9Y1NPcbTcYZnbGwa9I2a3zOycYlQMGZrrhqpQgJHlz+S
        8+BerA7dyPOyT2dXeGWZWV5Ql+5/HsfY0Eo0yug=
X-Google-Smtp-Source: ABdhPJydOCBHCBVhL5GrxiQp2LNkO7SO9fSpEb1ktgLdLbaiYOV8bo99cpA+GLEsnha3mdPvOSWLSKg/3Dqg7U73gXw=
X-Received: by 2002:a5d:6902:: with SMTP id t2mr20632629wru.317.1639236258246;
 Sat, 11 Dec 2021 07:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20211210221642.869015045@linutronix.de> <20211210221815.269468319@linutronix.de>
In-Reply-To: <20211210221815.269468319@linutronix.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 11 Dec 2021 16:24:02 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2=LKoe1nw1sZZmxFwAh+54n-Q3cMO3goHEVMQKSVSh+g@mail.gmail.com>
Message-ID: <CAK8P3a2=LKoe1nw1sZZmxFwAh+54n-Q3cMO3goHEVMQKSVSh+g@mail.gmail.com>
Subject: Re: [patch V3 34/35] soc: ti: ti_sci_inta_msi: Get rid of ti_sci_inta_msi_get_virq()
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
        Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        xen-devel <xen-devel@lists.xenproject.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Sinan Kaya <okaya@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5HDYMdGGBKFGwHoeCalJL/QFyVy0wCSKarQw+pZK/aSbdzLFWDI
 o+wWj6lUP1i527J2RhlFwDaxJ50W4ypE08znov/ebyk6LgYZ2jlBfkEIqPkBltKcvnYkNfu
 mh1kYcLUUOyIAVKM5ALPXxn0XYPiFDoN6AgEtDMLwc+68hY0xpxZ2ymPS8eyruOCpH3W2Zz
 QkN2wT1JRHlH78H7AMXKg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:nmth5IhXhkg=:sl8XUmrDBmcduQa4r0+LFc
 rATr+0dO5UaJcojS+ibdUcJsrO1w3HsrVwD3szoUbPEjuZL0OCbemZS7X5C1ABcyvpjYk1Igs
 f8IgSLH9V0rA/BD22F6Tg9gQmEVdADfZMjqkoxTj/RlpZUU82el36OAQM2mrZuqddkyiGSHzc
 DEpRc/mtuAMAfLP8GgVUIdoflbpKOZA2uB9ewvJKlKRTLszHDXtaq4J6KAa0dOFuUUbxXcg4G
 doIPJGqvHqpAWA4KuGbsPCNqEcgXgwAJu0XUK59V6yZweGqSmCuJH7H+doPbbZeRovV7+gVxa
 DUtxX9uiil+8xgsZNmFPhGSsTa1kPPeq87yRsCjS28GpOD92+j4cMw57oNjzn+Cew3c0HYSgF
 F6kG4KnTkkRG6OxI2EBuLuztgoFMvyTuiQcZnq8ug2XJ7TciZRYHj+dSA1sDx8ia1prywFSCq
 3bCH3zUwEAtx0oIJMM7Q/unX7R9AwsSaCxATwFDm2OB6VZxCtjgrHQI8XfUk8qM4/xWVMw70u
 tDQsdYeLTlMeLZDbagg2OfmkZJSpR1CHQ7acnVct420pLmYNilVe1XEN7fiHcFxG037TxNoFk
 DgnYtXpL/m3bPLTv82VlxTksKr30BxBtrF5ZshfXi7gYGjKgVZivwSnOfEiF5ls/LJV93YHrJ
 G/M/k4vZoKak6mXSbrZhMe9LR6eEwfemf9QcOrhWt5c0gredizUxcwsFsPlAk+D7Vq7/uInSc
 2F87Uosgdi47NRma9cAGVTw6biRSNIGEwgKpASBWJYtKQZ3yHEajHW9gBDrQ55+nkZsOFFYig
 CE0FqlE8KHR1zPwlaKL/s3yYWwNTUQuLdOlLn3h8hADv5BlaSvVrHjksxSBi/4q6//F4OQd
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Fri, Dec 10, 2021 at 11:19 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Just use the core function msi_get_virq().
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@gmail.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: dmaengine@vger.kernel.org

Acked-by: Arnd Bergmann <arnd@arndb.de>
