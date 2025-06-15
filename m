Return-Path: <dmaengine+bounces-5476-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B14DADA26B
	for <lists+dmaengine@lfdr.de>; Sun, 15 Jun 2025 17:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95BFD3B0EDB
	for <lists+dmaengine@lfdr.de>; Sun, 15 Jun 2025 15:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3019727B4F5;
	Sun, 15 Jun 2025 15:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2I6XrGx"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A927AC3E;
	Sun, 15 Jun 2025 15:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750001954; cv=none; b=P01ZOzwh3uv1g4gIun9vad32jL5ilQqbcLL2up0u5W1cxCjXT9U3R4RxqISwNuf16UJ9v7/24KL2zGMTAHWZnswcm5KnU8ZHEu/sJjiskmPl2/Um5NbdD2DqipM39N+NAxCf0aqbn9XcqZVCMxmQV7s/fXaFMnCFYRxg4Hdt06g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750001954; c=relaxed/simple;
	bh=m6LP38QwVoEaHLyw8YxufwF/MJQu9Kb3/FKUtYP05hk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qrKXdfaeSLn0LFQiUZd3Q1JffR98P8Ibs3HfdPGdd7nqhTY5NLzjzavSoBgg+Z/9P3iUUPvZoTnas1GTtTKKoX2x1yRpgSo1ZkqXK8auPX0hqJDW5SPlmAARg9L61jUthtbxCN8IY1m8OhT1Le/tCdxeZhpApQJpRO5xNoBtljg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2I6XrGx; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45310223677so30314795e9.0;
        Sun, 15 Jun 2025 08:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750001951; x=1750606751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=q7ElqBBxYK8zwqSy2KMj1EAXRpTMg0e1y6o6qhKBrfY=;
        b=N2I6XrGx41rGqvtbpEuLBRMLQabJXVHDPOjuKe90INXbClGdrxHNgMLszyyXxmJpod
         Pvnybc+3Ue1L9vYoo1QzQmCywvmqmJxAxm271RW0VS0bxhsJ9dN1uwycT/PUp5CuoEfc
         MDjH2HnomoVtYeB+yb0m/ukmPkMjswK7oT/qxc+EOMplhmHEHWfnTbPvfP28C5Izxegp
         AP2nBsBuhUi0t0NRy2oSuSiR16Ne6XoNieYe+mEkEIvqxGo/G5H2Ubi+sBUo1j3//Yls
         nNM/JUwYKG2/Uc1lgK/FrDvsSJnAE38NN9ppiJlDj7rHrGp7K16UZT/WQKNyVBLa+RJR
         S9FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750001951; x=1750606751;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q7ElqBBxYK8zwqSy2KMj1EAXRpTMg0e1y6o6qhKBrfY=;
        b=Z9M6iqJWaDsfmb/BpRjPsUF5L0j9INy42tLo/YD+MNuSU6DJBdArjuRXrfOMlng+7h
         jF2yfo2UEtwk7zlvwUUanbu4vFQrLlUK1OMlr6MyM0magvr5mUl+8ev+kOQ2BITGY+bR
         VbVH7GSotkyywwFPVCs4QJKr3hCJQ1z+z/0Rr6faFIeTiLR4Wxg+IJU5HP61IZjog3SB
         5s7KN9xHt3QSnRhIa7xfL19yusDi6nV4czrGWF+MaOYVU3uB8tZVzZFsIiUvaXHW+rER
         JfzrsAtvu0I1tH+TLbupm+4XLFa3JasP4mVjTqE2hARBpE6/JDq+mKJmXk8q4xN6Isp7
         QEPQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz8r4WSGku0X6ZjNDyJye2pTh80rn72m7lfl1wh0350UBCXxxUUdNTttvLy/5MLH8UBdwA1y/U12cGmJOI@vger.kernel.org, AJvYcCWaB32xyPy5RtzbAyePMfWg43kgRbNqvXOaKsxlznSESKODdikRm44YavBPkxsF6UCl2g3ucx9Dn8eD@vger.kernel.org, AJvYcCWtGMZHY+p4s37wRGSLPz3F6SZwb5RPjIJDs4VkbCOqnfd8J5XhtE71ilt9BmEYpKbpgxrv8Z34GoAy@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8U2MpqSmFbkEX0ShjW+LEwtwJmSDcOb4ta1GXcAE4T7ot+j+
	1Nv6q7qWnKAQjt561VGyaLgvxUt9mvlSlcJ0k27v2tUH8rAWQoaIrLDn
X-Gm-Gg: ASbGncs5VpxyaVfOmX7/aL5zYpvspgB9oHCPuEEmKnP7RBjblWygvolboM45Kk8nxn4
	b5qVbU6PxWOc+bOcVCq6I0DqdPK0WSTuAeT1gq/kM9kwCUukXEUEqY1qAlck6EiEn507/XD6nnK
	impSrMKkjCnfChYmb5pF5RSQIRdsfv8UabHRU2O5nybinwFaGwGfTMrN9gRItEJRWuyXcWtcyxu
	RvG4hMP8fZeg6i8ZdxDLjUphtt5C4bOSjZA+JK2/+lK3TqiOScYkkX2Jv0VHl1zjibM5b56WSYK
	REmbpqfkypg4Tr0gp0pf9dpQBdFUg0cQfIClDeZv8msnHXU12FdZxe4/6I7fczLnAjLVbs6H5Gd
	0b5wg+GckXphPlimV
X-Google-Smtp-Source: AGHT+IE3Nn2aP/qP3xfmKvxxE4Tm9DNlDreyA9eo2JAN2p1efPcWJyOTkPDySsjd3i0sSEsHjflkPQ==
X-Received: by 2002:a05:600c:3b17:b0:442:ff8e:11ac with SMTP id 5b1f17b1804b1-4533caa3473mr60153345e9.12.1750001950395;
        Sun, 15 Jun 2025 08:39:10 -0700 (PDT)
Received: from giga-mm-7.home ([2a02:1210:8608:9200:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c2d2sm116082625e9.1.2025.06.15.08.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 08:39:09 -0700 (PDT)
Message-ID: <fe84a75aa6d91bc8de7610660e861f1f60fdf9ef.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] reset: simple: add support for Sophgo CV1800B
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
Date: Sun, 15 Jun 2025 17:39:20 +0200
In-Reply-To: <20250611075321.1160973-3-inochiama@gmail.com>
References: <20250611075321.1160973-1-inochiama@gmail.com>
	 <20250611075321.1160973-3-inochiama@gmail.com>
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
> Reuse reset-simple driver for the Sophgo CV1800B reset generator.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> Reviewed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

Successfully tested with USB series in host mode on Milk-V Duo Module 01 EV=
B:

Tested-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> =C2=A0drivers/reset/reset-simple.c | 2 ++
> =C2=A01 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/reset/reset-simple.c b/drivers/reset/reset-simple.c
> index 276067839830..79e94ecfe4f5 100644
> --- a/drivers/reset/reset-simple.c
> +++ b/drivers/reset/reset-simple.c
> @@ -151,6 +151,8 @@ static const struct of_device_id reset_simple_dt_ids[=
] =3D {
> =C2=A0	{ .compatible =3D "snps,dw-high-reset" },
> =C2=A0	{ .compatible =3D "snps,dw-low-reset",
> =C2=A0		.data =3D &reset_simple_active_low },
> +	{ .compatible =3D "sophgo,cv1800b-reset",
> +		.data =3D &reset_simple_active_low },
> =C2=A0	{ .compatible =3D "sophgo,sg2042-reset",
> =C2=A0		.data =3D &reset_simple_active_low },
> =C2=A0	{ /* sentinel */ },

--=20
Alexander Sverdlin.

