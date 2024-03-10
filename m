Return-Path: <dmaengine+bounces-1328-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E988776AB
	for <lists+dmaengine@lfdr.de>; Sun, 10 Mar 2024 13:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E78B1C20FD8
	for <lists+dmaengine@lfdr.de>; Sun, 10 Mar 2024 12:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9725632;
	Sun, 10 Mar 2024 12:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="ttoxhuAU"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472F724B34;
	Sun, 10 Mar 2024 12:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074935; cv=none; b=b4OGbvvhVZ3wvhiIYHhsb0l+NT94GvPjaPlo6f+JZJbfqtkfhGQLLf89NaRwyvIyPkjqBKaT0ls9HYFSYz2KfjsBqdPZtYzpLBr3dkrHxBPraAwfihJ/zoScbCx45uu/D9tjsIqBTyiFu0KAdoNl5egx/kQwr39Q2tU+xlp4iJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074935; c=relaxed/simple;
	bh=4WZpQTJ2FC4y6Xp4cZA98rKgeB5l/4qw3o6ywlolN/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtSwGRGNdXtgVXJf0P9KESg6OW7OESSzO63K1DFRUQkV+jlLd55PY9MrghwNLuMnTMDWNUreKQk9yHA4PeTdBlfbbnKE3XGh3+N56lTL6f6T+mvdJ6P1AY+NJvnJffToZ6AmS5/751J1dLGPcPNG+TrdRggoEl81nAqHoZ2hx5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=ttoxhuAU; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1710074925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3MP05RR+wbCQqXOr0sgjO6JV62/cP9unyj6X/qG6Ojo=;
	b=ttoxhuAUS6+ngXFZaEOsmMvJ9SGESgjp3LJpwJyYloA440908l3ZTN8L2EaWDJNf6eEHW8
	KvUriPAWywZN95WcbPKCTaNJswgorMkKgnn/JB1c5uU/8O6oHiJbUM9MJMBMLQNIIljr1r
	zJnmTqxJB+Oz7iOFywn3b8s8tHqIepM=
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
Subject: [PATCH v9 0/6] iio: new DMABUF based API
Date: Sun, 10 Mar 2024 13:48:29 +0100
Message-ID: <20240310124836.31863-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Here's the final-er version of the IIO DMABUF patchset.

This v9 fixes the few issues reported by the kernel bot.

This was based on next-20240308.

Changelog:

- [3/6]:
    - Select DMA_SHARED_BUFFER in Kconfig
    - Remove useless forward declaration of 'iio_dma_fence'
    - Import DMA-BUF namespace
    - Add missing __user tag to iio_buffer_detach_dmabuf() argument

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
 drivers/iio/buffer/industrialio-buffer-dma.c  | 181 ++++++-
 .../buffer/industrialio-buffer-dmaengine.c    |  59 ++-
 drivers/iio/industrialio-buffer.c             | 462 ++++++++++++++++++
 include/linux/dmaengine.h                     |  27 +
 include/linux/iio/buffer-dma.h                |  31 ++
 include/linux/iio/buffer_impl.h               |  30 ++
 include/uapi/linux/iio/buffer.h               |  22 +
 11 files changed, 891 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/iio/iio_dmabuf_api.rst

-- 
2.43.0


