Return-Path: <dmaengine+bounces-5153-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034AEAB4D44
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 09:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC67A080A
	for <lists+dmaengine@lfdr.de>; Tue, 13 May 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914941E5B94;
	Tue, 13 May 2025 07:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yp2Ge4/R"
X-Original-To: dmaengine@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31A81E32D5;
	Tue, 13 May 2025 07:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747122460; cv=none; b=I/DZ9qTsSWrUJ0eEOdSxdUgMaul8xyQdpIBoPgm+v+Vpel8O+LOw140IsKUACJU8ukEyrobqAgRURvfl5/7AH1mQ4xN3d1RFuBXob/1OL1Do6ouTzh5XobcyFma0fKgKKVxd5zGenDXVjnJsJN/OXJ+Rlu0GoG4G4crXVaBOUZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747122460; c=relaxed/simple;
	bh=zTi2axbB6ur7cpoO+2lcwg8umJILunItxMMYQs51btE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gisdIwMBl8SyaDQhgpvj2/diK0p6GJKAltsQnsJn6kgx2pAsQrFYRtEhMJaV/aD7nKwRDdqpZkAFgQCwIHyngV3JdTFefiJJJ3Fhfd0eNvxKevxNHPqh/7EvNOzXLQ8b8qyrsgxxRxgTBswmfbCrcbkeXpw8rPp2GpfJb2LgLKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yp2Ge4/R; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1747122451; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7SvpWfljnrr5GhCK/xxKnAo/NO5d5M1IFimO04ksLmY=;
	b=yp2Ge4/RPVAnlGOUiyyikh5sjMxMoqhPzn9SmlhHScF8OZcHn0PVQPP1ZkMzyXFUr9wk6ZQvLYyeaU36L6S0OvVfX0RKREF3sdWlnx20xfP/o4XtPZtk62XQlHhljzHkDhuPPReWk+sH6ldJF/dbWZXsnRxUv8RuCm3riDFzMuQ=
Received: from 30.246.160.110(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0WaWaeSP_1747122449 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 May 2025 15:47:30 +0800
Message-ID: <0ded26fe-aac6-44e7-8a2e-30195d38b55f@linux.alibaba.com>
Date: Tue, 13 May 2025 15:47:26 +0800
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/9] dmaengine: idxd: fix memory leak in error handling
 path
To: vinicius.gomes@intel.com, dave.jiang@intel.com, fenghuay@nvidia.com,
 vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20250404120217.48772-1-xueshuai@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/4/4 20:02, Shuai Xue 写道:
> changes since v3:
> - remove a blank line to fix checkpatch warning per Fenghua
> - collect Reviewed-by tags from Fenghua
> 

Hi, all,

Gentle ping.

Thanks.
Shuai

