Return-Path: <dmaengine+bounces-5194-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFAAABB45F
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 07:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1917A18963CF
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 05:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1681F0E2F;
	Mon, 19 May 2025 05:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="CTgNn1YX"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDC81F0999;
	Mon, 19 May 2025 05:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631437; cv=fail; b=mdZvqd+mRZnnzx9hDbkj8k/qTRfCkW82QAFgvGn6I+om9dfLXyLG9NwGyd7TLbfMJsl2KoaY1iJ0PI19+nLN34NYgqhwwJQmlN5d6ASJ0bNXkUMi+hTfM45aaBN8kQOGgbqsDX2CkLdxjVW8J81fhQyUce9pZ/qYoJGKuTC390o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631437; c=relaxed/simple;
	bh=QOvmUGxMEA3SO2+fmxBVUMlAQ0WA3THxMYIuv9ULg10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kNt23KEuOPeRBK1Pusl/UaSOaFarITvrGKre6GQix4o0jEodJYEcoBnawDBXwHdXMPSSA8tf70W0qQipYegbieiq6dq1KyqzcOZaeHaeP7wb/wFbW+HogCr/KtMJyLGwkjHUsTCmaV9eqOUDxgnMZjcMR4WGBf33zu80EvJQRAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=CTgNn1YX; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GV74bWanqYJ12QeycD9w+5Fvp0edwCaNRB/Z2JHhcLt1cDE9RABGiQfk87k7fBemMubsmxeRFLfiZe7JUWq9d5XmT9mzwQI6IUNpQePT2p06UGY7xLtnWsmpjhEfoHZUyuA7TZvYj5ez3m0B5GXUebQLh6sT6VsCnjIePOloMq3vRDNgxLpvcYy5GhpELo7fF3lyRq6K3dWZDE5kfCcJpsxGM6ypcxpoh2Y2iqqJX0PFIJT+PTeCv+WHhFAxtqynPw8EjykPPpInwnyqQAXy4+6bZMTh7SzMwAo8EltQ3d0B0L/w9MoFznkuxt6WtG0Wd2wAJotrtDLcF2k5I3rMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=450zgrxTCw9vlmlkBuaEso5L28dUJbL1cF9+K3JWtO4=;
 b=t9YJvHpZN9d4qpvWPBwDcg8wTnczPKAltmUKOBqZ46yyfLHQZk+rMJY1SllJYzS3AfXGNSAXrZrO6P3EMfhBjPuV8JAgKaYEZ2jU/q22Gme8rtVFPVc3NmrSwKsC6EtA0eZxMKPIJRUlcsPAKoRa6ilU7kXDrR2I6NREEYoQ26hIf3hFHIgtrDajaQczjcRpGgAncYh4y0SvqIbQHHEo+kv8dI+LepXw7nO2sECI15ORh3U/K0iSZi/dAAhCAxaD8e5/Q4CqgJwaR03TKW+2Sw9aLMJ0KWCwB5/2KQOD0ixYqY0EdJgAntWX/eDrxYJsIthI4+GYI3IGHNvM8FGtDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=450zgrxTCw9vlmlkBuaEso5L28dUJbL1cF9+K3JWtO4=;
 b=CTgNn1YXsN39SAv5fJUDJeHS/TVjn1IIEjt26gjAAiU1OHnKCayCsF7l/iciSzipqeMlYAEv7rRnR7ohnSYNQcwpr5PDHo6WMGjcjz9TOq1cz/st2EnWECI6ganQpnSjloo6mFsl1jrEyltrwVg3Ql/NUUbpPN6zRrCzpAT7MAH9buzIeDo93k7lTV2R7eGy1RojkbkcKtJOEm+TG6Mcxt+HVpZlc5NoEKt1056nxv0yPzUvqJJCZ6tcvRz57x1lxwCY+tCUv6/crF88eKPnWG27YnS1N47kpo8onD7P0UMyDV1ozpqtBExD64a69P/zZaSidTGkbWCDVyOh6WOXwQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8060.namprd03.prod.outlook.com (2603:10b6:610:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:10:34 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 05:10:34 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: [PATCH v2 4/4] dma: dw-axi-dmac: Add support for dma-bit-mask property
Date: Mon, 19 May 2025 13:09:41 +0800
Message-ID: <18292747115f17704caf646784e64c5df64cadb6.1747630638.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1747630638.git.adrianhoyin.ng@altera.com>
References: <cover.1747630638.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: bd65f2ea-7854-4c37-63fc-08dd96937c20
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/NllYhA/P5eCU6J6tFR3nlrntz64Exz8oUJbj5o2c49VyY27Y7mF07a2CQh?=
 =?us-ascii?Q?QFce6aByJq6kgsZUCv2vxBKNd1RBX875b0E9hQDqnwTWaMRA4RN2gblijkQi?=
 =?us-ascii?Q?2OkyB3LdRMfNDi44A5ffoeMnC+BqDKlTefHAd42lX/tyRu7mFSsjxHcgpBVB?=
 =?us-ascii?Q?FUKiNh9aNmhrQ1grLiGSTkjhApXhy6vPlQ4Yx/Y3V7F5/1vs0OEcvKCStS/7?=
 =?us-ascii?Q?QUNJTnQNohywjhuN2M2EUNxdTmDoUxY8iHuiGPnnZXhU2G6j62en5imdJOBQ?=
 =?us-ascii?Q?dtaSA/iFjINB8vJIel/tc63sKS7JVfPEDt3FIp+FdO4LHaXlw8q8vIp85Jh6?=
 =?us-ascii?Q?h0c5d/uGsgEG0H+1i7kcACuhPCr1ztv7S0v7NAI4WOyyxnNoy/tg1/54MxT9?=
 =?us-ascii?Q?9D6uK2DzPopTahxT7th7EBInryBh1DnnrCOAIMSCpvcZZ/lgJ2yGzLbOeLvD?=
 =?us-ascii?Q?/pbNvZ2uUHPK/UJf3GFlRUsseuvDCL5g0H78LVOP/JPURTkahv92FayZRwwJ?=
 =?us-ascii?Q?veRSXdPsAHdE5UFmSD2yZSx2pfGLVeTh/T5iCMAE8zDvJ8ORqePfeQuQrXjo?=
 =?us-ascii?Q?x6gwq7mkwqrnRyXMmEbUwnIpV5WmuL2jLu0n2HWWDsYvF7M+lOh4PBlsS4wK?=
 =?us-ascii?Q?BPuicYIYy2ERfOALNm0ClKswo0Km72A3MTzEE9q63m3B6m6ug0egcjdWWeXR?=
 =?us-ascii?Q?lL7TfMIrMnLkivSWqpCdU/+8zLZ89epPBDHWLkyPIW+S0qCRE6poCBvdv9u7?=
 =?us-ascii?Q?pbimYhlMEMChoPMOAX0iakpC7elk87o5AjBDCYls8KsQKe0h3uwvZuI/M778?=
 =?us-ascii?Q?Pdwl+rhFCMA/ZMrqsxGIOxHsLdBQxyvqgS1siQMY6VQPj0ETlQIU54ui8WeJ?=
 =?us-ascii?Q?U7BBbqOXbo6N5VMvN+teNNEobQ7R52SY8CMz5YRjhG0Dvw2wAKjzYoprenx9?=
 =?us-ascii?Q?J1JedWidIqnoi0AF2LGWBEBuTJ+4cnHlIuI2l5TK5zyPVggVnVCIOoGOaG12?=
 =?us-ascii?Q?qD5iCqwqMtSvZRlv69+bxFVBqFeWI4XvcR5GPOpfrivL4MM2x56ngxiyN3Ut?=
 =?us-ascii?Q?b2sNCMtyvgfrNRZmS1pqHAxVXUhunax+HDVZ3MUrpgdWN8+mq6VYUh5LKhdG?=
 =?us-ascii?Q?gb7lenTtOtZcSs+0VH+rliSvmJUbGlTV5tSSiHKJ91EMjsoANJGhA1lH6idG?=
 =?us-ascii?Q?fb9d077s4seOScxh8F78TohvuwCgstaa5Fu4lVd6e14uoEbcdg3yLDzff0QS?=
 =?us-ascii?Q?px9APlss6T+0e3qU12UbBb+B+zQbFi28lyhju78qaL3B9cW7rfambqogQ2SC?=
 =?us-ascii?Q?no4bMxyaF4Z54+1pt0sAA27XMFr/pAVAFCpVf/8nsLIjTb1QKKh3w9I1Aj4k?=
 =?us-ascii?Q?G6Xhb4kV4wjaxShFy+uCOA3Z0CNIg5t9fBMR9riOquxtlimpGNJx3U0ppaud?=
 =?us-ascii?Q?3a4C8sF7NiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5W9H15qqzqvO2wnnGAoF++dTBIZi+wBO26NVz02oG2LSCkg4J3YjzMGg48YF?=
 =?us-ascii?Q?gkwv+l2KHf0s3rIhuxacxDiQdgdX+TBm9rNcBCc9gxkP5ilUyPUb40EIkq4P?=
 =?us-ascii?Q?s05SK+JPdgjldzdKdLhUjvXcfL2ftbES7QoGmEpFevOmgrqtVkP1PeJLnEZO?=
 =?us-ascii?Q?sX1pelaWlj+MBoa/mF8u529uN2xD08MQkhWCj+fKgfdbNZ9bObDETJ0xgQ/9?=
 =?us-ascii?Q?pjYrCDPgw5ox3tLFLVJlfGR5XHRt4QRHNv0C39G7nNcpIXfvMn0K9qMYrgy8?=
 =?us-ascii?Q?yXGzveIOwGBwBpC0b9XqsODRVL5sahptQYSNN5zeDw8OkntA5lfDO0d/WdRb?=
 =?us-ascii?Q?erEI0ZMrUkFYMPoMpITG9P5syGTKwzV2TcMk5os7/+9ioQgQkZoHK20USLNT?=
 =?us-ascii?Q?uuEc+WXTGK+rzlSEOYVt12Yy4SDVPCP88mNOqv822jimr+/BuZNTqYXGft4F?=
 =?us-ascii?Q?GilC2szYIEWTEehutYBrTD/mDmrF98I69SYIzNNVbHzloUFeppGCNhSMw0oN?=
 =?us-ascii?Q?2hdRJhPknYKdlurACWW7DnEcHXvdg+WpFL6bJtDcByBB7bQTwBhZoDSpt1Pe?=
 =?us-ascii?Q?j5CoV6/UOAeCfEpt0c6EGyA7aefxXC9Co4951nB6zfQYljo+SVE1IvhEaeQD?=
 =?us-ascii?Q?wpucAgyLjKNKZj+KTo8pHmBFhTkEoX/FFqZF+mfHhSftHN/nCPSdYoY9IGMW?=
 =?us-ascii?Q?Spoi1KrbQwCuZBJ3gHfzS/OKxM13FPn/CIIvyzQgsvDCsHdn46w+5oZFGYxX?=
 =?us-ascii?Q?Y58TmRKvtYr5Gfas6ycD1C9DRvmJN7Hd0Q+rOcDgWBEwwkownW3WhfxNsvkr?=
 =?us-ascii?Q?CE7hAUiUFW5y/1OPrEcrZcUKZLwYYbFlJ9U1JC9lvLDMDHL5VVw/VqK/KHGz?=
 =?us-ascii?Q?xAatnaGEU0KBNz10bAgNuHiP09oV189hWz5q3rIsR93wEuw5zxtN8+urKkN/?=
 =?us-ascii?Q?zO4cyQTNDJ+oEAwHRAuiskGKbnZkNI5GZM9FkGdUw4+NlaLsooUc7Vji3rYl?=
 =?us-ascii?Q?Xsterw1ZG0VYXrOGY4RvEFYNPf1WCe+kljYUDMfdL4HrXmG6U7t3Sb1bcUws?=
 =?us-ascii?Q?Vr4MCAP8kA2adcE+uGTu7JOp6k5lItB6BoyGE9CBHVzw9hA5Ahd9XEHvuZMf?=
 =?us-ascii?Q?SHgs91fEVHVdNh68XUZIJr0g8uJxnA/KKXvJFgbDTNlvPyJqAIvJpTM2v4X6?=
 =?us-ascii?Q?Hr6ZjbxfpQZpP3YFCqw4vZ+NmzRyoSC5VAaIFGOvvo/PeiWLjwEZRuBfStKz?=
 =?us-ascii?Q?NErp2I2YauZMO3RQ4LuW+OtJVDLOFgzQbnCJMof+XjE9kXiVPL/V2NOngb4C?=
 =?us-ascii?Q?1ZnuY+LO2wuIM3Kukbu2f93i2vGRV5ZfOSnHG//H5irgXGKysH3p0AXjiVX+?=
 =?us-ascii?Q?+a/PhVYzXW+qMuy78uqtFBe8SxhG1pkDwRxvsnAvtcHAXaajUBGyrOHQGwl3?=
 =?us-ascii?Q?pGqTo+ZUtsydZFQF5nLDF14RU0kcItJ7e46klvavFguSV8/VlBsneWtGm4+E?=
 =?us-ascii?Q?2LgUmp4FGWcXLm0ixC7m8z4EQHwUliUfeP6XKIGb2vFaDE243BjHTPf1le1n?=
 =?us-ascii?Q?HbshIdGwuDM4DagujM+RbceZ4UThuJ7YpOy/LULInuPibaPQMWh6VK0s23yX?=
 =?us-ascii?Q?Ng=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd65f2ea-7854-4c37-63fc-08dd96937c20
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:10:34.4248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GeblVccjPVp5wI3FsvbQryPz3HsV9jojwK6ZqCWXISJnq8fsSCf+9eOQzoWGGOAMD36DQ8WConOWfr8SloJYtvlqScQFf941KKtKP7jB2no=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8060

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Intel Agilex5 address bus only supports up to 40 bits. Add dma-bit-mask
property support where configure dma-bit-mask based on dma-bit-mask
property or fallback to default value if property is not present.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>

v2:
-Fix build errors and warning
---
 drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
index b23536645ff7..aa6e66dd67f7 100644
--- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
+++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
@@ -265,13 +265,23 @@ static inline bool axi_chan_is_hw_enable(struct axi_dma_chan *chan)
 static void axi_dma_hw_init(struct axi_dma_chip *chip)
 {
 	int ret;
-	u32 i;
+	u32 i, tmp;
 
 	for (i = 0; i < chip->dw->hdata->nr_channels; i++) {
 		axi_chan_irq_disable(&chip->dw->chan[i], DWAXIDMAC_IRQ_ALL);
 		axi_chan_disable(&chip->dw->chan[i]);
 	}
-	ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+
+	ret = device_property_read_u32(chip->dev, "snps,dma-bit-mask", &tmp);
+	if (ret)
+		ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(64));
+	else {
+		if (tmp == 0 || tmp < 32 || tmp > 64)
+			dev_err(chip->dev, "Invalid dma bit mask\n");
+
+		ret = dma_set_mask_and_coherent(chip->dev, DMA_BIT_MASK(tmp));
+	}
+
 	if (ret)
 		dev_warn(chip->dev, "Unable to set coherent mask\n");
 }
-- 
2.49.GIT


