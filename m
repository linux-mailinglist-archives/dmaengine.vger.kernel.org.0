Return-Path: <dmaengine+bounces-7248-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D851C6A580
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 16:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD2794F1BA8
	for <lists+dmaengine@lfdr.de>; Tue, 18 Nov 2025 15:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA40B364051;
	Tue, 18 Nov 2025 15:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V5rT83jj"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304EE3624CC
	for <dmaengine@vger.kernel.org>; Tue, 18 Nov 2025 15:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763479931; cv=none; b=OLXxNQ8bdnvEwChLKUB7oQdZsImvSYPE19Uqr+C5uE1dZIitpq59fqNu8JigB+cV+R74SzSNlfaHkkWFQ3DlEdEkOU6Miv3jvVa8XPcsMG9jPRUtOqNa8xW9OiwVGYgjzLJRoi4AHcezDY8nr0SHoYdmV8lcYMrBlIJRxTTojik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763479931; c=relaxed/simple;
	bh=34KGTKVHVeHBF1mUoMa8kaJ38TlGQ15s8VmpnV1gKgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fggwmXmvAqDdP6vmdThPuR/3OOYnI9zOtia8vMljQku4nnxcFZCF3IiU1JZL+DcpFlOF+RvsEyQT++fMpiLVW+SLlW4lMZmmVP2HUeysSusQwwKkMs00uEQtGEPlzhrU290QNGQzFk9N1pNT+RV3Gjkngc1b70RlaRNGliiHEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V5rT83jj; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-787ff3f462bso64849397b3.0
        for <dmaengine@vger.kernel.org>; Tue, 18 Nov 2025 07:32:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1763479929; x=1764084729; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IxHLXotX/VR/smtmuGtjLAN5l6lgr5iFZlYRIN9JEyQ=;
        b=V5rT83jj75lQdyh2fDZstAnatfHN6YsbNlFgvQITLIR5vRs5Qwttl4TsS1Vgv8uyrX
         DfL95JHOHrQB1gLYlfeWVRkCywD4lLZzv51xhBMej51xBmg/2A5TweAcJr4yAbuOJoXn
         wCVBVDEBkhsX9yJxfftUtxKkWFsiu7RpSo50jSsggH5MHCCVh5anDoTBsCPCiyy/XzW2
         nXJKRCBAIT0zYICrHCH5/8/8Hso4dHbvOxyefgSjDFvrSPycvMJ3qb7sHLcAIvZkJrkG
         0/fBozesXWPlLBgWQYxLUgidlt6Xt5tIjvk13UR0wkxxczO+I17XshiGoPenPTewtT6i
         Pk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763479929; x=1764084729;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IxHLXotX/VR/smtmuGtjLAN5l6lgr5iFZlYRIN9JEyQ=;
        b=vnqioWp5ru4RSUvipxUKmttnc83oBJzNA0LzTX10ZF2xs7BGshwJWAHbEe1fZ8FRyt
         T2yOxm5pyiP92j0a6ByYK3NPostpsNrivY9W0X4RcR1SmIen7M1WY7PcPFJ+HZpu+anT
         x6fELc84ScabvrUf840H8NQtltNlRevEByaoWQ/TXtz4mdGPI9rJi5zuzlQZQqa0ytxy
         +Pwc0TNXFUyz5mB1nMJ6HXeksS2ggG8GoX9Ua220pOVS78ffCCht2yYcM3VfCjCEu+qG
         msNLESFYDbJNtXwwDwQmwdUDHdrLawICzf3HK7SQCfe9uEiVJyD8VqjubFJOhqu1nVaU
         WwYA==
X-Forwarded-Encrypted: i=1; AJvYcCX9o2+1SDFi1pGDKL0+yDQ/wGHrDRGZDo8q/MynfB95oJiZhqnASbSS45dzNoH8986KbKVt90VMDRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRtsDiulLMHba8FRuHJCe06M8/8zdvaH7k/SawFyf5rLrv2E0
	DdDiBE3xzGdHrPdRRx+deFw1zG3mO2tv7ZkmrY8uV3mmnTCWMxLhb9NX5dqX/8rws/brYC/pWmA
	gpasoG4Cb7ejhXUFaDuCA2WG+UHhVS8PhFnX3vDgJUg==
X-Gm-Gg: ASbGncv1iqVZP2OOKbH6wVbeaKEqgq7IR3zFdLKYvJJoLlErkwvhmYrKBcdsxVjEFlp
	65/IBkW7Aao40Vv8iiWS3HRH/xTxcnUQXjqhnEtyYP1FkxzMU2U9sU/1BzKJf9CQEk1rgyQxQHN
	m0g4oL72JHi7tRjwraeLb6P9mTIj91cju5aZoEBLPw/Tu2NJ72CqqDt3UGz9wupFFB/S2U0j0FA
	eA2t6klZ+XLlTfWBeod33AKhYbarJJ91YyMvboEuRqzjA0ZcXYOMDubcvFiGkDQye7EympfGhPO
	YlmT3JgqbDFUBOe/xA==
X-Google-Smtp-Source: AGHT+IEc8GglvCIsD6cGrALsj9LLh6N+Jx7VKw+16XtXMLh8fZV72joZEMGSMeUR4bEuhwbV7IWYBeRgua2rFcuL8iQ=
X-Received: by 2002:a05:690e:d86:b0:640:d597:4170 with SMTP id
 956f58d0204a3-642132db3f6mr2565633d50.0.1763479928233; Tue, 18 Nov 2025
 07:32:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251115122120.35315-4-krzk@kernel.org> <20251115122120.35315-6-krzk@kernel.org>
In-Reply-To: <20251115122120.35315-6-krzk@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 18 Nov 2025 16:31:32 +0100
X-Gm-Features: AWmQ_bmXlb23IcHWwlaA2kdC6A8acUsbATP4k59c9PPxA0jX-7QbyyZj3x6u5n8
Message-ID: <CAPDyKFpquaBo64eKvMPiCPdKrPkYc8fhpaOmFL9KN0UzFs0xkw@mail.gmail.com>
Subject: Re: [PATCH 3/3] dt-bindings: mmc: am654: Simplify dma-coherent property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jyri Sarha <jyri.sarha@iki.fi>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
	Michal Simek <michal.simek@amd.com>, Michael Tretter <m.tretter@pengutronix.de>, 
	Harini Katakam <harini.katakam@amd.com>, Shyam Pandey <radhey.shyam.pandey@amd.com>, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 15 Nov 2025 at 13:21, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common boolean properties need to be only allowed in the binding
> (":true"), because their type is already defined by core DT schema.
> Simplify dma-coherent property to match common syntax.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/sdhci-am654.yaml | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> index 676a74695389..242a3c6b925c 100644
> --- a/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> +++ b/Documentation/devicetree/bindings/mmc/sdhci-am654.yaml
> @@ -50,8 +50,7 @@ properties:
>        - const: clk_ahb
>        - const: clk_xin
>
> -  dma-coherent:
> -    type: boolean
> +  dma-coherent: true
>
>    # PHY output tap delays:
>    # Used to delay the data valid window and align it to the sampling clock.
> --
> 2.48.1
>

