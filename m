Return-Path: <dmaengine+bounces-2841-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1C994E009
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 07:16:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0483A1F21603
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 05:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFD814AA9;
	Sun, 11 Aug 2024 05:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hM3yQmhc"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2010.outbound.protection.outlook.com [40.92.20.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38081C6A1;
	Sun, 11 Aug 2024 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723353372; cv=fail; b=rScVF+Ii5nMgfLUaqlaKOCKLFXTOquF1dEma/dugqDDZSfok4W6vekVwCXKQiwWwmcHV5qR/hfMnplH8R8YhcOO7wnDofl+lF4TVRXZvSvU/3VO9PTUCuA/gqpTDn91aa+0NQ+Me/CYrAf68L3Fu244bF+ex4Whm0+2Af4x39gI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723353372; c=relaxed/simple;
	bh=b1jPrAGiv28taOXHpYcEJ0PS5JdpeonjjYnNNoBeSgM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j/QPPvQ8itJDkqlyMV+jscacEp2uxhVKxW7C1n80Ye3EFL32NCZxurQcR6QMaa3iIHlImxSayNRY+xwKBxgPVRwyZUEXmcPqVDxhCI2Q2MFaHchasShrO2soplcj+gdzWJsAooHPKa/TgfS3dfxVN+eLMobGYdRUmY0rgxYuYBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hM3yQmhc; arc=fail smtp.client-ip=40.92.20.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lw8zZ7ucIAEsGUdd7HttfFB9y9zbgx6veGVY1b1Ia+SmR2ut4aNuEjsbaREr6gS1ipmitRyKMlQ1zxwInDqF6iKzOIMrDhJ+SOymubIykwzddYCfjou5BDDOT8ZkV5UQkg9oo52Gid3VdohAspHynhrnH0VvyRZ5KKAkMln9YaSmTUazivtcjsm37wU2XftMdvAfhxxmRYUsKIwN2F3vQrDMjRPsjmAuswbEeo3COfxVP/p/wKYsElVH72sCQqFEdHQc5fuYAZ9+YLH+5q4IyAdzn9yKLO55tukwzDzY/M37iyrag3roQSVeqZ9Hzz+IfIyFXRRDoPrFoqdoMi98Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/9Q+2e2zlu86X1dsJGt5xuNIl4U2iduEN0DBouPOQg=;
 b=a4Sv62NkFxx5w1bTw6HqHBpWAIqlYkQXxEIv6kPNN1wDmMSnvMrypLJTbigVallzzdMTbqvWbG5xIxam9LulvX1FrBqC5d0pEQQfWyXXLBQcFM3l04CvjWqrHhUbDQUEuauHhSXruzvkepyWmmZ4Ycri5ee+H4zl6Zxo2/gWvGsAdvyP3lXpIbiYDJ/7f10lXhBlOpU2xWXeqIs003SOr5FfqXgxKjsLel6JOj9vjwqWKiA0pky89du/BOB/pDOaW+6fc8JQLLqwMpqVjDwg2B9mvMUZ1SRgrrthawHMRRGK9tnSJBKVg6S5G9H+wmyFDTowsT/7ZTwJf8MK6xp+Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/9Q+2e2zlu86X1dsJGt5xuNIl4U2iduEN0DBouPOQg=;
 b=hM3yQmhcpPoWhmmj1/vJsxWjVETcqb39bxtoyGi6+uaMo5CjKhRVgPVs4Vj3eS26YiSWPpeURKfzd7kd/MQX9F3f8dmFTjsiEA1oTtHw76iFFohjZD1vuy1m3JBxseIYzATxnyTfxl1s3y4ikx9k0xQc+gKiWeaYrTMLV3Yx9rBMhy+RcbVDi77sPyjsOADn5tt5z2cdaKDgSrtl7ZUZplqE2iiiD1FxAby1SmuHWfD2GVYdcwPHn3biIrE5QO7UyzYYZ2soY5Tw0squKgAsIF0ndcjq6QTpxo/i7OXkP2INiyW4nmFLQDUspuNpwC8MW4RU2p35AS1u5LBfEaxY9A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB5255.namprd20.prod.outlook.com (2603:10b6:a03:47d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sun, 11 Aug
 2024 05:16:06 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.018; Sun, 11 Aug 2024
 05:16:06 +0000
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
Subject: [PATCH v11 0/3] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Sun, 11 Aug 2024 13:14:14 +0800
Message-ID:
 <IA1PR20MB495324F3EF7517562CB4CACFBB842@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [0hhUVPOQ/Ex73myy02+/PNezu2q8wKwZ0C4VVcsLf+Q=]
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240811051415.981890-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d12193-d496-4ab8-5183-08dcb9c4b407
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799003|8060799006|19110799003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	vg2bCyQLaczvLwP9wzMJrdSetqeBM3kWAPdYRUn81rNwSem3Sumlq5UZ7HpHN8N9RiwRnX9DcM5k6dUvx2i5IdzSPlFzp9Y8XjVWD3w968W3XK6Irm/F9MF190flXNqfqe+03fCUO5iOngs4VQ+g1OZE8p9KWmWEDhg0DFnX/O82iICzfS9NEpE5A13Y/Otgq0+NEtgfMFb7+7S+IY81Yeh9ySLVqrN4BPKClv++UmrWM+zUr4VgUyJFEFcJd5ebd8epyjS/uklx9K2LNchNQDrT1lKZzH4AnqAhCaUyk1HTwbw3uFFl+rSh3/XzfbOiWFiUV0utrja2WOoRMLZm7vwN9dEsqHuKdUGPLQrCyc47qTqBbRHY58kT4KXikbV1pfG2Mg+FE408JOAmBVKOhWmUsLMILjAu12k3WFoB7vtky6eD3ea37h/9n1kFTDOfxrQS06RANbEGaNhpGKEnld5lEo2ODE2fkt6vQcSRNe8EViBOURDzFqAfm1IYngInDYjUVn/HTbkXIEoEpuW2XHQoQsSrJNiqdO+klqAuzDyeyBCCz5oBegDVp/7i6COdCR0RPAG/9ZzVahd4WY1O6fXkdoyJm4r+SqbxA8hNRJxekt1Hr574tlaDdoWUPnZjhIuZf0tZRMpV6q57WSVQno8OIbtJBDZa/ua2mUPVw4yxz2/0+9rIBU8mGeKa2/r99ap4X/qVB16seZgZjWKhmPyC11CCVWqHOyk2KXILSPE=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EpSp+K2edy1SzB2aXkueASrBHm1oLSFJe1DwhntshOzoB7Mr1qhC9IuUUv87?=
 =?us-ascii?Q?xVTS5GY5fuBDTMe3YSqFJHdL9uCYfFs5cXlni5bL5FCR0s2tWZMxIfMUvBrd?=
 =?us-ascii?Q?s8jLN1jJMUWrfKttU9KfSIC9sU2Ff047SONyuo3usrG85UXzCN76FFH+07PY?=
 =?us-ascii?Q?ab4zjhoThVSRQNgqLepwsrASWp3SNgm2pOp+HwFQBw6SqYAvOgHF7QPNbkN5?=
 =?us-ascii?Q?n4mfltOhRFKtPug3D/gzOw4dtMEjIuuRv5lcGxQ24suzHe/ItKkRau4AzTsu?=
 =?us-ascii?Q?WLWqPY9I2zDgjRUCC2EFncNZpKFQvGZC4aA/5Qnj6kKsnrMwkTCkUiWMnsZ+?=
 =?us-ascii?Q?1ieL2hB8aXXwyvkKT4kGy1wUmAq0p5pQ1mCmfZFwRhmjAagPuucFFilKNImM?=
 =?us-ascii?Q?GUSZFhGL3yzKedpHKUQTnY5mUBBehzLg+9viJmaGrxaIB40D5ASGhivvRqfv?=
 =?us-ascii?Q?dHxDFt5pvA4RWOrIxB1L1unulrWv8n04S4SzViVQEr6wB42suI/TqEon8imn?=
 =?us-ascii?Q?G7neN6GxRrJZ5MqcnaOX0KZRbNdp4IyLUuYbArPDCmzILOwXUzILUtTp+YVo?=
 =?us-ascii?Q?35R3PnIALTiqhHTvNKNevvOwwJ+3qnzdpap6d6e/VZ2/R0YVf1xFAa07XF2k?=
 =?us-ascii?Q?cA3QDi4BRnVoeDqcN08pusZ8n+j7YQH2lrwNWmgHAQL5r7YEDXAwXCVeV8+7?=
 =?us-ascii?Q?v+uPFBf1sKevbmo7ncAMb+MecY52gX6Pzsr1hCCzvw8nagDcdPuzp5FtBjWx?=
 =?us-ascii?Q?dcNuPqo4BE2Xug/i7YnqjOO4H/w+tqsVeczea8py9A/vsD2YCQmCHHydnvLA?=
 =?us-ascii?Q?YTrPPwi2jGZqfCwIHDUgZJl+o9sgbZa1sZS5aR5y3DvowUXAlgvTMyuelxNC?=
 =?us-ascii?Q?21nhqN/R5MvvTsuqfvSzV7cW7XORLZg8hDzHuqzWaBgxU5kr5HBm05O0aNUa?=
 =?us-ascii?Q?WWJsSg4YjQj4HBcU6wuI6Aw7PBTABEESh0wjGKo5AOmyi3+kGop9HKtQIUOw?=
 =?us-ascii?Q?g0eJOVE6s3SaZpvPqHgECnmpwj1UpY0fKCp8EuBnaQNo5Jc14BM04YJhQmbM?=
 =?us-ascii?Q?rU721ENv0GX4PakesY4fZunaM1kNQQduZXgxOjkiEsheBvbIgQbRixEiOIaB?=
 =?us-ascii?Q?ne3mMxZfrx3bYQj8Af28WXv25jwRyHj2LcCWg/YjJN49CuDgaORH+dzT2I6j?=
 =?us-ascii?Q?JAqY5sPrRhQ++RcmD3WbvCx00YLAF69h8Aucog5hBTi0I1emHyCfoGemjcxL?=
 =?us-ascii?Q?RoMUhwIidEe18ymiOJCh?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d12193-d496-4ab8-5183-08dcb9c4b407
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 05:16:06.8349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB5255

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

As the syscon device of CV1800 have a usb phy subdevices. The
binding of the syscon can not be complete without the usb phy
is finished. As a result, the binding of syscon is removed
and will be evolved in its original series after the usb phy
binding is fully explored.

Changed from v10:
1. binding: fixed binding id.

Changed from v9:
1. binding: rename to cv1800b-dmamux.
2. binding: remove the unused formatting.

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

 .../bindings/dma/sophgo,cv1800b-dmamux.yaml   |  51 ++++
 drivers/dma/Kconfig                           |   9 +
 drivers/dma/Makefile                          |   1 +
 drivers/dma/cv1800-dmamux.c                   | 257 ++++++++++++++++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 ++
 5 files changed, 348 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800b-dmamux.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.46.0


