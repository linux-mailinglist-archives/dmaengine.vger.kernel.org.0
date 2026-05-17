Return-Path: <dmaengine+bounces-10490-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEF3Ak8gCmrkwwQAu9opvQ
	(envelope-from <dmaengine+bounces-10490-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 22:08:47 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A965563AFD
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 22:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB30F300CE4D
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 20:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6EB30C179;
	Sun, 17 May 2026 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skn4WbDv"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183F3223708
	for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 20:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779048524; cv=none; b=PsMQkakNCwnd0DqntIscQWQ6jvWP7ba7aPrq8UHJyAZomo0HP0SVhQJKwtpVBwF1+e9B5kveeXe+mUE2yPF9IsZICjC3d++1d/6Dud5N6PzKWxPJFBfyPIIDl8nCzPfOHqIoArmI06DZJdGdsinuy+3CBL/OK45r6CLsvUzkTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779048524; c=relaxed/simple;
	bh=zf+st0yI5heHtI4FZ1FB5w9AS2N7hIXhtUlFxWhN0A0=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=RSv1Qx6kzC6gn7vsNWuEVK+ExdIcaiyEcGxSczsbZbSXl+Uu/D6E+dww91pV6paytT5GnHtIPR+Lbh0qoeSUZKbadFdJQrCb+DXUbeTaNF6e46nmV0gs8apXl2UzvMayM54vvH+BIyaKVquOr4RpphvTg5kuvVXY9eRAJS3HQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skn4WbDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF64CC4AF09;
	Sun, 17 May 2026 20:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779048523;
	bh=zf+st0yI5heHtI4FZ1FB5w9AS2N7hIXhtUlFxWhN0A0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=skn4WbDvz+YzVITEc2A8jMQWG/mEwxA1MR+1BDPd+IfvSaGYnSZ9lHk/QLpM49Q6T
	 c0LlbgxeLH4cPOwqeh1j4tokTG8lkBim9yAp4xlNXejrTuSE4dN5trJLNKAjfubCyQ
	 qvBpa6ElOb6MJT9zJHDqLNY6TRi7RnZJndmwy+XIk6F/TsBFY/mnzVPCymlRBgLTXd
	 3eVUD1nkIyhutnjHanw9a7II5F3eY2ADvBb/0YjfTpxM8oJo87qM7lssEfu/PWF1Cp
	 bAXT2WEHmuXQ4HV7ErGjDvlzbXSCLv546B1GJIGE4c7DuMtjF+26q+kebOKJvksx+R
	 c2u+VNkBuEIJw==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id C860BF4007A;
	Sun, 17 May 2026 16:08:42 -0400 (EDT)
Received: from phl-imap-05 ([10.202.2.95])
  by phl-compute-04.internal (MEProxy); Sun, 17 May 2026 16:08:42 -0400
X-ME-Sender: <xms:SiAKajBOiIDolb2a-kfqXaAxniwDVxeyJ3C8HynOWI8qwMgSTYi72Q>
    <xme:SiAKakU-F8DyfzAbbYSvmyQROv5ynEHlx7fw9HE4l4kBDZHIYU0nPOpy6o0_L0-2d
    cV4vtZ1_lbnQ_eR7J5fLOhLDW_VAawJuxJhX8yIlecxTa0BMTljwOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeeiledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrfgrth
    htvghrnhepjeejffetteefteekieejudeguedvgfeffeeitdduieekgeegfeekhfduhfel
    hfevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedtvdeg
    qddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrdguvg
    dpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprggu
    uhhrvghghhgvlhhlohessggrhihlihgsrhgvrdgtohhmpdhrtghpthhtohepohhlthgvrg
    hnvhesghhmrghilhdrtghomhdprhgtphhtthhopehgvghrgheskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheplhhinhhugidqmheikehksehlihhsthhsrdhlihhnuhigqdhmieekkh
    drohhrghdprhgtphhtthhopegumhgrvghnghhinhgvsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqtggrnhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhsphhisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:SiAKakTianBIt_kJfTpAUmYEDEIsRbz-RK4e6Tn06xUqLrBqrGtXeQ>
    <xmx:SiAKaiMlHYWf2OJPGa0E8bXjTkpF2wUjEXjTjbDZuGSiH8Nc2n3Y4A>
    <xmx:SiAKaig-ETwcDW2Bs9qgLLZp2xq0cxnQ8FQ8o0l1WRMYU6rDzDByng>
    <xmx:SiAKavlN24Wb70sjBSt7-4YEC_WTmYn4eUwrlV0pEiWMCpa-NsW10Q>
    <xmx:SiAKaughoEk4-LIi6rkg2hjw1pPG16O79DVmftYomWtTb3OCI6X8tIjv>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id A509E182007A; Sun, 17 May 2026 16:08:42 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Am-_gogYW4uZ
Date: Sun, 17 May 2026 22:08:22 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Angelo Dureghello" <adureghello@baylibre.com>,
 "Greg Ungerer" <gerg@kernel.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-can@vger.kernel.org,
 linux-spi@vger.kernel.org, "Vladimir Oltean" <olteanv@gmail.com>
Message-Id: <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
In-Reply-To: 
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
References: <20260506142644.3234270-2-gerg@kernel.org>
 <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
 <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5A965563AFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux-m68k.org,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10490-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,app.fastmail.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
>> On 7/5/26 05:12, Arnd Bergmann wrote:
>> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
>
> [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> [    2.280000] spi_master spi0: failed to transfer one message from queue
> [    2.290000] spi_master spi0: noqueue transfer failed
> [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
>
> DSPI is using edma, i will try to understand where the issue is asap.
>
> About how it works:
> - for accesses to edma module (IP) mmio registers, must be native
> big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.

The twist here is that with the way that readl() is defined on
coldfire as a non-swapping operation, and the generic
definition assuming the opposite in

static inline u32 ioread32be(const void __iomem *addr)
{
        return swab32(readl(addr));
}

the function called ioread32be() actually tries to access
the registers as little-endian. I can see two possible ways
we got here, but don't know which one is currect:

a) the device actually has little-endian registers (like it
   does on i.MX, but unlike all other coldfire devices), and
   you just never noticed because using ioread32be() worked
   as you expected.

b) you tested the driver using an ioread32be() definition that
   did not have a byteswap and it correctly accessed big-endian
   registers at the time, but the version in mainline today does
   not.

> - for accessing the "tcd" memory structure, that must be, from what i
> remember, anyway in little endian, independently from the cpu core
> endiannes, this is the reason that big_endian flag is needed, it is
> used for tcd area accesses, so the IP module was built.
> The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).

edma_read_tcdreg() calls into edma_readl(), which is the same function
that is used for normal register access, so from what I can tell,
they always use the same endianess here.

      Arnd

