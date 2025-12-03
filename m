Return-Path: <dmaengine+bounces-7481-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B62C9E74A
	for <lists+dmaengine@lfdr.de>; Wed, 03 Dec 2025 10:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B17B94E1B36
	for <lists+dmaengine@lfdr.de>; Wed,  3 Dec 2025 09:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374A92DCF4D;
	Wed,  3 Dec 2025 09:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwlykdpO"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB82DCBF3
	for <dmaengine@vger.kernel.org>; Wed,  3 Dec 2025 09:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764753867; cv=none; b=V5I5+yJNsmSL5cJhzIYRpFgHUyvfrYM1ThrTeF9hZ/OiZyQvrrEJBBy0CkOcgHgmDyHaWgu447ZECu59vXROfXsI5/743isex8mfvqID+mbzBXi9LhwlcQk+D6bmlWvsne/AWHRKA/U6D7ru4fw63kp5uVrs6OVfLkkgTZFPf98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764753867; c=relaxed/simple;
	bh=gISgXZarD9qm8hi8sOqrhr7ifIhZiCjDJpFmY8PcJvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A6XAQ3OHPmZE/uZl5mdcdnnQ2Ipd9WGfsE0wVfh7hP32gIA+9vQPMqb58Xj0LzWCUgo1PygNnC8t5t6ZpjvSZ/Os4dLeWcsc5E9HOWB5MWqAn9t/677fgi4wgKoJakKtSRnStA6VJ+knJ7teXc3mgnQizGoMkQODOZ0kWMHlI+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VwlykdpO; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2ba54a6fso1548468f8f.3
        for <dmaengine@vger.kernel.org>; Wed, 03 Dec 2025 01:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764753863; x=1765358663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIq3IHSi3NCGoALJGtGBwT4WOSI8sD7pseTnOYUGDBU=;
        b=VwlykdpOBU7mAvpNHu3pxT18+iSR+YKm/j+NQf7Rzz/NwMEdaPFuoyFw4oqPbr2Lhj
         9EPd6+xhuQ4sVCTf1VruV1jurUJSN93t10QWp7qFT/qbAfOm901sLF1q5I08f5d9JU4j
         hVpm3m+TmknE7k/+Ie83xAXMVyda4c6nI397ystW5bG5/nBbKfSPVltSsUouK5QbtbQ5
         qlHQtyMWBaI90bkyrXrjP23k8P3AzCy54Hp0J/jATjxvxmoawEiX7PbA+Bxb9v0Ou/6x
         NtMvawqrApAxx1GtKpkzhyTv6csWcJ3KDfBiJLV1A2FEKPvrsLyquZMYak/OE5zKu6oq
         CY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764753863; x=1765358663;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIq3IHSi3NCGoALJGtGBwT4WOSI8sD7pseTnOYUGDBU=;
        b=f/8frDs+gpr8xdum6uAUz7VHn1L0XNkcJlh+9rTsaMyqx2j2HZ15vskbopjKknSEP+
         Yid8r4ws8zjn9kR6L1jbMio7v3TVfinLTKNI8Xdi1X5G+anuo/KUCE0H59z2aXVeqpQw
         bdzxIiMxGB8WKYExAgNgzD3kit11Ke+rCHhMW5pBdk2gOZGVx4dm/bNda6dpJiwYxIBX
         M0CmUcqIp8NiN2ciNcEdZuofYLTEm4BUP2W+KL/vr4EFTMQPl4VLJsgSyIGfILowgleb
         ptLh7dRGbFBZRyTnPyd5yAmIuoRDMVdOxcd4eVc3CscrEglteNOQZeD2JFeMphtObw/G
         TSVg==
X-Gm-Message-State: AOJu0Yw3aSFjyl+gS+1V+DJEigchGMIzfeNngtw9ZUozJliaweJPg7Gl
	DzUk/l2p31a6F+4BoNY63pUYVF+/OPsfhPIW5L5109xw7x8LtQTlQX8V0bAKIs+v9L8=
X-Gm-Gg: ASbGncv5ejmFjVx9hCj9a1WpEjT0rT794hxWi2bxrXOIcinpio1gioLs41LAKx5hEEJ
	JKCaAFPT6n1TshRoHqqXf8Uqke17Y0fv3DZEcJXpQkZwEy7Xm1RpCTI5QyNNM8Yw3ItcbtSd74U
	zCORiVdylqHcyQPm66XxGCVnck61boWPHBOn9HLE+UgcaZb6MItVaahR8YFYkfBScTqUJIQ6rLk
	kLGU5RbLNiXnXp3Nfbk/0qYZvtbadzqObxH/lq4/+TWEueU9N2nzxob/+cHk+DQqhKZNKOES9cE
	zazEYc6KV+HI69v/wP5WtvdTYjR9eXHX8rDRx2ZzAecZTdFta2K3d/BfZlYYU2ecxbkHxy2vDXR
	1Abbvmmr+VvueGafhI9WnHGIQpYprgF+1h3Xp8iJUV6tM+hPgXTRyTS9AmKPo7qfnT380DOjs+v
	wPuthfkwJHL78VxesLTwQLBRYUxIIbb2KRSid45//XBJvOOSfB/Wr9f4MUFA==
X-Google-Smtp-Source: AGHT+IF2iU8jB8+25UI8v8StXBFRMZ8jem8wdZqu4MTeDmBwzCDt27e9WG51u5pLanJkVFwLbAoY/A==
X-Received: by 2002:a05:6000:24c6:b0:42b:39ee:288e with SMTP id ffacd0b85a97d-42f7317d149mr1470532f8f.13.1764753863013;
        Wed, 03 Dec 2025 01:24:23 -0800 (PST)
Received: from [10.255.254.100] (bba-83-110-84-117.alshamil.net.ae. [83.110.84.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca78f77sm38217963f8f.32.2025.12.03.01.24.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Dec 2025 01:24:22 -0800 (PST)
Message-ID: <b6df2f2e-c1d6-4eb2-82e5-d7e149d12575@linaro.org>
Date: Wed, 3 Dec 2025 11:24:19 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
To: "Verma, Devendra" <Devendra.Verma@amd.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "mani@kernel.org" <mani@kernel.org>, "vkoul@kernel.org" <vkoul@kernel.org>
Cc: "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Simek, Michal" <michal.simek@amd.com>
References: <20251121113455.4029-1-devendra.verma@amd.com>
 <20251121113455.4029-3-devendra.verma@amd.com>
 <SA1PR12MB8120B42CB67E6A4F25318B4895DBA@SA1PR12MB8120.namprd12.prod.outlook.com>
From: Eugen Hristev <eugen.hristev@linaro.org>
Content-Language: en-US
In-Reply-To: <SA1PR12MB8120B42CB67E6A4F25318B4895DBA@SA1PR12MB8120.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/1/25 11:58, Verma, Devendra wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Hi All
> 
> Could you all please review the following patch?

No need to remind people, your patch will be reviewed.

> 
> Regards,
> Dev
> 
>> -----Original Message-----
>> From: Devendra K Verma <devendra.verma@amd.com>
>> Sent: Friday, November 21, 2025 5:05 PM
>> To: bhelgaas@google.com; mani@kernel.org; vkoul@kernel.org
>> Cc: dmaengine@vger.kernel.org; linux-pci@vger.kernel.org; linux-
>> kernel@vger.kernel.org; Simek, Michal <michal.simek@amd.com>; Verma,
>> Devendra <Devendra.Verma@amd.com>
>> Subject: [PATCH RESEND v6 2/2] dmaengine: dw-edma: Add non-LL mode
>>
>> AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.

Is this non-LL mode some official name ? (e.g. in the datasheet or
official product name )
Because having a 'bool non-LL' as false making it in a LL mode adds a
double negation that is difficult to follow.
 >> The current code does not have the mechanisms to enable the DMA
>> transactions using the non-LL mode. The following two cases are added with
>> this patch:
>> - When a valid physical base address is not configured via the
>>   Xilinx VSEC capability then the IP can still be used in non-LL
>>   mode. The default mode for all the DMA transactions and for all
>>   the DMA channels then is non-LL mode.
>> - When a valid physical base address is configured but the client
>>   wants to use the non-LL mode for DMA transactions then also the
>>   flexibility is provided via the peripheral_config struct member of
>>   dma_slave_config. In this case the channels can be individually
>>   configured in non-LL mode. This use case is desirable for single
>>   DMA transfer of a chunk, this saves the effort of preparing the
>>   Link List. This particular scenario is applicable to AMD as well
>>   as Synopsys IP.
>>
>> Signed-off-by: Devendra K Verma <devendra.verma@amd.com>

[...]

