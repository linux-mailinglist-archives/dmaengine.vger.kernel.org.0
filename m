Return-Path: <dmaengine+bounces-5323-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78443AD07BA
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 19:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B66174179
	for <lists+dmaengine@lfdr.de>; Fri,  6 Jun 2025 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45FBC1E5B88;
	Fri,  6 Jun 2025 17:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixOSjXDm"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0271E3DD7;
	Fri,  6 Jun 2025 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749232147; cv=none; b=BKzDuQCVQu/eLg7PVOVQZ1ELE4bGUUn643/efDtOhcFHDmWj/YqbssR3v49Tj4lX2+++sQrGf7KNV9Lg+Q+2VYQCyVId0HUn9xiiq3z430RAwSjGEFFjIqCUpG5gsNoLrXhRueT9COMXLUyfKzfUXg0wpWOvJql0dHvhXtEWq9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749232147; c=relaxed/simple;
	bh=QkCC156cFLZ32G7VZvrODLuLWj+/VBaRP7kkagtS93k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BJixyK1ForBTLvJ/xQVKiT8Q7QCLb1B+C1BXuLDEsawueV8eAsX32RL687zTiQpOL1Qp/+rloRs4cDyuf8CvmzHD4yF13R++mtwE6fBHhROXCSKY2vhwwM4HVsbb0+zxmlRqUS3z1/G1Vwkn9Nmk0mYMk08hMgBhRtHy7rJOlwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixOSjXDm; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-ade30256175so110323166b.1;
        Fri, 06 Jun 2025 10:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749232144; x=1749836944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QkCC156cFLZ32G7VZvrODLuLWj+/VBaRP7kkagtS93k=;
        b=ixOSjXDmeewQIvkxaE7NhwSw8ikmrRASV5R3bAwcLFzpZkBFY9f23y/pAD+GPWq3Qz
         TMukVR6E782ip4FDJfoIkORKyV+JHOo8MxabK7xsnViwQTtDYcXKgCR5i3mlV2K1Ht9Q
         TViVr/Cju57GUrzI5WXDLMFQn/IlMk3AJ3ZsnMIt2CjeyG8Zn6Nfx9WpkBfzNjgibQZy
         eqz22m7pfLqWtXN46HW3HXe9q1igjdvB3uF3Na2s3Bmn0XQkHu2KNPKf7RIeB6NiBrdT
         jy2wPkepNVk4jOA2CSUCeA7czK8Dtjk5DBDu3tY7gGuRwx5LOPZYsszgERSoF06OqoJG
         XhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749232144; x=1749836944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QkCC156cFLZ32G7VZvrODLuLWj+/VBaRP7kkagtS93k=;
        b=WJdom4LuTKwwRWny6CxjZ0DsZyjfhaiQJibtc75b59PqLjKvabCrHQLx2TvH1NR3Ea
         nNOkGUZxsoMzpxfU10NobfmeR8A2tTKtuKW3OWWBwrQbOPH8ev5p5I9/aKRu6hWO5IuT
         e6GGv4jCt664IyuAzCXIn6tlRRjSwIMIylBwg1H+62dpl/1i9hRUFFvykm5H9bRZylqc
         GJmtbW8tsv7Nu0V715CnA80W/OALXOosr2iiuDUcLwIQkGigplBgg1UhTF+ZYrEkjbju
         HW/czcB+zkIbnpVAJ1NfJXupdH3U1WEkHRwd7WgWlDb5e26YSMiFj5WmgARSSdbjDRWh
         NYww==
X-Forwarded-Encrypted: i=1; AJvYcCUB6AAXCgJdMk3mBDL4BQEzAMK4UevcijjLHNmiJFMqPzZQpaggk9ABcw8X46tkT95MBxuag0vqSZtEnlYb@vger.kernel.org, AJvYcCVS1eMhBaqgAzQMZd+pH33+igVCjoJ60B1qA5YpfM1HKh6o84m6oUEVKZjh8LmcQ+STHFsFrnEVeTQ=@vger.kernel.org, AJvYcCVj1FRR6ud8G3sEKPRZpfYe0TmanO8YZK4SE/nHohKHvAKh29Jv4l+LjhmGTK5g9DE6NPLQonDk@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+ZaEt2lyqldeVQo29VlW4rcrGmcg44/DTQpp1GICCsEKsz7cW
	HyXPp3Id7tbvP7Agu9uyM0IYhXu2HdKWWTPPkP38MUF3Q9FIwQ1AldpPzUt46YGY7F0aB6oPdbO
	n7y/FQzulDKw16MzWf1AEWnWRHmjDVWJLhqtIcT0rGQfb
X-Gm-Gg: ASbGnctH01CRyQTtou2sqb0UFIK9acqEsVGRpNf93ELq+t32Zjwvwsq2j4ugTLShbit
	BmhNy9U7iFzWS/ziYiAQTuolfHPQylmvHq7ZBuRUDM7htWnC4NZyIqX6cUeN2u2vQHLmStAVSUJ
	YkQ94/FKwzNafua9c8YLmXOvKRX26Hh0YFpyfHD0/RegY=
X-Google-Smtp-Source: AGHT+IHXAoU/5KkMHOwPj/9FFVapAMcrkwidaA20pDZe+6fW4OeNUdufuvg0OsHg+lbWtoD1W9V+6MaUGDrLNkTMyhA=
X-Received: by 2002:a17:907:60d1:b0:adb:2462:d921 with SMTP id
 a640c23a62f3a-ade1a9160c3mr401179666b.5.1749232143541; Fri, 06 Jun 2025
 10:49:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250606071709.4738-1-chenqiuji666@gmail.com> <ff77f70e-344d-4b8a-a27f-c8287d49339c@linaro.org>
 <CANgpojXWk1zvu32bMuGgkVGVNvPw+0NWmSUC62Sbc3WcUXAd3A@mail.gmail.com> <ca3ce8df-aa4f-4422-8455-29db2440d8d5@linaro.org>
In-Reply-To: <ca3ce8df-aa4f-4422-8455-29db2440d8d5@linaro.org>
From: Qiu-ji Chen <chenqiuji666@gmail.com>
Date: Sat, 7 Jun 2025 01:48:51 +0800
X-Gm-Features: AX0GCFs2ajWvvueyvPNV-snyunQFsI1e-MJEy6pQ_bQ_hu8xTMdazrmACi39OKk
Message-ID: <CANgpojV51R5sKvowPiMk5MRAzJ3KZoti6mRXjD3Knfz6kk6+MA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: mediatek: Fix a flag reuse error in mtk_cqdma_tx_status()
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: sean.wang@mediatek.com, vkoul@kernel.org, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com, stable@vger.kernel.org, 
	kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Eugen,

Thank you for discussing this with me!

In this specific code scenario, the lock acquisition order is strictly
fixed (e.g., pc->lock is always acquired before vc->lock). This
sequence is linear and won't interleave with other code paths in a
conflicting nested pattern (e.g., the pc =E2=86=92 vc sequence never coexis=
ts
with a potential vc =E2=86=92 pc sequence). Therefore, a standard spin_lock=
()
is sufficient to safely prevent deadlocks, and explicitly declaring a
nesting level via spin_lock_nested() is unnecessary.

Additionally, using spin_lock_nested() would require specifying an
extra nesting subclass parameter. This adds unnecessary complexity to
the code and could adversely affect maintainability for other
developers working on it in the future.

Best regards,
Qiu-ji Chen

> On 6/6/25 12:14, Qiu-ji Chen wrote:
> >> On 6/6/25 10:17, Qiu-ji Chen wrote:
> >>> Fixed a flag reuse bug in the mtk_cqdma_tx_status() function.
> >> If the first spin_lock_irqsave already saved the irq flags and disable=
d
> >> them, would it be meaningful to actually use a simple spin_lock for th=
e
> >> second lock ? Or rather spin_lock_nested since there is a second neste=
d
> >> lock taken ?
> >>
> >> Eugen
> >>
> >
> > Hello Eugen,
> >
> > Thanks for helpful suggestion. The modification has been submitted in
> > patch v2 as discussed.
> >
> > Best regards,
> > Qiu-ji Chen
>
> You are welcome, but in fact I suggested two alternatives. Any reason
> you picked this one instead of the other ?

