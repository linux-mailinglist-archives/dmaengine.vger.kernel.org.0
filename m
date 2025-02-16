Return-Path: <dmaengine+bounces-4500-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DE2A37311
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 10:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4191B188CC5D
	for <lists+dmaengine@lfdr.de>; Sun, 16 Feb 2025 09:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F4817C208;
	Sun, 16 Feb 2025 09:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="EXYS2+gy"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C69717BB16;
	Sun, 16 Feb 2025 09:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739697967; cv=none; b=Ik6DGFx/Mv0XHjJSdXr2EObuVtAT3gqmyWx2AVNB0BvgBT1w5tvfJj+fSxfNYVD8DRKm/v/BK91h6GWLqwWY3JEZWmtfswKGnUkWIyd0rp/5UrOZCCzprwTj+yFIfxwH1Vp5L9AMjihQuacvvPDJaJaKDxIsRGEijjEbif2UJlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739697967; c=relaxed/simple;
	bh=44yVB84rkQJMg7p8h5nwXIKSGjpwkTwTn0lIkA6w12A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rbnrkv4babNcaCfvsyflNLbAhQdIT1RxCECQBw3ZIwFJ5waw9cTuDPr5fFl+9M77jbz/aPD8trjeSWHw6konHT+AigkPQ2mfWrB2gkKWVUg4w9f4x40sIExl2/vlXmBBzrkjjP30P2xaNM6grewYz7v+gnilWBTtyYxubBJYL+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=EXYS2+gy; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739697954; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=A883eWTYaablIuVt76hhH6/BFXxd1A8zls1IQ1Wjhsg=;
	b=EXYS2+gyfYxmtfkeFES/cve3Cn/bLusERWBg+CiSSlLe3b6lml2akLG63U31DL+/VtR4afWQgSFAkVlCryJSHDNT2f/w9IAFzgjA5rzTWZ6V01LSD6ZwD83DGBF3N2G8c3k51tKorQEKi8XxDk2j5SfDXWaUaCnE8w0T3Df4Oqo=
Received: from 30.246.161.128(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WPWFy2n_1739697953 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 16 Feb 2025 17:25:53 +0800
Message-ID: <d1fe997f-90ff-4820-938d-be8adf6259f1@linux.alibaba.com>
Date: Sun, 16 Feb 2025 17:25:52 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] dmaengine: idxd: fix memory leak in error handling
 path of idxd_setup_wqs
To: Markus Elfring <Markus.Elfring@web.de>, dmaengine@vger.kernel.org,
 Dave Jiang <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Jerry Snitselaar <jsnitsel@redhat.com>
References: <20250215054431.55747-2-xueshuai@linux.alibaba.com>
 <09329455-a90a-4ff7-8184-31343def027e@web.de>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <09329455-a90a-4ff7-8184-31343def027e@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/15 21:34, Markus Elfring 写道:
> …
>> Fixes: a8563a33a5e2 ("dmanegine: idxd: reformat opcap output to match bitmap_parse() input")
> …
> 
> Would other commits be more appropriate for the desired reference
> (according to the affected function implementation)?
> 
> Examples:
> 2022-09-29: de5819b994893197c71c86d21af10f85f50d6499 ("dmaengine: idxd: track enabled workqueues in bitmap")
> 2021-04-21: 700af3a0a26cbac87e4a0ae1dfa79597d0056d5f ("dmaengine: idxd: add 'struct idxd_dev' as wrapper for conf_dev")
> 2021-04-20: 7c5dd23e57c14cf7177b8a5e0fd08916e0c60005 ("dmaengine: idxd: fix wq conf_dev 'struct device' lifetime")
> 

Ok, I will add the fixes.

> 
> Regards,
> Markus

Thanks.


