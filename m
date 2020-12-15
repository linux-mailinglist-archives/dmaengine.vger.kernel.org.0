Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039882DB2DE
	for <lists+dmaengine@lfdr.de>; Tue, 15 Dec 2020 18:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731269AbgLORlZ (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 15 Dec 2020 12:41:25 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46014 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731040AbgLORbi (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 15 Dec 2020 12:31:38 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E8118C04D0;
        Tue, 15 Dec 2020 17:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608053437; bh=oNfEKarVynQpWQYDjVDdd5U8tWSCEBgnT+5HnoYP8SI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=JFwIZvF5DM7HV26zwl5nYjXj82/8PcbaQvPdgYzFl4l6BeDWcppxyhXy1npyVK3Y4
         Cb3AcmpRAl/6gmW8+uhB8iaz4pb18X23iHOx9P4XOhovx83PGTXhQpW/UKQx7tSRQL
         BXh0GYG0NzJHucJ2IOUJb9PGLU846q3LuqvO3HgWfMyhf3ORn740FogzAWM5ZBZoFT
         3r65aWlPplC7Q2eOkCTkYhBI1a7ZOMIK9rslxggons6YL6o/LDmBD6VTOmiFUjAbjW
         k1w5NeWNj+SNyw7KZmNruP8T8kSpF8i0+72po2D30MkfrxLcaC7dUD9vX/8PfEEl/v
         onU4nTfF4EB/w==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 755ABA024A;
        Tue, 15 Dec 2020 17:30:35 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/15] dmaengine: dw-edma: Fix comments offset characters' alignment
Date:   Tue, 15 Dec 2020 18:30:11 +0100
Message-Id: <3525b67abb340d57d579f4d15edaf261855f96c4.1608053262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

Fix comments offset characters' alignment to follow the same structure
of similar comments.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/dma/dw-edma/dw-edma-v0-regs.h | 214 +++++++++++++++++-----------------
 1 file changed, 107 insertions(+), 107 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-v0-regs.h b/drivers/dma/dw-edma/dw-edma-v0-regs.h
index d07151d..e175f7b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-edma-v0-regs.h
@@ -25,177 +25,177 @@
 #define EDMA_V0_CH_EVEN_MSI_DATA_MASK			GENMASK(15, 0)
 
 struct dw_edma_v0_ch_regs {
-	u32 ch_control1;				/* 0x000 */
-	u32 ch_control2;				/* 0x004 */
-	u32 transfer_size;				/* 0x008 */
+	u32 ch_control1;				/* 0x0000 */
+	u32 ch_control2;				/* 0x0004 */
+	u32 transfer_size;				/* 0x0008 */
 	union {
-		u64 reg;				/* 0x00c..0x010 */
+		u64 reg;				/* 0x000c..0x0010 */
 		struct {
-			u32 lsb;			/* 0x00c */
-			u32 msb;			/* 0x010 */
+			u32 lsb;			/* 0x000c */
+			u32 msb;			/* 0x0010 */
 		};
 	} sar;
 	union {
-		u64 reg;				/* 0x014..0x018 */
+		u64 reg;				/* 0x0014..0x0018 */
 		struct {
-			u32 lsb;			/* 0x014 */
-			u32 msb;			/* 0x018 */
+			u32 lsb;			/* 0x0014 */
+			u32 msb;			/* 0x0018 */
 		};
 	} dar;
 	union {
-		u64 reg;				/* 0x01c..0x020 */
+		u64 reg;				/* 0x001c..0x0020 */
 		struct {
-			u32 lsb;			/* 0x01c */
-			u32 msb;			/* 0x020 */
+			u32 lsb;			/* 0x001c */
+			u32 msb;			/* 0x0020 */
 		};
 	} llp;
 } __packed;
 
 struct dw_edma_v0_ch {
-	struct dw_edma_v0_ch_regs wr;			/* 0x200 */
-	u32 padding_1[55];				/* [0x224..0x2fc] */
-	struct dw_edma_v0_ch_regs rd;			/* 0x300 */
-	u32 padding_2[55];				/* [0x324..0x3fc] */
+	struct dw_edma_v0_ch_regs wr;			/* 0x0200 */
+	u32 padding_1[55];				/* 0x0224..0x02fc */
+	struct dw_edma_v0_ch_regs rd;			/* 0x0300 */
+	u32 padding_2[55];				/* 0x0324..0x03fc */
 } __packed;
 
 struct dw_edma_v0_unroll {
-	u32 padding_1;					/* 0x0f8 */
-	u32 wr_engine_chgroup;				/* 0x100 */
-	u32 rd_engine_chgroup;				/* 0x104 */
+	u32 padding_1;					/* 0x00f8 */
+	u32 wr_engine_chgroup;				/* 0x0100 */
+	u32 rd_engine_chgroup;				/* 0x0104 */
 	union {
-		u64 reg;				/* 0x108..0x10c */
+		u64 reg;				/* 0x0108..0x010c */
 		struct {
-			u32 lsb;			/* 0x108 */
-			u32 msb;			/* 0x10c */
+			u32 lsb;			/* 0x0108 */
+			u32 msb;			/* 0x010c */
 		};
 	} wr_engine_hshake_cnt;
-	u32 padding_2[2];				/* [0x110..0x114] */
+	u32 padding_2[2];				/* 0x0110..0x0114 */
 	union {
-		u64 reg;				/* 0x120..0x124 */
+		u64 reg;				/* 0x0120..0x0124 */
 		struct {
-			u32 lsb;			/* 0x120 */
-			u32 msb;			/* 0x124 */
+			u32 lsb;			/* 0x0120 */
+			u32 msb;			/* 0x0124 */
 		};
 	} rd_engine_hshake_cnt;
-	u32 padding_3[2];				/* [0x120..0x124] */
-	u32 wr_ch0_pwr_en;				/* 0x128 */
-	u32 wr_ch1_pwr_en;				/* 0x12c */
-	u32 wr_ch2_pwr_en;				/* 0x130 */
-	u32 wr_ch3_pwr_en;				/* 0x134 */
-	u32 wr_ch4_pwr_en;				/* 0x138 */
-	u32 wr_ch5_pwr_en;				/* 0x13c */
-	u32 wr_ch6_pwr_en;				/* 0x140 */
-	u32 wr_ch7_pwr_en;				/* 0x144 */
-	u32 padding_4[8];				/* [0x148..0x164] */
-	u32 rd_ch0_pwr_en;				/* 0x168 */
-	u32 rd_ch1_pwr_en;				/* 0x16c */
-	u32 rd_ch2_pwr_en;				/* 0x170 */
-	u32 rd_ch3_pwr_en;				/* 0x174 */
-	u32 rd_ch4_pwr_en;				/* 0x178 */
-	u32 rd_ch5_pwr_en;				/* 0x18c */
-	u32 rd_ch6_pwr_en;				/* 0x180 */
-	u32 rd_ch7_pwr_en;				/* 0x184 */
-	u32 padding_5[30];				/* [0x188..0x1fc] */
-	struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	/* [0x200..0x1120] */
+	u32 padding_3[2];				/* 0x0120..0x0124 */
+	u32 wr_ch0_pwr_en;				/* 0x0128 */
+	u32 wr_ch1_pwr_en;				/* 0x012c */
+	u32 wr_ch2_pwr_en;				/* 0x0130 */
+	u32 wr_ch3_pwr_en;				/* 0x0134 */
+	u32 wr_ch4_pwr_en;				/* 0x0138 */
+	u32 wr_ch5_pwr_en;				/* 0x013c */
+	u32 wr_ch6_pwr_en;				/* 0x0140 */
+	u32 wr_ch7_pwr_en;				/* 0x0144 */
+	u32 padding_4[8];				/* 0x0148..0x0164 */
+	u32 rd_ch0_pwr_en;				/* 0x0168 */
+	u32 rd_ch1_pwr_en;				/* 0x016c */
+	u32 rd_ch2_pwr_en;				/* 0x0170 */
+	u32 rd_ch3_pwr_en;				/* 0x0174 */
+	u32 rd_ch4_pwr_en;				/* 0x0178 */
+	u32 rd_ch5_pwr_en;				/* 0x018c */
+	u32 rd_ch6_pwr_en;				/* 0x0180 */
+	u32 rd_ch7_pwr_en;				/* 0x0184 */
+	u32 padding_5[30];				/* 0x0188..0x01fc */
+	struct dw_edma_v0_ch ch[EDMA_V0_MAX_NR_CH];	/* 0x0200..0x1120 */
 } __packed;
 
 struct dw_edma_v0_legacy {
-	u32 viewport_sel;				/* 0x0f8 */
-	struct dw_edma_v0_ch_regs ch;			/* [0x100..0x120] */
+	u32 viewport_sel;				/* 0x00f8 */
+	struct dw_edma_v0_ch_regs ch;			/* 0x0100..0x0120 */
 } __packed;
 
 struct dw_edma_v0_regs {
 	/* eDMA global registers */
-	u32 ctrl_data_arb_prior;			/* 0x000 */
-	u32 padding_1;					/* 0x004 */
-	u32 ctrl;					/* 0x008 */
-	u32 wr_engine_en;				/* 0x00c */
-	u32 wr_doorbell;				/* 0x010 */
-	u32 padding_2;					/* 0x014 */
+	u32 ctrl_data_arb_prior;			/* 0x0000 */
+	u32 padding_1;					/* 0x0004 */
+	u32 ctrl;					/* 0x0008 */
+	u32 wr_engine_en;				/* 0x000c */
+	u32 wr_doorbell;				/* 0x0010 */
+	u32 padding_2;					/* 0x0014 */
 	union {
-		u64 reg;				/* 0x018..0x01c */
+		u64 reg;				/* 0x0018..0x001c */
 		struct {
-			u32 lsb;			/* 0x018 */
-			u32 msb;			/* 0x01c */
+			u32 lsb;			/* 0x0018 */
+			u32 msb;			/* 0x001c */
 		};
 	} wr_ch_arb_weight;
-	u32 padding_3[3];				/* [0x020..0x028] */
-	u32 rd_engine_en;				/* 0x02c */
-	u32 rd_doorbell;				/* 0x030 */
-	u32 padding_4;					/* 0x034 */
+	u32 padding_3[3];				/* 0x0020..0x0028 */
+	u32 rd_engine_en;				/* 0x002c */
+	u32 rd_doorbell;				/* 0x0030 */
+	u32 padding_4;					/* 0x0034 */
 	union {
-		u64 reg;				/* 0x038..0x03c */
+		u64 reg;				/* 0x0038..0x003c */
 		struct {
-			u32 lsb;			/* 0x038 */
-			u32 msb;			/* 0x03c */
+			u32 lsb;			/* 0x0038 */
+			u32 msb;			/* 0x003c */
 		};
 	} rd_ch_arb_weight;
-	u32 padding_5[3];				/* [0x040..0x048] */
+	u32 padding_5[3];				/* 0x0040..0x0048 */
 	/* eDMA interrupts registers */
-	u32 wr_int_status;				/* 0x04c */
-	u32 padding_6;					/* 0x050 */
-	u32 wr_int_mask;				/* 0x054 */
-	u32 wr_int_clear;				/* 0x058 */
-	u32 wr_err_status;				/* 0x05c */
+	u32 wr_int_status;				/* 0x004c */
+	u32 padding_6;					/* 0x0050 */
+	u32 wr_int_mask;				/* 0x0054 */
+	u32 wr_int_clear;				/* 0x0058 */
+	u32 wr_err_status;				/* 0x005c */
 	union {
-		u64 reg;				/* 0x060..0x064 */
+		u64 reg;				/* 0x0060..0x0064 */
 		struct {
-			u32 lsb;			/* 0x060 */
-			u32 msb;			/* 0x064 */
+			u32 lsb;			/* 0x0060 */
+			u32 msb;			/* 0x0064 */
 		};
 	} wr_done_imwr;
 	union {
-		u64 reg;				/* 0x068..0x06c */
+		u64 reg;				/* 0x0068..0x006c */
 		struct {
-			u32 lsb;			/* 0x068 */
-			u32 msb;			/* 0x06c */
+			u32 lsb;			/* 0x0068 */
+			u32 msb;			/* 0x006c */
 		};
 	} wr_abort_imwr;
-	u32 wr_ch01_imwr_data;				/* 0x070 */
-	u32 wr_ch23_imwr_data;				/* 0x074 */
-	u32 wr_ch45_imwr_data;				/* 0x078 */
-	u32 wr_ch67_imwr_data;				/* 0x07c */
-	u32 padding_7[4];				/* [0x080..0x08c] */
-	u32 wr_linked_list_err_en;			/* 0x090 */
-	u32 padding_8[3];				/* [0x094..0x09c] */
-	u32 rd_int_status;				/* 0x0a0 */
-	u32 padding_9;					/* 0x0a4 */
-	u32 rd_int_mask;				/* 0x0a8 */
-	u32 rd_int_clear;				/* 0x0ac */
-	u32 padding_10;					/* 0x0b0 */
+	u32 wr_ch01_imwr_data;				/* 0x0070 */
+	u32 wr_ch23_imwr_data;				/* 0x0074 */
+	u32 wr_ch45_imwr_data;				/* 0x0078 */
+	u32 wr_ch67_imwr_data;				/* 0x007c */
+	u32 padding_7[4];				/* 0x0080..0x008c */
+	u32 wr_linked_list_err_en;			/* 0x0090 */
+	u32 padding_8[3];				/* 0x0094..0x009c */
+	u32 rd_int_status;				/* 0x00a0 */
+	u32 padding_9;					/* 0x00a4 */
+	u32 rd_int_mask;				/* 0x00a8 */
+	u32 rd_int_clear;				/* 0x00ac */
+	u32 padding_10;					/* 0x00b0 */
 	union {
-		u64 reg;				/* 0x0b4..0x0b8 */
+		u64 reg;				/* 0x00b4..0x00b8 */
 		struct {
-			u32 lsb;			/* 0x0b4 */
-			u32 msb;			/* 0x0b8 */
+			u32 lsb;			/* 0x00b4 */
+			u32 msb;			/* 0x00b8 */
 		};
 	} rd_err_status;
-	u32 padding_11[2];				/* [0x0bc..0x0c0] */
-	u32 rd_linked_list_err_en;			/* 0x0c4 */
-	u32 padding_12;					/* 0x0c8 */
+	u32 padding_11[2];				/* 0x00bc..0x00c0 */
+	u32 rd_linked_list_err_en;			/* 0x00c4 */
+	u32 padding_12;					/* 0x00c8 */
 	union {
-		u64 reg;				/* 0x0cc..0x0d0 */
+		u64 reg;				/* 0x00cc..0x00d0 */
 		struct {
-			u32 lsb;			/* 0x0cc */
-			u32 msb;			/* 0x0d0 */
+			u32 lsb;			/* 0x00cc */
+			u32 msb;			/* 0x00d0 */
 		};
 	} rd_done_imwr;
 	union {
-		u64 reg;				/* 0x0d4..0x0d8 */
+		u64 reg;				/* 0x00d4..0x00d8 */
 		struct {
-			u32 lsb;			/* 0x0d4 */
-			u32 msb;			/* 0x0d8 */
+			u32 lsb;			/* 0x00d4 */
+			u32 msb;			/* 0x00d8 */
 		};
 	} rd_abort_imwr;
-	u32 rd_ch01_imwr_data;				/* 0x0dc */
-	u32 rd_ch23_imwr_data;				/* 0x0e0 */
-	u32 rd_ch45_imwr_data;				/* 0x0e4 */
-	u32 rd_ch67_imwr_data;				/* 0x0e8 */
-	u32 padding_13[4];				/* [0x0ec..0x0f8] */
+	u32 rd_ch01_imwr_data;				/* 0x00dc */
+	u32 rd_ch23_imwr_data;				/* 0x00e0 */
+	u32 rd_ch45_imwr_data;				/* 0x00e4 */
+	u32 rd_ch67_imwr_data;				/* 0x00e8 */
+	u32 padding_13[4];				/* 0x00ec..0x00f8 */
 	/* eDMA channel context grouping */
 	union dw_edma_v0_type {
-		struct dw_edma_v0_legacy legacy;	/* [0x0f8..0x120] */
-		struct dw_edma_v0_unroll unroll;	/* [0x0f8..0x1120] */
+		struct dw_edma_v0_legacy legacy;	/* 0x00f8..0x0120 */
+		struct dw_edma_v0_unroll unroll;	/* 0x00f8..0x1120 */
 	} type;
 } __packed;
 
-- 
2.7.4

