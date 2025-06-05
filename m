Return-Path: <dmaengine+bounces-5311-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 240D9ACEFF8
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 15:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30AF23AD80E
	for <lists+dmaengine@lfdr.de>; Thu,  5 Jun 2025 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B808227E94;
	Thu,  5 Jun 2025 13:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hE37ZiDG"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259D122331C
	for <dmaengine@vger.kernel.org>; Thu,  5 Jun 2025 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749128791; cv=none; b=pjHUKQW7XXcskYD1F3wMUByFMMe3nXdX8JA7z+wxivSy2YKatzU333ZULzSCbPzRQekUhvmV/wCQUgru/8XxRCH9bwLZJPvh11Ql3GjO21Itad9rAGwHlwgii7Yd9MM+g8vynm0IXTHour7V12Pby0Ru2MTmab+Df9F2Mh54e84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749128791; c=relaxed/simple;
	bh=zS8ecJYvpJitQ3UMbVXIWGqUkE6qbecokkfr7msuPkc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lLbNSJ/+tBUHfxJHNHA5NXAy0dTcwnwNHOHePE2Ni96lpxJJWhyWwssyw8LUyDpQUJN+SOVQvdd9cPqk/vuSSZDkg6wSXfI2Blxo6t09gQCEQUDfaB8w8BrJiJOEROrCGh1UXZ+05Jhpubk3JdX/Ynr4meZAUv8GCSxIpDd/zgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hE37ZiDG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so758180f8f.2
        for <dmaengine@vger.kernel.org>; Thu, 05 Jun 2025 06:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749128786; x=1749733586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALKVA2fW4irMbGXjAfGWZNtggykUGJCgahiUtNxuSd8=;
        b=hE37ZiDGu7jX1TYfxpGeiiSGeyzR99Jeoii3ivurbeE99fHaO2Y8MtfLhAOunRy0yx
         8zhitREKYvNICRpKf5pBIXnSKK/uMZv8A86Fug9mOZr75VM+FMqwfnTTlIzg+sv+Y0DY
         l2iLsqKB6Ks/IpgoBpYHuAlC69QZ4sstmmeev89FMW9EXtNNqLR/b6js1POkgY8PqBL5
         mFHXIlrHZTVmbPrOaF7aFKFRDCkGdav8diIUirYvUMSNBjD8gQYF4nZeNbNU//gtjHHy
         6XLZabXNJgO1HWCLmX1laGZZoQEZZp0ZYSJg95TsAOzjlzIj8DVidL/ePleu3M1iDJ1i
         pL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749128786; x=1749733586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ALKVA2fW4irMbGXjAfGWZNtggykUGJCgahiUtNxuSd8=;
        b=Xc2/QD9RsUFR1o5eX4EbQ/tBZXZRUIpo6FKOiVrBDdchRHNVTq5hANXziJY82zNHMh
         k7UvKFgl9wM0vHGDfxT45ZkNS+DaL8uoLZFHapdMH+pWyw2+BFAYvVw8+qHGtZMF4XJH
         LpVoOhx//GntoDIGxsgDHH7q2HlMj6nz8hxB/1xFozUJJ9TEwrWhqibiDDbixVo475V4
         VxR4MvuZkcFyXFevOSm8SzQekk7PwPe1pLCv4wVdUyIgzP8yiWFpEFJyMwL9xMgavNRu
         KXAxAxahROH8BeZFMaKPqDvmgOIEUsa/vBFbzx1pgQoq6gymCQ08eY+biELRE2kGTlA8
         8lgA==
X-Forwarded-Encrypted: i=1; AJvYcCUk6n6tvo+nkMhKSs/CAfMnCkn4cK7hX9VD3nPiEEJvffL/SCa7hfoOrZNH8Hb698FJj7CySXNFOO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxUtTJEExhij016lA6VM4YpEgqtTv6EOHm3f7AzsPMLB1pY52L
	ZgojpCHtxL35g88/FG/nowORz5hg6moaQF4mApSJ6NkDRoKCdyMLFKiGAoAynxVPZ6M=
X-Gm-Gg: ASbGncs8b2xkIhPEtt4TRWGJeRNDjI+SlghndnoP1hLbCvGgvhbf7sQlJ+G5vUN1H2x
	Xzzi79zWXbU6RkbKDT/JkfT/V0KTk46xXtbubHCiQVz/dNudYu0hJSAq5rPI47WU5VYioKqAhMg
	C5k28QDA8fE1hZeJCRQig5KAuQxvR3aagEt2eZsfPiyU0NHNogGeRB6Z93+dRNkGTyjtW/4CMN7
	dPcdeYK8vyubgAb7GohUVx7KB1g4yFPJyHw2X62K4ceyaQgNhW+gV2a8RDUJPxTpfGIwNQ0KxA2
	mOJAvuKA+xnBBoGl5xrhxSgtimlHiKsnMYdoWtmdEXh5wBWk9FYb3kXjbTmdHE7LbiXAug==
X-Google-Smtp-Source: AGHT+IFlFSrl3XSTZnrLX3liutqht/hIRQLoBNZPN0qE0WMgTCPvfiUO9lKb3LhAK0eALpw01RUcqg==
X-Received: by 2002:a05:6000:1a87:b0:3a4:f7f3:2840 with SMTP id ffacd0b85a97d-3a51d8f60c3mr6177072f8f.1.1749128786358;
        Thu, 05 Jun 2025 06:06:26 -0700 (PDT)
Received: from [192.168.1.221] ([5.30.189.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-451f99248a7sm23764615e9.36.2025.06.05.06.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 06:06:25 -0700 (PDT)
Message-ID: <99d180ad-7e64-41fc-b470-62300a064bbf@linaro.org>
Date: Thu, 5 Jun 2025 16:06:22 +0300
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dmaengine: qcom_hidma: fix memory leak on probe
 failure
To: Qasim Ijaz <qasdev00@gmail.com>, Sinan Kaya <okaya@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20250601224231.24317-1-qasdev00@gmail.com>
 <20250601224231.24317-2-qasdev00@gmail.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20250601224231.24317-2-qasdev00@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/2/25 01:42, Qasim Ijaz wrote:
> hidma_ll_init() is invoked to create and initialise a struct hidma_lldev
> object during hidma probe. During this a FIFO buffer is allocated, but
> if some failure occurs after (like hidma_ll_setup failure) we should
> clean up the FIFO.
> 
> Fixes: d1615ca2e085 ("dmaengine: qcom_hidma: implement lower level hardware interface")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qasim Ijaz <qasdev00@gmail.com>

Reviewed-by: Eugen Hristev <eugen.hristev@linaro.org>

