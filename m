Return-Path: <dmaengine+bounces-6054-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472BB2A197
	for <lists+dmaengine@lfdr.de>; Mon, 18 Aug 2025 14:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F21114E2CF9
	for <lists+dmaengine@lfdr.de>; Mon, 18 Aug 2025 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABF43218A3;
	Mon, 18 Aug 2025 12:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="apkXGnNX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2089831CA61
	for <dmaengine@vger.kernel.org>; Mon, 18 Aug 2025 12:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520138; cv=none; b=tmu+QgV7hVBoBBexYYZivwRWOGUDoksxgfCnoWwCgaDcwnSjmXs8Z2HMpvsPLrG+9J4aRMccZDLdNEL00oxjjzCdfrAN//7FOZgdPlGP0pqSTe1i6T7qtNDmfWFjsz89V/gasfCu8Qq8h9fSVm3gkEIuhvQjw9HooYwViboW8tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520138; c=relaxed/simple;
	bh=NQlTT8wrBf6/5TXR7NEJIm2qofkpWCiqbqPMT/ijYsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7CvOWiuGHenH7JGs/rSazyZ4CUgnr0DQspRhUaxL2OzKAROiIk6WVBHTTGrksJvGGfd5oFzwohbxdiTSnyGf9GZwmZMj1HJw9UI/nY0L+EXQxfv/joguO/QjW7Kr+3pxhE+hw2Om2hdFPn3SQCWRBvhS5keFv8i6mnHGNWvUXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=apkXGnNX; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e933de3880bso1602199276.3
        for <dmaengine@vger.kernel.org>; Mon, 18 Aug 2025 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1755520136; x=1756124936; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQlTT8wrBf6/5TXR7NEJIm2qofkpWCiqbqPMT/ijYsM=;
        b=apkXGnNXgGl7aZxSKibTdp0qeTPDTjWudLdbIDXHjAoMM9924TTUZQFW9AuxSMVXtt
         rl9Amti5ULwkeK4fcGv5CTV/3fIpDQzZZyCIHX6B7kZ9s681OyGUkigJIHkDj0RkBB1J
         nj3+vaku01NR1/y8Q5j/ZFTJT6QLouWVAYJp5Kc0xo2PDbwbV72r4EKhQI9XUaTYa1/C
         6vSEloZOCMUFA5C7yfXG1EzwMgPeD6dZ0pO8bx6FfVHPF45Xj5PCQkVEGjTgcPYjAU7c
         PSrNrqMWG+KjN8fZneGUn4hZMKjtw6TT+CsyCYg6HVYuCuvMtqXLahRPOTkzHdP420bf
         s+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520136; x=1756124936;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NQlTT8wrBf6/5TXR7NEJIm2qofkpWCiqbqPMT/ijYsM=;
        b=YIDNQPH7TQ+DJcUKa4d/X+tqPDkHAbzAaDiDy26TmwU70cpSjLqeNZDT+bA+0L0V9S
         bkA3mVWY2LQwzkRtJ4U0PBp03/fagKEGYQB9WwQV5L8eDbqbrteLa46lCvVyWJdh1YE4
         ct1lzNqSdUDP6nZhW4SL90awhxXuV5K+b+X9u14YiT7g4NoVwbZki/AC7IuFDobEOTNf
         Bh3j5paYnyOxreZc9yMYaOjW3a8IG54Hhtf+Hm5jXsAK40NbsChcB/H5bTLKnRqYSqVJ
         3BO7bxHCwdGSt+YzEPekkBuH5KTC/fayibxrC3Gx6fBb1Q6ZGO5L3lPWSKCTSMtDIgTW
         Iq7A==
X-Forwarded-Encrypted: i=1; AJvYcCWV/Hql1O2UPPgOenJd8EkHdz7Cl8zUfDWD+Vm4WQ6gJryZecSLSJPvk0SlE/tJ9XKfUAgxWm5pDcg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1KHp6CLZaSxySNq8xDNFf/U1nSMFYFl0LKW+l17gSdR1NEoPM
	liocDvmKQ/0qjP14bPkj1A29tvrUGx+RYIB2cyVf6h68NDD2OIr/O9/FMwCFMj1ovD17Mqt/r11
	ZO7f8Hq/3NbhdmHI8EiFVfCx+HBDZ+34hXBICn5QvyA==
X-Gm-Gg: ASbGnct3z0kNk116CDnsmoa29gqKCZlEK1Xvws60kFtcst5sWWNuP8aSopsAYmMQXuh
	y5758APKwGiR7t1hKhU3D0uFHAwDUOHkmDQxD8COG0zFmSDZpY88WhYPSaCYZA3UnHuIvFlJQd2
	lAI70rhdKjRBL85Vd0BxykIMBTyXOIxa+d9xn2h10+UyVwLGXtWziGGy+vXKI+WpeBiCe3QibIz
	efbcQ==
X-Google-Smtp-Source: AGHT+IFx20xElPVqlagxACjExJ+Sc5Ef/knSr80J9ZkH6gy2bssr57qeuBMFLMu09POyk3VR+IV54ktaJ+qDsdY+z6Q=
X-Received: by 2002:a05:6902:72c:b0:e93:4496:a2b9 with SMTP id
 3f1490d57ef6-e934496a74bmr9054970276.13.1755520135996; Mon, 18 Aug 2025
 05:28:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250815-working_dma_0701_v2-v4-0-62145ab6ea30@riscstar.com>
 <20250815-working_dma_0701_v2-v4-6-62145ab6ea30@riscstar.com> <34485B93B03EAD10+aJ7NVbe8aqjWBFd-@LT-Guozexi>
In-Reply-To: <34485B93B03EAD10+aJ7NVbe8aqjWBFd-@LT-Guozexi>
From: Guodong Xu <guodong@riscstar.com>
Date: Mon, 18 Aug 2025 20:28:45 +0800
X-Gm-Features: Ac12FXzcLxiREAyDvYqUpnp8Sh2Su74nBhalceLEh9KttzUfLjprws3CtQrXJOY
Message-ID: <CAH1PCMahKsCsgmZixartnu6Tq8Oo28bMVNfoAWjnFA2McOOU3Q@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] riscv: dts: spacemit: Add PDMA node for K1 SoC
To: Troy Mitchell <troy.mitchell@linux.spacemit.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@gentoo.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, duje@dujemihanovic.xyz, Alex Elder <elder@riscstar.com>, 
	Vivian Wang <wangruikang@iscas.ac.cn>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, spacemit@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025 at 2:04=E2=80=AFPM Troy Mitchell
<troy.mitchell@linux.spacemit.com> wrote:
>
> Thanks.
>
> Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
>

Thanks Troy.

