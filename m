Return-Path: <dmaengine+bounces-8624-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFFQFMLRfGlbOwIAu9opvQ
	(envelope-from <dmaengine+bounces-8624-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:44:02 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9938EBC26A
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 16:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E5D4302D96F
	for <lists+dmaengine@lfdr.de>; Fri, 30 Jan 2026 15:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33EC933ADB7;
	Fri, 30 Jan 2026 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Umm4LEIv"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4AC8330337;
	Fri, 30 Jan 2026 15:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769787800; cv=fail; b=pzRt+Gl2MIWZ+ZaYLdi3e7gMJEEwIk+PahfaLM1XkBFEllUsDOp5TQTe9vTPKwXWmrT5ojP3MNGEFWGrXDGFqK3uf9NekMdZbsb8eIF/JSdQq5pBx+nH7I97nhQSWaD57WuVmfT9eLUUbOKuabca/FB9ybAAyskGzbU20IOvKL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769787800; c=relaxed/simple;
	bh=e5ZKdt6Nivesc61JRbXdE+db6cag0fbqllb5Qwoz3O0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kBpSgLezvcYZ6geh9sne4hgSmVUYqaDeJvsGW+tArgDbXUr0NS5B8BmkEUNVTKT3Zly7pq2eBdx/ZBIA1b++LN+mKDLWk7+WUUOySWsZIyusDg1GG/5IqrYVBlJjFa/8zni7m6O9c9r+b417dIrt2PHPq/kVWwQBwxJpqkcuazI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Umm4LEIv; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HAPR5EQNkfnHhSLV32HjaoZ4RV/caIaTkryI6rLVOyJbvvzqC/p/5X45SDZBXQ3zA7PJXI1D1DYhEig/sz1cMSkl3frJ8J4lOL3abMb0Dv+mu1pv78PkSpkiJWUAiw1mSaEybp5//NZ+YXHRMmfG65hTDp2E3ZE7062dNXliQoqBIt/G+Hz2uh8AhYKWki/rQLHoOiLEivJyCvHOV9R0mEq0zmHtEiScGtqndlZiWgqBsJwi1z1SDipBJ8cg5dN771Brz2gXNBl9u9zezvZc6Kvazjidb8UX7zCU5XqJWFM1YjJ+4UjBmTVcG5VTOGYJ2dTaIXWNBuZCZwZ/iA2vuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wMiS+dUUrZBe+Pixog9O0YvVNoEt0agxR94PK/i8ef8=;
 b=iQlCSsG6s/zMkJWW1sp6Sml18Gi4QyHL+c1rhmAm31CtsmFfSYk0/0Qqb7ZS4iqP5xP4x9kKmGVrUkGo4jvcFtFCVKAZyZxO/6D8GSz46nxlymeiJB4gukvUNCFjwMG3BQ9o7L4laK1HGpji8HrlG/zywFkInC+VWRbt0zVD3JCi+tuNaB5DYnuSZJGjyHjgIiEjapSz5omFN2pp9fjiJe4jeQ5RoHhOv38x4O0CYXXR2eVC6O55PhxJVPbjWq0cu632ip8c8So9u+ydRcJjNOhfj9bGyuEu3kcDu/9sBIeOWgMSx5nxQGgI/gwAvN+Ag4QVN5twUbu1rTR0lGUpUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wMiS+dUUrZBe+Pixog9O0YvVNoEt0agxR94PK/i8ef8=;
 b=Umm4LEIvYMax2vSiVbSjw+dQc2bHJTTYnhVVfY9r0HMjV987XyRNcXbD7pHyXdxNQ+YRyst/NTDxQ+S0WIO9pcH1UafCCMkrMMaLvPO0py9eYGwU94iNTJ4BIidC3p6+HFVKA5xSlXqPH3zg9w9nM9hJr+9jxXDJmbo+wdfErTIUB4nEqyrakt57K6xDGyGO2liRVvfgMGBtkYNLZ/ZsPrDVYfFNeS5YEzLLj7DmyLou+dCnwaVBuQwOUoYMbUcguDvO6nq7XYFhBOjzzrT3ZBq7p96buDy3TJ4d3sDbR9LkHsWlnANibLP+BM6IkxB9Cs00/JUw6lrbTA/8K36GBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM9PR04MB8698.eurprd04.prod.outlook.com (2603:10a6:20b:43d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 15:43:12 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 15:43:12 +0000
Date: Fri, 30 Jan 2026 10:43:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Cc: peter.ujfalusi@gmail.com, vkoul@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, nm@ti.com,
	ssantosh@kernel.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, vigneshr@ti.com,
	r-sharma3@ti.com, gehariprasath@ti.com
Subject: Re: [PATCH v4 04/19] dmaengine: ti: k3-udma: move descriptor
 management to k3-udma-common.c
Message-ID: <aXzRiDoNu9ObEV02@lizhi-Precision-Tower-5810>
References: <20260130110159.359501-1-s-adivi@ti.com>
 <20260130110159.359501-5-s-adivi@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130110159.359501-5-s-adivi@ti.com>
X-ClientProxiedBy: PH0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::9) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM9PR04MB8698:EE_
X-MS-Office365-Filtering-Correlation-Id: d40abf8c-607e-407e-7214-08de60164626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|1800799024|366016|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?efBdxnoPpN++1f6QM3jILwq/Rx+6qB3+0ID4z1aj5SbVdpya6dVzXoHtEl/2?=
 =?us-ascii?Q?cyB4SVRjEUWTvbLiF7aF2KzevOtSK+/6QouKwDbgyafVrMjZz3GlpXL0wNeo?=
 =?us-ascii?Q?/8VSFoo8gIVo5HNDTpIqHMtl2/i15ke53OGrQ3T/YaD7mT1/lAKzOkPxctOq?=
 =?us-ascii?Q?6fNkfhjsLWao0pZwusVWTGw8zXKW8AwW1K05DCxBprChIif8RwzHSdBi5vtI?=
 =?us-ascii?Q?bofH2D35hQmyLMuwxAObL+/Uh98RKi56mTfUAWf5acc/t785UfeKpRtfLlvV?=
 =?us-ascii?Q?yk/9GkL31P1prrrIaql5RKlfSjhopUex/xxmkqXwEtm/LZJqWKe/N+4r/buI?=
 =?us-ascii?Q?NNv6dXzelX5DG8c2EVDwR8T8A3YUpzDHm/ZltvpYOiC30Lo+dajOFnpHGu/f?=
 =?us-ascii?Q?zsn4/Vm6TASGRW1tu0hGZEAvgpNnx0BipGirNqGiwJ8n8Pqm9sx7HaASdMvv?=
 =?us-ascii?Q?TGO9cIVRYghNFp8mDRPnkcD43z8VlQLnSNsv6kZ269mK5B/oe6s5AepaC6Mg?=
 =?us-ascii?Q?LTMDQN7KEbOI2tvVerOKDUUmiDRuKetFU2aNG+VtluwqRPJvZNux7TF9aJdt?=
 =?us-ascii?Q?GMWI0oFc3deQo7KNbX3f5q2jyaRIxpcvz/o799SC50fNyEN9IOa6wrcjC+Qs?=
 =?us-ascii?Q?hw5HX5S7xxWpQn5YU/oTZ0uumAH14XN3VP46BQgZg5xYokwFJOOJ8axbVwCI?=
 =?us-ascii?Q?7ozYFjfl3OX9XwpAas80TBtHifaqQs8K2/cD+pcP19ikKQMZnjD/VCrH/lq/?=
 =?us-ascii?Q?C1ViSVMqo/QOuD+2hBpAqXxPesDZSGCR3SwjZ5pSpQToaLOV8J9fzZnxr/It?=
 =?us-ascii?Q?VFdF8LiHDehBAUzm2xF7nzEhOO2+CF10/imYyscLUFZbiNkb+vBAjZyzxixG?=
 =?us-ascii?Q?tXroHB42rfUNGZEOSN7w+Qg/LM0SfLDn4OVnb/z8jlpMp0qHSzXKISnNzAvW?=
 =?us-ascii?Q?MGczvSDQu18/aHZc3BX4iGrX1syiuJt5lAAsaXaE7FveZ3BtWQlCOS8k3yPi?=
 =?us-ascii?Q?2tP2XZcuL+KZoQjgZuQnBDqr3vDAoW447gkxRang08tV43NNKiLfYyBwDmf3?=
 =?us-ascii?Q?wKyRaCVnqbK61hrYIwR8LhwqA1V2N67tli2LNyONYglvwufxQXcGJFPmiWYy?=
 =?us-ascii?Q?wdFl6EeP6C/9LujIQ8iPgbnDiz7z49GGFLDPSXbjElDtPjqVpZanwuH3Tb3B?=
 =?us-ascii?Q?pEmtkLf0X7aYE3ZKIGhJGgPtpRcKivH5v7UID5Cj7W8JPldcctcVuNkIiKvx?=
 =?us-ascii?Q?w9qNUtfg4QJ1imYPLCXDTEoSSP9bC8b+SawUhk0e0ZvtyQuZ8Cstf4sfnnGh?=
 =?us-ascii?Q?Kj161AVHJVZWMW39XfHGG+/t2Wbbt3OlqMDGQrJLhYOtjBlWjlZPSSoBVuk0?=
 =?us-ascii?Q?qr3ejCgvbvFC7Cy4uf5BTWj9Ixov5BVpD1rRNhjjZrbUVw9/ShjZSl1mYski?=
 =?us-ascii?Q?LJzaC8oe7jjWrogYQr/z7jdjYEg5kCIdV0sku1eU9cbsmYEX3WNha0AFmfwQ?=
 =?us-ascii?Q?k/V6tDxmbURkpvAlKNOOWa8LfEO6fzn0/tZd9q4P6Lg9Y2DeRBcMBcnp/yYa?=
 =?us-ascii?Q?iafZmGIHRhwkuGdtRY1+kTqm2v68d242DDs2r7r3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(1800799024)(366016)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EbXylDuN+31PUr0f0/j6N6+2Hm59CjU0gAqSHLBRlDmatxY7lLT57fqiO9Re?=
 =?us-ascii?Q?+zOaHsUrOo573Dk8/Vc8U7waESWDoxWvrrWLM5V2chHuKm2nQHqvVIA8bFOS?=
 =?us-ascii?Q?bjsxcTsXuR95x4wwmfGg4tIi4RRt4aOWXmKvW0a7Eo4AC+5iMuqnCe4DiVDr?=
 =?us-ascii?Q?8Zx5mCroNyziyyo+2v4U8jrnxrYTtPMbK9mFt1B9sazYBwA/M/gw9fWuZY3y?=
 =?us-ascii?Q?gJ4IBYG8W+iSpFVNiReiS6qixZ/2eCVybY+4mXR6YKU39Om8pcUY9sgIMqoB?=
 =?us-ascii?Q?kQCjXjUOb7HL+zw6Rqb8e45VNij2GCBHB72MNGjc0i4gYTJEfwo3lvfzlbjn?=
 =?us-ascii?Q?lRLm7q/S6ah8mBWyRavKelQz/B3b5KCLuFiXeaMGljGs4uWf8VqQCE6rv+rQ?=
 =?us-ascii?Q?OTsSK3LYaijnrXBHQvgCnhqqg6m8kv8MxK0DF27Pc5bYv/qqrJC2yRFgWRT+?=
 =?us-ascii?Q?I9tE49L68afutwZCH5zCtAyfqFbGeCBk8/4z3PWB59vPECVVciuBu0s+zOSI?=
 =?us-ascii?Q?qywI4uQiBks3SP2SG2APilWNWN4RJjkNy8nm9pO/32gGjB4Hzk8u/V4wCWQY?=
 =?us-ascii?Q?kHYybBZEqao9bYejtG52x2b6jVecqoJYB+HuXfDOt3U49m6d5rRBrpQLxI2o?=
 =?us-ascii?Q?l1qxyKDLH8GeFH/+Ea6thxa0AXqhzI8HS/mLjiWGveww1McEkW0Jb3itH8qG?=
 =?us-ascii?Q?MG2TID2XDfZ1MODfaox4RKoMB481BfgB43VYhvZVD3Stev3gPoIYWpr1iPEq?=
 =?us-ascii?Q?NVWcYPX9iVj4UCE0Qa7wJh9l+cgJXdj8Di973ltsg4mYWmHyU+UcveFSRdaE?=
 =?us-ascii?Q?TOiDXrN84rj2hwbzG60d5U+dgfVz1dmgCKxGu1Sdz1dKR6YO6cUH555KRaNk?=
 =?us-ascii?Q?VnWCu5cP5ThzisAimhrJzDvXsqM0QSjCF2fczIqLbmwtnywoL26VQfxmfUm/?=
 =?us-ascii?Q?CnJQTUlyPaA477oxgU6r/BEc/qt4wU99gWtPWVj5wJAtQ2Wge6Prkf+1U+T4?=
 =?us-ascii?Q?2zVIYSjUdOyoaT1pT3y766Lf2WFs/hYpzoNgeBelTtom4kNmb9ue3rJWuLOd?=
 =?us-ascii?Q?luoSJvNDnyOUeiuGMYZsjWu253g87aL3DBJk01bkqDVPvH+IlahyVCH0QV7u?=
 =?us-ascii?Q?mkjzlrzgPvmKbLIYtZbh1PLCBsvn/IX/IY/n+9vLZoo+k/PXS8K3HcJDKpLs?=
 =?us-ascii?Q?dWxPuGNvBOfC+OXgd2w1fKrn80La6Yy7tEnmELED0lHg1Mxgu366foQRrYR0?=
 =?us-ascii?Q?Lror+6885I5BOOsjGyYWoRgznA/ypzlNLj4vltw8+9yRVLNMgibH3JcgD9pN?=
 =?us-ascii?Q?G2KPqHYuJOWyDcujKcKvufLCIvubWlUj85Wjuk2sESCkfbX6eNzV2ZgTBM8Z?=
 =?us-ascii?Q?M9B14R4sHMskv06q0T3wMzVXZ6JOZGLDSZSK2wfq/90qPIonxar8VjveBA+F?=
 =?us-ascii?Q?XSOKVy64ztwSbuoKFCnwv7cuP5KbgNIZufvgMLbd4XGOTlYOlHU+wfGwxAgr?=
 =?us-ascii?Q?FiOJ/uwqdIRLmir7bWHyzfvN8C+E6HvlXDI2qvonubd7vy816ZPO+fukg+nv?=
 =?us-ascii?Q?oqvkV9A1R3hONmw42IU5z86slM/Ag2wK+kK4txXXeqiLEDmLT1v6zcfyB5zY?=
 =?us-ascii?Q?bPN/0Gd+YsJLVp8SRR+PKertVsukFQUJChA/Aom7RfdXnBjmOIgw2mtawRNv?=
 =?us-ascii?Q?pTwZ1Odvf2opLZ3b1TJwxUMqeAYRjZLEc5PMyhrbGTFo10cmAzzrLhNBEz1Q?=
 =?us-ascii?Q?5DX7kUFmzA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d40abf8c-607e-407e-7214-08de60164626
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 15:43:12.0644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msCrVos8ucCFu0OFfFAkJmdmZPPor9CECcEJluoYS6M53jFBHOeF4cPYe4j9bbFoJtlaaZoFk7E2v1RnAPFwoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8698
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8624-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,ti.com,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 9938EBC26A
X-Rspamd-Action: no action

On Fri, Jan 30, 2026 at 04:31:44PM +0530, Sai Sree Kartheek Adivi wrote:
> Refactor the K3 UDMA driver by moving all DMA descriptor handling
> functions from k3-udma.c to a new common library, k3-udma-common.c.
>
> This prepares the driver for supporting new K3 UDMA v2 variant
> (used in AM62L) that can reuse the same descriptor handling logic.
>
> To ensure this common code works correctly across all build
> configurations (built-in vs modules), introduce a hidden Kconfig symbol:
> CONFIG_TI_K3_UDMA_COMMON.
>
> No functional changes intended.
>
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  drivers/dma/ti/Kconfig          |    5 +
>  drivers/dma/ti/Makefile         |    1 +
>  drivers/dma/ti/k3-udma-common.c | 1243 +++++++++++++++++++++++++++++++
>  drivers/dma/ti/k3-udma.c        | 1218 ------------------------------

Can you trt use good git option (-C), let git to detect copy?

Frank

>  drivers/dma/ti/k3-udma.h        |   54 ++
>  5 files changed, 1303 insertions(+), 1218 deletions(-)
>  create mode 100644 drivers/dma/ti/k3-udma-common.c
>
> diff --git a/drivers/dma/ti/Kconfig b/drivers/dma/ti/Kconfig
> index cbc30ab627832..712e456015459 100644
> --- a/drivers/dma/ti/Kconfig
> +++ b/drivers/dma/ti/Kconfig
> @@ -42,12 +42,17 @@ config TI_K3_UDMA
>  	select DMA_ENGINE
>  	select DMA_VIRTUAL_CHANNELS
>  	select SOC_TI
> +	select TI_K3_UDMA_COMMON
>  	select TI_K3_RINGACC
>  	select TI_K3_PSIL
>          help
>  	  Enable support for the TI UDMA (Unified DMA) controller. This
>  	  DMA engine is used in AM65x and j721e.
>
> +config TI_K3_UDMA_COMMON
> +	tristate
> +	default n
> +
>  config TI_K3_UDMA_GLUE_LAYER
>  	tristate "Texas Instruments UDMA Glue layer for non DMAengine users"
>  	depends on ARCH_K3 || COMPILE_TEST
> diff --git a/drivers/dma/ti/Makefile b/drivers/dma/ti/Makefile
> index d376c117cecf6..3b91c02e55eaf 100644
> --- a/drivers/dma/ti/Makefile
> +++ b/drivers/dma/ti/Makefile
> @@ -3,6 +3,7 @@ obj-$(CONFIG_TI_CPPI41) += cppi41.o
>  obj-$(CONFIG_TI_EDMA) += edma.o
>  obj-$(CONFIG_DMA_OMAP) += omap-dma.o
>  obj-$(CONFIG_TI_K3_UDMA) += k3-udma.o
> +obj-$(CONFIG_TI_K3_UDMA_COMMON) += k3-udma-common.o
>  obj-$(CONFIG_TI_K3_UDMA_GLUE_LAYER) += k3-udma-glue.o
>  k3-psil-lib-objs := k3-psil.o \
>  		    k3-psil-am654.o \
> diff --git a/drivers/dma/ti/k3-udma-common.c b/drivers/dma/ti/k3-udma-common.c
> new file mode 100644
> index 0000000000000..9cb35759c70bb
> --- /dev/null
> +++ b/drivers/dma/ti/k3-udma-common.c
> @@ -0,0 +1,1243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Copyright (C) 2025 Texas Instruments Incorporated - http://www.ti.com
> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
> + */
> +
> +#include <linux/dmaengine.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/dmapool.h>
> +#include <linux/platform_device.h>
> +#include <linux/soc/ti/k3-ringacc.h>
> +
> +#include "k3-udma.h"
> +
> +struct dma_descriptor_metadata_ops metadata_ops = {
> +	.attach = udma_attach_metadata,
> +	.get_ptr = udma_get_metadata_ptr,
> +	.set_len = udma_set_metadata_len,
> +};
> +
> +struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
> +					    dma_addr_t paddr)
> +{
> +	struct udma_desc *d = uc->terminated_desc;
> +
> +	if (d) {
> +		dma_addr_t desc_paddr = udma_curr_cppi5_desc_paddr(d,
> +								   d->desc_idx);
> +
> +		if (desc_paddr != paddr)
> +			d = NULL;
> +	}
> +
> +	if (!d) {
> +		d = uc->desc;
> +		if (d) {
> +			dma_addr_t desc_paddr = udma_curr_cppi5_desc_paddr(d,
> +									   d->desc_idx);
> +
> +			if (desc_paddr != paddr)
> +				d = NULL;
> +		}
> +	}
> +
> +	return d;
> +}
> +EXPORT_SYMBOL_GPL(udma_udma_desc_from_paddr);
> +
> +void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d)
> +{
> +	if (uc->use_dma_pool) {
> +		int i;
> +
> +		for (i = 0; i < d->hwdesc_count; i++) {
> +			if (!d->hwdesc[i].cppi5_desc_vaddr)
> +				continue;
> +
> +			dma_pool_free(uc->hdesc_pool,
> +				      d->hwdesc[i].cppi5_desc_vaddr,
> +				      d->hwdesc[i].cppi5_desc_paddr);
> +
> +			d->hwdesc[i].cppi5_desc_vaddr = NULL;
> +		}
> +	} else if (d->hwdesc[0].cppi5_desc_vaddr) {
> +		dma_free_coherent(uc->dma_dev, d->hwdesc[0].cppi5_desc_size,
> +				  d->hwdesc[0].cppi5_desc_vaddr,
> +				  d->hwdesc[0].cppi5_desc_paddr);
> +
> +		d->hwdesc[0].cppi5_desc_vaddr = NULL;
> +	}
> +}
> +
> +void udma_purge_desc_work(struct work_struct *work)
> +{
> +	struct udma_dev *ud = container_of(work, typeof(*ud), purge_work);
> +	struct virt_dma_desc *vd, *_vd;
> +	unsigned long flags;
> +	LIST_HEAD(head);
> +
> +	spin_lock_irqsave(&ud->lock, flags);
> +	list_splice_tail_init(&ud->desc_to_purge, &head);
> +	spin_unlock_irqrestore(&ud->lock, flags);
> +
> +	list_for_each_entry_safe(vd, _vd, &head, node) {
> +		struct udma_chan *uc = to_udma_chan(vd->tx.chan);
> +		struct udma_desc *d = to_udma_desc(&vd->tx);
> +
> +		udma_free_hwdesc(uc, d);
> +		list_del(&vd->node);
> +		kfree(d);
> +	}
> +
> +	/* If more to purge, schedule the work again */
> +	if (!list_empty(&ud->desc_to_purge))
> +		schedule_work(&ud->purge_work);
> +}
> +EXPORT_SYMBOL_GPL(udma_purge_desc_work);
> +
> +void udma_desc_free(struct virt_dma_desc *vd)
> +{
> +	struct udma_dev *ud = to_udma_dev(vd->tx.chan->device);
> +	struct udma_chan *uc = to_udma_chan(vd->tx.chan);
> +	struct udma_desc *d = to_udma_desc(&vd->tx);
> +	unsigned long flags;
> +
> +	if (uc->terminated_desc == d)
> +		uc->terminated_desc = NULL;
> +
> +	if (uc->use_dma_pool) {
> +		udma_free_hwdesc(uc, d);
> +		kfree(d);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&ud->lock, flags);
> +	list_add_tail(&vd->node, &ud->desc_to_purge);
> +	spin_unlock_irqrestore(&ud->lock, flags);
> +
> +	schedule_work(&ud->purge_work);
> +}
> +EXPORT_SYMBOL_GPL(udma_desc_free);
> +
> +bool udma_desc_is_rx_flush(struct udma_chan *uc, dma_addr_t addr)
> +{
> +	if (uc->config.dir != DMA_DEV_TO_MEM)
> +		return false;
> +
> +	if (addr == udma_get_rx_flush_hwdesc_paddr(uc))
> +		return true;
> +
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(udma_desc_is_rx_flush);
> +
> +bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
> +{
> +	u32 peer_bcnt, bcnt;
> +
> +	/*
> +	 * Only TX towards PDMA is affected.
> +	 * If DMA_PREP_INTERRUPT is not set by consumer then skip the transfer
> +	 * completion calculation, consumer must ensure that there is no stale
> +	 * data in DMA fabric in this case.
> +	 */
> +	if (uc->config.ep_type == PSIL_EP_NATIVE ||
> +	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
> +		return true;
> +
> +	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
> +	bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> +
> +	/* Transfer is incomplete, store current residue and time stamp */
> +	if (peer_bcnt < bcnt) {
> +		uc->tx_drain.residue = bcnt - peer_bcnt;
> +		uc->tx_drain.tstamp = ktime_get();
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_GPL(udma_is_desc_really_done);
> +
> +struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
> +				     size_t tr_size, int tr_count,
> +				     enum dma_transfer_direction dir)
> +{
> +	struct udma_hwdesc *hwdesc;
> +	struct cppi5_desc_hdr_t *tr_desc;
> +	struct udma_desc *d;
> +	u32 reload_count = 0;
> +	u32 ring_id;
> +
> +	switch (tr_size) {
> +	case 16:
> +	case 32:
> +	case 64:
> +	case 128:
> +		break;
> +	default:
> +		dev_err(uc->ud->dev, "Unsupported TR size of %zu\n", tr_size);
> +		return NULL;
> +	}
> +
> +	/* We have only one descriptor containing multiple TRs */
> +	d = kzalloc(sizeof(*d) + sizeof(d->hwdesc[0]), GFP_NOWAIT);
> +	if (!d)
> +		return NULL;
> +
> +	d->sglen = tr_count;
> +
> +	d->hwdesc_count = 1;
> +	hwdesc = &d->hwdesc[0];
> +
> +	/* Allocate memory for DMA ring descriptor */
> +	if (uc->use_dma_pool) {
> +		hwdesc->cppi5_desc_size = uc->config.hdesc_size;
> +		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
> +							   GFP_NOWAIT,
> +							   &hwdesc->cppi5_desc_paddr);
> +	} else {
> +		hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size,
> +								 tr_count);
> +		hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
> +						uc->ud->desc_align);
> +		hwdesc->cppi5_desc_vaddr = dma_alloc_coherent(uc->ud->dev,
> +							      hwdesc->cppi5_desc_size,
> +							      &hwdesc->cppi5_desc_paddr,
> +							      GFP_NOWAIT);
> +	}
> +
> +	if (!hwdesc->cppi5_desc_vaddr) {
> +		kfree(d);
> +		return NULL;
> +	}
> +
> +	/* Start of the TR req records */
> +	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
> +	/* Start address of the TR response array */
> +	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size * tr_count;
> +
> +	tr_desc = hwdesc->cppi5_desc_vaddr;
> +
> +	if (uc->cyclic)
> +		reload_count = CPPI5_INFO0_TRDESC_RLDCNT_INFINITE;
> +
> +	if (dir == DMA_DEV_TO_MEM)
> +		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
> +	else
> +		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
> +
> +	cppi5_trdesc_init(tr_desc, tr_count, tr_size, 0, reload_count);
> +	cppi5_desc_set_pktids(tr_desc, uc->id,
> +			      CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> +	cppi5_desc_set_retpolicy(tr_desc, 0, ring_id);
> +
> +	return d;
> +}
> +
> +/**
> + * udma_get_tr_counters - calculate TR counters for a given length
> + * @len: Length of the transfer
> + * @align_to: Preferred alignment
> + * @tr0_cnt0: First TR icnt0
> + * @tr0_cnt1: First TR icnt1
> + * @tr1_cnt0: Second (if used) TR icnt0
> + *
> + * For len < SZ_64K only one TR is enough, tr1_cnt0 is not updated
> + * For len >= SZ_64K two TRs are used in a simple way:
> + * First TR: SZ_64K-alignment blocks (tr0_cnt0, tr0_cnt1)
> + * Second TR: the remaining length (tr1_cnt0)
> + *
> + * Returns the number of TRs the length needs (1 or 2)
> + * -EINVAL if the length can not be supported
> + */
> +int udma_get_tr_counters(size_t len, unsigned long align_to,
> +			 u16 *tr0_cnt0, u16 *tr0_cnt1, u16 *tr1_cnt0)
> +{
> +	if (len < SZ_64K) {
> +		*tr0_cnt0 = len;
> +		*tr0_cnt1 = 1;
> +
> +		return 1;
> +	}
> +
> +	if (align_to > 3)
> +		align_to = 3;
> +
> +realign:
> +	*tr0_cnt0 = SZ_64K - BIT(align_to);
> +	if (len / *tr0_cnt0 >= SZ_64K) {
> +		if (align_to) {
> +			align_to--;
> +			goto realign;
> +		}
> +		return -EINVAL;
> +	}
> +
> +	*tr0_cnt1 = len / *tr0_cnt0;
> +	*tr1_cnt0 = len % *tr0_cnt0;
> +
> +	return 2;
> +}
> +
> +struct udma_desc *
> +udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
> +		      unsigned int sglen, enum dma_transfer_direction dir,
> +		      unsigned long tx_flags, void *context)
> +{
> +	struct scatterlist *sgent;
> +	struct udma_desc *d;
> +	struct cppi5_tr_type1_t *tr_req = NULL;
> +	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> +	unsigned int i;
> +	size_t tr_size;
> +	int num_tr = 0;
> +	int tr_idx = 0;
> +	u64 asel;
> +
> +	/* estimate the number of TRs we will need */
> +	for_each_sg(sgl, sgent, sglen, i) {
> +		if (sg_dma_len(sgent) < SZ_64K)
> +			num_tr++;
> +		else
> +			num_tr += 2;
> +	}
> +
> +	/* Now allocate and setup the descriptor. */
> +	tr_size = sizeof(struct cppi5_tr_type1_t);
> +	d = udma_alloc_tr_desc(uc, tr_size, num_tr, dir);
> +	if (!d)
> +		return NULL;
> +
> +	d->sglen = sglen;
> +
> +	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
> +		asel = 0;
> +	else
> +		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> +
> +	tr_req = d->hwdesc[0].tr_req_base;
> +	for_each_sg(sgl, sgent, sglen, i) {
> +		dma_addr_t sg_addr = sg_dma_address(sgent);
> +
> +		num_tr = udma_get_tr_counters(sg_dma_len(sgent), __ffs(sg_addr),
> +					      &tr0_cnt0, &tr0_cnt1, &tr1_cnt0);
> +		if (num_tr < 0) {
> +			dev_err(uc->ud->dev, "size %u is not supported\n",
> +				sg_dma_len(sgent));
> +			udma_free_hwdesc(uc, d);
> +			kfree(d);
> +			return NULL;
> +		}
> +
> +		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
> +			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
> +
> +		sg_addr |= asel;
> +		tr_req[tr_idx].addr = sg_addr;
> +		tr_req[tr_idx].icnt0 = tr0_cnt0;
> +		tr_req[tr_idx].icnt1 = tr0_cnt1;
> +		tr_req[tr_idx].dim1 = tr0_cnt0;
> +		tr_idx++;
> +
> +		if (num_tr == 2) {
> +			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1,
> +				      false, false,
> +				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> +					 CPPI5_TR_CSF_SUPR_EVT);
> +
> +			tr_req[tr_idx].addr = sg_addr + tr0_cnt1 * tr0_cnt0;
> +			tr_req[tr_idx].icnt0 = tr1_cnt0;
> +			tr_req[tr_idx].icnt1 = 1;
> +			tr_req[tr_idx].dim1 = tr1_cnt0;
> +			tr_idx++;
> +		}
> +
> +		d->residue += sg_dma_len(sgent);
> +	}
> +
> +	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags,
> +			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
> +
> +	return d;
> +}
> +
> +struct udma_desc *
> +udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
> +				unsigned int sglen,
> +				enum dma_transfer_direction dir,
> +				unsigned long tx_flags, void *context)
> +{
> +	struct scatterlist *sgent;
> +	struct cppi5_tr_type15_t *tr_req = NULL;
> +	enum dma_slave_buswidth dev_width;
> +	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
> +	u16 tr_cnt0, tr_cnt1;
> +	dma_addr_t dev_addr;
> +	struct udma_desc *d;
> +	unsigned int i;
> +	size_t tr_size, sg_len;
> +	int num_tr = 0;
> +	int tr_idx = 0;
> +	u32 burst, trigger_size, port_window;
> +	u64 asel;
> +
> +	if (dir == DMA_DEV_TO_MEM) {
> +		dev_addr = uc->cfg.src_addr;
> +		dev_width = uc->cfg.src_addr_width;
> +		burst = uc->cfg.src_maxburst;
> +		port_window = uc->cfg.src_port_window_size;
> +	} else if (dir == DMA_MEM_TO_DEV) {
> +		dev_addr = uc->cfg.dst_addr;
> +		dev_width = uc->cfg.dst_addr_width;
> +		burst = uc->cfg.dst_maxburst;
> +		port_window = uc->cfg.dst_port_window_size;
> +	} else {
> +		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
> +		return NULL;
> +	}
> +
> +	if (!burst)
> +		burst = 1;
> +
> +	if (port_window) {
> +		if (port_window != burst) {
> +			dev_err(uc->ud->dev,
> +				"The burst must be equal to port_window\n");
> +			return NULL;
> +		}
> +
> +		tr_cnt0 = dev_width * port_window;
> +		tr_cnt1 = 1;
> +	} else {
> +		tr_cnt0 = dev_width;
> +		tr_cnt1 = burst;
> +	}
> +	trigger_size = tr_cnt0 * tr_cnt1;
> +
> +	/* estimate the number of TRs we will need */
> +	for_each_sg(sgl, sgent, sglen, i) {
> +		sg_len = sg_dma_len(sgent);
> +
> +		if (sg_len % trigger_size) {
> +			dev_err(uc->ud->dev,
> +				"Not aligned SG entry (%zu for %u)\n", sg_len,
> +				trigger_size);
> +			return NULL;
> +		}
> +
> +		if (sg_len / trigger_size < SZ_64K)
> +			num_tr++;
> +		else
> +			num_tr += 2;
> +	}
> +
> +	/* Now allocate and setup the descriptor. */
> +	tr_size = sizeof(struct cppi5_tr_type15_t);
> +	d = udma_alloc_tr_desc(uc, tr_size, num_tr, dir);
> +	if (!d)
> +		return NULL;
> +
> +	d->sglen = sglen;
> +
> +	if (uc->ud->match_data->type == DMA_TYPE_UDMA) {
> +		asel = 0;
> +		csf |= CPPI5_TR_CSF_EOL_ICNT0;
> +	} else {
> +		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> +		dev_addr |= asel;
> +	}
> +
> +	tr_req = d->hwdesc[0].tr_req_base;
> +	for_each_sg(sgl, sgent, sglen, i) {
> +		u16 tr0_cnt2, tr0_cnt3, tr1_cnt2;
> +		dma_addr_t sg_addr = sg_dma_address(sgent);
> +
> +		sg_len = sg_dma_len(sgent);
> +		num_tr = udma_get_tr_counters(sg_len / trigger_size, 0,
> +					      &tr0_cnt2, &tr0_cnt3, &tr1_cnt2);
> +		if (num_tr < 0) {
> +			dev_err(uc->ud->dev, "size %zu is not supported\n",
> +				sg_len);
> +			udma_free_hwdesc(uc, d);
> +			kfree(d);
> +			return NULL;
> +		}
> +
> +		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15, false,
> +			      true, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +		cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
> +		cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
> +				     uc->config.tr_trigger_type,
> +				     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC, 0, 0);
> +
> +		sg_addr |= asel;
> +		if (dir == DMA_DEV_TO_MEM) {
> +			tr_req[tr_idx].addr = dev_addr;
> +			tr_req[tr_idx].icnt0 = tr_cnt0;
> +			tr_req[tr_idx].icnt1 = tr_cnt1;
> +			tr_req[tr_idx].icnt2 = tr0_cnt2;
> +			tr_req[tr_idx].icnt3 = tr0_cnt3;
> +			tr_req[tr_idx].dim1 = (-1) * tr_cnt0;
> +
> +			tr_req[tr_idx].daddr = sg_addr;
> +			tr_req[tr_idx].dicnt0 = tr_cnt0;
> +			tr_req[tr_idx].dicnt1 = tr_cnt1;
> +			tr_req[tr_idx].dicnt2 = tr0_cnt2;
> +			tr_req[tr_idx].dicnt3 = tr0_cnt3;
> +			tr_req[tr_idx].ddim1 = tr_cnt0;
> +			tr_req[tr_idx].ddim2 = trigger_size;
> +			tr_req[tr_idx].ddim3 = trigger_size * tr0_cnt2;
> +		} else {
> +			tr_req[tr_idx].addr = sg_addr;
> +			tr_req[tr_idx].icnt0 = tr_cnt0;
> +			tr_req[tr_idx].icnt1 = tr_cnt1;
> +			tr_req[tr_idx].icnt2 = tr0_cnt2;
> +			tr_req[tr_idx].icnt3 = tr0_cnt3;
> +			tr_req[tr_idx].dim1 = tr_cnt0;
> +			tr_req[tr_idx].dim2 = trigger_size;
> +			tr_req[tr_idx].dim3 = trigger_size * tr0_cnt2;
> +
> +			tr_req[tr_idx].daddr = dev_addr;
> +			tr_req[tr_idx].dicnt0 = tr_cnt0;
> +			tr_req[tr_idx].dicnt1 = tr_cnt1;
> +			tr_req[tr_idx].dicnt2 = tr0_cnt2;
> +			tr_req[tr_idx].dicnt3 = tr0_cnt3;
> +			tr_req[tr_idx].ddim1 = (-1) * tr_cnt0;
> +		}
> +
> +		tr_idx++;
> +
> +		if (num_tr == 2) {
> +			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15,
> +				      false, true,
> +				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
> +			cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
> +					     uc->config.tr_trigger_type,
> +					     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC,
> +					     0, 0);
> +
> +			sg_addr += trigger_size * tr0_cnt2 * tr0_cnt3;
> +			if (dir == DMA_DEV_TO_MEM) {
> +				tr_req[tr_idx].addr = dev_addr;
> +				tr_req[tr_idx].icnt0 = tr_cnt0;
> +				tr_req[tr_idx].icnt1 = tr_cnt1;
> +				tr_req[tr_idx].icnt2 = tr1_cnt2;
> +				tr_req[tr_idx].icnt3 = 1;
> +				tr_req[tr_idx].dim1 = (-1) * tr_cnt0;
> +
> +				tr_req[tr_idx].daddr = sg_addr;
> +				tr_req[tr_idx].dicnt0 = tr_cnt0;
> +				tr_req[tr_idx].dicnt1 = tr_cnt1;
> +				tr_req[tr_idx].dicnt2 = tr1_cnt2;
> +				tr_req[tr_idx].dicnt3 = 1;
> +				tr_req[tr_idx].ddim1 = tr_cnt0;
> +				tr_req[tr_idx].ddim2 = trigger_size;
> +			} else {
> +				tr_req[tr_idx].addr = sg_addr;
> +				tr_req[tr_idx].icnt0 = tr_cnt0;
> +				tr_req[tr_idx].icnt1 = tr_cnt1;
> +				tr_req[tr_idx].icnt2 = tr1_cnt2;
> +				tr_req[tr_idx].icnt3 = 1;
> +				tr_req[tr_idx].dim1 = tr_cnt0;
> +				tr_req[tr_idx].dim2 = trigger_size;
> +
> +				tr_req[tr_idx].daddr = dev_addr;
> +				tr_req[tr_idx].dicnt0 = tr_cnt0;
> +				tr_req[tr_idx].dicnt1 = tr_cnt1;
> +				tr_req[tr_idx].dicnt2 = tr1_cnt2;
> +				tr_req[tr_idx].dicnt3 = 1;
> +				tr_req[tr_idx].ddim1 = (-1) * tr_cnt0;
> +			}
> +			tr_idx++;
> +		}
> +
> +		d->residue += sg_len;
> +	}
> +
> +	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags, csf | CPPI5_TR_CSF_EOP);
> +
> +	return d;
> +}
> +
> +int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
> +			    enum dma_slave_buswidth dev_width,
> +			    u16 elcnt)
> +{
> +	if (uc->config.ep_type != PSIL_EP_PDMA_XY)
> +		return 0;
> +
> +	/* Bus width translates to the element size (ES) */
> +	switch (dev_width) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +		d->static_tr.elsize = 0;
> +		break;
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +		d->static_tr.elsize = 1;
> +		break;
> +	case DMA_SLAVE_BUSWIDTH_3_BYTES:
> +		d->static_tr.elsize = 2;
> +		break;
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +		d->static_tr.elsize = 3;
> +		break;
> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +		d->static_tr.elsize = 4;
> +		break;
> +	default: /* not reached */
> +		return -EINVAL;
> +	}
> +
> +	d->static_tr.elcnt = elcnt;
> +
> +	if (uc->config.pkt_mode || !uc->cyclic) {
> +		/*
> +		 * PDMA must close the packet when the channel is in packet mode.
> +		 * For TR mode when the channel is not cyclic we also need PDMA
> +		 * to close the packet otherwise the transfer will stall because
> +		 * PDMA holds on the data it has received from the peripheral.
> +		 */
> +		unsigned int div = dev_width * elcnt;
> +
> +		if (uc->cyclic)
> +			d->static_tr.bstcnt = d->residue / d->sglen / div;
> +		else
> +			d->static_tr.bstcnt = d->residue / div;
> +	} else if (uc->ud->match_data->type == DMA_TYPE_BCDMA &&
> +		   uc->config.dir == DMA_DEV_TO_MEM &&
> +		   uc->cyclic) {
> +		/*
> +		 * For cyclic mode with BCDMA we have to set EOP in each TR to
> +		 * prevent short packet errors seen on channel teardown. So the
> +		 * PDMA must close the packet after every TR transfer by setting
> +		 * burst count equal to the number of bytes transferred.
> +		 */
> +		struct cppi5_tr_type1_t *tr_req = d->hwdesc[0].tr_req_base;
> +
> +		d->static_tr.bstcnt =
> +			(tr_req->icnt0 * tr_req->icnt1) / dev_width;
> +	} else {
> +		d->static_tr.bstcnt = 0;
> +	}
> +
> +	if (uc->config.dir == DMA_DEV_TO_MEM &&
> +	    d->static_tr.bstcnt > uc->ud->match_data->statictr_z_mask)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +struct udma_desc *
> +udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
> +		       unsigned int sglen, enum dma_transfer_direction dir,
> +		       unsigned long tx_flags, void *context)
> +{
> +	struct scatterlist *sgent;
> +	struct cppi5_host_desc_t *h_desc = NULL;
> +	struct udma_desc *d;
> +	u32 ring_id;
> +	unsigned int i;
> +	u64 asel;
> +
> +	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
> +	if (!d)
> +		return NULL;
> +
> +	d->sglen = sglen;
> +	d->hwdesc_count = sglen;
> +
> +	if (dir == DMA_DEV_TO_MEM)
> +		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
> +	else
> +		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
> +
> +	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
> +		asel = 0;
> +	else
> +		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> +
> +	for_each_sg(sgl, sgent, sglen, i) {
> +		struct udma_hwdesc *hwdesc = &d->hwdesc[i];
> +		dma_addr_t sg_addr = sg_dma_address(sgent);
> +		struct cppi5_host_desc_t *desc;
> +		size_t sg_len = sg_dma_len(sgent);
> +
> +		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
> +							   GFP_NOWAIT,
> +							   &hwdesc->cppi5_desc_paddr);
> +		if (!hwdesc->cppi5_desc_vaddr) {
> +			dev_err(uc->ud->dev,
> +				"descriptor%d allocation failed\n", i);
> +
> +			udma_free_hwdesc(uc, d);
> +			kfree(d);
> +			return NULL;
> +		}
> +
> +		d->residue += sg_len;
> +		hwdesc->cppi5_desc_size = uc->config.hdesc_size;
> +		desc = hwdesc->cppi5_desc_vaddr;
> +
> +		if (i == 0) {
> +			cppi5_hdesc_init(desc, 0, 0);
> +			/* Flow and Packed ID */
> +			cppi5_desc_set_pktids(&desc->hdr, uc->id,
> +					      CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> +			cppi5_desc_set_retpolicy(&desc->hdr, 0, ring_id);
> +		} else {
> +			cppi5_hdesc_reset_hbdesc(desc);
> +			cppi5_desc_set_retpolicy(&desc->hdr, 0, 0xffff);
> +		}
> +
> +		/* attach the sg buffer to the descriptor */
> +		sg_addr |= asel;
> +		cppi5_hdesc_attach_buf(desc, sg_addr, sg_len, sg_addr, sg_len);
> +
> +		/* Attach link as host buffer descriptor */
> +		if (h_desc)
> +			cppi5_hdesc_link_hbdesc(h_desc,
> +						hwdesc->cppi5_desc_paddr | asel);
> +
> +		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA ||
> +		    dir == DMA_MEM_TO_DEV)
> +			h_desc = desc;
> +	}
> +
> +	if (d->residue >= SZ_4M) {
> +		dev_err(uc->ud->dev,
> +			"%s: Transfer size %u is over the supported 4M range\n",
> +			__func__, d->residue);
> +		udma_free_hwdesc(uc, d);
> +		kfree(d);
> +		return NULL;
> +	}
> +
> +	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> +	cppi5_hdesc_set_pktlen(h_desc, d->residue);
> +
> +	return d;
> +}
> +
> +int udma_attach_metadata(struct dma_async_tx_descriptor *desc,
> +			 void *data, size_t len)
> +{
> +	struct udma_desc *d = to_udma_desc(desc);
> +	struct udma_chan *uc = to_udma_chan(desc->chan);
> +	struct cppi5_host_desc_t *h_desc;
> +	u32 psd_size = len;
> +	u32 flags = 0;
> +
> +	if (!uc->config.pkt_mode || !uc->config.metadata_size)
> +		return -EOPNOTSUPP;
> +
> +	if (!data || len > uc->config.metadata_size)
> +		return -EINVAL;
> +
> +	if (uc->config.needs_epib && len < CPPI5_INFO0_HDESC_EPIB_SIZE)
> +		return -EINVAL;
> +
> +	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> +	if (d->dir == DMA_MEM_TO_DEV)
> +		memcpy(h_desc->epib, data, len);
> +
> +	if (uc->config.needs_epib)
> +		psd_size -= CPPI5_INFO0_HDESC_EPIB_SIZE;
> +
> +	d->metadata = data;
> +	d->metadata_size = len;
> +	if (uc->config.needs_epib)
> +		flags |= CPPI5_INFO0_HDESC_EPIB_PRESENT;
> +
> +	cppi5_hdesc_update_flags(h_desc, flags);
> +	cppi5_hdesc_update_psdata_size(h_desc, psd_size);
> +
> +	return 0;
> +}
> +
> +void *udma_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
> +			    size_t *payload_len, size_t *max_len)
> +{
> +	struct udma_desc *d = to_udma_desc(desc);
> +	struct udma_chan *uc = to_udma_chan(desc->chan);
> +	struct cppi5_host_desc_t *h_desc;
> +
> +	if (!uc->config.pkt_mode || !uc->config.metadata_size)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> +
> +	*max_len = uc->config.metadata_size;
> +
> +	*payload_len = cppi5_hdesc_epib_present(&h_desc->hdr) ?
> +		       CPPI5_INFO0_HDESC_EPIB_SIZE : 0;
> +	*payload_len += cppi5_hdesc_get_psdata_size(h_desc);
> +
> +	return h_desc->epib;
> +}
> +
> +int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
> +			  size_t payload_len)
> +{
> +	struct udma_desc *d = to_udma_desc(desc);
> +	struct udma_chan *uc = to_udma_chan(desc->chan);
> +	struct cppi5_host_desc_t *h_desc;
> +	u32 psd_size = payload_len;
> +	u32 flags = 0;
> +
> +	if (!uc->config.pkt_mode || !uc->config.metadata_size)
> +		return -EOPNOTSUPP;
> +
> +	if (payload_len > uc->config.metadata_size)
> +		return -EINVAL;
> +
> +	if (uc->config.needs_epib && payload_len < CPPI5_INFO0_HDESC_EPIB_SIZE)
> +		return -EINVAL;
> +
> +	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> +
> +	if (uc->config.needs_epib) {
> +		psd_size -= CPPI5_INFO0_HDESC_EPIB_SIZE;
> +		flags |= CPPI5_INFO0_HDESC_EPIB_PRESENT;
> +	}
> +
> +	cppi5_hdesc_update_flags(h_desc, flags);
> +	cppi5_hdesc_update_psdata_size(h_desc, psd_size);
> +
> +	return 0;
> +}
> +
> +struct dma_async_tx_descriptor *
> +udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +		   unsigned int sglen, enum dma_transfer_direction dir,
> +		   unsigned long tx_flags, void *context)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	enum dma_slave_buswidth dev_width;
> +	struct udma_desc *d;
> +	u32 burst;
> +
> +	if (dir != uc->config.dir &&
> +	    (uc->config.dir == DMA_MEM_TO_MEM && !uc->config.tr_trigger_type)) {
> +		dev_err(chan->device->dev,
> +			"%s: chan%d is for %s, not supporting %s\n",
> +			__func__, uc->id,
> +			dmaengine_get_direction_text(uc->config.dir),
> +			dmaengine_get_direction_text(dir));
> +		return NULL;
> +	}
> +
> +	if (dir == DMA_DEV_TO_MEM) {
> +		dev_width = uc->cfg.src_addr_width;
> +		burst = uc->cfg.src_maxburst;
> +	} else if (dir == DMA_MEM_TO_DEV) {
> +		dev_width = uc->cfg.dst_addr_width;
> +		burst = uc->cfg.dst_maxburst;
> +	} else {
> +		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
> +		return NULL;
> +	}
> +
> +	if (!burst)
> +		burst = 1;
> +
> +	uc->config.tx_flags = tx_flags;
> +
> +	if (uc->config.pkt_mode)
> +		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
> +					   context);
> +	else if (is_slave_direction(uc->config.dir))
> +		d = udma_prep_slave_sg_tr(uc, sgl, sglen, dir, tx_flags,
> +					  context);
> +	else
> +		d = udma_prep_slave_sg_triggered_tr(uc, sgl, sglen, dir,
> +						    tx_flags, context);
> +
> +	if (!d)
> +		return NULL;
> +
> +	d->dir = dir;
> +	d->desc_idx = 0;
> +	d->tr_idx = 0;
> +
> +	/* static TR for remote PDMA */
> +	if (udma_configure_statictr(uc, d, dev_width, burst)) {
> +		dev_err(uc->ud->dev,
> +			"%s: StaticTR Z is limited to maximum %u (%u)\n",
> +			__func__, uc->ud->match_data->statictr_z_mask,
> +			d->static_tr.bstcnt);
> +
> +		udma_free_hwdesc(uc, d);
> +		kfree(d);
> +		return NULL;
> +	}
> +
> +	if (uc->config.metadata_size)
> +		d->vd.tx.metadata_ops = &metadata_ops;
> +
> +	return vchan_tx_prep(&uc->vc, &d->vd, tx_flags);
> +}
> +EXPORT_SYMBOL_GPL(udma_prep_slave_sg);
> +
> +struct udma_desc *
> +udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
> +			size_t buf_len, size_t period_len,
> +			enum dma_transfer_direction dir, unsigned long flags)
> +{
> +	struct udma_desc *d;
> +	size_t tr_size, period_addr;
> +	struct cppi5_tr_type1_t *tr_req;
> +	unsigned int periods = buf_len / period_len;
> +	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> +	unsigned int i;
> +	int num_tr;
> +	u32 period_csf = 0;
> +
> +	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
> +				      &tr0_cnt1, &tr1_cnt0);
> +	if (num_tr < 0) {
> +		dev_err(uc->ud->dev, "size %zu is not supported\n",
> +			period_len);
> +		return NULL;
> +	}
> +
> +	/* Now allocate and setup the descriptor. */
> +	tr_size = sizeof(struct cppi5_tr_type1_t);
> +	d = udma_alloc_tr_desc(uc, tr_size, periods * num_tr, dir);
> +	if (!d)
> +		return NULL;
> +
> +	tr_req = d->hwdesc[0].tr_req_base;
> +	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
> +		period_addr = buf_addr;
> +	else
> +		period_addr = buf_addr |
> +			((u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT);
> +
> +	/*
> +	 * For BCDMA <-> PDMA transfers, the EOP flag needs to be set on the
> +	 * last TR of a descriptor, to mark the packet as complete.
> +	 * This is required for getting the teardown completion message in case
> +	 * of TX, and to avoid short-packet error in case of RX.
> +	 *
> +	 * As we are in cyclic mode, we do not know which period might be the
> +	 * last one, so set the flag for each period.
> +	 */
> +	if (uc->config.ep_type == PSIL_EP_PDMA_XY &&
> +	    uc->ud->match_data->type == DMA_TYPE_BCDMA) {
> +		period_csf = CPPI5_TR_CSF_EOP;
> +	}
> +
> +	for (i = 0; i < periods; i++) {
> +		int tr_idx = i * num_tr;
> +
> +		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
> +			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +
> +		tr_req[tr_idx].addr = period_addr;
> +		tr_req[tr_idx].icnt0 = tr0_cnt0;
> +		tr_req[tr_idx].icnt1 = tr0_cnt1;
> +		tr_req[tr_idx].dim1 = tr0_cnt0;
> +
> +		if (num_tr == 2) {
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> +					 CPPI5_TR_CSF_SUPR_EVT);
> +			tr_idx++;
> +
> +			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1,
> +				      false, false,
> +				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +
> +			tr_req[tr_idx].addr = period_addr + tr0_cnt1 * tr0_cnt0;
> +			tr_req[tr_idx].icnt0 = tr1_cnt0;
> +			tr_req[tr_idx].icnt1 = 1;
> +			tr_req[tr_idx].dim1 = tr1_cnt0;
> +		}
> +
> +		if (!(flags & DMA_PREP_INTERRUPT))
> +			period_csf |= CPPI5_TR_CSF_SUPR_EVT;
> +
> +		if (period_csf)
> +			cppi5_tr_csf_set(&tr_req[tr_idx].flags, period_csf);
> +
> +		period_addr += period_len;
> +	}
> +
> +	return d;
> +}
> +
> +struct udma_desc *
> +udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
> +			 size_t buf_len, size_t period_len,
> +			 enum dma_transfer_direction dir, unsigned long flags)
> +{
> +	struct udma_desc *d;
> +	u32 ring_id;
> +	int i;
> +	int periods = buf_len / period_len;
> +
> +	if (periods > (K3_UDMA_DEFAULT_RING_SIZE - 1))
> +		return NULL;
> +
> +	if (period_len >= SZ_4M)
> +		return NULL;
> +
> +	d = kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
> +	if (!d)
> +		return NULL;
> +
> +	d->hwdesc_count = periods;
> +
> +	/* TODO: re-check this... */
> +	if (dir == DMA_DEV_TO_MEM)
> +		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
> +	else
> +		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
> +
> +	if (uc->ud->match_data->type != DMA_TYPE_UDMA)
> +		buf_addr |= (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> +
> +	for (i = 0; i < periods; i++) {
> +		struct udma_hwdesc *hwdesc = &d->hwdesc[i];
> +		dma_addr_t period_addr = buf_addr + (period_len * i);
> +		struct cppi5_host_desc_t *h_desc;
> +
> +		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
> +							   GFP_NOWAIT,
> +							   &hwdesc->cppi5_desc_paddr);
> +		if (!hwdesc->cppi5_desc_vaddr) {
> +			dev_err(uc->ud->dev,
> +				"descriptor%d allocation failed\n", i);
> +
> +			udma_free_hwdesc(uc, d);
> +			kfree(d);
> +			return NULL;
> +		}
> +
> +		hwdesc->cppi5_desc_size = uc->config.hdesc_size;
> +		h_desc = hwdesc->cppi5_desc_vaddr;
> +
> +		cppi5_hdesc_init(h_desc, 0, 0);
> +		cppi5_hdesc_set_pktlen(h_desc, period_len);
> +
> +		/* Flow and Packed ID */
> +		cppi5_desc_set_pktids(&h_desc->hdr, uc->id,
> +				      CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> +		cppi5_desc_set_retpolicy(&h_desc->hdr, 0, ring_id);
> +
> +		/* attach each period to a new descriptor */
> +		cppi5_hdesc_attach_buf(h_desc,
> +				       period_addr, period_len,
> +				       period_addr, period_len);
> +	}
> +
> +	return d;
> +}
> +
> +struct dma_async_tx_descriptor *
> +udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> +		     size_t period_len, enum dma_transfer_direction dir,
> +		     unsigned long flags)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	enum dma_slave_buswidth dev_width;
> +	struct udma_desc *d;
> +	u32 burst;
> +
> +	if (dir != uc->config.dir) {
> +		dev_err(chan->device->dev,
> +			"%s: chan%d is for %s, not supporting %s\n",
> +			__func__, uc->id,
> +			dmaengine_get_direction_text(uc->config.dir),
> +			dmaengine_get_direction_text(dir));
> +		return NULL;
> +	}
> +
> +	uc->cyclic = true;
> +
> +	if (dir == DMA_DEV_TO_MEM) {
> +		dev_width = uc->cfg.src_addr_width;
> +		burst = uc->cfg.src_maxburst;
> +	} else if (dir == DMA_MEM_TO_DEV) {
> +		dev_width = uc->cfg.dst_addr_width;
> +		burst = uc->cfg.dst_maxburst;
> +	} else {
> +		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
> +		return NULL;
> +	}
> +
> +	if (!burst)
> +		burst = 1;
> +
> +	if (uc->config.pkt_mode)
> +		d = udma_prep_dma_cyclic_pkt(uc, buf_addr, buf_len, period_len,
> +					     dir, flags);
> +	else
> +		d = udma_prep_dma_cyclic_tr(uc, buf_addr, buf_len, period_len,
> +					    dir, flags);
> +
> +	if (!d)
> +		return NULL;
> +
> +	d->sglen = buf_len / period_len;
> +
> +	d->dir = dir;
> +	d->residue = buf_len;
> +
> +	/* static TR for remote PDMA */
> +	if (udma_configure_statictr(uc, d, dev_width, burst)) {
> +		dev_err(uc->ud->dev,
> +			"%s: StaticTR Z is limited to maximum %u (%u)\n",
> +			__func__, uc->ud->match_data->statictr_z_mask,
> +			d->static_tr.bstcnt);
> +
> +		udma_free_hwdesc(uc, d);
> +		kfree(d);
> +		return NULL;
> +	}
> +
> +	if (uc->config.metadata_size)
> +		d->vd.tx.metadata_ops = &metadata_ops;
> +
> +	return vchan_tx_prep(&uc->vc, &d->vd, flags);
> +}
> +EXPORT_SYMBOL_GPL(udma_prep_dma_cyclic);
> +
> +struct dma_async_tx_descriptor *
> +udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> +		     size_t len, unsigned long tx_flags)
> +{
> +	struct udma_chan *uc = to_udma_chan(chan);
> +	struct udma_desc *d;
> +	struct cppi5_tr_type15_t *tr_req;
> +	int num_tr;
> +	size_t tr_size = sizeof(struct cppi5_tr_type15_t);
> +	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> +	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
> +
> +	if (uc->config.dir != DMA_MEM_TO_MEM) {
> +		dev_err(chan->device->dev,
> +			"%s: chan%d is for %s, not supporting %s\n",
> +			__func__, uc->id,
> +			dmaengine_get_direction_text(uc->config.dir),
> +			dmaengine_get_direction_text(DMA_MEM_TO_MEM));
> +		return NULL;
> +	}
> +
> +	num_tr = udma_get_tr_counters(len, __ffs(src | dest), &tr0_cnt0,
> +				      &tr0_cnt1, &tr1_cnt0);
> +	if (num_tr < 0) {
> +		dev_err(uc->ud->dev, "size %zu is not supported\n",
> +			len);
> +		return NULL;
> +	}
> +
> +	d = udma_alloc_tr_desc(uc, tr_size, num_tr, DMA_MEM_TO_MEM);
> +	if (!d)
> +		return NULL;
> +
> +	d->dir = DMA_MEM_TO_MEM;
> +	d->desc_idx = 0;
> +	d->tr_idx = 0;
> +	d->residue = len;
> +
> +	if (uc->ud->match_data->type != DMA_TYPE_UDMA) {
> +		src |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
> +		dest |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
> +	} else {
> +		csf |= CPPI5_TR_CSF_EOL_ICNT0;
> +	}
> +
> +	tr_req = d->hwdesc[0].tr_req_base;
> +
> +	cppi5_tr_init(&tr_req[0].flags, CPPI5_TR_TYPE15, false, true,
> +		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +	cppi5_tr_csf_set(&tr_req[0].flags, csf);
> +
> +	tr_req[0].addr = src;
> +	tr_req[0].icnt0 = tr0_cnt0;
> +	tr_req[0].icnt1 = tr0_cnt1;
> +	tr_req[0].icnt2 = 1;
> +	tr_req[0].icnt3 = 1;
> +	tr_req[0].dim1 = tr0_cnt0;
> +
> +	tr_req[0].daddr = dest;
> +	tr_req[0].dicnt0 = tr0_cnt0;
> +	tr_req[0].dicnt1 = tr0_cnt1;
> +	tr_req[0].dicnt2 = 1;
> +	tr_req[0].dicnt3 = 1;
> +	tr_req[0].ddim1 = tr0_cnt0;
> +
> +	if (num_tr == 2) {
> +		cppi5_tr_init(&tr_req[1].flags, CPPI5_TR_TYPE15, false, true,
> +			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> +		cppi5_tr_csf_set(&tr_req[1].flags, csf);
> +
> +		tr_req[1].addr = src + tr0_cnt1 * tr0_cnt0;
> +		tr_req[1].icnt0 = tr1_cnt0;
> +		tr_req[1].icnt1 = 1;
> +		tr_req[1].icnt2 = 1;
> +		tr_req[1].icnt3 = 1;
> +
> +		tr_req[1].daddr = dest + tr0_cnt1 * tr0_cnt0;
> +		tr_req[1].dicnt0 = tr1_cnt0;
> +		tr_req[1].dicnt1 = 1;
> +		tr_req[1].dicnt2 = 1;
> +		tr_req[1].dicnt3 = 1;
> +	}
> +
> +	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags, csf | CPPI5_TR_CSF_EOP);
> +
> +	if (uc->config.metadata_size)
> +		d->vd.tx.metadata_ops = &metadata_ops;
> +
> +	return vchan_tx_prep(&uc->vc, &d->vd, tx_flags);
> +}
> +EXPORT_SYMBOL_GPL(udma_prep_dma_memcpy);
> +
> +void udma_desc_pre_callback(struct virt_dma_chan *vc,
> +			    struct virt_dma_desc *vd,
> +			    struct dmaengine_result *result)
> +{
> +	struct udma_chan *uc = to_udma_chan(&vc->chan);
> +	struct udma_desc *d;
> +	u8 status;
> +
> +	if (!vd)
> +		return;
> +
> +	d = to_udma_desc(&vd->tx);
> +
> +	if (d->metadata_size)
> +		udma_fetch_epib(uc, d);
> +
> +	if (result) {
> +		void *desc_vaddr = udma_curr_cppi5_desc_vaddr(d, d->desc_idx);
> +
> +		if (cppi5_desc_get_type(desc_vaddr) ==
> +		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
> +			/* Provide residue information for the client */
> +			result->residue = d->residue -
> +					  cppi5_hdesc_get_pktlen(desc_vaddr);
> +			if (result->residue)
> +				result->result = DMA_TRANS_ABORTED;
> +			else
> +				result->result = DMA_TRANS_NOERROR;
> +		} else {
> +			result->residue = 0;
> +			/* Propagate TR Response errors to the client */
> +			status = d->hwdesc[0].tr_resp_base->status;
> +			if (status)
> +				result->result = DMA_TRANS_ABORTED;
> +			else
> +				result->result = DMA_TRANS_NOERROR;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_GPL(udma_desc_pre_callback);
> +
> +MODULE_DESCRIPTION("Texas Instruments K3 UDMA Common Library");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> index 4adcd679c6997..0a1291829611f 100644
> --- a/drivers/dma/ti/k3-udma.c
> +++ b/drivers/dma/ti/k3-udma.c
> @@ -131,105 +131,6 @@ static void udma_dump_chan_stdata(struct udma_chan *uc)
>  	}
>  }
>
> -static struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
> -						   dma_addr_t paddr)
> -{
> -	struct udma_desc *d = uc->terminated_desc;
> -
> -	if (d) {
> -		dma_addr_t desc_paddr = udma_curr_cppi5_desc_paddr(d,
> -								   d->desc_idx);
> -
> -		if (desc_paddr != paddr)
> -			d = NULL;
> -	}
> -
> -	if (!d) {
> -		d = uc->desc;
> -		if (d) {
> -			dma_addr_t desc_paddr = udma_curr_cppi5_desc_paddr(d,
> -								d->desc_idx);
> -
> -			if (desc_paddr != paddr)
> -				d = NULL;
> -		}
> -	}
> -
> -	return d;
> -}
> -
> -static void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d)
> -{
> -	if (uc->use_dma_pool) {
> -		int i;
> -
> -		for (i = 0; i < d->hwdesc_count; i++) {
> -			if (!d->hwdesc[i].cppi5_desc_vaddr)
> -				continue;
> -
> -			dma_pool_free(uc->hdesc_pool,
> -				      d->hwdesc[i].cppi5_desc_vaddr,
> -				      d->hwdesc[i].cppi5_desc_paddr);
> -
> -			d->hwdesc[i].cppi5_desc_vaddr = NULL;
> -		}
> -	} else if (d->hwdesc[0].cppi5_desc_vaddr) {
> -		dma_free_coherent(uc->dma_dev, d->hwdesc[0].cppi5_desc_size,
> -				  d->hwdesc[0].cppi5_desc_vaddr,
> -				  d->hwdesc[0].cppi5_desc_paddr);
> -
> -		d->hwdesc[0].cppi5_desc_vaddr = NULL;
> -	}
> -}
> -
> -static void udma_purge_desc_work(struct work_struct *work)
> -{
> -	struct udma_dev *ud = container_of(work, typeof(*ud), purge_work);
> -	struct virt_dma_desc *vd, *_vd;
> -	unsigned long flags;
> -	LIST_HEAD(head);
> -
> -	spin_lock_irqsave(&ud->lock, flags);
> -	list_splice_tail_init(&ud->desc_to_purge, &head);
> -	spin_unlock_irqrestore(&ud->lock, flags);
> -
> -	list_for_each_entry_safe(vd, _vd, &head, node) {
> -		struct udma_chan *uc = to_udma_chan(vd->tx.chan);
> -		struct udma_desc *d = to_udma_desc(&vd->tx);
> -
> -		udma_free_hwdesc(uc, d);
> -		list_del(&vd->node);
> -		kfree(d);
> -	}
> -
> -	/* If more to purge, schedule the work again */
> -	if (!list_empty(&ud->desc_to_purge))
> -		schedule_work(&ud->purge_work);
> -}
> -
> -static void udma_desc_free(struct virt_dma_desc *vd)
> -{
> -	struct udma_dev *ud = to_udma_dev(vd->tx.chan->device);
> -	struct udma_chan *uc = to_udma_chan(vd->tx.chan);
> -	struct udma_desc *d = to_udma_desc(&vd->tx);
> -	unsigned long flags;
> -
> -	if (uc->terminated_desc == d)
> -		uc->terminated_desc = NULL;
> -
> -	if (uc->use_dma_pool) {
> -		udma_free_hwdesc(uc, d);
> -		kfree(d);
> -		return;
> -	}
> -
> -	spin_lock_irqsave(&ud->lock, flags);
> -	list_add_tail(&vd->node, &ud->desc_to_purge);
> -	spin_unlock_irqrestore(&ud->lock, flags);
> -
> -	schedule_work(&ud->purge_work);
> -}
> -
>  static bool udma_is_chan_running(struct udma_chan *uc)
>  {
>  	u32 trt_ctl = 0;
> @@ -303,17 +204,6 @@ static int udma_push_to_ring(struct udma_chan *uc, int idx)
>  	return k3_ringacc_ring_push(ring, &paddr);
>  }
>
> -static bool udma_desc_is_rx_flush(struct udma_chan *uc, dma_addr_t addr)
> -{
> -	if (uc->config.dir != DMA_DEV_TO_MEM)
> -		return false;
> -
> -	if (addr == udma_get_rx_flush_hwdesc_paddr(uc))
> -		return true;
> -
> -	return false;
> -}
> -
>  static int udma_pop_from_ring(struct udma_chan *uc, dma_addr_t *addr)
>  {
>  	struct k3_ring *ring = NULL;
> @@ -674,33 +564,6 @@ static void udma_cyclic_packet_elapsed(struct udma_chan *uc)
>  	d->desc_idx = (d->desc_idx + 1) % d->sglen;
>  }
>
> -static bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d)
> -{
> -	u32 peer_bcnt, bcnt;
> -
> -	/*
> -	 * Only TX towards PDMA is affected.
> -	 * If DMA_PREP_INTERRUPT is not set by consumer then skip the transfer
> -	 * completion calculation, consumer must ensure that there is no stale
> -	 * data in DMA fabric in this case.
> -	 */
> -	if (uc->config.ep_type == PSIL_EP_NATIVE ||
> -	    uc->config.dir != DMA_MEM_TO_DEV || !(uc->config.tx_flags & DMA_PREP_INTERRUPT))
> -		return true;
> -
> -	peer_bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_PEER_BCNT_REG);
> -	bcnt = udma_tchanrt_read(uc, UDMA_CHAN_RT_BCNT_REG);
> -
> -	/* Transfer is incomplete, store current residue and time stamp */
> -	if (peer_bcnt < bcnt) {
> -		uc->tx_drain.residue = bcnt - peer_bcnt;
> -		uc->tx_drain.tstamp = ktime_get();
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static void udma_check_tx_completion(struct work_struct *work)
>  {
>  	struct udma_chan *uc = container_of(work, typeof(*uc),
> @@ -2344,1047 +2207,6 @@ static int udma_slave_config(struct dma_chan *chan,
>  	return 0;
>  }
>
> -static struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
> -					    size_t tr_size, int tr_count,
> -					    enum dma_transfer_direction dir)
> -{
> -	struct udma_hwdesc *hwdesc;
> -	struct cppi5_desc_hdr_t *tr_desc;
> -	struct udma_desc *d;
> -	u32 reload_count = 0;
> -	u32 ring_id;
> -
> -	switch (tr_size) {
> -	case 16:
> -	case 32:
> -	case 64:
> -	case 128:
> -		break;
> -	default:
> -		dev_err(uc->ud->dev, "Unsupported TR size of %zu\n", tr_size);
> -		return NULL;
> -	}
> -
> -	/* We have only one descriptor containing multiple TRs */
> -	d = kzalloc(sizeof(*d) + sizeof(d->hwdesc[0]), GFP_NOWAIT);
> -	if (!d)
> -		return NULL;
> -
> -	d->sglen = tr_count;
> -
> -	d->hwdesc_count = 1;
> -	hwdesc = &d->hwdesc[0];
> -
> -	/* Allocate memory for DMA ring descriptor */
> -	if (uc->use_dma_pool) {
> -		hwdesc->cppi5_desc_size = uc->config.hdesc_size;
> -		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
> -						GFP_NOWAIT,
> -						&hwdesc->cppi5_desc_paddr);
> -	} else {
> -		hwdesc->cppi5_desc_size = cppi5_trdesc_calc_size(tr_size,
> -								 tr_count);
> -		hwdesc->cppi5_desc_size = ALIGN(hwdesc->cppi5_desc_size,
> -						uc->ud->desc_align);
> -		hwdesc->cppi5_desc_vaddr = dma_alloc_coherent(uc->ud->dev,
> -						hwdesc->cppi5_desc_size,
> -						&hwdesc->cppi5_desc_paddr,
> -						GFP_NOWAIT);
> -	}
> -
> -	if (!hwdesc->cppi5_desc_vaddr) {
> -		kfree(d);
> -		return NULL;
> -	}
> -
> -	/* Start of the TR req records */
> -	hwdesc->tr_req_base = hwdesc->cppi5_desc_vaddr + tr_size;
> -	/* Start address of the TR response array */
> -	hwdesc->tr_resp_base = hwdesc->tr_req_base + tr_size * tr_count;
> -
> -	tr_desc = hwdesc->cppi5_desc_vaddr;
> -
> -	if (uc->cyclic)
> -		reload_count = CPPI5_INFO0_TRDESC_RLDCNT_INFINITE;
> -
> -	if (dir == DMA_DEV_TO_MEM)
> -		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
> -	else
> -		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
> -
> -	cppi5_trdesc_init(tr_desc, tr_count, tr_size, 0, reload_count);
> -	cppi5_desc_set_pktids(tr_desc, uc->id,
> -			      CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> -	cppi5_desc_set_retpolicy(tr_desc, 0, ring_id);
> -
> -	return d;
> -}
> -
> -/**
> - * udma_get_tr_counters - calculate TR counters for a given length
> - * @len: Length of the trasnfer
> - * @align_to: Preferred alignment
> - * @tr0_cnt0: First TR icnt0
> - * @tr0_cnt1: First TR icnt1
> - * @tr1_cnt0: Second (if used) TR icnt0
> - *
> - * For len < SZ_64K only one TR is enough, tr1_cnt0 is not updated
> - * For len >= SZ_64K two TRs are used in a simple way:
> - * First TR: SZ_64K-alignment blocks (tr0_cnt0, tr0_cnt1)
> - * Second TR: the remaining length (tr1_cnt0)
> - *
> - * Returns the number of TRs the length needs (1 or 2)
> - * -EINVAL if the length can not be supported
> - */
> -static int udma_get_tr_counters(size_t len, unsigned long align_to,
> -				u16 *tr0_cnt0, u16 *tr0_cnt1, u16 *tr1_cnt0)
> -{
> -	if (len < SZ_64K) {
> -		*tr0_cnt0 = len;
> -		*tr0_cnt1 = 1;
> -
> -		return 1;
> -	}
> -
> -	if (align_to > 3)
> -		align_to = 3;
> -
> -realign:
> -	*tr0_cnt0 = SZ_64K - BIT(align_to);
> -	if (len / *tr0_cnt0 >= SZ_64K) {
> -		if (align_to) {
> -			align_to--;
> -			goto realign;
> -		}
> -		return -EINVAL;
> -	}
> -
> -	*tr0_cnt1 = len / *tr0_cnt0;
> -	*tr1_cnt0 = len % *tr0_cnt0;
> -
> -	return 2;
> -}
> -
> -static struct udma_desc *
> -udma_prep_slave_sg_tr(struct udma_chan *uc, struct scatterlist *sgl,
> -		      unsigned int sglen, enum dma_transfer_direction dir,
> -		      unsigned long tx_flags, void *context)
> -{
> -	struct scatterlist *sgent;
> -	struct udma_desc *d;
> -	struct cppi5_tr_type1_t *tr_req = NULL;
> -	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> -	unsigned int i;
> -	size_t tr_size;
> -	int num_tr = 0;
> -	int tr_idx = 0;
> -	u64 asel;
> -
> -	/* estimate the number of TRs we will need */
> -	for_each_sg(sgl, sgent, sglen, i) {
> -		if (sg_dma_len(sgent) < SZ_64K)
> -			num_tr++;
> -		else
> -			num_tr += 2;
> -	}
> -
> -	/* Now allocate and setup the descriptor. */
> -	tr_size = sizeof(struct cppi5_tr_type1_t);
> -	d = udma_alloc_tr_desc(uc, tr_size, num_tr, dir);
> -	if (!d)
> -		return NULL;
> -
> -	d->sglen = sglen;
> -
> -	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
> -		asel = 0;
> -	else
> -		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> -
> -	tr_req = d->hwdesc[0].tr_req_base;
> -	for_each_sg(sgl, sgent, sglen, i) {
> -		dma_addr_t sg_addr = sg_dma_address(sgent);
> -
> -		num_tr = udma_get_tr_counters(sg_dma_len(sgent), __ffs(sg_addr),
> -					      &tr0_cnt0, &tr0_cnt1, &tr1_cnt0);
> -		if (num_tr < 0) {
> -			dev_err(uc->ud->dev, "size %u is not supported\n",
> -				sg_dma_len(sgent));
> -			udma_free_hwdesc(uc, d);
> -			kfree(d);
> -			return NULL;
> -		}
> -
> -		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
> -			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[tr_idx].flags, CPPI5_TR_CSF_SUPR_EVT);
> -
> -		sg_addr |= asel;
> -		tr_req[tr_idx].addr = sg_addr;
> -		tr_req[tr_idx].icnt0 = tr0_cnt0;
> -		tr_req[tr_idx].icnt1 = tr0_cnt1;
> -		tr_req[tr_idx].dim1 = tr0_cnt0;
> -		tr_idx++;
> -
> -		if (num_tr == 2) {
> -			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1,
> -				      false, false,
> -				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> -
> -			tr_req[tr_idx].addr = sg_addr + tr0_cnt1 * tr0_cnt0;
> -			tr_req[tr_idx].icnt0 = tr1_cnt0;
> -			tr_req[tr_idx].icnt1 = 1;
> -			tr_req[tr_idx].dim1 = tr1_cnt0;
> -			tr_idx++;
> -		}
> -
> -		d->residue += sg_dma_len(sgent);
> -	}
> -
> -	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags,
> -			 CPPI5_TR_CSF_SUPR_EVT | CPPI5_TR_CSF_EOP);
> -
> -	return d;
> -}
> -
> -static struct udma_desc *
> -udma_prep_slave_sg_triggered_tr(struct udma_chan *uc, struct scatterlist *sgl,
> -				unsigned int sglen,
> -				enum dma_transfer_direction dir,
> -				unsigned long tx_flags, void *context)
> -{
> -	struct scatterlist *sgent;
> -	struct cppi5_tr_type15_t *tr_req = NULL;
> -	enum dma_slave_buswidth dev_width;
> -	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
> -	u16 tr_cnt0, tr_cnt1;
> -	dma_addr_t dev_addr;
> -	struct udma_desc *d;
> -	unsigned int i;
> -	size_t tr_size, sg_len;
> -	int num_tr = 0;
> -	int tr_idx = 0;
> -	u32 burst, trigger_size, port_window;
> -	u64 asel;
> -
> -	if (dir == DMA_DEV_TO_MEM) {
> -		dev_addr = uc->cfg.src_addr;
> -		dev_width = uc->cfg.src_addr_width;
> -		burst = uc->cfg.src_maxburst;
> -		port_window = uc->cfg.src_port_window_size;
> -	} else if (dir == DMA_MEM_TO_DEV) {
> -		dev_addr = uc->cfg.dst_addr;
> -		dev_width = uc->cfg.dst_addr_width;
> -		burst = uc->cfg.dst_maxburst;
> -		port_window = uc->cfg.dst_port_window_size;
> -	} else {
> -		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
> -		return NULL;
> -	}
> -
> -	if (!burst)
> -		burst = 1;
> -
> -	if (port_window) {
> -		if (port_window != burst) {
> -			dev_err(uc->ud->dev,
> -				"The burst must be equal to port_window\n");
> -			return NULL;
> -		}
> -
> -		tr_cnt0 = dev_width * port_window;
> -		tr_cnt1 = 1;
> -	} else {
> -		tr_cnt0 = dev_width;
> -		tr_cnt1 = burst;
> -	}
> -	trigger_size = tr_cnt0 * tr_cnt1;
> -
> -	/* estimate the number of TRs we will need */
> -	for_each_sg(sgl, sgent, sglen, i) {
> -		sg_len = sg_dma_len(sgent);
> -
> -		if (sg_len % trigger_size) {
> -			dev_err(uc->ud->dev,
> -				"Not aligned SG entry (%zu for %u)\n", sg_len,
> -				trigger_size);
> -			return NULL;
> -		}
> -
> -		if (sg_len / trigger_size < SZ_64K)
> -			num_tr++;
> -		else
> -			num_tr += 2;
> -	}
> -
> -	/* Now allocate and setup the descriptor. */
> -	tr_size = sizeof(struct cppi5_tr_type15_t);
> -	d = udma_alloc_tr_desc(uc, tr_size, num_tr, dir);
> -	if (!d)
> -		return NULL;
> -
> -	d->sglen = sglen;
> -
> -	if (uc->ud->match_data->type == DMA_TYPE_UDMA) {
> -		asel = 0;
> -		csf |= CPPI5_TR_CSF_EOL_ICNT0;
> -	} else {
> -		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> -		dev_addr |= asel;
> -	}
> -
> -	tr_req = d->hwdesc[0].tr_req_base;
> -	for_each_sg(sgl, sgent, sglen, i) {
> -		u16 tr0_cnt2, tr0_cnt3, tr1_cnt2;
> -		dma_addr_t sg_addr = sg_dma_address(sgent);
> -
> -		sg_len = sg_dma_len(sgent);
> -		num_tr = udma_get_tr_counters(sg_len / trigger_size, 0,
> -					      &tr0_cnt2, &tr0_cnt3, &tr1_cnt2);
> -		if (num_tr < 0) {
> -			dev_err(uc->ud->dev, "size %zu is not supported\n",
> -				sg_len);
> -			udma_free_hwdesc(uc, d);
> -			kfree(d);
> -			return NULL;
> -		}
> -
> -		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15, false,
> -			      true, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
> -		cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
> -				     uc->config.tr_trigger_type,
> -				     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC, 0, 0);
> -
> -		sg_addr |= asel;
> -		if (dir == DMA_DEV_TO_MEM) {
> -			tr_req[tr_idx].addr = dev_addr;
> -			tr_req[tr_idx].icnt0 = tr_cnt0;
> -			tr_req[tr_idx].icnt1 = tr_cnt1;
> -			tr_req[tr_idx].icnt2 = tr0_cnt2;
> -			tr_req[tr_idx].icnt3 = tr0_cnt3;
> -			tr_req[tr_idx].dim1 = (-1) * tr_cnt0;
> -
> -			tr_req[tr_idx].daddr = sg_addr;
> -			tr_req[tr_idx].dicnt0 = tr_cnt0;
> -			tr_req[tr_idx].dicnt1 = tr_cnt1;
> -			tr_req[tr_idx].dicnt2 = tr0_cnt2;
> -			tr_req[tr_idx].dicnt3 = tr0_cnt3;
> -			tr_req[tr_idx].ddim1 = tr_cnt0;
> -			tr_req[tr_idx].ddim2 = trigger_size;
> -			tr_req[tr_idx].ddim3 = trigger_size * tr0_cnt2;
> -		} else {
> -			tr_req[tr_idx].addr = sg_addr;
> -			tr_req[tr_idx].icnt0 = tr_cnt0;
> -			tr_req[tr_idx].icnt1 = tr_cnt1;
> -			tr_req[tr_idx].icnt2 = tr0_cnt2;
> -			tr_req[tr_idx].icnt3 = tr0_cnt3;
> -			tr_req[tr_idx].dim1 = tr_cnt0;
> -			tr_req[tr_idx].dim2 = trigger_size;
> -			tr_req[tr_idx].dim3 = trigger_size * tr0_cnt2;
> -
> -			tr_req[tr_idx].daddr = dev_addr;
> -			tr_req[tr_idx].dicnt0 = tr_cnt0;
> -			tr_req[tr_idx].dicnt1 = tr_cnt1;
> -			tr_req[tr_idx].dicnt2 = tr0_cnt2;
> -			tr_req[tr_idx].dicnt3 = tr0_cnt3;
> -			tr_req[tr_idx].ddim1 = (-1) * tr_cnt0;
> -		}
> -
> -		tr_idx++;
> -
> -		if (num_tr == 2) {
> -			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE15,
> -				      false, true,
> -				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags, csf);
> -			cppi5_tr_set_trigger(&tr_req[tr_idx].flags,
> -					     uc->config.tr_trigger_type,
> -					     CPPI5_TR_TRIGGER_TYPE_ICNT2_DEC,
> -					     0, 0);
> -
> -			sg_addr += trigger_size * tr0_cnt2 * tr0_cnt3;
> -			if (dir == DMA_DEV_TO_MEM) {
> -				tr_req[tr_idx].addr = dev_addr;
> -				tr_req[tr_idx].icnt0 = tr_cnt0;
> -				tr_req[tr_idx].icnt1 = tr_cnt1;
> -				tr_req[tr_idx].icnt2 = tr1_cnt2;
> -				tr_req[tr_idx].icnt3 = 1;
> -				tr_req[tr_idx].dim1 = (-1) * tr_cnt0;
> -
> -				tr_req[tr_idx].daddr = sg_addr;
> -				tr_req[tr_idx].dicnt0 = tr_cnt0;
> -				tr_req[tr_idx].dicnt1 = tr_cnt1;
> -				tr_req[tr_idx].dicnt2 = tr1_cnt2;
> -				tr_req[tr_idx].dicnt3 = 1;
> -				tr_req[tr_idx].ddim1 = tr_cnt0;
> -				tr_req[tr_idx].ddim2 = trigger_size;
> -			} else {
> -				tr_req[tr_idx].addr = sg_addr;
> -				tr_req[tr_idx].icnt0 = tr_cnt0;
> -				tr_req[tr_idx].icnt1 = tr_cnt1;
> -				tr_req[tr_idx].icnt2 = tr1_cnt2;
> -				tr_req[tr_idx].icnt3 = 1;
> -				tr_req[tr_idx].dim1 = tr_cnt0;
> -				tr_req[tr_idx].dim2 = trigger_size;
> -
> -				tr_req[tr_idx].daddr = dev_addr;
> -				tr_req[tr_idx].dicnt0 = tr_cnt0;
> -				tr_req[tr_idx].dicnt1 = tr_cnt1;
> -				tr_req[tr_idx].dicnt2 = tr1_cnt2;
> -				tr_req[tr_idx].dicnt3 = 1;
> -				tr_req[tr_idx].ddim1 = (-1) * tr_cnt0;
> -			}
> -			tr_idx++;
> -		}
> -
> -		d->residue += sg_len;
> -	}
> -
> -	cppi5_tr_csf_set(&tr_req[tr_idx - 1].flags, csf | CPPI5_TR_CSF_EOP);
> -
> -	return d;
> -}
> -
> -static int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
> -				   enum dma_slave_buswidth dev_width,
> -				   u16 elcnt)
> -{
> -	if (uc->config.ep_type != PSIL_EP_PDMA_XY)
> -		return 0;
> -
> -	/* Bus width translates to the element size (ES) */
> -	switch (dev_width) {
> -	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> -		d->static_tr.elsize = 0;
> -		break;
> -	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> -		d->static_tr.elsize = 1;
> -		break;
> -	case DMA_SLAVE_BUSWIDTH_3_BYTES:
> -		d->static_tr.elsize = 2;
> -		break;
> -	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> -		d->static_tr.elsize = 3;
> -		break;
> -	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> -		d->static_tr.elsize = 4;
> -		break;
> -	default: /* not reached */
> -		return -EINVAL;
> -	}
> -
> -	d->static_tr.elcnt = elcnt;
> -
> -	if (uc->config.pkt_mode || !uc->cyclic) {
> -		/*
> -		 * PDMA must close the packet when the channel is in packet mode.
> -		 * For TR mode when the channel is not cyclic we also need PDMA
> -		 * to close the packet otherwise the transfer will stall because
> -		 * PDMA holds on the data it has received from the peripheral.
> -		 */
> -		unsigned int div = dev_width * elcnt;
> -
> -		if (uc->cyclic)
> -			d->static_tr.bstcnt = d->residue / d->sglen / div;
> -		else
> -			d->static_tr.bstcnt = d->residue / div;
> -	} else if (uc->ud->match_data->type == DMA_TYPE_BCDMA &&
> -		   uc->config.dir == DMA_DEV_TO_MEM &&
> -		   uc->cyclic) {
> -		/*
> -		 * For cyclic mode with BCDMA we have to set EOP in each TR to
> -		 * prevent short packet errors seen on channel teardown. So the
> -		 * PDMA must close the packet after every TR transfer by setting
> -		 * burst count equal to the number of bytes transferred.
> -		 */
> -		struct cppi5_tr_type1_t *tr_req = d->hwdesc[0].tr_req_base;
> -
> -		d->static_tr.bstcnt =
> -			(tr_req->icnt0 * tr_req->icnt1) / dev_width;
> -	} else {
> -		d->static_tr.bstcnt = 0;
> -	}
> -
> -	if (uc->config.dir == DMA_DEV_TO_MEM &&
> -	    d->static_tr.bstcnt > uc->ud->match_data->statictr_z_mask)
> -		return -EINVAL;
> -
> -	return 0;
> -}
> -
> -static struct udma_desc *
> -udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
> -		       unsigned int sglen, enum dma_transfer_direction dir,
> -		       unsigned long tx_flags, void *context)
> -{
> -	struct scatterlist *sgent;
> -	struct cppi5_host_desc_t *h_desc = NULL;
> -	struct udma_desc *d;
> -	u32 ring_id;
> -	unsigned int i;
> -	u64 asel;
> -
> -	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
> -	if (!d)
> -		return NULL;
> -
> -	d->sglen = sglen;
> -	d->hwdesc_count = sglen;
> -
> -	if (dir == DMA_DEV_TO_MEM)
> -		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
> -	else
> -		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
> -
> -	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
> -		asel = 0;
> -	else
> -		asel = (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> -
> -	for_each_sg(sgl, sgent, sglen, i) {
> -		struct udma_hwdesc *hwdesc = &d->hwdesc[i];
> -		dma_addr_t sg_addr = sg_dma_address(sgent);
> -		struct cppi5_host_desc_t *desc;
> -		size_t sg_len = sg_dma_len(sgent);
> -
> -		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
> -						GFP_NOWAIT,
> -						&hwdesc->cppi5_desc_paddr);
> -		if (!hwdesc->cppi5_desc_vaddr) {
> -			dev_err(uc->ud->dev,
> -				"descriptor%d allocation failed\n", i);
> -
> -			udma_free_hwdesc(uc, d);
> -			kfree(d);
> -			return NULL;
> -		}
> -
> -		d->residue += sg_len;
> -		hwdesc->cppi5_desc_size = uc->config.hdesc_size;
> -		desc = hwdesc->cppi5_desc_vaddr;
> -
> -		if (i == 0) {
> -			cppi5_hdesc_init(desc, 0, 0);
> -			/* Flow and Packed ID */
> -			cppi5_desc_set_pktids(&desc->hdr, uc->id,
> -					      CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> -			cppi5_desc_set_retpolicy(&desc->hdr, 0, ring_id);
> -		} else {
> -			cppi5_hdesc_reset_hbdesc(desc);
> -			cppi5_desc_set_retpolicy(&desc->hdr, 0, 0xffff);
> -		}
> -
> -		/* attach the sg buffer to the descriptor */
> -		sg_addr |= asel;
> -		cppi5_hdesc_attach_buf(desc, sg_addr, sg_len, sg_addr, sg_len);
> -
> -		/* Attach link as host buffer descriptor */
> -		if (h_desc)
> -			cppi5_hdesc_link_hbdesc(h_desc,
> -						hwdesc->cppi5_desc_paddr | asel);
> -
> -		if (uc->ud->match_data->type == DMA_TYPE_PKTDMA ||
> -		    dir == DMA_MEM_TO_DEV)
> -			h_desc = desc;
> -	}
> -
> -	if (d->residue >= SZ_4M) {
> -		dev_err(uc->ud->dev,
> -			"%s: Transfer size %u is over the supported 4M range\n",
> -			__func__, d->residue);
> -		udma_free_hwdesc(uc, d);
> -		kfree(d);
> -		return NULL;
> -	}
> -
> -	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> -	cppi5_hdesc_set_pktlen(h_desc, d->residue);
> -
> -	return d;
> -}
> -
> -static int udma_attach_metadata(struct dma_async_tx_descriptor *desc,
> -				void *data, size_t len)
> -{
> -	struct udma_desc *d = to_udma_desc(desc);
> -	struct udma_chan *uc = to_udma_chan(desc->chan);
> -	struct cppi5_host_desc_t *h_desc;
> -	u32 psd_size = len;
> -	u32 flags = 0;
> -
> -	if (!uc->config.pkt_mode || !uc->config.metadata_size)
> -		return -ENOTSUPP;
> -
> -	if (!data || len > uc->config.metadata_size)
> -		return -EINVAL;
> -
> -	if (uc->config.needs_epib && len < CPPI5_INFO0_HDESC_EPIB_SIZE)
> -		return -EINVAL;
> -
> -	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> -	if (d->dir == DMA_MEM_TO_DEV)
> -		memcpy(h_desc->epib, data, len);
> -
> -	if (uc->config.needs_epib)
> -		psd_size -= CPPI5_INFO0_HDESC_EPIB_SIZE;
> -
> -	d->metadata = data;
> -	d->metadata_size = len;
> -	if (uc->config.needs_epib)
> -		flags |= CPPI5_INFO0_HDESC_EPIB_PRESENT;
> -
> -	cppi5_hdesc_update_flags(h_desc, flags);
> -	cppi5_hdesc_update_psdata_size(h_desc, psd_size);
> -
> -	return 0;
> -}
> -
> -static void *udma_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
> -				   size_t *payload_len, size_t *max_len)
> -{
> -	struct udma_desc *d = to_udma_desc(desc);
> -	struct udma_chan *uc = to_udma_chan(desc->chan);
> -	struct cppi5_host_desc_t *h_desc;
> -
> -	if (!uc->config.pkt_mode || !uc->config.metadata_size)
> -		return ERR_PTR(-ENOTSUPP);
> -
> -	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> -
> -	*max_len = uc->config.metadata_size;
> -
> -	*payload_len = cppi5_hdesc_epib_present(&h_desc->hdr) ?
> -		       CPPI5_INFO0_HDESC_EPIB_SIZE : 0;
> -	*payload_len += cppi5_hdesc_get_psdata_size(h_desc);
> -
> -	return h_desc->epib;
> -}
> -
> -static int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
> -				 size_t payload_len)
> -{
> -	struct udma_desc *d = to_udma_desc(desc);
> -	struct udma_chan *uc = to_udma_chan(desc->chan);
> -	struct cppi5_host_desc_t *h_desc;
> -	u32 psd_size = payload_len;
> -	u32 flags = 0;
> -
> -	if (!uc->config.pkt_mode || !uc->config.metadata_size)
> -		return -ENOTSUPP;
> -
> -	if (payload_len > uc->config.metadata_size)
> -		return -EINVAL;
> -
> -	if (uc->config.needs_epib && payload_len < CPPI5_INFO0_HDESC_EPIB_SIZE)
> -		return -EINVAL;
> -
> -	h_desc = d->hwdesc[0].cppi5_desc_vaddr;
> -
> -	if (uc->config.needs_epib) {
> -		psd_size -= CPPI5_INFO0_HDESC_EPIB_SIZE;
> -		flags |= CPPI5_INFO0_HDESC_EPIB_PRESENT;
> -	}
> -
> -	cppi5_hdesc_update_flags(h_desc, flags);
> -	cppi5_hdesc_update_psdata_size(h_desc, psd_size);
> -
> -	return 0;
> -}
> -
> -static struct dma_descriptor_metadata_ops metadata_ops = {
> -	.attach = udma_attach_metadata,
> -	.get_ptr = udma_get_metadata_ptr,
> -	.set_len = udma_set_metadata_len,
> -};
> -
> -static struct dma_async_tx_descriptor *
> -udma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> -		   unsigned int sglen, enum dma_transfer_direction dir,
> -		   unsigned long tx_flags, void *context)
> -{
> -	struct udma_chan *uc = to_udma_chan(chan);
> -	enum dma_slave_buswidth dev_width;
> -	struct udma_desc *d;
> -	u32 burst;
> -
> -	if (dir != uc->config.dir &&
> -	    (uc->config.dir == DMA_MEM_TO_MEM && !uc->config.tr_trigger_type)) {
> -		dev_err(chan->device->dev,
> -			"%s: chan%d is for %s, not supporting %s\n",
> -			__func__, uc->id,
> -			dmaengine_get_direction_text(uc->config.dir),
> -			dmaengine_get_direction_text(dir));
> -		return NULL;
> -	}
> -
> -	if (dir == DMA_DEV_TO_MEM) {
> -		dev_width = uc->cfg.src_addr_width;
> -		burst = uc->cfg.src_maxburst;
> -	} else if (dir == DMA_MEM_TO_DEV) {
> -		dev_width = uc->cfg.dst_addr_width;
> -		burst = uc->cfg.dst_maxburst;
> -	} else {
> -		dev_err(chan->device->dev, "%s: bad direction?\n", __func__);
> -		return NULL;
> -	}
> -
> -	if (!burst)
> -		burst = 1;
> -
> -	uc->config.tx_flags = tx_flags;
> -
> -	if (uc->config.pkt_mode)
> -		d = udma_prep_slave_sg_pkt(uc, sgl, sglen, dir, tx_flags,
> -					   context);
> -	else if (is_slave_direction(uc->config.dir))
> -		d = udma_prep_slave_sg_tr(uc, sgl, sglen, dir, tx_flags,
> -					  context);
> -	else
> -		d = udma_prep_slave_sg_triggered_tr(uc, sgl, sglen, dir,
> -						    tx_flags, context);
> -
> -	if (!d)
> -		return NULL;
> -
> -	d->dir = dir;
> -	d->desc_idx = 0;
> -	d->tr_idx = 0;
> -
> -	/* static TR for remote PDMA */
> -	if (udma_configure_statictr(uc, d, dev_width, burst)) {
> -		dev_err(uc->ud->dev,
> -			"%s: StaticTR Z is limited to maximum %u (%u)\n",
> -			__func__, uc->ud->match_data->statictr_z_mask,
> -			d->static_tr.bstcnt);
> -
> -		udma_free_hwdesc(uc, d);
> -		kfree(d);
> -		return NULL;
> -	}
> -
> -	if (uc->config.metadata_size)
> -		d->vd.tx.metadata_ops = &metadata_ops;
> -
> -	return vchan_tx_prep(&uc->vc, &d->vd, tx_flags);
> -}
> -
> -static struct udma_desc *
> -udma_prep_dma_cyclic_tr(struct udma_chan *uc, dma_addr_t buf_addr,
> -			size_t buf_len, size_t period_len,
> -			enum dma_transfer_direction dir, unsigned long flags)
> -{
> -	struct udma_desc *d;
> -	size_t tr_size, period_addr;
> -	struct cppi5_tr_type1_t *tr_req;
> -	unsigned int periods = buf_len / period_len;
> -	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> -	unsigned int i;
> -	int num_tr;
> -	u32 period_csf = 0;
> -
> -	num_tr = udma_get_tr_counters(period_len, __ffs(buf_addr), &tr0_cnt0,
> -				      &tr0_cnt1, &tr1_cnt0);
> -	if (num_tr < 0) {
> -		dev_err(uc->ud->dev, "size %zu is not supported\n",
> -			period_len);
> -		return NULL;
> -	}
> -
> -	/* Now allocate and setup the descriptor. */
> -	tr_size = sizeof(struct cppi5_tr_type1_t);
> -	d = udma_alloc_tr_desc(uc, tr_size, periods * num_tr, dir);
> -	if (!d)
> -		return NULL;
> -
> -	tr_req = d->hwdesc[0].tr_req_base;
> -	if (uc->ud->match_data->type == DMA_TYPE_UDMA)
> -		period_addr = buf_addr;
> -	else
> -		period_addr = buf_addr |
> -			((u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT);
> -
> -	/*
> -	 * For BCDMA <-> PDMA transfers, the EOP flag needs to be set on the
> -	 * last TR of a descriptor, to mark the packet as complete.
> -	 * This is required for getting the teardown completion message in case
> -	 * of TX, and to avoid short-packet error in case of RX.
> -	 *
> -	 * As we are in cyclic mode, we do not know which period might be the
> -	 * last one, so set the flag for each period.
> -	 */
> -	if (uc->config.ep_type == PSIL_EP_PDMA_XY &&
> -	    uc->ud->match_data->type == DMA_TYPE_BCDMA) {
> -		period_csf = CPPI5_TR_CSF_EOP;
> -	}
> -
> -	for (i = 0; i < periods; i++) {
> -		int tr_idx = i * num_tr;
> -
> -		cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1, false,
> -			      false, CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -
> -		tr_req[tr_idx].addr = period_addr;
> -		tr_req[tr_idx].icnt0 = tr0_cnt0;
> -		tr_req[tr_idx].icnt1 = tr0_cnt1;
> -		tr_req[tr_idx].dim1 = tr0_cnt0;
> -
> -		if (num_tr == 2) {
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags,
> -					 CPPI5_TR_CSF_SUPR_EVT);
> -			tr_idx++;
> -
> -			cppi5_tr_init(&tr_req[tr_idx].flags, CPPI5_TR_TYPE1,
> -				      false, false,
> -				      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -
> -			tr_req[tr_idx].addr = period_addr + tr0_cnt1 * tr0_cnt0;
> -			tr_req[tr_idx].icnt0 = tr1_cnt0;
> -			tr_req[tr_idx].icnt1 = 1;
> -			tr_req[tr_idx].dim1 = tr1_cnt0;
> -		}
> -
> -		if (!(flags & DMA_PREP_INTERRUPT))
> -			period_csf |= CPPI5_TR_CSF_SUPR_EVT;
> -
> -		if (period_csf)
> -			cppi5_tr_csf_set(&tr_req[tr_idx].flags, period_csf);
> -
> -		period_addr += period_len;
> -	}
> -
> -	return d;
> -}
> -
> -static struct udma_desc *
> -udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
> -			 size_t buf_len, size_t period_len,
> -			 enum dma_transfer_direction dir, unsigned long flags)
> -{
> -	struct udma_desc *d;
> -	u32 ring_id;
> -	int i;
> -	int periods = buf_len / period_len;
> -
> -	if (periods > (K3_UDMA_DEFAULT_RING_SIZE - 1))
> -		return NULL;
> -
> -	if (period_len >= SZ_4M)
> -		return NULL;
> -
> -	d = kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
> -	if (!d)
> -		return NULL;
> -
> -	d->hwdesc_count = periods;
> -
> -	/* TODO: re-check this... */
> -	if (dir == DMA_DEV_TO_MEM)
> -		ring_id = k3_ringacc_get_ring_id(uc->rflow->r_ring);
> -	else
> -		ring_id = k3_ringacc_get_ring_id(uc->tchan->tc_ring);
> -
> -	if (uc->ud->match_data->type != DMA_TYPE_UDMA)
> -		buf_addr |= (u64)uc->config.asel << K3_ADDRESS_ASEL_SHIFT;
> -
> -	for (i = 0; i < periods; i++) {
> -		struct udma_hwdesc *hwdesc = &d->hwdesc[i];
> -		dma_addr_t period_addr = buf_addr + (period_len * i);
> -		struct cppi5_host_desc_t *h_desc;
> -
> -		hwdesc->cppi5_desc_vaddr = dma_pool_zalloc(uc->hdesc_pool,
> -						GFP_NOWAIT,
> -						&hwdesc->cppi5_desc_paddr);
> -		if (!hwdesc->cppi5_desc_vaddr) {
> -			dev_err(uc->ud->dev,
> -				"descriptor%d allocation failed\n", i);
> -
> -			udma_free_hwdesc(uc, d);
> -			kfree(d);
> -			return NULL;
> -		}
> -
> -		hwdesc->cppi5_desc_size = uc->config.hdesc_size;
> -		h_desc = hwdesc->cppi5_desc_vaddr;
> -
> -		cppi5_hdesc_init(h_desc, 0, 0);
> -		cppi5_hdesc_set_pktlen(h_desc, period_len);
> -
> -		/* Flow and Packed ID */
> -		cppi5_desc_set_pktids(&h_desc->hdr, uc->id,
> -				      CPPI5_INFO1_DESC_FLOWID_DEFAULT);
> -		cppi5_desc_set_retpolicy(&h_desc->hdr, 0, ring_id);
> -
> -		/* attach each period to a new descriptor */
> -		cppi5_hdesc_attach_buf(h_desc,
> -				       period_addr, period_len,
> -				       period_addr, period_len);
> -	}
> -
> -	return d;
> -}
> -
> -static struct dma_async_tx_descriptor *
> -udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr, size_t buf_len,
> -		     size_t period_len, enum dma_transfer_direction dir,
> -		     unsigned long flags)
> -{
> -	struct udma_chan *uc = to_udma_chan(chan);
> -	enum dma_slave_buswidth dev_width;
> -	struct udma_desc *d;
> -	u32 burst;
> -
> -	if (dir != uc->config.dir) {
> -		dev_err(chan->device->dev,
> -			"%s: chan%d is for %s, not supporting %s\n",
> -			__func__, uc->id,
> -			dmaengine_get_direction_text(uc->config.dir),
> -			dmaengine_get_direction_text(dir));
> -		return NULL;
> -	}
> -
> -	uc->cyclic = true;
> -
> -	if (dir == DMA_DEV_TO_MEM) {
> -		dev_width = uc->cfg.src_addr_width;
> -		burst = uc->cfg.src_maxburst;
> -	} else if (dir == DMA_MEM_TO_DEV) {
> -		dev_width = uc->cfg.dst_addr_width;
> -		burst = uc->cfg.dst_maxburst;
> -	} else {
> -		dev_err(uc->ud->dev, "%s: bad direction?\n", __func__);
> -		return NULL;
> -	}
> -
> -	if (!burst)
> -		burst = 1;
> -
> -	if (uc->config.pkt_mode)
> -		d = udma_prep_dma_cyclic_pkt(uc, buf_addr, buf_len, period_len,
> -					     dir, flags);
> -	else
> -		d = udma_prep_dma_cyclic_tr(uc, buf_addr, buf_len, period_len,
> -					    dir, flags);
> -
> -	if (!d)
> -		return NULL;
> -
> -	d->sglen = buf_len / period_len;
> -
> -	d->dir = dir;
> -	d->residue = buf_len;
> -
> -	/* static TR for remote PDMA */
> -	if (udma_configure_statictr(uc, d, dev_width, burst)) {
> -		dev_err(uc->ud->dev,
> -			"%s: StaticTR Z is limited to maximum %u (%u)\n",
> -			__func__, uc->ud->match_data->statictr_z_mask,
> -			d->static_tr.bstcnt);
> -
> -		udma_free_hwdesc(uc, d);
> -		kfree(d);
> -		return NULL;
> -	}
> -
> -	if (uc->config.metadata_size)
> -		d->vd.tx.metadata_ops = &metadata_ops;
> -
> -	return vchan_tx_prep(&uc->vc, &d->vd, flags);
> -}
> -
> -static struct dma_async_tx_descriptor *
> -udma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
> -		     size_t len, unsigned long tx_flags)
> -{
> -	struct udma_chan *uc = to_udma_chan(chan);
> -	struct udma_desc *d;
> -	struct cppi5_tr_type15_t *tr_req;
> -	int num_tr;
> -	size_t tr_size = sizeof(struct cppi5_tr_type15_t);
> -	u16 tr0_cnt0, tr0_cnt1, tr1_cnt0;
> -	u32 csf = CPPI5_TR_CSF_SUPR_EVT;
> -
> -	if (uc->config.dir != DMA_MEM_TO_MEM) {
> -		dev_err(chan->device->dev,
> -			"%s: chan%d is for %s, not supporting %s\n",
> -			__func__, uc->id,
> -			dmaengine_get_direction_text(uc->config.dir),
> -			dmaengine_get_direction_text(DMA_MEM_TO_MEM));
> -		return NULL;
> -	}
> -
> -	num_tr = udma_get_tr_counters(len, __ffs(src | dest), &tr0_cnt0,
> -				      &tr0_cnt1, &tr1_cnt0);
> -	if (num_tr < 0) {
> -		dev_err(uc->ud->dev, "size %zu is not supported\n",
> -			len);
> -		return NULL;
> -	}
> -
> -	d = udma_alloc_tr_desc(uc, tr_size, num_tr, DMA_MEM_TO_MEM);
> -	if (!d)
> -		return NULL;
> -
> -	d->dir = DMA_MEM_TO_MEM;
> -	d->desc_idx = 0;
> -	d->tr_idx = 0;
> -	d->residue = len;
> -
> -	if (uc->ud->match_data->type != DMA_TYPE_UDMA) {
> -		src |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
> -		dest |= (u64)uc->ud->asel << K3_ADDRESS_ASEL_SHIFT;
> -	} else {
> -		csf |= CPPI5_TR_CSF_EOL_ICNT0;
> -	}
> -
> -	tr_req = d->hwdesc[0].tr_req_base;
> -
> -	cppi5_tr_init(&tr_req[0].flags, CPPI5_TR_TYPE15, false, true,
> -		      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -	cppi5_tr_csf_set(&tr_req[0].flags, csf);
> -
> -	tr_req[0].addr = src;
> -	tr_req[0].icnt0 = tr0_cnt0;
> -	tr_req[0].icnt1 = tr0_cnt1;
> -	tr_req[0].icnt2 = 1;
> -	tr_req[0].icnt3 = 1;
> -	tr_req[0].dim1 = tr0_cnt0;
> -
> -	tr_req[0].daddr = dest;
> -	tr_req[0].dicnt0 = tr0_cnt0;
> -	tr_req[0].dicnt1 = tr0_cnt1;
> -	tr_req[0].dicnt2 = 1;
> -	tr_req[0].dicnt3 = 1;
> -	tr_req[0].ddim1 = tr0_cnt0;
> -
> -	if (num_tr == 2) {
> -		cppi5_tr_init(&tr_req[1].flags, CPPI5_TR_TYPE15, false, true,
> -			      CPPI5_TR_EVENT_SIZE_COMPLETION, 0);
> -		cppi5_tr_csf_set(&tr_req[1].flags, csf);
> -
> -		tr_req[1].addr = src + tr0_cnt1 * tr0_cnt0;
> -		tr_req[1].icnt0 = tr1_cnt0;
> -		tr_req[1].icnt1 = 1;
> -		tr_req[1].icnt2 = 1;
> -		tr_req[1].icnt3 = 1;
> -
> -		tr_req[1].daddr = dest + tr0_cnt1 * tr0_cnt0;
> -		tr_req[1].dicnt0 = tr1_cnt0;
> -		tr_req[1].dicnt1 = 1;
> -		tr_req[1].dicnt2 = 1;
> -		tr_req[1].dicnt3 = 1;
> -	}
> -
> -	cppi5_tr_csf_set(&tr_req[num_tr - 1].flags, csf | CPPI5_TR_CSF_EOP);
> -
> -	if (uc->config.metadata_size)
> -		d->vd.tx.metadata_ops = &metadata_ops;
> -
> -	return vchan_tx_prep(&uc->vc, &d->vd, tx_flags);
> -}
> -
>  static void udma_issue_pending(struct dma_chan *chan)
>  {
>  	struct udma_chan *uc = to_udma_chan(chan);
> @@ -3587,46 +2409,6 @@ static void udma_synchronize(struct dma_chan *chan)
>  	udma_reset_rings(uc);
>  }
>
> -static void udma_desc_pre_callback(struct virt_dma_chan *vc,
> -				   struct virt_dma_desc *vd,
> -				   struct dmaengine_result *result)
> -{
> -	struct udma_chan *uc = to_udma_chan(&vc->chan);
> -	struct udma_desc *d;
> -	u8 status;
> -
> -	if (!vd)
> -		return;
> -
> -	d = to_udma_desc(&vd->tx);
> -
> -	if (d->metadata_size)
> -		udma_fetch_epib(uc, d);
> -
> -	if (result) {
> -		void *desc_vaddr = udma_curr_cppi5_desc_vaddr(d, d->desc_idx);
> -
> -		if (cppi5_desc_get_type(desc_vaddr) ==
> -		    CPPI5_INFO0_DESC_TYPE_VAL_HOST) {
> -			/* Provide residue information for the client */
> -			result->residue = d->residue -
> -					  cppi5_hdesc_get_pktlen(desc_vaddr);
> -			if (result->residue)
> -				result->result = DMA_TRANS_ABORTED;
> -			else
> -				result->result = DMA_TRANS_NOERROR;
> -		} else {
> -			result->residue = 0;
> -			/* Propagate TR Response errors to the client */
> -			status = d->hwdesc[0].tr_resp_base->status;
> -			if (status)
> -				result->result = DMA_TRANS_ABORTED;
> -			else
> -				result->result = DMA_TRANS_NOERROR;
> -		}
> -	}
> -}
> -
>  /*
>   * This tasklet handles the completion of a DMA descriptor by
>   * calling its callback and freeing it.
> diff --git a/drivers/dma/ti/k3-udma.h b/drivers/dma/ti/k3-udma.h
> index 3a786b3eddc67..7c807bd9e178b 100644
> --- a/drivers/dma/ti/k3-udma.h
> +++ b/drivers/dma/ti/k3-udma.h
> @@ -556,6 +556,60 @@ static inline void udma_fetch_epib(struct udma_chan *uc, struct udma_desc *d)
>  	memcpy(d->metadata, h_desc->epib, d->metadata_size);
>  }
>
> +/* Common functions */
> +struct udma_desc *udma_udma_desc_from_paddr(struct udma_chan *uc,
> +					    dma_addr_t paddr);
> +void udma_free_hwdesc(struct udma_chan *uc, struct udma_desc *d);
> +void udma_purge_desc_work(struct work_struct *work);
> +void udma_desc_free(struct virt_dma_desc *vd);
> +bool udma_desc_is_rx_flush(struct udma_chan *uc, dma_addr_t addr);
> +bool udma_is_desc_really_done(struct udma_chan *uc, struct udma_desc *d);
> +struct udma_desc *udma_alloc_tr_desc(struct udma_chan *uc,
> +				     size_t tr_size, int tr_count,
> +				     enum dma_transfer_direction dir);
> +int udma_get_tr_counters(size_t len, unsigned long align_to,
> +			 u16 *tr0_cnt0, u16 *tr0_cnt1, u16 *tr1_cnt0);
> +struct udma_desc *udma_prep_slave_sg_tr(struct udma_chan *uc,
> +					struct scatterlist *sgl, unsigned int sglen,
> +					enum dma_transfer_direction dir,
> +					unsigned long tx_flags, void *context);
> +struct udma_desc *udma_prep_slave_sg_triggered_tr(struct udma_chan *uc,
> +						  struct scatterlist *sgl, unsigned int sglen,
> +						  enum dma_transfer_direction dir,
> +						  unsigned long tx_flags, void *context);
> +int udma_configure_statictr(struct udma_chan *uc, struct udma_desc *d,
> +			    enum dma_slave_buswidth dev_width, u16 elcnt);
> +struct udma_desc *udma_prep_slave_sg_pkt(struct udma_chan *uc,
> +					 struct scatterlist *sgl, unsigned int sglen,
> +					 enum dma_transfer_direction dir,
> +					 unsigned long tx_flags, void *context);
> +int udma_attach_metadata(struct dma_async_tx_descriptor *desc,
> +			 void *data, size_t len);
> +void *udma_get_metadata_ptr(struct dma_async_tx_descriptor *desc,
> +			    size_t *payload_len, size_t *max_len);
> +int udma_set_metadata_len(struct dma_async_tx_descriptor *desc,
> +			  size_t payload_len);
> +struct dma_async_tx_descriptor *udma_prep_slave_sg(struct dma_chan *chan,
> +						   struct scatterlist *sgl, unsigned int sglen,
> +						   enum dma_transfer_direction dir,
> +						   unsigned long tx_flags, void *context);
> +struct udma_desc *udma_prep_dma_cyclic_tr(struct udma_chan *uc,
> +					  dma_addr_t buf_addr, size_t buf_len, size_t period_len,
> +					  enum dma_transfer_direction dir, unsigned long flags);
> +struct udma_desc *udma_prep_dma_cyclic_pkt(struct udma_chan *uc,
> +					   dma_addr_t buf_addr, size_t buf_len, size_t period_len,
> +					   enum dma_transfer_direction dir, unsigned long flags);
> +struct dma_async_tx_descriptor *udma_prep_dma_cyclic(struct dma_chan *chan, dma_addr_t buf_addr,
> +						     size_t buf_len, size_t period_len,
> +						     enum dma_transfer_direction dir,
> +						     unsigned long flags);
> +struct dma_async_tx_descriptor *udma_prep_dma_memcpy(struct dma_chan *chan,
> +						     dma_addr_t dest, dma_addr_t src,
> +						     size_t len, unsigned long tx_flags);
> +void udma_desc_pre_callback(struct virt_dma_chan *vc,
> +			    struct virt_dma_desc *vd,
> +			    struct dmaengine_result *result);
> +
>  /* Direct access to UDMA low lever resources for the glue layer */
>  int xudma_navss_psil_pair(struct udma_dev *ud, u32 src_thread, u32 dst_thread);
>  int xudma_navss_psil_unpair(struct udma_dev *ud, u32 src_thread,
> --
> 2.34.1
>

