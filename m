Return-Path: <dmaengine+bounces-11797-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DAdvBqwQPmrA/QgAu9opvQ
	(envelope-from <dmaengine+bounces-11797-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:39:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79EE66CA6FD
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 07:39:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20201202 header.b=Li+ico90;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11797-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11797-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32F1E303DD6A
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 05:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A72B3C8C72;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D782389E13;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782452378; cv=none; b=Apuwe+DPs5GLSpSSPsFFL9S0RpEaty77wG6eUuBHu1JimELeKT699jdwULGYBZy33/FyuavICqb6GtIGjonh1VCbRT93wGoWGzM4UJlxIJif55uw313iiBJnQ/Q+UAGppyy5nsSYPbJgxjOU3uTEVQlaQ9bLGUhwSdm2FKfs0IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782452378; c=relaxed/simple;
	bh=iUbnNNDnyvLTkFPD4JLA2Wv2mD2RjH1h9z8LAG1hxhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jq/+6uZZBrdObDuEO4mW2hZuVZJOwyewvzBFH+RV9jVsdu9UhmJiGSqRuyjQB02W2y0cwdWq7/Aaq7wbbD3M1+iXeEWlLO3QV3iLs7HDb2pD91dBWHAq3NInR/cMi5E3w2DwLzu2Cd8CiMg3yySZ4ULerjVR1PjIi6Kd2X8uPRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Li+ico90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28D88C2BCC9;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782452378;
	bh=iUbnNNDnyvLTkFPD4JLA2Wv2mD2RjH1h9z8LAG1hxhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Li+ico906G/CeXR5F8SzBhUOZQc1ijMlzUFsB/QAxk9W68LGyBHL9Y79wPiyIS0ou
	 KRhlulRCnXlpUofsjhjsxlpf6sEuRhiMmkg8IaZd+yl5zoKwwgACxpivq4RxIyWBN3
	 l59DLhREKfRdMRO8moPc5488ndkW2OsCVb3+rfD/KTjG2DYD/ZeJ2E7bkNV15PtkOS
	 HbD4KeluOPNKdQ+ajtrcCtAFhKXRG4Hf0OO2L1SldRbtZMBWNbQVR22k3oLoU2FCoW
	 JmbL36hwCVPqfKD6/HOEUdP7cfL95j+WPxdhvljtAY+OTvt6lU8eUJ+eJFfJJtYl/O
	 /Niz9RA18T9Hw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17050CDE012;
	Fri, 26 Jun 2026 05:39:38 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Date: Fri, 26 Jun 2026 05:39:34 +0000
Subject: [PATCH v9 2/3] dmaengine: amlogic: Add general DMA driver for A9
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260626-amlogic-dma-v9-2-558d672c4a95@amlogic.com>
References: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
In-Reply-To: <20260626-amlogic-dma-v9-0-558d672c4a95@amlogic.com>
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Frank Li <Frank.Li@kernel.org>
Cc: linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782452375; l=24478;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=z4zsxXWzMnaawJXaxgwvMd3wznLl9AFgTNXsRJcnMCk=;
 b=dDWCIAZJMy9lVZYbFK5SxZ6nY/kCVvu1DA2kDv/1VsJ9xGw+kn/ZO6Ejlon1Bk2ZDhJMzj+nA
 /CGfo0YZXHOBZhN9i4wAsr/CvCwK6BWZqqe1MDkM+I+KnMGkEC2ReOZ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11797-lists,dmaengine=lfdr.de,xianwei.zhao.amlogic.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:kees@kernel.org,m:gustavoars@kernel.org,m:Frank.Li@kernel.org,m:linux-amlogic@lists.infradead.org,m:dmaengine@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:xianwei.zhao@amlogic.com,m:Frank.Li@nxp.com,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	HAS_REPLYTO(0.00)[xianwei.zhao@amlogic.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,dmaengine@vger.kernel.org];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,amlogic.com:replyto,amlogic.com:email,amlogic.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 79EE66CA6FD

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

Amlogic A9 SoCs include a general-purpose DMA controller that can be used
by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
is associated with a dedicated DMA channel in hardware.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
 drivers/dma/Kconfig       |  10 +
 drivers/dma/Makefile      |   1 +
 drivers/dma/amlogic-dma.c | 708 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 719 insertions(+)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index ae6a682c9f76..01f96a8257e5 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -85,6 +85,16 @@ config AMCC_PPC440SPE_ADMA
 	help
 	  Enable support for the AMCC PPC440SPe RAID engines.
 
+config AMLOGIC_DMA
+	tristate "Amlogic general DMA support"
+	depends on ARCH_MESON || COMPILE_TEST
+	select DMA_ENGINE
+	select DMA_VIRTUAL_CHANNELS
+	select REGMAP_MMIO
+	help
+	  Enable support for the Amlogic general DMA engines. THis DMA
+	  controller is used some Amlogic SoCs, such as A9.
+
 config APPLE_ADMAC
 	tristate "Apple ADMAC support"
 	depends on ARCH_APPLE || COMPILE_TEST
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 14aa086629d5..f62d12b08e15 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_DMATEST) += dmatest.o
 obj-$(CONFIG_ALTERA_MSGDMA) += altera-msgdma.o
 obj-$(CONFIG_AMBA_PL08X) += amba-pl08x.o
 obj-$(CONFIG_AMCC_PPC440SPE_ADMA) += ppc4xx/
+obj-$(CONFIG_AMLOGIC_DMA) += amlogic-dma.o
 obj-$(CONFIG_APPLE_ADMAC) += apple-admac.o
 obj-$(CONFIG_ARM_DMA350) += arm-dma350.o
 obj-$(CONFIG_AT_HDMAC) += at_hdmac.o
diff --git a/drivers/dma/amlogic-dma.c b/drivers/dma/amlogic-dma.c
new file mode 100644
index 000000000000..bce6932f3a12
--- /dev/null
+++ b/drivers/dma/amlogic-dma.c
@@ -0,0 +1,708 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR MIT)
+/*
+ * Copyright (C) 2025 Amlogic, Inc. All rights reserved
+ * Author: Xianwei Zhao <xianwei.zhao@amlogic.com>
+ */
+
+#include <dt-bindings/dma/amlogic,a9-dma.h>
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/dmaengine.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/list.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_dma.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include "virt-dma.h"
+
+#define RCH_REG_BASE		0x0
+#define WCH_REG_BASE		0x2000
+/*
+ * Each rch (read from memory) REG offset  Rch_offset 0x0 each channel total 0x40
+ * rch addr = DMA_base + Rch_offset+ chan_id * 0x40 + reg_offset
+ */
+#define RCH_READY		0x0
+#define RCH_STATUS		0x4
+#define RCH_CFG			0x8
+#define CFG_CLEAR		BIT(25)
+#define CFG_PAUSE		BIT(26)
+#define CFG_ENABLE		BIT(27)
+#define CFG_DONE		BIT(28)
+#define RCH_ADDR		0xc
+#define RCH_LEN			0x10
+#define RCH_RD_LEN		0x14
+#define RCH_PRT			0x18
+#define RCH_SYCN_STAT		0x1c
+#define RCH_ADDR_LOW		0x20
+#define RCH_ADDR_HIGH		0x24
+/* if work on 64, it work with RCH_PRT */
+#define RCH_PTR_HIGH		0x28
+
+/*
+ * Each wch (write to memory) REG offset  Wch_offset 0x2000 each channel total 0x40
+ * wch addr = DMA_base + Wch_offset+ chan_id * 0x40 + reg_offset
+ */
+#define WCH_READY		0x0
+#define WCH_TOTAL_LEN		0x4
+#define WCH_CFG			0x8
+#define WCH_ADDR		0xc
+#define WCH_LEN			0x10
+#define WCH_RD_LEN		0x14
+#define WCH_PRT			0x18
+#define WCH_CMD_CNT		0x1c
+#define WCH_ADDR_LOW		0x20
+#define WCH_ADDR_HIGH		0x24
+/* if work on 64, it work with RCH_PRT */
+#define WCH_PTR_HIGH		0x28
+
+/* DMA controller reg */
+#define RCH_INT_MASK		0x1000
+#define WCH_INT_MASK		0x1004
+#define CLEAR_W_BATCH		0x1014
+#define CLEAR_RCH		0x1024
+#define CLEAR_WCH		0x1028
+#define RCH_ACTIVE		0x1038
+#define WCH_ACTIVE		0x103c
+#define RCH_DONE		0x104c
+#define WCH_DONE		0x1050
+#define RCH_ERR			0x1060
+#define RCH_LEN_ERR		0x1064
+#define WCH_ERR			0x1068
+#define DMA_BATCH_END		0x1078
+#define WCH_EOC_DONE		0x1088
+#define WDMA_RESP_ERR		0x1098
+#define UPT_PKT_SYNC		0x10a8
+#define RCHN_CFG		0x10ac
+#define WCHN_CFG		0x10b0
+#define MEM_PD_CFG		0x10b4
+#define MEM_BUS_CFG		0x10b8
+#define DMA_GMV_CFG		0x10bc
+#define DMA_GMR_CFG		0x10c0
+
+#define MAX_CHAN_ID		32
+#define SG_MAX_LEN		GENMASK(26, 0)
+
+struct aml_dma_sg_link {
+#define LINK_LEN		GENMASK(26, 0)
+#define LINK_IRQ		BIT(27)
+#define LINK_EOC		BIT(28)
+#define LINK_LOOP		BIT(29)
+#define LINK_ERR		BIT(30)
+#define LINK_OWNER		BIT(31)
+	u32 ctl;
+	u32 addr_low;
+	u32 addr_high;
+	u32 revered;
+} __packed;
+
+/* 1 page for link 256*16 */
+#define DMA_MAX_LINK		256
+/* sizeof(struct aml_dma_sg_link) */
+#define DMA_LINK_SIZE		16
+#define DMA_LINK_MAX_SIZE	(DMA_LINK_SIZE * DMA_MAX_LINK)
+
+struct aml_dma_desc {
+	struct virt_dma_desc		vd;
+	struct aml_dma_sg_link		*sg_link;
+	struct dma_device		*dma_device;
+	dma_addr_t			sg_link_phys;
+	size_t				sg_link_size;
+	u32				data_len;
+};
+
+struct aml_dma_chan {
+	struct virt_dma_chan		vchan;
+	struct aml_dma_dev		*aml_dma;
+	struct aml_dma_desc		*cur_desc;
+	enum dma_status			pre_status;
+	enum dma_status			status;
+	enum dma_transfer_direction	direction;
+	int				chan_id;
+	/* reg_base (direction + chan_id) */
+	int				reg_offs;
+	/* When there are multiple consecutive transmission errors, this chanel halt */
+	int				err_num;
+};
+
+struct aml_dma_dev {
+	struct dma_device		dma_device;
+	void __iomem			*base;
+	struct regmap			*regmap;
+	struct clk			*clk;
+	int				irq;
+	struct platform_device		*pdev;
+	struct aml_dma_chan		*aml_rch[MAX_CHAN_ID];
+	struct aml_dma_chan		*aml_wch[MAX_CHAN_ID];
+	unsigned int			chan_nr;
+	unsigned int			chan_used;
+	struct aml_dma_chan		aml_chans[]__counted_by(chan_nr);
+};
+
+static inline struct aml_dma_chan *to_aml_dma_chan(struct dma_chan *chan)
+{
+	return container_of(chan, struct aml_dma_chan, vchan.chan);
+}
+
+static inline struct aml_dma_desc *to_aml_dma_desc(struct virt_dma_desc *vd)
+{
+	return container_of(vd, struct aml_dma_desc, vd);
+}
+
+static void aml_dma_free_desc(struct virt_dma_desc *vd)
+{
+	struct aml_dma_desc *aml_desc = to_aml_dma_desc(vd);
+
+	dma_free_coherent(aml_desc->dma_device->dev,
+			  aml_desc->sg_link_size,
+			  aml_desc->sg_link,
+			  aml_desc->sg_link_phys);
+	kfree(aml_desc);
+}
+
+static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+
+	/* offset is the same RCH_CFG and WCH_CFG */
+	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR);
+	regmap_clear_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
+	regmap_clear_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR);
+
+	aml_chan->status = DMA_COMPLETE;
+	aml_chan->cur_desc = NULL;
+	aml_chan->err_num = 0;
+
+	return 0;
+}
+
+static void aml_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	struct virt_dma_desc *cur_vd = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
+	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
+	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR);
+	if (aml_chan->cur_desc)
+		cur_vd = &aml_chan->cur_desc->vd;
+	aml_chan->cur_desc = NULL;
+	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
+	if (cur_vd)
+		aml_dma_free_desc(cur_vd);
+
+	vchan_free_chan_resources(&aml_chan->vchan);
+}
+
+/* DMA transfer state  update how many data reside it */
+static enum dma_status aml_dma_tx_status(struct dma_chan *chan,
+					 dma_cookie_t cookie,
+					 struct dma_tx_state *txstate)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	struct aml_dma_desc *aml_desc = NULL;
+	struct virt_dma_desc *vd;
+	u32 residue = 0, done;
+	unsigned long flags;
+	enum dma_status ret;
+
+	ret = dma_cookie_status(chan, cookie, txstate);
+	if (ret == DMA_COMPLETE || !txstate)
+		return ret;
+
+	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
+	vd = vchan_find_desc(&aml_chan->vchan, cookie);
+	if (vd) {
+		aml_desc = to_aml_dma_desc(vd);
+		residue = aml_desc->data_len;
+	} else if (aml_chan->cur_desc && aml_chan->cur_desc->vd.tx.cookie == cookie) {
+		aml_desc = aml_chan->cur_desc;
+		regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &done);
+		residue = aml_desc->data_len - done;
+	} else {
+		dev_err(aml_dma->dma_device.dev, "cookie error\n");
+	}
+	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
+
+	dma_set_residue(txstate, residue);
+
+	return ret;
+}
+
+static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
+		(struct dma_chan *chan, struct scatterlist *sgl,
+		unsigned int sg_len, enum dma_transfer_direction direction,
+		unsigned long flags, void *context)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	struct aml_dma_desc *aml_desc = NULL;
+	struct aml_dma_sg_link *sg_link = NULL;
+	struct scatterlist *sg = NULL;
+	u64 paddr;
+	u32 link_count, avail;
+	u32 i;
+
+	if (aml_chan->direction != direction) {
+		dev_err(aml_dma->dma_device.dev, "direction not support\n");
+		return NULL;
+	}
+
+	link_count = sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
+	if (link_count == 0)
+		return NULL;
+
+	aml_desc = kzalloc_obj(*aml_desc, GFP_NOWAIT);
+	if (!aml_desc)
+		return NULL;
+	aml_desc->sg_link_size = link_count * sizeof(*sg_link);
+	aml_desc->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev, aml_desc->sg_link_size,
+					       &aml_desc->sg_link_phys, GFP_NOWAIT);
+	if (!aml_desc->sg_link) {
+		kfree(aml_desc);
+		return NULL;
+	}
+	aml_desc->dma_device = &aml_dma->dma_device;
+
+	sg_link = aml_desc->sg_link;
+	for_each_sg(sgl, sg, sg_len, i) {
+		avail = sg_dma_len(sg);
+		paddr = sg->dma_address;
+		while (avail > SG_MAX_LEN) {
+			/* set dma address and len to sglink*/
+			sg_link->addr_low = lower_32_bits(paddr);
+			sg_link->addr_high = upper_32_bits(paddr);
+			sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
+			paddr = paddr + SG_MAX_LEN;
+			avail = avail - SG_MAX_LEN;
+			sg_link++;
+		}
+		/* set dma address and len to sglink*/
+		sg_link->addr_low = lower_32_bits(paddr);
+		sg_link->addr_high = upper_32_bits(paddr);
+		sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
+
+		aml_desc->data_len += sg_dma_len(sg);
+		sg_link++;
+	}
+
+	/* the last sg set eoc flag */
+	sg_link--;
+	sg_link->ctl |= LINK_EOC;
+
+	return vchan_tx_prep(&aml_chan->vchan, &aml_desc->vd, flags);
+}
+
+static int aml_dma_chan_pause(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	unsigned long flags;
+
+	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
+	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
+	aml_chan->pre_status = aml_chan->status;
+	aml_chan->status = DMA_PAUSED;
+	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
+
+	return 0;
+}
+
+static int aml_dma_chan_resume(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	unsigned long flags;
+
+	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
+	regmap_clear_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
+	aml_chan->status = aml_chan->pre_status;
+	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
+
+	return 0;
+}
+
+static int aml_dma_terminate_all(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	int chan_id = aml_chan->chan_id;
+	struct virt_dma_desc *cur_vd;
+	unsigned long flags;
+	LIST_HEAD(head);
+
+	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
+	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
+	regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR);
+
+	if (aml_chan->direction == DMA_MEM_TO_DEV)
+		regmap_set_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id));
+	else if (aml_chan->direction == DMA_DEV_TO_MEM)
+		regmap_set_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id));
+
+	vchan_get_all_descriptors(&aml_chan->vchan, &head);
+	cur_vd = &aml_chan->cur_desc->vd;
+	aml_chan->cur_desc = NULL;
+	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
+	if (cur_vd)
+		aml_dma_free_desc(cur_vd);
+
+	vchan_dma_desc_free_list(&aml_chan->vchan, &head);
+
+	regmap_clear_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
+	regmap_clear_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR);
+
+	return 0;
+}
+
+static void aml_dma_start(struct aml_dma_chan *aml_chan)
+{
+	struct virt_dma_desc *vd = vchan_next_desc(&aml_chan->vchan);
+	struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
+	struct aml_dma_desc *aml_desc = NULL;
+	int chan_id = aml_chan->chan_id;
+
+	if (aml_chan->status == DMA_ERROR) {
+		if (aml_chan->err_num > 5) {
+			dev_err(aml_dma->dma_device.dev, "hw error\n");
+			return;
+		}
+		regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
+		regmap_set_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR);
+		aml_chan->err_num++;
+		regmap_clear_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE);
+		regmap_clear_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR);
+		aml_chan->status = DMA_COMPLETE;
+	} else {
+		aml_chan->err_num = 0;
+	}
+
+	if (!vd)
+		return;
+
+	if (aml_chan->status != DMA_COMPLETE)
+		return;
+
+	list_del(&vd->node);
+	aml_desc = to_aml_dma_desc(vd);
+	aml_chan->cur_desc = aml_desc;
+
+	if (aml_chan->direction == DMA_MEM_TO_DEV) {
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR,
+			     lower_32_bits(aml_desc->sg_link_phys));
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_ADDR_HIGH,
+			     upper_32_bits(aml_desc->sg_link_phys));
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_LEN, aml_desc->data_len);
+		regmap_clear_bits(aml_dma->regmap, RCH_INT_MASK, BIT(chan_id));
+		/* for rch (tx) need set cfg 0 to trigger start */
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, 0);
+	} else if (aml_chan->direction == DMA_DEV_TO_MEM) {
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR,
+			     lower_32_bits(aml_desc->sg_link_phys));
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_ADDR_HIGH,
+			     upper_32_bits(aml_desc->sg_link_phys));
+		regmap_write(aml_dma->regmap, aml_chan->reg_offs + WCH_LEN, aml_desc->data_len);
+		regmap_clear_bits(aml_dma->regmap, WCH_INT_MASK, BIT(chan_id));
+	}
+}
+
+static void aml_dma_issue_pending(struct dma_chan *chan)
+{
+	struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
+	unsigned long flags;
+
+	spin_lock_irqsave(&aml_chan->vchan.lock, flags);
+	if (vchan_issue_pending(&aml_chan->vchan) && !aml_chan->cur_desc)
+		aml_dma_start(aml_chan);
+	spin_unlock_irqrestore(&aml_chan->vchan.lock, flags);
+}
+
+static irqreturn_t aml_dma_interrupt_handler(int irq, void *dev_id)
+{
+	struct aml_dma_dev *aml_dma = dev_id;
+	struct aml_dma_chan *aml_chan;
+	struct aml_dma_desc *aml_desc;
+	u32 done, eoc_done, err, err_l, end;
+	u32 cpl_data;
+	int i = 0;
+
+	/* deal with rch normal complete and error */
+	regmap_read(aml_dma->regmap, RCH_DONE, &done);
+	regmap_read(aml_dma->regmap, RCH_ERR, &err);
+	regmap_read(aml_dma->regmap, RCH_LEN_ERR, &err_l);
+	err = err | err_l;
+
+	done = done | err;
+
+	while (done) {
+		i = ffs(done) - 1;
+		regmap_write(aml_dma->regmap, CLEAR_RCH, BIT(i));
+		done &= ~BIT(i);
+		aml_chan = aml_dma->aml_rch[i];
+		if (!aml_chan) {
+			dev_err(aml_dma->dma_device.dev, "idx %d rch not initialized\n", i);
+			continue;
+		}
+		spin_lock(&aml_chan->vchan.lock);
+		aml_chan->status = (err & BIT(i)) ? DMA_ERROR : DMA_COMPLETE;
+		aml_desc = aml_chan->cur_desc;
+		if (!aml_desc) {
+			spin_unlock(&aml_chan->vchan.lock);
+			continue;
+		}
+		if (aml_chan->status == DMA_ERROR) {
+			aml_desc->vd.tx_result.result = DMA_TRANS_READ_FAILED;
+			regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &cpl_data);
+			aml_desc->vd.tx_result.residue = aml_desc->data_len - cpl_data;
+		}
+		vchan_cookie_complete(&aml_desc->vd);
+		aml_chan->cur_desc = NULL;
+		aml_dma_start(aml_chan);
+		spin_unlock(&aml_chan->vchan.lock);
+	}
+
+	/* deal with wch normal complete and error */
+	regmap_read(aml_dma->regmap, DMA_BATCH_END, &end);
+	if (end)
+		regmap_write(aml_dma->regmap, CLEAR_W_BATCH, end);
+
+	regmap_read(aml_dma->regmap, WCH_DONE, &done);
+	regmap_read(aml_dma->regmap, WCH_EOC_DONE, &eoc_done);
+	done = done | eoc_done;
+
+	regmap_read(aml_dma->regmap, WCH_ERR, &err);
+	regmap_read(aml_dma->regmap, WDMA_RESP_ERR, &err_l);
+	err = err | err_l;
+
+	done = done | err;
+	i = 0;
+	while (done) {
+		i = ffs(done) - 1;
+		done &= ~BIT(i);
+		regmap_write(aml_dma->regmap, CLEAR_WCH, BIT(i));
+		aml_chan = aml_dma->aml_wch[i];
+		if (!aml_chan) {
+			dev_err(aml_dma->dma_device.dev, "idx %d wch not initialized\n", i);
+			continue;
+		}
+		spin_lock(&aml_chan->vchan.lock);
+		aml_chan->status = (err & BIT(i)) ? DMA_ERROR : DMA_COMPLETE;
+		aml_desc = aml_chan->cur_desc;
+		if (!aml_desc) {
+			spin_unlock(&aml_chan->vchan.lock);
+			continue;
+		}
+		if (aml_chan->status == DMA_ERROR) {
+			aml_desc->vd.tx_result.result = DMA_TRANS_WRITE_FAILED;
+			regmap_read(aml_dma->regmap, aml_chan->reg_offs + RCH_RD_LEN, &cpl_data);
+			aml_desc->vd.tx_result.residue = aml_desc->data_len - cpl_data;
+		}
+		vchan_cookie_complete(&aml_desc->vd);
+		aml_chan->cur_desc = NULL;
+		aml_dma_start(aml_chan);
+		spin_unlock(&aml_chan->vchan.lock);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static struct dma_chan *aml_of_dma_xlate(struct of_phandle_args *dma_spec, struct of_dma *ofdma)
+{
+	struct aml_dma_dev *aml_dma = (struct aml_dma_dev *)ofdma->of_dma_data;
+	struct aml_dma_chan *aml_chan = NULL;
+	u32 type;
+	u32 phy_chan_id;
+
+	if (dma_spec->args_count != 2)
+		return NULL;
+
+	type = dma_spec->args[0];
+	phy_chan_id = dma_spec->args[1];
+
+	if (phy_chan_id >= MAX_CHAN_ID)
+		return NULL;
+
+	if (type == DMA_TX) {
+		aml_chan = aml_dma->aml_rch[phy_chan_id];
+		if (!aml_chan) {
+			if (aml_dma->chan_used >= aml_dma->chan_nr) {
+				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
+				return NULL;
+			}
+			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
+			aml_dma->chan_used++;
+			aml_chan->direction = DMA_MEM_TO_DEV;
+			aml_chan->chan_id = phy_chan_id;
+			aml_chan->reg_offs = RCH_REG_BASE + 0x40 * aml_chan->chan_id;
+			aml_dma->aml_rch[phy_chan_id] = aml_chan;
+		}
+	} else if (type == DMA_RX) {
+		aml_chan = aml_dma->aml_wch[phy_chan_id];
+		if (!aml_chan) {
+			if (aml_dma->chan_used >= aml_dma->chan_nr) {
+				dev_err(aml_dma->dma_device.dev, "some dma clients err used\n");
+				return NULL;
+			}
+			aml_chan = &aml_dma->aml_chans[aml_dma->chan_used];
+			aml_dma->chan_used++;
+			aml_chan->direction = DMA_DEV_TO_MEM;
+			aml_chan->chan_id = phy_chan_id;
+			aml_chan->reg_offs = WCH_REG_BASE + 0x40 * aml_chan->chan_id;
+			aml_dma->aml_wch[phy_chan_id] = aml_chan;
+		}
+	} else {
+		dev_err(aml_dma->dma_device.dev, "type %d not supported\n", type);
+		return NULL;
+	}
+
+	return dma_get_slave_channel(&aml_chan->vchan.chan);
+}
+
+static int aml_dma_probe(struct platform_device *pdev)
+{
+	struct device_node *np = pdev->dev.of_node;
+	struct dma_device *dma_dev;
+	struct aml_dma_dev *aml_dma;
+	int ret, i, len;
+	u32 chan_nr;
+
+	const struct regmap_config aml_regmap_config = {
+		.reg_bits = 32,
+		.val_bits = 32,
+		.reg_stride = 4,
+		.max_register = 0x3000,
+	};
+
+	ret = of_property_read_u32(np, "dma-channels", &chan_nr);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to read dma-channels\n");
+	if (chan_nr > (MAX_CHAN_ID * 2))
+		return dev_err_probe(&pdev->dev, -EINVAL, "dma-channels unusual\n");
+
+	len = sizeof(struct aml_dma_dev) + sizeof(struct aml_dma_chan) * chan_nr;
+	aml_dma = devm_kzalloc(&pdev->dev, len, GFP_KERNEL);
+	if (!aml_dma)
+		return -ENOMEM;
+
+	aml_dma->chan_nr = chan_nr;
+
+	aml_dma->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(aml_dma->base))
+		return PTR_ERR(aml_dma->base);
+
+	aml_dma->regmap = devm_regmap_init_mmio(&pdev->dev, aml_dma->base,
+						&aml_regmap_config);
+	if (IS_ERR_OR_NULL(aml_dma->regmap))
+		return PTR_ERR(aml_dma->regmap);
+
+	aml_dma->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(aml_dma->clk))
+		return PTR_ERR(aml_dma->clk);
+
+	aml_dma->irq = platform_get_irq(pdev, 0);
+
+	aml_dma->pdev = pdev;
+	aml_dma->dma_device.dev = &pdev->dev;
+
+	dma_dev = &aml_dma->dma_device;
+	INIT_LIST_HEAD(&dma_dev->channels);
+
+	/* Initialize channel parameters */
+	for (i = 0; i < chan_nr; i++) {
+		struct aml_dma_chan *aml_chan = &aml_dma->aml_chans[i];
+
+		aml_chan->aml_dma = aml_dma;
+		aml_chan->vchan.desc_free = aml_dma_free_desc;
+		vchan_init(&aml_chan->vchan, &aml_dma->dma_device);
+	}
+	aml_dma->chan_used = 0;
+
+	dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
+	dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
+	dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
+	dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
+	dma_dev->device_tx_status = aml_dma_tx_status;
+	dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
+	dma_dev->device_pause = aml_dma_chan_pause;
+	dma_dev->device_resume = aml_dma_chan_resume;
+	dma_dev->device_terminate_all = aml_dma_terminate_all;
+	dma_dev->device_issue_pending = aml_dma_issue_pending;
+	/* PIO 4 bytes and I2C 1 byte */
+	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
+	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
+	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
+
+	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
+	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
+
+	ret = devm_request_irq(&pdev->dev, aml_dma->irq, aml_dma_interrupt_handler,
+			       0, dev_name(&pdev->dev), aml_dma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register irq\n");
+
+	ret = dmaenginem_async_device_register(dma_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register dmaenginem\n");
+
+	ret = of_dma_controller_register(np, aml_of_dma_xlate, aml_dma);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "failed to register xlate\n");
+
+	platform_set_drvdata(pdev, aml_dma);
+
+	return 0;
+}
+
+static void aml_dma_remove(struct platform_device *pdev)
+{
+	struct aml_dma_dev *aml_dma = platform_get_drvdata(pdev);
+	struct aml_dma_chan *aml_chan = NULL;
+	int i;
+
+	of_dma_controller_free((&pdev->dev)->of_node);
+
+	regmap_write(aml_dma->regmap, RCH_INT_MASK, 0xffffffff);
+	regmap_write(aml_dma->regmap, WCH_INT_MASK, 0xffffffff);
+
+	for (i = 0; i < MAX_CHAN_ID; i++) {
+		aml_chan = aml_dma->aml_rch[i];
+		if (aml_chan)
+			tasklet_kill(&aml_chan->vchan.task);
+		aml_chan = aml_dma->aml_wch[i];
+		if (aml_chan)
+			tasklet_kill(&aml_chan->vchan.task);
+	}
+}
+
+static const struct of_device_id aml_dma_ids[] = {
+	{ .compatible = "amlogic,a9-dma", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, aml_dma_ids);
+
+static struct platform_driver aml_dma_driver = {
+	.probe		= aml_dma_probe,
+	.remove		= aml_dma_remove,
+	.driver		= {
+		.name	= "aml-dma",
+		.of_match_table = aml_dma_ids,
+	},
+};
+
+module_platform_driver(aml_dma_driver);
+
+MODULE_DESCRIPTION("GENERAL DMA driver for Amlogic");
+MODULE_AUTHOR("Xianwei Zhao <xianwei.zhao@amlogic.com>");
+MODULE_LICENSE("GPL");

-- 
2.52.0



