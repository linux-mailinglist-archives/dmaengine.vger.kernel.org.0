Return-Path: <dmaengine+bounces-10266-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Jgz3HuKj/Gl2SQAAu9opvQ
	(envelope-from <dmaengine+bounces-10266-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 16:38:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B96294EA51B
	for <lists+dmaengine@lfdr.de>; Thu, 07 May 2026 16:38:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E77B7304C636
	for <lists+dmaengine@lfdr.de>; Thu,  7 May 2026 14:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07249402B95;
	Thu,  7 May 2026 14:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeFNGBs/"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D705D3F9F39;
	Thu,  7 May 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164425; cv=none; b=brYe4LiWd/U2F1ItpqCZPB/Z7CfgkhZwDMUcEeHI7a3d4yPMLZ5KS63B/28fcQVgFwaa60lufE6tjBBOrArlz0f8OvJwktttnKF3eG37Z1c52x1PReUScV6y3h/+GYlf8m4Ocw9i0phXM5iBaIbvFR7bOgPR0MtGn5Jx9qtbmxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164425; c=relaxed/simple;
	bh=4h47Z6ML2wUmiSm067qKXqglBqLvg1eK31qkZ+Ft+/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLraz6HGOtkUgUaTZi8trw/E0xoKRAKk9TDyk+Sw+ZL6UyFJ/Z6Q6VCkSWcddDLZgcl2S55EA66D/NBAF1dvdHIak8UZl7V/iddvdUjgB1OW2QnxWZoqPCcBuGFbmfO9Ve48Ahbjd26gcoZEFiTdn8vX4+4FmshehzK7pfMRrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeFNGBs/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D63C2BCB2;
	Thu,  7 May 2026 14:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778164425;
	bh=4h47Z6ML2wUmiSm067qKXqglBqLvg1eK31qkZ+Ft+/M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oeFNGBs/orp6cCxb0HHNCkON/3uF18AuQK/w23afJiRNnQJzTEE17mH6NRRk85PRX
	 oHoNL3bBGEfL+N5fYKeYhLAwFBaQAHPCFXQKKu31lWD2wDNrw7ERx/aDzERBNWMWHB
	 fhQKUZMB7yVgM/TnM3Rt5aXhpkHV0IKy2UkGwrjxO8UzFR69gPbSXz8QTDpfvMJdbz
	 oJpk1/7htDYqWB5AaftvhKtVeqUu/q1GkdelKIhRb35Wi1o3nFGB2HDaTTwQJ7br6S
	 bRl5+TzDt83ChPkxn/6Wsmw3enejW/i0+IAKZLYKBjIIWZXbUKmVXy+CD6E+zcD8vc
	 z547l1n/896iQ==
Message-ID: <7bc9e2c2-3646-43bc-8405-c4367d99d8bc@kernel.org>
Date: Fri, 8 May 2026 00:33:40 +1000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 arnd@kernel.org, Greg Ungerer <gerg@linux-m68k.org>,
 dmaengine@vger.kernel.org, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, olteanv@gmail.com, adureghello@baylibre.com
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-8-gerg@kernel.org>
 <20260507-masterful-pegasus-of-science-c408e0-mkl@pengutronix.de>
Content-Language: en-US
From: Greg Ungerer <gerg@kernel.org>
In-Reply-To: <20260507-masterful-pegasus-of-science-c408e0-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: B96294EA51B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-m68k.org,vger.kernel.org,kernel.org,linux-m68k.org,gmail.com,baylibre.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10266-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@kernel.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Action: no action


On 7/5/26 23:30, Marc Kleine-Budde wrote:
> On 07.05.2026 00:26:48, Greg Ungerer wrote:
>> diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
>> index f5d22c61503f..a682f02d2c43 100644
>> --- a/drivers/net/can/flexcan/flexcan-core.c
>> +++ b/drivers/net/can/flexcan/flexcan-core.c
>> @@ -296,6 +296,7 @@ static_assert(sizeof(struct flexcan_regs) ==  0x4 * 18 + 0xfb8);
>>   static const struct flexcan_devtype_data fsl_mcf5441x_devtype_data = {
>>   	.quirks = FLEXCAN_QUIRK_BROKEN_PERR_STATE |
> 
> Nitpick:
> Can you move it here, so that the quirks stay sorted?

Yep, sure thing.


> 		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |
> 
>>   		FLEXCAN_QUIRK_NR_IRQ_3 | FLEXCAN_QUIRK_NR_MB_16 |
>> +		FLEXCAN_QUIRK_DEFAULT_BIG_ENDIAN |
>>   		FLEXCAN_QUIRK_SUPPORT_RX_MAILBOX |
>>   		FLEXCAN_QUIRK_SUPPORT_RX_FIFO,
>>   };
> 
> With that change:
> 
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for drivers/net/can/flexcan

Thanks
Greg



