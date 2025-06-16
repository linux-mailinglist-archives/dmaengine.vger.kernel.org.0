Return-Path: <dmaengine+bounces-5493-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B466ADB445
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 16:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDA7C1884E59
	for <lists+dmaengine@lfdr.de>; Mon, 16 Jun 2025 14:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C520468D;
	Mon, 16 Jun 2025 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="YVsB5QLh"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011071.outbound.protection.outlook.com [52.101.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9817A2F7;
	Mon, 16 Jun 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750084939; cv=fail; b=hLBXC1ulWXBuxgh4HoWrQVJEDnxC9QDRPPRhpeAm/0saXv6j1U4xOOuasLaBymAqWIrtE9zcNtGStyRY/2SYAj+Fagw2wayix8hpxGOjaRHea37+SUynXwJnuKu0LjxrP/oq+VZMt/DrvC0clFcy5F3BrQt7vACApCfhUIubv0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750084939; c=relaxed/simple;
	bh=VgNFTfsiBK4/WLulrsMDipiE063QBKiM/BPqxOO7b3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f6gxD0RaDuLBh65hkTCulaqjYaNxKV+SBDORxMQ278cCq4qJwdPRfLzSI6l3XRS/ugyq67jbrpsWRiR/pTuBpy3JWueMbUYeDmz2yyoAidy/jooO2BkyU+azB0RGM2RROb+VYSY1rA8xu7LoR25Iqp12yNA0Xr4TZHYcjXjMRQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=YVsB5QLh; arc=fail smtp.client-ip=52.101.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k4QEiH2vDeDO5N4f+HjYUndzjx/ZtSG2i8YiwZYxl8B9cUbt3tqCZqFmushI6ECtYQXsh9uyHmbDpJ192Nz2bjECwkIO9SWkg0xkXZRy+cskVlo8222BfH5MoGn+Rs6PA+cPMWswl4uxkV6xGVeWZZ7P0LypEDJ4+UniHt5oRh+kfSwbqxbzzWUIymIrPwe9b8IbvXj7PlNmWVhSY8SnBraKuI10bvGQV4MNgN/gqLvzYa2JrCd/1S6SNutUTtdG/j715MtJ+xvfIoc4uEcYoqHr2o1mii5k/K+a9VlO1QMmcfbcqW9fh4DSnXZzQlvtU2Fp+gw5/u877GRB+lACRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1SvdjS0s8gPZKNo3Vi+GmaZB7EAN6PHGSDOKU8bgAiQ=;
 b=jEbUov5JcHe6+qSf9mZsJ6u81jFnC0MOsFm+t6wjd4KinnC5MRcYC9DoLhADr6hOpSCpbmfzYjt0Z2S5OU1GRAKZZ6vcHzN9XbvV+8fQBze5yY0YktEZHjFi5Iib8PhVcpXtqHiuboabaMoP5yeqdoGt4Lmbve+DWuyumcKXQacjvVOw2HAvJrA/+ZpCu7/yhhv2G2Y2ziYQ7J0rJRKwDZg1TFgGpP6p7B15ATMdb2iqXBw7EG5Eho2JN5kCJpZI9s3uOsuuXk8kwB+We1uhbxD8qnM5JxaT1nd9q13fTpLFzTesqjK9su3qSEe05IjmZ67VKRU6m1QLOhONJDblig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1SvdjS0s8gPZKNo3Vi+GmaZB7EAN6PHGSDOKU8bgAiQ=;
 b=YVsB5QLhltQ2cv/FKEc63hxYZ3hoftg+2fM0CQ/+nB7/YzcTqNF3LBGf0KcLihxXzTq2XlIKi7pKBt53mvwxJslWvf+x40+6Hksv10+drQNiJo6WI/cJYDWteGBk+gF6o4FVRlj5V6FC7H8V1KtuBUTdJe0ZRXQY4lDDA+cfhCnb5zLj4nHI1BTnziGgzKw1a6xzocSYYmJhXHXW1anQgs1Wb6fN6OExot/qwITsfZns2Mh/X+nQhGLCeXsp8aBoNX5ORkgC99s0H8Thess3kSapeSz8nZHdPgaMG3wTTcrIHNeAkkqJTYF05IkVBJOD4AFHlsoZ2nb+inBd8bBW1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.29; Mon, 16 Jun 2025 14:42:16 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8835.027; Mon, 16 Jun 2025
 14:42:16 +0000
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
Subject: [PATCH v3 3/4] arm64: dts: socfpga: agilex5: Update Agilex5 DTSI and DTS
Date: Mon, 16 Jun 2025 22:40:47 +0800
Message-ID: <8d83831e5ec2759c8134440cded0cc20cdca331a.1750084527.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1750084527.git.adrianhoyin.ng@altera.com>
References: <cover.1750084527.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0022.namprd21.prod.outlook.com
 (2603:10b6:a03:114::32) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: f73f30b4-3d7a-423f-48e0-08ddace3fcef
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?avHp92gNqW4ssv8S6OGyp7zMtnTwAeDEeHXvVQgXCHvN7yZpbARG9x6IBW+Q?=
 =?us-ascii?Q?MJoqPwmxNOpECHTnRA3FSd6ou9VM+TE48Mjmp41sDiMZPZKLW5rokvCTsRDH?=
 =?us-ascii?Q?3E6VzIL/jSjCSeiEKHfwcX+Gc/P4FJOsObZTifq3Jq7phy5YJLycJLQdrOKr?=
 =?us-ascii?Q?1tThvcciWqo7CV5yQEyuk/2zZX4Pk/BbD6dnyHhQT78Iy6qkH5Jcut+U4CUE?=
 =?us-ascii?Q?Qwq+p8amdXaS+wthUkv2nhvUOQqv1/lNQ6mXfGeMyXHlX+Hz7WNIkkCdNwdi?=
 =?us-ascii?Q?NTrb9MBKFLJ6bg/VOrljcyZFzWbhflxUgvEpYuYR+XNLJlLtq+We/P79g9N8?=
 =?us-ascii?Q?SRVf0ozOvPHXvxzs5/RbZoNOUDlAS+pbcFsg8binDaC/5uyR5U5ht0dloDRE?=
 =?us-ascii?Q?rVTXDBgSAHs4FLNygNv+fja9IRkAQLXpyKzAf2RS1f/FrUWATw78khgFhb6Q?=
 =?us-ascii?Q?BMnTFWIaK07KJvcF992ZBxu313L/WBC8Rq1BD8rQtL9CXIFPaZvPPyHlMKeW?=
 =?us-ascii?Q?EtUyrUqzjstnzhdmu0wlubOf6oANCHwjiVdS95c5Affv/zo02dKrMvHBILMn?=
 =?us-ascii?Q?CMvbcsRBvo/sNC8fL7n7hShDAftb42RjGw9iMh29pVK4caxIvOmrTOprfGfl?=
 =?us-ascii?Q?7jbGEI5akyuWEunJQ+vCdttrBLbKM+AGYcEAjLyyN6ljellpXLWw0Ek8v7sK?=
 =?us-ascii?Q?mTO4wqmzP1tZt+JkrwfpygQqAHA7Ot+hw8W6O9IpPMFfSBPxv3e06NNHs9xj?=
 =?us-ascii?Q?WVYc07y0LrlNSBSVvP3O1O1KqNGoV2db/bkIMfxKDf5Rqp3RWG3HJK1oPt0k?=
 =?us-ascii?Q?WHD+TWdIcjxvGp8hu79o6eXcYF3/6LCJhQfrProu1MDDVY4aQymLi8fTKsfE?=
 =?us-ascii?Q?knYzOCuumd1TExgXikRHQAnb8wA0Mgp4PJPcX2lk+Mf0OprO/fRw+jT3R/RY?=
 =?us-ascii?Q?LmgWxUl9Fa7CoLve0vMDwj7e5mi+leN+qyAiRQbwG+VysbCWIBD8VXSN1L2E?=
 =?us-ascii?Q?TCo/CYMe63tW6ovfsuLMSdBRYAOaDJ3qCIryo+Y32+sN4xOQ/Bb2WaaRGicb?=
 =?us-ascii?Q?gPaNvMQrhWa+zzigYg8NOT6Vp+HSwKsnm0ARA/ypjWhO5BYgITyKoR/ivjss?=
 =?us-ascii?Q?+3Gn5JtEsZO5w/QUO2CWA4MArHuaSqjZ4WAjolEzJdeVrtAVy4asqgps4/tY?=
 =?us-ascii?Q?z1GP2KqVv7bNJHPDLXZRKZ1V7IjUX8/MP9APrdtZ7ICVdqiB0vSH6tvwen+9?=
 =?us-ascii?Q?gGMbD0ML8gvrQPzzW350FuHXerBLKajA8RmhqTBpcyQfk03W0SxtmCnwjyf5?=
 =?us-ascii?Q?JdAn6fz2WW7umbuEkyTZRxv6381ThrA1jkCq9F7kixX0RCKMu4UcQDHAbM9f?=
 =?us-ascii?Q?oHn9jiaHRI6wICnMVWJPZB4aduAUaflgVt/mn40ikXsLY5hKHSYDRHhv9M0S?=
 =?us-ascii?Q?dAd4BwHKmds=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BhfVsNOd2MvPLX3Boqbv9ygHBKAF+i6YUVsmpuIn4J5iaVZ4Uxeypc/r7L6p?=
 =?us-ascii?Q?irUBo9/aIL08zjaWH5IkpmPZ2DevI2qYq9bMLSSwQvDnV9j9C0dvKFpqqXf7?=
 =?us-ascii?Q?CyPkLwhOpP8Pr9QmsogmigxTmayjBl974Ix2QC6Rv7Mr21dadIohRvDCOvHZ?=
 =?us-ascii?Q?CNlrM7cWQv+3O1ZUF65uvakjKIJ1a3Hfh1tpW5EBqi64abpCUy534CKv4RHZ?=
 =?us-ascii?Q?Ji4lq6x2Y4B1UKGgccGnI4KKRZLUqw+A0IgwCqgg4XrCjz9gBqojyTvpOzud?=
 =?us-ascii?Q?QqgMGbGbvAOm0pzxrEtiHxLXjJLZgvD+0qffDgFwLY0cYnv+uLf9J++UdZR4?=
 =?us-ascii?Q?UI3rrqeD9YfiYS/QMWxtzM+rGTxtNf9YNzLRzN5sN1G0riXT2Bav03nCsK05?=
 =?us-ascii?Q?47Wo3dN2GWBEL+GaHy4KcSVIKUaLvMSOpcwwE3hDVUaZIGTQczy/wx49575U?=
 =?us-ascii?Q?zV7UkeWHvaJGXyKjEIbpf5NUY/vfCfREETXXSZ6tFZmHBYSFcdz7f4NpiOt3?=
 =?us-ascii?Q?RY+VcKa75rYk/3r3Su+ceD/yH1LhSW4y28ROCQWDnHPkdcBXcHqIo15oT5wk?=
 =?us-ascii?Q?XEAjTKVMDYHxqsRKKzlXlPrukzMXkHh6Cql+gZWZWVm54EzeM7Sj/xbFntho?=
 =?us-ascii?Q?pkzsUKskAB9GRSTbpHw/pL+AZ+FTS3d6QJ4J8Cq4Jd5K4lO5w5zQlXEXELws?=
 =?us-ascii?Q?MSF/ji4tbx0KT9T9mhhwacEmMigugWj+CnIrX4dh3LadWNe6Tx/ooVii3bNl?=
 =?us-ascii?Q?0S2zdxLoRwSQpbWf9yWHpVTlOAmaVdK1IqO3nhVBVU25fLa0xNqxBjHjiVPV?=
 =?us-ascii?Q?KT2PL4sfVvE5mfUt97f3NyCRPy4HLDCglW0avTeowSloRoTEpHR5uEvw9hFZ?=
 =?us-ascii?Q?ObtP3HEl+TuEcuUgiV1SXP1rsQli57QH2gUPdhe+YpyPYjSciU8aISNmoBLh?=
 =?us-ascii?Q?uCKbHgMMNm42PitcqxAK70O74qWOZaxA1f4b2Wknu32KZOsAMlwE84DcMrCv?=
 =?us-ascii?Q?3uBtFk3oVYGwcvxxhHRC6TgvTd84jHDsI52+hhG9KNcwDLFcTmB+eRIgaU3/?=
 =?us-ascii?Q?1rijdYgFE/ipu/hFqR5AYYcqR5fVT862c3cKjanpCgHuSddJqZdx2IsoKKjo?=
 =?us-ascii?Q?Y8fw/VK4Q8YXBhmwqxXp5Dx1Z1euxv9yPdvCQEBGR4hU7/6gvv7EvQiuuL2L?=
 =?us-ascii?Q?2gRBpuMS4mOrs+CdRpDey+76j4pkLVDoA5UmAy0aC2bb6jAzFK7fHTXH6Rfg?=
 =?us-ascii?Q?zEKVWNSVk2MXgGxjw6t+05+eWQbFVgJ+ZLoj9WtqW/Utc4mBIsZiQPxzyhKt?=
 =?us-ascii?Q?8i2RnXwWGKGpb7ghVjXc0J5Qcgctj1/6qfpgT81TwW5dhG06qE0IrH4H9mcC?=
 =?us-ascii?Q?WEs1c23T3wt9UgIcwc43MTHYXtMMQqG35rCJo6lv1W4yrg2nwN+cH2lmrw9u?=
 =?us-ascii?Q?545Dfa5NG0C949V4U9gntvAnNHRDRkT2Aj4VpwEkMM7pM6VTPVpjWQSTbRey?=
 =?us-ascii?Q?J5PiaT1aMxnNyvm9uCJxPoym2Axfx+1YnWoQapiPXm2Pnz+MjFYPtiqgIn6y?=
 =?us-ascii?Q?o1fMgqhazOIxgRUqNIY2FObpLkEyQlEtJMPw9vLCqDA8qZOAN8hM/yGOifCk?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f73f30b4-3d7a-423f-48e0-08ddace3fcef
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:42:16.0213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b5qPrrt1OI0ri+Avv6Jra8IE0g3N5vUcWSq5lzgwUaSC4Hxzw/7FD1HRzLPDt4FyXMlA68yC/5LrhFk9NLMa224na7MnNhBJwTZZdpSn2Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027

From: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>

Add SMMU node in Agilex5 DTSI and enable it in socdk DTS.
Add IOMMU support for Agilex5 DMA controllers by adding the iommus,
dma-coherent, and dma-addressable-bits properties to the device tree nodes.
Add IOMMU support for Agilex5 NAND controller by adding iommus and
dma-coherent properties.
Add IOMMU support for Agilex5 DWC2 controller by adding iommus property.
Add ADP support for Agilex5 DWC2 controller by adding otg-rev property.

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altrera.com>

v3:
-update commit description.
-update property name to match dt bindings.
---
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 22 +++++++++++++++++++
 .../boot/dts/intel/socfpga_agilex5_socdk.dts  |  4 ++++
 2 files changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 7d9394a04302..261cfdb4d297 100644
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
+			snps,dma-addressable-bits = <40>;
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
+			snps,dma-addressable-bits = <40>;
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
index d3b913b7902c..360f44ef76fe 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5_socdk.dts
@@ -76,6 +76,10 @@ root: partition@4200000 {
 	};
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


