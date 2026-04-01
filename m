Return-Path: <dmaengine+bounces-9796-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCJYCQbazGnnWwYAu9opvQ
	(envelope-from <dmaengine+bounces-9796-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 10:40:38 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0BA8376F85
	for <lists+dmaengine@lfdr.de>; Wed, 01 Apr 2026 10:40:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C57153021421
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 08:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470363BA237;
	Wed,  1 Apr 2026 08:40:31 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF93B960B
	for <dmaengine@vger.kernel.org>; Wed,  1 Apr 2026 08:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032830; cv=none; b=UHlZX7FvSQFMEWM6jI4CAG2Ptyv+lfPoQmWCl5R9QQwgfQq7FxvSHa1RPzpHC1jSgb61mnshuwrROlSCoN8ZftYU8pR/afatQUuDTcDLs8+/22okNu/7S4WthpygUuJaPYjWaYxeJotqX2j2BZOLCcJHpxnGGpuKrPDVSY8i2lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032830; c=relaxed/simple;
	bh=3s3LfhNqe/vU4X2yUsFGVqtyA8/HXi9SqILM/RQmCqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9D0P7EItPLfT5b0P56QsjStoVVRQEVu45yFIhO9kd8hve0InRSjK5do85/Au1K5Ea2lTuMOQnTUNkC+Am7oqRBFFg9jU2ZrUGhFOj20oVPq3YCTZKnqjBzo0i7lKnL6ZdvEgBvIKs24GFydb1fQXQ9rmR95yAr5il9nxD/Yyak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-6052f9376bfso1075219137.2
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 01:40:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032822; x=1775637622;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UjkBPhSq2KNJwwC5a6VjrIfS+wjdobuUB/quFKLmn9I=;
        b=rZa17a7xYFdWncKEyTHUwS9HcUhRpSj4TfU1WRBvEGcQITsRwWIxTXi+F/NiYcNVOg
         xuGzHrDKaMqgNLWy0j8AnHEAJXtdX3KBSs5S0rKZeApM8is2SOy3UWpl3D9izmx3Gcit
         SO8TbRPGSWvzJ2P7ScgXEXizIf0ksBR9XYCZXYfce7zr3XMsHQNgy3RQr6Rjtjg8Udhv
         pSfeyBdTU5jPI6SkHWE5Fk+cFBOV71JwriiCd0l55au6s/Bnxkoz1P0UV6Taw9WldSHE
         VwrT67/sIgq/xTsRszkd85p4tS0sP9VbUcehyZAxP6NUKK6xnF9WERzS0rtUJpMj54Sx
         miww==
X-Forwarded-Encrypted: i=1; AJvYcCUC2mapbBp2FJtPGwLJW+VXyS2+FcgwuDGt3HK0GOPvUdSvm/hxRiTvWpcCsSGc1DEHSUiolntWfrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzqG2KI97bj+cFkaFPBumYKg33XGfaPqKGFPmiHjM2ELOeS/l
	AGqe90eTG1XCHXA3spc/8V9dOT9cQJ1SjcvSaFTaQDrB6uaHmI97INjfNVx7xal1
X-Gm-Gg: ATEYQzzifBuquXgw32mg2VYD9R1EwYXSM6zjLpD0vmyCjAuCVCK2Iwu7HvfLbaReEy8
	q02rKAOdHWsDMBnlENcgBpomyNMBeIwP3p1zdMPnUhT8CZS68TvdwBJGC+1D/d9Bgq+8WI6i5E2
	7mDxXVAlE86IP517zwv3qCDJJM9ySd1or6X9pzbPrLZq0BqRgWqEbU/oIJ3Vj3QLmZXky3C8hw1
	ep81o9jm3eLyUVs+8vsD2zKMIK7H9BSDYpCBfi7mrQFkMKZK/NltBinMKjKhUZ+J4hTsjGvPJDS
	tO7QrFhXyrMnatL5fQq8g813vjaKy5WJRB7cl+7RfNG2cLZTA9NAgYPrClLjTE8TanCdf71uEZ7
	dX36aMtL/GdM4PRVFrvuwBrNoukNj45a+np0QvhKuNXL1r6mRLHSk/1QMpKVsRAEMbKoghnGUgE
	O8QxQi4inocl1cGZ4uszSw587SKKWF55R6WdvO9KNLHUNmVkLCfxV4L857kJmN
X-Received: by 2002:a05:6102:4492:b0:5ff:fe0f:67a4 with SMTP id ada2fe7eead31-60567e9403bmr867192137.14.1775032821932;
        Wed, 01 Apr 2026 01:40:21 -0700 (PDT)
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com. [209.85.217.48])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60512a1dc2asm15142515137.4.2026.04.01.01.40.20
        for <dmaengine@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 01:40:21 -0700 (PDT)
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5ffe1c73287so2403318137.3
        for <dmaengine@vger.kernel.org>; Wed, 01 Apr 2026 01:40:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWXqcyjVPzVXyLJXvNqCM86B03fVoJ4mhF9IDLnSJJmAwbBk5xiQxJi9WDCbsRyunTi57INwOURWJE=@vger.kernel.org
X-Received: by 2002:a05:6102:3749:b0:602:a9f3:74d8 with SMTP id
 ada2fe7eead31-60568183e55mr762941137.25.1775032820403; Wed, 01 Apr 2026
 01:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-fix-atomic-poll-timeout-regression-v1-1-5b7bd96eaca0@bereza.email>
 <vA8GpbivDeKzKN1k0B6m1cvW-rZwJjKzvhksYdUJPo4fsfhLQoXtWoK59V1YX_U2U3jcVR2PAmzrleamvq8Dmw==@protonmail.internalid>
 <833bb42a-65b8-4c93-8109-d2959f8b807f@amd.com> <DHHOCNHDN27K.RIE745OFAACD@bereza.email>
In-Reply-To: <DHHOCNHDN27K.RIE745OFAACD@bereza.email>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 1 Apr 2026 10:40:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV-NOqrApQpnq9cSRD69ViAcSyyRVERnuy9FiUJXFSZpA@mail.gmail.com>
X-Gm-Features: AQROBzBtK2awVoYZlNLRH_TxbROG8uZpU4rpSXf9Z2mSy2RwErngCSoFK_0ago8
Message-ID: <CAMuHMdV-NOqrApQpnq9cSRD69ViAcSyyRVERnuy9FiUJXFSZpA@mail.gmail.com>
Subject: Re: [PATCH] dmaengine: xilinx_dma: Fix CPU stall in xilinx_dma_poll_timeout
To: Alex Bereza <alex@bereza.email>
Cc: "Gupta, Suraj" <suraj.gupta2@amd.com>, Vinod Koul <vkoul@kernel.org>, 
	Frank Li <Frank.Li@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, 
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9796-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,dmaengine@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bereza.email:email,linux-m68k.org:email]
X-Rspamd-Queue-Id: B0BA8376F85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Alex,

On Wed, 1 Apr 2026 at 10:27, Alex Bereza <alex@bereza.email> wrote:
> On Wed Apr 1, 2026 at 7:23 AM CEST, Suraj Gupta wrote:
> >> Rename XILINX_DMA_LOOP_COUNT to XILINX_DMA_POLL_TIMEOUT_US because the
> >> former is incorrect. It is a timeout value for polling various register
> >> bits in microseconds. It is not a loop count. Add a constant
> >> XILINX_DMA_POLL_DELAY_US for delay_us value.
> >
> > Please split this change in a new patch.
>
> Ok, will send a v2.
>
> >> Fixes: 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic()")
> >
> > This patch doesn't fixes anything in iopoll, please use correct fixes tag.

Fixes-tag are also used as guidelines, to indicate which patches
are also needed when backporting something.  I.e. if 7349a69cf312 is
ever backported, any other commits that contain "Fixes: 7349a69cf312"
should be backported, too.  So having this Fixes-tag, in addition to
another xilinx_dma-specific one, sounds fine to me.

> Ok, but I'm not sure what would be the correct fixes tag then? I though I need to reference
> 7349a69cf312 in fixes tag because this is the actual change that surfaced the CPU stall issue that I
> want to fix in this driver. I'm fixing the call sites of xilinx_dma_poll_timeout but they were added
> in different commits. Should I add all of them? That would be the following then:
>
> Fixes: 9495f2648287 ("dmaengine: xilinx_vdma: Use readl_poll_timeout instead of do while loop's")
> Fixes: 676f9c26c330 ("dmaengine: xilinx: fix device_terminate_all() callback for AXI CDMA")

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

