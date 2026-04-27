Return-Path: <dmaengine+bounces-10160-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CszAp/a72mvGwEAu9opvQ
	(envelope-from <dmaengine+bounces-10160-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 23:52:31 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A50347AF4C
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 23:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 856A730093A7
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 21:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A41E2F9D85;
	Mon, 27 Apr 2026 21:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KMbVx6dF"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CBD4CB5B
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 21:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326747; cv=none; b=cNVWTGnTRWtpCL967RmwyacjcMMjHL5UY7kviRYB9NCwxdepE/JdniG+T7EJ3+9KuH5ARjtfdJPbg/b0zSGdlyDz/SQKyYRIiEWUyuMtYxi28DuqnAguIJb/G8iCt9hrNc5Us/ZYn4nPOmiFDRDwIbnKGkHYZZiI4guSaRvdUS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326747; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUg+bkNz3PNsID+LqtvEoHE2Sur0aNQjrJ7Tb7hwgiHTv/0J9D0srlCj/pcrFuOtmyuCZYrW5Tfwvhhryc9xwNG8nMPoevANjUco6/UoLFgbVsasF8SicespU6qE4UUG3QB+a/n7+XDeoDsr5nGtPh3IMm3/VYsojazh6nd8Fys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=KMbVx6dF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f9568e074so1772544566b.0
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 14:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326744; x=1777931544; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=KMbVx6dFZM9arFT+vWwXgJNIDxEsaYpVfVTVp8ZNJudkD23NzoKEPfV5b4l1sVHDHy
         1E9VJHF6LPvCHv1nlCIip2g8hx/UIGaqcnSSh9gHSyUdGOb+ljfRE7VPgFqKrbiak5xZ
         IlQdbBMZLahNFmE+ZA5y7YjiZhR6Z6yg/mGic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326744; x=1777931544;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=VD93+EjlHpudbQwf8mO7S8b/bjeJd4qfe3f27hUTixbCa6BC+QRwRAxa4wytJfGQkl
         mVxIfbTAasYR9nznLW9lf2lHw8fqh8gK7WpagjFhxnIV8TDNpDix10+3+yDhB95plzGw
         1EYua5/8T2fEDTP4QjSrlosECfMhp/BPe/RpDlrPvToeZkALXBTrDvijonrc1V33mNr6
         ZWjze1L1PZcD+gueRlZlP1D/Cc7oiObJEA5m4X7iuB42V8bIdFcr/If3flti9yP1rop3
         7Co0IWsCa6evId5it9XMMkZfc3p1t6SnDCdYgVgIZjstiH4lwDQjNur4Q5GwbECrTvSG
         zSgA==
X-Forwarded-Encrypted: i=1; AFNElJ86RlB6EL/SmXH8gQGdrOvISF/wxHoUIbqMyRoNhfdpOJvJTg6qiomAuLnImiTYzxptd32AZO5yWHM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLKehWHEJDG8T2M++k4uTl0rYpsHKfqq8j17JOmfxqYEmyoTpM
	OD9Thhnb8TTjz4JwKs2LIUhOlbiWykRNiSfNsFhXUHjxS/O5GAuyuyMTuxuDIp8n3BUv4hZ2NvH
	QRF5QRjdtbg==
X-Gm-Gg: AeBDievNSYZ15yG6V+/NDtLZ6YyoB1vauqvE/QzBf9kf2vNkYGQ9WZwJGkx3BIB5n2G
	CyrbmRdZQ7Gr1I5T55TGPD247zsqHac/hcG60QPS7xy/vs/h4mK8Cmn2/kMmpvQgEIo1Qw+FnDk
	VtGUWqpv2XlmCZpdYvF0COcZMwuznUV0Uo1a2a4SdEl76WB23dohTPn1FuRm39RpDjVaiyCu9eh
	Qqsgk4ww108T4iG/+YQWKlFzRtaTSaujbmIfkOo3lphV8b7aaxD+05eW7byy2cMVeKN6k03mz+U
	CCPv0l6fhkw2m8NUKfgVulaoE97ZUM/IdNtWf1pj7ELpSFeNUCsNg8v0mXpuWl7If/jT0myTDHS
	TuxomcQG/0wf/dpFXKul+FvtcXZvwAe8ORYBkDaBJQng5TSR3w8tYfQKXEUyBAAzoA9efxGPlST
	RSZvnITyNZoTDDe++FLfXfTV2WYbSVmxUipgJnQ9V+/T8OzKy3brDGB87WJbn+mVLSCrlmRk9qG
	HyWYoIrfBo=
X-Received: by 2002:a17:907:6d1b:b0:b9c:3d56:e4ec with SMTP id a640c23a62f3a-bb8037784famr31122766b.24.1777326743739;
        Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80bd91f49sm9971766b.51.2026.04.27.14.52.22
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:52:23 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so16193141a12.3
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 14:52:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/xw0RIyqXPrMQUNhL/z7DVJK/YIQ2FDZa6z18TW2w1df4gRqd4VJeS56Gy8U5WwiOo7FE+UYMudYU=@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4A50347AF4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10160-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[torvalds@linux-foundation.org,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux-foundation.org:dkim,nvidia.com:email]

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus

