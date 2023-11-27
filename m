Return-Path: <dmaengine+bounces-266-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B857FADBD
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 23:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21098281B80
	for <lists+dmaengine@lfdr.de>; Mon, 27 Nov 2023 22:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCDA48CCE;
	Mon, 27 Nov 2023 22:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mUI3vVoD"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe1e::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82A5137;
	Mon, 27 Nov 2023 14:56:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1vbf0wFqCOArSnjrevm5Srgy4ZxWn0YX0/aPkgQQ6X5qCbPFRawS9QoSDlTbscNpVZ3qUTTz/VJuJbM+k5JgnqH/D0oSEbfP5ZLaH5E5RyL803VvmRj+EcPkhov8355Oe/yNqk8ONb4oNctvjubNMZUDkMC8XiR6EwPRxtaLwkcoS1qcyiWx7RR80Prr8Xq+LYsIID/C7qowJezJppjEdzjhNhRGOFfk+N+THZ9KQ/UWHkyVwsVLfR6Xk8bgv12awWHgr296hSWLgVMlcyfkh3cqSn8tMkDhQdxJiFsx6wP7epeiqa6CACJojUJDLHRODPpL4cgi1oZkggszeRiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TyvZDVlie6UETphNaN3YSjifx3N56AINGHECLDutGwc=;
 b=JLYu8vfrUORRPjmF/hHoX/RdIpSbibSTq236KBOOD5quYUrv0lpejpywryv6/AeDff55p+s/vBrQZseNdLlyc8Z1QbM1lpZR8zx2WcVp+SCZ7byqdOgm2beK/C0mrWNInxPzgBQFHviCG1c94xVvq1nRogwPifFMn5AUrRpu9qrrlxJbrAD0Y2RsPNHLGZAe4kGKR47fi6qOgsuCdEOuFQd121FML/1GKQ6qWpo9A/Da0zRQPb5TSsLWacvmgBTihkf75wrFWf+jZlowidQhHIkgaqjo7w/r0l0akq2SYXwqFqILubxJDiMXmPtppWG/l4/F7qZ2lr6Xij8+zQfGxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TyvZDVlie6UETphNaN3YSjifx3N56AINGHECLDutGwc=;
 b=mUI3vVoDu4y6olgQY4wjqJHQjLhdEmBUDzPHwbHAc3ARcYWgJz5eZfVjcybEGN/JFLqx1GcFWidvwGBoXf1VqZmxh0dD+8iHeOofXI9KWBgOOETUtH9L3NSJqfxxzq3/uECTB0K9xqFd7kr98inZ6MuTLhmNZNiXG2ZBJuozjqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM8PR04MB7858.eurprd04.prod.outlook.com (2603:10a6:20b:237::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.21; Mon, 27 Nov
 2023 22:56:00 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7046.015; Mon, 27 Nov 2023
 22:56:00 +0000
From: Frank Li <Frank.Li@nxp.com>
To: frank.li@nxp.com,
	vkoul@kernel.org
Cc: devicetree@vger.kernel.org,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org,
	linux-kernel@vger.kernel.org,
	peng.fan@nxp.com,
	robh+dt@kernel.org,
	shenwei.wang@nxp.com
Subject: [PATCH v3 0/6] dmaengine: fsl-edma: integrate TCD64 support for 64bit physical address
Date: Mon, 27 Nov 2023 17:55:36 -0500
Message-Id: <20231127225542.2744711-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0116.namprd05.prod.outlook.com
 (2603:10b6:a03:334::31) To VI1PR04MB4845.eurprd04.prod.outlook.com
 (2603:10a6:803:51::30)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM8PR04MB7858:EE_
X-MS-Office365-Filtering-Correlation-Id: e9f251ad-22b8-4199-06f9-08dbef9c0583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zXNdoPMGhbgGZZGms4+ZGd9gjxeWGDaq62t+IGB3Fz2GpKxfuSeRKxxGWvY2FBCdMY9lmAi7GfFYfnlvny0chGoLexq37FEDFPyGfzRtYy3lhiWMwPph50XBagicOOb51KFfg1jUKUoKvYgu4pTT9IjxHZXvSqAVW3xl/KeXE9P26sonVaWGsruTjJDr7eF6a4LetaUzjqxKAgq8i7LHIbNlBik8606nY4QMiKiSfBF9j9uu6STxWkZhFAoAD8GpkTFziFpovIWtFCSXvgANmlXTjfCn2pqwmzcsAZM10Qx5oeD4Mxi7nyWl+on0le6yq4yRqnsAYMwCIrMSTnMMraCgw6AcfohgJNWaVCof1QbP+K4x3dJ+6anFK3hU0N2p+6XZYUg6JXXWAFUu+mVcAR+RNsWdH//E4LANNvN+EjYbMakWNorn4FnR6vq77FKj7Gn9YOfOERK8Ev/NUJ4tW9Hwze9K6i30rFKswM8F+2EPA1F7mebxCOXggROFCB9S++w+PHis6ukWCfTr6cX+8pGXv/uGw7UYqubr2gkknHnB8IUhLQXfMrlS34b9++c4uctqVg8f1Cbqf8oeeAf1poopvSB7g7bV4FiveQcm9roAghFktOTOKlWVEhsxY9IsrhkMj+Cq5Rp3qgBSKeIczweM+Dud3nm8VksTtWoguHA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(366004)(376002)(230173577357003)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2616005)(26005)(1076003)(6666004)(6506007)(8676002)(52116002)(4326008)(8936002)(6486002)(86362001)(5660300002)(478600001)(316002)(66946007)(66476007)(66556008)(38100700002)(83380400001)(6512007)(38350700005)(2906002)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xp0Dac0v9JTJtG4H2CRP8WRbIG544GNjirM7yhYDyM94KnMOT6VGu0/aOn2J?=
 =?us-ascii?Q?Aao/AdLu79fiIBHktS/jKAFtY5lh0MxVMYXPjQoo3bx7VcG9s+WZZOj9Jln3?=
 =?us-ascii?Q?cIrstQWwyOQQAHr4IfJv0tyGFHIDSMqXAy5PWZCoYd39ed1R/hvND1JpTw9T?=
 =?us-ascii?Q?N1b07ims6jHOrKp6T3RizU/ZHlvuekD6gkUo8B2Zxd3npnkzyfo/lG/f1WfT?=
 =?us-ascii?Q?99S4ubYyHlh5bo4GwDrtXdDKk+XaOB7UDTVy1Vrfz3BR/OXBOn6UyrwP956R?=
 =?us-ascii?Q?wTMsXTfRb+Kw587d5YZy/2N2Cf+Ut4bOyOlAXvtp/5msNdUT5cPiZa6aw7Ga?=
 =?us-ascii?Q?8a6dYiml5/ikYBEVNki2AmEwAEXsxFLqCRDOUOEv5cRcnFI/YMKCiC9fFDHd?=
 =?us-ascii?Q?fUkV72M0tu5xicmdyZJBMtZndKcLP0/VjXWxEghqPfiqpNTPVvPW7LS9eZyE?=
 =?us-ascii?Q?lsqW+ehwd+cb84nOcdkKNguGotIc5DZkOREHzlg0feoS+xvcckNkXzhdSJRc?=
 =?us-ascii?Q?KMxGItxaFUT9satJMBWJ82W4LKWkZgbN0rCCWrOa5J6tTjYRI76u1DoAOm+L?=
 =?us-ascii?Q?IeLLZhLM6oYPRQ0RaleXFro0X87v0wUy/Z5zs8A3VmHR3zUs7Rk+vB19fOwx?=
 =?us-ascii?Q?V5bOqECWY7hyNLw+lgU9can7GJ/yAsWb/Gq0vaGusdLW/9cI1eup0i8E+w84?=
 =?us-ascii?Q?oRQ2J70bJmFG8LON33GO8TXYxI6TMDxJhCQ0OGf2uTcEbI8NoHtw0V4RNW8w?=
 =?us-ascii?Q?tKY0dI7bfHHm17G2m2c5MlxzJCiQ9aOD+Aq6J/rRXqfU9IF7wCNk3kj+aGcI?=
 =?us-ascii?Q?oulyke4x24yuty5A7OFn9HY+y5sLqiEXDbhqbiACYkdKgbhvOaCVG1VfTQr6?=
 =?us-ascii?Q?1jwNlSy3Xp48vqKsNactJCzIAUEQYyuF33C8aWUVmRa7DBUPst4JGUhsF8jU?=
 =?us-ascii?Q?fX7HmnglhBcXVoBVIv4AhLC6yloIEJolKE1ebKqCQGYKx3pGm/l10MVJbgTq?=
 =?us-ascii?Q?WhYBDDEEmQJucFnt3D41cKtADfulp07Liw23dhcpgxiYKbM6t3AyvAG3+Vcn?=
 =?us-ascii?Q?7K2jyY98LeFDC3gAtjrm8jCtcgouFRAWqt6WpxiX61fcyo0W1m+Gr8No8Zhu?=
 =?us-ascii?Q?0soplFAKBJwbh1YVBVUNDMI55xUGpL/5upS4bWV/MPBryOte0+lYoy4ChdAB?=
 =?us-ascii?Q?/biKqQ5jZwBPBPPRxM20a1Y3XDw8pX1nNi1+GURzaM7cjhB9OC+6+hhIeVLL?=
 =?us-ascii?Q?VWkMzzr3/W8uXO0jZtwsnE/uWVs2pi9BqTqH8RqCbMBXBft3zXWRQm7kxKLc?=
 =?us-ascii?Q?H4gox2tLvzLliBJG0v9V5JCgUmFkV0jTgUr7+cwlPaSxEpp7JV423mLBACSl?=
 =?us-ascii?Q?LD3tJ2gw6Z1zGUIS8oQLqsv2VT9pEtlR9GHr73zKj/UDiZZ0vuXnGgr1+V9V?=
 =?us-ascii?Q?saaf55Cutuvumm5oglOS6K8EwoGJssiSpyjTRwTDk9mQ5qaKWnQAFeWIXcO2?=
 =?us-ascii?Q?9OZQVPk2WKbgmpzhUZqpolPiNTbOg/FE4hoMcAQy7NfmadgT6L0zIhXWFSfn?=
 =?us-ascii?Q?pPLmZy6M5Q1eZaVoQII=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9f251ad-22b8-4199-06f9-08dbef9c0583
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4845.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 22:56:00.0649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hoauu8BklMOMlJjCbNxAqLsqNQD2vMwwK4Q3txChSMQxHe5fJlOFv0wttKAJW/L9x/jHDMwdPUtZ8/2m5XD/VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7858

Change from v2 to v3:
 - fix sparse build warning

Change from v1 to v2:
- fixed mcf-edma-main.c build error.
- fixed readq build error. readq actually is not atomic read in imx95.
So split to two ioread32\iowrite32.
  It needs read at least twice to avoid lower 32 bit part wrap during read
up 32bit part.

first 2 patch is prepare, No function change.
3rd patch is dt-bind doc
4rd patch is actuall support TCD64

Frank Li (6):
  dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
  dmaengine: fsl-edma: fix spare build warning
  dmaengine: fsl-edma: add address for channel mux register in
    fsl_edma_chan
  dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
  dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
  dmaengine: fsl-edma: integrate TCD64 support for i.MX95

 .../devicetree/bindings/dma/fsl,edma.yaml     |   2 +
 drivers/dma/fsl-edma-common.c                 | 101 ++++++-----
 drivers/dma/fsl-edma-common.h                 | 161 ++++++++++++++++--
 drivers/dma/fsl-edma-main.c                   |  19 ++-
 drivers/dma/mcf-edma-main.c                   |   2 +-
 5 files changed, 223 insertions(+), 62 deletions(-)

-- 
2.34.1


