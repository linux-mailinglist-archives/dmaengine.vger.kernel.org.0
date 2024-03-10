Return-Path: <dmaengine+bounces-1334-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE708776D5
	for <lists+dmaengine@lfdr.de>; Sun, 10 Mar 2024 13:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D8CDB207C9
	for <lists+dmaengine@lfdr.de>; Sun, 10 Mar 2024 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA928389;
	Sun, 10 Mar 2024 12:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="LgQ5kVEB"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC52239FE9;
	Sun, 10 Mar 2024 12:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710074987; cv=none; b=Hydkls2jcrLpgeGKa+KYLKG4joVNbBB8Jtz452LrtcQEWJCN9ABNoSXLm79MACF1h+2ONq5YG8loTpolFY6zuI0zNR/dreU0RSh75LQUpNTQhMzkuV7En4aHF7rBIugUwCSyK7NvbQJijw29rgZV8ouY6nKAggcQp3t+1NkFyqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710074987; c=relaxed/simple;
	bh=7rJNPk5qiV3E0ifxTX8jkksd+LV5PqcDPbZuQZG7yB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdXPfNQRIaJvhRQfE3S7+8OdhN8OBkOy0VOTojPQ/KGxxo27nXtA4SDxWeRcvANn3clrkGbhbbtgWZdgnDlwjnMgTsjYYQty9TlUcqR7VpJkz/0ZSdH51qo5d92RaEsid6hh2Ml8dn0rF7cshLVXZsJRhCdhNthmXGBQU5a2Q7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=LgQ5kVEB; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1710074932;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zetX9Ab4rI9KD/Qs27nOHFRQ3+katPydkX7yEGprj4=;
	b=LgQ5kVEBKsl1tPmpaqeayrkOe46ZnML5PzzLNkMZVhwbgn/6SaiKV5Fy+C9lDLy4GFYSzB
	EaeGEzsHjeuS2Ajouwx8S4rpkTygI5n7990v40U/VhWuiNZxOZLQQnYcLfjL8KHElkBS71
	nF9kj04Z0OuVQLFzEapD4DXvGc/xvSE=
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
Subject: [PATCH v9 6/6] Documentation: iio: Document high-speed DMABUF based API
Date: Sun, 10 Mar 2024 13:48:35 +0100
Message-ID: <20240310124836.31863-7-paul@crapouillou.net>
In-Reply-To: <20240310124836.31863-1-paul@crapouillou.net>
References: <20240310124836.31863-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the new DMABUF based API.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Nuno Sa <nuno.sa@analog.com>

---
v2: - Explicitly state that the new interface is optional and is
      not implemented by all drivers.
    - The IOCTLs can now only be called on the buffer FD returned by
      IIO_BUFFER_GET_FD_IOCTL.
    - Move the page up a bit in the index since it is core stuff and not
      driver-specific.

v3: Update the documentation to reflect the new API.

v5: Use description lists for the documentation of the three new IOCTLs
    instead of abusing subsections.

v8: Renamed dmabuf_api.rst -> iio_dmabuf_api.rst, and updated index.rst
    whose format changed in iio/togreg.
---
 Documentation/iio/iio_dmabuf_api.rst | 54 ++++++++++++++++++++++++++++
 Documentation/iio/index.rst          |  1 +
 2 files changed, 55 insertions(+)
 create mode 100644 Documentation/iio/iio_dmabuf_api.rst

diff --git a/Documentation/iio/iio_dmabuf_api.rst b/Documentation/iio/iio_dmabuf_api.rst
new file mode 100644
index 000000000000..1cd6cd51a582
--- /dev/null
+++ b/Documentation/iio/iio_dmabuf_api.rst
@@ -0,0 +1,54 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================
+High-speed DMABUF interface for IIO
+===================================
+
+1. Overview
+===========
+
+The Industrial I/O subsystem supports access to buffers through a
+file-based interface, with read() and write() access calls through the
+IIO device's dev node.
+
+It additionally supports a DMABUF based interface, where the userspace
+can attach DMABUF objects (externally created) to a IIO buffer, and
+subsequently use them for data transfers.
+
+A userspace application can then use this interface to share DMABUF
+objects between several interfaces, allowing it to transfer data in a
+zero-copy fashion, for instance between IIO and the USB stack.
+
+The userspace application can also memory-map the DMABUF objects, and
+access the sample data directly. The advantage of doing this vs. the
+read() interface is that it avoids an extra copy of the data between the
+kernel and userspace. This is particularly useful for high-speed devices
+which produce several megabytes or even gigabytes of data per second.
+It does however increase the userspace-kernelspace synchronization
+overhead, as the DMA_BUF_SYNC_START and DMA_BUF_SYNC_END IOCTLs have to
+be used for data integrity.
+
+2. User API
+===========
+
+As part of this interface, three new IOCTLs have been added. These three
+IOCTLs have to be performed on the IIO buffer's file descriptor,
+obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.
+
+  ``IIO_BUFFER_DMABUF_ATTACH_IOCTL(int)``
+    Attach the DMABUF object, identified by its file descriptor, to the
+    IIO buffer. Returns zero on success, and a negative errno value on
+    error.
+
+  ``IIO_BUFFER_DMABUF_DETACH_IOCTL(int)``
+    Detach the given DMABUF object, identified by its file descriptor,
+    from the IIO buffer. Returns zero on success, and a negative errno
+    value on error.
+
+    Note that closing the IIO buffer's file descriptor will
+    automatically detach all previously attached DMABUF objects.
+
+  ``IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *iio_dmabuf)``
+    Enqueue a previously attached DMABUF object to the buffer queue.
+    Enqueued DMABUFs will be read from (if output buffer) or written to
+    (if input buffer) as long as the buffer is enabled.
diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
index 30b09eefe75e..feb50b61aac0 100644
--- a/Documentation/iio/index.rst
+++ b/Documentation/iio/index.rst
@@ -9,6 +9,7 @@ Industrial I/O
 
    iio_configfs
    iio_devbuf
+   iio_dmabuf_api
 
 Industrial I/O Kernel Drivers
 =============================
-- 
2.43.0


