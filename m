Return-Path: <dmaengine+bounces-424-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C0180A571
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 15:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEF61F213EF
	for <lists+dmaengine@lfdr.de>; Fri,  8 Dec 2023 14:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F91DDEA;
	Fri,  8 Dec 2023 14:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="FPm5wTGh"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59C1723
	for <dmaengine@vger.kernel.org>; Fri,  8 Dec 2023 06:28:03 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 3C5E22D00F7D;
	Fri,  8 Dec 2023 15:28:01 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id sWlbppDP4Gak; Fri,  8 Dec 2023 15:27:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 2CD322D00F7F;
	Fri,  8 Dec 2023 15:27:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 2CD322D00F7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1702045676;
	bh=cmjhnrITylWyViSC/W9FqGdU2krWgc0y0oM655lTAPk=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=FPm5wTGhmRslL6LOmi2PXB0RDGoFTXhNPNYUfQNEAduI16j/RFxEagrj+WPOD5v2I
	 cBm1zugn2PTsotsHj0lm8cTvjDmRtkVyAqC0+7HiQz3LXGkCxa0ex8CuXQyFw9sOQR
	 5Xh5cUHgck3/Z7wCK5JrpTnV7TaOtg9rMnmfp9NgCp88ix+JH120YdesSku2Zu3b77
	 blN+b/JZcKp17zZBzgCH09MIlKFXDTHZ6OdaByKKm2laq0N0SSONRZd2nIaIPZf0y5
	 XjDXz3/ybZtWPuxf7D4xMOQlg8uCXhUM2S2yhpY0ZZ0g2q3+2ZuygRL0BBPEXplV2u
	 t8Q+LYD8eBrsQ==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id LDBZHZIDa3y6; Fri,  8 Dec 2023 15:27:56 +0100 (CET)
Received: from [10.125.125.6] (unknown [10.125.125.6])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 9AA762D00F7D;
	Fri,  8 Dec 2023 15:27:55 +0100 (CET)
Message-ID: <0a616645-c663-4142-8901-4b19b20471dd@alatek.krakow.pl>
Date: Fri, 8 Dec 2023 15:27:54 +0100
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
To: Lizhi Hou <lizhi.hou@amd.com>, Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Brian Xu <brian.xu@amd.com>,
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
 <5ab105ae-2c10-45db-b5ae-f58e2f9ce8da@alatek.krakow.pl>
 <20231204153621.76f30a8f@xps-13>
 <ba61dfb1-cd79-ccec-5837-7daed3b23191@amd.com>
From: Jan Kuliga <jankul@alatek.krakow.pl>
In-Reply-To: <ba61dfb1-cd79-ccec-5837-7daed3b23191@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Here [1] you can find my new patchset, based on Miquel's one, as we agree=
d earlier this week. As my patches touch some common driver code, I'd app=
reciate if you could run them against your testcases and leave some feedb=
ack.

Thanks,
Jan

[1] https://lore.kernel.org/dmaengine/20231208134838.49500-1-jankul@alate=
k.krakow.pl/T/#t=20

On 4.12.2023 17:41, Lizhi Hou wrote:
>=20
> On 12/4/23 06:36, Miquel Raynal wrote:
>> Hi Jan,
>>
>> jankul@alatek.krakow.pl wrote on Mon, 4 Dec 2023 14:13:13 +0100:
>>
>>> Hi Miquel,
>>>
>>> On 4.12.2023 12:02, Miquel Raynal wrote:
>>>> Hi Jan,
>>>> =C2=A0=C2=A0
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 vchan_synchronize(&xdma_chan->vchan); +} + =
/** *
>>>>>>>>> xdma_prep_device_sg - prepare a descriptor for a DMA
>>>>> tr
>>>>>>> ansaction
>>>>>>>>> * @chan: DMA channel pointer @@ -1088,6 +1154,8 @@ static
>>>>>>>>> int xdma_probe(struct platform_device *
>>>>> pd
>>>>>>> ev)
>>>>>>>>> xdev->dma_dev.device_prep_slave_sg =3D
>>>>> xdma_prep_device_sg;
>>>>>>>>> xdev->dma_dev.device_config =3D xdma
>>>>> _de
>>>>>>> vice_config;
>>>>>>>>> xdev->dma_dev.device_issue_pending =3D
>>>>> xdma_issue_pending;
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_terminate_all =3D xdma=
_term
>>>>> in
>>>>>>> ate_all;
>>>>>>>>> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_synchronize =3D xdma_s=
ynchr
>>>>> on
>>>>>>> ize;
>>>>>>>>> xdev->dma_dev.filter.map =3D pdata->
>>>>> dev
>>>>>>> ice_map;
>>>>>>>>> xdev->dma_dev.filter.mapcnt =3D pdat
>>>>> a->
>>>>>>> device_map_cnt;
>>>>>>>>> xdev->dma_dev.filter.fn =3D xdma_fil
>>>>> ter
>>>>>>> _fn;
>>>> Not related, but if you could fix your mailer, it is a bit hard to
>>>> track your answers.
>>>> =C2=A0=C2=A0=20
>>> Thanks for pointing this out, I didn't notice it. From now on it shou=
ld be okay.
>>>
>>>>>>> I have already prepared a patch with an appropriate fix, which
>>>>>>> I'm goi
>>>>> ng to submit with the whole patch series, once I have interleaved
>>>>> DMA transfers properly sorted out (hopefully soon). Or maybe should
>>>>> I post this patch with fix, immediately as a reply to the already
>>>>> sent one? What do y ou prefer?
>>>>>> I see. Well in the case of cyclic transfers it looks like this
>>>>>> is enoug
>>>>> h
>>>>>> (I don't have any way to test interleaved/SG transfers) so maybe
>>>>>> =C2=A0 maintainers can take this now as it is ready and fixes cycl=
ic
>>>>>> transfers, so when the interleaved transfers are ready you can
>>>>>> improve these functions with a series on top of it?
>>>>>> =C2=A0=C2=A0=20
>>>>> So I decided to base my new patchset on my previous one, as I
>>>>> haven't seen any ack from any maintainer yet on both mine and your
>>>>> patchset. I'm going to submit it this week.
>>>> Well, the difference between the two approaches is that I am fixing
>>>> something upstream, and you're adding a new feature, which is not
>>>> ready yet. I don't mind about using your patch though, I just want
>>>> upstream to be fixed.
>>>> =C2=A0=C2=A0
>>>>> This specific commit of yours (PATCH 4/4) basically does the same
>>>>> thing as mine patch, so there will be no difference in its
>>>>> functionality, i.e. it will also fix cyclic transfers.
>>>> =C2=A0=C2=A0=20
>>> Okay, so as far as I understand, you'd like me to submit my patchset =
based on the top of yours.
>> That would be ideal, unless my series get postponed for any reason.
>> I believe the maintainers will soon give their feedback, we'll do what
>> they prefer.
>>
>> I believe Lizhi will also give a Tested-by -or not-.
>=20
> Yes, I verified this patch set for sg list test and it passed.
>=20
> Tested-by: Lizhi Hou <lizhi.hou@amd.com>
>=20
>>
>>> I guess maintainers will be fine with that (so do I). If so, what is =
the proper way to post my next
>>> patch series? Should I post it as a reply to your patchset, or as a c=
ompletely new thread
>>> with a information that it is based on this patchset?
>> You can definitely send an individual patchset and just point out that
>> it applies on top of the few fixes I sent.
>>
>>> I don't want to wait with submission
>>> without getting any feedback until your patches are going to be upstr=
eamed.
>> Of course.
>>
>> Thanks,
>> Miqu=C3=A8l

