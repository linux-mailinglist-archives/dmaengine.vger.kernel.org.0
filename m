Return-Path: <dmaengine+bounces-10183-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oC5VLFyA8GlSUAEAu9opvQ
	(envelope-from <dmaengine+bounces-10183-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:39:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4993A481A66
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 11:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91A263128F19
	for <lists+dmaengine@lfdr.de>; Tue, 28 Apr 2026 09:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64FB8383C7C;
	Tue, 28 Apr 2026 09:33:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABA73A6EED
	for <dmaengine@vger.kernel.org>; Tue, 28 Apr 2026 09:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368822; cv=none; b=htOjgnTfjwx9i0hR1+Uq70qfInzL4ntN8cJInCuU+O7qAs/DBIjCIoDwYea4x+4G6hDJ/1M8IqgkkOfRSpHawSTSCeuJ3kzTX63eZA9oStu9/vq/u8AmdPegim7A6FtFg3v4CHu0zqgVgUzmyBE7Ev15WVrgd2LeqguFqjVatIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368822; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dMCGdNCPHVDnF+IbPoYT0kgg0B+GB8XSEi62yHqw7s+FZFnRdCoAJo4RAMsDLgU1SmsZVClrGzbj6aoj3y9T6wdq/Qsmnu1MT3sXXtQzNHEhei6yYWHou87Y9/r/4J9wbtXw8g21Cwxg9/bs9fTaW5/9XkdLbn+vW7sGHS0t7I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-67389cf78b0so19509169a12.2
        for <dmaengine@vger.kernel.org>; Tue, 28 Apr 2026 02:33:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368819; x=1777973619;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=gOuEbCYbM+Eu4Bih5SSYJE9376B0khQIUQOPQP+n6cL5GUM5dckTdgUjuLHAPjoZUy
         l28joor/uYMCCbNy9fq7o0poJd8SvleHInBdQZXSoV3gsXVQ2YlSbNq0QvsQr1TgGwvi
         esHMT+k6QSL8KgC1j/tEbryQBo1tkNaeRgji7uzt4hMTD5giol2/ooadfjQhm+Ga9Zdv
         FPwSiFOzp4FfieJrqCOw1ToVA42GSTzdkdwC2ipARt50VymUNoX4a7i/p8OYFYvDc1l7
         FZSDrpg8Qxy+VIF6jCOeM5qykz/pBLVld097DbD2kNiLAzp/bBItLkBH6k8lrtQgYUD5
         KUhg==
X-Forwarded-Encrypted: i=1; AFNElJ/euH5U+IApSADhn/MOgfOWKV6HoIuu+IrJoDM652CI7wTCtPyGT6podMvLcH5MbIr251GYLTUZZ/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEMefVO7XycNTTIGc0UmdttLVwuLyYBKLkJJ56oWy9tlQ0gNot
	9ztL19D0/PlCzGEDj2zao+HsZH8rpkxusLg69yGJE5TFlxfEhj6TCG8uBQRom0wlSGw=
X-Gm-Gg: AeBDiet7BqKK9hxx+NuT1ncrQbE6lIeuOvUpNTjWayfqs9FjKWcYBLUe/C2DeXtaJ2a
	gELlGxVCbHIVV0jP5LzmF7QUqqGTtHNWkFqlJ8Kx3fHBjdfFPn3UqM7b5exWgtjUxhECu0io6Xd
	+dfuo7cYe/jngs74kzR+craC/zBzoUPo5XdDWNUAKK7NKe4+hgJI8cljWq7G/K83OPr1Q65XmHO
	XpoI36/FvlqXq7CWe7AK6gJBxjUxBLYbXP6sHVXErQeEev/iiV+nRzEzrie++cKU+dm0tNuH4Pv
	fefBuUtQFgymCaLyGSxEtlS1jb9a2eQ+sk61egPpoa8YvAC5BkxMYwdhmjxW1qqkzRV4Q9p3Ys/
	ZnNz96ox3xCdcodDP22ZbPCP02qZSWe47GR8ANivjxixrH0XeiHd0xsxX8OeuKJhFai6+7WPGg9
	RzPTRfqfeEUUEljdltMjghWkNhZvsLjq8F5KYyUSH83Ls81J/toiHmQGx+DGOacAjgYwJw2Jk=
X-Received: by 2002:a05:6402:26cc:b0:674:bbc4:be21 with SMTP id 4fb4d7f45d1cf-679bb0625e3mr1138328a12.10.1777368819215;
        Tue, 28 Apr 2026 02:33:39 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b67cd14bsm538208a12.3.2026.04.28.02.33.38
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:33:39 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so7382244a12.0
        for <dmaengine@vger.kernel.org>; Tue, 28 Apr 2026 02:33:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/RBFvCppdyVj7jKG6E6UFZat//53Zqcq43JTzOigyh2QTTaQgAG8YRAn4/0jtPHtCJayuMiFwSlIU=@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
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
X-Rspamd-Queue-Id: 4993A481A66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,linux-foundation.org,gmail.com,linutronix.de,vger.kernel.org,lists.infradead.org,lists.ozlabs.org,lists.freedesktop.org,lists.linux.dev,lists.xenproject.org,googlegroups.com,kvack.org,alsa-project.org,lists.linux-m68k.org];
	TAGGED_FROM(0.00)[bounces-10183-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[49];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.990];
	TAGGED_RCPT(0.00)[dmaengine];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

