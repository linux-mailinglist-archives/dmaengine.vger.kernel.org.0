Return-Path: <dmaengine+bounces-2212-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4C38D4651
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 09:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07D4B1F21CDC
	for <lists+dmaengine@lfdr.de>; Thu, 30 May 2024 07:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31B4176ABC;
	Thu, 30 May 2024 07:45:29 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2110.outbound.protection.partner.outlook.cn [139.219.146.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61908C2E9;
	Thu, 30 May 2024 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055129; cv=fail; b=Tj9qIiIN0LFwyA6taB0QG7lHSv+aLIOR7cLBLUALyBGKvqqTkhYjhvhCSaCOP8dK376juoNuorw/6M8edwbwKeSj0Bu5oLo9BD9JbUansYY5bpiraMK5nHrxJVIHUGokGy5m2qzZBs3d/BmGswtP10G9aGMX+bEfZTGmUyyKHco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055129; c=relaxed/simple;
	bh=5ZXG4d8/9BsBkqkELCWTjOlvcrcuY/2dOM8Yvnm/xn4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q4FWBG6gUSpm1ccDllTb4Woxsa0MEWbHC1TMXTLzguOwfY9NM5ZOeCmCrTwx7qIGToHrLXCda+Z8tRP8tX9F0nT6z0Hn9Va3QMZjhGKSJQjWQjN/aJWXNoEtOfeHeV1BH8ypdsHDtefNdvsWjdpxZXjU41IajF4pQeO7Ap/PDao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j73gtZD89HstbEeHXLvKbw36zHLAlp8YMSksoGW7mllXfL3kv/fysfl8EXLhxVnMdtnvyJHm8tD9NFZ/hgWj3iPLyW67mMLMyPE70uLCE9Yup6EQJp0c1vxAiXEMdSiTuAfYsNvKosT3MAQyMhNRCWbZUOFPeHhRI9cE/ACZmMv6cjFEGNhI7WhEHIFY78/r60C53wqyY0HVD/zgP1uPmeSXIam/j925M8muwS+5/fc3UeqkO3ZD99ewV332vPyzx410BJeFuUsufD5+AxmiI2LcBbMKWBlJwUn1x787FV4hB1P+u3gl1Li/4Qcea6kXcYj+RLuxq7V952JWU7W2hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LdsRqePpXLkY7j9IOxnswrsRGbzGB7Ma6sDy5vmhn8=;
 b=k1JjDxcM6ZKQVi0OoRyNNTHNbEGGb3lhohM4qCEQNXXB1WQT39n6j3hH3Og1tCt9SGtpFNCgfEX3WExPdh/mhHlbFvoTLua3PSFoqNOHkAq2QUmasn8fbCxjBgo6m746QPxAnwv5zPcs/3koBU/8N6Nu6KYE8aLqf9K2vcaiyyRNiDe/Q58yjmbPimTODtebgTGcRKBzK85pm4L+dsk2H4i/zcr1MsOZffWsi8EspRXRZem0AjbQ51PPaEOTF3Bht5MrMr/jfvAK9KdVJaXO5xtUZSTlloiKJzgUYYu1E6WXTCtjVtpLkBcDh/nGBZt7NnTmOguVXwAOKya+A6tOCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10) by NT0PR01MB1054.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:2::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Thu, 30 May
 2024 03:11:26 +0000
Received: from NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce]) by NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 ([fe80::e3b:43f8:2e6d:ecce%7]) with mapi id 15.20.7587.037; Thu, 30 May 2024
 03:11:26 +0000
From: Jia Jie Ho <jiajie.ho@starfivetech.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: [PATCH v5 1/3] dmaengine: dw-axi-dmac: Support hardware quirks
Date: Thu, 30 May 2024 11:11:10 +0800
Message-ID: <20240530031112.4952-2-jiajie.ho@starfivetech.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240530031112.4952-1-jiajie.ho@starfivetech.com>
References: <20240530031112.4952-1-jiajie.ho@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0027.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::17) To NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:10::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: NT0PR01MB1182:EE_|NT0PR01MB1054:EE_
X-MS-Office365-Filtering-Correlation-Id: 76fc530e-90a2-4067-6083-08dc80563131
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|41320700004|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	PKLjfg5kY63EVoSvCdSO3f1aw0VOszBM+FuwyqG3KG3/kDGZAs/VjaJ+cgtuacBq/0Pji4yKkEy2iZNzrPEVSlhpLMlk7RqFcH+wdV8R9q84q70Sqb6RsmLEWVM2XsPsBlWl3tj4Siakq2bbj96SsOLVpYyBSv8jNfpbEO7RsuUgqhWQ4BLdV84eERXT3dc+uNgK4Mrky6GJl4BeQWeK5cfzlTYhXrsCS+DNXNaVoIes6pkI0iKikxAVIHePlOS9F42tMjzXjCPnqMH3dyWS5wODE1qbaeCHcyY1Jw9OzhHL167NqWoTLxjt+e3K/De9ILWSgYbeUweOqfCEfOyQ0uaXkJAZxY3EJtP2FmiyzK0SP4PAUizlB02Vj0GL+gz6rgX64MIjfO5s233mGrjN0eAzxU1vH/FqOJEhHPiWik3Ijs9lYDR9p5ohuZmYmZ7dLnpMigWzjWK7KfMttRBHRt16r3vYgSYgywD9oFljEgVFtVe+Th5SXJfRcFTF3CFLT8ay8kVHYLAFS3j8PpXgoaYIS1IduLVw8jmAXh1LXHILo4qzrx6Wp96XwR/2gXCISeTu6RqhJcUxD8Mxlv2v4kfBpLZPw7pZsLUfboYxiELNxkStly1W93JO85iFehaK
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z4rVO9ZasdO4HMPYFkxhVCime2dM790OJBBAo0TsUho8RY3gIiCcwT5J5xuJ?=
 =?us-ascii?Q?rQqaDG7l73PuWedn2oZ6W08GWez+mN+gi7V5KcYrO8sK6SUVPGMUpUrQYeNq?=
 =?us-ascii?Q?rdIZEKPxEtHBtdlws1svCoitg/J+MrwPqg9rB1ZN+PZaumFJ1hQ/rwK6xPuN?=
 =?us-ascii?Q?2KHUCpuSxpB0k4dpTJNGh+6ri+UfD874p1yiksqe9bRNgwZMOPkwJ+WmSigH?=
 =?us-ascii?Q?UzKdrIAfoS89ytXflfBNr/1EE8HZVpD6veFPQIvfzcjBH3W9qTZ/vAl/7Pty?=
 =?us-ascii?Q?DtUUo7wp0/o8vz/iCh+7P+BRRok5MLT+VCl6dYAMt0rs8IYaDF8e+8MIuvdv?=
 =?us-ascii?Q?DsOyOZ4fvY5HJPN3DYISebry/XzMtzHkEHiOagwvjA0XS9apcARBPJVVf5eE?=
 =?us-ascii?Q?06DqKWKdImo9zXxqyzbdQMXtdhLIdV+VfnDNyYCWI7FcD73PR2gId7k6n25l?=
 =?us-ascii?Q?9J8pQBD+zAE/nKamt/XtccTbm2mW4IEp3LwEvtlBW0ZoDzeVBBHMeAyvgmWG?=
 =?us-ascii?Q?fHT7jF6TmUtpbgWrb1agD7A2ewtqXSenXx3C1WbIkSrnwlLuN0or0gSxmxLS?=
 =?us-ascii?Q?MMwaFLwh6T8rxXrgib6gPmKP3blc/To5Hj6jcNJpr5w0BIkK6jwIfxagjUpq?=
 =?us-ascii?Q?q7JO3K32Heu2pT/7/xSPKho53USeTjbg4T4FFuT/UqG/FqpdAAgyOazn0S+R?=
 =?us-ascii?Q?hruXH+c9ZXCWitN4un99ssWi6lw/6e9wI6J/UtLZ2KGV69cuSsi+3EaF6Gwj?=
 =?us-ascii?Q?Gei3RnDqjb+Dp0oYYmljYvYwNoNtBM03wONI8CI3mp2KLs1F/uIBdSuRlw9W?=
 =?us-ascii?Q?wz2QZOZXdO+M8BTaY7qFaEcNTq93VeOQ5BIWr68ugGfcSThYOhKaqYzTRCTX?=
 =?us-ascii?Q?4f0+Uz9ja0WpfLi7x8AhK1nH1/0QzJJCGAfdhwU7HA26yKZl2lxQnYJc6WMb?=
 =?us-ascii?Q?+CATnFNH+9PBT2pZlsMiHxY9UCDPoLMM4SaKSxo9qlevJr2JVWPrD+35EQaX?=
 =?us-ascii?Q?blup48DErAo92FZsgaOnZnXwEiZdm7M7fS45UqPYng/n8K8fmz7rCs+IIWEo?=
 =?us-ascii?Q?JznxxqpvCShQzfe/C+EB5kYps3UJi1+ztDdXzH5kv0iVHlpVViz4RDatzvLR?=
 =?us-ascii?Q?pVQEqhw96DMRTpJHd/DoeAaMxejXT+Te87NqwD7ZRvIkVIOIQ3hz9AJEozQx?=
 =?us-ascii?Q?DYG1X3D6lCSM8LSinP7y0NmGWVhZ8qzJtBysQhmOOaBJorhNC9ROu4Xfq0Db?=
 =?us-ascii?Q?Fc4OfbqTiyUSah1VK9c4GwaKa6m/T628oubwk0DOaHmOqfADdXLyji1G3DhY?=
 =?us-ascii?Q?PuKmBZv7e0VChN2hCQvAnFy4iszq6HIMvFVmqmX531GObS282xtm0nKAXLJ2?=
 =?us-ascii?Q?4S8EdN5lX9nBtxeqlyG/HJOAX3qqKS8dCAKuewomK7ytC6w8C15f07EPSzGr?=
 =?us-ascii?Q?YMb5GlTr5wP/m5uRW3MdT1SyT4XZwtEpsgM3bK4ISQQFLgIFBik4mBVODf+h?=
 =?us-ascii?Q?Dv7U1HX1fv/yBcjFQkHTFFvLQ01yFA5GBamDNsmPpk0oAwyvD26qyXKAy2nH?=
 =?us-ascii?Q?Ig+aq1oVlyc+Tw+rpafnwIbGRBUQLNGC216J+Jwy2aYD8rsR9O4xEnl4UK8E?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76fc530e-90a2-4067-6083-08dc80563131
X-MS-Exchange-CrossTenant-AuthSource: NT0PR01MB1182.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 03:11:26.2786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A38h/i4rk5PpYclyLRCSHU8pHJimFgVd3tQ8kpYIGJI0HH8aCyQBhUJmV0WfOkXBlVZdtsd7o4h4UIbUf3oPVK+B4knRJ4s/HsBvAQpGCcw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NT0PR01MB1054

Adds separate dma hardware descriptor setup for JH8100 hardware quirks.
JH8100 engine uses AXI1 master for data transfer but current dma driver
is hardcoded to use AXI0 only. The FIFO offset needs to be incremented due
to hardware limitations.

Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
---
 .../dma/dw-axi-dmac/dw-axi-dmac-platform.c    | 32 ++++++++++++++++---
 drivers/dma/dw-axi-dmac/dw-axi-dmac.h         |  2 ++
 include/linux/dma/dw_axi.h                    | 11 +++++++
 3 files changed, 40 insertions(+), 5 deletions(-)
 create mode 100644 include/linux/dma/dw_axi.h

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index 18ce7d64958b..1a8f2e140848 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -648,6 +648,7 @@ static void set_desc_dest_master(struct axi_dma_hw_desc *hw_desc,
 
 static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 				  struct axi_dma_hw_desc *hw_desc,
+				  struct axi_dma_desc *desc,
 				  dma_addr_t mem_addr, size_t len)
 {
 	unsigned int data_width = BIT(chan->chip->dw->hdata->m_data_width);
@@ -656,6 +657,8 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 	dma_addr_t device_addr;
 	size_t axi_block_ts;
 	size_t block_ts;
+	bool hw_quirks = chan->quirks & DWAXIDMAC_STARFIVE_SM_ALGO;
+	u32 val;
 	u32 ctllo, ctlhi;
 	u32 burst_len, src_burst_trans_len, dst_burst_trans_len;
 
@@ -676,7 +679,8 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 		device_addr = chan->config.dst_addr;
 		ctllo = reg_width << CH_CTL_L_DST_WIDTH_POS |
 			mem_width << CH_CTL_L_SRC_WIDTH_POS |
-			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_DST_INC_POS |
+			(hw_quirks ? DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS :
+				     DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_DST_INC_POS) |
 			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS;
 		block_ts = len >> mem_width;
 		break;
@@ -686,7 +690,8 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 		ctllo = reg_width << CH_CTL_L_SRC_WIDTH_POS |
 			mem_width << CH_CTL_L_DST_WIDTH_POS |
 			DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_DST_INC_POS |
-			DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_SRC_INC_POS;
+			(hw_quirks ? DWAXIDMAC_CH_CTL_L_INC << CH_CTL_L_SRC_INC_POS :
+				     DWAXIDMAC_CH_CTL_L_NOINC << CH_CTL_L_SRC_INC_POS);
 		block_ts = len >> reg_width;
 		break;
 	default:
@@ -739,6 +744,17 @@ static int dw_axi_dma_set_hw_desc(struct axi_dma_chan *chan,
 
 	set_desc_src_master(hw_desc);
 
+	if (hw_quirks) {
+		if (chan->direction == DMA_MEM_TO_DEV) {
+			set_desc_dest_master(hw_desc, desc);
+		} else {
+			/* Select AXI1 for src master */
+			val = le32_to_cpu(hw_desc->lli->ctl_lo);
+			val |= CH_CTL_L_SRC_MAST;
+			hw_desc->lli->ctl_lo = cpu_to_le32(val);
+		}
+	}
+
 	hw_desc->len = len;
 	return 0;
 }
@@ -815,8 +831,8 @@ dw_axi_dma_chan_prep_cyclic(struct dma_chan *dchan, dma_addr_t dma_addr,
 	for (i = 0; i < total_segments; i++) {
 		hw_desc = &desc->hw_desc[i];
 
-		status = dw_axi_dma_set_hw_desc(chan, hw_desc, src_addr,
-						segment_len);
+		status = dw_axi_dma_set_hw_desc(chan, hw_desc, NULL,
+						src_addr, segment_len);
 		if (status < 0)
 			goto err_desc_get;
 
@@ -898,7 +914,8 @@ dw_axi_dma_chan_prep_slave_sg(struct dma_chan *dchan, struct scatterlist *sgl,
 
 		do {
 			hw_desc = &desc->hw_desc[loop++];
-			status = dw_axi_dma_set_hw_desc(chan, hw_desc, mem, segment_len);
+			status = dw_axi_dma_set_hw_desc(chan, hw_desc, desc,
+							mem, segment_len);
 			if (status < 0)
 				goto err_desc_get;
 
@@ -1036,8 +1053,13 @@ static int dw_axi_dma_chan_slave_config(struct dma_chan *dchan,
 					struct dma_slave_config *config)
 {
 	struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
+	struct dw_axi_peripheral_config *periph = config->peripheral_config;
 
 	memcpy(&chan->config, config, sizeof(*config));
+	if (config->peripheral_size == sizeof(*periph))
+		chan->quirks = periph->quirks;
+	else
+		chan->quirks = 0;
 
 	return 0;
 }
diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
index d76d3d88ceb6..6a68c40c1bf3 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
@@ -14,6 +14,7 @@
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/dmaengine.h>
+#include <linux/dma/dw_axi.h>
 #include <linux/types.h>
 
 #include "../virt-dma.h"
@@ -50,6 +51,7 @@ struct axi_dma_chan {
 	struct dma_slave_config		config;
 	enum dma_transfer_direction	direction;
 	bool				cyclic;
+	u32				quirks;
 	/* these other elements are all protected by vc.lock */
 	bool				is_paused;
 };
diff --git a/include/linux/dma/dw_axi.h b/include/linux/dma/dw_axi.h
new file mode 100644
index 000000000000..fd49152869a4
--- /dev/null
+++ b/include/linux/dma/dw_axi.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __LINUX_DMA_DW_AXI_H
+#define __LINUX_DMA_DW_AXI_H
+
+#include <linux/types.h>
+
+struct dw_axi_peripheral_config {
+#define DWAXIDMAC_STARFIVE_SM_ALGO	BIT(0)
+	u32 quirks;
+};
+#endif /* __LINUX_DMA_DW_AXI_H */
-- 
2.43.0


