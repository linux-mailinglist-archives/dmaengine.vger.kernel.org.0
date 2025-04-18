Return-Path: <dmaengine+bounces-4923-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09BA0A934AD
	for <lists+dmaengine@lfdr.de>; Fri, 18 Apr 2025 10:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB731765B1
	for <lists+dmaengine@lfdr.de>; Fri, 18 Apr 2025 08:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FED26B0BF;
	Fri, 18 Apr 2025 08:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BirCfKSM"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC941DFFD;
	Fri, 18 Apr 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965234; cv=none; b=UK+/I9lEEtDPe8YdR/ZFRtCbCvM8AduHTeQhmoWNYBaYC2Vgxr5CiS1MS5OmeCBbM/cpdeO9C51dSXMIGwbNZ4hDtllq/NqQfMQT784StXSRJQdSsv6vm4ifW5P3ytOH5ThD+AMz+x7Ep1FI2dqMFEpS8FMIhcCLCk6lWmwS84U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965234; c=relaxed/simple;
	bh=f2+P+2oYFNpasFLC2+w6M+Z5BZYBWwbumzXH0XUg1Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AwY6MijY1shNBcM5yRHdRVccKDbU+O6T9/DmkpvQOZF/2z4wxKi8i57fsZKkgm8GQWLCHy2KARGHqIeggm6/yefTpQ4pRKALXN4C2fYfX6isG91oZJTSLrXknFnyti6s6yJKlVObwlw+jhXjWluHRqcdLoLCe0VBlqGTjXbWNiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BirCfKSM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-7fd35b301bdso1889529a12.2;
        Fri, 18 Apr 2025 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744965233; x=1745570033; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dKKqmmtJJd7AktC6eqljZLIqTmiDg8YWDPTK1yrbBoc=;
        b=BirCfKSMJ73jx5O3Cbe2+qQhMD/6vJXyBM9BmUM1W9qoVBUiF4CSCyd+xwMsle1YYX
         pigyWvfmpMju5i+Q3lvOmBzLFoPTp3TN2lmrV9d3uF8ykf76bMIvqPyNtnwCPB2nIVDg
         TwCcBTI/mWnFVLAO8ok/+Ge8DVhJ5dYAXeAmn19At98I6Q8dYGlTVjai8iAA1rI0+359
         vdZWDSiQqP1mmGXYVpd/QrqLYuAOuDoY1LdGKxUljYA8Clh6CIGK5YuQQZeqvvkL58of
         C6ZvJBWwDVsxxDON4zZrmlQ6pljmH0VCGPBT+h6cHBZOFPNeYg+gpbhR32EVqiUEeDwF
         6aiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744965233; x=1745570033;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dKKqmmtJJd7AktC6eqljZLIqTmiDg8YWDPTK1yrbBoc=;
        b=MAuedWYo+v8eWScdL0N4mJc+Hfk0bcGmktKzeM83/r7n2KhVdZHe2ir7ODC6b6d3lJ
         9JtZM9dCaur4S4061MjWisGGzI24XF7wzG0RGMyjxb0s+CI9FELDRvDLwxY2+iu9mfjH
         nW3BuFbQBz7g67yfMq3ZevEChfYzHdfvUpcVw6NsJIMLcx5KPqB8Z/jC8QlnR7vKbCuI
         TyL8mXZU9gLqXVKRuziR3trnxToKNn0BSIVIbHfTU0yYlVc/I77ULsQXLC7/isQUe09j
         VFb2D3RHFncrxK0Fa/IBBqNVWJon4ekc7yQF2AFmZRg19SEtl1zdLjqZZJqJFLTsfrIZ
         tTcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWH1cXuVPJZXLXpubqaa/Y7M84bqQ2HJCOqzHvfnUxBayfHVIc3qUQ+Xe4B5GDUcAEq4N/64xPTNXJCe6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzZACOXi+nUz9aPMgR6d8LAg7cVICemHdP/LFwpq/Di7pdLsfr
	XVUeCZBK4Q6ER+g4NAarvYL3hVxhOANausri1y+pXR9ury1HMikB
X-Gm-Gg: ASbGncvKEJatRGJ6qFmeJ5t3d1cYfWhw4wtLQwa9slul/qY6cR1kRk6Wf+XOEoRIuA4
	odnzp4kgTnVILq5Qkd5INJD+8NBi9Y193fS9/gRaGmgeDe21dhjpajHbs7oA+fRPqunYID5ivRm
	VrAneiiNEfc+bQEWk95jzjh7Efd7FmAf6pRnDMBM/r3vq9rxvr06koo3x6nuwqf0lqwAZHNtDZz
	/Lyc8ivqUuyO2o82PyA1qTP1rgb2mpImu02WHoT8qwOxNEOwKuoyTZBGcOGytdN7A7k6O3dKvpX
	IZD/ChH1TxqU8i1/8jCbR0YmKs7csdpqas6SKFd0aVwx1Kbx8h18w5QS7F603GoTdUH6N4UibmT
	fAIPTViMfPcCrsD2Js7LpsdY=
X-Google-Smtp-Source: AGHT+IHIw5qdDDP/+Wvs0WOY3BC9PXHZjSIeFiWqvduG04NnY6AADuV3TW8NPLxzBixR4Vs7y1lIOA==
X-Received: by 2002:a17:90a:c2d0:b0:2ee:b8ac:73b0 with SMTP id 98e67ed59e1d1-3087bb3f2cemr3126847a91.2.1744965232603;
        Fri, 18 Apr 2025 01:33:52 -0700 (PDT)
Received: from ?IPV6:2409:4080:218:8190:3fb8:76d:5206:c8c? ([2409:4080:218:8190:3fb8:76d:5206:c8c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087e0feb37sm725718a91.31.2025.04.18.01.33.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 01:33:52 -0700 (PDT)
Message-ID: <2583756c-ff50-4ad6-a280-525cea073b47@gmail.com>
Date: Fri, 18 Apr 2025 14:03:45 +0530
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma: idxd: cdev: Fix uninitialized use of sva in
 idxd_cdev_open
To: Vinod Koul <vkoul@kernel.org>, vinicius.gomes@intel.com,
 dave.jiang@intel.com
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250410110216.21592-1-purvayeshi550@gmail.com>
 <174490310744.238609.16595322952378683226.b4-ty@kernel.org>
Content-Language: en-US
From: Purva Yeshi <purvayeshi550@gmail.com>
In-Reply-To: <174490310744.238609.16595322952378683226.b4-ty@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/04/25 20:48, Vinod Koul wrote:
> 
> On Thu, 10 Apr 2025 16:32:16 +0530, Purva Yeshi wrote:
>> Fix Smatch-detected issue:
>> drivers/dma/idxd/cdev.c:321 idxd_cdev_open() error:
>> uninitialized symbol 'sva'.
>>
>> 'sva' pointer may be used uninitialized in error handling paths.
>> Specifically, if PASID support is enabled and iommu_sva_bind_device()
>> returns an error, the code jumps to the cleanup label and attempts to
>> call iommu_sva_unbind_device(sva) without ensuring that sva was
>> successfully assigned. This triggers a Smatch warning about an
>> uninitialized symbol.
>>
>> [...]
> 
> Applied, thanks!
> 
> [1/1] dma: idxd: cdev: Fix uninitialized use of sva in idxd_cdev_open
>        commit: 97994333de2b8062d2df4e6ce0dc65c2dc0f40dc
> 
> Best regards,

Hi Vinod,

Thank you for applying the patch!

Best regards,
Purva

