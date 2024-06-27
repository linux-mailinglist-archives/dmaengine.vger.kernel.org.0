Return-Path: <dmaengine+bounces-2552-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EE491A64C
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 14:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DB422863C7
	for <lists+dmaengine@lfdr.de>; Thu, 27 Jun 2024 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5336315443B;
	Thu, 27 Jun 2024 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VbmkkJgC"
X-Original-To: dmaengine@vger.kernel.org
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2152.outbound.protection.outlook.com [40.92.62.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACFD15278F;
	Thu, 27 Jun 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.152
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490203; cv=fail; b=C7qj74ng6zjQyn/dzeeoWfWzzwFRtZz24UeIBqkleFlrR7iX0gI1VH7F8HePJCG4YFn0zGEQ+HgQqDYXNYIg4Y8W5Wb+vvhn6u4MCMfdVfgzKZjzpAtvIaQvac2U3atMHgsDmb6OQRt22HZjngmEEtDLeODb5wDJKpk9PsZOLmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490203; c=relaxed/simple;
	bh=1YQY39ZbLG2pwt6lWkTLNWdPeH0WMvjQex78JPAmI70=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=GLmZInexjD3QRtD2ynVVElJXtXmD+4wv5zZ0DsDbMzHdENVqj4dn3uk8QoW1UnzHHwFqV+4nPnQuHD/1JO6x3SPoV8+ihTOJNU/ygaP197GemSnqR+BDb3e2TBAzAytYMq3/WCkT8YoHvKGSwrdHigDZ3LLsVdRDWhr0xamjXes=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VbmkkJgC; arc=fail smtp.client-ip=40.92.62.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2EOVCPVbYOFPJlixLIdivO2Y0nmzY7s/zc63XlXqr8nA06V9Gorr5cRP/y4QRClzwHluPpOvejQOL5ntnLDCF2Jls5ZMzJxzg3V73S4W6QXRWa22uwvkMAV1rkdj+NwUcPQ0pr53dEfNsYrEOgZrIN4Iqc70SA5LAtJHVMr+iwlriFxiIMRaVfVceRB+2S6kA4Zod/jrIwBpbEhRVZZRTEs4CsEkUoIF56SSnWYlinNpZSPHHt5zcMikNxvxd/aUI+reh4zuNZDN/aQBV2/+Q/oo5R5kFBGbP4QihhpbWcTbwwGJYESxQ77Y0xIgUgYsNqi0vcLLMl27F8dXYDdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OElH1khcdk9HXCdqKgdR4XeVspt/cgKsU0aihWOMaco=;
 b=lYpNOBJ7k7/+U/7zBObR2niPuJ4LTJdDvpGAbCjIKWknhu6MKhbLpIOAsBAfsgOCcPRxCF+fjxpPjBym873uRNPp96yzh7dZSHWLbj/lJGMcoPeprMUc6b42addrVT0UR1F8+wXqiqQnH5jUx6ONTie3LpvKjQThyOsbq2K2Q2zIgaKmvVR5lomDVsH7P9P1bGFz33YqGBkG+cGm1InqGZ5AtnyeUx2JMF9tiBMZKzAOeCCnopHJzy4IUiuqrv1pSpggXBx2oVu/3f39r5iW5OF6XrRqpQsJRPyUZQlomhAcCJJLrPhaYjKQJ4BVbgPvJsOmSoW+jt0wZ9hw5aHhRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OElH1khcdk9HXCdqKgdR4XeVspt/cgKsU0aihWOMaco=;
 b=VbmkkJgCCK9k7z6k8FcdB/FfEyDOKsTAJqJOPgOBssYz8KUBBnDkOOFCYlZjelVJeu1RrhyrnSJQpxNqW4SEbsMo7RwePgWS7ugDvZqZ3xsDSzIS0jAtTFtwQi9OURnwwA0VXU9o7PNAmh2XFmLkyoOLxMhrVSPn0yCqtqXKPuRwz/K9Ag3EbFYfZX7lQdCBh36uT6FAjMHtt+U3lQI1BTDZ2T8Oud4mFLc5Xgw+sWJCaxvoVsAfGGaVpxKbcKGEMRW7vX6zWNdiESsm+r+NErnuCgVFUmU9VTN39ASGePnCMq0K3UiN5FBHUtXb+OU9/OmPHC8pOhe/dobtP6U7yw==
Received: from SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:117::11)
 by SY7P282MB4753.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:273::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.35; Thu, 27 Jun
 2024 12:09:57 +0000
Received: from SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM
 ([fe80::aaba:e4e7:4639:7a7e]) by SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM
 ([fe80::aaba:e4e7:4639:7a7e%7]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 12:09:57 +0000
From: "zheng.dongxiong" <zheng.dongxiong@outlook.com>
To: manivannan.sadhasivam@linaro.org,
	fancer.lancer@gmail.com,
	vkoul@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"zheng.dongxiong" <zheng.dongxiong@outlook.com>
Subject: [PATCH 1/2] dmaengine: dw-edma: Move "Set consumer cycle" into first condition in dw_hdma_v0_core_start()
Date: Thu, 27 Jun 2024 20:09:46 +0800
Message-ID:
 <SYBP282MB26207BD3AC4C1B6ECD5ADDFDF9D72@SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Pi3aEuadkyf8+3nyTUaMzK0pMd2Lc6SD]
X-ClientProxiedBy: SG2PR06CA0224.apcprd06.prod.outlook.com
 (2603:1096:4:68::32) To SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:117::11)
X-Microsoft-Original-Message-ID:
 <20240627120947.11677-1-zheng.dongxiong@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBP282MB2620:EE_|SY7P282MB4753:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a51235-5116-49ca-105c-08dc96a20fd5
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|3412199025|3430499032|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	LiDVc1wykzr0qiE0I3LmOFXKdkRhkaPloamHedmvcNBEHK7nQKt3rbVy4Zrt93EH/z4y14Kdp9OkZkWHlduJQ3YTE25czTwn0PjAVcN6Zk33Nv3dfwyyyDWwyqdPSlir0ScYwJCgTDCVZt8UBQvPf2AzBeXiPZcWWeZXxHlPG4E4mZTfz6NEK7TfyBlGf7PP3jN9p8FEOeKMMxZR5rJcG6yZ3aSW75DgUgQ9bVsXsBAvbUWAz1yrBHIb9HpiiMVvTbcGv2N5OraMgJgLiI0iH26P9J3OHrKhHe9qu/5590gttpAsqdoxswI/+MoqM0jsno9M2YNXzaM2OWGH/c/6+nL7EFyd/If1cODrUDRQasyHLeM0GLfZPwQuz62+xp5qbMqBHAredz/3fAD+Ykpxhc+8E7X56yBfKiCXGwA9XpXwlfCMcioSLk+UchKOt3xh5PcRiIn/aZbl+WbX9YVLywFtx+MLxnwA0NI9LesS/erMXVWyQEhZ3VgjUul+RczXjeFVfJdjgFqQHzxlTxhnQ3uD1+8jASqn6Jsw238UypNLfQu/821ur3Q6R13+W3nrMV8xqk3OwCdTjsLgpU6diU3lCkRg6yzdjmO0G+qs15cmnTXcaJGGXpu70hZr05Ag
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZPbTMT45NEDFXTK8YRVajpXHDiXDUrPEJZ85g6QHDVUjaT2aQnGejgRopDRj?=
 =?us-ascii?Q?gqcxfgyV1Tpon4fFYDTAh8fFZwoGDKJtJVNZnQi9Jl7PXvZhUjAQgcGmGxw5?=
 =?us-ascii?Q?gTlDizi+siZfUuy3Yt0RXLsx8eVs+xdbMj0MMyagH8jQP/q7a2UFV1DVBHZo?=
 =?us-ascii?Q?GEdui1JXRKzU21EKZBVrMaIz+DWxX1rqrOHqm/YMQy1fEXc+sxrC7gINnYZ3?=
 =?us-ascii?Q?P43iB3r87aMEJAT3/YCbqVBZi5Mx9VvQB46bqYFgcvRqtwPg838yu7BoZTaV?=
 =?us-ascii?Q?nRA7J1A8qnJZUnZuiFQabNyycacyeR9Boj4PcvqbxANlHmAav51aYl5Hxh3k?=
 =?us-ascii?Q?fv4qveQ0XMIj6wasHjTAMUV9q36ZXaOC07OvKC2G72djfBvLke3+DuWdLOn0?=
 =?us-ascii?Q?l8EwfEpGDX9HfM6HeIGNkUqlmsnU7RN/UrpibGf3CTVJW2kaRGH0NYFQ9uFL?=
 =?us-ascii?Q?QChH10LiFzca9qDzhhZ92qeN52wap8kEDeCvuk6CQnDKfvSdXn/NwG5brv5G?=
 =?us-ascii?Q?23LCNlrFUonEBNmFUNlvqdTvix5xccOcxMoc7z03f/+qjFOhLRhugxBzGqcU?=
 =?us-ascii?Q?X2IJEjtv/AdyshZtTTrKWT+gWBeeymNbUXOOO6CSzmKrk/3CTd3iLR6nBWYw?=
 =?us-ascii?Q?qcW6EjFwEBUnekKTa/pgrxocXePuV3QluZgm8BmkQCNRks74vySqiql2y3p6?=
 =?us-ascii?Q?whKy+tibq4hYZev77gG+ralCBO5cpxMqLavtqZnj7l1HkPEjs5xSZ1zrlG2v?=
 =?us-ascii?Q?4Hkdj9JT7w4WP8kgsWoeCgQTc0mJeMoteXlHZ4wgoAdUIYGbn203ksCqnRap?=
 =?us-ascii?Q?A7zwCwFQRGEUkECBA7NX8UNPWP09r+iK+ATBHNQeoAMtMGSSOG91Ta6QS3sr?=
 =?us-ascii?Q?yTo57H5VB/eyhm8mZo7glLVEIuBRe4g9xSwylEnb7eXTF8AC0ZA06KJ8l9EG?=
 =?us-ascii?Q?AkTurS9Yhm7MG2wl2S6yS/Ns4UfG4hrN4dv0b16GgCV9RtL9oBMGHTNYZuJ9?=
 =?us-ascii?Q?rYg9P2Lf+JP3u6jaIv1ejxpVzNBztx5mOEbHixH4Xyiy8UD5nwT63djtWMn4?=
 =?us-ascii?Q?oym2Shtwb6IW2CoxC56Swpywu0XT/9UroRr5teEbaQOIpfMkKA5W6RKCQJO8?=
 =?us-ascii?Q?NH/+nt7W2LlveV3Vq0sdevvFuPk4+7dsJdoMALy/9troJDenP2jlS7vNYbas?=
 =?us-ascii?Q?UOeCcrCxdJwQUocFw/P6Z6L09ydWW3+/CKs5j5ELity8SNnSbZWP0lNpPhR7?=
 =?us-ascii?Q?7jQdBwyABKnrwuyzA9z6?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a51235-5116-49ca-105c-08dc96a20fd5
X-MS-Exchange-CrossTenant-AuthSource: SYBP282MB2620.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 12:09:57.6666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY7P282MB4753

Consumer cycle only needs to be set on the first transfer.

Signed-off-by: zheng.dongxiong <zheng.dongxiong@outlook.com>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 10e8f0715..d77051d1e 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -262,10 +262,10 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 			  lower_32_bits(chunk->ll_region.paddr));
 		SET_CH_32(dw, chan->dir, chan->id, llp.msb,
 			  upper_32_bits(chunk->ll_region.paddr));
+		/* Set consumer cycle */
+		SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
+			HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 	}
-	/* Set consumer cycle */
-	SET_CH_32(dw, chan->dir, chan->id, cycle_sync,
-		  HDMA_V0_CONSUMER_CYCLE_STAT | HDMA_V0_CONSUMER_CYCLE_BIT);
 
 	dw_hdma_v0_sync_ll_data(chunk);
 
-- 
2.34.1


