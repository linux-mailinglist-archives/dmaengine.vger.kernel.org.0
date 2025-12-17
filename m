Return-Path: <dmaengine+bounces-7780-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F76CC8ED8
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 18:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50AF23004625
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 17:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77244369964;
	Wed, 17 Dec 2025 15:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PkHoPuKZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010013.outbound.protection.outlook.com [52.101.229.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086E36657C;
	Wed, 17 Dec 2025 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765984676; cv=fail; b=EMCnuSA4yf3rq4CQU7HGM8Elc6LRcsp2+3AL1oVtNIEL8l1u9wouPMF7Pkwkzo/6H+8sTgttYfi8pkvEHbQioyqJU25s3OMvnv5IXXCEktGDlX0Cv9HHIk9CdrAyHp6mKS9ZO5EDaGSYRW1wy8z+kD8GL4wriWFXgpd2/LrKMbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765984676; c=relaxed/simple;
	bh=/1OXLMEl0+xEGADqX4N+3aFF3M9YFod1lihNvIzYdlo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pLgA/sB6PL3cqbMYASORkkNL/C03ii8OCH7UzGe9Ww4joKF756G1Y9dslcbHZ/rrCZfxeIvXaPKduFahxoCCvHFyO2WKEHldeljBRlqJrQzFXnTweq3o3t0Mj1ZBC83Bs5QiYqp9dWNG1kDqflA+KI0fiRi6xNrhtshQC+W95is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PkHoPuKZ; arc=fail smtp.client-ip=52.101.229.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcsrjkzKDGVldEdbKKTPNSclfH4EXp9psQHkPMUZ2lrO352WNz5N0X5dpmLApqJxZogtUv1itZGjq7mq5n/Rn8w0Lqtz5FJEtPEhYCtF5Q92GLcHgfJS3hYrjRBXpklHM1m+NMXJ/6MJzQxSr80DUr0dKzb7DoFElbUsGrAeW3p7otjz7DddBwdVlCrjKe9/9MKQdMyCXSK+ZXDNv1/W93FxY8sRR8wQG8y6xwZn8KxTzlk5rxkX9DuqvPxn/w7kEYiUjrzJbXw4bXxmFwUN0ZTVv1xcHu32qF7Zs4AJDQ9wLaNED9blphBThRM+Cp9znXSyYKbb96Dys47oh6UJgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jP2NFmFhezNJzOBBHMSBbmnhldv6+xAK3DW3wXhut7w=;
 b=t5f4LzLR7qP4m2i3/HTc5nc+ObMqXqpyhE3f4p6UX5y0nSetk01CuoSi+n6NcVF2TQcB0toS651pBku3W9GMwzu2ohKVt1JNTOjakgC3OeQ/dzmevitcAb7jSz28vLs1BVQrqhJZAriKHWkXO9j/sUxZYSZMcRQyxEvQ+/HfURvdX43KUBGaSCZMgjWkp3c93o9j3im2YJAJtNO4/4A5jcZ1VOSnH+SdpmCtWZULTzOcS58wMnJ6mJ482Yt+09CnzztLio7vAPz6xfdqw+ihEqJ6ff8JkQTgYkl4eQYA3NH3BsGdrtFeCW9hCELRSnBqpIu/NBud2ofPWUSXGBnHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jP2NFmFhezNJzOBBHMSBbmnhldv6+xAK3DW3wXhut7w=;
 b=PkHoPuKZmkyzIBnWwFExK4+Onb9EipTagd5w4Mar8EODBASEybyiySNhqI1e2dzuyEkf/XKz4gUUy36rLZeNC1NEZ6I/le+79rkzeTiwaVygwzjf1fug/nkmYpQBHNOt0M4V3IyJO3HaKCR+KM3vEU8qEQ0XnNswT37Ecz2OHck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:17:11 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:17:11 +0000
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
Subject: [RFC PATCH v3 32/35] arm64: dts: renesas: Add Spider RC/EP DTs for NTB with remote DW PCIe eDMA
Date: Thu, 18 Dec 2025 00:16:06 +0900
Message-ID: <20251217151609.3162665-33-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::19) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f302e8-3ca2-4242-58bc-08de3d7f48bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UkNuwyJ7ZgHFpV+z3f+5TOHkZCTqA72dcD5+4EEcG7ifBetYg2tb1r6FF7al?=
 =?us-ascii?Q?Pjn81bQLeQr/ZgfnlymqrPAwBMozXVvAbIHRc4WRUTvtKsXEGdcGwqa7SzcM?=
 =?us-ascii?Q?aPBO+5jk+IUSCqwZ+dpE0EEsGsyyZuJ3gFCEzOY4v03nKIvtAQjJPM3SuB/D?=
 =?us-ascii?Q?YzLScmw2jnFh9NX3HYkGZ2cZiqudiEfxh+cD1Fpd61PXk26mENYRWDZE4fos?=
 =?us-ascii?Q?fhfTTffMEUJJwLiT2HizRJ+dBSxvEm/XzF9sVkRcCBzL+DmdCxid7CeRvfwU?=
 =?us-ascii?Q?3scA3ozg7kkfrSNEdQrerM45x+DRRnhi3BhDSjfT2zMpv0sV68PAmyGKKQET?=
 =?us-ascii?Q?sA2OHsYPh2hv8qyJpXf8ZoAOjUKD7YbVCeBWzu85i+PoQVeW+vEsCw7B8ttN?=
 =?us-ascii?Q?H8Xv8jVeHAMPmT1tUfA9Rle3UXumIViI4NcYTXQIYeFzX0f0vFP4RBwDj4gp?=
 =?us-ascii?Q?KN0KJgE7oSTgWznNDXh+ucpR+dAACImtgEJHh53UMhQdqimrbq/zSQzW1C2q?=
 =?us-ascii?Q?KssXtlw3wlAIDxfw0MeOqIBqCx3102pFfWVIGUiXQ1Z5RGLjOzbIqdqAV8UZ?=
 =?us-ascii?Q?KcbN41pGNYXSLzE9nyezvt3wKV3ohziFhDoEK3HFdcgZq5Q4dRxfSr1GQb+A?=
 =?us-ascii?Q?BnH9au8mW8LbsoxFXlqKXSyIt+Yqvnevr+HQDDQbttgIVPgCPv2ufNA7GqPU?=
 =?us-ascii?Q?5+773CvdapUnukI1u4GxKO8TOrtUTMBCypBJLA9B3EsJcYBJanzWSxe4yBjM?=
 =?us-ascii?Q?lK0T5kvWfJo011H+fDjcopGY0CA+kbKzhTugIZDf2rAD0zIilYG+zvhM42WZ?=
 =?us-ascii?Q?/IA1XhkcDEtxRv1RjbGKcagh46NALrP1TF6teZgftJn/humqx8/NmCUTdfz0?=
 =?us-ascii?Q?dzcWhMZXkyaRjop3Ikr0f9CTdbKIJB8+rypS8NZNhyM6SmckpmgZjLHwLTHg?=
 =?us-ascii?Q?UyxL1HzbWA0scGCcCZemTLPExeLDU6xkiX4RouoGiGeFXq0DI4i0wIXZeW+O?=
 =?us-ascii?Q?5vMmdd+xIc2e/AE4bxDkKBp/e5wt8Up/jHHz3HFMZqi01qRROrW1ZcOfGi+E?=
 =?us-ascii?Q?JBWvPH9kIPm0avxlIrfXKxF75Ab90/FZkkM6o3e8CQdZzYf8ftxm9KMXnPzC?=
 =?us-ascii?Q?QQMwKMo7QfIYswc24B7N30kb+MebKte475HX1bUCXIVYHuASFoPoJRC8YbZj?=
 =?us-ascii?Q?RbhFOEsM7D/HwJ30WNFOv/I1U2HcpruQNFf3XWhfw5JcpXufJBmn4pKsn5xM?=
 =?us-ascii?Q?KWBrB5ZksAopIOOPAqHVQnepoIeOUmKDkIEydfrhOr5drFVprpgSGcguKnNm?=
 =?us-ascii?Q?JwF6a9TxeXSJzPWqfezra9K0ddONoAtvJ2eyMpXxNF8DI9uRd8brCMgBaKQx?=
 =?us-ascii?Q?zv+38hEByeM3tQ0da/ziGY+LCjFkTsl8zJC4ax9BPW1k8Rkw3qqpARPdqs8g?=
 =?us-ascii?Q?MQQPqjSoJ86RkGzjTlKsaeoC5VBCSZ52?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bLqHYW3hWW2Ak0Y+3zKiHqOshVsiz4cxQDqmu7oXx8+5nSBkwIgcfY58ibs9?=
 =?us-ascii?Q?AizHGAqW6jO4OneiOI1zDu02E8/5kDKp1iGaKBXfQ1uJ+AZ/UQmcqx2RUP14?=
 =?us-ascii?Q?24NVs8v9yQOY+8PRBxyqKW5eHwpRNxdSvL1LjDzA+hKfjs6bC7oMFzy6Bcv7?=
 =?us-ascii?Q?2vP0bLC+XxjnVgpAKOPZbUfBDEQ9Bl3sYH7Syr+G6YLSe8Yc19QdpHgfJ/QE?=
 =?us-ascii?Q?tf77vVSSX/4Qgz3h5E8qRe60W07zmEYdP7ijhcyLdmfn1Vec9P1vXEvmDd10?=
 =?us-ascii?Q?O7Oe4kaQ+B3ygNpeNAxEknnm6t+jwH8U037TgARpfpnYSnMvcq3MmuyG5Qa9?=
 =?us-ascii?Q?lHZFRZzB2dizvH6yjiDlTGmF30H5CCGysop0mgAlZQZsPsBiXKOWFWHu4oPc?=
 =?us-ascii?Q?QcqMQzt4A516QbQ67bao8VkULconUlZFI2wBjcz2Exf7wBs1Ur+69t083nrd?=
 =?us-ascii?Q?CDvqCGsqYQp7imf2HWVZ4l7+yPqJQF4AjRH2mwhR5/+MkAivXXDak/U7SFra?=
 =?us-ascii?Q?/nJIJg4+Y+40i8kP5bPwCw9DZmpAcWdYbiw/7kkO52a9b3Xj6mZsJQvb55mX?=
 =?us-ascii?Q?4AmNIjo0hCodyiEw0RJOMgiZ+i5rt7FBwKpTj6zi7Ke+wmLdfLIYzzoP5xyI?=
 =?us-ascii?Q?hFTeH89ooaLBdzTQY9c2+KdKrZXZ9dpMAEtZPPNXmcoGmH7tW64JsSSnf0Lo?=
 =?us-ascii?Q?3YLaS+827ok7D8y1d8sC2b5/D8y3PY1xvx1SHv49Qs8qJsORCc2exqNlpHxg?=
 =?us-ascii?Q?h5D2yD7Mvf6qn09YbWpy1b+Z7INFpCsIIBqtvQ9F0iafsjhumZAfxJh3OYiv?=
 =?us-ascii?Q?RnsrShiTs/VGfuOBRhkKKJHesL570X6A1PTdXeZ3HbA/uAd6r2uVUW2i64wH?=
 =?us-ascii?Q?RW5uJIAezV/xUZdq+ZTPp0eVQEhZJehNckEcv3p1Kjonnr/Z9VJ0oO2IHvXs?=
 =?us-ascii?Q?o+EREuxW35X6FVVXBqvyDe5Wp/LemzFKH/t8CYJ2eq3zIa23NJlE7qN6pfGL?=
 =?us-ascii?Q?ePMI5LLA2Y0+BJ6J5rAfTypJ30Fd1p/+OuI+FydOfI4xtZBA1oJrr3iYLXH8?=
 =?us-ascii?Q?YrYWZ9S5yTnquKv986n0yJNHoCyB6N1WhufKqptfF8qvGCbiQaKMjNDiQUop?=
 =?us-ascii?Q?ws1Erc+S7IFEeg848W8J9sV9YgcEo617MeuTttfbPdCO/fdoOkbC1/QbVSTa?=
 =?us-ascii?Q?4x37Ex17hjQtvVi43ala2mYLj5l3JKZgAEu9CfvqMF95HPF5VGgIVsNJQz8h?=
 =?us-ascii?Q?HTe93NSXIDU/0tQ9woGsDc17fmpcCy86h/Zh1Oxw/dl1FE5YfOGNTgH4GBfH?=
 =?us-ascii?Q?lo7XJiEYIhDTZGcHZCqQ8gTWSkWZF7yGo/JMMv15h1U6d3HyfZ3WNwhapHqC?=
 =?us-ascii?Q?LxBTGf/Yz5zmmJA9SyeItUOKRDsXgsir5GsN8R8do8rKAjrcNRU1oGW79rc9?=
 =?us-ascii?Q?axIS+4LfeEKuzyvalkIiOhANwQQZSpVxHJ/2Q3o2uY3kqCQdsowI0DTzbqcm?=
 =?us-ascii?Q?qFvBQzmIq2giWAljNTZcBhgIukS4ZqSMjQflw74gb3MqbSPB4ZpEa0e6n/MP?=
 =?us-ascii?Q?h4JHENQLFYI1Y5yXUrTGczpiNlZRqVwOBjHCoxS1fLcjHVtL4NtcFRAOuohU?=
 =?us-ascii?Q?/TzrJPoz6dlabbrjmQQl8Sw=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f302e8-3ca2-4242-58bc-08de3d7f48bb
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:42.4198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p62KTlN83cAZQl6OLISeg+irWBGnY6CvKdBI3Zr/hT/Z5wIug4xjeQw7E10RIdgc2/FaBxNLZQ53vtd+ljRHQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

Add dedicated DTs for the Spider CPU+BreakOut boards when used in PCIe
RC/EP mode with DW PCIe eDMA based NTB transport.

 * r8a779f0-spider-rc.dts describes the board in RC mode.

   It reserves 4 MiB of IOVA starting at 0xfe000000, which on this SoC
   is the ECAM/Config aperture of the PCIe host bridge. In stress
   testing with the remote eDMA, allowing generic DMA mappings to occupy
   this range led to immediate instability. The exact mechanism is under
   investigation, but reserving the range avoids the issue in practice.

 * r8a779f0-spider-ep.dts describes the board in EP mode.

   The RC interface is disabled and the EP interface is enabled. IPMMU
   usage matches the RC case.

The base r8a779f0-spider.dts is intentionally left unchanged and
continues to describe the default RC-only board configuration.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 arch/arm64/boot/dts/renesas/Makefile          |  2 +
 .../boot/dts/renesas/r8a779f0-spider-ep.dts   | 37 +++++++++++++
 .../boot/dts/renesas/r8a779f0-spider-rc.dts   | 52 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
 create mode 100644 arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts

diff --git a/arch/arm64/boot/dts/renesas/Makefile b/arch/arm64/boot/dts/renesas/Makefile
index 1fab1b50f20e..e8d312be515b 100644
--- a/arch/arm64/boot/dts/renesas/Makefile
+++ b/arch/arm64/boot/dts/renesas/Makefile
@@ -82,6 +82,8 @@ dtb-$(CONFIG_ARCH_R8A77995) += r8a77995-draak-panel-aa104xd12.dtb
 dtb-$(CONFIG_ARCH_R8A779A0) += r8a779a0-falcon.dtb
 
 dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider.dtb
+dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider-ep.dtb
+dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f0-spider-rc.dtb
 dtb-$(CONFIG_ARCH_R8A779F0) += r8a779f4-s4sk.dtb
 
 dtb-$(CONFIG_ARCH_R8A779G0) += r8a779g0-white-hawk.dtb
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
new file mode 100644
index 000000000000..6753f8497d0d
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-ep.dts
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree Source for the Spider CPU and BreakOut boards
+ * (PCIe EP mode with DW PCIe eDMA used for NTB transport)
+ *
+ * Based on the base r8a779f0-spider.dts.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a779f0-spider-cpu.dtsi"
+#include "r8a779f0-spider-ethernet.dtsi"
+
+/ {
+	model = "Renesas Spider CPU and Breakout boards based on r8a779f0";
+	compatible = "renesas,spider-breakout", "renesas,spider-cpu",
+		     "renesas,r8a779f0";
+};
+
+&i2c4 {
+	eeprom@51 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "breakout-board";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
+};
+
+&pciec0 {
+	status = "disabled";
+};
+
+&pciec0_ep {
+	iommus = <&ipmmu_hc 32>;
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts b/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
new file mode 100644
index 000000000000..c7112862e1e1
--- /dev/null
+++ b/arch/arm64/boot/dts/renesas/r8a779f0-spider-rc.dts
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree Source for the Spider CPU and BreakOut boards
+ * (PCIe RC mode with remote DW PCIe eDMA used for NTB transport)
+ *
+ * Based on the base r8a779f0-spider.dts.
+ *
+ * Copyright (C) 2025 Renesas Electronics Corp.
+ */
+
+/dts-v1/;
+#include "r8a779f0-spider-cpu.dtsi"
+#include "r8a779f0-spider-ethernet.dtsi"
+
+/ {
+	model = "Renesas Spider CPU and Breakout boards based on r8a779f0";
+	compatible = "renesas,spider-breakout", "renesas,spider-cpu",
+		     "renesas,r8a779f0";
+
+	reserved-memory {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		/*
+		 * Reserve 4 MiB of IOVA starting at 0xfe000000. Allowing DMA
+		 * writes whose DAR (destination IOVA) falls numerically inside
+		 * the ECAM/config window has been observed to trigger
+		 * controller misbehavior.
+		 */
+		pciec0_iova_resv: pcie-iova-resv {
+			iommu-addresses = <&pciec0 0x0 0xfe000000 0x0 0x00400000>;
+		};
+	};
+};
+
+&i2c4 {
+	eeprom@51 {
+		compatible = "rohm,br24g01", "atmel,24c01";
+		label = "breakout-board";
+		reg = <0x51>;
+		pagesize = <8>;
+	};
+};
+
+&pciec0 {
+	iommus = <&ipmmu_hc 32>;
+	iommu-map = <0 &ipmmu_hc 32 1>;
+	iommu-map-mask = <0>;
+
+	memory-region = <&pciec0_iova_resv>;
+};
-- 
2.51.0


