Return-Path: <dmaengine+bounces-5253-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF7DAC1BD3
	for <lists+dmaengine@lfdr.de>; Fri, 23 May 2025 07:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E228E4E7821
	for <lists+dmaengine@lfdr.de>; Fri, 23 May 2025 05:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF77221DA6;
	Fri, 23 May 2025 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CZtZcw+a"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1735223709;
	Fri, 23 May 2025 05:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747977945; cv=none; b=ia5veVzUuftih5ygVNNI75Blo8tYQWUn36USYxaorFfc5D5YlbpMokO6laE4XhMfwbr+iWCDpSAzuf9IlcwHWWPylFd+HHBIwSyzVGW6TecEAMcYPlPIOXxo+SKlIb2DUf/KeVm9cz3uj1RI+M1CtDeXUcRrqlvnOJKuWvkzZLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747977945; c=relaxed/simple;
	bh=zqFBXNgJR6QPqujYBcu7eKwHqsY+GG/0ieJMWXaanzY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q/fkIq41zx0r5sSu6fnSSA9YSWTakPIP/KOu2fjKaug5Nlql5b8YOVglpsiKbtoj0GX0FxFis9s4FrTWpMDOOU+4+DqmVrdyPRBrAPO8I8LBdQmLtVWvz9+rwoSNOaD/NzL3N+e3L8FfzT4pZstz5sDPj/Lr3jHjYG/H1NPNUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CZtZcw+a; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747977938; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=p9YLrwedFtwnpJG6tOJNl4XHicffoGD8uCwZAyB8uHI=;
	b=CZtZcw+aEPe0HT/wUy3oVlOn/BgLogIzKK0fCEUuASBLkMkRKKfo46791/PMhn5h/yB41J9N22hiuoFHqV261lehUnabbQwV0/tV3I14WAaUq8iqQozgA2PaeC8EiEpq9KbT3pZImJtartFJfKY0jWVKTDWcmoWXC+bAPvZk1co=
Received: from 30.246.160.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WbZ4I8V_1747977617 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 May 2025 13:20:18 +0800
Message-ID: <b2153756-a57e-4054-bde2-deb8865c9e59@linux.alibaba.com>
Date: Fri, 23 May 2025 13:20:16 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dmaengine: idxd: Fix race condition between WQ
 enable and reset paths
To: Dave Jiang <dave.jiang@intel.com>, vinicius.gomes@intel.com,
 fenghuay@nvidia.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, colin.i.king@gmail.com,
 linux-kernel@vger.kernel.org
References: <20250522063329.51156-1-xueshuai@linux.alibaba.com>
 <20250522063329.51156-2-xueshuai@linux.alibaba.com>
 <a03e4f97-2289-4af7-8bfc-ad2d38ec8677@intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <a03e4f97-2289-4af7-8bfc-ad2d38ec8677@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/22 22:55, Dave Jiang 写道:
> 
> 
> On 5/21/25 11:33 PM, Shuai Xue wrote:
>> A device reset command disables all WQs in hardware. If issued while a WQ
>> is being enabled, it can cause a mismatch between the software and hardware
>> states.
>>
>> When a hardware error occurs, the IDXD driver calls idxd_device_reset() to
>> send a reset command and clear the state (wq->state) of all WQs. It then
>> uses wq_enable_map (a bitmask tracking enabled WQs) to re-enable them and
>> ensure consistency between the software and hardware states.
>>
>> However, a race condition exists between the WQ enable path and the
>> reset/recovery path. For example:
>>
>> A: WQ enable path                   B: Reset and recovery path
>> ------------------                 ------------------------
>> a1. issue IDXD_CMD_ENABLE_WQ
>>                                     b1. issue IDXD_CMD_RESET_DEVICE
>>                                     b2. clear wq->state
>>                                     b3. check wq_enable_map bit, not set
>> a2. set wq->state = IDXD_WQ_ENABLED
>> a3. set wq_enable_map
>>
>> In this case, b1 issues a reset command that disables all WQs in hardware.
>> Since b3 checks wq_enable_map before a2, it doesn't re-enable the WQ,
>> leading to an inconsistency between wq->state (software) and the actual
>> hardware state (IDXD_WQ_DISABLED).
> 
> 
> Would it lessen the complication to just have wq enable path grab the device lock before proceeding?
> 
> DJ

Yep, how about add a spin lock to enable wq and reset device path.

diff --git a/drivers/dma/idxd/device.c b/drivers/dma/idxd/device.c
index 38633ec5b60e..c0dc904b2a94 100644
--- a/drivers/dma/idxd/device.c
+++ b/drivers/dma/idxd/device.c
@@ -203,6 +203,29 @@ int idxd_wq_enable(struct idxd_wq *wq)
  }
  EXPORT_SYMBOL_GPL(idxd_wq_enable);
  
+/*
+ * This function enables a WQ in hareware and updates the driver maintained
+ * wq->state to IDXD_WQ_ENABLED. It should be called with the dev_lock held
+ * to prevent race conditions with IDXD_CMD_RESET_DEVICE, which could
+ * otherwise disable the WQ without the driver's state being properly
+ * updated.
+ *
+ * For IDXD_CMD_DISABLE_DEVICE, this function is safe because it is only
+ * called after the WQ has been explicitly disabled, so no concurrency
+ * issues arise.
+ */
+int idxd_wq_enable_locked(struct idxd_wq *wq)
+{
+       struct idxd_device *idxd = wq->idxd;
+       int ret;
+
+       spin_lock(&idxd->dev_lock);
+       ret = idxd_wq_enable_locked(wq);
+       spin_unlock(&idxd->dev_lock);
+
+       return ret;
+}
+
  int idxd_wq_disable(struct idxd_wq *wq, bool reset_config)
  {
         struct idxd_device *idxd = wq->idxd;
@@ -330,7 +353,7 @@ int idxd_wq_set_pasid(struct idxd_wq *wq, int pasid)
  
         __idxd_wq_set_pasid_locked(wq, pasid);
  
-       rc = idxd_wq_enable(wq);
+       rc = idxd_wq_enable_locked(wq);
         if (rc < 0)
                 return rc;
  
@@ -380,7 +403,7 @@ int idxd_wq_disable_pasid(struct idxd_wq *wq)
         iowrite32(wqcfg.bits[WQCFG_PASID_IDX], idxd->reg_base + offset);
         spin_unlock(&idxd->dev_lock);
  
-       rc = idxd_wq_enable(wq);
+       rc = idxd_wq_enable_locked(wq);
         if (rc < 0)
                 return rc;
  
@@ -644,7 +667,11 @@ int idxd_device_disable(struct idxd_device *idxd)
  
  void idxd_device_reset(struct idxd_device *idxd)
  {
+
+       spin_lock(&idxd->dev_lock);
         idxd_cmd_exec(idxd, IDXD_CMD_RESET_DEVICE, 0, NULL);
+       spin_unlock(&idxd->dev_lock);
+

(The dev_lock should also apply to idxd_wq_enable(), I did not paste here)

Also, I found a new bug that idxd_device_config() is called without
hold idxd->dev_lock.

idxd_device_config() explictly asserts the hold of idxd->dev_lock.

+++ b/drivers/dma/idxd/irq.c
@@ -33,12 +33,17 @@ static void idxd_device_reinit(struct work_struct *work)
  {
         struct idxd_device *idxd = container_of(work, struct idxd_device, work);
         struct device *dev = &idxd->pdev->dev;
-       int rc, i;
+       int rc = 0, i;
  
         idxd_device_reset(idxd);
-       rc = idxd_device_config(idxd);
-       if (rc < 0)
+       spin_lock(&idxd->dev_lock);
+       if (test_bit(IDXD_FLAG_CONFIGURABLE, &idxd->flags))
+               rc = idxd_device_config(idxd);
+       spin_unlock(&idxd->dev_lock);
+       if (rc < 0) {
+               dev_err(dev, "Reinit: %s config fails\n", dev_name(idxd_confdev(idxd)));
                 goto out;
+       }
  
         rc = idxd_device_enable(idxd);
         if (rc < 0)

Please correct me if I missed anything.

Thanks.
Shuai


