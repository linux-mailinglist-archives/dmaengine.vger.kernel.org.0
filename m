Return-Path: <dmaengine+bounces-6400-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD11B45AD9
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 16:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73618BA1038
	for <lists+dmaengine@lfdr.de>; Fri,  5 Sep 2025 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA1374265;
	Fri,  5 Sep 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="wMg6SZGm"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010010.outbound.protection.outlook.com [52.101.228.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5C2371EAA;
	Fri,  5 Sep 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757083522; cv=fail; b=nRyceT24Lge8nJHSyoK4BzvS43BhDvXUsIlTxM59gYGUoJ9EEl9Xih0pAxGNvrIkX9TxFyslX0r16EQPvuWXw31ciqcN0OTNQIoujavBcUPK1OClTPsPH6NPfP0I6MEAtZGaikVt6gdgQeLZWMN5jfu1XvD0WgIASsy2VmlcP0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757083522; c=relaxed/simple;
	bh=ZKgAwpKQCCIs0opkW07MfdZajeoof0x0+8MuoFF8eFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Me98J3vp/YgIbs9lVlYMDh6DW3GrblBtOT9XOALSMWxs3+jf4m70JES2+EdeETdYtQXOv8l919D1zOc+t+wQFRVyPmdLZEBJ9tskJiOkQ8zgIgmTNmWQMZW/oAiMdgQHpdIEJfh+wiqIcGEsrUSp4ceV8RlroUDadMNTY62tKaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=wMg6SZGm; arc=fail smtp.client-ip=52.101.228.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mh4HCZTmCudDKq8LI6wRxNGOcfF5zXDjS7e6z9QRcRmRCYcjkl/S9i09ztpsZRKylqZcnc7QCSUGB5tS0EfseFEd1xzP6uEIDUbnTMc9E8+a1TaQx1HVLEfcFLIymHiedPS5oX7DmircXc+2fKNla0Oea6JD3B2LbUDevoPoyM4k5a3FPVs8Pps9+1Fk2czycRyN6RkojdqNjIF2QXDU2hvDc2bpsdw31tXcFovX8UjjZJ88h3SYYMNnNl/k+dTlJX5I+VdWYOIqpeFoz5tVXwqwTaqXQ9li4efWUmtISUfyZIjz5c1GaCss5gqPkZ+dEFDiKEKzyLX648LWs+/wuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SQKWIim/2yRuYWuuItOqo8SC+Qj/P/82LI4F0OcoI4=;
 b=o3MDfhiWZZgvpK/fZ1criAP9D2zSZm4cevUjsoK/i0sqwuWb+TkLTtpsGnl5CvYskGIVqP/A6VuYaNl8scR1MK8Sf4wHe171vOCjcM9gsv2n6UE6dhKadZFQZ5tSQjnIdN9stjczOO21JR+lyvgGuPEY5HO+oZwJ1W7r5o2v7TDZxiXxzprM++AUb8ZKnqdZSj/1WuFX4MYaS5akkhZs8apgi/icVrCaPDin6wsR6TasJ5ySJKOzYGWUhcCdNSz4OFIZvRBOc1yG6lyqHKLXskUKYiYWM4GMRpDt4avFVSxqMGMEbch5tjRgUwn/F45ftmyleSlYkn+uFndby2uJmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8SQKWIim/2yRuYWuuItOqo8SC+Qj/P/82LI4F0OcoI4=;
 b=wMg6SZGmJUM1kVx4Jr1s/cUJU1P4WNtxyRH5sn9N98MY6U7lgCemHWKvV9Bu7gOBXoxAIn/H7xYCtTBGmQYgtRkXFCEWFsPUYgW9bigebMHZYnU1jo3oMeBiARsR31EOyBl9VhfxvSvMgErwuUpPqyCtYg1cCUwq2nz0wZCcwuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS9PR01MB14067.jpnprd01.prod.outlook.com (2603:1096:604:364::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Fri, 5 Sep
 2025 14:45:17 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9094.016; Fri, 5 Sep 2025
 14:45:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: tomm.merciai@gmail.com
Cc: linux-renesas-soc@vger.kernel.org,
	biju.das.jz@bp.renesas.com,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
	Vinod Koul <vkoul@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] dmaengine: sh: rz-dmac: Add system sleep power management
Date: Fri,  5 Sep 2025 16:44:20 +0200
Message-ID: <20250905144427.1840684-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250905144427.1840684-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0420.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::17) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS9PR01MB14067:EE_
X-MS-Office365-Filtering-Correlation-Id: e630f729-db02-4e41-d501-08ddec8ad477
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?p1vbohIcIyGPSLzqk+wIZV++/CwX3Oj9fKEwRmDxVVW4PahxSh+MPjjf0P6V?=
 =?us-ascii?Q?jo1Vpe43PtwAWY+CgpPb5IaFrEv0XQIL9DDu4ba4hZDQmvZ4V5Ijuh4kqm7N?=
 =?us-ascii?Q?3qRW39HUmSlvVdJ92009EB6zLajwAU0odihHHA1DfA+GQ7+2yI90rx7C1OTF?=
 =?us-ascii?Q?kNW+Xsm7mVofC87K8qPPt58ysdRW2izO2SnI5fgCugEMwWntXhu+8HQXf6BK?=
 =?us-ascii?Q?/IBrNOkorGFEwycY5smaCIxNzOz4n7THE2waZPqDTDkahUnsU7pqMDIJvg3M?=
 =?us-ascii?Q?f5QgNLdg/wwxnOv+tDUU5A8RLIdtiFR64Um5cJNJ/qBHmQ/j7cZyBDUpAzkV?=
 =?us-ascii?Q?MW839F+B3pwIPQplwcGIhGpjvkClQBpGDpMSzj8ReG5N0CKRAX0Ol0MlkvLK?=
 =?us-ascii?Q?sv4x9d5y9XrHDuxR8wiuLB4HQye4me4MwB7L5UrNZZU/GL3gCYd705Dg+W1K?=
 =?us-ascii?Q?F8p3mXGR9V460lTYExautlRsWdsK/XLNNKTWvf73LnU32zZYBj4dhXjozDjq?=
 =?us-ascii?Q?aSrfIz7X4eRrnjXM/HX4bkE3b959bd32Xc75k2WwOs92WGG3twieO/nNpRIF?=
 =?us-ascii?Q?TzKT9w5EUka251E5xqGJZQOVYA09yHFtJR5GmzObEpBCECJNSRgrgIWBXDry?=
 =?us-ascii?Q?kGtQg+XxxfB5WU4GxqG9v9ekqNpSuXOZzZh6lsQam6k5NtcQywz4NoMUGZug?=
 =?us-ascii?Q?Ucs68K31n4QenbkZAldaJb/hCG2LR/2BxL9eNNtdixckH5Zpf4xQErYwWKG9?=
 =?us-ascii?Q?tY/shdFGN1WobhV5dwbNjNcYR6vif3bc2JgTRa6ophS3vHVKcHNsR4gKBNEh?=
 =?us-ascii?Q?jVufYnjdYxSNJQ12pBVl7aC+cKgE0XZNWak0alTzOMe02Y3j1xZWgk9mDHMf?=
 =?us-ascii?Q?evDwWHarEoSQ+IWIfgkVJFn1H7ykjAxU6I1xponBxAOlqV2aKdapE2/yxvNU?=
 =?us-ascii?Q?tAmymcIRISwI5miVlMpN1SfkgJaL1r8m8YMK/WUCpDjoNRnWiyaYb3XClD9O?=
 =?us-ascii?Q?E02EuMg85qYEyBMaB+YFAadn/5nKDaTp5QotATIE8jroV+SlJgOIdxp4bIU1?=
 =?us-ascii?Q?L5vFXkGS2Vz8ClftnHmGw997QsHHN6o5fXVCGAl6KqEZy6cmT/85v90qNt5S?=
 =?us-ascii?Q?RmYX8+D/7iFdhwxZ/NzfY1THqlVEXLqjhYS5zJ3R9jkOBArOoDJpiMQq/H47?=
 =?us-ascii?Q?k0N42OACQ++Ww5UIzPgxWmrrd/9kLnnx+IlIQrRPimPYDwTsEEyAOgYl0icb?=
 =?us-ascii?Q?/AiUEWWbQ33yeKdbINkFaoiYAcr+Ui2baXqAA+CtCynoQUTaHtOl9Ypybjxm?=
 =?us-ascii?Q?lTkEckE2/xoShSMTUz8lORCfqEJCtdZABx50fpj/Zl7dM2DYcLfVbp0V0sV6?=
 =?us-ascii?Q?bg7sbqw4coP6Y9sTlmOFhD/UTQWUFS3kZZjsM/Ro6Xk8BXmvBvR+qXrJa1HP?=
 =?us-ascii?Q?F4/Mx0avnZr/hnSY8Nzdd1M4k/XBSCAJQHVH979gt7yU7RYUHloG/A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jfE5GfwWNm3q6XVAfkH4/kV4iE+2g/+NwBQBwGUrnlPNKyYhcMRJeEkMRnEM?=
 =?us-ascii?Q?z68nRAcUoHYwKfS8fZwkLfwVfu9FS1De0kvYnI2Un+6MVd9/SjX9To6cQ+bI?=
 =?us-ascii?Q?kWf8mJ5KKKk5Js/PG6p9I5hyomFQoOrftUHDgy/DMF2eo5q7HR3jNJU79E16?=
 =?us-ascii?Q?FBWf1mfl3X4xfyIsSdc3/CSrCjncZzLU2Eb/HqyYfLIv65O3dtIFcvIJuC6W?=
 =?us-ascii?Q?BPYEx+ULOc/bY8mS4/8/MPDOZWMhVmda5WcWouW9Hr/XCl2QNg4Z94WfiB38?=
 =?us-ascii?Q?GBjMsLdjxYvSHiQPgDjj+tXkfiibIN8QH13Mr/6EdnHXhYE4y3pm5X4JbAdZ?=
 =?us-ascii?Q?XauURr3SadU5rCS1MjP1wMYWeHOiEreeJfpCSfttCLoPc1rsE0jXYBSZNXrG?=
 =?us-ascii?Q?7+yRx1XLal1WaPCNHiu1IvdGn213DtWK2H8wm5WVbQtHF+vubl5PeWVQlJZ3?=
 =?us-ascii?Q?+cXGad8LE7LFBpwxgfu54X6kIUDI3R7PDMYofIumYEsgSJW57LSQ7nb+RY4l?=
 =?us-ascii?Q?gswrXyafhUCltetVYCUx3AH+qLBSLCN/i66Pd5PqdEqd//hNPw5I9A+IPLjG?=
 =?us-ascii?Q?DKDkZ82rnLGHv4JFrj2/hrM0+o5vkL9tnE7F8BXSXtmG8J2xGPUm66unoz73?=
 =?us-ascii?Q?bX/iED9klhl6XVzhyTa9oW4Sb8spdvCuRy9kIuttxJyQhhNYbrDuKa8ZGsqr?=
 =?us-ascii?Q?7KS5rCHtWt719uvsTTJblky+Ej3tub2iUARg0oQj5d9qjOz8VKeO1RNpHVT9?=
 =?us-ascii?Q?WQHb+glFPYq41P3nqxTDB3sI1u91wyCAtXNeCP4nHuzKHIbwYW3PXsl0WGjE?=
 =?us-ascii?Q?diAm31WdqmD8zaMYPW3loL/KNPa942gXr8zD7LvoaFfPYL+Qb9J0DW2UPNIn?=
 =?us-ascii?Q?OKJJMnALEX8GDRkAMgtz2PEJEfz0xMd91t/CQwBc6tmR9U9P9WbpNCuBQpeG?=
 =?us-ascii?Q?UDyMqwPq1Sa002Iw8HyvjHti+jP5G6IkcizVPU8LUjxbg+5QytGrTvKtLyIF?=
 =?us-ascii?Q?sZXRnN3g6pgAJ1UGEHKFsODQyTd6IaLyCRkW6GzuabUJ3QwHMEzJvhB0B1CR?=
 =?us-ascii?Q?PC+gugRgUWpMxmAQCxFhz2VmKRDnNgMR+DyXjPWpywgmf1MMtLA787rsaHRu?=
 =?us-ascii?Q?4QM7dDDkwbDcYTmq9Wxg3/040JL4JI3RpXoWY3Mk7qv1NMLnc1aozjB1cJar?=
 =?us-ascii?Q?TSLI7T/TkIOfyYqpCey8dBvrlpK8N8RWklpV5/ObIgmRK7j+ddUVc0TzC/go?=
 =?us-ascii?Q?pejEkC8wWN/+eAtNJPj+xNpPZHm+r8D7MfMvsIe0PEMz1RrTdCliuP4uoXog?=
 =?us-ascii?Q?MBxrlfXXTEDpVt4zYjnfk6QKkk+GWBYswkUD/GYu6yCGZ/LhnxUVwKGmGmkP?=
 =?us-ascii?Q?Wyj1DzxXR4m0GOujhjdn+hL/PRH62VfL3L10K7/wEuc/XA0oMtJV3O40rhrb?=
 =?us-ascii?Q?sow9WJvWImbcmqJSDtvxucn2eF5p1yIMd4gn/6lwl6mgnDEklFytuvTVwyIL?=
 =?us-ascii?Q?O1es4OwL2rOsryADNzkKJwl1uK4aFolbNRmqJhAJxwku9daRT8iKQhcUv/7V?=
 =?us-ascii?Q?yedvV9b90rdkl+dyjogmUmdlT36Ya07Vsyb6hCo8GjhwAnTejsouV9HlKMEc?=
 =?us-ascii?Q?ualBMKzUb12ZqfGU4OarJNI=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e630f729-db02-4e41-d501-08ddec8ad477
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 14:45:17.3898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ba1zRAB0xhPHxGNfDtGf6vLmdpMLEFzJM0BSOIokxkOCANpr8kyYR7ZWbKYdfF3/j6MiL37NhqhbOUyzK+3pqW3tApupnQgQVeoVowpZNjLRm05z/53L/6g0FcgoVyTr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14067

Add runtime and system sleep power management operations to the RZ DMAC
driver. This enables proper handling of suspend and resume sequences,
including device reset and channel re-initialization, preparing the driver
for power state transitions.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 47 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index 4ab6076f5499e..d849e313a7f79 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -437,6 +437,24 @@ static int rz_dmac_xfer_desc(struct rz_dmac_chan *chan)
  * DMA engine operations
  */
 
+static int rz_dmac_chan_init_all(struct rz_dmac *dmac)
+{
+	unsigned int i;
+	int ret;
+
+	ret = pm_runtime_resume_and_get(dmac->dev);
+	if (ret < 0)
+		return ret;
+
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
+	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_8_15_COMMON_BASE + DCTRL);
+
+	for (i = 0; i < dmac->n_channels; i++)
+		rz_dmac_ch_writel(&dmac->channels[i], CHCTRL_DEFAULT, CHCTRL, 1);
+
+	return pm_runtime_put_sync(dmac->dev);
+}
+
 static int rz_dmac_alloc_chan_resources(struct dma_chan *chan)
 {
 	struct rz_dmac_chan *channel = to_rz_dmac_chan(chan);
@@ -1070,6 +1088,34 @@ static void rz_dmac_remove(struct platform_device *pdev)
 	platform_device_put(dmac->icu.pdev);
 }
 
+static int rz_dmac_suspend(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+
+	return reset_control_assert(dmac->rstc);
+}
+
+static int rz_dmac_resume(struct device *dev)
+{
+	struct rz_dmac *dmac = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(dmac->rstc);
+	if (ret)
+		return ret;
+
+	return rz_dmac_chan_init_all(dmac);
+}
+
+static const struct dev_pm_ops rz_dmac_pm_ops = {
+	/*
+	 * TODO for system sleep/resume:
+	 *   - Wait for the current transfer to complete and stop the device,
+	 *   - Resume transfers, if any.
+	 */
+	SYSTEM_SLEEP_PM_OPS(rz_dmac_suspend, rz_dmac_resume)
+};
+
 static const struct of_device_id of_rz_dmac_match[] = {
 	{ .compatible = "renesas,r9a09g057-dmac", },
 	{ .compatible = "renesas,rz-dmac", },
@@ -1079,6 +1125,7 @@ MODULE_DEVICE_TABLE(of, of_rz_dmac_match);
 
 static struct platform_driver rz_dmac_driver = {
 	.driver		= {
+		.pm	= pm_sleep_ptr(&rz_dmac_pm_ops),
 		.name	= "rz-dmac",
 		.of_match_table = of_rz_dmac_match,
 	},
-- 
2.43.0


