Return-Path: <dmaengine+bounces-10569-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEz/EXpeDWpuwgUAu9opvQ
	(envelope-from <dmaengine+bounces-10569-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 09:10:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DE084588B44
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 09:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E95DD300737A
	for <lists+dmaengine@lfdr.de>; Wed, 20 May 2026 07:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BAC34DCC8;
	Wed, 20 May 2026 07:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="B653PIVe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GnYd28z8"
X-Original-To: dmaengine@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4244E34F48F;
	Wed, 20 May 2026 07:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260838; cv=none; b=TIlg7HfUyxC/70SZ9cp9lQyxmA0dtk43pfGLApyJL14loTKSHMfDIJJIw0zKrElg6WhmUwVB8BO07lAbGutoPVFPphUk5Q9WPWWdp7FrFLaSDxy35Nbr5RBOr/Ys6kVs4KSzTvvenfOA0+HideBAW7cV5iz//0a6RrIHSna+mLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260838; c=relaxed/simple;
	bh=4UmG7P11W8AQAGwVtiZgMyYozzVFcf+K+iTyto2DY7Y=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=sNicx4et+RJK5dvWIppul5rrp4JpCXvKPpOQS/eMRzU4WDlrTpRAje3//EBe2D9pe4IDHOhbeihbboNjO4SXBjqR8KIa/Ap2meps7Uj/CzjTj9HF5p6ujYyXZAzOpUmWk3kpGw9x2piBnRQPouNAEm9Rar5SGztdC5YvJjcQU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=B653PIVe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GnYd28z8; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 45A361380030;
	Wed, 20 May 2026 03:07:16 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Wed, 20 May 2026 03:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779260836;
	 x=1779268036; bh=Yc0JG1Xn3Wha37rB1V4lbZPt4g1XIowSANBWVbYnYYg=; b=
	B653PIVeT6uaYy3t2lF/YnNdWPHqubwh3EDKNnOtFGEz+Fddi3+jLGVO7gIb6ZUN
	hPyzpzE00vzBB4FUos8RIMr4sCwlZQpGssPQnPh+6czAOoLwAftWa5e1FK7RpDEN
	rS1WcM+Dv1v71YncQWjBS35nP08DYu5Ci394FOzWskEmJ1U37vNqd1lTu+CTCQg/
	2t+eqXZfsHVisrfl284hE1uvTVn8jJCt8YJ/NiT8bobdKukP2Rvu2stuc7BJj4dU
	+e7h4wtogZIit97VsX07EyugTest4kUhBIiLUt7JGVFixgka05hqGjMuy1DkLN43
	JC41BZdEsZ0FWLTi7N1XUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779260836; x=
	1779268036; bh=Yc0JG1Xn3Wha37rB1V4lbZPt4g1XIowSANBWVbYnYYg=; b=G
	nYd28z87pqNi+9PdJzaxXZwhv0d9XOb673uhc0dQ12SOzgua/kwGuDzdJ3P/KXA7
	3wKhVpJEAcXpNHTMZjPSz28yz7/3VQlDPOAQEm8pe7MlfINyfzK1hcoKLwbdpURI
	Hk6It8Ms0Ab1wLvCqX/Z2v+VOAMREM55Dx6cyIGrz1qDwQxY6oJnQ0TQmVLsz6a7
	x18qidBeC6dQgG9AvzVdYaWz5fGH40LJZ6ICpW87Lz8JV+55ZXVQG7ntZsHwiC8V
	BjtLpJkbmlL+6zqwsHrCwc+QHrWJR7sdcp/88nuk4YWvM1bzHvuomb2vkFPiWzjW
	LpQlE35CMXRAm71I7taXw==
X-ME-Sender: <xms:oV0NahcvhCqxyShf_GQCxcWNLGoQg7kHPo8XsyEnOyzCH8smWX_kgw>
    <xme:oV0NaqCKWROXJfx0jBWTTTa4aw69uXBky8ZqSpccGHX2CA4W7mw9j4kFLNIqCjeZm
    zj3xBZN6UG3wcMx_NUU-6KlVXgXHDLkNGayRxRAMjlYL0TbkACmeo0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeefleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepkedvheeghfehlefhvdehfffggfdukeekkeehleeuvdeijeeuteevgeejvdefueet
    necuffhomhgrihhnpedujedrrghsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    hedtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnuhhnohdrshgrsegrnhgrlh
    hoghdrtghomhdprhgtphhtthhopegulhgvtghhnhgvrhessggrhihlihgsrhgvrdgtohhm
    pdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhope
    guphgvnhhklhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegvnhgvlhhsohhnmhho
    ohhrvgesghhmrghilhdrtghomhdprhgtphhtthhopehnphhighhgihhnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphht
    thhopeguiihmledusehhuhhsthdrvgguuhdrtghnpdhrtghpthhtohepphgvthgvrhiise
    hinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:ol0Nah2ii_y-TksNBCT-MowRFapYyZydyI7H4QxxQH4g9XTtz8bobg>
    <xmx:ol0NarIfG5ugU7JqBORV9sTbHmRBn4g4EaMGJ4YY0AclQPdkv_bZmw>
    <xmx:ol0Nav-OOvCx4WVvnznx03vUOOFvzfTjft2gLXlcAKL364cJsd6-WA>
    <xmx:ol0NaiQ9xIABZU_YgIC_PxsPzaYvVcygjExJvggA16DtUstR3GpVrg>
    <xmx:pF0NagQ9B6Q70cBKcBExfrRFa4A-4wY7ab5nhbQQey_V9mP7bRvenXP2>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id DE0EA182007A; Wed, 20 May 2026 03:07:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AoFiOxpvQUXV
Date: Wed, 20 May 2026 09:06:33 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "schuster.simon@siemens-energy.com" <schuster.simon@siemens-energy.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Wolfram Sang" <wsa+renesas@sang-engineering.com>
Cc: "Peter Zijlstra" <peterz@infradead.org>,
 "Dinh Nguyen" <dinguyen@kernel.org>, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, workflows@vger.kernel.org,
 Linux-Arch <linux-arch@vger.kernel.org>, dmaengine@vger.kernel.org,
 linux-i2c@vger.kernel.org, linux-iio@vger.kernel.org,
 Netdev <netdev@vger.kernel.org>, linux-pci@vger.kernel.org,
 linux-pwm@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 "Jonathan Corbet" <corbet@lwn.net>,
 "Shuah Khan" <skhan@linuxfoundation.org>,
 "Rob Herring" <robh@kernel.org>,
 "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>,
 "Daniel Lezcano" <daniel.lezcano@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Alex Shi" <alexs@kernel.org>,
 "Yanteng Si" <si.yanteng@linux.dev>, "Dongliang Mu" <dzm91@hust.edu.cn>,
 "Hu Haowen" <2023002089@link.tyut.edu.cn>, "Kees Cook" <kees@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, "Will Deacon" <will@kernel.org>,
 "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Nicholas Piggin" <npiggin@gmail.com>, "Vinod Koul" <vkoul@kernel.org>,
 "Frank Li" <Frank.Li@kernel.org>, "Dave Penkler" <dpenkler@gmail.com>,
 "Andi Shyti" <andi.shyti@kernel.org>,
 "Jonathan Cameron" <jic23@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 "Andy Shevchenko" <andy@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Pieralisi" <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 "Andreas Oetken" <andreas.oetken@siemens-energy.com>
Message-Id: <76af64fa-7820-4d92-8aa9-826c3bd812a1@app.fastmail.com>
In-Reply-To: <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
References: <20260518042833.272221-1-enelsonmoore@gmail.com>
 <d40b1e80-37fc-4c88-9d7f-dae6458efe6c@app.fastmail.com>
 <20260518105735.GW3126523@noisy.programming.kicks-ass.net>
 <20260518172444.zyd47mcagrcwu7wt@dev-vm-schuster>
 <CADkSEUjhq6HSdg4ignzbuJiN5uXATsTdxFbRJ3BMxs5=WUWLDg@mail.gmail.com>
 <20260519103012.blot4bssgiqfer6p@dev-vm-schuster>
Subject: Re: [PATCH] nios2: remove the architecture
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10569-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[siemens-energy.com,gmail.com,sang-engineering.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,kernel.org,vger.kernel.org,lwn.net,linuxfoundation.org,linux.dev,hust.edu.cn,link.tyut.edu.cn,redhat.com,linux-foundation.org,gmail.com,baylibre.com,analog.com,lunn.ch,davemloft.net,google.com,siemens-energy.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCPT_COUNT_GT_50(0.00)[51];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt,netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,arndb.de:dkim,app.fastmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DE084588B44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026, at 12:30, Simon Schuster wrote:
> On Mon, May 18, 2026 at 05:13:58PM -0700, Ethan Nelson-Moore wrote:
>
> 2035 is still a rather tight timeframe for our typical support/phase-out
> period (we would hope to get close to 2040 with the SLTS extensions),
> which is also the reason for our targeted 'lifetime extension' for the
> nios2 architecture for approximately 5 years, or more precisely ~2-3
> SLTS kernels assuming the usual cadence of 2 years between SLTS versions
> (+ some safety margin).

I think that is a reasonable target. We have a bunch of embedded
architectures that have a similarly small user base and I expect
that we will want to remove most of them at some point, as we did
for seven architectures in linux-4.17.

As long as there is a maintainer for nios2 and it's not actively
getting in the way of a specific treewide change, I don't see any
reason to remove this any earlier than the other ones.

Obviously at some point nios2 will have to get removed because
of the limit to gcc-14 or older, but that should not be a problem
for the next few LTS releases.

> Sure, I'd be glad to do so, but so far I refrained from it as I was a bit
> unsure about the netiquette (can I simply do so by self-proclamation? At
> least the git history seems to suggest so...).

Dinh already replied that he welcomes the help, and I also suggested
the same thing a year ago. As the only known user that has contributed
patches in a long time, you are obviously qualified.

Sending a patch for the MAINTAINERS file to Dinh is the first step,
once he has sent that upstream, you can (optionally) apply for
kernel.org account that would let you host a git tree on kernel.org
or have a tree that you both have access to.

     Arnd

