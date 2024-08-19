Return-Path: <dmaengine+bounces-2914-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48C69573FE
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 20:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6DAD1C21B10
	for <lists+dmaengine@lfdr.de>; Mon, 19 Aug 2024 18:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2170C1411E0;
	Mon, 19 Aug 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcFp9DTe"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B191EB3D;
	Mon, 19 Aug 2024 18:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724093619; cv=none; b=UVgty659HUNzhZdeAgZgRU7pn+ZIIUVlpuJWKQMjlkHXnoJuF+us3RFU209tfIttmGUHo7KiL5HjBgFrnqM9EUzFN2WKkCjAPN6GA6WVgTWK8YmaFQAa7bcAwgeyzbRiRLj4YkcAkAcUZd8MUjOS9HNMp+mc26WJDmxuIEn15pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724093619; c=relaxed/simple;
	bh=hk958LZG7P46VYbKlMNN/p9l+ikVk6K4JM3yoYkCjck=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cgoGnjkMIk9l9JYgwqPAvbff0rtRAzvclGYgbefI/LfjUhw61QPWH4Ugq9R3tFzk/7N96v3rGgW/+TeePOjK0yQ8CGoXcJZ8LBZyM+sUz0/NgB+0yIEo4kqAtrg+s87M81s+n0aMjw2pej7760CaZDoYsUOsIdx/gue+aGMzYtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YcFp9DTe; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2d3c5f769d6so3186059a91.3;
        Mon, 19 Aug 2024 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724093617; x=1724698417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hk958LZG7P46VYbKlMNN/p9l+ikVk6K4JM3yoYkCjck=;
        b=YcFp9DTeb1Ownasojn9f4a++ShYaCb8iCjQx5Jx9tmu9V18E2kkppkdV3PKV/ixI+W
         rZvy7CB2ySlDmAhyvVe0pWjVtVfX8Dr41jmvAb3FG7TeDaoYXyND5t+jxRtrqbU4X/bX
         zDlGrtM9rLptvpSfYpVtvMchqymaXtShRVp/PagEKmtpzNp2XpDk3/zjEE1ItSEHpov/
         onC126gIBYYeHoh6YcBEOzJmGEiyH6weRtnyHZbVs2KhtXyjtOfWSxP8PUllE+eLtEos
         xXp8O+t/ICuo+xx7LZfJTTA4o8LtNEDP5J8R6k38KZSmpkRJ5156MFCq90tfFiasGfL7
         3Oiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724093617; x=1724698417;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hk958LZG7P46VYbKlMNN/p9l+ikVk6K4JM3yoYkCjck=;
        b=YW3GBL59Gh/TjALp1QDPr4HplsrZKVFEy1aR5RTuqYUtuqLUH1nPdhU1AzPBU4Kn2G
         WdjHRD1rrrmfMWkCJIJS+WJ3Sb3eYO2K7gMSs90Fv2dJhbTvkHWGT+pLdyqUMml8KH/X
         kr7tgQlMZVwSQwl2s0uXF2+IlnZOY7rxqaTRadbg8/kzw80kxJ/4cJkYAz0XU/L2UUwN
         q/1JeEkYHsgDGQdnsmzI8ilsJ8tVlgzamFrRUxPD+x9NxAbFiXfDYnWe7zT48TEPl+9b
         G6vezSkPg9zvu447su+5uiXzSB5sK3cZ7c6WlVbC15lep9m3OVU2M1qt0h5kzJj7hwJT
         +bRA==
X-Forwarded-Encrypted: i=1; AJvYcCWjOXapDXhQeAOl1o7ckAz8T2IXbayGpuzUGKCVf4sD8cfWebWfDwdpn9/b+C+dKUQ0D84ou8x1F0oJ3rD4t7/iGczPZ/cj8ka90zuF
X-Gm-Message-State: AOJu0YypjPburZOlR3ahLQSbSCXBy24ReFk4GR6mqz03IGVffDd4b84W
	wRxlpvEWU2P8PRMSUCuhjp1Ncz8pOoq+wgAKBL7jR5LDQfxw5zO+iVZwJLl3SSwinWVx22HNZIp
	0uovIYi+Jr5Wxkq4sgN9XQ/PdisQ=
X-Google-Smtp-Source: AGHT+IE18Ezwozf0x2m4Q9qqvdaKGHFxfMrkNJDcv1NeOMhW8QxFPaRvb3hLvtgjAWMsKzJldyL+lC7RKVLbTG+w2xE=
X-Received: by 2002:a17:90a:fb0d:b0:2c7:e46e:f8b7 with SMTP id
 98e67ed59e1d1-2d3dfc3a592mr10456961a91.4.1724093616249; Mon, 19 Aug 2024
 11:53:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Haoyu Li <lihaoyu499@gmail.com>
Date: Mon, 19 Aug 2024 11:53:23 -0700
Message-ID: <CAPbMC74cxADGEd2bc8wYA4iUwkP2f-Uywf=V1aMYs4iSiqh1sg@mail.gmail.com>
Subject: [drivers/dma/ti] Question about `struct omap_desc`: misuse of __counted_by
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>, Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux Developers for TEXAS INSTRUMENTS DMA DRIVERS,

We are curious about the use of `struct omap_desc`. Its definition is
at https://elixir.bootlin.com/linux/v6.10.6/source/drivers/dma/ti/omap-dma.c#L111.
```
struct omap_desc {
struct virt_dma_desc vd;
bool using_ll;
enum dma_transfer_direction dir;
dma_addr_t dev_addr;
bool polled;

int32_t fi; /* for OMAP_DMA_SYNC_PACKET / double indexing */
int16_t ei; /* for double indexing */
uint8_t es; /* CSDP_DATA_TYPE_xxx */
uint32_t ccr; /* CCR value */
uint16_t clnk_ctrl; /* CLNK_CTRL value */
uint16_t cicr; /* CICR value */
uint32_t csdp; /* CSDP value */

unsigned sglen;
struct omap_sg sg[] __counted_by(sglen);
};
```

Our question is: The `sg` member of `struct omap_desc` is annotated
with "__counted_by", which means the size of the array is indicated by
`sglen`. Only if we set `sglen` before accessing `sg[0]`, the flexible
member `item` can be properly bounds-checked at run-time when enabling
CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE. Or there will be a
warning from each array access that is prior to the initialization
because the number of elements is zero.

So we think relocating `d->sglen = 1` before accessing `d->sg[0]` is
needed in the following three positions:
- https://elixir.bootlin.com/linux/v6.10.6/source/drivers/dma/ti/omap-dma.c#L1192
- https://elixir.bootlin.com/linux/v6.10.6/source/drivers/dma/ti/omap-dma.c#L1264
- https://elixir.bootlin.com/linux/v6.10.6/source/drivers/dma/ti/omap-dma.c#L1319
Perhaps we can set `d->sglen = 1` right after `d = kzalloc(...)` operation.

Here is a fix example of a similar situation :
https://lore.kernel.org/stable/20240613113225.898955993@linuxfoundation.org/.

Please kindly correct us if we missed any key information. Looking
forward to your response!

Best,
Haoyu Li

