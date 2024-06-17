Return-Path: <dmaengine+bounces-2377-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6347090A582
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 08:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 551FC1C242E3
	for <lists+dmaengine@lfdr.de>; Mon, 17 Jun 2024 06:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E3E184134;
	Mon, 17 Jun 2024 06:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nhx7Z4yO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7AD1822C2;
	Mon, 17 Jun 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605464; cv=none; b=g0rk7R+T4jhvjGJgSEehSkowznQJH+A5Nz8kW4CZPSWB8YjS8pa8sb1tVZCMi+5mCTM+vi0ZGLvmeh1Yn/x+MK6B27ZRY54w/VWEJMIdDiQK+IAgEjL/vIV+I3pL3kA2gmZurqkzt/+bbl/ponpk9BYW7Z0xIa/XnN75A7CKiLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605464; c=relaxed/simple;
	bh=5BA/TosT1CrxQE3NyCIfG5vCxzPOaTI0joE23Fx2Gqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tms/TgXBIw1OSJx5lvQorZGvQrM/Wx9RUy7+vc2jDR+eatZojMstDT+ZwnkIZw+K6zD1sr1DGWWT+VcZ4rfClTeBncwDwpiAnABZCsJMxn2gFpIiUdlf3IppYvH0HXna4O1kowACmfezJAs6ozecPjm5/kwsfggnkl8+Fz0tgbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nhx7Z4yO; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6f85f82ffeso80716866b.0;
        Sun, 16 Jun 2024 23:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718605461; x=1719210261; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5BA/TosT1CrxQE3NyCIfG5vCxzPOaTI0joE23Fx2Gqc=;
        b=Nhx7Z4yOw3F3MGDZn5mu0NdH0OPM80B1d1mWj+xqI2VyRyNdGA1j0pwsmm4x/c/Yd7
         BPZlzsht1k4P0pezqeRp3a16eErUJ4jg9QNAftMtE4iUe6wI51T4ME4OJV1MlOJOCvlF
         bB160rUY3wwHs0iPDfI5Mi/NT93vDAfYmkh8CgdJDvsveNYEsqHrVSmpjOFird8XLYRC
         OKBmXW2TJfP+jZZc4J/sfsmRs9cMNbKc3egsv35m0zOoP3uRRXSgp1KUKCHyzeUHxg04
         +hz8mbHAnqZqR052L/0K1DxR6rau9bq23bcNp41a2ws3vs5kgua5YcsIfQhsyhsHoz2+
         qMbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605461; x=1719210261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BA/TosT1CrxQE3NyCIfG5vCxzPOaTI0joE23Fx2Gqc=;
        b=VwcxIpgydbh4zeiqWzpt57lMK9OVy3ubvu8nS5gg34QPavW3ZeWPUhWYumQihSx7Zm
         sDF52LZk2IOTReiBd4vkEqpoJGMgGrV0Vy8iwin8DYytIoeFXE2teKny/nBjtpLreu0V
         LEN2gHXGykVVNEx4b3hZtICka+h2zCECUsRZiYKLQdcVr5Phfy/z9AQj7VTLPCvLtbUV
         +VpdotM7mGEg1x01PEFjGpxCUtzATzfRbpJy1/vDWHItEo9e1Oe/BJH003hT4otfYR4Y
         2yu9su+EDBb0PyUrcesMXJwIAz8gHuiKBr0LFjnLzBCv+4XMJZqe7wT5tFa0wIdmtBsM
         z11w==
X-Forwarded-Encrypted: i=1; AJvYcCVbcqmFb8dv74WH6IhdgGWPpUSGDc7h3j9t1jqtvvC206LRdc0peyarFtJyzr+27K4SCkbKV8S/eCGvOn3q+66Na9wyYg/spIXoXBEMC4QbIT1ZhakrsuShH460yGas0yr4SZGziTAz+ZJ33Z1SGurwusktd/ReMtwTcquThv+mWnKE0FBG0OTPy7A2Y51T0kYg+7A8Is81nEaH3rAlNSN8MkN6/PgEddHXTE1a0lJ36m3Ifzf2v9XcFuU=
X-Gm-Message-State: AOJu0Ywx1RO0jnCu/JjVqEyzWSrFkglHgO4lEQBHrIPyfzcQE6+kJwFG
	R3PDn6yyMIRCA7uXQ7JTGhNpv73+HalKHrwv5uvHUBpZF62pDtzy
X-Google-Smtp-Source: AGHT+IGwPJh8PW95cQ3TUh8Rt+F4WZpn4rbG8t7MJQz99Y0NFynHP5+QpRL00FDtWKBhhin6up50sQ==
X-Received: by 2002:a17:907:c003:b0:a6f:6b6a:e8d2 with SMTP id a640c23a62f3a-a6f6b6aec48mr560764166b.11.1718605460884;
        Sun, 16 Jun 2024 23:24:20 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f7c12f7c0sm191184366b.198.2024.06.16.23.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 23:24:20 -0700 (PDT)
Message-ID: <f0c709e3bf3f1ebfac29274b8f7182df9022376e.camel@gmail.com>
Subject: Re: [PATCH v10 3/6] iio: core: Add new DMABUF interface
 infrastructure
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Paul Cercueil <paul@crapouillou.net>, Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Jonathan Corbet <corbet@lwn.net>, Nuno Sa
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Date: Mon, 17 Jun 2024 08:24:19 +0200
In-Reply-To: <0cdcf83a1ab7c199244d4a00157f6fa8979ef819.camel@crapouillou.net>
References: <20240605110845.86740-1-paul@crapouillou.net>
	 <20240605110845.86740-4-paul@crapouillou.net>
	 <20240609105302.07de907a@jic23-huawei>
	 <0cdcf83a1ab7c199244d4a00157f6fa8979ef819.camel@crapouillou.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-15 at 13:07 +0200, Paul Cercueil wrote:
> Le dimanche 09 juin 2024 =C3=A0 10:53 +0100, Jonathan Cameron a =C3=A9cri=
t=C2=A0:
> > On Wed,=C2=A0 5 Jun 2024 13:08:42 +0200
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >=20
> > > Add the necessary infrastructure to the IIO core to support a new
> > > optional DMABUF based interface.
> > >=20
> > > With this new interface, DMABUF objects (externally created) can be
> > > attached to a IIO buffer, and subsequently used for data transfer.
> > >=20
> > > A userspace application can then use this interface to share DMABUF
> > > objects between several interfaces, allowing it to transfer data in
> > > a
> > > zero-copy fashion, for instance between IIO and the USB stack.
> > >=20
> > > The userspace application can also memory-map the DMABUF objects,
> > > and
> > > access the sample data directly. The advantage of doing this vs.
> > > the
> > > read() interface is that it avoids an extra copy of the data
> > > between the
> > > kernel and userspace. This is particularly userful for high-speed
> > > devices which produce several megabytes or even gigabytes of data
> > > per
> > > second.
> > >=20
> > > As part of the interface, 3 new IOCTLs have been added:
> > >=20
> > > IIO_BUFFER_DMABUF_ATTACH_IOCTL(int fd):
> > > =C2=A0Attach the DMABUF object identified by the given file descripto=
r
> > > to the
> > > =C2=A0buffer.
> > >=20
> > > IIO_BUFFER_DMABUF_DETACH_IOCTL(int fd):
> > > =C2=A0Detach the DMABUF object identified by the given file descripto=
r
> > > from
> > > =C2=A0the buffer. Note that closing the IIO buffer's file descriptor
> > > will
> > > =C2=A0automatically detach all previously attached DMABUF objects.
> > >=20
> > > IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
> > > =C2=A0Request a data transfer to/from the given DMABUF object. Its fi=
le
> > > =C2=A0descriptor, as well as the transfer size and flags are provided=
 in
> > > the
> > > =C2=A0"iio_dmabuf" structure.
> > >=20
> > > These three IOCTLs have to be performed on the IIO buffer's file
> > > descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
> > >=20
> > > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Need a brief note on the sign off chain.
> > What is Nuno's role in this series as he's not sending the emails and
> > not
> > marked with Co-developed-by=20
>=20
> That's a good question. I think he sent one revision of the patchset
> (v7 or something like that) so he added his SoB.
>=20
> (Nuno: you confirm?)

exactly...

>=20
> I'll add his Co-developed-by then.

Not sure if that is really deserved :)... Maybe just remove my tag.

- Nuno S=C3=A1



