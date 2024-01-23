Return-Path: <dmaengine+bounces-810-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 065048396E2
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 18:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC771F25077
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 17:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8B4811F7;
	Tue, 23 Jan 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9tWfBhX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4DC80056;
	Tue, 23 Jan 2024 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032198; cv=none; b=PIHN99Lyip/ruVRhj4+YLNtj1PvYSVs9gG85xsBEdH1rzQhxo26wfNWFm1lpB/Gzv8hR3Dq/FRrFU6D6leym57HeGf15xQqKAzsRzpGANd2QORg1BrizwOA9drSrETcrezw9/lJ3fRLbKAlUziM1fZeOYoWyz/OspjjGnNfep/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032198; c=relaxed/simple;
	bh=pZmhTwrYFluya1Y15DJtUQFyoFTSJRRJJCwBZJCZ/7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rl6ISlssXaeIBkjUX5y1HmfJCjqgfQlx71pGS5ThvT9SKej9h1ookmzyEl7a+beXy4USjeRd6vVKb2YKVzgg3IR2u8/tEJfPCkA9DGxEoOYH35XaJf8l8SOdw+AmPT3AlMS67Bq/A2lUfw9npTsOOBZeYALgW5OelLS4uOttk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9tWfBhX; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso28833155e9.1;
        Tue, 23 Jan 2024 09:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032195; x=1706636995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phUpc3vqpaERggtFkDbvhq6Ow8Zicp3uWb8jHfud6kw=;
        b=G9tWfBhX81Tw9+B5+c/bENYMAaHJ9aD2YQKpBCeLSQ852fiKv5WrZvxx9zX1/3iQaY
         Q0BWvuoL2wUFSS+DO77H7mfuc9Nnv5v4vt0SV1wOh51Z/i17tVP/SykQyFAALLlCYOIv
         YHPud/PJTPfyO/yR8vATHfJ/fVf8WzGXR1uCdzMQrO/iWnrNoJ71RkQNt6NbtgwLITlK
         VJq/AwmOmIgW/ud0TOvzVfP5gV51yo0hbGrOXnetbRdLkkUMffGuN32U2h/uBiOUcz1o
         /rKek0YoSc1jc3zRxGmMkxFa+huI3HuEYQ4E38QCEyzLlzi/Y49Vwho/1SDfYg3yeqzn
         PlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032195; x=1706636995;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phUpc3vqpaERggtFkDbvhq6Ow8Zicp3uWb8jHfud6kw=;
        b=NX5mYVhNOSLsp2tBq0BJe247O7tD+YEeLl8vEIp6dETOrkl3OGEC3R4SXz2phgPNJk
         bkPZYYPoTV1lM+ZoC2qytQql8G38aMUCYlj58BiO3+Z1pIakeMVFDLxI19x6YfBaWHDk
         mPL+Oj+b9I9RkwT9EgVXJgQJH3CSfAxsBPfB/HadEhVFPd88cE63sygQV1ssHDJlNcGI
         o4OLd4rcIYgCb+HDJ5U8OV45Jah7ffn9tGZzWJVLwXvZmwYlhZLy+D/SCV31moB5VDBf
         V8oyG8fpCcjXgZ/Kr4B2m03LDLaYEg33W5k5v6DyP7sNDY3FuFui5djriRi5U1Wl5x4n
         Tx0A==
X-Gm-Message-State: AOJu0YxZhxVnV9R8S43JOT4vPvFYGJ/j7emgFTQ7Zci7sC+GOjxiV19B
	lGqVGJe+b5UrxaU10DrLzMXIIE1u61fPgReDWaf6f5DEe4CS3Nin
X-Google-Smtp-Source: AGHT+IH7zIW6Sody5lpgf0QjQ/UUb5BDBibnCsSPJ9ObnPZSc8pZ+zdBI5rEoa7/i2qPfa4nThePJg==
X-Received: by 2002:a05:600c:198a:b0:40e:4786:9379 with SMTP id t10-20020a05600c198a00b0040e47869379mr416361wmq.103.1706032194674;
        Tue, 23 Jan 2024 09:49:54 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5711000000b00339273d0626sm9662579wrv.84.2024.01.23.09.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:49:54 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-sound@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 2/7] dt-bindings: sound: sun4i-spdif: Add Allwinner H616
 compatible
Date: Tue, 23 Jan 2024 18:49:53 +0100
Message-ID: <8325591.T7Z3S40VBb@jernej-laptop>
In-Reply-To: <20240122170518.3090814-3-wens@kernel.org>
References:
 <20240122170518.3090814-1-wens@kernel.org>
 <20240122170518.3090814-3-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 22. januar 2024 ob 18:05:13 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The SPDIF hardware block found in the H616 SoC has the same layout as
> the one found in the H6 SoC, except that it is missing the receiver
> side.
> 
> Add a new compatible string for it.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



