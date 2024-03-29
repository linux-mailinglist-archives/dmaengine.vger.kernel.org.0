Return-Path: <dmaengine+bounces-1645-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D39C1891150
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 03:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B541C29302
	for <lists+dmaengine@lfdr.de>; Fri, 29 Mar 2024 02:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA10224D1;
	Fri, 29 Mar 2024 02:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="fDD/CJYs"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2104.outbound.protection.outlook.com [40.92.45.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692AA2C697;
	Fri, 29 Mar 2024 02:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711677826; cv=fail; b=VUZ4KLGKqsgtiErR4kJ5lKPjXPut9hS3SbXR44EBF36gzZm3hkwNSZQ3iduG0kJSGBtZNMbsKmpDTtDsDYNaJX3rD7IumgTWFxeZnyGc9WVP0QHya3rVFFC3bCBIyaz93EGOf18whMasZFXWvlLUAJjnGipM+niUydWv9/UYIDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711677826; c=relaxed/simple;
	bh=hbzh6iVmNlaACTGef4rLTvavFSRVZgWomwmU67chwWM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FavCM2VoUFR0zi+wfbt1Ig1BuarBcSY1qGZX/12kEDvqvcU3MRjr7BTJBPCGKCddU4HKLE12C+21q8+hOSgnwlEOrZaZnVmHEhgesa9OEMWc1at6F44AK9DKxB0avv8UNLvv+AMJWiY16RR1UphbrI7dwWdB6XglXmtoVWN8BU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=fDD/CJYs; arc=fail smtp.client-ip=40.92.45.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGqMO/8VOf4tqiurwdC+tU3a5EK+n2fmqXFuOwn0Y+f4li52WcUCjKqfQKni9kwf7SAfgUInKt9LFtAgLMM4IujFC3RqfVcS/3OS4iW0NTDJRsJOc6eKtRg2fTGmjZph1NTilCaMFRIrbF1weC/YdtEqx+ncs75sByC8XGKo0f4PPqo6PVGNA0wAOVvV4kM2PSuqqGrKUj22nmJafyXw0opmyCJ79jmmxdi21oEXmA7d3VPZBDCzcIWrhhKTlj4QDeXdm/ThofA+xMUkM4Cbg8g/THNNtcG3TFGsg2ORA0GPONEZBoIyNDz2iKDUebsQIamWFFthI9WKXDtlWARGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6gTyBk0v5vgj6unpPBd91+KDAaaauyd4jg+5NST+vA=;
 b=JW/P85FBtJdicP7kRQG5Fqbp2uoYiauTuqiAtn5l5eONhIFlpdvpRPzLqc/mL4S2Y03Fm/cMSdQwzVCTqZOvG8Zuf+XdskEg5a2CP3F6vPVURYCC+clk8kS4+lHW1XykvHYgAwuFfc3FWjAG4niPs6LnB8ek8Nci0Fhv131ItHZPGH4Md5A7ErWJR5wOtBtlZe2269EsCVCJkyeESPhAUwothvlUE1XtkR9ExHdFiRN7NyUg3oyNpS+1vBAbaLmaBNYJNd4J72zrmj2p9TGsUmmEjdrAkyin/XsDgS5aAt3NQiyTKD/EKlnbEoWZMSRRKYgvcvXDQGaQ2RvTqofnwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6gTyBk0v5vgj6unpPBd91+KDAaaauyd4jg+5NST+vA=;
 b=fDD/CJYsrxgSSRtQU1qR7XPo/5wamcB+Df1O9mJXRsc6Qa4zTqbt/cg5zXCyszBZxamcMs1OWRlQVpMz54Q7jbUme+NWhRGcrHOuBk4R2o/thWP/cthZwULexYFUtWkc0JDaYCCTj9Qoe/5ey7WEDEEQkosDMpzLMTs39hu80Ofu539PaRvv868MgEs5refuokKm8+IHRz9B4rYKEwxycxk93psQG85zrdrhMq+XmFTk7RA5aiq0wrnpOulE8Teu8T1OiQwj+kXzHqEPMs/cShBl3Ettgl1hu7EgLrCqCk6VtIiohj9l3tO/+oN0r3Oq67caR3MyIcjaA7vAlRKyGQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB4438.namprd20.prod.outlook.com (2603:10b6:a03:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Fri, 29 Mar
 2024 02:03:41 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 02:03:41 +0000
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
Subject: [PATCH v6 0/3] riscv: sophgo: add dmamux support for Sophgo CV1800/SG2000 SoCs
Date: Fri, 29 Mar 2024 10:03:19 +0800
Message-ID:
 <IA1PR20MB4953F0FAED4373660C7873A2BB3A2@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [4VFe4J8sA1aADwdXjUhJcSnfcfgbLYET5A6M+sNv1v4=]
X-ClientProxiedBy: TYCP286CA0204.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240329020320.370923-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 61b270d3-9593-4659-a70c-08dc4f9474ca
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mt3t8AiAud8gUbq/SIaAmc9kb9In85pEmYq8PxhN6qAEhKbplRwdbhAL9oq8l5eUReTLcXvZzAiYUyZNBae6I6DMynlkPX6aK4dDbIdnrt7cdZcKS+jnL4njYvKyaRQgNk3wBC+s+4V2tIJ0Qo7/KZEKgu2esia5fSGxXg3y3jInvjqxyL6rmTio/2oELbaZklJ2OGjkh5HtpNZNULzthNi5QfipMJRqB92JCAeEUlNV16wzS4HRVArBoqn9FleKH4aUrfv15F4CHWadJHna71qOvciWDqWyNuqpoXGUbFQw+TFruhtoA+ioC8T65oKsiT+aQFIx0f1xAzw0FbqL2hipx6UYtwfeoybPCKmt9TUpr+eSkI9BJbq6w3g3Ea0TO2Yo7jsIXZ1jfrogwjD9L3OVPO1Ivoeg0QrCTO1YqUWAHkOknDqQlRD5Ni/OznOSEf8Lv4H53GvI+a1Fqw4t3Rb5wFmN+jRl4WnNjfE3/w2nXzbfJxh/aoZoYEm9fWNehs3lMaRyD3Wl669UYZUH/zx+Z1gd5SoC2VtXbf5J6fKDhpYPs1cWw9+6K1WxdCyMPmk8I66YwFmbtlAzw/2pW8J+s4u8kBjKepzGofucjaI=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UndjJxIxGash5m/oRgqdhhY9M50di0+HU2Un66nlGKhBI+ITK8bA3gCf6rvo?=
 =?us-ascii?Q?HA7OVsF4yQXr4tvWeN0LYVPlOGrjJtKyynL0MiDB6ts53+cSi0SMYkU3Z5jd?=
 =?us-ascii?Q?eu0AuezcbYVWYjyxnInc/kp8+cr7kJNaRHQNGYXuHjJBMjtR7AgzrmgQkc43?=
 =?us-ascii?Q?WlT+ijXa1ahhvHY7aWpV0lVMEayIAEeaO2wJMO6Tzu+M2+O6NrEduYvxzWQg?=
 =?us-ascii?Q?HSo+wzi+K87K8ZivbCTGWOeELqC4J2iTTRsUzyRqgAtWR7oeLRGQJm7+HG6J?=
 =?us-ascii?Q?GuGCWJ+fw3ZZJm1cL2PXOytTGcNIuYBl1aQeoVBHYA79vl6oY40GxWI+0Uyh?=
 =?us-ascii?Q?uRGtPaXJryl+QnsMLXgy8PH8bJn+l7QqgsOvj7lVPmYx5ojRVPeZJ8iMBxvx?=
 =?us-ascii?Q?PW8MV6LfN3fvetqnH6HfLteAI7GHvUXiLHNZBte9w9bW0uMyehi+FdKuQUSJ?=
 =?us-ascii?Q?8gmzkVoZzjOWPOJ+o3g6aO1twP3EXzVMV1zB6FmHkyAFwRVeeO1RzDxRda6D?=
 =?us-ascii?Q?omlk1lVnLjn45F5ZBDRsqXvQrrPsmLrjNp6SxmRBc01xFYIgWUPAm5s4XyML?=
 =?us-ascii?Q?7/wE/HckYuhCUv3Sy3zVSLWwUxxZ4pj1bmollsPL4rnrHPHCoEpCOMtkDCWv?=
 =?us-ascii?Q?/yWyNM0/7e60sCgPpzyyhNM3Gtdlir5BiaCczoiahjofabVHc+Thqk2HZpCr?=
 =?us-ascii?Q?Hw9KqDfrE8g6bP3N0bJ3sARlrqH9m8SYPK3RhQJJB6a1k1dIPr71oAVegfHA?=
 =?us-ascii?Q?dGIlzRzaSgNC5eVyD3XqNks1bVSpkgSeYrz+CfTZ1hglCZ4HY/1AGJ5K/yeI?=
 =?us-ascii?Q?r8ylF5IMVisUw5kdEgIJk6Fw17vLysC2QjC7eqPfGt0UsBto1GJOex2lV+SW?=
 =?us-ascii?Q?+t8+2aLYREHmTMmVb8MgKuImfwI/Ey+pAjrUZLPkcxAP7DCSCTUAps96BTcP?=
 =?us-ascii?Q?kFLqaSOlvyKQMNLC3gVYTNJoy0wfux4cy8aKNgdcjz5PAVk6Nk8zTiEiLoZQ?=
 =?us-ascii?Q?R6rpoTxXxp7EKVSd3q72eUhRigIbqd+AI9CooQm6sr0D5iTrGR5QaTM57pvD?=
 =?us-ascii?Q?+/Prz6PoKn7lyPJuBddKAJ24kW/wZ4lEjKVXF9s1zFOhwSR/YsZxqpeE32DV?=
 =?us-ascii?Q?cxm9KvqooNcvWXZgcxr3xeiTwQlYxnVGX5/KDZW1MhKdtBYpor+UktWeFXme?=
 =?us-ascii?Q?y4/febRc8GYdLUUYa3Em5O3Yww84miTbd23tX8+d5oQwSGGZBtkeqLc2F+L3?=
 =?us-ascii?Q?cNipgA9Wcs39DDjiupqD?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b270d3-9593-4659-a70c-08dc4f9474ca
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 02:03:41.5141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB4438

Add dma multiplexer support for the Sophgo CV1800/SG2000 SoCs.

As the syscon device of CV1800 have a usb phy subdevices. The
binding of the syscon can not be complete without the usb phy
is finished. As a result, the binding of syscon is removed
and will be evolved in its original series after the usb phy
binding is fully explored.

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
 drivers/dma/cv1800-dmamux.c                   | 267 ++++++++++++++++++
 include/soc/sophgo/cv1800-sysctl.h            |  30 ++
 5 files changed, 358 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
 create mode 100644 drivers/dma/cv1800-dmamux.c
 create mode 100644 include/soc/sophgo/cv1800-sysctl.h

--
2.44.0


