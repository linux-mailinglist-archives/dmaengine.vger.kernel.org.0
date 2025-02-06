Return-Path: <dmaengine+bounces-4316-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9E2A2A2BB
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 08:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33B1F3A39D1
	for <lists+dmaengine@lfdr.de>; Thu,  6 Feb 2025 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B4E2248BB;
	Thu,  6 Feb 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbUKCJAV"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DC4F2248AF;
	Thu,  6 Feb 2025 07:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828570; cv=none; b=QJXhm82Iihj6G5lmSE1r+JPWv55JIz8I9sZyQ5FVDvNiPf30MCWgkCLWcjZdRoB06Y8YpCOO2tKGEs6tiK4kINt4/NrrKaemLdqFHH3vTh5wFIapa+ZD5V01AKGQDCHJl3Q7DbDJ3B19nMYxD1uQdAq4ZGgwGIWKGyLRB6xipRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828570; c=relaxed/simple;
	bh=AEqIZa1c20GE/uxbotqVtezGJP1SyvKYBSzc37trZCQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwyisGIuu/Wy2EU7VHB1MiDw6lOmxEl+oHOlf85lRCLZyJLtw410FU9cHZQVtHSinnbBXoY63JYzjmGNFlWndgnYqA0JyJnzKsvNIEUm64zcJk6WbnKl6m/PTVfjIp3P0I8QgUoD+0YD6SupRDcigOHuwe1xBr39ZS+bnRyFKP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbUKCJAV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D16C4CEE4;
	Thu,  6 Feb 2025 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738828570;
	bh=AEqIZa1c20GE/uxbotqVtezGJP1SyvKYBSzc37trZCQ=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=mbUKCJAVnd0gw2qkD0wGt5Xv3Dzk2KGOVX+35Yv+F0p6hPPIlRumruFvwrTqICD/N
	 x2t5shCnOeLv4YDriUkDZh8WcLm752b/HYA7Z29AhC7rWORWfg7ehS/+NQiBZXiWLz
	 /0kE6M0ldvEhx+bUce072yyFZSyoeh5c2HrDhsGy9vy5ODJMXv/W8JS3YJ+0+t+Cwj
	 ABlEUsziAfj8PCCRSSDJWExO5/2C1ml5cKCk414NCsfI3DS5eAZvstBqnGz02kVwni
	 sHxcHM3nuIPp+Kq6WRUDPpIYf+boA+2zhKm3TiW7V69lThAELBggeNyqwPnW6YbitG
	 gez1EFLTjk1YA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30229d5b21cso5400031fa.1;
        Wed, 05 Feb 2025 23:56:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVQgV3giE+cNqGJJxaopp3ydvuPwo4gz31IzTXIb9QbFOG9zwmY+vrdYjFGEKCRLfa0W6nvPMQQWifBKB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEDDnYV7GfII6rKqSXBzqV6N2kIfyfskCZKLduwuG939odYghW
	SNr16tKtP8uyPH+OdE3xieAcfymYi5nOs83u8tzP5dae5kRKEIqvYjh91NlL42ImA6dgyTCifz9
	WXJPNOzSUqrD5NrnrJ0utibG5cW4=
X-Google-Smtp-Source: AGHT+IExYizR8AjRlIGIimdkZfX+9X0NRegGw1UkCfbyc+3a2hXIE82esqSCVnis8PSKgDv1Ot7p7cslZ7ZmlCRaP5E=
X-Received: by 2002:a2e:bc13:0:b0:2fa:cdd1:4f16 with SMTP id
 38308e7fff4ca-307cf314576mr19836061fa.14.1738828568791; Wed, 05 Feb 2025
 23:56:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250205173630.112020-2-csokas.bence@prolan.hu>
In-Reply-To: <20250205173630.112020-2-csokas.bence@prolan.hu>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 6 Feb 2025 15:55:56 +0800
X-Gmail-Original-Message-ID: <CAGb2v66yUuG=P5HRgVtLL7y+W49pP6DS6sstQz-qY8CwztdT2w@mail.gmail.com>
X-Gm-Features: AWEUYZni_KKoOE4E3mzLNcrihoeiCPzzxX66FMp6It2qHidhpuTepzOXlYpsAbY
Message-ID: <CAGb2v66yUuG=P5HRgVtLL7y+W49pP6DS6sstQz-qY8CwztdT2w@mail.gmail.com>
Subject: Re: [PATCH v3] dma-engine: sun4i: Use devm functions in probe()
To: =?UTF-8?B?QmVuY2UgQ3PDs2vDoXM=?= <csokas.bence@prolan.hu>
Cc: dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Samuel Holland <samuel@sholland.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 6, 2025 at 1:37=E2=80=AFAM Bence Cs=C3=B3k=C3=A1s <csokas.bence=
@prolan.hu> wrote:
>
> Clean up error handling by using devm functions
> and dev_err_probe(). This should make it easier
> to add new code, as we can eliminate the "goto
> ladder" in probe().
>
> Suggested-by: Chen-Yu Tsai <wens@kernel.org>
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> Signed-off-by: Bence Cs=C3=B3k=C3=A1s <csokas.bence@prolan.hu>

Acked-by: Chen-Yu Tsai <wens@csie.org>

