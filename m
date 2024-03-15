Return-Path: <dmaengine+bounces-1392-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A9087D12B
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 17:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00FF31C21AEF
	for <lists+dmaengine@lfdr.de>; Fri, 15 Mar 2024 16:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA502AEE4;
	Fri, 15 Mar 2024 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="Q4y2xaij"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F4F1773D
	for <dmaengine@vger.kernel.org>; Fri, 15 Mar 2024 16:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710520039; cv=none; b=l6wCS+JyqwIs3dJxb/uky3iwaTU1l7pWNx4/89OrWb8fBHc4d64YwmXaH8IRTreViplVShZ86MfTFiV0qMAjiMDPGSH2mTeG7wI+opv9nL7reTSesGUgLyUHOhsIKZw1fIYUSUDtjxVD9DQygduEdTIDoXUPhjkAPcEIk0mLcQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710520039; c=relaxed/simple;
	bh=hZEdXfu4cunN5NgZkpwioq1CASGzyElEmuM5XTFPjYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OzqKoYEB40MwLC5bnvRe2uP/fW/JhKOob0Z1JfLERXTszFh9jMuMjwHM2E6rbsnYgm8dPbnJYiZCqKlAFK+OCfNp5sQNdRkD1JSFJik9+7rH7iWxQEMHPghwO3IAjytKPMSvtV7AEQukHD2IQKFLagkiiwPbg/EAQ3kbgoDweTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=Q4y2xaij; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-60a15449303so25764687b3.0
        for <dmaengine@vger.kernel.org>; Fri, 15 Mar 2024 09:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1710520036; x=1711124836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yuPTn5RLZZX9Q1QpYoLinhsXoC3mINcsG1PWqfZJgSw=;
        b=Q4y2xaijEVIGHLQXPPPfWK5aWmQt4LZ6jrRxeYDd6Er89un9Y/nXz3Y1bZ25V0rM1d
         Ih379WlhvZr1PW6zkd+jIDbqHvcaw+bfifrU/SFjSjJLentzg1e804LYvS3mBtLLNhr1
         AKV0ZJOJkZOuyEfvDOz7Ub8R9vhlbOZFQ7sSdYYBxtNXj3s9HI8LrgPvdBdSKeG0fk1W
         LDrhA+kpPVSswC/myrgh+NQ+wejpgIBA5/8NzZYN8z64eRjHZravfo6wZIVhpmFRG1Ki
         U3YIF2KRfXgYsbCybDMHAHOppXi0T0Togka5yxI7+55AyjXD4BnClruIXLsgU86cdEBT
         M1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710520036; x=1711124836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yuPTn5RLZZX9Q1QpYoLinhsXoC3mINcsG1PWqfZJgSw=;
        b=satgShXgQJhD8zWqyCLmRn6tMev8pDj2p/GmyjpwvArTCoJCS0f6YPWtbEKxiSdYBF
         amzGEgL7+o83UIHcMGHfgixqOqJdc2g97zPNoQcAKcHmL+tcUSK6RISPfvWxlvEpExpu
         lEoSPX+DVgQunxk+zCGq0IduhI0AT7B7UeNK9cBmSHyz8vNkVV2fLnl0Nhqweu04Wqvf
         0WZjRKiakXD0NpyYU65juiguWs/FLZHb++HWcujSupwSvzyyNB5eMs06boWBudbrDFOq
         327uDd8H87UKdBwUp/Hp8UgUOtDdVs8S6YZhn/KlJxs8WZWC4Ex0rRfBAZrE41QbfAqN
         xu4w==
X-Forwarded-Encrypted: i=1; AJvYcCUZ3KFnm59H60iumbKjcpMoJf4M1ramUfNWfH23b9X/NOeAsuhwnk7PCkhBeSdRqQTds09LoVzKlXM3a2ozDq4OSm9XIBF6dnYP
X-Gm-Message-State: AOJu0Yz/Mmfxdkrjf8/jlRxWjPRMfi3SEPzrT7OptyMhubfzPUa8l8Pn
	CNK/n9f3jmMcxsMXAv7hmzrzLoN/VYcTE0pkHrSQwxT8743zHZXnbvTnThmC5IEtkrmIMr5AwXK
	2D34P10skxqKPwG4zW7gHElnuxVZ5LzHfQFNfhQ==
X-Google-Smtp-Source: AGHT+IHuGiMmEmtKmb+IqWUkn6ChUX5X0t1nTKF7+18TDO83dH8PpXHF3VgV2UV84rG+OUXtlUZIybkwAUKAVSEABig=
X-Received: by 2002:a81:6dc2:0:b0:609:8717:4361 with SMTP id
 i185-20020a816dc2000000b0060987174361mr5339606ywc.4.1710520036658; Fri, 15
 Mar 2024 09:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPY8ntByJYzSv0kTAc1kY0Dp=vwrzcA0oWiPpyg7x7_BQwGSnA@mail.gmail.com>
 <aa533a97-ea62-4d84-aea9-2714e7561517@sirena.org.uk>
In-Reply-To: <aa533a97-ea62-4d84-aea9-2714e7561517@sirena.org.uk>
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 15 Mar 2024 16:27:00 +0000
Message-ID: <CAPY8ntBua=wPVUj+SM0WGcUL0fT56uEHo8YZUTMB8Z54X_aPRw@mail.gmail.com>
Subject: Re: DMA range support on BCM283x
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-rpi-kernel@lists.infradead.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <mripard@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Stefan Wahren <wahrenst@gmx.net>, 
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Jim Quinlan <jim2101024@gmail.com>, 
	Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 13:47, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Mar 08, 2024 at 03:06:01PM +0000, Dave Stevenson wrote:
>
> > Assuming I'm correct with the above, the question is how to implement
> > a solution that corrects the behaviour whilst still supporting the old
> > DT, and preferably isn't spread far and wide through the code.
> > Worst case is to require all DMA users and the DMA controller to look
> > for the dma-ranges property, observe the range isn't present, and drop
> > back to the current behaviour.
> > Slightly nicer is to use the knowledge that "ranges" and "dma-ranges"
> > in this case should be identical, so have the DMA controller driver
> > attempt a lookup with "ranges" if "dma-ranges" fails.
>
> Either of those solutions seems fine to me.

Thanks Mark.
At least I know I'm not wasting my time trying to implement either of those.

  Dave

