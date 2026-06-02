Return-Path: <dmaengine+bounces-11118-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Jp8BNecHmq5CgAAu9opvQ
	(envelope-from <dmaengine+bounces-11118-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 11:05:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7F962B0B3
	for <lists+dmaengine@lfdr.de>; Tue, 02 Jun 2026 11:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADD09300BEBC
	for <lists+dmaengine@lfdr.de>; Tue,  2 Jun 2026 09:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F72035E1AF;
	Tue,  2 Jun 2026 09:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwFpFOlJ"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768EE35DA7B
	for <dmaengine@vger.kernel.org>; Tue,  2 Jun 2026 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780390830; cv=none; b=WzklpkbpNuM5+cGKQ5pqcJz6iLGePmNo1DcCeIHgsjT9JYplj9eG/lPnkuNaY8KHY86qZE5hMRwFAevB4JzCeiwb1NXSbASpPvVK4m8EB9lH1mq1bOYhFWHjv1ES4+qIeZpEOFcFl9pDcDOBWTdrMvSg2kVq0bPXqv/JGZiYYxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780390830; c=relaxed/simple;
	bh=FHDgS8AMhT4R95VWt+Yyv0IendpljPix7abNFklWbL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B0hxRN3tVINHRC4VNYGwv6+bLSqJJtxRDge2YFZy7rolJuyGzNYxmmteJ9/fpHXdxZdhHeOMXXHbqr7atn8IpDQ+kHF5OQe/bINOou5hw0b/coEeK0TFam0mQctDqTKtzzV1t+1une9/mZVhijhbmTxkrwA75hhtQJLRQOe67UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwFpFOlJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354401F00899
	for <dmaengine@vger.kernel.org>; Tue,  2 Jun 2026 09:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780390829;
	bh=FHDgS8AMhT4R95VWt+Yyv0IendpljPix7abNFklWbL0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CwFpFOlJSZDYsWyc5MnOra61cEb7iNH6oNV9Or6XaDikLzEZz45m3BwF9TsIsvt+N
	 7Ecd7gfoz7XnbYshQbKUZMV0DLzylwhmMqvlHoYwtHS8jbxBs5+qS9fcge01TOs+10
	 x/jnermS3EhLM4RCXfcCgnA8L1pTD+tXSRcQLEQHv5UOkUNFcMLQpvKtR1uD/ImgVR
	 0YLlIwr804Gxv4E/NXGZqbSl3Opz2PWe03k+xMccwgpmmocdO3M7G03L3faHjiQ6aL
	 8OmdNGA07Uvgg853nyKfAfr2P0m8NgXFIuSNivt0gwZk0V9XiObzVFeugYXlP7lswl
	 xJYL/1lrLmr3Q==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-396669329fbso25108931fa.0
        for <dmaengine@vger.kernel.org>; Tue, 02 Jun 2026 02:00:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YzATaalAZ19a2mbU53skB4k90dCT17/GJfE33FoNMXffjuCHmJZ
	L7SfO/S/0J29zLQ9hzAlvmdFkwnC5mjGDGSUaIlr5FjZeKUaDogFpGPzqekYcFHOQANm4B6bLPH
	0tuvDPDqDS8aohMd2Zs7mT9vTzjNjXMQ=
X-Received: by 2002:a05:651c:b2c:b0:396:a647:76f5 with SMTP id
 38308e7fff4ca-396a647a3cfmr3186821fa.5.1780390827982; Tue, 02 Jun 2026
 02:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531020843.594892-1-rosenp@gmail.com>
In-Reply-To: <20260531020843.594892-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 2 Jun 2026 11:00:14 +0200
X-Gmail-Original-Message-ID: <CAD++jLn9f4DdKp7Hwrfeaq0KhCNYXEjOs8+h7tyJMDNKUxDxXA@mail.gmail.com>
X-Gm-Features: AVHnY4LUYkGkjiqMzJmXJD25YPum2COv0RcAhRJ5_yU8NcSILWYb3quNRFCF5Ls
Message-ID: <CAD++jLn9f4DdKp7Hwrfeaq0KhCNYXEjOs8+h7tyJMDNKUxDxXA@mail.gmail.com>
Subject: Re: [PATCHv3] dmaengine: ste_dma40: turn d40_base phy_chans into a
 flexible array
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, 
	"moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0A7F962B0B3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11118-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Action: no action

On Sun, May 31, 2026 at 4:09=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wrot=
e:

> Convert the separately-offset phy_chans pointer to a C99 flexible array
> member at the end of struct d40_base, and switch the allocation to
> struct_size(). The log_chans and memcpy_chans slots continue to live
> in the same allocation immediately after phy_chans, indexed via
> base->log_chans. This removes the hand-rolled pointer fixup that
> recomputed phy_chans from base + ALIGN(sizeof(struct d40_base), 4).
>
> The ALIGN(sizeof(struct d40_base), 4) requirement is met implicitly by th=
e
> C compiler when using a flexible array member. With struct d40_chan
> phy_chans[] as the last member, the C standard guarantees
> sizeof(struct d40_base) includes trailing padding to satisfy the alignmen=
t
> of the flexible array element type (struct d40_chan). Since struct d40_ch=
an
> contains members like spinlock_t, pointers, and struct dma_chan =E2=80=94=
 all with
> alignment =E2=89=A5 4 =E2=80=94 the compiler ensures sizeof(struct d40_ba=
se) is already a
> multiple of _Alignof(struct d40_chan) >=3D 4. The struct_size() macro the=
n
> computes sizeof(struct d40_base) + sizeof(struct d40_chan) * num_phy_chan=
s,
> so phy_chans[0] lands at a properly aligned offset without needing the ma=
nual
> ALIGN.
>
> Assisted-by: Claude:Opus-4.7
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij

