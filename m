Return-Path: <dmaengine+bounces-1830-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEAD28A27A2
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 09:08:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F8A1C2103D
	for <lists+dmaengine@lfdr.de>; Fri, 12 Apr 2024 07:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE54CE13;
	Fri, 12 Apr 2024 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gelWtiff"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2064.outbound.protection.outlook.com [40.92.19.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1286C2C6BC;
	Fri, 12 Apr 2024 07:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905582; cv=fail; b=FrwDmi6X5aaarFvvtaUhposnkxzjZQ/jmrOJpOHoi/zneGyrmT0S7tt/c2r3kYS+TgQxFHL9BxI/7ASqCVI3H0sho8aGi+uUj2nV4GfwuI7EkGO8/pLTpl01grnR2xPIs0R1TYVgOhGzboLena/f0BRNBMcV5fZgVloW8IH4W/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905582; c=relaxed/simple;
	bh=P1jOG3ND4Mf1zjSBQvVz4l0JIQR4C4K7EMCPtti7aTU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SG98bpgm2xwLQifBC9XHcJrWaTygYemc6T77FOy2Wrx7I7jECl48Yl4ZTp2oM/MXaxAL3rIQOGCbjZYvJOaM0tP04OwMayVT0HhrCj3Y+9YM9S6zwMOaikuvw5Dn5SStN0DUhDZ9ct70QQzS4laqV4QsH/TJQERSxynOTcdXyjk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gelWtiff; arc=fail smtp.client-ip=40.92.19.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy7QPJxTTHTliNKDmoo2BzM41+Mmg60yCD9gZ8wUDo/YqhcI2hWHOnjT3uyi4n4r07XvCbArNE4XOolTD/8Z5n0hAEp2y2GxPyeBvjFHqSEGtX1u+13UwLWUnXDL5vUgQg2q+1l9zlO7zX7Mt8Ijtaw3OB7bt1VjasUu/MzMmtFZaBEhCE4Fx7qXBwEN0QayOoiqxz+f8Bg8yIfiQ+2l15hdgROCvT7QUT/suFm2IAoNbdGxrkfibAmPL+QVPXGfL8jz5q2jhutJdcwLTQOlBw4pIRSEHJ2TDEUr/V0D1cPogsrsn6Qp2bzK0ArMVS8ToY4E1we8HJXueMLeoHbY6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSdhpdIFY/BUNL2KPiiab+YLI170g9vlizGWY0C00TU=;
 b=mfDjBJ+n9cjpk3EDIv6/29kPQjQTzWanZkc5qLJwNcRmRAR/cAlf4Zwl2WEK6B2oCXRCoPEaDPFQQTSxrfuUoqqnt2nDdV5TjBHUwAoawiiX47SMrSiW/qgqEXlWkDVBo6JefNabdzw1japjeC0Bs8sM9vttmP8EXkrha7vdpXNmxnu2Or3SqGLNRUzCDlqCQR21ypLwvB0utoLgWQOPs9n3b+fiPyZB3tXOzdqDrJCNQM0r6iPv5tPXcc2hLl4FIg5o1PQ2jrH5EOh4MeCnrGxmuoxniLDim1INJdtiV8OPCe1c7eaCKQb1L3s7bhr80k9sr2nw5xmIKtDu9enGPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSdhpdIFY/BUNL2KPiiab+YLI170g9vlizGWY0C00TU=;
 b=gelWtiffPjO5yMHeRclpjFfU8KuQsTEO4P2U3p+iEEfKlKAqzuqYHMR/zO2DEfMUhaoB5/bomuC895LXMcZNilIkSNCpyI52B4bjJU5sb3wxpXfNd3BCSfb4DMkv6eRTWqpfjbitKDBW6XFtG0SaFw8epjxNFbRihKdKsCUpigass7DNEy0HARUONPPoaJCAWzNh6gF8X8jmtPB+2faF8dSkQcIpmeD8JI4iQK/2ZhBgMF3McNkgf7SVFoRxxRzq/fS9bx49Y+dy/Mas18IK9Fsa191UtJU+uqmXj4m3zStWAHLH/aShHO9XfsPFmEEhVHEF1Gq0pTK1s5O+ih4awg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SA1PR20MB7440.namprd20.prod.outlook.com (2603:10b6:806:3e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.56; Fri, 12 Apr
 2024 07:06:17 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.042; Fri, 12 Apr 2024
 07:06:17 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>,
	dlan@gentoo.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 0/3] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Fri, 12 Apr 2024 15:06:26 +0800
Message-ID:
 <IA1PR20MB495359880A3A8C4947702BB5BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [MtOayi7d3Pd2QjF5KvyqRN5W3CdgWaYyz81OJLYLavs=]
X-ClientProxiedBy: TYCP286CA0330.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240412070632.59800-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SA1PR20MB7440:EE_
X-MS-Office365-Filtering-Correlation-Id: e1361809-e541-4834-1c0d-08dc5abf0c86
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KUdqQT7qdudnd+Wp8zVlmJOdsrJ2Ey8ts0ej8Iul7gOKq8xdZ2xUclnEeoCGgPg3m43qiTwNKXw86GXeDbPKz6Wyar3WyWxr8C6+dPnFDHypLSHdjj8eEA1UpE8TorlSArQq/BbYD/2zf+VPQfFJ8MytyvX2nnshMeS7ng5HYNA/bgcj/Rz0O0Pb47w9eUME/2Nxuuu9nPoPSrSd/NmQafwVmomKFmJCrGEOVVFqR0tQFrixJ1/NNemwfzRJNDQ4cCDccQ7OBlt1vjn/C/AbZJTBJlsPhnppKcDHZNmaHuvu8nZcAbnpHOXhfz4Ye6eFn23magDIO1ZU+tSITYzc6iO06NjGF0PtzDoLHFdD8B5FgURBYBDGEfHo9tTjAkmZ8Vl/al71iKaH7jTS2GCCQZ4T5GWsxkS+qFFgXll3Vn/PzGK68QKlHJlP827iBUZEvHILJd4g5fhQf3075HYoyCzU4uewbYBuFNxN+n/rdRPwPAe9AclEpIlmyxrwgF6e2gC1ySlzecMgb3wXUS+SbTfn1c5wS0Z32ys5SuIg+ecTk3MQVY1dHW2Cj6Xj+wnDReT9A4v9ZOvRPV3j/SE1nj9NqQSdRSF51nEHZpwTkxs=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?d4NQCEryWG5rajixR7hpkeG6yx/cnLpTZ8kVVoNx1+0jvbmXw6dGFRkf754g?=
 =?us-ascii?Q?q46UuhBNWrAMHJOaxBK5BWJI1/UnWyAIuv5AlVfsJyhvOF0vEd6mvLJg+HVd?=
 =?us-ascii?Q?3AHAXdEuabmt42wNk33CyuFY7ZI6RP0eKQq/kdrejPV0BLcy46p/zx5KHVJZ?=
 =?us-ascii?Q?iRou4ZJYd37MwYpqhUGr9HJk4AFK1e3qg/lyerknWVF/QLzGbIVmd81F5SgC?=
 =?us-ascii?Q?6T7N2rEjuCGoq8gwehBgeaBDF190zvaBubu9RdesZNU61iiTLeD13HjmtTz7?=
 =?us-ascii?Q?zRV88vNR40O2ZdD/M2PatHINrkhsAOSTfZEHhSpysfSuj8bUYI5rwe5lHV4B?=
 =?us-ascii?Q?B2iuwCtp/8D55EZBKrkHwTNbE+LEo2EF4YJhPv9WIZ2VDkhYQdTmoJtxMcsp?=
 =?us-ascii?Q?IWd0tLwf4cFamH4NxwkepvIrXC01XSE27ReZpr/d3CC3hbwMKS3Rm1Z68NiT?=
 =?us-ascii?Q?2Iv58KdpPGRSDhBfssOOqP+NZ9SE9E+NY//qcQLTyKvQDRvgwO8rnlJd4VGh?=
 =?us-ascii?Q?BHaFprdHtUjWqxHqOLU+Py0Gsh5WbyCQmmCjdfy/xLgs/UhOSoc4hUeBOCOe?=
 =?us-ascii?Q?SynUBblgKNUgEfS9D7n+sWkwvek0/sr1jPKTmW8Xy6XI0n3GaC1svt/9wC2t?=
 =?us-ascii?Q?lSdX/V+Nh8viWh4UaJKhLLdvfOhlwi/xcTvyc6pvwiO7nNIC0/2MjmEewxBS?=
 =?us-ascii?Q?k07vbUktet/KT+ujv/6LqTziTd/qAEjVjpDIq/bMLQrlGseqZwyB8yIv9Cpx?=
 =?us-ascii?Q?Fn/EbbiNgFm88A9HnFtHxsVzwGOTvi25rs958XlIqMmZsaD7cA3Ys4+2Doro?=
 =?us-ascii?Q?zKbbQe4+O7YbN2tZ+AbL/W0ZBaCd0pOxDcxLWZNKTvw6A3ZVpWDW5/+KaXf/?=
 =?us-ascii?Q?oHT6VeRtZUb9PUEZ5W+FMxPrgWXv11FeVGqxwz1JUZFmmmXpYvqFUjTxKaVT?=
 =?us-ascii?Q?hjeozyrCj6UGixUQydsUTs+HTaD1rQHeQxnmr3dgF8/7fmHKFcP+5TrHGVOY?=
 =?us-ascii?Q?UyH8B9Z+6wCg5cxK0XomzAT9GmV1zKKJ6A6oKtdloJJfdLInI2BSCfV/jq77?=
 =?us-ascii?Q?K2jSQCe92MZozEza548Rle0mlGEgk2RJu1Dtk7g5xiVSDd8xWN9JheGYIwr8?=
 =?us-ascii?Q?Pk6KlaRhhYfoIVYV3yYyQLWuhg8sViOGhKi/AKkuFHfrYQA7nXV/zNdAh8hi?=
 =?us-ascii?Q?uxdHdW+xys6lbO0sd21UanCe47p3q2QhWUycRV7pwcY8GFkws2CWHVnzy3bJ?=
 =?us-ascii?Q?T0vkec9P/u3zxUPnXeiD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1361809-e541-4834-1c0d-08dc5abf0c86
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 07:06:17.6984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR20MB7440

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

As the syscon device of CV1800 have a usb phy subdevices. The
binding of the syscon can not be complete without the usb phy
is finished. As a result, the binding of syscon is removed
and will be evolved in its original series after the usb phy
binding is fully explored.

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
 drivers/dma/cv1800-dmamux.c                   | 259 ++++++++++++++++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 ++
 5 files changed, 350 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.44.0


