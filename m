Return-Path: <dmaengine+bounces-7957-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CBACE5E2A
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 04:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 127A13008F9C
	for <lists+dmaengine@lfdr.de>; Mon, 29 Dec 2025 03:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DD0275AEB;
	Mon, 29 Dec 2025 03:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MDv+p7BS"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010007.outbound.protection.outlook.com [40.93.198.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523DD218845;
	Mon, 29 Dec 2025 03:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766980159; cv=fail; b=Q9QcN3aezBMgHaj6OU3ryyyM05ceq6lb3f1TVkg5JeLn1BymiluMaUywSPQ9ciIv29yVxiAKBhmO+pd573Sph0CSwu0TndfDk9d1M4KdlVAV3sESM6mjxRk/hsekU7fw7FmW6llP6J9WhGztaT+E3DycX5Bg86InUtw6viysKqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766980159; c=relaxed/simple;
	bh=b+gvg6+OXZXqr/GiUEo7mWSnLZ2n19Ptz5kFq/HsaV8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fhvymtVnn1iARHrZr5nUtQeTZSlAtI93LiWDBl3tXWc9/pJ3b4YDKvq0CjKcmvE7TKDGsrqauOeLt/amaMJ7pcQok5MbXYBJZDR4JQcjQFpj79duMsEcdayNRd7V5r4No8uP2OSJ8wbEmXKDOlCLX25S9e9oVWpteYGFXF20YDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MDv+p7BS; arc=fail smtp.client-ip=40.93.198.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RU1lQZ7qya0m0Qf94vGbibhk57Nal+7RggX1xnMgz37A8LRDxBi5Rw53rv8MojwQcigdF+tZRRBFQ+3JOOwPt4Hiw+3yrUVGXXnAGmgogMv8MKOu2t8Tq9v9Ny1nS0qXGjQek1Ff5gf5CeeKnsCXzhmYBaogbnD8cda3QbcL8GDeLeRGEFcMK6TjT/qN8cTgFW2aNtnJM7BU1UChFJp0wO6pbwchdfIYEALRKWuboqyHloqNuegUb6mUaDvj5vXMyCsNmTE3QGFd/gDsI5hK49BKCVsTN7l0cQBZHMA5AbfHF9Z1bwnjo5l66SBbHbu9JMBq+k8kRVuGQ8GHhyXMHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9t30iNxIsFzX5ghDH/qYGDbCzWs3eafUQA+8rebweI=;
 b=U0IMC1E34iDoFrIrDwJ2d/K4MLGmXT9cZFwTpsE/fhX+HE1Yakc3jeqxd2WMpCBXSN1rYSZDUxNoJTTuAurZUw1MiDNSfv46gvNFtW6eMHSK8eoxqKUrYxD9EF/Y8tiJCBHh6/jv6wME5evq8ZIIkShWrqLNhpjBu29BgRA7rz4mns2kDTh4KNP0ho5FA8gCHZuSfgVGzqvJGdL1PPbN5yzawJ8cebOgCBFuqaVPWB+G3uh6o/oSM3jNMRQ8OpDXjTn43v1CsRiHKNzxBnO1H46Pz3F4iPbKP/FWz/nmjNligHFfuyqou1JtASYssP/P+xGPtl9+m/JYwK8kI6g1Tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9t30iNxIsFzX5ghDH/qYGDbCzWs3eafUQA+8rebweI=;
 b=MDv+p7BS48FLyPUEaFIrGJFsmQxX3UJgxPLIOSgUIMcyTI8YPh1a2q/ISZf/Q6ACpcL6iN/h+WCZ0J+PHjp+RmtCKweUjykl1i/+orJkY9DSJmjGeHhgPO7H2ti6QrJ4z7rfb3IRr8tdqYfONa/B/0JTSOi7N9esmL5UZS0TFBIFWmrhkZAqYS0ctYd7vARo+snE2w76AEgqjiu/H09IJGjNIfd143NHwd59P8kOFkQ3ZqNzHFKEYxUW9E4nGkbpSE+C4vmvEE1X+12TevyisXBVCRLjIMxXXDBhmq5NXz/sCJ4NSa/bqAYei1GrxLEJfPQJlRa8ojjxWspKjPKEBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA1PR03MB7055.namprd03.prod.outlook.com (2603:10b6:806:33b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 03:49:14 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 03:49:14 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH v5 2/2] arm64: dts: intel: agilex5: Add simple-bus node on top of dma controller node
Date: Mon, 29 Dec 2025 11:49:02 +0800
Message-ID: <ef6ed8338e54c02ed9508e91bdf120580e834e17.1766966955.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1766966955.git.khairul.anuar.romli@altera.com>
References: <cover.1766966955.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::11) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA1PR03MB7055:EE_
X-MS-Office365-Filtering-Correlation-Id: 498d230a-6f32-4974-b901-08de468d3bf9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B7cyLzi3yXdASscAOkvHgexL7Ie0+Yv/BnXx98w0E5FyJHqOPnuB455nCf1O?=
 =?us-ascii?Q?FiHswABOfBmcDwPeyQhgPbz7w/hcODSt9lf3MWI4arWc8ciboLpUoqOVtzKp?=
 =?us-ascii?Q?Kvny1/FqvF9JPcU1Te0QjZwm1qY2GYIF+r0KHU6zfJJicB7Oa1DG6W/l9Thj?=
 =?us-ascii?Q?mLmewSprjwM9XCIJU/g310WTcsGVRdNHC2Jp2F2F7ylEsNADPchnWpiIbApz?=
 =?us-ascii?Q?94JAFO3Wve1Hyle4Nd7BFhOE+dEVF94cuw/oSA0UN4C6mthbvLjF7Uk5yPMT?=
 =?us-ascii?Q?hLg/2KbYGcGt8ylbEPFI8DCSaXEpYLNMZegKdzbnX+7ffXmiLJ8xpj10z0yQ?=
 =?us-ascii?Q?cTBX4NLiwL//7exjE0e4yTZUxiPTjQNgI5DQ8D2sOvHN4mJenoXYVsBR4iLA?=
 =?us-ascii?Q?5ekrlrqn7cbBGgqfBv1C2ZNuqST+zKxCg8TGsdBmNAUd4jkDfMtJ4HRQeUo+?=
 =?us-ascii?Q?NnLjrENMVE16NNtLOEX6c7MlwS1oQ1IqK5oVTlT57sZBeDAOsc54ELvt+395?=
 =?us-ascii?Q?R0B5aSb+ILCIANd1AkpZ1wi8cTjMfWotw7N/9R7jsFru7wH3kcp61atcxSMX?=
 =?us-ascii?Q?oTBJVQuULSOkUHcy1rUU5E9Etrk4MfTqy7naL70so5/syD97UzUvCQ+tAOES?=
 =?us-ascii?Q?8s/wa1MFhEcpLYMIJAlQriQ0TuVWADGjUUfsX6/WAlxX6rYvVFtOa0y8Q0Zv?=
 =?us-ascii?Q?ZdbgglwPdeX6pSW+yBqZPvBBE06QTqlnN3e7lDjln7T/bBqHCkIktdjHnFTM?=
 =?us-ascii?Q?cF9YELJC/OVUm2+sIuREbU0VE7W/32r5vzk0lGDWe9qN/S0WKueyRipvG1j+?=
 =?us-ascii?Q?l/GB2QRuEnb7YpyMB9DHgkgsfi4j0dw/Qr8XuUXG6yLGl/RB0pVlcJnoHARR?=
 =?us-ascii?Q?ql8GnJB/fyXPGipeotMYGSlGZaQpqc86IpjFf8SZ0a78RPgoztof9eyrZL5r?=
 =?us-ascii?Q?VPG/CwYZxUeqnL6MzaNi0cxtqyrT1iFUbAYMYrZU1a4a/jpYgrpmt3cMJkjN?=
 =?us-ascii?Q?ib2uuE1Kr1+bp1aElZDNTYZYl6dFLZzmvc6HbgKX6ApeD3vsEISLMS8ORsIx?=
 =?us-ascii?Q?ssM9vSFRPG1u1Ru6YN4n6pldbY6fSPmC88QNzvSuOrs2uHfALeV0tgfgiADL?=
 =?us-ascii?Q?hYgYJjs0GGMqpa5hsdR28vvf0AE7OurvzhUONEOflYpKUpTgeCQ3L5yi1b3u?=
 =?us-ascii?Q?xCrSdx9gpxAqNsAoyteh/j6y8tHd/PlJm5aX+xJTpWplthwesGSrdQkKmKeK?=
 =?us-ascii?Q?uX/1RK4LrOYLggo6D1Ec4kncc2ZkhskSuQYW2v78Db58BPTvGaKl5SK785XL?=
 =?us-ascii?Q?HshV8x1qPSM49CUyx7v3nRPShEPRPc1qdmFW3l/vpjEz9CqemfYhi87r+jjk?=
 =?us-ascii?Q?dJ+ZeYXCCU4AfIRAWzZ+xkrwjIZyzWnd1qCNVBz6Aa6xPhCATdoYBS0NT+TP?=
 =?us-ascii?Q?BUcDYQuH1uk8z7sP/v0pqiN01vnpJL45PfmnqGBKR1bNOm8oDC8vMOkeyu0h?=
 =?us-ascii?Q?lXZZ+VL3KZrgzsw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QIm8RMnE9f5kHX/Uc42TRCGKqlptffczZvVkZvzdk+8Po0Y/dEqxI5iDXGcp?=
 =?us-ascii?Q?gFwyVkRcG2T7tdpY7avAo9klpWqoxTVNCcdbMvMzXy1DBUzgpA6DJbTquC6/?=
 =?us-ascii?Q?KrVctji3qCrxQijfi/JtaM8146r6yFo1zxIl4HVhRv8YFCinluoldjfgg/fz?=
 =?us-ascii?Q?1QunAr43hS1VmIF/nXfI2HLuNCmYEo8CevztJCJm0VCQ/iH2ZSkGj46J3lfA?=
 =?us-ascii?Q?NNKXJaoSx3CnC2yU5irFWH+QucZxkq1q7I9d0vp2FW4XdhdmE9vW6k5uu4Eh?=
 =?us-ascii?Q?I33G8342wwd4TA1R0tdI/3uontH1CnzdJaBpJeYMUtHaeGlurMf7JZLsXGRw?=
 =?us-ascii?Q?GBmOsNypoVX5Y8LZ4LyPGRDE7vSltdeewvRhtLpdQMMOGu/kSbqM4HSXiX0/?=
 =?us-ascii?Q?YUqCD9ipt5gb+yUFAWbCRqLK6QQ8KY17h4dMbsF5okd72a5H2BI53lwMpNRE?=
 =?us-ascii?Q?wBZ4oJMIEciILw71UgnTJliqXlUJMZFAJdbwQ2JDVrrfcvLg+X2RNbb/54CO?=
 =?us-ascii?Q?I1D5VkdFF7fxDViRsiHPvyHlWY7bQC+Kuo2A7nwdoz4tBEaRPk6DCILx/Oir?=
 =?us-ascii?Q?KxmesCtXV7nhnIEEMymN+JMZXDX/fWEZufI4z844h+3TgwTAePHqZySBxQUZ?=
 =?us-ascii?Q?cfTqrc+6u1vyUMMH2NDMMTsmfnaIShiHapz+RqOit6IWuAuuAynfK88FqBah?=
 =?us-ascii?Q?FHMg1kO3RL3kVk8B0p8m7YhZC+5qkl8/S7oN0sGKZ+fJ57bPSWglqCsPXQQf?=
 =?us-ascii?Q?biD4MsWz3VH7tbnrNaJuClAdBiE+FG6BxfcIx8kG1EH4jr1Tr33OvukuMG0p?=
 =?us-ascii?Q?ALFaKJEUNnsrDkJxF0S6qVCHg99lM21RP+y09Pvf1cs6WlFQ9qIjqa1eUakJ?=
 =?us-ascii?Q?fPT0nXfCpN3FYOjJ99kaiVBt5fAi60wR/QKQeXqF8ZkHXwKGgjCkBwLdOXDX?=
 =?us-ascii?Q?Ti5EYTBzCytDTbTdm7i0pGWbXcwMm5mgV6ZVRwd6LkGhyhSAxXEOaQbAHNwf?=
 =?us-ascii?Q?TuquwYMvEBZLv7rHFZq8aEoiswOqFt6NIQ4bTOV51nTYB/xfDVGJ/w3vKBNY?=
 =?us-ascii?Q?0WCl8F03jc7UoB2M18dS+FcqQ52a5zlTv3pY/R7Fwk6Z6vudrDBI0QLh295f?=
 =?us-ascii?Q?TDBLKaWl2eahpXSn9pFk0DbUyPD9kA2giju6uN+dTdPLuOLrkE+/E1dn+3G7?=
 =?us-ascii?Q?9tO35KJbwJzk9i9g90w0ycs8ObJpaRbSWy+OKqL/X7VDCsuFj0a+Zkxdeu/8?=
 =?us-ascii?Q?oNl8yVO7FISuuCnEs79RtPF2A1IuT+fSWzP5VQUPI3Xfban1z9zaJrWc27kw?=
 =?us-ascii?Q?BS+uvNzgvVnYwNBkWjfKcqCA1PGN2Ai/mzKi1XaMvxrYubAuTyU2eXuNkPK/?=
 =?us-ascii?Q?5uLegksegGsthZ3yhy3Vj0Vt5AUVLgGyImiuvihla0MTRVuCVMcILYeeRN7D?=
 =?us-ascii?Q?oPSpRXwSPEetNEBZrR4ruMzAbvp0Ca0VA7COyYp1DmCxcSm7V4SUmetx6VMZ?=
 =?us-ascii?Q?n03EUnrjHJgONJ9/bEo1BUTLz7k8QvjgjqHKP8iPv0s/ygA5kbKxXtVA50EI?=
 =?us-ascii?Q?sUQnoMwsfqiGog3vYkl3c5Sqg98sal1Q0gLhmGaUiBrht7YmYB6MAiHt4Lq/?=
 =?us-ascii?Q?kWtt31uSi4NLbfz0aPSe/OiTdejTb0TI6ClPNOlAZM70nIhKdAcmaC3cSGGh?=
 =?us-ascii?Q?dHBWJfmyazE6DxW4afjvla8V0s4HCP9bWDaz+q3w0DO7Yp3rJFxQQEeYLDI6?=
 =?us-ascii?Q?nB9nH/GpVf1XbKKqVttVLYufcxsB+Qw=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498d230a-6f32-4974-b901-08de468d3bf9
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 03:49:14.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Ltf2+3Xio5GeYlsLs+aNuRazRym5V04bOBW84CX9EDgcIc0el9Cd47NJ5fgJrPsNDSMPW7JmF1qtv3k/b3leMceCiV8WueQKQsJX3YFNog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7055

Move dma-controller node under simple-bus node to allow bus node specific
property able to be properly defined. This is require to fulfill Agilex5
bus limitation that is limited to 40-addressable-bit.

Update the compatible string for the DMA controller nodes in the Agilex5
device tree from the generic "snps,axi-dma-1.01a" to the platform-specific
"altr,agilex5-axi-dma". Add fallback capability to ensure driver is able
to initialize properly.

This change enables the use of platform-specific features and constraints
in the driver, such as setting a 40-bit DMA addressable mask through
dma-ranges, which is required for Agilex5. It also aligns with the updated
device tree bindings and driver support for this compatible string.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
Changes in v5:
	- No changes.
Changes in v4:
	- No changes.
Changes in v3:
	- Rename the patch  "arm64: dts: intel: agilex5: Add dma-ranges, address
	  and size cells to dma node"
	- Add simple-bus and move dmac0 and dmac1 1 level down.
Changes in v2:
	- Rename the from add platform specific to add dma-ranges, address
	  and size cells.
	- Define address-cells and size-cells for dmac0 and dmac1
	- Add dma-ranges for agilex5 for 40-bit
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 78 ++++++++++---------
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 78 ++++++++++---------
 1 file changed, 43 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index db8d5c426821..2d8ce64e2388 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -324,42 +324,50 @@ ocram: sram@0 {
 			#size-cells = <1>;
 		};
 
-		dmac0: dma-controller@10db0000 {
-			compatible = "snps,axi-dma-1.01a";
-			reg = <0x10db0000 0x500>;
-			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>,
-				 <&clkmgr AGILEX5_L4_MP_CLK>;
-			clock-names = "core-clk", "cfgr-clk";
-			interrupt-parent = <&intc>;
-			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
-			#dma-cells = <1>;
-			dma-channels = <4>;
-			snps,dma-masters = <1>;
-			snps,data-width = <2>;
-			snps,block-size = <32767 32767 32767 32767>;
-			snps,priority = <0 1 2 3>;
-			snps,axi-max-burst-len = <8>;
-			iommus = <&smmu 8>;
-			dma-coherent;
-		};
+		dma: dma-bus@10db0000 {
+			compatible = "simple-bus";
+			#address-cells = <1>;
+			#size-cells = <2>;
+			ranges = <0x00 0x10db0000 0x00 0x20000>;
+			dma-ranges = <0x00 0x00 0x100 0x00>;
+
+			dmac0: dma-controller@0 {
+				compatible = "altr,agilex5-axi-dma",
+					     "snps,axi-dma-1.01a";
+				reg = <0x0 0x0 0x500>;
+				clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>,
+					 <&clkmgr AGILEX5_L4_MP_CLK>;
+				clock-names = "core-clk", "cfgr-clk";
+				interrupt-parent = <&intc>;
+				interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+				#dma-cells = <1>;
+				dma-channels = <4>;
+				snps,dma-masters = <1>;
+				snps,data-width = <2>;
+				snps,block-size = <32767 32767 32767 32767>;
+				snps,priority = <0 1 2 3>;
+				snps,axi-max-burst-len = <8>;
+				iommus = <&smmu 8>;
+			};
 
-		dmac1: dma-controller@10dc0000 {
-			compatible = "snps,axi-dma-1.01a";
-			reg = <0x10dc0000 0x500>;
-			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>,
-				 <&clkmgr AGILEX5_L4_MP_CLK>;
-			clock-names = "core-clk", "cfgr-clk";
-			interrupt-parent = <&intc>;
-			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
-			#dma-cells = <1>;
-			dma-channels = <4>;
-			snps,dma-masters = <1>;
-			snps,data-width = <2>;
-			snps,block-size = <32767 32767 32767 32767>;
-			snps,priority = <0 1 2 3>;
-			snps,axi-max-burst-len = <8>;
-			iommus = <&smmu 9>;
-			dma-coherent;
+			dmac1: dma-controller@10000 {
+				compatible = "altr,agilex5-axi-dma",
+					     "snps,axi-dma-1.01a";
+				reg = <0x10000 0x0 0x500>;
+				clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>,
+					 <&clkmgr AGILEX5_L4_MP_CLK>;
+				clock-names = "core-clk", "cfgr-clk";
+				interrupt-parent = <&intc>;
+				interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+				#dma-cells = <1>;
+				dma-channels = <4>;
+				snps,dma-masters = <1>;
+				snps,data-width = <2>;
+				snps,block-size = <32767 32767 32767 32767>;
+				snps,priority = <0 1 2 3>;
+				snps,axi-max-burst-len = <8>;
+				iommus = <&smmu 9>;
+			};
 		};
 
 		rst: rstmgr@10d11000 {
-- 
2.43.7


