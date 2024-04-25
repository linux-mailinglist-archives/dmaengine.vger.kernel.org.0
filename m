Return-Path: <dmaengine+bounces-1962-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8778B1EB1
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 12:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B5B11F21A2E
	for <lists+dmaengine@lfdr.de>; Thu, 25 Apr 2024 10:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740985299;
	Thu, 25 Apr 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JNNWiFzS"
X-Original-To: dmaengine@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F984FD4;
	Thu, 25 Apr 2024 10:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714039415; cv=none; b=orkwOKcsrokyKpy8Yzro31Ohem2iumxBeNsoVO1LSkHbd5s/VtRuNNNhUMDu0/0KNPuqbCwnpiuMP0DHGajsvPpv4IOnjukWtuVYxJQm63/XuVEHrsDWrwDS4oT5uRT56H6HSQ98xvt8V1HHCi+lefS3gW20pmgLEb97of3Ks1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714039415; c=relaxed/simple;
	bh=3od3E4ATLOrKZD5prvwpsh6Qsde2VjYJWAfb7KIiH7c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=oIqZLliu68HFhIy2/QvUI0XAJtIe/JVPsrtYuRHSEULxWBS0vIFsUZsEGA146jkzr58c6i0uimUjF5580vZ9Qeli239Qw2JIJvQZDws87WSspD8GMQkUxrLCWO96lQwzv+NILtUmeB9m7ZRLHvKL21sTzcyRsOkKxSahv6Oj6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JNNWiFzS; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=3od3E4ATLOrKZD5prvwpsh6Qsde2VjYJWAfb7KIiH7c=;
	t=1714039414; x=1714471414; b=JNNWiFzSmiKzurVIHRHTw2YW5RPNJCzuiWkn3S/fIKgeidd
	V7MmL9nH1+mv2gIgBHOarUE68zWdMkg5Fo/KDbcg24TKwNkp8HTIcXsTVFNxz2StwU5AMC+ye15/C
	17izzkt1hDaIlb4w6r5Xla+Tddz6pwrJXtCSLP3oxcvDz7Hw8PD9Rq4aMr53Ks2HVBEAKx/6PQhIc
	g5JCBTXw1ezAsUtTXsbysDvzR+n+Gh2mN87AibFlcqLZlAx+YCQfWEz8k1tgDqXXbMyB/WY3ViKyO
	leyEgw6PFUqC/Gqu2goVIWxVRfAGeM1T/Bq5NmH7W4PYXu48bQTSSgfHXbY+P5hw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rzvwx-0000MR-16; Thu, 25 Apr 2024 12:03:31 +0200
Message-ID: <0b5da67a-7482-4f18-9246-9c118f182b8b@leemhuis.info>
Date: Thu, 25 Apr 2024 12:03:29 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dmaengine: CPU stalls while loading bluetooth module
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Vinod Koul <vkoul@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban@linumiz.com, saravanan@linumiz.com,
 'karthikeyan' <karthikeyan@linumiz.com>,
 "bumyong.lee" <bumyong.lee@samsung.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
 <1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
 <000001da6ecc$adb25420$0916fc60$@samsung.com>
 <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
 <000001da7140$6a0f1570$3e2d4050$@samsung.com>
 <07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>
 <001001da7a60$78603130$69209390$@samsung.com>
 <9490757c-4d7c-4d8b-97e2-812a237f902b@leemhuis.info>
 <8734a80b-c7a9-4cc2-91c9-123b391d468c@leemhuis.info>
 <ZgUTbiL86_bg0ZkZ@matsya>
 <2b2a6c9f-4df2-4962-b926-09adccd20715@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <2b2a6c9f-4df2-4962-b926-09adccd20715@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714039414;7d5e5266;
X-HE-SMSGID: 1rzvwx-0000MR-16

On 28.03.24 16:06, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 28.03.24 07:51, Vinod Koul wrote:
>> On 26-03-24, 14:50, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>
>>> Vinod Koul, what's your option here? We have two reports about
>>> regressions caused by 22a9d958581244 ("dmaengine: pl330: issue_pending
>>> waits until WFP state") [v6.8-rc1] now:
>>>
>>> https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/
>>>
>>> https://lore.kernel.org/all/ZYhQ2-OnjDgoqjvt@wens.tw/
>>> [the first link points to the start of this thread]
>>>
>>> To me it sounds like this is a change that better should be reverted,
>>> but you are of course the better judge here.
>>
>> Sure I have reverted this,
>
> Thx!

That revert afaics has not made it to Linus yet. Is that intentional, or
did it just fell through the cracks?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

