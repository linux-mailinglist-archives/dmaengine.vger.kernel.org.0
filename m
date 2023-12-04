Return-Path: <dmaengine+bounces-361-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD9B80341F
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 14:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 989F01C2095C
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 13:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A1424A1F;
	Mon,  4 Dec 2023 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="i+JxGBzS"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF35D5F
	for <dmaengine@vger.kernel.org>; Mon,  4 Dec 2023 05:13:20 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 9AB0B2CE0897;
	Mon,  4 Dec 2023 14:13:18 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id IG8vkyjdhi47; Mon,  4 Dec 2023 14:13:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 752282CE0898;
	Mon,  4 Dec 2023 14:13:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 752282CE0898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1701695594;
	bh=BcsoW0nZFQenoWlSsf1271DgKJitbfwrj5BCU5YM0Bk=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=i+JxGBzSdayKF2lJsC3WD7U/LN9Q5z54WDcH6nbH+Nm49ZWOqHZiaCoW2WAP5L50B
	 6Tz5Q4jumCpskV3pYnGkKgcwLGTA+ZaZhk7jOBFoKboGLbhs2zRPyWgKRqMKHg0pil
	 aHWQ8uL5BFGAhzzsBr/ajEYXaS0KKKZCxzZSbOXzjGHFL1QlGohA3+Ga371b5i0QO8
	 vMJSSWYomryBaXwa/lEr4oqoClHi/R6Xh26nozAT5BPfwDK8UUx5j/f9EWYVAWFtKv
	 k4Gz4zAaaCzLtlCT3R47cH9hNHWMWrA2RH656egU+c9U/GtjukI+ME/wUGVASj7kyC
	 bhUmKE1+8BWdw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id Ty1YcZ5PUEhc; Mon,  4 Dec 2023 14:13:14 +0100 (CET)
Received: from [192.168.1.103] (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 34AA02CE0897;
	Mon,  4 Dec 2023 14:13:14 +0100 (CET)
Message-ID: <5ab105ae-2c10-45db-b5ae-f58e2f9ce8da@alatek.krakow.pl>
Date: Mon, 4 Dec 2023 14:13:13 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] dmaengine: xilinx: xdma: Add
 terminate_all/synchronize callbacks
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>,
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>,
 Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Michal Simek <monstr@monstr.eu>, dmaengine@vger.kernel.org
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
 <20231130111315.729430-5-miquel.raynal@bootlin.com>
 <674c7bf3-77dd-9b44-a2cb-8e769a2080df@amd.com>
 <f2192d19-08e6-4f8b-b15c-f8bf44f9058b@alatek.krakow.pl>
 <20231130202339.5feac088@xps-13>
 <d27730fb-1c45-41e6-8cad-da172adf99d0@alatek.krakow.pl>
 <20231204120253.2591eb0b@xps-13>
From: Jan Kuliga <jankul@alatek.krakow.pl>
In-Reply-To: <20231204120253.2591eb0b@xps-13>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Miquel,                                                               =
                               =20

On 4.12.2023 12:02, Miquel Raynal wrote:
> Hi Jan,
>=20
>>>>>> +    vchan_synchronize(&xdma_chan->vchan); +} + /** *=20
>>>>>> xdma_prep_device_sg - prepare a descriptor for a DMA
>> tr
>>>> ansaction
>>>>>> * @chan: DMA channel pointer @@ -1088,6 +1154,8 @@ static=20
>>>>>> int xdma_probe(struct platform_device *
>> pd
>>>> ev)
>>>>>> xdev->dma_dev.device_prep_slave_sg =3D
>> xdma_prep_device_sg;
>>>>>> xdev->dma_dev.device_config =3D xdma
>> _de
>>>> vice_config;
>>>>>> xdev->dma_dev.device_issue_pending =3D
>> xdma_issue_pending;
>>>>>> +    xdev->dma_dev.device_terminate_all =3D xdma_term
>> in
>>>> ate_all;
>>>>>> +    xdev->dma_dev.device_synchronize =3D xdma_synchr
>> on
>>>> ize;
>>>>>> xdev->dma_dev.filter.map =3D pdata->
>> dev
>>>> ice_map;
>>>>>> xdev->dma_dev.filter.mapcnt =3D pdat
>> a->
>>>> device_map_cnt;
>>>>>> xdev->dma_dev.filter.fn =3D xdma_fil
>> ter
>>>> _fn;
>=20
> Not related, but if you could fix your mailer, it is a bit hard to=20
> track your answers.
>=20
Thanks for pointing this out, I didn't notice it. From now on it should b=
e okay.

>>>>=20
>>>> I have already prepared a patch with an appropriate fix, which=20
>>>> I'm goi
>> ng to submit with the whole patch series, once I have interleaved=20
>> DMA transfers properly sorted out (hopefully soon). Or maybe should
>> I post this patch with fix, immediately as a reply to the already
>> sent one? What do y ou prefer?
>>>=20
>>> I see. Well in the case of cyclic transfers it looks like this
>>> is enoug
>> h
>>> (I don't have any way to test interleaved/SG transfers) so maybe
>>>  maintainers can take this now as it is ready and fixes cyclic=20
>>> transfers, so when the interleaved transfers are ready you can=20
>>> improve these functions with a series on top of it?
>>>=20
>> So I decided to base my new patchset on my previous one, as I=20
>> haven't seen any ack from any maintainer yet on both mine and your=20
>> patchset. I'm going to submit it this week.
>=20
> Well, the difference between the two approaches is that I am fixing=20
> something upstream, and you're adding a new feature, which is not=20
> ready yet. I don't mind about using your patch though, I just want=20
> upstream to be fixed.
>=20
>> This specific commit of yours (PATCH 4/4) basically does the same=20
>> thing as mine patch, so there will be no difference in its=20
>> functionality, i.e. it will also fix cyclic transfers.
>=20
Okay, so as far as I understand, you'd like me to submit my patchset base=
d on the top of yours.
I guess maintainers will be fine with that (so do I). If so, what is the =
proper way to post my next
patch series? Should I post it as a reply to your patchset, or as a compl=
etely new thread
with a information that it is based on this patchset? I don't want to wai=
t with submission
without getting any feedback until your patches are going to be upstreame=
d.

> Thanks, Miqu=C3=A8lThanks,
Jan

