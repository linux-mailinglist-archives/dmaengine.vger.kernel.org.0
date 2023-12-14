Return-Path: <dmaengine+bounces-530-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F266281348B
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 16:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CBF2815A5
	for <lists+dmaengine@lfdr.de>; Thu, 14 Dec 2023 15:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1DA5C909;
	Thu, 14 Dec 2023 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4YLIvGa"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98511128;
	Thu, 14 Dec 2023 07:21:06 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ca208940b3so105281911fa.1;
        Thu, 14 Dec 2023 07:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702567265; x=1703172065; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+ZXfrwNL73DmZRssrQ+Pjv68oLlN6lGdgJdhPN6WudE=;
        b=R4YLIvGaHEjzsyP5WS2CIcQnW/M6WnRfUFGrrDWlQZ39SjgNxVPpnVjfRbWAB1FkIO
         RaWWtj3VUTpKdHpueAHjnVshUh79s5Psug0PxwqrJIZlfKDRKzAhGQoFJHUTljvOuyji
         MzWymvLmOpd6WLCSz8y98wIzwE5nQb9Mev+/d18ABiE+S8/MomdhGa/HuSbaARXrZ26U
         tKWZI0m5D6MEIYv0Burg4OmMC698iGyJ/f22SO+v2QkcrCEL1nI+yV3m5tHdTSmhAbmY
         hczv0m2BalbaLyb5gomfNM0MPMaxeLdB4IobCeR3sGKS8YU9xJpY+HNbTV9VIWIDwa6V
         daTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702567265; x=1703172065;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZXfrwNL73DmZRssrQ+Pjv68oLlN6lGdgJdhPN6WudE=;
        b=B2CNlRF6gz6RLASaZT9qd3Ewa8+27TIAt2IJI6kkphUGLmtR+y1j/jYi9RT7qFZZac
         LKp3wItqnpyRHMNo9pfj36MMRLhihNITkMr8yyDqz41tX66KovZ2Go8KpOC/Z1vFFc9e
         4n6rkOoyddUok8II/blVQ7l5HYF7pi4mgQauFP5S16Il9S2FOnlVa1bdkbFJCqIBYpR1
         ROEHkjvG45eaq5EVlSskW182CAm8VuHW4Nenvp0rcblS4s9KDTzLAZAbAyETocs8GgyQ
         Ir2OSdGJoMZI3rp/Om+HJzxUIUARCgn2Vax7Vjh3GkOANlfo1taovWTW97Zd6YGb1GDj
         O1yQ==
X-Gm-Message-State: AOJu0Yy1ysYaJdXaz5zcn1cMCiG6S7wNP24NIciSVQzqZxcUYI5KgEfW
	u6XN2fjUvB/bD90q/EU9qCw=
X-Google-Smtp-Source: AGHT+IEqoRgb65GiSDyLJiQXtrlfVkyncnLGOkUWsTwy1KLKC86xpxyLNJP3zraanJl+vb4UjdIQxQ==
X-Received: by 2002:a05:651c:1607:b0:2cc:31b4:c33b with SMTP id f7-20020a05651c160700b002cc31b4c33bmr3344799ljq.77.1702567264591;
        Thu, 14 Dec 2023 07:21:04 -0800 (PST)
Received: from ?IPV6:2001:999:500:b28b:4dc9:e5af:1ee1:c18e? ([2001:999:500:b28b:4dc9:e5af:1ee1:c18e])
        by smtp.gmail.com with ESMTPSA id s26-20020a2e9c1a000000b002c9ebbce198sm2126752lji.133.2023.12.14.07.21.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Dec 2023 07:21:04 -0800 (PST)
Message-ID: <b6338abd-f07b-4bbd-939c-f9668551a8cf@gmail.com>
Date: Thu, 14 Dec 2023 17:21:16 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: ti: k3-udma: Add PSIL threads for AM62P
To: Bryan Brattlof <bb@ti.com>, Vinod Koul <vkoul@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Vaishnav Achath
 <vaishnav.a@ti.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, DMA Engine <dmaengine@vger.kernel.org>
References: <20231212203655.3155565-2-bb@ti.com>
Content-Language: en-US
From: =?UTF-8?Q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@gmail.com>
In-Reply-To: <20231212203655.3155565-2-bb@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 12/12/2023 22:36, Bryan Brattlof wrote:
> From: Vignesh Raghavendra <vigneshr@ti.com>
> 
> Add PSIL and PDMA data for AM62P.

I prefer separate patches for udma and psil, please.
The patch on top of adding the PSIL map, it also adds support for am62P
in the UDMA driver.

-- 
Péter

> 
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> Signed-off-by: Bryan Brattlof <bb@ti.com>
> ---
>  drivers/dma/ti/Makefile        |   3 +-
>  drivers/dma/ti/k3-psil-am62p.c | 196 +++++++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-psil-priv.h  |   1 +
>  drivers/dma/ti/k3-psil.c       |   1 +
>  drivers/dma/ti/k3-udma.c       |   1 +
>  5 files changed, 201 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/dma/ti/k3-psil-am62p.c
> 


