Return-Path: <dmaengine+bounces-809-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB32D8396D8
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 18:49:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8109B1F21A57
	for <lists+dmaengine@lfdr.de>; Tue, 23 Jan 2024 17:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D2811F5;
	Tue, 23 Jan 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8tDoqL4"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F86811F6;
	Tue, 23 Jan 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706032136; cv=none; b=uaYsDuD24rZeuSGenCEoQWJtJaCpnMkrNxNtZ/xk+6O1i+pdssjEtoAxWGrDFdvnn0qgFJnh5K9/WL4CSNKati7LDvGGP+JpeyF0HRUi2oUBuNTY4u/gUr+Ms+LHNDFNo6a4JcEF6NIylU1ejnmjp4pAFnUu8LQ4zy2xkLPacnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706032136; c=relaxed/simple;
	bh=QQ9uZ4Wazjii5m802qrsRtRIm765++713g/rq7dljig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VgMQ2WYJDbQMVLoDBwPaeHE7VpTHhnLmm2/B0CkdwjVTZrcGJCw3NXbhQAggOwMt82Hr2kLT2RiseTJAV6f3Of/slMDE1L5g8Nm6/rfmWRY8ZukoA9qI5P04ZHtSh6ZM49tiyaqaFnmW4JYEf7G2jDUf+S/22BRKeUc6Ff95E2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8tDoqL4; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-337cf4eabc9so3753213f8f.3;
        Tue, 23 Jan 2024 09:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706032133; x=1706636933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUjlyaIMA5LD+Pgub4rYNwex11S+1W6zP2cY/Lr1Xls=;
        b=Y8tDoqL4P14FPmRdnia+YasCKacgcDoSIoz32rIb+nbjdKa444md6RAUiyPg3ABLRD
         ll1+u+HbbU4Race4hgDflHeVGCseT6joltFc5xCt6IT61XEWQC/39lL7DmQdHCg1NCOF
         ajICtrFwtMk7OYUFjLqS+o8U5+gp700tfR8iG0vRbuajRU+HtZpYDoErYQfTMGXu/C/R
         Eh3s0cUeh0VNvYHwQpKtBO0r4Xebl1Yq4Owg49Nr8U//8DxMW/YCr25UOdsKIkShX36y
         Xqiwyi3eN943waCFAgjxuUlnyvetHLAs47IRlZhAsxjZZAaZKD2h8NM+2rvP8AM7qs8j
         miZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706032133; x=1706636933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EUjlyaIMA5LD+Pgub4rYNwex11S+1W6zP2cY/Lr1Xls=;
        b=RjihdfSsMYB7AlM+V5ROZZOy36FESy/x51lbC9XyqZqAtLtMJezQMuyNWIAeTOJs3B
         GmiA2DxVEXgnzGy2sFwzZymnmibLpAf9jnREFns7hGBq8oRNUM9HGAJuQcM1jjGJEpTl
         7LkHaD3FQgmtj7eqg7l3jbIOFy2WGxXrggI8xjFMrFdioHbnm3fVABAWnCCYNm1+sxdD
         yR0ytozA25XN7yTwkj6JfujGqmqqBzj9N5BwNfegziV6rNRvYoo1zOped5VpordOHXf8
         Zhkpubw14v2E6VIN6hyqs8nCOzfp876UJGIUJcZu+KjRqaaqHK1LVm9do7jwakq2vAbm
         EWMg==
X-Gm-Message-State: AOJu0Yzr6ofuctxXZg3q6RNTakKIkCz2ucZ3GEkwZiFpo/KzTZgD7MIl
	HBBHDnbCAuYcNrJ3JZx3MvgWCNdB4aqqoJ63RNzHLiBo+5Wpw8to
X-Google-Smtp-Source: AGHT+IGctHEVFEZp6eUBc8QU6uDhSqzejWNbzNEdCvC2potV0ciD/WNpi/cB1xLvCujpx1Tux5Yl1A==
X-Received: by 2002:a05:6000:1089:b0:337:c80f:6e19 with SMTP id y9-20020a056000108900b00337c80f6e19mr3407648wrw.69.1706032132766;
        Tue, 23 Jan 2024 09:48:52 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id y6-20020a5d6146000000b003392f625adcsm7158392wrt.36.2024.01.23.09.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:48:52 -0800 (PST)
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
 Re: [PATCH 1/7] dt-bindings: sound: sun4i-spdif: Fix requirements for H6
Date: Tue, 23 Jan 2024 18:48:51 +0100
Message-ID: <3271743.aeNJFYEL58@jernej-laptop>
In-Reply-To: <20240122170518.3090814-2-wens@kernel.org>
References:
 <20240122170518.3090814-1-wens@kernel.org>
 <20240122170518.3090814-2-wens@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Dne ponedeljek, 22. januar 2024 ob 18:05:12 CET je Chen-Yu Tsai napisal(a):
> From: Chen-Yu Tsai <wens@csie.org>
> 
> When the H6 was added to the bindings, only the TX DMA channel was
> added. As the hardware supports both transmit and receive functions,
> the binding is missing the RX DMA channel and is thus incorrect.
> Also, the reset control was not made mandatory.
> 
> Add the RX DMA channel for SPDIF on H6 by removing the compatible from
> the list of compatibles that should only have a TX DMA channel. And add
> the H6 compatible to the list of compatibles that require the reset
> control to be present.
> 
> Fixes: b20453031472 ("dt-bindings: sound: sun4i-spdif: Add Allwinner H6 compatible")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



