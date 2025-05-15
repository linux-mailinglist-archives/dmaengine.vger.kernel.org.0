Return-Path: <dmaengine+bounces-5177-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAAEAB823F
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 11:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AC54867C3E
	for <lists+dmaengine@lfdr.de>; Thu, 15 May 2025 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E69BC28CF6B;
	Thu, 15 May 2025 09:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="DXhlJFfs"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D52152F88;
	Thu, 15 May 2025 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747300476; cv=none; b=KtSTIyOmV2m8+MsdGKt8+RKPQmPV8ol15zLI4yyYngiuUwYA3HQcW1etx9yxij/2RD4qMWqmjXa8NfLsqDK5XOc6u9PaH4JoO24c5KZzqGMpG8kuK5A2wqRK78JeXA8r26wcuV0VuLrfSHngY2R3AkP4IQBSo+mKeCg/jVH9M9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747300476; c=relaxed/simple;
	bh=Y/KpJyEAbhpNsINCs7cRVAYqOgkCdkE6/S/Pzp5AwCo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=ouwFCRhlH/bXLsJiT+qJ5op6BkFPIRoT32jjtOM8pBMLehQKLaRCAz5pbw6d2JamTrqz5h7tMCe+pLgnU6JG182dBTQWddLbcjVOXdq9HO+mpKrkF459DgJntvM4oukXQgoqVCWyG4rYu5VthR3rL+ip1zf644XjAKlm1oi8jeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=DXhlJFfs; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 1F6D2A0149;
	Thu, 15 May 2025 11:14:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=BqELylo+1x+Ji/2E4BhW
	BaCKgU1m0gtE541IdTwDmWQ=; b=DXhlJFfsBzh3PItI+RaXb17IizvM2dqy7JUe
	FjbOv6zgjMSrtE9vEdkagaGnPqqSlIa7B2S8BcH39SRHH0jErj6hlN49qvadjC+r
	ebahbAtnNnBFIngf3HZOL6jq2Yjgh8hTfoPNynGV1Nq+A6HoIQAy0T6OoG/kAAvJ
	fHFABQIprJL4mpidvPrjfUug8QEHNrmIxfxh0RzNOnem8Cj0yARlt1iXp3ekda5G
	6tTKmC7JI/VrrfZobjMQjBmSbplSN8q5l3ySM7zrI5LWzGAmrfD5kr/LQzx2FtuZ
	rQQfSdJnImPpaILVFaVlLjkDywcIibj38cYtDKkAaFqvFaUkhQB97kJMf5sdfUJ7
	SNzMZowJEq4XyylXEQlRqimOU/xyMOA80Qx5BYJl0AFvZYWPbVLg8qkEkXH5qqWY
	CK1kY5m+ACdcPwSgYbLD826D1AJjv4gePz+4LNeGeEY/o7z/StxRz9EKGOJOun7D
	3eTgKlF1wq71Pe/rYvTvlmkvf/tjHrvQaRFDMMtZ1yQNeDXY0ja/1f4Ca2Aw0mZY
	4a303i3GrPao0hwqKn9hy9kgu4zjeTzdFSCytHFCPZFAD1tOG+D9LpMY8Dr+PxDa
	CdVXbhpa2ovLWb0RfleqZtSDAB3ipA3Nd9G8ET838hr4KS28+usFZueNYYtsBVKk
	aXu+Mp8=
Message-ID: <e4e6c7a9-9b7a-4012-8bda-75804229ec95@prolan.hu>
Date: Thu, 15 May 2025 11:14:22 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
Subject: Re: [PATCH v6 0/2] Add `devm_dma_request_chan()` to simplify probe
 path in atmel-quadspi.c
To: Mark Brown <broonie@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>, "Vinod
 Koul" <vkoul@kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea
	<claudiu.beznea@tuxon.dev>, "Rafael J. Wysocki" <rafael@kernel.org>, "Tudor
 Ambarus" <tudor.ambarus@linaro.org>
References: <20250515083132.255410-1-csokas.bence@prolan.hu>
 <aCWpjplhAXUvr9fj@finisterre.sirena.org.uk>
Content-Language: en-US
In-Reply-To: <aCWpjplhAXUvr9fj@finisterre.sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: sinope.intranet.prolan.hu (10.254.0.237) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A296767155D617062

Hi,

On 2025. 05. 15. 10:45, Mark Brown wrote:
> On Thu, May 15, 2025 at 10:31:28AM +0200, Bence Csókás wrote:
> 
>> Change in v4:
>> * split PM imbalance fix (now merged) and DMA cleanup (this series)
>> Change in v6:
>> * rebase to spi/for-next, see note below:
>>
>> There is currently no difference in drivers/dma/dmaengine.c between it and
>> dma/next [1], therefore PATCH 1/2 should be safe for Vinod to apply. But
>> this way PATCH 2/2 is trivial to apply. I didn't want to pull the whole
>> linux-next tree, but if any ofyou run into problems, let me know, and I'll
>> rebase the series on it instead.
> 
> I can't tell what the plan is here, or what the status is for the first
> patch (since I'm not CCed).  The second patch depends on a new API
> introduced in the first patch so it can't be merged independently.

Yes, the situation is a bit convoluted. Obviously 2/2 will be applied 
after 1/2, in a similar vein than the former PM series.

So what I was trying to say: Vinod should be able to apply 1/2 to his 
branch (dma/next) right now, which can then be merged to spi/for-next. 
This merged branch should be able to then cleanly apply 2/2.

Bence


