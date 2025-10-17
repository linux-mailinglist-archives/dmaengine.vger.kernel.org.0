Return-Path: <dmaengine+bounces-6876-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0309BE7E9E
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 11:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92CB9427EC3
	for <lists+dmaengine@lfdr.de>; Fri, 17 Oct 2025 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DD12D661D;
	Fri, 17 Oct 2025 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0MaXotk"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757592DAFDE
	for <dmaengine@vger.kernel.org>; Fri, 17 Oct 2025 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760694987; cv=none; b=L16gEcIYHfvHOfEtTCO/L0BJncQIlOBIImEF6rTzHrE8y/7LyRXyFI7LbQlbnqKDKF3aJH9hBdvhWKcq+pQiEH1e7pxd8badS932RwWXWXb6+gGbag/aT0P3dl3TYqS3abR6Dm9PLmM2DIz4izBJhI9MDau9jOLW85lRSY1rsao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760694987; c=relaxed/simple;
	bh=rEcdNUhnQkS0I5XtW1CoPlxA7VWZfIMER4FzkAPDWao=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMTU4ao+0ncqBQ8MeBTQfORCS5ZZOATLwMaX3UyOf9fUZZF1atEX59rV5U3AJEsvn1E9aJGDzWRevl+qiYxZ6tR8MP82EIySqMZVLsllwSbZYlnjTEU28wFdE6r4NyoF0dSjtYCcBRZp/RM4MUwMENotVt3Nf7MCKN/If+86T5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R0MaXotk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b4c89df6145so298859266b.3
        for <dmaengine@vger.kernel.org>; Fri, 17 Oct 2025 02:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760694984; x=1761299784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEcdNUhnQkS0I5XtW1CoPlxA7VWZfIMER4FzkAPDWao=;
        b=R0MaXotkaH4RqT7DXAH8f5PqEsHPR9BlgXGPi7NK+yWcJRykEc3x9+dWtc5TiiGAiI
         +Kio0+vg0scTDpNcGoX5SZ23KWMIeik6AWwbHx073MeJub+u7PZwa6d/4Lp0USz7Z6x1
         /Ydl3xpJWPCK3P9uIdFl69a4llTW0CLvUQ36G+twIOTqPA3hF4JxLAdM36hDpfp4ZPaj
         mtrcXNExS3Rjrc5DpHTABwu5V+bq4UhGW5VPXQxW/9bn1gbdYZf0lTO3a2HcnqY5NlTs
         R6QgL0mjbC3P6fzddzu889EzmzeymDPLQTdBZGLWp7JG6oe5Mxw60VdMa9SM8GYYKMMR
         DHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760694984; x=1761299784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEcdNUhnQkS0I5XtW1CoPlxA7VWZfIMER4FzkAPDWao=;
        b=LbkYEYo7ABMsYz2AYSmmWnFNULUV+Ah3CxOpACnciiEk22haoiQCN682lygwiy9iuB
         x9ziV/69npWhH2A+DpIXmGeqf21gom5Og1gcaHFX0S+3VYxRJcMLGL3qLm7mjwIfiiAh
         57ekXIC62pQLQ6cy9XvAeXosRyzbhZOg110C+4kukaP1uPUbykYID47yp+34ec9bqWFe
         RPY263WkyW61Fhvywv1CTxjKXpUvvFPl/PoaqdVL56iqvcrg0ZqHDwcc1+sZpdCwQ/X1
         erE3TyPDFrtJIfLlxswuH+ctvu1XOKmYYwhkpclIBdeFprRe63Oz8WCCqci63MtZeoJA
         0X+A==
X-Forwarded-Encrypted: i=1; AJvYcCW9dspkfOp8VwR1Uzs6pD8VzRxFud1+oC3M7ZJZyADQR35mWnbI04g1v8OXGvbbJpNcZNwcsOS87SU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQxDjhLkpgNixG9mRA/dyDVYchF004NeaSPLXeQ9BN151UJadh
	My5/0pwEUC1SdS7IGpOC3p7UKBS9hx0DYqavYq4P3eX1l0Yn4OWNn25G5ZZXUpkHe+oJ5kVylq5
	onE03ZXXzja64keAUwkjYfADReSoLwpmfDOQuIFCndQ==
X-Gm-Gg: ASbGncs0e7wD3UHu01NU0UTN5VLSN5S9DhlhL54IwNiTYS33vvOhfKd0hkEmoecSF8l
	iGmBDMqS+oUkx/YDB5yCxa3KL7tumgSG21XhFbU+1gEyq8Z8x55jOlP3eh1SuyLm75EEyfTWDmq
	wvReW0HQtzEN/9qy1KxtE64Batc6VsolJPZ06jAJs8YnToEzXia6VYTmjxyWrukb5VGu6adzKYu
	hBmTxbI/X/oqRk3JkSBLPGWwoWldbyFoXEetZr6L+UjP8JucyO3+C98HtyRNA==
X-Google-Smtp-Source: AGHT+IHIBlLRTla75tbE4L9E1Bgzv5ZIwU4LRrpc2fLmL3EQ7rdSBDBBup9/WYitkzPac2rLYX5kvHc3YpAzwllbvVg=
X-Received: by 2002:a17:907:e8c:b0:b3d:30d8:b897 with SMTP id
 a640c23a62f3a-b6473241ed1mr303420866b.14.1760694983682; Fri, 17 Oct 2025
 02:56:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251016154627.175796-1-a.shimko.dev@gmail.com>
 <20251016154627.175796-3-a.shimko.dev@gmail.com> <9f7514c69d11a0377283fe52fa6e7558b75c7ad3.camel@pengutronix.de>
In-Reply-To: <9f7514c69d11a0377283fe52fa6e7558b75c7ad3.camel@pengutronix.de>
From: Artem Shimko <a.shimko.dev@gmail.com>
Date: Fri, 17 Oct 2025 12:56:12 +0300
X-Gm-Features: AS18NWBZMgvV7iogriyKPktuHwUDFbOQg9VA_DBN6dz8aE_cOJK2Sq_4nt-x6Cc
Message-ID: <CAOPX744yyWgZqkQaUfOf=GwQCS6MrAExP5s3Upnw-oO7inBChA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] dmaengine: dw-axi-dmac: add reset control support
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Vinod Koul <vkoul@kernel.org>, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 17, 2025 at 12:47=E2=80=AFPM Philipp Zabel <p.zabel@pengutronix=
.de> wrote:
> Missing error handling, or at least inconsistent with the deassert
> turing dw_probe().
Hi Philipp,

Thank you!

It seemed to me that these checks are not necessary in the future, I
don=E2=80=99t know why it seemed that way to me, I=E2=80=99ll fix it.

Regards,
Artem

