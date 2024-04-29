Return-Path: <dmaengine+bounces-1969-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDDC8B5065
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 06:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3281C21C0E
	for <lists+dmaengine@lfdr.de>; Mon, 29 Apr 2024 04:58:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC3C8E2;
	Mon, 29 Apr 2024 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="l1X1KYAj"
X-Original-To: dmaengine@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7708C147;
	Mon, 29 Apr 2024 04:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714366687; cv=none; b=skDkVBjyrn1MhcxrIdMm7a6axGx7s82kaERN9yHVcnOOm665N9BLAqwEuo2Qn5EfsX6fiWaOtexrPmF0YB36kfz9F3hPxTzQphb93NwWh25Cd+hOmkfTo7HNeRAXpUvMtOTeq5w+KrUw3YkrTEm9+qxhgUxTWvNNsvBoe0RJdVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714366687; c=relaxed/simple;
	bh=qwcuk2Zn9wJiQ5C9erBrZYZVUIhDBacnXUKFMj5UQys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4vC+tjkNLUOGzNVzsrc5dmf8yqIFdNB628OJBKG9oLg2Dz+KnHMCHKEg8jK1OGYM8p7WVGroNgICW7X4r9ftcm44OAf/zIYKXphRNWj0a7/qRmA73x5gzN9e5MPrxKDTxR58aDowVw0gj7NZcCjzVZUDMJOvP3IznpLqA5et2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=l1X1KYAj; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=aEXLd2DIoVZCU2/LTfjWm3bDpRi/ps0F+k24Tiuwso4=;
	t=1714366684; x=1714798684; b=l1X1KYAj3nijO4T9Haji3btSbw+4RsP5Kp6alHfkWeZs0qq
	hVeVjDHenxu5wFmMrtkXU3Zx2smquk/7pbuLBGk5XhxfMGreHl9UHrZ0EcvT4cbFprBhxXlbOxVP7
	JYJ6UDRDHB2bkUHhVoFIfnWUEU+Hj6n0Yg8NtFvLweDgnE3IftHebMzic7xzFseDD2jPorUb6kjvP
	KNiMmjvBLGWQtkSPGkQhnJSe3mjd5x60VqrG2JRRvcTuk5DiiwDgNBuJh2+nydDGjaHBMK0Dlmq6w
	eGxfNCFHH9mqbCzwmiTiJLh/1sSt7rvQV82hyrf98RUzUn+lTWT2kljFy6b3EXag==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1s1J5V-0000ES-35; Mon, 29 Apr 2024 06:58:01 +0200
Message-ID: <56bb312e-5dca-4005-a388-c039646a9fa4@leemhuis.info>
Date: Mon, 29 Apr 2024 06:58:00 +0200
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dmaengine: CPU stalls while loading bluetooth module
To: Vinod Koul <vkoul@kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban@linumiz.com, saravanan@linumiz.com,
 'karthikeyan' <karthikeyan@linumiz.com>,
 "bumyong.lee" <bumyong.lee@samsung.com>
References: <000001da6ecc$adb25420$0916fc60$@samsung.com>
 <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
 <000001da7140$6a0f1570$3e2d4050$@samsung.com>
 <07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>
 <001001da7a60$78603130$69209390$@samsung.com>
 <9490757c-4d7c-4d8b-97e2-812a237f902b@leemhuis.info>
 <8734a80b-c7a9-4cc2-91c9-123b391d468c@leemhuis.info>
 <ZgUTbiL86_bg0ZkZ@matsya>
 <2b2a6c9f-4df2-4962-b926-09adccd20715@leemhuis.info>
 <0b5da67a-7482-4f18-9246-9c118f182b8b@leemhuis.info>
 <Zi8mzMWubkfi9UiV@matsya>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <Zi8mzMWubkfi9UiV@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1714366684;5fe217de;
X-HE-SMSGID: 1s1J5V-0000ES-35

On 29.04.24 06:49, Vinod Koul wrote:
> On 25-04-24, 12:03, Thorsten Leemhuis wrote:
>> On 28.03.24 16:06, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 28.03.24 07:51, Vinod Koul wrote:
>>>> On 26-03-24, 14:50, Linux regression tracking (Thorsten Leemhuis) wrote:
>>>>>
>>>>> Vinod Koul, what's your option here? We have two reports about
>>>>> regressions caused by 22a9d958581244 ("dmaengine: pl330: issue_pending
>>>>> waits until WFP state") [v6.8-rc1] now:
>>>>>
>>>>> https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/
>>>>>
>>>>> https://lore.kernel.org/all/ZYhQ2-OnjDgoqjvt@wens.tw/
>>>>> [the first link points to the start of this thread]
>>>>>
>>>>> To me it sounds like this is a change that better should be reverted,
>>>>> but you are of course the better judge here.
>>>>
>>>> Sure I have reverted this,
>>>
>>> Thx!
>>
>> That revert afaics has not made it to Linus yet. Is that intentional, or
>> did it just fell through the cracks?
> 
> Nope, it was sent to Linus last week and is now in -rc6...

Yeah, I noticed yesterday, as I otherwise would have mentioned it to
Linus. But it wasn't merged yet when I wrote the quoted mail. ;-)

Thx again!

Ciao, Thorsten


