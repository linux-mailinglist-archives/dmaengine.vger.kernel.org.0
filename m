Return-Path: <dmaengine+bounces-10489-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UExMCF8aCmpawwQAu9opvQ
	(envelope-from <dmaengine+bounces-10489-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 21:43:27 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D5C5639A9
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 21:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 07A67300954E
	for <lists+dmaengine@lfdr.de>; Sun, 17 May 2026 19:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533EC3D332B;
	Sun, 17 May 2026 19:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="O1oKSyVv"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C92F3621
	for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 19:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779047004; cv=pass; b=csCRA4GoEtC6b14B95ZkhD6ItckAigFVpBFjcrt4Jp8uBnRJPNTeeTJGVqx9qPgnb6Mri4vkj81He0ZYqHLlFODcMQU8fX5+1YD9nml+bGULCfBNx3pufc0s5afbe8emdEO0k9Pk9tBquegLLRvtwNbr2U7ig2aMv8+vZcFH0/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779047004; c=relaxed/simple;
	bh=qohdw6c5XY/Mph5vnXjfspO9h70+dVSKRCgfLeBy8yM=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPy8434HklgKV5Iws1Xo1LNe4gEdD5ywmy3omvSXm4xGzh5s6Xg0VFLCtduAmQOYb96MMp0Wo1X7/UVAdqKzig4f4yZL+enqszwhAUrYJBqGh1EnABygzsUOCUdiwdt3x7YvqQLMtClqYXUwukorhLp6B6PNQnabWF4Il8ArDAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=O1oKSyVv; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd4f8260e4eso342013466b.1
        for <dmaengine@vger.kernel.org>; Sun, 17 May 2026 12:43:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779047000; cv=none;
        d=google.com; s=arc-20240605;
        b=YlL3LKSXbYH9YQzIDmA+wgTi3IC9G7rG5kqexNsLGXLWXH0fXk/c49cLblgRFke987
         tzjsAi6A5qH1u/D7j/kW7u9ffDdI3LmYa56slQ8x2cRiyKzUr16S8NLjmCwjF43q7bH+
         usw4Vr//W+psGh9fc7lVhPRKJR36et9xlN453Hw8n4Pea93cYv4lM1VfcrHuI6EwweW7
         KkXKE+Td5A6e4FUXANIt3yeFXvrBmNwAXZbmN3l21hgS3+UZ8sfWqyO3/NCvyg7WNh/J
         5vsWdya0dikJlYXimDlGJZgbp+Uh8tYsosLrt/WJSRhWH5giTnqxIVMZjqdXIjRFduqx
         tGTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:dkim-signature;
        bh=j6Mto1oYp8fxMNax/4CSsHkuQNzcdJnt+Yi59gbd/34=;
        fh=/Z7n5wSUnj2+eTpW4qXEdks0Gbp6OXssf9kz3z4qY70=;
        b=T6wnq+fzKQ1ibLK/bmQsHuukRMBoJexIU6mQEeMA+McNQVG/z59APOYvjEZyRVoFKj
         GqpHfK8wpOVNllwxf+3zIsVgx6EzAg/0+wy2q4jU+4ASIyu6XHEDvhB8gtMldouciDmK
         2Uy5InBvajwYGOsF6GNGRgsn+7C/m8huh6Jbw3vmnCIEAF8I4oSFfSKVLCr3bNbR/Ldr
         vePTm9wbPkesdrs8a0YEVxgXJujNLLJIgvcbbkyjzLnqOECGp1bbycUN4R+K4tQHuc6z
         R3RbAsynv006T3+mnRkGQDzmDjYZZQsIBJFEBMJdSdFElJMbHZanjUOwkYIUQ3eAg2ln
         pm2A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779047000; x=1779651800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=j6Mto1oYp8fxMNax/4CSsHkuQNzcdJnt+Yi59gbd/34=;
        b=O1oKSyVvQI4s7vPrStCGQYiyPmyqNHQroE6uKzZDznpIG8Uw2DwXDmcYIj6LiDShMe
         o5RtRmwOAgxfQZLTb2mooQeDL+pX+WzD+G5aKl3PkQ9fCBaxwKcJhh7+W03gZ1TiGUAA
         mxlrVCj/iPTIu1aitA9noatwI0DlC6/yDBBGczPO3mmEyk79uQ3t0i7fZYnxkez3+2HN
         YTnoWBNfB/1DgnqJr2+aoNDgBd3NSw2WBKYcodMADb4sfNYH7aEPX+rv+lhXG0hDnyHF
         rwU6u3+Hhrj0bp+DWf+II0IGh8/Vtz+2GlR7WYYMeoR5+ne9fc3cEIYrBNXWwy/5IMRu
         G8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779047000; x=1779651800;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j6Mto1oYp8fxMNax/4CSsHkuQNzcdJnt+Yi59gbd/34=;
        b=bWjSw5E6zbnfGxBU8CLpTfofyzONym2UOkZwP17mOp5+gh8jVskaRqBh82f5w69rcU
         TDF3iMFQCikJRzuf5AO7lwv2g4LlaYGzjJLoTRlxX9dqyW5Psz7EC59SeQyyGIJCOWE2
         R6DJ4JV+gRhSuByAuuhDL3vFqk4pQq/bliD/OCn9R9xKuybsamcorfP45sbkS1ZLZnUi
         P8ENdNRK4cF9EpXGbvVq+85wvhCpwdBLJEPnsc5mv2xD+FOMX1D9p49kPB6iv/hqRwd/
         gduIGMEOnvv6+Gg454LY2ZUYbbGn0cCpXOgSgoBINw5QzucwkzMS7gOW2DqD6Kw/uGx2
         YzQQ==
X-Forwarded-Encrypted: i=1; AFNElJ/1Ou7oPqKQyRQPukP7luv2ihBVAXi4jFIR9pj6B00jfkPUl+x6VTp+wTl0NsOGkgTKhH5eeGh9yzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaHplAIwBjEyCJ+15YGPTVn7K7m7palONOtVfwhR3zIT7SOjaL
	CPfgsKpaJCpmcuElOvH5WYMk1EeFEFk30XWIfOK63iW3gpsgGwlDPOZMYXBvaYU7zlrefEVX5+R
	WLRh1TK3JsDcefZoZHHSo7vpYgRchBlwcZ8jYrZ5p/A==
X-Gm-Gg: Acq92OGPfP0R/uBbP4UdxDgkpe0pfJ70lkJzkCiI9OEYLjNtmY92aszG1k9eTYN0lqx
	8Mn2rDZkRLlvUKoSlZ0V67oPWQi/nLy24kbcNuP9AwkoNnJEC0+Apz0FPnQYIGTLPIihdpEJpFr
	lpy2+UuqRQRGL8vvhMsDl3CW3ZdkSV+85Mtn2SUxirpnNpRcHeP/ZZda4WZtEUjw8r4g4i6i+72
	VBoqs0BVk1UvPG+mSmRc7zLAe8Eqxub5hq5Tg3Hh5tx4DOt99lV8hEMh+PdkD9t+sAFsoNNkO7H
	fgzhUU71emGJsutoAkEBkKIdilxUixH1or6UGObfPxlNgLQ=
X-Received: by 2002:a17:907:1c9c:b0:b98:40e:f335 with SMTP id
 a640c23a62f3a-bd51795070cmr615382266b.34.1779047000052; Sun, 17 May 2026
 12:43:20 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 12:43:19 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 17 May 2026 12:43:19 -0700
From: Angelo Dureghello <adureghello@baylibre.com>
References: <20260506142644.3234270-2-gerg@kernel.org> <20260506142644.3234270-8-gerg@kernel.org>
 <40aefc39-bd98-460d-8aa7-5dd79f562e0d@app.fastmail.com> <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <fdd6fc14-f607-4186-8db4-25de973ac322@kernel.org>
Date: Sun, 17 May 2026 12:43:19 -0700
X-Gm-Features: AVHnY4LTi1UepgBp7RlwHGhgQikPAAttg6_8VSJjgHVMj7UNTEH_cv4_jkSHs5E
Message-ID: <CALSJ-wCrNDv3N2Kdo0uoXsKGtp0GthJRBeYTNQA1gGE2akUWFg@mail.gmail.com>
Subject: Re: [RFC 4/4] m68k: coldfire: fix non-standard readX()/writeX() functions
To: Greg Ungerer <gerg@kernel.org>
Cc: Arnd Bergmann <arnd@kernel.org>, linux-m68k@lists.linux-m68k.org, 
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, 
	linux-can@vger.kernel.org, linux-spi@vger.kernel.org, 
	Vladimir Oltean <olteanv@gmail.com>, Angelo Dureghello <adureghello@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 89D5C5639A9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux-m68k.org,vger.kernel.org,gmail.com,baylibre.com];
	TAGGED_FROM(0.00)[bounces-10489-lists,dmaengine=lfdr.de];
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

Hi all,

sorry that i could check this now only, hope is not too late.

On Thu, May 07, 2026 at 10:43:01PM +1000, Greg Ungerer wrote:
> Hi Arnd,
>
> On 7/5/26 05:12, Arnd Bergmann wrote:
> > On Wed, May 6, 2026, at 16:26, Greg Ungerer wrote:
> >
> > > drivers/dma/mcf-edma-main.c
> > >    Supports big-endian access by setting the big-endian flag of
> > >    the drivers struct fsl_edma_engine. But locally should be using
> > >    ioread32be() and iowrite32be() instead of ioread32() and iowrite32().
> >
> > I'm still a bit confused about how this works at the moment,
> > since the drivers/dma/fsl-edma-common.h file already contains
> > checks for the edma->big_endian flag, which is set in
> > mcf_edma_probe(). The version after your patch makes sense
> > to me, but it looks like the existing code cannot work.
>
> Yes, it certainly doesn't look right to me either.
>
> Angelo: you look to be the original author of this driver, can you shed any
> light on its working status in mainline currently?
>

I was some years far from this driver (and the kernel itself), but i have
seen there are several changes in the edma common part from that time.
I remember i reviewed/tested some of them, some other unfortunately not.

I realized last month, that i was back working on this board (stmark2)
that somehting related to edma or dspi looks broken in mainline now:

[    2.270000] fsl-dspi fsl-dspi.0: Not able to get desc for DMA xfer
[    2.280000] fsl-dspi fsl-dspi.0: DMA transfer failed
[    2.280000] spi_master spi0: failed to transfer one message from queue
[    2.290000] spi_master spi0: noqueue transfer failed
[    2.290000] spi-nor spi0.1: probe with driver spi-nor failed with error -5

DSPI is using edma, i will try to understand where the issue is asap.

About how it works:
- for accesses to edma module (IP) mmio registers, must be native
big_endian, so using the "be" suffix in "mcf"_edma looks ok for me.
- for accessing the "tcd" memory structure, that must be, from what i
remember, anyway in little endian, independently from the cpu core
endiannes, this is the reason that big_endian flag is needed, it is
used for tcd area accesses, so the IP module was built.
The tcd area may be similar to pci accesses (see mcf54415 RM 19.4.16).

Anyway, tested the patch, nothing looks changed nor in better or worst.
Will look into this in the next days.

>
> > > drivers/spi/spi-fsl-dspi.c
> > >    Setting the regmap format_endian flags to use native endian will
> > >    force driver to use appropriate big or little endian access on
> > >    whatever platform it is built for.
> > >
> > > These drivers have only been compile tested.
> >
> > I would suggest marking these as explicit BIG_ENDIAN rather than
> > NATIVE_ENDIAN. The effect should be the same since coldfire CPUs
> > cannot run little-endian code, but the way that hardware usually
> > works is that the endianess is fixed at the bus level to one way
> > or the other. NATIVE_ENDIAN to me implies that the registers
> > have configurable endianess that is switched along with the CPU
> > mode.
>
> Ok, will change. I chose native endian in this case since the regmap config
> entry used for the m5441x family is also used by the vf610 devce (which looks
> to be an ARM imx SoC). So it will need a duplicate setup with those endian
> flags set to BIG_ENDIAN. But that is no problem.
>
> Thanks
> Greg
>

Regards,
angelo

