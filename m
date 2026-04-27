Return-Path: <dmaengine+bounces-10158-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBarOojV72nXGgEAu9opvQ
	(envelope-from <dmaengine+bounces-10158-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 23:30:48 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDEE47AA7A
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 23:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CE043087D16
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 21:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B73E38759C;
	Mon, 27 Apr 2026 21:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pM4bEk+K"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336337AA78
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325365; cv=none; b=LgOlal5mjWOhWwj722gQElU6co97g68csW0qqQXgif6BxYoKwtdaK4MGa8RQoRgO1Ad9I+bDTkT6ACe6TT5oqy0113/mp6o48MGKKIuj4FjOQkmn40q00AvmPFUqidUj3rrVhYdq6VnqT1VRCGKBHSFVBZsoIDgyBrr4PC9UGeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325365; c=relaxed/simple;
	bh=c8Xs8XIDe+SZyyGBpFGQP0PqyLAvYREVB87ThsvQG6c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r79QF4tg8OrJu5D7Dw7nKqdqQG0Oy6Uq9Aij0aefjijKBnPkWmLgjXef3ocZlMqj8uHvsRCY6KRg9k18H3fZ+cyCaKnn3R3fx7Z6hhCmwUA6Oi+bPJZ+oAD8pft2NRGkldz6t6BK/uHrsVnY+0asDxReMv2vzWju2zdNgUCiMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pM4bEk+K; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso148971745e9.3
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 14:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777325358; x=1777930158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ebg5+i/pOUuQx7xxuERTUppaj1qL6vIxTxgv86V/NC0=;
        b=pM4bEk+KWuVJs1U70UMTYiYKMTMTofFbWReYwBWyqhmru6Y2DXeQu1JWql0TDyt+VP
         KU6iTZ27w00J1ijxYV/Il69CxIz0aEodyojX5hvux8QzDCUptjfpO0GxqEopdd5J7LQe
         xWtNPQshDR5+AecefO+G7XCDnANkqrKF5HDpjRP71LYSISipG8uBZw3Llvrz/plVREw8
         7hx+6bhgCNzpupXctGieSqZ7959V9vurIkn5LhYgBA0CLbIQE+NEBCLE9iwlyuxnjMVK
         9ppisP58FPLXgdtkUISOXdh0pbxdbVuAXmsLhiX5O1W4051+CXyd/ZZNlvvioVVvo0G7
         77DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777325358; x=1777930158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ebg5+i/pOUuQx7xxuERTUppaj1qL6vIxTxgv86V/NC0=;
        b=hQe3UX15eXoTWM/I5S97biTt0325/wLbMw3fOEQ1vSvRKdPhxVABZKZPXYSGeIQkBg
         wDWTGA1DsyGKWg+WanjwO9pR8BeWb+jVGrHcNtm/gc5Qv5x8lYI5DAEnbRh0rwdvWwDK
         T+Tg59y4fF6OtqaPfFflIHFjgsVx0hJbq7KNgxbToTPXIFOI53MzdgO+Jh8xR3j4zFw4
         iaJJWA3yip07OddEXrtYKVVLF4NxizMELoyXDTVz9ZiMoiKkxbsoV/QKUk6Kvk78EUAG
         H207T2dvHS6n5nlOxq4ffh7K8mMj/EdIkXAWdZkyjPZ6aLbkXofg4uoBVmtJ1jk2W4ui
         fEeA==
X-Forwarded-Encrypted: i=1; AFNElJ/WH7P6GBZb39Wnh/ZIOCphVoRLv8dN3Fde1Y5GBKuUapoj+HLKW4gf/RRCBp3mZBcVTMYwb4XDXmU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMfYhPzbf0PJKEiVY0K/NkP5CEpDZYN0E0f0IMAQEj1ev//Hj0
	4tTMocHthHD8isaLdOYQPOxXKnQKdQ0h2fkckXsfqGbYmAMP9elod839
X-Gm-Gg: AeBDiesJnP2pJ+YrKlTPQ6mKDkFy+uaFKdAVlbL+BDpqzxHH43g1rf8cZcPq54bYJYq
	GPbQfSVePDa1JytfVZs7depOPU1ZOiKuyPD79+gg87/usObv9il5v3z565S03aI1nwrLwxvfee5
	/6Ez2ZvUZs01Dq+dVlA3RTm24GQTy0MYv97828Dx5yEEi8hGAtRDhW0rVl8BvAqR1/DWPvIQjJi
	xiS8oXbbtzUQHjFS5aDWwNaENUSOyIkbPGha2UtQeTsJXA2VLeCAEuZokpglDxb0ebfC7eV8Rwy
	+FRiZgOn52aspeTsmVLgmi1VYKbb3r0lfjxxHFqNLwU8blEVAdapnKZJEWhFdUfCc5Q+0cZvKBQ
	quAk7X64SSVdXSqxvHIGDlhQXW4ff7rZxCzf72SceNqpPRFHBLEywMWQRDZgIOwh3nOf4a9RcqJ
	FLiyfJVRiw5uf3Pm8oX0576rtrNB9PJ2CZK4/bZgb37GK/nQUHK8xSQayPCvb9BhMvV8La67P0/
	yJ9+H9KzntL5w==
X-Received: by 2002:a05:6000:3109:b0:43d:7d6f:f531 with SMTP id ffacd0b85a97d-44649ba1f4amr816127f8f.30.1777325358072;
        Mon, 27 Apr 2026 14:29:18 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463d02f270sm1120515f8f.9.2026.04.27.14.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 14:29:17 -0700 (PDT)
Date: Mon, 27 Apr 2026 22:29:14 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov
 <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, Thomas
 Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org,
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
 ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-mm@kvack.org, linux-x25@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-sound@vger.kernel.org,
 sound-open-firmware@alsa-project.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to
 copy_{to/from}_user_partial() when relevant
Message-ID: <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com>
References: <cover.1777306795.git.chleroy@kernel.org>
	<289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
	<CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5DDEE47AA7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10158-lists,dmaengine=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]

On Mon, 27 Apr 2026 12:01:23 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 27 Apr 2026 at 10:18, Christophe Leroy (CS GROUP)
> <chleroy@kernel.org> wrote:
> >
> > In a subsequent patch, copy_{to/from}_user() will be modified to
> > return -EFAULT when copy fails.  
> 
> Please don't do this.
> 
> This is a maintenance nightmare, and changes pretty much three decades
> of semantics, and will cause *very* subtle backporting issues if
> somebody happens to rely on the old / new behavior.
> 
> I understand the reasoning for the change, but I really don't think
> the pain of creating yet another user copy interface is worth it.
> 
> We already have a lot of different versions of user copies for
> different reasons, and while they all tend to have a good reason (and
> some not-so-good, but historical reasons) for existing, this one
> doesn't seem worth it.
> 
> The main - perhaps only - reason for this "partial" version is that
> you want to do that "automatically inlined and optimized fixed-sized
> case".
> 
> But here's the thing: I think you can already do that. Yes, it
> requires some improvements to unsafe_copy_from_user(), but *that*
> interface doesn't have three decades of history associated with it,
> _and_ you're extending on that one anyway in this series.
> 
> "unsafe_copy_from_user()" is very odd, is meant only for small simple
> copies that can be inlined and it's special-cased for 'objtool' anyway
> (because objtool would have complained about an out-of-line call,
> although it could have been special-cased other ways).
> 
> In other words: unsafe_copy_from_user() is *very* close to what you
> want for that "Oh, I noticed that it's a small fixed-size copy, so I
> want to special-case copy-from-user for that".
> 
> The _only_ issue with unsafe_copy_from_user() is that you can't see
> that there were partial successes. But if *that* was fixed, then this
> whole "create a new copy_from_user interface" issue would just go
> away.
> 
> So please - let's just change unsafe_copy_from_user() to be usable for
> the partial case.
> 
> And the thing is, all the existing unsafe_copy_from_user()
> implementations already effectively *have* the "how much did I not
> copy" internally, and they actually do extra work to hide it, ie they
> have things like that
> 
>         int _i;
> 
> that is "how many bytes have I copied" in the powerpc implementation,
> or the x86 code does
> 
>         size_t __ucu_len = (_len);
> 
> where that "ucu_len" is updated as you go along and is literally the
> "how many bytes are left to copy" return value that is missing from
> this interface.
> 
> So what I would suggest is
> 
>  - introduce a new user accessor helper that is used for *both*
> unsafe_copy_to/from_user() *and* the "inline small constant-sized
> normal copy_to/from_user()" calls
> 
>  - it's the same thing as the existing  unsafe_copy_to/from_user()
> implementation, except it exposes how many bytes are left to be copied
> to the exception label.

I think there is a slight difference in that the normal copy_to_user()
will determine the exact offset of the error by retrying with byte copies.

There is also the issue of misaligned copies.

Then there is the 'bugbear' of hardened user copies.
Chasing down the stack to find whether the kernel buffer crosses
a stack frame is probably more expensive than the copy for the typically
small copies that will use on-stack buffers.

	David

> 
> IOW, it would look something like
> 
>      #define unsafe_copy_to_user_outlen(_dst,_src,_len,label)...
> 
> which is exactly the same as the current unsafe_copy_to_user(),
> *except* it changes "_len" as it does along.
> 
> And then you use that for both the "real" unsafe_copy_user and for the
> "small constant values" case.
> 
> Just as an example, attached is a completely stupid rough draft of a
> patch that does this for x86 and only for unsafe_copy_to_user().
> 
> And I made a very very hacky change to kernel/sys.c to see what the
> code generation looks like.
> 
> This is what it results in on x86 with clang (with all the magic
> .section data edited out):
> 
>         ... edited out the code to generate the times
>         ... this is the actual user copy:
>         # HERE!
>         movabsq $81985529216486895, %rcx        # imm = 0x123456789ABCDEF
>         cmpq    %rcx, %rbx
>         cmovaq  %rcx, %rbx
>         stac
>         movq    %r13, (%rbx)                    # exception to .LBB45_8
>         movq    %r14, 8(%rbx)                   # exception to .LBB45_8
>         movq    %r15, 16(%rbx)                  # exception to .LBB45_8
>         movq    %rax, 24(%rbx)                  # exception to .LBB45_8
>         clac
> .LBB45_6:
>         movq    jiffies(%rip), %rdi
>         callq   jiffies_64_to_clock_t
> .LBB45_7:
>         addq    $16, %rsp
>         popq    %rbx
>         popq    %r12
>         popq    %r13
>         popq    %r14
>         popq    %r15
>         retq
> .LBB45_8:
>         clac
>         movq    $-14, %rax
>         jmp     .LBB45_7
> 
> and notice how the compiler noticed that the 'outlen' isn't actually
> used, and turned the exception label into just a "return -EFAULT" and
> never actually generated any code for updating remaining lengths?
> 
> That actually looks pretty much optimal for a 32-byte user copy.
> 
> And it didn't involve changing the semantics at all.
> 
> Just to check, I changed that "times()" system call to return the
> number of bytes uncopied instead (to emulate the "I actually want to
> know what's left" case), and it generated this:
> 
>         # HERE!
>         movabsq $81985529216486895, %rcx        # imm = 0x123456789ABCDEF
>         cmpq    %rcx, %rbx
>         cmovaq  %rcx, %rbx
>         stac
>         movl    $32, %ecx
>         movq    %r13, (%rbx)                    # exception to .LBB45_7
>         movl    $24, %ecx
>         movq    %r15, 8(%rbx)                   # exception to .LBB45_7
>         movl    $16, %ecx
>         movq    %r14, 16(%rbx)                  # exception to .LBB45_7
>         movl    $8, %ecx
>         movq    %rax, 24(%rbx)                  # exception to .LBB45_7
>         clac
>         xorl    %ecx, %ecx
> .LBB45_8:
>         movq    %rcx, %rax
>         addq    $16, %rsp
>         popq    %rbx
>         popq    %r12
>         popq    %r13
>         popq    %r14
>         popq    %r15
>         retq
> .LBB45_6:
>         movq    jiffies(%rip), %rdi
>         jmp     jiffies_64_to_clock_t           # TAILCALL
> .LBB45_7:
>         clac
>         jmp     .LBB45_8
> 
> so it all seems to work - although obviously the above is *not* the normal case.
> 
> NOTE NOTE NOTE! The attached patch is entirely untested. I obviously
> did some "test code generation" with it, but I only *looked* at the
> result, and maybe it has some fundamental problem that I just didn't
> notice. So treat this as a "how about this approach" patch, not as
> anything more serious than that.
> 
> And the kerrnel/sys.c hack is very obviously just that: a complate
> hack for testing.
> 
> A real patch would do that "for small constant-sized copies, turn
> copy_to_user() automatically into "_small_copy_to_user()".
> 
> The attached is *not* a real patch. Treat it with the contempt it deserves.
> 
>              Linus


