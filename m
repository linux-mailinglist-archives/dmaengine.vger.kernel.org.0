Return-Path: <dmaengine+bounces-5186-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4A5AB9527
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 06:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F573A9B6A
	for <lists+dmaengine@lfdr.de>; Fri, 16 May 2025 04:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8374322F39B;
	Fri, 16 May 2025 04:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="ruFyCto3"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11010030.outbound.protection.outlook.com [52.101.51.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C2322DA06;
	Fri, 16 May 2025 04:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.51.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747368399; cv=fail; b=UPE7Mzr8IT7ryrDCL4qgoi5Z2VteHZvBU3dtxQ9KePnDP8Y0z3Lxp4LAftH4w8Rfu22bFqfd4sCty83Jx3AjEyNgkdvgXxBtnLG4dcdyCOdCzjUmvRn5lDNT7xaiIWsHs89vgN4j1sJoqbiUshj3pV5XhANwPEJAInQ2xobW1iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747368399; c=relaxed/simple;
	bh=fWBQTdfpEVkj9EJz6G54p5xCLCPZiRjWrSEtZpoqv04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncCbw3qS0hcHJfTZ2ZezYtQ4s3aQpw8PMNOreHQ2zmso6KBhNuw3UpLAUVSTxrmwrJifSu+ruc6I61aja2w+3OtWMH1G+ryCkp6lQ/yeQ9Ayfzp1J7Xx0yucbcNBvh1Bn3KXcXmkopJS/RT5F4TZ3/yEZx8wtck2LUbKGZw14rE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=ruFyCto3; arc=fail smtp.client-ip=52.101.51.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bplMsd3AgDlJBTqp9jA2VHgP2PlwPrCvE36LsjY998eLOp7DoclNU29k9Q5UsIvVUy3WAmgTU9F1XpdArStwiDcODFXkVmXMjoQmm2x5ksypswUkgCeuSUXNOEpP4r3gfZJRdHuSXsitr35Hgh11QFxGrdmikkqD4sWxx34Q5odnwGIx5jqYfyKNClX6Qc+CNfsKqju3KHOfckXJoBmbKbbI2YdciXiM5L60A0+uMF2IioUPUVl35u4Ve6XYrNDDrInjpSxZ0n9JaPvLgWNuWd9n3QugNfnP7sZS5yqpTPlHqaS/Fvuj4p+dUrFgljry3znUSEI9CFNu5N3Sgtm4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwUtly7iSkhkQYiERlgNwiocJgZCaLVp7Oe17rN1fn0=;
 b=LWsvbZIykHYEtVuLC3GT65ea5ddvAErN82odD/WtLZWnFXz9nN/640UjuEgcpU92MDgilWu7n4WJrSrFqinTkRPgwtf1fQPJfHyLeotfEi8uMGD6tH6OFUrr8jRa/SCjLP/Q3QGtDTMI872E/0//VSXp1FzMtHCaL5FjeYrRwnBbdVOD6CRpvzcYOUuDcu1LmSbH1cXbaflWqO2swgYHK0dwppQFz3a3N5a+/dWk38gKJBD6Y3W6+J8j+9XyAyAPcqtDL1ZCn9W99aqJYnCzH2PdAikAEWLWaDack8nugUeYOK6SCXu3o26ZPwA2JpVRqYDKritmVH8uTBg00Kb/4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwUtly7iSkhkQYiERlgNwiocJgZCaLVp7Oe17rN1fn0=;
 b=ruFyCto3xCz9UVxajy31/U2jxdOptA0yqM6m5iuitS8fn2ZNGy6YHVS511G3N+Fq0/JNrbiSz5xnk1l2iQslw5BOGC/80eHRyXMFdRq8RSGRtxv3bfIf5UY7QL2++7ahh2BXnwhTH9jJoqWBwSmuKLxq5Lp8yz/GCP8Wo3XmrWluXxlGgxEzr3SWssrH7LDkeJwskOJfjdtcY2LtijUGwjgxFzSoMkIZRZh08+GI73JIY2jsJPeJER4MbQR9uWQePC5HPwzlmLS/yZZnqT/leoSCIJWtkIMidVLXDoC4SSuxoTJGhtnolsBsEVZAX71ukW9YfXFsvqRFgz67nfqLvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 SJ2PR03MB7093.namprd03.prod.outlook.com (2603:10b6:a03:4fb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Fri, 16 May
 2025 04:06:35 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8722.031; Fri, 16 May 2025
 04:06:35 +0000
From: adrianhoyin.ng@altera.com
To: dinguyen@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Eugeniy.Paltsev@synopsys.com,
	vkoul@kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: adrianhoyin.ng@altera.com,
	Matthew Gerlach <matthew.gerlach@altrera.com>
Subject: [PATCH 3/4] arm64: dts: socfpga: agilex5: Update Agilex5 DTSI and DTS
Date: Fri, 16 May 2025 12:05:47 +0800
Message-ID: <fcf4e787fa488543595c45def365710213463b8a.1747367749.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1747367749.git.adrianhoyin.ng@altera.com>
References: <cover.1747367749.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0126.apcprd03.prod.outlook.com
 (2603:1096:4:91::30) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|SJ2PR03MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: 03d875aa-77ad-47d8-a0c6-08dd942f0c9c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1JnKlWUFgSWMXrHOda8qphG1UUNSAlvZZxdRH5NhJA1e8Op1iaazvnr6rsbC?=
 =?us-ascii?Q?v0BfRH63Ka1E+CcMYMH7mRgCWOr0HM7zlE4KAyHCpIAvPYJ3Xu5Jl0sXwADL?=
 =?us-ascii?Q?hekZmm4rVdRAGtf+af7RXg9Hspd0HUAgGbF2hGr8Lukq92pRSISDnbBtjfyi?=
 =?us-ascii?Q?DFRgNWIkTx3yWINDJakHHVibjOAUbJ4fDabfxQkHf1p3i7GZnNYvBUsBK7US?=
 =?us-ascii?Q?IUXwnOaykM/srDUiKQ/p52DAYQjWwsQZP27CtoA7aBUTeJ7Puw4dGQmuu1oq?=
 =?us-ascii?Q?sy1ALNbpvzI01kxeZRA4BaJPGWHlrwDDYeCNAfUqKE0zTyi3y61eRFbpsgia?=
 =?us-ascii?Q?2/861rqYGSB9vTPJWtK5NBlrtg2ahQqjkRLhPNCW81x2QPSC3eyQ2LnDGP63?=
 =?us-ascii?Q?f0PvpRLG2ZezWla2Ve0S7jy+IxfAXpnHW1cZqBh+eK1NzMKGM+0o/LfqSEkM?=
 =?us-ascii?Q?ASZLqr1ruhmYbiPu8cXv++xlvs20ntoAmncLsqV3FSLVCoZn2CyC08Vjc0ld?=
 =?us-ascii?Q?ivDhlfrKhqAFIHQUveoEOyiRJV0JNP2y/HWwjdQmOMRSyE3d4/GnN9JyNzc4?=
 =?us-ascii?Q?KpmpowmWlmvrmqETNuk+/1z1J6yXJoV0voLCxGbys3VijW+JKlVxHozsIaSJ?=
 =?us-ascii?Q?b/0qU2sMR179/MoAXV3VCx/VomxR85Jsns0rTaj9HFfQ8NNucnRX3kJCVGsG?=
 =?us-ascii?Q?iZXk5ezCuq9PzGRzdU0NvvjjaKIedTz3NkO4VNKSdCTr+qultIhpyPeT5KXy?=
 =?us-ascii?Q?eKAvNMOh5hZ3PfEPpAX3AXPhzEYxhQkwIIhitxn+v+GYAMQ8xUmrb9ggZrWb?=
 =?us-ascii?Q?QqkE7gp45vtxlalOOTsGk2fIkEqt2nPEw9O8QgDVz7NVrnyyYxCJkIgQ+aJH?=
 =?us-ascii?Q?SAjF9VunXfh7NINxXb3HDYJIYLmDC4qPxHr701Ue/ZTJDbzZWdfd/SUC+dRw?=
 =?us-ascii?Q?IKiQRGpjFwPCFWHzsdl8hj5hZnZK74Ix5zEMyBveDmTCev8p2tata8YW888s?=
 =?us-ascii?Q?3UdZJHLUiuGcPUIefTYyZLpBgR8QyRodfk9GIugiLhhOMAasCdKG2TGIl9lM?=
 =?us-ascii?Q?sLnsqYz29Io2N4GL5ZfeyWGD1G5DLjwC9Q4vINedU0Xs0J/Rp7ISXIUcqD0l?=
 =?us-ascii?Q?fyPXInmgEfFRTVv2SfQyyyNBRBDuINE7v093pCZRfsgyFfeeCCxadPR6H5TC?=
 =?us-ascii?Q?JbJjEgLcfME7Vp/3CR8R05ReMb/ghPE7Ti/Qjm7lXyeLRYvzs2E+bUZKJDth?=
 =?us-ascii?Q?HINrQIkrGrm0C9x3Y75o4h3ptdsAPy+TBgauSH3Kc5X7iZE4wycZHV9Fpw64?=
 =?us-ascii?Q?hIam2/1WPvvSZvd45J4+NQapb+uwUx8Nq+7P3Zd9qWXOu8At/kndfHdzLCCg?=
 =?us-ascii?Q?qH3BNuC/JoYpYviZi0PaaoZaK1Iny0AKmY73b+nX8XDvx3RoW45G0jZF3ft2?=
 =?us-ascii?Q?7WIhgLp9nUA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LL3+MKMLzvzks4yQLbVcj1Dk8mVtICIPwAqe9HQaGbtWq1SrWI9g7sxMgoJk?=
 =?us-ascii?Q?jQyeO4zGBcaD89Q/sFdr6F6ROV0rNS2JGAlzdYsGCim8jb3OY4OT3vYwhmLW?=
 =?us-ascii?Q?8285jYEkC57IosH8OsjilhR8IhCvnwae/J4veMIuu+PHg4s66GB6WjoglBos?=
 =?us-ascii?Q?I4gv/todVKyp+1NbGHrLdlH3Zxo3Mo50qwtr5w0lJVIxm6sxZuDfKDvhUdCB?=
 =?us-ascii?Q?dClMBPq+71QROOQNfxZ4PLx0MlU1vAHnFz1GEqTrNuowlJWGsRfGtyklsLsE?=
 =?us-ascii?Q?qyNv37MlqlemiRGsuuUOgLtdOFGTJeCrHjE/3EW801FlrIczV5g9DQo6aIIT?=
 =?us-ascii?Q?GD7EspcxGc6WDS2N47wedqQp869T9+mwHBCaQgl2MWkQBGRxC0qJxLOqZZI8?=
 =?us-ascii?Q?bKAHGhZHlwpqPMFORsO0r9LSGt1tpvOx1+5JhxQQPCpIsih2o7VC7wVhpMpB?=
 =?us-ascii?Q?jHKkgygPsNs8YeYnKk5eiFJvgMjJ4jRSG9q6orh0sfAl6wUK25tE6tggZn8T?=
 =?us-ascii?Q?ifQ0k5+NLDkRraVHWO8gWy/9uEFp+cezHPZDP7y9J82MElHHq83tqC9X22r6?=
 =?us-ascii?Q?i6wk/tjtHD8h18A0uL3M24RcX2LX4nX1//Y0MOFoLPawp0fIrHMB86s/Tjt4?=
 =?us-ascii?Q?ZzSIHsNFmrnG70W5rSFN26XPUEcXSPsFwyLynN3ll1wWj8Gf9/AopaWHmjXo?=
 =?us-ascii?Q?1q4LZ3cyK2ck50UBXBTdJxCXNAGTFVLrzVL+/jSCZ/Zs1a3vqfmUN9Q5ViIk?=
 =?us-ascii?Q?r9gHvnkOEe6kEgNZxQZrtirpAX+kLHKlnVs8NwwUcqzzycgLXHfRbyQ40+ul?=
 =?us-ascii?Q?aV533y++HDOg3OnY9pL5t+++olCCCPQiLtyJ8j1A4j02b+3avc9Ltxttea7Z?=
 =?us-ascii?Q?keD4LRcbUD/7Befk4DmpHjM5wLhSqcvd3zZPNDWfCEissNPTZgRZGb2nTB9r?=
 =?us-ascii?Q?YPS/YrG0cD/bruTXb1KHe2WTE7Xc5lGH8LYwpYnSV6WgQU4p6tn85LFU29ts?=
 =?us-ascii?Q?rzSztsqJgtuTezB+arOK3ty1ZxFqLT6J5FrghuFaAx79k83wl0ioqQzfHPPO?=
 =?us-ascii?Q?X/7MExkyYnjydwcIgYEVWgm9s0cu14x2RhgT/nZJWqSXjiL+tbid6cpRNG5c?=
 =?us-ascii?Q?qLD0X+RQ81BFC5b5uV33HxMC/dk7hYSKoPG5tfhxHnci/nxu9gENrCO6vtja?=
 =?us-ascii?Q?MEltVEyN0epL3PbbB6hzRsiWgd6RDxKO/VfEJc2LtejxoEGmEiXQ7Zp5jSyv?=
 =?us-ascii?Q?KOuh+lSe972lVf736Ob0CSrloT4E80p+eYDCI1mdjuWYzjhsvLIPYMX1boM7?=
 =?us-ascii?Q?xqvX5iFVs/phyBo7uDv3zHzXFr6jdQAnNU73FV2n7lbk0yt/BKw+Gr5Dt/ue?=
 =?us-ascii?Q?XmBMwPKJRMR8L7JGnKFsbNmcMWzfV6nC+mUlY5bWF/QIAedo61sMhI6LvEMA?=
 =?us-ascii?Q?5tl6cWPnLBq1eCv11xTWXgd47YZPvhTGSp65KjaISDE7HQAFfWTVSZNEmnEA?=
 =?us-ascii?Q?oVVBihHuZ8AiT2ItiUQEB4NeOnFpyq7+jmIU/zOUSiSQbiYdWhkOtEuBu211?=
 =?us-ascii?Q?+kayUUCsiHmiRewQSEXh/SNVKl0thG69eg2R2KRJ5dPE7gfPGGjnxDGifz5E?=
 =?us-ascii?Q?bw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03d875aa-77ad-47d8-a0c6-08dd942f0c9c
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 04:06:35.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E7Jg13pDsMIdCkT2UTzfCZW9JsSUT01oL0ndkDfM3tuaBxEy++8QOYtI7G95/i92FprbdCTne/WaZ1k6WTHorm1nalGNSOVGoeOsA2fvmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7093

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add SMMU node in Agilex5 DTSI and enable it in socdk DTS.
Add IOMMU support to the Agilex5 DMA controllers by adding the iommus,
dma-coherent, and dma-bit-mask properties to the device tree nodes.
Add IOMMU support Agilex5 NAND controller by adding iommus and
dma-coherent properties.
Add IOMMU support Agilex5 DWC2 controller by adding iommus property.
Add ADP support for Agilex5 DWC2 controller by adding otg-rev property.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 22 +++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 51c6e19e40b8..61a0a24cda22 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -272,6 +272,8 @@ nand: nand-controller@10b80000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkmgr AGILEX5_NAND_NF_CLK>;
 			cdns,board-delay-ps = <4830>;
+			iommus = <&smmu 4>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -291,6 +293,7 @@ dmac0: dma-controller@10db0000 {
 			clock-names = "core-clk", "cfgr-clk";
 			interrupt-parent = <&intc>;
 			interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 8>;
 			#dma-cells = <1>;
 			dma-channels = <4>;
 			snps,dma-masters = <1>;
@@ -298,6 +301,8 @@ dmac0: dma-controller@10db0000 {
 			snps,block-size = <32767 32767 32767 32767>;
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
+			snps,dma-bit-mask = <40>;
+			dma-coherent;
 		};
 
 		dmac1: dma-controller@10dc0000 {
@@ -308,6 +313,7 @@ dmac1: dma-controller@10dc0000 {
 			clock-names = "core-clk", "cfgr-clk";
 			interrupt-parent = <&intc>;
 			interrupts = <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH>;
+			iommus = <&smmu 9>;
 			#dma-cells = <1>;
 			dma-channels = <4>;
 			snps,dma-masters = <1>;
@@ -315,6 +321,8 @@ dmac1: dma-controller@10dc0000 {
 			snps,block-size = <32767 32767 32767 32767>;
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
+			snps,dma-bit-mask = <40>;
+			dma-coherent;
 		};
 
 		rst: rstmgr@10d11000 {
@@ -323,6 +331,18 @@ rst: rstmgr@10d11000 {
 			#reset-cells = <1>;
 		};
 
+		smmu: iommu@16000000 {
+			compatible = "arm,smmu-v3";
+			reg = <0x16000000 0x30000>;
+			interrupts = <GIC_SPI 134 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 129 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 132 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "eventq", "gerror", "priq";
+			dma-coherent;
+			#iommu-cells = <1>;
+			status = "disabled";
+		};
+
 		spi0: spi@10da4000 {
 			compatible = "snps,dw-apb-ssi";
 			reg = <0x10da4000 0x1000>;
@@ -423,8 +443,10 @@ usb0: usb@10b00000 {
 			phy-names = "usb2-phy";
 			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
+			iommus = <&smmu 6>;
 			clocks = <&clkmgr AGILEX5_USB2OTG_HCLK>;
 			clock-names = "otg";
+			otg-rev = <0x0200>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
index c533e5a3a610..d64eb14ccee0 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -25,6 +25,10 @@ &osc1 {
 	clock-frequency = <25000000>;
 };
 
+&smmu {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
2.49.GIT


