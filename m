Return-Path: <dmaengine+bounces-332-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 029067FFACB
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 20:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251231C20D28
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990F5FEFF;
	Thu, 30 Nov 2023 19:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=alatek.krakow.pl header.i=@alatek.krakow.pl header.b="fTPS5/oM"
X-Original-To: dmaengine@vger.kernel.org
Received: from helios.alatek.com.pl (helios.alatek.com.pl [85.14.123.227])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD90D48
	for <dmaengine@vger.kernel.org>; Thu, 30 Nov 2023 11:07:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id ADF922CE0625;
	Thu, 30 Nov 2023 20:06:56 +0100 (CET)
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10032)
 with ESMTP id i2jC0UaX6WgO; Thu, 30 Nov 2023 20:06:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by helios.alatek.com.pl (Postfix) with ESMTP id 627992CE062D;
	Thu, 30 Nov 2023 20:06:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 helios.alatek.com.pl 627992CE062D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alatek.krakow.pl;
	s=99EE5E86-D06A-11EC-BE24-DBCCD0A148D3; t=1701371212;
	bh=PINhTVcuXix9lkza5bbzfTAITJ5fp6CgGECwtGq4aos=;
	h=Message-ID:Date:MIME-Version:To:From;
	b=fTPS5/oM5kMq/aWjnc4MKFk4HXHHyn5UQKHSPM1oYIoPGx7BpuYIeMN8A7wTqD1Xx
	 UhiTfhK9uAHFrp/kvjNbSa6ieuTRRSdf825XY8w0x9dF0A0Ujx/MISxGuULv3s4aM7
	 MYz29xJ2zNezd3DsA3svws90gTKhxiJ7z4WayOGhv+sYcaXI2PCnwOY7Qvp6+I/3OO
	 MHXCTAJzlhu9Me+huxZbQUE4godV3HKMbesdHPIS6W2Co9Ne4sU3IlaJRIyCGuQjfE
	 OCp11M9mejWmJDbZM2GTOcTaEyQJOxvOuZjG6ZWb3BG2i0MmpaVAZ1O4yu6XAtPEzD
	 /KaV/wvZSqadg==
X-Virus-Scanned: amavis at alatek.com.pl
Received: from helios.alatek.com.pl ([127.0.0.1])
 by localhost (helios.alatek.com.pl [127.0.0.1]) (amavis, port 10026)
 with ESMTP id t7LQKS85PJh4; Thu, 30 Nov 2023 20:06:52 +0100 (CET)
Received: from [192.168.1.103] (unknown [10.0.2.2])
	by helios.alatek.com.pl (Postfix) with ESMTPSA id 273292CE0625;
	Thu, 30 Nov 2023 20:06:52 +0100 (CET)
Message-ID: <f2192d19-08e6-4f8b-b15c-f8bf44f9058b@alatek.krakow.pl>
Date: Thu, 30 Nov 2023 20:06:51 +0100
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
To: Lizhi Hou <lizhi.hou@amd.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Brian Xu <brian.xu@amd.com>, Raj Kumar Rampelli
 <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Michal Simek <monstr@monstr.eu>, dmaengine@vger.kernel.org
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
 <20231130111315.729430-5-miquel.raynal@bootlin.com>
 <674c7bf3-77dd-9b44-a2cb-8e769a2080df@amd.com>
From: Jan Kuliga <jankul@alatek.krakow.pl>
In-Reply-To: <674c7bf3-77dd-9b44-a2cb-8e769a2080df@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi,

On 30.11.2023 18:28, Lizhi Hou wrote:
> Added Jan Kuliga who submitted a similar change.
>
Thanks for CC'ing me to the other patchset. I'm currently working on=20
interleaved-DMA transfers implementation for XDMA. While testing it,=20
I've come across a flaw in mine patch you mentioned here (and it also=20
exists in the Miquel's patch).

> https://lore.kernel.org/dmaengine/20231124192524.134989-1-jankul@alatek=
.krakow.pl/T/#m20c1ca4bba291f6ca07a8e5fbcaeed9fd0a6f008 >
> Thanks,
>=20
> Lizhi
>=20
> On 11/30/23 03:13, Miquel Raynal wrote:
>> The driver is capable of starting scatter-gather transfers and needs t=
o
>> wait until their end. It is also capable of starting cyclic transfers
>> and will only be "reset" next time the channel will be reused. In
>> practice most of the time we hear no audio glitch because the sound ca=
rd
>> stops the flow on its side so the DMA transfers are just
>> discarded. There are however some cases (when playing a bit with a
>> number of frames and with a discontinuous sound file) when the sound
>> card seems to be slightly too slow at stopping the flow, leading to a
>> glitch that can be heard.
>>
>> In all cases, we need to earn better control of the DMA engine and
>> adding proper ->device_terminate_all() and ->device_synchronize()
>> callbacks feels totally relevant. With these two callbacks, no glitch
>> can be heard anymore.
>>
>> Fixes: cd8c732ce1a5 ("dmaengine: xilinx: xdma: Support cyclic transfer=
s")
>> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
>> ---
>>
>> This was only tested with cyclic transfers.
>> ---
>> =C2=A0 drivers/dma/xilinx/xdma.c | 68 ++++++++++++++++++++++++++++++++=
+++++++
>> =C2=A0 1 file changed, 68 insertions(+)
>>
>> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
>> index e931ff42209c..290bb5d2d1e2 100644
>> --- a/drivers/dma/xilinx/xdma.c
>> +++ b/drivers/dma/xilinx/xdma.c
>> @@ -371,6 +371,31 @@ static int xdma_xfer_start(struct xdma_chan *xcha=
n)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xchan->busy =3D true;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +/**
>> + * xdma_xfer_stop - Stop DMA transfer
>> + * @xchan: DMA channel pointer
>> + */
>> +static int xdma_xfer_stop(struct xdma_chan *xchan)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct virt_dma_desc *vd =3D vchan_next_desc(&xcha=
n->vchan);
>> +=C2=A0=C2=A0=C2=A0 struct xdma_device *xdev =3D xchan->xdev_hdl;
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!vd || !xchan->busy)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>> +
>> +=C2=A0=C2=A0=C2=A0 /* clear run stop bit to prevent any further auto-=
triggering */
>> +=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(xdev->rmap, xchan->base + XDM=
A_CHAN_CONTROL_W1C,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 CHAN_CTRL_RUN_STOP);
>> +=C2=A0=C2=A0=C2=A0 if (ret)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;

Shouldn't status register be cleared prior to using it next time? It can=20
be cleared-on-read by doing a read from a separate register (offset 0x44)=
.
>> +
>> +=C2=A0=C2=A0=C2=A0 xchan->busy =3D false;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> =C2=A0 }
>> @@ -475,6 +500,47 @@ static void xdma_issue_pending(struct dma_chan=20
>> *chan)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&xdma_chan->vcha=
n.lock, flags);
>> =C2=A0 }
>> +/**
>> + * xdma_terminate_all - Terminate all transactions
>> + * @chan: DMA channel pointer
>> + */
>> +static int xdma_terminate_all(struct dma_chan *chan)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xdma_chan *xdma_chan =3D to_xdma_chan(chan)=
;
>> +=C2=A0=C2=A0=C2=A0 struct xdma_desc *desc =3D NULL;
>> +=C2=A0=C2=A0=C2=A0 struct virt_dma_desc *vd;
>> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
>> +=C2=A0=C2=A0=C2=A0 LIST_HEAD(head);
>> +
>> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
>> +=C2=A0=C2=A0=C2=A0 xdma_xfer_stop(xdma_chan);
>> +
>> +=C2=A0=C2=A0=C2=A0 vd =3D vchan_next_desc(&xdma_chan->vchan);
>> +=C2=A0=C2=A0=C2=A0 if (vd)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc =3D to_xdma_desc(vd);
>> +=C2=A0=C2=A0=C2=A0 if (desc) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_cookie_complete(&desc-=
>vdesc.tx);
Prior to a call to vchan_terminate_vdesc(), the vd node has to be=20
deleted from vc.desc_issued list. Otherwise, if there is more than one=20
descriptor present on that list, its link with list's head is going to=20
be lost and freeing resources associated with it will become impossible=20
(doing so results in dma_pool_destroy() failure). I noticed it when I=20
was playing with a large number of interleaved DMA TXs.
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vchan_terminate_vdesc(&des=
c->vdesc);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 vchan_get_all_descriptors(&xdma_chan->vchan, &head=
);
>> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&xdma_chan->vchan.lock, fla=
gs);
>> +=C2=A0=C2=A0=C2=A0 vchan_dma_desc_free_list(&xdma_chan->vchan, &head)=
;
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> +/**
>> + * xdma_synchronize - Synchronize terminated transactions
>> + * @chan: DMA channel pointer
>> + */
>> +static void xdma_synchronize(struct dma_chan *chan)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct xdma_chan *xdma_chan =3D to_xdma_chan(chan)=
;
>> +
>> +=C2=A0=C2=A0=C2=A0 vchan_synchronize(&xdma_chan->vchan);
>> +}
>> +
>> =C2=A0 /**
>> =C2=A0=C2=A0 * xdma_prep_device_sg - prepare a descriptor for a DMA tr=
ansaction
>> =C2=A0=C2=A0 * @chan: DMA channel pointer
>> @@ -1088,6 +1154,8 @@ static int xdma_probe(struct platform_device *pd=
ev)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_prep_slave_sg =3D =
xdma_prep_device_sg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_config =3D xdma_de=
vice_config;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_issue_pending =3D =
xdma_issue_pending;
>> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_terminate_all =3D xdma_termin=
ate_all;
>> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_synchronize =3D xdma_synchron=
ize;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.map =3D pdata->dev=
ice_map;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.mapcnt =3D pdata->=
device_map_cnt;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.fn =3D xdma_filter=
_fn;

I have already prepared a patch with an appropriate fix, which I'm going=20
to submit with the whole patch series, once I have interleaved DMA=20
transfers properly sorted out (hopefully soon). Or maybe should I post=20
this patch with fix, immediately as a reply to the already sent one?=20
What do you prefer?

Thanks,
Jan

