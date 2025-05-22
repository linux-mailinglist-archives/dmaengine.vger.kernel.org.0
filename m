Return-Path: <dmaengine+bounces-5251-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 461F8AC136F
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 20:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856791BC746D
	for <lists+dmaengine@lfdr.de>; Thu, 22 May 2025 18:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D95C19C540;
	Thu, 22 May 2025 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N5OBIZQT"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95CF51917F9
	for <dmaengine@vger.kernel.org>; Thu, 22 May 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747938911; cv=none; b=LoZsC9ti+oB6ozTK5j8v6qCJfSwe4RM6hNWIXOkhpqHZHoIk0b35Eu8nL+EYm6TgN3GiPhxYeUDbA7pgQPx/On2yXRjzO0r8/fQy8xZ/AKtDU9ae1PvCnyadr+GxUK/qk//TN0qrlj1z+uUzpe2927ANvGlkfRdnZesXAKuhYxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747938911; c=relaxed/simple;
	bh=f1D9BovMo8iqrKm/nDHPg06l6bXZxkHNmPPS65XcYBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m4+nNrbGbUPg0QUB42KfPiIxqDgIr5XooAemVmhqXNT/t9W9DJBYyX/8dm10k6u4w7gi3N2pQlwqKE1hFLLINPMIuQpYSj/waP7beac0gnbd96EmATn/AlHqmlTF/NzfRoueQ2jR6jtxbyrZRm+kQYZjVUTDPSPUi++RzRge6CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=N5OBIZQT; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a368259589so888393f8f.3
        for <dmaengine@vger.kernel.org>; Thu, 22 May 2025 11:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747938908; x=1748543708; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63yYAU1/zCZjwoovQdKacafDUnTaZ3CpcA6v5mzZ3T8=;
        b=N5OBIZQTP11W2XLCX0Jbk8GCqDhTYKEL6B2ekCTHUsdxYvcb3TiOQCVwQ5aLhW0fxj
         fUHFCxmPI2zFeUELb6clbAiSPtqEqsE89UKTvz4vPura1rK0HcTof9DpjZ2ip6t80wuF
         1hYn5V7bvy7ccohWZ92t5kGhBJsbVkEIsKTyb+tV8KBxyrlHHzLzUd0eQb3Ei36Rnw0n
         W62I8ksm3cY5rTLdsScALT+gOp38LsGkPTKGmKXJHm/aYWj5bI0P0yZ0tP1wzNj68Cih
         hIWxskUo7F+OpGLPZtkUTkoBenIbSfNQ8Kvd1AUafLvLY551ujW6DL8DQGgn7/m/CQ+q
         gKUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747938908; x=1748543708;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63yYAU1/zCZjwoovQdKacafDUnTaZ3CpcA6v5mzZ3T8=;
        b=W3XmctS1R/Indl5hm/Is7Hv+xO3/G2VezyB3JA+uHN1Pd23RK2UyCzHfy5qHg54l18
         2h2fuc8kcn7r/8KoflyEsicpaL4X0aMbd31BcObKy9+Z3B1LCVmoIeM/aoaY7HRwJ/TS
         0/gZRPhQzEiyfynPLm2Hp1MgLvpt0NUB4Pm1i4f/gvEhlOCGFaGCoZTcia5i1DZUjHvN
         KjH1EX/RgEQzmJUuPD6f3ZZdJnmFMNlNVy95OJIVjA2mfBXquWLCAG2iFxBFt+doG3hA
         XOSTva/Wy4w4Faf5hOUbxtNrRq+FnHz3MxH1mflSAeCPLOziTnJ8UVjWXvvXHCiqcWA1
         fZ5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZ0CwtUnRmVzPYFarXZ6VSSRXYhgBBNTcrPVX328+EPiqEVCKk2/3O2hMokDQv3fe8vMN/N2sXqv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvUn6bKzh6J4GEGNpybgVCT4VsAsyN+qPOTbgeRqJ9l4uCrw0k
	gKeg67jtWNcS3K0eIVrPJ2wmgeU0V3PeAB08fsh7wWocqyOeADzf84OAb04waRxguGftQnFhGsv
	jfy+5
X-Gm-Gg: ASbGnctgYO77Cupehx6sVP7Dg+TLCqypyQd7+WVkGDTKyZuETTrovFMLy+gLjQMh4g+
	ekIJAJ87QsFERk9by+rp3HwnsZ0UfwNwxVIkinlmMxjXcfenx38cckbH3DaoaFa34ZwtqPguXKN
	9rxC++midYEpbSxPT0j7xlDuoSsGv2hI3pDDgFmkP0jBwgIHSLSax4LZFY4GeUN5zvxQA09I9Dr
	7jnKMlcxD7NYnMzveiI0a2RI9Ko/BwGKi+ThwotK9QhPaY3zZinB23Lkw/3tlFJWoPZpJCmAF8A
	0/mGNVv/lO4ZpYOmlbRJ1W2D/Jqk7mheVzwmALTCAZtZEGnUxh5mGU18SQdWInJV4pVrkFw=
X-Google-Smtp-Source: AGHT+IEl3vOLOf2Qp9jRpcgL9PTta/D5XWSZ3M7PgmDofFcyAjPs7Cu8q5oB0FbiriHmg1z/1qWxrw==
X-Received: by 2002:a5d:5f46:0:b0:3a0:b807:742c with SMTP id ffacd0b85a97d-3a35c826936mr9382361f8f.6.1747938907879;
        Thu, 22 May 2025 11:35:07 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.223.125])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a36c6eeaf8sm16352368f8f.48.2025.05.22.11.35.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 May 2025 11:35:06 -0700 (PDT)
Message-ID: <2932ac8c-7248-4056-8b9e-4f5702d597ab@linaro.org>
Date: Thu, 22 May 2025 20:35:06 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: sh: Do not enable SH_DMAE_BASE by default
 during compile testing
To: Vinod Koul <vkoul@kernel.org>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <20250404122114.359087-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2025 14:21, Krzysztof Kozlowski wrote:
> Enabling the compile test should not cause automatic enabling of all
> drivers.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  drivers/dma/sh/Kconfig | 2 +-

Ping, can this be applied?

Best regards,
Krzysztof

