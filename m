Return-Path: <dmaengine+bounces-11381-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iPG2GVGyKGofIQMAu9opvQ
	(envelope-from <dmaengine+bounces-11381-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 02:39:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A04E664FDE
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 02:39:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=polyxeno.com header.s=fm1 header.b=VyY2ENsq;
	dkim=pass header.d=messagingengine.com header.s=fm1 header.b="j o1hgMe";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11381-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11381-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=polyxeno.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8344F30433FE
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 00:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280751A6835;
	Wed, 10 Jun 2026 00:39:41 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708D17A305;
	Wed, 10 Jun 2026 00:39:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781051981; cv=none; b=Yvq2SPEL33GABk0bWKSOVP2gZ7aurC7Wk864FOYo8Jr85NB7Wgr28EkLz/1fcv4On79HQcTLPNeLc+Gbf6bogIkHQc91Qo6AKZv84jH9bAFWS/bVjDpfNhO9cXDL6Y44a8r3Gy7889OuWPGG+W+F0B347KjxjR5OS41LSQcYAN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781051981; c=relaxed/simple;
	bh=ms75ffeU1inQ6MIWweBPYlVxfpf6Yx9LxALBHB8c4TM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OpZ8SybOWR15LUc55edgek+tvRNSg6+6pevO7rAuwl/YLh2tTpe2oYVBwzWWtNzZ7rkS+HDFQQtvaahrq2BagsniLGBEsy3FH6HLFCGzy48lOdAZaL4POaoDu3Uf9yl/W7g2VNzT1rc1Q0OjavBUPFsGPP9VSTdlqdETxY0MNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=polyxeno.com; spf=pass smtp.mailfrom=polyxeno.com; dkim=pass (2048-bit key) header.d=polyxeno.com header.i=@polyxeno.com header.b=VyY2ENsq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jo1hgMeq; arc=none smtp.client-ip=103.168.172.158
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6E9361400186;
	Tue,  9 Jun 2026 20:39:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 09 Jun 2026 20:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=polyxeno.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1781051978;
	 x=1781138378; bh=ZoDG4RUYnd/6YoHo/7tTv5h9HmMcyuxk57DAPYJvsyc=; b=
	VyY2ENsqGpLWqZXygS21mjA6njp5hIY1KPtwvNOw3eAmxHEhlOdh0qNu3AbFKvZL
	rOrqYgk6hQC83xX7dWHVF0t5gZJjkg6ZRgK6XaPlus/eWiuZVKBG3+hfKgbzWPWV
	XDF/gDIR9jOSzQKVI857neyqqN8i3piIX3c/XbP859fDPkg31nhQG/oQ71Ws0Y9/
	gis1vBs3DDhHWO062Eiju33aWpG/pdiV4jZJwDifZGXFJB+V2Wu2A7gbZM7MeeAf
	xI/84DnvKbnhIC/0es5/87neRKI/kvpJsj+aQjlyLsQy7nlZMr6f3LOwY7rhOESb
	HrIQyT8KCbXZuIum54w7ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781051978; x=
	1781138378; bh=ZoDG4RUYnd/6YoHo/7tTv5h9HmMcyuxk57DAPYJvsyc=; b=j
	o1hgMeqAyVvCkjcOTyZKzMufdH6mIz6KlzeiOPwKMA5Hq0aSfFlMkT48YexlQ4Sk
	vdQb5rLKDmA0iNiW11Vbeb2B+CYPtcENTJ9tl6ecqTDq8dSAK6+Rk84fRXdcdoHY
	DGiTT058rvBD3nE3u/qIXqWShutRvZVh7dsp8yHedL94HhgDi+rt18wK/ByTmg0B
	bjMY23atWtrzyrCFnBWpr64g1a0wdEvPn94wUXhdUGotufKs7LDyQ4gq56C/+Okr
	e03opGJ+cwNlcvbLYVz4Y22GHzCnwTGpGiybr5APzbJSX+jgcQPz+w98a8VuQK9a
	te5JOhdJODjFQe+antPWQ==
X-ME-Sender: <xms:SbIoajA9Zb4wp5h5r3U6oBIdze_eGPCdWwL8ZgHA3JLZlJO9sTqTiw>
    <xme:SbIoanyzzHC1vE37T1lvHWdEk6RgVOF-x8WBcvlZbAAe4_vK77fKh3NGMeu4RsQWD
    YHZlnXu0NWrsm1v347m1Q1Kz7XEBKh6kFV_8FBVf1haAd4tn-nYaCE>
X-ME-Received: <xmr:SbIoan4XCOYIKXBi7l0K3kCSu7DCU73yI4LkSrxjNuLq3C9rRuh98tjCZbro6gze9Q>
X-ME-Proxy-Cause: dmFkZTENRcTCDCEfam9c4btFwQZieytA23CVeQPOIhXFJ1QJG62h+oJ5jiDuvm4NMKBAzi
    +Vt9FL6yf5y/fSMuycru8cswZas2P/Ck4dOCNgbridrPDK9W77tfcPkum8+lXpi52bEjSZ
    b4mxJbr/ZxA1ilRIDYb4GBzwALE6+uCrhcRIEVai9moerGDry1uGwC82x6g+l8NIQ/QMs3
    1pRtnx8Verb5zEyehCWywyEFIkzb6i+hsa8XgsNB58yTpyYlqg3WLuIo7ZnxWgR2rAATub
    AZHnm+UEEBWpq9dgtQcZEkH+2U7fhmqN87WqfS0MSNh0tgJpAFezUi4FkMxZBmnMIy5Bc3
    2lecCiRMrJSgZ5Z7DNRrE635YwuIIBOffbrMwtXtZXEqqRj6QB6z5Bb3cD3zHgCgnVKUAi
    1WJdKL2Vhj6nbRguASZEEuPGPMZuTLIahtI4O5w2a2wcGaY1yYkDE1wYlYQnmmwOp+tiOi
    5irysCSZhQSw1BHMO0e0V2eCRozu0m4/x3i2WRNiLtYgQ0drL208Bjhh891stu9uANOPPs
    SLzSGRFN0DpxdTzJYbEpgFHWznKnRTpJpPPPSfHIp4/c2PYLUQr37agi5BFAcfM5GZc2wB
    +09OmqZOFHFhyz86L9HULZ1CzL4sdOYSxCoPdiBGVopyHS+jnywpzXkIxZzw
X-ME-Proxy: <xmx:SbIoaowHmhnJRthQmafjaG9yD7VLpL3j80FqBpJihHtcM8WYhtDTPA>
    <xmx:SbIoarcZOHYELpbx3YiI7qMicu42G_LJ8KU0UK76QNGtSMvIBGM4Yg>
    <xmx:SbIoatDH4uDLLZ_iFMz5BU2FU4A-tRM7tzFEdm9CvngPi_5e7lXUAw>
    <xmx:SbIoav4sJdz0ipmO1rzuSx0EIm8AsDEglyvgDDexNfYrVShMsyROtw>
    <xmx:SrIoamP5JsAW6hYp7GrTPBr-09L8JI_-4OZ7tDcaE4BHO4i--4khS8hq>
Feedback-ID: i09fe4b60:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Jun 2026 20:39:34 -0400 (EDT)
Message-ID: <350e54ed-45f9-4022-ac79-85f980e1a298@polyxeno.com>
Date: Wed, 10 Jun 2026 10:39:31 +1000
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX()
 functions
To: Angelo Dureghello <adureghello@baylibre.com>,
 Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@kernel.org>, Arnd Bergmann <arnd@kernel.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
References: <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
 <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
 <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
 <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
 <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
 <2b532d56-dce4-4f6d-84e0-2fd87d5494f8@kernel.org>
 <20260601144332.GC4918@lst.de>
 <CALSJ-wAaOsizvHGiCdL_mSKS-LQGJKgbnUeBAnE8H+h-7xOGhg@mail.gmail.com>
Content-Language: en-US
From: Greg Ungerer <gerg@polyxeno.com>
In-Reply-To: <CALSJ-wAaOsizvHGiCdL_mSKS-LQGJKgbnUeBAnE8H+h-7xOGhg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[polyxeno.com,none];
	R_DKIM_ALLOW(-0.20)[polyxeno.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-11381-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:adureghello@baylibre.com,m:hch@lst.de,m:gerg@kernel.org,m:arnd@kernel.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[polyxeno.com:+,messagingengine.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gerg@polyxeno.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gerg@polyxeno.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7A04E664FDE

Hi Angelo,

On 10/6/26 07:30, Angelo Dureghello wrote:
> On Mon, Jun 01, 2026 at 04:43:32PM +0200, Christoph Hellwig wrote:
>> On Sun, May 31, 2026 at 11:42:26PM +1000, Greg Ungerer wrote:
>>> I don't think that is right. The way the underlying data cache is setup for
>>> MMU ColdFire (via the ACR/CACR registers) means that individual pages cannot
>>> be marked as non-cached. So coherent memory allocations are not possible -
>>> at least the way things are today.
>>>
>>> It would be possible to set aside a chunk of RAM at kernel startup time
>>> to use as a pool for coherent allocations (since it could be marked as
>>> non-cached via the ACR/CACR registers), but there is no code to support doing
>>> that today.
>>
>> With CONFIG_DMA_GLOBAL_POOL there is some generic code dealing with
>> most of this.  But if this driver worked on coldfire in the past,
>> it must have been fine with non-coherent memory and could use the
>> non-coherent allocator.
>>
> 
> Ok, thanks, so the driver is working fine with non coherent memory but may
> be just for a case. I will try to setup a better SD test. And will send
> another patch to have dma enabled with non coherent allocator.

Sounds good. Thanks for taking the time to look into this.

Regards
Greg



