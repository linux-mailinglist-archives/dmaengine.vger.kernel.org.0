Return-Path: <dmaengine+bounces-358-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1B3802EA9
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 10:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A79A41F2111E
	for <lists+dmaengine@lfdr.de>; Mon,  4 Dec 2023 09:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873011A707;
	Mon,  4 Dec 2023 09:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="RllMubYx"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1F9AD2
	for <dmaengine@vger.kernel.org>; Mon,  4 Dec 2023 01:34:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id E8E282CE0842;
	Mon,  4 Dec 2023 10:34:40 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id oQhg8j8r2pHS; Mon,  4 Dec 2023 10:34:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id D18BA2CE0847;
	Mon,  4 Dec 2023 10:34:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl D18BA2CE0847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1701682475;
	bh=HiRDbygkx8xkPaowXuSrtBQo/3QC7FbiQvKsWhOjKow=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=RllMubYxqoRImzgVrE6ZQOy+r10V/a0zXnZnxnzsWeCOtjLbL9M1I1mYb+Al1XgDj
	 TEcTgAFrQ1cj64Fh1vZJIFo6ikw3q7BZUT5FFgwTwZ0/VTECFBYUoDrNOYpcWg3c8a
	 tstq0wPgPul2vJ+u4OTCyX9KRjq5DdaItiN1xa19TEUwCI+MEIipJcPG+xb1xY+gt4
	 Pu6+hepVnJuxT4Sf04w840yYtxUeQDp11HN9ks/E/lRFA6ORy3iDflkusiXuv8dad6
	 8pTMkgNhDYPYYuiTw+Mn2r4e5nCIgI48y9/dNa/JerVl8PTsZyPJBgrFZUZleZnBVA
	 T8r/qSOwOOxrw==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id d2XRS1MGG-_M; Mon,  4 Dec 2023 10:34:35 +0100 (CET)
Received: from [192.168.1.103] (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 9596F2CE0842;
	Mon,  4 Dec 2023 10:34:35 +0100 (CET)
Message-ID: <d27730fb-1c45-41e6-8cad-da172adf99d0@alatek.krakow.pl>
Date: Mon, 4 Dec 2023 10:34:35 +0100
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
From: Jan Kuliga <jankul@alatek.krakow.pl>
In-Reply-To: <20231130202339.5feac088@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi Miquel,

On 30.11.2023 20:23, Miquel Raynal wrote:
> Hi Jan,
>=20
> jankul@alatek.krakow.pl wrote on Thu, 30 Nov 2023 20:06:51 +0100:
>=20
>> Hi,
>>
>> On 30.11.2023 18:28, Lizhi Hou wrote:
>>> Added Jan Kuliga who submitted a similar change.
>>>  =20
>> Thanks for CC'ing me to the other patchset. I'm currently working on i=
nterleaved-DMA transfers implementation for XDMA. While testing it, I've =
come across a flaw in mine patch you mentioned here (and it also exists i=
n the Miquel's patch).
>>
>>> https://lore.kernel.org/dmaengine/20231124192524.134989-1-jankul@alat=
ek
>> .krakow.pl/T/#m20c1ca4bba291f6ca07a8e5fbcaeed9fd0a6f008 >
>>> Thanks,
>>>
>>> Lizhi
>>>
>>> On 11/30/23 03:13, Miquel Raynal wrote:
>>>> The driver is capable of starting scatter-gather transfers and needs=
 t
>> o
>>>> wait until their end. It is also capable of starting cyclic transfer=
s
>>>> and will only be "reset" next time the channel will be reused. In
>>>> practice most of the time we hear no audio glitch because the sound =
ca
>> rd
>>>> stops the flow on its side so the DMA transfers are just
>>>> discarded. There are however some cases (when playing a bit with a
>>>> number of frames and with a discontinuous sound file) when the sound
>>>> card seems to be slightly too slow at stopping the flow, leading to =
a
>>>> glitch that can be heard.
>>>>
>>>> In all cases, we need to earn better control of the DMA engine and
>>>> adding proper ->device_terminate_all() and ->device_synchronize()
>>>> callbacks feels totally relevant. With these two callbacks, no glitc=
h
>>>> can be heard anymore.
>>>>
>>>> Fixes: cd8c732ce1a5 ("dmaengine: xilinx: xdma: Support cyclic transf=
er
>> s")
>>>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>>>> ---
>>>>
>>>> This was only tested with cyclic transfers.
>>>> ---
>>>>  =C2=A0 drivers/dma/xilinx/xdma.c | 68 +++++++++++++++++++++++++++++=
+++
>> +++++++
>>>>  =C2=A0 1 file changed, 68 insertions(+)
>>>>
>>>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>>>> index e931ff42209c..290bb5d2d1e2 100644
>>>> --- a/drivers/dma/xilinx/xdma.c
>>>> +++ b/drivers/dma/xilinx/xdma.c
>>>> @@ -371,6 +371,31 @@ static int xdma_xfer_start(struct xdma_chan *xc=
ha
>> n)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xchan->busy =3D true;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_xfer_stop - Stop DMA transfer
>>>> + * @xchan: DMA channel pointer
>>>> + */
>>>> +static int xdma_xfer_stop(struct xdma_chan *xchan)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct virt_dma_desc *vd =3D vchan_next_desc(&xc=
ha
>> n->vchan);
>>>> +=C2=A0=C2=A0=C2=A0 struct xdma_device *xdev =3D xchan->xdev_hdl;
>>>> +=C2=A0=C2=A0=C2=A0 int ret;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!vd || !xchan->busy)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 /* clear run stop bit to prevent any further aut=
o-
>> triggering */
>>>> +=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(xdev->rmap, xchan->base + X=
DM
>> A_CHAN_CONTROL_W1C,
>>>> +_______________________
>> _____ CHAN_CTRL_RUN_STOP);
>>>> +=C2=A0=C2=A0=C2=A0 if (ret)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>>
>> Shouldn't status register be cleared prior to using it next time? It c=
an be cleared-on-read by doing a read from a separate register (offset 0x=
44)
>> .
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 xchan->busy =3D false;
>>>> +
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>>>>  =C2=A0 }
>>>> @@ -475,6 +500,47 @@ static void xdma_issue_pending(struct dma_chan =
>> *chan)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&xdma_chan->v=
cha
>> n.lock, flags);
>>>>  =C2=A0 }
>>>> +/**
>>>> + * xdma_terminate_all - Terminate all transactions
>>>> + * @chan: DMA channel pointer
>>>> + */
>>>> +static int xdma_terminate_all(struct dma_chan *chan)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct xdma_chan *xdma_chan =3D to_xdma_chan(cha=
n)
>> ;
>>>> +=C2=A0=C2=A0=C2=A0 struct xdma_desc *desc =3D NULL;
>>>> +=C2=A0=C2=A0=C2=A0 struct virt_dma_desc *vd;
>>>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>>>> +=C2=A0=C2=A0=C2=A0 LIST_HEAD(head);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&xdma_chan->vchan.lock, flags)=
;
>>>> +=C2=A0=C2=A0=C2=A0 xdma_xfer_stop(xdma_chan);
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 vd =3D vchan_next_desc(&xdma_chan->vchan);
>>>> +=C2=A0=C2=A0=C2=A0 if (vd)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc =3D to_xdma_desc(vd=
);
>>>> +=C2=A0=C2=A0=C2=A0 if (desc) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_cookie_complete(&des=
c-
>>> vdesc.tx);
>> Prior to a call to vchan_terminate_vdesc(), the vd node has to be dele=
ted from vc.desc_issued list. Otherwise, if there is more than one descri=
ptor present on that list, its link with list's head is going to be lost =
and freeing resources associated with it will become impossible (doing so=
 results in dma_pool_destroy() failure). I noticed it when I was playing =
with a large number of interleaved DMA TXs.
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vchan_terminate_vdesc(&d=
es
>> c->vdesc);
>>>> +=C2=A0=C2=A0=C2=A0 }
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 vchan_get_all_descriptors(&xdma_chan->vchan, &he=
ad
>> );
>>>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&xdma_chan->vchan.lock, f=
la
>> gs);
>>>> +=C2=A0=C2=A0=C2=A0 vchan_dma_desc_free_list(&xdma_chan->vchan, &hea=
d)
>> ;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>>> +}
>>>> +
>>>> +/**
>>>> + * xdma_synchronize - Synchronize terminated transactions
>>>> + * @chan: DMA channel pointer
>>>> + */
>>>> +static void xdma_synchronize(struct dma_chan *chan)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct xdma_chan *xdma_chan =3D to_xdma_chan(cha=
n)
>> ;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 vchan_synchronize(&xdma_chan->vchan);
>>>> +}
>>>> +
>>>>  =C2=A0 /**
>>>>  =C2=A0=C2=A0 * xdma_prep_device_sg - prepare a descriptor for a DMA=
 tr
>> ansaction
>>>>  =C2=A0=C2=A0 * @chan: DMA channel pointer
>>>> @@ -1088,6 +1154,8 @@ static int xdma_probe(struct platform_device *=
pd
>> ev)
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_prep_slave_sg =3D=
 xdma_prep_device_sg;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_config =3D xdma=
_de
>> vice_config;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_issue_pending =3D=
 xdma_issue_pending;
>>>> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_terminate_all =3D xdma_term=
in
>> ate_all;
>>>> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_synchronize =3D xdma_synchr=
on
>> ize;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.map =3D pdata->=
dev
>> ice_map;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.mapcnt =3D pdat=
a->
>> device_map_cnt;
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.fn =3D xdma_fil=
ter
>> _fn;
>>
>> I have already prepared a patch with an appropriate fix, which I'm goi=
ng to submit with the whole patch series, once I have interleaved DMA tra=
nsfers properly sorted out (hopefully soon). Or maybe should I post this =
patch with fix, immediately as a reply to the already sent one? What do y=
ou prefer?
>=20
> I see. Well in the case of cyclic transfers it looks like this is enoug=
h
> (I don't have any way to test interleaved/SG transfers) so maybe
> maintainers can take this now as it is ready and fixes cyclic
> transfers, so when the interleaved transfers are ready you can
> improve these functions with a series on top of it?
>=20
So I decided to base my new patchset on my previous one, as I haven't=20
seen any ack from any maintainer yet on both mine and your patchset. I'm=20
going to submit it this week.

This specific commit of yours (PATCH 4/4) basically does the same thing=20
as mine patch, so there will be no difference in its functionality, i.e.=20
it will also fix cyclic transfers.

> Thanks,
> Miqu=C3=A8l
Thanks,
Jan

