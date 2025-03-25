Return-Path: <dmaengine+bounces-4779-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D02A70159
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 14:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6976084455A
	for <lists+dmaengine@lfdr.de>; Tue, 25 Mar 2025 13:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C4226FA7A;
	Tue, 25 Mar 2025 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b="S9dATbHQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B626FA6F;
	Tue, 25 Mar 2025 12:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.68.50.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906399; cv=none; b=o1KgXM8Ad8pYFXjbY9BFqYtJrhjBT/v2UBI51KKdJeObnxY57FAykGssxUXgecKeBBhlvqpEJcR87wW9KRbr4CD2vG30d9mpdVD2SFQ3mFdgyQ6ueiUP42BI++PNNUdwUg8AXGq7PzroY8XDi/+rcVfzhhMv2ZOX58mMPCdjCSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906399; c=relaxed/simple;
	bh=8tP82OotsJmSeaPv/t9mJp2OiMqNRSJ6qjsDyEcX6/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=KWFipGRFtOOtm8Vm6SZaGUPQzdHe3JAZPvahyk4rVkvF+CnLLEK4JKBczc7/3Qwt8f3QWdFtGLRoYJARSEXIJ6KLd6fTQ6AsQfaraHCylfnDd/ws0+fCjJk1NR/x0BrtmEMPP1w3i/J4kc2KL29+zkaqL3KH6tVMy75u5bKBJF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu; spf=pass smtp.mailfrom=prolan.hu; dkim=pass (4096-bit key) header.d=prolan.hu header.i=@prolan.hu header.b=S9dATbHQ; arc=none smtp.client-ip=193.68.50.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=prolan.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain [127.0.0.1])
	by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id E788AA05BE;
	Tue, 25 Mar 2025 13:39:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:from:from:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=mail; bh=RB9GJiRFJg6/bN2vnJM4
	vC1ljE25oPT92TiI7BbGuH4=; b=S9dATbHQKVhWMebPspBcq6wTeWmup9sX72Kh
	N6n2EOKfMxJ8hfo0eTHPW1XJagCC0ai0nBmCHIVy4CcHtuy/IXnIgexI30R+GdNl
	duApg87u5HRR6AeTK/YocuQ6l0qO/UdIfXUct1soL8X9PKv9cQq0h1NBt2X0kI5q
	+lEN+F2l2JIQI486Y6hh0CZEyKqP0TkDztsZGjlE3Uso/PHsCX1aGKhdGaqF1Rjl
	+yZcvJGLae6yNEZgZGvIv3HmOOj4JjKAWu/0xAH4uJW4swwIiqcoJFiSrmskdLTm
	7Y8ihLBis0RuF6MM+NSrVlSq4oBw/2dK9YHX3tSsi05orp7W06buvBssdGEA9Ovd
	fZ2XqrL02cu625TnlTkTjrZBBs2DMjBk09f03HHe3wJhNAcqCHG5HmRSwsqLkJ0d
	szXn94T4iai0+JUcFgko07Kg+uYwgI8hpnU+wrH90xaphxeVtGYJzCpqbXd6zy/A
	5z8DotmD6V5RMOrH2eXdQhM8tJTAkLeUyWinSo3HCsKf8NIzqB8pJz95XaMWGHH+
	1PqX1GnooCT3EhMYUffDfPUnOWlwoeOhS5ygusL8nLXtNLTMmYRquF+i7C7zWzVM
	kwqMGcHByQCN9+ea0sgxkir8QTN4PyVDIzYVihd/v0s3gW9o51tuF2S0SEKD2pDk
	+07bpVg=
Message-ID: <bd7b31d8-be25-4dbc-9a81-4b0cccd64798@prolan.hu>
Date: Tue, 25 Mar 2025 13:39:51 +0100
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v6] dma-engine: sun4i: Simplify error handling in probe()
To: Julian Calaby <julian.calaby@gmail.com>, Markus Elfring
	<Markus.Elfring@web.de>
CC: <dmaengine@vger.kernel.org>, <linux-sunxi@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>, Chen-Yu Tsai <wens@csie.org>, "Christophe
 Jaillet" <christophe.jaillet@wanadoo.fr>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Vinod Koul
	<vkoul@kernel.org>
References: <20250324172026.370253-2-csokas.bence@prolan.hu>
 <92772f63-52c9-4979-9b60-37c8320ca009@web.de>
 <7064597b-caf7-42e2-b083-b3531e874200@prolan.hu>
 <7332ccd2-ebe6-4b9d-a2ae-8f33641e7bd4@web.de>
 <7afcbbee-6261-4b2f-be14-a3076746d53c@prolan.hu>
 <26e36378-d393-4fe1-938a-be8c3db94ede@web.de>
 <CAGRGNgU7t85oG3Bq7L3KjKUAbRyd6SHSM6F6BvmdXDVkbNegKg@mail.gmail.com>
Content-Language: en-US, hu-HU
From: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>
In-Reply-To: <CAGRGNgU7t85oG3Bq7L3KjKUAbRyd6SHSM6F6BvmdXDVkbNegKg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ATLAS.intranet.prolan.hu (10.254.0.229) To
 ATLAS.intranet.prolan.hu (10.254.0.229)
X-EsetResult: clean, is OK
X-EsetId: 37303A2980D948526C7562

Hi Julian,

On 2025. 03. 25. 13:20, Julian Calaby wrote:
> Hi Markus,
> 
> I really wanted to keep out of this, but...
> 
> On Tue, Mar 25, 2025 at 8:14 PM Markus Elfring <Markus.Elfring@web.de> wrote:
>>
>>>> Implementation details are probably worth for another look.
>>>
>>> What don't you like in the implementation? Let's discuss that then.
>>
>> I dare to point concerns out also for the development process.
> 
> You're "concerned" about patch granularity, but this is not the sort
> of thing that some random person would raise, this is the sort of
> thing a maintainer asks for when patches are doing too many things or
> are unreviewable. This is neither. It is a very simple cleanup of a
> probe function as it says in the patch subject.

Exactly. That's why I asked if it broke something on Markus' end, 
because it is a really specific thing to nitpick about, especially in a 
changeset this small. So far, he did not indicate the *reasons* why he 
thinks this should be split further.

> Futhermore, this already has an ack from the maintainer of this file.
> This indicates that they're happy with it and no significant changes
> are required. This is also version 6 of the patch, if the maintainer
> was concerned about this, they'd have already provided some clear
> guidance on this. If you check previous versions of this patch, no
> such requests have been made.
> 
> Your only other "concern" had already been addressed as has already
> been pointed out to you.
> 
>>>> Please distinguish better between information from the “changelog”
>>>> and items in a message subject.
>>>
>>> What do you mean? The email body will be the commit message.
>> See also:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.14#n623
> 
> The email and patch structure are following the format outlined in the
> document you link to _exactly_.
> 
> 
> Once again your comments are just noise, and your insistence on
> repeating them over and over and over and over and over again is
> borderline harassment.
> 
> You have been told to stop this nonsense many many times, here's a
> link to the most recent one:
> 
> https://lore.kernel.org/all/92d1a410788c54facedec033474046dda6a1a2cc.camel@sipsolutions.net/
> 
> Please stop sending these emails and go do something constructive with
> your life.
> 
> * * * * *
> 
> Bence Csókás, (I hope I've got the order of your names correct)

Either order works, Bence is the given name, and Csókás is the family 
name (surname). Hungarian and Japanese order follows the scientific 
"Surname, Given Name(s)" order, but commas broke many tools, including 
Git < v2.46, and b4, so I switched to the germanic "Firstname Lastname" 
format.

> Please block or ignore Markus, at best he's a nuisance and at worst a troll.

I'm still open to hear him out if, and only if, he can give *clear and 
valid* reasoning on why he wants to achieve this. I'm a generally 
understanding person. But if it's just hand-waving and linking to the 
same page over and over again with no explanation on why he _thinks_ I 
broke SubmittingPatches, then I will do exactly this.

Lastly, to all other adressees, sorry for the spam. So let's end this 
meta-discussion here and keep the rest of the conversation professional, 
reasoning about the technicals.

Bence


