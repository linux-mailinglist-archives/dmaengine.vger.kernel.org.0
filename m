Return-Path: <dmaengine+bounces-9003-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2A6MCtKxmWnlWAMAu9opvQ
	(envelope-from <dmaengine+bounces-9003-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 14:23:30 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A36E816CE6D
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 14:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F86C302000F
	for <lists+dmaengine@lfdr.de>; Sat, 21 Feb 2026 13:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DBE1B6CE9;
	Sat, 21 Feb 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eZkVA2x+"
X-Original-To: dmaengine@vger.kernel.org
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com [209.85.221.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659B27082F
	for <dmaengine@vger.kernel.org>; Sat, 21 Feb 2026 13:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771680174; cv=none; b=lNcM9pGI/JPanah5xgAfXZiEcPOKKvixNktDCpguitZ4UVwm79nJlCF/CHQT/u4OOipNnnY3dWXbG6gY9vKUzomfmgu9PWRwpgTdJpGBC265kjOf6QnPy1ypLOctgLgQFXjGnmUhEbhLH0vFTCaA3FDwIRMbg8mkyUPERV1mjPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771680174; c=relaxed/simple;
	bh=4WaT+SLTA5E2qENtPUwbbJ6yGcs0q8qkWKWbbfS7YHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BW0uHyhevpb6Nkk3lHAGTTswOgdT1B8KEEiPWGK8y39mjuTNriyFPe0lA/Ew/Wr84/Ur30voWlRRqcQg/lTEOqwQzsiNgXBC0N8y8cSFKcUVT1bWVd5y3cJCkRl8x+jeIqnB7YNbvVZlNlMdgwIGBxtkGQeVmbQesSpFLl4frfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eZkVA2x+; arc=none smtp.client-ip=209.85.221.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f66.google.com with SMTP id ffacd0b85a97d-436317c80f7so2629535f8f.1
        for <dmaengine@vger.kernel.org>; Sat, 21 Feb 2026 05:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771680171; x=1772284971; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mW2mqb4iYYLGxYXz3pBe0gQX7nYgSCJZQBErENVSksc=;
        b=eZkVA2x+u/39+yidrbcztofQubsI561elfwtzMCEUDNAbUykmRYz0vegb6oQ+o9phD
         +R3ydDf+MIGnhq+zw731E+xO9bZf6RawkSq/YIsHeEx7n+qRpukIvc6TNlGte5sfzL3I
         IYGRkz4904Ob32WJ4pwD+HfxH0j3+z6ump3E8iB+o9tL5BEDl8PS8aVvzyhQ+aa/cA/h
         jHRyrWrQetpt/26+rN7tYvRFAo/UyKqoYEWZjyM/RzTpAb59I5c6n3nlo9Ey/gqraMJv
         4xqWEiSzsB5G5fcprRjYGqUaakS7IB2O8mAuIyH1Rlqf2qhA1mfinrveJWah9OAh2Olr
         zRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771680171; x=1772284971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mW2mqb4iYYLGxYXz3pBe0gQX7nYgSCJZQBErENVSksc=;
        b=AxHGtHGR4TSqMB8zYVAkzoi0jzcrrCZqkd7U1LRuZ+kWEMOl3atZp9vkR64gN8fFFA
         SjQjQtpKaM3ZI2upjrQ61ug/YKmRW6vi32nLOBEtY5nl1SsVlyP5FucL9/SJY/P0KW0m
         zM+nvPcgguz3TlG/ULkyCB+e7uTs5B7LSpWr4Z58fO4MVb0MoAuZIwsY/JZkjniq1nHM
         q1eSRob3hDaLS6OtFcM1LL1jehdhR3wMBgRspDd0WIZ4oA3cZ0mwjc0Y+r5tAk51vfzZ
         Wie855gWB6WFLzZBt9BhjDRG7WZaLxkcyeO6pwVYyWIHfJ03QLso3QZtfC6+CXqXFkBb
         Hpow==
X-Gm-Message-State: AOJu0YzRgoF/nnZHA5Bpr8XRf+PA2c0NzxIPK7qk307MrJ9IwqoZXcua
	l2iSZuwBykOBnlTzwJ0gPNuT1FEOwyhF+JT0NIc1SoXXrjofz9vvHsa3xBkJ61xYbak=
X-Gm-Gg: AZuq6aKg+9H/MeeCTlTxLXmmdLP3s68fNFkUKrkWyOyVLEmKQaCxl3uA/zmQzWtMpGD
	GKcis9wdxgRcjlQZGFfSOun7u9Z/VhWZ5gV8dKpxbjRtkEngzTvDzo0CgqydlNLABz+MpF7xcSy
	6ZGmgedTc7P4udcFxhHGcFXda14/JFAg3y7FakbqJ8ENGVeElnIptOh4okGG+UTTEobpS0DtXSu
	U2bHyqJQQo2YFqYD2zAw30qb0GG06eXvcdxLMYqm3uRDN7zz8o6gupFzDvgEdd6mWEV171ZTsDc
	yvjy97M6mRMn09c6jamRfSjObXgEwdd75muyoVT5n559lSNkPGPyN/tKNBQSsUSMDHBW5UAO55N
	KBiBMJOvrRnRQLtT9u1CLMfJihlkJzjszPfnuuFuHDi30EH7bl5akcL0gdCXYQkmTCmCcIFFxyG
	Hz6b9O5q7oK3o7bwQz1sXOLc/V9fY=
X-Received: by 2002:a05:6000:26ce:b0:437:7719:ca82 with SMTP id ffacd0b85a97d-4396fd9bda4mr5318534f8f.3.1771680170611;
        Sat, 21 Feb 2026 05:22:50 -0800 (PST)
Received: from ideapad ([2a02:8070:a483:bca0:8c22:565c:f0a8:cd41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970bfa1bdsm4645071f8f.3.2026.02.21.05.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 05:22:50 -0800 (PST)
From: Alexander Gordeev <a.gordeev.box@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dmaengine/dma-slave: DMA slave device xfer passthrough driver
Date: Sat, 21 Feb 2026 14:22:47 +0100
Message-ID: <20260221132248.17721-2-a.gordeev.box@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260221132248.17721-1-a.gordeev.box@gmail.com>
References: <20260221132248.17721-1-a.gordeev.box@gmail.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9003-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[agordeevbox@gmail.com,dmaengine@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A36E816CE6D
X-Rspamd-Action: no action

This is a driver to help bringing up or debug DMA slave devices.
A target device should expose itself as DMA_SLAVE to be able get
found by dma_request_channel() service. It is located by the name
as exposed in /sys/class/dma.

The ioctl() caller is expected to map a file in user space and
provide the mapping address along with DMA transfer parameters.
The driver sets up and triggers a single the DMA transfer using
zero-copy approach.

The DMA transfer parameters are not sanitized in any way and the
ioctl() caller is expected to be the device-aware.

In other words, considering the DMA transfer parameters and the
data itself this introduces a DMA passthrough driver.

Signed-off-by: Alexander Gordeev <a.gordeev.box@gmail.com>
---
 drivers/dma/Kconfig            |   7 +
 drivers/dma/Makefile           |   1 +
 drivers/dma/dma-slave.c        | 246 +++++++++++++++++++++++++++++++++
 include/uapi/linux/dma-slave.h |  30 ++++
 4 files changed, 284 insertions(+)
 create mode 100644 drivers/dma/dma-slave.c
 create mode 100644 include/uapi/linux/dma-slave.h

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 4d0946f92edf..03808df52f4b 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -801,6 +801,13 @@ config DMATEST
 	  Simple DMA test client. Say N unless you're debugging a
 	  DMA Device driver.
 
+config DMA_SLAVE
+	tristate "DMA Slave Test client"
+	depends on DMA_ENGINE
+	help
+	  Simple DMA Passthrough Slave test client. Say N unless you're
+	  debugging a DMA Device driver.
+
 config DMA_ENGINE_RAID
 	bool
 
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index a6535b2310bb..f52a2d525e8b 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_DMA_OF) += of-dma.o
 
 #dmatest
 obj-$(CONFIG_DMATEST) += dmatest.o
+obj-$(CONFIG_DMA_SLAVE) += dma-slave.o
 
 #devices
 obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
diff --git a/drivers/dma/dma-slave.c b/drivers/dma/dma-slave.c
new file mode 100644
index 000000000000..c8671ade2ef6
--- /dev/null
+++ b/drivers/dma/dma-slave.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2026 Alexander Gordeev <a.gordeev.box@gmail.com>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/miscdevice.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-direction.h>
+#include <linux/dma-mapping.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+#include <uapi/linux/dma-slave.h>
+
+static bool filter(struct dma_chan *chan, void *filter_param)
+{
+	const char *name = dma_chan_name(chan);
+
+	if (!name)
+		return false;
+	return !strcmp(name, (char *)filter_param);
+}
+
+static struct dma_chan *dma_slave_request_chan(char *channel_name)
+{
+	dma_filter_fn filter_fn = NULL;
+	struct dma_chan *chan;
+	dma_cap_mask_t mask;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_SLAVE, mask);
+
+	if (channel_name[0])
+		filter_fn = filter;
+	chan = dma_request_channel(mask, filter_fn, channel_name);
+	if (!chan)
+		return ERR_PTR(-ENODEV);
+
+	return chan;
+}
+
+static void dma_slave_release_chan(struct dma_chan *chan)
+{
+	dma_release_channel(chan);
+}
+
+static int dma_slave_setup_config(unsigned int cmd,
+				  struct dma_slave_config *cfg,
+				  struct dma_slave_config_uapi *ucfg,
+				  enum dma_data_direction *dir)
+{
+	if (!IS_ALIGNED((unsigned long)ucfg->data.iov_base, PAGE_SIZE))
+		return -EINVAL;
+	if (!ucfg->data.iov_len)
+		return -EINVAL;
+	if (strnlen(ucfg->channel_name, sizeof(ucfg->channel_name)) >= sizeof(ucfg->channel_name))
+		return -EINVAL;
+
+	if (ucfg->peripheral_config.iov_len) {
+		cfg->peripheral_config = kmalloc(ucfg->peripheral_config.iov_len, GFP_KERNEL);
+		if (!cfg->peripheral_config)
+			return -ENOMEM;
+		if (copy_from_user(cfg->peripheral_config,
+				   (void __user *)ucfg->peripheral_config.iov_base,
+				   ucfg->peripheral_config.iov_len)) {
+			kfree(cfg->peripheral_config);
+			return -EFAULT;
+		}
+		cfg->peripheral_size = ucfg->peripheral_config.iov_len;
+	}
+	if (cmd == IOCTL_DMA_SLAVE_READ) {
+		cfg->direction		= DMA_DEV_TO_MEM;
+		*dir			= DMA_FROM_DEVICE;
+	} else {
+		cfg->direction		= DMA_MEM_TO_DEV;
+		*dir			= DMA_TO_DEVICE;
+	}
+	cfg->src_addr			= ucfg->src_addr;
+	cfg->dst_addr			= ucfg->dst_addr;
+	cfg->src_addr_width		= ucfg->src_addr_width;
+	cfg->dst_addr_width		= ucfg->dst_addr_width;
+	cfg->src_maxburst		= ucfg->src_maxburst;
+	cfg->dst_maxburst		= ucfg->dst_maxburst;
+	cfg->src_port_window_size	= ucfg->src_port_window_size;
+	cfg->dst_port_window_size	= ucfg->dst_port_window_size;
+	cfg->device_fc			= ucfg->device_fc;
+
+	return 0;
+}
+
+static void dma_slave_teardown_config(struct dma_slave_config *cfg)
+{
+	kfree(cfg->peripheral_config);
+}
+
+static void dma_slave_callback(void *callback_param)
+{
+	complete((struct completion *)callback_param);
+}
+
+static long dma_slave_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct dma_async_tx_descriptor *desc;
+	struct dma_slave_config_uapi ucfg;
+	struct dma_slave_config cfg = {};
+	enum dma_data_direction dir;
+	struct page **pages;
+	unsigned long nr_pages;
+	struct dma_chan *chan;
+	struct sg_table sgt;
+	unsigned int foll;
+	dma_cookie_t tx;
+	struct completion completion;
+	long ret;
+	int i;
+
+	switch (cmd) {
+	case IOCTL_DMA_SLAVE_READ:
+	case IOCTL_DMA_SLAVE_WRITE:
+		if (copy_from_user(&ucfg, (void __user *)arg, sizeof(ucfg)))
+			return -EFAULT;
+
+		ret = dma_slave_setup_config(cmd, &cfg, &ucfg, &dir);
+		if (ret)
+			return ret;
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	chan = dma_slave_request_chan(ucfg.channel_name);
+	if (IS_ERR(chan)) {
+		ret = PTR_ERR(chan);
+		goto err_teardown_config;
+	}
+
+	ret = dmaengine_slave_config(chan, &cfg);
+	if (ret)
+		goto err_release_chan;
+
+	nr_pages = DIV_ROUND_UP(ucfg.data.iov_len, PAGE_SIZE);
+	pages = kmalloc_array(nr_pages, sizeof(pages[0]), GFP_KERNEL);
+	if (!pages) {
+		ret = -ENOMEM;
+		goto err_release_chan;
+	}
+
+	foll = 0;
+	if (cmd == IOCTL_DMA_SLAVE_READ)
+		foll |= FOLL_WRITE;
+	mmap_read_lock(current->mm);
+	ret = pin_user_pages((unsigned long)ucfg.data.iov_base, nr_pages, foll, pages);
+	if (ret < 0)
+		goto err_mmap_unlock;
+	if (ret != nr_pages) {
+		nr_pages = ret;
+		ret = -EFAULT;
+		goto err_unpin_pages;
+	}
+
+	ret = sg_alloc_table_from_pages(&sgt, pages, nr_pages, 0, ucfg.data.iov_len, GFP_KERNEL);
+	if (ret)
+		goto err_unpin_pages;
+
+	ret = dma_map_sgtable(chan->device->dev, &sgt, dir, 0);
+	if (ret)
+		goto err_free_sgt;
+
+	desc = dmaengine_prep_slave_sg(chan, sgt.sgl, sgt.nents, cfg.direction,
+				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto err_unmap_sgt;
+	}
+	init_completion(&completion);
+	desc->callback = dma_slave_callback;
+	desc->callback_param = &completion;
+
+	tx = dmaengine_submit(desc);
+	ret = dma_submit_error(tx);
+	if (ret < 0)
+		goto err_unmap_sgt;
+
+	dma_async_issue_pending(chan);
+
+	ret = wait_for_completion_interruptible(&completion);
+	if (ret)
+		goto err_term_sync;
+
+	if (dma_async_is_tx_complete(chan, tx, NULL, NULL) != DMA_COMPLETE) {
+		ret = -EIO;
+		goto err_term_sync;
+	}
+
+	if (cmd == IOCTL_DMA_SLAVE_READ) {
+		for (i = 0; i < nr_pages; i++)
+			set_page_dirty_lock(pages[i]);
+	}
+
+	goto err_unmap_sgt;
+
+err_term_sync:
+	dmaengine_terminate_sync(chan);
+err_unmap_sgt:
+	dma_unmap_sgtable(chan->device->dev, &sgt, dir, 0);
+err_free_sgt:
+	sg_free_table(&sgt);
+err_unpin_pages:
+	unpin_user_pages(pages, nr_pages);
+err_mmap_unlock:
+	mmap_read_unlock(current->mm);
+	kfree(pages);
+err_release_chan:
+	dma_slave_release_chan(chan);
+err_teardown_config:
+	dma_slave_teardown_config(&cfg);
+
+	return ret;
+}
+
+static const struct file_operations dma_slave_fops = {
+	.owner		= THIS_MODULE,
+	.unlocked_ioctl	= dma_slave_ioctl,
+};
+
+struct miscdevice misc_dev = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= DMA_SLAVE_DEVICE,
+	.nodename	= DMA_SLAVE_DEVICE,
+	.fops		= &dma_slave_fops,
+	.mode		= 0600,
+};
+
+static int __init dma_slave_init(void)
+{
+	return misc_register(&misc_dev);
+}
+late_initcall(dma_slave_init);
+
+static void __exit dma_slave_exit(void)
+{
+	misc_deregister(&misc_dev);
+}
+module_exit(dma_slave_exit);
+
+MODULE_AUTHOR("Alexander Gordeev <a.gordeev.box@gmail.com>");
+MODULE_DESCRIPTION("DMA slave passthrough driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/dma-slave.h b/include/uapi/linux/dma-slave.h
new file mode 100644
index 000000000000..e3da14d4224e
--- /dev/null
+++ b/include/uapi/linux/dma-slave.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (C) 2026 Alexander Gordeev <a.gordeev.box@gmail.com>
+ */
+#ifndef _UAPI_LINUX_DMA_SLAVE_H__
+#define _UAPI_LINUX_DMA_SLAVE_H__
+
+#define DMA_SLAVE_DEVICE		"dma-slave"
+
+struct dma_slave_config_uapi {
+	struct iovec data;
+	struct iovec peripheral_config;
+	__u64 src_addr;
+	__u64 dst_addr;
+	__u32 src_addr_width;
+	__u32 dst_addr_width;
+	__u32 src_maxburst;
+	__u32 dst_maxburst;
+	__u32 src_port_window_size;
+	__u32 dst_port_window_size;
+	bool device_fc;
+	char channel_name[32];
+};
+
+#define DMA_SLAVE_SIG 'S'
+
+#define IOCTL_DMA_SLAVE_READ		_IOR(DMA_SLAVE_SIG, 0, struct dma_slave_config_uapi)
+#define IOCTL_DMA_SLAVE_WRITE		_IOW(DMA_SLAVE_SIG, 1, struct dma_slave_config_uapi)
+
+#endif
-- 
2.51.0


