Return-Path: <dmaengine+bounces-4502-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2AA7A373E0
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 12:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E13853AC790
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 11:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9641624E2;
	Sun, 16 Feb 2025 11:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GG2iREBr"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F7C3209;
	Sun, 16 Feb 2025 11:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739703897; cv=none; b=X7GPdI0TiAuuJiYv9B1Xm+Le/KPHxbieFg5JEJszdzXKngQ+oCtlrMfrsn27ax3x94JAjb9NTmGJ5FDDRSn+QzXznJjhdZsJIVVLbHg9J1vAuHqimY1D64m5AEsL9tHfSt5OUhcHZc3D0X3IBExmG0TFDlqXQeMLWlKSepc1Yxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739703897; c=relaxed/simple;
	bh=z9x8xH8SWbg10OAFANJInFF/Fw8mgRPqB2Lc31pVMp4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzndduz6TRDYrx7/FG82sRLAsJ7cLBiNrJGn/gfSztiyTfR1RDtQNqEgwUFz7lPZ3jERikdunIf5U3HiNVBU31ilsK4ielZuqYwoDCB8r/2pKdRQnEcnway4kAsmPQU8hpb6kkyTq8JqUHihG32wht7LFTyb6i72SL8J+p+lDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GG2iREBr; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739703885; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=BNWxHp3VpENqQX9PIKu665q5aryES8RoVts4fxU0i60=;
	b=GG2iREBrj5HoEFF4S5pBkAJiws/UH144eayEdLacF1sboSFT2uM78HLSn65ZEyaBWlinrZV5mKrUmw8dZO8rRMoqjLD6N9/8fjAC1feGNcPuhitYP9kAbrSxZXp3QemGQ8//O/NnO8Tu7nyuosQ1QhKT7pzdUUa/frv+iudP8ig=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPWTwAZ_1739703884 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Feb 2025 19:04:44 +0800
Message-ID: <761ef7d1-47d0-4ada-a5d5-8e7b8bf966ea@linux.alibaba.com>
Date: Sun, 16 Feb 2025 19:04:43 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 1/7] dmaengine: idxd: fix memory leak in error handling path
 of idxd_setup_wqs()
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
 <98327a4d-7684-4908-9d67-5dfcaa229ae1@web.de>
 <4128c7ad-a191-4c37-a6ba-47b06324a8b5@linux.alibaba.com>
 <825ed0c6-e804-4e07-9881-78de319aadf2@web.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <825ed0c6-e804-4e07-9881-78de319aadf2@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/16 17:34, Markus Elfring 写道:
>>> Will a “stable tag” become relevant also for this patch series?
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/stable-kernel-rules.rst?h=v6.14-rc2#n3
>>
>> I don't know if this is a real serious issue for stable kernel.
> How many resource leaks would you like to avoid with your contributions?

For this patch:

     - wqs = 8 * 8 bytes = 64 bytes
     - wq = 8 * 2400 bytes =  19200 bytes
     - opcap_bmap = 256 bit / 8 = 32 bytes

Around 18 KB.


> 
> Regards,
> Markus

Thanks.
Shuai


