Return-Path: <dmaengine+bounces-1451-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D81E880B36
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 07:28:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9186283836
	for <lists+dmaengine@lfdr.de>; Wed, 20 Mar 2024 06:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F330918659;
	Wed, 20 Mar 2024 06:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="X4dOTilF"
X-Original-To: dmaengine@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950811864A;
	Wed, 20 Mar 2024 06:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710916108; cv=none; b=rqG+VqjA5Z4BRMgWJ0K3Dgy8HdqZ/Jb2A4gJkZpeplihOW2lJdHQFHnC1RjwpBmCZjOvcAx/NXczEnbJVjeBgICc35SPR/ble4uk7hzT879MMO4WMQouUwJr9y/eCk71O8pwS7aaL4YBmzLhn+69tBddgc22alJ5gIF2qkCfa3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710916108; c=relaxed/simple;
	bh=NHf4lcNnbKil3Xd3j0ggC1F+MXxx5165hkG+xD5RsMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p5Ht/pG3qeXQB4U/cVPXRGO+yLi5M2Zf4a7QSYIU2h+vX4f7HARGuTSGkK/xrOc/IrYgeOZvHycHlKGbTiiCLK9VoeauwV54TsfOzagWj37RraaUp7WekuVbwcCpH+VDjCnm8sb4j3hQvI3uEgpWHz1lVnVhkwkE+GE6Rt20F/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=X4dOTilF; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=+uvbFMBaxnEo7FnlRK2VWajdBLpdj74HCBLMlUuMnzs=;
	t=1710916106; x=1711348106; b=X4dOTilFLlgayLWWCqi/gx7N9s7/xqE38i/e7uH+77VYwTK
	sgdY/JzK4jlAtJJpHxb+AAQiUjenqEhjEzl5AbkbX1Fd07fhCM9wQKWJ0mghctqnypInTb6ZAanDI
	CtrW5tWGXlT7d9mjqwRzN9HLQBHoH3Q0bPB1LW2eI6atPosLTY/9XkA78EC4y+AFnyUuSZGZq4F5Z
	Z2XIkkOEhRMFf9w/fyi9ar7hZMiAWOJittvQCjjOOYg8lVzeC50ZjsfsEppvWwB2SRCRbPOANc0ti
	PCCoG41xuhBFbUyggeTfpKr0gvy/SVww8reMFcXhWLrUsYw6xfJlQu43nKQOp6Lg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rmpR0-0007mH-ND; Wed, 20 Mar 2024 07:28:22 +0100
Message-ID: <9490757c-4d7c-4d8b-97e2-812a237f902b@leemhuis.info>
Date: Wed, 20 Mar 2024 07:28:22 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dmaengine: CPU stalls while loading bluetooth module
Content-Language: en-US, de-DE
To: "bumyong.lee" <bumyong.lee@samsung.com>,
 'Linux regressions mailing list' <regressions@lists.linux.dev>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban@linumiz.com, saravanan@linumiz.com,
 'karthikeyan' <karthikeyan@linumiz.com>, vkoul@kernel.org
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
 <1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
 <000001da6ecc$adb25420$0916fc60$@samsung.com>
 <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
 <000001da7140$6a0f1570$3e2d4050$@samsung.com>
 <07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>
 <001001da7a60$78603130$69209390$@samsung.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <001001da7a60$78603130$69209390$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710916106;93568396;
X-HE-SMSGID: 1rmpR0-0007mH-ND

On 20.03.24 01:49, bumyong.lee wrote:
>>>> Hmmm. 6.8 final is due. Is that something we can live with? Or would
>>>> it be a good idea to revert above commit for now and reapply it when
>>>> something better emerged? I doubt that the answer is "yes, let's do
>>>> that", but I have to ask.
>>>
>>> I couldn't find better way now.
>>> I think it's better to follow you mentioned
>>
>> 6.8 is out, but that issue afaics was not resolved, so allow me to ask:
>> did "submit a revert" fell through the cracks or is there some other
>> solution in the works? Or am I missing something?
> 
> "submit a revert" would fix the issue. but it would make another issue
> that the errata[1] 719340 described.

"Make" as it "that other issue was present before the culprit was
applied"? Then that other issue does not matter due to the "no
regression" rule and how Linus afaics wants to see it applied in
practice. For details on the latter, see the quotes from him here:
https://docs.kernel.org/process/handling-regressions.html
 Hence please submit a revert (or tell me if I misunderstood something)
-- or of course a workaround for the other issue that does not cause the
regression people reported.

> [...]
> [1]: https://developer.arm.com/documentation/genc008428/latest

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

