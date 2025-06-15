Return-Path: <dmaengine+bounces-5474-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 02C92ADA265
	for <lists+dmaengine@lfdr.de>; Sun, 15 Jun 2025 17:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A35FF188EFB8
	for <lists+dmaengine@lfdr.de>; Sun, 15 Jun 2025 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D691127AC3E;
	Sun, 15 Jun 2025 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djDKeMJf"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80827B4F9;
	Sun, 15 Jun 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001937; cv=none; b=cdJwBVF6z7dKcuC0jdZ7evc/9s1mndkT1ebZ4/pLdOecTlCiYH5uiyyaopPbrLTDbshfWi4rY/9dh1C+KINlrodHItWKyyDbgKJ/ZeQdyeWluwKVg5DvT4OHLU4yupoM/ItL6uILlfx/wCQ6U5k6NDO2rPudAE6E1IaDc2v5R5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001937; c=relaxed/simple;
	bh=Qe6Shilu7HNdH7Cf+5SwJEQwPbJdRgtKIZLinXtUYwU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XNuVOkdzmfS9n73ywVcbkmnDWu403LERc1xP1RaD7SMhLt4L1BgqcEm1++INmJ2tv4YIOxg7mCFmmlmcIt1RNVJRIUTIwe/uASP/q/ox5kZ7WW3CQo2lw3L5YfgODE3rpJXbLwRlch1gYHXuYQSIPYIfWPIyG3BdC3fv0yR8gC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=djDKeMJf; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-450cf214200so31064695e9.1;
        Sun, 15 Jun 2025 08:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750001934; x=1750606734; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qe6Shilu7HNdH7Cf+5SwJEQwPbJdRgtKIZLinXtUYwU=;
        b=djDKeMJfrRs6djWWX5wAnBdumD8fjlHik75C1X2Jkk0xnH7jNcW7N6DJTV8QTlRxVe
         NIwJAcAEBVcf/BTaxhbZbxJpte0TSC05hKwMGJ8BjuKwG6uHt9cE7jVGi60dYwb6JyTq
         RDWNWl9g1Zd82+WPGqZtBZAgD4oYYNUQXz0fBPx9rxHlLF+TqGQ/jrZG8nvJ0KMSa9jE
         zEDuT63VWjtisgFJTnfj0Isf6X89dhd09obaKEekD2pkAX8G/TMRYKtPfRTUizNRzQln
         4cRKXyxGbGZe2r8OMg8niS0GtPSOQTfmeoaGNINDWHL+ktxcffbFse4QREyommf7D6tJ
         aoUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750001934; x=1750606734;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qe6Shilu7HNdH7Cf+5SwJEQwPbJdRgtKIZLinXtUYwU=;
        b=NgixPS6dKJkSQvnra029yzZJ5KTZf192NAlScSDp/rZ9jcxlJnTRd3zA9EL0IWJ0+Q
         NLDjzUCGjaOuRco88b48Jfy1BjWI8XHc9xQhNAKDBMsaykJNONIvqxBB9hFYqw/fpEuW
         rqk28L05mIRvI97AYbfVyGlbcb7mbUc0r6zz/HkhWKyJXmEkFb/HlEpfD+a5M2uT12y2
         qMBzWSE+kS6e6+CkNa0ewOLOiFg6wf2bnMuLK56dg6VXkiClTy7dsyIsU61msAjCGiDO
         L/4zmaeeNv5shzBSQROS6m22Qp8oXn8ZvBTvFns09ILGeywt9CP//wHlAuHq8P0dfrim
         xHNg==
X-Forwarded-Encrypted: i=1; AJvYcCURw1frScXCgNkzmJL1tnyzwEyk99CZyR2BXLIC+q+IyzR33020Xy3j0YeZ6c+h0MmFd6Oosteo3M/Qi9H5@vger.kernel.org, AJvYcCWce4hJafVXWN3AkvTkDewDlklpNyT5JjhE71aEyJja2nSUtc392IRMb+1dCf+qK4Shx3OTxCW/OdB2@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1D6cXTASCxyqQUvM5klzq9Bwukq14JiYZbLKhR8Zoev3BI8AY
	k1ZvTvo0/kqKKrYCQ0dHDKmYUe+QCu6MLqsVEzw/eXwNnRoz0Z/nXNRI
X-Gm-Gg: ASbGnct/ZTzYseH5QNKYw42VE21TO7P6Et5f6wu8b9RtZj8Br7Ej9zQUgp/YmKo0Iqu
	tewnggwH1ZUVldCmIWEuoGhM0qRNsMoqLkF8by36tWibwbe+pHwfJdSjqQ7N+65Uqf2RjuWeZYA
	jlxqWFZQUO1MiuBSPSfou09teJaoFNA8Rafroi4txb2Cs09mQWuY17Gy+PIV/9Xqqp9E9Fdvwon
	uZpBf1Fbjve+ZTz5oM6/VgUNA7VlhbijqYTbC9upShHj/BLO8idBpYfDIUS69gkoGFLYOONuQGL
	WqfKDrTMzfO+OjStvqvzHWbQrB1Q2PeGBh6DadyFCxUkHTyMz7L+Tc6xxb6HYXO4zVP1LSkwsNf
	FtCgS4w==
X-Google-Smtp-Source: AGHT+IGM1N0DYCxpTEmsEntEQYJyHGWXdzg0ibk6tQMpo/pKHCYqDtPWIrJWX2KzhfQvaFKskAJ3Jg==
X-Received: by 2002:a05:600c:46cb:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-4533ca5f35emr60057845e9.4.1750001934191;
        Sun, 15 Jun 2025 08:38:54 -0700 (PDT)
Received: from giga-mm-7.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e232b68sm111179995e9.10.2025.06.15.08.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:38:53 -0700 (PDT)
Message-ID: <efce5e1909ead19a46c87fa36652be70e9233161.camel@gmail.com>
Subject: Re: [PATCH v14 2/2] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Vinod Koul <vkoul@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley	 <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Paul
 Walmsley	 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou	 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Yixun Lan <dlan@gentoo.org>, Longbin Li
	 <looong.bin@gmail.com>
Date: Sun, 15 Jun 2025 17:39:06 +0200
In-Reply-To: <20250611081000.1187374-3-inochiama@gmail.com>
References: <20250611081000.1187374-1-inochiama@gmail.com>
	 <20250611081000.1187374-3-inochiama@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks for the patch, Inochi!

On Wed, 2025-06-11 at 16:09 +0800, Inochi Amaoto wrote:
> Sophgo CV18XX/SG200X use DW AXI CORE with a multiplexer for remapping
> its request lines. The multiplexer supports at most 8 request lines.
>=20
> Add driver for Sophgo CV18XX/SG200X DMA multiplexer.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Successfully tested with USB series in host mode on Milk-V Duo Module 01 EV=
B:

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/dma/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 9 ++
> =C2=A0drivers/dma/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/dma/cv1800b-dmamux.c | 259 ++++++++++++++++++++++++++++++++=
+++
> =C2=A03 files changed, 269 insertions(+)
> =C2=A0create mode 100644 drivers/dma/cv1800b-dmamux.c

--=20
Alexander Sverdlin.

