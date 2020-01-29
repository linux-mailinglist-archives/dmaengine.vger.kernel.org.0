Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 179C414C8DD
	for <lists+dmaengine@lfdr.de>; Wed, 29 Jan 2020 11:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgA2KmU (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 29 Jan 2020 05:42:20 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16132 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgA2KmU (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 29 Jan 2020 05:42:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e31617d0000>; Wed, 29 Jan 2020 02:42:05 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 29 Jan 2020 02:42:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 29 Jan 2020 02:42:19 -0800
Received: from [10.21.133.51] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 10:42:17 +0000
Subject: Re: [PATCH v4 01/14] dmaengine: tegra-apb: Fix use-after-free
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200112173006.29863-1-digetx@gmail.com>
 <20200112173006.29863-2-digetx@gmail.com>
 <4c1b9e48-5468-0c03-2108-158ee814eea8@nvidia.com>
 <1327bb21-0364-da26-e6ed-ff6c19df03e6@gmail.com>
 <e39ef31d-4cff-838a-0fc1-73a39a8d6120@nvidia.com>
 <b0c85ca7-d8ac-5f9d-2c57-79543c1f9b5d@gmail.com>
 <5bbe9e3e-a64f-53be-e7f6-63e36cbae77d@nvidia.com>
 <be7addff-9f5c-e40a-923f-db895ce89fa2@gmail.com>
 <9ca67d17-3bb0-abb4-9d95-1057d0828ed2@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <7c1c0672-4e6d-ae49-d041-2838199f0fcd@nvidia.com>
Date:   Wed, 29 Jan 2020 10:42:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <9ca67d17-3bb0-abb4-9d95-1057d0828ed2@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580294525; bh=wjynjpVyGxlBTl7eVUVMSSvHGxWVDUtEVYlNZPNB5Yo=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SM3+JTVIGImmEmzhMh8zDa/K2oYqNjh2xSdanDqxobHqTOoFsnrv+VbF3vnG9CBbu
         mC8FANu1TRHpAungtGRUjM9rkCkPS7HLA3UvB9sqWhDzkljx5n6KHP0cgrWE+FFERP
         xB+wUWdRnXdbutaE2esCrUVadh25sCMdY7cPi/rpPIrIRBT2OwVClCDr+Ay2jYxNS4
         fnDFZdTV8UExYoiF3hJtkbR7U7quB6AUG7KwZ9wd1tLj8Vjn+f7Aju4clsa6Wfn1qs
         Eyufc1ZMxzP3S76UKLEBw5BDfU4Yok7d9h1PpQMXe2rpE7w3a2jpk9+jKvCE98ouqP
         0GsmaZq43LYSQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 29/01/2020 00:12, Dmitry Osipenko wrote:
> 28.01.2020 17:51, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>> 28.01.2020 17:02, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>
>>> On 16/01/2020 20:10, Dmitry Osipenko wrote:
>>>> 15.01.2020 12:00, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>
>>>>> On 14/01/2020 20:33, Dmitry Osipenko wrote:
>>>>>> 14.01.2020 18:09, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>>>>>>
>>>>>>> On 12/01/2020 17:29, Dmitry Osipenko wrote:
>>>>>>>> I was doing some experiments with I2C and noticed that Tegra APB D=
MA
>>>>>>>> driver crashes sometime after I2C DMA transfer termination. The cr=
ash
>>>>>>>> happens because tegra_dma_terminate_all() bails out immediately if=
 pending
>>>>>>>> list is empty, thus it doesn't release the half-completed descript=
ors
>>>>>>>> which are getting re-used before ISR tasklet kicks-in.
>>>>>>>
>>>>>>> Can you elaborate a bit more on how these are getting re-used? What=
 is
>>>>>>> the sequence of events which results in the panic? I believe that t=
his
>>>>>>> was also reported in the past [0] and so I don't doubt there is an =
issue
>>>>>>> here, but would like to completely understand this.
>>>>>>>
>>>>>>> Thanks!
>>>>>>> Jon
>>>>>>>
>>>>>>> [0] https://lore.kernel.org/patchwork/patch/675349/
>>>>>>>
>>>>>>
>>>>>> In my case it happens in the touchscreen driver during of the
>>>>>> touchscreen's interrupt handling (in a threaded IRQ handler) + CPU i=
s
>>>>>> under load and there is other interrupts activity. So what happens h=
ere
>>>>>> is that the TS driver issues one I2C transfer, which fails with
>>>>>> (apparently bogus) timeout (because DMA descriptor is completed and
>>>>>> removed from the pending list, but tasklet not executed yet), and th=
en
>>>>>> TS immediately issues another I2C transfer that re-uses the
>>>>>> yet-incompleted descriptor. That's my understanding.
>>>>>
>>>>> OK, but what is the exact sequence that it allowing it to re-use the
>>>>> incompleted descriptor?
>>>>
>>>>    TDMA driver                      DMA Client
>>>>
>>>> 1.
>>>>                                     dmaengine_prep()
>>>>
>>>> 2.
>>>>    tegra_dma_desc_get()
>>>>    dma_desc =3D kzalloc()
>>>>    ...
>>>>    tegra_dma_prep_slave_sg()
>>>>    INIT_LIST_HEAD(&dma_desc->tx_list);
>>>>    INIT_LIST_HEAD(&dma_desc->cb_node);
>>>>    list_add_tail(sgreq->node,
>>>>                  dma_desc->tx_list)
>>>>
>>>> 3.
>>>>                                     dma_async_issue_pending()
>>>>
>>>> 4.
>>>>    tegra_dma_tx_submit()
>>>>    list_splice_tail_init(dma_desc->tx_list,
>>>>                          tdc->pending_sg_req)
>>>>
>>>> 5.
>>>>    tegra_dma_isr()
>>>>    ...
>>>>    handle_once_dma_done()
>>>>    ...
>>>>    sgreq =3D list_first_entry(tdc->pending_sg_req)
>>>>    list_del(sgreq->node);
>>>>    ...
>>>>    list_add_tail(dma_desc->cb_node,
>>>>                  tdc->cb_desc);
>>>>    list_add_tail(dma_desc->node,
>>>>                  tdc->free_dma_desc);
>>>
>>> Isn't this the problem here, that we have placed this on the free list
>>> before we are actually done?
>>>
>>> It seems to me that there could still be a potential race condition
>>> between the ISR and the tasklet running.
>>
>> Yes, this should be addressed by the patch #3 "dmaengine: tegra-apb:
>> Prevent race conditions of tasklet vs free list".
>=20
> correction (to avoid confusion): it's actually patch #5, my bad

Ah OK great! Could be worth making that patch #1 or #2 in the series as
theses are somewhat related.

Cheers
Jon

--=20
nvpublic
