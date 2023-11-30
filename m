Return-Path: <dmaengine+bounces-333-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E41FB7FFB30
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 20:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59ABCB21253
	for <lists+dmaengine@lfdr.de>; Thu, 30 Nov 2023 19:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8872342074;
	Thu, 30 Nov 2023 19:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ABHshLH0"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 847D2171D
	for <dmaengine@vger.kernel.org>; Thu, 30 Nov 2023 11:23:43 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1455B240003;
	Thu, 30 Nov 2023 19:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701372221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+anfi2GDRmS9F4Ro1QYA6AhDYJUTQdHt709iDGZslw=;
	b=ABHshLH00IuulwUpGkcUiT+3HUWmbIojXWpxOJmLDUtufpKbT68/ePv41qaKHOnbiuYLza
	hKjBJ+t3XQbMUnYWT6WkyoEvHZEyl12zdODdMpIw7WVW/iBfZx+OTPpAecmR5K3Jy+Lano
	y12LzyDureqM/cIJCiXuHGHXG2CINeVr4C/ERohGr6EyS/SOpUfZD/zGL4dH9L5AX1JUHK
	xErNaSNIrP2TzkrMqIEoSLBqkkLPqGExfxoktZdj0j3zD4953ibvdRyTlXCGRc44A0u1Ru
	77rnTqzz+W80WBBB/b51t2NkCU30CwRdd4gJzC0i1xNI0qDXo89LplyVXI5R4g==
Date: Thu, 30 Nov 2023 20:23:39 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Jan Kuliga <jankul@alatek.krakow.pl>
Cc: Lizhi Hou <lizhi.hou@amd.com>, Brian Xu <brian.xu@amd.com>, Raj Kumar
 Rampelli <raj.kumar.rampelli@amd.com>, Vinod Koul <vkoul@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Michal Simek
 <monstr@monstr.eu>, dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 4/4] dmaengine: xilinx: xdma: Add
 terminate_all/synchronize callbacks
Message-ID: <20231130202339.5feac088@xps-13>
In-Reply-To: <f2192d19-08e6-4f8b-b15c-f8bf44f9058b@alatek.krakow.pl>
References: <20231130111315.729430-1-miquel.raynal@bootlin.com>
	<20231130111315.729430-5-miquel.raynal@bootlin.com>
	<674c7bf3-77dd-9b44-a2cb-8e769a2080df@amd.com>
	<f2192d19-08e6-4f8b-b15c-f8bf44f9058b@alatek.krakow.pl>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Jan,

jankul@alatek.krakow.pl wrote on Thu, 30 Nov 2023 20:06:51 +0100:

> Hi,
>=20
> On 30.11.2023 18:28, Lizhi Hou wrote:
> > Added Jan Kuliga who submitted a similar change.
> > =20
> Thanks for CC'ing me to the other patchset. I'm currently working on inte=
rleaved-DMA transfers implementation for XDMA. While testing it, I've come =
across a flaw in mine patch you mentioned here (and it also exists in the M=
iquel's patch).
>=20
> > https://lore.kernel.org/dmaengine/20231124192524.134989-1-jankul@alatek=
 =20
> .krakow.pl/T/#m20c1ca4bba291f6ca07a8e5fbcaeed9fd0a6f008 >
> > Thanks,
> >=20
> > Lizhi
> >=20
> > On 11/30/23 03:13, Miquel Raynal wrote: =20
> >> The driver is capable of starting scatter-gather transfers and needs t=
 =20
> o
> >> wait until their end. It is also capable of starting cyclic transfers
> >> and will only be "reset" next time the channel will be reused. In
> >> practice most of the time we hear no audio glitch because the sound ca=
 =20
> rd
> >> stops the flow on its side so the DMA transfers are just
> >> discarded. There are however some cases (when playing a bit with a
> >> number of frames and with a discontinuous sound file) when the sound
> >> card seems to be slightly too slow at stopping the flow, leading to a
> >> glitch that can be heard.
> >>
> >> In all cases, we need to earn better control of the DMA engine and
> >> adding proper ->device_terminate_all() and ->device_synchronize()
> >> callbacks feels totally relevant. With these two callbacks, no glitch
> >> can be heard anymore.
> >>
> >> Fixes: cd8c732ce1a5 ("dmaengine: xilinx: xdma: Support cyclic transfer=
 =20
> s")
> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >> ---
> >>
> >> This was only tested with cyclic transfers.
> >> ---
> >> =C2=A0 drivers/dma/xilinx/xdma.c | 68 ++++++++++++++++++++++++++++++++=
 =20
> +++++++
> >> =C2=A0 1 file changed, 68 insertions(+)
> >>
> >> diff --git a/drivers/dma/xilinx/xdma.c b/drivers/dma/xilinx/xdma.c
> >> index e931ff42209c..290bb5d2d1e2 100644
> >> --- a/drivers/dma/xilinx/xdma.c
> >> +++ b/drivers/dma/xilinx/xdma.c
> >> @@ -371,6 +371,31 @@ static int xdma_xfer_start(struct xdma_chan *xcha=
 =20
> n)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xchan->busy =3D true;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 return 0;
> >> +}
> >> +
> >> +/**
> >> + * xdma_xfer_stop - Stop DMA transfer
> >> + * @xchan: DMA channel pointer
> >> + */
> >> +static int xdma_xfer_stop(struct xdma_chan *xchan)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 struct virt_dma_desc *vd =3D vchan_next_desc(&xcha=
 =20
> n->vchan);
> >> +=C2=A0=C2=A0=C2=A0 struct xdma_device *xdev =3D xchan->xdev_hdl;
> >> +=C2=A0=C2=A0=C2=A0 int ret;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 if (!vd || !xchan->busy)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 /* clear run stop bit to prevent any further auto-=
 =20
> triggering */
> >> +=C2=A0=C2=A0=C2=A0 ret =3D regmap_write(xdev->rmap, xchan->base + XDM=
 =20
> A_CHAN_CONTROL_W1C,
> >> +_______________________ =20
> _____ CHAN_CTRL_RUN_STOP);
> >> +=C2=A0=C2=A0=C2=A0 if (ret)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret; =20
>=20
> Shouldn't status register be cleared prior to using it next time? It can =
be cleared-on-read by doing a read from a separate register (offset 0x44)
> .
> >> +
> >> +=C2=A0=C2=A0=C2=A0 xchan->busy =3D false;
> >> +
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> >> =C2=A0 }
> >> @@ -475,6 +500,47 @@ static void xdma_issue_pending(struct dma_chan >>=
 *chan)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&xdma_chan->vcha=
 =20
> n.lock, flags);
> >> =C2=A0 }
> >> +/**
> >> + * xdma_terminate_all - Terminate all transactions
> >> + * @chan: DMA channel pointer
> >> + */
> >> +static int xdma_terminate_all(struct dma_chan *chan)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 struct xdma_chan *xdma_chan =3D to_xdma_chan(chan)=
 =20
> ;
> >> +=C2=A0=C2=A0=C2=A0 struct xdma_desc *desc =3D NULL;
> >> +=C2=A0=C2=A0=C2=A0 struct virt_dma_desc *vd;
> >> +=C2=A0=C2=A0=C2=A0 unsigned long flags;
> >> +=C2=A0=C2=A0=C2=A0 LIST_HEAD(head);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 spin_lock_irqsave(&xdma_chan->vchan.lock, flags);
> >> +=C2=A0=C2=A0=C2=A0 xdma_xfer_stop(xdma_chan);
> >> +
> >> +=C2=A0=C2=A0=C2=A0 vd =3D vchan_next_desc(&xdma_chan->vchan);
> >> +=C2=A0=C2=A0=C2=A0 if (vd)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 desc =3D to_xdma_desc(vd);
> >> +=C2=A0=C2=A0=C2=A0 if (desc) {
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma_cookie_complete(&desc-=
 =20
> >vdesc.tx); =20
> Prior to a call to vchan_terminate_vdesc(), the vd node has to be deleted=
 from vc.desc_issued list. Otherwise, if there is more than one descriptor =
present on that list, its link with list's head is going to be lost and fre=
eing resources associated with it will become impossible (doing so results =
in dma_pool_destroy() failure). I noticed it when I was playing with a larg=
e number of interleaved DMA TXs.
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vchan_terminate_vdesc(&des=
 =20
> c->vdesc);
> >> +=C2=A0=C2=A0=C2=A0 }
> >> +
> >> +=C2=A0=C2=A0=C2=A0 vchan_get_all_descriptors(&xdma_chan->vchan, &head=
 =20
> );
> >> +=C2=A0=C2=A0=C2=A0 spin_unlock_irqrestore(&xdma_chan->vchan.lock, fla=
 =20
> gs);
> >> +=C2=A0=C2=A0=C2=A0 vchan_dma_desc_free_list(&xdma_chan->vchan, &head)=
 =20
> ;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 return 0;
> >> +}
> >> +
> >> +/**
> >> + * xdma_synchronize - Synchronize terminated transactions
> >> + * @chan: DMA channel pointer
> >> + */
> >> +static void xdma_synchronize(struct dma_chan *chan)
> >> +{
> >> +=C2=A0=C2=A0=C2=A0 struct xdma_chan *xdma_chan =3D to_xdma_chan(chan)=
 =20
> ;
> >> +
> >> +=C2=A0=C2=A0=C2=A0 vchan_synchronize(&xdma_chan->vchan);
> >> +}
> >> +
> >> =C2=A0 /**
> >> =C2=A0=C2=A0 * xdma_prep_device_sg - prepare a descriptor for a DMA tr=
 =20
> ansaction
> >> =C2=A0=C2=A0 * @chan: DMA channel pointer
> >> @@ -1088,6 +1154,8 @@ static int xdma_probe(struct platform_device *pd=
 =20
> ev)
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_prep_slave_sg =3D =
xdma_prep_device_sg;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_config =3D xdma_de=
 =20
> vice_config;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_issue_pending =3D =
xdma_issue_pending;
> >> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_terminate_all =3D xdma_termin=
 =20
> ate_all;
> >> +=C2=A0=C2=A0=C2=A0 xdev->dma_dev.device_synchronize =3D xdma_synchron=
 =20
> ize;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.map =3D pdata->dev=
 =20
> ice_map;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.mapcnt =3D pdata->=
 =20
> device_map_cnt;
> >> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xdev->dma_dev.filter.fn =3D xdma_filter=
 =20
> _fn;
>=20
> I have already prepared a patch with an appropriate fix, which I'm going =
to submit with the whole patch series, once I have interleaved DMA transfer=
s properly sorted out (hopefully soon). Or maybe should I post this patch w=
ith fix, immediately as a reply to the already sent one? What do you prefer?

I see. Well in the case of cyclic transfers it looks like this is enough
(I don't have any way to test interleaved/SG transfers) so maybe
maintainers can take this now as it is ready and fixes cyclic
transfers, so when the interleaved transfers are ready you can
improve these functions with a series on top of it?

Thanks,
Miqu=C3=A8l

