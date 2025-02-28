Return-Path: <dmaengine+bounces-4594-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE1FA49205
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 08:18:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1B43B4677
	for <lists+dmaengine@lfdr.de>; Fri, 28 Feb 2025 07:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A01C3C1D;
	Fri, 28 Feb 2025 07:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N8F1jYKA"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2047.outbound.protection.outlook.com [40.107.20.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26D71C3C15;
	Fri, 28 Feb 2025 07:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740727126; cv=fail; b=X9zNYW6n7FfLSKEtn9CCY+dl6M2FAPD8IuYkR6HU9DA0wLxnVTPqgIPbEqjvegooBeV99AdPOxEsejer4XlhU4qxRWhtcnesJKcp5kz987ZJpFj7qLq/Ysqpmmw4hsRohW8w/Ed34bHfBBlwDAkurlUBu7DeFiUgF9q6685uU14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740727126; c=relaxed/simple;
	bh=AIjEW1iuHqLDuYIZZXKS/1ogA3leukZcjC1fGuw6X8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uRZl/lVn914K30lty1I1REhS+g9dY4df4CDDrKx8dC3FtXDfCcrE1oHvZaGXiGZhNCaRclhsLnWfXN2+km1Z8qcOUgI09ovKhT7fSVgJGRJMqe0LaT/WaTCqAGa8VTcKh3EEeFB2vqn2Jn/TCahuvcHHtRF8N2CUOSZEhclG8mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=N8F1jYKA; arc=fail smtp.client-ip=40.107.20.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7F56sEB5D5igsKAnm79vzZkE6EBVFVxBk+/e7fW7ydRJWAZcRDZNd70+/fpU0MHbMpB/PoXsAdxhduee/icZxhPwHD7tEI5qsKY/4i79b/modHVMi0QiwUhANJxxAZh6qwk5lU2bckYwtQ/RH1JypRil/8GIyX6bitT+uMAUn5GrMs1afON971w2tKo7+xjuFWAC8eyt/GVrD+5oFIF0pGU3fLrnNhKrUGWSRZrKqdamyyukSX1OMMXNfOyyj3VwmF09hpEZiDKzuqJ6oXbW/BWT9vO1O6tLbuJK1coZMgqTT9dArFHM8QAjpwuCQVITfswOy7l89kg/Nh4VVe16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dO/gQByDYvHjvuAd2hY6MBjjuxO8dNknTOFPvkLcpHg=;
 b=X+DUpfSWFaTrafehEsTLcj97ghL5dJCi25aC2v4GiWWTwa/sBiIX4L4g8nWzL39LW7M0I0pwkF8gbRA9oq//wG2o6gFH4wzoHuakLuOjslzv7vhCQZSjpJ2RapJrYlP8H3TjGNwjb4btJAoR07twsWglCHLH07nWcVAjaZgPruon+rBiF48G8HECovTSO9o3UR1ZYoJzJa7jYYtQFjCRM87AL5Xmur0QWXVjwYRGxOMKCoy43ytc5h7Rz4VY5AFzs9JDQJGR2+FqGulP1LDaA61XyPCP4YhB+lFr3crtJpF7OBdmHSb3VcQqr812PA29BR3OAjDXx3WpAdnJG3CNdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dO/gQByDYvHjvuAd2hY6MBjjuxO8dNknTOFPvkLcpHg=;
 b=N8F1jYKAVxaYkT+5tWwLXiWH1IU89SUgbA8lcS1wdYJ/NUJEKdYbtk2rtZkSB9R5U28rdnK4Dae+wG9TPe+lwwonR1SW6aaawpIN63y91SfiE2TBIC4W8EMaYuUlHQMaZ6OpU8/I+K1kgK1fOLd3YGi1kix3ltLgmbob95n+aSq56JQFwFKfVMvMCWmHZxki9qL3fW+0HfGbfvPsXrlTMDPe/f9pNNc6UbI59Hrp3p5BVq3JokHDhuQXU6fhh/5CGgGdEYfYIglTzuHg6S0w2TCpXTOv+nD66LJjnuSlMo/6/MRlTCqmP7NI7YIKX9MbTgYG9TsFG15uSplJP0xmUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8511.eurprd04.prod.outlook.com (2603:10a6:102:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Fri, 28 Feb
 2025 07:18:42 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8466.013; Fri, 28 Feb 2025
 07:18:42 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: Frank.Li@nxp.com,
	vkoul@kernel.org
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 RESEND 2/2] dmaengine: fsl-edma: free irq correctly in remove path
Date: Fri, 28 Feb 2025 15:17:20 +0800
Message-Id: <20250228071720.3780479-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250228071720.3780479-1-peng.fan@oss.nxp.com>
References: <20250228071720.3780479-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: 85ef61f4-b40d-415e-080c-08dd57c8215b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hfEVdZ1BIz8ztaqpuuRFwU1/qe+VGei0XjMZ4gsTJK6iovdBl2UL8ZRqRoNq?=
 =?us-ascii?Q?7P8LT3pO4zDZOQpvG4znVlh3AGWfFpfl3otueWbA3E1n2ip9sWWmqlFfTaaU?=
 =?us-ascii?Q?5jeFFQUPTz9eREwl+D45gK5uVgXvoY6DCg14fCiu8y+h6zCQb/42rD5D7GgN?=
 =?us-ascii?Q?DmzkvmBkvCWkBXUgdj09WM599yHvrFyyaNDHmuiOZYCtu3sauYvx1Fanl6hV?=
 =?us-ascii?Q?Ybv6UzhI9buZr4HOsUaDv7OYhEnGbLWVffj8PVHJ2wUnaLmbujDgURyn7AGc?=
 =?us-ascii?Q?HQKoGuaeokVEsIzkh159/+vuLqTcWUjig8B0UV688aCRMlkh7Nm3bHqAEKFq?=
 =?us-ascii?Q?eLNBUJ7GrGsaScAGngu24R7KZ319EIRTYBA6quvD4suz4w8w+YBRkqp5af6k?=
 =?us-ascii?Q?In7vVR1oKDwNhc+TWE/27BGFTeoUzBtuQk+xw+Ho3ux0DK0hx95X0SWG9La1?=
 =?us-ascii?Q?lyosHN77Y0AfBuARYZKNIbz4HQmge61Yn23Hu83FGIyIG9WyjmjfT4bNRoaf?=
 =?us-ascii?Q?56NpmiG2DOI/oosM/mdKBE9+5O7y5KkT09dEoZOQ5uZDjBkRH6heFnsnu5Mk?=
 =?us-ascii?Q?1wOnU/Qqb/hOMx0imo299NzcRqMK9L3DdVbjAt5KGM9ZvaBBeIhZIv1IdO7j?=
 =?us-ascii?Q?pzBP6f9noeXfDpc7qTUvS8SeJ3WJMArsRvQbGWM5Q311vX5bX46cDmWYBgMh?=
 =?us-ascii?Q?fwX59BGBOUph8qkbaRhehsT/rE3mii6+LAzxL2q7o2Nh+tlI7eWX6RclyLrl?=
 =?us-ascii?Q?KzdcC3lIWZOgIud5BGQ39DOv3ULg0vhRG6DNz71B4E0zD3/Cz/rDFhPcjfCx?=
 =?us-ascii?Q?ctgGSXhLnJmfQ5n+N2khok0Pn+kTuybolggjbk+ph9YGFPnZtzCLXDiZBgmC?=
 =?us-ascii?Q?zfc+GqsYvDQWl1YsCguyIODEZeCU3av5NLZfkNVbHok6XyrQNWE5YCdQ6NxZ?=
 =?us-ascii?Q?FJazeE46RrC1fpHIZe3IAdoxn174muareaSjR1ALzkAdUqLjmx3Sy2zJpwvc?=
 =?us-ascii?Q?NiBxcAOUokX7nOuSLgU7TKCxxQ2jihM9OOLcbq4ySNFyTZb2r44Z4sqywmit?=
 =?us-ascii?Q?wL9BB5/OgtcZ/XUd8iwWLdicBSzjezLtEjSJwo5HHOUBrTQdUwX2RJMF+dAO?=
 =?us-ascii?Q?ahFQY+azpsObHU29yFqCv+YJWdzpWS1HBz/Fn9GGyF2v3JKyEaXNM7JHFekH?=
 =?us-ascii?Q?jyl+wxcXf009bPX4g6WWT/3ItJeR2/uVr8tmzqXwcOJrIW7fxQ6tHEZIUXuS?=
 =?us-ascii?Q?v50QMqwy4XdN2YQupoS50ZyHB6BrqGk2Ok+1KzltFFjeS/8OqLm3cZg36Re6?=
 =?us-ascii?Q?pgrn4Kn7DhWjGUj6qb3v9Hl7+9KyzeS7x5D5wOFUe0HT8rmuiX7VlM9Ad5/C?=
 =?us-ascii?Q?rM3sv7VjpAR4SrPItXuqM9b8trrOC+XruWFk7rR8SVgr41BZWauNj99yRoTl?=
 =?us-ascii?Q?X0uzOFH/sEHfVFdS2M5O4hSaFXO8dKQ0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UiUbvcLrC6o+s72kXgHljbp8ds7MJoZ96H1UNVe0z0Dg29KCp3zOqrrKoizR?=
 =?us-ascii?Q?3Q8DrZJHugCtH3IURRybMmHvYJ3CzTwo15WIoMiufXmemahO6KGu75/vKDY9?=
 =?us-ascii?Q?jsOgTkoF1vlrNvX9SpVoW13BjyFV0V/jxUyM3DEqcrO1JuWS1j1cYZ0GIK5F?=
 =?us-ascii?Q?gEN+wvcWcO+e8kUaFfdC4tbDNLJC9hcU2isSTEqRtnY77/HwM5abQGoRpxwX?=
 =?us-ascii?Q?LGsL2otNxthYxfWghDtvNCdLPxCg/tXSrhVuh9ok8HhhVJhdxYtcvJkCrrla?=
 =?us-ascii?Q?DR//5l/DEvh//5qUjNKXR5KaMdh2LBcRrzgTrXodVSoB5NqViX1J3BpEFXLR?=
 =?us-ascii?Q?mUDMgfRgGk1TF4Kygfn4fBpdp1dpzO7jDEcSNXuq91u5NLJkrYEuKzx3vfJP?=
 =?us-ascii?Q?OiV7fLI5pkmRbzsHSaiYxSVsAphW3ifM61zqh6FpAOEQf+9TG4TKd3tq4onR?=
 =?us-ascii?Q?U9/HaDSxZ96hPzOUlWlgjfb3s2wusW5XZGKqbEWilUU2RCIiGsh52PbDgDQX?=
 =?us-ascii?Q?pobWU7b8+9dM4R0ZVkX0+DVoBcgLlHcjTV5nPnBbYrroKxiW0s/9rLARXIzo?=
 =?us-ascii?Q?FCqlvg4jy36uhXXLCWVikwIuKv00l8GXjjYrO67MpVWlUTEFD2T5P5lhLmu8?=
 =?us-ascii?Q?OAuaW9DKK5iqnV/khRIcpySUs5WCABvu7e/TlCaYrC0BkFz38FxGxxUIJfvr?=
 =?us-ascii?Q?WUdc/PUOEtq4oc8oYGwxEYzIXK4F2eSF40xukVagA1W0LIcM6eWLhyKAe9uz?=
 =?us-ascii?Q?jQk9j/gdkQYLFEzmJgMFe47sWvf6/bLOTCbYbfS/hU+S/LukIq8RfJZ8Si/U?=
 =?us-ascii?Q?EmNu+aCka8lCat28SHP9CXAKSLNvs+jVh2m64w4OSovcNQayymC97Q6FGSeh?=
 =?us-ascii?Q?rIRFM0akGMoPbqNGULQXe1hu1GoAY5YBxf7BAiMoM9w6syo7211FL/9XMnYA?=
 =?us-ascii?Q?Dmje8SrIn9vCPnCPaGYFoZIPqW3tPkO7bS2vEGphhg3zrd4zV9YkiaDDzvYw?=
 =?us-ascii?Q?+4h7Hfd44GXBHZa/dUIHIfuRAE0qopRl63haKlf8cyl0eKl8UDN7xkYRhsp+?=
 =?us-ascii?Q?KXjWPE5xNXszZDgPFUoYSV3XMX33f9xi2YU/DYU1z56aXoxFU10v5blpRiQv?=
 =?us-ascii?Q?75hMudxuwEXvX8LBYjRrpmB7yui/FlqP3s1Kg0BbxTB8xu54faKuGX3wreo9?=
 =?us-ascii?Q?26BTg8cxd5xrfVzdbphpHT8E5OktNtj7n/Iobn1EpcVb/rthIA0jcHnhrXbI?=
 =?us-ascii?Q?MaS9yurK/h7yS4epktPdj3Msp8BZlGXureEzlLSy22Q7alFl+q45B9Ff68Cz?=
 =?us-ascii?Q?aA4zenlE+0d+9jsA10bsaPSHEOtJGPxjZ1K5lFTaXWKT65ZiVpubVx+Ue8sM?=
 =?us-ascii?Q?nzwyWkDHnsq5DtuQZ4EIQzfJzawvnzB0m6+D0mNc2ovF8ibNrzx1oG1HBeIv?=
 =?us-ascii?Q?QhaSaMl4vf3Vg0O+X2NO4ioJ4OwRIV/srjjNYMzCoGQAuOe5vtJSGM00fX0q?=
 =?us-ascii?Q?C3t7N4COr3Gy3ckthManny7s6O1zgS9nxi5inRUjyOH70bP4bdHL4Lq0AqUf?=
 =?us-ascii?Q?ICujBf+k9ZTFsE5gnuHkKor9ieUSKf/m67aCKBf8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ef61f4-b40d-415e-080c-08dd57c8215b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 07:18:42.3615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WvnP4yiaxQYg8LKQ0nIs29imPbZhtRvZ3ulFwRDZzwLlblIl8PmxveCjzq3qR8esqiO2oGaP/qJv3s9YvqbMig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8511

From: Peng Fan <peng.fan@nxp.com>

Add fsl_edma->txirq/errirq check to avoid below warning because no
errirq at i.MX9 platform. Otherwise there will be kernel dump:
WARNING: CPU: 0 PID: 11 at kernel/irq/devres.c:144 devm_free_irq+0x74/0x80
Modules linked in:
CPU: 0 UID: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.12.0-rc7#18
Hardware name: NXP i.MX93 11X11 EVK board (DT)
Workqueue: events_unbound deferred_probe_work_func
pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : devm_free_irq+0x74/0x80
lr : devm_free_irq+0x48/0x80
Call trace:
 devm_free_irq+0x74/0x80 (P)
 devm_free_irq+0x48/0x80 (L)
 fsl_edma_remove+0xc4/0xc8
 platform_remove+0x28/0x44
 device_remove+0x4c/0x80

Fixes: 44eb827264de ("dmaengine: fsl-edma: request per-channel IRQ only when channel is allocated")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V4:
 Update commit log per Frank
 Add R-b
V3:
 Update commit log
V2:
 None


 drivers/dma/fsl-edma-main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 7eb4d898434b..756d67325db5 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -401,6 +401,7 @@ fsl_edma2_irq_init(struct platform_device *pdev,
 
 		/* The last IRQ is for eDMA err */
 		if (i == count - 1) {
+			fsl_edma->errirq = irq;
 			ret = devm_request_irq(&pdev->dev, irq,
 						fsl_edma_err_handler,
 						0, "eDMA2-ERR", fsl_edma);
@@ -420,10 +421,13 @@ static void fsl_edma_irq_exit(
 		struct platform_device *pdev, struct fsl_edma_engine *fsl_edma)
 {
 	if (fsl_edma->txirq == fsl_edma->errirq) {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
 	} else {
-		devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
-		devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
+		if (fsl_edma->txirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->txirq, fsl_edma);
+		if (fsl_edma->errirq >= 0)
+			devm_free_irq(&pdev->dev, fsl_edma->errirq, fsl_edma);
 	}
 }
 
@@ -620,6 +624,8 @@ static int fsl_edma_probe(struct platform_device *pdev)
 	if (!fsl_edma)
 		return -ENOMEM;
 
+	fsl_edma->errirq = -EINVAL;
+	fsl_edma->txirq = -EINVAL;
 	fsl_edma->drvdata = drvdata;
 	fsl_edma->n_chans = chans;
 	mutex_init(&fsl_edma->fsl_edma_mutex);
-- 
2.37.1


