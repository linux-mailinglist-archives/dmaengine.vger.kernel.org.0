Return-Path: <dmaengine+bounces-3899-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7E89E4C9B
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 04:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE772826A2
	for <lists+dmaengine@lfdr.de>; Thu,  5 Dec 2024 03:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C4818C33C;
	Thu,  5 Dec 2024 03:23:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0938C;
	Thu,  5 Dec 2024 03:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733368988; cv=none; b=nhP7ZpGMmiWr9X2q/1qEgV4KmvwrqTyOGgEt83KHEL/H3ktyjTUe0tKv7HIP+LZFcDPSF6EUrLbWnwy0tDdTRkENwExY6Lo7AWe0Gl5bFkNRcJd5LRd4kVfmUUrqOtzET73rjIbtePZPHPIzSAPVt6jdiS4AGrQjwbvrtZGdh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733368988; c=relaxed/simple;
	bh=+EO6J8kgF5TZ6sv4dT6wkIQhsuMHYqCRsITgSQoB1/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2PCcMxfMk+CrG8I/rJQKzwP5Z2RyVnPFtrq6/MjT1PmQV4Z9sya0/vLVJuOEXGJVFvtMtbjNexhnpKJPMLtzF5eHChh/N6b/JhqUSR7ml8DOShTsHTB8F1MDx2SRJ9+y4UZCR4gH4vkbR9E0aRnjOxAzWDfR+QfqlJ5sDgwL74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e2129be67so545918e87.2;
        Wed, 04 Dec 2024 19:23:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733368983; x=1733973783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y5SX3vvLoPm9Eik2OYGQGpzcsjOKwp5Zg+ZD1GAa2Zw=;
        b=Me/yYGc9NndB9Jkp3tvwnsc3YEOnjdL9xC69z/Q1OCAXgLPb2oJlkyyBRWQffxWz2B
         j512zzG0ssMtNKHK8PuQXUxyD7Ee5Zi/7MgrRg4JoUIqA3/eWsVx8gaJbHWlneA0c8N8
         fHLDCaAcOE11ZGzyuOTTiJ6JvZCmXhMrgMjRiZYiXpR4H9O6kZVLYDIeoCwnUtN9PtPv
         +tfGI2DkfY80MZtDLW/J2u9VtCyoRD33aIZlDNeAXT14FOjC8cSN7sZSt7Lyoq2Eb4AO
         PQGqFcaUoTnu92BXMk8sj52qJiI8vcMuzg+br2MD+TL0FMaZHXHZFVnDIYSxNqWPQ990
         FSFw==
X-Forwarded-Encrypted: i=1; AJvYcCVCUTFKL94fuNHRJY65zBqgBwptmL9WPBEVc2knKu4Xgqwq9pzXqBpyiUZ7xoQZtnOJS72a0J1zlCrOWFkP@vger.kernel.org, AJvYcCVUY1KiOiA8UMYIjbiRLz9KifEpT9vAgQ0UJQ5Cur+AEPGhn/kTA5vg5zJW9ozS0wFgNSuLZVyTEuF+@vger.kernel.org, AJvYcCWuqsVyzr7lInV6v7580BDTeCCsR11QLZCHMPQSGxDVXO8kCoNJhfWaL7/quMDa3pwfpZa9P8T9Xx3f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ET76bhDmbSYvthvSLbNZkQpvlwF+m75Xbz0K2aj91qeTCxTj
	JPDCrPmsiOF3NC8aLFbbYZxPRoYZHgbQ/OGzlvWLUbM8ce1otEZVErSA++5g
X-Gm-Gg: ASbGncvlD/Cj/KAW/Rh+GWSsZ2oZzo/5FuVZ7aUE2rNoBaFoMNZ5iWQa7E7izsFWDhI
	tVgqJD3A8aIaKsfJtJOy3nwUWGwtKPHi6Sh9oupqMj5ESig3fFoOppieCHISRur80eJvO9T2OKz
	0ts0r/xcH8K9w61jUgPuti3VbsmGV2VbUSQp4WSYmGmXOfmLaxOUqMTf469UXCczmuaaQtSUCiK
	iw4RJSQ/zUqTJ6QqNrXcLcbmIFaIn5g0hmEBhw9tmHKjcqhIHWaHP79NQIk89rGN9U7Eji+TBWF
	CcO4+8o=
X-Google-Smtp-Source: AGHT+IGQDMIGbzhx1pByFUNUUxvOX7cfIM6HTIbi1m5955RoMud2q8/f/aNrEGeEHy14kTbZ0FWISQ==
X-Received: by 2002:a05:6512:6c9:b0:53d:ed76:4607 with SMTP id 2adb3069b0e04-53e129ff448mr6265214e87.22.1733368982633;
        Wed, 04 Dec 2024 19:23:02 -0800 (PST)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e229cb980sm85339e87.281.2024.12.04.19.23.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 19:23:01 -0800 (PST)
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ffc3f2b3a9so3639851fa.1;
        Wed, 04 Dec 2024 19:23:00 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLv5AdeNvGr24S/miO2iikj/3HIwj99EzeWG2u+LqkRLLpapldXbBTA+5bvmjoIsZ+FTe+u7MgJ6W7@vger.kernel.org, AJvYcCVu5DsdOP852iTbbkTgxMXwJjw13yUBINJhuwDQcII78RKAf8hfgD1kvYkE49XFBnOHZNpf/6AGyPX6jZtW@vger.kernel.org, AJvYcCXVMvQ+tn1PqaP94O6IPMKD7P9PNDii18RTlWq1/EGPj2e/d3bslU6ET3DjaLSfS0HmAmtm2fOsB9Ar@vger.kernel.org
X-Received: by 2002:a2e:3507:0:b0:300:17a3:7ad9 with SMTP id
 38308e7fff4ca-30017a37d6emr21436331fa.12.1733368980758; Wed, 04 Dec 2024
 19:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241122161128.2619172-1-csokas.bence@prolan.hu>
 <173331833897.673424.223627111827356616.b4-ty@kernel.org> <932d4f7a-c9cf-4e48-afd3-476b6c0fbc86@prolan.hu>
In-Reply-To: <932d4f7a-c9cf-4e48-afd3-476b6c0fbc86@prolan.hu>
Reply-To: wens@csie.org
From: Chen-Yu Tsai <wens@csie.org>
Date: Thu, 5 Dec 2024 11:22:48 +0800
X-Gmail-Original-Message-ID: <CAGb2v65M9g-3nLAe=7Q3sbJ2wtpvQXXVhb+h08m=2pWY6g7HzA@mail.gmail.com>
Message-ID: <CAGb2v65M9g-3nLAe=7Q3sbJ2wtpvQXXVhb+h08m=2pWY6g7HzA@mail.gmail.com>
Subject: Re: (subset) [PATCH v5 0/5] Add support for DMA of F1C100s
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Cc: Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	Mark Brown <broonie@kernel.org>, Mesih Kilinc <mesihkilinc@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Conor Dooley <conor.dooley@microchip.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Amit Singh Tomar <amitsinght@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 5, 2024 at 7:55=E2=80=AFAM Cs=C3=B3k=C3=A1s Bence <csokas.bence=
@prolan.hu> wrote:
>
> Hi,
>
> On 2024. 12. 04. 14:18, Vinod Koul wrote:
> >
> > On Fri, 22 Nov 2024 17:11:23 +0100, Cs=C3=B3k=C3=A1s, Bence wrote:
> >> Support for Allwinner F1C100s/200s series audio was
> >> submitted in 2018 as an RFC series, but was not merged,
> >> despite having only minor errors. However, this is
> >> essential for having audio on these SoCs.
> >> This series was forward-ported/rebased to the best of
> >> my abilities, on top of Linus' tree as of now:
> >> commit 28eb75e178d3 ("Merge tag 'drm-next-2024-11-21' of https://gitla=
b.freedesktop.org/drm/kernel")
> >>
> >> [...]
> >
> > Applied, thanks!
> >
> > [1/5] dma-engine: sun4i: Add a quirk to support different chips
> >        commit: eeca1b60138189ef1b9636709e578d0c9e0de517
> > [2/5] dma-engine: sun4i: Add has_reset option to quirk
> >        commit: 1f738d0c2f67ae3551e4543e8dddbfb44cdd9f53
> > [3/5] dt-bindings: dmaengine: Add Allwinner suniv F1C100s DMA
> >        commit: 1ad2ebf3be836e62792788f4cd105b30ca9178b6
> > [4/5] dma-engine: sun4i: Add support for Allwinner suniv F1C100s
> >        commit: 61785259d1eb4e4c4acef8551a2524441683dbf3
>
> Thanks! Though unfortunately, b4 has once again mangled my sign-off,
> leaving it empty :/

There's one or more issues filed for b4 regarding this. See
- https://github.com/mricon/b4/issues/50
- https://github.com/mricon/b4/issues/52  (filed by me)

ChenYu

