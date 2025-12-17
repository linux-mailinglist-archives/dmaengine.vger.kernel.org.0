Return-Path: <dmaengine+bounces-7771-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7C0CC88F9
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 16:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B901B31FD5C4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 15:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A1933FE27;
	Wed, 17 Dec 2025 15:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FpYbeuan"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C9B31A56B;
	Wed, 17 Dec 2025 15:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984662; cv=fail; b=ak/wYOlsWwwXwHBrAqdzCuy+83wVybcoAxGRLKkf3Hbf6UBrbFku2KWZv9+TlsqsBCiEfO0f1BJMNwgaPMB3WqVrz+toEtN/PozUOCzEkBKjB9ICf4AbcF1y3meFYSKMGC3JjpTtg6tHtwhXGnCsPT7nHrSobT7LkPTVhz2t3xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984662; c=relaxed/simple;
	bh=pcMvzx+ypf03MqbD/g3qJhWZzoaKKlK3H/UYlz1XWHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QevF+coYCs6eYJAjUZguAMyLGDEJu/FfiVTcNXZgbpigIz5mtpWImKxJ3DDGt+v4VfrbNI1TZX7AUDJNnJr4k7Aq9Js+1rVYWfP69qzF5NN8cfbt80LW2ANTu67zl2Ao1idxE83fSgKVYrfgtfnKaNhE+yOqKba8NVmIfwh4KDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FpYbeuan; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fT/FtZUhis9OXA7SFMIcxPXuq6RRY6l5Eut99Vimhb3NUp+KdbCT5uWBwRlx82yirLG2xsYSmApbIPws7D0OWzL7gy82w/k+XoI7PDUNdA7c+tebg6tC9TfVHptrmDuauguA1Ayrz1y0loZquF8FlMQcG6nHUd7/lsyXncFmn2F/I7bG7j/DQoJeR07ByLVUPCV7YsaTng4xyBFyh4EemkhZxuWCgYets1+WRWKU7ZcCdYtn6AZa2ZK7eNEHsZRs9zmV7drRoLR2GkkrVHahxDF0BKuTWH4Y3UziAYzeuF2gIQKmyxjmVLu7A3LXMettFZkOqeg2XDr4TkBKVOAidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Y0lLodyJucNadOovaGYXyFEz6UX4NrVKsR5R8tKTW4=;
 b=zHxPsAXfwc7l3n9azi03NQpD2tDwS/4KxEsWjfZ4FY6R6sZD6gdCY08WM3WzJfYkyw4ZTQ7Bue+nHpPBSjGP+hH+vqKqlBdSAPG5rBeUW3NxzLTeehhcGanJxPrHy4yfXDRgzx3/XeunFxdY1bhe3YDalLBNo91tqCgIEJSYNCexK+fzkEeTMG9Kw4KYbpua3N7hvlU1yoKzDRD551VBWawLw8NzFSV0D3EkFFGEmqhKhf1Zv+/jd6ERIzjzW+5FIvNkSfded5fDIqCs39GVeb7wFsFiRXWVmcylKJtUQ/YtLkiLp0oaxwNZh6zJE9MpSXFqoougnyvNMzyNmvM42A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Y0lLodyJucNadOovaGYXyFEz6UX4NrVKsR5R8tKTW4=;
 b=FpYbeuan2twGH2i/RxeBU0lzFjKNKuCa2tp5XosvBx9jTVrganrdu7QACgpoexBF7sJvDKWiAL8JpM76ER3Ckr/lbcM5ZNvsjO6YZ54GivL0oqGgbqCcDAG67YK+TymVZc9m2ZSBhWNqJf3ypVskO758rN5uwAI8kmxIZbVCFkw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:32 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:32 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Frank.Li@nxp.com,
	dave.jiang@intel.com,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	jdmason@kudzu.us,
	allenbh@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	utkarsh02t@gmail.com,
	jbrunet@baylibre.com,
	dlemoal@kernel.org,
	arnd@arndb.de,
	elfring@users.sourceforge.net,
	den@valinux.co.jp
Subject: [RFC PATCH v3 21/35] dmaengine: dw-edma: Add a helper to retrieve LL (Linked List) region
Date: Thu, 18 Dec 2025 00:15:55 +0900
Message-ID: <20251217151609.3162665-22-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0162.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::20) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: 640e0a5f-0bfc-4c83-1f32-08de3d7f42cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MW7qLq2hrNTLj0ywH/dwFeSjYnhQnK+wP0NRAjtnGZrO4Ma9Brr4dsgYGPnE?=
 =?us-ascii?Q?UVNXjabi85wy2SZx8A8TmOxqIuZOPesmYwO3kMYYVY4xw5sH4fbxYgAxhNoG?=
 =?us-ascii?Q?/k5br4mWYXzOU2gZ5+57Wk0VW1XVXIhPn6OhZCQMlL2urSIreyiL3F4U+9HY?=
 =?us-ascii?Q?vurmTBPiNv7a9/uLk00Ssjew4NZDKOSG+pOJSQWNFZA+6V2RO4S1vbmdMmzY?=
 =?us-ascii?Q?Nxz8Spr4P+xh0IhjbzeiBvCsLlt6Pgkiql3nXBkqlKwpp6rVIeN2QqR8q323?=
 =?us-ascii?Q?tX1VpKbq2x7P1ry5bKLgXzTXozFqLzt95zMGFbNvF1l+zBMhJIhNLT6SOT06?=
 =?us-ascii?Q?izJkaHDw81ZwtS+qxanzLsbPYZ0niD0Zn4wdNCPncSGpbuqx2oc1MSkqN6/f?=
 =?us-ascii?Q?2SlaVgZrr54fNzGpoHabzUtAipEC39Fu2DqXQ0Vc+P6Y/5Rye37za/zlezYL?=
 =?us-ascii?Q?TMPvkw7He8PQkUsE6OapCeCUfA1JKYv1DZ5ej4mxeFYOueAQEXYiRxjHi0s7?=
 =?us-ascii?Q?eH5NzYkEp76hBwsQWQ4CYVzvM+YesCWSzzvAladdBttd9zXKASE65RbwzAlt?=
 =?us-ascii?Q?Dehwsop875iWsIAYfQNvET0d4RmnYyW55qGewe+jH3jT39NntrElovRPJU7N?=
 =?us-ascii?Q?jXdA31+PH0ZO35+dFb7ACMQAxWvwqkq4gGXlrMYB8I4RONevz5AgE9e2+6/o?=
 =?us-ascii?Q?PjhKYVFZmZFT67IiPpiSWSatCD7ErWtCf4+hXPgernxtxP2qotly20XBykOY?=
 =?us-ascii?Q?sdZM2xEmxd8wXDH7PymAOW+z5ixzNnF8RjrIxg1AzKGrcazcW+Aoekutaimp?=
 =?us-ascii?Q?9PlwesI2cEaiU+by6BZG3gxMCuyyW8uwch0bPjQIaF/+dymL7FeCT9wFaLwS?=
 =?us-ascii?Q?lXc21U+12Vm1nPDxroFaTXGtRcY2V+RTc9lqgCGXITyy/QYJ8PeypvyFMaGN?=
 =?us-ascii?Q?9gA8cszVO31BpTntkLWVFGTbF1824VOuZwy41oRv5OAJE4sbTYlT0KP8/+th?=
 =?us-ascii?Q?BzST7rT27UobXKMqVnVx42v930Iy8gqnggI0nmETb3jw8OpVypNUm2kVv87N?=
 =?us-ascii?Q?21gM1Yu2P3L3VpAz3grBJYURuDXkD2Hmnw3D9yLkyJIY5CBYkui6Jk+PBZpR?=
 =?us-ascii?Q?2hSYfRtvR5jToy/cKFqly1GyF7A5qjR6vS4KmmEhdpht0uyBtK3X+f0sJkVu?=
 =?us-ascii?Q?ffwXK02Xl7AfcA62xLCk/xFNbeLpDxJGOgvMAz/SDo/kNzInIvZ6WBYBdqIa?=
 =?us-ascii?Q?+BZmxELRNEiEQkj4uHeBVB2w0RNIS8h0hT+p3I4zxfYNhnrO1Yg8ZsCdFvsg?=
 =?us-ascii?Q?n3ctgvcUsoF3oFiXMiYujSnfFx2S90/jXvFe3zj6qyxq3B8Ol0n6ic6qnStV?=
 =?us-ascii?Q?iRxVTFIWrRbpfHXtbYqkGVd+H9j1Ah+X+fDPkOb5qWP/KmbcNkS7JI1xvhbe?=
 =?us-ascii?Q?ICrPyVvA8kA7C4jMFf8wF13PQ6q/0K5s?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FtKN8dz2dwKqsM0SmZklErhiJPH/7jKUW0sjCffYq5V8b4TTuRCoLgqhneHY?=
 =?us-ascii?Q?ruvq6B99uMbJuDkfy8oOAww5LRqM4t2E92aJUDSDkBq8799/na0vYaNLDMHv?=
 =?us-ascii?Q?uizOAYTB1PcKjh7jW54mAHPAhcopfCDzGTRjzwQXdv3RRUEHegVOT7zMTRNV?=
 =?us-ascii?Q?gcdqWIlXahXFDKo/5gNoX73Opt6xaNDGBqBhvWMcyyUMhWmV8RLyIvqM2YOa?=
 =?us-ascii?Q?iHcXxkd4aBL8wzD0jW8P0WMr/2l065dwoMS/g31JlqTTKV8l4P9ps0YY7MYd?=
 =?us-ascii?Q?L5PPZwwTCYtirVQrRytlSfK1t46v3bkfAr0fLI2kQLfKqNUvhKy3tFUEcDzw?=
 =?us-ascii?Q?hZcn+QAxPSoEeS/LLt2gW4ZhG+LBWS6QghbM8VxyzOtjyt3GuCB4NG0Bip1c?=
 =?us-ascii?Q?6L8yW9nsk+1vT1p1lDyjGMiN9wNp6shOT8nLfyhwPDH10KaLdoPCXBjjQv6R?=
 =?us-ascii?Q?KBvP6Q9GPhfs6PtOB26DPXRY8/CycVPc+NyS0yP/Eaf0YQa24xs2TrbKpWkG?=
 =?us-ascii?Q?nPeSa3iZeHwqMCpR0We7Fdqh1Kxa45Ag6NwgN6GWmNuDPpBJcoJV5UDmqNOg?=
 =?us-ascii?Q?u3qt0ZQfp1bymmUzbpT47n2Snkuig2kctvnvsxEZHic3gephiclyzLWq7HLg?=
 =?us-ascii?Q?mdwv9FBui0g+CCPt1GXls+iokQg+/wRw5hqFbm+spRwSngubR303urMqfsPh?=
 =?us-ascii?Q?kKq5cLMz2KLL5n5SDhqq8MjhtKPhrXtZAH2mlefI8rRWytCS+vaNLJIeh1H1?=
 =?us-ascii?Q?knYR4qA/+XOdcCvLeNUX0wWs9pfbtmsg6VGbvyNjcTqL0MUHCNtMUD6OPqiy?=
 =?us-ascii?Q?y9tA7hciE0B4HfbKSoiLvAh+pqNDkX+DwXDikiwx0m/YGtCoPNerkkYXGMDl?=
 =?us-ascii?Q?+yc75orHDqgPJGVcebXZaN98v37dKcRLjGusoVfRVQEUDFr/DdelkIif0c7G?=
 =?us-ascii?Q?O8GaNCwxUjIO2vqtB6GGDLDAzW/YIsP4lNqB/b4ZcIMU1FIioC0ct5hcfuza?=
 =?us-ascii?Q?m1/YaWngkZzi2Dwq5kNCtFODPA8rn6QGUH7uQMkx1rVj4yRHKil+Wz4L81q/?=
 =?us-ascii?Q?wpKDiTu+p0/r8lYk6NnQdajnRQqlv4rkUykrqhBzWT7JU7tK8KKNjqm+wEk3?=
 =?us-ascii?Q?0omgLEv1mA7ZoNdoiShCkBiCk4AQKnGV9VEt905a/A91en46jJi79l0Xvt2B?=
 =?us-ascii?Q?rM7tCOW90zqIaEj0DiInm5zuJokVYUD+pOrANyaLzMV5i2rjQY0IP/mhIDJs?=
 =?us-ascii?Q?OxRqfvo/8jSYQJadw2UPQl0TWggW6gYcVuEnTFQcVO1XJjHl8Lyz3aT2HS7y?=
 =?us-ascii?Q?EsaOncJjA3tVvJ4GbwlcH1K6e685OqYzF3NESLMwlndYwYIsCV2fOI+/8jX/?=
 =?us-ascii?Q?HnAkN78n7O+5x5FOZELHKjN4wcCJb99TmQOJQviY/8bQquH5r0Y5GR6Q6x9S?=
 =?us-ascii?Q?3kEMzWkq2xIbCgd+o/18/ARTV1457/pPsv0xV1YAixMkXu+APo0+RUoBht8j?=
 =?us-ascii?Q?FVDqh0afqn6QUQT18ddHb2eUo2hWSuHKNCqmBp6HgnUawx158wpELKyeSkZ8?=
 =?us-ascii?Q?ld0ouFhX4zYoZhSb51v4nRILJcJpktC8izu2FMCgfEjdvJhF/QpcQz/wPTpF?=
 =?us-ascii?Q?+or04S6ACe7XM12Rk5touUU=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 640e0a5f-0bfc-4c83-1f32-08de3d7f42cb
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:32.4810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7+kQa4SoP83wi9Vb0MywI6p2r73U22a2EE7GsK80R8jKxYPd7YXcCWbriWK9J0XA3aULoXjPzOZ0CDSyAMsbYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Remote eDMA users may want to know LL memory region addresses that were
configured perhaps on boot time by SoC glue driver, so that those
regions can later be exposed to the remote host side, who will run
dw_edma_probe() to configure remote eDMA.

Export a helper to query the LL region associated with a dma_chan.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c | 27 +++++++++++++++++++++++++++
 include/linux/dma/edma.h           | 14 ++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 8e262f61f02d..77f523f40038 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -1203,6 +1203,33 @@ int dw_edma_chan_register_notify(struct dma_chan *dchan,
 }
 EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
 
+int dw_edma_chan_get_ll_region(struct dma_chan *dchan,
+			       struct dw_edma_region *region)
+{
+	struct dw_edma_chip *chip;
+	struct dw_edma_chan *chan;
+
+	if (!dchan || !region || !dchan->device ||
+	    dchan->device->device_prep_slave_sg_config != dw_edma_device_prep_slave_sg_config)
+		return -ENODEV;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (!chan)
+		return -ENODEV;
+
+	chip = chan->dw->chip;
+	if (!(chip->flags & DW_EDMA_CHIP_LOCAL))
+		return -EINVAL;
+
+	if (chan->dir == EDMA_DIR_WRITE)
+		*region = chip->ll_region_wr[chan->id];
+	else
+		*region = chip->ll_region_rd[chan->id];
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_get_ll_region);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 4caf5cc5c368..1f40e027fa56 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -110,6 +110,15 @@ int dw_edma_chan_register_notify(struct dma_chan *chan,
 				 void (*cb)(struct dma_chan *chan, void *user),
 				 void *user);
 
+/**
+ * dw_edma_chan_get_ll_region - get linked list (LL) memory for a dma_chan
+ * @chan: the target DMA channel
+ * @region: output parameter returning the corresponding LL region
+ */
+int dw_edma_chan_get_ll_region(struct dma_chan *chan,
+			       struct dw_edma_region *region);
+
+
 #if IS_REACHABLE(CONFIG_PCIE_DW)
 /**
  * dw_edma_get_reg_window - get eDMA register base and size
@@ -207,6 +216,11 @@ static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
 {
 	return -ENODEV;
 }
+static inline int dw_edma_chan_get_ll_region(struct dma_chan *chan,
+					     struct dw_edma_region *region)
+{
+	return -EINVAL;
+}
 #endif
 
 #endif /* _DW_EDMA_H */
-- 
2.51.0


