Return-Path: <dmaengine+bounces-11045-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AhkwDSNlGmpo4AgAu9opvQ
	(envelope-from <dmaengine+bounces-11045-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 06:18:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9596360B3AA
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 06:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C013304C06D
	for <lists+dmaengine@lfdr.de>; Sat, 30 May 2026 04:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615E2F0C45;
	Sat, 30 May 2026 04:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sSlmG4sX"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BFD30E853
	for <dmaengine@vger.kernel.org>; Sat, 30 May 2026 04:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780114719; cv=pass; b=tfQYr/Jnhur1apyadKHlVvJIjCWshbFGR9oIPQIBFPOPjaX8TS4seSUIFzOeBghryUTba1ZUSPA0uCnWUZMPsZoaLLMkyFuVngAk6eTpGUBiY5nZ6Rgs4HZKFx8Ndf2HDuOSokwP8g4bPLmOGpxUoemfJskNwXrs+PumHukZ6bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780114719; c=relaxed/simple;
	bh=wt7vymfuvb00mlogfJIV49ibnO1dnFDAFSRvrqXEuRA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gOBw535404zXk8TIwUWqXUgI3vJgTOgEEaFirpMmwwl/xLoXVL7eX133eI9imupYv0CCl3bjq9yafNpdVtsx+YAZ30CVAO2abcUrskKxO3CeaZcMxEgr5MT+aQLVxRm6O9HeAibQ7nHHVAD7saj6/FJyvvo5z95FVDZzAb7Bn64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sSlmG4sX; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68ca6f01079so403410a12.0
        for <dmaengine@vger.kernel.org>; Fri, 29 May 2026 21:18:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780114716; cv=none;
        d=google.com; s=arc-20240605;
        b=DSiNFHSNB8BqucFg8Qbb7Tzdki5Sh31O/2bo6gqx/xab2QfBHEmOIyt0vU6mIG6YM9
         ECmlDgVCSSz/6WeHNCwJC6Fa5s6SkP+hKj/Eqavaaro4yjia1HuYdTf7AazGLs0+IzE9
         prl/xH9sntUq4qv5eOQev1TKlT9IOQFrOC1WvJIhLyY+DIS1ZIa/tQBNqF1DOaGQF/lb
         tNY0uvUD19QIWkjUjfd96NQOvs5iV3+rSrfblX8iNf7Q8mdAPb4HbN0nt9lMMC0pB0/M
         QqmjMXRzSCUc3J85DFib0fAovpoLuJFVd7gHiCnly4VsRPRUZ8/iZ7VcYmWbweGAUNcm
         e7WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hErNnC1lMlzvaZQ75VA5piTpzFVvISuyV2i8pxTk4yY=;
        fh=Jv6cvDHfyYdiVtF3DafBi2UY8wIEHrQytBEgWDH9L6Q=;
        b=PENclw1zJ/xSyDT71kuJZTbYCwTNHTet0HQ+bE5bBOV3eBNOwPRJ1sMduBg9puoXq6
         jZqkpbVTPZYkrO8z4G1sgQZClCuq//vsfmyightTuY0z1+PeP7Z0s9Cjfc1m9vh3Tzo3
         B6UlQzuk+D5/qVgoPci1y638G+ROJO3UF6hNpgS1glT1f7cr+T7VsrWDARXba48JbMR+
         E6UJxNM0k9/7mSrsNwq3p1ca7sdxm9RZlpxcgvBhuVbp9iRhr1kDGwJig7YrxWAG0qEl
         PTRV/hK+sh2ky1ev1CD9sSntI/sIiIwqvQzx+5bFgCGoSkF+d/dqNSX7Z21CnuygnPES
         bQ8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780114716; x=1780719516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hErNnC1lMlzvaZQ75VA5piTpzFVvISuyV2i8pxTk4yY=;
        b=sSlmG4sXUARcziYMBMlXJkL0sBVriq+WKmj5raPtR7l8CEjeP3Qqsegx161WnoLA5w
         m9tdOAmAbuRJ2XO5R8PgO/GGaw+hxuhWbTc1t09DTx1/oL/MsQDVcvinG3nUJGpULfRs
         YB164W8RUGMny6832yY64U/htA/2MGzZFTxg5QU7XtNsYbRZL1KBQ01K7SOLQJlclhB8
         BDBRcc4WVbNktDtxhBQuyqB06c2BQTs5uJhptl1RuMjwn4eZNOn0XRGf9U1szGSmHSyh
         SQK+7SX80g67rk0XTbdEJnq3gMOcwz3BLUF9IjftY8hLOC8gRyCEEknOwCDDvMdMv+bc
         nJoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780114716; x=1780719516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hErNnC1lMlzvaZQ75VA5piTpzFVvISuyV2i8pxTk4yY=;
        b=TFH0R7y8tYXlQfxtqFV4D2QiyrbGsgKkobezdZ4F/4PAKesVL+ea67MznCC5+dENgX
         nTEhu6HxnxmuvhowpuGwPAwmlea2r16mEKjmN3jJs896Nnf67Bykl6Yn6OhPLK+l7EED
         6eWaFOBUkx2ix/h5pS3XEdZ5RivVfKt3X1dVPRao+34P1/G5ZvbQlLztDjwi+RX95Hg3
         JkJrrqk+0PKkbeRGOjAb14ShoFpgLbHeuHw4Q2EPyMAFB8aDfff4Gn2Fo/gcy2aEsQrc
         cyqOjOWoNVjGUeNJ6suFQEj3SHgWxM42IJdnP/Ma0uZfbeJzgZG+hODLmby7IiHiD8zv
         bwBA==
X-Forwarded-Encrypted: i=1; AFNElJ/WYpwwurjWmGzbuxb9YNLC6ekskgddzBbvdBijX3cxOn47qz9aMBoNDn76WL7LdIyneAXfspAnpcU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIFnbJSdKZuBMC64Oq6wyUC5mMtSQUsjs8TWjR4B9aIU6/2hRE
	d9gH+lFovlpme7SYqbQtl5v2sWVrbwyIBXosTW721Si3A8hTvyqjmufw5W9IbYR0KtWZESc3hMc
	bcVYt5qh5RzTDGzYoRx12VCNbtTyLZxM=
X-Gm-Gg: Acq92OHTOrHOHzVtjKJXYsWapd9JKwfJXzZFIFVrwcLn8oJ0YHKV2PNNBw7E5028FlF
	szJHTVwIh0V4wbEj8r8tflBXKFOH17CICYXTtmzwWM9wkfUOTV/OlkyiohJn1j7UdxY+GaDpGDM
	n6ts65DCMxHs83pJd5YockLXIIAVCqML5v0ui0TFe9ttRkv6jDXNnii561QQWJs4vdZsXEL1RXl
	qdqwymMaUXRCLfOe4syXn9Vc5MNFEx5ZSLLw9tv/0A3VdP1X41lV/w7dtmma9urncFs/rdMcfQk
	4/Rxkp+vlNpDKuotVo5jqUJ7n8Z4DnIJQ8H1MkvlIWSWSa0E/Lq86qRVP8bbwPt9ytb+n0Ni76R
	rOsv5OHL+KDy3S22ji6aplfi1EpVHKiyb+2Y2MvsmhrNZnDmhXaNCUs6WL7/vyrnz74LUdsmce/
	y8GMc=
X-Received: by 2002:a50:cc4b:0:b0:687:7fc4:1ea5 with SMTP id
 4fb4d7f45d1cf-68c8d0076fbmr934151a12.23.1780114715584; Fri, 29 May 2026
 21:18:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530030152.49759-1-rosenp@gmail.com> <20260530031259.A630B1F00893@smtp.kernel.org>
In-Reply-To: <20260530031259.A630B1F00893@smtp.kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 29 May 2026 21:18:23 -0700
X-Gm-Features: AVHnY4LE4rbusb4FylXC6QnjDFW8i-P8aeafMpSxzTJ-JOOmjN1LqDrPgB91-lM
Message-ID: <CAKxU2N_Vc1CuONb0gwi-3afzLoEfo0+d0M9w9R9GtO-q6GpgRg@mail.gmail.com>
Subject: Re: [PATCH] bestcomm/gen_bd: fix out-of-bounds access in PSC
 parameter lookup
To: sashiko-reviews@lists.linux.dev
Cc: vkoul@kernel.org, dmaengine@vger.kernel.org, Frank.Li@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11045-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,dmaengine@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9596360B3AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 8:13=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [Critical] Unchecked array access in `mpc512x_psc_alloc_clock` and rela=
ted clock functions where `psc_num` derived from device tree is used to ind=
ex arrays, causing out-of-bounds reads and writes.
> --
>
> commit 7a3c433b5cd814a1fd0d2b57113cd41cb03279a5
> Author: Rosen Penev <rosenp@gmail.com>
>
> bestcomm/gen_bd: fix out-of-bounds access in PSC parameter lookup
>
> This commit fixes an out-of-bounds access issue in bcom_psc_gen_bd_rx_ini=
t()
> and bcom_psc_gen_bd_tx_init() by properly using ARRAY_SIZE() for bounds
> checking on psc_num. It also removes an unused forward declaration in
> bcom_psc_gen_bd_tx_init().
>
> > diff --git a/drivers/dma/bestcomm/gen_bd.c b/drivers/dma/bestcomm/gen_b=
d.c
> > index 8a24a5cbc2633..75d1a6f543df9 100644
> > --- a/drivers/dma/bestcomm/gen_bd.c
> > +++ b/drivers/dma/bestcomm/gen_bd.c
> > @@ -315,7 +315,7 @@ static struct bcom_psc_params {
> >  struct bcom_task * bcom_psc_gen_bd_rx_init(unsigned psc_num, int queue=
_len,
> >                                          phys_addr_t fifo, int maxbufsi=
ze)
> >  {
> > -     if (psc_num >=3D MPC52xx_PSC_MAXNUM)
> > +     if (psc_num >=3D ARRAY_SIZE(bcom_psc_params))
>
> [Severity: Critical]
> This is a pre-existing issue, but while looking at this fix for the psc_n=
um
> bounds checking, I noticed a similar unchecked array access regression ve=
ctor
> using psc_num in drivers/tty/serial/mpc52xx_uart.c.
cross driver review. Impressive. How is anyone supposed to get anything mer=
ged?
>
> In mpc512x_psc_alloc_clock(), psc_num is calculated directly from
> port->mapbase:
>
> drivers/tty/serial/mpc52xx_uart.c:mpc512x_psc_alloc_clock() {
>         ...
>         psc_num =3D (port->mapbase & 0xf00) >> 8;
>         ...
>         psc_mclk_clk[psc_num] =3D clk;
>         ...
> }
>
> Because port->mapbase comes from the device tree via
> of_address_to_resource(), a malformed device tree could supply an address
> like 0x11F00, allowing psc_num to evaluate up to 15.
>
> Since psc_mclk_clk and psc_ipg_clk are arrays sized to MPC52xx_PSC_MAXNUM
> (which is 12 when CONFIG_PPC_MPC512x is defined), wouldn't this allow an
> out-of-bounds write of a pointer to the BSS section?
>
> The exact same unchecked psc_num calculation also appears in
> mpc512x_psc_relse_clock() and mpc512x_psc_endis_clock(), leading to simil=
ar
> out-of-bounds reads and writes.
>
> >               return NULL;
> >
> >       return bcom_gen_bd_rx_init(queue_len, fifo,
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260530030152.49=
759-1-rosenp@gmail.com?part=3D1

