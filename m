Return-Path: <dmaengine+bounces-2259-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB8B8FC45D
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 09:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7643BB2B02E
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 07:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4319F18C33F;
	Wed,  5 Jun 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WG0h8kF0"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F03218C33B;
	Wed,  5 Jun 2024 07:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571894; cv=none; b=YatX5rQBQoobVxpeatDpBnQT/y2veEthNHIq4EmEk9Bp1KY7zShia81Ix+q5ixKM/nEa60hO1Se/z5tgMCwYwhd1hC8S8QX0oTqr7ft+SYQCdYScWp97RvbJATSanHZ1XEt054arGzJXPw5r5naVOlhqtTt9QmEY7Z2hY+NP00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571894; c=relaxed/simple;
	bh=dLZfj+lF2pdzUNgY2vq7Z5VyS4ll2D19Bifu/3ACJII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JmQ6NDo6sqeWevK5EZHRi9F2oLaejkBs7yEsA1VEUvP6BkqwL/BjLVXRRSABc3Yia+GjFrUjLnpk0ne/G4pUWa91Y2DdpWXJ39B1BG8j5GvdGmVbucZbmbQmggxW7M46yYbQ4Nl9myvYVrkbKl4QyV/WMW1s6KcFan7vJXwZkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WG0h8kF0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso2524615a12.0;
        Wed, 05 Jun 2024 00:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717571891; x=1718176691; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fFZLLJugyEkXACayOyd5Vqrj8cwmkHVVSRUdcCX1r9w=;
        b=WG0h8kF0UhHHTyMLLfLEFlMxNbv26hb+TdRL8ajrSzeNVKNbN+yGbSp8VYRrZuBNQ7
         o9lSSQObRXrxB1baZHGGVwYwf+5QrwiRxQbOfvqTJu9kqptBzJe7vYcCy99T53Rg28oA
         i4ypFTFqGg4R7cmdVIuZENCt+MM13l8ZhCYgSc99zduj+zwjUYOmWRAm3lCgGQIUzPFo
         Qf/UbqCa6w2Xyt6x4myTW7T4XofgoLBdS0grHcZuV8sHYPdSQWGd5ciS5oF6dj9b5Q8Q
         L55Ovy3GtB0XJ13OIjUjjQHnj5LEIkFa/0DDeRMJgbfwMXer8fceAz3yz0mkY5oFGitu
         Bw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717571891; x=1718176691;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fFZLLJugyEkXACayOyd5Vqrj8cwmkHVVSRUdcCX1r9w=;
        b=L1n4SCpQNZkKUfAvWNaowbpXBfM4TE9YLrwIoKfqSZqPGH1T2JdEwc7y5u0A97n1bz
         Vn6tFvU+uzTSfl7toKHW/srUVVmN6YR/lm7T8YcQqw6pMV3MHm5PpdottDCM5L0CvIOV
         QyKk/Gc6rgGi3Y1oHkDJdNwUhj1A/KCSakxvzREQTU/mTiig1AlnppuQKHoE8V5rCUyy
         gqAdgwlTFm681DpyTrjHy2a/UdnarorZnrR3IsnCPykQj6OlKOGXewOkmU7myGZy30F3
         144waxQwSKWtc1sj4Ixxk/5S79ztM5xLVoHAS2SeWPSBczvrV/g4HyQ04K002Qf3hPZd
         Qdlw==
X-Forwarded-Encrypted: i=1; AJvYcCXvjn1zTs9+kobc750W62K+XuPPTzElbunUbBjsTBjYZbuJ2bm33r4l2QWkmnrSOFfdPiWrCLQP6J/dUaJk0uXegr+932hHILar/RdwRMDR2LEZnGEjk29/AtONI/wqdaS6Mvw6/SZK2N5vVhytVVGFeKk1f/0jbvYA18sJI17KpdrE1Q==
X-Gm-Message-State: AOJu0YyMYdmBijSiqN25QJO2VpAS3L7sXJddih/YCAD5eGWrDeSWs2iq
	QYDlF+aqs7fxQhKrd2hyEasqOGJFyFHHO0vqn/1eKoKVSTeuc9F5sNSZNf3IVASnJqMyGpdQQZg
	jXbSOoUy953d/GjA8n7GBgquxizo=
X-Google-Smtp-Source: AGHT+IGCDDriZeoft/BQkhFfCJxIbesa8W3MH2Arr0IrBUIEL0fsCEGslzaYr5dbseFZeSfmz8I3ox7Q/mLHlr/UNSg=
X-Received: by 2002:a17:906:3786:b0:a68:e335:3e62 with SMTP id
 a640c23a62f3a-a69a0017340mr101774866b.72.1717571890486; Wed, 05 Jun 2024
 00:18:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240605003356.46458-1-animeshagarwal28@gmail.com> <1b98bb9a-8373-4858-b31b-37e6f9da453b@kernel.org>
In-Reply-To: <1b98bb9a-8373-4858-b31b-37e6f9da453b@kernel.org>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 5 Jun 2024 10:17:57 +0300
Message-ID: <CAEnQRZDWFN2Fwb5Kxn-TkP_uUah-dz-fSO7t0MJjXFgW+5hixQ@mail.gmail.com>
Subject: Re: [PATCH v3] dt-bindings: dma: fsl,imx-dma: Convert to dtschema
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Animesh Agarwal <animeshagarwal28@gmail.com>, Vinod Koul <vkoul@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

On Wed, Jun 5, 2024 at 10:07=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 05/06/2024 02:33, Animesh Agarwal wrote:
> > Convert the fsl i.MX DMA controller bindings to DT schema. Remove old
> > and deprecated properties #dma-channels and #dma-requests.
>
> Where? I see them.

What you see is dma-channels which is the newer properties. We removed
the deprecated ones named '#dma-channels'

See the original txt file:

-- dma-requests : Number of DMA requests supported.
-- #dma-requests : deprecated

Funny or not there were two properties with similar names the only differen=
ce
was the '#' at the beginning.

We removed the deprecated property named '#dma-requests'.

 > +
> > +  dma-requests:
> > +    description: Number of DMA requests supported.
>
> That's confusing. It is supposed to be deprecated.

No, this is not deprecated.

The property starting with '#' is deprecated and we removed it from
the yaml file.

For example you can look at this commit:

commit bd1eca7b2c66c53873a0eab84f9f301aca41f33a
Author: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date:   Tue May 3 08:54:04 2022 +0200

    dt-bindings: dmaengine: mmp: deprecate '#dma-channels' and '#dma-reques=
ts'

    The generic properties, used in most of the drivers and defined in
    generic dma-common DT bindings, are 'dma-channels' and 'dma-requests'.

    Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

