Return-Path: <dmaengine+bounces-5475-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1A5ADA26D
	for <lists+dmaengine@lfdr.de>; Sun, 15 Jun 2025 17:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BD11890E72
	for <lists+dmaengine@lfdr.de>; Sun, 15 Jun 2025 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5622B27C863;
	Sun, 15 Jun 2025 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3x43rQr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A831927A448;
	Sun, 15 Jun 2025 15:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001947; cv=none; b=W+yhjdAPul8RBVrcyMX9pNOXUtrS/ZDnG9f2RwH0Hn4V2QmUQSB1R9+qPRbcahb8XlMXBKNL6wpUAcHdnGoFt+mUzrFu4WCkvUX8t+o1YIl7kF2QSEEt37fmpzOzpnPK+tfIqRgbqm71b1J/3NRJyqrkr6O3n+pqDYKIOPFNhEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001947; c=relaxed/simple;
	bh=wcbVuvRtZ3mAuFzXuF9+M9EX2ls9QRm4Zi5LwXhPPgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oQ2i/YNLUeUVUGJMYgUCcJctnl2/Iwvw0ZdwaGzU4+pbbvjVZBCxsgyDs8GvdDNqJT+dp5jbGzEfeG0RE4YEF7gWy1OwjOVhshsSoV0QnV74QWSR2VPS5S3KuOkQEbKevEKwwLX56Ylts7HTITbmDvBwAyqnD17ELwAyqRjg93I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3x43rQr; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso3624882f8f.1;
        Sun, 15 Jun 2025 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750001944; x=1750606744; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wcbVuvRtZ3mAuFzXuF9+M9EX2ls9QRm4Zi5LwXhPPgs=;
        b=h3x43rQrU/Mj7qOHnqKDfWzHH302p/JobfcVL+DKohH1g8a+chP6y74KgH9Cd0IPhM
         0oP/qnb8UrkhB26R7GAtcd/cFLStnQT5bxT0emUYRuDlP7hJiUpztKuPJzfWphIcbRwP
         x7CHoR3B4GZs+j4vE4pN6/olleSvxoRWghs2hKdDu6Ana3HNBBthXOeuCOX4f7iPRQb7
         GP65vPCKNF35oWKqqEB5KEFuzj1QKNrsL8TkqFORCSU8UCH4CGqDZoLDaRWrjixaz9rf
         BOF9NQ0jnJoumaDNJcgJ2Wt8cTsnqYVILlIAEJVIzbJm5Iji/5UWntwybuZd8StRg3pf
         gF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750001944; x=1750606744;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wcbVuvRtZ3mAuFzXuF9+M9EX2ls9QRm4Zi5LwXhPPgs=;
        b=vpht7TE7r9p7faOqVwkR7ihyWOcRrK3EGhDaLwMgaerZFRfY43XOvGBpHllE16X9EO
         Rmi0ktcWHU8iuFINR2f+T9iCoOe+9RtwVLkoMrPOiNfJTQopkCCJLp+MgX5ocT4Cj0WW
         ZbAXcAnGWFH5XSEkHsASRYyqGkXaOj2wr+EEd939Rt4jswJIrO9xF804k+GBB7zJg30J
         ROIyJxGOWd5/Ufw/qIQsS/fMFW2vq+fmj7pvAkbqqSpUI/xNKFqo4IfF20CjQ1T/ymLu
         n7k1Umfbh19x9LqLV7iW+tcXvvqZzAn7OfHfYa9h7nDjE4Ttm7EmQr8a03HE8XzIaBIi
         O7bA==
X-Forwarded-Encrypted: i=1; AJvYcCUlifBIpYxZBeIGiBhJWaQeZCq60j6pCpmyl7KSwaVrlQogUuQfFMVYe/wCVN+HrRhW2xMALiRSLceE@vger.kernel.org, AJvYcCUqQRA/uE0x5LKTGC0czk9MNPPByRrMtJtS2sylcNbkLiYCa6LKRtNja1BzBgtfju/REZj5V6pnj1oC662o@vger.kernel.org, AJvYcCWP8hf+H+vrs5FbyYnaBM4INtU/sYSHKbOFLfIetG4DbZ8BuINnDb0oE981DtPRRhCfi+odP7DCcfXs@vger.kernel.org
X-Gm-Message-State: AOJu0YyuyV3YVyz1n7yq6eHmoQ+fOkFiZM/l53DvEXvakx4XJoFBiP3o
	bkuZ9/zI4RpGGTrwwR8GuD1QjdZsRFwFtvmBdhF9DOHxim2dw5OGMLZQ
X-Gm-Gg: ASbGncs6jT9ptXP84LvOo1QE+82M8OLSye7NlWmEVf8JfuJuOHc7Zgc+oTf8RxG70nZ
	1WRR/qOJrQbvkTtt9tkJb49k7760iPjKVO83qHtfdHXKXqFMwURwIBFlZ2ZghKeZ6jJZ4F2YlLc
	N7dMG3l2ZspCH7dKFSgFtp8mg36VvtJf9BZ0iEQ4oko95aB93PlhN+Z1ptrPN0+5Vqxd3JBEdPA
	ZXci8+aFMY5ePLs+hSwgup7Ik3SvuLeGf+SNkQk4mAeCBLcRvAsxbiZhdTUjHwCIAuMv84UxNAu
	We9GQVlZZeb6K/vmQUymEl0HpoI8f/F1bR6XA4Gwpv2ObpeeUHUe0gMd9bIQvHZTO4e+KeyASSm
	YpmgYHQ==
X-Google-Smtp-Source: AGHT+IHTCj/8xJaYk/rbIb+RSYTHCr6hOLzVXx4YVk5M42GtMekvX58mlmih49xOLygZ2eRiQqolng==
X-Received: by 2002:a05:6000:2408:b0:3a5:2f23:377d with SMTP id ffacd0b85a97d-3a572e4c71emr4704384f8f.50.1750001943816;
        Sun, 15 Jun 2025 08:39:03 -0700 (PDT)
Received: from giga-mm-7.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4534394c90fsm34711485e9.3.2025.06.15.08.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:39:03 -0700 (PDT)
Message-ID: <ebdba4671998c23e6b0eebee77bf2b3cd439341a.camel@gmail.com>
Subject: Re: [PATCH v3 3/4] riscv: dts: sophgo: add reset generator for
 Sophgo CV1800 series SoC
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Inochi Amaoto <inochiama@gmail.com>, Philipp Zabel
 <p.zabel@pengutronix.de>,  Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Chen
 Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt	 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti	 <alex@ghiti.fr>, Vinod Koul <vkoul@kernel.org>, Yu Yuan
 <yu.yuan@sjtu.edu.cn>,  Ze Huang <huangze@whut.edu.cn>, Thomas Bonnefille
 <thomas.bonnefille@bootlin.com>
Cc: Junhui Liu <junhui.liu@pigmoral.tech>, devicetree@vger.kernel.org, 
	sophgo@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, dmaengine@vger.kernel.org, Yixun Lan
	 <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Date: Sun, 15 Jun 2025 17:39:15 +0200
In-Reply-To: <20250611075321.1160973-4-inochiama@gmail.com>
References: <20250611075321.1160973-1-inochiama@gmail.com>
	 <20250611075321.1160973-4-inochiama@gmail.com>
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

On Wed, 2025-06-11 at 15:53 +0800, Inochi Amaoto wrote:
> Add reset generator node for all CV18XX series SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Successfully tested with USB series in host mode on Milk-V Duo Module 01 EV=
B:

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0arch/riscv/boot/dts/sophgo/cv180x.dtsi=C2=A0=C2=A0=C2=A0 |=C2=A0 7 =
++
> =C2=A0arch/riscv/boot/dts/sophgo/cv18xx-reset.h | 98 ++++++++++++++++++++=
+++
> =C2=A02 files changed, 105 insertions(+)
> =C2=A0create mode 100644 arch/riscv/boot/dts/sophgo/cv18xx-reset.h

--=20
Alexander Sverdlin.

