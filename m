Return-Path: <dmaengine+bounces-6283-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA4DB3AC20
	for <lists+dmaengine@lfdr.de>; Thu, 28 Aug 2025 22:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63EB03AB425
	for <lists+dmaengine@lfdr.de>; Thu, 28 Aug 2025 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A43317A300;
	Thu, 28 Aug 2025 20:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ma0UHEbi"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930B29ACC2
	for <dmaengine@vger.kernel.org>; Thu, 28 Aug 2025 20:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414778; cv=none; b=qFWHtbVsIEVcO1Om7CMZ5gcf34kKgZrmJxE7ZZAfyArnSNiF5NmEHAu8CQ4JHWoMudk9fzmmcoxvQG/3+YjsoCmbot4BqwSpVUDFDIIguS/0InqDF1Kx/Incuktgc4WseE8sOQKAWwo4XIBE36RjB5hL9pKWU+oRl6zBoh3zKLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414778; c=relaxed/simple;
	bh=nhUyagpznBFRZ9pdGyujL8snMtRV7AxzIDv/2iWCkkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X4IumSWb0kowzZOY7qE7tpxRxVc7ACdqz5L42UBgnOxvDYsTzOCtFIHxDhbmLmgaij1QgQZwA0c001xOxnj/ZWdTosj1rtJb9hZzvmrA+tFB1B1cP03jnXZXn2CX/qigvzLUnxoNbFMhLM9YuPkRBE4k+vntvyljoEv+mFB3nhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ma0UHEbi; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f6507bd53so846041e87.3
        for <dmaengine@vger.kernel.org>; Thu, 28 Aug 2025 13:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414773; x=1757019573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhUyagpznBFRZ9pdGyujL8snMtRV7AxzIDv/2iWCkkM=;
        b=ma0UHEbiqECEh1ErdOJKkoTyNFYpeCWAacmYShnvRQtRoLZw0bgzRlsCjg9W4G05n9
         +tZq90pA8y2W96oo9gJz3DFMyIbReffSe0GCsxR7W4QNpvMQMajQS11gI9WjHmlS5/Mc
         PVErZ3LQQg0yK71YfAMF89IX6GMDptM56tP2AKp+h7SkBnQ1TWOPdQw9Sv7C0qcWdwEi
         45VtKF2ccAVKTJMbuQSGsqXuKZLPWwCdxAxB742/7pA7mmvOtBPkvL4cTNMwOKQRVi+z
         1x0asfo3p0mDwZxQTQa+qVxw1A+GwnJGx7QDVH9uk/k80sBixcSfQgo1INWRs/KflI72
         hnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414773; x=1757019573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhUyagpznBFRZ9pdGyujL8snMtRV7AxzIDv/2iWCkkM=;
        b=lPdAApIKSx6Iu4C9bTfV2cx6Y5c/vPWy9AKvqPxlQh1Li+KYdZjwZ5xErtLokWwpi8
         wetDw5R3csvgry4CKbXZYlyq2pZGVQ9ivceTH/Ao7nY4QzMFo86iJAqkXYzMRuFT7aUx
         bdfYsgETgqOXUGqwCDQsKWQV5VQSLwi9NpNbJJYDTEzipcQgM66EPN5SCCIowDdUIWb7
         sX6nSTtgIXLUsVV3l5bBR0ad3+gAxAadG1cxyUOxr8YGE76ghjeCpama0HsLpxyFHcJf
         TB4d2Er4Np4tv9v3rs4QXXdXmW7QIQj+5EUSMMLNMF2eO7kYipIIjU388PDhjVa9X31p
         cheg==
X-Forwarded-Encrypted: i=1; AJvYcCXWIpgRbV/PeQRCOPKmNbzQuhxC2cmu+7nJqPFC4kAVNTfn9p8Q2EMkSB6zOoLiXzzhfZP9AKST/Hw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy95wOmZyJiORiFwHWFT+dLIHT6whWAIWEiohCdlnSOYJJLgagw
	BLzskK7lc/8fQK8TGtMsraK+kd2nIgpDng6o0OxOKYzQQVlwaw8bNgczN3zKA3vm3ce3zC8+hve
	9+bsu8mSd5j125Za5JCX644hLL02g5E/frfj6KMBhZQ==
X-Gm-Gg: ASbGncs6e73n7Cd+ivLg3JPWgXDuoXKeQWVhYpEEsqAkpozV1pwWkb5QVrqMTW+hsOM
	sTqJJYa8ivqJiVUfsdRQJIMljhzhIyrpJ843Z+ymZQgImgx5oF5Zxq9ebBEcMUb3LBi9QA+YGc2
	//VTplM6tvaDE53z6i8sj2zEqg0ORQ3MXmQw4D6eK2ua/CrXA8wsLUVGI8uiovq8sohMOuM7sjE
	t/rHWE=
X-Google-Smtp-Source: AGHT+IGkAeRfSepttrAWspST3WxeFhzvmsQkOJn8zGWgyydoFU7mfe7dFpmDKHnPoU/jmN1MyfkA6699WvyfKPSV4Ms=
X-Received: by 2002:a05:6512:6301:b0:55f:503c:d322 with SMTP id
 2adb3069b0e04-55f503cd585mr2344975e87.40.1756414773211; Thu, 28 Aug 2025
 13:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-8-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-8-507ba4c4b98e@jannau.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:59:22 +0200
X-Gm-Features: Ac12FXwdi56r5WxKQlnuWh0e5CWqxbReZCdYkWbkMywpfjpFF5zgYMlMEAzYzgg
Message-ID: <CACRpkdbvLhTQ8EujGg9QMbuGVRDnH9ApVxVt1NdmSmPw77QXdA@mail.gmail.com>
Subject: Re: [PATCH 08/37] pinctrl: apple: Add "apple,t8103-pinctrl" as compatible
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Hector Martin <marcan@marcan.st>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Mark Kettenis <kettenis@openbsd.org>, Andi Shyti <andi.shyti@kernel.org>, 
	Jassi Brar <jassisinghbrar@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Sasha Finkelstein <fnkl.kernel@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johannes Berg <johannes@sipsolutions.net>, 
	van Spriel <arend@broadcom.com>, Lee Jones <lee@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Michael Turquette <mturquette@baylibre.com>, 
	=?UTF-8?Q?Martin_Povi=C5=A1er?= <povik+lin@cutebit.org>, 
	Vinod Koul <vkoul@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, asahi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, iommu@lists.linux.dev, 
	linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-bluetooth@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-pwm@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-clk@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-sound@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 4:02=E2=80=AFPM Janne Grunau <j@jannau.net> wrote:

> After discussion with the devicetree maintainers we agreed to not extend
> lists with the generic compatible "apple,pinctrl" anymore [1]. Use
> "apple,t8103-pinctrl" as fallback compatible as it is the SoC the driver
> and bindings were written for.
>
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

