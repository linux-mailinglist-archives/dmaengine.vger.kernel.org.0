Return-Path: <dmaengine+bounces-1311-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5648766FF
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 16:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860DE285569
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 15:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A371D15AF;
	Fri,  8 Mar 2024 15:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b="RMGk4lgb"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE19322A
	for <dmaengine@vger.kernel.org>; Fri,  8 Mar 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910380; cv=none; b=Csvw6InM802fSalOZ6gArzaucg+6wZR5dncruKSVGQ/9T1ytt2/c73+zbUXaYFaC0YMusa3YK+WWPsEjel1gagCDDXRWAdo0N+jmo7Thin0RC9vIMOsFFVlvi7x1P9DGruM929RDaSWj73sW0l6jiMlAUH5GQOUxQmeEL9gtucg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910380; c=relaxed/simple;
	bh=7K7XjjuuDVmZoheJLsmPuwqN4KUFOWM5enHgBCjK8gA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UlzKOYYJOYJoO98nLecxsHai9mIMK7RX0mOwb/Beu18gZprkhVe0z9b98cTa7rlXn8klVNEJeLt4KNCFHlQOMPCvt82lertesMbRXbmh2RixzoqAns5O6eh9qrfhims4RaWE4BRMthImgupAU6+0cekK5uiepBHsdtOmSRm+5UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com; spf=pass smtp.mailfrom=raspberrypi.com; dkim=pass (2048-bit key) header.d=raspberrypi.com header.i=@raspberrypi.com header.b=RMGk4lgb; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=raspberrypi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=raspberrypi.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a0579a931so6137727b3.0
        for <dmaengine@vger.kernel.org>; Fri, 08 Mar 2024 07:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1709910378; x=1710515178; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=axI3J2zPNBTuuTSQPMGPqfRBpJXr7xhUiDs5BnpD2pg=;
        b=RMGk4lgbWguFqnV4B0iMg6QxRhxRZsbWvw9humNE1xojcesWcCC+LJ6EAu6nKSuuNY
         OKrjqKHNmDzmNP9bJma5D5ax1GjWuisQUKveD4OB233a7+Da41h5VB0296NDzPfJbRdj
         qvAiRZAo+UGNiPehMvMymop9y16vmUfFV0FXBd8iMbDC+c8hLdEih7eYj0VB6Hho763O
         nBdikSl/LUry1JmS+qxw+6kvIbgW6BSDo27q9XLDJFRlNYoH7P/l00FqQod2JGPf6oOg
         7tQwhdUv4JwMnJ36hZfI0DG6NM4g6upP1v0+G+m16n+jciTHemSwEvqxxvdZKfVcfHSf
         8q4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709910378; x=1710515178;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axI3J2zPNBTuuTSQPMGPqfRBpJXr7xhUiDs5BnpD2pg=;
        b=uoysEzKZYnyDhM2bLwtID0iqAviKDTJCNw8jX+iQpaKGyi8uliIY4roGN4FoO2qldr
         M0JQNCif7tNVXgKb3Lh4tMKxi+Scsw9SkkTqSoF/mlAd6Pokgg1N3yjXjnmUsFCo6kbQ
         xvI1+d5lO6Jb7WEZzCnuWOX9eTXkkF1gYwfhZ1iTxsJDcHXodB04xCs6+Sz3m+IkTmBT
         O6nqxToygPxlQ+nQsmgjvpGN+ZtQmpymbIhiEn1+knXGdqQvBSLMuziv+TTNw8lCMSnJ
         J51sQKDb+viJBhRNfym36G7g5OUIrm6TKRryetnf/H5YL6AUiiY39ofKUQ89Yw8b0xbt
         ehhw==
X-Forwarded-Encrypted: i=1; AJvYcCXh7B/ZjSADdRrOTTFOU54qrzgPimz14vn+yMWPwGhmQ2QtMKduVyNd0AHAfKvuIt5ZChDJx97HJqKpzIhRpk4PtqpPNmpgSJBR
X-Gm-Message-State: AOJu0YxKVcMfx6gIR6rLOBiPj4sVt3FaqYM0DhkUM+LBT1gH+T9ppmm8
	kAltbAKW0r66SvXywIl6M7IREdM1v+oO1dBEMTu+DQMqfiwB3D/zPP+RiyQjJreDrYybgdalMYa
	EKR1AjNBNttEvCv1tsDs/qDOUwGHTF1ZM+9yk0g==
X-Google-Smtp-Source: AGHT+IFPjvRVAZhj2KVjP0oxh4Wt6WXqKEiHEys0nCNZxI94SUj0Gz/IxXTE4vOhz893yhBNzBJVLmlT7IcS9rCrnOs=
X-Received: by 2002:a25:ae8b:0:b0:dcd:ba5a:8704 with SMTP id
 b11-20020a25ae8b000000b00dcdba5a8704mr18539467ybj.24.1709910377508; Fri, 08
 Mar 2024 07:06:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Stevenson <dave.stevenson@raspberrypi.com>
Date: Fri, 8 Mar 2024 15:06:01 +0000
Message-ID: <CAPY8ntByJYzSv0kTAc1kY0Dp=vwrzcA0oWiPpyg7x7_BQwGSnA@mail.gmail.com>
Subject: DMA range support on BCM283x
To: Vinod Koul <vkoul@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, dmaengine@vger.kernel.org, 
	Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, linux-rpi-kernel@lists.infradead.org, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc: Maxime Ripard <mripard@kernel.org>, Mark Brown <broonie@kernel.org>, 
	Ulf Hansson <ulf.hansson@linaro.org>, Stefan Wahren <wahrenst@gmx.net>, 
	Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, Jim Quinlan <jim2101024@gmail.com>, 
	Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"

Hi All

I'm looking at the DMA configuration on BCM283x as part of upstreaming
the 40 bit controller for BCM2711.

It looks like we have a historical misconfiguration, and I'm not sure
how we resolve it.

On BCM283x, dma address != CPU physical address, particularly for the
peripheral registers.

The DMA users have been passing in the DMA address extracted from DT,
eg HDMI audio [1], SPI [2], and MMC [3]. Certainly for HDMI audio this
is implied as correct by struct snd_dmaengine_dai_dma_data taking a
dma_addr_t, except snd_dmaengine_pcm_set_config_from_dai_data() then
assigns that dma_addr_t to a phys_addr_t[4].

Our understanding now is that this is incorrect, and they should be
passed the CPU physical address. "dma-ranges" should then reflect the
mapping, and the dma driver should be using dma_map_resource() to map
between the two (although it currently doesn't consider dma-ranges as
raised in [5]).

BCM283x DT currently doesn't cover the peripheral registers in
"dma-ranges", although it is present in "ranges". AIUI it's considered
ABI so we can't now mandate that mapping be present.

Assuming I'm correct with the above, the question is how to implement
a solution that corrects the behaviour whilst still supporting the old
DT, and preferably isn't spread far and wide through the code.
Worst case is to require all DMA users and the DMA controller to look
for the dma-ranges property, observe the range isn't present, and drop
back to the current behaviour.
Slightly nicer is to use the knowledge that "ranges" and "dma-ranges"
in this case should be identical, so have the DMA controller driver
attempt a lookup with "ranges" if "dma-ranges" fails.

It's an awkward situation that we find ourselves in, but any advice on
routes forward would be appreciated.

Many thanks
  Dave

[1] https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/vc4/vc4_hdmi.c#L2729-L2743
dates back to bb7d78568814 ("drm/vc4: Add HDMI audio support") in 2017
[2] https://github.com/torvalds/linux/blob/master/drivers/spi/spi-bcm2835.c#L898-L905
dates back to 3ecd37edaa2a ("spi: bcm2835: enable dma modes for
transfers meeting certain conditions") in 2015
[3] https://github.com/torvalds/linux/blob/master/drivers/mmc/host/bcm2835.c#L1370-L1380
[4] https://github.com/torvalds/linux/blob/master/sound/core/pcm_dmaengine.c#L112
and line 120.
[5] https://lkml.org/lkml/2024/2/5/1161

