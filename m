Return-Path: <dmaengine+bounces-5789-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7CB036B1
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 08:13:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 621507A1CA6
	for <lists+dmaengine@lfdr.de>; Mon, 14 Jul 2025 06:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A721822259A;
	Mon, 14 Jul 2025 06:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALsZpZ5N"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D04222574;
	Mon, 14 Jul 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752473593; cv=none; b=Nt/+GU5MnS8zaxSM8ywnGkMAKTq4dYnp+qSclkY87/qMpn+otLns/xyBoANR6rG88CxFe7U4xBXeBIUMQGLDcvCzJsV8QPvWcMNqqkNxz027n2Ybt4TCg3xDYEKkgCF67PzQLECLjYkMqH7AG1k8skVbRE+bkTjuNceelmwUkFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752473593; c=relaxed/simple;
	bh=K6rTZa+mjUsFCcLD5fAui8r+wQYrBXhnTQ2dLU8CeRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/VDA0grBrMvshtcQ1hdjGI9Gd/6mVK5X/WdZjK9v5oFRhm/9D4Q4+6EsUjrlRSFWNSIIm54UWIpAa+0onJzeiXqZAXNeoaGT1nlZQKqwH6zkdscxH75WBDbmZdFY1aptYbO1oeVLHpCO2eRS8b0zwnIAlnea9endxOiKjMIvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALsZpZ5N; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so10396899a12.1;
        Sun, 13 Jul 2025 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752473590; x=1753078390; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vvozbmvdghn0xuJhVjwu4pQc8eFowQW5vD9wXdzvh2E=;
        b=ALsZpZ5Nwk0QPl9HEVXg0BgXgV/0oGOnzEJeNal2xZfLiTqtprh8NIc+B9yAZo3Iyw
         8RY7AeH/stuMCjEmmJBgcQNCDqXHEmAro34tjiskjt9cEYBFJwvbf7XgPG0ChQca3Fp1
         5nyF2HY1O19gIFwAV0iPuQVzMwWmV1ELLeVifNIiilV/LbQuRNHTAQOYlfeEPsHCaDJn
         I+6gq0/NE/ae8enM3WsoDcD1N04Zua/PHYgx6iL4E1d11pz3fYmMtOmCeSiojBnqO8U9
         rgvjfmvMU3pd6JG0ooHR70qlHpOQvXaATLeJs8Rd2oeSPIjF28ACBmEUxwortIYxArWK
         4Wlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752473590; x=1753078390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vvozbmvdghn0xuJhVjwu4pQc8eFowQW5vD9wXdzvh2E=;
        b=AX6KyacYKSsVmXSsn1BHeRqRMO2e7ZoQqLm0Q8MrjJ+MZXX3V3wqTVJlU4Un+cDXdh
         0eHqOHe/iQKkWsA+P2wbl7XcS+tkxhMVmMKg5LCzRnAUK42krHN2Y4GYyhOM2TDn2dLq
         +UkMql3hcqNxciNdjOES1jV+4T+goxrEyMrifUPxxW2d7Rh+SP7+EGGxStORcgQXvH+1
         maimu5sfHNrUgdPBuueHHQdDHvFemDemJnziN7vCmgfZ8LU3rU4gDpCaEmIApDy+DTr/
         FurycAhOqC3uVdiMEfDp5CLGRclM4iGZ5k4V9uiA9xpB5SgqMpJgFFXV2ht6awEJhWZK
         AOkw==
X-Forwarded-Encrypted: i=1; AJvYcCUP9cCEGBtIfr4mj8xq/Eb9LeEOYHuQaWg7DecbOSeLyjmdGBsu89NKvBfOe5Mpxy2p0WMa5X3eB2OQ@vger.kernel.org, AJvYcCUStQ+kZD3RgEiqCqamDPHN0+V8U//75gB5aBA/VFf/8TxBwYmlbFOrNTmcls2xSkxfzTkJbh1izJUn@vger.kernel.org, AJvYcCUu/1mhYdj5sMEGBzzl15XoaiyAFFWhgEjtWzX76d2pShQ/mNzScoB3zBJvqR/9LZq31mqppD0IV70=@vger.kernel.org, AJvYcCVstpNyGdvuY73VnuNsfHVFZp+Ibrgrdw6r36tXAZ6bHdgKEM8rbl+dffkiBgU4ZIz3E4mae5bxw5CYU5w=@vger.kernel.org, AJvYcCW0SyBXuZZvd/xJRQljFHmZZeK27WVLgdkeC50Y0Ub2vYEcwxbkffKOuPuFt/NDDMfwKU0qSkr3+OOeV0V3zg==@vger.kernel.org, AJvYcCW9KUj+JjF5ly7puv2tvDzq8+x1Op4tL9Qp0opokzItOLrzzOp8nZDLBSMKCFsv8iGwfAi2VpTAbRT/@vger.kernel.org, AJvYcCWCJTujwin9rvVzkB2+pYTryRkQpYeQHH7hj/ZAtqaa7ztVx09K4xQ05d8TrssfdLgBtpiikUwl6k0mJaas@vger.kernel.org, AJvYcCWVojriAO944z+btF5GTxaZUZCinYblWnzszeAL3ErTaCzTc4dmv9W51Pv3w/UOIkrUDJwcXKXnKsMlID1S@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYB1+qM4aL9I+xyEElR/MdHfEasVuCVboe38WY1xF0F4jbRQb
	PJhr5OJpS0nyaUrTHjE5Xs4BO1IeOKlW234I8ekBlgq7OXfOqlDGmcfE
X-Gm-Gg: ASbGncsVzO3u2eRRPkqHSExy4M7lF3/AqBCyho/g29LYpWj7iPq7+3VHbuJ8XUz5zUh
	XvbjJPk9jXCfIQMiqT4i+CEEISiQpedpCb9vyjf4+7DDhq3Jmr1V5+R9ShnnbGf8lPp9ovCVb0V
	GYnbTFIeLu6NoJa8NB/aWSzV8nXEtD8QXaTDsjm4Gqp6HfiEMSBw0ai8XTXG1R/XJDWQIlXTcAX
	+fSzIIeS5RrvTPZ8v5iGi2aYialOjERouHKAYIZ0FmgAYr0nhCdDUo3ukisQ2vqqTlQsWm852eH
	0qrys1fbQfL7XFpn13BhNOrFlQ2Mm06BX3zlOngHXilZmyDqgE5qIF902v/whLdVa5ROZxTfdHb
	5a30NVO/tm5Y+56IaMLVGLbeVXbKPIfOCHJ6CsLZkQrLFCOQKU5vR7qFhQU5KyQZ7j5UtkII022
	eawnCCt9xeeqWy3IrLPLA+zA==
X-Google-Smtp-Source: AGHT+IHhpjs0q3mi1BpnwNvryChqNwp5/Dw+yK56vrj/BWwwZ/DXYC0z9I3eOOpItRqe5sk1H/USWg==
X-Received: by 2002:a17:906:9f86:b0:ae3:a4a6:a32e with SMTP id a640c23a62f3a-ae6e253ddf4mr1701256366b.29.1752473589912;
        Sun, 13 Jul 2025 23:13:09 -0700 (PDT)
Received: from [192.168.0.124] (ip-37-248-155-42.multi.internet.cyfrowypolsat.pl. [37.248.155.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294bc2sm766171566b.135.2025.07.13.23.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Jul 2025 23:13:09 -0700 (PDT)
Message-ID: <ee0d148e-71cd-4136-b3cb-145566abdfbe@gmail.com>
Date: Mon, 14 Jul 2025 08:13:05 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] Various dt-bindings for SM7635 and The Fairphone
 (Gen. 6) addition
To: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, Vinod Koul <vkoul@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Robert Marko <robimarko@gmail.com>,
 Das Srinagesh <quic_gurus@quicinc.com>, Thomas Gleixner
 <tglx@linutronix.de>, Jassi Brar <jassisinghbrar@gmail.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Ulf Hansson <ulf.hansson@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-crypto@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-mmc@vger.kernel.org
References: <20250625-sm7635-fp6-initial-v1-0-d9cd322eac1b@fairphone.com>
 <aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com>
Content-Language: en-US
From: Artur Weber <aweber.kernel@gmail.com>
In-Reply-To: <aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/30/25 23:59, Bjorn Andersson wrote:
> On Wed, Jun 25, 2025 at 11:22:55AM +0200, Luca Weiss wrote:
>> Document various bits of the SM7635 SoC in the dt-bindings, which don't
>> really need any other changes.
>>
>> Then we can add the dtsi for the SM7635 SoC and finally add a dts for
>> the newly announced The Fairphone (Gen. 6) smartphone.
>>
>> Dependencies:
>> * The dt-bindings should not have any dependencies on any other patches.
>> * The qcom dts bits depend on most other SM7635 patchsets I have sent in
>>    conjuction with this one. The exact ones are specified in the b4 deps.
>>
> 
> Very nice to see the various patches for this platform on LKML!
> 
> 
> Can you please use the name "milos" in compatibles and filenames instead
> of sm7635.
Hi, small half-related question - does this mean that future Qualcomm
SoC additions should use the codename for compatibles instead of the
model number as well?

I was working on SM7435 (parrot) patches a while back; when I get around
to submitting those, will I have to use "parrot" or "sm7435" in the
compatibles?

Best regards
Artur

