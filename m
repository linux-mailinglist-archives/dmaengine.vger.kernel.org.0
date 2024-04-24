Return-Path: <dmaengine+bounces-1947-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7558B0237
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 08:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A51F239A7
	for <lists+dmaengine@lfdr.de>; Wed, 24 Apr 2024 06:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33055157496;
	Wed, 24 Apr 2024 06:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="okP5igdW"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20318157490;
	Wed, 24 Apr 2024 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713940643; cv=fail; b=uMnKjeCoQKm4qQOTZDVgP3n2U4Ta7UyNOkdIgXxyDeOwoVhB4Jc9CMgPix+O1QlQPKk9GW/wVKd9H9njl2MNFZ7MQG6QlGhvm4kaCjudWnwsAkI3IgAZny5nrLDdBPg5h9kWHMD2/bRwWO0uWG42+VFWtmpDvAJkgn9G8PS+qTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713940643; c=relaxed/simple;
	bh=mpprf0b43IuOgoyYR3yyC2IvO3v6NwZZs38gWW2xwuY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Lw5VoFaGl9BGrdWKadL4GscGUrm6ioJXvzBPbWH3ag6JV3wW1FQdXVpwVvYk453U3g0IK+ahw4l6+c8WohOWpdxT7j27fM9mtN9bgil5U75MYYPlzRZR8hnXSkgxUUFcXy3PCb44vfn35eOdxr2J82SGzIPpVaJubZ9tVe5tguQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=okP5igdW; arc=fail smtp.client-ip=40.107.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SFfb6xHOWZRdxqBumrxE4wZagVPdv97spH3lG0v0AbGisadqLmxu0A3BKh/szKJbK1w5Z9DGMLRZbWFyqXr1h/IFm1vJRxXefars6wfmq1/RE/uw9hNXkb78ijTXV8JwklbS6SYOQ/pjlgpFMO4FhjSO1ZcmbFAV37ECA/zeqlyvOb3L7d9bKYssRn2aqcaTGsa4jlEdYa9hy39cGILct15DGNgNkdz8j8J7kCWPn8ZJKJhlRgJPMlGuMDCXapzDDKOlC5zTW+9bEnRoI6MbRaGJflYxA2SZxeTs6T5255/1czMXN375nGlA7FqlzzdGFF1X0D82MpMfOND9a/Ie3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOO3gdOAnKpZmh9cZKvrdRMt9hG2p1V674jPyPOZsIo=;
 b=my8JE9Fwm6LAVJlqyC4d00L/JftgrzNRCVOnuTC/8kOhSMwukdoe6UmxkVHJmYIUWFB3lptrzejF6bmFiS+yE2W6qK6S8XDdL/X/tGZz3ckYOLHUHBjHAbxwvFX26MDq73si+sAwOto9CXHQA7nmnlYR8aLkMZFrG0V3F1ms5KMRl+ue+1ZJUEDY9vg5DqhYsT6SOaZIEDd4PTb1rgrDnwAIwF5pGZe2ScTdizaamOe9KYC4PZ49LEJMECCA0KMz7e0Tdfh4svChzgYmJvJZXMNuI+jr24iZINJrYyHjmg+RZLffI0s3fQNGH1YeEaBgRU2faJAAw6kl89Jo7EVXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOO3gdOAnKpZmh9cZKvrdRMt9hG2p1V674jPyPOZsIo=;
 b=okP5igdWgtfANkhbDmcirQgvYCz/+g+Iww4JS1E4pEszC0EAz/yzjn4nN+Mk6p6KrDOz/HqhpVA5H/MloE/GoIUG8nJFQDpYZoXR/qgq4PLgW2LxdOMSciAWItPy2hHWQIyoUVQcM62Bw8XY5RuDqRWKlnPd3XWkiIdLOIkFZDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS4PR04MB9483.eurprd04.prod.outlook.com (2603:10a6:20b:4ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 06:37:17 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 06:37:17 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	peng.fan@nxp.com,
	vkoul@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v5 0/2] clean up unused "fsl,imx8qm-adma" compatible string
Date: Wed, 24 Apr 2024 14:45:06 +0800
Message-Id: <20240424064508.1886764-1-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0029.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::16)
 To AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AS4PR04MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: 26f934a1-0e9f-4d51-ffd8-08dc6428fc19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dwUVmUdCv8lR2V5V9a83DiAUnK3T5z2zAGkz8l3woDLjpOwFZyBoxexZzJkI?=
 =?us-ascii?Q?yIx68Txybl/z/D3ySYQCu2q/T0vC3wtbPimvwgnGxwxKpKXYqmiaZP5O4196?=
 =?us-ascii?Q?McZlbKHLw1sxpnhPwqScuWNnRNRwbIhPAWOtwu8kyKlW9OdQAZkGd+scxqli?=
 =?us-ascii?Q?dEIJ9mi7HNWE9QP1ySPtzKrDZMnKZUCidADQh7wKvJhc0pWV3UQASRLSMED/?=
 =?us-ascii?Q?h7hzkroJebDx8WcTH+BgXbOZkWbhJrbQtck2OqwAjWDlDKn26ZlfGwemlWEx?=
 =?us-ascii?Q?RGbofdYkjnUIOsVZKbPVRyBuAKJ4Qd1QPIzL6KEQ7OmWA6eLcq/HOgYevsBc?=
 =?us-ascii?Q?+O2NGDz4toqB2JlKZ2e1HE2WjXeMG/q4e1fjTIuLqArl601tZLH+4HskoJSg?=
 =?us-ascii?Q?ug91HEu1guFRt0F5Zyi3/Ti2SA9kA4HyZ7TbWPFeaUwCgVSccSOpAM69g1L7?=
 =?us-ascii?Q?ZTJ5L4lmZn1hGEFxEeH0jVS7UahPNcQjSeoCF4+5Ab4QeaoRCYKE5tZDQI+c?=
 =?us-ascii?Q?1G9xta7qfk4SiWeyoGHSjI5wJxajHG4r5Xs5Xtza6NN6Vvq46rR0VY/kqw7Q?=
 =?us-ascii?Q?cisi+0mK4wW5drm6VgNLKz6irneubUmiWqjIU1aKTwOw3evoL4JhPt8H/sBv?=
 =?us-ascii?Q?VcxTj0/fX5Gsy9vzts36sXs9cck9K8wz339ZLUfb+zGUc6W6NwbsFnDKbVqB?=
 =?us-ascii?Q?NG3UneX7T4pF4xP2g2JkqjzUoq3dYPkqDCd7svcXn1uOkWqD5oCDPp/wl8cc?=
 =?us-ascii?Q?doNjOYV5iXez3aWIHqkHrjDjw5Hb6gIzoglqEnSNG3brygFzcUujR6WupXqf?=
 =?us-ascii?Q?W94eREOlGz5M25Og7TqOS2y3nAONG1CE4Vfy96THCXuxelTfHTZafkI0oi53?=
 =?us-ascii?Q?Cc87IPFOPyhCB10mEh13xPZiWbNtpbxCJHVEnmpvPRVgOeaMXa2DnEo9fhqh?=
 =?us-ascii?Q?dT6BKuxTf4tGtY0F3BgMi9e0Si02xK+48xgbhZOw+9UJ5GecI3S0hsFbHDDR?=
 =?us-ascii?Q?VTc2TMtpLluqPJkSboYTGTRQ+zOuppmkbm1aZFCk0xlHIhrSq+Tnit2v/LyK?=
 =?us-ascii?Q?WMPCcOjXe+60eZpIG5P7vqgmZK0ZHT8bvluw0QfNdQ2UZpBKIQm0RPbbvvak?=
 =?us-ascii?Q?Ofqc4PQ9oraCBsPoR84pPlfmsfBgmODklp0pnu1/zgZVfNJW3q+KQy0Ncwls?=
 =?us-ascii?Q?4kBeiBPiIAuO+pIzO5qsVHcczCgrReN3WIZoRT4XOn14CX827dhblWb2bV7r?=
 =?us-ascii?Q?AIENjBZASSWqUcHKoo6tnsdYd557biMhmUTtHgAeHGnjBY90ZFpeT9XtK27X?=
 =?us-ascii?Q?+b9UTfZ4w3NlxGgZv7IyBaLq3lskhV5mcmQmEufYNh+ndw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7EmFFuJBTEXP8NH++S5hpF/1xNvS1PlQ7QA/cu+bRcx1PtJrzk/Fpks8UWXc?=
 =?us-ascii?Q?G8idHJR2Yr598aJoReBik4iEmmZtZYecMZsk9DzKnMxwp9FbmJVvmkVWyRJw?=
 =?us-ascii?Q?Mjfd8IA1Voj4uHUYJwZOpYl4IFx0Y6qF0Ph7syFm9tUfcbsAdIc8GJ7ZxNac?=
 =?us-ascii?Q?UTKpntJ8SmVtLmsQjWVhl4DAsqQ8h7n2NZSM9Rza2CAgN8ZgeWcIFefk+dD5?=
 =?us-ascii?Q?4ChR5VhN8uGwQnH1G1khcFEb1SyVdYqy3MDMsLdLgvVSKGloy8ag3VemThNS?=
 =?us-ascii?Q?lIXCLuotPI45iKB3MrWiBip/rdGPyGEEHuqximJCtE6D2bKlMHq7N5jn8qsZ?=
 =?us-ascii?Q?mm2QHo4ydYlpod/2/S5XdtbKAIeYPCFwJ6zue9WpMTzFuro6FLc+u0tuBDDb?=
 =?us-ascii?Q?LGGEe04hRzJz+W8NoLfR0EnsOu0U+Y5Ar/YhTvC6PZSrH/LwznmeDkj2mA/P?=
 =?us-ascii?Q?OJQUbiK+elm0+D2nMZ1q1Npv7YPTMJGTXTsXjBIU56RDzqhcY85xzPew3Ip5?=
 =?us-ascii?Q?LGzCvoHsuIw+5AkIxU7sdFRSUGgcpTUCjBgYkfDvK44W2pekpQ1CbRHKlwJW?=
 =?us-ascii?Q?69x4ybMrwjBqUkWkRen8ZMFJDGLHfvGBAGPo6fds9NH8O+hAN6KebQ5Ruklq?=
 =?us-ascii?Q?1jbbe4V+xSmmgvCzYuku3nremG/GJIwqzYKvvwPVsmv35p73ooB+DOBkAB7B?=
 =?us-ascii?Q?XDDnBeq2lZ824pNIrP7AvVCJ0lo2Z5sfiAQjIkeAfCxMja+/zX1fWEJ0ZQNP?=
 =?us-ascii?Q?r296O/AmVnRkGfQ+V1QumYzXcbWEpfl/2BzsVBfx2wY+tMvlhabSVJGqsFR6?=
 =?us-ascii?Q?iR+cZ0ceL7RjAPbCZyQIdq1hqJ7nIqX72kuQ/kISPvh8TOgTRp61Hi5xAJfs?=
 =?us-ascii?Q?wgKJU9vVMQig26YHG4puFq4KQ2QUvSK6XkPFl8EAkHQn3l6i6GGMVFGighml?=
 =?us-ascii?Q?grmFngXowPDg9YUtpw8zt4uEJh3IsYE8FvLO9kC1Ueu4Un8c3HcPnJWrPW5l?=
 =?us-ascii?Q?hx37KDQxenFA4s7w1N3yqfXJTppyr/ddDHFIH2YYCoowqODmRo5OXAJdSPv0?=
 =?us-ascii?Q?+cmPRD10Jqmlronu4YsCp3N2uJl2PnQdzDCf0CQBQtt4C9kzw7/RsxPoV3H3?=
 =?us-ascii?Q?zKuzOoTVaAPScxGqSypnBuubq08SdA8a3VwwfWBppxT1SgdAuJcOvaIP/blV?=
 =?us-ascii?Q?vOFy733BtW9VoEhafwyR3Br6IHRkTAMEFnDSnXKxVUyKvWfFk4xauG70c0dH?=
 =?us-ascii?Q?aBbhrfG8YqAhFE7wCj3pxP6AugB1MbO+6FehoifhURuvpBMKiSM/TTNhhmNo?=
 =?us-ascii?Q?nsYNzblfLpzkdLtmu08WJPyyx1NIM7mez2fiPcq/K69iMQO9kaPsFLuSj41K?=
 =?us-ascii?Q?usPU9TpP88F/iJvqjdljrLfmSIRtsYG5gIfmPPmknGVnmH+ZUS/IAAr9F4fU?=
 =?us-ascii?Q?RZxOQxsBgaK1k/IH8TR4FDckY/70oVPD7DnqMJcj2k+eL0hMhKU2vQ0XcXgD?=
 =?us-ascii?Q?E+HXrTG1TKQg6E+au5yikK60imN/BmvHblc2rxhbOYnmUbphIRI4u4Nv5jcG?=
 =?us-ascii?Q?nthty9Ozg+Z31u4sk2INdhgpRoOitmoexfDml3H6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26f934a1-0e9f-4d51-ffd8-08dc6428fc19
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 06:37:17.3953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yn5jwl9VJpBaixezwMIMf6b49DS0tyrHnzSUwsIoOLZzxSDgXOfPsZErXpmlMD8V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9483

The patchset clean up "fsl,imx8qm-adma" compatible string.
For the details, please check the patch commit log.

---
Changes for v5:
1. remove remove FSL_EDMA_DRV_QUIRK_SWAPPED in fsl-edma-common.h.
2. modify the bindings patch commit message and add review tag.

Changes for v4:
1. change patch subject.

Changes for v3:
1. add more description for dt-bindings patch commit message.
2. remove the unused compatible string "fsl,imx8qm-adma" from allOf property.

Changes for v2:
1. Change the patchset subject.
2. Add bindings update.

Joy Zou (2):
  dmaengine: fsl-edma: clean up unused "fsl,imx8qm-adma" compatible
    string
  dt-bindings: fsl-dma: fsl-edma: clean up unused "fsl,imx8qm-adma"
    compatible string

 .../devicetree/bindings/dma/fsl,edma.yaml        |  2 --
 drivers/dma/fsl-edma-common.c                    | 16 ++++------------
 drivers/dma/fsl-edma-common.h                    |  2 --
 drivers/dma/fsl-edma-main.c                      |  8 --------
 4 files changed, 4 insertions(+), 24 deletions(-)

-- 
2.37.1


