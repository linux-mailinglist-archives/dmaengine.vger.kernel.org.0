Return-Path: <dmaengine+bounces-1514-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AD88C41B
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 14:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC0531C3F089
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 13:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9403A4EB37;
	Tue, 26 Mar 2024 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="ZHynT0rv"
X-Original-To: dmaengine@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C405182A3;
	Tue, 26 Mar 2024 13:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711461017; cv=none; b=RD5qOCesad4ax4Dqi4S5x7z4VkPEcZHAHWM8uHMgva1D+jZZ8px3Fn+Kgta8NJRuF41krq9+30mPdhWvwKerei+nTkY7ftL8sf0DPhJyu8wJABQ/KdURnuTqCcJTi502wn+QYFgLGRFaX5GnKafXWLLV0y8MDFUHevGw6rXO87Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711461017; c=relaxed/simple;
	bh=ge9l/Gwc3AxYtcSsPMc+z1dOFILly49XM8PZgooU2WM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y0XUCqfVYp6gQfyfrzXCDNXXBjfvElqF0SP43s96YOIJLM69XfpVHOOcQTfxa05XXO+N/BI7+i9gN/SexRS51Q787gPsGe8EZ1zzNlhQAeYAyoaYfzIbktfUzhnkuk9/GwS4y81lwPxYewkmTnCdbQZN5V7Cb08QhYLzu+vMScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=ZHynT0rv; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Reply-To:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=42Ec/7rrOkb0s10VDIHJ7GTucWOmYS68hh6j9o0Neio=;
	t=1711461015; x=1711893015; b=ZHynT0rvvMp2iCCb9ldJ5pRPHY7yKvOU2jYRS+XrzZX39b7
	KfT+NkSz/HRTZtcKISuA4qKuCuw5iKPlizxYWPndZjP4cxAJ39VVrh2+SZ3TTbikHOVfUIByH2WG/
	fjRzSDFhI9BPhl5i9ENXHcbcRFUh7LHg3UjM0M0lvOiR5qskJQyC9BgU+M4/qztpQTtY/NRRuyPtK
	XC+ThhiT7WHVorQ0a59wjET1Eaq2VVrzfQUDLgoyv0FuMtw4XrpGJUk0HMnUVH/ZsVTpzyTm8beWS
	qW5ple9+9k4oQIBvuZps1qeq+veh6uc1b6cna0OvRUuAVLJr3ddVai3ejKvk7+Yw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rp7Bl-0003I9-VQ; Tue, 26 Mar 2024 14:50:06 +0100
Message-ID: <8734a80b-c7a9-4cc2-91c9-123b391d468c@leemhuis.info>
Date: Tue, 26 Mar 2024 14:50:05 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dmaengine: CPU stalls while loading bluetooth module
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
To: vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban@linumiz.com, saravanan@linumiz.com,
 'karthikeyan' <karthikeyan@linumiz.com>,
 "bumyong.lee" <bumyong.lee@samsung.com>,
 'Linux regressions mailing list' <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
 <1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
 <000001da6ecc$adb25420$0916fc60$@samsung.com>
 <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
 <000001da7140$6a0f1570$3e2d4050$@samsung.com>
 <07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>
 <001001da7a60$78603130$69209390$@samsung.com>
 <9490757c-4d7c-4d8b-97e2-812a237f902b@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <9490757c-4d7c-4d8b-97e2-812a237f902b@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711461015;a078b924;
X-HE-SMSGID: 1rp7Bl-0003I9-VQ

Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
for once, to make this easily accessible to everyone.

Vinod Koul, what's your option here? We have two reports about
regressions caused by 22a9d958581244 ("dmaengine: pl330: issue_pending
waits until WFP state") [v6.8-rc1] now:

https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/

https://lore.kernel.org/all/ZYhQ2-OnjDgoqjvt@wens.tw/
[the first link points to the start of this thread]

To me it sounds like this is a change that better should be reverted,
but you are of course the better judge here.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

On 20.03.24 07:28, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 20.03.24 01:49, bumyong.lee wrote:
>>>>> Hmmm. 6.8 final is due. Is that something we can live with? Or would
>>>>> it be a good idea to revert above commit for now and reapply it when
>>>>> something better emerged? I doubt that the answer is "yes, let's do
>>>>> that", but I have to ask.
>>>>
>>>> I couldn't find better way now.
>>>> I think it's better to follow you mentioned
>>>
>>> 6.8 is out, but that issue afaics was not resolved, so allow me to ask:
>>> did "submit a revert" fell through the cracks or is there some other
>>> solution in the works? Or am I missing something?
>>
>> "submit a revert" would fix the issue. but it would make another issue
>> that the errata[1] 719340 described.
> 
> "Make" as it "that other issue was present before the culprit was
> applied"? Then that other issue does not matter due to the "no
> regression" rule and how Linus afaics wants to see it applied in
> practice. For details on the latter, see the quotes from him here:
> https://docs.kernel.org/process/handling-regressions.html
>  Hence please submit a revert (or tell me if I misunderstood something)
> -- or of course a workaround for the other issue that does not cause the
> regression people reported.
> 
>> [...]
>> [1]: https://developer.arm.com/documentation/genc008428/latest
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> 
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

