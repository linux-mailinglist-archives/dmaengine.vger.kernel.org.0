Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB8A1516E1
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 09:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgBDIPx (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 03:15:53 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51380 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgBDIPw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 03:15:52 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0148Fecf050733;
        Tue, 4 Feb 2020 02:15:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580804140;
        bh=3SnPYnNot4VX/dHttLLvQW7rGKtohAoR8aTexJCrYWc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=W5/HMG+YiSZ4dsSi+9KqonrC4Zw4YdP7goyTm7wfWnadcmCHQhFbRUCzIl14fX0aJ
         p+7suvnnW+Ty5Rw1Cj1uyPtUTT2VBgUcJMgKtUAmS9i/08N2/UOoFdv/NSGi8bDbkA
         /wRqdVg+hC5z8HVx3zs/N9cvQLVUyyBeDZRLOxFg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0148Fe3g096338
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Feb 2020 02:15:40 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 02:15:39 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 02:15:39 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0148FaZ0078304;
        Tue, 4 Feb 2020 02:15:38 -0600
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        dmaengine <dmaengine@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <20200203101806.2441-1-peter.ujfalusi@ti.com>
 <CAHp75Vf__isc59YBS9=O+9ApSV62XuZ2nBAWKKD_K7i72P-yFg@mail.gmail.com>
 <e47927aa-8d40-aa71-aef4-5f9c4cbbc03a@ti.com>
 <CAHp75Vd1A+8N_RPq3oeoXS19XeFtv7YK69H5XfzLMxWyCHbzBQ@mail.gmail.com>
 <701ab186-c240-3c37-2c0b-8ac195f8073f@ti.com>
 <CAMuHMdUYRvjR5qe5RVzggN+BaHw8ObEtnm8Kdn25XUiv2sJpPg@mail.gmail.com>
 <38f686ae-66fa-0e3a-ec2e-a09fc4054ac4@physik.fu-berlin.de>
 <CAMuHMdXahPt4q7Dd-mQ9RNr7JiCt8PhXeT5U2D+n-ngJmEQMgw@mail.gmail.com>
 <b09ad222-f5b8-af5a-6c2b-2dd6b30f1c73@ti.com>
 <CAMuHMdUYcSPoK8NOSdMzU_Jtg84aPMNKeGnacnF7=aidV4eqvw@mail.gmail.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <b0a0e1ca-a2c4-5144-d02e-efbf04b88a6e@ti.com>
Date:   Tue, 4 Feb 2020 10:15:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUYcSPoK8NOSdMzU_Jtg84aPMNKeGnacnF7=aidV4eqvw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Hi Geert,

On 04/02/2020 10.01, Geert Uytterhoeven wrote:
> Hi Peter,
> 
> On Tue, Feb 4, 2020 at 7:52 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>> On 03/02/2020 22.34, Geert Uytterhoeven wrote:
>>> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>>>
>>>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>>>> for classical SuperH hardware. It was never merged, unfortunately :(.
>>>
>>> True.
>>>
>>>>> Anyone who cares for DMA on SuperH?
>>>>
>>>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>>>> essential hardware features?
>>>
>>> It may make a few things slower.
>>
>> I would not drop DMA support but I would suggest to add dma_slave_map
>> for non DT boot so the _compat() can be dropped.
> 
> Which is similar in spirit to gpiod_lookup and clk_register_clkdev(),
> right?

Yes, it is similar:

/* OMAP730, OMAP850 */
static const struct dma_slave_map omap7xx_sdma_map[] = {
	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(8) },
	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(9) },
	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(10) },
	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(11) },
	{ "mmci-omap.0", "tx", SDMA_FILTER_PARAM(21) },
	{ "mmci-omap.0", "rx", SDMA_FILTER_PARAM(22) },
	{ "omap_udc", "rx0", SDMA_FILTER_PARAM(26) },
	{ "omap_udc", "rx1", SDMA_FILTER_PARAM(27) },
	{ "omap_udc", "rx2", SDMA_FILTER_PARAM(28) },
	{ "omap_udc", "tx0", SDMA_FILTER_PARAM(29) },
	{ "omap_udc", "tx1", SDMA_FILTER_PARAM(30) },
	{ "omap_udc", "tx2", SDMA_FILTER_PARAM(31) },
};

"device name", "channel name", "parameter for filter"

The in the DMA driver (omap-dma.c):
	od->ddev.filter.map = od->plat->slave_map;
	od->ddev.filter.mapcnt = od->plat->slavecnt;
	od->ddev.filter.fn = omap_dma_filter_fn;

When things are converted the filter function no longer needs to be
exported, it is local to the DMA driver.

> 
>> Imho on lower spec SoC (and I believe SuperH is) the DMA makes big
>> difference offloading data movement from the CPU.
> 
> Assumed it is actually used...

Right, imho (again) we should not decide if given SoC needs it or not.
It is up to the drivers to use it or not, but with the dma_slave_map
there is no difference between DT or legacy boot handling towards DMA.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
