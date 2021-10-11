Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36810429282
	for <lists+dmaengine@lfdr.de>; Mon, 11 Oct 2021 16:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhJKOuK (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Mon, 11 Oct 2021 10:50:10 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([81.169.146.172]:15079 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237241AbhJKOuI (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Mon, 11 Oct 2021 10:50:08 -0400
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Mon, 11 Oct 2021 10:50:07 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1633963330;
    s=strato-dkim-0002; d=gerhold.net;
    h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=UzqLq5X+NdJ3nfVnD7Tp1tpkMdNwmA2nVPh71ioKI6M=;
    b=dtsiQ91FeNo7zX7up6RXtiUV2CJ5Qsd77UiQuBtU2SuNnsPz5+STRLnCItXMisiXgN
    VDT9o+5AxEe81u0asXJuNvHewNg8aVPCzd7R5SKSS4VfQ0BXe51qRm7rrnjL4D0MzUaq
    mWDPsGeb9pPvtV06R9lH24ZlEDNasVToZpvAJcdR0fXCdDG+7WFMqS48E62quwPSutPe
    0Xi2oVFMHTadxFsxn6HlwkLcyohbPCEnL+P0pEhtVdxJ5PJwA4UDUT4cCJ0iz5aG8D2K
    Mn0+5lXmELztJGzzNugFMZjxj+HhaN6Kh6K1i5KEsmhAd6gSV144/EMfmsE/vqWz5X3k
    9EvQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXTbAOHjRHIhr3eFeIrw=="
X-RZG-CLASS-ID: mo00
Received: from droid..
    by smtp.strato.de (RZmta 47.33.8 SBL|AUTH)
    with ESMTPSA id 301038x9BEg9tvA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Oct 2021 16:42:09 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Aleksander Morgado <aleksander@aleksander.es>,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH net-next v2 4/4] net: wwan: Add Qualcomm BAM-DMUX WWAN network driver
Date:   Mon, 11 Oct 2021 16:17:36 +0200
Message-Id: <20211011141733.3999-5-stephan@gerhold.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211011141733.3999-1-stephan@gerhold.net>
References: <20211011141733.3999-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The BAM Data Multiplexer provides access to the network data channels of
modems integrated into many older Qualcomm SoCs, e.g. Qualcomm MSM8916 or
MSM8974. It is built using a simple protocol layer on top of a DMA engine
(Qualcomm BAM) and bidirectional interrupts to coordinate power control.

The modem announces a fixed set of channels by sending an OPEN command.
The driver exports each channel as separate network interface so that
a connection can be established via QMI from userspace. The network
interface can work either in Ethernet or Raw-IP mode (configurable via
QMI). However, Ethernet mode seems to be broken with most firmwares
(network packets are actually received as Raw-IP), therefore the driver
only supports Raw-IP mode.

Note that the control channel (QMI/AT) is entirely separate from
BAM-DMUX and is already supported by the RPMSG_WWAN_CTRL driver.

The driver uses runtime PM to coordinate power control with the modem.
TX/RX buffers are put in a kind of "ring queue" and submitted via
the bam_dma driver of the DMAEngine subsystem.

The basic architecture looks roughly like this:

                   +------------+                +-------+
         [IPv4/6]  |  BAM-DMUX  |                |       |
         [Data...] |            |                |       |
        ---------->|wwan0       | [DMUX chan: x] |       |
         [IPv4/6]  | (chan: 0)  | [IPv4/6]       |       |
         [Data...] |            | [Data...]      |       |
        ---------->|wwan1       |--------------->| Modem |
                   | (chan: 1)  |      BAM       |       |
         [IPv4/6]  | ...        |  (DMA Engine)  |       |
         [Data...] |            |                |       |
        ---------->|wwan7       |                |       |
                   | (chan: 7)  |                |       |
                   +------------+                +-------+

However, on newer SoCs/firmware versions Qualcomm began gradually moving
to QMAP (rmnet driver) as backend-independent protocol for multiplexing
and data aggegration. Some firmware versions allow using QMAP on top of
BAM-DMUX (effectively resulting in a second multiplexing layer plus data
aggregation). The architecture with QMAP would look roughly like this:

           +-------------+           +------------+                  +-------+
 [IPv4/6]  |    RMNET    |           |  BAM-DMUX  |                  |       |
 [Data...] |             |           |            | [DMUX chan: 0]   |       |
---------->|rmnet_data1  |     ----->|wwan0       | [QMAP mux-id: x] |       |
           | (mux-id: 1) |     |     | (chan: 0)  | [IPv4/6]         |       |
           |             |     |     |            | [Data...]        |       |
 [IPv4/6]  | ...         |------     |            |----------------->| Modem |
 [Data...] |             |           |            |       BAM        |       |
---------->|rmnet_data42 | [QMAP: x] |[wwan1]     |   (DMA Engine)   |       |
           | (mux-id: 42)| [IPv4/6]  |... unused! |                  |       |
           |             | [Data...] |[wwan7]     |                  |       |
           |             |           |            |                  |       |
           +-------------+           +------------+                  +-------+

In this case, wwan1-7 would remain unused. The firmware used on the most
recent SoCs with BAM-DMUX even seems to announce only a single BAM-DMUX
channel (wwan0), which makes QMAP the only option for multiplexing there.

However, so far the driver is mainly tested without QMAP, on various
smartphones/tablets based on Qualcomm MSM8916/MSM8974. It looks like QMAP
depends on a MTU negotiation feature in BAM-DMUX which is not supported yet.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
Note that this is my first network driver, so I apologize in advance
if I made some obvious mistakes. :)

Changes since RFC:
  - Rebase on net-next and fix conflicts
  - Rename network interfaces from "rmnet%d" -> "wwan%d"
  - Fix wrong file name in MAINTAINERS entry
  - Clarify control channel in commit message. (It is entirely independent
    of BAM-DMUX and is already supported by the RPMSG WWAN CTRL driver.)

Like in the RFC version [1], the driver does not currently use the link
management of the WWAN subsystem. Instead, it simply exposes one network
interface for each of the up to 8 channels.

This setup works out of the box with all available open-source userspace
WWAN implementations, especially ModemManager (no changes needed).
oFono works too although it requires minor changes to support WWAN control
ports (/dev/wwan0qmi0) which are independent of BAM-DMUX (already provided
by the "rpmsg_wwan_ctrl" driver).
It was easy to support because the setup is very similar to ones already
supported for USB modems. Some of them provide multiple network interfaces
and ModemManager can bundle them together to a single modem.

I believe it is best to keep this setup as-is for now and not add even
more complexity to userspace with another setup that works only in this
particular configuration. I will reply to this patch separately to explain
that a bit more clearly. This patch is already long enough as-is. :)

[1]: https://lore.kernel.org/netdev/20210719145317.79692-5-stephan@gerhold.net/
---
 MAINTAINERS                      |   8 +
 drivers/net/wwan/Kconfig         |  13 +
 drivers/net/wwan/Makefile        |   1 +
 drivers/net/wwan/qcom_bam_dmux.c | 907 +++++++++++++++++++++++++++++++
 4 files changed, 929 insertions(+)
 create mode 100644 drivers/net/wwan/qcom_bam_dmux.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a4a0c2baaf27..62bfdac5fa0b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15464,6 +15464,14 @@ S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
 F:	drivers/net/wireless/ath/ath9k/
 
+QUALCOMM BAM-DMUX WWAN NETWORK DRIVER
+M:	Stephan Gerhold <stephan@gerhold.net>
+L:	netdev@vger.kernel.org
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
+F:	drivers/net/wwan/qcom_bam_dmux.c
+
 QUALCOMM CAMERA SUBSYSTEM DRIVER
 M:	Robert Foss <robert.foss@linaro.org>
 M:	Todor Tomov <todor.too@gmail.com>
diff --git a/drivers/net/wwan/Kconfig b/drivers/net/wwan/Kconfig
index 17543be14665..bdb2b0e46c12 100644
--- a/drivers/net/wwan/Kconfig
+++ b/drivers/net/wwan/Kconfig
@@ -50,6 +50,19 @@ config MHI_WWAN_MBIM
           To compile this driver as a module, choose M here: the module will be
           called mhi_wwan_mbim.
 
+config QCOM_BAM_DMUX
+	tristate "Qualcomm BAM-DMUX WWAN network driver"
+	depends on (DMA_ENGINE && PM && QCOM_SMEM_STATE) || COMPILE_TEST
+	help
+	  The BAM Data Multiplexer provides access to the network data channels
+	  of modems integrated into many older Qualcomm SoCs, e.g. Qualcomm
+	  MSM8916 or MSM8974. The connection can be established via QMI/AT from
+	  userspace with control ports available through the WWAN subsystem
+	  (CONFIG_RPMSG_WWAN_CTRL) or QRTR network sockets (CONFIG_QRTR).
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called qcom_bam_dmux.
+
 config RPMSG_WWAN_CTRL
 	tristate "RPMSG WWAN control driver"
 	depends on RPMSG
diff --git a/drivers/net/wwan/Makefile b/drivers/net/wwan/Makefile
index fe51feedac21..e722650bebea 100644
--- a/drivers/net/wwan/Makefile
+++ b/drivers/net/wwan/Makefile
@@ -10,5 +10,6 @@ obj-$(CONFIG_WWAN_HWSIM) += wwan_hwsim.o
 
 obj-$(CONFIG_MHI_WWAN_CTRL) += mhi_wwan_ctrl.o
 obj-$(CONFIG_MHI_WWAN_MBIM) += mhi_wwan_mbim.o
+obj-$(CONFIG_QCOM_BAM_DMUX) += qcom_bam_dmux.o
 obj-$(CONFIG_RPMSG_WWAN_CTRL) += rpmsg_wwan_ctrl.o
 obj-$(CONFIG_IOSM) += iosm/
diff --git a/drivers/net/wwan/qcom_bam_dmux.c b/drivers/net/wwan/qcom_bam_dmux.c
new file mode 100644
index 000000000000..5dfa2eba6014
--- /dev/null
+++ b/drivers/net/wwan/qcom_bam_dmux.c
@@ -0,0 +1,907 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Qualcomm BAM-DMUX WWAN network driver
+ * Copyright (c) 2020, Stephan Gerhold <stephan@gerhold.net>
+ */
+
+#include <linux/atomic.h>
+#include <linux/bitops.h>
+#include <linux/completion.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/if_arp.h>
+#include <linux/interrupt.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/netdevice.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/soc/qcom/smem_state.h>
+#include <linux/spinlock.h>
+#include <linux/wait.h>
+#include <linux/workqueue.h>
+#include <net/pkt_sched.h>
+
+#define BAM_DMUX_BUFFER_SIZE		SZ_2K
+#define BAM_DMUX_HDR_SIZE		sizeof(struct bam_dmux_hdr)
+#define BAM_DMUX_MAX_DATA_SIZE		(BAM_DMUX_BUFFER_SIZE - BAM_DMUX_HDR_SIZE)
+#define BAM_DMUX_NUM_SKB		32
+
+#define BAM_DMUX_HDR_MAGIC		0x33fc
+
+#define BAM_DMUX_AUTOSUSPEND_DELAY	1000
+#define BAM_DMUX_REMOTE_TIMEOUT		msecs_to_jiffies(2000)
+
+enum {
+	BAM_DMUX_CMD_DATA,
+	BAM_DMUX_CMD_OPEN,
+	BAM_DMUX_CMD_CLOSE,
+};
+
+enum {
+	BAM_DMUX_CH_DATA_0,
+	BAM_DMUX_CH_DATA_1,
+	BAM_DMUX_CH_DATA_2,
+	BAM_DMUX_CH_DATA_3,
+	BAM_DMUX_CH_DATA_4,
+	BAM_DMUX_CH_DATA_5,
+	BAM_DMUX_CH_DATA_6,
+	BAM_DMUX_CH_DATA_7,
+	BAM_DMUX_NUM_CH
+};
+
+struct bam_dmux_hdr {
+	u16 magic;
+	u8 signal;
+	u8 cmd;
+	u8 pad;
+	u8 ch;
+	u16 len;
+};
+
+struct bam_dmux_skb_dma {
+	struct bam_dmux *dmux;
+	struct sk_buff *skb;
+	dma_addr_t addr;
+};
+
+struct bam_dmux {
+	struct device *dev;
+
+	int pc_irq;
+	bool pc_state, pc_ack_state;
+	struct qcom_smem_state *pc, *pc_ack;
+	u32 pc_mask, pc_ack_mask;
+	wait_queue_head_t pc_wait;
+	struct completion pc_ack_completion;
+
+	struct dma_chan *rx, *tx;
+	struct bam_dmux_skb_dma rx_skbs[BAM_DMUX_NUM_SKB];
+	struct bam_dmux_skb_dma tx_skbs[BAM_DMUX_NUM_SKB];
+	spinlock_t tx_lock; /* Protect tx_skbs, tx_next_skb */
+	unsigned int tx_next_skb;
+	atomic_long_t tx_deferred_skb;
+	struct work_struct tx_wakeup_work;
+
+	DECLARE_BITMAP(remote_channels, BAM_DMUX_NUM_CH);
+	struct work_struct register_netdev_work;
+	struct net_device *netdevs[BAM_DMUX_NUM_CH];
+};
+
+struct bam_dmux_netdev {
+	struct bam_dmux *dmux;
+	u8 ch;
+};
+
+static void bam_dmux_pc_vote(struct bam_dmux *dmux, bool enable)
+{
+	reinit_completion(&dmux->pc_ack_completion);
+	qcom_smem_state_update_bits(dmux->pc, dmux->pc_mask,
+				    enable ? dmux->pc_mask : 0);
+}
+
+static void bam_dmux_pc_ack(struct bam_dmux *dmux)
+{
+	qcom_smem_state_update_bits(dmux->pc_ack, dmux->pc_ack_mask,
+				    dmux->pc_ack_state ? 0 : dmux->pc_ack_mask);
+	dmux->pc_ack_state = !dmux->pc_ack_state;
+}
+
+static bool bam_dmux_skb_dma_map(struct bam_dmux_skb_dma *skb_dma,
+				 enum dma_data_direction dir)
+{
+	struct device *dev = skb_dma->dmux->dev;
+
+	skb_dma->addr = dma_map_single(dev, skb_dma->skb->data, skb_dma->skb->len, dir);
+	if (dma_mapping_error(dev, skb_dma->addr)) {
+		dev_err(dev, "Failed to DMA map buffer\n");
+		skb_dma->addr = 0;
+		return false;
+	}
+
+	return true;
+}
+
+static void bam_dmux_skb_dma_unmap(struct bam_dmux_skb_dma *skb_dma,
+				   enum dma_data_direction dir)
+{
+	dma_unmap_single(skb_dma->dmux->dev, skb_dma->addr, skb_dma->skb->len, dir);
+	skb_dma->addr = 0;
+}
+
+static void bam_dmux_tx_wake_queues(struct bam_dmux *dmux)
+{
+	int i;
+
+	dev_dbg(dmux->dev, "wake queues\n");
+
+	for (i = 0; i < BAM_DMUX_NUM_CH; ++i) {
+		struct net_device *netdev = dmux->netdevs[i];
+
+		if (netdev && netif_running(netdev))
+			netif_wake_queue(netdev);
+	}
+}
+
+static void bam_dmux_tx_stop_queues(struct bam_dmux *dmux)
+{
+	int i;
+
+	dev_dbg(dmux->dev, "stop queues\n");
+
+	for (i = 0; i < BAM_DMUX_NUM_CH; ++i) {
+		struct net_device *netdev = dmux->netdevs[i];
+
+		if (netdev)
+			netif_stop_queue(netdev);
+	}
+}
+
+static void bam_dmux_tx_done(struct bam_dmux_skb_dma *skb_dma)
+{
+	struct bam_dmux *dmux = skb_dma->dmux;
+	unsigned long flags;
+
+	pm_runtime_mark_last_busy(dmux->dev);
+	pm_runtime_put_autosuspend(dmux->dev);
+
+	if (skb_dma->addr)
+		bam_dmux_skb_dma_unmap(skb_dma, DMA_TO_DEVICE);
+
+	spin_lock_irqsave(&dmux->tx_lock, flags);
+	skb_dma->skb = NULL;
+	if (skb_dma == &dmux->tx_skbs[dmux->tx_next_skb % BAM_DMUX_NUM_SKB])
+		bam_dmux_tx_wake_queues(dmux);
+	spin_unlock_irqrestore(&dmux->tx_lock, flags);
+}
+
+static void bam_dmux_tx_callback(void *data)
+{
+	struct bam_dmux_skb_dma *skb_dma = data;
+	struct sk_buff *skb = skb_dma->skb;
+
+	bam_dmux_tx_done(skb_dma);
+	dev_consume_skb_any(skb);
+}
+
+static bool bam_dmux_skb_dma_submit_tx(struct bam_dmux_skb_dma *skb_dma)
+{
+	struct bam_dmux *dmux = skb_dma->dmux;
+	struct dma_async_tx_descriptor *desc;
+
+	desc = dmaengine_prep_slave_single(dmux->tx, skb_dma->addr,
+					   skb_dma->skb->len, DMA_MEM_TO_DEV,
+					   DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dmux->dev, "Failed to prepare TX DMA buffer\n");
+		return false;
+	}
+
+	desc->callback = bam_dmux_tx_callback;
+	desc->callback_param = skb_dma;
+	desc->cookie = dmaengine_submit(desc);
+	return true;
+}
+
+static struct bam_dmux_skb_dma *
+bam_dmux_tx_queue(struct bam_dmux *dmux, struct sk_buff *skb)
+{
+	struct bam_dmux_skb_dma *skb_dma;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dmux->tx_lock, flags);
+
+	skb_dma = &dmux->tx_skbs[dmux->tx_next_skb % BAM_DMUX_NUM_SKB];
+	if (skb_dma->skb) {
+		bam_dmux_tx_stop_queues(dmux);
+		spin_unlock_irqrestore(&dmux->tx_lock, flags);
+		return NULL;
+	}
+	skb_dma->skb = skb;
+
+	dmux->tx_next_skb++;
+	if (dmux->tx_skbs[dmux->tx_next_skb % BAM_DMUX_NUM_SKB].skb)
+		bam_dmux_tx_stop_queues(dmux);
+
+	spin_unlock_irqrestore(&dmux->tx_lock, flags);
+	return skb_dma;
+}
+
+static int bam_dmux_send_cmd(struct bam_dmux_netdev *bndev, u8 cmd)
+{
+	struct bam_dmux *dmux = bndev->dmux;
+	struct bam_dmux_skb_dma *skb_dma;
+	struct bam_dmux_hdr *hdr;
+	struct sk_buff *skb;
+	int ret;
+
+	skb = alloc_skb(sizeof(*hdr), GFP_KERNEL);
+	if (!skb)
+		return -ENOMEM;
+
+	hdr = skb_put_zero(skb, sizeof(*hdr));
+	hdr->magic = BAM_DMUX_HDR_MAGIC;
+	hdr->cmd = cmd;
+	hdr->ch = bndev->ch;
+
+	skb_dma = bam_dmux_tx_queue(dmux, skb);
+	if (!skb_dma) {
+		ret = -EAGAIN;
+		goto free_skb;
+	}
+
+	ret = pm_runtime_get_sync(dmux->dev);
+	if (ret < 0)
+		goto tx_fail;
+
+	if (!bam_dmux_skb_dma_map(skb_dma, DMA_TO_DEVICE)) {
+		ret = -ENOMEM;
+		goto tx_fail;
+	}
+
+	if (!bam_dmux_skb_dma_submit_tx(skb_dma)) {
+		ret = -EIO;
+		goto tx_fail;
+	}
+
+	dma_async_issue_pending(dmux->tx);
+	return 0;
+
+tx_fail:
+	bam_dmux_tx_done(skb_dma);
+free_skb:
+	dev_kfree_skb(skb);
+	return ret;
+}
+
+static int bam_dmux_netdev_open(struct net_device *netdev)
+{
+	struct bam_dmux_netdev *bndev = netdev_priv(netdev);
+	int ret;
+
+	ret = bam_dmux_send_cmd(bndev, BAM_DMUX_CMD_OPEN);
+	if (ret)
+		return ret;
+
+	netif_start_queue(netdev);
+	return 0;
+}
+
+static int bam_dmux_netdev_stop(struct net_device *netdev)
+{
+	struct bam_dmux_netdev *bndev = netdev_priv(netdev);
+
+	netif_stop_queue(netdev);
+	bam_dmux_send_cmd(bndev, BAM_DMUX_CMD_CLOSE);
+	return 0;
+}
+
+static unsigned int needed_room(unsigned int avail, unsigned int needed)
+{
+	if (avail >= needed)
+		return 0;
+	return needed - avail;
+}
+
+static int bam_dmux_tx_prepare_skb(struct bam_dmux_netdev *bndev,
+				   struct sk_buff *skb)
+{
+	unsigned int head = needed_room(skb_headroom(skb), BAM_DMUX_HDR_SIZE);
+	unsigned int pad = sizeof(u32) - skb->len % sizeof(u32);
+	unsigned int tail = needed_room(skb_tailroom(skb), pad);
+	struct bam_dmux_hdr *hdr;
+	int ret;
+
+	if (head || tail || skb_cloned(skb)) {
+		ret = pskb_expand_head(skb, head, tail, GFP_ATOMIC);
+		if (ret)
+			return ret;
+	}
+
+	hdr = skb_push(skb, sizeof(*hdr));
+	hdr->magic = BAM_DMUX_HDR_MAGIC;
+	hdr->signal = 0;
+	hdr->cmd = BAM_DMUX_CMD_DATA;
+	hdr->pad = pad;
+	hdr->ch = bndev->ch;
+	hdr->len = skb->len - sizeof(*hdr);
+	if (pad)
+		skb_put_zero(skb, pad);
+
+	return 0;
+}
+
+static netdev_tx_t bam_dmux_netdev_start_xmit(struct sk_buff *skb,
+					      struct net_device *netdev)
+{
+	struct bam_dmux_netdev *bndev = netdev_priv(netdev);
+	struct bam_dmux *dmux = bndev->dmux;
+	struct bam_dmux_skb_dma *skb_dma;
+	int active, ret;
+
+	skb_dma = bam_dmux_tx_queue(dmux, skb);
+	if (!skb_dma)
+		return NETDEV_TX_BUSY;
+
+	active = pm_runtime_get(dmux->dev);
+	if (active < 0 && active != -EINPROGRESS)
+		goto drop;
+
+	ret = bam_dmux_tx_prepare_skb(bndev, skb);
+	if (ret)
+		goto drop;
+
+	if (!bam_dmux_skb_dma_map(skb_dma, DMA_TO_DEVICE))
+		goto drop;
+
+	if (active <= 0) {
+		/* Cannot sleep here so mark skb for wakeup handler and return */
+		if (!atomic_long_fetch_or(BIT(skb_dma - dmux->tx_skbs),
+					  &dmux->tx_deferred_skb))
+			queue_pm_work(&dmux->tx_wakeup_work);
+		return NETDEV_TX_OK;
+	}
+
+	if (!bam_dmux_skb_dma_submit_tx(skb_dma))
+		goto drop;
+
+	dma_async_issue_pending(dmux->tx);
+	return NETDEV_TX_OK;
+
+drop:
+	bam_dmux_tx_done(skb_dma);
+	dev_kfree_skb_any(skb);
+	return NETDEV_TX_OK;
+}
+
+static void bam_dmux_tx_wakeup_work(struct work_struct *work)
+{
+	struct bam_dmux *dmux = container_of(work, struct bam_dmux, tx_wakeup_work);
+	unsigned long pending;
+	int ret, i;
+
+	ret = pm_runtime_resume_and_get(dmux->dev);
+	if (ret < 0) {
+		dev_err(dmux->dev, "Failed to resume: %d\n", ret);
+		return;
+	}
+
+	pending = atomic_long_xchg(&dmux->tx_deferred_skb, 0);
+	if (!pending)
+		goto out;
+
+	dev_dbg(dmux->dev, "pending skbs after wakeup: %#lx\n", pending);
+	for_each_set_bit(i, &pending, BAM_DMUX_NUM_SKB) {
+		bam_dmux_skb_dma_submit_tx(&dmux->tx_skbs[i]);
+	}
+	dma_async_issue_pending(dmux->tx);
+
+out:
+	pm_runtime_mark_last_busy(dmux->dev);
+	pm_runtime_put_autosuspend(dmux->dev);
+}
+
+static const struct net_device_ops bam_dmux_ops = {
+	.ndo_open	= bam_dmux_netdev_open,
+	.ndo_stop	= bam_dmux_netdev_stop,
+	.ndo_start_xmit	= bam_dmux_netdev_start_xmit,
+};
+
+static const struct device_type wwan_type = {
+	.name = "wwan",
+};
+
+static void bam_dmux_netdev_setup(struct net_device *dev)
+{
+	dev->netdev_ops = &bam_dmux_ops;
+
+	dev->type = ARPHRD_RAWIP;
+	SET_NETDEV_DEVTYPE(dev, &wwan_type);
+	dev->flags = IFF_POINTOPOINT | IFF_NOARP;
+
+	dev->mtu = ETH_DATA_LEN;
+	dev->max_mtu = BAM_DMUX_MAX_DATA_SIZE;
+	dev->needed_headroom = sizeof(struct bam_dmux_hdr);
+	dev->needed_tailroom = sizeof(u32); /* word-aligned */
+	dev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+
+	/* This perm addr will be used as interface identifier by IPv6 */
+	dev->addr_assign_type = NET_ADDR_RANDOM;
+	eth_random_addr(dev->perm_addr);
+}
+
+static void bam_dmux_register_netdev_work(struct work_struct *work)
+{
+	struct bam_dmux *dmux = container_of(work, struct bam_dmux, register_netdev_work);
+	struct bam_dmux_netdev *bndev;
+	struct net_device *netdev;
+	int ch, ret;
+
+	for_each_set_bit(ch, dmux->remote_channels, BAM_DMUX_NUM_CH) {
+		if (dmux->netdevs[ch])
+			continue;
+
+		netdev = alloc_netdev(sizeof(*bndev), "wwan%d", NET_NAME_ENUM,
+				      bam_dmux_netdev_setup);
+		if (!netdev)
+			return;
+
+		SET_NETDEV_DEV(netdev, dmux->dev);
+		netdev->dev_port = ch;
+
+		bndev = netdev_priv(netdev);
+		bndev->dmux = dmux;
+		bndev->ch = ch;
+
+		ret = register_netdev(netdev);
+		if (ret) {
+			dev_err(dmux->dev, "Failed to register netdev for channel %u: %d\n",
+				ch, ret);
+			free_netdev(netdev);
+			return;
+		}
+
+		dmux->netdevs[ch] = netdev;
+	}
+}
+
+static void bam_dmux_rx_callback(void *data);
+
+static bool bam_dmux_skb_dma_submit_rx(struct bam_dmux_skb_dma *skb_dma)
+{
+	struct bam_dmux *dmux = skb_dma->dmux;
+	struct dma_async_tx_descriptor *desc;
+
+	desc = dmaengine_prep_slave_single(dmux->rx, skb_dma->addr,
+					   skb_dma->skb->len, DMA_DEV_TO_MEM,
+					   DMA_PREP_INTERRUPT);
+	if (!desc) {
+		dev_err(dmux->dev, "Failed to prepare RX DMA buffer\n");
+		return false;
+	}
+
+	desc->callback = bam_dmux_rx_callback;
+	desc->callback_param = skb_dma;
+	desc->cookie = dmaengine_submit(desc);
+	return true;
+}
+
+static bool bam_dmux_skb_dma_queue_rx(struct bam_dmux_skb_dma *skb_dma, gfp_t gfp)
+{
+	if (!skb_dma->skb) {
+		skb_dma->skb = __netdev_alloc_skb(NULL, BAM_DMUX_BUFFER_SIZE, gfp);
+		if (!skb_dma->skb)
+			return false;
+		skb_put(skb_dma->skb, BAM_DMUX_BUFFER_SIZE);
+	}
+
+	return bam_dmux_skb_dma_map(skb_dma, DMA_FROM_DEVICE) &&
+	       bam_dmux_skb_dma_submit_rx(skb_dma);
+}
+
+static void bam_dmux_cmd_data(struct bam_dmux_skb_dma *skb_dma)
+{
+	struct bam_dmux *dmux = skb_dma->dmux;
+	struct sk_buff *skb = skb_dma->skb;
+	struct bam_dmux_hdr *hdr = (struct bam_dmux_hdr *)skb->data;
+	struct net_device *netdev = dmux->netdevs[hdr->ch];
+
+	if (!netdev || !netif_running(netdev)) {
+		dev_warn(dmux->dev, "Data for inactive channel %u\n", hdr->ch);
+		return;
+	}
+
+	if (hdr->len > BAM_DMUX_MAX_DATA_SIZE) {
+		dev_err(dmux->dev, "Data larger than buffer? (%u > %u)\n",
+			hdr->len, (u16)BAM_DMUX_MAX_DATA_SIZE);
+		return;
+	}
+
+	skb_dma->skb = NULL; /* Hand over to network stack */
+
+	skb_pull(skb, sizeof(*hdr));
+	skb_trim(skb, hdr->len);
+	skb->dev = netdev;
+
+	/* Only Raw-IP/QMAP is supported by this driver */
+	switch (skb->data[0] & 0xf0) {
+	case 0x40:
+		skb->protocol = htons(ETH_P_IP);
+		break;
+	case 0x60:
+		skb->protocol = htons(ETH_P_IPV6);
+		break;
+	default:
+		skb->protocol = htons(ETH_P_MAP);
+		break;
+	}
+
+	netif_receive_skb(skb);
+}
+
+static void bam_dmux_cmd_open(struct bam_dmux *dmux, struct bam_dmux_hdr *hdr)
+{
+	struct net_device *netdev = dmux->netdevs[hdr->ch];
+
+	dev_dbg(dmux->dev, "open channel: %u\n", hdr->ch);
+
+	if (__test_and_set_bit(hdr->ch, dmux->remote_channels)) {
+		dev_warn(dmux->dev, "Channel already open: %u\n", hdr->ch);
+		return;
+	}
+
+	if (netdev) {
+		netif_device_attach(netdev);
+	} else {
+		/* Cannot sleep here, schedule work to register the netdev */
+		schedule_work(&dmux->register_netdev_work);
+	}
+}
+
+static void bam_dmux_cmd_close(struct bam_dmux *dmux, struct bam_dmux_hdr *hdr)
+{
+	struct net_device *netdev = dmux->netdevs[hdr->ch];
+
+	dev_dbg(dmux->dev, "close channel: %u\n", hdr->ch);
+
+	if (!__test_and_clear_bit(hdr->ch, dmux->remote_channels)) {
+		dev_err(dmux->dev, "Channel not open: %u\n", hdr->ch);
+		return;
+	}
+
+	if (netdev)
+		netif_device_detach(netdev);
+}
+
+static void bam_dmux_rx_callback(void *data)
+{
+	struct bam_dmux_skb_dma *skb_dma = data;
+	struct bam_dmux *dmux = skb_dma->dmux;
+	struct sk_buff *skb = skb_dma->skb;
+	struct bam_dmux_hdr *hdr = (struct bam_dmux_hdr *)skb->data;
+
+	bam_dmux_skb_dma_unmap(skb_dma, DMA_FROM_DEVICE);
+
+	if (hdr->magic != BAM_DMUX_HDR_MAGIC) {
+		dev_err(dmux->dev, "Invalid magic in header: %#x\n", hdr->magic);
+		goto out;
+	}
+
+	if (hdr->ch >= BAM_DMUX_NUM_CH) {
+		dev_dbg(dmux->dev, "Unsupported channel: %u\n", hdr->ch);
+		goto out;
+	}
+
+	switch (hdr->cmd) {
+	case BAM_DMUX_CMD_DATA:
+		bam_dmux_cmd_data(skb_dma);
+		break;
+	case BAM_DMUX_CMD_OPEN:
+		bam_dmux_cmd_open(dmux, hdr);
+		break;
+	case BAM_DMUX_CMD_CLOSE:
+		bam_dmux_cmd_close(dmux, hdr);
+		break;
+	default:
+		dev_err(dmux->dev, "Unsupported command %u on channel %u\n",
+			hdr->cmd, hdr->ch);
+		break;
+	}
+
+out:
+	if (bam_dmux_skb_dma_queue_rx(skb_dma, GFP_ATOMIC))
+		dma_async_issue_pending(dmux->rx);
+}
+
+static bool bam_dmux_power_on(struct bam_dmux *dmux)
+{
+	struct device *dev = dmux->dev;
+	struct dma_slave_config dma_rx_conf = {
+		.direction = DMA_DEV_TO_MEM,
+		.src_maxburst = BAM_DMUX_BUFFER_SIZE,
+	};
+	int i;
+
+	dmux->rx = dma_request_chan(dev, "rx");
+	if (IS_ERR(dmux->rx)) {
+		dev_err(dev, "Failed to request RX DMA channel: %pe\n", dmux->rx);
+		dmux->rx = NULL;
+		return false;
+	}
+	dmaengine_slave_config(dmux->rx, &dma_rx_conf);
+
+	for (i = 0; i < BAM_DMUX_NUM_SKB; i++) {
+		if (!bam_dmux_skb_dma_queue_rx(&dmux->rx_skbs[i], GFP_KERNEL))
+			return false;
+	}
+	dma_async_issue_pending(dmux->rx);
+
+	return true;
+}
+
+static void bam_dmux_free_skbs(struct bam_dmux_skb_dma skbs[],
+			       enum dma_data_direction dir)
+{
+	int i;
+
+	for (i = 0; i < BAM_DMUX_NUM_SKB; i++) {
+		struct bam_dmux_skb_dma *skb_dma = &skbs[i];
+
+		if (skb_dma->addr)
+			bam_dmux_skb_dma_unmap(skb_dma, dir);
+		if (skb_dma->skb) {
+			dev_kfree_skb(skb_dma->skb);
+			skb_dma->skb = NULL;
+		}
+	}
+}
+
+static void bam_dmux_power_off(struct bam_dmux *dmux)
+{
+	if (dmux->tx) {
+		dmaengine_terminate_sync(dmux->tx);
+		dma_release_channel(dmux->tx);
+		dmux->tx = NULL;
+	}
+
+	if (dmux->rx) {
+		dmaengine_terminate_sync(dmux->rx);
+		dma_release_channel(dmux->rx);
+		dmux->rx = NULL;
+	}
+
+	bam_dmux_free_skbs(dmux->rx_skbs, DMA_FROM_DEVICE);
+}
+
+static irqreturn_t bam_dmux_pc_irq(int irq, void *data)
+{
+	struct bam_dmux *dmux = data;
+	bool new_state = !dmux->pc_state;
+
+	dev_dbg(dmux->dev, "pc: %u\n", new_state);
+
+	if (new_state) {
+		if (bam_dmux_power_on(dmux))
+			bam_dmux_pc_ack(dmux);
+		else
+			bam_dmux_power_off(dmux);
+	} else {
+		bam_dmux_power_off(dmux);
+		bam_dmux_pc_ack(dmux);
+	}
+
+	dmux->pc_state = new_state;
+	wake_up_all(&dmux->pc_wait);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t bam_dmux_pc_ack_irq(int irq, void *data)
+{
+	struct bam_dmux *dmux = data;
+
+	dev_dbg(dmux->dev, "pc ack\n");
+	complete_all(&dmux->pc_ack_completion);
+
+	return IRQ_HANDLED;
+}
+
+static int bam_dmux_runtime_suspend(struct device *dev)
+{
+	struct bam_dmux *dmux = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "runtime suspend\n");
+	bam_dmux_pc_vote(dmux, false);
+
+	return 0;
+}
+
+static int __maybe_unused bam_dmux_runtime_resume(struct device *dev)
+{
+	struct bam_dmux *dmux = dev_get_drvdata(dev);
+
+	dev_dbg(dev, "runtime resume\n");
+
+	/* Wait until previous power down was acked */
+	if (!wait_for_completion_timeout(&dmux->pc_ack_completion,
+					 BAM_DMUX_REMOTE_TIMEOUT))
+		return -ETIMEDOUT;
+
+	/* Vote for power state */
+	bam_dmux_pc_vote(dmux, true);
+
+	/* Wait for ack */
+	if (!wait_for_completion_timeout(&dmux->pc_ack_completion,
+					 BAM_DMUX_REMOTE_TIMEOUT)) {
+		bam_dmux_pc_vote(dmux, false);
+		return -ETIMEDOUT;
+	}
+
+	/* Wait until we're up */
+	if (!wait_event_timeout(dmux->pc_wait, dmux->pc_state,
+				BAM_DMUX_REMOTE_TIMEOUT)) {
+		bam_dmux_pc_vote(dmux, false);
+		return -ETIMEDOUT;
+	}
+
+	/* Ensure that we actually initialized successfully */
+	if (!dmux->rx) {
+		bam_dmux_pc_vote(dmux, false);
+		return -ENXIO;
+	}
+
+	/* Request TX channel if necessary */
+	if (dmux->tx)
+		return 0;
+
+	dmux->tx = dma_request_chan(dev, "tx");
+	if (IS_ERR(dmux->rx)) {
+		dev_err(dev, "Failed to request TX DMA channel: %pe\n", dmux->tx);
+		dmux->tx = NULL;
+		bam_dmux_runtime_suspend(dev);
+		return -ENXIO;
+	}
+
+	return 0;
+}
+
+static int bam_dmux_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct bam_dmux *dmux;
+	int ret, pc_ack_irq, i;
+	unsigned int bit;
+
+	dmux = devm_kzalloc(dev, sizeof(*dmux), GFP_KERNEL);
+	if (!dmux)
+		return -ENOMEM;
+
+	dmux->dev = dev;
+	platform_set_drvdata(pdev, dmux);
+
+	dmux->pc_irq = platform_get_irq_byname(pdev, "pc");
+	if (dmux->pc_irq < 0)
+		return dmux->pc_irq;
+
+	pc_ack_irq = platform_get_irq_byname(pdev, "pc-ack");
+	if (pc_ack_irq < 0)
+		return pc_ack_irq;
+
+	dmux->pc = devm_qcom_smem_state_get(dev, "pc", &bit);
+	if (IS_ERR(dmux->pc))
+		return dev_err_probe(dev, PTR_ERR(dmux->pc),
+				     "Failed to get pc state\n");
+	dmux->pc_mask = BIT(bit);
+
+	dmux->pc_ack = devm_qcom_smem_state_get(dev, "pc-ack", &bit);
+	if (IS_ERR(dmux->pc_ack))
+		return dev_err_probe(dev, PTR_ERR(dmux->pc_ack),
+				     "Failed to get pc-ack state\n");
+	dmux->pc_ack_mask = BIT(bit);
+
+	init_waitqueue_head(&dmux->pc_wait);
+	init_completion(&dmux->pc_ack_completion);
+	complete_all(&dmux->pc_ack_completion);
+
+	spin_lock_init(&dmux->tx_lock);
+	INIT_WORK(&dmux->tx_wakeup_work, bam_dmux_tx_wakeup_work);
+	INIT_WORK(&dmux->register_netdev_work, bam_dmux_register_netdev_work);
+
+	for (i = 0; i < BAM_DMUX_NUM_SKB; i++) {
+		dmux->rx_skbs[i].dmux = dmux;
+		dmux->tx_skbs[i].dmux = dmux;
+	}
+
+	/* Runtime PM manages our own power vote.
+	 * Note that the RX path may be active even if we are runtime suspended,
+	 * since it is controlled by the remote side.
+	 */
+	pm_runtime_set_autosuspend_delay(dev, BAM_DMUX_AUTOSUSPEND_DELAY);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_enable(dev);
+
+	ret = devm_request_threaded_irq(dev, pc_ack_irq, NULL, bam_dmux_pc_ack_irq,
+					IRQF_ONESHOT, NULL, dmux);
+	if (ret)
+		return ret;
+
+	ret = devm_request_threaded_irq(dev, dmux->pc_irq, NULL, bam_dmux_pc_irq,
+					IRQF_ONESHOT, NULL, dmux);
+	if (ret)
+		return ret;
+
+	ret = irq_get_irqchip_state(dmux->pc_irq, IRQCHIP_STATE_LINE_LEVEL,
+				    &dmux->pc_state);
+	if (ret)
+		return ret;
+
+	/* Check if remote finished initialization before us */
+	if (dmux->pc_state) {
+		if (bam_dmux_power_on(dmux))
+			bam_dmux_pc_ack(dmux);
+		else
+			bam_dmux_power_off(dmux);
+	}
+
+	return 0;
+}
+
+static int bam_dmux_remove(struct platform_device *pdev)
+{
+	struct bam_dmux *dmux = platform_get_drvdata(pdev);
+	struct device *dev = dmux->dev;
+	LIST_HEAD(list);
+	int i;
+
+	/* Unregister network interfaces */
+	cancel_work_sync(&dmux->register_netdev_work);
+	rtnl_lock();
+	for (i = 0; i < BAM_DMUX_NUM_CH; ++i)
+		if (dmux->netdevs[i])
+			unregister_netdevice_queue(dmux->netdevs[i], &list);
+	unregister_netdevice_many(&list);
+	rtnl_unlock();
+	cancel_work_sync(&dmux->tx_wakeup_work);
+
+	/* Drop our own power vote */
+	pm_runtime_disable(dev);
+	pm_runtime_dont_use_autosuspend(dev);
+	bam_dmux_runtime_suspend(dev);
+	pm_runtime_set_suspended(dev);
+
+	/* Try to wait for remote side to drop power vote */
+	if (!wait_event_timeout(dmux->pc_wait, !dmux->rx, BAM_DMUX_REMOTE_TIMEOUT))
+		dev_err(dev, "Timed out waiting for remote side to suspend\n");
+
+	/* Make sure everything is cleaned up before we return */
+	disable_irq(dmux->pc_irq);
+	bam_dmux_power_off(dmux);
+	bam_dmux_free_skbs(dmux->tx_skbs, DMA_TO_DEVICE);
+
+	return 0;
+}
+
+static const struct dev_pm_ops bam_dmux_pm_ops = {
+	SET_RUNTIME_PM_OPS(bam_dmux_runtime_suspend, bam_dmux_runtime_resume, NULL)
+};
+
+static const struct of_device_id bam_dmux_of_match[] = {
+	{ .compatible = "qcom,bam-dmux" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, bam_dmux_of_match);
+
+static struct platform_driver bam_dmux_driver = {
+	.probe = bam_dmux_probe,
+	.remove = bam_dmux_remove,
+	.driver = {
+		.name = "bam-dmux",
+		.pm = &bam_dmux_pm_ops,
+		.of_match_table = bam_dmux_of_match,
+	},
+};
+module_platform_driver(bam_dmux_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Qualcomm BAM-DMUX WWAN Network Driver");
+MODULE_AUTHOR("Stephan Gerhold <stephan@gerhold.net>");
-- 
2.33.0

