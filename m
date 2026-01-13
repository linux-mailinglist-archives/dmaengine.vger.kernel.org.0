Return-Path: <dmaengine+bounces-8232-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BD5D1707C
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 08:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3D70303F7A2
	for <lists+dmaengine@lfdr.de>; Tue, 13 Jan 2026 07:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5239230DD2F;
	Tue, 13 Jan 2026 07:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="jEGNnA/+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GHdTGADu"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D02BD035;
	Tue, 13 Jan 2026 07:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289647; cv=none; b=pBqk0nz7ZbR77nHiy1hqSxu9zXCVpJFagySDqIXFxUuGjLWeFdyjURrU2YRSwcSzmnI3vfahc94ERmbvplmrS3Gzz1ElU49emF6uJD+s1XVHBrBwEjBEJazURv+d0LtJ0EZurOdq3CWjOVQvi9r72KYX5kh5lph2wYUdZBw7SO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289647; c=relaxed/simple;
	bh=KHcAdk1EcU9QYhIbFO3tmf2DHLDghedrNlEFHsyPteQ=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=Rm+RwmT3rWliTfBz8wfvsm6XTkoZt5f5A42X42FPFI9n9uzjGsk6IdLA5cpmepfjFCEIVDc9uvhDtPfZPBuE7VRwYlq33778jSPlp/eEXIBbeYqzrTiOG86qam4pjNtFbscVGEZKnhQU9GlylZ48NwuPKuJWNI/ZaFl3FXH7B6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=jEGNnA/+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GHdTGADu; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F0863EC025D;
	Tue, 13 Jan 2026 02:34:04 -0500 (EST)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Tue, 13 Jan 2026 02:34:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768289644;
	 x=1768376044; bh=cWKvpQocrBPSOG5Q9EfpVcet2bNTJlrRSKPrB2roZrg=; b=
	jEGNnA/+gfoy9E2txFxxAxRly67zzRC9BdYpJuJJPwQv1NUiyKvOKpHgoT9/4Smw
	R8sql7swGeS9+8Y3eq5k1pMh+U8/WZb2IsAZ1uzatj+w3q1Apjvj+Z2bWCN7UT0+
	A6l+Hv+RPNO9/a+HZK/0fAWCSU4loB1mvfCK9dTHqot7qlG9AD5hum7jLP6xCWIU
	XeMh+BuDqDAekhLaTs6tGPd/2mXf50zM3pvp+Q57nWmJllvDk54oFpIn/HXXOC0m
	yyhpKrfWGuATPZot0SsdAOyrDhkC7PyL6EB7nhGo3g4h8U2p5pzxaceZPb8IbewA
	vgzLggjVVTd1Jaovn+moNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768289644; x=
	1768376044; bh=cWKvpQocrBPSOG5Q9EfpVcet2bNTJlrRSKPrB2roZrg=; b=G
	HdTGADupGn61nHQ8nWGUp000CmtFbYkUWERq2rxDZPC/xtQjym+9YRG4OUZfVAr0
	fQjrPDf5LePUrpp9mFTJKNufEi3pBiX6kV6rCjzrC1jBibKYfv5eD+d0Lr+TN+N5
	r+MZRAd04X7DqyHq7Hk5kEaGTBhugQyBzNq19zkNzja6OqUJ1Jl/lnLh3y6niNz6
	zEBsn0cgbaPs3piuRVi6xI6ghMlvAC1seN5w2nETBrZogS4PBiEWLT8yE44pG1rZ
	D3Zx7IEUT3Ds0mLSoeF9eQAuxG6mwDPV5WKzaxQR9z/icw/G5NC2/gfxPZRh84qy
	OLsrRTBA8jXXLokh4Dreg==
X-ME-Sender: <xms:bPVlaVtfaDL49AjXQzjVmQuBXWtR2lxUnxPwrySPbMcyD68mEoVf3w>
    <xme:bPVlaZQvj-mNoBX37XuLHHb9gOyznXUdmiu-uApZWYSDPXo-LmgeU5fo7dtX8D5On
    ptb94UdhDqRdk6z-kkR7hbknBEPqgHA_9zQ487AZPL9JorAvjTE18o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeljeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:bPVlaf5cMmY5l6MQhFYlWfKp7o3tajjTk6yFGx3My5Q2LLG4pzTI-Q>
    <xmx:bPVlad0lIsUEiMXnA2A_x5l-MUw3__w-8khrYQSb5VnNUFlJZ125gQ>
    <xmx:bPVlaSD1g4GFeNibMYvYwXQqKDV_HACIkKN5qsZhaLqwRz8-P0swlA>
    <xmx:bPVlaQNgW2Rsd0HvPaNHcHlnWND6zpSR9IZv40KTjEKnO8WGBO_x1w>
    <xmx:bPVlaXngFYn37w6FaxMOnp42xeAz_-Xx9R4pw6e0K4GmypJ50NoHF4dJ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CE426700065; Tue, 13 Jan 2026 02:34:04 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AlCBMFNMbPuR
Date: Tue, 13 Jan 2026 08:33:44 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: Allen <allen.lkml@gmail.com>
Cc: "Vinod Koul" <vkoul@kernel.org>, "Kees Cook" <kees@kernel.org>,
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <b309e54a-b3b6-49f9-af85-2df5ffbe13bf@app.fastmail.com>
In-Reply-To: 
 <CAOMdWSJ7ut3n-nryTYSyPD37YwN7UqyZ1VcgZ9nmBcRF_jxH=w@mail.gmail.com>
References: <20260108080332.2341725-1-allen.lkml@gmail.com>
 <20260108080332.2341725-2-allen.lkml@gmail.com>
 <6342bd3d-6023-4780-b3b9-96af7d2a4814@app.fastmail.com>
 <CAOMdWSLX07i_-NjUB6TTXbWVmeFLSNoaTBhvOs0WX6Ad=A6PDA@mail.gmail.com>
 <7a557097-5dca-4c44-a48f-21dfa2659abc@app.fastmail.com>
 <CAOMdWSJ7ut3n-nryTYSyPD37YwN7UqyZ1VcgZ9nmBcRF_jxH=w@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] dmaengine: introduce dmaengine_bh_wq and bh helpers
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 12, 2026, at 23:20, Allen wrote:
>> >   A hardirq callback path feels like a larger API change, so I=E2=80=
=99d
>> > prefer to handle that as a separate follow=E2=80=91up (e.g. explici=
t hardirq
>> >  callback/flag + user migration where safe). Thoughts?
>>
>> Yes, definitely keep that separate. I still think that this is
>> what we want eventually for a bigger improvement, but your
>> patch seems valuable on its own as well.
>>
>
> Thanks for the detailed feedback. I=E2=80=99ll respin along these line=
s:
>
>   - Split the series into two patches: (1) introduce the per=E2=80=91c=
hannel BH API,
>     (2) switch the vchan implementation over to the WQ_BH backend if w=
e decide
>     to keep that step. This should make the progression clearer.
>
>   - The dmaengine_*_bh_wq() helpers will be made static; only dma_chan=
_*_bh()
>     stays exported.

Sounds good, yes.

>   - I won=E2=80=99t try to move the other per=E2=80=91driver tasklets =
onto the shared queue in
>     this series. That feels like a separate discussion, and the right =
context
>     (hardirq/threaded/workqueue) may vary by driver.

I'm not sure we are talking about the same thing here. I do think we sho=
uld
try to have all the callbacks in each dmaengine driver go through the sa=
me
per-channel deferral mechanism. What I meant to say is that all the task=
lets
that are not used for the client callbacks should be separate from those,
e.g. the pl330_dotask() handler is used for unexpected events unrelated
to a channel.

>   - I=E2=80=99ll keep the hardirq callback path separate. For that fol=
low=E2=80=91up, I can plan
>     to add an explicit =E2=80=9Chardirq safe=E2=80=9D request bit (e.g=
. a new dma_ctrl_flags)
>     and update vchan_cookie_complete() to invoke the callback directly=
 when
>     requested; otherwise it stays on the tasklet path.
>
>   If you=E2=80=99d prefer I drop the WQ_BH conversion entirely for now=
 and keep only the
>   tasklet=E2=80=91based per=E2=80=91channel API, I can do that too.

No, I think that part is fine.

     Arnd

