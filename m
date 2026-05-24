Return-Path: <dmaengine+bounces-10800-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNE+BeRqE2pIAgcAu9opvQ
	(envelope-from <dmaengine+bounces-10800-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 23:17:24 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 616315C453C
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 23:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D018C300B9DF
	for <lists+dmaengine@lfdr.de>; Sun, 24 May 2026 21:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471E53382E8;
	Sun, 24 May 2026 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="F1bMJPdt"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98521C68F
	for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 21:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779657433; cv=pass; b=Zv6jhCKdvSIFuCs2ZA6n2/ceMXcUKX1leCfUxGvhHncytZndrSaQVqxgLQU+PjuahVp0vTzEr6gHN5quK3yKihhtVWeYA3Kae+5OvX+wiC92xapefMF0dNc9wHvK4V1oqz2SRcd8zbe/sKSancb8a0o5sTxTqEmB0NSCcB0YXYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779657433; c=relaxed/simple;
	bh=qfr3PV+aenV2JpxF3FEwOoVdituPWH2TqiuNbdw2APY=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IYMQES7K8AxReP4VqB1scEE3MJXH5Lg/xMdfpHRYRMCUl2/qceQ8w9L+mCksETPYiNVsIDKRV3HAmUBiM6Vie7nY3sasYB2wgyKQZ5f9kHJl0nLIw4pdv+laBFIOJgaOMQG6GKq9oS1blnDZdWtZNR4WZETdhEVFZwPZKc9v+n4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=F1bMJPdt; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67b8d9c26bbso18179153a12.2
        for <dmaengine@vger.kernel.org>; Sun, 24 May 2026 14:17:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779657428; cv=none;
        d=google.com; s=arc-20240605;
        b=RRuHY3duoKCYYBjOJIPGHIcekBG8dpwTOCkvgAK3WVN4jhNPD/S6TYFnPOm95clBGW
         hYlB/9bDXxibdSeRFaRR4mRegHlxHjINMryLRePU6XlJX8SWKLBtGvj00cdQ2LwkeEHQ
         djlpkrpSr9At419h4YezIWEZRePbEJ45p5zGq6U4akAp2P8992HGSzZWZ9X+iuiQlG4k
         BhBjn9uBRELPznrsl+TPWDKGM24h43+xmU8eHi9YYmq73gXywrE1Ddp4K1/rveP1bjxG
         92TVvVFR2kiEn7nFmevRmXpUmx4BqOiZphqa6TsQmB5oAaLJn2OHhWSGx/9yx8/riavq
         OX0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        fh=upFGsTHvqs8/XK7GUhgr9q6ce0qNz126O9hTKta9JpE=;
        b=P9HDBC+UHczpYWzRn1zT/wNcfcH+EInGdxHw8pfxlCqybhXN7RqTZXO+UDUZygWSl/
         BVeibtswSvQgglTZrBPW8/yTeSGo6uccOBiEseSWzFuywMQTm9HReKgu8rJ9ov3N4N2y
         sg2NTWXo9ZNcWFI8L2tpT08lFTaJogSGHwW35+apzchJZ01q5h23UoDqjzvU0P4w3XGS
         gBN9sAfbitA+hGD4pXWE6/BKEHjOz0DcY+hP5ELU+1BZOURzd7gy7UY2CkzxbcYTTFjv
         KLAkqL3CuwOutfx+dIKQ/jVA9e2OBSt0UysZiRIr/56t9HkJ6OxlygSDWO9aYorwdYEv
         pzzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779657428; x=1780262228; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        b=F1bMJPdtZgkqyu65CsjIi2ZYg5QbFD7Y7uGdQ7uE6/w5Oe26j1eOnTsAdgHkCUL2e2
         ZCFd9WPpLhoWkrzVQylPo/yBj7h9eahiygtA5PLTStex4JFHWzGURgWQEmVJYVahTdTF
         tVrSTVhjG97cnaIFgfEdJ1PovFmar8znQH9RPzTWpD49DqB0m/PoYMcNs1v8jlBuaLEw
         S9g8r5d07Lj6Kl13piXqv+IVAEd+YRGmqCaW/VA+KxhPj1HNzhtXomG79r3EypvTljRJ
         3/oCNDItTkc2AffGkN7wSsX9UtmfWVb+t47+t31q3pEXAeF3iyf/Z5ILFVSwxC1vO5hh
         vx1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779657428; x=1780262228;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81SVtsumHItsjvk/xJawurytwgu7zZM7CD6y/vNW0oQ=;
        b=FbSB6wVVBJ/kecpE4NWUJWEngiWrUOwPwNCfrAGJPQXOfdj0pSSjM0AjybSjKxZ4eB
         dxNMn7LseUUa8xR+87WfVJkaPx4jgljdW1haS8q1I84+U/7rQvzaLTTSVfMJ+911m6r8
         DnSFsMepnd8i2TqTHSTd39zXJptEaROuZpv9tZSSKqov/ne1DR79Qn34lr7PLl9elGR4
         cFzIpd4Ei9Cqp5LS6kBx3zH9/4sFn85dZz8BwlSCy3qdIXwkwmAegPgH88crfvYCwtDy
         jdLSQJe8RHRUc5QOkDHn9Tl29KyLp4gU8LswEhjEj19f7gCcE3hEzPZbcDJy5sFs3FND
         dfHA==
X-Forwarded-Encrypted: i=1; AFNElJ9Z32okDKvMcqmrBt80AoBcxQ74aq+Dnp+aO+5eEp6wMh611BwozuO/wNAjNfAj3maeDbh0kg/aE18=@vger.kernel.org
X-Gm-Message-State: AOJu0YymFUQsBTWvpuOcV2el3d/h/GSQ7/mUFoI441smnm8RpZg8gFJF
	rr361/NFLn8Z4qDcmeXDruS7l/4TBPMZo46TIOV7z3RUez+MKXyt7Zm7dOZo553zLVW+ptvoXez
	oY6AZPj4KPZFYioOc/qUDr/Sh/uGPCxXypQsVgqxPEA==
X-Gm-Gg: Acq92OEfU4xaDb+jmQL90vBzEqJshLNRcTmrwh2SmEHlgAv1x/l2ba4boF0h6WRucpf
	G8WFVVf3/4lvFU04zO7AifpQNeaGlV5G3AYRpEUVVMS7Hbez34t08ApQKqf2bQDgLlY0t2HEQsz
	7Q0NqdjQw05FA0bRUH/v6VLblGkqYZrJOs2WRa/IQANxmZdVjVbGMJEqerk9j3qD/Z9rkF/80bD
	Exm9nEi3GlanhcPxadIaT18l2RLDLOy2zTRR9W9M1I++YuyL/y79Uev3XuKnYxXBlI2jb7Rc6GB
	cxSUXFcpd57y7XniD/LTnq+Mqr307xngHqH0
X-Received: by 2002:a17:907:7290:b0:bd2:4aa6:1a9d with SMTP id
 a640c23a62f3a-bdd2360237fmr744344866b.16.1779657428216; Sun, 24 May 2026
 14:17:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 May 2026 14:17:07 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 24 May 2026 14:17:07 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
 <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
Date: Sun, 24 May 2026 14:17:07 -0700
X-Gm-Features: AVHnY4JHtsLYNvdawYYzb7h3_2sEIhQJt9TYhOw6--5OCNVF-hms1fU3-Y2rI9c
Message-ID: <CALSJ-wDm8NoB8mF3KSx49XMSWz1vjwFhSmgJZWq8pN2pCf12mw@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-10800-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 616315C453C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi All,

On Sun, May 17, 2026 at 03:41:31PM -0700, Angelo Dureghello wrote:
> Hi,
>
> On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
> > Hi Arnd,
> >
> > On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> > > On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > > > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> > > >> On 7/5/26 05:12, Arnd Bergmann wrote:
> > > >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> > > >
> > > > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > > > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > > > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > > > [    2.290000] spi_master spi0: noqueue transfer failed
> > > > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> > > >
>
> About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
> i probably lost some dma config option.
>

so i worked on this open issue above:

- moved to master and rebased,
- crated a wip/edma branch,
- bisected and found the offending commit, before this, mcf-edma driver
  and connected spi-fsl-dspi (using edma) was both working correctly.

7a360df941a4bd60847208de59f1ac8b166265a2 is the first bad commit
commit 7a360df941a4bd60847208de59f1ac8b166265a2 (HEAD)
Author: Christoph Hellwig <hch@lst.de>
Date:   Thu Oct 12 09:52:27 2023 +0200

    m68k: don't provide arch_dma_alloc for nommu/coldfire

    Coldfire cores configured with a data cache can't provide coherent
    DMA allocations at all.

    Instead of returning non-coherent kernel memory in this case,
    return NULL and fail the allocation.

    The only driver that used to rely on the previous behavior (fec) has
    been switched to use non-coherent allocations for this case recently.

    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
    Tested-by: Greg Ungerer <gerg@linux-m68k.org>

 arch/m68k/Kconfig      |  1 -
 arch/m68k/kernel/dma.c | 23 -----------------------
 2 files changed, 24 deletions(-)

So i can try next week a patch for edma looking what has been done
in fec, and since i am probably the only with mcf54415, will test it
here.

> > > > DSPI is using edma, i will try to understand where the issue is asap.
> > > >
> > > > About how it works:
> > > > - for accesses to edma module (IP) mmio registers, must be native
> > > > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
> > >
> > > The twist here is that with the way that readl() is defined on
> > > coldfire as a non-swapping operation, and the generic
> > > definition assuming the opposite in
> > >
> > > static inline u32 ioread32be(const void __iomem *addr)
> > > {
> > >         return swab32(readl(addr));
> > > }
> > >
> > > the function called ioread32be() actually tries to access
> > > the registers as little-endian. I can see two possible ways
> > > we got here, but don't know which one is currect:
> > >
> > > a) the device actually has little-endian registers (like it
> > >    does on i.MX, but unlike all other coldfire devices), and
> > >    you just never noticed because using ioread32be() worked
> > >    as you expected.
> > >
> > > b) you tested the driver using an ioread32be() definition that
> > >    did not have a byteswap and it correctly accessed big-endian
> > >    registers at the time, but the version in mainline today does
> > >    not.
> >
> > Ok. The ioread32be now works properly since i had applied Greg patches.
> > I generated an error in _probe on edma channel 2, reading status reg.
> > looks consistent:
> >
> > 	iowrite16(2121, regs->erqh);
> > 	iowrite8(0x77, regs->serq);
> > 	iowrite8(0x12, regs->ssrt);
> > 	
> > 	u32 status = ioread32be(regs->es);
> > 	printk("%s() status: %04x\n", __func__, status);
> >
> > [    0.140000] mcf_edma_probe() entering
> > [    0.140000] mcf_edma_probe(): allocating data
> > [    0.140000] mcf_edma_probe() status: 800012f8
> >
> > If i am not loosing myself in this r/w labyrinth, the path should be:
> >
> > 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
> > 2) So the ioread32be swaps the standard LE read giving BE.
> >
> > Am i correct ?
> >
> >
> > >
> > > > - for accessing the "tcd" memory structure, that must be, from what i
> > > > remember, anyway in little endian, independently from the cpu core
> > > > endiannes, this is the reason that big_endian flag is needed, it is
> > > > used for tcd area accesses, so the IP module was built.
> > > > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
> > >
> > > edma_read_tcdreg() calls into edma_readl(), which is the same function
> > > that is used for normal register access, so from what I can tell,
> > > they always use the same endianess here.
> > >
> >
> > If edma_readl was using
> >
> >         if (edma->big_endian)
> >                 val = ioread32be(addr);
> >
> > and never changed, without Greg patch, it was likely returning little
> > endian for coldfire and correct LE for other arch ? :)
> >
> > I remember something about tcd area was coded LE, but will investigate
> > better, now i am over midnight.
> >
> > Regards,
> > angelo
> >
> > >       Arnd
>
> Regards,
> angelo

Regards,
angelo

