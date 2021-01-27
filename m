Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81178305A13
	for <lists+dmaengine@lfdr.de>; Wed, 27 Jan 2021 12:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhA0Llz (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Wed, 27 Jan 2021 06:41:55 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236703AbhA0L35 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Wed, 27 Jan 2021 06:29:57 -0500
X-UUID: 70c8faca70bb4ae7bf2bc637281d644b-20210127
X-UUID: 70c8faca70bb4ae7bf2bc637281d644b-20210127
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <eastl.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1648497017; Wed, 27 Jan 2021 19:28:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 27 Jan 2021 19:28:49 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 27 Jan 2021 19:28:49 +0800
From:   EastL Lee <EastL.Lee@mediatek.com>
To:     Sean Wang <sean.wang@mediatek.com>
CC:     <vkoul@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <matthias.bgg@gmail.com>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <wsd_upstream@mediatek.com>, <cc.hwang@mediatek.com>,
        <joane.wang@mediatek.com>, <adrian-cj.hung@mediatek.com>,
        EastL Lee <EastL.Lee@mediatek.com>
Subject: [PATCH v1 1/3] memory: Add support for MediaTek External Memory Interface driver
Date:   Wed, 27 Jan 2021 19:28:42 +0800
Message-ID: <1611746924-12287-2-git-send-email-EastL.Lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1611746924-12287-1-git-send-email-EastL.Lee@mediatek.com>
References: <1611746924-12287-1-git-send-email-EastL.Lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

MediaTek External Memory Interface(emi) on MT6779 SoC controls all the
transitions from master to dram, there are emi-cen & emi-mpu drivers.

emi-cen driver provides phy addr to dram rank, bank, column and other
information, as well as the currently used dram channel number, rank
number, rank size.

emi-mpu (memory protect unit) driver provides an interface to set emi
regions, need to enter the secure world setting and the violation irq
isr will collect mpu violation information, after all regions have
protected their respective regions, emi-mpu will set the ap region to
protect all the remaining dram.

Signed-off-by: EastL Lee <EastL.Lee@mediatek.com>
---
 drivers/memory/Kconfig                   |    1 +
 drivers/memory/Makefile                  |    1 +
 drivers/memory/mediatek/Kconfig          |   23 +
 drivers/memory/mediatek/Makefile         |    4 +
 drivers/memory/mediatek/emi-cen.c        | 1305 ++++++++++++++++++++++++++++++
 drivers/memory/mediatek/emi-mpu.c        |  908 +++++++++++++++++++++
 include/linux/soc/mediatek/mtk_sip_svc.h |    3 +
 include/soc/mediatek/emi.h               |  101 +++
 8 files changed, 2346 insertions(+)
 create mode 100644 drivers/memory/mediatek/Kconfig
 create mode 100644 drivers/memory/mediatek/Makefile
 create mode 100644 drivers/memory/mediatek/emi-cen.c
 create mode 100644 drivers/memory/mediatek/emi-mpu.c
 create mode 100644 include/soc/mediatek/emi.h

diff --git a/drivers/memory/Kconfig b/drivers/memory/Kconfig
index 00e013b..1339884 100644
--- a/drivers/memory/Kconfig
+++ b/drivers/memory/Kconfig
@@ -218,5 +218,6 @@ config STM32_FMC2_EBI
 
 source "drivers/memory/samsung/Kconfig"
 source "drivers/memory/tegra/Kconfig"
+source "drivers/memory/mediatek/Kconfig"
 
 endif
diff --git a/drivers/memory/Makefile b/drivers/memory/Makefile
index e71cf7b..e3ac040 100644
--- a/drivers/memory/Makefile
+++ b/drivers/memory/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_RENESAS_RPCIF)	+= renesas-rpc-if.o
 obj-$(CONFIG_STM32_FMC2_EBI)	+= stm32-fmc2-ebi.o
 
 obj-$(CONFIG_SAMSUNG_MC)	+= samsung/
+obj-$(CONFIG_HAVE_MTK_MC)       += mediatek/
 obj-$(CONFIG_TEGRA_MC)		+= tegra/
 obj-$(CONFIG_TI_EMIF_SRAM)	+= ti-emif-sram.o
 ti-emif-sram-objs		:= ti-emif-pm.o ti-emif-sram-pm.o
diff --git a/drivers/memory/mediatek/Kconfig b/drivers/memory/mediatek/Kconfig
new file mode 100644
index 0000000..37535bb
--- /dev/null
+++ b/drivers/memory/mediatek/Kconfig
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config HAVE_MTK_MC
+	bool "MediaTek Memory Controller support"
+	select MTK_EMI
+	help
+	  Support for the Memory Controller (MC) devices found on
+	  MediaTek(R) SoCs.
+	  This config enables MTK_EMI and MTK_DRAMC for EMI and
+	  DRAMC drivers.
+
+if HAVE_MTK_MC
+
+config MTK_EMI
+	tristate "MediaTek External Memory Interface driver"
+	depends on HAVE_MTK_MC
+	help
+	  This selects the MediaTek(R) EMI driver.
+	  Provide the API for MPU registration, EMI MPU violation handling,
+	  the API for EMI information, the BWL golden setting,
+	  and the sysfs for EMI ISU control.
+
+endif
diff --git a/drivers/memory/mediatek/Makefile b/drivers/memory/mediatek/Makefile
new file mode 100644
index 0000000..22947c1
--- /dev/null
+++ b/drivers/memory/mediatek/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MTK_EMI) += emi.o
+emi-objs := emi-cen.o
+obj-$(CONFIG_MTK_EMI) += emi-mpu.o
diff --git a/drivers/memory/mediatek/emi-cen.c b/drivers/memory/mediatek/emi-cen.c
new file mode 100644
index 0000000..6cdb4b1
--- /dev/null
+++ b/drivers/memory/mediatek/emi-cen.c
@@ -0,0 +1,1305 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <soc/mediatek/emi.h>
+
+/*
+ * EMI address-to-dram setting's structure.
+ * a2d is the abbreviation of addr2dram.
+ * s6s is the abbreviation of settings.
+ */
+struct a2d_s6s_v1 {
+	unsigned int magics[8];
+	unsigned long cas;
+	unsigned long chab_rk0_sz, chab_rk1_sz;
+	unsigned long chcd_rk0_sz, chcd_rk1_sz;
+	unsigned int channels;
+	unsigned int dualrk_ch0, dualrk_ch1;
+	unsigned int chn_hash_lsb, chnpos;
+	unsigned int chab_row_mask[2], chcd_row_mask[2];
+	unsigned int chab_col_mask[2], chcd_col_mask[2];
+	unsigned int dw32;
+	unsigned int chn_4bank_mode;
+};
+
+struct a2d_s6s_v2 {
+	unsigned int chn_bit_position;
+	unsigned int chn_en;
+	unsigned int magics[8];
+
+	unsigned int dual_rank_en;
+	unsigned int dw32_en;
+	unsigned int bg1_bk3_pos;
+	unsigned int rank_pos;
+	unsigned int magics2[7];
+	unsigned int rank0_row_width, rank0_bank_width, rank0_col_width;
+	unsigned int rank0_size_MB, rank0_bg_16bank_mode;
+	unsigned int rank1_row_width, rank1_bank_width, rank1_col_width;
+	unsigned int rank1_size_MB, rank1_bg_16bank_mode;
+};
+
+struct emi_cen {
+	/*
+	 * EMI setting from device tree
+	 */
+	int ver;
+	unsigned int emi_cen_cnt;
+	unsigned int ch_cnt;
+	unsigned int rk_cnt;
+	unsigned long long *rk_size;
+	void __iomem **emi_cen_base;
+	void __iomem **emi_chn_base;
+
+	/* address from the sysfs file for EMI addr2dram */
+	unsigned long a2d_addr;
+
+	/*
+	 * EMI addr2dram settings from device tree
+	 */
+	unsigned int disph;
+	unsigned int hash;
+
+	/*
+	 * EMI addr2dram settings calculated at run time
+	 */
+	unsigned long offset;
+	unsigned long max;
+	union {
+		struct a2d_s6s_v1 v1;
+		struct a2d_s6s_v2 v2;
+	} a2d_s6s;
+};
+
+#define EMI_CONA_DW32_EN 1
+#define EMI_CONA_CHN_POS_0 2
+#define EMI_CONA_CHN_POS_1 3
+#define EMI_CONA_COL 4
+#define EMI_CONA_COL2ND 6
+#define EMI_CONA_CHN_EN 8
+#define EMI_CONA_ROW 12
+#define EMI_CONA_ROW2ND 14
+#define EMI_CONA_DUAL_RANK_EN_CHN1 16
+#define EMI_CONA_DUAL_RANK_EN 17
+#define EMI_CONA_CAS_SIZE 18
+#define EMI_CONA_CHN1_COL 20
+#define EMI_CONA_CHN1_COL2ND 22
+#define EMI_CONA_ROW_EXT0 24
+#define EMI_CONA_ROW2ND_EXT0 25
+#define EMI_CONA_CAS_SIZE_BIT3 26
+#define EMI_CONA_RANK_POS 27
+#define EMI_CONA_CHN1_ROW 28
+#define EMI_CONA_CHN1_ROW2ND 30
+
+#define EMI_CONH_CHN1_ROW_EXT0 4
+#define EMI_CONH_CHN1_ROW2ND_EXT0 5
+#define EMI_CONH_CHNAB_RANK0_SIZE 16
+#define EMI_CONH_CHNAB_RANK1_SIZE 20
+#define EMI_CONH_CHNCD_RANK0_SIZE 24
+#define EMI_CONH_CHNCD_RANK1_SIZE 28
+
+#define EMI_CONH_2ND_CHN_4BANK_MODE 6
+
+#define EMI_CONK_CHNAB_RANK0_SIZE_EXT 16
+#define EMI_CONK_CHNAB_RANK1_SIZE_EXT 20
+#define EMI_CONK_CHNCD_RANK0_SIZE_EXT 24
+#define EMI_CONK_CHNCD_RANK1_SIZE_EXT 28
+
+#define EMI_CHN_CONA_DUAL_RANK_EN 0
+#define EMI_CHN_CONA_DW32_EN 1
+#define EMI_CHN_CONA_ROW_EXT0 2
+#define EMI_CHN_CONA_ROW2ND_EXT0 3
+#define EMI_CHN_CONA_COL 4
+#define EMI_CHN_CONA_COL2ND 6
+#define EMI_CHN_CONA_RANK0_SIZE_EXT 8
+#define EMI_CHN_CONA_RANK1_SIZE_EXT 9
+#define EMI_CHN_CONA_16BANK_MODE 10
+#define EMI_CHN_CONA_16BANK_MODE_2ND 11
+#define EMI_CHN_CONA_ROW 12
+#define EMI_CHN_CONA_ROW2ND 14
+#define EMI_CHN_CONA_RANK0_SZ 16
+#define EMI_CHN_CONA_RANK1_SZ 20
+#define EMI_CHN_CONA_4BANK_MODE 24
+#define EMI_CHN_CONA_4BANK_MODE_2ND 25
+#define EMI_CHN_CONA_RANK_POS 27
+#define EMI_CHN_CONA_BG1_BK3_POS 31
+
+#define MTK_EMI_DRAM_OFFSET 0x40000000
+#define MTK_EMI_HASH 0x7
+#define MTK_EMI_DISPATCH 0x0
+
+static unsigned int emi_a2d_con_offset[] = {
+	/* central EMI CONA, CONF, CONH, CONH_2ND, CONK */
+	0x00, 0x28, 0x38, 0x3c, 0x50
+};
+
+static unsigned int emi_a2d_chn_con_offset[] = {
+	/* channel EMI CONA, CONC, CONC_2ND */
+	0x00, 0x10, 0x14
+};
+
+/* global pointer for exported functions */
+static struct emi_cen *global_emi_cen;
+
+/*
+ * NoteXXX: emimpu_ap_region_init() will initialize the latest EMI MPU
+ * region for AP CPU. It must be called after initialization of drivers
+ * in which call mtk_emimpu_set_protection() to initialize other EMI
+ * MPU regions.
+ *
+ * For guaranteeing the call sequence, emimpu_ap_region_init() is
+ * either called via late_initcall_sync (when EMI drivers are not built
+ * as kernel modules) or called in emicen_init() (When EMI drivers are
+ * kernel modules).
+ *
+ * Scenario #1: EMI drivers are kernel modules:
+ * Other drivers (which call mtk_emimpu_set_protection()) must be
+ * loaded before emi-cen.ko is loaded.
+ *
+ * Scenario #2. EMI drivers are NOT kernel modules:
+ * Other drivers must be initialized before kernel's initcall stage.
+ */
+#if !defined(MODULE)
+static void __init emicen_init_mpu_ap_region(void)
+{
+	emimpu_ap_region_init();
+}
+late_initcall_sync(emicen_init_mpu_ap_region);
+#endif
+
+/*
+ * mtk_emicen_get_ch_cnt - get the channel count
+ *
+ * Returns the channel count
+ */
+unsigned int mtk_emicen_get_ch_cnt(void)
+{
+	return (global_emi_cen) ? global_emi_cen->ch_cnt : 0;
+}
+EXPORT_SYMBOL(mtk_emicen_get_ch_cnt);
+
+/*
+ * mtk_emicen_get_rk_cnt - get the rank count
+ *
+ * Returns the rank count
+ */
+unsigned int mtk_emicen_get_rk_cnt(void)
+{
+	return (global_emi_cen) ? global_emi_cen->rk_cnt : 0;
+}
+EXPORT_SYMBOL(mtk_emicen_get_rk_cnt);
+
+/*
+ * mtk_emicen_get_rk_size - get the rank size of target rank
+ * @rk_id: the id of target rank
+ *
+ * Returns the rank size of target rank
+ */
+unsigned int mtk_emicen_get_rk_size(unsigned int rk_id)
+{
+	if (rk_id < mtk_emicen_get_rk_cnt())
+		return (global_emi_cen) ? global_emi_cen->rk_size[rk_id] : 0;
+	else
+		return 0;
+}
+EXPORT_SYMBOL(mtk_emicen_get_rk_size);
+
+/*
+ * prepare_a2d_v1: a helper function to initialize and calculate settings for
+ *                 the mtk_emicen_addr2dram_v1() function
+ *
+ * There is no code comment for the translation. This is intended since
+ * the fomular of translation is derived from the implementation of EMI.
+ */
+static inline void prepare_a2d_v1(struct emi_cen *cen)
+{
+	const unsigned int mask_4b = 0xf, mask_2b = 0x3;
+	void __iomem *emi_cen_base;
+	struct a2d_s6s_v1 *s6s;
+	unsigned long emi_cona;
+	unsigned long emi_conf;
+	unsigned long emi_conh;
+	unsigned long emi_conh_2nd;
+	unsigned long emi_conk;
+	unsigned long tmp;
+
+	if (!cen)
+		return;
+
+	emi_cen_base = cen->emi_cen_base[0];
+	s6s = &cen->a2d_s6s.v1;
+
+	emi_cona = readl(emi_cen_base + emi_a2d_con_offset[0]);
+	emi_conf = readl(emi_cen_base + emi_a2d_con_offset[1]);
+	emi_conh = readl(emi_cen_base + emi_a2d_con_offset[2]);
+	emi_conh_2nd = readl(emi_cen_base + emi_a2d_con_offset[3]);
+	emi_conk = readl(emi_cen_base + emi_a2d_con_offset[4]);
+
+	cen->offset = MTK_EMI_DRAM_OFFSET;
+
+	s6s->magics[0] = emi_conf & mask_4b;
+	s6s->magics[1] = (emi_conf >> 4) & mask_4b;
+	s6s->magics[2] = (emi_conf >> 8) & mask_4b;
+	s6s->magics[3] = (emi_conf >> 12) & mask_4b;
+	s6s->magics[4] = (emi_conf >> 16) & mask_4b;
+	s6s->magics[5] = (emi_conf >> 20) & mask_4b;
+	s6s->magics[6] = (emi_conf >> 24) & mask_4b;
+	s6s->magics[7] = (emi_conf >> 28) & mask_4b;
+
+	s6s->dw32 = test_bit(EMI_CONA_DW32_EN, &emi_cona) ? 1 : 0;
+
+	s6s->channels = (emi_cona >> EMI_CONA_CHN_EN) & mask_2b;
+
+	s6s->cas = (emi_cona >> EMI_CONA_CAS_SIZE) & mask_2b;
+	s6s->cas += s6s->dw32 << 2;
+	s6s->cas += ((emi_cona >> EMI_CONA_CAS_SIZE_BIT3) & 1) << 3;
+	s6s->cas = s6s->cas << 28;
+	s6s->cas = s6s->cas << s6s->channels;
+
+	s6s->dualrk_ch0 = test_bit(EMI_CONA_DUAL_RANK_EN, &emi_cona) ?  1 : 0;
+	s6s->dualrk_ch1 = test_bit(EMI_CONA_DUAL_RANK_EN_CHN1,
+				   &emi_cona) ? 1 : 0;
+
+	s6s->chn_hash_lsb = 7 + (cen->hash & (~(cen->hash) + 1));
+	if (cen->hash) {
+		s6s->chnpos = s6s->chn_hash_lsb;
+	} else {
+		s6s->chnpos = test_bit(EMI_CONA_CHN_POS_1, &emi_cona) ?  2 : 0;
+		s6s->chnpos |= test_bit(EMI_CONA_CHN_POS_0, &emi_cona) ?  1 : 0;
+	}
+
+	tmp = (emi_conh >> EMI_CONH_CHNAB_RANK0_SIZE) & mask_4b;
+	tmp += ((emi_conk >> EMI_CONK_CHNAB_RANK0_SIZE_EXT) & mask_4b) << 4;
+	if (tmp) {
+		s6s->chab_rk0_sz = tmp << 8;
+	} else {
+		tmp = (emi_cona >> EMI_CONA_COL) & mask_2b;
+		tmp += (emi_cona >> EMI_CONA_ROW) & mask_2b;
+		tmp += test_bit(EMI_CONA_ROW_EXT0, &emi_cona) ? 4 : 0;
+		tmp += s6s->dw32;
+		tmp += 7;
+		s6s->chab_rk0_sz = 1 << tmp;
+	}
+
+	tmp = (emi_conh >> EMI_CONH_CHNAB_RANK1_SIZE) & mask_4b;
+	tmp += ((emi_conk >> EMI_CONK_CHNAB_RANK1_SIZE_EXT) & mask_4b) << 4;
+	if (tmp) {
+		s6s->chab_rk1_sz = tmp << 8;
+	} else if (!test_bit(EMI_CONA_DUAL_RANK_EN, &emi_cona)) {
+		s6s->chab_rk1_sz = 0;
+	} else {
+		tmp = (emi_cona >> EMI_CONA_COL2ND) & mask_2b;
+		tmp += (emi_cona >> EMI_CONA_ROW2ND) & mask_2b;
+		tmp += test_bit(EMI_CONA_ROW2ND_EXT0, &emi_cona) ? 4 : 0;
+		tmp += s6s->dw32;
+		tmp += 7;
+		s6s->chab_rk1_sz = 1 << tmp;
+	}
+
+	tmp = (emi_conh >> EMI_CONH_CHNCD_RANK0_SIZE) & mask_4b;
+	tmp += ((emi_conk >> EMI_CONK_CHNCD_RANK0_SIZE_EXT) & mask_4b) << 4;
+	if (tmp) {
+		s6s->chcd_rk0_sz = tmp << 8;
+	} else {
+		tmp = (emi_cona >> EMI_CONA_CHN1_COL) & mask_2b;
+		tmp += (emi_cona >> EMI_CONA_CHN1_ROW) & mask_2b;
+		tmp += test_bit(EMI_CONH_CHN1_ROW_EXT0, &emi_conh) ? 4 : 0;
+		tmp += s6s->dw32;
+		tmp += 7;
+		s6s->chcd_rk0_sz = 1 << tmp;
+	}
+
+	tmp = (emi_conh >> EMI_CONH_CHNCD_RANK1_SIZE) & mask_4b;
+	tmp += ((emi_conk >> EMI_CONK_CHNCD_RANK1_SIZE_EXT) & mask_4b) << 4;
+	if (tmp) {
+		s6s->chcd_rk1_sz = tmp << 8;
+	} else if (!test_bit(EMI_CONA_DUAL_RANK_EN_CHN1, &emi_cona)) {
+		s6s->chcd_rk1_sz = 0;
+	} else {
+		tmp = (emi_cona >> EMI_CONA_CHN1_COL2ND) & mask_2b;
+		tmp += (emi_cona >> EMI_CONA_CHN1_ROW2ND) & mask_2b;
+		tmp += test_bit(EMI_CONH_CHN1_ROW2ND_EXT0, &emi_conh) ? 4 : 0;
+		tmp += s6s->dw32;
+		tmp += 7;
+		s6s->chcd_rk1_sz = 1 << tmp;
+	}
+
+	cen->max = s6s->chab_rk0_sz + s6s->chab_rk1_sz;
+	cen->max += s6s->chcd_rk0_sz + s6s->chcd_rk0_sz;
+	if (s6s->channels > 1 || cen->disph > 0)
+		cen->max *= 2;
+	cen->max = cen->max << 20;
+
+	s6s->chab_row_mask[0] = (emi_cona >> EMI_CONA_ROW) & mask_2b;
+	s6s->chab_row_mask[0] += test_bit(EMI_CONA_ROW_EXT0,
+					&emi_cona) ? 4 : 0;
+	s6s->chab_row_mask[0] += 13;
+	s6s->chab_row_mask[1] = (emi_cona >> EMI_CONA_ROW2ND) & mask_2b;
+	s6s->chab_row_mask[1] += test_bit(EMI_CONA_ROW2ND_EXT0,
+					&emi_cona) ? 4 : 0;
+	s6s->chab_row_mask[1] += 13;
+
+	s6s->chcd_row_mask[0] = (emi_cona >> EMI_CONA_CHN1_ROW) & mask_2b;
+	s6s->chcd_row_mask[0] += test_bit(EMI_CONH_CHN1_ROW_EXT0,
+					&emi_conh) ? 4 : 0;
+	s6s->chcd_row_mask[0] += 13;
+	s6s->chcd_row_mask[1] = (emi_cona >> EMI_CONA_CHN1_ROW2ND) & mask_2b;
+	s6s->chcd_row_mask[1] += test_bit(EMI_CONH_CHN1_ROW2ND_EXT0,
+					&emi_conh) ? 4 : 0;
+	s6s->chcd_row_mask[1] += 13;
+
+	s6s->chab_col_mask[0] = (emi_cona >> EMI_CONA_COL) & mask_2b;
+	s6s->chab_col_mask[0] += 9;
+	s6s->chab_col_mask[1] = (emi_cona >> EMI_CONA_COL2ND) & mask_2b;
+	s6s->chab_col_mask[1] += 9;
+
+	s6s->chcd_col_mask[0] = (emi_cona >> EMI_CONA_CHN1_COL) & mask_2b;
+	s6s->chcd_col_mask[0] += 9;
+	s6s->chcd_col_mask[1] = (emi_cona >> EMI_CONA_CHN1_COL2ND) & mask_2b;
+	s6s->chcd_col_mask[1] += 9;
+
+	s6s->chn_4bank_mode = test_bit(EMI_CONH_2ND_CHN_4BANK_MODE,
+				       &emi_conh_2nd) ? 1 : 0;
+}
+
+/*
+ * use_a2d_magic_v1: a helper function to calculate the input address
+ *                   for the mtk_emicen_addr2dram_v1() function
+ *
+ * There is no code comment for the translation. This is intended since
+ * the fomular of translation is derived from the implementation of EMI.
+ */
+static inline unsigned int use_a2d_magic_v1(unsigned long addr,
+					    unsigned int bit)
+{
+	unsigned long magic;
+	unsigned int ret;
+
+	if (!global_emi_cen)
+		return 0;
+
+	magic = global_emi_cen->a2d_s6s.v1.magics[((bit >= 9) & (bit <= 16)) ?
+						(bit - 9) : 0];
+
+	ret = test_bit(bit, &addr) ? 1 : 0;
+	ret ^= (test_bit(16, &addr) && test_bit(0, &magic)) ? 1 : 0;
+	ret ^= (test_bit(17, &addr) && test_bit(1, &magic)) ? 1 : 0;
+	ret ^= (test_bit(18, &addr) && test_bit(2, &magic)) ? 1 : 0;
+	ret ^= (test_bit(19, &addr) && test_bit(3, &magic)) ? 1 : 0;
+
+	return ret;
+}
+
+/*
+ * mtk_emicen_addr2dram_v1 - Translate a physical address to
+ *                           a DRAM-point-of-view map for EMI v1
+ * @addr - input physical address
+ * @map - output map stored in struct emi_addr_map
+ *
+ * Return 0 on success, -1 on failures.
+ *
+ * There is no code comment for the translation. This is intended since
+ * the fomular of translation is derived from the implementation of EMI.
+ */
+static int mtk_emicen_addr2dram_v1(unsigned long addr,
+				   struct emi_addr_map *map)
+{
+	struct a2d_s6s_v1 *s6s;
+	unsigned long disph, hash;
+	unsigned long saddr, bfraddr, chnaddr;
+	unsigned long max_rk0_sz;
+	unsigned int tmp;
+	unsigned int chn_hash_lsb, row_mask, col_mask;
+	bool ch_ab_not_cd;
+
+	if (!global_emi_cen)
+		return -1;
+	if (!map)
+		return -1;
+	if (addr < global_emi_cen->offset)
+		return -1;
+
+	addr -= global_emi_cen->offset;
+	if (addr > global_emi_cen->max)
+		return -1;
+
+	map->emi = -1;
+	map->channel = -1;
+	map->rank = -1;
+	map->bank = -1;
+	map->row = -1;
+	map->column = -1;
+
+	s6s = &global_emi_cen->a2d_s6s.v1;
+	disph = global_emi_cen->disph;
+	hash = global_emi_cen->hash;
+	chn_hash_lsb = s6s->chn_hash_lsb;
+
+	tmp = (test_bit(8, &addr) & test_bit(0, &disph)) ? 1 : 0;
+	tmp ^= (test_bit(9, &addr) & test_bit(1, &disph)) ? 1 : 0;
+	tmp ^= (test_bit(10, &addr) & test_bit(2, &disph)) ? 1 : 0;
+	tmp ^= (test_bit(11, &addr) & test_bit(3, &disph)) ? 1 : 0;
+	map->emi = tmp;
+
+	saddr = addr;
+	clear_bit(9, &saddr);
+	clear_bit(10, &saddr);
+	clear_bit(11, &saddr);
+	clear_bit(12, &saddr);
+	clear_bit(13, &saddr);
+	clear_bit(14, &saddr);
+	clear_bit(15, &saddr);
+	clear_bit(16, &saddr);
+	saddr |= use_a2d_magic_v1(addr, 9) << 9;
+	saddr |= use_a2d_magic_v1(addr, 10) << 10;
+	saddr |= use_a2d_magic_v1(addr, 11) << 11;
+	saddr |= use_a2d_magic_v1(addr, 12) << 12;
+	saddr |= use_a2d_magic_v1(addr, 13) << 13;
+	saddr |= use_a2d_magic_v1(addr, 14) << 14;
+	saddr |= use_a2d_magic_v1(addr, 15) << 15;
+	saddr |= use_a2d_magic_v1(addr, 16) << 16;
+
+	if (global_emi_cen->disph <= 0) {
+		bfraddr = saddr;
+	} else {
+		tmp = 7 + __ffs(disph);
+		bfraddr = (saddr >> (tmp + 1)) << tmp;
+		bfraddr += saddr & ((1 << tmp) - 1);
+	}
+
+	if (bfraddr < s6s->cas)
+		return -1;
+
+	if (!s6s->channels) {
+		map->channel = s6s->channels;
+	} else if (hash) {
+		tmp = (test_bit(8, &addr) && test_bit(0, &hash)) ? 1 : 0;
+		tmp ^= (test_bit(9, &addr) && test_bit(1, &hash)) ? 1 : 0;
+		tmp ^= (test_bit(10, &addr) && test_bit(2, &hash)) ? 1 : 0;
+		tmp ^= (test_bit(11, &addr) && test_bit(3, &hash)) ? 1 : 0;
+		map->channel = tmp;
+	} else {
+		if (s6s->channels == 1) {
+			tmp = 0;
+			switch (s6s->chnpos) {
+			case 0:
+				tmp = 7;
+				break;
+			case 1:
+				tmp = 8;
+				break;
+			case 2:
+				tmp = 9;
+				break;
+			case 3:
+				tmp = 12;
+				break;
+			default:
+				return -1;
+			}
+			map->channel = (bfraddr >> tmp) % 2;
+		} else if (s6s->channels == 2) {
+			tmp = 0;
+			switch (s6s->chnpos) {
+			case 0:
+				tmp = 7;
+				break;
+			case 1:
+				tmp = 8;
+				break;
+			case 2:
+				tmp = 9;
+				break;
+			case 3:
+				tmp = 12;
+				break;
+			default:
+				return -1;
+			}
+			map->channel = (bfraddr >> tmp) % 4;
+		} else {
+			return -1;
+		}
+	}
+
+	if (map->channel > 1) {
+		ch_ab_not_cd = 0;
+	} else {
+		if (map->channel == 1)
+			ch_ab_not_cd = (s6s->channels > 1) ?  1 : 0;
+		else
+			ch_ab_not_cd = 1;
+	}
+
+	max_rk0_sz = (ch_ab_not_cd) ?  s6s->chab_rk0_sz : s6s->chcd_rk0_sz;
+	max_rk0_sz = max_rk0_sz << 20;
+
+	if (!s6s->channels) {
+		chnaddr = bfraddr;
+	} else if (s6s->chnpos > 3) {
+		tmp = chn_hash_lsb;
+		chnaddr = bfraddr >> (tmp + 1);
+		chnaddr = chnaddr << tmp;
+		chnaddr += bfraddr & ((1 << tmp) - 1);
+	} else if (s6s->channels == 1 ||
+			s6s->channels == 2) {
+		tmp = 0;
+		switch (s6s->chnpos) {
+		case 0:
+			tmp = 7;
+			break;
+		case 1:
+			tmp = 8;
+			break;
+		case 2:
+			tmp = 9;
+			break;
+		case 3:
+			tmp = 12;
+			break;
+		default:
+			break;
+		}
+		chnaddr = bfraddr >> (tmp + (s6s->channels - 1));
+		chnaddr = chnaddr << tmp;
+		chnaddr += bfraddr & ((1 << tmp) - 1);
+	} else {
+		return -1;
+	}
+
+	if (map->channel ? !s6s->dualrk_ch1 : !s6s->dualrk_ch0) {
+		map->rank = 0;
+	} else {
+		if (chnaddr > max_rk0_sz)
+			map->rank = 1;
+		else
+			map->rank = 0;
+	}
+
+	row_mask = (ch_ab_not_cd) ?
+			((map->rank) ?
+				s6s->chab_row_mask[1] : s6s->chab_row_mask[0]) :
+			((map->rank) ?
+				s6s->chcd_row_mask[1] : s6s->chcd_row_mask[0]);
+	col_mask = (ch_ab_not_cd) ?
+			((map->rank) ?
+				s6s->chab_col_mask[1] : s6s->chab_col_mask[0]) :
+			((map->rank) ?
+				s6s->chcd_col_mask[1] : s6s->chcd_col_mask[0]);
+
+	tmp = chnaddr - (max_rk0_sz * map->rank);
+	tmp /= 1 << (s6s->dw32 + 1 + col_mask + 3);
+	tmp &= (1 << row_mask) - 1;
+	map->row = tmp;
+
+	tmp = chnaddr;
+	tmp /= 1 << (s6s->dw32 + 1 + col_mask);
+	tmp &= ((!s6s->chn_4bank_mode) ? 8 : 4) - 1;
+	map->bank = tmp;
+
+	tmp = chnaddr;
+	tmp /= 1 << (s6s->dw32 + 1);
+	tmp &= (1 << col_mask) - 1;
+	map->column = tmp;
+
+	return 0;
+}
+
+/*
+ * prepare_a2d_v2: a helper function to initialize and calculate settings for
+ *                 the mtk_emicen_addr2dram_v2() function
+ *
+ * There is no code comment for the translation. This is intended since
+ * the fomular of translation is derived from the implementation of EMI.
+ */
+static inline void prepare_a2d_v2(struct emi_cen *cen)
+{
+	const unsigned int mask_4b = 0xf, mask_2b = 0x3;
+	struct a2d_s6s_v2 *s6s;
+	void __iomem *emi_cen_base, *emi_chn_base;
+	unsigned long emi_cona, emi_conf, emi_conh, emi_conh_2nd, emi_conk;
+	unsigned long emi_chn_cona, emi_chn_conc, emi_chn_conc_2nd;
+	int tmp;
+	int col, col2nd, row, row2nd, row_ext0, row2nd_ext0;
+	int rank0_size, rank1_size, rank0_size_ext, rank1_size_ext;
+	int chn_4bank_mode, chn_bg_16bank_mode, chn_bg_16bank_mode_2nd;
+	int b11s, b12s, b13s, b14s, b15s, b16s;
+	int b8s, b11s_ext, b12s_ext, b13s_ext, b14s_ext, b15s_ext, b16s_ext;
+	unsigned long ch0_rk0_sz, ch0_rk1_sz;
+	unsigned long ch1_rk0_sz, ch1_rk1_sz;
+
+	if (!cen)
+		return;
+
+	s6s = &cen->a2d_s6s.v2;
+	cen->offset = MTK_EMI_DRAM_OFFSET;
+
+	emi_cen_base = cen->emi_cen_base[0];
+	emi_cona = readl(emi_cen_base + emi_a2d_con_offset[0]);
+	emi_conf = readl(emi_cen_base + emi_a2d_con_offset[1]);
+	emi_conh = readl(emi_cen_base + emi_a2d_con_offset[2]);
+	emi_conh_2nd = readl(emi_cen_base + emi_a2d_con_offset[3]);
+	emi_conk = readl(emi_cen_base + emi_a2d_con_offset[4]);
+
+	emi_chn_base = cen->emi_chn_base[0];
+	emi_chn_cona = readl(emi_chn_base + emi_a2d_chn_con_offset[0]);
+	emi_chn_conc = readl(emi_chn_base + emi_a2d_chn_con_offset[1]);
+	emi_chn_conc_2nd = readl(emi_chn_base + emi_a2d_chn_con_offset[2]);
+
+	tmp = (emi_cona >> EMI_CONA_CHN_POS_0) & mask_2b;
+	switch (tmp) {
+	case 3:
+		s6s->chn_bit_position = 12;
+		break;
+	case 2:
+		s6s->chn_bit_position = 9;
+		break;
+	case 1:
+		s6s->chn_bit_position = 8;
+		break;
+	default:
+		s6s->chn_bit_position = 7;
+		break;
+	}
+
+	s6s->chn_en = (emi_cona >> EMI_CONA_CHN_EN) & mask_2b;
+
+	s6s->magics[0] = emi_conf & mask_4b;
+	s6s->magics[1] = (emi_conf >> 4) & mask_4b;
+	s6s->magics[2] = (emi_conf >> 8) & mask_4b;
+	s6s->magics[3] = (emi_conf >> 12) & mask_4b;
+	s6s->magics[4] = (emi_conf >> 16) & mask_4b;
+	s6s->magics[5] = (emi_conf >> 20) & mask_4b;
+	s6s->magics[6] = (emi_conf >> 24) & mask_4b;
+	s6s->magics[7] = (emi_conf >> 28) & mask_4b;
+
+	s6s->dual_rank_en =
+		test_bit(EMI_CHN_CONA_DUAL_RANK_EN, &emi_chn_cona) ?  1 : 0;
+	s6s->dw32_en = test_bit(EMI_CHN_CONA_DW32_EN, &emi_chn_cona) ? 1 : 0;
+	row_ext0 = test_bit(EMI_CHN_CONA_ROW_EXT0, &emi_chn_cona) ? 1 : 0;
+	row2nd_ext0 = test_bit(EMI_CHN_CONA_ROW2ND_EXT0, &emi_chn_cona) ? 1 : 0;
+	col = (emi_chn_cona >> EMI_CHN_CONA_COL) & mask_2b;
+	col2nd = (emi_chn_cona >> EMI_CHN_CONA_COL2ND) & mask_2b;
+	rank0_size_ext =
+		test_bit(EMI_CHN_CONA_RANK0_SIZE_EXT, &emi_chn_cona) ? 1 : 0;
+	rank1_size_ext =
+		test_bit(EMI_CHN_CONA_RANK1_SIZE_EXT, &emi_chn_cona) ? 1 : 0;
+	chn_bg_16bank_mode =
+		test_bit(EMI_CHN_CONA_16BANK_MODE, &emi_chn_cona) ? 1 : 0;
+	chn_bg_16bank_mode_2nd =
+		test_bit(EMI_CHN_CONA_16BANK_MODE_2ND, &emi_chn_cona) ? 1 : 0;
+	row = (emi_chn_cona >> EMI_CHN_CONA_ROW) & mask_2b;
+	row2nd = (emi_chn_cona >> EMI_CHN_CONA_ROW2ND) & mask_2b;
+	rank0_size = (emi_chn_cona >> EMI_CHN_CONA_RANK0_SZ) & mask_4b;
+	rank1_size = (emi_chn_cona >> EMI_CHN_CONA_RANK1_SZ) & mask_4b;
+	chn_4bank_mode =
+		test_bit(EMI_CHN_CONA_4BANK_MODE, &emi_chn_cona) ? 1 : 0;
+	s6s->rank_pos = test_bit(EMI_CHN_CONA_RANK_POS, &emi_chn_cona) ? 1 : 0;
+	s6s->bg1_bk3_pos =
+		test_bit(EMI_CHN_CONA_BG1_BK3_POS, &emi_chn_cona) ? 1 : 0;
+
+	b11s = (emi_chn_conc >> 8) & mask_4b;
+	b12s = (emi_chn_conc >> 12) & mask_4b;
+	b13s = (emi_chn_conc >> 16) & mask_4b;
+	b14s = (emi_chn_conc >> 20) & mask_4b;
+	b15s = (emi_chn_conc >> 24) & mask_4b;
+	b16s = (emi_chn_conc >> 28) & mask_4b;
+
+	b11s_ext = (emi_chn_conc_2nd >> 4) & mask_2b;
+	b12s_ext = (emi_chn_conc_2nd >> 6) & mask_2b;
+	b13s_ext = (emi_chn_conc_2nd >> 8) & mask_2b;
+	b14s_ext = (emi_chn_conc_2nd >> 10) & mask_2b;
+	b15s_ext = (emi_chn_conc_2nd >> 12) & mask_2b;
+	b16s_ext = (emi_chn_conc_2nd >> 14) & mask_2b;
+	b8s = (emi_chn_conc_2nd >> 16) & mask_2b;
+
+	s6s->magics2[0] = b8s;
+	s6s->magics2[1] = b11s_ext * 16 + b11s;
+	s6s->magics2[2] = b12s_ext * 16 + b12s;
+	s6s->magics2[3] = b13s_ext * 16 + b13s;
+	s6s->magics2[4] = b14s_ext * 16 + b14s;
+	s6s->magics2[5] = b15s_ext * 16 + b15s;
+	s6s->magics2[6] = b16s_ext * 16 + b16s;
+
+	s6s->rank0_row_width = row_ext0 * 4 + row + 13;
+	s6s->rank0_bank_width = (chn_bg_16bank_mode == 1) ? 4 :
+				(chn_4bank_mode == 1) ? 2 : 3;
+	s6s->rank0_col_width = col + 9;
+	s6s->rank0_bg_16bank_mode = chn_bg_16bank_mode;
+	s6s->rank0_size_MB = (rank0_size_ext * 16 + rank0_size) * 256;
+	if (!(s6s->rank0_size_MB)) {
+		tmp = s6s->rank0_row_width + s6s->rank0_bank_width;
+		tmp += s6s->rank0_col_width + s6s->dw32_en;
+		s6s->rank0_size_MB = 2 << (tmp - 20);
+	}
+
+	s6s->rank1_row_width = row2nd_ext0 * 4 + row2nd + 13;
+	s6s->rank1_bank_width = (chn_bg_16bank_mode_2nd == 1) ? 4 :
+				(chn_4bank_mode == 1) ? 2 : 3;
+	s6s->rank1_col_width = col2nd + 9;
+	s6s->rank1_bg_16bank_mode = chn_bg_16bank_mode_2nd;
+	s6s->rank1_size_MB = (rank1_size_ext * 16 + rank1_size) * 256;
+	if (!(s6s->rank1_size_MB)) {
+		tmp = s6s->rank1_row_width + s6s->rank1_bank_width;
+		tmp += s6s->rank1_col_width + s6s->dw32_en;
+		s6s->rank1_size_MB = 2 << (tmp - 20);
+	}
+
+	if (s6s->rank0_size_MB) {
+		ch0_rk0_sz = s6s->rank0_size_MB;
+	} else {
+		tmp = s6s->rank0_row_width + s6s->rank0_bank_width;
+		tmp += s6s->rank0_col_width + s6s->dw32_en ? 2 : 1;
+		tmp -= 20;
+		ch0_rk0_sz = 1 << tmp;
+	}
+	ch1_rk0_sz = ch0_rk0_sz;
+	if (s6s->rank1_size_MB) {
+		ch0_rk1_sz = s6s->rank1_size_MB;
+	} else {
+		tmp = s6s->rank1_row_width + s6s->rank1_bank_width;
+		tmp += s6s->rank1_col_width + s6s->dw32_en ? 2 : 1;
+		tmp -= 20;
+		ch0_rk1_sz = 1 << tmp;
+	}
+	ch1_rk1_sz = ch0_rk1_sz;
+
+	cen->max = ch0_rk0_sz;
+	if (s6s->dual_rank_en)
+		cen->max += ch0_rk1_sz;
+	if (s6s->chn_en)
+		cen->max += ch1_rk0_sz + ((s6s->dual_rank_en) ? ch1_rk1_sz : 0);
+	if (cen->disph)
+		cen->max *= 2;
+	cen->max = cen->max << 20;
+}
+
+/*
+ * use_a2d_magic_v2: a helper function to calculate the input address
+ *                   for the mtk_emicen_addr2dram_v2() function
+ *
+ * There is no code comment for the translation. This is intended since
+ * the fomular of translation is derived from the implementation of EMI.
+ */
+static inline unsigned int use_a2d_magic_v2(unsigned long addr,
+					    unsigned long magic,
+					    unsigned int bit)
+{
+	unsigned int ret;
+
+	ret = test_bit(bit, &addr) ? 1 : 0;
+	ret ^= (test_bit(16, &addr) & test_bit(0, &magic)) ? 1 : 0;
+	ret ^= (test_bit(17, &addr) & test_bit(1, &magic)) ? 1 : 0;
+	ret ^= (test_bit(18, &addr) & test_bit(2, &magic)) ? 1 : 0;
+	ret ^= (test_bit(19, &addr) & test_bit(3, &magic)) ? 1 : 0;
+	ret ^= (test_bit(20, &addr) & test_bit(4, &magic)) ? 1 : 0;
+	ret ^= (test_bit(21, &addr) & test_bit(5, &magic)) ? 1 : 0;
+
+	return ret;
+}
+
+/*
+ * a2d_rm_bit: a helper function to calculate the input address
+ *             for the mtk_emicen_addr2dram_v2() function
+ *
+ * There is no code comment for the translation. This is intended since
+ * the fomular of translation is derived from the implementation of EMI.
+ */
+static inline unsigned long a2d_rm_bit(unsigned long taddr, int bit)
+{
+	unsigned long ret;
+
+	ret = taddr;
+	clear_bit(bit, &ret);
+
+	ret = ret >> (bit + 1);
+	ret = ret << bit;
+	ret = ret & ~((1UL << bit) - 1);
+
+	ret = ret | (taddr & ((1UL << bit) - 1));
+
+	return ret;
+}
+
+/*
+ * mtk_emicen_addr2dram_v2 - Translate a physical address to
+ *                           a DRAM-point-of-view map for EMI v2
+ * @addr - input physical address
+ * @map - output map stored in struct emi_addr_map
+ *
+ * Return 0 on success, -1 on failures.
+ *
+ * There is no code comment for the translation. This is intended since
+ * the fomular of translation is derived from the implementation of EMI.
+ */
+static int mtk_emicen_addr2dram_v2(unsigned long addr,
+				   struct emi_addr_map *map)
+{
+	struct a2d_s6s_v2 *s6s;
+	unsigned long disph, hash;
+	unsigned long saddr, taddr, bgaddr, noraddr;
+	unsigned long tmp;
+	int emi_tpos, chn_tpos;
+
+	if (!global_emi_cen)
+		return -1;
+	if (!map)
+		return -1;
+	if (addr < global_emi_cen->offset)
+		return -1;
+
+	addr -= global_emi_cen->offset;
+	if (addr > global_emi_cen->max)
+		return -1;
+
+	map->emi = -1;
+	map->channel = -1;
+	map->rank = -1;
+	map->bank = -1;
+	map->row = -1;
+	map->column = -1;
+
+	s6s = &global_emi_cen->a2d_s6s.v2;
+	disph = global_emi_cen->disph;
+	hash = global_emi_cen->hash;
+
+	saddr = addr;
+	clear_bit(9, &saddr);
+	clear_bit(10, &saddr);
+	clear_bit(11, &saddr);
+	clear_bit(12, &saddr);
+	clear_bit(13, &saddr);
+	clear_bit(14, &saddr);
+	clear_bit(15, &saddr);
+	clear_bit(16, &saddr);
+	saddr |= use_a2d_magic_v2(addr, s6s->magics[0], 9) << 9;
+	saddr |= use_a2d_magic_v2(addr, s6s->magics[1], 10) << 10;
+	saddr |= use_a2d_magic_v2(addr, s6s->magics[2], 11) << 11;
+	saddr |= use_a2d_magic_v2(addr, s6s->magics[3], 12) << 12;
+	saddr |= use_a2d_magic_v2(addr, s6s->magics[4], 13) << 13;
+	saddr |= use_a2d_magic_v2(addr, s6s->magics[5], 14) << 14;
+	saddr |= use_a2d_magic_v2(addr, s6s->magics[6], 15) << 15;
+	saddr |= use_a2d_magic_v2(addr, s6s->magics[7], 16) << 16;
+
+	if (!hash) {
+		map->channel = test_bit(s6s->chn_bit_position, &saddr) ? 1 : 0;
+
+		chn_tpos = s6s->chn_bit_position;
+	} else {
+		tmp = (test_bit(8, &saddr) && test_bit(0, &hash)) ? 1 : 0;
+		tmp ^= (test_bit(9, &saddr) && test_bit(1, &hash)) ? 1 : 0;
+		tmp ^= (test_bit(10, &saddr) && test_bit(2, &hash)) ? 1 : 0;
+		tmp ^= (test_bit(11, &saddr) && test_bit(3, &hash)) ? 1 : 0;
+		map->channel = tmp;
+
+		if (test_bit(0, &hash))
+			chn_tpos = 8;
+		else if (test_bit(1, &hash))
+			chn_tpos = 9;
+		else if (test_bit(2, &hash))
+			chn_tpos = 10;
+		else if (test_bit(3, &hash))
+			chn_tpos = 11;
+		else
+			chn_tpos = -1;
+	}
+
+	if (!disph) {
+		map->emi = 0;
+
+		emi_tpos = -1;
+	} else {
+		tmp = (test_bit(8, &saddr) && test_bit(0, &disph)) ? 1 : 0;
+		tmp ^= (test_bit(9, &saddr) && test_bit(1, &disph)) ? 1 : 0;
+		tmp ^= (test_bit(10, &saddr) && test_bit(2, &disph)) ? 1 : 0;
+		tmp ^= (test_bit(11, &saddr) && test_bit(3, &disph)) ? 1 : 0;
+		map->emi = tmp;
+
+		if (test_bit(0, &disph))
+			emi_tpos = 8;
+		else if (test_bit(1, &disph))
+			emi_tpos = 9;
+		else if (test_bit(2, &disph))
+			emi_tpos = 10;
+		else if (test_bit(3, &disph))
+			emi_tpos = 11;
+		else
+			emi_tpos = -1;
+	}
+
+	taddr = saddr;
+	if (!disph) {
+		if (!s6s->chn_en)
+			taddr = saddr;
+		else
+			taddr = a2d_rm_bit(taddr, chn_tpos);
+	} else {
+		if (chn_tpos < 0 || emi_tpos < 0)
+			return -1;
+		if (!s6s->chn_en) {
+			taddr = a2d_rm_bit(taddr, emi_tpos);
+		} else if (emi_tpos > chn_tpos) {
+			taddr = a2d_rm_bit(taddr, emi_tpos);
+			taddr = a2d_rm_bit(taddr, chn_tpos);
+		} else {
+			taddr = a2d_rm_bit(taddr, chn_tpos);
+			taddr = a2d_rm_bit(taddr, emi_tpos);
+		}
+	}
+
+	saddr = taddr;
+	clear_bit(8, &saddr);
+	clear_bit(11, &saddr);
+	clear_bit(12, &saddr);
+	clear_bit(13, &saddr);
+	clear_bit(14, &saddr);
+	clear_bit(15, &saddr);
+	clear_bit(16, &saddr);
+	saddr |= use_a2d_magic_v2(taddr, s6s->magics2[0], 8) << 8;
+	saddr |= use_a2d_magic_v2(taddr, s6s->magics2[1], 11) << 11;
+	saddr |= use_a2d_magic_v2(taddr, s6s->magics2[2], 12) << 12;
+	saddr |= use_a2d_magic_v2(taddr, s6s->magics2[3], 13) << 13;
+	saddr |= use_a2d_magic_v2(taddr, s6s->magics2[4], 14) << 14;
+	saddr |= use_a2d_magic_v2(taddr, s6s->magics2[5], 15) << 15;
+	saddr |= use_a2d_magic_v2(taddr, s6s->magics2[6], 16) << 16;
+
+	if (!s6s->dual_rank_en) {
+		map->rank = 0;
+	} else {
+		if (!s6s->rank_pos) {
+			map->rank = ((saddr >> 20) > s6s->rank0_size_MB) ?
+					1 : 0;
+		} else {
+			tmp = 1 + s6s->dw32_en;
+			tmp += s6s->rank0_col_width + s6s->rank0_bank_width;
+			map->rank = saddr >> tmp;
+		}
+	}
+
+	tmp = (map->rank)
+		? s6s->rank1_bg_16bank_mode
+		: s6s->rank0_bg_16bank_mode;
+	if (tmp) {
+		bgaddr = a2d_rm_bit(saddr, 8);
+		map->column = (bgaddr >> (1 + s6s->dw32_en))
+			% (1 << ((map->rank)
+				? s6s->rank1_col_width
+				: s6s->rank0_col_width));
+
+		tmp = (map->rank) ? s6s->rank1_col_width : s6s->rank0_col_width;
+		tmp = (bgaddr >> (1 + s6s->dw32_en + tmp))
+			% (1 << ((map->rank)
+				? s6s->rank1_bank_width - 1
+				: s6s->rank0_bank_width - 1));
+		map->bank = test_bit((s6s->bg1_bk3_pos) ? 0 : 1, &tmp) ? 1 : 0;
+		map->bank += test_bit((s6s->bg1_bk3_pos) ? 1 : 2, &tmp) ? 2 : 0;
+		map->bank += test_bit(8, &saddr) ? 4 : 0;
+		map->bank += test_bit((s6s->bg1_bk3_pos) ? 2 : 0, &tmp) ? 8 : 0;
+	} else {
+		map->column = (saddr >> (1 + s6s->dw32_en))
+			% (1 << ((map->rank)
+				? s6s->rank1_col_width
+				: s6s->rank0_col_width));
+
+		tmp = (map->rank) ? s6s->rank1_col_width : s6s->rank0_col_width;
+		map->bank = (saddr >> (1 + s6s->dw32_en + tmp))
+			% (1 << ((map->rank)
+				? s6s->rank1_bank_width
+				: s6s->rank0_bank_width));
+	}
+
+	if (!s6s->rank_pos) {
+		noraddr = (map->rank) ?
+			saddr - (s6s->rank0_size_MB << 20) : saddr;
+	} else {
+		tmp = 1 + s6s->dw32_en;
+		tmp += (map->rank) ?
+			s6s->rank1_bank_width : s6s->rank0_bank_width;
+		tmp += (map->rank) ?
+			s6s->rank1_col_width : s6s->rank0_col_width;
+		noraddr = a2d_rm_bit(saddr, tmp);
+	}
+	tmp = 1 + s6s->dw32_en;
+	tmp += (map->rank) ? s6s->rank1_bank_width : s6s->rank0_bank_width;
+	tmp += (map->rank) ? s6s->rank1_col_width : s6s->rank0_col_width;
+	noraddr = noraddr >> tmp;
+	tmp = (map->rank) ? s6s->rank1_row_width : s6s->rank0_row_width;
+	map->row = noraddr % (1 << tmp);
+
+	return 0;
+}
+
+/*
+ * mtk_emicen_addr2dram - Translate a physical address to
+			a DRAM-point-of-view map
+ * @addr - input physical address
+ * @map - output map stored in struct emi_addr_map
+ *
+ * Return 0 on success, -1 on failures.
+ *
+ * There is no code comment for the translation. This is intended since
+ * the fomular of translation is derived from the implementation of EMI.
+ */
+int mtk_emicen_addr2dram(unsigned long addr, struct emi_addr_map *map)
+{
+	if (!global_emi_cen)
+		return -1;
+
+	if (global_emi_cen->ver == 1)
+		return mtk_emicen_addr2dram_v1(addr, map);
+	else
+		return mtk_emicen_addr2dram_v2(addr, map);
+}
+EXPORT_SYMBOL(mtk_emicen_addr2dram);
+
+static ssize_t emicen_addr2dram_show(struct device_driver *driver, char *buf)
+{
+	int ret;
+	struct emi_addr_map map;
+	unsigned long addr;
+
+	if (!global_emi_cen)
+		return 0;
+
+	addr = global_emi_cen->a2d_addr;
+
+	ret = mtk_emicen_addr2dram(addr, &map);
+	if (!ret) {
+		return snprintf(buf, PAGE_SIZE,
+		     "0x%lx\n->\nemi%d\nchn%d\nrank%d\nbank%d\nrow%d\ncol%d\n",
+		     addr, map.emi, map.channel, map.rank,
+		     map.bank, map.row, map.column);
+	} else {
+		return snprintf(buf, PAGE_SIZE, "0x%lx\n->failed\n", addr);
+	}
+}
+
+static ssize_t emicen_addr2dram_store
+	(struct device_driver *driver, const char *buf, size_t count)
+{
+	u64 addr;
+	int ret;
+
+	if (!global_emi_cen)
+		return count;
+
+	ret = kstrtou64(buf, 16, &addr);
+	if (ret)
+		return ret;
+
+	global_emi_cen->a2d_addr = (unsigned long)addr;
+
+	return ret ? : count;
+}
+
+static DRIVER_ATTR_RW(emicen_addr2dram);
+
+static int emicen_probe(struct platform_device *pdev)
+{
+	struct device_node *emicen_node = pdev->dev.of_node;
+	struct device_node *emichn_node =
+		of_parse_phandle(emicen_node, "mediatek,emi-reg", 0);
+	struct emi_cen *cen;
+	unsigned int i;
+	int ret;
+
+	dev_info(&pdev->dev, "driver probed\n");
+
+	cen = devm_kzalloc(&pdev->dev,
+			   sizeof(struct emi_cen), GFP_KERNEL);
+	if (!cen)
+		return -ENOMEM;
+
+	cen->ver = (int)of_device_get_match_data(&pdev->dev);
+
+	ret = of_property_read_u32(emicen_node,
+				   "ch_cnt", &cen->ch_cnt);
+	if (ret) {
+		dev_err(&pdev->dev, "No ch_cnt\n");
+		return -ENXIO;
+	}
+
+	ret = of_property_read_u32(emicen_node,
+				   "rk_cnt", &cen->rk_cnt);
+	if (ret) {
+		dev_err(&pdev->dev, "No rk_cnt\n");
+		return -ENXIO;
+	}
+
+	cen->rk_size = devm_kmalloc_array(&pdev->dev,
+					  cen->rk_cnt,
+					  sizeof(unsigned long long),
+					  GFP_KERNEL);
+	if (!cen->rk_size)
+		return -ENOMEM;
+
+	ret = of_property_read_u64_array(emicen_node,
+					 "rk_size", cen->rk_size, cen->rk_cnt);
+	if (ret) {
+		dev_err(&pdev->dev, "No rk_size\n");
+		return -ENXIO;
+	}
+
+	ret = of_property_count_elems_of_size(emicen_node,
+					      "reg", sizeof(unsigned int) * 4);
+	if (ret <= 0) {
+		dev_err(&pdev->dev, "No reg\n");
+		return -ENXIO;
+	}
+	cen->emi_cen_cnt = (unsigned int)ret;
+
+	cen->emi_cen_base = devm_kmalloc_array(&pdev->dev,
+					       cen->emi_cen_cnt,
+					       sizeof(phys_addr_t),
+					       GFP_KERNEL);
+	if (!cen->emi_cen_base)
+		return -ENOMEM;
+	for (i = 0; i < cen->emi_cen_cnt; i++)
+		cen->emi_cen_base[i] = of_iomap(emicen_node, i);
+
+	cen->emi_chn_base = devm_kmalloc_array(&pdev->dev,
+					       cen->ch_cnt,
+					       sizeof(phys_addr_t),
+					       GFP_KERNEL);
+	if (!cen->emi_chn_base)
+		return -ENOMEM;
+	for (i = 0; i < cen->ch_cnt; i++)
+		cen->emi_chn_base[i] = of_iomap(emichn_node, i);
+
+	ret = of_property_read_u32(emicen_node,
+				   "a2d_disph", &cen->disph);
+	if (ret) {
+		dev_info(&pdev->dev, "No a2d_disph\n");
+		cen->disph = MTK_EMI_DISPATCH;
+	}
+
+	ret = of_property_read_u32(emicen_node,
+				   "a2d_hash", &cen->hash);
+	if (ret) {
+		dev_info(&pdev->dev, "No a2d_hash\n");
+		cen->hash = MTK_EMI_HASH;
+	}
+
+	ret = of_property_read_u32_array(emicen_node,
+					 "a2d_conf_offset", emi_a2d_con_offset,
+		ARRAY_SIZE(emi_a2d_con_offset));
+	if (ret)
+		dev_info(&pdev->dev, "No a2d_conf_offset\n");
+
+	ret = of_property_read_u32_array(emicen_node,
+					 "a2d_chn_conf_offset",
+					 emi_a2d_chn_con_offset,
+					 ARRAY_SIZE(emi_a2d_chn_con_offset));
+	if (ret)
+		dev_info(&pdev->dev, "No a2d_chn_conf_offset\n");
+
+	if (cen->ver == 1)
+		prepare_a2d_v1(cen);
+	else if (cen->ver == 2)
+		prepare_a2d_v2(cen);
+	else
+		return -ENXIO;
+
+	global_emi_cen = cen;
+
+	dev_info(&pdev->dev, "%s(%d) %s(%d), %s(%d)\n",
+		 "version", cen->ver,
+		 "ch_cnt", cen->ch_cnt,
+		 "rk_cnt", cen->rk_cnt);
+
+	for (i = 0; i < cen->rk_cnt; i++)
+		dev_info(&pdev->dev, "rk_size%d(0x%llx)\n",
+			 i, cen->rk_size[i]);
+
+	dev_info(&pdev->dev, "a2d_disph %d\n", cen->disph);
+
+	dev_info(&pdev->dev, "a2d_hash %d\n", cen->hash);
+
+	for (i = 0; i < ARRAY_SIZE(emi_a2d_con_offset); i++)
+		dev_info(&pdev->dev, "emi_a2d_con_offset[%d] %d\n",
+			 i, emi_a2d_con_offset[i]);
+
+	for (i = 0; i < ARRAY_SIZE(emi_a2d_chn_con_offset); i++)
+		dev_info(&pdev->dev, "emi_a2d_chn_con_offset[%d] %d\n",
+			 i, emi_a2d_chn_con_offset[i]);
+
+	return 0;
+}
+
+static int emicen_remove(struct platform_device *pdev)
+{
+	global_emi_cen = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id emicen_of_ids[] = {
+	{.compatible = "mediatek,common-emicen", .data = (void *)1 },
+	{.compatible = "mediatek,mt6779-emicen", .data = (void *)1 },
+	{}
+};
+
+static struct platform_driver emicen_drv = {
+	.probe = emicen_probe,
+	.remove = emicen_remove,
+	.driver = {
+		.name = "emicen_drv",
+		.owner = THIS_MODULE,
+		.of_match_table = emicen_of_ids,
+	},
+};
+
+__weak int emiisu_init(void)
+{
+	return 0;
+}
+
+static __init int emicen_init(void)
+{
+	int ret;
+
+	pr_info("emicen was loaded\n");
+
+	ret = platform_driver_register(&emicen_drv);
+	if (ret) {
+		pr_err("emicen: failed to register driver\n");
+		return ret;
+	}
+
+	ret = driver_create_file(&emicen_drv.driver,
+				 &driver_attr_emicen_addr2dram);
+	if (ret) {
+		pr_err("emicen: failed to create addr2dram file\n");
+		return ret;
+	}
+
+	ret = emiisu_init();
+	if (ret) {
+		pr_err("emicen: failed to init isu\n");
+		return ret;
+	}
+
+#if defined(MODULE)
+	emimpu_ap_region_init();
+#endif
+
+	return 0;
+}
+
+module_init(emicen_init);
+
+MODULE_DESCRIPTION("MediaTek EMI Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/memory/mediatek/emi-mpu.c b/drivers/memory/mediatek/emi-mpu.c
new file mode 100644
index 0000000..3cfe9a1
--- /dev/null
+++ b/drivers/memory/mediatek/emi-mpu.c
@@ -0,0 +1,908 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#include <linux/arm-smccc.h>
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/slab.h>
+#include <linux/soc/mediatek/mtk_sip_svc.h>
+#include <soc/mediatek/emi.h>
+
+struct emi_mpu {
+	unsigned long long dram_start;
+	unsigned long long dram_end;
+	unsigned int region_cnt;
+	unsigned int domain_cnt;
+	unsigned int addr_align;
+	unsigned int ctrl_intf;
+
+	unsigned int dump_cnt;
+	struct reg_info_t *dump_reg;
+
+	unsigned int clear_reg_cnt;
+	struct reg_info_t *clear_reg;
+
+	struct reg_info_t *clear_md_reg;
+	unsigned int clear_md_reg_cnt;
+
+	unsigned int emi_cen_cnt;
+	void __iomem **emi_cen_base;
+	void __iomem **emi_mpu_base;
+
+	struct emimpu_region_t *ap_rg_info;
+
+	/* interrupt id */
+	unsigned int irq;
+
+	/* hook functions in ISR */
+	emimpu_pre_handler pre_handler;
+	emimpu_post_clear post_clear;
+	emimpu_md_handler md_handler;
+
+	/* debugging log for EMI MPU violation */
+	char *vio_msg;
+	unsigned int in_msg_dump;
+
+	/* hook functions in worker thread */
+	struct emimpu_dbg_cb *dbg_cb_list;
+};
+
+/* global pointer for exported functions */
+static struct emi_mpu *global_emi_mpu;
+
+static void set_regs(struct reg_info_t *reg_list, unsigned int reg_cnt,
+		     void __iomem *emi_cen_base)
+{
+	unsigned int i, j;
+
+	for (i = 0; i < reg_cnt; i++)
+		for (j = 0; j < reg_list[i].leng; j++)
+			writel(reg_list[i].value, emi_cen_base +
+				reg_list[i].offset + 4 * j);
+
+	/*
+	 * Use the memory barrier to make sure the interrupt signal is
+	 * de-asserted (by programming registers) before exiting the
+	 * ISR and re-enabling the interrupt.
+	 */
+	mb();
+}
+
+static void clear_violation(struct emi_mpu *mpu,
+			    unsigned int emi_id)
+{
+	void __iomem *emi_cen_base;
+
+	emi_cen_base = mpu->emi_cen_base[emi_id];
+
+	set_regs(mpu->clear_reg,
+		 mpu->clear_reg_cnt, emi_cen_base);
+
+	if (mpu->post_clear)
+		mpu->post_clear(emi_id);
+}
+
+static void emimpu_vio_dump(struct work_struct *work)
+{
+	struct emi_mpu *mpu;
+	struct emimpu_dbg_cb *curr_dbg_cb;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return;
+
+	for (curr_dbg_cb = mpu->dbg_cb_list; curr_dbg_cb;
+		curr_dbg_cb = curr_dbg_cb->next_dbg_cb)
+		curr_dbg_cb->func();
+
+	mpu->in_msg_dump = 0;
+}
+
+static DECLARE_WORK(emimpu_work, emimpu_vio_dump);
+
+static irqreturn_t emimpu_violation_irq(int irq, void *dev_id)
+{
+	struct emi_mpu *mpu = (struct emi_mpu *)dev_id;
+	struct reg_info_t *dump_reg = mpu->dump_reg;
+	void __iomem *emi_cen_base;
+	unsigned int emi_id, i;
+	ssize_t msg_len;
+	int n, nr_vio;
+	bool violation;
+
+	if (mpu->in_msg_dump)
+		goto ignore_violation;
+
+	n = snprintf(mpu->vio_msg, MTK_EMI_MAX_CMD_LEN, "violation\n");
+	msg_len = (n < 0) ? 0 : (ssize_t)n;
+
+	nr_vio = 0;
+	for (emi_id = 0; emi_id < mpu->emi_cen_cnt; emi_id++) {
+		violation = false;
+		emi_cen_base = mpu->emi_cen_base[emi_id];
+
+		for (i = 0; i < mpu->dump_cnt; i++) {
+			dump_reg[i].value = readl(emi_cen_base + dump_reg[i].offset);
+
+			if (msg_len < MTK_EMI_MAX_CMD_LEN) {
+				n = snprintf(mpu->vio_msg + msg_len,
+					     MTK_EMI_MAX_CMD_LEN - msg_len,
+					     "%s(%d),%s(%x),%s(%x);\n",
+					     "emi", emi_id,
+					     "off", dump_reg[i].offset,
+					     "val", dump_reg[i].value);
+				msg_len += (n < 0) ? 0 : (ssize_t)n;
+			}
+
+			if (dump_reg[i].value)
+				violation = true;
+		}
+
+		if (!violation)
+			continue;
+
+		/*
+		 * The DEVAPC module used the EMI MPU interrupt on some
+		 * old smart-phone SoC. For these SoC, the DEVAPC driver
+		 * will register a handler for processing its interrupt.
+		 * If the handler has processed DEVAPC interrupt (and
+		 * returns IRQ_HANDLED), just skip dumping and exit.
+		 */
+		if (mpu->pre_handler)
+			if (mpu->pre_handler(emi_id, dump_reg,
+					     mpu->dump_cnt) == IRQ_HANDLED) {
+				clear_violation(mpu, emi_id);
+				mtk_clear_md_violation();
+				continue;
+			}
+
+		nr_vio++;
+
+		/*
+		 * Whenever there is an EMI MPU violation, the Modem
+		 * software would like to be notified immediately.
+		 * This is because the Modem software wants to do
+		 * its coredump as earlier as possible for debugging
+		 * and analysis.
+		 * (Even if the violated master is not Modem, it
+		 *  may still need coredump for clarification.)
+		 * Have a hook function in the EMI MPU ISR for this
+		 * purpose.
+		 */
+		if (mpu->md_handler) {
+			mpu->md_handler(emi_id,
+					dump_reg, mpu->dump_cnt);
+		}
+	}
+
+	if (nr_vio) {
+		pr_info("%s: %s", __func__, mpu->vio_msg);
+		mpu->in_msg_dump = 1;
+		schedule_work(&emimpu_work);
+	}
+
+ignore_violation:
+	for (emi_id = 0; emi_id < mpu->emi_cen_cnt; emi_id++)
+		clear_violation(mpu, emi_id);
+
+	return IRQ_HANDLED;
+}
+
+int emimpu_ap_region_init(void)
+{
+	struct emi_mpu *mpu;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return 0;
+
+	if (!(mpu->ap_rg_info))
+		return 0;
+
+	pr_info("%s: enable AP region\n", __func__);
+
+	mtk_emimpu_set_protection(mpu->ap_rg_info);
+	mtk_emimpu_free_region(mpu->ap_rg_info);
+
+	kfree(mpu->ap_rg_info);
+	mpu->ap_rg_info = NULL;
+
+	return 0;
+}
+EXPORT_SYMBOL(emimpu_ap_region_init);
+
+/*
+ * mtk_emimpu_init_region - init rg_info's apc data with default forbidden
+ * @rg_info:	the target region for init
+ * @rg_num:	the region id for the rg_info
+ *
+ * Returns 0 on success, -EINVAL if rg_info or rg_num is invalid,
+ * -ENODEV if the emi-mpu driver is not probed successfully,
+ * -ENOMEM if out of memory
+ */
+int mtk_emimpu_init_region(struct emimpu_region_t *rg_info, unsigned int rg_num)
+{
+	struct emi_mpu *mpu;
+	unsigned int size;
+	unsigned int i;
+
+	if (rg_info)
+		memset(rg_info, 0, sizeof(struct emimpu_region_t));
+	else
+		return -EINVAL;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return -ENODEV;
+
+	if (rg_num >= mpu->region_cnt) {
+		pr_info("%s: fail, out-of-range region\n", __func__);
+		return -EINVAL;
+	}
+
+	size = sizeof(unsigned int) * mpu->domain_cnt;
+	rg_info->apc = kmalloc(size, GFP_KERNEL);
+	if (!(rg_info->apc))
+		return -ENOMEM;
+	for (i = 0; i < mpu->domain_cnt; i++)
+		rg_info->apc[i] = MTK_EMIMPU_FORBIDDEN;
+
+	rg_info->rg_num = rg_num;
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_emimpu_init_region);
+
+/*
+ * mtk_emi_mpu_free_region - free the apc data in rg_info
+ * @rg_info:	the target region for free
+ *
+ * Returns 0 on success, -EINVAL if rg_info is invalid
+ */
+int mtk_emimpu_free_region(struct emimpu_region_t *rg_info)
+{
+	if (rg_info && rg_info->apc) {
+		kfree(rg_info->apc);
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL(mtk_emimpu_free_region);
+
+/*
+ * mtk_emimpu_set_addr - set the address space
+ * @rg_info:	the target region for address setting
+ * @start:	the start address
+ * @end:	the end address
+ *
+ * Returns 0 on success, -EINVAL if rg_info is invalid
+ */
+int mtk_emimpu_set_addr(struct emimpu_region_t *rg_info,
+			unsigned long long start, unsigned long long end)
+{
+	if (rg_info) {
+		rg_info->start = start;
+		rg_info->end = end;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL(mtk_emimpu_set_addr);
+
+/*
+ * mtk_emimpu_set_apc - set access permission for target domain
+ * @rg_info:	the target region for apc setting
+ * @d_num:	the target domain id
+ * @apc:	the access permission setting
+ *
+ * Returns 0 on success, -EINVAL if rg_info or d_num is invalid,
+ * -ENODEV if the emi-mpu driver is not probed successfully
+ */
+int mtk_emimpu_set_apc(struct emimpu_region_t *rg_info,
+		       unsigned int d_num, unsigned int apc)
+{
+	struct emi_mpu *mpu;
+
+	if (!rg_info)
+		return -EINVAL;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return -ENODEV;
+
+	if (d_num >= mpu->domain_cnt) {
+		pr_info("%s: fail, out-of-range domain\n", __func__);
+		return -EINVAL;
+	}
+
+	rg_info->apc[d_num] = apc & 0x7;
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_emimpu_set_apc);
+
+/*
+ * mtk_emimpu_lock_region - set lock for target region
+ * @rg_info:	the target region for lock
+ * @lock:	enable/disable lock
+ *
+ * Returns 0 on success, -EINVAL if rg_info is invalid
+ */
+int mtk_emimpu_lock_region(struct emimpu_region_t *rg_info, bool lock)
+{
+	if (rg_info) {
+		rg_info->lock = lock;
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL(mtk_emimpu_lock_region);
+
+/*
+ * mtk_emimpu_set_protection - set emimpu protect into device
+ * @rg_info:	the target region information
+ *
+ * Returns 0 on success, -EINVAL if rg_info is invalid,
+ * -ENODEV if the emi-mpu driver is not probed successfully,
+ * -EPERM if the SMC call returned failure
+ */
+int mtk_emimpu_set_protection(struct emimpu_region_t *rg_info)
+{
+	struct emi_mpu *mpu;
+	unsigned int start, end;
+	unsigned int group_apc;
+	unsigned int d_group;
+	struct arm_smccc_res smc_res;
+	int i, j;
+
+	if (!rg_info)
+		return -EINVAL;
+
+	if (!(rg_info->apc)) {
+		pr_info("%s: fail, protect without init\n", __func__);
+		return -EINVAL;
+	}
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return -ENODEV;
+
+	d_group = mpu->domain_cnt / 8;
+
+	start = (unsigned int)
+		(rg_info->start >> (mpu->addr_align)) |
+		(rg_info->rg_num << 24);
+
+	for (i = d_group - 1; i >= 0; i--) {
+		end = (unsigned int)
+			(rg_info->end >> (mpu->addr_align)) |
+			(i << 24);
+
+		for (group_apc = 0, j = 0; j < 8; j++)
+			group_apc |=
+				((rg_info->apc[i * 8 + j]) & 0x7) << (3 * j);
+		if (i == 0 && rg_info->lock)
+			group_apc |= 0x80000000;
+
+		arm_smccc_smc(MTK_SIP_EMIMPU_CONTROL, MTK_EMIMPU_SET,
+			      start, end, group_apc, 0, 0, 0, &smc_res);
+		if (smc_res.a0) {
+			pr_info("%s:%d failed to set region permission, ret=0x%lx\n",
+				__func__, __LINE__, smc_res.a0);
+			return -EPERM;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_emimpu_set_protection);
+
+/*
+ * mtk_emimpu_clear_protection - clear emimpu protection
+ * @rg_info:	the target region information
+ *
+ * Returns 0 on success, -EINVAL if rg_info is invalid,
+ * -ENODEV if the emi-mpu driver is not probed successfully,
+ * -EPERM if the SMC call returned failure
+ */
+int mtk_emimpu_clear_protection(struct emimpu_region_t *rg_info)
+{
+	struct emi_mpu *mpu;
+	struct arm_smccc_res smc_res;
+
+	if (!rg_info)
+		return -EINVAL;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return -ENODEV;
+
+	if (rg_info->rg_num > mpu->region_cnt) {
+		pr_info("%s: region %u overflow\n", __func__, rg_info->rg_num);
+		return -EINVAL;
+	}
+
+	arm_smccc_smc(MTK_SIP_EMIMPU_CONTROL, MTK_EMIMPU_CLEAR,
+		      rg_info->rg_num, 0, 0, 0, 0, 0, &smc_res);
+	if (smc_res.a0) {
+		pr_info("%s:%d failed to clear region permission, ret=0x%lx\n",
+			__func__, __LINE__, smc_res.a0);
+		return -EPERM;
+	}
+	return 0;
+}
+EXPORT_SYMBOL(mtk_emimpu_clear_protection);
+
+/*
+ * mtk_emimpu_prehandle_register - register callback for irq prehandler
+ * @bypass_func:	function point for prehandler
+ *
+ * Return 0 for success, -EINVAL for fail
+ */
+int mtk_emimpu_prehandle_register(emimpu_pre_handler bypass_func)
+{
+	struct emi_mpu *mpu;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return -EINVAL;
+
+	if (!bypass_func) {
+		pr_info("%s: bypass_func is NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	mpu->pre_handler = bypass_func;
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_emimpu_prehandle_register);
+
+/*
+ * mtk_emimpu_postclear_register - register callback for clear posthandler
+ * @clear_func:	function point for posthandler
+ *
+ * Return 0 for success, -EINVAL for fail
+ */
+int mtk_emimpu_postclear_register(emimpu_post_clear clear_func)
+{
+	struct emi_mpu *mpu;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return -EINVAL;
+
+	if (!clear_func) {
+		pr_info("%s: clear_func is NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	mpu->post_clear = clear_func;
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_emimpu_postclear_register);
+
+/*
+ * mtk_emimpu_md_handling_register - register callback for md handling
+ * @md_handling_func:	function point for md handling
+ *
+ * Return 0 for success, -EINVAL for fail
+ */
+int mtk_emimpu_md_handling_register(emimpu_md_handler md_handling_func)
+{
+	struct emi_mpu *mpu;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return -EINVAL;
+
+	if (!md_handling_func) {
+		pr_info("%s: md_handling_func is NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	mpu->md_handler = md_handling_func;
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_emimpu_md_handling_register);
+
+/*
+ * mtk_clear_md_violation - clear irq for md violation
+ *
+ * No return
+ */
+void mtk_clear_md_violation(void)
+{
+	struct emi_mpu *mpu;
+	void __iomem *emi_cen_base;
+	unsigned int emi_id;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return;
+
+	for (emi_id = 0; emi_id < mpu->emi_cen_cnt; emi_id++) {
+		emi_cen_base = mpu->emi_cen_base[emi_id];
+
+		set_regs(mpu->clear_md_reg,
+			 mpu->clear_md_reg_cnt, emi_cen_base);
+	}
+}
+EXPORT_SYMBOL(mtk_clear_md_violation);
+
+/*
+ * mtk_emimpu_debugdump_register - register callback for debug info dump
+ * @debug_func:	function point for debug info dump
+ *
+ * Return 0 for success, -EINVAL for fail
+ */
+int mtk_emimpu_debugdump_register(emimpu_debug_dump debug_func)
+{
+	struct emimpu_dbg_cb *targ_dbg_cb;
+	struct emimpu_dbg_cb *curr_dbg_cb;
+	struct emi_mpu *mpu;
+
+	mpu = global_emi_mpu;
+	if (!mpu)
+		return -EINVAL;
+
+	if (!debug_func) {
+		pr_info("%s: debug_func is NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	targ_dbg_cb = kmalloc(sizeof(*targ_dbg_cb), GFP_KERNEL);
+	if (!targ_dbg_cb)
+		return -ENOMEM;
+
+	targ_dbg_cb->func = debug_func;
+	targ_dbg_cb->next_dbg_cb = NULL;
+
+	if (!(mpu->dbg_cb_list)) {
+		mpu->dbg_cb_list = targ_dbg_cb;
+		return 0;
+	}
+
+	for (curr_dbg_cb = mpu->dbg_cb_list; curr_dbg_cb;
+		curr_dbg_cb = curr_dbg_cb->next_dbg_cb) {
+		if (!(curr_dbg_cb->next_dbg_cb)) {
+			curr_dbg_cb->next_dbg_cb = targ_dbg_cb;
+			break;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL(mtk_emimpu_debugdump_register);
+
+static const struct of_device_id emimpu_of_ids[] = {
+	{.compatible = "mediatek,common-emimpu",},
+	{.compatible = "mediatek,mt6779-emimpu",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, emimpu_of_ids);
+
+static int emimpu_probe(struct platform_device *pdev)
+{
+	struct device_node *emimpu_node = pdev->dev.of_node;
+	struct device_node *emicen_node =
+		of_parse_phandle(emimpu_node, "mediatek,emi-reg", 0);
+	struct emi_mpu *mpu;
+	int ret, size, i;
+	struct emimpu_region_t *rg_info;
+	struct arm_smccc_res smc_res;
+	struct resource *res;
+	unsigned int *dump_list;
+	unsigned int *ap_apc;
+	unsigned int ap_region;
+	unsigned int slverr;
+
+	dev_info(&pdev->dev, "driver probed\n");
+
+	if (!emicen_node) {
+		dev_err(&pdev->dev, "No emi-reg\n");
+		return -ENXIO;
+	}
+
+	mpu = devm_kzalloc(&pdev->dev,
+			   sizeof(struct emi_mpu), GFP_KERNEL);
+	if (!mpu)
+		return -ENOMEM;
+
+	ret = of_property_read_u32(emimpu_node,
+				   "region_cnt", &mpu->region_cnt);
+	if (ret) {
+		dev_err(&pdev->dev, "No region_cnt\n");
+		return -ENXIO;
+	}
+
+	ret = of_property_read_u32(emimpu_node,
+				   "domain_cnt", &mpu->domain_cnt);
+	if (ret) {
+		dev_err(&pdev->dev, "No domain_cnt\n");
+		return -ENXIO;
+	}
+
+	ret = of_property_read_u32(emimpu_node,
+				   "addr_align", &mpu->addr_align);
+	if (ret) {
+		dev_err(&pdev->dev, "No addr_align\n");
+		return -ENXIO;
+	}
+
+	ret = of_property_read_u64(emimpu_node,
+				   "dram_start", &mpu->dram_start);
+	if (ret) {
+		dev_err(&pdev->dev, "No dram_start\n");
+		return -ENXIO;
+	}
+
+	ret = of_property_read_u64(emimpu_node,
+				   "dram_end", &mpu->dram_end);
+	if (ret) {
+		dev_err(&pdev->dev, "No dram_end fail\n");
+		return -ENXIO;
+	}
+
+	ret = of_property_read_u32(emimpu_node,
+				   "ctrl_intf", &mpu->ctrl_intf);
+	if (ret) {
+		dev_err(&pdev->dev, "No ctrl_intf\n");
+		return -ENXIO;
+	}
+
+	size = of_property_count_elems_of_size(emimpu_node,
+					       "dump", sizeof(char));
+	if (size <= 0) {
+		dev_err(&pdev->dev, "No dump\n");
+		return -ENXIO;
+	}
+	dump_list = devm_kmalloc(&pdev->dev, size, GFP_KERNEL);
+	if (!dump_list)
+		return -ENOMEM;
+	size >>= 2;
+	mpu->dump_cnt = size;
+	ret = of_property_read_u32_array(emimpu_node, "dump",
+					 dump_list, size);
+	if (ret) {
+		dev_err(&pdev->dev, "No dump\n");
+		return -ENXIO;
+	}
+	mpu->dump_reg = devm_kmalloc(&pdev->dev,
+				     size * sizeof(struct reg_info_t), GFP_KERNEL);
+	if (!(mpu->dump_reg))
+		return -ENOMEM;
+	for (i = 0; i < mpu->dump_cnt; i++) {
+		mpu->dump_reg[i].offset = dump_list[i];
+		mpu->dump_reg[i].value = 0;
+		mpu->dump_reg[i].leng = 0;
+	}
+
+	size = of_property_count_elems_of_size(emimpu_node,
+					       "clear", sizeof(char));
+	if (size <= 0) {
+		dev_err(&pdev->dev, "No clear\n");
+		return  -ENXIO;
+	}
+	mpu->clear_reg = devm_kmalloc(&pdev->dev,
+				      size, GFP_KERNEL);
+	if (!(mpu->clear_reg))
+		return -ENOMEM;
+	mpu->clear_reg_cnt = size / sizeof(struct reg_info_t);
+	size >>= 2;
+	ret = of_property_read_u32_array(emimpu_node, "clear",
+					 (unsigned int *)(mpu->clear_reg), size);
+	if (ret) {
+		dev_err(&pdev->dev, "No clear\n");
+		return -ENXIO;
+	}
+
+	size = of_property_count_elems_of_size(emimpu_node,
+					       "clear_md", sizeof(char));
+	if (size <= 0) {
+		dev_err(&pdev->dev, "No clear_md\n");
+		return -ENXIO;
+	}
+	mpu->clear_md_reg = devm_kmalloc(&pdev->dev,
+					 size, GFP_KERNEL);
+	if (!(mpu->clear_md_reg))
+		return -ENOMEM;
+	mpu->clear_md_reg_cnt = size / sizeof(struct reg_info_t);
+	size >>= 2;
+	ret = of_property_read_u32_array(emimpu_node, "clear_md",
+					 (unsigned int *)(mpu->clear_md_reg), size);
+	if (ret) {
+		dev_err(&pdev->dev, "No clear_md\n");
+		return -ENXIO;
+	}
+
+	mpu->emi_cen_cnt = of_property_count_elems_of_size(emicen_node,
+							   "reg",
+							   sizeof(unsigned int) * 4);
+	if (mpu->emi_cen_cnt <= 0) {
+		dev_err(&pdev->dev, "No reg\n");
+		return -ENXIO;
+	}
+
+	mpu->emi_cen_base = devm_kmalloc_array(&pdev->dev,
+					       mpu->emi_cen_cnt,
+					       sizeof(phys_addr_t),
+					       GFP_KERNEL);
+	if (!(mpu->emi_cen_base))
+		return -ENOMEM;
+
+	mpu->emi_mpu_base = devm_kmalloc_array(&pdev->dev,
+					       mpu->emi_cen_cnt,
+					       sizeof(phys_addr_t),
+					       GFP_KERNEL);
+	if (!(mpu->emi_mpu_base))
+		return -ENOMEM;
+
+	for (i = 0; i < mpu->emi_cen_cnt; i++) {
+		mpu->emi_cen_base[i] = of_iomap(emicen_node, i);
+		if (IS_ERR(mpu->emi_cen_base[i])) {
+			dev_err(&pdev->dev, "Failed to map EMI%d CEN base\n",
+				i);
+			return -EIO;
+		}
+
+		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
+		mpu->emi_mpu_base[i] =
+			devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(mpu->emi_mpu_base[i])) {
+			dev_err(&pdev->dev, "Failed to map EMI%d MPU base\n",
+				i);
+			return -EIO;
+		}
+	}
+
+	mpu->vio_msg = devm_kmalloc(&pdev->dev, MTK_EMI_MAX_CMD_LEN, GFP_KERNEL);
+	if (!(mpu->vio_msg))
+		return -ENOMEM;
+
+	global_emi_mpu = mpu;
+	platform_set_drvdata(pdev, mpu);
+
+	ret = of_property_read_u32(emimpu_node, "ap_region", &ap_region);
+	if (ret) {
+		mpu->ap_rg_info = NULL;
+		dev_info(&pdev->dev, "No ap_region\n");
+	} else {
+		/* initialize the AP region */
+
+		size = sizeof(unsigned int) * mpu->domain_cnt;
+		ap_apc = devm_kmalloc(&pdev->dev, size, GFP_KERNEL);
+		if (!ap_apc)
+			return -ENOMEM;
+		ret = of_property_read_u32_array(emimpu_node, "ap_apc",
+						 (unsigned int *)ap_apc,
+						 mpu->domain_cnt);
+		if (ret) {
+			dev_err(&pdev->dev, "No ap_apc\n");
+			return -ENXIO;
+		}
+
+		mpu->ap_rg_info = kmalloc(sizeof(*mpu->ap_rg_info),
+					  GFP_KERNEL);
+		if (!(mpu->ap_rg_info))
+			return -ENOMEM;
+
+		rg_info = mpu->ap_rg_info;
+
+		mtk_emimpu_init_region(rg_info, ap_region);
+
+		mtk_emimpu_set_addr(rg_info,
+				    mpu->dram_start, mpu->dram_end);
+
+		for (i = 0; i < mpu->domain_cnt; i++)
+			if (ap_apc[i] != MTK_EMIMPU_FORBIDDEN)
+				mtk_emimpu_set_apc(rg_info, i, ap_apc[i]);
+
+		mtk_emimpu_lock_region(rg_info, MTK_EMIMPU_LOCK);
+	}
+
+	mpu->irq = irq_of_parse_and_map(emimpu_node, 0);
+	if (mpu->irq == 0) {
+		dev_err(&pdev->dev, "Failed to get irq resource\n");
+		ret = -ENXIO;
+		goto free_ap_rg_info;
+	}
+	ret = request_irq(mpu->irq, (irq_handler_t)emimpu_violation_irq,
+			  IRQF_TRIGGER_NONE, "emimpu", mpu);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to request irq");
+		ret = -EINVAL;
+		goto free_ap_rg_info;
+	}
+
+	ret = of_property_read_u32(emimpu_node, "slverr", &slverr);
+	if (!ret && slverr)
+		for (i = 0; i < mpu->domain_cnt; i++) {
+			arm_smccc_smc(MTK_SIP_EMIMPU_CONTROL, MTK_EMIMPU_SLVERR,
+				      i, 0, 0, 0, 0, 0, &smc_res);
+			if (smc_res.a0) {
+				dev_err(&pdev->dev, "Failed to set MPU domain%d Slave Error, ret=0x%lx\n",
+					i, smc_res.a0);
+				ret = -EINVAL;
+				goto free_ap_rg_info;
+			}
+		}
+
+	devm_kfree(&pdev->dev, ap_apc);
+	devm_kfree(&pdev->dev, dump_list);
+
+	dev_info(&pdev->dev, "%s(%d),%s(%d),%s(%d),%s(%llx),%s(%llx),%s(%d)\n",
+		 "region_cnt", mpu->region_cnt,
+		 "domain_cnt", mpu->domain_cnt,
+		 "addr_align", mpu->addr_align,
+		 "dram_start", mpu->dram_start,
+		 "dram_end", mpu->dram_end,
+		 "ctrl_intf", mpu->ctrl_intf);
+
+	return 0;
+
+free_ap_rg_info:
+	kfree(mpu->ap_rg_info);
+
+	return ret;
+}
+
+static int emimpu_remove(struct platform_device *pdev)
+{
+	struct emi_mpu *mpu = platform_get_drvdata(pdev);
+
+	dev_info(&pdev->dev, "driver removed\n");
+
+	free_irq(mpu->irq, mpu);
+
+	flush_work(&emimpu_work);
+
+	global_emi_mpu = NULL;
+
+	return 0;
+}
+
+static struct platform_driver emimpu_driver = {
+	.probe = emimpu_probe,
+	.remove = emimpu_remove,
+	.driver = {
+		.name = "emimpu_driver",
+		.owner = THIS_MODULE,
+		.of_match_table = emimpu_of_ids,
+	},
+};
+
+static __init int emimpu_init(void)
+{
+	int ret;
+
+	pr_info("emimpu was loaded\n");
+
+	ret = platform_driver_register(&emimpu_driver);
+	if (ret) {
+		pr_err("emimpu: failed to register driver\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+module_init(emimpu_init);
+
+MODULE_DESCRIPTION("MediaTek EMI MPU Driver");
+MODULE_LICENSE("GPL v2");
diff --git a/include/linux/soc/mediatek/mtk_sip_svc.h b/include/linux/soc/mediatek/mtk_sip_svc.h
index 082398e..65a959a 100644
--- a/include/linux/soc/mediatek/mtk_sip_svc.h
+++ b/include/linux/soc/mediatek/mtk_sip_svc.h
@@ -21,5 +21,8 @@
 #define MTK_SIP_SMC_CMD(fn_id) \
 	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, MTK_SIP_SMC_CONVENTION, \
 			   ARM_SMCCC_OWNER_SIP, fn_id)
+/* EMI MPU */
+#define MTK_SIP_EMIMPU_CONTROL \
+	MTK_SIP_SMC_CMD(0x50B)
 
 #endif
diff --git a/include/soc/mediatek/emi.h b/include/soc/mediatek/emi.h
new file mode 100644
index 0000000..e766a7f
--- /dev/null
+++ b/include/soc/mediatek/emi.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ */
+
+#ifndef __EMI_H__
+#define __EMI_H__
+
+#include <linux/irqreturn.h>
+
+#define MTK_EMIMPU_NO_PROTECTION	0
+#define MTK_EMIMPU_SEC_RW		1
+#define MTK_EMIMPU_SEC_RW_NSEC_R	2
+#define MTK_EMIMPU_SEC_RW_NSEC_W	3
+#define MTK_EMIMPU_SEC_R_NSEC_R		4
+#define MTK_EMIMPU_FORBIDDEN		5
+#define MTK_EMIMPU_SEC_R_NSEC_RW	6
+
+#define MTK_EMIMPU_UNLOCK		false
+#define MTK_EMIMPU_LOCK			true
+
+#define MTK_EMIMPU_SET			0
+#define MTK_EMIMPU_CLEAR		1
+#define MTK_EMIMPU_READ			2
+#define MTK_EMIMPU_SLVERR		3
+#define MTK_EMIDBG_DUMP			4
+#define MTK_EMIDBG_MSG			5
+
+#define MTK_EMIMPU_READ_SA		0
+#define MTK_EMIMPU_READ_EA		1
+#define MTK_EMIMPU_READ_APC		2
+
+#define MTK_EMI_MAX_TOKEN		4
+#define MTK_EMI_MAX_CMD_LEN		4096
+
+struct emi_addr_map {
+	int emi;
+	int channel;
+	int rank;
+	int bank;
+	int row;
+	int column;
+};
+
+struct reg_info_t {
+	unsigned int offset;
+	unsigned int value;
+	unsigned int leng;
+};
+
+struct emimpu_region_t {
+	unsigned long long start;
+	unsigned long long end;
+	unsigned int rg_num;
+	bool lock;
+	unsigned int *apc;
+};
+
+typedef irqreturn_t (*emimpu_pre_handler)(unsigned int emi_id,
+					  struct reg_info_t *dump,
+					  unsigned int leng);
+typedef void (*emimpu_post_clear)(unsigned int emi_id);
+typedef void (*emimpu_md_handler)(unsigned int emi_id,
+				  struct reg_info_t *dump,
+				  unsigned int leng);
+typedef void (*emimpu_debug_dump)(void);
+
+struct emimpu_dbg_cb {
+	emimpu_debug_dump func;
+	struct emimpu_dbg_cb *next_dbg_cb;
+};
+
+/* mtk emicen api */
+unsigned int mtk_emicen_get_ch_cnt(void);
+unsigned int mtk_emicen_get_rk_cnt(void);
+unsigned int mtk_emicen_get_rk_size(unsigned int rk_id);
+int mtk_emicen_addr2dram(unsigned long addr, struct emi_addr_map *map);
+
+/* mtk emidbg api */
+void mtk_emidbg_dump(void);
+
+/* mtk emimpu api */
+int emimpu_ap_region_init(void);
+int mtk_emimpu_init_region(struct emimpu_region_t *rg_info,
+			   unsigned int rg_num);
+int mtk_emimpu_set_addr(struct emimpu_region_t *rg_info,
+			unsigned long long start, unsigned long long end);
+int mtk_emimpu_set_apc(struct emimpu_region_t *rg_info,
+		       unsigned int d_num, unsigned int apc);
+int mtk_emimpu_lock_region(struct emimpu_region_t *rg_info, bool lock);
+int mtk_emimpu_set_protection(struct emimpu_region_t *rg_info);
+int mtk_emimpu_free_region(struct emimpu_region_t *rg_info);
+int mtk_emimpu_clear_protection(struct emimpu_region_t *rg_info);
+int mtk_emimpu_prehandle_register(emimpu_pre_handler bypass_func);
+int mtk_emimpu_postclear_register(emimpu_post_clear clear_func);
+int mtk_emimpu_md_handling_register(emimpu_md_handler md_handling_func);
+int mtk_emimpu_debugdump_register(emimpu_debug_dump debug_func);
+void mtk_clear_md_violation(void);
+
+#endif /* __EMI_H__ */
+
-- 
1.9.1

