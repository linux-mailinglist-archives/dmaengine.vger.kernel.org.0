Return-Path: <dmaengine+bounces-5283-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2000AC8805
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 07:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15B973BE9DD
	for <lists+dmaengine@lfdr.de>; Fri, 30 May 2025 05:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409031DE2A7;
	Fri, 30 May 2025 05:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cmp2k3Ew"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153C110F1;
	Fri, 30 May 2025 05:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748583597; cv=none; b=oEXyaAjRbQXGNpBNV+mHbfa8il7MWQk2V3yRGvlzjyo3QdYya1rvpQGkbNzaYxXyFj9mSdFkCST29a/d1lxPRb/f+Uf33F5PDx4SjQ1/JqkIVg2tejGW6hDPSadt0GBrhlMvyLJuCoxX/+LuwXXEuIc0t4c+nDqWWd4pKNUhsdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748583597; c=relaxed/simple;
	bh=dsMm9xxT+4g42r4do5g1cUDskHBfQ976M0MnVKdumSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CqD5T28uAOww/ns+TCYOd0dGZH2RcCS9NgD+ToVZ5kNrJD68oKYajN7sJqmng/P+7zNePBNdNTWMYze58pGDl04VlBBXkg6JyHIT4HdTXc2fapcKxaL8gxl07hhnac7TmbwaXNdiqw+uBX7TtMg6Roiteaj56JVxCiKwFZ7HJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cmp2k3Ew; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748583585; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tdcQ7DCRnJexevViWBNT3Gq6oWDJx5lqE6/m9p96IMk=;
	b=Cmp2k3EwSvYc3Mk8QVSP8fgAwg8TM2mDOEH7yz3zwNch4hDCew2htvGWAN+AOS5GyZeu67sgj6xzm47+bTv7nneVXPtUg4TuQ1qM4XDQia8k+JLiMek2GUoPPAg5HaO/qiPtKrufLBxwBw1Rn200VoigzVJrbsfuhWk+Q97sgMs=
Received: from 30.246.160.208(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WcK4iST_1748583584 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 May 2025 13:39:45 +0800
Message-ID: <78dd14f8-8344-49a4-95eb-14ff005c5ba5@linux.alibaba.com>
Date: Fri, 30 May 2025 13:39:44 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dmaengine: idxd: Fix refcount underflow on module
 unload
To: Yi Sun <yi.sun@intel.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: dave.jiang@intel.com, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, gordon.jin@intel.com
References: <20250529153431.1160067-1-yi.sun@intel.com>
 <20250529153431.1160067-2-yi.sun@intel.com> <87msav9wm6.fsf@intel.com>
 <aDkgxCsCtsEugTdI@ysun46-mobl.ccr.corp.intel.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <aDkgxCsCtsEugTdI@ysun46-mobl.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/5/30 11:06, Yi Sun 写道:
> On 29.05.2025 10:04, Vinicius Costa Gomes wrote:
>> Yi Sun <yi.sun@intel.com> writes:
>>
>>> A recent refactor introduced a misplaced put_device() call, resulting in
>>> reference count underflow when the module is unloaded.
>>>
>>> Expand the idxd_cleanup() function to handle proper cleanup, and remove
>>> idxd_cleanup_internals() as it was not part of the driver unload path.
>>>
>>
>> 'idxd_cleanup_internals()' frees a bunch of stuff. I would expect an
>> explanation of when those things are being free'd now that removed that
>> call.
>>
> 
> I believe the call to idxd_unregister_devices(), which is invoked at the
> very beginning of idxd_remove(), already takes care of the necessary
> put_device() through the following call path:
> idxd_unregister_devices() -> device_unregister() -> put_device()
> 
> Therefore, there's no need to add additional put_device() calls for idxd
> groups, engines, or workqueues. While the commit message for a409e919ca3
> states: "Note, this also fixes the missing put_device() for idxd groups,
> engines, and wqs."
> it appears that no such omission actually existed, this part of the flow
> was already correctly handled.
> 
> Moreover, this refcount underflow issue appears to be a a clear
> regression. Prior to this commit, idxd_cleanup_internals() was not part of
> the driver unload path. The commit did not provide a strong justification
> for calling idxd_cleanup_internals() within idxd_cleanup().
> 
> For reference, the both two related bugs produce nearly identical call
> traces, and I think both are blocking issues.
> 
> Thanks
>     --Sun, Yi

Hi, Sun, Yi

idxd_pci_probe_alloc() {
	rc = idxd_probe(idxd);
	rc = idxd_register_devices(idxd);
	if (rc) {
		dev_err(dev, "IDXD sysfs setup failed\n");
		goto err_dev_register;
	}
// ...
  err_dev_register:			<-
	idxd_cleanup(idxd);
}

We use idxd_cleanup() when register devices failed to undo the
idxd_probe(). idxd_probe() sets up idxd groups, engine and wqs and
get reference counts by device_initialize().

what's the difference between idxd_cleanup_internals() and
idxd_unregister_devices()?

Thanks.
Shuai



