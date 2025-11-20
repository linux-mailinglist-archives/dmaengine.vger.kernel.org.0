Return-Path: <dmaengine+bounces-7254-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D90C73C4A
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 12:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 764D74EC925
	for <lists+dmaengine@lfdr.de>; Thu, 20 Nov 2025 11:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CB730ACE9;
	Thu, 20 Nov 2025 11:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="RN1fn2wt"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4BB313540;
	Thu, 20 Nov 2025 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763638345; cv=fail; b=p+MqhXEOIr11tk6NsfghxB3+7/ngyhc9Ze8PurZQMcLp8RNVURlUw6T+/WB+oWXNR0WRgTiJze74ai/4D+Jt8mnvNSaAlWtYq7MmFaGcrGty56AVUZipzoOGxZmVPpi8SZlnDauGzTGpgVH8wJHL7+0E2dRSu9U2SKY3RMo/CDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763638345; c=relaxed/simple;
	bh=UOpaLFIq2QUBVUSRCgg2UIRyoSePY7kqndBEPvAzCwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QuO29WoSNX2qDLAujy14bFw+rw9k0hdBOjbkYHUbI8CBI7bEuRr6vUMu+SGXPT01B2Pwi3+OF1blzdFux2EDlGjdUeq9jzcgiMtlTdSdxuwhc/VxFiKsy8iVIBAlWW9iopsta283SGhpxWSpp7Sgrasct5R5/vWw7niRHlbaFhs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=RN1fn2wt; arc=fail smtp.client-ip=40.93.198.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIwWDLm65RSY4nw8VoesYOC95oRMRKMO+yaX39NHSNPUnRGsBUbajbplXbUkz9nORnP/JpgWwXlwmkSq18morBe7wPvZq0Xi41EX6UwudiAjfX/6z4KseSTyxDk3b1hsSfgolhtmTxBy/2FwIxBftI7yW+QHxEABy6PgE8GfqyxIs1OzFeiCj3l10l3htYIKL1RQSayKI2vmFzBPoP+wsDV4N2oCaQcY1DyYUvcU61HHOmMU8CQ6v/M4DKlWaTx33sQpbQNf2HGhHi+Ct24SR+QcbC+QY1eMVEQusVd8FPD13/C4fDfdTjWobn6zZ+mLo9st61HFI9nKPvxV/ilt6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L2NzU6nn3KJYkK6DRkANpmqYAlnBtJnOTmlFoYZ3pHw=;
 b=PLMM4FeCJuWc2c+0hGo6bNPBQeifAJQNctjRRAk5c5T90N3aK8DADVkr8YhNHBlqd1EO0iijHt3bKodUsVH3X57WuJMR5NiFSxFAivOuyCH64X2MsHrVspvObLlnHh9V8naYrZDDHvcYx+vCEfJwiyjWBGgI2pvKJ9BQA9PddPHQOQLaeGInGz655DiJL3IYYndpbWLZlg9HrI4RbA0ErueE9xTjRhFEU5RricOCxyYv5pPALD7KvPRF9Fp81qqic76p9iOrTKZdqpT1G2hCjF5soS5bME/zqWo3olvxLAu5dPcFglDOV50Kkgbe3z16DDirS1RyxoY5tCDdB9OzHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L2NzU6nn3KJYkK6DRkANpmqYAlnBtJnOTmlFoYZ3pHw=;
 b=RN1fn2wtBlBYxYh4SXHP7qZd5lmEwrZRunZHP558baRt1PReZmOtmPHYrEMK7qoFaVWjzvWp9gJwk9iEU3cEgtW7gYn9Kzfg80aI3/7YAxLcy9WgAAI0Y5ty9rKGFxhviDWVuNcurBfMO2NCwOybviejiiP8d5wq+fOI7fBSONhcdECYVeazRG8T9eF0g+Ydw2cCncehfhZeUEQN2amJqXjZxBPQ4VlQyfhbpa7Sk5BWCbYyaZLgYTwDh/Tj9rCfxWxupduysrm1mamNQp3mIkJMV43+5oLVdnoTQV5x9HjOpCwmd3+5uwaRhyKdtbA11/K6osZgCndaKQDXMDNEsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by PH0PR03MB6914.namprd03.prod.outlook.com (2603:10b6:510:168::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Thu, 20 Nov
 2025 11:32:20 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9320.021; Thu, 20 Nov 2025
 11:32:20 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 2/2] arm64: dts: agilex5: Use platform-specific compatible for AXI DMA
Date: Thu, 20 Nov 2025 19:31:11 +0800
Message-ID: <ccc5dbcb9de9dc2ea6c5e46833ce8943b0c2bd52.1763598785.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1763598785.git.khairul.anuar.romli@altera.com>
References: <cover.1763598785.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|PH0PR03MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: 73074f06-c9a6-4f1b-88c9-08de28286afa
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFLxmZ6/bpLU7OIwnd/1V7QRmRJSQsIZZgbkl9FU1nRKWSY+Wzdtjv231MoJ?=
 =?us-ascii?Q?Tu3geUAs2ovq+Eqtsr9YifBYilSeFbIhYOU6tLhRC/9aShP0nuChdpiyNDk0?=
 =?us-ascii?Q?L7Y7TJRlUcn84kvM5GRwEWnDFy27pf6pXBtjspgdvTyEUQowYCO4H6Jlb/ax?=
 =?us-ascii?Q?McmoQEz5Xh3LuhvzFRRwU20mPmEDsgZL6QIkEyttt9TaUasvuA+UpTJf2KFv?=
 =?us-ascii?Q?jff4LdPKt3WyRCH2hPtQgqkayfi2qNFxOUr9RpzjiO8yIwkKkS5VgDpxCkpS?=
 =?us-ascii?Q?d3tlkJVRKJY/5zBh/2qehB0lrddR1T+vYWdkfqrmssVZ9zbrqvBsz5IompnR?=
 =?us-ascii?Q?T5RY7X2BJDHJdHUsT1UP5H91KKqEOKtY/8jFxHt7hIcaG9vV7OsVtSyHxF4F?=
 =?us-ascii?Q?VaM3OXyDcP/6Qyk7ei3q4sUhKbE7981AHG73MM62jHEQmwizZQsVOY5cVioq?=
 =?us-ascii?Q?6ah9zdC28DJS3m1VUlt/pBJWKgj8DZdKPnKrmYQPmpZkKiFFXKUMRRRkG2zv?=
 =?us-ascii?Q?A732ezwvjUQWj9uKWAJUIJd0wkoRUVUyrj3OducEy6Gc/n+h2+eM0Ujp8fUO?=
 =?us-ascii?Q?TY3VvCgj1D+wiWIL7kdOpBOeZjTab9jPVijJeUXrLvcD6QSrmzXiG7/Cxzcq?=
 =?us-ascii?Q?1aOzQRLOmXXeKDOno1UdUzl/RDH4C/9S6PuzT/0woDYsVZdwNuPzD35RTEIC?=
 =?us-ascii?Q?78ridnc/qGmKM7EwDL52CobI+zDFbVx0ltjf3A8q2YC/TfFyoI/nd40bwxXD?=
 =?us-ascii?Q?/0/mLJ3Fmo9RuE1pDPz+eBSzikschIYsYdzClCHMdr8n1c30X7LzmQtrV1Og?=
 =?us-ascii?Q?JoudVB9CIvgD2MTAMPEGX7WRPCpexvzb/XeibfT4ju6HZBQm/1qf/F920Znc?=
 =?us-ascii?Q?kN9XBWHmKZD3Iqw10MYZgh9gznL9iciOVzvlJ7Std9vuBxpssDmVg7YDQcNI?=
 =?us-ascii?Q?0Sx7q+bg2x1l9c1cS3tqdi61YoI9QlDO/U+axL7oCdvW4Zv+i6f+4UKDQhAp?=
 =?us-ascii?Q?6iByiQfAbn0wYHstvLRp/jyQfFh9G8XVNs60TIrx+xcGwCRUUNR7kFVNUtGA?=
 =?us-ascii?Q?LRNDZIbK3It2/EOMNc8JhCRMEdSbo+B4Q+t7Tw6Ko7beNswxlnVutZaYMF2i?=
 =?us-ascii?Q?SEf0oJ2tfI2CwMkQ376HJZdnVEaOHZj935NPkty9wBS6VbVO2k882bMMnabQ?=
 =?us-ascii?Q?AMsKJ8xiL17iWspRpXjL+KTK09JdRGP2rWT47GGd68fdJZqaZDwpxwhm2nP3?=
 =?us-ascii?Q?jp+ijpwZ/Pi5nWvFQ7ttiTbAWrhGu6ySxndKfYw4YSYqGxaIggUcrrIAfjlw?=
 =?us-ascii?Q?psB1FebuZYowsfyskwFNHoGUxKAembm132PzQJL6TWFPS+sRW7mPM1KkpEAH?=
 =?us-ascii?Q?aqFkUSXAKocKQgYBjJ8avAiZ0THOUAuy94T9S2/heQQMeQC1eRdI4C/WplwT?=
 =?us-ascii?Q?h/UOmKDqpCQD2ujlduU7A03Yz+4XHmOO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?K1sr6iKtTPatCzGIkDVjnVLPCSdPMtaCdCqVnB8uJa4RaWyKOVL8YyfgvVPL?=
 =?us-ascii?Q?nbZqTxlTxYKGmhfBxhvq1F0dmF9OVfyAeUcZP68RYlIj7YjuxJC+oYlLW6XM?=
 =?us-ascii?Q?mZX0h76hb55F8uNm5e7Y7WiYnGMUpB6rKFjMvHy1R7eStJZPiWRvZym66/rt?=
 =?us-ascii?Q?MDOhbMGq3e9r+t1faViTyoJ+tLjUJHQCTZjXBWUWZb8cQLIdunBft2zMj64q?=
 =?us-ascii?Q?G+mK2pLWW9EJtLugUu6E2IPH5mvxViWhoRt+Akxoq+QtFawGSq862MYagRMf?=
 =?us-ascii?Q?7sf+pQNK1vEcrbJIcAvdEXq2D6iKdKpC3MAyN+hI/KuSLu9BEw3On2ETEGDB?=
 =?us-ascii?Q?zRq+2JVB6mZ4B3ua5tAmTL510FrrySdjDaNUReWskqH7r/reWY0QGjay3rQl?=
 =?us-ascii?Q?I+q5D4vrd6/nQhVvQK0goq/FtzH94h5KCeEAUMRYFT8VzJlbn87014jkISKF?=
 =?us-ascii?Q?qawVol7PL69l5GYVH3b6wO4NOausDY86PZYPJiXE9OSOsSR+JTYQ/gCp4hIP?=
 =?us-ascii?Q?mIpGCQ/xHWR6QKq45G3sg70U94JbDI9My9glhzekTnUqcKX8eibT5YCI8T1m?=
 =?us-ascii?Q?Nrklr1PzkyWUuMIZL1dgYU2Eg1KQA3rNtkeP9NPPB1TrISeFAI3XrEKD3uMw?=
 =?us-ascii?Q?gfI4wgmWHtHrjts4nZzafBzxyhqQCSXdgmUI34aJztZ5mxii1CFOIh/djuWA?=
 =?us-ascii?Q?QdjPIIt9gJYblX8j5+r7PuINZsh4BgzlpOmp5bQmQXQXRiLnUyJ0o7WEaFaR?=
 =?us-ascii?Q?qGhc1tF6vkCMPcHFajZXhtwPxz8pIxBqs7zb3Re5nutwb9+57x88uHoRtSIK?=
 =?us-ascii?Q?SDSz2NNFhJtbcDTaPqCVX+jdlFUWH8QdOwDXsQp15valR1YDDYHDZamu5g7/?=
 =?us-ascii?Q?aKVzGf7hvBgZHuJr5UXZqLG1WKb+ERNSNRpuDC7QIwZcUBn1lIfSVL70du9U?=
 =?us-ascii?Q?MTujM/NxtIXMj+YVu165RK/t5YPPgiCgA4jZ+mT1H3B8XBiPVwSt+tit5zee?=
 =?us-ascii?Q?TsgS7nGDb7UeoSqujs8Hy1DuZfsDauxG/drPT/+z3FqbR4jk5rBlpNCZWGCQ?=
 =?us-ascii?Q?JBeXJpe9J/L5Akx8JQbKWLef08yTgdLFEFqqXY7XxAgKZX3auBCRBZAMeXwg?=
 =?us-ascii?Q?jmd6PDlfSNktPkZKDyV3ACFvbhoke9qBKMh+hlxcRPv2Z7PQXX9zoM7i9ari?=
 =?us-ascii?Q?6GRR7BroMq4gCFM7O9qMmr6m3qM+FfciGS2Et1R3VwxB8Oh8puuwP/l76StH?=
 =?us-ascii?Q?gjCMLTsn6hLrxij7z6As0/XZ86gPSfA2w9ogz2D3vx5sYr0ibh7qkp4v9gRW?=
 =?us-ascii?Q?EXnheqcppXqayAlwC1mKiV2mtq85jVJjxyPX0bfxTJDTd6KszttRfhwfR9gD?=
 =?us-ascii?Q?iB4SvgbCKopMhZx1Le5QhGFxglqUTr/3LCblLdXYWA0l330LPigPTx9e/Px1?=
 =?us-ascii?Q?Q409QSbobSJN4p4G2PFRuT+ouFSkxvcQCPvaZKB3degYxv0K1n/Hx5gNvNfQ?=
 =?us-ascii?Q?jCoQoro6QA/aIjUqiViOsIpXW/lWpSfgXACjwUaerhLAdRT1QfYZpahSF+9H?=
 =?us-ascii?Q?8y4hbD57npR7DG5uodFJQyk3fHiH7efSlTpJr2nI73ErYiciu0hYCXj7PETb?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73074f06-c9a6-4f1b-88c9-08de28286afa
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 11:32:20.1926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RI0uOR9TitdgVJvoNws1xSQdwWeNsHH12sOfQBWvu/zNh5EAFHTBfXS0DiwinkIz0Qht9rMzrsbf7zTW7ipNDT4+zrALrVQbSQxmBlbPKpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6914

Update the compatible string for the DMA controller nodes in the Agilex5
device tree from the generic "snps,axi-dma-1.01a" to the platform-specific
"altr,agilex5-axi-dma". Add fallback capability to ensure driver is able
to initialize properly.

This change enables the use of platform-specific features and constraints
in the driver, such as setting a 40-bit DMA addressable mask, which is
required for Agilex5. It also aligns with the updated device tree bindings
and driver support for this compatible string.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index a5c2025a616e..ef33f27b1a4d 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -324,7 +324,8 @@ ocram: sram@0 {
 		};
 
 		dmac0: dma-controller@10db0000 {
-			compatible = "snps,axi-dma-1.01a";
+			compatible = "altr,agilex5-axi-dma",
+				     "snps,axi-dma-1.01a";
 			reg = <0x10db0000 0x500>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>,
 				 <&clkmgr AGILEX5_L4_MP_CLK>;
@@ -342,7 +343,8 @@ dmac0: dma-controller@10db0000 {
 		};
 
 		dmac1: dma-controller@10dc0000 {
-			compatible = "snps,axi-dma-1.01a";
+			compatible = "altr,agilex5-axi-dma",
+				     "snps,axi-dma-1.01a";
 			reg = <0x10dc0000 0x500>;
 			clocks = <&clkmgr AGILEX5_L4_MAIN_CLK>,
 				 <&clkmgr AGILEX5_L4_MP_CLK>;
-- 
2.43.7


