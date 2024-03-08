Return-Path: <dmaengine+bounces-1312-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3DD8876904
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 18:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8163C2862BE
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF6F1CFAB;
	Fri,  8 Mar 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="mmd0bdG2"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E615D0;
	Fri,  8 Mar 2024 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917276; cv=none; b=b+9K0LZWxST9I8HxMEQD3NUkyww1Gp/2c8VzArpgRkkPTW6nB1WKwORYlBCgcL99f2jSwmCm4US/zIRBLN4Vl4vGiMXp3ieI2xOvUK6a/kAYeKR6O+Zt61yzJkm6gW/ecUJ5gA3WSCTA7DxIL2p9igURxNyVAMVAPZfCOGGbs6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917276; c=relaxed/simple;
	bh=5s4uVZYzL5xnUpS0cs0ZcugLLMwfYan+D4jDkzO05oI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F5yeBgfJBUpt2plQ6RABpe+qB0nYeW6sYW3gh+vcsrZAb/1TEz+n6rA4PEoz4R++trqZpT7ps0pC48ZEukXYfiVs+Vd/gP7ZcI479ZusZIjUIch4ojcPvfeC6fbN4H1LYC1c9KTxTuMvcy4mswmOXFpJXyZsBO6rnJajtTK2Jec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=mmd0bdG2; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1709917266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SFBKjiymmjn1Cc3fHZlhJhqjEETz/4Y5VvGtGcGIiE0=;
	b=mmd0bdG2Y0uIyMvOaFFYjT8Bw1Stk2P0bT4cT5sR/e4CzY9Zm9IbFsvaT9Hfsr9jTrdlkv
	hBs20kbmTnPHjoFINI/0dooDsZ/lEFTN/ma1tt030mEWOn3CDLI1ldB2WDsxQlMUagr13Y
	jenhVg/B0/sIAM4we3ixpKlj8VvNc7Q=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Vinod Koul <vkoul@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Cc: Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v8 0/6] iio: new DMABUF based API
Date: Fri,  8 Mar 2024 18:00:40 +0100
Message-ID: <20240308170046.92899-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Here's the final(tm) version of the IIO DMABUF patchset.

This v8 fixes the remaining few issues that Christian reported.

I also updated the documentation patch as there has been changes to
index.rst.

This was based on next-20240308.

Changelog:

- [3/6]:
    - Fix swapped fence direction
    - Simplify fence wait mechanism
    - Remove "Buffer closed with active transfers" print, as it was dead
      code
    - Un-export iio_buffer_dmabuf_{get,put}. They are not used anywhere
      else so they can even be static.
    - Prevent attaching already-attached DMABUFs
- [6/6]:
    Renamed dmabuf_api.rst -> iio_dmabuf_api.rst, and updated index.rst
    whose format changed in iio/togreg.

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
 drivers/iio/buffer/industrialio-buffer-dma.c  | 181 ++++++-
 .../buffer/industrialio-buffer-dmaengine.c    |  59 ++-
 drivers/iio/industrialio-buffer.c             | 462 ++++++++++++++++++
 include/linux/dmaengine.h                     |  27 +
 include/linux/iio/buffer-dma.h                |  31 ++
 include/linux/iio/buffer_impl.h               |  30 ++
 include/uapi/linux/iio/buffer.h               |  22 +
 10 files changed, 890 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/iio/iio_dmabuf_api.rst

-- 
2.43.0


