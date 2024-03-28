Return-Path: <dmaengine+bounces-1586-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077E588F3AB
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 01:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3254E1C23166
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 00:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D788F72;
	Thu, 28 Mar 2024 00:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zj6lr0AL"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5951E498;
	Thu, 28 Mar 2024 00:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711585406; cv=none; b=BcMuXeUGWUHaEnLQZrWpY7tOyYqu/jtojRcgXwxVCS9KWjXsTKghUjddymbpy6MMSSehi0ZyM51pQmmBPCKgm4RNMZbMFRATShioxfK5XHEFpmiyDx82TNEJS27Pk4duPOHAI4Mz8dsE+QO1ONwucvS69pC/9I6z8ArJxx9BxI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711585406; c=relaxed/simple;
	bh=QBhJNdXt3ZDE1KYix7kVNCLNrhefe3LPg7AK/U9VUX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EYmj9afwlijNeXYr1FVsyj/Z2f78J8j71Jh9MS1Qf9Sm2rvNtI712wmFC67qvMvmSJcHl8CLO4sWcnTASgpYdjM84X/HKWQ+h8wc5xgLb4THgdu38q6Spv3wOSTofdbAZaq3KSqTUybb7TZl2Bc3SFU4Kp0a1G88EyaQgSTxbuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zj6lr0AL; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 71C63FF802;
	Thu, 28 Mar 2024 00:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711585396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wrkfJcTuEi+D+HvBe61cn2FoxEmO6/EMkOnHD/GfbVk=;
	b=Zj6lr0AL5lpyDHEmBNKHoDUp8yYNVdu+j6B2c/n+9L4YqqNlPbqUykWamyW25LRM7Zl2n0
	4gBIpQViRbWJi50k/2DGDhQoluW7Mx2v5juh32IvkijyCIXq/oTpkCD7HT5VRhJwcATOWL
	j38C8hYFXRA+OjFsOorQUiUzwWY7DgvKekSna9OBvnB9/jLcp0E4G0CY48x5zSfA78ec/h
	6jlZrsYjsyOWsxKeOrtZVbJpLTr1z86o74MT4buG1l3QBFMb8gAN0ZUR6z2aadu1DpZrOU
	kaugZr7iYw0QuWll34OHEdvLE9nN2GQhGces5PpaaOA23A7wp3LNPmxlAYDeYg==
Date: Thu, 28 Mar 2024 01:23:13 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Lizhi Hou <lizhi.hou@amd.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, Brian Xu <brian.xu@amd.com>,
 Raj Kumar Rampelli <raj.kumar.rampelli@amd.com>, Vinod Koul
 <vkoul@kernel.org>, Michal Simek <michal.simek@amd.com>, Jan Kuliga
 <jankul@alatek.krakow.pl>, <dmaengine@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] dmaengine: xilinx: xdma: Fix synchronization issue
Message-ID: <20240328012257.4a5955f2@xps-13>
In-Reply-To: <b59dd8cd-fd75-5342-d411-817f33e0ff48@amd.com>
References: <20240327-digigram-xdma-fixes-v1-0-45f4a52c0283@bootlin.com>
	<20240327-digigram-xdma-fixes-v1-2-45f4a52c0283@bootlin.com>
	<b59dd8cd-fd75-5342-d411-817f33e0ff48@amd.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Lizhi,

> > @@ -376,6 +378,8 @@ static int xdma_xfer_start(struct xdma_chan *xchan)
> >   		return ret; =20
> >   >   	xchan->busy =3D true; =20
> > +	xchan->stop_requested =3D false;
> > +	reinit_completion(&xchan->last_interrupt); =20
>=20
> If stop_requested is true, it should not start another transfer. So I wou=
ld suggest to add
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (xchan->stop_requested)
>=20
>  =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=
=A0 return -ENODEV;

Maybe -EBUSY in this case?

I thought synchronize() was mandatory in-between. If that's not the
case then indeed we need to block or error-out if a new transfer
gets started.

>=20
> at the beginning of xdma_xfer_start().
>=20
> xdma_xfer_start() is protected by chan lock.
>=20
> >   >   	return 0; =20
> >   }

Thanks,
Miqu=C3=A8l

