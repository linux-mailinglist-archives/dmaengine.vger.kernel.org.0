Return-Path: <dmaengine+bounces-10493-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MjImJCZECmoKygQAu9opvQ
	(envelope-from <dmaengine+bounces-10493-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 00:41:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7556431B
	for <lists+dmaengine@lfdr.de>; Mon, 18 May 2026 00:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF583007940
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 22:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E323D6476;
	Sun, 17 May 2026 22:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="yeUYLRx2"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0FC3D6487
	for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779057697; cv=pass; b=FM4uBzY2l6V8eu7Tz2IHtF30/ojPBNFrNs9g/+wOdXL+thbjgHjf7yvYMLzkDiIC8AU5Rg+sa10l9TGdR1OyMt9FKWyJJ3gQHqVZA+91384haaz1t4bQjWhaCfNQPd05vXTCzw+PHNrToDuKlDFqWDLuGewOAU5yl9kcuW6KAP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779057697; c=relaxed/simple;
	bh=UDRqVbPZNo1rDKG47pl3Cfg1y+NpJU3+9tCj4VzpKzA=;
	h=References:MIME-Version:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nL4t9ChhcmEQvW1uxeZgivDULrlwoT0UF0qsCrcQmtd0Oqlr8xX6VamswNJ5e2m+qaepfs6xqSwoq7MHc18/zXVOPmXM80qy0hEAjTq+8kBcLM4aSpEPvzk58nwEXCv8DTqxEHi+0ssZxv6VAzlNV7ueuWuP2eb2EVhcTMyPsSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=yeUYLRx2; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bd5047a2a4cso291873466b.3
        for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 15:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779057692; cv=none;
        d=google.com; s=arc-20240605;
        b=SfRdUdFxGEzXkwRtXdkhpc3IS0f124zXOK3f0ExxuSyocREpSQ36RdQaQsAgF+ZjFk
         ewF0YQDbrpBjJgrmcuQxlYNWYV3uYz2crhgXdaJ3cL+d3hWjUpLjWOah5zxwc3SWyXYE
         nj1xhCLFm1lLFLaDg+3t8RFCRxGRFsBIndGTAvne0V/BB5B6fLhB/Lr1fbvRLYHb3Gm4
         kiWDU7/Hov79I9ZLha+sWQsY/Qn0pF1g2Wnkp0GDHBFvXjefB3sHRE+2kniUdrah1FyU
         A/sa/6Nzm/sWz2io0b6fY5esQA5UE+yeqtaiUHJrtobalVpazIv1aLMpG0/d3RK39lM3
         ke6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:dkim-signature;
        bh=6WvnwIRGvHEPeQ8ZKX+R0d/VCeeAw5//At/YqjZNVr0=;
        fh=i8uF9BYLS8Pwi3AI00Vcm020SysOH1qZm1oeO70j0qE=;
        b=YBbP5OJze1dL0pcJpPu72RtcPmsMfi4N1XDMYqdHYR/zIG7bDG81z2UDUBx1edz2uR
         HrTPnKR/TKuiBrlrEI7cxGhmPSfc+2+zcbLBROZhAHsv0ltW6wHnaHbLgqCtQdqTSo/V
         089y6PmWAvsHPYvNaj/CP5rUxG6lpkDNleM3m8SxBGenrpgbopavSyVpOPdukwi/XeTr
         BJxVslKo6wpVRqV+7cVroonAnqPvT+6Wz5QfZypyseU9zR0paalZfpDA8eNdFUOO/DRV
         J81As/nwZ/kmppxpOAb1WdUWgJnTkEsON5vmLkrSLBKh+FVgd5PWs4MVX6BrA4loeW8/
         w0Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779057692; x=1779662492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:from:to:cc:subject:date:message-id:reply-to;
        bh=6WvnwIRGvHEPeQ8ZKX+R0d/VCeeAw5//At/YqjZNVr0=;
        b=yeUYLRx2ZpZFxVDTbe432d7JGuXuyNQn2mARdpaCX0NIQUBK2S4HkgWyUxmF3ZtAhf
         gja4tkIKOU6EYIswd6FavucUO/m/Z8XKwkUeZyf05p0zRclWWcAJ+lJyIpxUhDwBVl1E
         Ne0Wf62u8gN6ca82mlsJ6DTEMKib/xM3U7Gref0cc3UNC4fv5Rh/ZKlnC7g6DhvsOkJa
         ocqbCsO62WsFBPQWIPykD+F2WZxsKb0P1zJcxkEYVnam+bUUV3WgBwhjUbBfQj70hqqO
         XsOEg19E7oDkjPuv4zVPNbItSde66le3vGzH87KGzemIfIJsBGF97tp10C8Fe5WWx22u
         M5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779057692; x=1779662492;
        h=cc:to:subject:message-id:date:from:in-reply-to:mime-version
         :references:esfrom:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6WvnwIRGvHEPeQ8ZKX+R0d/VCeeAw5//At/YqjZNVr0=;
        b=JN7qV7KP+cSykmM4nsBN+QnxkaL503QkJrDKK0vcvrklUSs7vSP+ohT3esRTMuAvJ4
         w+UDJn443SJesWHhEPoPNmVtPVJeJNVsP0puLcB1IneHgQv2rttdTRaA+Kcx0s7q+0gn
         XSzSb+3AzR8GAUA8WLB4wOCuG67hz1hcHTJNRaLUdBS7MYBC2XCQ4ixZNyDMS1So+VYK
         SIA2sFn/5Y2tAjpVXHHU76dx/KajVD+57Vky/4xCQiykiDkJRfGSHifG+B/4fFANT3yM
         kP8MC2RwoVPX5bA7lznRgxBc/G1EBKNCjeeTT0QJs64D+I2EredxcNfzFyYYhQxXwXx8
         lM7g==
X-Forwarded-Encrypted: i=1; AFNElJ/W/K0UkoNcrpXrhHGjWyqGPPPBztbUIe4W8o6DdDNDuur8WXHIb2H12k8F3VVK+l+f4BjdqKqLTkk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzysPvalujFfaMZxw/Xcqy+2oUWF/HJgnkjb9gswEmByutqYnlM
	J6+/E9t4+TEJQTAV4aGR523w32FiTq20jke2LJL0ywKM7L9wOb/ujpROvSBQ0usCkFNS+XeVefR
	ZDSkXC0//iLYcdbOAzY07e0CI21IoQ8RVMQLTqlM7Yg==
X-Gm-Gg: Acq92OF5JIX77Q0TGtHCNgleODmUDTufSfYEIYSIl/+aCMKfcjK50XW/X2BNY/uFSgn
	16IkbZvmGoUxB8M4y6AmQg3DrVQwCQwzR9L1nPS+VO3x0emKzMPoWwBZOY+CNIZ7DhgFrysWz+q
	a4LtGdl4UmaTSksHwQEstTpgGz5GG82gjYFgEmMXSHv1DWktIJS8tVWcA50hXVupITBt08ZsJwX
	zzLs5sAs/UKhpOm3o1t2OSbncZGHTWhcOYz1h5l07imqC663n7P8CuQGUJ8eimsumrunPZw8ee7
	qNS+aSazPqBwVwB4Zwr+fpnWZRH2DHBwJW6k
X-Received: by 2002:a17:907:1c8d:b0:bd2:bd2:6ca0 with SMTP id
 a640c23a62f3a-bd5177bd03fmr585833066b.11.1779057691600; Sun, 17 May 2026
 15:41:31 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:41:31 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 15:41:31 -0700
esFrom: angelo@archlinux
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
 <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
 <9391b782-7727-47fa-ac37-05cd50821d35@app.fastmail.com> <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CALSJ-wBRmUpjz-_ehZ0U0Gu+fPqRUeAn47E0_pwpXQa0tCNzVA@mail.gmail.com>
From: Angelo Dureghello <adureghello@baylibre.com>
Date: Sun, 17 May 2026 15:41:31 -0700
X-Gm-Features: AVHnY4L86sFPwvstwRi47J91deZeB_tEn5rDsykk8GHRpiEzaTYsrGzZ-WixK9I
Message-ID: <CALSJ-wCuZs9cBJsuOOYMEYM6xOXZbdOm_pr=70d3HRYYSYJ0KA@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Greg Ungerer <gerg@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 02A7556431B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-10493-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20251104.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adureghello@baylibre.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,baylibre-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Action: no action

Hi,

On Sun, May 17, 2026 at 03:04:23PM -0700, Angelo Dureghello wrote:
> Hi Arnd,
>
> On Sun, May 17, 2026 at 10:08:22PM +0200, Arnd Bergmann wrote:
> > On Sun, May 17, 2026, at 21:43, Angelo Dureghello wrote:
> > > On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> > >> On 7/5/26 05:12, Arnd Bergmann wrote:
> > >> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> > >
> > > [    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
> > > [    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
> > > [    2.280000] spi_master spi0: failed to transfer one message from queue
> > > [    2.290000] spi_master spi0: noqueue transfer failed
> > > [    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5
> > >

About this issue, it fails on dma_pool_alloc(), so tomorrow will check,
i probably lost some dma config option.

> > > DSPI is using edma, i will try to understand where the issue is asap.
> > >
> > > About how it works:
> > > - for accesses to edma module (IP) mmio registers, must be native
> > > big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
> >
> > The twist here is that with the way that readl() is defined on
> > coldfire as a non-swapping operation, and the generic
> > definition assuming the opposite in
> >
> > static inline u32 ioread32be(const void __iomem *addr)
> > {
> >         return swab32(readl(addr));
> > }
> >
> > the function called ioread32be() actually tries to access
> > the registers as little-endian. I can see two possible ways
> > we got here, but don't know which one is currect:
> >
> > a) the device actually has little-endian registers (like it
> >    does on i.MX, but unlike all other coldfire devices), and
> >    you just never noticed because using ioread32be() worked
> >    as you expected.
> >
> > b) you tested the driver using an ioread32be() definition that
> >    did not have a byteswap and it correctly accessed big-endian
> >    registers at the time, but the version in mainline today does
> >    not.
>
> Ok. The ioread32be now works properly since i had applied Greg patches.
> I generated an error in _probe on edma channel 2, reading status reg.
> looks consistent:
>
> 	iowrite16(2121, regs->erqh);
> 	iowrite8(0x77, regs->serq);
> 	iowrite8(0x12, regs->ssrt);
> 	
> 	u32 status = ioread32be(regs->es);
> 	printk("%s() status: %04x\n", __func__, status);
>
> [    0.140000] mcf_edma_probe() entering
> [    0.140000] mcf_edma_probe(): allocating data
> [    0.140000] mcf_edma_probe() status: 800012f8
>
> If i am not loosing myself in this r/w labyrinth, the path should be:
>
> 1) Greg removed coldfire readl/writel, leaving now the standard LE r/w,
> 2) So the ioread32be swaps the standard LE read giving BE.
>
> Am i correct ?
>
>
> >
> > > - for accessing the "tcd" memory structure, that must be, from what i
> > > remember, anyway in little endian, independently from the cpu core
> > > endiannes, this is the reason that big_endian flag is needed, it is
> > > used for tcd area accesses, so the IP module was built.
> > > The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).
> >
> > edma_read_tcdreg() calls into edma_readl(), which is the same function
> > that is used for normal register access, so from what I can tell,
> > they always use the same endianess here.
> >
>
> If edma_readl was using
>
>         if (edma->big_endian)
>                 val = ioread32be(addr);
>
> and never changed, without Greg patch, it was likely returning little
> endian for coldfire and correct LE for other arch ? :)
>
> I remember something about tcd area was coded LE, but will investigate
> better, now i am over midnight.
>
> Regards,
> angelo
>
> >       Arnd

Regards,
angelo

