Return-Path: <dmaengine+bounces-10873-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJQnL6FRFGryMQcAu9opvQ
	(envelope-from <dmaengine+bounces-10873-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 15:41:53 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2405B5CB4A9
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 15:41:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69C8B301A3A7
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 13:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9C5384CFF;
	Mon, 25 May 2026 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Hxkft0Kv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4CC34C9A3
	for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779716397; cv=pass; b=NUX9vOznuqnGp4q4jt7WEefiRgrKPD/QeDbWAnKYAwsdRjCJ2dD/DORveC2rh1yHsnUcwZBEQTZzFp5QS9b2hWcPIE1x2KNz56Nt8X4uehRW/d1q7W4X1EhYsaH8tW0iq5LYY/kLTC35cflzQBR/AYnaW7DmTJm6rMMH1iNOcIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779716397; c=relaxed/simple;
	bh=NjcoxtPxAXPyy+r6qEG8tR6sVU2Znv7M+7Rf2K1IM6s=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YG+LHSftAM2ZMKbxPweH4E0Hy/7QGGXAwECf5rq9qYrqvo5FZnAI69yvX3HX6h3hGd5GUm/KB99bnEk41Wx6+d5HH9IgXv37zmK8K3CEKNJnfRqGB4Zju20iSsDLkMfXJDAKoUWVfRdUFKfW4fQyY1L5IY02tLgxuKM4IsHom3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Hxkft0Kv; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-687e7edaafeso4525511a12.1
        for <dmaengine@vger.kernel.org>; Mon, 25 May 2026 06:39:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779716393; cv=none;
        d=google.com; s=arc-20240605;
        b=YEXhApx1wrYZl93ogfDwoVbQT8hgOxm6pQEhOqOyK5wQRMNr3aas5ae44QaP5liOv2
         XfXNONXireoTq32KAlcVcnHqIi3MbPNL1jP8/ZT7beWTTEgfZZNYtQzbF5jlloEHSq+H
         YgV4NfGN/WOtJ+eZLXVUCFu4wT3KwaZ+XO4SuqMZi1/CPRVoDtzZN5LBUY0KImSZ89Xf
         /tQwjoW/L0oaJAqETLt22wmnPGl8qdbrfZkMx0ZX5gcsTLYmimAjQauiodT5mWgxYe6P
         6nWEZIzljWT3s0WVlpKoXYosCf4/caueQVgljFr8K6/ezkpa/Y+pnL1TLE/FEWWGLsNt
         tjWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=hvrtSfS2XPLiN7M0l4zK1UsQIdB9tCKglzozVLNovnI=;
        fh=ncpUZxnyQodLKkd8e80P4tPEzYv9kL1WGQgw8TNJxFQ=;
        b=CKZwwQO+h4rSEYkazOYWCkyCW3vpoR3CJfrDPGy2Ogt0D8M4v6LNyK8Fgt+Pysvcs1
         v1P31SJim6ZfkDma++VkALuIubZX4Ms2Fo/mf5Kkp0nGdaa3hmuhFT9KKQU5G6/rFBIg
         cnXD1cxkpCbg6wmLsO9+56WYqyWpiitG59P37cn9IChdHWVmuAJwxhv+eYkxdtvdQwcU
         21gDZPEOHqcR5y+KgBpSfzF57eVpBzxOkZ1p4SeeIZWzMwwmJ7M4UvbgCqECuJDsmV82
         bcg1vYkndNj4nFLArytcL+XFRhH1w902lieNYW9CaoF2lXDcT5+fpVZnm0FGSV9r8PvC
         JDRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779716393; x=1780321193; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=hvrtSfS2XPLiN7M0l4zK1UsQIdB9tCKglzozVLNovnI=;
        b=Hxkft0KvERMTMzXxBOlEr+W32q8Kan57nvrkaB+PJ8ITksriR6rgI0qC9VTOSLr1Bf
         kogt7MG/kMnTrMgaaI3TmrgX9yoY1/liPHUCu0rbHgQ637XtxKyacCov0miYljweQEFm
         xCcMHhiDlI50D1uVioaqqE3YXcpbQYqj0p8WwUOWSdkTWgGCUImac9TUUIraBxRCS710
         Gk7b4a6+XukROM3clvflFf5cjBUvjjQWdpJ2GrDfDeAuEEd8RH/GhxpoNBda+QqzobWl
         Wz1AJW5PLxq3DG2SIGRkqqMLIL+mc31Uxb9qV+CSI9bcbd0nX5iPZPWAclklz/8OwkuT
         +mjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779716393; x=1780321193;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hvrtSfS2XPLiN7M0l4zK1UsQIdB9tCKglzozVLNovnI=;
        b=bipFDWD26pOVB5aUvQhhFa6VFqe8XYgL4pGwPMMBosjWeRRhL7wIXvgqLVgl9qfu51
         cjyiyd2l1Mgza0mc/0QZ5eggljZLrao4QpeCteOww7qRZwnAFdBFaxGXUeH1ItQSH9q+
         ++6Xbz2UVykWXLTlOoLlGgJbvIxcWbzulEHB6Y6dTnGz0NMjloDOjXIi+PzAHBeLPeNk
         Bq3aRLzCQv9O7AjAWaIFh8fd3cGOj2eoxVdCq0foWEw5hG9Ydnpv+CudqIYJuAxWWDG/
         YHj7ZYtAd7XyQbXL1r5PT2EHAjffVU4qG0Bs8QJ5IpnF7IAeYDCHUxgRr6aJHBbwaLiS
         yRvg==
X-Forwarded-Encrypted: i=1; AFNElJ/RBarqiihzoenmXrmo9CsYtznkZPMOJiXmGa7qbBwRU5V94fMf1pP4iAS93bacrALiVEKIczq+cTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznQQegaSlyWfvaB00ICqqZMb6j70Z1toO0BeRZTCCXjwMLG9Sh
	A/PupDbJ6UhoNEBLRwGAgyXSkWP9oN5lTEwUQxUUVAbMBsVxcYkcfbegkCG7YcvmvQoeGO6RnbN
	3CqCsr3LVDs9e6vYgn1eP36lHpckRBHPq/W68LFrVcQ==
X-Gm-Gg: Acq92OGbBvby2GkwkZmYe8zKCa+OTU0yHoh351XqojRrLGWcwyjY8Hx3NWh/tApY8U9
	16xsy5DZ03n3PlMKiBQIYtwjRcyQjWki6+4KzyPjgyzFMSn8Fbk07F+wzKJSY8ikTyiBhWuFiTu
	4TksbWWTr7T8QNFNVZDjRm9O64ZreJvGHX23ba47K7+XKi8D/fM2q411hplPCxI5Fqk+/+No7a/
	F53NRlgPIvUlbXoqDoBwivVEaYeUvawvhiv/lzKv3ZKdXrIGBHxh79OJpZfGV4qc8RJkyzi0Ijq
	vWRjo05MHlLjqVEhaAgQ5wDBj0uClrOJWDH8
X-Received: by 2002:a17:907:3c8a:b0:bcf:9dd2:f79e with SMTP id
 a640c23a62f3a-bdd26cd265bmr861792166b.29.1779716393446; Mon, 25 May 2026
 06:39:53 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 06:39:52 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 25 May 2026 06:39:52 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
 <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com> <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALSJ-wDY_8SMAvKT0L6wMbH1=w5pZNmV=xyeX1REb=BMRZWj-g@mail.gmail.com>
Date: Mon, 25 May 2026 06:39:52 -0700
X-Gm-Features: AVHnY4LbckeKGYKU7CghJurgC1FodfGLzJmAolw5gCW0YFJ46Zr4ueny_XzVmqs
Message-ID: <CALSJ-wBfn9vkZYM8AfB3SvCH-AkuYEW9ccQ-p3N+GWR11da5dQ@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Greg Ungerer <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10873-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux-m68k.org:email]
X-Rspamd-Queue-Id: 2405B5CB4A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg and all,

so i posted a patch this morning to have edma driver back working.
If approved, i can proceed testing this RFC (adjusting it as needed)
with edma and dspi driver.

Regards,
angelo

On Sun, May 24, 2026 at 04:34:03PM -0500, Angelo Dureghello wrote:
> On Sun, May 24, 2026 at 02:17:07PM -0700, Angelo Dureghello wrote:
> > Hi All,
> >
> > On Sun, May 17, 2026 at 03:41:31PM -0700, Angelo Dureghello wrote:
> > > Hi,
> > >
> > > On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
> > > > Hi Arnd,
> > > >
> > > > On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> > > > > On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > > > > > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> > > > > >> On 7/5/26 05:12, Arnd Bergmann wrote:
> > > > > >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> > > > > >
> > > > > > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > > > > > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > > > > > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > > > > > [    2.290000] spi_master spi0: noqueue transfer failed
> > > > > > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> > > > > >
> > >
> > > About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
> > > i probably lost some dma config option.
> > >
> >
> > so i worked on this open issue above:
> >
> > - moved to master and rebased,
> > - crated a wip/edma branch,
> > - bisected and found the offending commit, before this, mcf-edma driver
> >   and connected spi-fsl-dspi (using edma) was both working correctly.
> >
> > 7a360df941a4bd60847208de59f1ac8b166265a2 is the first bad commit
> > commit 7a360df941a4bd60847208de59f1ac8b166265a2 (HEAD)
> > Author: Christoph Hellwig <hch@lst.de>
> > Date:   Thu Oct 12 09:52:27 2023 +0200
> >
> >     m68k: don't provide arch_dma_alloc for nommu/coldfire
> >
> >     Coldfire cores configured with a data cache can't provide coherent
> >     DMA allocations at all.
> >
> >     Instead of returning non-coherent kernel memory in this case,
> >     return NULL and fail the allocation.
> >
> >     The only driver that used to rely on the previous behavior (fec) has
> >     been switched to use non-coherent allocations for this case recently.
> >
> >     Signed-off-by: Christoph Hellwig <hch@lst.de>
> >     Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
> >     Tested-by: Greg Ungerer <gerg@linux-m68k.org>
> >
> >  arch/m68k/Kconfig      |  1 -
> >  arch/m68k/kernel/dma.c | 23 -----------------------
> >  2 files changed, 24 deletions(-)
> >
> > So i can try next week a patch for edma looking what has been done
> > in fec, and since i am probably the only with mcf54415, will test it
> > here.
> >
>
> Looking into this better, looks like the above commit was meant for the
> majority on non-mmu ColdFire. I think mcf5441x and some other with mmu
> enabled can flag pages as "page cache disabled".
>
> So i would re-enabled that code only for such mmu families.
>
> Please let me know if i am correct.
> Thanks.
>
> > > > > > DSPI is using edma, i will try to understand where the issue is asap.
> > > > > >
> > > > > > About how it works:
> > > > > > - for accesses to edma module (IP) mmio registers, must be native
> > > > > > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
> > > > >
> > > > > The twist here is that with the way that readl() is defined on
> > > > > coldfire as a non-swapping operation, and the generic
> > > > > definition assuming the opposite in
> > > > >
> > > > > static inline u32 ioread32be(const void __iomem *addr)
> > > > > {
> > > > >         return swab32(readl(addr));
> > > > > }
> > > > >
> > > > > the function called ioread32be() actually tries to access
> > > > > the registers as little-endian. I can see two possible ways
> > > > > we got here, but don't know which one is currect:
> > > > >
> > > > > a) the device actually has little-endian registers (like it
> > > > >    does on i.MX, but unlike all other coldfire devices), and
> > > > >    you just never noticed because using ioread32be() worked
> > > > >    as you expected.
> > > > >
> > > > > b) you tested the driver using an ioread32be() definition that
> > > > >    did not have a byteswap and it correctly accessed big-endian
> > > > >    registers at the time, but the version in mainline today does
> > > > >    not.
> > > >
> > > > Ok. The ioread32be now works properly since i had applied Greg patches.
> > > > I generated an error in _probe on edma channel 2, reading status reg.
> > > > looks consistent:
> > > >
> > > > 	iowrite16(2121, regs->erqh);
> > > > 	iowrite8(0x77, regs->serq);
> > > > 	iowrite8(0x12, regs->ssrt);
> > > > 	
> > > > 	u32 status = ioread32be(regs->es);
> > > > 	printk("%s() status: %04x\n", __func__, status);
> > > >
> > > > [    0.140000] mcf_edma_probe() entering
> > > > [    0.140000] mcf_edma_probe(): allocating data
> > > > [    0.140000] mcf_edma_probe() status: 800012f8
> > > >
> > > > If i am not loosing myself in this r/w labyrinth, the path should be:
> > > >
> > > > 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
> > > > 2) So the ioread32be swaps the standard LE read giving BE.
> > > >
> > > > Am i correct ?
> > > >
> > > >
> > > > >
> > > > > > - for accessing the "tcd" memory structure, that must be, from what i
> > > > > > remember, anyway in little endian, independently from the cpu core
> > > > > > endiannes, this is the reason that big_endian flag is needed, it is
> > > > > > used for tcd area accesses, so the IP module was built.
> > > > > > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
> > > > >
> > > > > edma_read_tcdreg() calls into edma_readl(), which is the same function
> > > > > that is used for normal register access, so from what I can tell,
> > > > > they always use the same endianess here.
> > > > >
> > > >
> > > > If edma_readl was using
> > > >
> > > >         if (edma->big_endian)
> > > >                 val = ioread32be(addr);
> > > >
> > > > and never changed, without Greg patch, it was likely returning little
> > > > endian for coldfire and correct LE for other arch ? :)
> > > >
> > > > I remember something about tcd area was coded LE, but will investigate
> > > > better, now i am over midnight.
> > > >
> > > > Regards,
> > > > angelo
> > > >
> > > > >       Arnd
> > >
> > > Regards,
> > > angelo
> >
> > Regards,
> > angelo
>
> Regards,
> angelo

