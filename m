Return-Path: <dmaengine+bounces-961-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F6884BAF3
	for <lists+dmaengine@lfdr.de>; Tue,  6 Feb 2024 17:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F8AF28923E
	for <lists+dmaengine@lfdr.de>; Tue,  6 Feb 2024 16:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD4C10E4;
	Tue,  6 Feb 2024 16:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="YKQedl+r"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98041137E
	for <dmaengine@vger.kernel.org>; Tue,  6 Feb 2024 16:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237085; cv=none; b=qr+Cuq9wgYUNnPI4WBn4ZC5kSR+F6UhHLNvsEYHgBevX/oXKRvZnO+heUZHywymnhSSmm07/psyhJmEMBZ3WiypRrq1iJH8m4Xo1xKwUeAea+ybh2g+umKYdXk0HyOo8wd4P0P3pdxjtCLUBhgdRLDukwDVja+utcRpP8CyhsDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237085; c=relaxed/simple;
	bh=m5YMgx/Rk89i31JsX7thzYfxW4hoc3JFWWBtlsOhGSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJQdImQlCku9IFOfSf+xuudh0w/t3Qx1NjPB5J/MDTTM1nfgOsFZ2JfNOC7qmqh6GD5OobadItswsF0owLtt0PECz9zwAl4o/f7qfsjhP1fCtYZAae3EimX+iy8xNlmSveLGf020BKN37Z96LxDPmIcjIJpWp9YnsPMmd2qcLiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=YKQedl+r; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc6df0f9bcdso5286845276.2
        for <dmaengine@vger.kernel.org>; Tue, 06 Feb 2024 08:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1707237082; x=1707841882; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wRJIyHV5VgYGC62PnCxR7qX0sGX7lOztrrbBlwUaWj8=;
        b=YKQedl+r7VZqwhdAcmGDUbp/RlNzWvhM23qfqFWUB7cwWEK2G9wl/mKY69IqPzWoYo
         DAj5wfTnCtgZbQ6DK91/iln5K3buC5ycQ7KbLcn45ungN8/d8c/Z2w6DdvGDa5XrMytG
         3y9CvLnUUPkiwvd/SVKFjDs0EghOGp1aqJHR6zkyAw1A4y214gcgfT/xuRWASrVFI0q1
         mUh3br6xmetxLf2qbgVItK9bDWnYiOQhUrfK2GgLv4U5/8iVs9JWFcNNXrHcXP7JpFCI
         rtbAUQDq4WLZSqQbf2URaADp1KpEp/WhxpsMZaLaXhAimTAWiecKyj8wMTWz2M9dMciA
         gabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707237082; x=1707841882;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wRJIyHV5VgYGC62PnCxR7qX0sGX7lOztrrbBlwUaWj8=;
        b=U+DANZnyBN9vfnqVU4xEq2E/8eFPRi3Dp09g8qlouZJnZWQvpzVAOnFweubwVDIOGJ
         MKi+WTrq7rA35h47cc/fHsoUg0qzWqyU7enCpeZKrON0R1to6OpaRa2ViCo6xlcbZyoA
         CJd6W+BVqm2FE0scyb9YEk7fzsaC5q2L6YOH70iY6J301MpnUR+MP/wosamQqxo4x5s9
         3z+MjhSdWh5hwbvrh4puY1FKjZFp4vwQFf+bnvqwWfgeLyAPwZlTNGJixRnx8lUyXIy4
         cLqCZ5ab7fDiu+Q2Hfmjr0eSsAaJ2OFYzE2P/bOjIelYBIC3FKfOD1hWkPGHd6/wjOC8
         4E4w==
X-Gm-Message-State: AOJu0YzLJH6WU1mzvvXg6PkhNqUdM33yTR6+fhrmOsaS7i0P0/COgPvd
	I0AJuY2Fr8VM9TQfpB/1hYM3XhM5pVxYnhpygt8xgeoB4aU6PfJfpzt54c5M3q9ZjVt4MSz9HFW
	o1x+KXgdKrVFZbk72EIl7QWEhY1wZRTtp9yopOw==
X-Google-Smtp-Source: AGHT+IH/RWk7n17FsIM6ZLFkgpIBG5LLj62gEHMbGZsFtCblxeMsBXg47ecJv1kl1vVPCeDRQ/RSwDIIaW275+Ua6iY=
X-Received: by 2002:a5b:50:0:b0:dc6:e219:980e with SMTP id e16-20020a5b0050000000b00dc6e219980emr2261716ybp.56.1707237082535;
 Tue, 06 Feb 2024 08:31:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1706948717.git.andrea.porta@suse.com> <eeb94204c30c2182f5ffd3ec083c04399ecdee32.1706948717.git.andrea.porta@suse.com>
 <8736c115-e11c-41ca-85eb-7cd19a205068@gmx.net>
In-Reply-To: <8736c115-e11c-41ca-85eb-7cd19a205068@gmx.net>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Tue, 6 Feb 2024 16:31:06 +0000
Message-ID: <CAPY8ntCEvsTJwoEBYc7JsTaYfdMURhmytvvVMcLVNBkmdTNcZQ@mail.gmail.com>
Subject: Re: [PATCH 02/12] bcm2835-dma: Add proper 40-bit DMA support
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Andrea della Porta <andrea.porta@suse.com>, Vinod Koul <vkoul@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Ray Jui <rjui@broadcom.com>, 
	Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>, 
	Dom Cobley <popcornmix@gmail.com>, Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi Stefan and Andrea

On Mon, 5 Feb 2024 at 18:50, Stefan Wahren <wahrenst@gmx.net> wrote:
>
> Hi Andrea,
>
> [add Dave]
>
> Am 04.02.24 um 07:59 schrieb Andrea della Porta:
> > From: Phil Elwell <phil@raspberrypi.org>
> >
> > BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
> > to access the full 4GB of memory on a Pi 4.
> >
> > Cc: Phil Elwell <phil@raspberrypi.org>
> > Cc: Maxime Ripard <maxime@cerno.tech>
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> mainlining isn't that simple by sending just the downstream patches to
> the mailing list. In many cases there reasons why this hasn't been
> upstreamed yet.
>
> In my opinion just this feature is worth a separate patch series. In
> 2021 i already send an initial version, which tried to implement it in a
> cleaner & maintainabler way [1]. In the meantime Dave Stevenson from
> Raspberry Pi wrote that he also wanted to work on this. Maybe you want
> to work on this together?

Yes, I'm looking at reworking Stefan's series to work on Pi4 & Pi5 as
it's needed for HDMI audio (and other things) on those platforms which
I'm working to upstream.

I was getting weirdness from the sdhci block when I was last looking
at it, so it was just proving a little trickier than first thought.
Hopefully I'll get some time on it in the next couple of weeks.

  Dave

> [1] -
> https://lore.kernel.org/linux-arm-kernel/13ec386b-2305-27da-9765-8fa3ad71146c@i2se.com/T/

