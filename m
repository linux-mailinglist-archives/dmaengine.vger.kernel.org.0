Return-Path: <dmaengine+bounces-4262-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5385DA26051
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 17:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB08B16389B
	for <lists+dmaengine@lfdr.de>; Mon,  3 Feb 2025 16:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD03F20B1FB;
	Mon,  3 Feb 2025 16:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Og7buhXF"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD612080FD;
	Mon,  3 Feb 2025 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738600764; cv=fail; b=mX3ZYPF0gAHEvhzOcs894o7QAsvDghm8cYhyXWANEUmNrWp8HUalZ6C+kZOjOoOHQy0V3ixoO03CXWTHm+hD+Q1oWPN7K4sVrbCg9W9z/ZbLxdylFqgskmae18LuwQLiNCLQ/w3778SBY1qAGrWjhartcKE7Yk91jbR7b65M6OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738600764; c=relaxed/simple;
	bh=NtgvXicW8DllxHCFVc+qXu3UYT6RjWPVYssNClQ0tqA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ob/AjBPIL7bLlWuXSOWkrrPE5EfBTI95hHrXpqX0pRChbKwdk6V/u06Bv6vLwNNeIgY5w/xoaKnoY9keaeQKT4m5SKKIG60KD69g2U80Mtav/Msj/m3Dsr1xPUzAiH7qdETbUHHZBOVzD2dFdfYoECbinJ+e8NDUk6xvaPOK9pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Og7buhXF; arc=fail smtp.client-ip=40.107.236.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mPfOGpcOcwYjl3zA3O72cDmjhHaEeh2ugeqqgf2SrziEglDwuw/RubzgaI28qCFtvAC6NAnVzQis2L9MdUcSoRkb+AY3e9ORw5s/DtNDJz3I05bRGD03NWiNsbbnyol3LfCn1fvZJrNXrcPqNrGj51iqnDNbGsV1db6z2kMv9E8EhdyQtBWo2GSzHydJJK0CBw25T+aN0v2xWBiXqnWdvnpgy+ItdHFh2x9z6sK3Zkk8juTgXx7XIrwITzL2dv5S3TOy0FC6ZKFJalpXiF69akC/jFLGUc+r77Y2tqrTSfTanjxAQYIcCA03OhQzrS87kluGdW2063Haun44NJo0tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMQc94gA4RuTHwJ+H56qNlZxhgA90xOSrP1iV38eZDc=;
 b=pnffvB6TuO9xxlea0qXxVOknUVYtGC0qNui0LB9DGYkWfH4WMWeOt038uYsNDx0OCOeIgu0gYlz6dMZgs12vNlHszmQ+tEjdtUYOtiadTqgkVjCorwH8D6Gd78FgzFuvU279Cnr2+GL7nSaBHHMsQlJC7v99vQITKBp2bT7E9k7IU2xpB0ciYrvC193SpNQ1Oq4qErq3Mzu4KcNLwRubvoCh0TTKUGycbNQXGUONlvrSGeyWfqRNpdSzkXpvGt7a9KkksGeCBMxJS4AHhOuhKpx8UpMSArcUL64CUGNx7mlXV7CAf3/37D9m0J6kE+XRTgS9t47HKixRkMEo2cpWfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQc94gA4RuTHwJ+H56qNlZxhgA90xOSrP1iV38eZDc=;
 b=Og7buhXFpczM+LhtxpAg8dtRQHaXprPT4ehpU/3IyGPcsnBZ9e6bYKRTvxuCM4ycOMpIC9c1j2/1ao4pupEFoCpayjNuMQcutVBd/k1bJ9Klt3YJ/7fzMeF/JFiBBJnOo4sSbl94ku2NQ/zt7QijgKkGP5w42MyFy1Q+7ipYZfA=
Received: from SA0PR12CA0021.namprd12.prod.outlook.com (2603:10b6:806:6f::26)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 16:39:19 +0000
Received: from SN1PEPF00036F43.namprd05.prod.outlook.com
 (2603:10b6:806:6f:cafe::92) by SA0PR12CA0021.outlook.office365.com
 (2603:10b6:806:6f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 16:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F43.mail.protection.outlook.com (10.167.248.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 16:39:19 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Feb
 2025 10:39:15 -0600
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
Subject: [PATCH 0/2] arm64: zynqmp: Move firmware constants from binding to platform
Date: Mon, 3 Feb 2025 17:39:09 +0100
Message-ID: <cover.1738600745.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=michal.simek@amd.com; h=from:subject:message-id; bh=NtgvXicW8DllxHCFVc+qXu3UYT6RjWPVYssNClQ0tqA=; b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQFH/XO9aSdvRt6edPv2Vp+/kZ8dWIMGz6mbFlxdOK8Z cs29Les74hlYRBkYpAVU2SRtrlyZm/ljCnCFw/LwcxhZQIZwsDFKQATCbnEMJv9X03yK0ZNMcH6 vO2TFxv4/nzZ/JNhvs+iIwIrey9Z/9rWeONr5s5lRVMu+gAA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp; fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F43:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: b13da256-9f65-4880-4245-08dd44714e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gRRc5v6PqVw/xUB/0pO5QmPVMVs5BLUNXEhz0u3D6rsQCtHp3IjUz6ajjk2O?=
 =?us-ascii?Q?dfgkyo8D0/vmZqhChzjLO7jSvDA+JjSdDQdY57DdD2yvfopsCYwPhoh7SHdO?=
 =?us-ascii?Q?4VeuRzKcaOl0EfGovAE3IVXeQhHe1RoDlnZXvKJJ5v3SGnQtLBfj4apfio4V?=
 =?us-ascii?Q?1z8EJkH/oAyQ6UDqyqq22JOjmvWawZVLswLxAyA1bbRD5i556+1rmEWG5MNL?=
 =?us-ascii?Q?HvtTgdizLCvjaLO4qL+Wmsna8f5Vi13bbWjWdDHJGnSzHNU199txzk1nIROT?=
 =?us-ascii?Q?sun166WQFquGiAIp5KVsMswnhcHT21Zs9c1aHcL+mosOEUeyDRKkwQcM7m7t?=
 =?us-ascii?Q?a87lFRXzfn3o0byFhR/ioMXD/fSYj1j9NU66aAXYwKJutPo+0ZdudjJyWFyB?=
 =?us-ascii?Q?8k0efBNU2H6XQorzdn2T64boKbiaIwQ60XrtN9kqvuHZBzOx7pwDXU2Eedjl?=
 =?us-ascii?Q?UH4Cajz0r72mdDjPUlhsjBiySXvs2SiprF4XxmnbtrfwyZWl9f9ioBmpNyL+?=
 =?us-ascii?Q?BtFAxItfSXAnzizMvsqeIdpYygbXlADfRN14ohed8uvV9n+gJpBast7OVNR3?=
 =?us-ascii?Q?QQjCYW+CXyi8Aqi4Na2S/xu6wHnDyeXxjvgBJ86Aam6SRbphAluLw5TF10fL?=
 =?us-ascii?Q?dUYLY8PX57JC0sjQwpmsnYWS+jbMgrmZw7qtwG8xGqq4p8BIHotomC/tbYaW?=
 =?us-ascii?Q?gWY6fYd7CCteyXJ2T/5IGlwJYHw71Ol16zBZFpkfIcRF+6toE3BBrVzlaR5H?=
 =?us-ascii?Q?/pR0VCX+cQhk4IvoS6VilxBKitoniEcoFLFrUROnep9eIbNbeQGadXm+vxXh?=
 =?us-ascii?Q?gcc1DPhCqlRPjZPA+8aBs8Hnb/uKZ5fBb+gi//uVQe6ONCGXjMIc4LF65Yx8?=
 =?us-ascii?Q?EYsMnTwmYToKsuPLIS0FVzkq+xcqHi+aNmCbjB9U7p5x9oVZ4zFcNNrpoN+T?=
 =?us-ascii?Q?3A8SWOE2hOKIityDXZJnhtTaUHnHSADegI3Y+7ZzLTuTt9G10q58HoByy6/f?=
 =?us-ascii?Q?hC3lQ245ZXGg9s1lfj1JtkA7E8Kr4rIQpqLBv3/rfbiJDzm5eu2XTRPBgLbw?=
 =?us-ascii?Q?wyzbqxeUa6CwO2zpC+w0ouoyDBJI4hNaHdGWpZLNHoluXChuqm6UnFatfqWr?=
 =?us-ascii?Q?qtjFnywyxMuUFFigmJOpSgFt0WePNvojyBIElqoZyWXPoNgR8IMps7/qGtVe?=
 =?us-ascii?Q?57WNiiDCYvkVgS5lHz+HyNnso1OlpwBtoWyL6/5UPb0QYjeq7q99l/NZ0+vF?=
 =?us-ascii?Q?JjW+pguEuuS+dze/1Cc5Ftf4SIhnMnMJTQL1povml5wTd2LYbuDV31CkA+7G?=
 =?us-ascii?Q?t+zpOl4taLTPefIEPdHrUIIqzCEuLVP/J7qL6rLIMZ6WbwiBnR4A71JeheS2?=
 =?us-ascii?Q?a9DXrTSldw24lFPG892bxq9R/cl4bBWZ8QzDvXnn3GhO+HshJZ2DM7/kUkTi?=
 =?us-ascii?Q?waJdjcVTX9VYpN2OtBzIr9944EMCvsqAulIs6twYQ5XBtb+XsYfWIKR+4QQ7?=
 =?us-ascii?Q?1YTxJjh6e6bXzTU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 16:39:19.3211
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b13da256-9f65-4880-4245-08dd44714e69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F43.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

Hi,

Based on discussion done long time ago
https://lore.kernel.org/all/5353872c-56a3-98f9-7f22-ec1f6c2ccdc8@linaro.org/
it is better to deprecate firmware contants which are not used in any code
and it's only purpose is to use macros in dt files.

There is no reason to be the part of dt bindings but it should be kept
there with adding deprecated warning.

I want to see if this is the right way to go. If yes, I will also do the
same changes in other headers which contain only constans which are not
used in any code.

Thanks,
Michal


Michal Simek (2):
  arm64: zynqmp: Use DT header for firmware constants
  dt-bindings: xilinx: Deprecate header with firmware constants

 .../bindings/ata/ceva,ahci-1v84.yaml          |   4 +-
 .../dma/xilinx/xlnx,zynqmp-dma-1.0.yaml       |   3 +-
 .../bindings/iio/adc/xlnx,zynqmp-ams.yaml     |   3 +-
 .../devicetree/bindings/net/cdns,macb.yaml    |   7 +-
 .../bindings/spi/spi-zynqmp-qspi.yaml         |   3 +-
 .../devicetree/bindings/usb/dwc3-xilinx.yaml  |   3 +-
 arch/arm64/boot/dts/xilinx/xlnx-zynqmp-clk.h  | 126 ++++++++++++++++++
 .../arm64/boot/dts/xilinx/zynqmp-clk-ccf.dtsi |   2 +-
 include/dt-bindings/clock/xlnx-zynqmp-clk.h   |   7 +
 9 files changed, 142 insertions(+), 16 deletions(-)
 create mode 100644 arch/arm64/boot/dts/xilinx/xlnx-zynqmp-clk.h

-- 
2.43.0


