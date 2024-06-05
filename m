Return-Path: <dmaengine+bounces-2272-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C551B8FC9FE
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 13:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D553286116
	for <lists+dmaengine@lfdr.de>; Wed,  5 Jun 2024 11:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4813419148B;
	Wed,  5 Jun 2024 11:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="fnNXiWCz"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717514B974;
	Wed,  5 Jun 2024 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717586156; cv=none; b=tI5qNrbKzzEr1IS5CLGnDht1AlolBma0XptRx36nA8HeMw6MjEgaVC/kSH88cMyZlyU0PiMby/t+SvwAryzJBw7G8EDjSk5S3rKCuTPZvr3n17XfKm7djCgOJATPFMKFLrFTjaDDJNHkH+U6PByB6su6En92LTLLWB9wFgG5DDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717586156; c=relaxed/simple;
	bh=j23cpuGAemJTmamOXD92cbvxQHnwkWvNJTIkvGKjv2U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EyyjgJFXVDVkY9ihX+6uxmb4JnUuA1oDV5my9RE1oeJ8x/I8BeszBU4phpwUPSvoNsa2Y9hVBObALJKOt/rnzH53k1XJhxfFkZHFHDUzJvreyt1jXD7fRGLni0YVnbyb2CS5smlFBRuy0A9K9e/Qe/cLUcB2joMR/f8gQU0kCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=fnNXiWCz; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1717585738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lbF3Hr41nIth/kjABYAo6ELsT9zfo9W62/2gY+j3W6A=;
	b=fnNXiWCz+piHjs3cCFKX5GI5TCn9Y2prcen/ET7kh9pye5qm+pIgUBf/O3bV3BnNT1h/2u
	NyMwYH4qGWbWGr1IYazRbY6rtGSVJoiMLXi/3PHX/GFa4ahJSbYFIZ5go1Y3p1tTrpunF0
	gFAQsaj5oi/revV7EdeAexrsKXH2qHg=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v10 0/6] iio: new DMABUF based API v10
Date: Wed,  5 Jun 2024 13:08:39 +0200
Message-ID: <20240605110845.86740-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Here is a revised (and hopefully final?) version of my DMABUF patchset.

This v10 removes the extra "flags" parameter of
dmaengine_prep_peripheral_dma_vec(), and adds kernel doc to the function
as Vinod requested.

As Nuno upstreamed support for output buffers, I (slightly) modified
patch 5/6 and now output buffers are supported with the DMABUF API.
All I did was remove a "fail if output" check really.

This was based on next-20240605.

Changelog:
- [1/6]:
  - Add kernel doc to dmaengine_prep_peripheral_dma_vec()
  - Remove extra flags parameter
- [2/6]:
  - Use the new function prototype (without the extra prep_flags).
- [5/6]:
  - Remove extra flags parameter to dmaengine_prep_peripheral_dma_vec()
  - Add support for TX transfers

Cheers,
-Paul

Paul Cercueil (6):
  dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
  dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
  iio: core: Add new DMABUF interface infrastructure
  iio: buffer-dma: Enable support for DMABUFs
  iio: buffer-dmaengine: Support new DMABUF based userspace API
  Documentation: iio: Document high-speed DMABUF based API

 Documentation/iio/iio_dmabuf_api.rst          |  54 ++
 Documentation/iio/index.rst                   |   1 +
 drivers/dma/dma-axi-dmac.c                    |  40 ++
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/buffer/industrialio-buffer-dma.c  | 180 ++++++-
 .../buffer/industrialio-buffer-dmaengine.c    |  62 ++-
 drivers/iio/industrialio-buffer.c             | 462 ++++++++++++++++++
 include/linux/dmaengine.h                     |  33 ++
 include/linux/iio/buffer-dma.h                |  31 ++
 include/linux/iio/buffer_impl.h               |  30 ++
 include/uapi/linux/iio/buffer.h               |  22 +
 11 files changed, 896 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/iio/iio_dmabuf_api.rst

-- 
2.43.0


