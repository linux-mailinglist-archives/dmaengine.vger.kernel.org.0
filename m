Return-Path: <dmaengine+bounces-1739-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36287898301
	for <lists+dmaengine@lfdr.de>; Thu,  4 Apr 2024 10:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A571F2258D
	for <lists+dmaengine@lfdr.de>; Thu,  4 Apr 2024 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10FD6BB46;
	Thu,  4 Apr 2024 08:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MQe8ddn8"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4963679E1
	for <dmaengine@vger.kernel.org>; Thu,  4 Apr 2024 08:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712218723; cv=none; b=cQD/3e1kKkLdrwxnYJmOuF4A+XD9N1D39Qu6OZx5YRxXmQ5VtsU79VKTc3URImaHYKOa+2Iya+gDfUARAZc8yiYBaRcZCCwhBcEhaD+QUFOEH2k+AAhhEHr4qGL9E0xSnatiZMIxtNs8psW+ILh1yVH7JtH4sMG3a5S2k1ZWRUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712218723; c=relaxed/simple;
	bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpFbWsX0vtZzMOTz6ln5Bc6nZCjKz2qigecO8hGR11FivK2C3Q/8FEBtJejFeu5gSfArrbKlOp6rhN5cbDktdopbcz5UDk8XW4tnzLQd71kwMfjZsjwQu+fqOBC4pYSAABXrUrjO5YxHilwNJZtiKD35oGKS+iWJbTrSVrDPs94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MQe8ddn8; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc745927098so736275276.3
        for <dmaengine@vger.kernel.org>; Thu, 04 Apr 2024 01:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712218721; x=1712823521; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
        b=MQe8ddn8hPCohkddiIdfjpxUkDgJfFcLgz578s90FL1abBGWq05W/lle5UAnhJLadA
         EfqU4JIiFXsKnpC9HVNB227hiL69Yne4IdbsawEmjvi80kZuAtpopTdIccmEHVcXq+zD
         Xz56eU0Wd1xhiuampa6zSfTZruO6Q+ePOgzKMeBqKYd90Ya1ygSjImtBE4Xud0KFnvpP
         7WcL4GgiXD+SPPaH4OGUK9cdbdbMFFO9t1kK2UO2Hmp1gju0ScVA177lRivKSOCTlbl6
         UTDva2eOtgb84bZJsHelg52wi5cOf7hiYaqx4E7SRGlWv405pZZEhby72I/YMxkfeWFQ
         tauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712218721; x=1712823521;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyAd8Fm3t44gc7qEKT0d4Zv8xoYimRNogrja13Iomu4=;
        b=Nk8mmEZOJsP5d6zInHPWIhmTc+FQaBCjMxuWTnZlXcm9f1OMTghNKJzIkypj+p8aJV
         L4Ja7tiWeO2/Lk12gwp5xPUbPcJWsJ5i8lJ0lGZoSnm56jtNFJInSXK3PhyfRtO82o+U
         h+NNHrCk/lTMWsHzj1HtPkJWJI3Fs3dtsHWMhmY/80nEkkl+KUkyAT8cgxB0eSBNuQ5R
         oL38XeKJP5cf3mHCzWh/ztd0PAzEJIKB5yuDfLmVNtgBKZi8IdHif9WvYzLd9I9aCug6
         1Tgv313FARJMrUvx3/NzOTHYYFklZJbkVy1NGnh+HFyGFz7u7SCjCkb/JzKcwJDBlcKw
         Bv2w==
X-Forwarded-Encrypted: i=1; AJvYcCVsVrAX9V5Xn2+rMuML6rgmvuJDYaTl3EG6XN45nyeRccS/0VaBeN2xJ06QPTYV/QcMwleantUFm7qk71Y3qLzO684EEOmu6juw
X-Gm-Message-State: AOJu0YyvqOlNZ6Qo4tNm9AVUva6uLltqj+EahKuhn1X6Kg8g5/9C1Nfj
	4fMHA7By/7LrT20ATZhLr7VayBBTn04Q3oRlYPRlmIPCAZt/G/yT7RBiCmWAcg8Ayv3F5WLfmvu
	049uLzaS3/0BzEMG0cDJovgsOUVaYubcX4cCfdA==
X-Google-Smtp-Source: AGHT+IF10RS0Ghp5cgYZUvg6PBzUDvxfLN9KgcqveP0TSNC3zgxigAL30JAOcgZTHb+RkMpEFaPK7ZHMMNnVTswBtzY=
X-Received: by 2002:a5b:d06:0:b0:dd0:6f7:bc3b with SMTP id y6-20020a5b0d06000000b00dd006f7bc3bmr1651889ybp.10.1712218721029;
 Thu, 04 Apr 2024 01:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-module-owner-amba-v1-0-4517b091385b@linaro.org> <20240326-module-owner-amba-v1-15-4517b091385b@linaro.org>
In-Reply-To: <20240326-module-owner-amba-v1-15-4517b091385b@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 4 Apr 2024 10:18:30 +0200
Message-ID: <CACRpkdZa7mszi45M72qKPM=NJtou1A5DjVVUFzChFtZwzwVZyA@mail.gmail.com>
Subject: Re: [PATCH 15/19] hwrng: nomadik: drop owner assignment
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Russell King <linux@armlinux.org.uk>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Vinod Koul <vkoul@kernel.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Miquel Raynal <miquel.raynal@bootlin.com>, 
	Michal Simek <michal.simek@amd.com>, Eric Auger <eric.auger@redhat.com>, 
	Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org, 
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-i2c@vger.kernel.org, 
	linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-input@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 9:24=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> Amba bus core already sets owner, so driver does not need to.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

