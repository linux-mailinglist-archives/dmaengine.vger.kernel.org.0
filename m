Return-Path: <dmaengine+bounces-2969-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF473960241
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 773D4285683
	for <lists+dmaengine@lfdr.de>; Tue, 27 Aug 2024 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA180146596;
	Tue, 27 Aug 2024 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fxC92KEB"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2090.outbound.protection.outlook.com [40.92.40.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8470146D68;
	Tue, 27 Aug 2024 06:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724741398; cv=fail; b=u5+VNAYprkZW/0nuoyjZE6+ZtwYRVPtY8741CuoYdhS6VykZEYsPwwvcplNUPT8vQZaL195cx6gINqHLx2oAHn8rHUyPM4SgJYLD40vJFBvQ1gTyNnIjLD1w6zVNrrl9GR5kf/5geP6y81Zx3ItV4Z75qhPuEeDRZVTkujLDbdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724741398; c=relaxed/simple;
	bh=B+wnLTCIDTwn0nmQ9BPFRIzv2OYEFwAIyHlsQih5y+U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XG+IokoO6qBkNNuVJc7MzJFDkLLWJkIRfDhP4uxvnQPwBI8Imm/M0NhAbE25LnpCPPKN7zSPtOT+ba3/QQaugsnimEqzQfV3V3XLMH6G/6Jstc5M886XXdXBPwtckBPIQC/2ilhELaq5Is3haYRWtgx2ES7m4AHYaNbHoFP95DM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fxC92KEB; arc=fail smtp.client-ip=40.92.40.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgtjAE0OkG4BP6LyIUk8mmj10ZJf27yBx4lbRJYj3HQ6KFi6YuNb6wIdv63fCjZEoD1WqkPTcMn4KnNn8JV0KqJvk/vMH9S83a+K2KdXN5PDQiS2nt06Et19yFq0jpsogsTllLl2ye2kMfpHU7DnQKVRSydDvxUTCmQcvNkWSDGjU58sW+tYxf1bjeMxoVpQqRzk6yH8JSL2kdyab18GPA3wLxShbys3Z1K61BlcuOHUKxJe2e+dEquRdwYmHiOoMwHzL3S4GmbqATVCsLz1uIX/gpNJZF+jZXuwtVTEaTWXFh10Gkgf2zrMxrsC7yMmZftKZdL6SopguECksNv4/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo4PA/EshPnhNpeVdtaP8xDELtLm+fQPpOw2VYvKD7s=;
 b=By+abC7KNaohvQmRPN48Al3F8OhKjDT4GRxvK818hNkZMAdCcLOiE24YBGCId1YNzrSBzp1y74EqjtgDo2iYRWQOt6cIB3/IOyOBoFUp0kWHFyPKJTod/OL5ZBzaDxhGTiEQZmRmI1F9qUnG+zsQsuC+SP7+0GCLgnjvLLWIG1sXBL0Dy05bxsXZ3fII5LR2I6hMepST81yZks/YhNXuHA24XuJAXGoWZVqFR3Uns8ZBnHsCom/b5O67LLctcNxG5h7hX+fa1w+QF/bq189wSADTM8mM8rWGE0ASo05A9frpOXkBVYTlwgaV4GVaM3DgIaZdYhg/flj27K+j5Vjklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mo4PA/EshPnhNpeVdtaP8xDELtLm+fQPpOw2VYvKD7s=;
 b=fxC92KEBvD1Ct/QDLV1gfgDuzkK1Y3oYCXpRCWhHEbMvF7CDDIuzqE7EXhKpSSVOY1oKQ1U4GAsZRGr7nOXL5oYOmnX4q4yJHdIvLaE1LwflYSpjJ7BkjayZitO9RYN+Bihtim+LkMw7RmMF+nRdHn+d/UK8rzHDpYAwVYwJPYbIo1uBFWeuhKXunXMEzfQ9w9Auv55YJnNGPiV3tCt7KVZnvMQqkQCRaVCyQhREjcHrQoyy1+0ZtXyE1aE46f+pg5muMIQgd+WHBHrWzEtciJu7vSgqcy+DMg8us1/w3TZRJNS6ZjWPqwjD3ACOVDVX5ELjmBKM3BcCZedfJLaV6w==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DM3PR20MB6939.namprd20.prod.outlook.com (2603:10b6:0:42::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 06:49:54 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 06:49:54 +0000
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
Subject: [PATCH v12 0/3] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Tue, 27 Aug 2024 14:48:49 +0800
Message-ID:
 <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [dMwwi6QimMzRlleiV7vzaY1GWJbvvAZz7ZmYNUdowXM=]
X-ClientProxiedBy: TYCP286CA0107.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::9) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240827064850.739895-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DM3PR20MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 68e8a3be-5020-448a-8719-08dcc664745d
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799006|5072599009|19110799003|8022599003|8060799006|461199028|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	wAnbX2VtVWX1zcS0G8ytlo1QHtkuGgsbUQvl7avc8d+uILbZjOgM7+7Y/qLmhxdMvq3Kmx1AQcpLqKkjmAEy8FO5jpAelUV0ZUgUIjAZ0XO0cB3Qu5JHiPONGiIk0P5rV18ZE+ktb+ZIVTTghtJ0dVMK3QMG7UXbKUI3vo9L+9ZDbjy8OJh4bwiB/CeDVntdrlw/0/NlJaw/JS3idlTvoh6uDLQ71KAUfMoWTorGQXIfXGl6Z74kStD1nbuYRFANhW2r+OAKMnuQlXzfA+7nX2olopcf0S9Ca9HTPRsbTPUb8YdB11TGt1C069ZYZxNfBGT+MWhEgCNppIApScU1nZDtDdC0FZSzRmAbOkTTcfCu5lY7UDo0E2vg/mo5hY25UuMyBCFC/S2fA3hC/RfINVbbDYRkbVBSKnb1TUUbihcxk3CfD3UfNe/cyh3AHYz3MAAMIk2zRCQigKTkMMjtdluJc4xVfMSnJGFjbScvmx9pzXF3jMwoU5r21UkVcat2PqWZ7o8iaJ5vtkfazOaxE+omQR5QhPNyPVLBY9wkyljfX+3tJUTVX4HtYtD3s6pS0OFM/knZa0pRk/wKbGdxED4zW4880MEmbLZ26Fs2n4PwaSQxkw0wZYBacY/4sunz8qsBMkQNW//6LDySnKl+rQAuHsguHjF+l7E8tARBgCibjZT+B4ERIsOhCc4fqbuhBW51/Bs720TCtz7Dlboqggarsbhmsq0t8CW0EYS1LgkKIUyTvi/HpVj/ZZ2Pnpmsy3HwI1KSscY69ow6Y3NNxQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ct7Hza4RCxyAi849SNnUgxQqoOaCcFlIRNmGE9hQz73L2zwZOw6mmrIG6b/U?=
 =?us-ascii?Q?IKE60+sXmyumCSTUukpEIacAdO+/TitmdUu/ybyd39eMQe9DYsBZ3ytwa8IY?=
 =?us-ascii?Q?DeLUJU2XzH/MZa4NCGBI4xAynA+gdwGoqosR0eeXklLQ3UAHXtGbCsqiByAo?=
 =?us-ascii?Q?o652Y1YOhElUFi3sqrQTGSnr67Rdob98fgeeNbwKdx2C7Ch1pGVCkPXbn9T2?=
 =?us-ascii?Q?96SF16bvXFh0FjWOEvSJZ7F+1PSww6SFVeNCJn/sAbajarI4yf1RCAVhgqkz?=
 =?us-ascii?Q?dC8PQwchvyYetdYgFfBFCqA7GVQspo6aWFPSX/zUmanzqtJhzy8EiKAGHpDp?=
 =?us-ascii?Q?yXEcLdE/5pu7uX15ZX9j5XbCYq+sBbeagyiFD1+nCUe6AD5GZmpYMb2UWGG0?=
 =?us-ascii?Q?1wC8mkVvcBVG08Tum9mjlP3GONHFmbqSZnLPWgSMqXE1Htp7aHV0BUQVEYhT?=
 =?us-ascii?Q?KvNlxz71OgRcp+OfyWjO6ThmwdVow26eBG2d5UQ57dkZEIDWy5uGEk2dXsYy?=
 =?us-ascii?Q?6OKgCglmM7K8zZ19BE5iXu5WNWjrArvk7TF0l7OIxur+uKao7uPiQ5fkZEW2?=
 =?us-ascii?Q?ecB3fNObTmBA4mx31yWBkwGbZI8T2YwwakE+ETCVM3UPv54TUtuo+kApu9Zm?=
 =?us-ascii?Q?fM+Xyiurjs+5p2HI3jF61q8nbELLZNlZ+SsnwRh4fYuj5nJj5M2cj1+M5fxQ?=
 =?us-ascii?Q?WpWuKH98bRvlXyxrlV8tovN5pLPPqa5ESGgLLlj0GjqO0TL4JC9IlhMQlWPL?=
 =?us-ascii?Q?ktBkWuqDiOSoZCx0y5J5zb5/X/jx0AC1xq7JeIcIKqoKHujB8RZxxJ3Vc6tL?=
 =?us-ascii?Q?MCqvujeY5dm9lt+4liaA5o2FVV039wmLjQckZ5nzutzpTxpGvV/eKP5II4LR?=
 =?us-ascii?Q?X5etBU8pgVIORTGCk/OsEzyE/OomD2qXIESkO4Hni+MkQVW+7f6v0BIIKJzw?=
 =?us-ascii?Q?fqTun/SNOor3U6ShIsHj7aMSJmMIPA9hWkp/wGFFGWMS+tYEW7KdQEs0U59/?=
 =?us-ascii?Q?f8a4caWMQ0Mn06zcOulETxTs82fyYTVufu3XQCwW74QaXPUaUMUqtA3e2CYg?=
 =?us-ascii?Q?b52TM7Z/qXgG6widoqusIh8gYM+j69cZzFCWOeRO7JkHn1al1om4YGKI36Cp?=
 =?us-ascii?Q?zbodmhG4jFwh6YXw1Y1IJlP12lZ/yzOXbK/WtF2E8RkhDCWwHax/d9Fy9nqQ?=
 =?us-ascii?Q?eYNkqcrgAaCtbdhcQHvJT1EzoyYfkuBuO8zMI0w1ojGcbJJtvkvbIQepLU+g?=
 =?us-ascii?Q?d3hnGWD8+wHFxFpq5Vta?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68e8a3be-5020-448a-8719-08dcc664745d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 06:49:54.4648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR20MB6939

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

As the syscon device of CV1800 have a usb phy subdevices. The
binding of the syscon can not be complete without the usb phy
is finished. As a result, the binding of syscon is removed
and will be evolved in its original series after the usb phy
binding is fully explored.

Changed from v11:
1. init all the field of the driver data.

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


