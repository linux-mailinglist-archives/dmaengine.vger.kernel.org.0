Return-Path: <dmaengine+bounces-5529-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A0AADE016
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 02:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C2916BEDC
	for <lists+dmaengine@lfdr.de>; Wed, 18 Jun 2025 00:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59967080D;
	Wed, 18 Jun 2025 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TnJxgWFD"
X-Original-To: dmaengine@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC362F531E;
	Wed, 18 Jun 2025 00:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750207101; cv=none; b=HOJ1RdENOFuqffspOe9Toa+RxxOID/8BWpDYqHQO7X2b8BMMdXBcP+cKdtFiHlfIFKFhaqovTl0/uMJY8gQyBEUtlxT1LCiVSZkCymsl/zVw4RoonM+5knPWazj6ZNpyA+ADRpq7djwkmenp85eCQRiW5RnAVB9FunNozAZ9tS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750207101; c=relaxed/simple;
	bh=kr/dpxCIiFx2PARCp0s8CBGX8HSEHg1lXZUOZePGodQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=exk4dTIyzSU0q9+pFS2/mJAK5aUaH4VKl0FG3Xplje5soLWS4eFEaCENS+u6CKFmvZcvkeOTCQsnYo/tChlFYxO6mnjB7kqyGyLjjZ7A7QzoJAvAtKs7FaWgH4p2kFVIpjRkFiz3Dz0v8IzlTKKNeQ/VcV83HLXgcojgW/C+GJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TnJxgWFD; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750207101; x=1781743101;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=kr/dpxCIiFx2PARCp0s8CBGX8HSEHg1lXZUOZePGodQ=;
  b=TnJxgWFD9N1Zwj/YqpP3umUHBn3eOSk6R8SYZ7EQzn/ha3AtsZWSZZm6
   dYcO2aXT6D4vcogVB/7ELoIH3UtlwuQj+daZ4XHZk8MaX+XvGv7vdCv85
   9n37mJExMIGFsrOkPsFNeue2qExGM0KaJfE7rMdt4cWRNtIAXaW8rMfRI
   0x8x2pACWylhkKGLZHdZ7v8Wdr2ZkKmxgt6TaEQrreWJfK7vDaC0sMo93
   VwOa/CoDxLmuS6rghJOd6uV9ChaF82s7hGaBDXamZxsVM0YNmXDmBin2+
   rIKew8uuYKqinn6YGGwDYjxXQTFZK8QAgRgpYQzdQg3Q0VELrsAbqeQX+
   Q==;
X-CSE-ConnectionGUID: fKU8qtKRTBmJ+dy/D1ezqg==
X-CSE-MsgGUID: ALimepv9RKurW3LQJA/j2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52386204"
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="52386204"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:38:20 -0700
X-CSE-ConnectionGUID: D7hSyphjQUSQgNYrhIVGGQ==
X-CSE-MsgGUID: JeKkNUs1RdWgXffme3kQ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,244,1744095600"; 
   d="scan'208";a="172320539"
Received: from unknown (HELO vcostago-mobl3) ([10.241.226.49])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2025 17:38:18 -0700
From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
To: Fenghua Yu <fenghuay@nvidia.com>, Yi Sun <yi.sun@intel.com>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: dave.jiang@intel.com, gordon.jin@intel.com
Subject: Re: [PATCH v3 2/2] dmaengine: idxd: Fix refcount underflow on
 module unload
In-Reply-To: <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
References: <20250617102712.727333-1-yi.sun@intel.com>
 <20250617102712.727333-3-yi.sun@intel.com>
 <39398407-009e-4afe-acb6-e3de931627d7@nvidia.com>
Date: Tue, 17 Jun 2025 17:38:17 -0700
Message-ID: <871prh9952.fsf@intel.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Fenghua Yu <fenghuay@nvidia.com> writes:

> Hi, Yi,
>
> On 6/17/25 03:27, Yi Sun wrote:
>> A recent refactor introduced a misplaced put_device() call, leading to a
>> reference count underflow during module unload.
>>
>> There is no need to add additional put_device() calls for idxd groups,
>> engines, or workqueues. Although commit a409e919ca3 claims:"Note, this
>> also fixes the missing put_device() for idxd groups, engines, and wqs."
>> It appears no such omission existed. The required cleanup is already
>> handled by the call chain:
>>
>>
>> Extend idxd_cleanup() to perform the necessary cleanup, and remove
>> idxd_cleanup_internals() which was not originally part of the driver
>> unload path and introduced unintended reference count underflow.
>>
>> Fixes: a409e919ca32 ("dmaengine: idxd: Refactor remove call with idxd_cleanup() helper")
>> Signed-off-by: Yi Sun <yi.sun@intel.com>
>>
>> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
>> index 40cc9c070081..40f4bf446763 100644
>> --- a/drivers/dma/idxd/init.c
>> +++ b/drivers/dma/idxd/init.c
>> @@ -1292,7 +1292,10 @@ static void idxd_remove(struct pci_dev *pdev)
>>   	device_unregister(idxd_confdev(idxd));
>>   	idxd_shutdown(pdev);
>>   	idxd_device_remove_debugfs(idxd);
>> -	idxd_cleanup(idxd);
>> +	perfmon_pmu_remove(idxd);
>> +	idxd_cleanup_interrupts(idxd);
>> +	if (device_pasid_enabled(idxd))
>> +		idxd_disable_system_pasid(idxd);
>>
> This will hit memory leak issue.
>
> idxd_remove_internals() does not only put_device() but also free 
> allocated memory for wqs, engines, groups. Without calling 
> idxd_remove_internals(), the allocated memory is leaked.
>
> I think a right fix is to remove the put_device() in 
> idxd_cleanup_wqs/engines/groups() because:
>
> 1. idxd_setup_wqs/engines/groups() does not call get_device(). Their 
> counterpart idxd_cleanup_wqs/engines/groups() shouldn't call put_device().
>
> 2. Fix the issue mentioned in this patch while there is no memory leak 
> issue.
>

In my opinion, I think the problem is a bit different, it is that the
driver is doing a lot of custom deallocation itself and not
trusting/depending on the device lifetime tracking to do the
deallocation of resources. That is, we should free the memory associated
with a device when its .release() is called.

>>   	pci_iounmap(pdev, idxd->reg_base);
>>   	put_device(idxd_confdev(idxd));
>>   	pci_disable_device(pdev);
>
> Thanks.
>
> -Fenghua
>

Cheers,
-- 
Vinicius

