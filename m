Return-Path: <dmaengine+bounces-2541-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5AFB917BBF
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 11:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA93285833
	for <lists+dmaengine@lfdr.de>; Wed, 26 Jun 2024 09:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186E71684A2;
	Wed, 26 Jun 2024 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MdI6eein"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401F2168492
	for <dmaengine@vger.kernel.org>; Wed, 26 Jun 2024 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719392869; cv=none; b=C7FK3MpO/6jMtc3rjLM5dfNBm6AfTx8A7suly8n4jtG9FvKFiDrzX/VfFnQwJ0jlm07b1kk+bdc3GMVCMlXYg5TbAb5FduM9domJUxF1xeBF7m5NOnzmPqhGpoqRGWDKKH7XeHiSR3b7XVJcbbM2dHyYgr6l0UVXBKOh0UiAQFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719392869; c=relaxed/simple;
	bh=ssH+6iURMN7zx64iT61gWIWA5rPqCh8kGeC+MevKIHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRetA+t+HBm7T1ABk1oy95GPykDsrDJ7C4xnww8h8N+54eZOn0wMFGPwn7U+WSTqk73+472UhgG+2V7f00kMWZHPvnnL8Q/KGhahq3rq6xYQpNGR+ESRzVJsrdf0CwHtl+3DALrl8AlRUDFr5iOAhjHPmFwmD9s1qarOeJYlNoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=MdI6eein; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-57d1782679fso7981433a12.0
        for <dmaengine@vger.kernel.org>; Wed, 26 Jun 2024 02:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1719392865; x=1719997665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lxJDkVp4n9+n100SOtMCWceyFBnjbdm10d/AO3Twck=;
        b=MdI6eeinTKb5wFX6TVzWmfAtKWgiJC6nutanQfCgFhYFzKwnKkL7v/3pJLsznjKfBJ
         iacqiS+EBV+oCwu8ShFQwZfNmgwB60BWrwndZfzDKYFY5o4b6vpMN73x9DHEzxH5rZpK
         2XZFmeEribEfd9fSqP7EcxjL5WLNYI/Xe55F0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719392865; x=1719997665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lxJDkVp4n9+n100SOtMCWceyFBnjbdm10d/AO3Twck=;
        b=ri+355iR6VN+TcMU7jIckd7xrn3yaeFuGIO2jfHrPsyNXLTG30UVFg2rOgWzF2+EA7
         sYl7mc9rK4gOnjlAfH+iC2e7eY5FQh1Q2r++d29i9sOn2PTOJW9oAsMpX2lY7Z0OKAmS
         eywgxGdVhoHouJvBuHY0KjsLaeOyhMOdE9OSkomdrR4KRUwpeR3dsjuwMdLNYLP++fUq
         XHNe1lKd1jdtons0C7aIWjGXdGnXdpYn24mbALrgUuL/iUoWi5mHPhHMxOJ5mVmLG5BS
         Nj0//h3jlepaUbCipC5JtYEDvyw9r3FVRLNuBC5YUpAyd3n6pQDW1ganlozesjSiQ6gE
         GPYw==
X-Forwarded-Encrypted: i=1; AJvYcCXzPKpjtcwLVHZ7luybJdkCh3AVpJyL8D5jo0tsk7RsuCxvj8UaPHFkFd+GGKahtvBGzloSbQhOyPUCeg5QGdxqR6wF+11R4Xih
X-Gm-Message-State: AOJu0YyZ1nu8mJRUrJnyIzpII8gCDKqhfucHc+ZCHky0rBAwVE7E/EZd
	lT7U33MoDdyvaQbjW5Z2nqt3/FrYTv81xGb0OgQwfuFR5URNq9GICmj8QsrM+J3SvknmEQupdiH
	dsMJk1VetC76CeuMZ0u8o1ZJT1ppftq5MmtlCAg==
X-Google-Smtp-Source: AGHT+IHykAPt//reChktNIqv1b8u1tQWErhzQtFS2JSTQpUaKUXwg3goKPI4W/qQKafT4xUP3B30jIrlQPXEK6H9lgE=
X-Received: by 2002:a50:9350:0:b0:57d:24ce:cbc8 with SMTP id
 4fb4d7f45d1cf-57d4bdcedebmr6248778a12.31.1719392865433; Wed, 26 Jun 2024
 02:07:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240626084515.2829595-1-make24@iscas.ac.cn> <AM6PR04MB594141B66F1DEB2354ADDF7B88D62@AM6PR04MB5941.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB594141B66F1DEB2354ADDF7B88D62@AM6PR04MB5941.eurprd04.prod.outlook.com>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Wed, 26 Jun 2024 11:07:33 +0200
Message-ID: <CAOf5uwkrGGPrfAcHO_hDQEZMvBHZ5JR9B=7=COSJLGjQV307SQ@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mxs-dma: Add check for dma_set_max_seg_size in mxs_dma_probe()
To: Peng Fan <peng.fan@nxp.com>
Cc: Ma Ke <make24@iscas.ac.cn>, "vkoul@kernel.org" <vkoul@kernel.org>, 
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, 
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, 
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

On Wed, Jun 26, 2024 at 11:02=E2=80=AFAM Peng Fan <peng.fan@nxp.com> wrote:
>
> > Subject: [PATCH] dmaengine: mxs-dma: Add check for
> > dma_set_max_seg_size in mxs_dma_probe()
>
> Please read
> https://lore.kernel.org/all/ZiocjS6tbeTt2mPD@matsya/
>
> Regards,
> Peng.
>
> >
> > As the possible failure of the dma_set_max_seg_size(), we should
> > better check the return value of the dma_set_max_seg_size().
> >
> > Fixes: a580b8c5429a ("dmaengine: mxs-dma: add dma support for
> > i.MX23/28")
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> > ---
> >  drivers/dma/mxs-dma.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c index
> > cfb9962417ef..90cbb9b04b02 100644
> > --- a/drivers/dma/mxs-dma.c
> > +++ b/drivers/dma/mxs-dma.c
> > @@ -798,7 +798,9 @@ static int mxs_dma_probe(struct
> > platform_device *pdev)
> >       mxs_dma->dma_device.dev =3D &pdev->dev;
> >
> >       /* mxs_dma gets 65535 bytes maximum sg size */
> > -     dma_set_max_seg_size(mxs_dma->dma_device.dev,
> > MAX_XFER_BYTES);
> > +     ret =3D dma_set_max_seg_size(mxs_dma->dma_device.dev,
> > MAX_XFER_BYTES);
> > +     if (ret)
> > +             return ret;
> >

If the function returns an error then you should check for it. If it's
not logical to have it, then you could
make void the function that is called and WARN_ON on an illogical situation

Michael

> >       mxs_dma->dma_device.device_alloc_chan_resources =3D
> > mxs_dma_alloc_chan_resources;
> >       mxs_dma->dma_device.device_free_chan_resources =3D
> > mxs_dma_free_chan_resources;
> > --
> > 2.25.1
> >
>
>

