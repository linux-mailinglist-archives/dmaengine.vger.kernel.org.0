Return-Path: <dmaengine+bounces-6284-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D30B3AC2C
	for <lists+dmaengine@lfdr.de>; Thu, 28 Aug 2025 23:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30745580728
	for <lists+dmaengine@lfdr.de>; Thu, 28 Aug 2025 21:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E64C2C324C;
	Thu, 28 Aug 2025 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dC1uDxHL"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABCB29A30D
	for <dmaengine@vger.kernel.org>; Thu, 28 Aug 2025 20:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414797; cv=none; b=Owot0bZ5pDNQRCJmqwCs11DtFvSYlh5rhPTtRAqdtFPiEXtCpI68cWXlmS/Ej9rxeO/q4X+v5mpDu1laAIju8pG7cQ3BO/yUEHS9xEF8laSoPDZ5bZpWKUq2dnStBPer1A5F5NxFKp9GlCOKnBIR1SZM40QFYLOF1/PEk9uYmoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414797; c=relaxed/simple;
	bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a5JNA7FNWVXu/kfPvebAyCGbKXN1kGNKCwDXZqK8oDFszL1Td/+opPPbEjOdvS6RrbeF1YZGIO5WVSIdQ1s1njxlYeNgo7m47FgRXJfDQP9Winn4zbTndk1Ymxgws/o9Hn7xNG+JOUTpCuoF9br7KR5BZv1Uh25nFoRkgjvPAig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dC1uDxHL; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-336b63d2e56so1217491fa.2
        for <dmaengine@vger.kernel.org>; Thu, 28 Aug 2025 13:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756414792; x=1757019592; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
        b=dC1uDxHLdzR89Uj56ebMGaoDeRvegTy02rmD4lDoUGNwIlNRsYa+MDnEwUwxYsuVya
         Y8brW/f7t8jPxSO+kvkkj5EpDjPec/e6TYHDcu5+BEGKhiYpSHNcgh4PjIPQTjSrFuGv
         29bmDkLl6eQ4isdMBsaJKvQxTXRA97n+Owzb0UaOKn2DK5J6NDKruHPhNyLdj28A6f1U
         xa7AB1eEBovGXqonRimswFIIH/UBqn7V2U2Bz07sKbRA7ciRp74+aSbBdni3PZz/n9wh
         ArMCqsNRws0dRWKWBV/F+8m8qKVhCtZunjvcaF8fk8oIzDZryq51BDa8XZkckv0/glo7
         4tVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756414792; x=1757019592;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcH+lJXlXkzbWh1s+giYmvp9r3m+hUxJ894v+cf3nQo=;
        b=qBJ6aKcexAFX0llGq73mWAV/DUC59vi7XmqgS+BgMbE/VTqWGq9/W7mkPvDO1f1MEw
         YIjxn2OyrjKBk6wQzunv+9nrisNczSCZWuQ6yFEGSGpDr73ZvPmHYa1GrDO4UweV5CT5
         rKi1Fe7JrymV9UTKrnUalbyF8Xa5zh9cye+L+NrTFOrtQbHuaXW1EuWkfxTxBFMvQtgH
         b7qR1gOsyn5Yg3UTUS59tsaG8xAHPl4yUAiw77A6pH2eyhfrJK9LECunmPCeBh/gjjNR
         Q3j4aNE+LSAm1Et9MYz2BeTztVAYetz46sihvDiPCFJbLjeKYRZy88WLziWjfzh/R/1e
         KnwA==
X-Forwarded-Encrypted: i=1; AJvYcCUoSNkXjgcgUhz9FLRaHT/WZ0lyzyOqqspnc7FelhRMiuJEATEyRDXQ5zZ/B3kT20ZN0t+vjyH6pWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEzzH5CfB1sm7fCXFFiPuERDeKEsoDX1GFPXbbl3D9yeLnwy4H
	ZeWUoSN5xDCELFLtvlg6jXQA5xzW0nzYFvdHy4IVbb6U/AG2d+deUKnjDGQeidbJnmFGdua6FCZ
	WWyfSCI+hIC2twYrY/IuszQnRB+QVNTMVBsTeIz4Qvw==
X-Gm-Gg: ASbGncuIHDttbuFH1nKS8Dhv7XnHvqVyHQQ03uC4U8b+9JHmdTBeE1ePpOgr4LHocTw
	248FXa80OlX7iyXPtBBf3e7RekCgqfqaU8dKrQEHIMOfjRTz7adraMJpDPB96h5ihwc6phKUYgV
	ivB6dP2TKAAnEnsFjCQ9HIwXCuDk59PeXNaVN7xBuE+NuJX0395kmFOXbYCYmKlcyhIbqLolbah
	87n3aw=
X-Google-Smtp-Source: AGHT+IEvCK27Dx3T+NwB4QTV9UIlsAab63smCZ6D7uUks2NtQZowbM82iFbh3N6kvr8t1WPK8CdOU0xtB51L+4ds/dQ=
X-Received: by 2002:a05:651c:3256:10b0:332:3fd0:15fb with SMTP id
 38308e7fff4ca-33650ba8612mr48592831fa.0.1756414792241; Thu, 28 Aug 2025
 13:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828-dt-apple-t6020-v1-0-507ba4c4b98e@jannau.net> <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
In-Reply-To: <20250828-dt-apple-t6020-v1-9-507ba4c4b98e@jannau.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Aug 2025 22:59:41 +0200
X-Gm-Features: Ac12FXyoYnYKNXDomZzl4EdS0dXvIhCV2tkZJGb1B6Y1kaQgUA-l_NpqH411N_c
Message-ID: <CACRpkdbg8KYcDpqDKn9fqs+rL9hLK9mGCj0PTXPBGDW7A_AZbw@mail.gmail.com>
Subject: Re: [PATCH 09/37] dt-bindings: pinctrl: apple,pinctrl: Add
 apple,t6020-pinctrl compatible
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
> The M2 Pro/Max/Ultra SoCs use the same pinctrl hardware, so just add its
> per-SoC compatible using the new base as fallback.
>
> [1]: https://lore.kernel.org/asahi/12ab93b7-1fc2-4ce0-926e-c8141cfe81bf@k=
ernel.org/
>
> Signed-off-by: Janne Grunau <j@jannau.net>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

