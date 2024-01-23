Return-Path: <dmaengine+bounces-813-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB82839701
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 18:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0956AB23B28
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 17:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 673E581AA5;
	Tue, 23 Jan 2024 17:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W1RxQXQP"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01558004C;
	Tue, 23 Jan 2024 17:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032444; cv=none; b=ZdVOQX0nLeHwgZrMd7BkTYwGQiTIroFozS+DtIiIx0XDjyerq7Kh8uUKLTMJrjc/DJpzLg+Bcpq+0BzAjkOm7oFWotVy9kdYBcs7/GUcZ7/J8wgp39YUPukZPHQX+7SzGzBarULijjDveXQTiRE1ExqYygrnIb91nmQKFi3v5Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032444; c=relaxed/simple;
	bh=/Lf65r0jEFfaCyx/YVAM+/B+UJeshYc86BaIyXbVHIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtH+MO3EX4rPPhNaDHjAN6KePAnSQ8+BVQr7IsQ/YzDC78i97iGYCg1RWJTYtDRjSnnD/HP8x2bfu1YjG/s0dWsrl0rZs52KjmrPYr9VM+wNSmm3JR3mshJtb3RG54yTJWn2CfkrtmeKYWt/U5ZEi3eUbA4zbcQunsrBFVugtoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W1RxQXQP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40eacb6067dso28879555e9.1;
        Tue, 23 Jan 2024 09:54:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032441; x=1706637241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T9axCURSdPj5O6k/8fwokenEz2T/EczgGrNIrYgrSFE=;
        b=W1RxQXQPxmgC4hjde1Xra6NULCtL8wQd2yIwEfjwHTwRCf3E53PObHwNcWEOc6Jo5g
         2wAOZu6VEh4QwXFFo4EexEcJezUBIUzLrHdZam78peBnD/K5aPT/PtqB1d6TffFpnVHy
         B6FwUsydRWP9LBo/gk/9I8W+P7kPrXQNgwHrI7J+xAu+p5nhHVoRakBT6/01Zvc/nkiJ
         8ufAjOreZuIsGvc6KvhII6NgAKAV8zelkG3OpPStipRoIXpNZyEuSfgBj+aHnaZRtRen
         l/qs5cRKNryR7lrxhy5BSPHzjU7IM9nWXp7UXqoWC2Xw3LArVQSqjaC3NiUc03k1d0p2
         cw9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032441; x=1706637241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9axCURSdPj5O6k/8fwokenEz2T/EczgGrNIrYgrSFE=;
        b=i3fd0V+uJBBIpFUUOlLbjeo4Qd4EY0dobjE2+8hDPzKf2pLTWcwMDz00ADsVUC6ALZ
         IhLzkJU1uitd82reQlo8biGUS2eVc2M2Vd+QxgBbNbPXqN9cFxJJ7kWB//rE2q4V3hsc
         VSZBKkuqUezB/fA3COZSbZE8fjDs1ppzbs3SS1RT+vqaqHpkz0vEKMAA/sOf0FDgH4E7
         Hqiu9mcLm7Ofjd15sIIGeDZG65ne+Kd9g/zT4s6k0OuiU2BzGqpgClS6nTI57D0maqA1
         HoOZmwSShyK0XvJV7zJ4ieVnzqECW117DJtH54yjlFMzxa2wZ6gETaJvOIkv096xCUvQ
         HFMw==
X-Gm-Message-State: AOJu0YwNPMD/ldS5Y+FYW5X8hwjPR2jZb7yPmcYJV/agSPuA+R8PSTNe
	fYBEoY3NBe6rpd02wamIywpaRAjB5kmqLu+uhJeePlFfD/vsmq35bc2biGvNhWM=
X-Google-Smtp-Source: AGHT+IHfolV3zQWbsCi6txDpI6lqMV3lpStI7mStzT3HOm8ywicmpEIYK00D6kIX3ljjceGHtRFaog==
X-Received: by 2002:a05:600c:4657:b0:40e:5afe:a42e with SMTP id n23-20020a05600c465700b0040e5afea42emr409342wmo.247.1706032441017;
        Tue, 23 Jan 2024 09:54:01 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b0040d87100733sm43414126wmg.39.2024.01.23.09.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:54:00 -0800 (PST)
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
Subject: Re: [PATCH 7/7] arm64: dts: allwinner: h616: Add SPDIF device node
Date: Tue, 23 Jan 2024 18:53:59 +0100
Message-ID: <3786260.kQq0lBPeGt@jernej-laptop>
In-Reply-To: <20240122170518.3090814-8-wens@kernel.org>
References:
 <20240122170518.3090814-1-wens@kernel.org>
 <20240122170518.3090814-8-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 22. januar 2024 ob 18:05:18 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> The H616 SoC has an SPDIF transmitter hardware block, which has the same
> layout as the one in the H6, minus the receiver side.
> 
> Add a device node for it, and a default pinmux.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



