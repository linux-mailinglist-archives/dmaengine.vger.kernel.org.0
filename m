Return-Path: <dmaengine+bounces-4773-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA48A6EB7A
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 09:26:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DC17A2F44
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 08:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8A219F111;
	Tue, 25 Mar 2025 08:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="jZUKmodv"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E34A77104;
	Tue, 25 Mar 2025 08:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891195; cv=none; b=j1hliBWFRYv1Wr813EjYFzljJYfgqHksr6Z0/i+nlJZxyItKb3fN5Z6UNdtdc6mhI6K1wyXVujdNGJ/Qb7qv7KHVadQAV1CV4Ww5uBWTlRs0/DABh4Mj0yW42Jh3cF5vw2KD2J2FI6+01wbb0+TcV3UW9s1xe/B2Et9vOCeII1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891195; c=relaxed/simple;
	bh=XJBOQX68Wiw/xxf+8cp4P0AZ+h1LmW7Aor9NhCYN/9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YBARjUwcFlj0K+ft253s8WUauXDD0ej+A5DJf29LpP/qYKHhoGOfi9hUzoJaOL+H83ixdDoEjzrksB24iYnXu0w5pn7bv+9RuvDqFIGVgyC70iMQO062KvFyE4SRkCkb3P0lTN/3tD82U1RaVNcmqEV2mkwKTvpE6ZCOUE45vh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=jZUKmodv; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 0C49DA05E5;
	Tue, 25 Mar 2025 09:26:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=75jo1ATccOc9aW+qm12j
	P+zYXFT30Ic6m1MzSKkACUs=; b=jZUKmodvzicP1rFtYuKNCAsnMD9y5KhV2RWA
	A0Hdk6Xh1SNDGR9j833aE3fn5qvp5KTSRyq9kduSs6hkkOG0VGeSGR+9GYDDHsRB
	zXD11Jy5KL6OdkoLNM+zbaOf3fQWeLhl0Id9z5qAHmzrV3pNf1/u3/UKWB91qnYS
	zZ2JxbtglXa6AE5ft61G0s+iaT/r5O9gksUgJDd1zmVUmlrtJQStJoMPchM3P2UQ
	MX0MY6dPIKBz4KLxhOdbbOtnv7YcWIWcrwtui/b1PVzlyl/4V6dBO+foin1gms7A
	ovsEsy2knhaYR+WNlgq7BIIhLLyd4O7f5NI3ITer3K+zaBUMpE4c8ieX7ArB34gO
	Gm7PkO2mV7Qr3vSjeYZ5Y8bT35Wobf925bkmhbbuB9jn62iWeDK2KmN2UJ/Fgi0k
	7reWmRN1+txMo2SebooxkNw1Lsq6HPwphSo6OwGjCV2LJ2Ov5fCTDvW8lEoPqQsB
	teHJgkXPRhVZLt0l3iXvgnXMXGudpTKra4gPIGnKpbkqclDoEyETK8wRz4PjJXdR
	uyJCnTme+8/hUwJ5Qu5JGiWN8KyqI42jQObZ4dljCLNfFrE/bWjGZj96MVs4NTCb
	EkN5E+4646eXwMJEK6gvT7nTd08MVVnrgN0cl1Ew8qtvolRk5ccIkn/bLhxsq7wO
	T5AFAeA=
Message-ID: <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
Date: Tue, 25 Mar 2025 09:26:28 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] dma-engine: sun4i: Simplify error handling in probe()
To: Markus Elfring <Markus.Elfring@web.de>, <dmaengine@vger.kernel.org>,
	<linux-sunxi@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>
CC: LKML <linux-kernel@vger.kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>, Christophe Jaillet
	<christophe.jaillet@wanadoo.fr>, Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, Vinod Koul <vkoul@kernel.org>
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
 <92772f63-52c9-4979-9b60-37c8320ca009@web.de>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <92772f63-52c9-4979-9b60-37c8320ca009@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526D7C6A

Hi,

On 2025. 03. 24. 18:55, Markus Elfring wrote:
>> Clean up error handling by using devm functions and dev_err_probe().
> …
> 
> Do any contributors care for a different patch granularity?
> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14#n81

I still don't understand why you are so adamant on this. It is just a 
simple refactor patch changing 33 lines, mostly in one function, with no 
logic change. Does it break something in your system? Please explain 
yourself so we can understand your viewpoint better.

> Will it be clearer to mention also the function name “sun4i_dma_probe”
> in the summary phrases?


I already added it as per your last response, did you not read the message?

On 2025. 03. 24. 18:20, Bence Csókás wrote:
 > Clean up error handling by using devm functions and dev_err_probe(). This
 > should make it easier to add new code, as we can eliminate the "goto
 > ladder" in sun4i_dma_probe().

Bence


