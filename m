Return-Path: <dmaengine+bounces-4486-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95DC8A36B39
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 03:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CD181705BC
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 02:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A160770FE;
	Sat, 15 Feb 2025 02:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rYm1eQYW"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67238DE9;
	Sat, 15 Feb 2025 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739584882; cv=none; b=frirRx9fD4C8fpqYzLSQQnigRE/CeFAOge1BqDFE6qvXo+2aeTGojJnrlHxmVJ4pedZh7yU1z4wDGvvvZlqgszwmspw3Cd2eW8Y5M56p/aCbCHoExP+PwGavPhTmmLRVeusJ+kfYJUcpXdqH2FS6afYBqtyf05lfkFRLtN33n1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739584882; c=relaxed/simple;
	bh=gncXKG7beu+TTX3jEhMnjEvxKai7cCwthLIhdbfy9tI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2hlksRvH718xEodAcgKNIZoNVvqcWvB9uey5zdYFic37IIFxg5re7eK+hifupNkuNan8+JhCjni03vREDaWh5cFRVVSNtIlsmPOCeslvs4kCWWb0TtK4pwLOYsty8QydiVjHNXL3jBf11jcreZpjvvLDW2gRDxEkg8p36CLl5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rYm1eQYW; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739584875; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=UZ1ldi7XqZiWV5GPZclbn7U2sRzymXfxs/plAaNIJR0=;
	b=rYm1eQYWIuTeP1wI9cBoWBuyTc/T3VHZkpMNgjp7oq5yCnbCa5Foroof3Fec7EmPNGoCGBaH9Zfcv+k6te9guWYmu0NragZsVa7C/F1QeL+73YfwuHlKkLhDiJhCjrX8yIS9JXEy0zqdh7Rry4cyoyY2+xC0krw2xVEi7Vb2+Ds=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSMrjJ_1739584874 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 10:01:15 +0800
Message-ID: <4661c8da-8f50-4d9d-8c0e-5208067c9ed8@linux.alibaba.com>
Date: Sat, 15 Feb 2025 10:01:13 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] dmaengine: idxd: fix memory leak in error handling
 path
To: Dave Jiang <dave.jiang@intel.com>, Markus Elfring
 <Markus.Elfring@web.de>, dmaengine@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <61c9c416-711c-44dc-87af-b1aefc76b87e@web.de>
 <3bcf7b21-d894-4aa1-ba00-d32a32a72b2d@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <3bcf7b21-d894-4aa1-ba00-d32a32a72b2d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/15 01:22, Dave Jiang 写道:
> 
> 
> On 2/14/25 10:15 AM, Markus Elfring wrote:
>> …
>>>   drivers/dma/idxd/init.c | 62 ++++++++++++++++++++++++++++++++---------
>> …
>>
>> How do you think about to add any tags (like “Fixes” and “Cc”)
>> for the presented patches accordingly?
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14-rc2#n145
> 
> I actually thought about asking for that. But I believe the fixes are against code that just went in for 6.14 so backporting won't be necessary.

Will add fixes tags in next version.

> 
>>
>> Regards,
>> Markus

Thanks.
Shuai

