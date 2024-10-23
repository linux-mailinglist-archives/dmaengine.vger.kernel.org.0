Return-Path: <dmaengine+bounces-3430-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352029AC76D
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 12:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49F6282D5B
	for <lists+dmaengine@lfdr.de>; Wed, 23 Oct 2024 10:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615A719E97E;
	Wed, 23 Oct 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="Umr0psrm"
X-Original-To: dmaengine@vger.kernel.org
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1480319E99E;
	Wed, 23 Oct 2024 10:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729678231; cv=none; b=Q1T5+wMUKuVxz4c9YeqcbEfgXsOl1bc3fR690nqMtWYgVb1a2IQ8ZYiLUaU7eeL3scFUbZbOQ/piKxPlvNKawJaKwF2WtX1t6lz68G5E5k7TMMsbtGwg4BVyAR+npPSmq6HPlhoC2YTUlbsJtj9Zl65YgZjwHgGUZ3lnOhas/LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729678231; c=relaxed/simple;
	bh=k3SnHG7oA3l5HZSfi1tB7TiZdo9WbfAs0mivdJqWgUA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ClprA59Dm1ZXxkrQs5niJ6O8VPNoYP7rWjihtgazvzI7U0o20z0rq6jWyflUEzO8nSwnAVxB0ZYyJk+1oDWQKAoVH7gyf8hIxKibxV1nY5GUwPTlVgnHZshFMsuECqF7KP1/Ep29HPC9Z4ZKKYBqpSLG07BIEH1BlzBLFlhZAOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io; spf=pass smtp.mailfrom=aosc.io; dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b=Umr0psrm; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aosc.io
Received: from relay4.mymailcheap.com (relay4.mymailcheap.com [137.74.80.154])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 5BD4F20056;
	Wed, 23 Oct 2024 10:10:27 +0000 (UTC)
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay4.mymailcheap.com (Postfix) with ESMTPS id 4D9932031B;
	Wed, 23 Oct 2024 10:10:17 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id 50CB940071;
	Wed, 23 Oct 2024 10:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=aosc.io; s=default;
	t=1729678215; bh=k3SnHG7oA3l5HZSfi1tB7TiZdo9WbfAs0mivdJqWgUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Umr0psrmam/LzPClkicD6UONSbNtPFt2zd+HnRZ33WMqljjb/ERG1gQxqLuL/UALX
	 zG1oHfQPfJpGIvCVJirzaft9phPUwh2VWYIbowP8RGXfcifTkvUpdgW1qijU76cBPO
	 SNrwEqnmTJd/9tabIqPFGhObkbafmG+vYJZEA7po=
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id AAADC411E7;
	Wed, 23 Oct 2024 10:10:14 +0000 (UTC)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 18:10:14 +0800
From: Mingcong Bai <jeffbai@aosc.io>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: WangYuli <wangyuli@uniontech.com>, gregkh@linuxfoundation.org,
 patches@lists.linux.dev, nikita@trvn.ru, ink@jurassic.park.msu.ru,
 shc_work@mail.ru, richard.henderson@linaro.org, mattst88@gmail.com,
 linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 fancer.lancer@gmail.com, linux-hwmon@vger.kernel.org,
 dmaengine@vger.kernel.org, xeb@mail.ru, netdev@vger.kernel.org,
 s.shtylyov@omp.ru, linux-ide@vger.kernel.org, serjk@netup.ru,
 aospan@netup.ru, linux-media@vger.kernel.org, ddrokosov@sberdevices.ru,
 linux-iio@vger.kernel.org, v.georgiev@metrotek.ru,
 linux-mips@vger.kernel.org, ntb@lists.linux.dev,
 linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-spi@vger.kernel.org, dushistov@mail.ru,
 manivannan.sadhasivam@linaro.org, conor.dooley@microchip.com,
 linux-fpga@vger.kernel.org, tsbogend@alpha.franken.de,
 hoan@os.amperecomputing.com, geert@linux-m68k.org,
 wsa+renesas@sang-engineering.com
Subject: Re: [PATCH] MAINTAINERS: Remove some entries due to various
 compliance requirements.
In-Reply-To: <418359de-e084-47f9-9090-7980e41661e0@flygoat.com>
References: <2024101835-tiptop-blip-09ed@gregkh>
 <A74519B4332040FA+20241023063058.223139-1-wangyuli@uniontech.com>
 <a08dc31ab773604d8f206ba005dc4c7a@aosc.io>
 <444fa53bdfdee75522a1af41655a99b0@aosc.io>
 <418359de-e084-47f9-9090-7980e41661e0@flygoat.com>
Message-ID: <5d8614084599ff1b7f70aa1b427bdfb3@aosc.io>
X-Sender: jeffbai@aosc.io
Organization: Anthon Open Source Community
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Queue-Id: 50CB940071
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 10.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_GOOD(-0.10)[text/plain];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ONE(0.00)[1];
	RCPT_COUNT_TWELVE(0.00)[37];
	TAGGED_RCPT(0.00)[renesas];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,mail.ru];
	FREEMAIL_CC(0.00)[uniontech.com,linuxfoundation.org,lists.linux.dev,trvn.ru,jurassic.park.msu.ru,mail.ru,linaro.org,gmail.com,vger.kernel.org,lists.infradead.org,omp.ru,netup.ru,sberdevices.ru,metrotek.ru,microchip.com,alpha.franken.de,os.amperecomputing.com,linux-m68k.org,sang-engineering.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[]

Greetings again (oops),

I messed up the reference levels when I sent my disclosure. Jiaxun got 
most of the references right but the last sentence.

在 2024-10-23 17:53，Jiaxun Yang 写道：
> On 2024/10/23 09:26, Mingcong Bai wrote:
>> No, no, no. Nuh, uh.
>> 
>> Greg has unfortunately decided to respond in private over a matter 
>> that by no means should be glossed over. Here below is our 
>> conversation:
> 
> I can't believe a senior maintainer is breaking our agreed netiquette 
> [1], but that's happening.
> 
>> 在 2024-10-23 15:55，Greg KH 写道：
> [...]
>> 
>> Request declined. Your response is now public knowledge (and hey, if 
>> this is not by your will, my apologies). Again, this matter requires 
>> public response.
>> 
>>> 在 2024-10-23 14:30，WangYuli 写道： Although this commit has been merged, 
>>> it's still important to know the
>>> specific reason (or even an example) that triggered this change for
>>> everyone here, right?
>>> 
>>> And those maintainers who have been removed should be notified.
>>> Seconded.
>> 
>> Sorry, but that's not how this is allowed to work.  Please contact 
>> your
>> company lawyers if you have any questions about this.  And this only
>> affects maintainers, as you aren't listed in the MAINTAINERS file, 
>> there
>> should not be any issue, but again, contact your company if you have 
>> any
>> questions as they know what is going on.
> 
> I think there are no regulations on earth preventing itself from being 
> referenced.
> Even if the regulation prevents further communication with affected 
> bodies,
> the wider community still deserves an explanation.
> 
> As a person with M entries I found this behavior appalling. It shakes 
> mutual
> trust between maintainers, as we all assumed that patches being applied 
> are
> well scrutinized.
> 
> Besides, many of us are working on kernel as hobbyist  in a personal 
> capacity.
> That means we don't have access to lawyers, especially US one. While I 
> understand
> corporate participants may be the majority of the community, please 
> don't leave
> hobbyists behind!
> 
> I've had some interactions with some of people being removed here, and 
> I would
> say they are all brilliant individuals. It's  really sad to see them 
> being turned away :-(
> 
>> 
>> Just *wink* if you were compelled into this.
> ^ It sounds unprofessional to me.

For the record, I wrote that unprofessional sentence ("Just *wink*"), 
since it was private.

Best Regards,
Mingcong Bai

> 
> Thanks
> - Jiaxun
> 
> [1]: https://people.kernel.org/tglx/notes-about-netiquette-qw89
>> 
>>> thanks,
>>> 
>>> greg k-h
>> 
>> Best Regards,
>> Mingcong Bai
>> 

