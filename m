Return-Path: <dmaengine+bounces-7789-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B59DCC8ED4
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 18:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 57DF83039DE5
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 17:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB3634B183;
	Wed, 17 Dec 2025 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="LxOESZ29"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010053.outbound.protection.outlook.com [52.101.229.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10008349B06;
	Wed, 17 Dec 2025 16:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765990271; cv=fail; b=bAMRXHj91ZZQhXqINBETNlsFofOIfbgPIbtkf5+A7H8lcZsGJc1oG2v/G9BgMkqcq3LO3PgzqvcasiCvq6024i3c9W4zZydpA8/Enk9j4GtMqjcVSoH5NusQYinEV1BA8bWZswYAx1f16gMF5D9IriUGdtWHgqb9pwCNe+JNYZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765990271; c=relaxed/simple;
	bh=ylI98fwT+/hYImWzY3eMWp6QcjILvYfNA+tyY3F/P1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=csfg1tJRq/9Xn8zbV52+cWAregXbJwQlDwanXFKHCbluDx0Ka5TjaOtOO2KNna1YZW61780H4wcHGnRZucKGqDwLYjZfiy8KAHu2LxEraWGU1EohPI0NcuwLfnxkyEVQiqs/KH0nH1a+2FLf/haYleYuB41xdQeaihsBx4kkhNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=LxOESZ29; arc=fail smtp.client-ip=52.101.229.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fI+c4zmE6vm/MM7lvE77gms8ZszY0L/YFmWpbEeJsTiSAoMpCdrGzxf0XJuuXPXyfQyF/dHLfMEH/eFGBk67L3qEboDXFW+iYlt3ez7ZPbLwgr77i4+FDkznP9X5jXgSz4KNfUsFlneo4/UwJNOEfixB+OdHr/3Ik14eygY9EqTP4wA7NTNst2j909P+tQiPhgaaKPNXzP2JEX2IADmeu7x7qYRmYsh0OsLkzWmnLGsa2QYm8ImiRuFURrjMjb27W4ohBOqaNPOhefaUOmgoIys1Ez6WQtcqcCzM24Tis69GxGTFYDKk+JObk2U3ZQCdO3Gx44nsyU5622BbnJr+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6YYcrDuPtoMFX/JbuSd1wp5KoLwbFTSYKMRD/fEs81Y=;
 b=h+5qUOKSjrqpgFeMNmuK47GbUCR2UKM7G77UBdX6HSttM/f0Nv7q0VYtVQufk3Nil9FvEzPuqdxgqyRkxFPbS/pUGCIwVvWeYkX641ucA+h34mUmOLUY6QeGJI7wXXbXvnUA938Go0pskGpcz68AltfsxEX6GS1mvJa2eSqB/cqigQgJjKsTR7aLqHa7iUTV2GbZw2kWnMnm0wptKahVDtzwTa2bCaLQOWSIzDmwHnNdWDCxmVSQK72sAUzL+oRpgiTkAwZQoggh6bPJYiTQKGAjPiZcS0hLL1jiK1MrVr8RE61Yi2vThxQIgaxt0xUoJF77q2Ee74Eh4wq8DTf4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6YYcrDuPtoMFX/JbuSd1wp5KoLwbFTSYKMRD/fEs81Y=;
 b=LxOESZ29NKdX9KORMCmsarUSnN6JiXE/xhvjf3j4qz3broUxgF5gmOAr3ZFWXKPi6r9BPJBJkdt4QR6M3ZTo+8b9BtvlLvocPa/Jq/vNfB/dAGoI3lGbJn1vnx7rae2qh4J+JVW434FbASnIcVwQi3jh/CytyYIZaL+5Z/snjC0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYCP286MB2863.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:306::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:16:29 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 15:16:29 +0000
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
Subject: [RFC PATCH v3 18/35] dmaengine: dw-edma: Add per-channel interrupt routing mode
Date: Thu, 18 Dec 2025 00:15:52 +0900
Message-ID: <20251217151609.3162665-19-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251217151609.3162665-1-den@valinux.co.jp>
References: <20251217151609.3162665-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:371::8) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYCP286MB2863:EE_
X-MS-Office365-Filtering-Correlation-Id: bf9b95bd-280f-484c-3c47-08de3d7f4119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fji93WD+ctlGmeuwNFC9DB+xZ1BXxPjy7E7ReMVX22XxMb0jnIR0V9D0rhzg?=
 =?us-ascii?Q?DQPkhCIYnDZgMjRyScD2nDXXl+NatN4dmEI/VgFWzSI8voTx1TzMT1WuSUUG?=
 =?us-ascii?Q?2LaqiZIc/D2hJg0kQercKSWMh9fKPr0HyEktT9egTqGV80dCgCoogomlKeWX?=
 =?us-ascii?Q?oE2JyMnAvIZ1s8RQuujNCEZWQsIuVqohBPYvO2LPNZhLfVgepfqtNIFMKTZi?=
 =?us-ascii?Q?1hN9t+N5GsmxnRDANsbbVTHCnO432i3sMx6soyyJWj5UOQJzE8atYtlzs81R?=
 =?us-ascii?Q?u6vdp+k6JTMur1FmEIXx6gej1XvyuNSnYONaf5UqFmtT45EGswgPt5IU7AUy?=
 =?us-ascii?Q?XJrda+zJq6hsG6uQGU8ryS2uSvBrjd+fawRo5SWG7pbxivMtaLAK96jKV5k8?=
 =?us-ascii?Q?kdnoiD6hYcn/x7hIUom9Zcq631k9XbE5b7YnRpoPmY1KU9KOvnk8QjZy3jJX?=
 =?us-ascii?Q?IFFfRo7nqGyLI+JRCxVKsAzU9inxabAwSAw+4yEM6k2RemaOIKZZe1bixKgT?=
 =?us-ascii?Q?vEeTidJ814qIu9yD9tQIWsr/N4ojX3GotaxgBalM5riNFBNuxPkNRrrB0XeW?=
 =?us-ascii?Q?QJuA9xjD1O57S5HscI4H/m0ZBBMC8FaiQwre8eRNXbgPFww7LWzbh3UGTOMK?=
 =?us-ascii?Q?zuB/bYBtbMand6uofecHQJgiP6BcYEhTrmgqG3EUzVhU2zm9Zofs5YDbSp3z?=
 =?us-ascii?Q?IAdqc6h7AAdxT2wyJ6n0g1myOfMDEAYxSwVqZ98lFQmGku6wjlgzxD0HOZ4d?=
 =?us-ascii?Q?Ik/A1teu9EyMdEteWVGwDKmuZn3AyMWKDQJUX5HxUsEdRWvioQbNvHwDxBqo?=
 =?us-ascii?Q?9Svf/E4RRvEskhC/myvvnVj3xfBlWRngDv46sxMt6lSly9glyDU987z2F02k?=
 =?us-ascii?Q?PS+COPAQnUDUYmLSR+YjIbBdtLtdr6l+OAmS+y3MZkx5yWPxrt88bv6RprjZ?=
 =?us-ascii?Q?JiN7ZjovdJM8AO2UfiYjtIQ7BZIavIL0BObO24jzMAG+4XVi16e4P7iaJvK6?=
 =?us-ascii?Q?B30wzVMdo0iRzYlntBoXllLlu8H6lwSsPpcZrW7qAXCNicwgEHIet76VX6Nl?=
 =?us-ascii?Q?zFDtzbpz1WuLeTnmkXhN5njam05SSvFuRUjpTEvV2BHDtlgsT4s98+wS4An5?=
 =?us-ascii?Q?OUNTriO1dp7ffQG3YcCixrqcZZos2AzQ2RgP8BvHq0fbZKn6CjfW3DCzF68X?=
 =?us-ascii?Q?hQ+mLmVdv99HaRgYX3QxVJt1CuJfpTLN5EdJzQllOTUgtMRlpTHppCBHm1Wp?=
 =?us-ascii?Q?63q+APF1fIfP7ODNKqEzgpQag9Do5FofgCvG2wRfEuUwsF8W5qrR5btiYdRG?=
 =?us-ascii?Q?shIoLy1oey+xcvKJzchLaTPwPgHS67fs0PyL/qSzwCE/vk8Xr8b7ZfgTzGKk?=
 =?us-ascii?Q?AoF+xAQ44ZYSW9t9yEs6nVh71DrZ9z2ru71d2PcMNWtFCfnjWP0beyTkGUOz?=
 =?us-ascii?Q?fYDuG7JQr2RAYFNFylEUi5J8/HFxZfiO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OhpW3UnPSNJLm9kfskc2AMTBE7x+bcWoTP1a0OTdR61sHYLbG/0ZvqC43Iu2?=
 =?us-ascii?Q?lvQ4k8F8JE6H7reUj/QDOvTqTW5QZ/pmC5P000DPUP4gM3xQS6XXWViQkhjz?=
 =?us-ascii?Q?EOrVdpEiGejV2ubQ+x8z9ttPjcnDActv88lnZ/YXAxmCP9F9bojPsQ2nPLtf?=
 =?us-ascii?Q?HO3iglVQvAOkZOasl2SKJ0me9QEuRR9angRlsckLLTD5e7hhg53v+A2oVkRU?=
 =?us-ascii?Q?XHjr6Hq9O2g7Sgu6CCbkfRNkPn9RrpcRiqBTH+bDkOcatznR2vrTZ0ifRWDs?=
 =?us-ascii?Q?Z2DdmHiJx+d+8r1WmUAiJ+w92+9724bJA0FfZQKLKXvDp9A8F7A5qn+GrFM8?=
 =?us-ascii?Q?iVT9cJC/nNFgHn06GKp3sX5eb/3lJlpK2o5YgW0zpS0YvDt1fyMTQTU9gm1h?=
 =?us-ascii?Q?qapWFPpVpx2zdibDfYZqiEUB2dWSAmXpZuoU/nezrSv3Inc0ZrdUe4JD/Mlf?=
 =?us-ascii?Q?XXZAjsFf8gg0vJDjQluibpnEgjtp1iULLlmFhbWUGCu4cHv7rSHnm4tyOtWT?=
 =?us-ascii?Q?HpE1yBEFthDRpysjiEMY8Ov9dQ35flvPQvAS9P5s1MwOv8gBfJHW8Yk7dOcW?=
 =?us-ascii?Q?hSUcAGs/8vGPctwA8iTvO3bPblMmIoL8dYyt16vaUhg/kh+S7sz4Q58mHUFa?=
 =?us-ascii?Q?72wIc4IDdVaOTLL4+45gvO1in8h27DpjyOoSraha+7I0OMlswWi1+Njz6uH6?=
 =?us-ascii?Q?mzSQEX2aii5btJWFWcPIGhC8FmJc34BjaLRx23XA7xJoJO1EnnfugnaCBpV5?=
 =?us-ascii?Q?gBAZZXbACojB92X8u9vTmxg+cm0FEByL3UI8lWwxQndWSF10Zh623OgHOE+a?=
 =?us-ascii?Q?KKa8Wxkj6BSdI1bV7k6G3qBPSjZDnMSKYvDQTaM2Bf701wkhJ3iUezMC+COb?=
 =?us-ascii?Q?V7LlCzNWwdwLZWVd3h0b1IKnOjKGg66g4eTUmo/N/ZKcorpl8yMTAh2l3/M/?=
 =?us-ascii?Q?UkVIVI6te/3T0Pg5REUBicYF6xF8WlDjpFpEPRFN8uDHWaddWkewHRNW8eIZ?=
 =?us-ascii?Q?1xnJrRm9pcWqLrz4yvPyDZRkC76WnSbZpuCvWbFoulrRU73pjG3OljQi4O8j?=
 =?us-ascii?Q?76MVLCuDYHjkmG7ySV6CgLQ08C0lp/bhBdvd9zgdvGhJ91PDbtLEJTiq9bBe?=
 =?us-ascii?Q?w4FbzBpGTiTCeXgiAjUQtwSh9u8Hhdbk3bLocwQ6lugibIx0gPDvrFhP453C?=
 =?us-ascii?Q?a1z+gr7Uu/sq06+kOZA5DhbwTZ4BNS8+iF55phddB1W+D0M2U8cFpnUDv4TV?=
 =?us-ascii?Q?1QM58tWo4VOfUG7bCy805jGd4YEkRHY2J4T1dKjzUKqs3uDxo5q5N3zDm2ZA?=
 =?us-ascii?Q?b3iMXgZVgzFxOWT5/FGy8jZQBI3wOe36IkY9rHIzNt6vhFipgvCZhsomzKa+?=
 =?us-ascii?Q?O5Q+1F427HgkqoajRVpiAxqspc6rcURfz/nD6nh0BID7ktgbYcnBFFmkF9w6?=
 =?us-ascii?Q?EikEPrxXu62m0O4zGQdvMCiN/Dpdv6HK0eHgxbrwTibEqDeaEykSFfWgsO5L?=
 =?us-ascii?Q?l4OhPK6UkL/Bt3xttobX2rvszWHoX61i4AAF8kdiiM2VGjRbnelWAu/25ZBJ?=
 =?us-ascii?Q?zBlkBOhN9IIr7fLH9fgMG3K98Ek6IyXpxmsGEW+9Gioq2rDtPSRd3tAOmrPs?=
 =?us-ascii?Q?XnaNAUJAHDaNSXnEKsDO7F0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: bf9b95bd-280f-484c-3c47-08de3d7f4119
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:16:29.6291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g1tGRkTKsicqlTOeeAZgtzHZgLW21KhBOQtn4Tu/WMXD4iPRL9BTNnPf5K4YuHr5v6bR2xlcq4QhQ7CqKsX3Ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB2863

DesignWare eDMA linked-list mode supports both local and remote
completion interrupts (LIE/RIE). For remote eDMA users, we need to
decide per-channel whether completion should be handled locally,
remotely, or both.

Introduce a per-channel interrupt routing mode and export a small API to
configure/query it. Update v0 programming so that RIE and local
done/abort interrupt masking follow the selected mode. The default mode
keeps the original behavior, so unless the new APIs are explicitly used,
no functional changes.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.c    | 49 +++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-edma-core.h    |  2 ++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 26 +++++++++-----
 include/linux/dma/edma.h              | 46 +++++++++++++++++++++++++
 4 files changed, 115 insertions(+), 8 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 1b935da65d05..0bceca2d56c5 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -765,6 +765,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = DW_EDMA_CH_IRQ_DEFAULT;
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
@@ -1059,6 +1060,54 @@ int dw_edma_remove(struct dw_edma_chip *chip)
 }
 EXPORT_SYMBOL_GPL(dw_edma_remove);
 
+int dw_edma_chan_irq_config(struct dma_chan *dchan,
+			    enum dw_edma_ch_irq_mode mode)
+{
+	struct dw_edma_chan *chan;
+
+	/* Only LOCAL/REMOTE bits are valid. Zero keeps legacy behaviour. */
+	if (mode & ~(DW_EDMA_CH_IRQ_LOCAL | DW_EDMA_CH_IRQ_REMOTE))
+		return -EINVAL;
+
+	if (!dchan || !dchan->device ||
+	    dchan->device->device_prep_slave_sg_config != dw_edma_device_prep_slave_sg_config)
+		return -ENODEV;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (!chan)
+		return -ENODEV;
+
+	chan->irq_mode = mode;
+
+	dev_vdbg(chan->dw->chip->dev, "Channel: %s[%u] set irq_mode=%u\n",
+		 str_write_read(chan->dir == EDMA_DIR_WRITE),
+		 chan->id, mode);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_irq_config);
+
+bool dw_edma_chan_ignore_irq(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan;
+	struct dw_edma *dw;
+
+	if (!dchan || !dchan->device ||
+	    dchan->device->device_prep_slave_sg_config != dw_edma_device_prep_slave_sg_config)
+		return false;
+
+	chan = dchan2dw_edma_chan(dchan);
+	if (!chan)
+		return false;
+
+	dw = chan->dw;
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+EXPORT_SYMBOL_GPL(dw_edma_chan_ignore_irq);
+
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
 MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..8458d676551a 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..42a254eb9379 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,8 +256,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_done_int(chan);
-		done(chan);
+		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
+			dw_edma_v0_core_clear_done_int(chan);
+			done(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -267,8 +269,10 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
-		dw_edma_v0_core_clear_abort_int(chan);
-		abort(chan);
+		if (!dw_edma_chan_ignore_irq(&chan->vc.chan)) {
+			dw_edma_v0_core_clear_abort_int(chan);
+			abort(chan);
+		}
 
 		ret = IRQ_HANDLED;
 	}
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 11d6eeb19fff..8c1b1d25fa44 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -61,6 +61,40 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/*
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   LIE=1/RIE=1, local interrupt unmasked
+ * @DW_EDMA_CH_IRQ_LOCAL:     LIE=1/RIE=0
+ * @DW_EDMA_CH_IRQ_REMOTE:    LIE=1/RIE=1, local interrupt masked
+ *
+ * Some implementations require using LIE=1/RIE=1 with the local interrupt
+ * masked to generate a remote-only interrupt (rather than LIE=0/RIE=1).
+ * See the DesignWare endpoint databook 5.40, "Hint" below "Figure 8-22
+ * Write Interrupt Generation".
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
+/**
+ * dw_edma_chan_irq_config - configure per-channel interrupt routing
+ * @chan: DMA channel obtained from dma_request_channel()
+ * @mode: interrupt routing mode
+ *
+ * Returns 0 on success, -EINVAL for invalid @mode, or -ENODEV if @chan does
+ * not belong to the DesignWare eDMA driver.
+ */
+int dw_edma_chan_irq_config(struct dma_chan *chan,
+			    enum dw_edma_ch_irq_mode mode);
+
+/**
+ * dw_edma_chan_ignore_irq - tell whether local IRQ handling should be ignored
+ * @chan: DMA channel obtained from dma_request_channel()
+ */
+bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
+
 #if IS_REACHABLE(CONFIG_PCIE_DW)
 /**
  * dw_edma_get_reg_window - get eDMA register base and size
@@ -141,4 +175,16 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
 }
 #endif /* CONFIG_DW_EDMA */
 
+#if !IS_ENABLED(CONFIG_DW_EDMA)
+static inline int dw_edma_chan_irq_config(struct dma_chan *chan,
+					  enum dw_edma_ch_irq_mode mode)
+{
+	return -ENODEV;
+}
+static inline bool dw_edma_chan_ignore_irq(struct dma_chan *chan)
+{
+	return false;
+}
+#endif
+
 #endif /* _DW_EDMA_H */
-- 
2.51.0


