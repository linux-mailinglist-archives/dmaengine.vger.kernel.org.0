Return-Path: <dmaengine+bounces-4488-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F51A36B48
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 03:07:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C966F17188C
	for <lists+dmaengine@lfdr.de>; Sat, 15 Feb 2025 02:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754CD770FE;
	Sat, 15 Feb 2025 02:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qLAv0QtH"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35211DDA8;
	Sat, 15 Feb 2025 02:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739585218; cv=none; b=Ax2kWbOCLhYp7+31x2n1tb6xc3VtQc+ZudT06IqJbzqy/LTUqKCFSJV3RY7N0dQSMqJa+PdU0PPShBdSTfYfrdMFYCesLsCb6QscN3hZPcz7a/JY38tCM6m2QS01RG8kWb2kwAg/Ye/FXYJ+/dUJ3Ug3ZMf3ymnX/nck9K3F0LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739585218; c=relaxed/simple;
	bh=LFqqFYAr3FEQzxQBI4kQ1/9vn9sI70QlxmyQsWYdHuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riYxeRPr1hQcyfbdUDNfJkFu/0r6jytwa2Vkp9pv/o3tKcF8oH6vddAPHunGL5Qw9WxJn9xFQ1wiaf3pqI1V+T4eorey8QVG1GVgd9CL3hM6e72UHsb0plU0lKr8YDonlxmTNgE6kery+Th5Y7T2w6sYm9Ly3xctLiARBzYXOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qLAv0QtH; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739585206; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Ssc9b2y5CD0n/EXyQ7xSDezl4zLnSk9Vo/2nwGLo0b0=;
	b=qLAv0QtHqCNDLwwz/mbVkt91PezDBWiivvlnC9Z1ugI+tDIJygrXuCHZMRJ+d4/AD76B1KMy+4acM1V+VdUl2wWEtDB2Gu6HjA42GlUz/MqdzcuQMsn0wZoyAkOKfTLqX9FVFBA2I2fTixEPgQsJEtF2J6bG+2sTVv34EgFah7k=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPSP86n_1739585205 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 15 Feb 2025 10:06:45 +0800
Message-ID: <f9151732-50e0-4e6d-8087-3270c9069ea8@linux.alibaba.com>
Date: Sat, 15 Feb 2025 10:06:44 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/5] dmaengine: idxd: fix memory leak in error handling
 path of idxd_pci_probe
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>, fenghua.yu@intel.com,
 dave.jiang@intel.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
 <20250110082237.21135-6-xueshuai@linux.alibaba.com>
 <87jz9s5c24.fsf@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <87jz9s5c24.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/15 07:41, Vinicius Costa Gomes 写道:
> Shuai Xue <xueshuai@linux.alibaba.com> writes:
> 
>> Memory allocated for idxd is not freed if an error occurs during
>> idxd_pci_probe(). To fix it, free the allocated memory in the reverse
>> order of allocation before exiting the function in case of an error.
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> ---
>>   drivers/dma/idxd/init.c | 10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index f0e3244d630d..9b44f5d38d3a 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -548,6 +548,14 @@ static void idxd_read_caps(struct idxd_device *idxd)
>>   		idxd->hw.iaa_cap.bits = ioread64(idxd->reg_base + IDXD_IAACAP_OFFSET);
>>   }
>>   
>> +static void idxd_free(struct idxd_device *idxd)
>> +{
>> +	put_device(idxd_confdev(idxd));
>> +	bitmap_free(idxd->opcap_bmap);
>> +	ida_free(&idxd_ida, idxd->id);
>> +	kfree(idxd);
>> +}
>> +
> 
> I was expecting this function to be called from idxd_remove() as well.
> Perhaps on a separate patch?

You are right, I missed the idxd_remove() to destroy idxd device.
Will add a new patch in next version.

> 
>>   static struct idxd_device *idxd_alloc(struct pci_dev *pdev, struct idxd_driver_data *data)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -820,7 +828,7 @@ static int idxd_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>    err:
>>   	pci_iounmap(pdev, idxd->reg_base);
>>    err_iomap:
>> -	put_device(idxd_confdev(idxd));
>> +	idxd_free(idxd);
>>    err_idxd_alloc:
>>   	pci_disable_device(pdev);
>>   	return rc;
>> -- 
>> 2.39.3
>>
> 
> Cheers,

Thanks.
Shuai


