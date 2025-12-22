Return-Path: <dmaengine+bounces-7863-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D851CCD54D8
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 10:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B9D63007C5B
	for <lists+dmaengine@lfdr.de>; Mon, 22 Dec 2025 09:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446683090CC;
	Mon, 22 Dec 2025 09:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Ad2WlJIu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f2To8LbV"
X-Original-To: dmaengine@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3977C13959D;
	Mon, 22 Dec 2025 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766395315; cv=none; b=b4AtOn8UzYgIdyTJIwU5c4hC+nuNcjf+NFmr/uaWEF5bH4QkEstZ4mDh70PKTJmON4XX2gyABPHS/BKGJBLRuFO2m3fWcd1xg/HZN9W6D8kaCiW4lU3hSaIrO46A5uNDpOBFyvIF1EuN9XF4NG0aEoKAADnde2yUDTcH7spUlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766395315; c=relaxed/simple;
	bh=cvlyUBDX6+e2wPVlgcubg2bBxCLZKZeLme9jqZ1Aqds=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=V7u6R7T9uAfWp/C0yjkSp0r8M1PJPf0UvfIXplh3+Z63sQQ+lCehe443Zr7WXqGD78ksTFFhIaxJ8m54ZS15R8adOLZe4Oh2aH3ybudT8D3tvCY+Gcc09vs+XzXjh1i/jyn07Jxx8x8Vikdk6CWirztmghtImbwHRSkCdK9Os64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Ad2WlJIu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f2To8LbV; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 441B11D00070;
	Mon, 22 Dec 2025 04:21:52 -0500 (EST)
Received: from phl-imap-17 ([10.202.2.105])
  by phl-compute-04.internal (MEProxy); Mon, 22 Dec 2025 04:21:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1766395312;
	 x=1766481712; bh=aSoxsmf+Y71lyGjCN0Q0k/Yv0E6KF5Wpn24d4lIijMo=; b=
	Ad2WlJIu+ptS2H1tq4RJyIA0bT5ydQP4JNdhOaDfcK/w41NQJ2M2//CMh6bUHA6t
	zL6QjyT1vrNhZvBQYGnrApzz6WxI/bljjrZ77LOYWrOhBNbAQj1RNyYk+14rq2+/
	cetLwGGNU5CgzSnjQkcTBxhCy95CPFKJ7WT7CiSTiE6xKOqhiPTYgHg881liAMVL
	+Q4Cm5vvUriKY80cueynBBLDEby9zrEV3VvBtcrlb6VeO3Qjx7gNmS2dwLL7sT8N
	KsJvfFuF0NJK3e1ZrdWDh6CUoCuQI0UtF99it/mKl/gPVbbHbP/A8GRRRZ1Naoo1
	Kuy7lqIAv9KhOTf1KoplqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1766395312; x=
	1766481712; bh=aSoxsmf+Y71lyGjCN0Q0k/Yv0E6KF5Wpn24d4lIijMo=; b=f
	2To8LbV4IsaPArujcUn8ofFe5MTWrTMSdvjwzY6+lTJjK0idI5NqsjMOhsX7gTnn
	GqJDqeJei2gmidChV01WMymH2j3MIw5+hvmFOpwo2RK2NoEUGwWSiQEZAnm6WZu+
	GrAUmluVCcDLmvyii56EBkW03DvGnrtquT99nlR0OYNr8oUGvpmlJLuFNvu0MNAu
	pCIOkQYEBfhAMeRj8gvjUTmJsSZ1XeaDeobrczi2GSM9h1LcmxOKS3CKuPS1JEDR
	C0iQ63XgKmRwb1emNP0fUmROjWtRAdPL2tz7q4dem5X+iWOwjbIFSFEZDeKwAqGN
	eLgHoqpNZYHN5jWWaeSyw==
X-ME-Sender: <xms:rw1JaeJRpF9DGnLw7VK3wLT7m6uJnZjUfmcphAxzB54SIrNzDqEiSg>
    <xme:rw1JaQ-9bq7Uf3zCJiqw0tZZFEU9o6VHWmwfmJkE1GZ2kUOaGIRW2iMzJBkpVC8v4
    SQsEaWbU6itznEvSmoLph7IcO_NyEWBsyuqw8o9-wNIt1tEbHuDiA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdehieehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthhqredtredtjeenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpedvhfdvkeeuudevfffftefgvdevfedvleehvddvgeejvdefhedtgeegveehfeeljeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnug
    esrghrnhgusgdruggvpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopegurghvvgdrjhhirghnghesihhnthgvlhdrtghomhdprhgtphhtthhope
    hvihhnihgtihhushdrghhomhgvshesihhnthgvlhdrtghomhdprhgtphhtthhopehthhho
    mhgrshdrfigvihhsshhstghhuhhhsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
    epughmrggvnhhgihhnvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehl
    ihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:rw1JaYihvqZ23HFMUo1kDi4npNA8hPLVsecmoGZLi0GyH4dRYjKZvQ>
    <xmx:rw1Jae8-5HMzvQ0qyr9sEpovVGoLJIituT-1pT9oNznlQlZ6KyxItg>
    <xmx:rw1JaSbHfqYnbZ0BYRWXUfOpUOcu5XxXqU1y0z9DJIxHYrtsTL9Bhw>
    <xmx:rw1Jad1Jsp6kN6Gw_SlAanQXt8rXcJv3S8-Ri4EzhTrCdngVSvb9Cg>
    <xmx:sA1Jac3aNDd2JuVIVDQDk3_OH4ljvdrqyPbjeGcYx9fQZdhpabtH5JR1>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id B6EB9C40054; Mon, 22 Dec 2025 04:21:51 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: As4msN9o8sCJ
Date: Mon, 22 Dec 2025 10:21:31 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Vinicius Costa Gomes" <vinicius.gomes@intel.com>,
 "Dave Jiang" <dave.jiang@intel.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <a4c50d48-8b5f-4b5f-9a4e-6ea1f9433c0b@app.fastmail.com>
In-Reply-To: <20251222-uapi-idxd-v1-1-baa183adb20d@linutronix.de>
References: <20251222-uapi-idxd-v1-1-baa183adb20d@linutronix.de>
Subject: Re: [PATCH] dmaengine: idxd: uapi: use UAPI types
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025, at 09:04, Thomas Wei=C3=9Fschuh wrote:
> Using libc types and headers from the UAPI headers is problematic as it
> introduces a dependency on a full C toolchain.
>
> Use the fixed-width integer types provided by the UAPI headers instead.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Acked-by: Arnd Bergmann <arnd@arndb.de>

This is certainly an improvement.=20

Since I'm looking at this file, I'd point out a few other oddities
in the header that have absolutely nothing to do with your patch:

> @@ -176,132 +172,132 @@ enum iax_completion_status {
>  #define DSA_COMP_STATUS(status)		((status) & DSA_COMP_STATUS_MASK)
>=20
>  struct dsa_hw_desc {
> -	uint32_t	pasid:20;
> -	uint32_t	rsvd:11;
> -	uint32_t	priv:1;
> -	uint32_t	flags:24;
> -	uint32_t	opcode:8;
> -	uint64_t	completion_addr;
> +	__u32	pasid:20;
> +	__u32	rsvd:11;
> +	__u32	priv:1;
> +	__u32	flags:24;
> +	__u32	opcode:8;
> +	__u64	completion_addr;

Bitfields are usually a bad idea to describe hardware structures
since the actual layout is ABI specific.

>  	union {
> -		uint8_t		expected_res;
> +		__u8		expected_res;
>  		/* create delta record */
>  		struct {
> -			uint64_t	delta_addr;
> -			uint32_t	max_delta_size;
> -			uint32_t 	delt_rsvd;
> -			uint8_t 	expected_res_mask;
> +			__u64	delta_addr;
> +			__u32	max_delta_size;
> +			__u32	delt_rsvd;
> +			__u8	expected_res_mask;
>  		};

All the outer structures are marked as __packed, but
the unions and inner structures are not, so this still
ends up with padding, and a -Wpadded warning. This came
up as one of the uapi structures that is incompatible
between x86-64 and compat i386 user space.

This ends up being harmless since other members of the
union are the same 24 byte length. For consistency, I'd
always add explicit padding, and I plan to send a patch
for all uapi structures that need this in the future.

> -		uint8_t		op_specific[24];
> +		__u8		op_specific[24];
>  	};
>  } __attribute__((packed));

The packed attribute here makes the structure unsuitable
for hardware DMA access since the compiler may generate
bytewise access. These should probably all be dropped or
changed into

__attribute__((packed, aligned(8)))

to make the structure itself aligned by the members if
some members need packing.

>   * volatile and prevent the compiler from optimize the read.
>   */
>  struct dsa_completion_record {
> -	volatile uint8_t	status;
> +	volatile __u8	status;

volatile by itself is not really sufficient to do that in
portable code, there should also be a dmb_mb() or similar
around it.

As far as I can tell, the driver cannot ever be used on
anything other than x86, so there is no harm in practice.

        Arnd

