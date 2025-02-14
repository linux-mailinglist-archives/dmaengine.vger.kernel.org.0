Return-Path: <dmaengine+bounces-4465-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABE4A35758
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 07:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD1BD7A58E4
	for <lists+dmaengine@lfdr.de>; Fri, 14 Feb 2025 06:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D3620370C;
	Fri, 14 Feb 2025 06:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mQxM8RjI"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD11FFC47;
	Fri, 14 Feb 2025 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739515404; cv=none; b=FZ/EnF8JOABGWcsccO53rfBYaQzhuWZqUVG2Y0D6OcRU+9HMeW571UMDXEQtUNUp9E6ileZeA7SaB7MEckUEw6Cta85BLdKoQ51iRTYASplBKmj0vLs/uj50EttxHf3KeleeshZ7CS6rOSuRwlWRpCtzeVm56dGsQnbpPPPMT/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739515404; c=relaxed/simple;
	bh=2S6r+HHD3z++VZJtO16bk53DSKJlqHFV87Zks7enz0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IEdVVrr9UvgDNQj+PVTS7/ZpXoKGoZbWgmL4lgjdqbAfOSXB6xQsj/6RPm6kr9ccdl2plRINYEVc1Ch2nFweCEYSY01vLr3WAse+axGtN1ymI949EGpHTgFLLlEg1ct0SrLL/YNz8BlgBgrIe3VLaNUw1MjjqnqcL20vy2rgKT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mQxM8RjI; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739515390; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=RNOF/n77yyrcRuXjxmW7njvQ2mvDSHhwktLJqu0AdI0=;
	b=mQxM8RjIHVOk78szGS4zJfWjMUtNgFqQeEPGK2Wt7hQGWBsG78+dqQdDzgVADfUP3lsgkP5m7H3bGKLFsGgFdHJcTTFooXlw3tQYLY7wGDniNW5uZry6LcH9IE2PCCJ0ilzPND0xnk1OXPjdcgVEfC32LUPCW+8PJ6k4MNnkOrU=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPPx.GR_1739515388 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Feb 2025 14:43:09 +0800
Message-ID: <5814fac9-4b11-4c18-8ab4-70f0f2536c61@linux.alibaba.com>
Date: Fri, 14 Feb 2025 14:43:07 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/5] dmaengine: idxd: fix memory leak in error handling
 path
To: fenghua.yu@intel.com, dave.jiang@intel.com, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250110082237.21135-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/1/10 16:22, Shuai Xue 写道:
> Shuai Xue (5):
>    dmaengine: idxd: fix memory leak in error handling path of
>      idxd_setup_wqs
>    dmaengine: idxd: fix memory leak in error handling path of
>      idxd_setup_engines
>    dmaengine: idxd: fix memory leak in error handling path of
>      idxd_setup_groups
>    dmaengine: idxd: fix memory leak in error handling path of idxd_alloc
>    dmaengine: idxd: fix memory leak in error handling path of
>      idxd_pci_probe
> 
>   drivers/dma/idxd/init.c | 62 ++++++++++++++++++++++++++++++++---------
>   1 file changed, 49 insertions(+), 13 deletions(-)
> 

Hi, all,

Gentle Ping.

Thanks.
Shuai

