Return-Path: <dmaengine+bounces-9586-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNbwEBcKwWmtPwQAu9opvQ
	(envelope-from <dmaengine+bounces-9586-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 10:38:31 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD0B2EF31B
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 10:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 135473031B16
	for <lists+dmaengine@lfdr.de>; Mon, 23 Mar 2026 09:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9A838552C;
	Mon, 23 Mar 2026 09:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUrYX+cZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A118737BE66
	for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 09:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774258408; cv=none; b=V5GvHLM8I6uza0oKM5VVXI+4aYLcVsILu6i2mdY+tGB4zbNyCcNirGJ4yAyATtMhzfj7IyjWIeY+FV95REZfUO4CN2GGmh3izIY+8zAkk25dSw7Pe5c7dUwgGzdr3sX7OUWq65mBxhoRB0fUAyegxsPZ352R63L6EvCMZUoBlAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774258408; c=relaxed/simple;
	bh=KRxBm1ceWdh4JSdKGz9/QEaRpfyX/bIND2I+6uxavEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=swVXLc8d7+OURKDHu8RxpIo5bmJDQ5V1fsvQ+JncygxrDkTfDN3IkVZb4F+FucfAJIWdWmBBr5c8TNf4YSc4sLKDau+ogbvELREnH0Q5MdP/S1mqyK7ls3fQp9u0Fz3YIzIPxKRaZdWr46IXl08ON7UTMGwneOLbt0irobJpnh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUrYX+cZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-487012ce896so12673945e9.0
        for <dmaengine@vger.kernel.org>; Mon, 23 Mar 2026 02:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774258405; x=1774863205; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KRxBm1ceWdh4JSdKGz9/QEaRpfyX/bIND2I+6uxavEo=;
        b=UUrYX+cZ/ThZ7itPqX1uBUO82xlx0UAvMlDX9oJo8apuGXxescmMwhFiYsf1G9JL3B
         RWJzHgx9FL4tNAk25hDyRS4MbQD6tlemTSQv98SJlnuKjd+S423Cgw9U84Wwt4xOKYXg
         DnebftcuaFa2IAnj/oUhCAE+4QZxJeHIL4w+fIf68l9GFop8HUDaUxFmEiPpCOXyAPri
         R3lV9rm8rktSGKkMXTk1Dq6pEwFekYzj7gFfnA3bPLI1opCJ5Coy+6QjszLNAvrHHijn
         ac3CY7k888Tu++pGC/bt8xMCtlEXWhMjPzUZoHU2y3ACPwIytmUgep1ihg8dY2Npt1kj
         AFjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774258405; x=1774863205;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRxBm1ceWdh4JSdKGz9/QEaRpfyX/bIND2I+6uxavEo=;
        b=LZIyQcthm+fyw6v2F3SJj9jysFvEr60THQ+VXrzn1/3xaxxGQwu99zYYUWJYuMdv6E
         kJ8nnzovpOp+duYiiltzoYmMktjTKTSB0MpDrhd3CCMWn1SOtNEGoEZ6TdcvbaG7rJXB
         XyzQ8hgHYxlefahHPG3hxmOTsihbNT2+o5jP4hSGctJoZaA1vdajhmzd2ZLPVvk4/5Uk
         SxrOMhK6CjZgaiT5IBE3kU3/hbtkubDKR+CdSEzuPVaUDEAfiM55F35hnC8mp5MQsr9D
         KCJSmVUhm9WFIKyA0fa3n8cbxzIvUKpdUPkG7Tm8kb9NOaM+Hxi6qcY/jMDizDBGI9wQ
         F3TQ==
X-Gm-Message-State: AOJu0YwqiDCHZX6PurvnwMmo1ZO/hBQsWpvK4JNuVIT0q6fhPZ7d/cPl
	/ou8QrnEfbC6me4sUp5prfVB4AvGZRof6vvzl5DJzjPrRd6I2eS9sn3u
X-Gm-Gg: ATEYQzx8tOmrr9FslIXi2EnIBhrrV81BPQ0QrrSvth/Ksu/2Aa4TGa2vX5WU64ekrXV
	VseOnx8jB3TG8t/xOG/fUnxTkehW1oW6YojI4b9Cu7zs0bVA8bPM9spVT+4QochRTXRvx/z5DWu
	59aTnuLzcfLSnNj7KU5dYm6QNL05EoaDXWu6PyR0WB5i8Vjtv+npqjLXNe0KuROHJ6DQzzZEVsX
	MSekqJLOLkwEBl95lHp8H75FZAzofgTP82cf2trWPgDcoXkZirS/JCHDOWlo9659ia7O5waEyHm
	YYsbPNN5ZvMvIadww2mY25FDvLmkGSL0Xv1kXPAjJDNfA1bdkIIBv4exol6A1SV/e7tKZjlRRHr
	qeD/lwh8giPhYMxwtZKpj+JqyOhuAPlG6jXkPYzNSAyFUsEgulX0ffQNE/ACHM0JoM2KyJLZON9
	/owLhSQwORLgFiRsDqAh0m58u83zqu3z0=
X-Received: by 2002:a05:600c:4fc9:b0:483:6a8d:b2f9 with SMTP id 5b1f17b1804b1-486fede7393mr160520115e9.5.1774258404714;
        Mon, 23 Mar 2026 02:33:24 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48700524864sm98310685e9.5.2026.03.23.02.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 02:33:24 -0700 (PDT)
Message-ID: <8b6cd66550d7c3cbee0fe1f488d87f00beef12a9.camel@gmail.com>
Subject: Re: [PATCH v2 0/5] dmaengine: dma-axi-dmac: Add cyclic transfer
 support and graceful termination
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>, Frank Li
 <Frank.Li@nxp.com>
Date: Mon, 23 Mar 2026 09:34:10 +0000
In-Reply-To: <abkoXXbaxaiqbBuX@vaman>
References: <20260303-axi-dac-cyclic-support-v2-0-0db27b4be95a@analog.com>
	 <177304239096.87946.15531982345548560058.b4-ty@kernel.org>
	 <c4e7e6f071ce0e7dfdd624b3b31077e2b0f4e454.camel@gmail.com>
	 <abkoXXbaxaiqbBuX@vaman>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9586-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADD0B2EF31B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-03-17 at 15:39 +0530, Vinod Koul wrote:
> On 09-03-26, 13:30, Nuno S=C3=A1 wrote:
> > On Mon, 2026-03-09 at 08:46 +0100, Vinod Koul wrote:
> > Thanks for applying the patches. Since I have you here and if you have =
5 min I would like to
> > ask you for some clarifications. It seems there's a bit of a confusion =
regarding src_addr_widths
> > and dst_addr_widths. For instance the docs say the following:
> >=20
> > " bit mask of src addr widths the channel supports.
> > Width is specified in bytes, e.g. for a channel supporting
> > a width of 4 the mask should have BIT(4) set."
> >=20
> > And I suspect that BIT(4) is leading into some confusion. Like, if I ha=
ve a width of 4, then my
> > mask should look like 0x04 and not 0x20, right? Like the code in [1] lo=
oks suspicious to me...
> > And
> > it seems that pattern is followed in a lot of other places. If I look a=
t [2], then it looks more
> > with what I would expect.
> >=20
> > Like, if the correct way is 1), then it means that 64bytes is not reall=
y possible right now
> > given
> > that BIT(64) is UB and that looks a bit limitating and odd to me. That =
and given that the
> > AXI_DMAC
> > might also suffer from a, possible bug, made me want to clarify this.
>=20
> If you look at the field it documents "@src_addr_width: this is the width=
 in bytes of the source
> (RX)
> =C2=A0* register where DMA data shall be read. If the source is memory th=
is
> =C2=A0* may be ignored depending on architecture. Legal values: 1, 2, 3, =
4,
> =C2=A0* 8, 16, 32, 64, 128."

Yeah, I figured. It seems some drivers are using the enum directly as the m=
ask instead for BIT(x).

>=20
> We cant have bitmask as 64bit wont work! So I guess lets fix it

I do have a working patch locally. I'll send it later this week.

- Nuno S=C3=A1


