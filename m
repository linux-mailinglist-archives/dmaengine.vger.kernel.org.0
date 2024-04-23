Return-Path: <dmaengine+bounces-1940-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7DB8AF3C9
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 18:22:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA551F2427D
	for <lists+dmaengine@lfdr.de>; Tue, 23 Apr 2024 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB5413CFA1;
	Tue, 23 Apr 2024 16:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VjLlekDd"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CE713CF8E
	for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 16:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889340; cv=none; b=QW9OwD1vYdFlFb0rVAUvun9EZW0i50jazapoioEJN2xKXwVNhyWEe2Y5J3BzGGEbS0pice31vh5w34pp8xZjwDM9MtHLMRsCSPfkxqhGuBQKCIWMJM3FZI5CqCDPUQP6YU9M18HtnH5abGs8BpY754Kv58Jfo51OjVuZAZhbxSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889340; c=relaxed/simple;
	bh=zO79EE5lca96y5tk1jBN2RNddNarlFD6LibZvjCWZN8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t86QrhRYZqSDbmrHF/IbG+hn3MAx4LGj3BaKoNj4qY5mTbmschvW17hJy0Tyjb01KLQafo3MSXD/AYVNbpAjzqjOsSd5BLSOpS2dEqIby5qAJJV7wzSGHoylH3LlYhGRE/BkL/p7KdjEi289axK/NZYCt+ohd9wjOgPTkgeT4Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VjLlekDd; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51bafbe7509so1171986e87.1
        for <dmaengine@vger.kernel.org>; Tue, 23 Apr 2024 09:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713889337; x=1714494137; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rryQLukNGX6bltbPu3dT4IMJ7VdkGWG4t49Lq/kGVaM=;
        b=VjLlekDdLPh3AoMfFCjl7qtwNdQsBLEeD1eFpRAqxuiqwgvYAO4S3NR9hGfu8NPqXa
         S15rXRJ0MIGEWxkpM0S3SwSXq+mbFPPRKk4KxeACIA1R6dVhZJV+ih4KXGPhzyk8CpZW
         MJuqLZAhlYvg4TSe9GEGX3EvHH9yiAC4UFGeXcDY2tsGPQ1iY5CVvVu1Ad4MnkcdksIx
         lCobJZiTeTacDMPJtB7tvQ0DR7+FIcDhN6AnUo5otGLIDzaP44DVAuOTEsMIi2kx3l4G
         L5D6+sTUCQq2UUusriZtRvLihrwHr4TnjHcPzUyYiqtbO0ID581fFn2UZrpQF2ymvNwm
         yTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889337; x=1714494137;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rryQLukNGX6bltbPu3dT4IMJ7VdkGWG4t49Lq/kGVaM=;
        b=cbmr749NBWGfP0L/sWWlta1d8fABSkhGrDiGsaJgfK9Fw6qmehdUgEDK1fbYC9hZEq
         hLwvdqfpe+5L8ABMlT3GrnIaGqNV1+M77w4oL/hOsblju07DrQ5CsfuxjFUbP2BX1m5c
         7EXVYsG/iRisY7jrwGhoO+mhSw+Wj/UsOa7HIPDQy3PfFa9jJMrABzKbMsq5bJ56YSml
         Q322yASsBNmbL82xu4fgcKHXfuuumFmroucPRYcbh77vGpeRxMP7X+Kk+u2TUCDv4ESh
         WC+IAjMCc5iGBGohPeogs6hmQyDH7mRk8ZrVkXTkJd/GM/oaCjeVzPavO/zI42s5OCw7
         /Gtg==
X-Forwarded-Encrypted: i=1; AJvYcCXvNyVyD+71DRFmz3HHd9EJPgIXf71fDdDNQC+Ooj6OYupJ1vQ2p05cY4g2xyW4rEMBjug06gGFcjCRGTmu4tVsHGj9/SgQOsec
X-Gm-Message-State: AOJu0YxiJ9CIz5vdHec0AO/A9aw6QoYi6qXo2gYMohJKFlrEAoqhA0WI
	MWIrYkOgB5502mRCzsYTc9WVx7CI5albGj9tfGq572J9FtUigEQDtNatOJN9IslMGMXiyIlY7di
	6
X-Google-Smtp-Source: AGHT+IH3nmHnEwYavp+3AF85hgClGpBGLwqG5/uE47MnsvBC78Cj0bT1r9wjIUlQwfxrbFen9V+3jQ==
X-Received: by 2002:ac2:4143:0:b0:515:a8c9:6e99 with SMTP id c3-20020ac24143000000b00515a8c96e99mr26825lfi.5.1713889337192;
        Tue, 23 Apr 2024 09:22:17 -0700 (PDT)
Received: from [172.30.205.0] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u21-20020ac24c35000000b0051b246caaddsm745480lfq.259.2024.04.23.09.22.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 09:22:16 -0700 (PDT)
Message-ID: <808243c7-bc27-46d8-8dc6-ce7932931e01@linaro.org>
Date: Tue, 23 Apr 2024 18:22:12 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: dma: Drop unused QCom hidma binding
To: "Rob Herring (Arm)" <robh@kernel.org>, Sinan Kaya <okaya@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240423161413.481670-1-robh@kernel.org>
 <20240423161413.481670-2-robh@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240423161413.481670-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/23/24 18:14, Rob Herring (Arm) wrote:
> The QCom hidma binding was used on a defunct QCom server platform which
> mainly used ACPI. DT support in the Linux driver has been broken since
> 2018, so it seems this binding is unused and can be dropped.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

