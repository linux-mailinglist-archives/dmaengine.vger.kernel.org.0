Return-Path: <dmaengine+bounces-3174-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E8497A753
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 20:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7001F264B5
	for <lists+dmaengine@lfdr.de>; Mon, 16 Sep 2024 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46013E49D;
	Mon, 16 Sep 2024 18:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CACxILnd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122C38FA1;
	Mon, 16 Sep 2024 18:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511548; cv=none; b=Shk0EwdJF3qARbwURjwtND/DwaGRSs/d4ByK06XR8Ak0AeAKpRTVa183f0uyQ6QKiL2WCy48ZogJrl11jSljHH+CIpBChBoXtysX7/u4aBe7I7mVGiQ3jNDuIbpK1AUDTk6FiUYXmSTBI3v+uJAfUmO9Z0TgzHS+B5KvL9SQVlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511548; c=relaxed/simple;
	bh=U0kB/a/w5m1cWR4/u4c0+Uu5pOhQ2VpCVFKfWhFj3nI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lBX4JKVKXzWMJpAjxeFWy0suk0ILJr7tA7MvZy4WxdLGJJCGXis8Q3FHXv0IFA93DtCyt5WKtCpnavDewu/FYAuHdU3mTWIbfXPLV+dcWd3etXDtnDf+LHrpGTNqZHWD2TB4zDoOf+o/V5M9GCmaubbXDjdA9l0DIQ+/cqwfVGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CACxILnd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a8a6d1766a7so625243766b.3;
        Mon, 16 Sep 2024 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726511545; x=1727116345; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=N++jJf1MNCR28pXLj/xzz/4s0nJnbeFi2VTpqhVj0xY=;
        b=CACxILndFfkkVpH8EYGmrx/blpVcZCiALxUIPoaA2zkvymeYp9kKYfXAiZr4fxzYWF
         OKvCy0aBbiXeLCsybBy1TZM/PrMUHyeRsMkCcFfreBNCMPsbghUGxL8EwEpuLkC3McLL
         9rwRqrXYnpF3PthRbqt8Uurk4/KJr3GN4QA8nS3cuy/dO/eumSz/KVZjY9vHb8zY79+y
         X3dCjXM7O/WYXwS7KAYAuqFlzKUNbpFs5MRSbHMu100V1KCO+vcQ5BaXUBv5xxNbRRs+
         6nUaKEnQ1pQK+0ICcNngE2LXBqAS9SLbDwf6QatKU5OieO9awlx3sYANaLsiEFNiaZvM
         Viaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726511545; x=1727116345;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N++jJf1MNCR28pXLj/xzz/4s0nJnbeFi2VTpqhVj0xY=;
        b=Veot6kStmoyBqbjFJFsjk6sbPkFQfojB6g1mNl6vsfchI1MVJhgGj4heQaai+A+tpu
         PnbL4dUw9YatKYFH0XjC03sRY8ZB8YFLrRz0qJ9kP71etLMiLKDUlkUHAKK8w9Z9om8C
         jDayjbhhJg4CVoHREyWuv9DtZvMg2o0V7x0XR0gROs6OajT5AQP9pwadwVgLMoS/k1td
         mn4TheY+rfUHaNuKfezzoJFNZYoUHJ8F9GwvdgVtlS0sghOBPZ5b50vU/anHY/yGkpAJ
         jzqmUdjLUINaLNz7m3De8BUWE4j4jM6AwRH61OMaNWCQPiJtBDO8lzc0J8uDflZ4+7/7
         +lCA==
X-Forwarded-Encrypted: i=1; AJvYcCV70Aa/KWlZ96OfwF61NoXoogZSjmIZ2/NHidniYO4cqLyr8hM2QBg/BX2JUzHFXE3A+r2BLQa0JJU=@vger.kernel.org, AJvYcCW7CCeNb1nTOEgU4W140LL79U1h7FJGEkbT7FIprfs7hw23Of09rJYtjYyoZuaCz6HGcbm2GHJT7ln9umG0@vger.kernel.org, AJvYcCWV19O0ClJY6EyXTEu9NOaBuueWZpnDAOIsKJ1TZ5eIWSK+qyNRHfUevQIlczcjCB9tggffhD6mq3iSYZtbKgtm@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/guE+q4AO5bMaJVvsQ7NmMBndpMSHy5xEAJ59SPVnyQYz2djI
	JCsKhKRMKhmjTlBnr1lhpgydlM7TK3C82i3kIdv79nfX5YDfQEk+
X-Google-Smtp-Source: AGHT+IG2bkFgI0St5jlbMoVCtTJAllqGSMBJmDSSn3KuFp377KkOkZ5iaD+a5l/Ft83eECi1XIMk3g==
X-Received: by 2002:a17:907:86a2:b0:a8a:86a9:d6e2 with SMTP id a640c23a62f3a-a90294eda24mr1602504766b.37.1726511544796;
        Mon, 16 Sep 2024 11:32:24 -0700 (PDT)
Received: from tuxbook.home ([2a02:1210:861b:6f00:b2be:83ff:fe21:42e1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90610f4450sm348473866b.55.2024.09.16.11.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 11:32:24 -0700 (PDT)
Message-ID: <75639e2d585a2d45e015e80044c0f88a3f5ec3b1.camel@gmail.com>
Subject: Re: [PATCH] dmaengine: ep93xx: Fix NULL vs IS_ERR() check in
 ep93xx_dma_probe()
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>, Vinod Koul
 <vkoul@kernel.org>, Nikita Shubin <nikita.shubin@maquefel.me>, Arnd
 Bergmann <arnd@arndb.de>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org, 
	error27@gmail.com
Date: Mon, 16 Sep 2024 20:32:23 +0200
In-Reply-To: <20240916182337.1986380-1-harshit.m.mogalapalli@oracle.com>
References: <20240916182337.1986380-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Harshit,

thanks for looking into this!

On Mon, 2024-09-16 at 11:23 -0700, Harshit Mogalapalli wrote:
> ep93xx_dma_of_probe() returns error pointers on error. Change the NULL
> check to IS_ERR() check instead.
>=20
> Fixes: 5313a72f7e11 ("dmaengine: cirrus: Convert to DT for Cirrus EP93xx"=
)
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Dan has already fixed this though:
https://lore.kernel.org/lkml/459a965f-f49c-45b1-8362-5ac27b56f5ff@stanley.m=
ountain/

> ---
> This is based on static analysis with Smatch
> ---
> =C2=A0drivers/dma/ep93xx_dma.c | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> index d084bd123c1c..ca86b2b5a913 100644
> --- a/drivers/dma/ep93xx_dma.c
> +++ b/drivers/dma/ep93xx_dma.c
> @@ -1504,7 +1504,7 @@ static int ep93xx_dma_probe(struct platform_device =
*pdev)
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	edma =3D ep93xx_dma_of_probe(pdev);
> -	if (!edma)
> +	if (IS_ERR(edma))
> =C2=A0		return PTR_ERR(edma);
> =C2=A0
> =C2=A0	dma_dev =3D &edma->dma_dev;

--=20
Alexander Sverdlin.


