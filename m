Return-Path: <dmaengine+bounces-4534-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCF0A3BF60
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 14:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4F5987A2314
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 13:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998AB1DF756;
	Wed, 19 Feb 2025 13:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="QSG6P8AY"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E182AD00;
	Wed, 19 Feb 2025 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739970332; cv=none; b=jp/Lgb1SBI7zKAZcrYViGyq1wMAwXSx5PJOxr3rYwG5uKE6lB4gGkXcV3oIq41vj9pHcsY6iYNCQYqKDPjW6CIjhQy9thL7XVbe+6iHDrruy3JA5KoaonNG87mMxXWYeFtpyjK02YThYjUkIY2q2KokEQA2j1OhFeadBeIGKZBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739970332; c=relaxed/simple;
	bh=s911wMcbeZp32AGNtUVATQgYnK5tlhQjxdBvXNAXKhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBy9aVclSK+rJgOWqC2nZfWKrFnvqn+uqh9T7XBdiOnzAHpsl+XAHabFmanXmnempoWK4oc/Ks7sutXGonJQRCMoOn+9zW2MP+pDlrXR/nGaUlBEZsbcs1NpZvJHQVOsPTDKTFt/ygkUGkAMyOBJZbLDZEC1jEZVT4CiHJTLKMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=QSG6P8AY; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739970318; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=4wI6vYc+X3DPw8mXzQ1PLO+DDcPPxrtx9n1GzpVltlk=;
	b=QSG6P8AYmYhHM8c8sqPhUXN3eh3AWUbZ47HXWAKLPIys+AFZUN0pfDeg7IndaBVyM0eBECzIc96Qz1+3VWAZjxcQqg71HpX0YYmi7B/YiuvVHt91PSHdt5qu4GjKFbThMcEMkuYnPoaQscRXe+s7QZsoscNZJPfbuGcNPp+MRkc=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPpRQpA_1739970317 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 21:05:18 +0800
Message-ID: <78f7d2ab-67d8-41ab-a7b6-1313d1c1655c@linux.alibaba.com>
Date: Wed, 19 Feb 2025 21:05:16 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_pci_probe
To: Fenghua Yu <fenghuay@nvidia.com>, vinicius.gomes@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: nikhil.rao@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250215054431.55747-1-xueshuai@linux.alibaba.com>
 <20250215054431.55747-6-xueshuai@linux.alibaba.com>
 <5959e316-19da-4d10-bc7c-75431b87b9e0@nvidia.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <5959e316-19da-4d10-bc7c-75431b87b9e0@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/19 04:21, Fenghua Yu 写道:
> Hi, Shuai,
> 
> On 2/14/25 21:44, Shuai Xue wrote:
>> Memory allocated for idxd is not freed if an error occurs during
>> idxd_pci_probe(). To fix it, free the allocated memory in the reverse
>> order of allocation before exiting the function in case of an error.
>>
>> Fixes: bfe1d56091c1 ("dmaengine: idxd: Init and probe for Intel data accelerators")
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/dma/idxd/init.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index dc34830fe7c3..ac1cdc1d82bf 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -550,6 +550,14 @@ static void idxd_read_caps(struct idxd_device *idxd)
>>           idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
>>   }
>> +static void idxd_free(struct idxd_device *idxd)
>> +{
>> +    put_device(idxd_confdev(idxd));
>> +    bitmap_free(idxd->opcap_bmap);
>> +    ida_free(&idxd_ida, idxd->id);
>> +    kfree(idxd);
> 
> opcap_bmap, idxd_ida, idxd are NOT allocated during FLR re-init idxd device. In the FLR case, they should not be freed.
> 

After relook the code, idxd_free() will not be called in FLR case,
because all error lable in idxd_pci_probe_alloc() is called from
alloc_idxd=true, not the FLR case.

Anyway, I will add a protection in idxd_free().

Thanks.
Shuai


