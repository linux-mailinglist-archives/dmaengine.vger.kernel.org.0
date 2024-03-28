Return-Path: <dmaengine+bounces-1621-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1038B8902A1
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 16:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8D8294207
	for <lists+dmaengine@lfdr.de>; Thu, 28 Mar 2024 15:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B8128383;
	Thu, 28 Mar 2024 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="zC7qQt9D"
X-Original-To: dmaengine@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E027E772;
	Thu, 28 Mar 2024 15:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638401; cv=none; b=AEL81ssOhYVARd3aFOjQtgS+mdwAgrJmdSVCH7eXMoknmde9Al0hINXKcXosnGrdYLqvn5nCK5mY5Dd0fy7DJaI1xY4qZqHP17Ykc1BQikv8hazYDKoB+Ebg/eLv0z73IOYq5lfGb5osC1uxJcQOI5JETAw52X923R2fZPLdG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638401; c=relaxed/simple;
	bh=tFIN/tKvxw1OPQyXxVyqG9hoRwQxc5PdtvaAaSxuREw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWVDhbofI225QAXVabZ1oANOmpnqtoT3abQ879zxsamtD5LqulobpDGmc+Jk2owD2UxrflM6nQB6z03da+q3t2N+uDcYzBRQwtqwKPzi04V+KHkHl/9sG8CunffSGiQde12d3qFgPeTthvrvOaLK2H5BPpAXfNuDA6tQ537rHVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=zC7qQt9D; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=HlX7rSDT+xTTJ0yT83bN1/Fuwujcx7/ZH4CK3LA5S8Q=;
	t=1711638399; x=1712070399; b=zC7qQt9DAfcLxsoFIpmLF77yysU10TQLtSicYa2HvaoHOcJ
	hdXNT7O+di3Sa7THW+G6YXui+N8Aao61AREokP3BThG3I0JZLO6VPFQyzIIFUTCLeZB6VmsbmwWJY
	a2+8NXyzcLKoQJjLSxjgbAmF03x7ZfJowBstutquIO86/Vizv7xE30QIuJu3PFJ+RR5SbB514yQpg
	gLvlnQJRolohgeUq4IvLbaaJ7ghUBQ3P+A5PfOGWeYtQ0uJs7UPHHRBlxSj1+nvE3kI1kqAieT3F1
	LRFT8pnkz0PmtOiTLjslBaGdnNOUQksRXtYJTtWWlIlHoN0DrYmKKKqOfSemImPw==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rprKn-0000Xu-B6; Thu, 28 Mar 2024 16:06:29 +0100
Message-ID: <2b2a6c9f-4df2-4962-b926-09adccd20715@leemhuis.info>
Date: Thu, 28 Mar 2024 16:06:28 +0100
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
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <ZgUTbiL86_bg0ZkZ@matsya>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1711638399;3bbc3f2a;
X-HE-SMSGID: 1rprKn-0000Xu-B6

On 28.03.24 07:51, Vinod Koul wrote:
> On 26-03-24, 14:50, Linux regression tracking (Thorsten Leemhuis) wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
>> for once, to make this easily accessible to everyone.
>>
>> Vinod Koul, what's your option here? We have two reports about
>> regressions caused by 22a9d958581244 ("dmaengine: pl330: issue_pending
>> waits until WFP state") [v6.8-rc1] now:
>>
>> https://lore.kernel.org/lkml/1553a526-6f28-4a68-88a8-f35bd22d9894@linumiz.com/
>>
>> https://lore.kernel.org/all/ZYhQ2-OnjDgoqjvt@wens.tw/
>> [the first link points to the start of this thread]
>>
>> To me it sounds like this is a change that better should be reverted,
>> but you are of course the better judge here.
> 
> Sure I have reverted this,

Thx!

> so original issue exist as is now...

Yeah, that's a downside, but that's afaik how Linus wants these
situations to be handled. Hopefully it will motivate someone to fix the
original issue without causing a regression.

Thx again! Ciao, Thorsten

P.S.:

#regzbot fix: dmaengine: Revert "dmaengine: pl330: issue_pending waits
until WFP state"

(that's
https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git/commit/?h=fixes&id=afc89870ea677bd5a44516eb981f7a259b74280c
currently)

