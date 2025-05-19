Return-Path: <dmaengine+bounces-5193-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324DABB45D
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 07:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FCF33B7B30
	for <lists+dmaengine@lfdr.de>; Mon, 19 May 2025 05:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F691F03FB;
	Mon, 19 May 2025 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="LQ7FYmKQ"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8941EB9FA;
	Mon, 19 May 2025 05:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747631434; cv=fail; b=gULiX1oSfm+Syajm4G0enkBRdiOD0DcVJXnp+Uokcu2dA/eBXBn8rRz/ZqHEIoWrIq+pkrN1WLuGRw0AoqlitvjBNNQSG9Pz/7Ekj321yIA8eyONdVtanbw63/q3ppIpdXXvh9sTSyjKoOpzNxOGOzkvBYhg4d2rZRb6bbyQW68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747631434; c=relaxed/simple;
	bh=fWBQTdfpEVkj9EJz6G54p5xCLCPZiRjWrSEtZpoqv04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q3sSdOl6r9uFZ+U84RCuiCnVE1FI0AOEk3raV5taQzQUR+DH0w44LxHeTzX8utsmANagBapjG2CAin4inZrlvmKyxz0OlN4bpDmQDkAW5XD53lXtiZLCZcGsQxabvWM/b9Q2dG0x6UoU+gWc+zc3WcmyZKu4ioqEv7OSXQgpqJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=LQ7FYmKQ; arc=fail smtp.client-ip=40.107.93.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUw2/qW/LCilSF/oziu2LDG/KhP4a6qn/X4ENyLQmvRw+ZFzp/DPeeBgllbYZAGtPGH/h6L3TMs/tmGkV6etxZvzDjdgzxapUSBsSU/AHhyKMuFm59wL2qdr9sGo0PGCDkC3CSswIm/dli2mJKFCK2lk8cnDwem0l9AaGxpjRmi/pHRt2D1u0NzNS48uWiLoxTQdD4EzTwHGNTqFeRGDO4V+fmK9VCBGHCa615Ni9GwftOadkX+UpetPztAwXAWUD6H+dkX1WSgp0MdxegNh68zJNsiZLQg0PqWmX/iTuqpSrm1lSAS8hdy5qHYSohYn0L+SQPSB9mLillh0VSh7jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CwUtly7iSkhkQYiERlgNwiocJgZCaLVp7Oe17rN1fn0=;
 b=iY+j6jzegCoXNHVDqb2Sx0M492+nXHdCGvyJnGIfjA2CTULlIOPcLcZE39dBl4J9skwjKiDMSAYD7HM8sGcohaHUOeR1I6dJBlu5q8iIrtLTl+uGxxYs5IMecuSrzY7dPgoMQHzh8M5oLDDbCZ69DXJ82qdkipKFJZAS6vf4VI7+7PvtBZ/1d6MG6abuFSx/vvdcmYIco+g2pb8p6o+rsS6M3f833Mm5G9BYXeo2pCSPQctNIESzz9cyZ1reWujYcxbIPTB5e/ggf1WSBSFI5vSCGAtFA8ELZUns4Kpf+UPLUG8xIcrpioG+KBmKb8E4jkbN9jlZGyf+XQy/9EYQCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CwUtly7iSkhkQYiERlgNwiocJgZCaLVp7Oe17rN1fn0=;
 b=LQ7FYmKQVUQcT14g795zUu5CInUx/L+Hu0qjPnBV/YRicTtd1qZ+u9oUnjYugWMZVGKxmc/P/3R1Mk5MVJ09ySAwxrj6x18NskWRR7/dTg49mMxFpFw05qLTrKYd72k8xTEyPkBAEndkSR4mZHeNpQquNMRiQJUi95kxvZ02/QsgbadABper0JljWssyscYzpEVj8zLRsL9EiP7rLgPR5GByXXIMPKPxhvkfnyo9FqRjOc0f1TZTU7CEK1rl21f1IaGup1hbirSNcaRT9yhU5GwySVXZwQTGW1kzg17W3AqUMyLQJ6RH++PS4I0X2XB7/Ydci7IfYeRuOWWPoIV2yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM8PR03MB6230.namprd03.prod.outlook.com (2603:10b6:8:3c::13) by
 CH2PR03MB8060.namprd03.prod.outlook.com (2603:10b6:610:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 05:10:30 +0000
Received: from DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71]) by DM8PR03MB6230.namprd03.prod.outlook.com
 ([fe80::c297:4c45:23cb:7f71%7]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 05:10:30 +0000
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
Subject: [PATCH v2 3/4] arm64: dts: socfpga: agilex5: Update Agilex5 DTSI and DTS
Date: Mon, 19 May 2025 13:09:40 +0800
Message-ID: <fcf4e787fa488543595c45def365710213463b8a.1747630638.git.adrianhoyin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <cover.1747630638.git.adrianhoyin.ng@altera.com>
References: <cover.1747630638.git.adrianhoyin.ng@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0114.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::18) To DM8PR03MB6230.namprd03.prod.outlook.com
 (2603:10b6:8:3c::13)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR03MB6230:EE_|CH2PR03MB8060:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a3d343c-c547-4944-89b7-08dd969379ce
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RzHtiBcnFjxgi7p7dp6pNctsjqu3uME6NT/TwjBV1kt3bpQxYNCzUTcDL4Z6?=
 =?us-ascii?Q?lStUdZJP57ab7A96ZuLgPoOpH66DbIh80PilFkkw7m0hJYRgqjNSCK2tKXvl?=
 =?us-ascii?Q?ZZf0NmGYIhr/ma4ogQ+Mh7iPrblq98cFj4eaIbzpgXe379LEKaXcpA3Ovdzv?=
 =?us-ascii?Q?S70FzGkrKLqNrYiXUkSub3YyKViOOUvmfs3ptCvptmljtLChEFAwne335t3U?=
 =?us-ascii?Q?JKwu6GP9Wci0Oy1wzz6HMByc0q7Vk0vODC+ogn3EE3GEeHopWhmd1ZVjsQOO?=
 =?us-ascii?Q?MMsFYmc5KnMF/WChCKocqGQfTYkv/f6sVm91rNWzT435AZBg88CsY6n+TeuS?=
 =?us-ascii?Q?YbddAOp1B7Qipf3rip5/wHo0lv1iDOL6fjHLn2yIt3QdDEUDK7OKEOd8QfOf?=
 =?us-ascii?Q?eG/U6N5junLFOYmzdL8wb+vNj9f4nO5YVEjR/srntsThEL5ZqPLpoOPcH5t7?=
 =?us-ascii?Q?+F14ZY3SBL2pWaOIvFXu3iV+PhuS14aGb70QsykgUU4zsnv+oyH6roDuewnX?=
 =?us-ascii?Q?BWW6yODrxHZVY8/fqA/ShLZ4WDOGX7rG4yHN83RbouX0T0UoEOkSDDRx9MLg?=
 =?us-ascii?Q?Y3fBfsWs+FxdTt2+MOZCUTm4LXgAdkOrQdpxWFuA1ZXYPwOZUMug0UkiScEl?=
 =?us-ascii?Q?71pxESzgMW73aDwXX/3qI4W90u7FzvslM9HrpWoumQiBfxykjgkKEthD94IN?=
 =?us-ascii?Q?CG/kTAqQC7iOt+aNApNQXTeWHv5BEM34trIupRU6VCGwb3anl7DLkGw6xzfT?=
 =?us-ascii?Q?k276vf5Up19j9c9jx+H/MATTjyuQLAtmkRMC4X0P9Qw0HMxS9bBLWHOGT+HV?=
 =?us-ascii?Q?irAfR8yWEfHOBq8WtEaPCSx3f+ZTAl4Ny87CduiPKuCmZitDMN8fFcZBEFBL?=
 =?us-ascii?Q?QMUZuKJsmj2kiXJOGJVaotA9GuHWSUz74kHgqTYxWKJgq1jhvBmzmYOW0yeG?=
 =?us-ascii?Q?lIqHMBSAPgNIHU/3KjRgVCqSn4Z/hiHXGI/F49FVyvqYVwqNvbNM10iHs3Ks?=
 =?us-ascii?Q?Ga5FwY496b6c6JZiRfdHpwV1hp91JVlefjzv/umr8lztYP8GeaEN0uc8jkxX?=
 =?us-ascii?Q?KKmVYjQiqq3+qa1DedyKw7pzK0O7rWL7JoH9MdwrcgBl6Iuv3NWkXZyZ+FX8?=
 =?us-ascii?Q?dSzLrKEs+Jirrw/oRiaQ7WaONWp4QzxPtlbnK3m5X/hU1zBF/6C1AOkfeGNS?=
 =?us-ascii?Q?D+jVvA6f3N5TASctcEhGav+HB7ImlJgwDpMs+wYg+Y+F0H4+r9ihxVk85ELB?=
 =?us-ascii?Q?bIoyCRlvj4/FIGtCJdz85EJBTi70n/XG44+RIPUkzXgDCa3IUq4jPV30uqoc?=
 =?us-ascii?Q?gZLVEolcbRx57sv/rJBUJyqBFshfaG8xgKiz+KbSQdjSMgPvoF7Nrx2Cm/x0?=
 =?us-ascii?Q?kcXd0bn5ddjtedaABOVDTojaboxaPafMWNj99Nv82Ffz8hlNz1wKZIYwhZn9?=
 =?us-ascii?Q?JAJd1By+Bnk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR03MB6230.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?00pV4RC1r8jtMQnY4xWtVMBwqZaV6sosZIRZTv0DgkEiRvFGgR1xgT5WSXEk?=
 =?us-ascii?Q?XXFxskKwGMNycVykhw7EC4NDbY3LcBblsuzsxa+MSJG5BBPQN8DNdFLD6ncj?=
 =?us-ascii?Q?JCa1cH/FWnOrRrKk5XGbeUrMIQjApV5kbuIhVvBjaeCpdJ4lLB7sX1s16qT1?=
 =?us-ascii?Q?imZgbbfsvLYwOKRwAECPQHL/1hCyL9J3dyQjBAm+jJKgWhWDIbz3Ch3FUOfB?=
 =?us-ascii?Q?fogqrqYwCsdVM23vOGtZ53Hi9c0e9RkZsOp7zgYRf6eLCgh9bWfcZVhR9FT2?=
 =?us-ascii?Q?FR8+faz/QgMa5iv8q4zhs/UtR3nMZdceqXypV5PFG0bH7WJjqm66UX2RhJH4?=
 =?us-ascii?Q?m3ovRCU1cFg6ue3v94w5/GKOiBpShG0TDNC+P9GgDPqWg9D6WEzUDxGT53/x?=
 =?us-ascii?Q?hKDE3Ue7izd2fyQRWm0tHGWtqQJejlLCXYtoDr3aSMatMx2RpDi21GVBHKBg?=
 =?us-ascii?Q?ZueRYsljnQ6sjLWt+KK5y84eKu2DXwQ/gggzLBvlYoIgo31bfl85B1qbT6WK?=
 =?us-ascii?Q?wNdWC80AVVHQxaIbmlrBAUBsG4aEkdh0susgNLjcMrA3hiHlNJuCgjtdvxl5?=
 =?us-ascii?Q?Zesu57timDP8Jc+gi1RAYCRB0YD1CW3SUJ8eSksOP8ZPg3o6XjUrK6sTs97L?=
 =?us-ascii?Q?p89rrLYqqppds5UGBmejhRKwVbqnKf/dAWHNPeCH6qpRLcOte+z+XTt1FoHK?=
 =?us-ascii?Q?t1DbVYVgQH866tqMFv5iN5NYIOsyW+2S++dWBMA365Hg90gGtGdu42fcM66l?=
 =?us-ascii?Q?pC2BjuPJtZ03sXrqnklI48u74Dl4GHYjLtMkG+rh1hjm2GwtVzhciy2BcaSn?=
 =?us-ascii?Q?OE1aUJ5BtUxQskf4Ri5NvPqyGu6n+1yv8h0xtoVN85f7Vv2To99p87EJU3GW?=
 =?us-ascii?Q?VX80G3HlDUA7Ey0ihYH1qZYt3OqwmCoCfP6k9npaolh9zwaZiObYB0a7x2nO?=
 =?us-ascii?Q?HCBFA5EpJr2x7u/RV5TOvm/R24cssUQ3jkQ2H9nmbU+Ab6LHobViFxGkvUkV?=
 =?us-ascii?Q?6nEQ15rM4dTCfomjMSX3G6M7I3mSYzT1DCqouvVs4IkO5D8ZC/v8wfA54z3f?=
 =?us-ascii?Q?YRDA6t1Yd5l11ljiChbX7vCzh6rQ1P81zJns3pt75fnXnwErivvwHa+tVPMl?=
 =?us-ascii?Q?kRrgYbS/rc2xYV5uQytIgPL01eh8CTV+fVqtiyyMclIMnEYqwx+afWmcDgAF?=
 =?us-ascii?Q?U+nqapsbmM7NFRFqtP7JmHQSxULBREIf9Pqg6hZMQ0iY1e10ZTw3jdplZoRT?=
 =?us-ascii?Q?8nuXM4jHD04ii53ZbV0onM1xH7+vw/E63obNRAXdwJ5V0mMYhXyTSeWBM4e6?=
 =?us-ascii?Q?j+0Yck/tdju+m6iUNAPlmuwHCa6WYYk04tgfVe+rjxuc8WjbMJK4pb5l7kMU?=
 =?us-ascii?Q?wl3iKDy5XBN8pjubC/KEt00rIwEjgdO/GSGrLJ3T8DXw1dKY82af0hEpEDuy?=
 =?us-ascii?Q?AkZWjseAavvE0kP+Djlnf8t4K6e9SyLJx/HhnvxvzxH7Yd0JPBlf1mddFQXK?=
 =?us-ascii?Q?RA6MV3Hj/NR7bsqtlhFcll9lLBf/S9jemjdxvRidj4xCo2ZvxxF4FwFuTynv?=
 =?us-ascii?Q?6xE22Dmoc9Hl4iuTolCdeSCcAX2s4pRL5N8/LHEt2Q2vqZauXSZpyVUHT0Jk?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a3d343c-c547-4944-89b7-08dd969379ce
X-MS-Exchange-CrossTenant-AuthSource: DM8PR03MB6230.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 05:10:30.5441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWEg6iSJ6V1tlk3Me+HUll9VOcHwHAyQ3mLeVw9MIQJrs0E+Vb/1KtWe89L/NIsUg/A4PIjXmMyoEB9wJWLe/WbPQv3plCARqbAYCS+rN4E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8060

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


