Return-Path: <dmaengine+bounces-2398-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CA490C8D1
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 13:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961A61C2248F
	for <lists+dmaengine@lfdr.de>; Tue, 18 Jun 2024 11:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E3415A852;
	Tue, 18 Jun 2024 10:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="AlD+nGDp"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF87155CB9;
	Tue, 18 Jun 2024 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704993; cv=none; b=bJ+skRC/apLO4/UBdlQ4iQtlJ2E3Lc63lZ+qAEQ83z25bLx2P6youd+KA/Ry7Z+gWq42HZOyjhhwE8tCzB0omIozaWdLwCPD3i+4oPOOQ8cr+/OXKvtDrrVDcubVwoxMgZXlUFUb0uZuZEu9DhMJf78sq7hXNJdg8fR/5MdWtcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704993; c=relaxed/simple;
	bh=386FCeqt+cn7DvWw7dkFBzGG8Ln9RJz10ej5VMspYfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mN7IhOPqDKiOzVedrrOClSZhPwRe7A8XGUsqHlt12H+kk5gIzl9jXyOWQekyJC4gkTKQbp/SM6fib0gDvwYvrQo6EfCBeHQbDr6ZtSOLTovnxwdJarrj2ZPuuYbHxYDcjdRC4eb+MGnYhtsUi+994VDeKeZMd8y2YvgTMX43u1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=AlD+nGDp; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1718704989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NxqtKVmPuUzwzAnL9yG1og2+bE3kuPHhJ1Yqq2XKxc0=;
	b=AlD+nGDpK6gCIMbHauLWNfqyJinEDblVKdWZGHz8xE48iFVFAme6uVJkQxDFPoZt+uEFes
	/Rc3cYsphNB5UaWeiWtzJDipNZxbF8aDK7Rh46l3rVOyiHVVMQSgTLZITWCQUM9hQNvgAB
	9RsRg4uhiVPvSW2xh8ZZGUqFGS4FvjI=
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
Subject: [PATCH v11 0/7] iio: new DMABUF based API v11
Date: Tue, 18 Jun 2024 12:02:55 +0200
Message-ID: <20240618100302.72886-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jonathan,

Here's the v11 of my patchset that introduces DMABUF support to IIO.

It addresses the few points that were raised in the review of the v10.
It also adds Nuno as a co-developer.

Changelog:
- [3/7]:
    - Document .lock_queue / .unlock_queue buffer callbacks
    - Add small comment to explain what the spinlock protects
    - Use guard(mutex)

- [4/7]:
    - Remove useless field "attach" in struct iio_dma_buffer_block
    - Document "sg_table" and "fence" fields in struct iio_block_state

- [6/7]:
    - "a IIO buffer" -> "an IIO buffer"
    - Add variable name in IOCTL calls

- [7/7]: New patch, to document the DMA changes

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
 drivers/iio/industrialio-buffer.c             | 457 ++++++++++++++++++
 include/linux/dmaengine.h                     |  33 ++
 include/linux/iio/buffer-dma.h                |  31 ++
 include/linux/iio/buffer_impl.h               |  33 ++
 include/uapi/linux/iio/buffer.h               |  22 +
 13 files changed, 911 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/iio/iio_dmabuf_api.rst

-- 
2.43.0


