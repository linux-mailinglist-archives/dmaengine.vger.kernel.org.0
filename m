Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22795BD4C0
	for <lists+dmaengine@lfdr.de>; Tue, 24 Sep 2019 23:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404533AbfIXV7e (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 24 Sep 2019 17:59:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387723AbfIXV7d (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 24 Sep 2019 17:59:33 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6156D217D7;
        Tue, 24 Sep 2019 21:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569362372;
        bh=7EnBQLGJXbJ0krx6sf9eAXMt0SpVcFYHvJ4Ffxc+GEI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZUjBfJ5y+ysHUqZVHvVQV6vmXEF5m5l7X/D3o8MMo6T+fnXCBe1Len91UdIVSmNm8
         1+IgmCK2yWkyLXKdLfON0wTF2uVY6/Zj+z4CbqBQ8S1mTFhTzxJ4K+kIhlIbeitlp5
         qXtcO6SJzhSJ74/8s14mN0YBxYms1LJJP0SwTimA=
Received: by mail-qt1-f179.google.com with SMTP id x4so4100980qtq.8;
        Tue, 24 Sep 2019 14:59:32 -0700 (PDT)
X-Gm-Message-State: APjAAAUSipfNLAs0r3iY98Oq51rlrlAyRzY6XaLme2e9ZLFqmU4bXOcs
        y3XFqQogK86HIUelflV99P3yYhl0p6JxbjmCsw==
X-Google-Smtp-Source: APXvYqxu7lx2ORNXYuD01RyoAdK8YY//zQYn3oJnMVZaPVMMDgXcioCqkbUXveNdRfpBkQzN/4OY/SjTncH5t1k8eUk=
X-Received: by 2002:ac8:6982:: with SMTP id o2mr5274643qtq.143.1569362371529;
 Tue, 24 Sep 2019 14:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190924181244.7159-1-nsaenzjulienne@suse.de>
In-Reply-To: <20190924181244.7159-1-nsaenzjulienne@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 24 Sep 2019 16:59:20 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+v+svTyna7UzQdRVqfNc5Z_bgWzxNRXv7-Wqv3NwDu2g@mail.gmail.com>
Message-ID: <CAL_Jsq+v+svTyna7UzQdRVqfNc5Z_bgWzxNRXv7-Wqv3NwDu2g@mail.gmail.com>
Subject: Re: [PATCH 00/11] of: Fix DMA configuration for non-DT masters
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" 
        <dmaengine@vger.kernel.org>, etnaviv@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        xen-devel@lists.xenproject.org, linux-tegra@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-pci@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        james.quinlan@broadcom.com, Stefan Wahren <wahrenst@gmx.net>,
        Dan Williams <dan.j.williams@intel.com>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Sep 24, 2019 at 1:12 PM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi All,
> this series tries to address one of the issues blocking us from
> upstreaming Broadcom's STB PCIe controller[1]. Namely, the fact that
> devices not represented in DT which sit behind a PCI bus fail to get the
> bus' DMA addressing constraints.
>
> This is due to the fact that of_dma_configure() assumes it's receiving a
> DT node representing the device being configured, as opposed to the PCIe
> bridge node we currently pass. This causes the code to directly jump
> into PCI's parent node when checking for 'dma-ranges' and misses
> whatever was set there.
>
> To address this I create a new API in OF - inspired from Robin Murphys
> original proposal[2] - which accepts a bus DT node as it's input in
> order to configure a device's DMA constraints. The changes go deep into
> of/address.c's implementation, as a device being having a DT node
> assumption was pretty strong.
>
> On top of this work, I also cleaned up of_dma_configure() removing its
> redundant arguments and creating an alternative function for the special cases
> not applicable to either the above case or the default usage.
>
> IMO the resulting functions are more explicit. They will probably
> surface some hacky usages that can be properly fixed as I show with the
> DT fixes on the Layerscape platform.
>
> This was also tested on a Raspberry Pi 4 with a custom PCIe driver and
> on a Seattle AMD board.

Humm, I've been working on this issue too. Looks similar though yours
has a lot more churn and there's some other bugs I've found.

Can you test out this branch[1]. I don't have any h/w needing this,
but wrote a unittest and tested with modified QEMU.

Rob

[1] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git dma-masks
