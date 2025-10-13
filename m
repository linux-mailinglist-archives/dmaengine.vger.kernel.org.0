Return-Path: <dmaengine+bounces-6805-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D67EBD10FB
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 03:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246F91893767
	for <lists+dmaengine@lfdr.de>; Mon, 13 Oct 2025 01:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B38B22068A;
	Mon, 13 Oct 2025 01:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="cyaZmFDl"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010042.outbound.protection.outlook.com [40.93.198.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B5F21D5B3;
	Mon, 13 Oct 2025 01:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760317644; cv=fail; b=b4DL60km3NfIpzwoHcIhwrXVE5D5/nOSyUyCQlnJkvtoOJyZQtyieesoDlBbk5r0VDVfV+iFoz7JaaaYVbQNU4gFHbJcrFfZBHlO2mnPvP+n3U3XbCj3q/Whenxpb9AnuoRdACIRhuGb+JoCkN/zxu8hJVHJrsiloRqwlX7a1xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760317644; c=relaxed/simple;
	bh=bjFBXS/9iCJ+aLyvtCj8/5avI2L0g/3q0l+sXhe/S5A=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JaJUYb2ansFbpL0vqW237ZfTvUI7LYV8/ZJ5YzCnWFdOgxRE5p4WIUH16n+LskYu6xAWdBbm2p+d2Ek0WfcBeC+ETxfU4TgiP9ek4Wb8DmonepMn1RTQJYc4Xc0SxwGWHRHThPxbqT9U4StFthsX3V5t8d+uBMq5QZNXToXwTVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=cyaZmFDl; arc=fail smtp.client-ip=40.93.198.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb7PhTlFaXp0GK/EDon1z+VUjpM0Ris647D+QPpipLboOevL94h1HRoQVfQ3LfxzxvUNc6oS8ahJwCVad/R9P6OtbAE1Vs+tCt3ISx3+jY8xluX/PaQxHA5U/AhdvdPvicIBl3sLSY0IRFKYXrvwRWWGg2yZkfJbaDDvfd6KOEuZaVzdbl3TSlbbC35yOyA8EBWkxrwyIWThIuL52onqlFVs7i0ErUFNFt5RtHuimQJmej02Jk/BkJxg/XM63I3twn2+Xq+KpFZc88HySQ3xAron8aLxXBcq1K6mjX9yfIRq7cdmexQshuoRfREWkpPBlKjZRmM6o3lWoPS1/jHX2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nT9Yh41e14dlPS4HKX2DO3kdwkILvE/xjpgSSYD9ww=;
 b=vXNqCm2VbVWAPdGnolTMYlCtqodpedzlH8Xj8u2FLm2H6BC/cd6ITQBrgtEzmCtLDzY913UZPBB2+pFyPMZ1cEBQP9c3k66mbYSyjq/TuwLgOU6G2FfVhi3shmy+cXWiH7C2rQceuGEOlY9zi3JYs/mhppM129hsgIbHjzzjSR3gDSwvPm0BaI3QJJoJVuOJt5YuaLcVPf8Ih3Wi1tl6F9nDop+VTBvagQSYlZbpjqPFZDOmwTtNoEm+Fu7gqu5OOIT6pXP0SUPG/lvE2WtQYWU84tdlnO3flAQtkbzcbKEYgd37YOk/fU9SdTLBMMNchqiYeEg5PwxLohWWd9j5JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nT9Yh41e14dlPS4HKX2DO3kdwkILvE/xjpgSSYD9ww=;
 b=cyaZmFDlEYOUxcj/lCzsCHrWAlgT7kAgcIlg4H/nc+9X3bJmVImmws0f5g3hkH40Y+Bstu2yIf4BNuRB0WPN0Cn2rSXr28i/7lxHx2TWlVxhosmA5exVIL4cGXaduLZb9Ck+XPYOTo96CMKuUS74ZPR0YgpCoj42hW9HBufo9oGHkCmKaPMsaglSGrIBnJzA1Z/GRU0xQDByvHtVrvJbP9ZIHSogaKc9ocJIBF/99/jtHm+IrzLvuDnRn/fsnHWztavG7FdvtQFjd3bLHe3BR/tn/wKtaehxVW3g4imjM8AHSIVzeGteryepTIUT37urkMQ9k+gSFeZhmeNJlHSEeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SA2PR03MB5946.namprd03.prod.outlook.com (2603:10b6:806:111::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:07:21 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 01:07:20 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list),
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	linux-mtd@lists.infradead.org (open list:CADENCE NAND DRIVER),
	Dinh Nguyen <dinguyen@kernel.org>,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>,
	Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Subject: [PATCH 3/3] arm64: dts: socfpga: agilex5: Add SMMU nodes
Date: Mon, 13 Oct 2025 09:06:55 +0800
Message-Id: <ad9012ff220e1e471017770de98b880aa2c25f80.1760316996.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1760316996.git.khairul.anuar.romli@altera.com>
References: <cover.1760316996.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR10CA0027.namprd10.prod.outlook.com
 (2603:10b6:a03:255::32) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SA2PR03MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: fe455173-3330-4b18-bffa-08de09f4dc4d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zje9Yqr08Ewg5HmmVWJAExsit3hiAxuwUMAy+O6xzUq96eiyGZETwqqqgnet?=
 =?us-ascii?Q?3Frb+NavZWEqTKY3fivy5cTDNbBT0wJhPhSDbVH4E8ucp18O5h668l6TvdGj?=
 =?us-ascii?Q?cyuswuNIf4HpZuOi54wZdy/+rdsaIBqfYbrhuloGibyd80BgNY8RrVaBv6TQ?=
 =?us-ascii?Q?N4mN6WtNcgONSaZmQ9LthewT/vJbkXUWupznI8BGBbRPusaOiKaH87DeJlCU?=
 =?us-ascii?Q?2YhOz1HQRtLLHRyqPskSNLRP5b/LSh1uv1lwk66orxp25hUnsVgdWq/2pH1D?=
 =?us-ascii?Q?jFKfBw8uy5IH2rnOR8za0bcS+9RF3DNI/mFF3UoXQX4ahZvrOCIqF2Q3dTO4?=
 =?us-ascii?Q?mLuoWgqP5rZoYuPGnR+XEYtq1vgwQcRwFQjUWb/5IJNnd1M4TpYw4Yu2Cudt?=
 =?us-ascii?Q?SvOPNiXpQsfZjJHyu5CVdyHd2o73+r1UsYtN9FJTsfIAxs86L25cS5oIiYmw?=
 =?us-ascii?Q?oxFUMnGz+QvsGjgHU8QtYGDojJtG7P8BB5ozocLHcLsbfbdgRGH4ipaH4ttJ?=
 =?us-ascii?Q?n30H+gX59yAk3y+OK0jG1WKBD5c54lTnRUnwm3V3sYsdzhNqr1TJ1SmuwIT0?=
 =?us-ascii?Q?cKSou+JyFqYcAKhb5oidXkfTYCHaegClhdr0p/6ugA/teYkvyyiyX7MX4uT/?=
 =?us-ascii?Q?8hnilRCVlC1I7Op3j1uychYFz4a0j23/VjBEPJkdi9OtbrKHyl7TOwV/Jwor?=
 =?us-ascii?Q?SZgptBC7h7297O7Ej6Vd/uPtpVNOq6NB4m9L42zFCF3/LFuIqbZyBasoiszN?=
 =?us-ascii?Q?DD5Ib1wfyKIET9+FXZ7fOwGRERxjC9auo/43+jcimYMsv1Dbr7RbEVlFOEq5?=
 =?us-ascii?Q?ngGVUSc8jeIpk98LU70qRBDy8W60ONkXKQdu2raYoEWxu+PcBtbnXr/ayur+?=
 =?us-ascii?Q?v88r5+asnooPF3bnWiCgDbDPA5DHLiNSqdrciNcd0uCTdWpYch44KHBMn4bF?=
 =?us-ascii?Q?UqVx1osmJoOQcGvWRfUqmqwv2CtM6UJm+QOgJ5RI5yugozPo3XP9d8hCKKKv?=
 =?us-ascii?Q?NCTtJmAwK/TC1xGJICE9hpS2uj80vLKfrT3S0mEU68dhMTga+Y255yiP4oD8?=
 =?us-ascii?Q?AsmjegLqNT8yFP+4ikUkkmLUvTcDu2WZTAcbk3VRtTqO47sh7Swfd89zhAal?=
 =?us-ascii?Q?GM3kWa/tLtj14gub8RPr6KGGULCnqiMenv5uLPQrmlZa3PjD1KDI+I04XInk?=
 =?us-ascii?Q?LXn+NmZ39WYFVCeJqdO4AUuXPYqVFcoC6gYFl+MwO3KQunFBiWeLSByaQN3z?=
 =?us-ascii?Q?h5O2KGXky1LqVrUGxB+cqbqSjru9btyE2YyT6SDdjCTLaCF6QjdSeFHS9UzV?=
 =?us-ascii?Q?BRdC5uTn2LDbXA4qcgEr3q+H/OO2VPr6Iym33AoJGGZl0BtuPrD0SIVjCFnd?=
 =?us-ascii?Q?LyIghOkEN0O6FyNzdGETJiF5ZD18JUKF2FtU4QDqgPQ9DcBfJK8gA/60wgRH?=
 =?us-ascii?Q?k84XV/jh7ZiGL1lRrhv+8NF90Hda/WUzIbiTHzWKOEL12o9/NfVrSMlKrrNU?=
 =?us-ascii?Q?hOWB1M+fQAlXoXg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tzYO6gew2CyUAVjnLO4pFvgiv9zlWt07gGcrJ7qmySbQ8ellxowsX48wCZ15?=
 =?us-ascii?Q?P5CyFD1CDfdByB0LP1CFHPACbk6yJv7tjvHXzimMcuugT7Hpi9IqSAFAGO44?=
 =?us-ascii?Q?AOlAfxg06AO8eFlhUjZleQjbWidrm6AFMKHAd4ftt5fxPOrVM9MOKoGcfzo+?=
 =?us-ascii?Q?8Tnko6BhcAiDPEGOafW/E3ysADS2WxTU10dQN7FWpDToGgcl+fe9++p0niHS?=
 =?us-ascii?Q?AlRdKbb5FJD+KoJesErlmvGOMdKHbPUwpse/D+aAKBoQI4DqoPFxZBKPrX8L?=
 =?us-ascii?Q?MwRQVzUWHJlUXf2jEIlj6VlX+teHuAxTFpKBYwYwuGZgjRGAmPGbjSN6yyGO?=
 =?us-ascii?Q?Kt5j/BPMUWqoucvPI3Q71wNLLGo4vptCebPMjVGO61sBfnmnfKOHAB7ljlol?=
 =?us-ascii?Q?3C+JaqcSSR2+OMsZPBTg2/S+mFajjPp7A7S9ey12YRmATYnhjslvdmlqeMTG?=
 =?us-ascii?Q?3ZMWRzpu/T2mtDvlbKBJByz0EOr02y0xJXEsn+ggNhnovy06nvvphQNBoV2p?=
 =?us-ascii?Q?ps0bQMExfWzTjSOVHSna4Fpg05Aqx35nVEdZ4HbL4ivgKzv6mWSNBh9wZqDM?=
 =?us-ascii?Q?loiB2UzbyIGoIexLS7HCe5UFO5OyBvwniy/EVCOl+1c8izwP90Tv9dLz5RBD?=
 =?us-ascii?Q?T9PlvUi19aKGQHtUE5oXwvCV9IUIlse/FcS2MwOWlqkY7/TghSkQvfaTb576?=
 =?us-ascii?Q?lkywc4lqOkpNZzQ5nEQmADUMYJacECl+BoLAT9FG8dxoNldVkrBQExQMQ2hr?=
 =?us-ascii?Q?osGyDGo4CILzKG/pC1PUarDIwZne2pHhJ7ouiOdATGDXmUAivKxQi/OWlMAx?=
 =?us-ascii?Q?eXEmHFPiQ8HJa5TAsa6T+igz5QlHAoy7bPeCL3Gat2ITrtSmlkrya5x1oHKH?=
 =?us-ascii?Q?EYz/2tIAyIhNwjTcXFUU4KeNpTHGdb+mC7bsgmDOXQuR4o+t6Zr3u8YTkDrv?=
 =?us-ascii?Q?+OA+pDRKa+6HnSI7mRzRT/KE5GnbPobKQyFstFaeovVMXgjAsFztAKTAXczX?=
 =?us-ascii?Q?slZFx9fmRDB3yBHTuY7YiE74m20L12ydHnJGJPz75Ubsc+NNlAtr1ymUMyo4?=
 =?us-ascii?Q?686Ftj2EZw4/CmijUVQYgxO9lJUHTdTMeggA+cU1YFkt6jgNxyuUiyI1rE3+?=
 =?us-ascii?Q?JPe0o4S+NvwrUaRhPiniSY3k9z5oJeN3CZuGAICwPasZg2RClDYCVT9bIXp5?=
 =?us-ascii?Q?fax+V6uwgiU9Tjlh5LoQ0EApzUrl0LKiH4zdB7KPWE9PMqdtCDyx8zzQp3x0?=
 =?us-ascii?Q?AQkypVmMz/zLWIdAHyHNIPqTpqh8/VJ0l60HVlGt3+CHyabJOcBuM+JNv0Ow?=
 =?us-ascii?Q?hC/UuJNFU352x5Ov8CsrA4db3FtX6TrL1Eowtd1Tk9JPUdwugv4enk5Sf4ht?=
 =?us-ascii?Q?bmgCCyORvJ5opCuzAB7VoZr3FiPP3MaLcdmzJebuR3ZqeGi4U00v2PtCJxUD?=
 =?us-ascii?Q?zfJLjsRf3EAWC14y37UZiCSBB601ugqhCH4tkxQlnVna1jwaeqBkkAVqlWs0?=
 =?us-ascii?Q?5WugmtyOY9oFknn1VVPBfQUjUN7IbSKtJRx0FsDHlqiqaIKKD/Js8zlZ0MrB?=
 =?us-ascii?Q?Xrlkm939/6siR/ssPxPKIJ6210SliL7zpTK4gNR2zfrqQ75f+Yj0TBNxnpNZ?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe455173-3330-4b18-bffa-08de09f4dc4d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 01:07:20.9385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t21HyBd2t/aaJirzLt41kusBr+Nn0YHMpr5DiA2beV9fBuEBP5c+9CeknxpmBFB5F/e2nwrGQfH22hD5hEXSsgtALPOSV8LChG5r9B8E730=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR03MB5946

Add SMMU nodes for Agilex5. This SMMU nodes is compatible with arm,smmu-v3.

Add IOMMU property to the supported nodes.
- nand-controller
- dma-controller 0 and dma-controller 1
- usb

Signed-off-by: Adrian Ng Ho Yin <adrianhoyin.ng@altera.com>
Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 04e99cd7e74b..a22cf6a211e2 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -272,6 +272,7 @@ nand: nand-controller@10b80000 {
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&clkmgr AGILEX5_NAND_NF_CLK>;
 			cdns,board-delay-ps = <4830>;
+			iommus = <&smmu 4>;
 			status = "disabled";
 		};
 
@@ -298,6 +299,7 @@ dmac0: dma-controller@10db0000 {
 			snps,block-size = <32767 32767 32767 32767>;
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
+			iommus = <&smmu 8>;
 		};
 
 		dmac1: dma-controller@10dc0000 {
@@ -315,6 +317,7 @@ dmac1: dma-controller@10dc0000 {
 			snps,block-size = <32767 32767 32767 32767>;
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
+			iommus = <&smmu 9>;
 		};
 
 		rst: rstmgr@10d11000 {
@@ -323,6 +326,18 @@ rst: rstmgr@10d11000 {
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
@@ -423,6 +438,7 @@ usb0: usb@10b00000 {
 			phy-names = "usb2-phy";
 			resets = <&rst USB0_RESET>, <&rst USB0_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
+			iommus = <&smmu 6>;
 			clocks = <&clkmgr AGILEX5_USB2OTG_HCLK>;
 			clock-names = "otg";
 			status = "disabled";
-- 
2.35.3


