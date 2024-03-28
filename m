Return-Path: <dmaengine+bounces-1598-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7737788F87C
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 08:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17F4BB21D0B
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 07:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987CF4CB38;
	Thu, 28 Mar 2024 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRTMSL6+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5677849C;
	Thu, 28 Mar 2024 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711610521; cv=none; b=JwHM2vOAtEujss6Kr3eDfg59q/qWJrEx1lOqpRGO+k34Sa0OBee57dEQTHogbBv5bSmdarZMnbqtkcpd4bmze54EB7/JEzm+moYCqPQ/m1maF+XZdMph2l/xENJ6VwMdM5Gk55jEA5lmiDigp0AQxqb+H/ypDDtpeOcfmMvwHz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711610521; c=relaxed/simple;
	bh=RDLMounM+oNUUK0WHuzBxzl+3fV0+tqGhQC0XWsFu1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LyJiKj4Tdsz9H2n+VoS6QzV+8MDe8/G7QfNgXMRJMe+k9dTRPB8EO5y3tOcNE0pG8iWLcrw/NLaY7sObVtCJoZkw8mB/kd/6EM2zgFGKfiXJyDXOwwpaKz29DkrjoTroT6vngZNGtoDxYUXUyt7enSeIe1OCJQ3VETMyNFIkvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRTMSL6+; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso310983f8f.0;
        Thu, 28 Mar 2024 00:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711610518; x=1712215318; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kJpvDpfLjJLSt/OJwCo1YyhZj36N/3VIrucKVgmj2vI=;
        b=jRTMSL6+7tUUWlaxNXyPL+2i+wgVMXk0/zVois6labh4cm6h9XB2YqsRNWU8vdmVJb
         8+TeUHvMdV96nNiTBj6R3NLk4RquCZb5zXsWwEKIe8nzftAxe3n9YfIt8U1kBrAkoEc0
         Nlb9KaJrG3H2F4fAlaxoIwNXsWhel5i1bpFHDiZR0MMB9MdmKMAIISCJJw1zRQwFZXib
         hyBFOOgGkPVv/peHCM7QS1kelB7OApwXutTSReUugJVd1goLqs513JdYHUXSZ9vR0epq
         Ph1HCeznJM6ys17vJRK8i0eLLkskmlHDKoccXamMu8Nb7Ywv3Rr4xxMObmVTwOS6LKWe
         GugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711610518; x=1712215318;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kJpvDpfLjJLSt/OJwCo1YyhZj36N/3VIrucKVgmj2vI=;
        b=fcKxU3JcLQqziMXlk6wA9i0rZ35QlRs67RRA5VoPkN5OqvA8Hd8UyNCpetDpJHvSFx
         1v3pXIt0SmmXXhrMlEoEGH0JCWJV+Ov2BDY3ychZ9rgD1oH7B63gNjdLoxNYqVkFbHDs
         UmhbFas0vQzdi4/EDbXg8o2HCGNETaeTGf6NFCUp9ZYKeYCQxDZ4kkjbYPmI3PiDpIup
         MGCOU6eHCeX06jNHUAiesazQ/tvLCqbBNpgW1uhSEsi6V6LCrWbvottwaUnQCKWUsTg+
         UF2/4nnkWJ6mEWWfYxbXwS7kGr6aF4P2fR7fyXYqUJDlnjeVvUE6exHfI60f5I7pBVDQ
         GUYA==
X-Forwarded-Encrypted: i=1; AJvYcCXMEAj8bgFSrPga6kSTbtHiuhHlQtzdrZZpKQN+9URr/AmG4ToDIdb2LKGAVW90MsfZNpJ07J0zYRpKXUnXNbdXLSRHcwJ1CHXLejbY
X-Gm-Message-State: AOJu0Yxo8TFHFJgPKYGT+ddiQR3rKDwLAY1MAEKR8DFiFmdZuKlFxwGi
	YA4HSCdqrgPtuj/dTr2TXCNj6/LGUJ8VanFlozcS+Gq2diXDyPAk
X-Google-Smtp-Source: AGHT+IHqBBW6zwzPPjWKrQiNiS/dr66u/ZdVU93uqw9cq6aAPGVD2UpJB/cV0hnwWhtHji7Uo/dktA==
X-Received: by 2002:adf:ab1e:0:b0:341:c99a:8de2 with SMTP id q30-20020adfab1e000000b00341c99a8de2mr1187407wrc.11.1711610517815;
        Thu, 28 Mar 2024 00:21:57 -0700 (PDT)
Received: from giga-mm-1.home ([2a02:1210:8690:9300:82ee:73ff:feb8:99e3])
        by smtp.gmail.com with ESMTPSA id dd7-20020a0560001e8700b00341c6440c36sm947564wrb.74.2024.03.28.00.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 00:21:57 -0700 (PDT)
Message-ID: <d620c37f58b303260096f73e04dfff6bb65ed1ef.camel@gmail.com>
Subject: Re: [PATCH v9 09/38] dma: cirrus: Convert to DT for Cirrus EP93xx
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
To: Vinod Koul <vkoul@kernel.org>, nikita.shubin@maquefel.me
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
	 <arnd@arndb.de>
Date: Thu, 28 Mar 2024 08:21:32 +0100
In-Reply-To: <ZgTytMtgvqcHlEsO@matsya>
References: <20240326-ep93xx-v9-0-156e2ae5dfc8@maquefel.me>
	 <20240326-ep93xx-v9-9-156e2ae5dfc8@maquefel.me> <ZgTytMtgvqcHlEsO@matsya>
Autocrypt: addr=alexander.sverdlin@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Vinod!

On Thu, 2024-03-28 at 10:01 +0530, Vinod Koul wrote:
> On 26-03-24, 12:18, Nikita Shubin via B4 Relay wrote:
> > From: Nikita Shubin <nikita.shubin@maquefel.me>
> >=20
> > Convert Cirrus EP93xx DMA to device tree usage:
>=20
> Subsytem is dmaengine: pls fix that
>=20
> >=20
> > - add OF ID match table with data
> > - add of_probe for device tree
> > - add xlate for m2m/m2p
> > - drop subsys_initcall code
> > - drop platform probe
> > - drop platform structs usage
> >=20
> > > From now on it only supports device tree probing.
> >=20
> > Co-developed-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > Signed-off-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>
> > Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> > ---
> > =C2=A0 drivers/dma/ep93xx_dma.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 239 +++++++++++=
+++++++++++++-------
> > =C2=A0 include/linux/platform_data/dma-ep93xx.h |=C2=A0=C2=A0 6 +
> > =C2=A0 2 files changed, 191 insertions(+), 54 deletions(-)
> >=20
> > diff --git a/drivers/dma/ep93xx_dma.c b/drivers/dma/ep93xx_dma.c
> > index d6c60635e90d..17c8e2badee2 100644
> > --- a/drivers/dma/ep93xx_dma.c
> > +++ b/drivers/dma/ep93xx_dma.c

[...]

> > =C2=A0=20
> > @@ -104,6 +106,11 @@
> > =C2=A0 #define DMA_MAX_CHAN_BYTES		0xffff
> > =C2=A0 #define DMA_MAX_CHAN_DESCRIPTORS	32
> > =C2=A0=20
> > +enum ep93xx_dma_type {
> > +	M2P_DMA,
>=20
> Is this missing P2M?

Not really. It's not the most obvious one, but anyway a way to enumerate
two types of DMA engines:

"7.1.1 DMA Features List
DMA specific features are:
=E2=80=A2 Ten fully independent, programmable DMA controller internal M2P/P=
2M
channels (5 Tx and 5 Rx).
=E2=80=A2 Two dedicated channels for Memory-to-Memory (M2M) and
Memory-to-External Peripheral Transfers (external M2P/P2M)."

Now the confusing part is that this "M2M" engine is actually used
to transfer to and from *some* devices, like SPI and IDE.
So both engines are capable of M2P and P2M, maybe Cirrus has named
two engines in a sub-optimal way decades ago and this is now a bit
historical naming.

> > +	M2M_DMA,
> > +};

--=20
Alexander Sverdlin.


