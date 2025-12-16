Return-Path: <dmaengine+bounces-7736-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70993CC577C
	for <lists+dmaengine@lfdr.de>; Wed, 17 Dec 2025 00:27:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 232533051EAE
	for <lists+dmaengine@lfdr.de>; Tue, 16 Dec 2025 23:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E3433FE26;
	Tue, 16 Dec 2025 23:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="Lf/DJxtc"
X-Original-To: dmaengine@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010035.outbound.protection.outlook.com [52.101.85.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03F133FE18;
	Tue, 16 Dec 2025 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765927597; cv=fail; b=ql1FLhn+61KVYqxYsIHkpBnBxilWPWeeiqNWMNSTdUlp/YNdohn7UM+W0VtaUK9hX7/eNAynjzOoHTrMh32zAn2193VtXpyBs/sCrKMcpHzTmkj146Dn0i8aiSW9BghDoII8pBbxpJIz+8rAWM518x+070YigfmpDZ6R4fwOjH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765927597; c=relaxed/simple;
	bh=CGdTMgO4LNXuDvElK7ZsaaQ8KrM1ROXAOStqHOz06Ug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FPd1SVVx6PMloIXdFss2FRZcmTGSOUYnuhGML2slQ5nuzURGntr1KeIlTk1TVxJmHpyMoFY4vONOlWL7oPy53rktAfQxubFAZ3WN097vcRNfbWyxNcHXzCDj2KR+2jMonwOMD6gIPWboJOs8A52V25NWhjYiS1hye7YBXdH3+Xs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=Lf/DJxtc; arc=fail smtp.client-ip=52.101.85.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2NVyXheKD5mbfEyoxfikoYfMZA9jOSMox1BpTTduRIe4FNYrdX0yVlCoe3SMqhIVK5Fk3Mr+bX+8GMZpMF3cabUA7hS8fpkEkJEHhjs48mTksjsy5hZhCAfAIyIqxlaJG7qMmGbnjopi9AsGYP8EpQML8mW2XtlhkWB5jxQOnaeGxKcB4fIu2lix+XkUMXFtTbAVZPinX4R1BD7L5Fk9Svfph3dRzfObFKUux8qgOXnFHiFK6XCo5cw1iUNNy23Twp/IIfxK67Z5h08iZiofnbMpY2QdcpCDGVLZjfK+ZnFPKP3Dj7a7c2XobmHSNLIF/fk2px9jPGTPONNT0lYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BSd7Secu0V/xQiq21VFka2vKsBWe2eK/bBs5BG4T4U=;
 b=EIqS+UeYmXFkcvFpVFXFsU6co9kmd/W10zlLElont3xqwVtUXmtEykwMbnFTsxOsXD7+kU6vG+XDODBbL0AsJQBLFU2qlwEjeunDeiB3VVmDR34Tnl+4RoR5eTdnpWufpyRiBWot1lrURkd9ronzajhsCz/jJ6s9NNknht2SqYDw+35BO6TuDOuHxrWP/Pp+qtZyubqu8wyLuI3Fb7q9cN8XX0tZTAClYyycSdOXb+Mb+1zOUqQgzWL7kR/U+8ixqrH8ULZBgGoHuOWAsD8BR84tW8mo5jK4UAKBre5EbETPa2bnfIEorbmkB4VraIx+C8A/yBPr2EuXNuUEvFa2zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BSd7Secu0V/xQiq21VFka2vKsBWe2eK/bBs5BG4T4U=;
 b=Lf/DJxtcy5uv1Em/Vx3LqAYxjXgfHovJM1kocpFcdlT2RVG/ynAoxJvopit0ONWZNjODy73qjdZUx1q/R66h1fULHSzvckNAIRn6WxhbeC4YS9HXHaaNW+0sswUhg/JhkLhaxs5AijEh9gKQCuuGk0CZeu9klXz+J261Lsy/CJ4JoLAj2rm1k+HO+c1Lb1hsjcI8LUZsJgsSKmIaprMGFNZcLJvISuddSw/Hbeyc/UvKYXmN4P4D5YuvZOlT3GBlAHIdoZS1axHQXW0LFxTBPnFXijWb9bKB+NywZBQ7snzyyU6WQen8I4tTpDhAXWlWZdS4xcR/fXt5LLOtuUpw0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by SA1PR03MB6497.namprd03.prod.outlook.com (2603:10b6:806:1c4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Tue, 16 Dec
 2025 23:26:31 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 23:26:31 +0000
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
Subject: [PATCH v4 2/3] arm64: dts: intel: agilex5: Add simple-bus node on top of dma controller node
Date: Wed, 17 Dec 2025 07:26:17 +0800
Message-ID: <ef6ed8338e54c02ed9508e91bdf120580e834e17.1765845252.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1765845252.git.khairul.anuar.romli@altera.com>
References: <cover.1765845252.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|SA1PR03MB6497:EE_
X-MS-Office365-Filtering-Correlation-Id: 3998c100-251e-47ff-39ec-08de3cfa8b69
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lowiWqY3XBrUG0HYdjlBdFUF5gSKVGyEtWQbKedlJfSk5GB122HpNfphw4en?=
 =?us-ascii?Q?7b7BcJllhj5TlVZnSYyYQLwm/QceaMPtIWu18w+uHNl+QT+nHKyEioLNtI2N?=
 =?us-ascii?Q?LiBcGDKQ/Mqx3u36e22ITZEoFLrT3SVRRWixVYGENAKnT3hq8Zm2envlBFDC?=
 =?us-ascii?Q?rw6REYbZS1v3RXP+1rkrjnUT79wvOhLhGmwT2TIo5cGY98Zwa76+dWxdeONr?=
 =?us-ascii?Q?xN8W9Cy4ofrEDT9xPA300YbvMz6c9+0MrK4ak0O5gk9+GzA/gC7Kmj5HX9oh?=
 =?us-ascii?Q?XPLZAY8RKta5d8gSAAh4Y7zcY6Z/LsjGHBgP7mqamnEUcr2Qlkc7zojD7pPr?=
 =?us-ascii?Q?HbR8nkkwyPjxOAbmEL7sF7vwNAcospwlhwcETvnYHBsn+xOBXHKvtvRimXwn?=
 =?us-ascii?Q?phDV7+ZJB8aj9MtcA4xSDr8Y8B8IP2lwSoQ26aV0hHYzPs1zVoao7k8PFnK1?=
 =?us-ascii?Q?HZGeI57VPjBjNRXViz8tiS4W0+kKReA5v+WXReMqzudFbbK+MUpRh+EvlbQW?=
 =?us-ascii?Q?cbsfOSkvp+RkzUpKDKpocvbCw03gj37UmYbAe5FfScv6+qVYiLAmtXPwJJdt?=
 =?us-ascii?Q?6dGW72b5sQTw0RAX/V1JlFKGHFKPfoh6eyCzwXFjWeGFvYhPpGwJP+UB8sK9?=
 =?us-ascii?Q?hXD7z5nNSGsl3UNMJDwyNl6s/uafFGTgiRgT0xeWLL4oz+/iyDEk+M4p3jMb?=
 =?us-ascii?Q?JDU9/ghOnCj+oNleY2Oy7C1jTchzhv7J2J4eKDjBzDbei9FYofeqOEzG+stG?=
 =?us-ascii?Q?MtTnqq2UVGz2/JMydqW+evUdQX6IsVf7Bf/m0/Lgx1Yay0mFXkMmA30L7etB?=
 =?us-ascii?Q?Kf81zRConyZ2PvAXNeQTUeYiwlMPCSEgr29zWR/I2r7mMDAnm/er8VEDDA7u?=
 =?us-ascii?Q?LDFRFLBuMtIoYvMU+lDaMykFWNIfOUTQjKEBZVQOhAp7mOqmORIcGnHcFXdk?=
 =?us-ascii?Q?d5/Moq6P6UA6ll3k1UNDeJt4kwq/8+2dG5P4R8g/sjv/BpZzUgprtepMq3uE?=
 =?us-ascii?Q?zPJ8iqzA9Syh+BcrG3Ce6km6nu+BSAAUV54mEGHHS5pypt/d0xdlTs2xwXTn?=
 =?us-ascii?Q?lAUts0YhE8AMau5UtHMUDCugdD382XSLV+cT35QZOSqizWVnalrNNYnQT0zB?=
 =?us-ascii?Q?bx9+moBDJ9TF0FcG7p6del4vVdZiSGDTQJLHMnJqw5jtRGiZardKUunrc/+c?=
 =?us-ascii?Q?L+556Dgj+79PLX95VMORN7Afx0oylDyelq78HBSWbupJeIYQoORDuKyVLvq5?=
 =?us-ascii?Q?IFJThsFXu+hGm3ujoOk1JUv90boNCU7eWq2Xmibi2y/tEbMKLqHRkx0euJES?=
 =?us-ascii?Q?r6BXYDBIRi1PbWpOdz377/o4ZHMepatxyJjulot/A9s19yl3AEGbZ4g8wuAN?=
 =?us-ascii?Q?Fe65W3ue4n478GphRKgFVegYjOyXKkP/dIx40yBUe8msIcg6/m1hm+PhFjY1?=
 =?us-ascii?Q?mGOz2V7/XaJaeyGHgpoxrM7HvhagX1OCtJg4+IHcwzynaLrxV3OxEKINoupi?=
 =?us-ascii?Q?9IPDjmD4xGgI+6E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hn6G2oO8kZC3U/ibgVvXprAvkgRuez2lt1x00KJtfymuW0ekXWaJPZ75Z9JV?=
 =?us-ascii?Q?56YM73I7JtLNzfcv8CwzC8+eEDLJVslsbjOYiQc6LpZAU2+37XbMGlk/Y3tQ?=
 =?us-ascii?Q?Ka8vpOKWMxo2ogiqNW7FerQjIohi4uazb4ags283AZHucYotVE8UtZlrp/F2?=
 =?us-ascii?Q?y0cx04aqoQ+Q0DPzydjVND9btwXoLfJalO06npoK0P3GelmztutoN2Esj0RZ?=
 =?us-ascii?Q?qfWVojm5Zy8cq23SDWbUWeP+dLangB9hdOCmXpjPZVlCaOADROj05k2Tu8Di?=
 =?us-ascii?Q?4fbzFbwPmf6WFbH7BgF16toUzb9qM+oIfa2Rr41YXy6twmF2JZVh+wv2VSF5?=
 =?us-ascii?Q?L2vw0RrUPQ/9/FX26XztwHPIC5N4bzpDth6WnHEmeyuaBDr1Ymzv4ZMgsoCS?=
 =?us-ascii?Q?6xJntroe31aGeIV1hisyFH9BxPZGvVgdQSWKS2gBBAJFWa4+1jXUSlNTbyHJ?=
 =?us-ascii?Q?+CUUpq/nJnY8P9hFkxYLFMsYsRPbQqbM/WVdD2P7YDEClfxBo9s2gtE2wpWW?=
 =?us-ascii?Q?PiXCVTatKZA29IrvOdm7s/xcCBuOMC1j99C4AA0rv2iwF5bnz7wfIxu7suhA?=
 =?us-ascii?Q?Eo0nBJxdyBdqexcRPhCPPOdkbP+KtJq88zAf6PZfAd5OpTcrsgyHkEf3AXJK?=
 =?us-ascii?Q?uDJ5i4F65qSFXu6d8wjAq/j0k5OY28yUrIOyp1QDZqVPUh6XB82PidcOwpgq?=
 =?us-ascii?Q?Q4ZoDilX3jcsiFkVqYNiikjNKbKgRVeTrsCA7sa4U60HHlFddS+r8VWT2qIV?=
 =?us-ascii?Q?3IzLwoBQxlYZRwM00LsDvr6RDkt4wYCzsFtaIibSYqMnlVU4xn4hUp9DG42l?=
 =?us-ascii?Q?tof0OqgDZb+cTbsEYsro+/c44tfUd/bAEU8TgEJjyI0J569gSDe3LJ/1jZwd?=
 =?us-ascii?Q?/5EWA/kK7/tNx9LUUEDvs9P+9PCET09fuSqweHqiXsOAOkT0pSkm+Wbg0xpS?=
 =?us-ascii?Q?eQ9DGgEbQR7AgfP9FYglqoYrBZTetDg1VQp1v1jMoCCb2vfp12vKgNCq8D0Z?=
 =?us-ascii?Q?JisqbOQ6RodHLUZQ+gogZw8f5J7fRhioyQXajsVCMneX+zqFQTCZV3TH/JKW?=
 =?us-ascii?Q?z/A/OATvfpywkj8mogbj7dhM5PlT1zl2Gzu5yAKe/jPIt/YfbouhSLOTiLTG?=
 =?us-ascii?Q?jpWE2WL2Cvl1fQMVAXuLEqAw45svmCm8TzDP/u4Y8adC0LbwIgHickiKL0Kk?=
 =?us-ascii?Q?hl1s1/Em7m0GXp0ToVGDVwU0XnzAo1Ujqfd26YW+HB9EX+r3r1kWbyeZfWSz?=
 =?us-ascii?Q?hoY6z7VczIKCu6k+3KcflULFr6dLhGm1oeqjTEDZBJwADxHypJVBVu85vK1F?=
 =?us-ascii?Q?nnrkStxprkYhK+WJROCVRLzN9BxZ4Nu6zGL9GYbITYhd7Oqj/Is8i4UdC1cB?=
 =?us-ascii?Q?xZ/esvIp/Rn4N+YhlK9EudvNwXMbfwDoWp8T9LpuvF3deVGqmKH4NUqZ5zxn?=
 =?us-ascii?Q?TRDOI+ti5MQgnFSNbmB4pLKqYqFPWTH5aNSrPXXqZs0SLwE2WEze+eo14f9B?=
 =?us-ascii?Q?tx67IcPVcg+gWsxAiXqFuY6l9gLsX8gIxzW+NxjY2IoGIFHWDlZKnIv2yUsU?=
 =?us-ascii?Q?EG/6KvAl5ekOJau+CPMKPqG4hpEKPheZiRY4myqKW6YhVfPoRyBZNxkgPBsg?=
 =?us-ascii?Q?jV7+f8kt4qJr9SE+viwMZWgC1kEPhZSWx5G+LUBwyyJPzDkllfpTNoIGEjzO?=
 =?us-ascii?Q?82GhTWCOAxgGU2ZVUuPMYCce/ukbn8a/rd8Bs58GZE2RZ3S8cKOMqwO8guG9?=
 =?us-ascii?Q?2Ns8B42BFu7kW3GvVEjiT1cxhmy5R0Q=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3998c100-251e-47ff-39ec-08de3cfa8b69
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 23:26:31.4090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ch09bReokmgdKPEdL2kOZciVKQxIQMhesxNs/UrBb+fVm6Y7crhGYhFOtz/8mrAGDHvv9c6AaLFfA16Gf12EdHNmPmHlyz+3+TrRaY05SzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6497

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


