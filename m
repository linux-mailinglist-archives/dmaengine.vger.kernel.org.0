Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8600814E256
	for <lists+dmaengine@lfdr.de>; Thu, 30 Jan 2020 19:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgA3Sv2 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Thu, 30 Jan 2020 13:51:28 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:10195 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730952AbgA3SpL (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Thu, 30 Jan 2020 13:45:11 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3324010000>; Thu, 30 Jan 2020 10:44:17 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 30 Jan 2020 10:45:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 30 Jan 2020 10:45:09 -0800
Received: from [10.26.11.91] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 30 Jan
 2020 18:45:06 +0000
Subject: Re: [PATCH v6 11/16] dmaengine: tegra-apb: Keep clock enabled only
 during of DMA transfer
To:     Dmitry Osipenko <digetx@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
CC:     <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200130043804.32243-1-digetx@gmail.com>
 <20200130043804.32243-12-digetx@gmail.com>
 <2442aee7-2c2a-bacc-7be9-8eed17498928@nvidia.com>
 <0c766352-700a-68bf-cf7b-9b1686ba9ca9@gmail.com>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <e72d00ee-abee-9ae2-4654-da77420b440e@nvidia.com>
Date:   Thu, 30 Jan 2020 18:45:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <0c766352-700a-68bf-cf7b-9b1686ba9ca9@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580409857; bh=NTNk64HjtDFZrHfyhVZ3O6MmE7stxmOe9qj355qyAZs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SHkpSFkR6sv74qAeAywct2+4iC/uJlc9jxd/uwdaVcFSwkneaceYqIQWLYPexSzKx
         JnobA1Sdoh3R5lCydTZxXy5seCOXooSLmABO+Tm0wRLvgCTlrh4rptoGvR/16hUFXT
         9EiVQNL9DlYJDgLqoJtLDTwCbTOzIEOTaLbPukJBgdP1mdNG4/xypo+2gAY1ZOyyje
         KBxpldFddenf7rQlUMBnw2vGE0nRzgkF6XQm+FRc6GqC8+BeimCDsiN0Di54iQwzcg
         Gj1/l/nM5jDGN43NGdVFgiX0Wk92CILUpx3KZ6QD3xyviWtQdn+Nohj6Yeuo1/jNb1
         Kttu3uywAZjZQ==
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org


On 30/01/2020 16:11, Dmitry Osipenko wrote:
> 30.01.2020 17:09, Jon Hunter =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>>
>> On 30/01/2020 04:37, Dmitry Osipenko wrote:
>>> It's a bit impractical to enable hardware's clock at the time of DMA
>>> channel's allocation because most of DMA client drivers allocate DMA
>>> channel at the time of the driver's probing, and thus, DMA clock is kep=
t
>>> always-enabled in practice, defeating the whole purpose of runtime PM.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/dma/tegra20-apb-dma.c | 47 ++++++++++++++++++++++++-----------
>>>  1 file changed, 32 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dm=
a.c
>>> index 22b88ccff05d..0ee28d8e3c96 100644
>>> --- a/drivers/dma/tegra20-apb-dma.c
>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>> @@ -436,6 +436,8 @@ static void tegra_dma_stop(struct tegra_dma_channel=
 *tdc)
>>>  		tdc_write(tdc, TEGRA_APBDMA_CHAN_STATUS, status);
>>>  	}
>>>  	tdc->busy =3D false;
>>> +
>>> +	pm_runtime_put(tdc->tdma->dev);
>>>  }
>>> =20
>>>  static void tegra_dma_start(struct tegra_dma_channel *tdc,
>>> @@ -500,18 +502,25 @@ static void tegra_dma_configure_for_next(struct t=
egra_dma_channel *tdc,
>>>  	tegra_dma_resume(tdc);
>>>  }
>>> =20
>>> -static void tdc_start_head_req(struct tegra_dma_channel *tdc)
>>> +static bool tdc_start_head_req(struct tegra_dma_channel *tdc)
>>>  {
>>>  	struct tegra_dma_sg_req *sg_req;
>>> +	int err;
>>> =20
>>>  	if (list_empty(&tdc->pending_sg_req))
>>> -		return;
>>> +		return false;
>>> +
>>> +	err =3D pm_runtime_get_sync(tdc->tdma->dev);
>>> +	if (WARN_ON_ONCE(err < 0))
>>> +		return false;
>>> =20
>>>  	sg_req =3D list_first_entry(&tdc->pending_sg_req, typeof(*sg_req), no=
de);
>>>  	tegra_dma_start(tdc, sg_req);
>>>  	sg_req->configured =3D true;
>>>  	sg_req->words_xferred =3D 0;
>>>  	tdc->busy =3D true;
>>> +
>>> +	return true;
>>>  }
>>> =20
>>>  static void tdc_configure_next_head_desc(struct tegra_dma_channel *tdc=
)
>>> @@ -615,6 +624,8 @@ static void handle_once_dma_done(struct tegra_dma_c=
hannel *tdc,
>>>  	}
>>>  	list_add_tail(&sgreq->node, &tdc->free_sg_req);
>>> =20
>>> +	pm_runtime_put(tdc->tdma->dev);
>>> +
>>>  	/* Do not start DMA if it is going to be terminate */
>>>  	if (to_terminate || list_empty(&tdc->pending_sg_req))
>>>  		return;
>>> @@ -730,9 +741,7 @@ static void tegra_dma_issue_pending(struct dma_chan=
 *dc)
>>>  		dev_err(tdc2dev(tdc), "No DMA request\n");
>>>  		goto end;
>>>  	}
>>> -	if (!tdc->busy) {
>>> -		tdc_start_head_req(tdc);
>>> -
>>> +	if (!tdc->busy && tdc_start_head_req(tdc)) {
>>>  		/* Continuous single mode: Configure next req */
>>>  		if (tdc->cyclic) {
>>>  			/*
>>> @@ -775,6 +784,13 @@ static int tegra_dma_terminate_all(struct dma_chan=
 *dc)
>>>  	else
>>>  		wcount =3D status;
>>> =20
>>> +	/*
>>> +	 * tegra_dma_stop() will drop the RPM's usage refcount, but
>>> +	 * tegra_dma_resume() touches hardware and thus we should keep
>>> +	 * the DMA clock active while it's needed.
>>> +	 */
>>> +	pm_runtime_get(tdc->tdma->dev);
>>> +
>>
>> Would it work and make it simpler to just enable in the issue_pending
>> and disable in the handle_once_dma_done or terminate_all?
>>
>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma=
.c
>> index 3a45079d11ec..86bbb45da93d 100644
>> --- a/drivers/dma/tegra20-apb-dma.c
>> +++ b/drivers/dma/tegra20-apb-dma.c
>> @@ -616,9 +616,14 @@ static void handle_once_dma_done(struct
>> tegra_dma_channel *tdc,
>>         list_add_tail(&sgreq->node, &tdc->free_sg_req);
>>
>>         /* Do not start DMA if it is going to be terminate */
>> -       if (to_terminate || list_empty(&tdc->pending_sg_req))
>> +       if (to_terminate)
>>                 return;
>>
>> +       if (list_empty(&tdc->pending_sg_req)) {
>> +               pm_runtime_put(tdc->tdma->dev);
>> +               return;
>> +       }
>> +
>>         tdc_start_head_req(tdc);
>>  }
>>
>> @@ -729,6 +734,11 @@ static void tegra_dma_issue_pending(struct dma_chan
>> *dc)
>>                 goto end;
>>         }
>>         if (!tdc->busy) {
>> +               if (pm_runtime_get_sync(tdc->tdma->dev) < 0) {
>> +                       dev_err(tdc2dev(tdc), "Failed to enable DMA!\n")=
;
>> +                       goto end;
>> +               }
>> +
>>                 tdc_start_head_req(tdc);
>>
>>                 /* Continuous single mode: Configure next req */
>> @@ -788,6 +798,7 @@ static int tegra_dma_terminate_all(struct dma_chan *=
dc)
>>                                 get_current_xferred_count(tdc, sgreq,
>> wcount);
>>         }
>>         tegra_dma_resume(tdc);
>> +       pm_runtime_put(tdc->tdma->dev);
>>
>>  skip_dma_stop:
>>         tegra_dma_abort_all(tdc);
>>
>=20
> The tegra_dma_stop() should put RPM anyways, which is missed in yours
> sample. Please see handle_continuous_head_request().

Yes and that is deliberate. The cyclic transfers the transfers *should*
not stop until terminate_all is called. The tegra_dma_stop in
handle_continuous_head_request() is an error condition and so I am not
sure it is actually necessary to call pm_runtime_put() here.

> I'm also finding the explicit get/put a bit easier to follow in the
> code, don't you think so?

I can see that, but I was thinking that in the case of cyclic transfers,
it should only really be necessary to call the get/put at the beginning
and end. So in my mind there should only be two exit points which are
the ISR handler for SG and terminate_all for SG and cyclic.

Jon

--=20
nvpublic
