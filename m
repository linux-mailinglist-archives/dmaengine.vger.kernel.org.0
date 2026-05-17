Return-Path: <dmaengine+bounces-10492-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MQmAXg7CmrtxwQAu9opvQ
	(envelope-from <dmaengine+bounces-10492-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 00:04:40 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC265641DD
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 00:04:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 505353003612
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 22:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD77A331A63;
	Sun, 17 May 2026 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LXAwF2Pr"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C33314C4
	for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 22:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779055476; cv=pass; b=Gsev6j2L/uFIjhyLXl9iZmvunOreEagdGKyw99oEyk/pcBpFePeao/myZ8572ETbRri73/Vttp0rmlzVF7TbJxwiQE5RO4aEII0Quo22Po0UQTl3MXy5J+u+3j0QqFN0NJuTQW+Q2c9q/oQ9ph4dzbyQcJHlMrS+lru97rO+j5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779055476; c=relaxed/simple;
	bh=gZHJrfIdPYrab0HpvH9DcCEOEOFnzCPNy8/jE8lgWog=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jh4jfFcqndYeyqPn4IgRKGOq0ALpSkBsrO0DVEfdPkVuwj4oA8YOSMiV6LqtiYsbwHlSf3AhkuuyNQqkz9tk1dAJF4mfSy1ZNkm4PXu7i+aVKNZb8vV9f2DdHw1KUX/eeTirfHngWWdR9TOtS4jrC8Yab6ifiuerPrtp0x1rKZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=LXAwF2Pr; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9d9971d059so228648466b.2
        for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 15:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779055465; cv=none;
        d=google.com; s=arc-20240605;
        b=U6EsFcX7e2U/Bc3I5Udh3SU00EfMdD49KAEqN46k/8HZfTEnLsOg0wz0kSaSrbs/Lh
         xgbAF7LWBxRTq5E5u8S8iQhrwg/DyeSYmC3VzzchrsZFMCWYknt1b6zQkrGmgZryU5w8
         fhwxwJQM+wZWuAnacVxK5fztHYDDJ+1C5GAoAGMErv/+W+k1NCF+t2PXitrchMZMW4Bn
         Dq13m0YBjy5IUwo45qDT/FvjcHE6BhIi67INIBxPLb6Mkl9YbgABfQqY5lhAdfVzZ6rt
         W8WWRuJj/4ajt/O2HQM3R1XPbdN5+yB9oFkBadVZt0lG9kiwCwZjq8gfXgOJWAGZhAv4
         HhvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        fh=5LtRE6tIsNP+VjaTgQvVZ3dJkA9plvB8uODwzUmWBuI=;
        b=dcS2orSJ+6RnsuLjERvUHaEnW2PsO1CacHD0XfcbYljsPtp92J2ycknNLEqFC17KGR
         gjjtwnTuVFWglGYEG+3a7mk86u4uY8gA3DJqqt5J+w9d5G9Pfvp6DTWznwAf9pM2ECDg
         9jVduoEV092QZRX0wFhWgL24usY4hVn10F9xgZf7ap5Tb9F54rCct8xePD0MHrCrK8Bo
         G0rV78m+LaNrZJK6Ve1tYF+97BglQq7amv3zQ7AWbr+s+TnRZqRm8IiEIfkjzurwzFdP
         00fg01EkWNVhx2yZz0il6S9BGsCTlzgKbsz7pP3jX2VYyN5LLoAF/BTYjrxMpVZp9Fkl
         Z3kA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779055465; x=1779660265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        b=LXAwF2PrT5A9q9fuByASsT3Wn/hhfhryTp/ed5JOL1JhYOtxs9V+nCy97YzXUfp4kz
         VT6nlWpF8Sd90IQWMWpP8IVAu/vhMQ26OSOjaC0Ugc8TnDq0/SBbJNiABkL26hw3DB8N
         OHMkEEQupPKPoeZmdRjOa/a0mvtC3FwpJCyhKo9ADBIqdbpQQfjwNKLqt9kdxima/dRd
         HZFqr+5fAgH/K2Z678tylyWv3L74Q2/vWpc63Bf+vgdjaeruHqNsz7J6z2TIauN9AVQ+
         hfDrcihuGzHPLRwa3YYfY9utzd3YOCXFlAo3qCShBVqPyYvX+sS6sRzni7ejQ1BcRYuO
         fktQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779055465; x=1779660265;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+glZ8x8Rm3dZ3GzM3y1RWyyv+YJrSKIn1wrNvuWwxYc=;
        b=g4iCyQ1Xo07W2CfjKY6QVS3t42NTEEdUkY3/DpQfLV42b5Le2lMkhQjfEzXiChPQ0u
         tWNQnfXlugBvhaBnSVU+e/lsJ41BGa5+9HuvAb5KHvRfP7bXEN973BZoGpcd2D7J4DRn
         vIbUgPtM5Lhj3CgB5zUQWxeAD7dG3BZKBr+6z8GLbmoHKTxwukftBCbOC9ESHth5pjV1
         4FeT0bqOukaUp+QUehMdATzJwDuLOKtHRkyXvuTWPuL+ULr5dlzeBWJ+ETwH9O523Gm1
         RdTHeUjLzU4qAgg+EsmpdGRIyhWBeRydkf99XKiHESumuki12f3GYyohy4JqiNGyjPTN
         REuA==
X-Forwarded-Encrypted: i=1; AFNElJ84/nB4wEWaW9cfAovBqfraXSseEXBp8uyavB5iL8bogGfkM5rSYtfbzB5yJSuKGOMrmSU2CnPaM1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvTgoOQ27etyygv2FzXB/O1aeeDGzeCwsoOO18bGiRJLRRwcg1
	oedD1G8BkL0KuIUmwYCnyYDvy2QwqRo2hfxErZs5gk4mHIpy39LGzPsD39orw4Vq5GR0CmRaSiQ
	nIeNfxBjMZEyl/nKhyNFT4PcarpU0u2IFKOVvEZ2oww==
X-Gm-Gg: Acq92OHPTgzUERVA3JFa4ra5yEtq9b5eMHE/TrIswylCz7yjm4zb6CTcGkdIzXsMhqG
	6nEFF8f0DAWHKvvT7g0GqFntStwqFo+Pvu/eOdSV8L4h62M1LKsLSLja4w0gA2bZAO0qY+kAFZz
	z009lC/utUhATGHVoOIhCPdJj8z8dFhn8DVXWxUKq2AUHCDpSiFYe++8IBy1nDrAfgv1o1dyeiG
	0soi4djGUQ7XaN5SKCFfHGl5p0iG09cLTYh2siKmomr5eqJU4uE/0xIRS8yfEa56jiqf9t3/FYK
	p7Excn1isM144XW8BWe4VdtZHyRM93rx1rZW
X-Received: by 2002:a17:907:3cc7:b0:bd5:18e8:1ad8 with SMTP id
 a640c23a62f3a-bd518e82334mr600884066b.4.1779055464251; Sun, 17 May 2026
 15:04:24 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:04:23 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:04:23 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com> <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com>
Date: Sun, 17 May 2026 15:04:23 -0700
X-Gm-Features: AVHnY4IqhiV2sSnDG3bDc8vtXUEslTxnP4xgh859XRbJ5eiok2HZwd1skAiBlBc
Message-ID: <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Arnd Bergmann <arnd@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Greg Ungerer <gerg@kernel.org>, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-can@vger.kernel.org, 
	linux-spi@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: DEC265641DD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[baylibre.com,kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10492-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre-com.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

Hi Arnd,

On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> >> On 7/5/26 05:12, Arnd Bergmann wrote:
> >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> >
> > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > [    2.290000] spi_master spi0: noqueue transfer failed
> > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> >
> > DSPI is using edma, i will try to understand where the issue is asap.
> >
> > About how it works:
> > - for accesses to edma module (IP) mmio registers, must be native
> > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
>
> The twist here is that with the way that readl() is defined on
> coldfire as a non-swapping operation, and the generic
> definition assuming the opposite in
>
> static inline u32 ioread32be(const void __iomem *addr)
> {
>         return swab32(readl(addr));
> }
>
> the function called ioread32be() actually tries to access
> the registers as little-endian. I can see two possible ways
> we got here, but don't know which one is currect:
>
> a) the device actually has little-endian registers (like it
>    does on i.MX, but unlike all other coldfire devices), and
>    you just never noticed because using ioread32be() worked
>    as you expected.
>
> b) you tested the driver using an ioread32be() definition that
>    did not have a byteswap and it correctly accessed big-endian
>    registers at the time, but the version in mainline today does
>    not.

Ok. The ioread32be now works properly since i had applied Greg patches.
I generated an error in _probe on edma channel 2, reading status reg.
looks consistent:

	iowrite16(2121, regs->erqh);
	iowrite8(0x77, regs->serq);
	iowrite8(0x12, regs->ssrt);
	
	u32 status = ioread32be(regs->es);
	printk("%s() status: %04x\n", __func__, status);

[    0.140000] mcf_edma_probe() entering
[    0.140000] mcf_edma_probe(): allocating data
[    0.140000] mcf_edma_probe() status: 800012f8

If i am not loosing myself in this r/w labyrinth, the path should be:

1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
2) So the ioread32be swaps the standard LE read giving BE.

Am i correct ?


>
> > - for accessing the "tcd" memory structure, that must be, from what i
> > remember, anyway in little endian, independently from the cpu core
> > endiannes, this is the reason that big_endian flag is needed, it is
> > used for tcd area accesses, so the IP module was built.
> > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
>
> edma_read_tcdreg() calls into edma_readl(), which is the same function
> that is used for normal register access, so from what I can tell,
> they always use the same endianess here.
>

If edma_readl was using

        if (edma->big_endian)
                val = ioread32be(addr);

and never changed, without Greg patch, it was likely returning little
endian for coldfire and correct LE for other arch ? :)

I remember something about tcd area was coded LE, but will investigate
better, now i am over midnight.

Regards,
angelo

>       Arnd

