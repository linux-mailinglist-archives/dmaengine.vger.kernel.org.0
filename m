Return-Path: <dmaengine+bounces-4180-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FB2A1B0F0
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 08:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9B1D1644E5
	for <lists+dmaengine@lfdr.de>; Fri, 24 Jan 2025 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3E91D9A54;
	Fri, 24 Jan 2025 07:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pTK62dgd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 614231DA10A
	for <dmaengine@vger.kernel.org>; Fri, 24 Jan 2025 07:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737703773; cv=none; b=ZQyn3gtZzfs5z1ompV2n07my+o66FO6FSV+mGd9I5uKKnApDt/DgFYNniZSJFPAeNXqVXX7Mu8V1z3kl3jhPwqDMrqg9R+Nla3KQwC86bI4f6zEXdPGjKrCl4ry8n/dMLObEvs1Dz4CHG20/AC0yY4YTrBW9hLWy4s0Fdt7R5Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737703773; c=relaxed/simple;
	bh=q7Fi3/0mHBsmLrdImLubh2UpmYzy/sUBxLRa28tP8gM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H8N87Md3qh1d2hSXO+Y+NXVUOXo0qZeqAY2aIyZteV9i/Fck4CcOWJcCEc+fksrLhI2wVN9GrcE2RoqueWUSrADBTJ7bjrhqz/Sq5kmMq4mm3n82BXf8eRUCVtDp7JCkfQFTfBfcvvsm242H6i0SPAXF7ZAMqwEmw9ZLBvGGFYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pTK62dgd; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab2aea81cd8so327471066b.2
        for <dmaengine@vger.kernel.org>; Thu, 23 Jan 2025 23:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1737703769; x=1738308569; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BFRWQAnQKD0cOeCdNKHeHeJi/NQ7F6aLdvoRMADeNDY=;
        b=pTK62dgdjW1FhZsQ87Z96vriiBPHhDnfEFep952pADYWkkVE0Iq01dPVrr46eUYAIv
         dunk4kBxO29qTfucLB4L7CottFJJKaJMeQa4Ispc349jvxkhc8wpcKKI/oEUk36snTcm
         5HUgwAgFLxlNXvIr/Hq80pC43Gun3zuN9QyZXPUv0t+bOKeuafvR0QjGIlK8FStBw/ED
         mcs1kmKRLvESRN+ufwjNUjnVDXH5CMkOcbaf9y1GUV2tFCSYi7KIZJT9Or/vZY0nIHx4
         zXPgxRAWihTE2jeBkqV7QPw2kpkmeUnRFy+rphJrlbt1GUUxpifBMSDYEfI3H5dKAs1L
         w+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737703769; x=1738308569;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BFRWQAnQKD0cOeCdNKHeHeJi/NQ7F6aLdvoRMADeNDY=;
        b=lbfNPG8+8ttu7KWIP/s9KKhtFUYwdOHsemxapBkpyxvF2LTXorMQ8K+NnRvQGpbkLU
         6PV3fEELS/nBD0NNUgGZ1bsLEcUVZQpxcWyZFSkiTqZup4D7V20nCi4iZuI2mjElPOZf
         apWLHy/ungCyv42pqu4LJhlUYztxurlq/E+1cFBVwyxQ5PZpfqbjpP+2rP+f7HclKGUy
         RBOqjBC9bD3QYl87aoL55WpQqm69Ki0M/fZ11mD8UIMlvvCUQFf5EPlIZUFD8oLO6dI4
         iI3WLVyOX0Bkto1Ur8Cuc66RHXFY7Px2nqCplgN90TxxGYZY6Wt50k7yittdBM5ciF8d
         6JFQ==
X-Gm-Message-State: AOJu0YyKn+o63rxml9r5Ofm3OS2YIa2aR9g6MTw/uy1PBt+OWMKSflST
	Vs+EvgTzvSq/rBvkDe1f5QBuPtA6T6aSZKNMwbOvwHoicGZs0qEYfP8LTlronCU=
X-Gm-Gg: ASbGncuWdlT5VARK7fME3LXxT7nPgi765m7RTKzsGUc8LPLKR9W3S46Ph8alsWP0DL0
	2ysj3G7hNJLDrU7wMoJzNW6yN5snFjVCXmxD2tB6hG4RaEDSYdlgeXxhdEf3q8UQr1r42O+VqkF
	7lV/yt9q6go+443QqZ10epCLQXDvrlks72WYqRAsFo4LHTzUXGgbb6/zp22Jh77rehhGGtsVL+n
	p0crRHb6kh0yaCPvgUclCwkCb5LxhyQaNJ8Cyz1fY57RbcxcmifYKDWTVTKu1jK568Ttin+y040
	Bqtjt+58a23ieQ==
X-Google-Smtp-Source: AGHT+IGlO8IurKfAUaDFQ9yj+nNACZ22XTZ7n6MTCnWo3Z3sqwo54Pz73RTpqelSGI+/3LK+XKZGdg==
X-Received: by 2002:a17:906:f598:b0:aa6:4a5b:b729 with SMTP id a640c23a62f3a-ab38b1bbeacmr3032453266b.33.1737703768986;
        Thu, 23 Jan 2025 23:29:28 -0800 (PST)
Received: from [192.168.0.14] ([79.115.63.251])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc18618362sm770232a12.14.2025.01.23.23.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2025 23:29:28 -0800 (PST)
Message-ID: <6057f88e-e690-44fb-b70f-97347f9decab@linaro.org>
Date: Fri, 24 Jan 2025 07:29:26 +0000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: dma: convert atmel-dma.txt to YAML
To: Charan Pedumuru <charan.pedumuru@microchip.com>,
 Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Durai Manickam KR <durai.manickamkr@microchip.com>
References: <20250123-dma-v1-1-054f1a77e733@microchip.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250123-dma-v1-1-054f1a77e733@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/23/25 9:28 AM, Charan Pedumuru wrote:
> +maintainers:
> +  - Ludovic Desroches <ludovic.desroches@microchip.com>
> +  - Tudor Ambarus <tudor.ambarus@linaro.org>

If sending v3, please drop me from the maintainers list.

Thanks,
ta

