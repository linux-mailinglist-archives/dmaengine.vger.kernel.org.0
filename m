Return-Path: <dmaengine+bounces-8164-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7927DD0B5B0
	for <lists+dmaengine@lfdr.de>; Fri, 09 Jan 2026 17:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9562C303C8CB
	for <lists+dmaengine@lfdr.de>; Fri,  9 Jan 2026 16:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC8D36657D;
	Fri,  9 Jan 2026 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="uamQh8vm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ar5xMfpR"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03533365A0C;
	Fri,  9 Jan 2026 16:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767977020; cv=none; b=ELW9dtAEETunp7wqFREjQi5vN+ZomQHqQVMSe9U8a0ATcR1VbD9kfUB0wb3VoQB70fxdlqdukbQnYPjxLlx9Rq26GAeBzPB9iBknL7UF9VoCIhdI+KBue7Fszlh3K1fb+lDZKmvf9qle2d6lDda3lPJH1fROPWwLLl+BzYDdjjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767977020; c=relaxed/simple;
	bh=/wQMMc2/Hg1lD5uTE2mxY96FQrsGBTSvXDsqcv+vtLU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=WPlRevAYv8IZYCgYou7Yq9M5p4P7E5O/6elMjykpaJ1BbPDeBPA9ryGWURFyqkEzYzZz9g0g+JHDM/JuUT28bncnmb51/k3ze4IRETTZBfDR/nVlEHGUju1pLzwf14Bd91vguyq1IeROyaljifCe/VRD6UkVbtN+ntqJs3Oa/Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=uamQh8vm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ar5xMfpR; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 26AC31D00061;
	Fri,  9 Jan 2026 11:43:37 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Fri, 09 Jan 2026 11:43:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1767977017;
	 x=1768063417; bh=BqEr8EKVvdyxbYB/bQT/+zuTIjlopH42cFweYRqUF6Y=; b=
	uamQh8vmPwcpfWD6s6m5k9rlEdgUf/zXuTIi1+n5xw3WpPNMWE7KGFnk2whijzyh
	k77r7VERHpto/6EPqG6aPQfYqgpn+CIPeGPo7aAMrzhA6Xy+ZXWS7evt51hyDxc0
	hC5XccRPekC+K1BvjsZgwqZzIlcnPocJDqWURuS6l7eWc3yjCEm+lJrgy0WeLBQ/
	7OGCKirQ9P9unBbn8zGIiZuhflFRwAgGbF3XOufpmdW2WJzU4DSiu5McfF/kGwhX
	vtpLJABsu5C8VAD08aBvxkVZzvxFyI0rRNZs71tNKSWWFvYkEVScyiWvUkSeeeOD
	BkSaTlzATT7rIgsmgv8UEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767977017; x=
	1768063417; bh=BqEr8EKVvdyxbYB/bQT/+zuTIjlopH42cFweYRqUF6Y=; b=A
	r5xMfpRwgTdp7oef5boYpJgNkk6tVtwGYhtgi3K0rfv3I+p6LLD9ZUQUqwH5W7If
	2uIZBqLcuH7sj5xtTaFBl+i16pkvGqZVv/oOngShkptUyMpJ4dG2eMn1uuSs+C6s
	Y2wrIoJVXXT8Lkmm3SnZYEBKdqUagLBTgZu4Fj9weBKJflsO01sAZa55H/EQGzIW
	1UH+uK+MgDN9YsAk3FqDI6/6czbaOFarSIy1NN7pyUy9977X9mcdc9PHjaaUbSfJ
	y7ZMLJ4hlVRAVFyXrdSscg7PnoBM+dHWKN5V0/lJQ08SUWrWZMz1n2NvSKmgGEpa
	WBbPnGNdtJvd1EXib1mtQ==
X-ME-Sender: <xms:ODBhaR0vSAKiqmmHx85Zh6Ld04G--LlvYAuAdT-gRi0Cd6jMwT9LFg>
    <xme:ODBhaS7xWkPpUJC548lG5GNnwDFjJ6MQzQuA-94lue4aZRzf48QCj3WJ_BPt5tFSZ
    CgvttFQ0cBXFEQHMjrFsCp_2iJ9x2uYwZXAZDiVKmyak9wGBHNBkR4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtoheprghllhgvnhdrlhhkmhhlsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhgvvghssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehvkhhouhhlsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:ODBhaeC_ZBo8lu4seki0GvdkPqRw05PNL4lwCxeeq6r9CAUx5MHGgw>
    <xmx:ODBhaRdMxecC_D_rXJEsYwuVyD0C8-QKB0t4YpZ9nWXrgBWVLwWN5Q>
    <xmx:ODBhadJXy14CQR1tgWsX5J9zZKh2s9L5hL2s8cQCqna5BXy9puJ9fg>
    <xmx:ODBhac1RhBa1n1_y7TJE4MWZfc0vt3AQe3bHSlExc4VQl7cVPD0SZg>
    <xmx:OTBhacu2o3px3pkUNrmXRHrBTwrir6IOYIQ2INhMJ9aQefeWPiDIU3wU>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A3F58700065; Fri,  9 Jan 2026 11:43:36 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlCBMFNMbPuR
Date: Fri, 09 Jan 2026 17:42:54 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: Allen <allen.lkml@gmail.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Kees Cook" <kees@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <7a557097-5dca-4c44-a48f-21dfa2659abc@app.fastmail.com>
In-Reply-To: 
 <CAOMdWSLX07i_-NjUB6TTXbWVmeFLSNoaTBhvOs0WX6Ad=A6PDA@mail.gmail.com>
References: <20260108080332.2341725-1-allen.lkml@gmail.com>
 <20260108080332.2341725-2-allen.lkml@gmail.com>
 <6342bd3d-6023-4780-b3b9-96af7d2a4814@app.fastmail.com>
 <CAOMdWSLX07i_-NjUB6TTXbWVmeFLSNoaTBhvOs0WX6Ad=A6PDA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] dmaengine: introduce dmaengine_bh_wq and bh helpers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026, at 20:22, Allen wrote:
>
>    Thanks for the feedback. My intent with WQ_BH was to keep callbacks=
 in
>   softirq/BH context, but I agree the scheduling overhead and existing=
 tasklet
>   assumptions are valid concerns.

Hi Allen,

Sorry about missing the bit about WQ_BH, I forgot about the details
of or previous discussion and this is pretty much what I had
suggested last time,=20

>   I can re-spin the RFC to drop the workqueue entirely and keep
> tasklet semantics,
>   while still abstracting tasklet handling into dmaengine helpers so d=
rivers no
>   longer directly manipulate tasklets. That keeps
> dmaengine_desc_callback_invoke()
>   in tasklet context and avoids breaking DMA users that rely on that b=
ehavior.

It's probably fine to do both, but a series of two patches (first introd=
uce
the per-channel API, then move it over to WQ_BH) may be slightly
clearer here.

I'm not sure why the dmaengine_*_bh_wq() functions are exported
interfaces, as far as I can tell, you use them only internally
in the dma_chan_*_bh() functions, so making them static would
let the compiler inline them where possible.

There are of course dmaengine drivers that use tasklets for other
purposes than the channel callback. Was your idea here to use
the same workqueue for these? I would perhaps hold off on that for
the moment and see if there is a better alternative for those,
possibly hardirq context, threaded irq or a regular workqueue
depending on the driver.

>   A hardirq callback path feels like a larger API change, so I=E2=80=99d
> prefer to handle that as a separate follow=E2=80=91up (e.g. explicit h=
ardirq
>  callback/flag + user migration where safe). Thoughts?

Yes, definitely keep that separate. I still think that this is
what we want eventually for a bigger improvement, but your
patch seems valuable on its own as well.

Some more thoughts on where that later change could take us:

>    /*
>   - * This tasklet handles the completion of a DMA descriptor by
>   - * calling its callback and freeing it.
>   + * This bottom-half handler completes a DMA descriptor by invoking =
its
>   + * callback and freeing it.
>     */
>   -static void vchan_complete(struct tasklet_struct *t)
>   +static void vchan_complete(struct dma_chan *chan)
>    {
>   -    struct virt_dma_chan *vc =3D from_tasklet(vc, t, task);
>   +    struct virt_dma_chan *vc =3D to_virt_chan(chan);
>        struct virt_dma_desc *vd, *_vd;
>        struct dmaengine_desc_callback cb;
>        LIST_HEAD(head);
>   @@ -131,7 +131,7 @@ void vchan_init(struct virt_dma_chan *vc, struct
> dma_device *dmadev)
>        INIT_LIST_HEAD(&vc->desc_completed);
>        INIT_LIST_HEAD(&vc->desc_terminated);
>
>   -    tasklet_setup(&vc->task, vchan_complete);
>   +    dma_chan_init_bh(&vc->chan, vchan_complete);

This is where I think it makes sense to start, again for
the vchan imlmenentation. What the dmaengine drivers have
is a per-driver tasklet (or WQ_BH) with a single complete()
function that directly calls into the client drivers for
each completion that has happened.

Since the context we want depends on the type of client
driver, I think a good approach would be to start
by modifying vchan_cookie_complete() to allow it to
call the callback function directly from hardirq context
when the client asks for that, and avoid the round trip
through the tasklet where possible.

A new bit in the dma_ctrl_flags word could be used
to ask for hardirq vs softirq context, and the existing
drivers just fall back to using a tasklet for softirq
context.

      Arnd

