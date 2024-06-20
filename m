Return-Path: <dmaengine+bounces-2432-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248C390FB42
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 04:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CC41C213AA
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 02:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C7B1AACC;
	Thu, 20 Jun 2024 02:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/aQp5j/"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30822F1E;
	Thu, 20 Jun 2024 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718849916; cv=fail; b=K6GFtLriShQeJCcEpZV2qnKQNljJxGIrhGngyVHHJF0249+Ka/+Tz4XJK6TTQF9FHW5ST6fKfcGbmURXiiY7C8yyr+yOldE6RQ8XcORGT6X7Y7nbFl7fvRcXdWIgwZ7bN8B2gHppcmzKtwcY8QHfS3OTZH/BOuO1GpRMMo6RESs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718849916; c=relaxed/simple;
	bh=HhWFM/NIJ818daNzs/NIMrBccY0eImiCxnHUP2ZRH9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EQNVcZnlgoUv92bwp+wPKR3LNKiIjE70OzbWz4eoIE5ar8KJ7prIfurTZqsR0LNA49oMLwhdQQkB/Wpd8hMMfGhJL+mtfEZi9SfPRkEulKzqjxfxND1wn1jVP1uIU6wxMAJG9x9xJBOn1umugSyoW2FGUjgzo+LZuoqxf+xVCQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=g/aQp5j/; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlDrTnYD96oHqiIsh+SD8ZqRh8WFtSY8RH1xZJ6vX2EpUy/ht0+KHN0VWzfwf+ddYgwIFsXAfmbgDYQrDw5bbMfnxVTPCcEuGSXCcyUguLJ1EXoaG+8fcxbxD2faGxgbis7YY0aWjje1lxlcpAq261+i+161jA6PteYgjPIkiJNI8t3Zi1hBbfYXWADrQCd+o2EekhlBTrkvm5nLdw1NLZOVBY0XwtMS9HJNkrDPLAW1KCKcBfNHXuzVhj5ijseGNIMROHPeV/RDvqZ4sGSMGy5AKR4cx6qx+cVeVtI2XJq3jMoIOdUfdgW9tT/MCqe2Mjnct3XwH0Hu+QgvvFRjbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eLtdH/MBBC8dj0Oowels/gWNCuy6IvhYge11DY2MbU=;
 b=lEa3tN8pSsbJ/Mr1yV4CowOaiSLjc18rXgJfBdNDjDE/MJSF0kt2kjzf21GqesJJvDcbcp3I0UD6i2KxuFDIPkUj8nucoHG2KkBAsftbR60lLXUlXeqnmRFk3llYb3ECoG02tvyipmzqu7F2kKvJunXdqDPDJ0rKNjl5aTsMtmYGrNXcdledoucxvzIjRqpaJXx0U3YdOKaET6F76bTihkDqpX3aR6YERep9Gthrqbfi8GvYSk0/33nzCmNb4UspVroHfUf+EiXLyV4UBfLsNrPRXGuOgxcwZXhsl4t3XfTetGNGKlsdo+E470wdBY2ZpIjEiGtAg7vy83mr3E3v9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eLtdH/MBBC8dj0Oowels/gWNCuy6IvhYge11DY2MbU=;
 b=g/aQp5j/rP256mmypXnxX7SDKjRBjXp4fgWzYUxsiCOz+PfO+98Wct/cSax4Uo2ZAWH+w1liCNGfJwLYvPjhiVXEi3233ymrXgFdTidF2UovXR+k5Wwc4Yf8g3Qowx7PHkJn8LscO61eSlSVYaFlTGJ6ftW9rTMuffJojOla77E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AM9PR04MB8472.eurprd04.prod.outlook.com (2603:10a6:20b:417::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Thu, 20 Jun
 2024 02:18:31 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::261e:eaf4:f429:5e1c%5]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 02:18:30 +0000
From: Joy Zou <joy.zou@nxp.com>
To: frank.li@nxp.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: imx93-11x11-evk: reorder lpi2c2, lpi2c3, mu1 and mu2 label
Date: Thu, 20 Jun 2024 10:26:37 +0800
Message-Id: <20240620022637.2494329-3-joy.zou@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240620022637.2494329-1-joy.zou@nxp.com>
References: <20240620022637.2494329-1-joy.zou@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::18) To AS4PR04MB9386.eurprd04.prod.outlook.com
 (2603:10a6:20b:4e9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR04MB9386:EE_|AM9PR04MB8472:EE_
X-MS-Office365-Filtering-Correlation-Id: 4316b22e-642f-436d-3406-08dc90cf471a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|1800799021|52116011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZpR8fXeomvgA83DAEPIBEjEgJl0nudbqnNiDtzTGveEmhyCmq1YN0aWuxcZ0?=
 =?us-ascii?Q?EaYjrmn3AQkcDBNY368Owx60bEb2fGPY2sfuucXbokeSQZO1K015b+0goM5O?=
 =?us-ascii?Q?g5kBQmJt79FsLgMbLwZWNV0VgLOhl/czPn/cP7w0SQD6o6P50XY0N1kGAKOf?=
 =?us-ascii?Q?agF7oDV3PwXbANnQHnKC0ofUxzVuumWFim6SfvDEpf7TM2C3nhCAEAmZnL1n?=
 =?us-ascii?Q?kvsuPtyeF4ZW0saf1jgsKyl2a3eRDfEaCdziZTDyRvbESXrNqw5yaXjy3HdK?=
 =?us-ascii?Q?op6JuFFC6Vi5BV8bG1IsuPrSu/1e1H7uY9aqajVknNfWlZM/Tfv9okXxk9Md?=
 =?us-ascii?Q?94wP3adEuhuC9nDXM9ZwgrNeXNeP17Z9UXc6250roKPY4QT62bP4Zv8e4JER?=
 =?us-ascii?Q?w/ptjRD2O77Msqkp6k9tdtShdOWO4Jw2n7dPF2bp47XyzUX6tBIQfLkbTYm1?=
 =?us-ascii?Q?p+zWd9oC384stJ1YGoNKbivfW2wM8/utLExhsZoug+Jjg8ThQ/0/cy4kX67W?=
 =?us-ascii?Q?fwNDGWthw8OHXTW321lE2bteEdzKS5doll6FYYZZQ1yR6zgZtW/LiQjSkBlS?=
 =?us-ascii?Q?D1fvzIVC7N7s9vRxHf3C0P0PjFAB1SbWCUnMqgwIh6/+xJTHx52jUMDC4obF?=
 =?us-ascii?Q?AzM714RxHy066/uIK+euP3lfPVOcGBYpJp8A75V5soJJvnPbdp4N7hmvTvaU?=
 =?us-ascii?Q?wpP6VeO+E+Lc+GCIVwFfKlaWC11qMGf4eODIFsXs3YtnPaYEYpYJ4ACfROMD?=
 =?us-ascii?Q?Cievv3df2jLGVZC9g4bXjhnVXcsnZGhZvp+P0FFkaO894DLD4EIihPhDsSvB?=
 =?us-ascii?Q?A0HsODLNp2iwokCq6ZSu/PP3x4bhzAYYTeHas3lsrxXAThACXK3CUKjBF/Dd?=
 =?us-ascii?Q?k55yiLD9cp2/5EnKgscB/LVdTiGQAZO1njsMsNtZELQpsyr9M8aShNNar8wI?=
 =?us-ascii?Q?jbVpFZQGaloiM12RDFaiVjPOIx3Ay6jwLDXdBfeREWJbo3xeBcyJTn8KqQI+?=
 =?us-ascii?Q?sYmi2J+XGaI8+YHbwKiPgV/yqtZ7R2jR6kBm+rXM9mAFxd3rF2Gi00+DGgTO?=
 =?us-ascii?Q?4sWdkhPgYBx62SQ+gCN2JzbeLSUJmU1xI9oVKDxsV2w9orm8a2jHn8x6gGFN?=
 =?us-ascii?Q?UPCjmwU0pykAraszKuerIQ7fgLqFq4bS9OKx9c0s7iJ4B5UV+WiZ2UE7D942?=
 =?us-ascii?Q?e7zNDzIB1hQTl1DnDQfxzab8utOCegY8WkFxixNh5aJLMGYZt8KPPGBJWt2/?=
 =?us-ascii?Q?/p7CkHeV7rnesD+BxubwY9lZmbfsAD23b6Dfd4LVpitTcBKjPdikxTeJxque?=
 =?us-ascii?Q?pmH+5ybskaEk0nNggQZQGvhzoZYQPnsmiqq2y1AWSuDSCAYzNCIR35RDLzGP?=
 =?us-ascii?Q?oJlGeeY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(1800799021)(52116011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+D7lfoShUsiF4AEvp0b378GdhGcIYUNhLJJCJLCR5iggRZGLC45I39hHXKQ?=
 =?us-ascii?Q?Osc/h98f8cOAf8dlI8Bed6v37k/8WbvBvzuTBfMRWzl6O0BsD9fXIIKIqhLI?=
 =?us-ascii?Q?MBLQLFMy3EeEmIV6XZxQF0x5pHIJWo55Q3EyzH6NyinNrNBY/8M/66DR0G0H?=
 =?us-ascii?Q?kXJRFjTyeUy+VHHFdTqTX+rZ3KwB1wShaiZ2guToozDPWbc1Sf49QadPVL2b?=
 =?us-ascii?Q?AbktekD2GrFL9VTSqpJVoBOL4fHHfAS5SnCdMbAblXXeu6aPYQ92n81jCUgf?=
 =?us-ascii?Q?S/+CrBGz3itEwBQAiT3qTKLyEuflk4WYO/jHwLvPEBBkrpIgozCIpu5dDZMd?=
 =?us-ascii?Q?UtG6bV9NPyG6VYcc36ipYVGhH9SG1yJw/H624wFWDY7GzxIg9gEqGTK+Hd1B?=
 =?us-ascii?Q?muvJ7NG21KdEhnzCH0cxQVftbeucZy+5QyPPdPv15EOWLAQuE+7kmo5N8fP2?=
 =?us-ascii?Q?knMOv5U0I3Fm+AQ9oCSJOU2ZHDBeBTMPkYY41KTF5dMAa8803tKhHMO40FOd?=
 =?us-ascii?Q?FnzZrLn7aTGdDv9Xlraom51f/dcGLR2BxXCUQ90+9iWEqtBeQU0iYxnEo90n?=
 =?us-ascii?Q?f13CAkmTtJKrRkJcD6NeMb/miMwlAlK8ZoV//vsEmv8GPnoLjb/PDSawlA+3?=
 =?us-ascii?Q?YBuSYiHQvxhV6pq5G/Vz14dnqpVWNd1m510CIsyeJGJoISPxwDcrxcnqzFpa?=
 =?us-ascii?Q?rycTk0bvcDhr4rKq2pI9NA9MmvJQr75Q2pxYKdRiwcdap3hL86CCfCh4u66r?=
 =?us-ascii?Q?p+eEmFqM/uFzzZj9vdxtOcOZyHQ8xS9uczw8CboQaPi8oR+v81a232iN0bow?=
 =?us-ascii?Q?eHx/wEUqL/SCkBZ7mMXu7OXvl3hw+89viYgLaAx96fdiMXWEpHeYheSvOJ3w?=
 =?us-ascii?Q?AKJutT4hHqbP5sp4xSHSx6FMKwhl/eEMRGhP+9W9I6p5GLiRO5HPtSTidFll?=
 =?us-ascii?Q?26ue5mc91lvOz75lalZJD2PLZEIOJODGkmGSMYtOqaXNIFwWCnwtXHqrc3RA?=
 =?us-ascii?Q?lNqYgIYDmadsHU1pHGr8NYM7mk68o3UB1ezaCUx502c9hocVbv33xrwLqnn6?=
 =?us-ascii?Q?0tBlNheaYFt24QOUE/J8pVkxSrunR9p4is3rZ6eWud6oVUttIsGha8Y75R80?=
 =?us-ascii?Q?IGLcIwJ8UQ3KUcXnLmoPdzGS1IpnFlxbzyERMkT75z2Tx4aAHTiT7QJrSVQQ?=
 =?us-ascii?Q?VfOFWKSAr9L5nE/dS3p8UBOpYXdVHsZ0kem+C0A9/gmtkRg4ISi5iifbzSId?=
 =?us-ascii?Q?vz+sI9ypkOo7yfDerDFNkdUahoI+LX0Rs9ODtimZ4tSLBm/wIdoyyzs74mSz?=
 =?us-ascii?Q?9Kpehk728/fYc9wQnmv1W7WU8hC8CmNd3BFVA6CDo9PZ0g99nPK2hxC27Ix1?=
 =?us-ascii?Q?GDG4oba7dnke9+Squ9M8bJAXRgW30AgCOzQfTq5lrYZ/xrbbJKsQHZwMyhub?=
 =?us-ascii?Q?K3LZM8+BeGya6UzAHeoXM0XRI8jhRwNliXzN/cfc2A3QLntsPajMzXxpsR27?=
 =?us-ascii?Q?X1euum4ap6bNADs/9+LgpiZ4HbT8v3ZUY8a06Q34YBPKCPfJ9UcwtCc0DPCA?=
 =?us-ascii?Q?m4v9BCh77kuIP0MzHUJCE1fKqX3dV/tJ8RcDwB+I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4316b22e-642f-436d-3406-08dc90cf471a
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 02:18:30.8420
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lQk0ZMTF3f5yQqUA/+AA9aGdF/Dm40gyg/fpFgJAvtN0QyzwkFsALpIWnsV6nkfn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8472

Reorder lpi2c2, lpi2c3, mu1 and mu2 label in alphabetical order.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 296 +++++++++---------
 1 file changed, 148 insertions(+), 148 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
index 095bbcb3b3ee..a15987f49e8d 100644
--- a/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
@@ -97,12 +97,150 @@ &cm33 {
 	status = "okay";
 };
 
-&mu1 {
+&eqos {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_eqos>;
+	pinctrl-1 = <&pinctrl_eqos_sleep>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy1>;
 	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy1: ethernet-phy@1 {
+			reg = <1>;
+			eee-broken-1000t;
+			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+		};
+	};
 };
 
-&mu2 {
+&fec {
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_fec>;
+	pinctrl-1 = <&pinctrl_fec_sleep>;
+	phy-mode = "rgmii-id";
+	phy-handle = <&ethphy2>;
+	fsl,magic-packet;
+	status = "okay";
+
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		clock-frequency = <5000000>;
+
+		ethphy2: ethernet-phy@2 {
+			reg = <2>;
+			eee-broken-1000t;
+			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10000>;
+			reset-deassert-us = <80000>;
+		};
+	};
+};
+
+&lpi2c2 {
+	#address-cells = <1>;
+	#size-cells = <0>;
+	clock-frequency = <400000>;
+	pinctrl-names = "default", "sleep";
+	pinctrl-0 = <&pinctrl_lpi2c2>;
+	pinctrl-1 = <&pinctrl_lpi2c2>;
 	status = "okay";
+
+	pcal6524: gpio@22 {
+		compatible = "nxp,pcal6524";
+		reg = <0x22>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_pcal6524>;
+		gpio-controller;
+		#gpio-cells = <2>;
+		interrupt-controller;
+		#interrupt-cells = <2>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	pmic@25 {
+		compatible = "nxp,pca9451a";
+		reg = <0x25>;
+		interrupt-parent = <&pcal6524>;
+		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
+
+		regulators {
+			buck1: BUCK1 {
+				regulator-name = "BUCK1";
+				regulator-min-microvolt = <610000>;
+				regulator-max-microvolt = <950000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck2: BUCK2 {
+				regulator-name = "BUCK2";
+				regulator-min-microvolt = <600000>;
+				regulator-max-microvolt = <670000>;
+				regulator-boot-on;
+				regulator-always-on;
+				regulator-ramp-delay = <3125>;
+			};
+
+			buck4: BUCK4{
+				regulator-name = "BUCK4";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck5: BUCK5{
+				regulator-name = "BUCK5";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <3400000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			buck6: BUCK6 {
+				regulator-name = "BUCK6";
+				regulator-min-microvolt = <1060000>;
+				regulator-max-microvolt = <1140000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo1: LDO1 {
+				regulator-name = "LDO1";
+				regulator-min-microvolt = <1620000>;
+				regulator-max-microvolt = <1980000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo4: LDO4 {
+				regulator-name = "LDO4";
+				regulator-min-microvolt = <800000>;
+				regulator-max-microvolt = <840000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+
+			ldo5: LDO5 {
+				regulator-name = "LDO5";
+				regulator-min-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
+				regulator-boot-on;
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &lpi2c3 {
@@ -187,54 +325,6 @@ pcf2131: rtc@53 {
 	};
 };
 
-&eqos {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_eqos>;
-	pinctrl-1 = <&pinctrl_eqos_sleep>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy1>;
-	status = "okay";
-
-	mdio {
-		compatible = "snps,dwmac-mdio";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy1: ethernet-phy@1 {
-			reg = <1>;
-			eee-broken-1000t;
-			reset-gpios = <&pcal6524 15 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <80000>;
-		};
-	};
-};
-
-&fec {
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_fec>;
-	pinctrl-1 = <&pinctrl_fec_sleep>;
-	phy-mode = "rgmii-id";
-	phy-handle = <&ethphy2>;
-	fsl,magic-packet;
-	status = "okay";
-
-	mdio {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		clock-frequency = <5000000>;
-
-		ethphy2: ethernet-phy@2 {
-			reg = <2>;
-			eee-broken-1000t;
-			reset-gpios = <&pcal6524 16 GPIO_ACTIVE_LOW>;
-			reset-assert-us = <10000>;
-			reset-deassert-us = <80000>;
-		};
-	};
-};
-
 &lpuart1 { /* console */
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
@@ -247,6 +337,14 @@ &lpuart5 {
 	status = "okay";
 };
 
+&mu1 {
+	status = "okay";
+};
+
+&mu2 {
+	status = "okay";
+};
+
 &usbotg1 {
 	dr_mode = "otg";
 	hnp-disable;
@@ -310,104 +408,6 @@ &wdog3 {
 	status = "okay";
 };
 
-&lpi2c2 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-frequency = <400000>;
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pinctrl_lpi2c2>;
-	pinctrl-1 = <&pinctrl_lpi2c2>;
-	status = "okay";
-
-	pcal6524: gpio@22 {
-		compatible = "nxp,pcal6524";
-		reg = <0x22>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&pinctrl_pcal6524>;
-		gpio-controller;
-		#gpio-cells = <2>;
-		interrupt-controller;
-		#interrupt-cells = <2>;
-		interrupt-parent = <&gpio3>;
-		interrupts = <27 IRQ_TYPE_LEVEL_LOW>;
-	};
-
-	pmic@25 {
-		compatible = "nxp,pca9451a";
-		reg = <0x25>;
-		interrupt-parent = <&pcal6524>;
-		interrupts = <11 IRQ_TYPE_EDGE_FALLING>;
-
-		regulators {
-			buck1: BUCK1 {
-				regulator-name = "BUCK1";
-				regulator-min-microvolt = <610000>;
-				regulator-max-microvolt = <950000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck2: BUCK2 {
-				regulator-name = "BUCK2";
-				regulator-min-microvolt = <600000>;
-				regulator-max-microvolt = <670000>;
-				regulator-boot-on;
-				regulator-always-on;
-				regulator-ramp-delay = <3125>;
-			};
-
-			buck4: BUCK4{
-				regulator-name = "BUCK4";
-				regulator-min-microvolt = <1620000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck5: BUCK5{
-				regulator-name = "BUCK5";
-				regulator-min-microvolt = <1620000>;
-				regulator-max-microvolt = <3400000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			buck6: BUCK6 {
-				regulator-name = "BUCK6";
-				regulator-min-microvolt = <1060000>;
-				regulator-max-microvolt = <1140000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo1: LDO1 {
-				regulator-name = "LDO1";
-				regulator-min-microvolt = <1620000>;
-				regulator-max-microvolt = <1980000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo4: LDO4 {
-				regulator-name = "LDO4";
-				regulator-min-microvolt = <800000>;
-				regulator-max-microvolt = <840000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-
-			ldo5: LDO5 {
-				regulator-name = "LDO5";
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
-				regulator-boot-on;
-				regulator-always-on;
-			};
-		};
-	};
-};
-
 &iomuxc {
 	pinctrl_eqos: eqosgrp {
 		fsl,pins = <
-- 
2.37.1


