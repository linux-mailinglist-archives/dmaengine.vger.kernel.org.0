Return-Path: <dmaengine+bounces-582-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A76818EE8
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 18:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6930F1C24AFF
	for <lists+dmaengine@lfdr.de>; Tue, 19 Dec 2023 17:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED39D3FE3E;
	Tue, 19 Dec 2023 17:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="pXQivTgW"
X-Original-To: dmaengine@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7341942054;
	Tue, 19 Dec 2023 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1703008223;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YYehNBgT3gl7Aub1xHBJlvTB7ei9jO5KY2L6XcmlaP4=;
	b=pXQivTgWp46MYo89Y87zWo2NeOjSvY4hatDwM5yCoV4CKYJnOdZUMpH5dgUEOA93A9Qh8P
	qbTA359k57KsfMeoOSkdlaBmEslCgWVdj8ai1r3CBDRfsypp4opL6dlKTTeXIcZ90pFc6H
	qk0UAinhcz5ivLdevJLw021xR9/V6TQ=
From: Paul Cercueil <paul@crapouillou.net>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Vinod Koul <vkoul@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v5 5/8] iio: core: Add new DMABUF interface infrastructure
Date: Tue, 19 Dec 2023 18:50:06 +0100
Message-ID: <20231219175009.65482-6-paul@crapouillou.net>
In-Reply-To: <20231219175009.65482-1-paul@crapouillou.net>
References: <20231219175009.65482-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes

Add the necessary infrastructure to the IIO core to support a new
optional DMABUF based interface.

With this new interface, DMABUF objects (externally created) can be
attached to a IIO buffer, and subsequently used for data transfer.

A userspace application can then use this interface to share DMABUF
objects between several interfaces, allowing it to transfer data in a
zero-copy fashion, for instance between IIO and the USB stack.

The userspace application can also memory-map the DMABUF objects, and
access the sample data directly. The advantage of doing this vs. the
read() interface is that it avoids an extra copy of the data between the
kernel and userspace. This is particularly userful for high-speed
devices which produce several megabytes or even gigabytes of data per
second.

As part of the interface, 3 new IOCTLs have been added:

IIO_BUFFER_DMABUF_ATTACH_IOCTL(int fd):
 Attach the DMABUF object identified by the given file descriptor to the
 buffer.

IIO_BUFFER_DMABUF_DETACH_IOCTL(int fd):
 Detach the DMABUF object identified by the given file descriptor from
 the buffer. Note that closing the IIO buffer's file descriptor will
 automatically detach all previously attached DMABUF objects.

IIO_BUFFER_DMABUF_ENQUEUE_IOCTL(struct iio_dmabuf *):
 Request a data transfer to/from the given DMABUF object. Its file
 descriptor, as well as the transfer size and flags are provided in the
 "iio_dmabuf" structure.

These three IOCTLs have to be performed on the IIO buffer's file
descriptor, obtained using the IIO_BUFFER_GET_FD_IOCTL() ioctl.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>

---
v2: Only allow the new IOCTLs on the buffer FD created with
    IIO_BUFFER_GET_FD_IOCTL().

v3: - Get rid of the old IOCTLs. The IIO subsystem does not create or
    manage DMABUFs anymore, and only attaches/detaches externally
    created DMABUFs.
    - Add IIO_BUFFER_DMABUF_CYCLIC to the supported flags.

v5: - Use dev_err() instead of pr_err()
    - Inline to_iio_dma_fence()
    - Add comment to explain why we unref twice when detaching dmabuf
    - Remove TODO comment. It is actually safe to free the file's
      private data even when transfers are still pending because it
      won't be accessed.
    - Fix documentation of new fields in struct iio_buffer_access_funcs
    - iio_dma_resv_lock() does not need to be exported, make it static
---
 drivers/iio/industrialio-buffer.c | 402 ++++++++++++++++++++++++++++++
 include/linux/iio/buffer_impl.h   |  26 ++
 include/uapi/linux/iio/buffer.h   |  22 ++
 3 files changed, 450 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 09c41e9ccf87..24c040e073a7 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -13,10 +13,14 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/device.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-fence.h>
+#include <linux/dma-resv.h>
 #include <linux/file.h>
 #include <linux/fs.h>
 #include <linux/cdev.h>
 #include <linux/slab.h>
+#include <linux/mm.h>
 #include <linux/poll.h>
 #include <linux/sched/signal.h>
 
@@ -28,6 +32,31 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/buffer_impl.h>
 
+#define DMABUF_ENQUEUE_TIMEOUT_MS 5000
+
+struct iio_dma_fence;
+
+struct iio_dmabuf_priv {
+	struct list_head entry;
+	struct kref ref;
+
+	struct iio_buffer *buffer;
+	struct iio_dma_buffer_block *block;
+
+	u64 context;
+	spinlock_t lock;
+
+	struct dma_buf_attachment *attach;
+	struct iio_dma_fence *fence;
+};
+
+struct iio_dma_fence {
+	struct dma_fence base;
+	struct iio_dmabuf_priv *priv;
+	struct sg_table *sgt;
+	enum dma_data_direction dir;
+};
+
 static const char * const iio_endian_prefix[] = {
 	[IIO_BE] = "be",
 	[IIO_LE] = "le",
@@ -332,6 +361,7 @@ void iio_buffer_init(struct iio_buffer *buffer)
 {
 	INIT_LIST_HEAD(&buffer->demux_list);
 	INIT_LIST_HEAD(&buffer->buffer_list);
+	INIT_LIST_HEAD(&buffer->dmabufs);
 	init_waitqueue_head(&buffer->pollq);
 	kref_init(&buffer->ref);
 	if (!buffer->watermark)
@@ -1519,14 +1549,54 @@ static void iio_buffer_unregister_legacy_sysfs_groups(struct iio_dev *indio_dev)
 	kfree(iio_dev_opaque->legacy_scan_el_group.attrs);
 }
 
+static void iio_buffer_dmabuf_release(struct kref *ref)
+{
+	struct iio_dmabuf_priv *priv = container_of(ref, struct iio_dmabuf_priv, ref);
+	struct dma_buf_attachment *attach = priv->attach;
+	struct iio_buffer *buffer = priv->buffer;
+	struct dma_buf *dmabuf = attach->dmabuf;
+
+	buffer->access->detach_dmabuf(buffer, priv->block);
+
+	dma_buf_detach(attach->dmabuf, attach);
+	dma_buf_put(dmabuf);
+	kfree(priv);
+}
+
+void iio_buffer_dmabuf_get(struct dma_buf_attachment *attach)
+{
+	struct iio_dmabuf_priv *priv = attach->importer_priv;
+
+	kref_get(&priv->ref);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_dmabuf_get);
+
+void iio_buffer_dmabuf_put(struct dma_buf_attachment *attach)
+{
+	struct iio_dmabuf_priv *priv = attach->importer_priv;
+
+	kref_put(&priv->ref, iio_buffer_dmabuf_release);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_dmabuf_put);
+
 static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
 {
 	struct iio_dev_buffer_pair *ib = filep->private_data;
 	struct iio_dev *indio_dev = ib->indio_dev;
 	struct iio_buffer *buffer = ib->buffer;
+	struct iio_dmabuf_priv *priv, *tmp;
 
 	wake_up(&buffer->pollq);
 
+	/* Close all attached DMABUFs */
+	list_for_each_entry_safe(priv, tmp, &buffer->dmabufs, entry) {
+		list_del_init(&priv->entry);
+		iio_buffer_dmabuf_put(priv->attach);
+	}
+
+	if (!list_empty(&buffer->dmabufs))
+		dev_warn(&indio_dev->dev, "Buffer FD closed with active transfers\n");
+
 	kfree(ib);
 	clear_bit(IIO_BUSY_BIT_POS, &buffer->flags);
 	iio_device_put(indio_dev);
@@ -1534,11 +1604,343 @@ static int iio_buffer_chrdev_release(struct inode *inode, struct file *filep)
 	return 0;
 }
 
+static int iio_dma_resv_lock(struct dma_buf *dmabuf, bool nonblock)
+{
+	int ret;
+
+	ret = dma_resv_lock_interruptible(dmabuf->resv, NULL);
+	if (ret) {
+		if (ret != -EDEADLK)
+			goto out;
+		if (nonblock) {
+			ret = -EBUSY;
+			goto out;
+		}
+
+		ret = dma_resv_lock_slow_interruptible(dmabuf->resv, NULL);
+	}
+
+out:
+	return ret;
+}
+
+static struct dma_buf_attachment *
+iio_buffer_find_attachment(struct iio_dev *indio_dev, struct dma_buf *dmabuf)
+{
+	struct dma_buf_attachment *elm, *attach = NULL;
+	int ret;
+
+	ret = iio_dma_resv_lock(dmabuf, false);
+	if (ret)
+		return ERR_PTR(ret);
+
+	list_for_each_entry(elm, &dmabuf->attachments, node) {
+		if (elm->dev == indio_dev->dev.parent) {
+			attach = elm;
+			break;
+		}
+	}
+
+	if (attach)
+		iio_buffer_dmabuf_get(elm);
+
+	dma_resv_unlock(dmabuf->resv);
+
+	return attach ?: ERR_PTR(-EPERM);
+}
+
+static int iio_buffer_attach_dmabuf(struct iio_dev_buffer_pair *ib,
+				    int __user *user_fd)
+{
+	struct iio_dev *indio_dev = ib->indio_dev;
+	struct iio_buffer *buffer = ib->buffer;
+	struct dma_buf_attachment *attach;
+	struct iio_dmabuf_priv *priv;
+	struct dma_buf *dmabuf;
+	int err, fd;
+
+	if (!buffer->access->attach_dmabuf
+	    || !buffer->access->detach_dmabuf
+	    || !buffer->access->enqueue_dmabuf)
+		return -EPERM;
+
+	if (copy_from_user(&fd, user_fd, sizeof(fd)))
+		return -EFAULT;
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	spin_lock_init(&priv->lock);
+	priv->context = dma_fence_context_alloc(1);
+
+	dmabuf = dma_buf_get(fd);
+	if (IS_ERR(dmabuf)) {
+		err = PTR_ERR(dmabuf);
+		goto err_free_priv;
+	}
+
+	attach = dma_buf_attach(dmabuf, indio_dev->dev.parent);
+	if (IS_ERR(attach)) {
+		err = PTR_ERR(attach);
+		goto err_dmabuf_put;
+	}
+
+	kref_init(&priv->ref);
+	priv->buffer = buffer;
+	priv->attach = attach;
+	attach->importer_priv = priv;
+
+	priv->block = buffer->access->attach_dmabuf(buffer, attach);
+	if (IS_ERR(priv->block)) {
+		err = PTR_ERR(priv->block);
+		goto err_dmabuf_detach;
+	}
+
+	list_add(&priv->entry, &buffer->dmabufs);
+
+	return 0;
+
+err_dmabuf_detach:
+	dma_buf_detach(dmabuf, attach);
+err_dmabuf_put:
+	dma_buf_put(dmabuf);
+err_free_priv:
+	kfree(priv);
+
+	return err;
+}
+
+static int iio_buffer_detach_dmabuf(struct iio_dev_buffer_pair *ib, int *user_req)
+{
+	struct dma_buf_attachment *attach;
+	struct iio_dmabuf_priv *priv;
+	struct dma_buf *dmabuf;
+	int dmabuf_fd, ret = 0;
+
+	if (copy_from_user(&dmabuf_fd, user_req, sizeof(dmabuf_fd)))
+		return -EFAULT;
+
+	dmabuf = dma_buf_get(dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	attach = iio_buffer_find_attachment(ib->indio_dev, dmabuf);
+	if (IS_ERR(attach)) {
+		ret = PTR_ERR(attach);
+		goto out_dmabuf_put;
+	}
+
+	priv = attach->importer_priv;
+	list_del_init(&priv->entry);
+
+	/*
+	 * Unref twice to release the reference obtained with
+	 * iio_buffer_find_attachment() above, and the one obtained in
+	 * iio_buffer_attach_dmabuf().
+	 */
+	iio_buffer_dmabuf_put(attach);
+	iio_buffer_dmabuf_put(attach);
+
+out_dmabuf_put:
+	dma_buf_put(dmabuf);
+
+	return ret;
+}
+
+static const char *
+iio_buffer_dma_fence_get_driver_name(struct dma_fence *fence)
+{
+	return "iio";
+}
+
+static void iio_buffer_dma_fence_release(struct dma_fence *fence)
+{
+	struct iio_dma_fence *iio_fence =
+		container_of(fence, struct iio_dma_fence, base);
+
+	kfree(iio_fence);
+}
+
+static const struct dma_fence_ops iio_buffer_dma_fence_ops = {
+	.get_driver_name	= iio_buffer_dma_fence_get_driver_name,
+	.get_timeline_name	= iio_buffer_dma_fence_get_driver_name,
+	.release		= iio_buffer_dma_fence_release,
+};
+
+static int iio_buffer_enqueue_dmabuf(struct iio_dev_buffer_pair *ib,
+				     struct iio_dmabuf __user *iio_dmabuf_req,
+				     bool nonblock)
+{
+	struct iio_dev *indio_dev = ib->indio_dev;
+	struct iio_buffer *buffer = ib->buffer;
+	struct iio_dmabuf iio_dmabuf;
+	struct dma_buf_attachment *attach;
+	struct iio_dmabuf_priv *priv;
+	enum dma_data_direction dir;
+	struct iio_dma_fence *fence;
+	struct dma_buf *dmabuf;
+	struct sg_table *sgt;
+	unsigned long timeout;
+	bool dma_to_ram;
+	bool cyclic;
+	int ret;
+
+	if (copy_from_user(&iio_dmabuf, iio_dmabuf_req, sizeof(iio_dmabuf)))
+		return -EFAULT;
+
+	if (iio_dmabuf.flags & ~IIO_BUFFER_DMABUF_SUPPORTED_FLAGS)
+		return -EINVAL;
+
+	cyclic = iio_dmabuf.flags & IIO_BUFFER_DMABUF_CYCLIC;
+
+	/* Cyclic flag is only supported on output buffers */
+	if (cyclic && buffer->direction != IIO_BUFFER_DIRECTION_OUT)
+		return -EINVAL;
+
+	dmabuf = dma_buf_get(iio_dmabuf.fd);
+	if (IS_ERR(dmabuf))
+		return PTR_ERR(dmabuf);
+
+	if (!iio_dmabuf.bytes_used || iio_dmabuf.bytes_used > dmabuf->size) {
+		ret = -EINVAL;
+		goto err_dmabuf_put;
+	}
+
+	attach = iio_buffer_find_attachment(indio_dev, dmabuf);
+	if (IS_ERR(attach)) {
+		ret = PTR_ERR(attach);
+		goto err_dmabuf_put;
+	}
+
+	priv = attach->importer_priv;
+
+	dma_to_ram = buffer->direction == IIO_BUFFER_DIRECTION_IN;
+	dir = dma_to_ram ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+
+	sgt = dma_buf_map_attachment(attach, dir);
+	if (IS_ERR(sgt)) {
+		ret = PTR_ERR(sgt);
+		dev_err(&indio_dev->dev, "Unable to map attachment: %d\n", ret);
+		goto err_attachment_put;
+	}
+
+	fence = kmalloc(sizeof(*fence), GFP_KERNEL);
+	if (!fence) {
+		ret = -ENOMEM;
+		goto err_unmap_attachment;
+	}
+
+	fence->priv = priv;
+	fence->sgt = sgt;
+	fence->dir = dir;
+	priv->fence = fence;
+
+	dma_fence_init(&fence->base, &iio_buffer_dma_fence_ops,
+		       &priv->lock, priv->context, 0);
+
+	ret = iio_dma_resv_lock(dmabuf, nonblock);
+	if (ret)
+		goto err_fence_put;
+
+	timeout = nonblock ? 0 : msecs_to_jiffies(DMABUF_ENQUEUE_TIMEOUT_MS);
+
+	/* Make sure we don't have writers */
+	ret = (int) dma_resv_wait_timeout(dmabuf->resv, DMA_RESV_USAGE_WRITE,
+					  true, timeout);
+	if (ret == 0)
+		ret = -EBUSY;
+	if (ret < 0)
+		goto err_resv_unlock;
+
+	if (dma_to_ram) {
+		/*
+		 * If we're writing to the DMABUF, make sure we don't have
+		 * readers
+		 */
+		ret = (int) dma_resv_wait_timeout(dmabuf->resv,
+						  DMA_RESV_USAGE_READ, true,
+						  timeout);
+		if (ret == 0)
+			ret = -EBUSY;
+		if (ret < 0)
+			goto err_resv_unlock;
+	}
+
+	ret = dma_resv_reserve_fences(dmabuf->resv, 1);
+	if (ret)
+		goto err_resv_unlock;
+
+	dma_resv_add_fence(dmabuf->resv, &fence->base,
+			   dma_resv_usage_rw(dma_to_ram));
+	dma_resv_unlock(dmabuf->resv);
+
+	ret = buffer->access->enqueue_dmabuf(buffer, priv->block, sgt,
+					     iio_dmabuf.bytes_used, cyclic);
+	if (ret)
+		iio_buffer_signal_dmabuf_done(attach, ret);
+
+	dma_buf_put(dmabuf);
+
+	return ret;
+
+err_resv_unlock:
+	dma_resv_unlock(dmabuf->resv);
+err_fence_put:
+	dma_fence_put(&fence->base);
+err_unmap_attachment:
+	dma_buf_unmap_attachment(attach, sgt, dir);
+err_attachment_put:
+	iio_buffer_dmabuf_put(attach);
+err_dmabuf_put:
+	dma_buf_put(dmabuf);
+
+	return ret;
+}
+
+void iio_buffer_signal_dmabuf_done(struct dma_buf_attachment *attach, int ret)
+{
+	struct iio_dmabuf_priv *priv = attach->importer_priv;
+	struct iio_dma_fence *fence = priv->fence;
+	enum dma_data_direction dir = fence->dir;
+	struct sg_table *sgt = fence->sgt;
+
+	dma_fence_get(&fence->base);
+	fence->base.error = ret;
+	dma_fence_signal(&fence->base);
+	dma_fence_put(&fence->base);
+
+	dma_buf_unmap_attachment(attach, sgt, dir);
+	iio_buffer_dmabuf_put(attach);
+}
+EXPORT_SYMBOL_GPL(iio_buffer_signal_dmabuf_done);
+
+static long iio_buffer_chrdev_ioctl(struct file *filp,
+				    unsigned int cmd, unsigned long arg)
+{
+	struct iio_dev_buffer_pair *ib = filp->private_data;
+	void __user *_arg = (void __user *)arg;
+
+	switch (cmd) {
+	case IIO_BUFFER_DMABUF_ATTACH_IOCTL:
+		return iio_buffer_attach_dmabuf(ib, _arg);
+	case IIO_BUFFER_DMABUF_DETACH_IOCTL:
+		return iio_buffer_detach_dmabuf(ib, _arg);
+	case IIO_BUFFER_DMABUF_ENQUEUE_IOCTL:
+		return iio_buffer_enqueue_dmabuf(ib, _arg,
+						 filp->f_flags & O_NONBLOCK);
+	default:
+		return IIO_IOCTL_UNHANDLED;
+	}
+}
+
 static const struct file_operations iio_buffer_chrdev_fileops = {
 	.owner = THIS_MODULE,
 	.llseek = noop_llseek,
 	.read = iio_buffer_read,
 	.write = iio_buffer_write,
+	.unlocked_ioctl = iio_buffer_chrdev_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.poll = iio_buffer_poll,
 	.release = iio_buffer_chrdev_release,
 };
diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index 89c3fd7c29ca..55d93705c96b 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -9,8 +9,11 @@
 #include <uapi/linux/iio/buffer.h>
 #include <linux/iio/buffer.h>
 
+struct dma_buf_attachment;
 struct iio_dev;
+struct iio_dma_buffer_block;
 struct iio_buffer;
+struct sg_table;
 
 /**
  * INDIO_BUFFER_FLAG_FIXED_WATERMARK - Watermark level of the buffer can not be
@@ -39,6 +42,13 @@ struct iio_buffer;
  *                      device stops sampling. Calles are balanced with @enable.
  * @release:		called when the last reference to the buffer is dropped,
  *			should free all resources allocated by the buffer.
+ * @attach_dmabuf:	called from userspace via ioctl to attach one external
+ *			DMABUF.
+ * @detach_dmabuf:	called from userspace via ioctl to detach one previously
+ *			attached DMABUF.
+ * @enqueue_dmabuf:	called from userspace via ioctl to queue this DMABUF
+ *			object to this buffer. Requires a valid DMABUF fd, that
+ *			was previouly attached to this buffer.
  * @modes:		Supported operating modes by this buffer type
  * @flags:		A bitmask combination of INDIO_BUFFER_FLAG_*
  *
@@ -68,6 +78,14 @@ struct iio_buffer_access_funcs {
 
 	void (*release)(struct iio_buffer *buffer);
 
+	struct iio_dma_buffer_block * (*attach_dmabuf)(struct iio_buffer *buffer,
+						       struct dma_buf_attachment *attach);
+	void (*detach_dmabuf)(struct iio_buffer *buffer,
+			      struct iio_dma_buffer_block *block);
+	int (*enqueue_dmabuf)(struct iio_buffer *buffer,
+			      struct iio_dma_buffer_block *block,
+			      struct sg_table *sgt, size_t size, bool cyclic);
+
 	unsigned int modes;
 	unsigned int flags;
 };
@@ -136,6 +154,9 @@ struct iio_buffer {
 
 	/* @ref: Reference count of the buffer. */
 	struct kref ref;
+
+	/* @dmabufs: List of DMABUF attachments */
+	struct list_head dmabufs;
 };
 
 /**
@@ -156,9 +177,14 @@ int iio_update_buffers(struct iio_dev *indio_dev,
  **/
 void iio_buffer_init(struct iio_buffer *buffer);
 
+void iio_buffer_dmabuf_get(struct dma_buf_attachment *attach);
+void iio_buffer_dmabuf_put(struct dma_buf_attachment *attach);
+
 struct iio_buffer *iio_buffer_get(struct iio_buffer *buffer);
 void iio_buffer_put(struct iio_buffer *buffer);
 
+void iio_buffer_signal_dmabuf_done(struct dma_buf_attachment *attach, int ret);
+
 #else /* CONFIG_IIO_BUFFER */
 
 static inline void iio_buffer_get(struct iio_buffer *buffer) {}
diff --git a/include/uapi/linux/iio/buffer.h b/include/uapi/linux/iio/buffer.h
index 13939032b3f6..c666aa95e532 100644
--- a/include/uapi/linux/iio/buffer.h
+++ b/include/uapi/linux/iio/buffer.h
@@ -5,6 +5,28 @@
 #ifndef _UAPI_IIO_BUFFER_H_
 #define _UAPI_IIO_BUFFER_H_
 
+#include <linux/types.h>
+
+/* Flags for iio_dmabuf.flags */
+#define IIO_BUFFER_DMABUF_CYCLIC		(1 << 0)
+#define IIO_BUFFER_DMABUF_SUPPORTED_FLAGS	0x00000001
+
+/**
+ * struct iio_dmabuf - Descriptor for a single IIO DMABUF object
+ * @fd:		file descriptor of the DMABUF object
+ * @flags:	one or more IIO_BUFFER_DMABUF_* flags
+ * @bytes_used:	number of bytes used in this DMABUF for the data transfer.
+ *		Should generally be set to the DMABUF's size.
+ */
+struct iio_dmabuf {
+	__u32 fd;
+	__u32 flags;
+	__u64 bytes_used;
+};
+
 #define IIO_BUFFER_GET_FD_IOCTL			_IOWR('i', 0x91, int)
+#define IIO_BUFFER_DMABUF_ATTACH_IOCTL		_IOW('i', 0x92, int)
+#define IIO_BUFFER_DMABUF_DETACH_IOCTL		_IOW('i', 0x93, int)
+#define IIO_BUFFER_DMABUF_ENQUEUE_IOCTL		_IOW('i', 0x94, struct iio_dmabuf)
 
 #endif /* _UAPI_IIO_BUFFER_H_ */
-- 
2.43.0


