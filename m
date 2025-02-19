Return-Path: <dmaengine+bounces-4533-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D34A3BE0A
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 13:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1510D3B56E5
	for <lists+dmaengine@lfdr.de>; Wed, 19 Feb 2025 12:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4141D1DFD91;
	Wed, 19 Feb 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tiz6X19K"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1502E1D52B;
	Wed, 19 Feb 2025 12:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739968111; cv=none; b=N64Vnvt3wxTz3gS4IVZOyaUtUUR8X/J3jL35XFltsakyXIZpMeTR0sQIGf14u0QFPFfyNBg0QLeopUGtF7K96rlh+UYhCCz6s2BdGeCJuZUPd5JelZpeQNJ9KzxBRC+fDKp/xkppyA+qrZg4FNOZ+YANagKgWvjaWjHFWxptdmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739968111; c=relaxed/simple;
	bh=6OYuPYLFFGSzAYcwYN9dlH4FnHdeBk6mh2HE/XQ2Xr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IjMqHPvlLhmsV2oPRi56Jm3yw2IhJSIihys6fEFLSa/8rN3pZkqX8Rpy9oSsW1JzRyoBdirtldqYVwns+AapnVrRC0JxhPrPaSeoXTf4v1iZgufOcUzSNU5RVNeKu+gi4IULNgXWnhZQr+dFLIvb6muWV8wSggqXypOaxxHiN0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tiz6X19K; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739968103; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FK40UwTND3UC7WyjcHaw02QI5U346kVynN6H6JZkPro=;
	b=tiz6X19Kd5S9vmqSrIhVuRE9B3YEccVl0JeOaf45DVnUAMFGJ17No9/A5lqYK8BGt60zky+RnntxmOnoPdwG17IVofGlw9z48xWwBjrJ0z9kkJLluYJcnaC27K5ioFFE90y6K0qKMH5jKMMRY6GCv8VrvF9SYLI/lB6m1vFC6wk=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPpI3nf_1739968102 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Feb 2025 20:28:22 +0800
Message-ID: <8880c4b6-233f-4b8a-a73f-398448169dfd@linux.alibaba.com>
Date: Wed, 19 Feb 2025 20:28:21 +0800
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

Great catch, thanks.

Will fix it in next version.

Shuai



