Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AAC78B5CF
	for <lists+dmaengine@lfdr.de>; Mon, 28 Aug 2023 19:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbjH1RBD (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 28 Aug 2023 13:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjH1RAb (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 28 Aug 2023 13:00:31 -0400
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05E1AD;
        Mon, 28 Aug 2023 10:00:19 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1693242017; bh=yHYMn8VwEhZ/a8WcphAnVJ8O+OeZOYbwP+w67RCAmoI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Mq0CCjTxBwjyFsoeW3Ad+P8/D/BMiGrjZJEHK+ifPDBWx5RnAdPUY5gVZ0NydELx+
         R1bcZWBJEPSkHk3dAreKJdG8+2ZZgFvCoHuXf6Sw+xUSBHsj3lqly4wRLsUT69Pp3h
         SsvuO3hddNB0PahetQNSoR5a7z+86MH3Jj5uoFs4=
To:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     asahi@lists.linux.dev, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] dmaengine: apple-sio: Add Apple SIO driver
Date:   Mon, 28 Aug 2023 19:00:13 +0200
Message-Id: <20230828170013.75820-3-povik+lin@cutebit.org>
In-Reply-To: <20230828170013.75820-1-povik+lin@cutebit.org>
References: <20230828170013.75820-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add a dmaengine driver for the Apple SIO coprocessor found on Apple
SoCs where it provides DMA services. Have the driver support cyclic
transactions so that ALSA drivers can rely on it in audio output to
HDMI and DisplayPort.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 MAINTAINERS             |   2 +
 drivers/dma/Kconfig     |  11 +
 drivers/dma/Makefile    |   1 +
 drivers/dma/apple-sio.c | 868 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 882 insertions(+)
 create mode 100644 drivers/dma/apple-sio.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3be1bdfe8ecc..e65cf3d535ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1865,7 +1865,9 @@ M:	Martin Povišer <povik+lin@cutebit.org>
 L:	asahi@lists.linux.dev
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Maintained
+F:	Documentation/devicetree/bindings/dma/apple,sio.yaml
 F:	Documentation/devicetree/bindings/sound/apple,*
+F:	drivers/dma/apple-sio.c
 F:	sound/soc/apple/*
 F:	sound/soc/codecs/cs42l83-i2c.c
 
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f52d36e713f3..6e385dee2d3d 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -89,10 +89,21 @@ config APPLE_ADMAC
 	tristate "Apple ADMAC support"
 	depends on ARCH_APPLE || COMPILE_TEST
 	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
 	default ARCH_APPLE
 	help
 	  Enable support for Audio DMA Controller found on Apple Silicon SoCs.
 
+config APPLE_SIO
+	tristate "Apple SIO support"
+	depends on ARCH_APPLE || COMPILE_TEST
+	depends on APPLE_RTKIT
+	select DMA_ENGINE
+	default ARCH_APPLE
+	help
+	  Enable support for the SIO coprocessor found on Apple Silicon SoCs
+	  where it provides DMA services.
+
 config AT_HDMAC
 	tristate "Atmel AHB DMA support"
 	depends on ARCH_AT91
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 83553a97a010..787583ff2d45 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
 obj-$(CONFIG_AMD_PTDMA) += ptdma/
 obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
+obj-$(CONFIG_APPLE_SIO) += apple-sio.o
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
 obj-$(CONFIG_AT_XDMAC) += at_xdmac.o
 obj-$(CONFIG_AXI_DMAC) += dma-axi-dmac.o
diff --git a/drivers/dma/apple-sio.c b/drivers/dma/apple-sio.c
new file mode 100644
index 000000000000..e15deeded4dc
--- /dev/null
+++ b/drivers/dma/apple-sio.c
@@ -0,0 +1,868 @@
+// SPDX-License-Identifier: GPL-2.0-only OR MIT
+/*
+ * Driver for SIO coprocessor on t8103 (M1) and other Apple SoCs
+ *
+ * Copyright (C) The Asahi Linux Contributors
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/completion.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of_dma.h>
+#include <linux/soc/apple/rtkit.h>
+
+#include "dmaengine.h"
+#include "virt-dma.h"
+
+#define NCHANNELS_MAX	0x80
+
+#define REG_CPU_CONTROL	0x44
+#define CPU_CONTROL_RUN BIT(4)
+
+#define SIOMSG_DATA	GENMASK(63, 32)
+#define SIOMSG_TYPE	GENMASK(23, 16)
+#define SIOMSG_PARAM	GENMASK(31, 24)
+#define SIOMSG_TAG	GENMASK(13, 8)
+#define SIOMSG_EP	GENMASK(7, 0)
+
+#define EP_SIO		0x20
+
+#define MSG_START	0x2
+#define MSG_SETUP	0x3
+#define MSG_CONFIGURE	0x5
+#define MSG_ISSUE	0x6
+#define MSG_TERMINATE	0x8
+#define MSG_ACK		0x65
+#define MSG_NACK	0x66
+#define MSG_STARTED	0x67
+#define MSG_REPORT	0x68
+
+#define SIO_CALL_TIMEOUT_MS	100
+#define SIO_SHMEM_SIZE		0x1000
+#define SIO_NO_DESC_SLOTS	64
+
+/*
+ * There are two kinds of 'transaction descriptors' in play here.
+ *
+ * There's the struct sio_tx, and the struct dma_async_tx_descriptor embedded
+ * inside, which jointly represent a transaction to the dmaengine subsystem.
+ * At this time we only support those transactions to be cyclic.
+ *
+ * Then there are the coprocessor descriptors, which is what the coprocessor
+ * knows and understands. These don't seem to have a cyclic regime, so we can't
+ * map the dmaengine transaction on an exact coprocessor counterpart. Instead
+ * we continually queue up many coprocessor descriptors to implement a cyclic
+ * transaction.
+ *
+ * The number below is the maximum of how far ahead (how many) coprocessor
+ * descriptors we should be queuing up, per channel, for a cyclic transaction.
+ * Basically it's a made-up number.
+ */
+#define SIO_MAX_NINFLIGHT	4
+
+struct sio_coproc_desc {
+	u32 pad1;
+	u32 flag;
+	u64 unk;
+	u64 iova;
+	u64 size;
+	u64 pad2;
+	u64 pad3;
+} __packed;
+static_assert(sizeof(struct sio_coproc_desc) == 48);
+
+struct sio_shmem_chan_config {
+	u32 datashape;
+	u32 timeout;
+	u32 fifo;
+	u32 threshold;
+	u32 limit;
+} __packed;
+
+struct sio_data;
+struct sio_tx;
+
+struct sio_chan {
+	unsigned int no;
+	struct sio_data *host;
+	struct virt_dma_chan vc;
+	struct work_struct terminate_wq;
+
+	struct sio_tx *current_tx;
+};
+
+#define SIO_NTAGS		16
+
+typedef void (*sio_ack_callback)(struct sio_chan *, void *, bool);
+
+struct sio_data {
+	void __iomem *base;
+	struct dma_device dma;
+	struct device *dev;
+	struct apple_rtkit *rtk;
+	void *shmem;
+	struct sio_coproc_desc *shmem_desc_base;
+	unsigned long *desc_allocated;
+
+	struct sio_tagdata {
+		DECLARE_BITMAP(allocated, SIO_NTAGS);
+		int last_tag;
+
+		struct completion completions[SIO_NTAGS];
+		bool atomic[SIO_NTAGS];
+		bool acked[SIO_NTAGS];
+
+		sio_ack_callback ack_callback[SIO_NTAGS];
+		void *cookie[SIO_NTAGS];
+	} tags;
+
+	int nchannels;
+	struct sio_chan channels[];
+};
+
+struct sio_tx {
+	struct virt_dma_desc vd;
+	struct completion done;
+
+	bool terminated;
+	size_t period_len;
+	int nperiods;
+	int ninflight;
+	int next;
+
+	struct sio_coproc_desc *siodesc[];
+};
+
+static int sio_send_siomsg(struct sio_data *sio, u64 msg);
+static int sio_send_siomsg_atomic(struct sio_data *sio, u64 msg,
+				  sio_ack_callback ack_callback,
+				  void *cookie);
+static int sio_call(struct sio_data *sio, u64 msg);
+
+static struct sio_chan *to_sio_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct sio_chan, vc.chan);
+}
+
+static struct sio_tx *to_sio_tx(struct dma_async_tx_descriptor *tx)
+{
+	return container_of(tx, struct sio_tx, vd.tx);
+}
+
+static int sio_alloc_tag(struct sio_data *sio)
+{
+	struct sio_tagdata *tags = &sio->tags;
+	int tag, i;
+
+	/*
+	 * Because tag number 0 is special, the usable tag range
+	 * is 1...(SIO_NTAGS - 1). So, to pick the next usable tag,
+	 * we do modulo (SIO_NTAGS - 1) *then* plus one.
+	 */
+
+#define SIO_USABLE_TAGS (SIO_NTAGS - 1)
+	tag = (READ_ONCE(tags->last_tag) % SIO_USABLE_TAGS) + 1;
+
+	for (i = 0; i < SIO_USABLE_TAGS; i++) {
+		if (!test_and_set_bit(tag, tags->allocated))
+			break;
+
+		tag = (tag % SIO_USABLE_TAGS) + 1;
+	}
+
+	WRITE_ONCE(tags->last_tag, tag);
+
+	if (i < SIO_USABLE_TAGS)
+		return tag;
+	else
+		return -EBUSY;
+#undef SIO_USABLE_TAGS
+}
+
+static void sio_free_tag(struct sio_data *sio, int tag)
+{
+	struct sio_tagdata *tags = &sio->tags;
+
+	if (WARN_ON(tag >= SIO_NTAGS))
+		return;
+
+	tags->atomic[tag] = false;
+	tags->ack_callback[tag] = NULL;
+
+	WARN_ON(!test_and_clear_bit(tag, tags->allocated));
+}
+
+static void sio_set_tag_atomic(struct sio_data *sio, int tag,
+			       sio_ack_callback ack_callback,
+			       void *cookie)
+{
+	struct sio_tagdata *tags = &sio->tags;
+
+	tags->atomic[tag] = true;
+	tags->ack_callback[tag] = ack_callback;
+	tags->cookie[tag] = cookie;
+}
+
+static struct sio_coproc_desc *sio_alloc_desc(struct sio_data *sio)
+{
+	int i;
+
+	for (i = 0; i < SIO_NO_DESC_SLOTS; i++)
+		if (!test_and_set_bit(i, sio->desc_allocated))
+			return sio->shmem_desc_base + i;
+
+	return NULL;
+}
+
+static void sio_free_desc(struct sio_data *sio, struct sio_coproc_desc *desc)
+{
+	clear_bit(desc - sio->shmem_desc_base, sio->desc_allocated);
+}
+
+static int sio_coproc_desc_slot(struct sio_data *sio, struct sio_coproc_desc *desc)
+{
+	return (desc - sio->shmem_desc_base) * 4;
+}
+
+static enum dma_transfer_direction sio_chan_direction(int channo)
+{
+	/* Channel directions are fixed based on channel number */
+	return (channo & 1) ? DMA_DEV_TO_MEM : DMA_MEM_TO_DEV;
+}
+
+static void sio_tx_free(struct virt_dma_desc *vd)
+{
+	struct sio_data *sio = to_sio_chan(vd->tx.chan)->host;
+	struct sio_tx *siotx = to_sio_tx(&vd->tx);
+	int i;
+
+	for (i = 0; i < siotx->nperiods; i++)
+		if (siotx->siodesc[i])
+			sio_free_desc(sio, siotx->siodesc[i]);
+	kfree(siotx);
+}
+
+static struct dma_async_tx_descriptor *sio_prep_dma_cyclic(
+		struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
+		size_t period_len, enum dma_transfer_direction direction,
+		unsigned long flags)
+{
+	struct sio_chan *siochan = to_sio_chan(chan);
+	struct sio_tx *siotx = NULL;
+	int i, nperiods = buf_len / period_len;
+
+	if (direction != sio_chan_direction(siochan->no))
+		return NULL;
+
+	siotx = kzalloc(struct_size(siotx, siodesc, nperiods), GFP_NOWAIT);
+	if (!siotx)
+		return NULL;
+
+	init_completion(&siotx->done);
+	siotx->period_len = period_len;
+	siotx->nperiods = nperiods;
+
+	for (i = 0; i < nperiods; i++) {
+		struct sio_coproc_desc *d;
+
+		siotx->siodesc[i] = d = sio_alloc_desc(siochan->host);
+		if (!d) {
+			sio_tx_free(&siotx->vd);
+			return NULL;
+		}
+
+		d->flag = 1; // not sure what's up with this
+		d->iova = buf_addr + period_len * i;
+		d->size = period_len;
+	}
+	dma_wmb();
+
+	return vchan_tx_prep(&siochan->vc, &siotx->vd, flags);
+}
+
+static enum dma_status sio_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
+				     struct dma_tx_state *txstate)
+{
+	struct sio_chan *siochan = to_sio_chan(chan);
+	struct virt_dma_desc *vd;
+	struct sio_tx *siotx;
+	enum dma_status ret;
+	unsigned long flags;
+	int periods_residue;
+	size_t residue;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&siochan->vc.lock, flags);
+	siotx = siochan->current_tx;
+
+	if (siotx && siotx->vd.tx.cookie == cookie) {
+		ret = DMA_IN_PROGRESS;
+		periods_residue = siotx->next - siotx->ninflight;
+		while (periods_residue < 0)
+			periods_residue += siotx->nperiods;
+		residue = (siotx->nperiods - periods_residue) * siotx->period_len;
+	} else {
+		ret = DMA_IN_PROGRESS;
+		residue = 0;
+		vd = vchan_find_desc(&siochan->vc, cookie);
+		if (vd) {
+			siotx = to_sio_tx(&vd->tx);
+			residue = siotx->period_len * siotx->nperiods;
+		}
+	}
+	spin_unlock_irqrestore(&siochan->vc.lock, flags);
+	dma_set_residue(txstate, residue);
+
+	return ret;
+}
+
+static bool sio_fill_in_locked(struct sio_chan *siochan);
+
+static void sio_handle_issue_ack(struct sio_chan *siochan, void *cookie, bool ok)
+{
+	unsigned long flags;
+	dma_cookie_t tx_cookie = (unsigned long) cookie;
+	struct sio_tx *tx;
+
+	if (!ok) {
+		dev_err(siochan->host->dev, "nacked issue on chan %d\n", siochan->no);
+		return;
+	}
+
+	spin_lock_irqsave(&siochan->vc.lock, flags);
+	if (!siochan->current_tx || tx_cookie != siochan->current_tx->vd.tx.cookie ||
+			siochan->current_tx->terminated)
+		goto out;
+
+	tx = siochan->current_tx;
+	tx->next = (tx->next + 1) % tx->nperiods;
+	tx->ninflight++;
+	sio_fill_in_locked(siochan);
+
+out:
+	spin_unlock_irqrestore(&siochan->vc.lock, flags);
+}
+
+static bool sio_fill_in_locked(struct sio_chan *siochan)
+{
+	struct sio_data *sio = siochan->host;
+	struct sio_tx *tx = siochan->current_tx;
+	struct sio_coproc_desc *d = tx->siodesc[tx->next];
+	int ret;
+
+	if (tx->ninflight >= SIO_MAX_NINFLIGHT || tx->terminated)
+		return false;
+
+	static_assert(sizeof(dma_cookie_t) <= sizeof(void *));
+	ret = sio_send_siomsg_atomic(sio, FIELD_PREP(SIOMSG_EP, siochan->no) |
+				     FIELD_PREP(SIOMSG_TYPE, MSG_ISSUE) |
+				     FIELD_PREP(SIOMSG_DATA, sio_coproc_desc_slot(sio, d)),
+				     sio_handle_issue_ack, (void *) (uintptr_t) tx->vd.tx.cookie);
+	if (ret < 0)
+		dev_err_ratelimited(sio->dev, "can't issue on chan %d ninflight %d: %d\n",
+				    siochan->no, tx->ninflight, ret);
+	return true;
+}
+
+static void sio_update_current_tx_locked(struct sio_chan *siochan)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&siochan->vc);
+
+	if (vd && !siochan->current_tx) {
+		list_del(&vd->node);
+		siochan->current_tx = to_sio_tx(&vd->tx);
+		sio_fill_in_locked(siochan);
+	}
+}
+
+static void sio_issue_pending(struct dma_chan *chan)
+{
+	struct sio_chan *siochan = to_sio_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&siochan->vc.lock, flags);
+	vchan_issue_pending(&siochan->vc);
+	sio_update_current_tx_locked(siochan);
+	spin_unlock_irqrestore(&siochan->vc.lock, flags);
+}
+
+static int sio_terminate_all(struct dma_chan *chan)
+{
+	struct sio_chan *siochan = to_sio_chan(chan);
+	unsigned long flags;
+	LIST_HEAD(to_free);
+
+	spin_lock_irqsave(&siochan->vc.lock, flags);
+	if (siochan->current_tx && !siochan->current_tx->terminated) {
+		dma_cookie_complete(&siochan->current_tx->vd.tx);
+		siochan->current_tx->terminated = true;
+		schedule_work(&siochan->terminate_wq);
+	}
+	vchan_get_all_descriptors(&siochan->vc, &to_free);
+	spin_unlock_irqrestore(&siochan->vc.lock, flags);
+
+	vchan_dma_desc_free_list(&siochan->vc, &to_free);
+
+	return 0;
+}
+
+static void sio_terminate_work(struct work_struct *wq)
+{
+	struct sio_chan *siochan = container_of(wq, struct sio_chan, terminate_wq);
+	struct sio_tx *tx;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&siochan->vc.lock, flags);
+	tx = siochan->current_tx;
+	spin_unlock_irqrestore(&siochan->vc.lock, flags);
+
+	if (WARN_ON(!tx))
+		return;
+
+	ret = sio_call(siochan->host, FIELD_PREP(SIOMSG_EP, siochan->no) |
+				      FIELD_PREP(SIOMSG_TYPE, MSG_TERMINATE));
+	if (ret < 0)
+		dev_err(siochan->host->dev, "terminate call on chan %d failed: %d\n",
+			siochan->no, ret);
+
+	ret = wait_for_completion_timeout(&tx->done, msecs_to_jiffies(500));
+	if (!ret)
+		dev_err(siochan->host->dev, "terminate descriptor wait timed out\n");
+
+	tasklet_kill(&siochan->vc.task);
+
+	spin_lock_irqsave(&siochan->vc.lock, flags);
+	WARN_ON(siochan->current_tx != tx);
+	siochan->current_tx = NULL;
+	sio_update_current_tx_locked(siochan);
+	spin_unlock_irqrestore(&siochan->vc.lock, flags);
+
+	sio_tx_free(&tx->vd);
+}
+
+static void sio_synchronize(struct dma_chan *chan)
+{
+	struct sio_chan *siochan = to_sio_chan(chan);
+
+	flush_work(&siochan->terminate_wq);
+}
+
+static void sio_free_chan_resources(struct dma_chan *chan)
+{
+	sio_terminate_all(chan);
+	sio_synchronize(chan);
+	vchan_free_chan_resources(&to_sio_chan(chan)->vc);
+}
+
+static struct dma_chan *sio_dma_of_xlate(struct of_phandle_args *dma_spec,
+					 struct of_dma *ofdma)
+{
+	struct sio_data *sio = (struct sio_data *) ofdma->of_dma_data;
+	unsigned int index = dma_spec->args[0];
+
+	if (dma_spec->args_count != 1 || index >= sio->nchannels)
+		return ERR_PTR(-EINVAL);
+
+	return dma_get_slave_channel(&sio->channels[index].vc.chan);
+}
+
+static void sio_rtk_crashed(void *cookie)
+{
+	struct sio_data *sio = cookie;
+
+	dev_err(sio->dev, "SIO down (crashed)");
+}
+
+static void sio_process_report(struct sio_chan *siochan)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&siochan->vc.lock, flags);
+	if (siochan->current_tx) {
+		struct sio_tx *tx = siochan->current_tx;
+
+		if (tx->ninflight)
+			tx->ninflight--;
+		vchan_cyclic_callback(&tx->vd);
+		if (!sio_fill_in_locked(siochan) && !tx->ninflight)
+			complete(&tx->done);
+	}
+	spin_unlock_irqrestore(&siochan->vc.lock, flags);
+}
+
+static void sio_recv_msg(void *cookie, u8 ep, u64 msg)
+{
+	struct sio_data *sio = cookie;
+	struct sio_tagdata *tags = &sio->tags;
+	u32 data;
+	u8 param, type, tag, sioep;
+
+	if (ep != EP_SIO)
+		goto unknown;
+
+	data  = FIELD_GET(SIOMSG_DATA, msg);
+	param = FIELD_GET(SIOMSG_PARAM, msg);
+	type  = FIELD_GET(SIOMSG_TYPE, msg);
+	tag   = FIELD_GET(SIOMSG_TAG, msg);
+	sioep = FIELD_GET(SIOMSG_EP, msg);
+
+	switch (type) {
+	case MSG_STARTED:
+		dev_info(sio->dev, "SIO protocol v%u\n", data);
+		type = MSG_ACK; /* Pretend this is an ACK */
+		fallthrough;
+	case MSG_ACK:
+	case MSG_NACK:
+		if (WARN_ON(tag >= SIO_NTAGS))
+			break;
+
+		if (tags->atomic[tag]) {
+			sio_ack_callback callback = tags->ack_callback[tag];
+
+			if (callback && !WARN_ON(sioep >= sio->nchannels))
+				callback(&sio->channels[sioep],
+					 tags->cookie[tag], type == MSG_ACK);
+			if (type == MSG_NACK)
+				dev_err(sio->dev, "got a NACK on channel %d\n", sioep);
+			sio_free_tag(sio, tag);
+		} else {
+			tags->acked[tag] = (type == MSG_ACK);
+			complete(&tags->completions[tag]);
+		}
+		break;
+
+	case MSG_REPORT:
+		if (WARN_ON(sioep >= sio->nchannels))
+			break;
+
+		sio_process_report(&sio->channels[sioep]);
+		break;
+
+	default:
+		goto unknown;
+	}
+	return;
+
+unknown:
+	dev_warn(sio->dev, "received unknown message: ep %x data %016llx\n",
+		 ep, msg);
+}
+
+static int _sio_send_siomsg(struct sio_data *sio, u64 msg, bool atomic,
+			    sio_ack_callback ack_callback, void *cookie)
+{
+	int tag, ret;
+
+	tag = sio_alloc_tag(sio);
+	if (tag < 0)
+		return tag;
+
+	if (atomic)
+		sio_set_tag_atomic(sio, tag, ack_callback, cookie);
+	else
+		reinit_completion(&sio->tags.completions[tag]);
+
+	msg &= ~SIOMSG_TAG;
+	msg |= FIELD_PREP(SIOMSG_TAG, tag);
+	ret = apple_rtkit_send_message(sio->rtk, EP_SIO, msg, NULL,
+				       atomic);
+	if (ret < 0) {
+		sio_free_tag(sio, tag);
+		return ret;
+	}
+
+	return tag;
+}
+
+static int sio_send_siomsg(struct sio_data *sio, u64 msg)
+{
+	return _sio_send_siomsg(sio, msg, false, NULL, NULL);
+}
+
+static int sio_send_siomsg_atomic(struct sio_data *sio, u64 msg,
+				  sio_ack_callback ack_callback,
+				  void *cookie)
+{
+	return _sio_send_siomsg(sio, msg, true, ack_callback, cookie);
+}
+
+static int sio_call(struct sio_data *sio, u64 msg)
+{
+	int tag, ret;
+
+	tag = sio_send_siomsg(sio, msg);
+	if (tag < 0)
+		return tag;
+
+	ret = wait_for_completion_timeout(&sio->tags.completions[tag],
+					  msecs_to_jiffies(SIO_CALL_TIMEOUT_MS));
+	if (!ret) {
+		dev_warn(sio->dev, "call %8x timed out\n", msg);
+		sio_free_tag(sio, tag);
+		return -ETIME;
+	}
+
+	ret = sio->tags.acked[tag];
+	sio_free_tag(sio, tag);
+
+	return ret;
+}
+
+static const struct apple_rtkit_ops sio_rtkit_ops = {
+	.crashed = sio_rtk_crashed,
+	.recv_message = sio_recv_msg,
+};
+
+static int sio_device_config(struct dma_chan *chan,
+			     struct dma_slave_config *config)
+{
+	struct sio_chan *siochan = to_sio_chan(chan);
+	struct sio_data *sio = siochan->host;
+	bool is_tx = sio_chan_direction(siochan->no) == DMA_MEM_TO_DEV;
+	struct sio_shmem_chan_config *cfg = sio->shmem;
+	int ret;
+
+	switch (is_tx ? config->dst_addr_width : config->src_addr_width) {
+	case DMA_SLAVE_BUSWIDTH_1_BYTE:
+		cfg->datashape = 0;
+		break;
+	case DMA_SLAVE_BUSWIDTH_2_BYTES:
+		cfg->datashape = 1;
+		break;
+	case DMA_SLAVE_BUSWIDTH_4_BYTES:
+		cfg->datashape = 2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cfg->fifo = 0x800;
+	cfg->limit = 0x800;
+	cfg->threshold = 0x800;
+	dma_wmb();
+
+	ret = sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_CONFIGURE) |
+			    FIELD_PREP(SIOMSG_EP, siochan->no));
+
+	if (ret == 1)
+		ret = 0;
+	else if (ret == 0)
+		ret = -EINVAL;
+	return ret;
+}
+
+static int sio_alloc_shmem(struct sio_data *sio)
+{
+	dma_addr_t iova;
+	int err;
+
+	sio->shmem = dma_alloc_coherent(sio->dev, SIO_SHMEM_SIZE,
+					&iova, GFP_KERNEL);
+	if (!sio->shmem)
+		return -ENOMEM;
+
+	sio->shmem_desc_base = (struct sio_coproc_desc *) (sio->shmem + 56);
+	sio->desc_allocated = devm_kzalloc(sio->dev, SIO_NO_DESC_SLOTS / 32,
+					   GFP_KERNEL);
+	if (!sio->desc_allocated)
+		return -ENOMEM;
+
+	err = sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_SETUP) |
+			    FIELD_PREP(SIOMSG_PARAM, 1) |
+			    FIELD_PREP(SIOMSG_DATA, iova >> 12));
+	if (err != 1) {
+		if (err == 0)
+			err = -EINVAL;
+		return err;
+	}
+
+	err = sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_SETUP) |
+			    FIELD_PREP(SIOMSG_PARAM, 2) |
+			    FIELD_PREP(SIOMSG_DATA, SIO_SHMEM_SIZE));
+	if (err != 1) {
+		if (err == 0)
+			err = -EINVAL;
+		return err;
+	}
+
+	return 0;
+}
+
+static int sio_send_dt_params(struct sio_data *sio)
+{
+	struct device_node *np = sio->dev->of_node;
+	const char *propname = "apple,sio-firmware-params";
+	int nparams, err, i;
+
+	nparams = of_property_count_u32_elems(np, propname);
+	if (nparams < 0) {
+		err = nparams;
+		goto badprop;
+	}
+
+	for (i = 0; i < nparams / 2; i++) {
+		u32 key, val;
+
+		err = of_property_read_u32_index(np, propname, 2 * i, &key);
+		if (err)
+			goto badprop;
+		err = of_property_read_u32_index(np, propname, 2 * i + 1, &val);
+		if (err)
+			goto badprop;
+
+		err = sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_SETUP) |
+				    FIELD_PREP(SIOMSG_PARAM, key & 0xff) |
+				    FIELD_PREP(SIOMSG_EP, key >> 8) |
+				    FIELD_PREP(SIOMSG_DATA, val));
+		if (err < 1) {
+			if (err == 0)
+				err = -ENXIO;
+			return dev_err_probe(sio->dev, err, "sending SIO parameter %#x value %#x\n",
+					     key, val);
+		}
+	}
+
+	return 0;
+
+badprop:
+	return dev_err_probe(sio->dev, err, "failed to read '%s'\n", propname);
+}
+
+static int sio_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct sio_data *sio;
+	struct dma_device *dma;
+	int nchannels;
+	int err, i;
+
+	err = of_property_read_u32(np, "dma-channels", &nchannels);
+	if (err || nchannels > NCHANNELS_MAX)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "missing or invalid dma-channels property\n");
+
+	sio = devm_kzalloc(&pdev->dev, struct_size(sio, channels, nchannels), GFP_KERNEL);
+	if (!sio)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, sio);
+	sio->dev = &pdev->dev;
+	sio->nchannels = nchannels;
+
+	sio->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(sio->base))
+		return PTR_ERR(sio->base);
+
+	sio->rtk = devm_apple_rtkit_init(&pdev->dev, sio, NULL, 0, &sio_rtkit_ops);
+	if (IS_ERR(sio->rtk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(sio->rtk),
+				     "couldn't initialize rtkit\n");
+	for (i = 1; i < SIO_NTAGS; i++)
+		init_completion(&sio->tags.completions[i]);
+
+	dma = &sio->dma;
+	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
+	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
+
+	dma->dev = &pdev->dev;
+	dma->device_free_chan_resources = sio_free_chan_resources;
+	dma->device_tx_status = sio_tx_status;
+	dma->device_issue_pending = sio_issue_pending;
+	dma->device_terminate_all = sio_terminate_all;
+	dma->device_synchronize = sio_synchronize;
+	dma->device_prep_dma_cyclic = sio_prep_dma_cyclic;
+	dma->device_config = sio_device_config;
+
+	dma->directions = BIT(DMA_MEM_TO_DEV);
+	dma->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
+	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
+			       BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
+			       BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+
+	INIT_LIST_HEAD(&dma->channels);
+	for (i = 0; i < nchannels; i++) {
+		struct sio_chan *siochan = &sio->channels[i];
+
+		siochan->host = sio;
+		siochan->no = i;
+		siochan->vc.desc_free = sio_tx_free;
+		INIT_WORK(&siochan->terminate_wq, sio_terminate_work);
+		vchan_init(&siochan->vc, dma);
+	}
+
+	writel(CPU_CONTROL_RUN, sio->base + REG_CPU_CONTROL);
+
+	err = apple_rtkit_boot(sio->rtk);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "SIO did not boot\n");
+
+	err = apple_rtkit_start_ep(sio->rtk, EP_SIO);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "starting SIO endpoint\n");
+
+	err = sio_call(sio, FIELD_PREP(SIOMSG_TYPE, MSG_START));
+	if (err < 1) {
+		if (err == 0)
+			err = -ENXIO;
+		return dev_err_probe(&pdev->dev, err, "starting SIO service\n");
+	}
+
+	err = sio_send_dt_params(sio);
+	if (err < 0)
+		return dev_err_probe(&pdev->dev, err, "failed to send boot-up parameters\n");
+
+	err = sio_alloc_shmem(sio);
+	if (err < 0)
+		return err;
+
+	err = dma_async_device_register(&sio->dma);
+	if (err)
+		return dev_err_probe(&pdev->dev, err, "failed to register DMA device\n");
+
+	err = of_dma_controller_register(pdev->dev.of_node, sio_dma_of_xlate, sio);
+	if (err) {
+		dma_async_device_unregister(&sio->dma);
+		return dev_err_probe(&pdev->dev, err, "failed to register with OF\n");
+	}
+
+	return 0;
+}
+
+static int sio_remove(struct platform_device *pdev)
+{
+	struct sio_data *sio = platform_get_drvdata(pdev);
+
+	of_dma_controller_free(pdev->dev.of_node);
+	dma_async_device_unregister(&sio->dma);
+	return 0;
+}
+
+static const struct of_device_id sio_of_match[] = {
+	{ .compatible = "apple,sio", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sio_of_match);
+
+static struct platform_driver apple_sio_driver = {
+	.driver = {
+		.name = "apple-sio",
+		.of_match_table = sio_of_match,
+	},
+	.probe = sio_probe,
+	.remove = sio_remove,
+};
+module_platform_driver(apple_sio_driver);
+
+MODULE_AUTHOR("Martin Povišer <povik+lin@cutebit.org>");
+MODULE_DESCRIPTION("Driver for SIO coprocessor on Apple SoCs");
+MODULE_LICENSE("Dual MIT/GPL");
-- 
2.38.3

