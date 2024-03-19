Return-Path: <dmaengine+bounces-1436-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD6C87F582
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 03:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271C1282BF1
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 02:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D0F7B3EB;
	Tue, 19 Mar 2024 02:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dsm3ozNn"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5FF33FE;
	Tue, 19 Mar 2024 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710816066; cv=none; b=a5QgEmxMUYTxQZKIul/MyLF5K8TRhxv4O/mk8U9FuHCxSF+ksMlrrWepYS55+bkq4vBk5FW4PpjPxBLPiZ5kpMqWw0yyyTyFn26g3Xa5u8HUb5ZvKN1NLAGtlVewAtPtn7Epw0mHD8xD04KGn+NyzP/q0qgpF68dOXh+678KJgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710816066; c=relaxed/simple;
	bh=3ub4ncvqYvXyiNVjOCBt4ba6/O87K2dqhXmuWt7lj4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VnzLbYG5ku19+Othy5Ugz0ODC5/CXyRbmXPHLmS25Y+XLT1o4PHUfPEYUiwDVDkEHiPfLsMm6qcMCDMd+lp3mm0RcfYan8JPBqHgNNNQRdXf76YSjAd8NFTxasOXZeSRjMyjhyNpHBFNBEto/Nl5Bgw38EGkd8d6Zx+nDtc9KkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dsm3ozNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE420C43399;
	Tue, 19 Mar 2024 02:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710816065;
	bh=3ub4ncvqYvXyiNVjOCBt4ba6/O87K2dqhXmuWt7lj4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Dsm3ozNngtqNbRPQU4pz65ZAyGsxlfuf1a9Pjc4UzHb9kkq+kbMKnfypQ5HMlEt+k
	 vQFRMJN4AekNBUzy/XxZyAknNgr55M2FyffxcSxMC4a7I1bv3t8x1tIrwVC6iY6usv
	 cbTf0VwcSwexkvKDpiAp24pmZp9npKSUbjIl9jb384RoSheOIX7umNVfg8emqkOL53
	 XQdkDaFKaohbjf7oNP59NalRf/uysHzH540pXRmEd1/i1T2MJGyTpBusQUuyuW16ZK
	 ugUr7vXxq1PHgFP3jCHgzfAKoHO9IVPBGuerFN90xP/QXUS3Ved8WV4dcM/y9FNeF7
	 bsCO1FbA0wdbw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-513d3e57518so5365189e87.3;
        Mon, 18 Mar 2024 19:41:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWc0tlZ4JdhBx2D8ghnNG5nacbCZ9YC7Q8etr5P6KBnerdPseFZhyuYZ/hmLJIlasNSvljJjjHHQaB5+BWq0CyVUjiX67JA7CPQyBzgoctqG/ZOaHorEu4107SZ449u8a/ssJ7iboVCyK+SO6cGtr75WbF7ZdFM02tO/vlPWbgVJbOXtBaPPW+ry01cgMwqUH8c8FQ0PSp6MzOl/LLbOOk=
X-Gm-Message-State: AOJu0YyTo1xlEm2qUo7oTSNeZhP+frLOhxuIINSw4Kqj+0DpI/TTS7F1
	H/U8q2tZllr1cN6cW3sSdsmaFkoKxBsRPwi5ZCYEbpTrel9abmJ4uuNVQFwLtERBJjOAsoEtqfS
	nfXA0mBBlSQexHoBR98dA3lgQZjo=
X-Google-Smtp-Source: AGHT+IGV97VjOSsYVFgOZWmkNKgxKdHut2PXg2d4iYsFbh+2T05kimd5E/BwkdwGxnlPNv4kX7fg1f2FWwe7xmsCqPM=
X-Received: by 2002:ac2:5f91:0:b0:513:c9a4:5ee5 with SMTP id
 r17-20020ac25f91000000b00513c9a45ee5mr8911556lfe.30.1710816064094; Mon, 18
 Mar 2024 19:41:04 -0700 (PDT)
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
In-Reply-To: <CAJhJPsXKZr7XDC-i1O_tpcgGE9c0yk7S9Qjnpk7hrU0evAJ+FQ@mail.gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Tue, 19 Mar 2024 10:40:54 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5Gm6mACV4smxDB=BJvLr8C1AmgY=mMqfNYOOxEUBhqFA@mail.gmail.com>
Message-ID: <CAAhV-H5Gm6mACV4smxDB=BJvLr8C1AmgY=mMqfNYOOxEUBhqFA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Add support for Loongson1 DMA
To: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 10:32=E2=80=AFAM Keguang Zhang <keguang.zhang@gmail=
.com> wrote:
>
> On Mon, Mar 18, 2024 at 11:42=E2=80=AFPM Conor Dooley <conor@kernel.org> =
wrote:
> >
> > On Mon, Mar 18, 2024 at 10:26:51PM +0800, Huacai Chen wrote:
> > > Hi, Conor,
> > >
> > > On Mon, Mar 18, 2024 at 7:28=E2=80=AFPM Conor Dooley <conor@kernel.or=
g> wrote:
> > > >
> > > > On Mon, Mar 18, 2024 at 03:31:59PM +0800, Huacai Chen wrote:
> > > > > On Mon, Mar 18, 2024 at 10:08=E2=80=AFAM Keguang Zhang <keguang.z=
hang@gmail.com> wrote:
> > > > > >
> > > > > > Hi Huacai,
> > > > > >
> > > > > > > Hi, Keguang,
> > > > > > >
> > > > > > > Sorry for the late reply, there is already a ls2x-apb-dma dri=
ver, I'm
> > > > > > > not sure but can they share the same code base? If not, can r=
ename
> > > > > > > this driver to ls1x-apb-dma for consistency?
> > > > > >
> > > > > > There are some differences between ls1x DMA and ls2x DMA, such =
as
> > > > > > registers and DMA descriptors.
> > > > > > I will rename it to ls1x-apb-dma.
> > > > > OK, please also rename the yaml file to keep consistency.
> > > >
> > > > No, the yaml file needs to match the (one of the) compatible string=
s.
> > > OK, then I think we can also rename the compatible strings, if possib=
le.
> >
> > If there are no other types of dma controller on this device, I do not
> > see why would we add "apb" into the compatible as there is nothing to
> > differentiate this controller from.
>
> That's true. 1A/1B/1C only have one APB DMA.
> Should I keep the compatible "ls1b-dma" and "ls1c-dma"?
The name "apbdma" comes from the user manual, "exchange data between
memory and apb devices", at present there are two drivers using this
naming: tegra20-apb-dma.c and ls2x-apb-dma.c.

Huacai

>
> --
> Best regards,
>
> Keguang Zhang

