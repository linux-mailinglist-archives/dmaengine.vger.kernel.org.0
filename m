Return-Path: <dmaengine+bounces-4263-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0CDA2605E
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 17:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52D493A3D35
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A92D20CCD0;
	Mon,  3 Feb 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CcM+krmB"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2085.outbound.protection.outlook.com [40.107.101.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C81820B1EF;
	Mon,  3 Feb 2025 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600774; cv=fail; b=o1R2YGfKrQFIABj21Kpe84MyQw9iJj/H+e5nUL2KXqrkuivUCKe6pdIKQOp6QwLMHZ/cusuIvOGti0tKWsAzXBlaiEiTzKdXUK7CahBepKG38owQrCULT7d1b/tQphJLA7h8vRoJNxGJkBgEjPooknAa4tfD3B8hNiLrq6lO3Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600774; c=relaxed/simple;
	bh=+jSQf/Gr4acmyLhhyPaP/EXiwN+V2xT0LlYFWxHtJdg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DRTyRUf1ANgVlMELGmn5L9jlfHoF5pmwgCIwB0kBSoL5gplDN4jei/8ta9Yg7N+K6ljmzvMpdKwyeAxMywY6IUNYaVR1aMdOQBnY4EXCr5i3bgZnuAGIbNZtVmcxdIG7MbbtsWPubuqp4D/C6vZ+PlyzK+DfdW1Dpw/aO4peFPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CcM+krmB; arc=fail smtp.client-ip=40.107.101.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UjGJrhKszhFzGYioHDhYBojx1CO2CvOUuWgOMHuRzBmavfrFlFObgngyAmMY1+xlfGzrgGfIuKUISuCjgeslBwtZkGhyOgJshWN6rA+vtVnsdi+OiMWKCtWA60h4Hw1KFzrQY9WPnnfFLvff/2QZxuhIDGa0+zdFtgX+PWV0pjj+M6LQeoWqFVZVm0Xnjp/C/CwwEVAFsDsuCQ26zQ57xv9r5mZ31cxrnFvEsGR3iJTkp9Uy2B4KIm8s1iTaz1dSghKEy9akO01lcwgbvKWxirokaHt4RYaNaJpByDsxaNafwU9Vyv3KWmBDk1EbyUFoltxcglMlCo9cymKNWETUPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oxo7EEfcw0Pt1miinnT6cq3B2NNPzlz1Sa2Mok5SOy0=;
 b=H5FiySKuSGbKt/WL/oZw0eVQed0XpC2nrdJ14JJnuJqDjKwz29eTf2/xpg1fFJQDbQXkIiVLYHLCy0tUgV/ZryEWo0NC+6V/ODjNHlfyLxVYxSCSNI3Brt/GnNd/a7LWcsVX/lmKs8goAiNwcuw/AqPbgkpN1awMjKysdeUoOXAri1z6pgWFPii8IoQZh46k6SrWzK+OpdlHS4UHHsFXXjnFrtmnfjEkECS+smD9g0Zj6OHNydenNV6nuJs0I9vKkpzPwqcyBsbLZrkfvD+WDoB1UzcKORuJbpRlRhVVgoSzW9QSnrym3+hyDtl4ne4SjEmBtCMxYudLpwkM2V8jvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oxo7EEfcw0Pt1miinnT6cq3B2NNPzlz1Sa2Mok5SOy0=;
 b=CcM+krmBp03UPKd1zafcvvPJ8i4bi4HMCLw7H14GhaILssvEiUsQeYM9S45zDcMnfDSJT5yrUoN2yxWk29NdsZM/Ig35iPgdodI3rXH5tSG8zYdZw4xbJI3wOSYH67pKgBTC0KRVdBOUX6DKpTgzp2sRMZDQNwbXpHBgsFUI+jA=
Received: from SJ0PR13CA0178.namprd13.prod.outlook.com (2603:10b6:a03:2c7::33)
 by MW4PR12MB7334.namprd12.prod.outlook.com (2603:10b6:303:219::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 16:39:26 +0000
Received: from SN1PEPF00036F41.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::3c) by SJ0PR13CA0178.outlook.office365.com
 (2603:10b6:a03:2c7::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 16:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F41.mail.protection.outlook.com (10.167.248.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 16:39:25 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 10:39:23 -0600
From: Michal Simek <michal.simek@amd.com>
To: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<michal.simek@xilinx.com>, <git@xilinx.com>
CC: Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, "Conor
 Dooley" <conor+dt@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Harini Katakam
	<harini.katakam@amd.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan Cameron
	<jic23@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Michael Tretter
	<m.tretter@pengutronix.de>, Michael Turquette <mturquette@baylibre.com>,
	Mubin Sayyed <mubin.sayyed@amd.com>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Niklas Cassel <cassel@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Shyam Pandey
	<radhey.shyam.pandey@amd.com>, Stephen Boyd <sboyd@kernel.org>, Vinod Koul
	<vkoul@kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS" <devicetree@vger.kernel.org>, "open list:DMA GENERIC OFFLOAD ENGINE
 SUBSYSTEM" <dmaengine@vger.kernel.org>, "moderated list:ARM/ZYNQ
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:COMMON CLK
 FRAMEWORK" <linux-clk@vger.kernel.org>, "open list:LIBATA SUBSYSTEM (Serial
 and Parallel ATA drivers)" <linux-ide@vger.kernel.org>, "open list:XILINX AMS
 DRIVER" <linux-iio@vger.kernel.org>, "open list:SPI SUBSYSTEM"
	<linux-spi@vger.kernel.org>, "open list:USB SUBSYSTEM"
	<linux-usb@vger.kernel.org>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>
Subject: [PATCH 2/2] dt-bindings: xilinx: Deprecate header with firmware constants
Date: Mon, 3 Feb 2025 17:39:11 +0100
Message-ID: <2a6f0229522327939e6893565e540b75f854a37b.1738600745.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1738600745.git.michal.simek@amd.com>
References: <cover.1738600745.git.michal.simek@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7990; i=michal.simek@amd.com; h=from:subject:message-id; bh=+jSQf/Gr4acmyLhhyPaP/EXiwN+V2xT0LlYFWxHtJdg=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQFH/Uly/cozLT9NHXTtG1/olc/PZ9V9//Hv5glty+4q Knascs864hlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATuV/DsGDCusSzjI3JTXEl EqJSuSXFkvKNPAzzzH/aVt9wrLdf/6J8u45mwpq7vZ7hAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F41:EE_|MW4PR12MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 3be94396-7605-45b6-08ec-08dd44715230
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|30052699003|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LJeZFRk2OOQH/3mRw/ckgthqDs+08DXHUorvEYlAwwHF93rutjEWXqTy7Ijc?=
 =?us-ascii?Q?AXddcQbiKfthM+BGebr+TZ8NrfRJ0tJp0jK4EhU26xGyxz2X5bsuhjBi8vOX?=
 =?us-ascii?Q?22iqhW9O3DCuoRRgv7ZTmbuiF7BZkxIfRxLGp2NMBw8BrO7XwqOWbn3TF1yy?=
 =?us-ascii?Q?0IpRRiAMK7zHAVP7/lQhHW7Wi7ZF+uz2Y0mYVrB6lOgCdcks+jqyl616MN9y?=
 =?us-ascii?Q?I1tz4pyKlgcC74NMGoQvWvSHsvxeYoJs+bbq3FkS/3zdH3qqlL145pYaKmkK?=
 =?us-ascii?Q?9nFdRH4IhsNKbGIOUgLtVtUWOKmALkprrVhpJk0baBNtOsYJIxbGVnp5lM/P?=
 =?us-ascii?Q?Z5SyMxuIUMXtm6Cx9tot/1uyjhVDYhdtFMVpo+4A5lbzsilhUQAUC/F/dqZV?=
 =?us-ascii?Q?xa8a5mSA2rszfXPhPMwK+EGghjeNwpAQAR6Tz1ZmUaTDBRC2oVThvxoJHTOq?=
 =?us-ascii?Q?KR+StkYTXGA0ipwJe1YOgZk8yPpqRBkB+TMArtrXXK0M5R46HT2MMP59rNcP?=
 =?us-ascii?Q?/Y7LN9Nc79vogKzidPZb5FqBnoZfMB5w+M6z3TwF72i8xWBgboI66uDsyrAV?=
 =?us-ascii?Q?nTcIAfTKHc4ts0irG+kpysaQGaaipPHleZelM3d64bMio4FToqMHsSW5qPFr?=
 =?us-ascii?Q?51W8PS0dnzKbE24eXzZV+Ws2dkMn3th4wjvIp0OFYMKW5FrKIvQVvUghypdw?=
 =?us-ascii?Q?HzmLd5uK6X5DwHoznly+3R60S0HR0ZPvLbViPwFTB5Moqf3UvY5iHTze040W?=
 =?us-ascii?Q?IctjcKTrpnBf3x+K3HfEm09CRKcfJg6Wz9ovwcVaisNQMpLYbkOvI6vyVI9i?=
 =?us-ascii?Q?W4G96v++JmXb1EnyVraBYVYwRMHSCjSlTi3O/YhDjXXsP0EvQYd4/QiXGxic?=
 =?us-ascii?Q?3WEoCWBL9J1iu0Og0qKCLPsq+JKuz98Pzlo9vAXMgmwdUgJH+ceXbJNLhGIV?=
 =?us-ascii?Q?kRJcwWyQSggkRg607VOVpKlQHqovCrEWFk94iU/X2vwP/D0mKmCH3+DKZxeW?=
 =?us-ascii?Q?H+STjSV5LhtPYBAl542cUPhl2rTwMfLwvT/Vd6RDJsEvQnEsp7V4IARVPawx?=
 =?us-ascii?Q?8x6cprIllX+rsJW0SnE/5IXVDFN1pZHukiYVizEm5O6dj6bT0nOvJLha1lDX?=
 =?us-ascii?Q?D5shoXUsMwqp/jvKwXop905emIaM7N1960OTm4M9v7AqTG/+na1pt4W8XUVx?=
 =?us-ascii?Q?RzOyOcSvfw7F5skjQ5Jm9lpQ2jyribCZXIGZNBiTPYXSDX+yTY68tP91Q8Wt?=
 =?us-ascii?Q?wBqpNmAiMCGrb3ShGSSDv1sXbephPAMM1+baHLNGfOq/xZA6IImt3e9HLrlq?=
 =?us-ascii?Q?mK75xNjpO+A89ccqAQ8FSzFTs8O2SzIzGyzLf0Pr2vpcpAaXv+CujzBlYFWA?=
 =?us-ascii?Q?j53u7j/IBuzW5Huf+Xx5ER7zHZPVhFr2PDzcceA6UcgDpdKTUe8pFlCYmqP0?=
 =?us-ascii?Q?cQwaSvrGyP5uClYU0v5pytAPkJ/bOOGyZtswAxEyu/YmLH2EoxlgAg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(30052699003)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:39:25.6570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be94396-7605-45b6-08ec-08dd44715230
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F41.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7334

Firmware contants do not fit the purpose of bindings because they are not
independent IDs for abstractions. They are more or less just contants which
better to wire via header with DT which is using it.
That's why add deprecated message to dt binding header and also update
existing dt bindings not to use macros from the header  and replace them by
it's value. Actually value is not relevant because it is only example.

The similar changes have been done by commit 9d9292576810 ("dt-bindings:
pinctrl: samsung: deprecate header with register constants").

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml  | 4 +---
 .../bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml           | 3 +--
 .../devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml       | 3 +--
 Documentation/devicetree/bindings/net/cdns,macb.yaml       | 7 +++----
 Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml | 3 +--
 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml     | 3 +--
 include/dt-bindings/clock/xlnx-zynqmp-clk.h                | 7 +++++++
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
index 9952e0ef7767..6ad78429dc74 100644
--- a/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
+++ b/Documentation/devicetree/bindings/ata/ceva,ahci-1v84.yaml
@@ -163,11 +163,9 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/power/xlnx-zynqmp-power.h>
     #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
-    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
     #include <dt-bindings/phy/phy.h>
 
     sata: ahci@fd0c0000 {
@@ -175,7 +173,7 @@ examples:
         reg = <0xfd0c0000 0x200>;
         interrupt-parent = <&gic>;
         interrupts = <0 133 IRQ_TYPE_LEVEL_HIGH>;
-        clocks = <&zynqmp_clk SATA_REF>;
+        clocks = <&zynqmp_clk 22>;
         ceva,p0-cominit-params = /bits/ 8 <0x0F 0x25 0x18 0x29>;
         ceva,p0-comwake-params = /bits/ 8 <0x04 0x0B 0x08 0x0F>;
         ceva,p0-burst-params = /bits/ 8 <0x0A 0x08 0x4A 0x06>;
diff --git a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
index ac3198953b8e..b5399c65a731 100644
--- a/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
+++ b/Documentation/devicetree/bindings/dma/xilinx/xlnx,zynqmp-dma-1.0.yaml
@@ -75,7 +75,6 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
 
     fpd_dma_chan1: dma-controller@fd500000 {
       compatible = "xlnx,zynqmp-dma-1.0";
@@ -84,7 +83,7 @@ examples:
       interrupts = <0 117 0x4>;
       #dma-cells = <1>;
       clock-names = "clk_main", "clk_apb";
-      clocks = <&zynqmp_clk GDMA_REF>, <&zynqmp_clk LPD_LSBUS>;
+      clocks = <&zynqmp_clk 19>, <&zynqmp_clk 31>;
       xlnx,bus-width = <128>;
       dma-coherent;
     };
diff --git a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
index 8cbad7e792b6..a403392fb263 100644
--- a/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml
@@ -193,7 +193,6 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
 
     bus {
         #address-cells = <2>;
@@ -204,7 +203,7 @@ examples:
             interrupt-parent = <&gic>;
             interrupts = <0 56 4>;
             reg = <0x0 0xffa50000 0x0 0x800>;
-            clocks = <&zynqmp_clk AMS_REF>;
+            clocks = <&zynqmp_clk 70>;
             #address-cells = <1>;
             #size-cells = <1>;
             #io-channel-cells = <1>;
diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 3c30dd23cd4e..8d69846b2e09 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -197,7 +197,6 @@ examples:
     };
 
   - |
-    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
     #include <dt-bindings/power/xlnx-zynqmp-power.h>
     #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
     #include <dt-bindings/phy/phy.h>
@@ -210,9 +209,9 @@ examples:
                     interrupt-parent = <&gic>;
                     interrupts = <0 59 4>, <0 59 4>;
                     reg = <0x0 0xff0c0000 0x0 0x1000>;
-                    clocks = <&zynqmp_clk LPD_LSBUS>, <&zynqmp_clk GEM1_REF>,
-                             <&zynqmp_clk GEM1_TX>, <&zynqmp_clk GEM1_RX>,
-                             <&zynqmp_clk GEM_TSU>;
+                    clocks = <&zynqmp_clk 31>, <&zynqmp_clk 105>,
+                             <&zynqmp_clk 51>, <&zynqmp_clk 50>,
+                             <&zynqmp_clk 44>;
                     clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";
                     #address-cells = <1>;
                     #size-cells = <0>;
diff --git a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
index 04d4d3b4916d..02cf1314367b 100644
--- a/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-zynqmp-qspi.yaml
@@ -65,14 +65,13 @@ allOf:
 
 examples:
   - |
-    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
     soc {
       #address-cells = <2>;
       #size-cells = <2>;
 
       qspi: spi@ff0f0000 {
         compatible = "xlnx,zynqmp-qspi-1.0";
-        clocks = <&zynqmp_clk QSPI_REF>, <&zynqmp_clk LPD_LSBUS>;
+        clocks = <&zynqmp_clk 53>, <&zynqmp_clk 82>;
         clock-names = "ref_clk", "pclk";
         interrupts = <0 15 4>;
         interrupt-parent = <&gic>;
diff --git a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
index 00f87a558c7d..b5843f4d17d8 100644
--- a/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml
@@ -101,7 +101,6 @@ examples:
     #include <dt-bindings/dma/xlnx-zynqmp-dpdma.h>
     #include <dt-bindings/power/xlnx-zynqmp-power.h>
     #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
-    #include <dt-bindings/clock/xlnx-zynqmp-clk.h>
     #include <dt-bindings/reset/xlnx-zynqmp-resets.h>
     #include <dt-bindings/phy/phy.h>
     axi {
@@ -113,7 +112,7 @@ examples:
             #size-cells = <0x2>;
             compatible = "xlnx,zynqmp-dwc3";
             reg = <0x0 0xff9d0000 0x0 0x100>;
-            clocks = <&zynqmp_clk USB0_BUS_REF>, <&zynqmp_clk USB3_DUAL_REF>;
+            clocks = <&zynqmp_clk 32>, <&zynqmp_clk 34>;
             clock-names = "bus_clk", "ref_clk";
             power-domains = <&zynqmp_firmware PD_USB_0>;
             resets = <&zynqmp_reset ZYNQMP_RESET_USB1_CORERESET>,
diff --git a/include/dt-bindings/clock/xlnx-zynqmp-clk.h b/include/dt-bindings/clock/xlnx-zynqmp-clk.h
index cdc4c0b9a374..f0f7ddd3dcbd 100644
--- a/include/dt-bindings/clock/xlnx-zynqmp-clk.h
+++ b/include/dt-bindings/clock/xlnx-zynqmp-clk.h
@@ -9,6 +9,13 @@
 #ifndef _DT_BINDINGS_CLK_ZYNQMP_H
 #define _DT_BINDINGS_CLK_ZYNQMP_H
 
+/*
+ * These bindings are deprecated, because they do not match the actual
+ * concept of bindings but rather contain pure firmware values.
+ * Instead include the header in the DTS source directory.
+ */
+#warning "These bindings are deprecated. Instead use the header in the DTS source directory."
+
 #define IOPLL			0
 #define RPLL			1
 #define APLL			2
-- 
2.43.0


