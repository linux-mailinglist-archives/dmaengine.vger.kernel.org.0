Return-Path: <dmaengine+bounces-4671-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC03A58A1D
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 02:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2A7188CB07
	for <lists+dmaengine@lfdr.de>; Mon, 10 Mar 2025 01:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183CF14AD29;
	Mon, 10 Mar 2025 01:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="q/J5z5yU"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B7A433C0;
	Mon, 10 Mar 2025 01:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741570943; cv=none; b=J4CR887qDNblie3QhvuFIMLM6dHB2RmD8JvASLKBaUChBjZGaVfW+CjdDHCtiuMX4IZh0xW5zKZ1au9lxPEfC/s5SbMAYJMd9JbR+D4EL/j7HlCknIQjddxKQOb92WPdAX0C+S6u6eUkvFodmFibnEjbwfrdiYoeLT/bEfo53GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741570943; c=relaxed/simple;
	bh=QVv8P+QtngepIKslcEWvFxI5YuvaAMhU2DEqYPzrrLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f14/+hneHiqWRlCMZwjcXuJXXpNtsAc7eRUoUG6j+fOyrjMCK3kvo3z1w4Nk09id1DDNg5oRLua+QkwhYcmei1oG6c2dio59wLI/C97VzLIcGUYOECeuwAHXbAB9BqnUQZCy0WrJBA7A93TpIV8zKLu9XHYq/A/WKa5XZ4N7CqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=q/J5z5yU; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741570930; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=QtQEM0Kw+zy/Rl1a6uiSxghYfQNaqS0fHa7jQOsaVbU=;
	b=q/J5z5yUF3YTGz/R7/cgiTm9DtDp4PSOHLYS0XenFFb+EWQOoxEQNdXXDnO5il+jhQ7q25YVn2iKIGFQxAo/W+tbBxLMrRWPR9YYTMhvjiQf+ZU2Cm5UTpVWlAY4NiLHZD23rZsIHoT4h8+/3D/hHMPd8ruAtp7f+eh9AGj+O+g=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WQyHCMs_1741570928 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 09:42:09 +0800
Message-ID: <bb29d6d8-6887-4eed-ba24-7392de9c2c29@linux.alibaba.com>
Date: Mon, 10 Mar 2025 09:42:07 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs()
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>, Fenghua Yu <fenghuay@nvidia.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250309062058.58910-1-xueshuai@linux.alibaba.com>
 <20250309062058.58910-2-xueshuai@linux.alibaba.com>
 <8545206d-4a7d-4e0f-812b-dadf923b5b5c@web.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <8545206d-4a7d-4e0f-812b-dadf923b5b5c@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/3/9 17:10, Markus Elfring 写道:
> …
>> +++ b/drivers/dma/idxd/init.c
> …
>> @@ -203,7 +201,6 @@ static int idxd_setup_wqs(struct idxd_device *idxd)
>>   		wq->enqcmds_retries = IDXD_ENQCMDS_RETRIES;
>>   		wq->wqcfg = kzalloc_node(idxd->wqcfg_size, GFP_KERNEL, dev_to_node(dev));
>>   		if (!wq->wqcfg) {
>> -			put_device(conf_dev);
>>   			rc = -ENOMEM;
>>   			goto err;
>>   		}
> 
> I suggest to move such an error code assignment also to the end of this function implementation.
> 

I prefer to set error code before jumping to error handling label
so that we can extend/change the error code in any future path.

> Regards,
> Markus

Thanks for valuable comments.
Best Regards,
Shuai

