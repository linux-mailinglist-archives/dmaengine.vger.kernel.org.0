Return-Path: <dmaengine+bounces-2780-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E9F39459F3
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 10:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D156D1F25994
	for <lists+dmaengine@lfdr.de>; Fri,  2 Aug 2024 08:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65501BF32B;
	Fri,  2 Aug 2024 08:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VUhjbLoy"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2074.outbound.protection.outlook.com [40.92.19.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC1E1CAB3;
	Fri,  2 Aug 2024 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722587556; cv=fail; b=Hdkk+uvS/Q7wfetoQFhywMFdjrOtn5JaQt1RqWgFGOOpQ8D8sI5YhPW9PediV+dLHU9IKcQQa9U+M1MMxZ9pISveLjNHRalqXKaBZ+eH5l/AG046prLnH73dNCzEZY2SVsDtQzE5jwkBKI98taUKQ1PKfY4kCDHySNaWAE/7yoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722587556; c=relaxed/simple;
	bh=O0D5bQ0+LP3yBq/eF4DGlcTAEPaAI7TlXn+CVxKO+CY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pvNaSPrsLAUhNEGHJ5ang+j+g9giL+ypfio6fSlGI2n+PgKF+Ryc91hQXIJ88EN89SmPCidlDAjKZ+ig313sUZ+eG1UvD5/rszapOQixbiHsy1HGizgIAYyX6up6rjC86/HdaWUN8xxN7PrTP38pTSQUvQ2RaVauUt6xwC96mfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VUhjbLoy; arc=fail smtp.client-ip=40.92.19.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7IwuYOrkaUZxgGhVjL9sAs6ejuUrpoWBDE/U5BMdNVvM/oCtVSt3IWEneNtWar5489hLaDkdP8tVtJ7MMdvcg+YAICuK+ip84ISBrwXJC3IZhuMd92Js0OpcDzfjg/I44mtB+xG95FUPYo++EwK2ryx++kTWcHfsbAYBGzGbqDITs/YdEEbn2kvOV0QkdJHjJuifZTYWy/ztGgFBDHWilooWMP+w6uTjyjGsfP3y+/PiKwySpcY61FZbZV2kw/Xsu1ql1g25Nmmstut3mLY48NUDnjmgpMGncNVG3VNmXbJzhrOvbLZILO5hQ/QGmcoRsHmttNT6whM3ije+MRbQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/pextPI+wqNmLsc0K/svaxd7L0mRDUMAtpOQf+6CsfA=;
 b=qP5sUO72rUmPlRjW1/cJtngQOwLUL8JxaDtj74TpKhdXOv0A7Wgf2OdQme/ky3eMNCTBbiSdtPX0xgl8OJikVRPHje7oRgVhT9O/b1G5eC1nVpmtLy8dsT3NRrVcVhmwAAZNwu1j+mqQDtHhcjaz35reCoMNSrmfwEv0APplhojrTRwCDfRNSVkzcPCHBSM0biYAw+gXBimC9HuB8rM11qR2+63aStmq21/nTok51tM3oqhgfljdWFsTtugHjIWmH6WPb0bdSJNRbfwOvz8z5puAnitKZvasfgEuQMBegt9r2lShjRsmTtp8aWjAILso+T+rf6S7Rs90dGOyK2PKDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/pextPI+wqNmLsc0K/svaxd7L0mRDUMAtpOQf+6CsfA=;
 b=VUhjbLoy5sSpDSu2wOHNhhp+v9FkVvt5cY/11oJP7sZR/Jdss0oaKKhL7/2FXsO1dXq/Cm9EeUXYxV/hv/+6ptjx4Rj4YrEuBMWckpeRVM5vHNDiusXWe902v6OsXnsBw9oSxyNxqXJ/vslNvkvAvY1GyzAoIRXXYVZnqCzFgf1Ol56Bo8BdLcc1mpYpjDrSeZdp146lIq2AVfo3AypbzP7XVieXObcjjUTv8D3Wy6fvn2zlgbYiLfrpg6e3YO/sveGTei4f1+1HoSTkZIRo4GdEaccXkKshwwuVnNLkfhRAoeEnP5HGCNf+ACM1bCIz9uaPamB7HMNZGHtBsXnjDQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CH3PR20MB7441.namprd20.prod.outlook.com (2603:10b6:610:1e5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Fri, 2 Aug
 2024 08:32:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7828.023; Fri, 2 Aug 2024
 08:32:32 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v9 0/3] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Fri,  2 Aug 2024 16:31:59 +0800
Message-ID:
 <IA1PR20MB495332ACF71E3E8D631508B2BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [Y2GrmuNqxRsTNGpBW9QLSg4nEXt73RUWBAqnOVrJgvA=]
X-ClientProxiedBy: TY2PR06CA0023.apcprd06.prod.outlook.com
 (2603:1096:404:42::35) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240802083200.1286151-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CH3PR20MB7441:EE_
X-MS-Office365-Filtering-Correlation-Id: 87503412-5d33-409b-f8d5-08dcb2cda65d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	oxTy0w0jnPhmSFNEAZtJZOE2FLooTG0KBfthd1IyWaCgO06Xjz+IVAvNrFHYx3AdXsG4wZFCkY7Yl7CrQmFNrg4Y8UFR36YutmuLKOJvVr4lEjKGsH+XFPrFLDbwj9vlmOV5kJo7kOpQJfG6lyUiW25FujlfFMAmOxb6w/4u3ct5efFuL7ln3TmClm7XGF9aD097BoaViLDn+peZNBERPBfZ87ZcNLtr0XLssi9SuxfJLTAMZshxyzNFqeWeWF9k4Ye0hL2N1ecsDiTAm+XkXlAkuPscaVDOEo+/7YbOTPQ7ig33QspTbMIOg7xZwjcbGEFhI6pDjBuS/3gCOU2bh/y178yny9xBdvgRWV3nfkiA05jNo/V4H6mIMDymgkeqD/2Hu3crzWX5Yozr/ASq4Eh2cXHRL6iIKxxR4V3aQ6Q/jF6o/FkDMA9EL59WDatNL7+M3Ul5PhsINICoMDkI/PTaUKMl2sP6VqLmp7M4NZob6FEEfvDNX7XMMRYtBCnwnVYaTZNJbZCQ4LTiKrIgYFQOILbIIKFTOXDFyUlgeNtcGFJTNP93UL2+xon2VDvPnrw6tiWFMpF0hssy+YsbKMv1HFsv4cXI6A7n51P+Mh1P2E5qVoY2+9aMBc3iv1wg/PL527sOOoUrWKQq2+LCqQm4UXTr2y0u/F4DJU9Y4T9FatEnHpKn273uOvwBUPytqREp4z0Y8gIcg4L63pJ0zg==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EW83OqwYNNkOM+g1jUqxmbjydw9duqg5SUrOtPIqvBvBFQmpaSCQwM6DKS4Q?=
 =?us-ascii?Q?zTa4LaUuq618qGmRaJYP4uK3w5/6icXR1RjAzXboT6awvRrh4cPHf5lWVAz/?=
 =?us-ascii?Q?Ld1/QrF9DHXQGCPeP46EsZv4w0xnysCpN3panWaPl29tjr2H4C+XZ2PVsj7S?=
 =?us-ascii?Q?hCYdc73vq/O2hRUco5kcGO7I3Gh1QQuRiSvWgCG0Kc6HJn8NUXBYG9txDJ7i?=
 =?us-ascii?Q?aF/kpwXPR1BCz9wLvvjmvYoPbpzD35Mf5fTYlBckS2Pw529ajDiI4oCQwkNp?=
 =?us-ascii?Q?YL7ir+sTtSUlIZ0ab8gMG62/Dkx06lHC1QYGCB7KWGyFEQesDZeyvu8UWx0p?=
 =?us-ascii?Q?RGVJnOwk2STOEg4P5TVG4mdPcWKEVFSE3/V7oPa/zPKo2jBFXRRwAF2uix95?=
 =?us-ascii?Q?c1w6Nw+cewCUTN/fWG3QLO70gldjqnzZX8pzdTczLXH226VjF8etArVTxouH?=
 =?us-ascii?Q?k80fz9NFeiG1F8oSV0mxpw4DzxTwIIF9L7maqHLmcxSLi+cObfbUaOQcYrRy?=
 =?us-ascii?Q?h5B0Z6JIsKLg/kfd8fibQ1pnhK4Su/cBqFiIRiVOt9zsTCzwxW4eSl3oGVIK?=
 =?us-ascii?Q?Of5+hkG3dUHGRWohJazvA49GiX6XXUTayXlzPtSuF8lzNf3DlEXsgCuWKBFm?=
 =?us-ascii?Q?HyhsSulJGSWelR/PyvZFRtGvan8CUIsmi9yveYK2w0LoU/gt5ntcwGn+VO2Z?=
 =?us-ascii?Q?BiWtLBfgLDp9vv4NgzVBkTnhkZYNWw6Yn42/kMSO9OXsXiVjFbxWCpe4YZwi?=
 =?us-ascii?Q?2TUdcPjMDCH9zWsRPTXX+qtTX80NPQ3qlUeTZuw4SAq9GagXWcjZcuR6yzpT?=
 =?us-ascii?Q?0PmGQOUtR6RJLPQhYI2UshKN1Pd96N2+tzcOTqKpj5tw1RYjYG6/3AC1zSjh?=
 =?us-ascii?Q?DUc9odGSkNRREL5yhWLOqSFlFhAZG+uD/Vqm3/GI7zvBm9OPE+kRvrl0y9a9?=
 =?us-ascii?Q?IgfJjGnpjmY5FyWyi1TyP4atjaoWQDKdp1K8KYsiQHfiz8rBfpdRBpHLtiaN?=
 =?us-ascii?Q?/OdX+yHz9iN8VxGcveJLQ91fA8t7+KElPHIfR2deVJ5s3D8JhAOQ0qKAhFaO?=
 =?us-ascii?Q?VNieucSBUR5d2PNvYEKpGWuFQs0NSvD3owZ78KI4l66UwMuvaKWYOkiokjuh?=
 =?us-ascii?Q?HMK76h+7ahMn9kXnzuQtfpvEpt8eqTC+Vl7AZFgSTFSNb+OvnZCX/jOM0fTm?=
 =?us-ascii?Q?m1EoBKcvBthlalt1TpnmWoUdhwMqDwEE21OlkxwDTpD8QV2CAiaHRNFmGISL?=
 =?us-ascii?Q?mky+s7u9ALhCvh0bklhu?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87503412-5d33-409b-f8d5-08dcb2cda65d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2024 08:32:32.1533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR20MB7441

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

As the syscon device of CV1800 have a usb phy subdevices. The
binding of the syscon can not be complete without the usb phy
is finished. As a result, the binding of syscon is removed
and will be evolved in its original series after the usb phy
binding is fully explored.

Changed from v8:
1. change compatible name from cv1800-dmamux to cv1800b-dmamux
2. use guard to simpify spinlock process.

Changed from v7:
1. remove unused variable

Changed from v6:
1. fix copyright time.
2. driver only output mapping info in when debugging.
3. remove dma-master check in the driver init since the binding
always require it.

Changed from v5:
1. remove dead binding header.
2. make "reg" required so the syscon binding can have the same
example node of the dmamux binding.

Changed from v4:
1. remove the syscon binding since it can not be complete (still
lack some subdevices)
2. add reg description for the binding,
3. remove the fixed channel assign for dmamux binding
3. driver adopt to the binding change. Now the driver allocates all the
channel when initing and maps the request chan to the channel dynamicly.

Changed from v3:
1. fix dt-binding address issue.

Changed from v2:
1. add reg property of dmamux node in the binding of patch 2

Changed from v1:
1. fix wrong title of patch 2.

Inochi Amaoto (3):
  dt-bindings: dmaengine: Add dma multiplexer for CV18XX/SG200X series
    SoC
  soc/sophgo: add top sysctrl layout file for CV18XX/SG200X
  dmaengine: add driver for Sophgo CV18XX/SG200X dmamux

 .../bindings/dma/sophgo,cv1800-dmamux.yaml    |  51 ++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800-dmamux.c                   | 257 ++++++++++++++++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 ++
 5 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.46.0


