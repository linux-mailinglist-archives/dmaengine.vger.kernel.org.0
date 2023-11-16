Return-Path: <dmaengine+bounces-119-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382D97EE936
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 23:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6B72280F9E
	for <lists+dmaengine@lfdr.de>; Thu, 16 Nov 2023 22:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5DD2C851;
	Thu, 16 Nov 2023 22:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FxoG5pqx"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2040.outbound.protection.outlook.com [40.107.13.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4350B9;
	Thu, 16 Nov 2023 14:28:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwDwkPuI3FEZ5pjnC1usMetC5J4OnCoNCrL2+FE2Yj2y2VmlrK3t3VEvdjda5NJCS4OVfheb75GvBCUZo2B+8shi6iik6ff8EjJIZFNIP00uACMVygxk9k6OJkH6hvLCvMK3YNNaMueXMVpns4LDjji9gjCd8w7hCtG/fgmoczpFotdfi4WlpMmIlMCtSh7Ra3TusnhCc+8XFzGoQo5smQ+T/xgqkgw3+rGeaWdn+MUN7HpXT6fleGJy+e/SElx+bFWCxVG0tWXmLxxc8hL/0G33UtTRbgbV7JqnYtbB90ZeEngjUnSTiFEwRFXlWccykPxm24Ma6OiGfMYuYbhyeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GOqp2hX+xz1yu312sraVbtYWLD9796KDcven75a2Zd4=;
 b=BK4wLF7HHYkZJH2OWwue5YeGYAup7+OdEURoRZgaQcg0B4fv0ECj6vgI2/a6LahyZLHzg0GDLZAf1D1c3TLAqVVipQH4dn4jPf2AD4Wc45jspYBaBERbt/28AvdnPEXNHlbx0ONvXS4+2fNmyN1+xZZJH75tu3ifbyJnFvGM9R+phQv+ox0vccJzhtZaWz7OXkyVr7yy9D0yzupof+4fYPt5QRS/KhSs5iHJ3/QQjs97tawSjl/tsCt5+2qJxelNgCx8CXAUtZSrhluYpvdh9tcXL1ncWbVSPcqedijHMxAbfUncqtnbmAhqfB833kR8W1uNMNM/iRr0aQ7vhw4q7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GOqp2hX+xz1yu312sraVbtYWLD9796KDcven75a2Zd4=;
 b=FxoG5pqxWmX4ZJ/c1WElkI8QhFGJJx+Dwid3txFzRNq92tv4X5KanPAcNTh1KvdvLRPtWA5UFUJyh+l/H+OVzskp9S1XtObb6Ce7QvJZxACSVFIOraTsaxm7d5dOJHSwLepQAPKaJkPlED5qv9664414q95VExyej4v7M1Jl/N8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8857.eurprd04.prod.outlook.com (2603:10a6:20b:408::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Thu, 16 Nov
 2023 22:28:01 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::c048:114f:b7c2:7dcf%3]) with mapi id 15.20.7025.007; Thu, 16 Nov 2023
 22:28:01 +0000
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
Subject: [PATCH v2 0/5] dmaengine: fsl-edma: integrate TCD64 support for 64bit physical address
Date: Thu, 16 Nov 2023 17:27:38 -0500
Message-Id: <20231116222743.2984776-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR02CA0071.namprd02.prod.outlook.com
 (2603:10b6:a03:54::48) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8857:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a81dff-e38a-45e4-21a6-08dbe6f34adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9i/7yDaUm1iX38bxkXIosZL6TYTqsi9a39WTbov1+GxV43SPz+X1TTCv39WFvciJF9LI7ywoF79H5tkPmgpabegzps3s1WYrBFc71K+KgYmJPUd8K8r+UsGurykwNZLqaul9XYzGQzeC+Fxzl9K/zBFNOoOcp5UX9VYxxQ2APOgWeB9s1ATmOnFtriO+ZA0LuwH9s0/aLb8PmV8D27I1Gpb576HzQPW/XNVSX4ALFFlO8YSy2uHx7d2FNgUXRDnVoURjt2MSu+/oNffYjgog7+SKbdMnAnmy4lsaSjbTfTTUXoqFZxYQtthntLdxt1CflpSpy6XTM7iedrpEdxGjSZytfbMF8sGe9KifWq5AVCYoyrhu1caH00nomHGiWRTx/8d1DCpUCBffyMz6tQOpnK6R4BBaZxOywwHU32frNDsFqsDHJey0v3ku5ifwAJ8Xq5x8o43JfjxpiKVedvrG/eIXfFz4FSDRDxfwGhE7yfFOMna2BDUb7bYACuwzfto7v7CC/aVYPJ2C05UF5hc0WK8T4YIJt07zlDB58r1EDWERMUjQ4zfRom19oOrt8gv2PmfIXc8BiWAbqC3c1/B19k2wVYMcKEya/mf0M+XLIrNgR1hHe0RUTBTxQJ7ck8z8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(6486002)(478600001)(6666004)(2906002)(2616005)(6506007)(5660300002)(52116002)(86362001)(8676002)(4326008)(8936002)(4744005)(6512007)(66476007)(66946007)(66556008)(316002)(41300700001)(83380400001)(38100700002)(26005)(36756003)(38350700005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6FMh6BZqCCKHprcwe9+fRfK+6gF3LUHqq9sSRQTChO+0FOJ4FO+YjZtTm63T?=
 =?us-ascii?Q?WtGlTnR8SkTVidQEzJprzXb70I4w9HfE9BcEJCeHmwLILe+2ZcGbZX0dWnw9?=
 =?us-ascii?Q?aj79KeG7djijpDvmjSuX9KTMyRd2pvahyORuhj5Qa2hytAtZDgJKLEpkde2p?=
 =?us-ascii?Q?CFOQ8RlSZJumcaNFbFQIuZkuRApA2+hUO6VwzCP7ig0nb+LCak9375g4iDN4?=
 =?us-ascii?Q?6DBiEyF8wUFsm7Q3ynnurSaxO+chjEAzKbiRN4QVMsIEP7LnQIjIMNViPqGk?=
 =?us-ascii?Q?QAFLGJpM8k3RzfftIQHGHcOh7kUAAAuYh72KD3DzsZpg6ciJ+J9WxCFFU4H6?=
 =?us-ascii?Q?LyZr/U+9dKGHiUFWYl955a+P47chP9ir0MbJnGR+PYgcfOsvRxCqL03w7/1S?=
 =?us-ascii?Q?Aj86TlDVj71FO8uNdp3irFnAcaI9QsFfqUflbg+7ZLxHFkBHWmAMULSnbZFt?=
 =?us-ascii?Q?O7rClsnU9HHVXmtnLMGLVJ9dyn0eRKkedCTLyorGEvudWqRo8G6xlSOlqtnz?=
 =?us-ascii?Q?yQGeDJQTJtJfRNW7XnWg4O0iSK9EN9AWGQg3mXcAVIjPwdUqTIvf2olVKK9h?=
 =?us-ascii?Q?qRZyCYKCi/tMCA5MV+Z3qmswFTaNUwMEHTvSKMdDv2yT62zotlv1orSmPF0Z?=
 =?us-ascii?Q?BYaNOnZnfxH7WLA0SWH5QrbWnNclAqbvug5GhWM6C4ziUU17w3fTydUsPJfS?=
 =?us-ascii?Q?pcKw3LiBYecABVGNvdAinS3Byow3D5HAYkqunnNYJ3w6S8DD4h1AiK5Ovw6B?=
 =?us-ascii?Q?lbPgTAdwa/pGkwb4r3w7jrssZU7Vqb5ERPH4T3FjIdNu4m+hxgXdeyfs7RpM?=
 =?us-ascii?Q?b2Rk6hdJjjORkbv95UvuUrJCcHZwzXXeqGG3mId8k9JScgLK9j/TBlB+9yVj?=
 =?us-ascii?Q?iHiepE4F6tGAQXrC2XSuxN7uSUBknYCoXcrFlG0/iZxNfHjjx5uu7cclO20i?=
 =?us-ascii?Q?SubaQwRaJL3V0T2+DQ4kkx+vXmVXMX3j8XTinTWa3nJGLHlCtD+ueTkpRmS/?=
 =?us-ascii?Q?ggAaeReAQW11TV24Z8/VSrNPLNnT0uOwZ0X6bXQ85lg6O9mSouNCX2JpuPML?=
 =?us-ascii?Q?EvD0xStMRvqR9r4pxbhXd7MobBlEicJufrC2Cox9OCL2RWi17iyo33evNtCA?=
 =?us-ascii?Q?l4hyBJMTh02OVBQOeHdPr8BWr2T0gzynpWCGyP5ONJDW9x0vFMhsA1jiJYrQ?=
 =?us-ascii?Q?MBIefXwgxG40X92zL7VPB/yDS2uHue261cOhxm7z3Xv7+UjvVL0rlz+rh75m?=
 =?us-ascii?Q?31E6TY/s057d6YXmRg9K34WV8ZuH7eYPWUPbA7X54cbFAGJNBrLloISvToaz?=
 =?us-ascii?Q?i81azNEhsfQ/0LyA4Pa4ZkgQIEt5VzWjJ4NfJT+j0+KJHgleK57faUvs6Pn0?=
 =?us-ascii?Q?5xAOZJuGcw787fFhpMe6B9xqal4MM3WoYTGx5kec/y0rMBN+v8RZziPLGALu?=
 =?us-ascii?Q?DTahaH/mL6XKxT+zQkMQbsUvlaCyOBCRrdE9lifUYurGz/WGznZZPHu+ILxL?=
 =?us-ascii?Q?RuA0SEfDjLQF4VOQpQcHeTfMFnJ62sluYhvL+GJB6p7GnSyN6kQcAtCPqQ6F?=
 =?us-ascii?Q?KZ8o4ZqRE9KBXa/sbXnpuVLWjrJKd04MFuQADbJj?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a81dff-e38a-45e4-21a6-08dbe6f34adc
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 22:28:01.3748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6yP2zqaoSwEF5P8BAnloue7MoQLSK80mbCup5x2S2w8eCa6LTZCRFVIqiuLeDXTRrpncpi99meFe+H2IDXDd3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8857

Change from v1 to v2:
- fixed mcf-edma-main.c build error.
- fixed readq build error. readq actually is not atomic read in imx95.
So split to two ioread32\iowrite32.
  It needs read at least twice to avoid lower 32 bit part wrap during read
up 32bit part.

first 2 patch is prepare, No function change.
3rd patch is dt-bind doc
4rd patch is actuall support TCD64

Frank Li (5):
  dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
  dmaengine: fsl-edma: add address for channel mux register in
    fsl_edma_chan
  dmaengine: mcf-edma: force type conversion for TCD pointer
  dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
  dmaengine: fsl-edma: integrate TCD64 support for i.MX95

 .../devicetree/bindings/dma/fsl,edma.yaml     |   2 +
 drivers/dma/fsl-edma-common.c                 | 101 +++++++------
 drivers/dma/fsl-edma-common.h                 | 134 ++++++++++++++++--
 drivers/dma/fsl-edma-main.c                   |  17 +++
 drivers/dma/mcf-edma-main.c                   |   2 +-
 5 files changed, 198 insertions(+), 58 deletions(-)

-- 
2.34.1


