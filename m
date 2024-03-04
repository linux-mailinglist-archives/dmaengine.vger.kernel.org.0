Return-Path: <dmaengine+bounces-1239-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9525486FB2C
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 08:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7CC2815C7
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 07:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104501643E;
	Mon,  4 Mar 2024 07:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ftNv2pas"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFB514005;
	Mon,  4 Mar 2024 07:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538987; cv=none; b=WT967ERcABrSaRIuDrRV1+/biVWZJpL2g6zI8GXu5IarrNPhbVMc5h3ESqF6UNhKxy5ppFSqPkkiC0ocq/NupFLshPqTrHB8svPcAfmaLEC2qfs/duxBwR1qqcYXY5cNHJj4Lz2gkVHx5G/NRfI/2j5t4esaH9v48WY9W6llddk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538987; c=relaxed/simple;
	bh=JU7B4JEXTqNDcYf4cw4oV1wq3naZdiA7hXrTs7ex2DA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hz9tUXX0KPrJ50I9L/fwd6fOmLxYwlwa9lWTvMb2qCxpYrry6Cirq8heUCStXzDbqSOB0H3fcgmRMbKcAdgliBzBUgazGkXkUJssYNyiSxuqgGswtpuNhbuQZ20O89whq+9JR63ACUz3KvUep48BBbkXFnZERZSpDmmUD4R1D3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ftNv2pas; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45606c8444so41621366b.3;
        Sun, 03 Mar 2024 23:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709538983; x=1710143783; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JU7B4JEXTqNDcYf4cw4oV1wq3naZdiA7hXrTs7ex2DA=;
        b=ftNv2paseRsgY8Budqo5Sya3Ru844KgFEAs3H64DDT/pGTikYNodj49JhD/rFIXdQB
         D/jnpRgo62eK0kXe3I1lJVyiUEgYadvIRpGarcFL/k6S3zmOjx4HNpdw7vcQYp5uPuff
         +xxQjDtWW2KPMAAk1ql2StkuLCZxFHBBxZgHIQTC/gsAEW69AWKLKvZqIDmNaYPaYHgX
         nObnB9w3AF5yY+eZ+c0ZtQlo62anm9RUUby/wG6XVfEv9Y8ztS7NRmUYi3h05oDmTn90
         /cWQuJ/6/R7kfvamXUFsDyO7XZPDyUGfsey/FcC/sxgXWNromQAiEQBswmD0E5QV1nyz
         7Ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709538983; x=1710143783;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JU7B4JEXTqNDcYf4cw4oV1wq3naZdiA7hXrTs7ex2DA=;
        b=VWqIpQY1l2dXvQklQij5WRDJtH4GB7fJBuPBibt+67UHg1PplvL1qhhtRNC9RSfcp+
         jeJxjzN78oGvF6FvZRJjDajv7AnXE/nDiV7TcGd//TyrBp/UCSXyK4AFaD5/WboRJIGJ
         3haoZDPGXn6IQxwshiQqHVFZlhNoqEO0ZqLQhU5TPM3jGCYoJ0KECPcj3//Yv1AJ22S5
         OhZ4aQ4SWlx6XorVR85Msyt67Py1Zha6ThC6nmnUwOtUGeqHLlwUz680rKQBHgvM1YJj
         jPwoZk8IC2ZlK+yU+8BebIwywl8Va/c3R6KePBVM4/NqZ38FPUUl+Fxrk+SpFvQZhEwA
         yL0w==
X-Forwarded-Encrypted: i=1; AJvYcCW9jkXG8130/gg3fVFDEdwF3FVqSELq6INf33Bx0hWchE8u5Cfrg8+WKjXW4ZyoCY3KO4pmUaChoRbnxe60v8Uj14tNdvdjN5ZizlpcC7yP0a2s2uJZZrFja3pvPlV//bAuzlNiOi2q0Q965bpjmDPvC3iCUNp87Vnfe0Ua0a/Mu8+fSpiAdR2tPsuamlMyN0n8TIZR5ZIeQSnDXRU=
X-Gm-Message-State: AOJu0YybcC9PQw3+hFyeCao/Ec4+kKiNEH2eMa7RnSOQYX7Rzs2GKK0J
	0W38v9ZzLOB+DVWoXo2CzjUHadaCis0+DXLNPd9tfoUcY1W3YekI
X-Google-Smtp-Source: AGHT+IFDGr7vFAQ+PxmjQk9WiX9JA+Bj/agAwF6Fti3FyVIMSz4fL7PwqOI0+GiLNxiumrzfSC6zRg==
X-Received: by 2002:a17:906:f293:b0:a45:1fa8:3850 with SMTP id gu19-20020a170906f29300b00a451fa83850mr1753968ejb.58.1709538982788;
        Sun, 03 Mar 2024 23:56:22 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id h4-20020a1709063b4400b00a433f470cf1sm4402055ejf.138.2024.03.03.23.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 23:56:22 -0800 (PST)
Message-ID: <43787ce68f731b9267ee558c4c38d634acffe8b9.camel@gmail.com>
Subject: Re: [PATCH v7 0/6] iio: new DMABUF based API
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: Vinod Koul <vkoul@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>,  Jonathan Corbet <corbet@lwn.net>, Paul
 Cercueil <paul@crapouillou.net>, Daniel Vetter <daniel@ffwll.ch>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  linux-doc@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linaro-mm-sig@lists.linaro.org
Date: Mon, 04 Mar 2024 08:59:47 +0100
In-Reply-To: <20240303174245.37efc0b0@jic23-huawei>
References: <20240223-iio-dmabuf-v7-0-78cfaad117b9@analog.com>
	 <20240303174245.37efc0b0@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-03-03 at 17:42 +0000, Jonathan Cameron wrote:
> On Fri, 23 Feb 2024 13:13:58 +0100
> Nuno Sa <nuno.sa@analog.com> wrote:
>=20
> > Hi Jonathan, likely you're wondering why I'm sending v7. Well, to be
> > honest, we're hoping to get this merged this for the 6.9 merge window.
> > Main reason is because the USB part is already in (so it would be nice
> > to get the whole thing in). Moreover, the changes asked in v6 were simp=
le
> > (even though I'm not quite sure in one of them) and Paul has no access =
to
> > it's laptop so he can't send v7 himself. So he kind of said/asked for m=
e to
> > do it.
>=20
> So, we are cutting this very fine. If Linus hints strongly at an rc8 mayb=
e we
> can sneak this in. However, I need an Ack from Vinod for the dma engine
> changes first.
>=20
> Also I'd love a final 'looks ok' comment from DMABUF folk (Ack even bette=
r!)
>=20
> Seems that the other side got resolved in the USB gadget, but last we hea=
rd
> form
> Daniel and Christian looks to have been back on v5. I'd like them to conf=
irm
> they are fine with the changes made as a result.=20
>=20

I can ask Christian or Daniel for some acks but my feeling (I still need, a=
t
some point, to get really familiar with all of this) is that this should be
pretty similar to the USB series (from a DMABUF point of view) as they are =
both
importers.

> I've been happy with the IIO parts for a few versions now but my ability =
to
> review
> the DMABUF and DMA engine bits is limited.
>=20
> A realistic path to get this in is rc8 is happening, is all Acks in place=
 by
> Wednesday,
> I get apply it and hits Linux-next Thursday, Pull request to Greg on Satu=
rday
> and Greg
> is feeling particularly generous to take one on the day he normally close=
s his
> trees.
>=20

Well, it looks like we still have a shot. I'll try to see if Vinod is fine =
with
the DMAENGINE stuff.

- Nuno S=C3=A1


