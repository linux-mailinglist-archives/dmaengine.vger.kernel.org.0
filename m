Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDBC21B15D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2020 10:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgGJIbP (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 10 Jul 2020 04:31:15 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57176 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgGJIbO (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Fri, 10 Jul 2020 04:31:14 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06A8Uj5W051326;
        Fri, 10 Jul 2020 03:30:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594369845;
        bh=aASjBaynNGHy9YdF4r1xWy8RE/lfoom+1VXoKmsjynU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=rY863hSGr3T9f1kgsDiKQ375WtTBh+aeC0eOEp9Mj04P/Yxa3nZxHgELd350a8TRY
         19EGMjWn0sDwHciPLMQCmesYJL5qDGdBJ2sFsrOi4+/1LXa+xHPZMW+BKQWcLZIDJb
         HvHodxqEc/KRu/7jR14UpQtxR5AHnUnLNZgVliNI=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06A8Uj5O067706
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 10 Jul 2020 03:30:45 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 10
 Jul 2020 03:30:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 10 Jul 2020 03:30:45 -0500
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06A8UgXj109862;
        Fri, 10 Jul 2020 03:30:42 -0500
Subject: Re: [PATCH v7 04/11] dmaengine: Introduce max SG list entries
 capability
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200709224550.15539-1-Sergey.Semin@baikalelectronics.ru>
 <20200709224550.15539-5-Sergey.Semin@baikalelectronics.ru>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
X-Pep-Version: 2.0
Message-ID: <d667adda-6576-623d-6976-30f60ab3c3dc@ti.com>
Date:   Fri, 10 Jul 2020 11:31:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200709224550.15539-5-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 10/07/2020 1.45, Serge Semin wrote:
> Some devices may lack the support of the hardware accelerated SG list
> entries automatic walking through and execution. In this case a burden =
of
> the SG list traversal and DMA engine re-initialization lies on the
> DMA engine driver (normally implemented by using a DMA transfer complet=
ion
> IRQ to recharge the DMA device with a next SG list entry). But such
> solution may not be suitable for some DMA consumers. In particular SPI
> devices need both Tx and Rx DMA channels work synchronously in order
> to avoid the Rx FIFO overflow. In case if Rx DMA channel is paused for
> some time while the Tx DMA channel works implicitly pulling data into t=
he
> Rx FIFO, the later will be eventually overflown, which will cause the d=
ata
> loss. So if SG list entries aren't automatically fetched by the DMA
> engine, but are one-by-one manually selected for execution in the
> ISRs/deferred work/etc., such problem will eventually happen due to the=

> non-deterministic latencies of the service execution.

It is not really the number of sg nents which is the problem, but the
combination of total number of bytes _and_ the number of nents used to
map them.
Obviously the TX and RX number of bytes must match in duplex case and at
the same time neither nents should be over the number of SGs the DMA
device can handle without interruption (linking, chaining, or whatever
means).

The EDMA from TI have similar limitation (we set the limit to 20 nents).
Longer lists will be broken up to maximum of 20 segment transfers.
This setup has bigger impact on audio (cyclic) as we need to limit the
number of periods to not exceed this limit of 20.

The sDMA on the other hand has different limits. Earlier versions
without linking support can execute one SG chunk at the time and needs
to reconfigure for the next one -> max_sg_nents is 1 for the older sDMAs.=
=2E.

> In order to let the DMA consumer know about the DMA device capabilities=

> regarding the hardware accelerated SG list traversal we introduce the
> max_sg_list capability. It is supposed to be initialized by the DMA eng=
ine
> driver with 0 if there is no limitation for the number of SG entries
> atomically executed and with non-zero value if there is such constraint=
s,
> so the upper limit is determined by the number set to the property.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: linux-mips@vger.kernel.org
> Cc: devicetree@vger.kernel.org
>=20
> ---
>=20
> Changelog v3:
> - This is a new patch created as a result of the discussion with Vinud =
and
>   Andy in the framework of DW DMA burst and LLP capabilities.
>=20
> Changelog v4:
> - Fix of->if typo. It should be definitely of.
> ---
>  drivers/dma/dmaengine.c   | 1 +
>  include/linux/dmaengine.h | 8 ++++++++
>  2 files changed, 9 insertions(+)
>=20
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index b332ffe52780..ad56ad58932c 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -592,6 +592,7 @@ int dma_get_slave_caps(struct dma_chan *chan, struc=
t dma_slave_caps *caps)
>  	caps->directions =3D device->directions;
>  	caps->min_burst =3D device->min_burst;
>  	caps->max_burst =3D device->max_burst;
> +	caps->max_sg_nents =3D device->max_sg_nents;
>  	caps->residue_granularity =3D device->residue_granularity;
>  	caps->descriptor_reuse =3D device->descriptor_reuse;
>  	caps->cmd_pause =3D !!device->device_pause;
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index 0c7403b27133..a7e4d8dfdd19 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -467,6 +467,9 @@ enum dma_residue_granularity {
>   *	should be checked by controller as well
>   * @min_burst: min burst capability per-transfer
>   * @max_burst: max burst capability per-transfer
> + * @max_sg_nents: max number of SG list entries executed in a single a=
tomic
> + *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
> + *	value means unlimited number of entries.

Without looking at the comment the name max_sg_nents implies that the
DMA can not handle longer lists, but it is not really true.
max_sg_nents_burst might be a bit cleaner for the first look?

>   * @cmd_pause: true, if pause is supported (i.e. for reading residue o=
r
>   *	       for resume later)
>   * @cmd_resume: true, if resume is supported
> @@ -481,6 +484,7 @@ struct dma_slave_caps {
>  	u32 directions;
>  	u32 min_burst;
>  	u32 max_burst;
> +	u32 max_sg_nents;
>  	bool cmd_pause;
>  	bool cmd_resume;
>  	bool cmd_terminate;
> @@ -773,6 +777,9 @@ struct dma_filter {
>   *	should be checked by controller as well
>   * @min_burst: min burst capability per-transfer
>   * @max_burst: max burst capability per-transfer
> + * @max_sg_nents: max number of SG list entries executed in a single a=
tomic
> + *	DMA tansaction with no intermediate IRQ for reinitialization. Zero
> + *	value means unlimited number of entries.
>   * @residue_granularity: granularity of the transfer residue reported
>   *	by tx_status
>   * @device_alloc_chan_resources: allocate resources and return the
> @@ -844,6 +851,7 @@ struct dma_device {
>  	u32 directions;
>  	u32 min_burst;
>  	u32 max_burst;
> +	u32 max_sg_nents;
>  	bool descriptor_reuse;
>  	enum dma_residue_granularity residue_granularity;
> =20
>=20

- P=C3=A9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

