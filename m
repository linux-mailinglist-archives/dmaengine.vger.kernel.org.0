Return-Path: <dmaengine+bounces-7351-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2880EC888F2
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 09:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 090C1355D9A
	for <lists+dmaengine@lfdr.de>; Wed, 26 Nov 2025 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A731D30CDA4;
	Wed, 26 Nov 2025 08:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="XhkV5307"
X-Original-To: dmaengine@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD53195E4;
	Wed, 26 Nov 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764144414; cv=fail; b=jLlVmbK8yVZAzF822xxn3cWPvVl26p6FVMtweENNY2Ck3lfg5yCrAQBT/LjeF/yhBwoagNbHzNQMsreAoghZUg7NRmOLKeuKrA2s879WQ91wpL/3sI0AAX4hTsge+eftyz2Jf4FPDPIObzSHRShBvMJQKEDHawXXYjnIKzlA6hs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764144414; c=relaxed/simple;
	bh=kzx+Dz4QQcJGgUmPCOGnC4UF8lFnVJNJlneGXN3oPQU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mUUJ/zALxN7gpt/3aJGaIY7ocIWKejYJNQN7i7Qd/BEN/L6+ZtaqcUtFdO4hOJJWUEdNZSDLwg8P78wzWZ8NHqEdk/vj4NLh6o73tUhARaYCr5EimHJ+lsbWGWjdFSFOsdZX3dsYUOUQ63710ZV8MpX0Sr0gAvaHZSA5Zvee6i4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=XhkV5307; arc=fail smtp.client-ip=52.101.193.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f+oGBhYoSOQHrnZh4THGruZzFyyLaYKD4FRXJbrTvIXXBqCo+/uHeFMJkBQQdPL6ozJyvv0qHVYcd08AraM7kpjU+HcQad0pYjBSfEeBuEaVf6rqm0+B4yrOUeRsYHaq2Yo3zCqoYIrnmATOmltx+JYH9MrkmceRxbZZmYNUvZ1N3Vey5LAp7AG+antPZfokWSofc+V4NXXtaDWmaJSe51n6nGCM5evf8tIcvcC2nHKeg/HEPHKA7SAvXow4eTHpe1pQopeFzAB9t3HNSDWSOHQF6B7sVdh9EQIQ5ogG0Jo/RQ0VG3ce9k8NgH+g1muz+t8Zv7GycfA1Mtz4rtnNJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3vlI5YqNHKd0caiGBZbrmZ2HeCX+dgPP1vQ160UNfJ8=;
 b=EAhjjdqsFniY12K2f47E1mv3PO5cEpG7BirXZ3jAGAYgEgRO6fAMbb3Oks1iAQcNlzbQ2/pUME/2AoymwqlCyek9VXuyl0m+v3RgUrhWLvczmk8GIxsO1kFmk+Ncv7a0+OhveJtrHhGyK1y8og3zAnwy+Yhn8N82IcZTvaz9sZBvTQnX57GUBAtVprMukiw+ntHj7aKhiOA2OtqrVHTQqtF0qFJ7fdtb+zCKaM0dlH9odVqtauqEl282/I/CteGCXfNmz+48ml5d8RZ9oeNKOyVzjS5wr1N2OjGW92Sf6IcVdTOaOaY3+L9ikGc1bfSAwAVMIZ5Av63WWkvCv+BV2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3vlI5YqNHKd0caiGBZbrmZ2HeCX+dgPP1vQ160UNfJ8=;
 b=XhkV5307I+6h5LTuNphC9KHDu1WRiMP68S1lJCKKMG4Ee2uXfYm/EtkehcuZQJ4PUIhqSIQwbDFGA68zD8N8O/msgFXVE9MXI5A2zfBKzAzRPDuDs+pZuxoBzWsm129zu3PMxyhoaDfIGWtWl+JtOrQY2dFQ4lEEZ+yNzsLg66HEvV1MTjD/PJdtQcBYSPkIzpP2MgMq6ayRq20iO6n/ckX9gY/6pzVIMaHCSS87qZAnV3jWh2IZYm4y0lUU/U1KxHshVM1DCf2VCYIxKT3BvqgnykEtNjYGCJIyks3vua5jh0xvZalmd11Tx8XySVOYXoIp1hTD8WThObYFyXkTEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from MN2PR03MB4927.namprd03.prod.outlook.com (2603:10b6:208:1a8::8)
 by SJ0PR03MB6581.namprd03.prod.outlook.com (2603:10b6:a03:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 08:06:50 +0000
Received: from MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419]) by MN2PR03MB4927.namprd03.prod.outlook.com
 ([fe80::bfcb:80f5:254c:c419%5]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:06:50 +0000
From: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
To: Dinh Nguyen <dinguyen@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Niravkumar L Rabara <niravkumar.l.rabara@intel.com>,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Khairul Anuar Romli <khairul.anuar.romli@altera.com>
Subject: [PATCH 3/3] arm64: dts: socfpga: agilex5: Add dma-coherent property
Date: Wed, 26 Nov 2025 16:06:24 +0800
Message-ID: <4517536b397e5c63cac287174fad167a29b2173c.1764143105.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1764143105.git.khairul.anuar.romli@altera.com>
References: <cover.1764143105.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0202.namprd05.prod.outlook.com
 (2603:10b6:a03:330::27) To MN2PR03MB4927.namprd03.prod.outlook.com
 (2603:10b6:208:1a8::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR03MB4927:EE_|SJ0PR03MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: f6d36bfa-ed75-4e47-0bb2-08de2cc2c08c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?M7WjAS/F2CLBLctmdIF5GRZwhr8665zTUEMBYAV6+q6NXGtBMDyjxhl5YPZh?=
 =?us-ascii?Q?cBqsPQ5+DC0AMJ/hjENubVIJnjLe4HkRsXfU7nRlWiumorRoxjbQI82YkQWt?=
 =?us-ascii?Q?Kuz2K3KSQnlj5w6DgYnaGBjo0fBnkwRjgrZD2igDQMA+9Os/LDcOkAj9oZ1b?=
 =?us-ascii?Q?nxDvoVN7VhaNrlzMmlIWhd2PxRbHeYME3KOcKyIHplHb8SlIZnlBDfKMSGO7?=
 =?us-ascii?Q?X3E9EaiOkh/JWy6tX4zrIHPaHwc4n4hUftzfHmrluk3tr6Cd5s4yWRc1Qdsc?=
 =?us-ascii?Q?ljO08tTEX+BqJ+prW1/S73Vu7z4PIqbay4zYQeK+7momCKXovmpPvpsOGNaU?=
 =?us-ascii?Q?tdxhpPGsWBdluEIj4skKvFuiylhFK8nKjEknIDq4koy3o/R7PcSi9YmMoKQm?=
 =?us-ascii?Q?0llJxaZxRSPHchNT6Fqb3BHKNsmhMK8vYzCi24K+SXbUDy/AWiKqHkc+/5N3?=
 =?us-ascii?Q?KH9YbuCanQAxjTRlnTQorlRXWOa0IN2zKBYzACzNT8yN7f8fYNRH1bTgEJGr?=
 =?us-ascii?Q?fL5DMQmmfVjHKuYO7DqzWIKoOqJl08Z0b2IIUyTQY7ppdfkXlK5qxmkFIM6d?=
 =?us-ascii?Q?z+uGSpWAzW/AoAtUvsYh3iASgWOt4Ro7B5dXDAQtZ86V2BEOTBRQIw4O+itL?=
 =?us-ascii?Q?Ly/mOkEu+04hD7t57elsmL66UUCmUTejCA9nVL8jdPcads9kKmUva2JZCxAw?=
 =?us-ascii?Q?vT9wH/okf7K8CJ6CfQd3cjJLRck8lunw5zHRuGKJ0UroldGekvgqr9GSJgAS?=
 =?us-ascii?Q?1bpovSVb6811dDen/LrS+T5zrNuZbgpz+MEt7y9NV2fz2fOW9WPHo8n07A9G?=
 =?us-ascii?Q?uRK/h/2NmtEQJiBBM0j72pvbG8DWcxWJRJSOdJnV82k+2nOlzBn280/jUtg3?=
 =?us-ascii?Q?gV7Im6uESdVusjDiT+E4u7r8yoVoMURlLzySeaiABW3oHHwYQqUsrlG3HNdP?=
 =?us-ascii?Q?8Ay3qVb/aTbYEi1aa73YJAcuX8RuC7srZDiLq48M2XFvNM145mHQ2iVmNQSX?=
 =?us-ascii?Q?4IntziyGSZY08XkJqp8hXj8FXHpqqBWZKD4BI3gNsCY1sKDuuAeJMbZu8fNA?=
 =?us-ascii?Q?4MCgxfeKH9py2sEQMc8A35CRboh8RM0Y7y+AZa2JyV6nC8UHYN96Eot/y4e3?=
 =?us-ascii?Q?5ffkmOW3eN6nDii8zKyTBHEOGtwOgH4E/hAZixPKAsWSv0+y9Ehyh607bq07?=
 =?us-ascii?Q?iAFuypb4WEMavXRxEEI5hHzt0V1JdnL72QHA8kmx78Pst4gt2HbrkkQcmiZt?=
 =?us-ascii?Q?ZYmti+oG6Jsu/xg1K3LpOTz/DPhx+P9IO9y/C8jrhuCRnjMAegqzmrScescM?=
 =?us-ascii?Q?y3+WVjJFhdMJWIjumJOrQjZ9g2X91Ag89oGDtlreIAarHSt47CiKANPe1zpb?=
 =?us-ascii?Q?p+SDiJCC0mhjvdnHonzb4dRCVQa8sNA8dWWk0Im6jJeIx3XlEyyrVAiLOSIQ?=
 =?us-ascii?Q?oCQC/K/72nKXNyWvzzsLMnQ1qDmsheU/U1rM2rm+UO/4MKRq5md9YI88aCqh?=
 =?us-ascii?Q?qeydwG13duf1jws=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR03MB4927.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uZw4tKijFNMHORYEARoslQ6xQMiEH7syBy06pvvS3yZBxsEjicR9mqx3AGO7?=
 =?us-ascii?Q?nExt16J9Iz0V2qcVQ2VWPAI4mi1Zm6Tcy1nJ4DPXLIyu4QErAZ5BrSUZbOdR?=
 =?us-ascii?Q?yGnOOsyRvPnKlL74UI+UhpedC33rvTWn3MZDZP8ppQpRzyGWlwC276qhRzWV?=
 =?us-ascii?Q?rm+F60cK/oeSUXmj4sfLIBFqnOuZtbHX6YXBHMhQBi71uA4lx/QT0AJhN1ht?=
 =?us-ascii?Q?sv3vV3OkHnNIjftYjr27/mCCrrZMuxe+zel4jsuX5BZaeFF/3YdCCNs/lZs/?=
 =?us-ascii?Q?Va4qcYtV7qIKhTw0cL/p67IsCP9xcKErhAeoy7dgjp9n0YLz3a34LHJt+wv5?=
 =?us-ascii?Q?c6vbKxS1zjeXmhGErBxW/Ta15E/iElS4V0pLYgkSKy1hoXHfyg0atXNqPIXk?=
 =?us-ascii?Q?q5wRUfmObtah9LLrWB6yRCDRrReiwxzhknkVgj/sk+270S18QVtseeB5LJuV?=
 =?us-ascii?Q?l71aLzsTuAC2R0VLQyjUTFGhEPaDZciBDJA8qJ8oHAEPvnlCsOf46347YsGa?=
 =?us-ascii?Q?rwH+2PMgMKcEg10PA1tVl7SKtEFs/W/tFj7uG5iLUHR6lcPM5fqe/nOa2UdV?=
 =?us-ascii?Q?aKruL86tX/mpbITimbH/3MJdgy4JQfSUlhFi2JLcN/wKFeERJNL4Old0723n?=
 =?us-ascii?Q?0nEyj8XUgf8qzbyPk+fxHkeRxuDQbpT4SaOmGA4mCmYBgQTMBUWwAzK5na5B?=
 =?us-ascii?Q?m53TnAEyxSW/MmZzmXUSWokC1xHaB4mOZdnkGih7nEnn58mBtSJbhpMrowiD?=
 =?us-ascii?Q?X1945QDjr/E3omqvzYap9gH2FrB+SKfugpjLrPS2T6aUiDxUmI4+TwR5fwMk?=
 =?us-ascii?Q?Kj2cg8i9Aa9FJha372Go7oJUxtx9D1SMgda0oEQyio67vFcep4Wjo1NgQB+t?=
 =?us-ascii?Q?3QpDQhyYp+ZdNQaeUWALaYWculZ8SgwE5Pgmt2CIKZkX+agNPy82chcKPfWl?=
 =?us-ascii?Q?Ovh4VmvxEYXFlGXh7YVKP+0XC1s0kWw6gKu/6YPjUWz/XyEeQCPULOv72HGu?=
 =?us-ascii?Q?2fUeS5tFGu9YSJpG1IzPfpzTKA9pQOp2/zdHd/JPZ17Xe4e0ZQYRkVKu5Qlg?=
 =?us-ascii?Q?Sut59cdGC+cFG/Q3ez/BUlkvZ7Rmwe2/MLvH1YjUIcXJxAQ5BovV6KTLYZqY?=
 =?us-ascii?Q?+5YSpejVjeoa8S2onxZGBM3BYmOYoE55lNA4WwLJ8PDem6kQsfpqEj9Yjq0F?=
 =?us-ascii?Q?ApAiS3lA8DjMvnDuq7k3V2QBgx8tp9VvE+XRceanZqs6nX2vQz38KYcZp/8y?=
 =?us-ascii?Q?6mYkdj4RQzMa/Z7xEGf4aIeUjf/7Z15cpZwTxc/56OB7mRvCQ+sN0yPNd6RY?=
 =?us-ascii?Q?E836hHj20g7d8ADMjqhatlKTrMIcOlHggKDYeMacqPbcOHf+wuDPG0mq8ipQ?=
 =?us-ascii?Q?9HTFxqMRdkrhuQONZNcEi93SMvffhNFGSez8NCGqEf6TxXjC/ThtGrK/ug3I?=
 =?us-ascii?Q?OV8S75yg+ikZ5GYlFcO/jkaPUf2dtnpJYYuBz1nWvee9obIUuygjV0qAzsLd?=
 =?us-ascii?Q?/VxC52ETXR5CoZDAelos7NYFJ+5WnwBC08anJ57heMHti8fVkBaz23KrPJ9U?=
 =?us-ascii?Q?8F8IDLhrK2Hfjjzq9KIdvy+ceh05CSdbO3J9WFxytWUKyyArJdr3Wl29lxDN?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6d36bfa-ed75-4e47-0bb2-08de2cc2c08c
X-MS-Exchange-CrossTenant-AuthSource: MN2PR03MB4927.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:06:50.1876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e7yJyB9yUjPWAPhXDX/BJg7mDSibQVATWpmwAB/KW5Cd3u6VWzWsrSdj7ke1DYWPYJGyTb2fsA8vtZwjuAYIBtctp/sBWUv0b779fCQFOAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6581

Add the `dma-coherent` property to these device nodes to inform the
kernel and DMA subsystem that the devices support hardware-managed
cache coherence.

Changes:
 - Add `dma-coherent` to `cdns,hp-nfc`
 - Add `dma-coherent` to both `snps,axi-dma-1.01a` instances
   (dmac0, dmac1)

This aligns the Agilex5 device tree with the coherent DMA-capable
devices accordingly.

Signed-off-by: Khairul Anuar Romli <khairul.anuar.romli@altera.com>
---
 arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 1f5d560f97b2..d6a2fe445fa6 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -324,6 +324,7 @@ nand: nand-controller@10b80000 {
 			clock-names = "nf_clk";
 			cdns,board-delay-ps = <4830>;
 			iommus = <&smmu 4>;
+			dma-coherent;
 			status = "disabled";
 		};
 
@@ -351,6 +352,7 @@ dmac0: dma-controller@10db0000 {
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
 			iommus = <&smmu 8>;
+			dma-coherent;
 		};
 
 		dmac1: dma-controller@10dc0000 {
@@ -369,6 +371,7 @@ dmac1: dma-controller@10dc0000 {
 			snps,priority = <0 1 2 3>;
 			snps,axi-max-burst-len = <8>;
 			iommus = <&smmu 9>;
+			dma-coherent;
 		};
 
 		rst: rstmgr@10d11000 {
-- 
2.43.7


