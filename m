Return-Path: <dmaengine+bounces-1602-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1B88F8BA
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41571C29214
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B852F95;
	Thu, 28 Mar 2024 07:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="A9e2NBjX"
X-Original-To: dmaengine@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BC152F6C;
	Thu, 28 Mar 2024 07:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711611019; cv=none; b=tc8mY55wBJZGN0BHpV2iKL20jHVwUdF/GZTqTO3RCVP4JJohwj5X+6SZlmD0t32TjDOg6iUIHGjibbTQA/Xf3PasyuGGbIPleLe4RqNOEzDEckc2iiz3qUM7OwUzfA0YvoNjMhlQEBdchcdWAMmUvgK2LbycTa+toG2Qbk/Ygyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711611019; c=relaxed/simple;
	bh=bRVgFqHFRGemmtjNQzkJSMwtxi1ANVGaKfrKPoTWPXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kHvwx2SHpznVvbZ/bNTfMyNvMMqcn5nNVVsTtftjSJNLr9E/nfv2Dl4r+iMxJxXDMEKwBnuVeId99tIOK1bFmuaRl6LAumYo7URtceA7k0ZFPkhcG+5zHjBPH86dPwwCf8YxTt+lPRmbfy2ThphmND90UM4rSjq0wZ9I4FqPP/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me; spf=pass smtp.mailfrom=maquefel.me; dkim=pass (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b=A9e2NBjX; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maquefel.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maquefel.me
Received: from mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0d:193:0:640:a325:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id ADBDB61D82;
	Thu, 28 Mar 2024 10:24:25 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id OOHQfKCGluQ0-10d0dH6M;
	Thu, 28 Mar 2024 10:24:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail;
	t=1711610665; bh=bRVgFqHFRGemmtjNQzkJSMwtxi1ANVGaKfrKPoTWPXs=;
	h=References:Date:In-Reply-To:Cc:To:From:Subject:Message-ID;
	b=A9e2NBjXYR/su5FPIUiqJbhtyLfm93unMpbCKmofAVDuYnY8DyM6Ypa1/SJeYEGd7
	 QZWu/11UcJwjYQhBsmOLEPwHJP72dsBn9pMtYzdz8ap+NjA5zaM4Z0lXhSjZR+hQLb
	 blU6ZNFUt4mncN4245FGlcYKW4+SeWWX6spLTirs=
Authentication-Results: mail-nwsmtp-smtp-production-main-74.vla.yp-c.yandex.net; dkim=pass header.i=@maquefel.me
Message-ID: <821da3f70fcd326860a995514791b228e3f3f7b7.camel@maquefel.me>
Subject: Re: [PATCH v9 09/38] dma: cirrus: Convert to DT for Cirrus EP93xx
From: Nikita Shubin <nikita.shubin@maquefel.me>
To: Vinod Koul <vkoul@kernel.org>
Cc: Alexander Sverdlin <alexander.sverdlin@gmail.com>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
	 <arnd@arndb.de>
Date: Thu, 28 Mar 2024 10:24:25 +0300
In-Reply-To: <ZgTytMtgvqcHlEsO@matsya>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
	 <20240326-ep93xx-v9-9-156e2ae5dfc8@maquefel.me> <ZgTytMtgvqcHlEsO@matsya>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Vinod!

Thank you for looking into this.

On Thu, 2024-03-28 at 10:01 +0530, Vinod Koul wrote:
> On 26-03-24, 12:18, Nikita Shubin via B4 Relay wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > +enum ep93xx_dma_type {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0M2P_DMA,
>=20
> Is this missing P2M?
>=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0M2M_DMA,
> > +};
> > +

These are internal types used only to distinguish M2P/P2M and M2M
capable controllers in "of_device_id ep93xx_dma_of_ids[]".

So M2P_DMA is M2P/P2M, a can rename M2P_DMA to M2P_P2M_DMA to avoid
confusion.


> > =C2=A0struct ep93xx_dma_engine;
> > =C2=A0static int ep93xx_dma_slave_config_write(struct dma_chan *chan,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 enum
> > dma_transfer_direction dir,
> > @@ -129,11 +136,17 @@ struct ep93xx_dma_desc {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct list_head=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0node;
> > =C2=A0};
> > =C2=A0
> > +struct ep93xx_dma_chan_cfg {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u8=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0port;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum dma_transfer_direction=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dir;
>=20
> Why is direction stored here, it should be derived from the prep_xxx
> call, that has direction as an argument
>=20
>=20

M2P/P2M channels aren't unidirectional.

Citing "EP9xx User Guide":

"Ten fully independent, programmable DMA controller internal M2P/P2M
channels (5 Tx and 5 Rx)."

We need to return correct channel based on Device Tree provided data,
because we need direction in device_alloc_chan_resources() for hardware
setup before prepping.

May be i am mistaking somewhere.


