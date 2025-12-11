Return-Path: <dmaengine+bounces-7566-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1033CB4B01
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 05:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 289E430173B1
	for <lists+dmaengine@lfdr.de>; Thu, 11 Dec 2025 04:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38AC27FB12;
	Thu, 11 Dec 2025 04:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b="MJJALsZ/"
X-Original-To: dmaengine@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010019.outbound.protection.outlook.com [52.101.61.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34FA271A94;
	Thu, 11 Dec 2025 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765428054; cv=fail; b=T2Ht55JPoRKsOcUwfUkeSlbVBshAsFvaZ1T3rcdACNIB/q4pHiLnpQdqXQE1W7tmrhZNyfqzEsZ0Vj3ooUEBxI7PHBKf47I3Dn4831O6sWGVn7fkq5SFF8K960BZLUKNAxc6RIFWfwCqtIN4r+KJ6PHepwjQszW8IAFGLPKks6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765428054; c=relaxed/simple;
	bh=/9Vo+AGApO7DqiCCoq/Ha3/VzsEXprbZTNzSt/GZFhU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AV2FbG9OR5b8EnN4+V9HfHGbdMCSZs0xVpczCR6uUD8wwhXaqvN76xX0v01us/7pr/N6sPMiySznYiVane6TK6HBEE5vlpmgKUkJ+kTLeEVF0HlMFqbuSV/TkoB7QvqgOxEqP50ENVWm/yLRnt68F4Otcseb+EGjDCwqJfxYvJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=MJJALsZ/; arc=fail smtp.client-ip=52.101.61.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yaC/wwmGzG14fDwsONhiPM9yVE4F3BkI1TvCznb9Zz0SVABnHWAIQhfJww7Nk8r8TgLSIrIbGpQ0pZLl+ORKzPPOyZ0kYLZBG1W/6rVxOcgrJ1cB7OI8fSU/Vcd2CBxZvUOJOsF0KdIpvq1FzHVf7jMQ/BYQeoPgbN27EAzm0YYSEl8bmziKMEpIiDAJ8NBqrEKaFqaPuoWFybvNDWAMao0q3Da+CYxLWwWdGYGqOUMUyot6SBNzYk/wjZTk1KOUHBCcjwVhdG/q5NelOy6TKEbE8veuZ/X5lQmDyEnTNBWf/YmHBKO073EnbiO0LhKBq5gyjxC8gShFPvrLOERiZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TzC3FBkKxVU3/3rLR8AGPTEgyIa12IYdOFR+nKRE2Wg=;
 b=DQGbyfwj9SCzAJIeHbCG2UPYcFsKR/1PaueRAPkuxTiV1tAfFTy98u6Y6Gjt6kIzznih1xUWZ+bBVmzzzWcSi3eIUvUxOoGQVt3bgBXkVAeXbtQhhL3spu++XcXeL9MWFHJKMtUww7Zck3D/6xCoD+3KhUtUiLbQFLhH5FlZNys8ct3a3MQQ3LzlB0iBTRYXi+JQlASPRw9J/DtLMyjELpLzTovySoo4PG78lhAD6J0K1sR97dimWVv+T3JhGp5dI4+OIvch13ptXc45/YTPQ2wCFFfqRorkPNGIwC4SLUgbrq9AzYjH13y8VdQMJR+98rGFicn/sDZlaZR6NsOMHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TzC3FBkKxVU3/3rLR8AGPTEgyIa12IYdOFR+nKRE2Wg=;
 b=MJJALsZ/m4EsJZV7PMvuGPrIkrUgnwdOcaTXic09SH++cbCTJiLIlsGF2ykxP/G4d35DT/eznROFyHdCzSoSpmClv9skV1/iaKLI82cnlD4rb/LcFi3895l2R4ARcWRY5twS0mNBsfX7v0g6n20RVL/ekyu14PVMlJcBoWzWOuKV/mcm//1QfBu8k6QtYxQHPZ61YbnNGR5pPrmTRcf7ixcdyb+bzVAil2gOLZStplNJ4sLEZO+sv9QSB9MbEP6xu1KyXsP94d37DM4DhoRwmTWgzHMLltBhmGLs0Al/mmBKqQX3doPPUdMa/6wgfuR+vqaBxDw1CC6SfJIQ3lsU5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS4PR03MB8447.namprd03.prod.outlook.com (2603:10b6:8:322::12)
 by DM6PR03MB5308.namprd03.prod.outlook.com (2603:10b6:5:242::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.15; Thu, 11 Dec
 2025 04:40:51 +0000
Received: from DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a]) by DS4PR03MB8447.namprd03.prod.outlook.com
 ([fe80::4682:710e:536c:360a%2]) with mapi id 15.20.9388.013; Thu, 11 Dec 2025
 04:40:51 +0000
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
Subject: [PATCH v3 2/3] arm64: dts: intel: agilex5: Add simple-bus node on top of dma controller node
Date: Thu, 11 Dec 2025 12:40:37 +0800
Message-ID: <807b496fed7a7b97327180c3895e9b741fac7915.1765425415.git.khairul.anuar.romli@altera.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <cover.1765425415.git.khairul.anuar.romli@altera.com>
References: <cover.1765425415.git.khairul.anuar.romli@altera.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0060.namprd17.prod.outlook.com
 (2603:10b6:a03:167::37) To DS4PR03MB8447.namprd03.prod.outlook.com
 (2603:10b6:8:322::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR03MB8447:EE_|DM6PR03MB5308:EE_
X-MS-Office365-Filtering-Correlation-Id: 180ffd65-b648-49bb-016f-08de386f7662
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4RW52zs2Hf0u2xSVXf3FzAy19zx5a/U73cs+Hogm0ulszv8ybMutAfd9K1Lt?=
 =?us-ascii?Q?3LysCJAVrCGNkFprPdm0hmWIo/6GL5+ZQHpFYysiLyd0NfJkk+sg+SkEbgPq?=
 =?us-ascii?Q?z4kbRsD1bMyu8vjNJa0WYkwIl9AnhD/4aO4mM6b7fju08xXZlOqkBrZHpX43?=
 =?us-ascii?Q?etw8tEFwBjrnwju9mRXuGkj7szszzIyn0cKB5JvbamsXSAhY/H/KOQS+R1zN?=
 =?us-ascii?Q?YfP+pudv2yeWhMPJgvs/vXy4JQcDF7gMQhc9ekEdFcBNUVTaPfnWqohR2T+g?=
 =?us-ascii?Q?FCmK6963XLmoquU2IXT/Kjrlz7WEE9LMBoT5FX7FEsUl06eYn6Ii0NwRFcos?=
 =?us-ascii?Q?ckpCVZegbm/dn3d3HdRB7DSZeSsCj2ioTXGA3C5UDolnv6lHyXsGUdAsYEDW?=
 =?us-ascii?Q?dBlyxlJQoxijg+lpmkeVvs/hsMPjJquyiDfTp4kOesjV+plajtT0Wrg8RAGi?=
 =?us-ascii?Q?w8VpmzPJC8v5RmSh7COTFK1ADhEV7O8n6OOcthXC/cv0mQXt/KZCeEN2yKkT?=
 =?us-ascii?Q?3R2YxXN2krZ+WLOSbi4E3LcgrCHzlEN8QR5JjChkvvDPdSs0Ag6/ZkOiN/M6?=
 =?us-ascii?Q?Og5FUW8Gj+KBB7C4Q7uG7D6u3rJOfLcSABqb32t2/yt8gJW4IPiH19Fs0Jzf?=
 =?us-ascii?Q?iOsVcfbPRZ/tprvNdTlbYt/7zkzsQXI95HkcX9qpH9nuKrhYJVai+jeALOC1?=
 =?us-ascii?Q?RllOP9EuVE5QQMWjX7+sMmEJZpLCvXwapNChfm5asp/atPxNEwhtcyJzGeol?=
 =?us-ascii?Q?kE6G0kdgaEgb06R/4cbYp3hMe+M4K8DgYlwY+qJmZ+jOkskMFGL8HuMF8Eod?=
 =?us-ascii?Q?0YWqF/t8Y7dNdihzJbmPwC8K67/9bE1+m3wdoT6WPJBkM4Y1XTvHO5q4kH5A?=
 =?us-ascii?Q?ZsRFT3yriCQAN1gMykg+Qw7IZ9gq219HlK8DrXQyXeTTpJYZmDK/AAUW5myD?=
 =?us-ascii?Q?QrpM6IUpAvSc2EuMpO/PWV4b0M1IdLl1R7Hvrv2iy6APA36jxtbY9aK9BYic?=
 =?us-ascii?Q?C3DPVAp+pkfqnPv8YWYz7KFVymmPagT+HQQKhy5bL+KCAV8eiFxAvHYhmV7v?=
 =?us-ascii?Q?7aDAn/RH8J7URZ/VywYncTArmq+WSlMe5q8FMwUrOnErv2iLW49cGlQcXT9q?=
 =?us-ascii?Q?+mJ/4KyUVtsVGKT5z19hFB51k22zEkQaaHHA4fpWyV9/kDDjGMfuKPrdcejK?=
 =?us-ascii?Q?sQ6+5txLaOMTWIlEepZn1xcXIJupZd6gVHuz+K+aD46F0WmFnfg3dOk2Xr1I?=
 =?us-ascii?Q?xoNpcPj0w+NEpa8wdna02MazzrNoMdmoSJ8jc8RTaqLLAH6uJ78ZT44d18gI?=
 =?us-ascii?Q?imU2ogYSRUmUXyTKqlmsXm+u8/iZlyXEFVy3QOMFZIMqhZtqCceqhfjyKre/?=
 =?us-ascii?Q?A1i9bzn1LjrTMhVJwZcftI9XXUqwjgT3PjqS0bPZPp9/SmiuaFSsEVnoPiWY?=
 =?us-ascii?Q?Yx0ZYddXGKAYvDdJ4NcMWv201FSXHIAPEU8KKWoAcmm7f77r4q6jUWVI/bjs?=
 =?us-ascii?Q?jyLWkFqkwiL4eVE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PR03MB8447.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RDIUiu19cMVUNr31VmOX3pJc4b322RqHbWxAKqfmdm+nNDsBfbOv90VuYzSB?=
 =?us-ascii?Q?qyZQPVITJakZQFgs4LWfKFvl4shB5HWzrp/qExc0C8lZS249evjhJ9JQmRff?=
 =?us-ascii?Q?5ApOJj5fFtXj4jAvk83vyP537mZAHQMN8ONdYRDq6PpLNkczlo/KMXapjwLr?=
 =?us-ascii?Q?+LcbUlLWEZ+ww2zO3iC9vM5PAnRVN+Dr0PpCkOSiWe7B6Q4np6MSCHbBiWOn?=
 =?us-ascii?Q?B/b/ArJLKS2mINiW9NfA5/KnRFhNlQrX9RNOYwdDJ095CLhFoDelQDzxxWW+?=
 =?us-ascii?Q?XmAhutrp6pXTtvYSa4aW4/NXJizJYYf78quiMDKQXUfL2cgtVr09cAZB1JVJ?=
 =?us-ascii?Q?eD0mdVvhp5pcsd9zbkjIcHOoREv5X6OYeftLi9y7spgUsqzkcrARo/CvkUD/?=
 =?us-ascii?Q?hB9AC708ILG7h9TQA7B+AF7L39RLkp5eIixE/EMVSyJc8EdhWnX8X4I/fryd?=
 =?us-ascii?Q?nmm/8eYG21Y2cGLWGkMoJXLo7hg3j6IdFEAUepvFv6egL/ConHIpvHe9elzS?=
 =?us-ascii?Q?ZL8/W8qMDL4theDNkybmJSFX9i7Xs/5+nALh9nEjR5oJrPsl809OB/xY9+5o?=
 =?us-ascii?Q?Qho6oyAZtzEXoAPWFMy/TruG3VZGc5fjLkELYs+bumn2dYIS7NZ4WUNOb9+f?=
 =?us-ascii?Q?yvztQa4GQ27ZnKv0MMHhUO+84JFn+YeZd2yQ65fj+GNqItjrvU4oVJyy8tLi?=
 =?us-ascii?Q?X/fNziSjBe2XpTW+oicKgWRIj69EMrXtk9tMRFfmvuJgkKYzTe5Tqzt/4y92?=
 =?us-ascii?Q?53SRT4I6N8dBMHeB1m5FwUoJFd1/uwqgXabZPCXCPcR9dg+rENN50OREoJiH?=
 =?us-ascii?Q?vfM572YmOwgOVdt3S70fVZ2uLJJkzYoQZRbcN3wbEtwqdcMniQ6mLkKRyc5S?=
 =?us-ascii?Q?ToTu3RKjAQRmqpdgkr4y2dRNr+0dEf6px2KVOs9kKD8cWpkCarqd4m9cF4Mw?=
 =?us-ascii?Q?n5IiGxWt2ERoIguGAVueogKh8CfviQcGXP5vhdhCM+drYCuDQqro47jf9Lhc?=
 =?us-ascii?Q?AjgHYZnIGN+RoHbd6npbZ064rIv4aIZE5Q4Tm+GG/KSDmgWm0M1dJRsC9PSl?=
 =?us-ascii?Q?ylu+/uaEzbD/3g9PknfWIQrfIVQODr+/DsWxjIgQdGXBnLR6TvTjego1xU9T?=
 =?us-ascii?Q?pmSEXdZScmXkYDC4bgaItDnG/+9f2h6fufpvgm67Mc/Vx1AswW8i2Yt89d5z?=
 =?us-ascii?Q?zIF6GZFs2/ab71IqD15DSWfREV4efo7o4s95HCGy6tNU1+vwejY2CfpZ2lbJ?=
 =?us-ascii?Q?5UewDQIZoNmbBqCrlj7FHuCoTfKKhfUObBNkoLVeP/2G4NQtAoJq9YxPGoPl?=
 =?us-ascii?Q?Mr+z/sWQ4EvrXbTmtp/vdKwfr3bYIO5+zC1GpcsLx1WfMbzYxyfDKS1AFU79?=
 =?us-ascii?Q?2HPXc1R96pKGaB1f/6w0JKpILlfE26OrrXqSsMqoL+LEIlPZdS8BKl7zfSif?=
 =?us-ascii?Q?GCKy9BJ26pWNCL4xN5JrQh6PUqB8MtkRf0/YoM1QXh+N188XzLTGBKMYJ9j6?=
 =?us-ascii?Q?OXibWdLHidQ8Cu7Rv0vYcKh5zOFeqBL0UDTU6M+tjnwlHnnS/d/fTK9Qqxao?=
 =?us-ascii?Q?RacZyici+3WH0vDFAm7uKPXtFGXTZaYE9S+sLaUtO4UMPC8mPeKp+D+1Rzvr?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180ffd65-b648-49bb-016f-08de386f7662
X-MS-Exchange-CrossTenant-AuthSource: DS4PR03MB8447.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 04:40:51.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QC4VIgvIL4GUs+6KveTy1lRNSP3cwnSifUuCNEK1X7SOTRsCv4Lgb5pqVT66RlMC1fudJx//W/3uNUQ682cejzpTnqX/mERe5BF1Jn7qoFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5308

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
 .../arm64/boot/dts/intel/socfpga_agilex5.dtsi | 78 +++++++++++--------
 1 file changed, 44 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
index 06f98667499b..bffd914cf051 100644
--- a/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
+++ b/arch/arm64/boot/dts/intel/socfpga_agilex5.dtsi
@@ -335,40 +335,50 @@ ocram: sram@0 {
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
-		};
-
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
+
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


