Return-Path: <dmaengine+bounces-1240-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7552986FFC7
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 12:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30C5E282CB6
	for <lists+dmaengine@lfdr.de>; Mon,  4 Mar 2024 11:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECFC381CF;
	Mon,  4 Mar 2024 11:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkM7w7N6"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB4A2BAF5;
	Mon,  4 Mar 2024 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550458; cv=none; b=kRtkCM8RHUBhesC9fEY7ORb027PrehG+HLdjPZturggrAXOQfXMiH8fwsvVZO0pkMlNJ4OffPSUx8O7+vGHAxb4YB1+IyePZYVwemuiRnXdvVs7jO3ECnHWh5+9s6poMmjA/AgNILAW3dwAqMjHkiHuCQ2K7HbALBJ1arHSjMqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550458; c=relaxed/simple;
	bh=Wu1HQfAzXdwAMW97wtn2MyUT9kqXYE4x4WqJIu7nsOI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JSGDWxJmlVFLs1UUP5/Hd2YdvLbsCht3XPEe/YfI3eJFWws1KBHmJ4OJ+L5eN6Q8YeefgzBndXx1zQ/xWG/2HKxpWXs2Mwm+K4tXvA3K9Ow53GMAaFv3QE8+SVW6Z7y+zfCtO8C82OjK/80B9ZEcQMb9x1zLL1hIfmOhKEWl36A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkM7w7N6; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a441d7c6125so525625466b.2;
        Mon, 04 Mar 2024 03:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709550455; x=1710155255; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Wu1HQfAzXdwAMW97wtn2MyUT9kqXYE4x4WqJIu7nsOI=;
        b=DkM7w7N6chsrTadjk+5y6I7kQbbUCRM8SVNPGcg/wczjnTO+4rL92wptPGOJmk2LqH
         JwbHP/lmdzzMo/OY03CFJACZZfXz54WNpF9gxExFCfcerYinHwS4KDUbDVJc9mi6rLEr
         pWxZfxDyCwc8mkmnhGX7swtkSWlDIpE5GK0E70J7YIzMgdTMfDjRRakoIQ0ILsrrLwPk
         9JKOPfKx121lUdCaYH8ufT9J0PPwSd0Ba0sqzikovjCgNvY/aSH6sNhfFpbOdeuZ0FFw
         vUwya8u/KmHQYXPCmk8hzUXqzKm1IzhftsR8cLNv+MmsDNIaGMKs7GJfyy5yrLSAMJSX
         hlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550455; x=1710155255;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wu1HQfAzXdwAMW97wtn2MyUT9kqXYE4x4WqJIu7nsOI=;
        b=QdV7bTBI+F9GPF7gtZw3uQjkz4TjzshUcD7D1TOES0pZwY8fjGeJUD1+mQphd37NQP
         l30CKfeXPOWZgFbqGXi5a+ZAFSoPDoxvrI5gSuDLrjNiG5stKZnPsenLv2czsJScQq3t
         UrWFJXH7hOP6B/SvUEwGz/qZeeWol6bcqJMDmHNcTuhenuFUckBDf7oAaW9pT8NWgmdX
         P6lMdQ4AGI1mIaK4Vhgp27gUoXRrH7yu1kBiYNYll6fSkMTWiY4SBySJVkGN8ZJwsH9B
         Bn/vJCn6hEpeWxnNNhYRGvhrVrPfu8ZTGdBPtpPPJjCg1ul3wcdgE7zkvyVxV2SaCa16
         V1ww==
X-Forwarded-Encrypted: i=1; AJvYcCVeb3yrfNQLLqo6YEkPXnPzusPj5bCzwaP+jjArw/sjEAMuHO5qW3m2bQdCJB4qP/EnCa0YoRyho5dFrUnYaSdm09KZbHZkAUZWlL37yxEotinnTrVk17CT6cheOnL1nQWDWFHL9Fbd+vnn2chGSCmoLtP8/J2aCUikYA4+pE4wdF1vKUHY3NHx8jUIO7QnGYpJzKOXFBiplco+/z4=
X-Gm-Message-State: AOJu0YwOETIYd1Hi/wFLi3+ca6eAJmA+WDfh43Zl6qPw9RA8VV3lBdJY
	mA8bpoPfHZ9HKnDO2m5t0iIhvBsXTABeosHiveiOEiKA+rv/6qfY
X-Google-Smtp-Source: AGHT+IHgDGK/BZFLZ4o0q5QlhX+iDooVzGPEucKa4H0749pnNAkElImYC6SGV1YXCUk8M8A4OsMdqw==
X-Received: by 2002:a17:906:3511:b0:a3f:ac2f:893a with SMTP id r17-20020a170906351100b00a3fac2f893amr5794723eja.73.1709550454470;
        Mon, 04 Mar 2024 03:07:34 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id i23-20020a170906265700b00a44dca5f9c1sm2512075ejc.100.2024.03.04.03.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:07:34 -0800 (PST)
Message-ID: <a8c3bddfb7a53682f23f4c99ce46e67ffc0213d1.camel@gmail.com>
Subject: Re: [PATCH v7 1/6] dmaengine: Add API function
 dmaengine_prep_peripheral_dma_vec()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Nuno Sa <nuno.sa@analog.com>, Vinod Koul <vkoul@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, Sumit
 Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Jonathan Corbet <corbet@lwn.net>, Paul Cercueil
 <paul@crapouillou.net>
Cc: Daniel Vetter <daniel@ffwll.ch>, Michael Hennerich
	 <Michael.Hennerich@analog.com>, linux-doc@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org
Date: Mon, 04 Mar 2024 12:10:58 +0100
In-Reply-To: <20240223-iio-dmabuf-v7-1-78cfaad117b9@analog.com>
References: <20240223-iio-dmabuf-v7-0-78cfaad117b9@analog.com>
	 <20240223-iio-dmabuf-v7-1-78cfaad117b9@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-02-23 at 13:13 +0100, Nuno Sa wrote:
> From: Paul Cercueil <paul@crapouillou.net>
>=20
> This function can be used to initiate a scatter-gather DMA transfer,
> where the address and size of each segment is located in one entry of
> the dma_vec array.
>=20
> The major difference with dmaengine_prep_slave_sg() is that it supports
> specifying the lengths of each DMA transfer; as trying to override the
> length of the transfer with dmaengine_prep_slave_sg() is a very tedious
> process. The introduction of a new API function is also justified by the
> fact that scatterlists are on their way out.
>=20
> Note that dmaengine_prep_interleaved_dma() is not helpful either in that
> case, as it assumes that the address of each segment will be higher than
> the one of the previous segment, which we just cannot guarantee in case
> of a scatter-gather transfer.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> ---

Hi Vinod,

Is this already good for you? I do not want to be pushy but we're trying to=
 see
if we can have this in the 6.9 cycle and Jonathan definitely wants an ack f=
rom
you before merging this in his tree. I've more or less till Wednesday so th=
at's
why I'm asking already today so I still have time to re-spin if you want so=
me
changes.

- Nuno S=C3=A1



