Return-Path: <dmaengine+bounces-1318-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F9876934
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E92D1F24027
	for <lists+dmaengine@lfdr.de>; Fri,  8 Mar 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAD925561;
	Fri,  8 Mar 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="cfe3jGSB"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B39920B10;
	Fri,  8 Mar 2024 17:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709917327; cv=none; b=oKeUzVOv2tiMbLILXCJv2wNwMsDqdQ4Th51ceJJh/2YUMrkPLCkERuROBugjbtJo5wIFY9k2xNammKCz3p78LbOYqo7nFp0/kzPVQPtkWXJYkoTDhZmp66dBmu0Xc7daM2bk1od6mzM5p3sM3/AaFF1kjSunOMEZOf3zBow+Lw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709917327; c=relaxed/simple;
	bh=7rJNPk5qiV3E0ifxTX8jkksd+LV5PqcDPbZuQZG7yB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tKiVPRWhiQ/HqHwfF2jmoSz1n7/7bhRVn2ppC7wqO7eyQUlXDVazrOCMH1DJDADZsi8ECBbtiFrunoAzxIRW0n7aN/uDDkUjs84AFcSZTHlVUBCcIB2zbxd+QMoEK++fO6JfKRx86ARjul3Y9PQIIOdTyJUjMEXJyK87JntxTYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=cfe3jGSB; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1709917273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2zetX9Ab4rI9KD/Qs27nOHFRQ3+katPydkX7yEGprj4=;
	b=cfe3jGSBYDasKN6ckheBBouRjThZ6zA+AxR3dGNEkoLdqhufOpbu7M6odg6P7rT/uuch58
	esoVNMuN6Z6uW3zMqk5PMUuTSEp85/SJCW5tY9HonKYfgtv9kxn5nwwtXX4GAkBrzj1X+I
	+40Yq3c7kjnqQjbwQRwKNMBegpWSS6o=
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
Subject: [PATCH v8 6/6] Documentation: iio: Document high-speed DMABUF based API
Date: Fri,  8 Mar 2024 18:00:46 +0100
Message-ID: <20240308170046.92899-7-paul@crapouillou.net>
In-Reply-To: <20240308170046.92899-1-paul@crapouillou.net>
References: <20240308170046.92899-1-paul@crapouillou.net>
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


