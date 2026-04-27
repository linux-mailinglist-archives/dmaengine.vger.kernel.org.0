Return-Path: <dmaengine+bounces-10159-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNv5KyPa72m/GwEAu9opvQ
	(envelope-from <dmaengine+bounces-10159-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 23:50:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 159BC47AF03
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 23:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 514DA305EAA8
	for <lists+dmaengine@lfdr.de>; Mon, 27 Apr 2026 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9878930AD0C;
	Mon, 27 Apr 2026 21:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WRJE89gp"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239773002AB
	for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326368; cv=none; b=ueZSll55RvBxHuFIL+8iYOZyEoV5WH6cEisfowRZEShSjG5/svyjwbDgSynU69xYeVAMBMBhUUImmgrUsJ7GFKtoX3Az0yODNMyD6AjeHZSvGQuQixeINguBYm698AniXChMHyCLHvyoeXLCTz3Eb9Z/uo8B0iajzFbM0x9oSIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326368; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jjzU14FZwGgDa9zAPbkywQa2qkFN3RdX+/rRLPBP1gA8tuMhw/utGyzW8/USiRYX4WyorTR1oO2tkKxwCC9gRrkqTgYkkzwJrvTKpgheaBi8HrWLRNK0rTh4qzmqeSYm2IK6jNA5xThNHyDWFfxzIDoZ/HLlfYnbKisa7IgfcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WRJE89gp; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b9c01854477so696667966b.0
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 14:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326365; x=1777931165; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=WRJE89gpEi2cqwkQ4oMCuk1vMy/BVyJJfFwTeEi7DtNo5gRUHhC+HURgQo+TWBv8cr
         Z2PwSIcVZa/MW2rUZH+kWgB0YeXk9IfY+BBdLZ1i5Af/pTCBmQDA5YG0L3TxuqemIL70
         gMErpw97TPsWTLNi+etHMXZlqRJAh79ezVQ3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326365; x=1777931165;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=FQuP44TqfNB+go74N5LhiArZJQniwTbuzijW/lR78JVjupYM4v6IAXJvewV5Rpn+7u
         +gMHvaAVA5X9HCgRM3Nl7XqGhHss+q3nH01E3HImxjNikmhqdfgHwTI6fkscz86WN5Wt
         YYdwbWaEkqLLqDPAeiR6qus25VQHzTDy9/fyKoUMWeH9FoGA5UaDHVnfRKCWv2P+/ufB
         lWnjLaAuYkuCK4ScLQlZMGwA5Z4E9ZfLeAnLaHN/uw06+r2d90lTG9XG8rD5rVXIojlB
         fnBag/kEz1E4yUcTP2VaBRqfydD+4Lp4pqbqxjv2CdAcqWwvmt1XZh+q15CQcxf/3z61
         x48A==
X-Forwarded-Encrypted: i=1; AFNElJ//MKrPokSAf9aG4WRk997m4L5BY0QcTnZa858JgZpqGoF/ys3lKK8mbpEEBLBRreuwFKyw2040FjA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3TAn3sq5oCLZ55iNIKeWZaZ8rCDhbY8nWggn1IHi2lI9qlr37
	zW0R7cuMGsGL3i4GVImH6kYIai2tPv+eNIjnm84M7gbDmCD+2Qu1hNrevcWSAG3dDiUhNTNsDNn
	17ZqWRGeY9g==
X-Gm-Gg: AeBDieusPQpbAMr0xYBFtld8vUOcr8xaKz5l+Xrr3L7JNvkDS9Yxrh2k9AijdSr9Zx8
	q+FEzo4M0cySPNss3qVDP3+8/gXjI6XQUjW+QHou0OnS3CouMvN/v24Bm1TfpkOEEzxFPqM87k4
	fhg8nAP7hABvYsOJOhv86WbX+r1C90OYo5YFO2Fue6IKI/zW2+FPTz00CHloKiwJt/0HSHPbSsQ
	xmn/HvaBPb2KVeunm1O0ZiwfpD9hJb4c4nDfnIjBFHDwIF/EYwk0dDD3EpW+2FG/HvfFGtouFbO
	041a+itSkbi2sN9pwv5HNrkEvK25C1rL0fmfsbOzhqFPzST06wIOWyr4ei5WikExPufI7MrZd7r
	qlbvrLcdWfZAy2PK79up/EeUFRzx99NHNEqTZ76lOJ6gOFAIndy4sH7d6H/wKLVU6Y54ZaEdyMd
	JcqGCUg9xypx7aAqhodcv3qMFbn1xhinUfNSavZRUuUhcZGCbz83T4wrzx407hGgS4kXoQA3Jwk
	R8oiiqz6dY=
X-Received: by 2002:a17:907:cc08:b0:ba4:8288:b464 with SMTP id a640c23a62f3a-bb8020c9f1amr18059966b.6.1777326365166;
        Mon, 27 Apr 2026 14:46:05 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80bd9377bsm9504466b.53.2026.04.27.14.46.05
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:46:05 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b886fc047d5so1921015666b.3
        for <dmaengine@vger.kernel.org>; Mon, 27 Apr 2026 14:46:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+YYOq81WLhmUSXSFkFI+Kbqoz7poXxyMN2LGcP3ENOffmtZXKpMi1Uyi3qNpNkHG/E2QS+hfUU5KU=@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 159BC47AF03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-10159-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[48];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:dkim]

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus

