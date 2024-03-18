Return-Path: <dmaengine+bounces-1419-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7EC87EAE8
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 15:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 260D228158E
	for <lists+dmaengine@lfdr.de>; Mon, 18 Mar 2024 14:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2710A4C3D0;
	Mon, 18 Mar 2024 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EByKinSA"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89A5208CA;
	Mon, 18 Mar 2024 14:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772025; cv=none; b=f775+6g+OIuRhsD+N57RO69zZe5SSlyq++PwRRe3pkwRvPL06ybzACIlQuXWArreM4oqPhfOtK5BXNC9KLpQMfpVFRCdYQGddZlPUbeDaCday6mfq8YA9Q9fPXMOruwz/8QooBGStijZH+QsKE6k+PYrP4gc/TFS3xtS/8r70Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772025; c=relaxed/simple;
	bh=b2cyyjzKnYUICayyPbXTaKZuyUfiyf8ysQ9CaUjaECc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SOsz1+99/+FvNuvYiQmFdaXH1JDG1I2kIlpU59PxI7AF8z3HwceAp9JOb+zLkgaJ8+ZB9cUUqq8sI3X1WqCHO/Btjmeym4FA3g95Jsxk8H/5kgFZnVnDpoU9vAiwTvXDfTeHL+bwqz2OFN1Yeaull3XdVxRhZj5wI21a2OM9Axk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EByKinSA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B89DC43399;
	Mon, 18 Mar 2024 14:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710772024;
	bh=b2cyyjzKnYUICayyPbXTaKZuyUfiyf8ysQ9CaUjaECc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=EByKinSAHudiZFzVPsQfkQG4g1BQDVoN8aPTmx/CWtZlk7KDCLv2BU3Rqh5O1KX88
	 5MNkC4DwXc6SisaZfWusPNS9rZP3k6ZHtPlrXj8oBNJ+0EVPz7jRZZDM0GjFrtVo7p
	 b/uVxCl7Go99xF7KqJStxDEb72D4GanbYRbIV5MKUMjE6gdhiq2y8PGmv4Y99Kns4O
	 qybxW03jiZrKrHO3j+TnoA8X+m3XUZdeQT79i1evy99FpKNp6Oi3lpPQFoN/J8s3I0
	 4jXeORKrhP4YQib7O6F6OLnMhtLHcpjVGWNvhr8XgCyUiL0zEzg1pf7jSrMoiggFS0
	 GALP/l1O3U15w==
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-568aa282ccdso4165525a12.3;
        Mon, 18 Mar 2024 07:27:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUUC+0W2bIl/KUj5+cB4Am/4tAdORbqvyVZxGNOOzQrVLnlvhKlsR2BtGW/SLGTBoqS3lo8wvEaFItxN2tegwaDlNdvOMaRU32ildBEDpG5jA4ksU1SxgEFmxLdR2C/riox8+Z7yekbDT5vCEQDPQpTHM91KiQqoC0U0euUdc8tfyzh8rJe2CpWWTo4dowNcQcW2t+U5DYTo/SsM+OzJF4=
X-Gm-Message-State: AOJu0YznEZwP0UCWTL2r1CcqQPL8rKGF9VnO65+2I4DfBobyMN2gnfBQ
	g9af1L2dQZcjvdJKuug5LP1F8M6AT+d41bA2yYCb/kbRX2EHSprO6X0qQaEfqu50TE1uqDxVIX9
	ipRcV196M6WF/0/Rd7qDcvfoZM/0=
X-Google-Smtp-Source: AGHT+IHuf+qXAqqeJl2FpM9uElseUPhxl+nzd9pZnr71oH/rIuv35FharL5lu8UxXyLjwaXp90V4xKHfcbd1QWlZy0E=
X-Received: by 2002:a17:906:ecfc:b0:a46:6557:716f with SMTP id
 qt28-20020a170906ecfc00b00a466557716fmr7444525ejb.20.1710772022975; Mon, 18
 Mar 2024 07:27:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
 <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
 <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com> <20240318-average-likely-6a55c18db7bb@spud>
In-Reply-To: <20240318-average-likely-6a55c18db7bb@spud>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 18 Mar 2024 22:26:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4oMoPt7WwWc7wbxy-ShNQ8dPkuTAuvSEGAPBKvkkn24w@mail.gmail.com>
Message-ID: <CAAhV-H4oMoPt7WwWc7wbxy-ShNQ8dPkuTAuvSEGAPBKvkkn24w@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
To: Conor Dooley <conor@kernel.org>
Cc: Keguang Zhang <keguang.zhang@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Conor,

On Mon, Mar 18, 2024 at 7:28=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Mar 18, 2024 at 03:31:59PM +0800, Huacai Chen wrote:
> > On Mon, Mar 18, 2024 at 10:08=E2=80=AFAM Keguang Zhang <keguang.zhang@g=
mail.com> wrote:
> > >
> > > Hi Huacai,
> > >
> > > > Hi, Keguang,
> > > >
> > > > Sorry for the late reply, there is already a ls2x-apb-dma driver, I=
'm
> > > > not sure but can they share the same code base? If not, can rename
> > > > this driver to ls1x-apb-dma for consistency?
> > >
> > > There are some differences between ls1x DMA and ls2x DMA, such as
> > > registers and DMA descriptors.
> > > I will rename it to ls1x-apb-dma.
> > OK, please also rename the yaml file to keep consistency.
>
> No, the yaml file needs to match the (one of the) compatible strings.
OK, then I think we can also rename the compatible strings, if possible.

Huacai

