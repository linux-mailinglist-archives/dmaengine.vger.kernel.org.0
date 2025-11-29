Return-Path: <dmaengine+bounces-7388-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FC4C94202
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 17:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AB2A1346289
	for <lists+dmaengine@lfdr.de>; Sat, 29 Nov 2025 16:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D721630E843;
	Sat, 29 Nov 2025 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hATV1CL9"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA226E704;
	Sat, 29 Nov 2025 16:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764432268; cv=fail; b=FgFgjbzqh0rBJfE5k07FWdHLSVAm+qG5KfKVRYHylModIkoR392QJOHuU1z9DH1AbvxB6fqEj7xFWb5z/1KV9Edz+lwZjKLS6AHiHlCNcv4Jn9eYFb3ndHGZZa4BOBZt1ma/pUZiWQ8mvFb8FjKmrcr/A79McGzg8NG15w4Y5PM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764432268; c=relaxed/simple;
	bh=2nUA1zCGpabdSGOuh2wWne0BwiG/Kh26sCnNrLWPgrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CAz+B/M5P88s67yjIKIrfipY1cd8L+oiI900FdmLsLr5ikbmDSYL5HQygzzwp7E6vFNar/H74H4FUgkaFDf1SuiKvIO0zN//7QnWctJmc0zLogdIgDrezqWYhII6eiVQ3YHpIw9AlRq2kdMtRQ/sILRSlr9nenRHMiIQ3wc6b5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hATV1CL9; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMv7J47Oxllpf202soifmoQa2RUfl1yx7o/Gp0+7bAxuz6CWXEDvKEi65USiYH+xTzNB8qYD6WiHGwoEBiD1D3cYSJ8hD5LRebP0avD5j6KqR5Eon4c2kXdRP/OZ/3nIjV13lDaRta3Tw0L/9+eG1JC/X+177h1mL2vh7eTyHv3RUpj7qf2ARFHkUpiKxlJquFJyFi9UtsJ9j0LQYMSEvQLK/SFnW2KZN1q9ftgK8QnsXTo3dPTeX+QTUGrRsSpkQl1WcGyisYqcyLs0VICSGZecOzduDYzv5bLzokw6n8Thc0uPOjylaHv3+KnwzQ0OidOBgyuzSaRbkLGrp0jx+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhIuzA2RPUAu4BgyrY1Eb8OqCdUGvZHg++B5Ffmmt7g=;
 b=cuJCC63wqDrX4zl2uEqea4bNMDkr7qBuhU2X86/pk1w99dnA8G3zklmKCPyrjQcuE2f2VL9yHMiJ6Gy3WzAIh7daB7U1Foj2gsJg4TK7fZFNTbq6XUA3lvnupy9F6IHrDTJ82wDVw2oO6qrbaFPPLjQmKx/rwc5i8r9DB6cnW+nFl+oBg1Wd5gSxpPYNXV1QmHokyBaSwbOKSgGSZRjTCY99ybr+rwzR4wGz1qb9wzT+eSNML71I4gp7vDVQGM4XfwlXKYSL0nZnJFxFjDs6FUoJUjVG9DdkkIO0zlVk/1Fa2iEyfgPvtClWj6m+vib+wUbM554AZFh2gcZCdpHH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhIuzA2RPUAu4BgyrY1Eb8OqCdUGvZHg++B5Ffmmt7g=;
 b=hATV1CL9/NFwlA5K8Z+km8bEMJP7/tGq/zsEC1Ur1JcFLNHCPE9rLxiONYvjFEeB8iVbFbNBXtOCWU9l2O+kAbbnja7X3kM7pGJ//1qZ7a67zW1Lk+U4bV8M5g5ze+xdZ8Y6s6JXN9Lhe9dUAUPVepoJ+awaCMwZ6aiKj6Y3TOg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2050.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 16:04:21 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 16:04:21 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank.Li@nxp.com
Cc: mani@kernel.org,
	kwilczynski@kernel.org,
	kishon@kernel.org,
	bhelgaas@google.com,
	corbet@lwn.net,
	vkoul@kernel.org,
	jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Basavaraj.Natikar@amd.com,
	Shyam-sundar.S-k@amd.com,
	kurt.schwemmer@microsemi.com,
	logang@deltatee.com,
	jingoohan1@gmail.com,
	lpieralisi@kernel.org,
	robh@kernel.org,
	jbrunet@baylibre.com,
	fancer.lancer@gmail.com,
	arnd@arndb.de,
	pstanner@redhat.com,
	elfring@users.sourceforge.net
Subject: [RFC PATCH v2 03/27] NTB: epf: Handle mwN_offset for inbound MW regions
Date: Sun, 30 Nov 2025 01:03:41 +0900
Message-ID: <20251129160405.2568284-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251129160405.2568284-1-den@valinux.co.jp>
References: <20251129160405.2568284-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0085.jpnprd01.prod.outlook.com
 (2603:1096:405:3::25) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2050:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d45160f-39d8-47fc-822d-08de2f60f56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xa20fNJWEHlAcd3c2X1FDDFtnA29DdwE4iDxTWYCrK2z6tTWIAP1SakE/sYG?=
 =?us-ascii?Q?hCoXHl2MElsSmtt9Mxc8TFTlDPb+mmOv0ANeCk4zQki48+RLOiqfxtPuZc5m?=
 =?us-ascii?Q?GsXAocssAWFiH+QJPAhjp/jth8ogd6V4hLygtAQB6GvfV860jEhUjiMS5slO?=
 =?us-ascii?Q?+5PSCCeISAT3WiS8v9UGZw25Fk92vz2pHFUaQCW6G7oOga2qRcueg5tP7EGZ?=
 =?us-ascii?Q?VVvjMRQ3S9p5hoxmR37XjpKJAph68C2zzNEBja9e/YpqqDKa5vgzvJgsemL/?=
 =?us-ascii?Q?mkJPgYKr3+N9JVzsj80HdEpyQZriiVPsZar4Em+at5NIyBlZ0Dv3U20IlZPf?=
 =?us-ascii?Q?1ygvuMAe30cS5ZVDbgONRR+gDhyWPBcGgNuhZzirMtAoO/SR3+6TBSVqJq2R?=
 =?us-ascii?Q?Z/AzE9jQ4q2t0lk1GbN7Dsye6tLG+BNE8TPZQvZ6ubdpTcc/29Y2H6x2fJYV?=
 =?us-ascii?Q?MMFgdYFFAGDQZBuIUDjX5acrnohLDiU54ZT14yA5hxAD4o8OtrhjPA/cDKJ+?=
 =?us-ascii?Q?WO73G7nO2//tkP35eJxoLvqMiqMlc8UN3plEWPOTyV1aWqpO7dSxzqqLhCBs?=
 =?us-ascii?Q?RFHy3Z39IBcxvTEn3jpLQnkSCz1hiaALUv9DshRbNA9pttVA5yPuPe2arfbl?=
 =?us-ascii?Q?h9tHgWdHzY3LBPoDw02vXjQKj/C7ttNEVua4Fxs9gdcEWhqpIDI3GDZ6kKrF?=
 =?us-ascii?Q?Doh/1UBuG3zHKF07eIv/bBAmIdVy4gb/zdkzlWhNyhbPHa6PFaZnNOE44bsK?=
 =?us-ascii?Q?Ucu1m6hhEaPo+N3lL3QVFOPUhD76K7AEVBrM3zDqk2CtYNQgfXdCKuQuem1U?=
 =?us-ascii?Q?l9P1PbPfWRXsI9tWBPWjjt0O2ILU1ArlSxnrTsreo61SQSmB+tej3ABMLRGn?=
 =?us-ascii?Q?VcPH41Z6IsWWe38k3UIYTivXprVrK8bk0WrEwP+pnMDd5hhBed52JjaGgvlm?=
 =?us-ascii?Q?3jxtsBGvOYkgGJyR/MgFV4utFH72pj3yi+hrd/3PV+A2gEuOPBFBwuhZUTER?=
 =?us-ascii?Q?x3ua7Xxw9D9Swrl5XO06WojSpN0yEM16Rdrrx3eU3gl+y62P9qShX12bKBkr?=
 =?us-ascii?Q?6JhUBwgwbqqxFAZsnvcVQmPEqk18MP5nnsmmCeBQXX8B2eSbgGWjKP8SGNGV?=
 =?us-ascii?Q?77kggx/tFizr+UoWeZz8p+EZu0i/pv5yeekBYHNsEK7XDcqRzv2FJDPUos4e?=
 =?us-ascii?Q?/PaMsOzGkLG2OdduYleOV1OYIJqQqaH/hZ6vH7OPuLQwvg3hsFFXOEb3GWX6?=
 =?us-ascii?Q?6IYZbrCrcChNeV/a2xm5A6og9vXiJzD8PeKydgkudhJa8hcKgBhxdVln6DTJ?=
 =?us-ascii?Q?Ad1fYvY2NVjS0ABZp3B3Lg2LPFHkcGurlFd2xqdD8LJVHa+69GadrbVYv4rt?=
 =?us-ascii?Q?DuOH/xsFhL0q8q6Y2aNjKsuWO3W7Xy6OtxOBOG7FKFGH6vZ7/8mVr9SjnJYg?=
 =?us-ascii?Q?K8rP3i/c7vY1i5e4EK4fsqNVsbCAliYi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AqCy+sRaEdi0BYr1AWHy6B7ApuuG1m1Xdh23j4Kr9FMkEl5cIXC2lT7G8zAe?=
 =?us-ascii?Q?x8+vMYN4NoRs8bFe87wDOoLw/N0+7yh3tZNXLKf8FNxD6jpJVr8XmFW0OJ0m?=
 =?us-ascii?Q?wRjSazjXHBVqXN/GK+uwC+2766T/25ZPRxwgzVKCnTaEvC6fmrmARbBkAYTY?=
 =?us-ascii?Q?K+2TAVYZxJbOL1W95VKTYj72hnipNqC8WdRHE9q5CAyEyHD2hke15LVRF7Nd?=
 =?us-ascii?Q?qghIvKkJxQSPe4PLN8+BYkDqwJ6IXd1CtCh1YVv7MB8C9nXh+2+9n3LZVWu/?=
 =?us-ascii?Q?ZNddAlyPvVH20JE0XeJbFUZZzhDj7Fv2vHn5UVWsP9jGbAtLXOmjS07N55Ti?=
 =?us-ascii?Q?xSQwzmkk4mTRD3YVje+ZNOzXRet3qCb0+5h2UBNj6MHaOdChXCUKip35PnhW?=
 =?us-ascii?Q?8SyfPRXct0L9vi17ZhJXKr84mjAjC1JHAMbMggfYQCDyWX5Zd8117A+OcFka?=
 =?us-ascii?Q?NWWwq+wVHJP5i27HXRQmsd462wCThFWxYeChDYcly/Vl3fCxO9yt6Hdp+Nlt?=
 =?us-ascii?Q?V5j9HxOC55oL446Z5P+4T/dqSZOlpmrNlPEiNof8n9NPcuLogqL0HB8mgPCM?=
 =?us-ascii?Q?Jy45cdqRwb8G9eoZEn2ZKzlSDMDkZ7awTnrTX90F2K/H7jxl5MSCmxyVp4IS?=
 =?us-ascii?Q?CN95DEsc0GWWmxsH5xzoMUp+jh+eZ9vgXjzNRa/taDrWQ2LOxK6hVqC6CV3Q?=
 =?us-ascii?Q?FYUN9SZ9ZZE93QvQKRPqUpclF7v1nvYuxp/2Pvrgb5lveW8Yq0nv4H4SNJMX?=
 =?us-ascii?Q?LxYXBm3YXsUemtB99oSCBMeXUK0gsEKn+RxnWuqqpudLhL1C3M80LNZmzr6a?=
 =?us-ascii?Q?l5U8AkMOTN3RNy0oyvayT6Y1aNlunRE5nJUqWNSATdgxWrIgnVU46tMcj8Rl?=
 =?us-ascii?Q?TE5KEfp16WfaryC/NUvtOUBJJlc7kcoWT3ja5YxdfAo+zJwomzl2EeJIaMBJ?=
 =?us-ascii?Q?ZvqXMTgWz4xGKzZIwxKfzbEim3w9qMPrUsc1lHLus2sEa1uQjtTbD1DCCPiV?=
 =?us-ascii?Q?V4T6drOcAiWNaeHKdZl6YDeazuYwMNGj1aSdRP3/LuGRDsClkBLcsF5iqweI?=
 =?us-ascii?Q?hfQOEFVelCGBI1Llhc7z615hvnBsNvTygw7n+oT+jcMQAk60SVQ6ti2712wm?=
 =?us-ascii?Q?eRe+2yRHnKBDnMQFV4zbv81pDKC+qgRn55Z9Slr20kHGnXSnRp8mssnKsoZj?=
 =?us-ascii?Q?uX9SzRBgBO4y4ShpHVAp8qN5Xrh1TkbK5iFbKPKHJwjc/AQzpf48dA3tU/Vv?=
 =?us-ascii?Q?ky0VxKmyEXwdS/Iwgs8OhgFTwSE0zthceveckd4TWRiVZ7fbiZp9GZ1c+uqI?=
 =?us-ascii?Q?7ScujzvwsNzZ0E1yRoC8N8VoMoP5g4fF9mQ3nfi/G0XlVEnExwTla/ub+bpx?=
 =?us-ascii?Q?3NwBped2DnNKksJYjqulIT9jvYchrsvCvL2By0nBsOe8pMHPDgziAh76ZZhs?=
 =?us-ascii?Q?boXlKJFDDVQw0bN2pyWb4gAaCNH7fh8BcCmVVR+QZe8ZCMCB1oK3x66mosEP?=
 =?us-ascii?Q?1udPO2hbPQurSJDzB7L+SRShIgR8P16avAxBpOKAnYuEBhcEjQ0A70hnSduz?=
 =?us-ascii?Q?3O+l/n8uueoBddmlvEJC3hJGyF0KdcZOGNPaEyqcHv/M7ZX4g89ScFixKCSs?=
 =?us-ascii?Q?Ly82oe3Aekn/rRKNCin70KQ=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d45160f-39d8-47fc-822d-08de2f60f56c
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 16:04:21.4747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H0udlyITKNVS1vDS1CA94ELN0zyw5VN9AXFRPjC6I0eA5LbxKoEyNY0b3PaSoQ0Ln858GZ9j3aIBWJapYDQBpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2050

Add and use new fields in the common control register to convey both
offset and size for each memory window (MW), so that it can correctly
handle flexible MW layouts and support partial BAR mappings.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..91d3f8e05807 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -36,12 +36,13 @@
 #define NTB_EPF_LOWER_SIZE	0x18
 #define NTB_EPF_UPPER_SIZE	0x1C
 #define NTB_EPF_MW_COUNT	0x20
-#define NTB_EPF_MW1_OFFSET	0x24
-#define NTB_EPF_SPAD_OFFSET	0x28
-#define NTB_EPF_SPAD_COUNT	0x2C
-#define NTB_EPF_DB_ENTRY_SIZE	0x30
-#define NTB_EPF_DB_DATA(n)	(0x34 + (n) * 4)
-#define NTB_EPF_DB_OFFSET(n)	(0xB4 + (n) * 4)
+#define NTB_EPF_MW_OFFSET(n)	(0x24 + (n) * 4)
+#define NTB_EPF_MW_SIZE(n)	(0x34 + (n) * 4)
+#define NTB_EPF_SPAD_OFFSET	0x44
+#define NTB_EPF_SPAD_COUNT	0x48
+#define NTB_EPF_DB_ENTRY_SIZE	0x4C
+#define NTB_EPF_DB_DATA(n)	(0x50 + (n) * 4)
+#define NTB_EPF_DB_OFFSET(n)	(0xD0 + (n) * 4)
 
 #define NTB_EPF_MIN_DB_COUNT	3
 #define NTB_EPF_MAX_DB_COUNT	31
@@ -451,11 +452,12 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 				    phys_addr_t *base, resource_size_t *size)
 {
 	struct ntb_epf_dev *ndev = ntb_ndev(ntb);
-	u32 offset = 0;
+	resource_size_t bar_sz;
+	u32 offset, sz;
 	int bar;
 
-	if (idx == 0)
-		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
+	offset = readl(ndev->ctrl_reg + NTB_EPF_MW_OFFSET(idx));
+	sz = readl(ndev->ctrl_reg + NTB_EPF_MW_SIZE(idx));
 
 	bar = ntb_epf_mw_to_bar(ndev, idx);
 	if (bar < 0)
@@ -464,8 +466,11 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
 
-	if (size)
-		*size = pci_resource_len(ndev->ntb.pdev, bar) - offset;
+	if (size) {
+		bar_sz = pci_resource_len(ndev->ntb.pdev, bar);
+		*size = sz ? min_t(resource_size_t, sz, bar_sz - offset)
+			   : (bar_sz > offset ? bar_sz - offset : 0);
+	}
 
 	return 0;
 }
-- 
2.48.1


