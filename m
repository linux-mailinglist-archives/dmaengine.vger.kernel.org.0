Return-Path: <dmaengine+bounces-2712-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFD1933A78
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 11:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71B2428416B
	for <lists+dmaengine@lfdr.de>; Wed, 17 Jul 2024 09:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EBB117E908;
	Wed, 17 Jul 2024 09:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bdtiPJ4h"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BAF433B9
	for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 09:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721210170; cv=none; b=YPEk4pSpBKMQaRIw6mm7t0NaqX08k/haCV3smXlq4w6OCgACZvKn0ItDLG5fw4Q8eZCu+MEG9PxeVHIDqGSYjF1MIEqotridIzOxTiu3ZfMWR7xNyohHc8v0v1QWklVqeZnsyJ9ehelVxUAu4h+AR5Eqnfs6b0ghsNNkgGv/ubE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721210170; c=relaxed/simple;
	bh=jp3e99QVDqnQQxHvvBlwbSm4q4rUzFLrF13oCAQ6nAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pcm/rgzhEQ+rVOnGFl7Ys2EO/oa7WUZN/rb8/DVjJQAmupz9WKr/L+SOnP0U0J/0KtYN7+pSxkEKcbYlECLipbI+OrF5Fpa2Gpoyg5u1CdjStu+2qnRls16qI9srXWe00e8OeCiVsPeLupMUtv2eCg2/zMfSqNOzCKlr/LGo880=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bdtiPJ4h; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a77b60cafecso752855766b.1
        for <dmaengine@vger.kernel.org>; Wed, 17 Jul 2024 02:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721210167; x=1721814967; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3Ybf9RTTlEByDRMU6BLctZ8O27rbBGmtGuZm+WoUIQk=;
        b=bdtiPJ4hyx6yXqHQrfpC+xuDOAY6ccVsjfSd5M58lw3KTG8chjx2MljsMlVUmX70GY
         KGVBHgArwK2Y3vdlA1W31Pz/3XmlLlTo34S75Pq133BiWhYdF7tTayQ/4E0Dk/isjIXg
         EPvCLPXPDKFlrpNS8GWLVLzYxjQxzyUet+f1/5zBmdOZsQgEPWfj0SPYkzInFyJ9P1mR
         Y1TIrM4FZERQoCF08AWIOTx9UaVQNMHSmnERJbBU73OfBheGDbScAh9roBDjyqTdMxHY
         yWN1JCCvodO/MSiC5kIeBjazrukXlThCieNVn7J/AhzUFzI72Z1mhxLaaMEG6VT6U/pI
         SnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721210167; x=1721814967;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Ybf9RTTlEByDRMU6BLctZ8O27rbBGmtGuZm+WoUIQk=;
        b=HLgGv6MFUF2iQOfEpveNl6//3lTUVw+eCRnjryYUubx1uVurIVmCzn6YSrxq2b/qIR
         Qg0KvbNFbHEoNlY3ZXhFsPYCUNEHyCnFcFLysdwhreFAlofGjEbEV9ifHbH+4BtyyX8e
         c1sNq6I8XtzC1AZ+j6AS6G1A4ONo+z96oYky3VFB0ASxkADJ+24N5NjLQkxizzF4NuWB
         GMBVl/IInTKXrgx8cCIPST5E2qGCkiEa4/jTJivJJx3PRbaXglWg10SbIlNuu1/LKaSn
         cl5yVJBVPOHsjgfHwsC8CH8btv1pclBXtxOKUsYQ8q3Jf1wAT4ZKZPF5TXk2+ZaojFfm
         lsxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYTiGFQwrfRol99xQ4EQUXyi2rm9/d6eEJtEngodIw+eoqrAQKVnhSkv9GOJkRQMxUnsKNCyT26VlgoMNeYzOENb2S1jQdE041
X-Gm-Message-State: AOJu0Yx9FQSOMn7NWUC0sQp73OgxkyD2xWUphrfRfbyr2lkoDQOp9pXM
	VCWJN3sISCbOgKHrvUZJn1hjL1so3YRNq0ho7kJpoSKtedtqe//PCbKLQdkVNlE=
X-Google-Smtp-Source: AGHT+IFfxjPFtfLZ6aQ4LxGM3vXifyjU51J9L4vdzvC5yaAyJS1vSqnsXD4BgjxSeFKYCkCEmgwzfA==
X-Received: by 2002:a17:906:694f:b0:a6f:e47d:a965 with SMTP id a640c23a62f3a-a7a011d2a95mr77670066b.41.1721210167050;
        Wed, 17 Jul 2024 02:56:07 -0700 (PDT)
Received: from [192.168.105.194] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1d11sm426622266b.139.2024.07.17.02.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 02:56:06 -0700 (PDT)
Message-ID: <6162202e-78b2-44f9-8508-2f0b01112fe5@linaro.org>
Date: Wed, 17 Jul 2024 11:56:04 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: Handle the return value of
 bam_dma_resume
To: Chen Ni <nichen@iscas.ac.cn>, vkoul@kernel.org, gustavoars@kernel.org,
 u.kleine-koenig@pengutronix.de, kees@kernel.org, caleb.connolly@linaro.org
Cc: linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240717073553.1821677-1-nichen@iscas.ac.cn>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240717073553.1821677-1-nichen@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17.07.2024 9:35 AM, Chen Ni wrote:
> As pm_runtime_force_resume() can return error numbers, it should be
> better to check the return value and deal with the exception.
> 
> Fixes: 0ac9c3dd0d6f ("dmaengine: qcom: bam_dma: fix runtime PM underflow")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

