Return-Path: <dmaengine+bounces-11357-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rGLWDfeFKGr/FgMAu9opvQ
	(envelope-from <dmaengine+bounces-11357-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 23:30:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05C664414
	for <lists+dmaengine@lfdr.de>; Tue, 09 Jun 2026 23:30:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=baylibre.com header.s=google header.b="TcmC/V6Q";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11357-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11357-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9AD03027D9C
	for <lists+dmaengine@lfdr.de>; Tue,  9 Jun 2026 21:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C1AB41168B;
	Tue,  9 Jun 2026 21:30:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFBC175A7E
	for <dmaengine@vger.kernel.org>; Tue,  9 Jun 2026 21:30:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781040628; cv=pass; b=ieQ8pSgO1DATnEfmEcmTfU7RX2JgWtLwmoNo02oTfKJ8PmiLVNgCblAuCsQGH+IVvunY2hfgNIxgZ/PTVlPuDyaYILOKUF5YM9PcgHdWTJrYdld+Vw6Ia9nOTnfQdyzO5PnUqN13bLyr8fRslnpF01k+LSDJ8vTNysOoX47GdcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781040628; c=relaxed/simple;
	bh=TbynbP/rbCQk2ywH5TiPVu9krPSvulMPQby7aN5rr0s=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZjsbOI4UReXhp2L01jjl8dB2jXxUw3GDj3sF93Q6Iu4n6Q5wj2ELNj5Z/6A5DUjw1BKaTihezcLoIOVZta2TwZSa5Z/MaDxR82RqVsRUOJZV8TIz9dMu5m72YjnWHhWmrhDGKxigPGstbXzaCHR1S/AYXciECsGH3ejzksnwQ0g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TcmC/V6Q; arc=pass smtp.client-ip=209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec354815b9so624469366b.3
        for <dmaengine@vger.kernel.org>; Tue, 09 Jun 2026 14:30:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781040625; cv=none;
        d=google.com; s=arc-20240605;
        b=RX8jVgyit/RO9T0ObY8kMr40JzqevRuguQnaHSb/jrb27/n5lRdJl4pc1w/G9+1HU+
         abz8qCHoqRjpz9KA/8yna/rqfX9/eWvlWNhvyVZ0X8keTDCYRpH96Pbk7oTvLeD/ah6R
         MlqNgzPX/anvKoaFCJINfpHM7LDfmSSAT2ykNCPhdDEI+9nVl/xXMzs3+hJeB49jApdW
         7YDOuTUjYRdX5cP4HSC11bg3j1wCxnV7HvAQrgs0b9NXoDR6WC0rtgG/W9PshtysDFsx
         Sv8jWHeBVFEjw2d+90PvZAnas2PQ+EckN8P2LeJ8/iT0pLXBZFmVTk4SEjhSIZyKZ6Gy
         ay4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        fh=0kHv3jrE4ILIIjy2tZwHLzAsA7Fr15HR7OnyfR0opwk=;
        b=TWL7Nt/J+FnUPwENXf0e90m5laIcOXdcQ0HJ0G2KOrMlJc+FzdAU0d1gxKx5WNrb4U
         sv4BSZMtg12k1QapdneacVElTlWW1Hw7XxQPVoa6/PSIHyuzrE2Xrhyvx9Dr20Uaql8A
         EAmhMO5GZO5HTxLw2mlDCL8dH4CMxOtCmJiOOA77LDY/13SiQ2Bsooe1Hi5mMMKxsqrL
         f3OXhz37DbgoxVeLnv759QSwSngz37xscsRdX72SdVu3FQBSzctrHQez2DF5bDth/zQ8
         SVEWr3g57Cq5ZTQrpOp3eURfdI2JeStA2Ncj3iARMuUxlnRzhL7rhBbrAFP9tsGvdDaW
         bfrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781040625; x=1781645425; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        b=TcmC/V6QXQfxwZKSWjtKlkvjOwoGt3xSPNg+O3KPbq/fsdAH7hoPIx2dJMRtxmQTDN
         c/FuN1pAa/+rFBM/8t6MyolmQjEbFoaajsLcwXG1asaHuZ0TYbMK9sODkclAppLdvDa8
         XEqEr8UlaPYpVpXIivFBHpa92NURMdaJ+DmTgLEoFu0oHxzM+5JLV35D+p9VDIjXHUKN
         Uvs5gA/R3tFy5Wc6kL+WSt84rmFgd588ff00SnkV/5TwmN+369ZaQj/8CpoOOQ7c8iCX
         /ZKNIoloMz0ViWo2W+9uOwnZ2zRmN7jrXekx5SWZaz+Z37Prrq/QMjiQ2YTGWz5v5osl
         CoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781040625; x=1781645425;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OyaoLWvSBSKiTIcOe7IFeaXY8jjEo9UJ9whgcmi/C6I=;
        b=IgSXB8LSmWuxXpINm6Un7Do39JJK06da+eA6t/Vwi7/j43OHPuh3nqNrXPMgTLwlJV
         guJ3svc1iTUNcBSTKhNEm1nmibcIU2D911nYDEkG36YGQXEcsdQ2TCIGu3peHth0QOjy
         TDv9EU0mP+UZH/cPMqCunKa81bti521us77zzV9iO0878gwtiSH3yjyTHVlq3at8Tl//
         wZZ3AGBPCu0UmAcDB+p2hz9SvM3uBxWk3JXnPiJlWDI6yp/EFsutmqeOghYkYu3cChiC
         pXBLdPoYg0s1/jlATPFvtu6wahwWXi+4LeykTgFlOZllEyRuBgSVM2/plylkPPV+ZRNU
         Higg==
X-Forwarded-Encrypted: i=1; AFNElJ9HbNH34KyzV+tVuyagR4cL+RbDzaidfFsMMij/tNDWmnqX3XBah9SVRs4tuJF9c6Uf0MrqX8W0RmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsXVXxoygIprlMo/SdMI4/Mx8gvMf3daa9ELKapffkwBhRO8iJ
	TSccu6eR3kWBwHp885Z5JsPxiyHzrrYcdydgvGXzFWYAGrAYbB3ARSw/Rm+hGW/8OyFnmyFoQb+
	d/cnqBFs7rgN5aOqXcIPL43dh1RM6GOAw8vyu38TcBQ==
X-Gm-Gg: Acq92OFjNCTjCyVa5YWdS+vTGsst2uE/6bgxTmgaKM9Bw/+jXBSbfHSZ1NnlB5WnV/i
	Kq8w7yATcYlk2QiOQ6kP8huCQotOTukwlzAS1cF7ZIUsS2goiS8YSi8LeB+77+4kc7xoOtwY/yQ
	VHpUFaRHMLR5nCGb5zk4O8/W+6ozSnIVQkBv77Zm6bvaKZEqAyDKf5hJur+/g8mrTjlPY/Q4FRV
	jG3GRv0fkNCRiC/fPzDRHQ/V405KMfxrXJ9i/dLg6Fxpg6xSadMRNyIv4UXViZcvbED2vPxyfzb
	LjdBRToINOBqadbYX+CkhqegloKwOo3TIgHjzXNm7V0OvcA=
X-Received: by 2002:a17:907:8693:b0:bea:3e9b:83b5 with SMTP id
 a640c23a62f3a-bf370e63a84mr999800966b.22.1781040625083; Tue, 09 Jun 2026
 14:30:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 16:30:23 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 9 Jun 2026 16:30:23 -0500
From: Angelo Dureghello <adureghello@baylibre.com>
References: <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com>
 <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org> <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
 <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
 <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
 <2b532d56-dce4-4f6d-84e0-2fd87d5494f8@kernel.org> <20260601144332.GC4918@lst.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260601144332.GC4918@lst.de>
Date: Tue, 9 Jun 2026 16:30:23 -0500
X-Gm-Features: AVVi8CezOGOq-MNrhv5y2nA_4hBEGDCtfXzAaSWT86Uo7sqynIRfYGOJbVIBc1M
Message-ID: <CALSJ-wAaOsizvHGiCdL_mSKS-LQGJKgbnUeBAnE8H+h-7xOGhg@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Christoph Hellwig <hch@lst.de>
Cc: Greg Ungerer <gerg@kernel.org>, Angelo Dureghello <adureghello@baylibre.com>, 
	Arnd Bergmann <arnd@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11357-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:gerg@kernel.org,m:adureghello@baylibre.com,m:arnd@kernel.org,m:linux-m68k@lists.linux-m68k.org,m:linux-kernel@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-can@vger.kernel.org,m:linux-spi@vger.kernel.org,m:olteanv@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,baylibre.com,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[adureghello@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,baylibre.com:dkim,baylibre.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F05C664414

Hi,

On Mon, Jun 01, 2026 at 04:43:32PM +0200, Christoph Hellwig wrote:
> On Sun, May 31, 2026 at 11:42:26PM +1000, Greg Ungerer wrote:
> > I don't think that is right. The way the underlying data cache is setup for
> > MMU ColdFire (via the ACR/CACR registers) means that individual pages cannot
> > be marked as non-cached. So coherent memory allocations are not possible -
> > at least the way things are today.
> >
> > It would be possible to set aside a chunk of RAM at kernel startup time
> > to use as a pool for coherent allocations (since it could be marked as
> > non-cached via the ACR/CACR registers), but there is no code to support doing
> > that today.
>
> With CONFIG_DMA_GLOBAL_POOL there is some generic code dealing with
> most of this.  But if this driver worked on coldfire in the past,
> it must have been fine with non-coherent memory and could use the
> non-coherent allocator.
>

Ok, thanks, so the driver is working fine with non coherent memory but may
be just for a case. I will try to setup a better SD test. And will send
another patch to have dma enabled with non coherent allocator.

Regards,
angelo

