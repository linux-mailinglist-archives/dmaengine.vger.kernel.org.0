Return-Path: <dmaengine+bounces-69-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8682D7E7D26
	for <lists+dmaengine@lfdr.de>; Fri, 10 Nov 2023 15:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A801C20A30
	for <lists+dmaengine@lfdr.de>; Fri, 10 Nov 2023 14:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33471C28A;
	Fri, 10 Nov 2023 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGvtEy7w"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656611BDF1
	for <dmaengine@vger.kernel.org>; Fri, 10 Nov 2023 14:50:25 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D5C39CDE
	for <dmaengine@vger.kernel.org>; Fri, 10 Nov 2023 06:50:22 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083740f92dso15895095e9.3
        for <dmaengine@vger.kernel.org>; Fri, 10 Nov 2023 06:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699627821; x=1700232621; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WwUj9+JHQkH7vG/710feDzITxHqn37W9wlvZGZZv7E=;
        b=lGvtEy7we2hNT1LB9m+K2OhqyGgebQQ8gl0q47oAq+oE3RDU+UbKyI9qGXd8T5fRk2
         RH/osAKJtfjC3tf8w9610BIZzfw3GN2kizbz1hQZTVFmBiQPxn3r0tSgW6DN9yRofWjD
         UTZ+sPXvLICFik0o5fr1w+f/TJr3u8Ymdho+fsbVtmHn/PzJS76ypmVJf3VMJtScRV18
         hyjzsjmcAowQzvzFYmHlGHHOaT1czXWvYVhmQg3XIADSaeqHjoeiGbm6PmwcDgMwnBUx
         zjPYbupV0F94AbpRx95BGsa1kQRaT82H1j0glbyMyX5EGE3J5+4+iKdNJURMZgX/0A+z
         midw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699627821; x=1700232621;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WwUj9+JHQkH7vG/710feDzITxHqn37W9wlvZGZZv7E=;
        b=oiubF3MpDlFOHYvna/JQLSXLxza3aknirz5UFigCjW/QqmSZVcP718iJlPX1Cu94bj
         vW4I6YrrQWu/nHhXnlFGicL51317j7qPXno2lne7GbZhSgxk9uxgU7blVXCLRIFJvtX8
         crtIgtIgiecU9AtOUtAeRsC8qxpJUfCXsRvAFEtm9Zpug3lm5PdSjP+DlLmDEcgL/N+G
         BrvpUtHpFJ/CkQjeyzKO1R1+Y3ww4Xmu6bi0qUeAe61rXb6AauZTkxwhk3lUvDts8zdS
         6wq9uJ4lElQR/+bH8zw2Gk3u9Q83qdVB9nCUSMQfuBHKXoSKDzD4tKSafG7VXBNVzQKy
         Jp1g==
X-Gm-Message-State: AOJu0YyoljuHeoxXxB60BGqqMA0N0Wak8FwgG7YB5nKR1iKPO8gOVQaN
	MfCjhsJ0Z+NxVlL2u+ZMjHFTCw==
X-Google-Smtp-Source: AGHT+IE+kRatp2oEHy0dhmgJ8N9B7j/GLXQpHYJnq+gKfgd3LokNnxftIEwaYYySIEHkq/5rf+AtKA==
X-Received: by 2002:a05:600c:3103:b0:404:fc52:a3c6 with SMTP id g3-20020a05600c310300b00404fc52a3c6mr6818062wmo.25.1699627820758;
        Fri, 10 Nov 2023 06:50:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c138800b004075d5664basm5497409wmf.8.2023.11.10.06.50.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 06:50:20 -0800 (PST)
Message-ID: <f095ba95-ce76-4821-87b7-083f4162fc63@linaro.org>
Date: Fri, 10 Nov 2023 15:50:18 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] dmaengine: fsl-edma: integrate TCD64 support for
 i.MX95
Content-Language: en-US
To: Frank Li <Frank.Li@nxp.com>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
 imx@lists.linux.dev, joy.zou@nxp.com, krzysztof.kozlowski+dt@linaro.org,
 linux-kernel@vger.kernel.org, peng.fan@nxp.com, robh+dt@kernel.org,
 shenwei.wang@nxp.com, vkoul@kernel.org
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
 <20231109212059.1894646-5-Frank.Li@nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231109212059.1894646-5-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/11/2023 22:20, Frank Li wrote:
> In i.MX95's edma version 5, the TCD structure is extended to support 64-bit
> addresses for fields like saddr and daddr. To prevent code duplication,
> employ help macros to handle the fields, as the field names remain the same
> between TCD and TCD64.
> 
> Change local variables related to TCD addresses from 'u32' to 'dma_addr_t'
> to accept 64-bit DMA addresses.
> 
> Change 'vtcd' type to 'void *' to avoid direct use. Use helper macros to
> access the TCD fields correctly.
> 
> Call 'dma_set_mask_and_coherent(64)' when TCD64 is supported.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Three kbuild reports with build failures.

I have impression this was never build-tested and reviewed internally
before posting. We had such talk ~month ago and I insisted on some
internal review prior submitting to mailing list. I did not insist on
internal building of patches, because it felt obvious, so please kindly
thoroughly build, review and test your patches internally, before using
the community for this. I am pretty sure NXP can build the code they send.

Thank you in advance.

Best regards,
Krzysztof


