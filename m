Return-Path: <dmaengine+bounces-1450-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB02880994
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 03:28:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A32691C2207A
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 02:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58756C8E2;
	Wed, 20 Mar 2024 02:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWsnwBvu"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8872E8C0B;
	Wed, 20 Mar 2024 02:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710901681; cv=none; b=k4p6PSDktVMvCqLITyf1n5/Ap3NYXddxqKfI/GFlTRQ1Re9M3/lZ0CToYI3BeQFlY/Io6u7BvAFZlB32VD40bXfbVxPVLDiGQJ0a/Njb4BVlF4WpQhoRdo+v3uf4pggpLtdmuB0sIqOSY+qUO4JPkMh+YdxDSc6XNM7ooBTiqO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710901681; c=relaxed/simple;
	bh=CrEDZNktWLaecr9rY/RqMJilDdld6VN4fBZu4A2CU4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2pHXomeFIvk/LTinQ3G41/8VbyVgJskimDdBz7F6jWJSXSVRAyUKCOiy6WCy+Mg7k9WNSpnKwWvx8BLcfCwqV84Ji4Q8yXHWgisJeGs0/lMRwOZdsJW5WVHgHsFeK8kHIP+jmY1KOYEq4ctFC5h6rZ+OFCHCES6TDmAqq6no3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWsnwBvu; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56a2bb1d84eso797699a12.1;
        Tue, 19 Mar 2024 19:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710901678; x=1711506478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CrEDZNktWLaecr9rY/RqMJilDdld6VN4fBZu4A2CU4A=;
        b=jWsnwBvuUoWHGHVnDfaNmIDjd7pxM6Hv1OsVRUoo3Ghp7lLlvaQvF0r+rpTaSYgezO
         vqfRRas+vt+z7YnK272XaFKLgk72RRA99gsokPAvMu6b55ihsoeUDE37vPDNx810puDq
         IjsSPC0+cnkBxu9RzQd/NBc9jAqTpYcLxsv2/Py/LAi7l8mXpeJ5tCdiCI/dp9DhPHZU
         2jnDhIX3AQX8uctCgufkk35YgUYo/a9Rbs7e3FdlfC8sH5xsi67KtDwW1B/rydi1vFR6
         DsE07RIEcENBA/UBMaj0I3sftbIxUrrR2Jh0AQgh5+RQzS0PEiktKUQeL3CMFqRMDTDM
         f7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710901678; x=1711506478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CrEDZNktWLaecr9rY/RqMJilDdld6VN4fBZu4A2CU4A=;
        b=XPoobr/fu/jhLsQqrT2hku2wqD2kaNsLeggnjy6y1vk6ZrK3P0D4x+dnfKSagq5cTk
         9O4WCOEMhO1Z8zqwWNx7SVw2TCNqaf1KiXqBb8hxQjYq9h6q6aryNOyKSEWNXtC1wp07
         uu0ihCa+naayZcAeJAnN6t1/6EBEiVMcLaJxg/uvw1jYn7iQA3n+AdZm+hXbOHrP1qwD
         HHoRlFcXjc28lm+xeIohw1rl65X9rycTshd5k+X0qrdo+SH0sTOkxUIX01Vf+ILxgzuL
         4DThtyc2oXoAZ5+2bJ/Ns8n77NeBZQIGz2wf+9EULMgruOHO+Q6GxsNPrZG+VB/FD4al
         nkhw==
X-Forwarded-Encrypted: i=1; AJvYcCVnUAKtmtEiS+4RQ9TzFa/RELa+CfoM9HCH0jkM5uUoh5ikj5+vIiYwxknfGyZXzMTBgNExmaVPL43bBvfibc3+LsaPUR5HKVDGWf4TKuGTnCL7ze/kZq1KYpn9rQuEwSZ5nS6eQldFkPIOwca4aFsaVyJGFVi2hX/hmNyXABYlOz5t/CXLlOGuVBarns8+iPFbd0wYoc16Wx0/c8vq9Ao=
X-Gm-Message-State: AOJu0YwYrjLTy9IWFY7tjftP7KARVI4UwfiqeECIc03Y3L2qSqQ/0sHt
	LI1HSLBFt7xzEkz7Pn7WIqeVCC8xtTmPSRj9NtXwk120ywSupjzdcPTRjBoMuyPYp4YqCKsNDow
	5/q6PJmfz94it1kFyM15oIYteATM=
X-Google-Smtp-Source: AGHT+IFt/7I86CbjlI0gZQSF/qcTE6qkqcQl29FokubkU6RSRoHeUOxDw6UA1S3xokrCdi4OqK1Tz8KHuh8CHwiixEY=
X-Received: by 2002:a50:9e61:0:b0:568:a8f5:d47d with SMTP id
 z88-20020a509e61000000b00568a8f5d47dmr3899542ede.17.1710901677672; Tue, 19
 Mar 2024 19:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316-loongson1-dma-v6-0-90de2c3cc928@gmail.com>
 <CAAhV-H6aGS6VXGzkqWTyxL7bGw=KdjmnRZj7SpwrV5hT6XQcpg@mail.gmail.com>
 <CAJhJPsVSM-8VA604p2Vr58QJEp+Tg72YTTntnip64Ejz=0aQng@mail.gmail.com>
 <CAAhV-H5TR=y_AmbF6QMJmoS0BhfB=K7forMg0-b2YWm7trktjA@mail.gmail.com>
 <20240318-average-likely-6a55c18db7bb@spud> <CAAhV-H4oMoPt7WwWc7wbxy-ShNQ8dPkuTAuvSEGAPBKvkkn24w@mail.gmail.com>
 <20240318-saxophone-sudden-ce0df3a953a8@spud> <CAJhJPsXKZr7XDC-i1O_tpcgGE9c0yk7S9Qjnpk7hrU0evAJ+FQ@mail.gmail.com>
 <CAAhV-H5Gm6mACV4smxDB=BJvLr8C1AmgY=mMqfNYOOxEUBhqFA@mail.gmail.com> <20240319-trimester-manhole-3bd092f3343f@spud>
In-Reply-To: <20240319-trimester-manhole-3bd092f3343f@spud>
From: Keguang Zhang <keguang.zhang@gmail.com>
Date: Wed, 20 Mar 2024 10:27:21 +0800
Message-ID: <CAJhJPsWN24p8VcLeeB8v_JU6KXTVBzWWcE-Aj4Tc2urqx6sYrw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
To: Conor Dooley <conor@kernel.org>
Cc: Huacai Chen <chenhuacai@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 1:41=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Tue, Mar 19, 2024 at 10:40:54AM +0800, Huacai Chen wrote:
> > On Tue, Mar 19, 2024 at 10:32=E2=80=AFAM Keguang Zhang <keguang.zhang@g=
mail.com> wrote:
> > >
> > > On Mon, Mar 18, 2024 at 11:42=E2=80=AFPM Conor Dooley <conor@kernel.o=
rg> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 10:26:51PM +0800, Huacai Chen wrote:
> > > > > Hi, Conor,
> > > > >
> > > > > On Mon, Mar 18, 2024 at 7:28=E2=80=AFPM Conor Dooley <conor@kerne=
l.org> wrote:
> > > > > >
> > > > > > On Mon, Mar 18, 2024 at 03:31:59PM +0800, Huacai Chen wrote:
> > > > > > > On Mon, Mar 18, 2024 at 10:08=E2=80=AFAM Keguang Zhang <kegua=
ng.zhang@gmail.com> wrote:
> > > > > > > >
> > > > > > > > Hi Huacai,
> > > > > > > >
> > > > > > > > > Hi, Keguang,
> > > > > > > > >
> > > > > > > > > Sorry for the late reply, there is already a ls2x-apb-dma=
 driver, I'm
> > > > > > > > > not sure but can they share the same code base? If not, c=
an rename
> > > > > > > > > this driver to ls1x-apb-dma for consistency?
> > > > > > > >
> > > > > > > > There are some differences between ls1x DMA and ls2x DMA, s=
uch as
> > > > > > > > registers and DMA descriptors.
> > > > > > > > I will rename it to ls1x-apb-dma.
> > > > > > > OK, please also rename the yaml file to keep consistency.
> > > > > >
> > > > > > No, the yaml file needs to match the (one of the) compatible st=
rings.
> > > > > OK, then I think we can also rename the compatible strings, if po=
ssible.
> > > >
> > > > If there are no other types of dma controller on this device, I do =
not
> > > > see why would we add "apb" into the compatible as there is nothing =
to
> > > > differentiate this controller from.
> > >
> > > That's true. 1A/1B/1C only have one APB DMA.
> > > Should I keep the compatible "ls1b-dma" and "ls1c-dma"?
> > The name "apbdma" comes from the user manual, "exchange data between
> > memory and apb devices", at present there are two drivers using this
> > naming: tegra20-apb-dma.c and ls2x-apb-dma.c.
>
> I think it's unnessesary but I won't stand in your way.

Then I will follow Huacai's suggestion.
Thanks for your review, Conor and Huacai.

--=20
Best regards,

Keguang Zhang

