Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1798A1516F0
	for <lists+dmaengine@lfdr.de>; Tue,  4 Feb 2020 09:21:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgBDIVw (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 4 Feb 2020 03:21:52 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47448 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgBDIVw (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 4 Feb 2020 03:21:52 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0148LedE106347;
        Tue, 4 Feb 2020 02:21:40 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580804500;
        bh=cdRcHIYmGTk/Lxu45I64Xr0pKK1z8aQrkVi5WMDxmYY=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ff+vWcmQviCPynq90OM6xs1y0zx4ibzBOnMqqEZZxoxJabWduWTXEg1qrzqIp05I1
         CUZdXO/Xue7Iiuy8fgdzvuxPOEp2BbEm+cIwrLqUlIJa6dvQH238HfvLmBTv2HWGxF
         o5Ox7OsNXF0gdgBt+EOD0NaBgN3B5uzB1thaFRTg=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0148Lek3029462;
        Tue, 4 Feb 2020 02:21:40 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 4 Feb
 2020 02:21:40 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 4 Feb 2020 02:21:40 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0148Lbad104400;
        Tue, 4 Feb 2020 02:21:38 -0600
Subject: Re: [PATCH 0/3] dmaengine: Stear users towards
 dma_request_slave_chan()
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
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
 <b0a0e1ca-a2c4-5144-d02e-efbf04b88a6e@ti.com>
Message-ID: <eab36657-5f03-456d-79da-93bd026cda72@ti.com>
Date:   Tue, 4 Feb 2020 10:21:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <b0a0e1ca-a2c4-5144-d02e-efbf04b88a6e@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org



On 04/02/2020 10.15, Peter Ujfalusi wrote:
> Hi Geert,
> 
> On 04/02/2020 10.01, Geert Uytterhoeven wrote:
>> Hi Peter,
>>
>> On Tue, Feb 4, 2020 at 7:52 AM Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
>>> On 03/02/2020 22.34, Geert Uytterhoeven wrote:
>>>> On Mon, Feb 3, 2020 at 9:21 PM John Paul Adrian Glaubitz
>>>> <glaubitz@physik.fu-berlin.de> wrote:
>>>>> On 2/3/20 2:32 PM, Geert Uytterhoeven wrote:
>>>>>> Both rspi and sh-msiof have users on legacy SH (i.e. without DT):
>>>>>
>>>>> FWIW, there is a patch set by Yoshinori Sato to add device tree support
>>>>> for classical SuperH hardware. It was never merged, unfortunately :(.
>>>>
>>>> True.
>>>>
>>>>>> Anyone who cares for DMA on SuperH?
>>>>>
>>>>> What is DMA used for on SuperH? Wouldn't dropping it cut support for
>>>>> essential hardware features?
>>>>
>>>> It may make a few things slower.
>>>
>>> I would not drop DMA support but I would suggest to add dma_slave_map
>>> for non DT boot so the _compat() can be dropped.
>>
>> Which is similar in spirit to gpiod_lookup and clk_register_clkdev(),
>> right?
> 
> Yes, it is similar:
> 
> /* OMAP730, OMAP850 */
> static const struct dma_slave_map omap7xx_sdma_map[] = {
> 	{ "omap-mcbsp.1", "tx", SDMA_FILTER_PARAM(8) },
> 	{ "omap-mcbsp.1", "rx", SDMA_FILTER_PARAM(9) },
> 	{ "omap-mcbsp.2", "tx", SDMA_FILTER_PARAM(10) },
> 	{ "omap-mcbsp.2", "rx", SDMA_FILTER_PARAM(11) },
> 	{ "mmci-omap.0", "tx", SDMA_FILTER_PARAM(21) },
> 	{ "mmci-omap.0", "rx", SDMA_FILTER_PARAM(22) },
> 	{ "omap_udc", "rx0", SDMA_FILTER_PARAM(26) },
> 	{ "omap_udc", "rx1", SDMA_FILTER_PARAM(27) },
> 	{ "omap_udc", "rx2", SDMA_FILTER_PARAM(28) },
> 	{ "omap_udc", "tx0", SDMA_FILTER_PARAM(29) },
> 	{ "omap_udc", "tx1", SDMA_FILTER_PARAM(30) },
> 	{ "omap_udc", "tx2", SDMA_FILTER_PARAM(31) },
> };
> 
> "device name", "channel name", "parameter for filter"

fwiw for EDMA on daVinci we have these (for da850):
static const struct dma_slave_map da850_edma0_map[] = {
	{ "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
	{ "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
	{ "davinci-mcbsp.0", "rx", EDMA_FILTER_PARAM(0, 2) },
	{ "davinci-mcbsp.0", "tx", EDMA_FILTER_PARAM(0, 3) },
	{ "davinci-mcbsp.1", "rx", EDMA_FILTER_PARAM(0, 4) },
	{ "davinci-mcbsp.1", "tx", EDMA_FILTER_PARAM(0, 5) },
	{ "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
	{ "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
	{ "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
	{ "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
	{ "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
	{ "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
};

static const struct dma_slave_map da850_edma1_map[] = {
	{ "da830-mmc.1", "rx", EDMA_FILTER_PARAM(1, 28) },
	{ "da830-mmc.1", "tx", EDMA_FILTER_PARAM(1, 29) },
};

and in the DMA driver:
	ecc->dma_slave.filter.map = info->slave_map;
	ecc->dma_slave.filter.mapcnt = info->slavecnt;
	ecc->dma_slave.filter.fn = edma_filter_fn;

When I added the dma_slave_map support it was done in a way that it
could be used by anyone having the same issue as we were facing with
legacy daVinci and OMAP1 boards (no DT support in sight).

Drivers do not need to care about legacy/DT boot.

> 
> The in the DMA driver (omap-dma.c):
> 	od->ddev.filter.map = od->plat->slave_map;
> 	od->ddev.filter.mapcnt = od->plat->slavecnt;
> 	od->ddev.filter.fn = omap_dma_filter_fn;
> 
> When things are converted the filter function no longer needs to be
> exported, it is local to the DMA driver.
> 
>>
>>> Imho on lower spec SoC (and I believe SuperH is) the DMA makes big
>>> difference offloading data movement from the CPU.
>>
>> Assumed it is actually used...
> 
> Right, imho (again) we should not decide if given SoC needs it or not.
> It is up to the drivers to use it or not, but with the dma_slave_map
> there is no difference between DT or legacy boot handling towards DMA.
> 
>> Gr{oetje,eeting}s,
>>
>>                         Geert
>>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
