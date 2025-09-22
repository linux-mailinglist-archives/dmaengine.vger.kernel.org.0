Return-Path: <dmaengine+bounces-6675-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5721B91A2E
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 16:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C9032A5190
	for <lists+dmaengine@lfdr.de>; Mon, 22 Sep 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18D551022;
	Mon, 22 Sep 2025 14:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xmDGy+ST"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F26A33991
	for <dmaengine@vger.kernel.org>; Mon, 22 Sep 2025 14:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550865; cv=none; b=fBESHcWk1SX9gpfed19Ld7Z2dcFrWwnyRSR/P2Ls/W9mijRjBXOY4Xcx5f5ki+i6fxamKcp4XRUfvo7CIRQIx8buwjUEW28qeaDYxT8oR3lHszlLsWFsrrMP5KlOhMEtiyi5c9HpXFE8VhXr718vyWlZ2lTA8UPnnEQcOd7vKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550865; c=relaxed/simple;
	bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gUztMe24m+qcfCgziWRKo2Q8LXR2RRF3po/ShnNs/NboOWvQ9wZAqnbYii/X8Nyu0ODCxt8hScwssS50tBoJIcL0Vp2pO/PePYOv/B5N+EI00hQ6HzswKlV85tT7Va5676OMEy9+xvkFPMmwzY6L3XzO7DWwinwuIXkMMiQion8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xmDGy+ST; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-57bd04f2e84so1982607e87.1
        for <dmaengine@vger.kernel.org>; Mon, 22 Sep 2025 07:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1758550862; x=1759155662; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
        b=xmDGy+STUmXvdAJZ0LPjBV1yp4IwEktn7OtJPwqszQGAibeAm50CKoYPBSFDur6O5k
         YxgwbAzPbvlH17GdsSgow65hWx7+QQbk/ydzLml3jOScoZyeDOG4JEPy0L2Suu5AFVGJ
         pOW2VEF/PGAVH0iVvunzOleqiTKo2VTEcWdq8k16ndTSmuYjB/YwouiTdPQTb+2OcYjD
         vGgyTpj0TCpKNXPjXtJLKpeo7ln+JUULrnpOUP1vhsKR4UC12JT8l69KH9BQLE2bBMdV
         JMX98k6kQba0kM4u2GF/jEWhUlzOdQdS78ZV73oplEKcupAak60k75nA1BClFMwmJ8LY
         pnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758550862; x=1759155662;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ug0zAAEr5kbnK08BBV4RWvp/VJgoebn0vXwAlF1IdfQ=;
        b=kvOnHhNV+DVf1zhvdiDwfHK28Sd+sM7qAb5/2vrb5QpaBDSueDmQO/+8uZfrJsehyo
         bjfbHFif9tEU93yah9Cfk1gau9whDvo3YNPgrLyIV4QE5RI+F9a7Z4JUQVnF1iZTtjCh
         DZoQot3hmlm8SNgdxzAX2t2fuxpuYNqCuLQJ4ngf++pz8jx4UVEctYq6s5CYcoV3HkB2
         zeQ+aqBOim52h2v/gkjxPEhkQBEkm4V49GHRB9suPNldqYG4aU6Wac7BUpqbLKDJv42I
         jhqTvP15VvW88wKu9ESJKE17zNfQEmGyUsdYtbJDFqWi1uT38DanUibBFTdzQeHGLnuV
         JIlg==
X-Forwarded-Encrypted: i=1; AJvYcCVb2ZcAwfKUzKT1SmPT7pl8dSMbLk3B/rOCxCN1L+ljvgaE1cOZUp+tuOnODAPtpI5a3rdZ1a11BrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcQteXHnsGOFdLMf30Rn7wYPXPYn12hL5ejbIxFscEXLf2oYHh
	GlAU+QdRbUmf5R5Xm6ZxGOTtbMkEVl/MkMqnuOOMKG43v2HOoZhr0RudE14eavsBY/IkCvW09am
	u1dHCFloTAObWaT9SSTEMYs9Bie3fy4ONW5pca3iICw==
X-Gm-Gg: ASbGncvivbYd0qwRGsf0D8uujcIQkAcKghqmKTYlc/j2w5nUO1fM61wCdlN+D58/xjY
	JtwJK7pqXoQ+bGdgasOXHjoUaOT6j+un8tCOTp7ZBSh0f37TOFJZm02R/G1aT44aNO6+xekQi+E
	MTVoudvXn1X35QW8a2sYbgIHoIjiL5uyJkqHIiKmSfqKVqJ8zYTzUYmoI971Zqc8eSwSfZnx0ft
	ViML887xz0njjZSCY581XanW22Z/FL+IL8viA==
X-Google-Smtp-Source: AGHT+IH7ov3L6MY+/rmciyf47ro1aYeL/sC/ClPN8jzfMPrPzjD7iBzVpIdeYJWjKJ4AasrYgahlFBVLjb5jrV6WEng=
X-Received: by 2002:a05:6512:2305:b0:560:9993:f14d with SMTP id
 2adb3069b0e04-579e1b68f17mr5336192e87.3.1758550862286; Mon, 22 Sep 2025
 07:21:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919-rda8810pl-mmc-v1-0-d4f08a05ba4d@mainlining.org> <20250919-rda8810pl-mmc-v1-6-d4f08a05ba4d@mainlining.org>
In-Reply-To: <20250919-rda8810pl-mmc-v1-6-d4f08a05ba4d@mainlining.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Sep 2025 16:20:50 +0200
X-Gm-Features: AS18NWCnht0SxyHuFtw_GctfcVE1YPQlre0zCChnlr1t9VjjDpuBjNY-9qJgvpY
Message-ID: <CAMRc=Meh5WJ_C1wMjAk9CzFW729QfX_Fbq5diZ99GtsR43k8ag@mail.gmail.com>
Subject: Re: [PATCH 06/10] gpio: rda: Make direction register unreadable
To: dang.huynh@mainlining.org
Cc: Manivannan Sadhasivam <mani@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Vinod Koul <vkoul@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-unisoc@lists.infradead.org, linux-gpio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-mmc@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 8:49=E2=80=AFPM Dang Huynh via B4 Relay
<devnull+dang.huynh.mainlining.org@kernel.org> wrote:
>
> From: Dang Huynh <dang.huynh@mainlining.org>
>
> The register doesn't like to be read and would cause all the input
> to be switched to output.
>
> This causes the SD Card Detect GPIO to misbehaves in the OS and/or
> may cause hardware to malfunction.
>
> Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
> ---

I have responded to you already[1]. The commit message is still
sub-par. Don't say "the register doesn't like", say: "Reading the X
register causes Y to happen. In order to remedy it, do Z." You haven't
answered my question: what will happen to existing users of this
driver?

Also: you have not bumped the series version to v2, that makes
tracking the changes hard.

Bartosz

[1] https://lore.kernel.org/all/CAMRc=3DMeHQf_Oa2DRR0T7tum-Tuk3qPh5r5gimxGY=
3EXTyvoKZQ@mail.gmail.com/

