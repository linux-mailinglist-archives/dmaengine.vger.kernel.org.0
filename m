Return-Path: <dmaengine+bounces-2435-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DA69103F5
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 14:28:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F26FB225A2
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B51AC770;
	Thu, 20 Jun 2024 12:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="lqyoE7Lh"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F001AC43A;
	Thu, 20 Jun 2024 12:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718886471; cv=none; b=p6nMIZTdhPMu4KSgKd8wvaX+oJgNrMQ1pFvyPZsXjetlCOrOmKYhzBMm8Eogeyr4JXyc62PkmvjMpkWwfhVg3ejMTC+OKvy+6j2SSdz2tm+08sAKIv6GB8EDX+kUqYVI2geYL6Im+apqGLd43RRKImwl3Zl0NxSQvXfGb0EBvKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718886471; c=relaxed/simple;
	bh=IVri826X6pjvmhvTPcELbF/pb2ND/lJ9NsEDK/hpclw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o+wVlu5dE6CeY3YxgXaXXFrEHW9vov5Knb5FrLFsP9j+tDrSKelDc4Y/aGoPhFwxh/FS04YbiG6vt+DhZGGnxx0dd3Vb3dciYkDul2whgg6MJmpINE+iTBiy+yLHUmIw1DN5EaDMCEsB8q/nqAtYt+5y0tqTU01Knl4trKU13c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=lqyoE7Lh; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718886461;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Phdke2IFP5DcYdJ0p7PW2PSRcousUzjTQIkIha9HQSc=;
	b=lqyoE7LhGfv+iomk4eTa9NEiOz1RYXGYKWnWtmg0TLRMwz3ZwT5U4Q1tiD3BbLWC7jd1gd
	wvR7Cn975V5ErvS3+B/VzBl9ndkSmmj8f4FUb3xv3z9aE/TKsnvtI/iW13i70tQlXiJFk3
	stFWt0d2tKtU1RCBJSvdUg2aBvZBX2s=
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
Subject: [PATCH v12 0/7] iio: new DMABUF based API v12
Date: Thu, 20 Jun 2024 14:27:19 +0200
Message-ID: <20240620122726.41232-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Here's the v12 of my patchset that introduces DMABUF support to IIO.

Apart from a small documentation fix, it reverts to using
mutex_lock/mutex_unlock in one particular place, which used cleanup
GOTOs (which don't play well with scope-managed cleanups).

Changelog:
- [3/7]:
    - Revert to mutex_lock/mutex_unlock in iio_buffer_attach_dmabuf(),
      as it uses cleanup GOTOs
- [6/7]:
    - "obtained using..." -> "which can be obtained using..."

This is based on next-20240619.

Cheers,
-Paul

Paul Cercueil (7):
  dmaengine: Add API function dmaengine_prep_peripheral_dma_vec()
  dmaengine: dma-axi-dmac: Implement device_prep_peripheral_dma_vec
  iio: core: Add new DMABUF interface infrastructure
  iio: buffer-dma: Enable support for DMABUFs
  iio: buffer-dmaengine: Support new DMABUF based userspace API
  Documentation: iio: Document high-speed DMABUF based API
  Documentation: dmaengine: Document new dma_vec API

 Documentation/driver-api/dmaengine/client.rst |   9 +
 .../driver-api/dmaengine/provider.rst         |  10 +
 Documentation/iio/iio_dmabuf_api.rst          |  54 +++
 Documentation/iio/index.rst                   |   1 +
 drivers/dma/dma-axi-dmac.c                    |  40 ++
 drivers/iio/Kconfig                           |   1 +
 drivers/iio/buffer/industrialio-buffer-dma.c  | 178 ++++++-
 .../buffer/industrialio-buffer-dmaengine.c    |  62 ++-
 drivers/iio/industrialio-buffer.c             | 459 ++++++++++++++++++
 include/linux/dmaengine.h                     |  33 ++
 include/linux/iio/buffer-dma.h                |  31 ++
 include/linux/iio/buffer_impl.h               |  33 ++
 include/uapi/linux/iio/buffer.h               |  22 +
 13 files changed, 913 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/iio/iio_dmabuf_api.rst

-- 
2.43.0


