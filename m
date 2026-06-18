Return-Path: <dmaengine+bounces-11622-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S6wuJRQoNGqfQAYAu9opvQ
	(envelope-from <dmaengine+bounces-11622-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 19:17:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8AD6A1DF0
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 19:17:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=DTF8u9QR;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11622-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11622-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EA4230E2EAC
	for <lists+dmaengine@lfdr.de>; Thu, 18 Jun 2026 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073D431E820;
	Thu, 18 Jun 2026 17:09:54 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED83438BC
	for <dmaengine@vger.kernel.org>; Thu, 18 Jun 2026 17:09:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781802593; cv=none; b=liGdRAyMTb2vCl0B3mAEXsEYFkG9eKAhVCCI18xGI2xCN+gzEWmgwcCmZFBi9/Yw74Kvf82OJRoMEHwwOhOlAGfsPjm0hktSNZpW2cmJB8vksQckZEkB0hbr4xwdmO4oIvlQ/QXkoVtJztMKtgeuEwa/1gohPf50r7How5BfrYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781802593; c=relaxed/simple;
	bh=ek1Rt+RCKFx1ZAENatPdrTmZhOVWSxe+TUDrReqCslQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5LH2m1werhlUKhVC7YPtWuRsNDQEOYkuI/SEl45lsetsnfbbrmbBxk2yr6rSpwPQJznG9/WGMDJMvSiFIhGB2kPad8CZbtCOcxEOXzQsCgIzdzr8DPJKrfApfTC9y9/84OznFs0uP/uY0Ju6LKngFfWdChnW6oeoIL5ukvZDWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTF8u9QR; arc=none smtp.client-ip=209.85.128.51
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so7371055e9.0
        for <dmaengine@vger.kernel.org>; Thu, 18 Jun 2026 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781802591; x=1782407391; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pb6ELezZamFIkjKnVRa59Yjxr/sCCIOAAtSuv8gn1wU=;
        b=DTF8u9QRWt0bafU4I/kvxlEJn8P425OJmfYbnHsDt2e6rNF1FxFN/eFZojYeEU3Vwd
         0kuRMoxT93tCujJBZgOYCi9pVii7NqtudAllomOuorGnvVVtVzYwcP++CVid0MEnhTcj
         dMB+uLpEkH4Zlj1kBdUhGjkFWgZVCwsUgDLVPLnXPeDzS+l+zetkWHQnF0+9nyB9hCF5
         FCNeD3tQidY3ICSdGrmpF2DeOuUDQ2bzfAF6fazb3n/IYX53I9X+lgsEXgHJkar0FLlA
         tAgoHd2rK63HIp4sIUB8b6IVEqUGhKXaJLdijEpFgkyNo0MIOLyog2pdb2Q80ynNqP/J
         D8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781802591; x=1782407391;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pb6ELezZamFIkjKnVRa59Yjxr/sCCIOAAtSuv8gn1wU=;
        b=PJTnWXGUetR/ggLJwkE7uuw/kI6vb15chRM63DcAwiWleSwtBxI4zrV5quzWcQxXpx
         NGRWxgAo49Pt/KINCzqXnQBg5Q227O5Dnj6O3p/AiU3fQdTW9YL8xkyXliO2znBvKkrD
         +dV805MgTY86qvA86J8hCwnKHpRlTvwz9GAYoWn42MiVPf/Btu3/VCE9YnGbgkplm+GJ
         U51VupDWE1J3TzLHMsnS7XljATMWqdy/WvCpe7ZK/JLdvsE01jrOwtmSHbLkHeH++2bc
         hL+LX3+4cddLFyd2Qn4AwjmG02V4HeJwQ4xFlMSaAKqfk/7Gq2FUMQ15wjfOekoU1Z9O
         mhrA==
X-Forwarded-Encrypted: i=1; AFNElJ/ixOhyS4ZLXAI/ZpX+HgLR4WB1pM7Fxp83liMCv5YqIL1xXEm9oB1hKgx0A4xfvASQdrt+ztvj+ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVp/pRzzddvSdKoDt+FwBYSFXSmLu78mF5THc1pqhzCvyo3GgC
	sNyhSvU0KEfo59Dm0Q2zsCPmdbI6mLuWZAMK7BGtkJTlZdc6Z8J7ZHkM
X-Gm-Gg: AfdE7clbIZByQ0Bes98VfrFmUhErKQYhF19PZqOtk8Hk1b4zHRDZGwzr5prZg+TgFvO
	eAMH/RIuzZbPYTJomV7U0JScMc9HAltMwM9Ok9C8wc0UhNjiabaNNVMIUnDd4PAO1SJbMyr79qi
	nVVFwIzYFbHUNHrCcHH63M8MvjvZAf45KUoWnOuI/EACwR6fFrBsJcuqDGckAATHN4SZUPOnAiG
	8VQQScdMj+EGySnFMOSgYqipF0E40i1qA9DRRqiGg9wCMZAJ6tFmWgCyGo9Nh+mXErRKYKJw0t3
	gvOBCctO5jNlP+gltaTFzG/nCDykHTXygzdpJCvYd5DPYHXfMU2u/KK7pvTkRRNS/iClTaurnlM
	+Wg+IBN+4qgBNuMg3SQilScfd7raidnTv7SFZqVF14P1FFhs0l5ni8II9ksZwoRnNysYNu0KtKa
	nmRT29
X-Received: by 2002:a05:600c:828a:b0:490:b58a:e6ff with SMTP id 5b1f17b1804b1-4923f56c180mr7690965e9.22.1781802590913;
        Thu, 18 Jun 2026 10:09:50 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4650bc422c0sm233910f8f.26.2026.06.18.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 10:09:50 -0700 (PDT)
Date: Thu, 18 Jun 2026 18:10:52 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Frank Li <Frank.li@oss.nxp.com>
Cc: nuno.sa@analog.com, dmaengine@vger.kernel.org, 
	linux-iio@vger.kernel.org, Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
	Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC 2/3] dmaengine: dma-axi-dmac: Switch to bitmap-based
 address width masks
Message-ID: <ajQkupPzv8-GdEjv@nsa>
References: <20260616-dmaengine-support-wider-dma-masks-v1-0-da23a8dcb756@analog.com>
 <20260616-dmaengine-support-wider-dma-masks-v1-2-da23a8dcb756@analog.com>
 <ajF4i3o0gNRtUelb@SMW015318>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajF4i3o0gNRtUelb@SMW015318>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11622-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:Frank.li@oss.nxp.com,m:nuno.sa@analog.com,m:dmaengine@vger.kernel.org,m:linux-iio@vger.kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:lars@metafoo.de,m:jic23@kernel.org,m:dlechner@baylibre.com,m:andy@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nonamenuno@gmail.com,dmaengine@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	REDIRECTOR_URL(0.00)[aka.ms];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nsa:mid,vger.kernel.org:from_smtp,bootlin.com:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EB8AD6A1DF0

On Tue, Jun 16, 2026 at 11:23:39AM -0500, Frank Li wrote:
> On Tue, Jun 16, 2026 at 04:40:53PM +0100, Nuno Sá via B4 Relay wrote:
> > [You don't often get email from devnull+nuno.sa.analog.com@kernel.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > From: Nuno Sá <nuno.sa@analog.com>
> >
> > Advertise the source and destination bus widths through the new
> > dma_set_{src,dst}_addr_mask() helpers instead of open-coding the legacy
> > BIT() mask. This moves the driver onto the representation that can
> > express widths of 32 bytes and above and allows the legacy u32 field to
> > be removed once all users are converted.
> >
> > While at it, give the channel width members their proper
> > enum dma_slave_buswidth type.
> >
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >  drivers/dma/dma-axi-dmac.c | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> > index d47ff27e1408..19c258d511ca 100644
> > --- a/drivers/dma/dma-axi-dmac.c
> > +++ b/drivers/dma/dma-axi-dmac.c
> > @@ -152,8 +152,8 @@ struct axi_dmac_chan {
> >         struct list_head active_descs;
> >         enum dma_transfer_direction direction;
> >
> > -       unsigned int src_width;
> > -       unsigned int dest_width;
> > +       enum dma_slave_buswidth src_width;
> > +       enum dma_slave_buswidth dest_width;
> >         unsigned int src_type;
> >         unsigned int dest_type;
> >
> > @@ -1262,8 +1262,12 @@ static int axi_dmac_probe(struct platform_device *pdev)
> >         dma_dev->device_terminate_all = axi_dmac_terminate_all;
> >         dma_dev->device_synchronize = axi_dmac_synchronize;
> >         dma_dev->dev = &pdev->dev;
> > -       dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
> > -       dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
> > +       ret = dma_set_src_addr_mask(dma_dev, &dmac->chan.src_width, 1);
> > +       if (ret)
> > +               return ret;
> > +       ret = dma_set_dst_addr_mask(dma_dev, &dmac->chan.dest_width, 1);
> > +       if (ret)
> > +               return ret;
> 
> 
> This patch is okay.  I think most system only set one width once, do we
> really need pass down arrary.

I think so. See:

https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/st_fdma.c#L723
https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c#L1565
https://elixir.bootlin.com/linux/v7.1/source/drivers/dma/hsu/hsu.c#L475

And likely there are more. To fully support all widths I'm not seeing
any other obvious way.

- Nuno Sá
> 
> Frank
> 
> >         dma_dev->directions = BIT(dmac->chan.direction);
> >         dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
> >         dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */
> >
> > --
> > 2.54.0
> >
> >

