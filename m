Return-Path: <dmaengine+bounces-1306-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 039C2876028
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 09:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3516C1C228BE
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 08:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A42929CFB;
	Fri,  8 Mar 2024 08:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="of2pqqxZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CDB208AD;
	Fri,  8 Mar 2024 08:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887879; cv=none; b=SgpaxdbafI7kdjexLz1U8d21gdMgVEhKIsDjM49hETnH8h8X/KXYTqIuQRKmGJC5WokamvVGPMgX0VfxnxsuyfrqxNBI1lKJdmukgbLBmRs5rBTcCCItTviUhVV55AhzyWHxF2H9KkFLqglbB7wUBElLPDKYXwN/qntMHXL9f6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887879; c=relaxed/simple;
	bh=xa9S9gA+2Kdx0nRGP4a+OCGAFa+zMDo98VZV5Yh0Xcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HKb+gO2wUttVDRUw9fk4H82hWUAQP46Xa8E0J0+SuOCzBNpvKV1Ma6fqoRlKsDlmk7irfQd5WraM8TStUldavxX792ScmFEHOeQnp/Csj1hC44Vqu+w0m1dYwz2wq6EeBCd1+oZlf9S2tb/UMUXh2iW4hFIkBscH88VYa5Rffco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=of2pqqxZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=IPYOyNy9SYM4JNCOX10vMNStn8WkuVS6FnTRy1OZhq8=;
	t=1709887877; x=1710319877; b=of2pqqxZxl23woIulpy9kOTQsuDdqvWDpRW5oc0AXqzKULJ
	tXR3gQ6nPdgX0WIUcrFZ5n/RtE+pN5PEmy8RO2yuZgmFehjgqzjGYRjFy+y5vTaInSVwFLlzL8bFp
	cQhMnCDhJqp5jbx0vUM0dNeOpDT0oyPLJTIdIbYTOXV8xXb8CTeDvHE3KniTKUuCBiaRbKrOe5hBg
	ZDz7KhgCGMjf9j01af7OCtvAbiJjOCfqD+R26VayiX42juYJwjU6L2nQ9Af9NZuaNK/F9VC6Ww+Ju
	Dwk+DI84ZvUdiu/qwuCGOknJ7W7VpM4fo63vBkDFt2Vc6+QziMuBu9kj3egnFOsA==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1riVwf-0005on-QT; Fri, 08 Mar 2024 09:51:13 +0100
Message-ID: <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
Date: Fri, 8 Mar 2024 09:51:13 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: dmaengine: CPU stalls while loading bluetooth module
Content-Language: en-US, de-DE
To: "bumyong.lee" <bumyong.lee@samsung.com>,
 'karthikeyan' <karthikeyan@linumiz.com>, vkoul@kernel.org
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban@linumiz.com, saravanan@linumiz.com,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
 <1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
 <000001da6ecc$adb25420$0916fc60$@samsung.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
In-Reply-To: <000001da6ecc$adb25420$0916fc60$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709887877;4e0565a6;
X-HE-SMSGID: 1riVwf-0005on-QT

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 05.03.24 08:13, bumyong.lee wrote:
>> we have encountered CPU stalls in mainline kernel while loading the
>> bluetooth module. We have custom board based on rockchip rv1109 soc and
>> there is bluetooth chipset of relatek 8821cs. CPU is stalls  while realtek
>> 8821cs module.
>>
>> Bug/Regression:
>> In current mainline, we found CPU is stalls when we load bluetooth module.
>> git bisect shows commit 22a9d9585812440211b0b34a6bc02ade62314be4
>> as a bad, which produce CPU stalls.
>>
>> git show 22a9d9585812440211b0b34a6bc02ade62314be4
>> commit 22a9d9585812440211b0b34a6bc02ade62314be4
>> Author: Bumyong Lee <bumyong.lee@samsung.com>
>> Date:   Tue Dec 19 14:50:26 2023 +0900
>>
>>      dmaengine: pl330: issue_pending waits until WFP state
>>
> [...]
>>
>> By reverting this commit, we have success in loading of bluetooth module.
> 
>> Output of CPU stalls:
> [...]
> 
> I discussed this issue. Could you refer to this[1]?
> I haven't received anymore reply from him after that.
> If you have any more opinion, please let me know.
> [1]: https://lore.kernel.org/lkml/000001da3869$ca643fa0$5f2cbee0$@samsung.com/T/

Hmmm. 6.8 final is due. Is that something we can live with? Or would it
be a good idea to revert above commit for now and reapply it when
something better emerged? I doubt that the answer is "yes, let's do
that", but I have to ask.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: To be sure the issue doesn't fall through the cracks unnoticed,
I'm adding it to regzbot, the Linux kernel regression tracking bot:

#regzbot report /
#regzbot introduced 22a9d9585812440211b
#regzbot duplicate: https://lore.kernel.org/lkml/ZYhQ2-OnjDgoqjvt@wens.tw/
#regzbot title dmaengine: CPU stalls while loading bluetooth module
#regzbot ignore-activity

