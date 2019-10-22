Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E14D6E09F1
	for <lists+dmaengine@lfdr.de>; Tue, 22 Oct 2019 19:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733002AbfJVRAt (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 22 Oct 2019 13:00:49 -0400
Received: from mail-eopbgr690058.outbound.protection.outlook.com ([40.107.69.58]:51744
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733000AbfJVRAs (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Tue, 22 Oct 2019 13:00:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJPa6oV0DmHT2ApzRT0XrdmH4wde6mLCVRYSoU2bTSh0tcDJDyztBm0FSl1qoOpAqvYXHjnnAmr9ozez6DcmWFg5EDTZwSsvTEVxK29x9SdBDttuuf/AlC9AkcmKYeMikNMIAKO0wh93q6oPqeF9ojjxLztTJ8V/vyEouRiA6Q9i5VVLDawf+P+DassTmZT2QgyYtmkIZu0+ILgFEMLxYKgbbGRDwz+1iu0WHzWynaV4GrfN/EM88fUQ4pJOwztvcHFkpDhLDAexSty8KRSgY5hzUaUXd5hP14uKF9bTKa9c0k9940FrPJIIDbuSGmJyo0s8m7cjCXMg7FSElJ44Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/9KcTsVK/tmUnZACNYE3qmEQuuyWtAysFtkNZJSDeg=;
 b=GA0pGecEUp26D5Zc/ZaOGzPVUp1TDJuEZMojN/pQzQnvbJnVreMsjEnjUwXaAXi3in66WloeRr4qvpdHrs52YOMAyYZxtfT4os5d7e1TG9mFMdk9B32RE0F7EKhtuKXqE+yooryLupUmTascozuB2X+6d7FBxkER+XsDZS6zSb+FXKWNk8HtoBmormSNGBK4ishsv0jrYvYIuk6+KftQm/2q07H07fGDbcSJ6goUmNsJ6vPAykHch4ZbDjOSJ8H9Ff3lSq5iL9BIYcNZtK+X/VtDdOxaLRQ/cjQHM1zVC8IEat7Q+xOllvU3t6pQCnrycdIlRQggC/RvNMEyisf3rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/9KcTsVK/tmUnZACNYE3qmEQuuyWtAysFtkNZJSDeg=;
 b=d2B3XSV+zFTQAmC+56dHJ3/VtRoQDnqfMiHpZQI0fBJZ0p0sPkmACdsq1v53Z/oxsQlE4HAFZqjJ0qVV9ndza9DPC2cgIKr5bJjsFP3NV17TBWLBYaawGjrDvlsWpByLtf0fEDw0rXV9ZjUYiESKoP330uB4j1NJfmW34+s25+k=
Received: from CY4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:903:18::23)
 by BN6PR02MB2801.namprd02.prod.outlook.com (2603:10b6:404:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.20; Tue, 22 Oct
 2019 17:00:43 +0000
Received: from SN1NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by CY4PR02CA0013.outlook.office365.com
 (2603:10b6:903:18::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.21 via Frontend
 Transport; Tue, 22 Oct 2019 17:00:43 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT051.mail.protection.outlook.com (10.152.73.103) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.2367.14
 via Frontend Transport; Tue, 22 Oct 2019 17:00:42 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWU-0006Ao-AJ; Tue, 22 Oct 2019 10:00:42 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1iMxWP-0005GS-00; Tue, 22 Oct 2019 10:00:37 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x9MH0XSm022074;
        Tue, 22 Oct 2019 10:00:35 -0700
Received: from [10.140.184.180] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1iMxWK-0005B4-Pl; Tue, 22 Oct 2019 10:00:33 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id DFEC1101134; Tue, 22 Oct 2019 22:30:30 +0530 (IST)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     vkoul@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        dan.j.williams@intel.com, michal.simek@xilinx.com,
        anirudha.sarangi@xilinx.com, nick.graumann@gmail.com,
        andrea.merello@gmail.com, appana.durga.rao@xilinx.com,
        mcgrof@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Subject: [PATCH -next 6/6] dmaengine: xilinx_dma: Add Xilinx AXI MCDMA Engine driver support
Date:   Tue, 22 Oct 2019 22:30:22 +0530
Message-Id: <1571763622-29281-7-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1571763622-29281-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--5.202-7.0-31-1
X-imss-scan-details: No--5.202-7.0-31-1;No--5.202-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(346002)(396003)(136003)(189003)(199004)(8936002)(446003)(11346002)(48376002)(426003)(336012)(126002)(50226002)(476003)(2906002)(486006)(42186006)(106002)(2616005)(186003)(36756003)(8676002)(81156014)(81166006)(4326008)(14444005)(107886003)(70586007)(6266002)(316002)(26005)(70206006)(103686004)(5660300002)(478600001)(305945005)(50466002)(7416002)(6666004)(16586007)(356004)(51416003)(47776003)(30864003)(76176011)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2801;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ec76a97-3086-49be-14bc-08d757115fd1
X-MS-TrafficTypeDiagnostic: BN6PR02MB2801:
X-Microsoft-Antispam-PRVS: <BN6PR02MB280188B0E2CFD70592555CF1C7680@BN6PR02MB2801.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:525;
X-Forefront-PRVS: 01986AE76B
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3e3UDmyqZPn78imZbu4KUI0gxbEg0VP9I+ymFhSvGhMX+LqGzUr0gjJ1W6eMlpBLJuD6UXcPKeWK/9iLSOYkKQ8POEN1hV/yJFnZPIJ2/2RSlDHlobGA3+680S/DOJfQJuoLtk/s1hv8jbirOpwYQ0xU8xhmxpPJHbdKxN3Rf0YRx6wwqCCiB6se/cd+DN9msa+K9pVhmiqMWBWIPf/nTNeT0RUJtCdJYirTGEEZpddsQuljR+bBLdSCnfnJFUqlFKdqZpkf3ZmHhA5f+fqLcjnDW4ABpsYCUwsrAuoK62EZfB5oMNfu6b5R3mEkac+CHMysEjwuI3ewvjmSS818UJvjs+XP6j8xwUulsDrombm1NAvL5+K9kcUsFWAqjvoaqWzpL8Gw2dw9XEdwWK/R+/YDm1l/3/Gfrxyd0t5/h2ei11IQm6z0Wt1Hpg1x5dEi
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2019 17:00:42.7581
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec76a97-3086-49be-14bc-08d757115fd1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2801
Sender: dmaengine-owner@vger.kernel.org
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Add support for AXI Multichannel Direct Memory Access (AXI MCDMA)
core, which is a soft Xilinx IP core that provides high-bandwidth
direct memory access between memory and AXI4-Stream target peripherals.
The AXI MCDMA core provides scatter-gather interface with multiple
independent transmit and receive channels. The driver supports
device_prep_slave_sg slave transfer mode.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes since RFC:
Mention that xilinx_mcdma_start_transfer is called with lock held.
Remove bogus empty lines.
Fix xilinx_mcdma_prep_slave_sg indentation.
In mcdma slave_sg function merge chan->direction and app word check.
Reuse axidma s2mm and mm2 channel nodes.
Add MCDA IP description in dma kconfig.
Regression fixes.
---
 drivers/dma/Kconfig             |   4 +
 drivers/dma/xilinx/xilinx_dma.c | 460 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 455 insertions(+), 9 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 59390e8..cc57801 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -655,6 +655,10 @@ config XILINX_DMA
 	  destination address.
 	  AXI DMA engine provides high-bandwidth one dimensional direct
 	  memory access between memory and AXI4-Stream target peripherals.
+	  AXI MCDMA engine provides high-bandwidth direct memory access
+	  between memory and AXI4-Stream target peripherals. It provides
+	  the scatter gather interface with multiple channels independent
+	  configuration support.
 
 config XILINX_ZYNQMP_DMA
 	tristate "Xilinx ZynqMP DMA Engine"
diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index 25042a9..d24d1a2 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -25,6 +25,12 @@
  * The AXI CDMA, is a soft IP, which provides high-bandwidth Direct Memory
  * Access (DMA) between a memory-mapped source address and a memory-mapped
  * destination address.
+ *
+ * The AXI Multichannel Direct Memory Access (AXI MCDMA) core is a soft
+ * Xilinx IP that provides high-bandwidth direct memory access between
+ * memory and AXI4-Stream target peripherals. It provides scatter gather
+ * (SG) interface with multiple channels independent configuration support.
+ *
  */
 
 #include <linux/bitops.h>
@@ -116,7 +122,7 @@
 #define XILINX_VDMA_ENABLE_VERTICAL_FLIP	BIT(0)
 
 /* HW specific definitions */
-#define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x2
+#define XILINX_DMA_MAX_CHANS_PER_DEVICE	0x20
 
 #define XILINX_DMA_DMAXR_ALL_IRQ_MASK	\
 		(XILINX_DMA_DMASR_FRM_CNT_IRQ | \
@@ -179,6 +185,31 @@
 
 #define xilinx_prep_dma_addr_t(addr)	\
 	((dma_addr_t)((u64)addr##_##msb << 32 | (addr)))
+
+/* AXI MCDMA Specific Registers/Offsets */
+#define XILINX_MCDMA_MM2S_CTRL_OFFSET		0x0000
+#define XILINX_MCDMA_S2MM_CTRL_OFFSET		0x0500
+#define XILINX_MCDMA_CHEN_OFFSET		0x0008
+#define XILINX_MCDMA_CH_ERR_OFFSET		0x0010
+#define XILINX_MCDMA_RXINT_SER_OFFSET		0x0020
+#define XILINX_MCDMA_TXINT_SER_OFFSET		0x0028
+#define XILINX_MCDMA_CHAN_CR_OFFSET(x)		(0x40 + (x) * 0x40)
+#define XILINX_MCDMA_CHAN_SR_OFFSET(x)		(0x44 + (x) * 0x40)
+#define XILINX_MCDMA_CHAN_CDESC_OFFSET(x)	(0x48 + (x) * 0x40)
+#define XILINX_MCDMA_CHAN_TDESC_OFFSET(x)	(0x50 + (x) * 0x40)
+
+/* AXI MCDMA Specific Masks/Shifts */
+#define XILINX_MCDMA_COALESCE_SHIFT		16
+#define XILINX_MCDMA_COALESCE_MAX		24
+#define XILINX_MCDMA_IRQ_ALL_MASK		GENMASK(7, 5)
+#define XILINX_MCDMA_COALESCE_MASK		GENMASK(23, 16)
+#define XILINX_MCDMA_CR_RUNSTOP_MASK		BIT(0)
+#define XILINX_MCDMA_IRQ_IOC_MASK		BIT(5)
+#define XILINX_MCDMA_IRQ_DELAY_MASK		BIT(6)
+#define XILINX_MCDMA_IRQ_ERR_MASK		BIT(7)
+#define XILINX_MCDMA_BD_EOP			BIT(30)
+#define XILINX_MCDMA_BD_SOP			BIT(31)
+
 /**
  * struct xilinx_vdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
@@ -225,6 +256,30 @@ struct xilinx_axidma_desc_hw {
 } __aligned(64);
 
 /**
+ * struct xilinx_aximcdma_desc_hw - Hardware Descriptor for AXI MCDMA
+ * @next_desc: Next Descriptor Pointer @0x00
+ * @next_desc_msb: MSB of Next Descriptor Pointer @0x04
+ * @buf_addr: Buffer address @0x08
+ * @buf_addr_msb: MSB of Buffer address @0x0C
+ * @rsvd: Reserved field @0x10
+ * @control: Control Information field @0x14
+ * @status: Status field @0x18
+ * @sideband_status: Status of sideband signals @0x1C
+ * @app: APP Fields @0x20 - 0x30
+ */
+struct xilinx_aximcdma_desc_hw {
+	u32 next_desc;
+	u32 next_desc_msb;
+	u32 buf_addr;
+	u32 buf_addr_msb;
+	u32 rsvd;
+	u32 control;
+	u32 status;
+	u32 sideband_status;
+	u32 app[XILINX_DMA_NUM_APP_WORDS];
+} __aligned(64);
+
+/**
  * struct xilinx_cdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
  * @next_desc_msb: Next Descriptor Pointer MSB @0x04
@@ -271,6 +326,18 @@ struct xilinx_axidma_tx_segment {
 } __aligned(64);
 
 /**
+ * struct xilinx_aximcdma_tx_segment - Descriptor segment
+ * @hw: Hardware descriptor
+ * @node: Node in the descriptor segments list
+ * @phys: Physical address of segment
+ */
+struct xilinx_aximcdma_tx_segment {
+	struct xilinx_aximcdma_desc_hw hw;
+	struct list_head node;
+	dma_addr_t phys;
+} __aligned(64);
+
+/**
  * struct xilinx_cdma_tx_segment - Descriptor segment
  * @hw: Hardware descriptor
  * @node: Node in the descriptor segments list
@@ -329,11 +396,13 @@ struct xilinx_dma_tx_descriptor {
  * @ext_addr: Indicates 64 bit addressing is supported by dma channel
  * @desc_submitcount: Descriptor h/w submitted count
  * @seg_v: Statically allocated segments base
+ * @seg_mv: Statically allocated segments base for MCDMA
  * @seg_p: Physical allocated segments base
  * @cyclic_seg_v: Statically allocated segment base for cyclic transfers
  * @cyclic_seg_p: Physical allocated segments base for cyclic dma
  * @start_transfer: Differentiate b/w DMA IP's transfer
  * @stop_transfer: Differentiate b/w DMA IP's quiesce
+ * @tdest: TDEST value for mcdma
  * @has_vflip: S2MM vertical flip
  */
 struct xilinx_dma_chan {
@@ -364,11 +433,13 @@ struct xilinx_dma_chan {
 	bool ext_addr;
 	u32 desc_submitcount;
 	struct xilinx_axidma_tx_segment *seg_v;
+	struct xilinx_aximcdma_tx_segment *seg_mv;
 	dma_addr_t seg_p;
 	struct xilinx_axidma_tx_segment *cyclic_seg_v;
 	dma_addr_t cyclic_seg_p;
 	void (*start_transfer)(struct xilinx_dma_chan *chan);
 	int (*stop_transfer)(struct xilinx_dma_chan *chan);
+	u16 tdest;
 	bool has_vflip;
 };
 
@@ -378,12 +449,14 @@ struct xilinx_dma_chan {
  * @XDMA_TYPE_AXIDMA: Axi dma ip.
  * @XDMA_TYPE_CDMA: Axi cdma ip.
  * @XDMA_TYPE_VDMA: Axi vdma ip.
+ * @XDMA_TYPE_AXIMCDMA: Axi MCDMA ip.
  *
  */
 enum xdma_ip_type {
 	XDMA_TYPE_AXIDMA = 0,
 	XDMA_TYPE_CDMA,
 	XDMA_TYPE_VDMA,
+	XDMA_TYPE_AXIMCDMA
 };
 
 struct xilinx_dma_config {
@@ -412,6 +485,7 @@ struct xilinx_dma_config {
  * @nr_channels: Number of channels DMA device supports
  * @chan_id: DMA channel identifier
  * @max_buffer_len: Max buffer length
+ * @s2mm_index: S2MM channel index
  */
 struct xilinx_dma_device {
 	void __iomem *regs;
@@ -430,6 +504,7 @@ struct xilinx_dma_device {
 	u32 nr_channels;
 	u32 chan_id;
 	u32 max_buffer_len;
+	u32 s2mm_index;
 };
 
 /* Macros */
@@ -530,6 +605,18 @@ static inline void xilinx_axidma_buf(struct xilinx_dma_chan *chan,
 	}
 }
 
+static inline void xilinx_aximcdma_buf(struct xilinx_dma_chan *chan,
+				       struct xilinx_aximcdma_desc_hw *hw,
+				       dma_addr_t buf_addr, size_t sg_used)
+{
+	if (chan->ext_addr) {
+		hw->buf_addr = lower_32_bits(buf_addr + sg_used);
+		hw->buf_addr_msb = upper_32_bits(buf_addr + sg_used);
+	} else {
+		hw->buf_addr = buf_addr + sg_used;
+	}
+}
+
 /* -----------------------------------------------------------------------------
  * Descriptors and segments alloc and free
  */
@@ -603,6 +690,30 @@ xilinx_axidma_alloc_tx_segment(struct xilinx_dma_chan *chan)
 	return segment;
 }
 
+/**
+ * xilinx_aximcdma_alloc_tx_segment - Allocate transaction segment
+ * @chan: Driver specific DMA channel
+ *
+ * Return: The allocated segment on success and NULL on failure.
+ */
+static struct xilinx_aximcdma_tx_segment *
+xilinx_aximcdma_alloc_tx_segment(struct xilinx_dma_chan *chan)
+{
+	struct xilinx_aximcdma_tx_segment *segment = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chan->lock, flags);
+	if (!list_empty(&chan->free_seg_list)) {
+		segment = list_first_entry(&chan->free_seg_list,
+					   struct xilinx_aximcdma_tx_segment,
+					   node);
+		list_del(&segment->node);
+	}
+	spin_unlock_irqrestore(&chan->lock, flags);
+
+	return segment;
+}
+
 static void xilinx_dma_clean_hw_desc(struct xilinx_axidma_desc_hw *hw)
 {
 	u32 next_desc = hw->next_desc;
@@ -614,6 +725,17 @@ static void xilinx_dma_clean_hw_desc(struct xilinx_axidma_desc_hw *hw)
 	hw->next_desc_msb = next_desc_msb;
 }
 
+static void xilinx_mcdma_clean_hw_desc(struct xilinx_aximcdma_desc_hw *hw)
+{
+	u32 next_desc = hw->next_desc;
+	u32 next_desc_msb = hw->next_desc_msb;
+
+	memset(hw, 0, sizeof(struct xilinx_aximcdma_desc_hw));
+
+	hw->next_desc = next_desc;
+	hw->next_desc_msb = next_desc_msb;
+}
+
 /**
  * xilinx_dma_free_tx_segment - Free transaction segment
  * @chan: Driver specific DMA channel
@@ -628,6 +750,20 @@ static void xilinx_dma_free_tx_segment(struct xilinx_dma_chan *chan,
 }
 
 /**
+ * xilinx_mcdma_free_tx_segment - Free transaction segment
+ * @chan: Driver specific DMA channel
+ * @segment: DMA transaction segment
+ */
+static void xilinx_mcdma_free_tx_segment(struct xilinx_dma_chan *chan,
+					 struct xilinx_aximcdma_tx_segment *
+					 segment)
+{
+	xilinx_mcdma_clean_hw_desc(&segment->hw);
+
+	list_add_tail(&segment->node, &chan->free_seg_list);
+}
+
+/**
  * xilinx_cdma_free_tx_segment - Free transaction segment
  * @chan: Driver specific DMA channel
  * @segment: DMA transaction segment
@@ -681,6 +817,7 @@ xilinx_dma_free_tx_descriptor(struct xilinx_dma_chan *chan,
 	struct xilinx_vdma_tx_segment *segment, *next;
 	struct xilinx_cdma_tx_segment *cdma_segment, *cdma_next;
 	struct xilinx_axidma_tx_segment *axidma_segment, *axidma_next;
+	struct xilinx_aximcdma_tx_segment *aximcdma_segment, *aximcdma_next;
 
 	if (!desc)
 		return;
@@ -696,12 +833,18 @@ xilinx_dma_free_tx_descriptor(struct xilinx_dma_chan *chan,
 			list_del(&cdma_segment->node);
 			xilinx_cdma_free_tx_segment(chan, cdma_segment);
 		}
-	} else {
+	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		list_for_each_entry_safe(axidma_segment, axidma_next,
 					 &desc->segments, node) {
 			list_del(&axidma_segment->node);
 			xilinx_dma_free_tx_segment(chan, axidma_segment);
 		}
+	} else {
+		list_for_each_entry_safe(aximcdma_segment, aximcdma_next,
+					 &desc->segments, node) {
+			list_del(&aximcdma_segment->node);
+			xilinx_mcdma_free_tx_segment(chan, aximcdma_segment);
+		}
 	}
 
 	kfree(desc);
@@ -770,10 +913,23 @@ static void xilinx_dma_free_chan_resources(struct dma_chan *dchan)
 				  chan->cyclic_seg_v, chan->cyclic_seg_p);
 	}
 
-	if (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA) {
+	if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		spin_lock_irqsave(&chan->lock, flags);
+		INIT_LIST_HEAD(&chan->free_seg_list);
+		spin_unlock_irqrestore(&chan->lock, flags);
+
+		/* Free memory that is allocated for BD */
+		dma_free_coherent(chan->dev, sizeof(*chan->seg_mv) *
+				  XILINX_DMA_NUM_DESCS, chan->seg_mv,
+				  chan->seg_p);
+	}
+
+	if (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA &&
+	    chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIMCDMA) {
 		dma_pool_destroy(chan->desc_pool);
 		chan->desc_pool = NULL;
 	}
+
 }
 
 /**
@@ -955,6 +1111,30 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 			list_add_tail(&chan->seg_v[i].node,
 				      &chan->free_seg_list);
 		}
+	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		/* Allocate the buffer descriptors. */
+		chan->seg_mv = dma_alloc_coherent(chan->dev,
+						  sizeof(*chan->seg_mv) *
+						  XILINX_DMA_NUM_DESCS,
+						  &chan->seg_p, GFP_KERNEL);
+		if (!chan->seg_mv) {
+			dev_err(chan->dev,
+				"unable to allocate channel %d descriptors\n",
+				chan->id);
+			return -ENOMEM;
+		}
+		for (i = 0; i < XILINX_DMA_NUM_DESCS; i++) {
+			chan->seg_mv[i].hw.next_desc =
+			lower_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
+				((i + 1) % XILINX_DMA_NUM_DESCS));
+			chan->seg_mv[i].hw.next_desc_msb =
+			upper_32_bits(chan->seg_p + sizeof(*chan->seg_mv) *
+				((i + 1) % XILINX_DMA_NUM_DESCS));
+			chan->seg_mv[i].phys = chan->seg_p +
+				sizeof(*chan->seg_v) * i;
+			list_add_tail(&chan->seg_mv[i].node,
+				      &chan->free_seg_list);
+		}
 	} else if (chan->xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		chan->desc_pool = dma_pool_create("xilinx_cdma_desc_pool",
 				   chan->dev,
@@ -970,7 +1150,8 @@ static int xilinx_dma_alloc_chan_resources(struct dma_chan *dchan)
 	}
 
 	if (!chan->desc_pool &&
-	    (chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA)) {
+	    ((chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIDMA) &&
+		chan->xdev->dma_config->dmatype != XDMA_TYPE_AXIMCDMA)) {
 		dev_err(chan->dev,
 			"unable to allocate channel %d descriptor pool\n",
 			chan->id);
@@ -1368,6 +1549,76 @@ static void xilinx_dma_start_transfer(struct xilinx_dma_chan *chan)
 }
 
 /**
+ * xilinx_mcdma_start_transfer - Starts MCDMA transfer
+ * @chan: Driver specific channel struct pointer
+ */
+static void xilinx_mcdma_start_transfer(struct xilinx_dma_chan *chan)
+{
+	struct xilinx_dma_tx_descriptor *head_desc, *tail_desc;
+	struct xilinx_axidma_tx_segment *tail_segment;
+	u32 reg;
+
+	/*
+	 * lock has been held by calling functions, so we don't need it
+	 * to take it here again.
+	 */
+
+	if (chan->err)
+		return;
+
+	if (!chan->idle)
+		return;
+
+	if (list_empty(&chan->pending_list))
+		return;
+
+	head_desc = list_first_entry(&chan->pending_list,
+				     struct xilinx_dma_tx_descriptor, node);
+	tail_desc = list_last_entry(&chan->pending_list,
+				    struct xilinx_dma_tx_descriptor, node);
+	tail_segment = list_last_entry(&tail_desc->segments,
+				       struct xilinx_axidma_tx_segment, node);
+
+	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest));
+
+	if (chan->desc_pendingcount <= XILINX_MCDMA_COALESCE_MAX) {
+		reg &= ~XILINX_MCDMA_COALESCE_MASK;
+		reg |= chan->desc_pendingcount <<
+			XILINX_MCDMA_COALESCE_SHIFT;
+	}
+
+	reg |= XILINX_MCDMA_IRQ_ALL_MASK;
+	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
+
+	/* Program current descriptor */
+	xilinx_write(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET(chan->tdest),
+		     head_desc->async_tx.phys);
+
+	/* Program channel enable register */
+	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHEN_OFFSET);
+	reg |= BIT(chan->tdest);
+	dma_ctrl_write(chan, XILINX_MCDMA_CHEN_OFFSET, reg);
+
+	/* Start the fetch of BDs for the channel */
+	reg = dma_ctrl_read(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest));
+	reg |= XILINX_MCDMA_CR_RUNSTOP_MASK;
+	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_CR_OFFSET(chan->tdest), reg);
+
+	xilinx_dma_start(chan);
+
+	if (chan->err)
+		return;
+
+	/* Start the transfer */
+	xilinx_write(chan, XILINX_MCDMA_CHAN_TDESC_OFFSET(chan->tdest),
+		     tail_segment->phys);
+
+	list_splice_tail_init(&chan->pending_list, &chan->active_list);
+	chan->desc_pendingcount = 0;
+	chan->idle = false;
+}
+
+/**
  * xilinx_dma_issue_pending - Issue pending transactions
  * @dchan: DMA channel
  */
@@ -1466,6 +1717,74 @@ static int xilinx_dma_chan_reset(struct xilinx_dma_chan *chan)
 }
 
 /**
+ * xilinx_mcdma_irq_handler - MCDMA Interrupt handler
+ * @irq: IRQ number
+ * @data: Pointer to the Xilinx MCDMA channel structure
+ *
+ * Return: IRQ_HANDLED/IRQ_NONE
+ */
+static irqreturn_t xilinx_mcdma_irq_handler(int irq, void *data)
+{
+	struct xilinx_dma_chan *chan = data;
+	u32 status, ser_offset, chan_sermask, chan_offset = 0, chan_id;
+
+	if (chan->direction == DMA_DEV_TO_MEM)
+		ser_offset = XILINX_MCDMA_RXINT_SER_OFFSET;
+	else
+		ser_offset = XILINX_MCDMA_TXINT_SER_OFFSET;
+
+	/* Read the channel id raising the interrupt*/
+	chan_sermask = dma_ctrl_read(chan, ser_offset);
+	chan_id = ffs(chan_sermask);
+
+	if (!chan_id)
+		return IRQ_NONE;
+
+	if (chan->direction == DMA_DEV_TO_MEM)
+		chan_offset = chan->xdev->s2mm_index;
+
+	chan_offset = chan_offset + (chan_id - 1);
+	chan = chan->xdev->chan[chan_offset];
+	/* Read the status and ack the interrupts. */
+	status = dma_ctrl_read(chan, XILINX_MCDMA_CHAN_SR_OFFSET(chan->tdest));
+	if (!(status & XILINX_MCDMA_IRQ_ALL_MASK))
+		return IRQ_NONE;
+
+	dma_ctrl_write(chan, XILINX_MCDMA_CHAN_SR_OFFSET(chan->tdest),
+		       status & XILINX_MCDMA_IRQ_ALL_MASK);
+
+	if (status & XILINX_MCDMA_IRQ_ERR_MASK) {
+		dev_err(chan->dev, "Channel %p has errors %x cdr %x tdr %x\n",
+			chan,
+			dma_ctrl_read(chan, XILINX_MCDMA_CH_ERR_OFFSET),
+			dma_ctrl_read(chan, XILINX_MCDMA_CHAN_CDESC_OFFSET
+				      (chan->tdest)),
+			dma_ctrl_read(chan, XILINX_MCDMA_CHAN_TDESC_OFFSET
+				      (chan->tdest)));
+		chan->err = true;
+	}
+
+	if (status & XILINX_MCDMA_IRQ_DELAY_MASK) {
+		/*
+		 * Device takes too long to do the transfer when user requires
+		 * responsiveness.
+		 */
+		dev_dbg(chan->dev, "Inter-packet latency too long\n");
+	}
+
+	if (status & XILINX_MCDMA_IRQ_IOC_MASK) {
+		spin_lock(&chan->lock);
+		xilinx_dma_complete_descriptor(chan);
+		chan->idle = true;
+		chan->start_transfer(chan);
+		spin_unlock(&chan->lock);
+	}
+
+	tasklet_schedule(&chan->tasklet);
+	return IRQ_HANDLED;
+}
+
+/**
  * xilinx_dma_irq_handler - DMA Interrupt handler
  * @irq: IRQ number
  * @data: Pointer to the Xilinx DMA channel structure
@@ -1972,6 +2291,104 @@ static struct dma_async_tx_descriptor *xilinx_dma_prep_dma_cyclic(
 }
 
 /**
+ * xilinx_mcdma_prep_slave_sg - prepare descriptors for a DMA_SLAVE transaction
+ * @dchan: DMA channel
+ * @sgl: scatterlist to transfer to/from
+ * @sg_len: number of entries in @scatterlist
+ * @direction: DMA direction
+ * @flags: transfer ack flags
+ * @context: APP words of the descriptor
+ *
+ * Return: Async transaction descriptor on success and NULL on failure
+ */
+static struct dma_async_tx_descriptor *
+xilinx_mcdma_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
+			   unsigned int sg_len,
+			   enum dma_transfer_direction direction,
+			   unsigned long flags, void *context)
+{
+	struct xilinx_dma_chan *chan = to_xilinx_chan(dchan);
+	struct xilinx_dma_tx_descriptor *desc;
+	struct xilinx_aximcdma_tx_segment *segment = NULL;
+	u32 *app_w = (u32 *)context;
+	struct scatterlist *sg;
+	size_t copy;
+	size_t sg_used;
+	unsigned int i;
+
+	if (!is_slave_direction(direction))
+		return NULL;
+
+	/* Allocate a transaction descriptor. */
+	desc = xilinx_dma_alloc_tx_descriptor(chan);
+	if (!desc)
+		return NULL;
+
+	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
+	desc->async_tx.tx_submit = xilinx_dma_tx_submit;
+
+	/* Build transactions using information in the scatter gather list */
+	for_each_sg(sgl, sg, sg_len, i) {
+		sg_used = 0;
+
+		/* Loop until the entire scatterlist entry is used */
+		while (sg_used < sg_dma_len(sg)) {
+			struct xilinx_aximcdma_desc_hw *hw;
+
+			/* Get a free segment */
+			segment = xilinx_aximcdma_alloc_tx_segment(chan);
+			if (!segment)
+				goto error;
+
+			/*
+			 * Calculate the maximum number of bytes to transfer,
+			 * making sure it is less than the hw limit
+			 */
+			copy = min_t(size_t, sg_dma_len(sg) - sg_used,
+				     chan->xdev->max_buffer_len);
+			hw = &segment->hw;
+
+			/* Fill in the descriptor */
+			xilinx_aximcdma_buf(chan, hw, sg_dma_address(sg),
+					    sg_used);
+			hw->control = copy;
+
+			if (chan->direction == DMA_MEM_TO_DEV && app_w) {
+				memcpy(hw->app, app_w, sizeof(u32) *
+				       XILINX_DMA_NUM_APP_WORDS);
+			}
+
+			sg_used += copy;
+			/*
+			 * Insert the segment into the descriptor segments
+			 * list.
+			 */
+			list_add_tail(&segment->node, &desc->segments);
+		}
+	}
+
+	segment = list_first_entry(&desc->segments,
+				   struct xilinx_aximcdma_tx_segment, node);
+	desc->async_tx.phys = segment->phys;
+
+	/* For the last DMA_MEM_TO_DEV transfer, set EOP */
+	if (chan->direction == DMA_MEM_TO_DEV) {
+		segment->hw.control |= XILINX_MCDMA_BD_SOP;
+		segment = list_last_entry(&desc->segments,
+					  struct xilinx_aximcdma_tx_segment,
+					  node);
+		segment->hw.control |= XILINX_MCDMA_BD_EOP;
+	}
+
+	return &desc->async_tx;
+
+error:
+	xilinx_dma_free_tx_descriptor(chan, desc);
+
+	return NULL;
+}
+
+/**
  * xilinx_dma_terminate_all - Halt the channel and free descriptors
  * @dchan: Driver specific DMA Channel pointer
  *
@@ -2363,6 +2780,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	    of_device_is_compatible(node, "xlnx,axi-cdma-channel")) {
 		chan->direction = DMA_MEM_TO_DEV;
 		chan->id = chan_id;
+		chan->tdest = chan_id;
 
 		chan->ctrl_offset = XILINX_DMA_MM2S_CTRL_OFFSET;
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
@@ -2379,6 +2797,8 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 					   "xlnx,axi-dma-s2mm-channel")) {
 		chan->direction = DMA_DEV_TO_MEM;
 		chan->id = chan_id;
+		xdev->s2mm_index = xdev->nr_channels;
+		chan->tdest = chan_id - xdev->nr_channels;
 		chan->has_vflip = of_property_read_bool(node,
 					"xlnx,enable-vert-flip");
 		if (chan->has_vflip) {
@@ -2387,7 +2807,11 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 				XILINX_VDMA_ENABLE_VERTICAL_FLIP;
 		}
 
-		chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
+		if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA)
+			chan->ctrl_offset = XILINX_MCDMA_S2MM_CTRL_OFFSET;
+		else
+			chan->ctrl_offset = XILINX_DMA_S2MM_CTRL_OFFSET;
+
 		if (xdev->dma_config->dmatype == XDMA_TYPE_VDMA) {
 			chan->desc_offset = XILINX_VDMA_S2MM_DESC_OFFSET;
 			chan->config.park = 1;
@@ -2402,7 +2826,7 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	}
 
 	/* Request the interrupt */
-	chan->irq = irq_of_parse_and_map(node, 0);
+	chan->irq = irq_of_parse_and_map(node, chan->tdest);
 	err = request_irq(chan->irq, xdev->dma_config->irq_handler,
 			  IRQF_SHARED, "xilinx-dma-controller", chan);
 	if (err) {
@@ -2413,6 +2837,9 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
 		chan->start_transfer = xilinx_dma_start_transfer;
 		chan->stop_transfer = xilinx_dma_stop_transfer;
+	} else if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		chan->start_transfer = xilinx_mcdma_start_transfer;
+		chan->stop_transfer = xilinx_dma_stop_transfer;
 	} else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA) {
 		chan->start_transfer = xilinx_cdma_start_transfer;
 		chan->stop_transfer = xilinx_cdma_stop_transfer;
@@ -2466,7 +2893,11 @@ static int xilinx_dma_chan_probe(struct xilinx_dma_device *xdev,
 static int xilinx_dma_child_probe(struct xilinx_dma_device *xdev,
 				    struct device_node *node)
 {
-	int i, nr_channels = 1;
+	int ret, i, nr_channels = 1;
+
+	ret = of_property_read_u32(node, "dma-channels", &nr_channels);
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA && ret < 0)
+		dev_warn(xdev->dev, "missing dma-channels property\n");
 
 	for (i = 0; i < nr_channels; i++)
 		xilinx_dma_chan_probe(xdev, node, xdev->chan_id++);
@@ -2501,6 +2932,11 @@ static const struct xilinx_dma_config axidma_config = {
 	.irq_handler = xilinx_dma_irq_handler,
 };
 
+static const struct xilinx_dma_config aximcdma_config = {
+	.dmatype = XDMA_TYPE_AXIMCDMA,
+	.clk_init = axidma_clk_init,
+	.irq_handler = xilinx_mcdma_irq_handler,
+};
 static const struct xilinx_dma_config axicdma_config = {
 	.dmatype = XDMA_TYPE_CDMA,
 	.clk_init = axicdma_clk_init,
@@ -2517,6 +2953,7 @@ static const struct of_device_id xilinx_dma_of_ids[] = {
 	{ .compatible = "xlnx,axi-dma-1.00.a", .data = &axidma_config },
 	{ .compatible = "xlnx,axi-cdma-1.00.a", .data = &axicdma_config },
 	{ .compatible = "xlnx,axi-vdma-1.00.a", .data = &axivdma_config },
+	{ .compatible = "xlnx,axi-mcdma-1.00.a", .data = &aximcdma_config },
 	{}
 };
 MODULE_DEVICE_TABLE(of, xilinx_dma_of_ids);
@@ -2567,7 +3004,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 	/* Retrieve the DMA engine properties from the device tree */
 	xdev->max_buffer_len = GENMASK(XILINX_DMA_MAX_TRANS_LEN_MAX - 1, 0);
 
-	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA) {
+	if (xdev->dma_config->dmatype == XDMA_TYPE_AXIDMA ||
+	    xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
 		if (!of_property_read_u32(node, "xlnx,sg-length-width",
 					  &len_width)) {
 			if (len_width < XILINX_DMA_MAX_TRANS_LEN_MIN ||
@@ -2640,7 +3078,9 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		xdev->common.device_prep_dma_memcpy = xilinx_cdma_prep_memcpy;
 		/* Residue calculation is supported by only AXI DMA and CDMA */
 		xdev->common.residue_granularity =
-					DMA_RESIDUE_GRANULARITY_SEGMENT;
+					  DMA_RESIDUE_GRANULARITY_SEGMENT;
+	} else if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA) {
+		xdev->common.device_prep_slave_sg = xilinx_mcdma_prep_slave_sg;
 	} else {
 		xdev->common.device_prep_interleaved_dma =
 				xilinx_vdma_dma_prep_interleaved;
@@ -2676,6 +3116,8 @@ static int xilinx_dma_probe(struct platform_device *pdev)
 		dev_info(&pdev->dev, "Xilinx AXI DMA Engine Driver Probed!!\n");
 	else if (xdev->dma_config->dmatype == XDMA_TYPE_CDMA)
 		dev_info(&pdev->dev, "Xilinx AXI CDMA Engine Driver Probed!!\n");
+	else if (xdev->dma_config->dmatype == XDMA_TYPE_AXIMCDMA)
+		dev_info(&pdev->dev, "Xilinx AXI MCDMA Engine Driver Probed!!\n");
 	else
 		dev_info(&pdev->dev, "Xilinx AXI VDMA Engine Driver Probed!!\n");
 
-- 
2.7.4

