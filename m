Return-Path: <dmaengine+bounces-2330-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE39E901823
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 22:34:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 869261F21394
	for <lists+dmaengine@lfdr.de>; Sun,  9 Jun 2024 20:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D076D26286;
	Sun,  9 Jun 2024 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fBmOZ037"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3187517BD3;
	Sun,  9 Jun 2024 20:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717965241; cv=none; b=Crw9N8h+DvW1P4Mq8fl/CDNT/rNWIBXMMH7yV2Csear9l3YRJOXqTG91ArdKAVReICU5m4xkfPGSgSXIlDz/KUT4U6OGy1moMyAlQa6KnUHCYgcV575oB4HbVLUuaHlmQBdCrvNUFgnfb+HHOkfz68G9nlwBEJZrHP1ZpNM8QgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717965241; c=relaxed/simple;
	bh=rIKPDLDsHnN3JbRPuvRDCF5YTJrHLEE5++xGLHlQGoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f49MywR76d/MvO+5JA1+QLs282AHz8NpP9a7KycFNamz0W9+4r7TtOaPxE8YwV0Xea0mIMsqIqevzcbGMAY6ZGio100gteqnaC4ceXfpBQeSk9G4jpavxZiIf7169U1rmXAd2tIglvpqwwtslmKhA8HuwzeCUJR92bKcgnb3TZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fBmOZ037; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f0f4746c2so1056529f8f.3;
        Sun, 09 Jun 2024 13:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717965238; x=1718570038; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3n8SaL8WINeV1wuWjpxwfyGNSRase5dnk0DKSMoT+2M=;
        b=fBmOZ0374mnyw4wVkZEPL96F2/Jkh8Pz06VV/vTBTHdVi+j09fB33010IhXNhvmrRn
         2NKqN69GqoaXsfgDqH83boOWR4e0TeXCbzGyYmKsomYY0xjeE3ioxy+OjqaEfz0ywMSD
         WFGHwazrw9CwLYCT7GCgHFTL8EMSXFOBXo63y8a349S52eKTuMTYAy9RN7yISZvkPYkC
         6VE+A9EWbcTWsBVfh8mgTo69p6LTwMF/8RtBJLNp2D/6WStwBse5ucB3U8mcJvqw1ybV
         SpaUhfdMKKL9dTjY4yOTPTgmAknMzf+sFojDc47zc5/BGFYYNXTJ6cG+D2nD15KiIuWM
         k4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717965238; x=1718570038;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3n8SaL8WINeV1wuWjpxwfyGNSRase5dnk0DKSMoT+2M=;
        b=Xu0g3ZqxITI02iAM+uUJartfePs/iTwgYLLp+wtR1okFyqc9NYAFdWatDWmS7ihwdh
         sORMl5Iinm1cquXzPsiOG/4ImNRX8ACUg27YNzwpGR8s40TZ1sglhA6dh0LzsSSdze6N
         lYgo0DR5WmYXBfQEnrzXoCOJQmvif2jO0dBkJUd1kwEWzc4eR2gPIhdTd7g/gOlyAzyr
         n8Zba7069jN/FdkJa49EQ4C3PZeGBWV5jMJ4ICHEObreDgU+1ZsdNWOFOU87fnh/zwZw
         j4sfcYPngd8HbVIBoGYPhruspC7+kKN1ooqCEPCfupoznaFmkGOqCxALFgjhLzpTqnfT
         htfg==
X-Forwarded-Encrypted: i=1; AJvYcCXVnZUsCutREk9MDTlqQ8RyvjvrnoiR6hf1fL4GRgwRI5JkKbTPBZeR+MhwnB/p99MKCpNRQ+r5UBqUaalfFAgl7AHEQ+HGmnw3Iyoz
X-Gm-Message-State: AOJu0YyjymvA1NFtomR/fAYXelRjaGwdiT2IB5txHPRAXL06blakjz7M
	RpYyiZ/w4t3swKdkQhnaIyXOIJJTdWdSU5nunKB/w1LB7di5Lmew
X-Google-Smtp-Source: AGHT+IFjKEniKG4XHDd7L4jElOc8JPpB7pazEHoJbSUzpzS95u/4aGEhVfjC1UyxWpQScCb8ixY1CQ==
X-Received: by 2002:adf:ef0c:0:b0:35f:25c9:8c2 with SMTP id ffacd0b85a97d-35f25c90961mr211695f8f.46.1717965238385;
        Sun, 09 Jun 2024 13:33:58 -0700 (PDT)
Received: from olivier-manjaro (oliv-cloud.duckdns.org. [78.196.47.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f1fd78d1bsm2251058f8f.48.2024.06.09.13.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 13:33:57 -0700 (PDT)
Date: Sun, 9 Jun 2024 22:33:56 +0200
From: Olivier Dautricourt <olivierdautricourt@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: dmaengine@vger.kernel.org, Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Eric Schwarz <eas@sw-optimization.com>
Subject: Re: [PATCH v2 2/3] dmaengine: altera-msgdma: cleanup after
 completing all descriptors
Message-ID: <ZmYRtMlJheCp7i-E@olivier-manjaro>
References: <20240608213216.25087-2-olivierdautricourt@gmail.com>
 <0e439d73-aff5-4d56-9a3c-b29867132db1@web.de>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e439d73-aff5-4d56-9a3c-b29867132db1@web.de>

On Sun, Jun 09, 2024 at 07:20:49PM +0200, Markus Elfring wrote:
> …
> > This fixes a Sparse warning because we first take the lock in
> > msgdma_tasklet.
> …
> 
> Can the tag “Fixes” become relevant for the proposed change?

I can add a Fixes tag, it will target only the first commit introducing
this driver.

> 
> 
> …
> > +++ b/drivers/dma/altera-msgdma.c
> > @@ -585,6 +585,8 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
> >  	struct msgdma_sw_desc *desc, *next;
> >  	unsigned long irqflags;
> >
> > +	spin_lock_irqsave(&mdev->lock, irqflags);
> > +
> >  	list_for_each_entry_safe(desc, next, &mdev->done_list, node) {
> >  		struct dmaengine_desc_callback cb;
> >
> > @@ -600,6 +602,8 @@ static void msgdma_chan_desc_cleanup(struct msgdma_device *mdev)
> >  		/* Run any dependencies, then free the descriptor */
> >  		msgdma_free_descriptor(mdev, desc);
> >  	}
> > +
> > +	spin_unlock_irqrestore(&mdev->lock, irqflags);
> >  }
> …
> 
> Would you become interested to apply the guard “spinlock_irqsave”?
> https://elixir.bootlin.com/linux/v6.10-rc2/source/include/linux/spinlock.h#L574

I could but arent these type of things to be integrated in a more global patch serie
targeting (let say) all drivers in one subsystem ?
Currently it seems only one driver uses a guard in the dmaengine subsystem.


Kr,

Olivier

