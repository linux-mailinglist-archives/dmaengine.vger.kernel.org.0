Return-Path: <dmaengine+bounces-1445-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D86E687FA4E
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162DD1C21B9A
	for <lists+dmaengine@lfdr.de>; Tue, 19 Mar 2024 09:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01227CF0F;
	Tue, 19 Mar 2024 09:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="1dKghYCC"
X-Original-To: dmaengine@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8147C6C0;
	Tue, 19 Mar 2024 09:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710839228; cv=none; b=LSs+1eAOcclWJ+WVSq+hw1Q18syLbwU9/hz451rfgdO54j83weuceM3Yc8uHRg1QRqJsEykJTMmHnuMf5SR8LMOCxLO6uUIdM272rQUMSjwjlVAfQDUsb+RWZAamxEgNfbETeKAKsL/Bgxkld+rpn1aR+HXHUQBkpixia3K2ENU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710839228; c=relaxed/simple;
	bh=2Y/b4m71YtOxGVZHdyOIhqXQXwQS/87eE2O8y1ODX2I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bQZKOJZ9rZm6BJ0yugrWNHp5A4VWdY7LTp24L8cFMLO7xeNCOO0WNsc0GCYY6OOnHmGZWoUGDNFg4Sl9bJrfftTdq+D/oFYOzRwQf1e7Fu7uu4yYEKZFXIO3mkic8jQpV80GifKvs8Qdy/50HGoyQjH6vNHFDYx08JehxJnXpL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=1dKghYCC; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=1mmeAtxPsqXAAJIIP58R7GsVBAFDYCW1BxUcEz2Evog=;
	t=1710839226; x=1711271226; b=1dKghYCCGSGFFVq+Mx7NmUHBze13jgZydGNPeoDjY9/vRsq
	Zote2rnY9ZaUsdhC2rQHdh6p7g6NHYFoGaODe7TwVI7JPdUEymCX3PDc4kPV8cKRfjfWuyjJfhhmH
	64GV7I2o9CeSsgdnLPfTIbUWmoENseUo05e3mLqWTvZbGZ5Jli52s+3yDhUiUb6tFwgJTUCSOA8LM
	lWZGB6nQ4M7l4YK1Dr4rNzViC9O70SDj9BENPkxUkZigBy3/dprS3+MmPUuQglP5o5/lWOjpUnEey
	rZS4sEBeDNnUODi1ZlgRCzeueKtanFwMq4GmHD8dDf7sh01m+Sqk0Ohj5a9eu4Gg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rmVR2-0004aI-9H; Tue, 19 Mar 2024 10:07:04 +0100
Message-ID: <07b0c5f6-1fe2-474e-a312-5eb85a14a5c8@leemhuis.info>
Date: Tue, 19 Mar 2024 10:07:03 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dmaengine: CPU stalls while loading bluetooth module
Content-Language: en-US, de-DE
To: "bumyong.lee" <bumyong.lee@samsung.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
 parthiban@linumiz.com, saravanan@linumiz.com,
 'karthikeyan' <karthikeyan@linumiz.com>, vkoul@kernel.org,
 'Linux regressions mailing list' <regressions@lists.linux.dev>
References: <CGME20240305062038epcas2p143c5e1e725d8a934b0208266a2f78ccb@epcas2p1.samsung.com>
 <1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com>
 <000001da6ecc$adb25420$0916fc60$@samsung.com>
 <12de921e-ae42-4eb3-a61a-dadc6cd640b8@leemhuis.info>
 <000001da7140$6a0f1570$3e2d4050$@samsung.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <000001da7140$6a0f1570$3e2d4050$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1710839226;71d58032;
X-HE-SMSGID: 1rmVR2-0004aI-9H

On 08.03.24 11:07, bumyong.lee wrote:
> 
>> Hmmm. 6.8 final is due. Is that something we can live with? Or would it be
>> a good idea to revert above commit for now and reapply it when something
>> better emerged? I doubt that the answer is "yes, let's do that", but I
>> have to ask.
> 
> I couldn't find better way now.
> I think it's better to follow you mentioned

6.8 is out, but that issue afaics was not resolved, so allow me to ask:
did "submit a revert" fell through the cracks or is there some other
solution in the works? Or am I missing something?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

