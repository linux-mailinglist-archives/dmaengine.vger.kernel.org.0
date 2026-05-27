Return-Path: <dmaengine+bounces-10973-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G3mMXjFFmrOqgcAu9opvQ
	(envelope-from <dmaengine+bounces-10973-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 12:20:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 827A35E288E
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 12:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A98013019817
	for <lists+dmaengine@lfdr.de>; Wed, 27 May 2026 10:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F9D3DEAC1;
	Wed, 27 May 2026 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AgrenHeF"
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF84A3E0087
	for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 10:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876873; cv=none; b=enCCmJ0m/xMd26peDkXRvWfyxt4kTTJd3qk4UBitP9EIFEghr1TUtwQWM/QKvJX21Roo9r9j8i4nsQG0ewWWu2Fz599aA07A4tWrodEmzFAhUHzQ/92nNZLfXTmWxkmFfbxp7L8C576Ugn3PYI7kVh3vrrcvvZNkzjtWPsRyD6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876873; c=relaxed/simple;
	bh=i+a6ES9k4qMXke1lKhLxqe4tQHAM74ug7t0WxpH6nMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SXlJ8M1bbgo+3otWvJHFLVTzkesIk82KrflKwtJ3i6SNeYpUAt6MeLkUffMoKS0qZY6LypbjKa8ICblQBIuXf/1fLXy0fxO/GaQucaGSQad6VC/iHgD8AIybKLrC3x9/dXbNFnAp2w0j5kDKoYSK2yXTvkRXGpyczHT2xnMBvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AgrenHeF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C6F51F00A3C
	for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779876865;
	bh=wyp3LEuIpSMecSYlF89GeYwIafNLAOLt3ZDaQLTASAM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AgrenHeF5KNnz8Wo0H+M4M7cpFKo1CX+8UrSpHYqe6Smb2LOiSirjaEe96kqFdlWm
	 wYkuwDNi8svkRkJorERhkv2eZ5Aa4epDp3q/FpfEjM0SwwFUFx6Gwm1RSyIM4O24cu
	 59+wElnJtHBi+X//9Ns9bk3ZaYy4YXk8ltxlyWmzqCSegHbideKb/CMvWYAsyYdFCx
	 5uTkttpx5CoJqr1pPkiY/oWpQQU3B1wlzTIxPCLSrgThJd4Vqp6yu3YL+6QWgEV6Ct
	 xuog0OMR8nmTt/jluKlWVDS2UAevJB8ILsqpgS8+iGlZBKi7a9eh6Y6fqMZr4i2or+
	 1qFiOP8Vss6/A==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a877510541so12535682e87.2
        for <dmaengine@vger.kernel.org>; Wed, 27 May 2026 03:14:25 -0700 (PDT)
X-Gm-Message-State: AOJu0Yya6HstEfPEHzDqLfo6VWLNs5J26iGT+DBe/HVQZBmxkElkNnYC
	muhBjEj37phoc8NmeKLxUwDqxV62PotJI8Ot2a/l10N3onwa8PCR01NJL1Ea/syGK3RsEa/7By5
	oMmLBthmGQeYc4We3D8IstVj2zF/icc0=
X-Received: by 2002:a05:6512:31c8:b0:5a8:71ab:294a with SMTP id
 2adb3069b0e04-5aa3237d4f9mr6996183e87.2.1779876864000; Wed, 27 May 2026
 03:14:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526201552.13376-1-rosenp@gmail.com>
In-Reply-To: <20260526201552.13376-1-rosenp@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 27 May 2026 12:14:11 +0200
X-Gmail-Original-Message-ID: <CAD++jL=W-gcheTLgfJvFU4CBeHkxQ5gcwbzQA10PNE0eP0=nxw@mail.gmail.com>
X-Gm-Features: AVHnY4IhkhSPQ_Y4Fv0BX1iknBR8l12AAn8QQBDBpYk8LDuUupH4qFmIhr0E-Dk
Message-ID: <CAD++jL=W-gcheTLgfJvFU4CBeHkxQ5gcwbzQA10PNE0eP0=nxw@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: ste_dma40: turn d40_base phy_chans into a
 flexible array
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, 
	"moderated list:ARM/NOMADIK/Ux500 ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10973-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 827A35E288E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Rosen,

thanks for your patch!

On Tue, May 26, 2026 at 10:16=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wro=
te:

> Convert the separately-offset phy_chans pointer to a C99 flexible array
> member at the end of struct d40_base, and switch the allocation to
> struct_size(). The log_chans and memcpy_chans slots continue to live
> in the same allocation immediately after phy_chans, indexed via
> base->log_chans. This removes the hand-rolled pointer fixup that
> recomputed phy_chans from base + ALIGN(sizeof(struct d40_base), 4).
>
> Assisted-by: Claude:Opus-4.7
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

OK!

Please add

unsigned int num_phy_chans

> +       struct d40_chan                  phy_chans[];

and

phy_chans[] __counted_by(num_phy_chans);


> -       base =3D devm_kzalloc(dev,
> -               ALIGN(sizeof(struct d40_base), 4) +
> -               (num_phy_chans + num_log_chans + num_memcpy_chans) *
> -               sizeof(struct d40_chan), GFP_KERNEL);
> +       alloc_size =3D struct_size(base, phy_chans, num_phy_chans);
> +       alloc_size +=3D sizeof(*base->log_chans) * (num_log_chans + num_m=
emcpy_chans);
> +       base =3D devm_kzalloc(dev, alloc_size, GFP_KERNEL);

Please describe exactly how the ALIGN(sizeof(struct d40_base), 4) requireme=
nt
is met by the new code?

The phy_chans will be read by hardware which depends on this specific
alignment otherwise the data will be corrupted.

Yours,
Linus Walleij

