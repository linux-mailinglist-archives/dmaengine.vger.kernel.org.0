Return-Path: <dmaengine+bounces-3179-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4DC97B719
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 05:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D661AB25FB9
	for <lists+dmaengine@lfdr.de>; Wed, 18 Sep 2024 03:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F20E9443;
	Wed, 18 Sep 2024 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="nXRRq5hv"
X-Original-To: dmaengine@vger.kernel.org
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2074.outbound.protection.outlook.com [40.107.255.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192C3282E5;
	Wed, 18 Sep 2024 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726630898; cv=fail; b=tXVpADDT6EpmG1QhsmDVF6TpfxELxRg0YnbpZ2FuMiWUs5xl001pV9OUjIpeRyC0JuWl/cJkPwTvuXscuqmu6tSEU3lC1KlnRbZ/p6P9CETWyKjpMhFjlEJBTXoOR/NTzrhd7Hrptb19fuWJYWxQ9Jhh5u/mR27sbjbSjPD0mdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726630898; c=relaxed/simple;
	bh=Qs/LYZq98vvdeL3usPMjrqNz3fQNro9Wd2WUBN4y/w4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HYp79B3yKdsOUR5tZmNdpkS0F7YnoZ/nkwXQFEmhOgnUAjz5YnTa9ErOSzI5c+ISH6HPm2vcf0qY85lt3zha+c8eFXxfAs4qFWtOMEKyBIu9L5Xj+Y8jds0zKZFUNGS3wQM7w1jJDQ8WptioRvo/KIBAMh9sO6MeZ7waHWc2cog=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=nXRRq5hv; arc=fail smtp.client-ip=40.107.255.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T6K/8GuyNzrBDsrnp0hQ61jP/vRPvXnVRL71xPggvcTlZ7mERQXFYGH456qMC8lxF7MYM0ckAlSmW2wMmbqO5e6AyJJ28O89Jc6QZ1PSVvNnyUvWZA0ON6oO6CjZHP+pGCga3ztbyHwob3fglmZamY0UKQ6R5ewfb2/oHcFVoqoqOvx5QxSWAA+TQGWWtCNOz7wVVdNZVG1l0JNSs5DYgqG5iYUdChueBptlv4sb1aC5r4ZbcJjnkY9Hli+SgoL35+c6QChgrJqEYQ/EFtKMvUUHEROXzgJzyjRNq8elkd8oL/iEF73T7SgQlVfoG3Da2kyaUMOGzhSTEYFeRVZ6eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tM2gMM+qt4307g9PFKqo1MlKnvJYAMTrzTKL/COV++g=;
 b=ZkNqmpjSfF7GF7CLtL2PHyPQZ2tmpmXkjU2CSCpdh6yqmJkV3lNaHNte7SoCxpuuuUB5HrH6ahf2ZcVuDQctyeMSnuRfCIU1Qjc8E7K50l1dWx76FiEAucAGUBhPth+Ko4RCrbQkYHLLiTicefflQKBH77TSxvSRfAmXuj7nUbnPGUDh+h1Lgtrr7KRYWyJJfbBjROhwgO667j/6TPny5QRD3U6fg8fwe4y7y+Q8TFqhfBILh6wpS2wPJiOMwKmXIu3p+l5sh3bPbeuu2MRFr7L96RyqzTT2U62BbcSANE17rUXEA8VVkFFmjfV2s/kI1ehmgyxo03YpAzQZLHlbGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tM2gMM+qt4307g9PFKqo1MlKnvJYAMTrzTKL/COV++g=;
 b=nXRRq5hv+s74iWalu2GKa+/nBt8OTEX1UNpNo2fpu+cospk1ydRP8rZu5QHTN0A8jllT9jyXq8E7zboJnxlY8+MUMPc0LGd2Io9xRZPJN56Myxe7DJI7mfNn9H35+rvEwatxcn1IknR/Xfu7ReTXnmJYPt4p+L7ziWxrbWENNn0TV6eD01j16ViUrUA8FawcsG1R51bFwY2ZvIZ6Bn/5H7F6X4rjiDdpJOCy9LrRRUIAUtcFavjXeWatNFgysajiJ3aqOJxmpGC4JmkUZN7frHsW20KPywv4AyeqLJrMmN5/YhOoyFuX4Xabour5rxEc4b/2YrPaooKNkVngVYrzyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com (2603:1096:820:31::7)
 by KL1PR06MB6556.apcprd06.prod.outlook.com (2603:1096:820:f1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 03:41:31 +0000
Received: from KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1]) by KL1PR0601MB4113.apcprd06.prod.outlook.com
 ([fe80::7e85:dad0:3f7:78a1%4]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 03:41:30 +0000
From: Yan Zhen <yanzhen@vivo.com>
To: vkoul@kernel.org,
	paul.walmsley@sifive.com,
	samuel.holland@sifive.com,
	michal.simek@amd.com
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	opensource.kernel@vivo.com,
	Yan Zhen <yanzhen@vivo.com>
Subject: [PATCH v1] dma: fix typo in the comment
Date: Wed, 18 Sep 2024 11:41:14 +0800
Message-Id: <20240918034114.860132-1-yanzhen@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0013.apcprd06.prod.outlook.com
 (2603:1096:4:186::18) To KL1PR0601MB4113.apcprd06.prod.outlook.com
 (2603:1096:820:31::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB4113:EE_|KL1PR06MB6556:EE_
X-MS-Office365-Filtering-Correlation-Id: fc3e070e-14f5-436e-5942-08dcd793c873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BcNEwugvib1LowLzpV7hslX2zKH16g65G31SIHKyJY8WnWf5L/YuR9Bxecg0?=
 =?us-ascii?Q?qhTPTVSPPl/zEdpNppgMJiG2xWvJyea4aBWc7/KPdscvpOCyepnkhbcAqD0p?=
 =?us-ascii?Q?Te3UuILqK6AFt7x8KaYha+f0IS+qBXlRqGGKGsInWFCzKs1d7n4veKe470Za?=
 =?us-ascii?Q?uk00PxEgbSNkwnYUGn9RugKcXZ5YGMrSNe8W9/AGd0QQU4Xg4kORFTT0eF/U?=
 =?us-ascii?Q?35SUO6tBUBWXq62lrFdjNAJszkfXgXAT1xx3wnbnEH5Oyg9cy7BoUdG9xHeJ?=
 =?us-ascii?Q?Ev/QNL/kCp4ziAhCwcI5G0PQhHFBU/stSn8iGBT33tIIibYBbF68pQMUNmdJ?=
 =?us-ascii?Q?JtyZEth+zCyisii7m8jeWYOL4TlGQ/Qv8AxT9J71drhmADzlpQFkKL3Z+OVN?=
 =?us-ascii?Q?5Vyl87r4U4YpGol7e5TOeYj0UEwkjhYHJ0pI+8UYmeFJ6pvUYxVzQR0+/QCR?=
 =?us-ascii?Q?wC0bc5BCmBrZdeF3CTK9t4y8kQ+ucdBILJVKW/3VwW6UCPNlx1Ofs2ldOBlg?=
 =?us-ascii?Q?iWuXT+FiDsuHLhJMZyun2yMeW2zVH4O7L2+mgPBjfVvduI1FE2Vk7xnNuue2?=
 =?us-ascii?Q?qEDjj5ntkPu2T5yUkGzdyRJAHzR25NAXfjE5nqTuO4MxDkQtayqNG+bwJiPi?=
 =?us-ascii?Q?wWp3kYyYoV2rHYsDGCFc07hqjPIginmh1MIdyAwI1vFw67sIHdQV/RC9FIaW?=
 =?us-ascii?Q?HX/i9kPbFx8QIT7131IEsY6ZfZ2tm2paOUTpwQigmfye/TKLil4Apm5E0H3p?=
 =?us-ascii?Q?1tRatUM32XNhIrHXmSKOv8uvN2rhVra0qEU7n63ra9N/7dtPMlJmQgabUgyf?=
 =?us-ascii?Q?xfqDyv7VZVaA/c1KWn1tKUCbqRTuBFzqVbefl5ogkP1Deu8Tfku6eAdm4BO/?=
 =?us-ascii?Q?ItCw1wwcjKe52Nhy+OTeKNnd/qSDFxsTDInFeACl5+8J8plBS/Nx0lBbvJ+s?=
 =?us-ascii?Q?UFprdKbMABK5OYtuY8MCEB1QjnpojxGtwzH8f9A3bCuW1XOGl6buTemi7fEv?=
 =?us-ascii?Q?vkQn3FpIoTUMu+1/4h/+dh0gD1ue22f8UikGbcrAVP0+wPWSS2Lf20KNHGak?=
 =?us-ascii?Q?MfhEBAc8NSmq/pwJSb/XwZPVj8xHwFkcxmR+We6EzWFKxXZXhaQfQLwB+h4I?=
 =?us-ascii?Q?d3cKbbIzCeypyH/GIOy+4jeRBBun32b6oTPz+6J6fO0qzt27Hv96RFmAQqEp?=
 =?us-ascii?Q?5VQ6jCTAOCWJ/+GWaDRJOmcz5oihq03m0tf+2UBmPWmUcPCzkixw+BaLtTtf?=
 =?us-ascii?Q?qNcEEYc79gk598k1SveOu2dra16CPGRhcz0ys0HQIOmn6VomLMy0fInAh116?=
 =?us-ascii?Q?+x2YTnq5ZBdoHQVzjTEwYesC82muxImR1/NqXiEHeSLXDT3TvjiY6PuSUpHG?=
 =?us-ascii?Q?vql8+HWBxE6teAulC+5HEeNeqRfh95dqSNwPpKIoKsxtQFmlyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4113.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?44zBTEkUp6G8cUoVMzFGhDdl1bnmS9CubUISFJFb7QK+HNBffYO2RTTlcxuK?=
 =?us-ascii?Q?gWpVLJVHVjmiUNWsIDTltp8cOP5dYfQkEqawWD5BLT+xEmpd8LFFLb59j4/i?=
 =?us-ascii?Q?KXsmqIbVjCCwLmfXs1YtFTz5LYE0gKPIvKToH7106j4tvWqN788gaArgrbWh?=
 =?us-ascii?Q?SX5D6jZw9gdaJztv34Dx96qydAWpMvjyb9e65uV5TGT/kUOYzRlcUKRP7f4D?=
 =?us-ascii?Q?6xoQqdmAghgvFodrJf947FJFFaJUgo5KpgHLwYDilA59y5qChZC9snnybSH1?=
 =?us-ascii?Q?a+zRAtpucLabSrakslvWuvRLnO2yMCzbEJmVFYfC1jLxVhJ3OL3wSOu1rgV5?=
 =?us-ascii?Q?pfLbT97u7ci/+epBG0xhi2iE7vTXjJ+J+kgfsI+hMJRGQxqAfDgn4UH5IEYS?=
 =?us-ascii?Q?55GPk8NJWglzafLTF2XzXdUX8FVUvjTpa+AY56gJtMEJf2aennTLFvO34Rj1?=
 =?us-ascii?Q?PPVSTu4nPfRLsAkCJxI9KjnWiT8mKOMbvx5QE9lYtxkdWD4gcz2IbJtNY212?=
 =?us-ascii?Q?SOYeFhIe6iJyd4HrYG+iiDdtsLlB//BrC1Ja5LosExnArfEvZYEQ+zGOdw3I?=
 =?us-ascii?Q?HgtOKrZ+Z5j1emk9frWJAmWpNSgb9AG1VUeymTrkbzU4VpwGl33YJ/esWW1d?=
 =?us-ascii?Q?PiNk/z/ZMr4hLuauIvk1DZDTy3H4lvgx7dm4hDar+kXr7zjZ7cPbFm1n7++r?=
 =?us-ascii?Q?9EwJp03WeoLpTJYfnfkAjxwus9qNEx+oeggAhtVif940oMA2S81KKoo05DK+?=
 =?us-ascii?Q?FhHJv7MZ52NoLXactbO5H2UmcRz6lmzV1VF25letBYjex0DdxRAXErsl66uA?=
 =?us-ascii?Q?0uDlB32kmYr8awLEBlUdoGwx/twxhUW9ulBMwzYTCvZCn7tPA0yp65gaSWRu?=
 =?us-ascii?Q?tIDCJsm7g56quvTCf5kO1S4Zi732urPk7loPlqZk84g+fcChw100eXWMdA8/?=
 =?us-ascii?Q?oCRFaFZCKeIa4hEMuvywyAkkHiu6oUHcRjkZ4kg1M23r5GFOa4RF5U/ArYaM?=
 =?us-ascii?Q?dpalGwa1qsvOJC0ZH8aOk1Q8EwDtc75ed0XDMYps766NCJR5Y1wFzoNrZEVa?=
 =?us-ascii?Q?kLx4/vEgp2T4zI53DqR5JLGFQZdwySEy+yata0L01WF5o5D4uMZhr7kD7mvY?=
 =?us-ascii?Q?uKu2GO7g3BRgbzj9MD1X73kYoPw6xi9LylNRtLPzjFMDNiq7tRNhaCOznyWA?=
 =?us-ascii?Q?0xxgKP54OQca30aLQw2kWQQq5cZZbw/Jq5RUIqFoS9hwOWr/rCeTpUWLaskt?=
 =?us-ascii?Q?jDuaFaKFcxjTUBp+3sNHBZyx4hte+1q8pTkJaVkBZkfyTHuPqOlQQHIWKpSh?=
 =?us-ascii?Q?dXA/S9dHORYlssyH4R7Pk/ZSl1K+6D6/7iVcHsn2PwS0uh9SZAOI1gTuecwJ?=
 =?us-ascii?Q?W8V0KI/QUQXkcZXRvHCZSYW1USdwuIQ+sMgYlCggwO+aaPCkaXTE/DoiDIFi?=
 =?us-ascii?Q?5nRRV3Z2CWQqRyx/1cLPyaMj5MYAOIQL8ImSCoZtpp14e62Jz2WO7pFv790o?=
 =?us-ascii?Q?zXKWCelKFrmm6gVava7QdCwYjkyr03yQxSAzV1vxOVgXDAgZggZZi4ZOd7L/?=
 =?us-ascii?Q?3Zs4hG6RutKv6sGOYG+GcStotLS2YuaaQ0HgF9UX?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc3e070e-14f5-436e-5942-08dcd793c873
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4113.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 03:41:30.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0QxJmNMp2YPd+Kv5ggb0ihSF4O41jDwW3kOxz68o5pWbTqMPZK7CsWDEJaGGROd+ug6jXxGSMcDwHNWHTZz/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6556

Correctly spelled comments make it easier for the reader to understand
the code.

Replace 'enngine' with 'engine' in the comment &
replace 'trascatioin' with 'transaction' in the comment &
replace 'descripter' with 'descriptor' in the comment &
replace 'descritpor' with 'descriptor' in the comment &
replace 'rgisters' with 'registers' in the comment.

Signed-off-by: Yan Zhen <yanzhen@vivo.com>
---
 drivers/dma/mv_xor_v2.c         | 2 +-
 drivers/dma/sf-pdma/sf-pdma.c   | 2 +-
 drivers/dma/sh/shdma-base.c     | 2 +-
 drivers/dma/sh/usb-dmac.c       | 2 +-
 drivers/dma/xilinx/zynqmp_dma.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/mv_xor_v2.c b/drivers/dma/mv_xor_v2.c
index c8c67f4d982c..c6c9702dcca0 100644
--- a/drivers/dma/mv_xor_v2.c
+++ b/drivers/dma/mv_xor_v2.c
@@ -635,7 +635,7 @@ static int mv_xor_v2_descq_init(struct mv_xor_v2_device *xor_dev)
 	writel(MV_XOR_V2_DESC_NUM,
 	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_SIZE_OFF);
 
-	/* write the DESQ address to the DMA enngine*/
+	/* write the DESQ address to the DMA engine*/
 	writel(lower_32_bits(xor_dev->hw_desq),
 	       xor_dev->dma_base + MV_XOR_V2_DMA_DESQ_BALR_OFF);
 	writel(upper_32_bits(xor_dev->hw_desq),
diff --git a/drivers/dma/sf-pdma/sf-pdma.c b/drivers/dma/sf-pdma/sf-pdma.c
index 428473611115..538a7bc58108 100644
--- a/drivers/dma/sf-pdma/sf-pdma.c
+++ b/drivers/dma/sf-pdma/sf-pdma.c
@@ -354,7 +354,7 @@ static irqreturn_t sf_pdma_done_isr(int irq, void *dev_id)
 	if (!residue) {
 		tasklet_hi_schedule(&chan->done_tasklet);
 	} else {
-		/* submit next trascatioin if possible */
+		/* submit next transaction if possible */
 		struct sf_pdma_desc *desc = chan->desc;
 
 		desc->src_addr += desc->xfer_size - residue;
diff --git a/drivers/dma/sh/shdma-base.c b/drivers/dma/sh/shdma-base.c
index 588c5f409a80..fdd41e1c2263 100644
--- a/drivers/dma/sh/shdma-base.c
+++ b/drivers/dma/sh/shdma-base.c
@@ -961,7 +961,7 @@ void shdma_chan_probe(struct shdma_dev *sdev,
 
 	spin_lock_init(&schan->chan_lock);
 
-	/* Init descripter manage list */
+	/* Init descriptor manage list */
 	INIT_LIST_HEAD(&schan->ld_queue);
 	INIT_LIST_HEAD(&schan->ld_free);
 
diff --git a/drivers/dma/sh/usb-dmac.c b/drivers/dma/sh/usb-dmac.c
index f7cd0cad056c..cc7f7ee7f74a 100644
--- a/drivers/dma/sh/usb-dmac.c
+++ b/drivers/dma/sh/usb-dmac.c
@@ -301,7 +301,7 @@ static struct usb_dmac_desc *usb_dmac_desc_get(struct usb_dmac_chan *chan,
 	struct usb_dmac_desc *desc = NULL;
 	unsigned long flags;
 
-	/* Get a freed descritpor */
+	/* Get a freed descriptor */
 	spin_lock_irqsave(&chan->vc.lock, flags);
 	list_for_each_entry(desc, &chan->desc_freed, node) {
 		if (sg_len <= desc->sg_allocated_len) {
diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index 9ae46f1198fe..18a407975e14 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -366,7 +366,7 @@ static void zynqmp_dma_init(struct zynqmp_dma_chan *chan)
 	}
 	writel(val, chan->regs + ZYNQMP_DMA_DATA_ATTR);
 
-	/* Clearing the interrupt account rgisters */
+	/* Clearing the interrupt account registers */
 	val = readl(chan->regs + ZYNQMP_DMA_IRQ_SRC_ACCT);
 	val = readl(chan->regs + ZYNQMP_DMA_IRQ_DST_ACCT);
 
-- 
2.34.1


