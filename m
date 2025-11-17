Return-Path: <dmaengine+bounces-7184-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 627EFC620A8
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 02:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6BC4A35D9DB
	for <lists+dmaengine@lfdr.de>; Mon, 17 Nov 2025 01:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF4A23ABB0;
	Mon, 17 Nov 2025 01:59:52 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022097.outbound.protection.outlook.com [52.101.126.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC2F1FA272;
	Mon, 17 Nov 2025 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763344792; cv=fail; b=nmHptXz1cAM9iztiPQwlwKOLpRbjnh7HTDeu827iH1k2CVdg7WYjFTma800uI0U/wqY4tgh4oMclicB5RfHMe3EgY7Lrj55CXYCG7a20WQ5nAZNKkRobSXsidFa5BUZBVOxmYAqCyns/l5+7vxErqAYSShGjOlLLJh+Vw4lBi5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763344792; c=relaxed/simple;
	bh=4iJmhO9rtjxtaVbnlKp6CC6mizQyz2vmxFeOXwolYLw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=YHNvd3oY9ZeUk4cVKvDMsWmrJ0v4xeIctMzv4IGuhLu0L7T/Fy1zSsiN9cn0+iI+arQAT6V0QrF03YKXKXCO6WzWFup55P8+RLjwqZ4xB1P0/ENax8cYyd/Na97NO91g3e4rUEihN0VIeVYeYFo3y3MfqU7zARMThE6uHbztIMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com; spf=pass smtp.mailfrom=cixtech.com; arc=fail smtp.client-ip=52.101.126.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PC989Sh1wnnGbw2sExVDAL7GO6vEkxJQhF9UK1AwMiq/7q5ZJohRTMVs1X2yMdffN39Z04bSs/hDh9qNIpH0OCsajcpnxoaDdGDL1kN63YAwCE23ukRXNdWHZMhVnIjnj6Nne0K576h3B6ibJeNaB4K9NJKnUw2ZJEJ7guglCJXZdg07pQKqVmZHuHYPkS/IfWAPMiDzoBsjXmhzKkwNKM5SXMF0f9Zc390z3Y1dYDe64WWLnEuXzVvP/VRNXTqdqS57YfGfq8WVHTgPKlusmTefePs+QdSq0/+wOOR3nisoG0nL7H3wzdMyCCbotU+txJhJrIltMZqFzIiODkaFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0Jnp8Tew0Wm2+7Bj11kGT0P+edv2iluYdvTgz7Jr88=;
 b=mV8ixYfs/y8b6d2XMLaJvrtc3707HTIeE3X9fJan4kASomx+u7fPaC6W81AMnXB8PY8Ly3CynRiwENfqR2liiWG6OZzlXNGeV0Q/uoSSFU4NQ5NEDX4P15X7fuU1kBXx24FP8sgPZpk+AyLByqvQb9LnJpGwjl72hNU3qIHeNqWFxqMOSccseQoBOxuLNtQwFEJOM30i6FjdUHOuh1G+DOXaIzCDkm9d+Qw58laPlNIJ3hVidFRSZRQleEhyauJ51ZjQmapaYDxOuZtxEU86pzmAfpaDJW1xmqeaWFwyHp/yAkNoL/H4py1znqwg4kal1WcTuFee91E43Mv9Ft3V1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 222.71.101.198) smtp.rcpttodomain=arm.com smtp.mailfrom=cixtech.com;
 dmarc=bestguesspass action=none header.from=cixtech.com; dkim=none (message
 not signed); arc=none (0)
Received: from SI1PR02CA0052.apcprd02.prod.outlook.com (2603:1096:4:1f5::20)
 by TYSPR06MB6469.apcprd06.prod.outlook.com (2603:1096:400:482::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 01:59:45 +0000
Received: from SG2PEPF000B66CD.apcprd03.prod.outlook.com
 (2603:1096:4:1f5:cafe::55) by SI1PR02CA0052.outlook.office365.com
 (2603:1096:4:1f5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.21 via Frontend Transport; Mon,
 17 Nov 2025 01:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 222.71.101.198)
 smtp.mailfrom=cixtech.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=cixtech.com;
Received-SPF: Pass (protection.outlook.com: domain of cixtech.com designates
 222.71.101.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=222.71.101.198; helo=smtprelay.cixcomputing.com; pr=C
Received: from smtprelay.cixcomputing.com (222.71.101.198) by
 SG2PEPF000B66CD.mail.protection.outlook.com (10.167.240.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 01:59:44 +0000
Received: from guoo-System-Product-Name.. (unknown [172.20.64.188])
	by smtprelay.cixcomputing.com (Postfix) with ESMTPSA id CDA9B41C0143;
	Mon, 17 Nov 2025 09:59:43 +0800 (CST)
From: Jun Guo <jun.guo@cixtech.com>
To: peter.chen@cixtech.com,
	fugang.duan@cixtech.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	vkoul@kernel.org,
	ychuang3@nuvoton.com,
	schung@nuvoton.com,
	robin.murphy@arm.com
Cc: dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cix-kernel-upstream@cixtech.com,
	linux-arm-kernel@lists.infradead.org,
	Jun Guo <jun.guo@cixtech.com>
Subject: [PATCH 0/3] dmaengine: arm-dma350: add support for shared interrupt mode
Date: Mon, 17 Nov 2025 09:59:40 +0800
Message-Id: <20251117015943.2858-1-jun.guo@cixtech.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66CD:EE_|TYSPR06MB6469:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c4f4b3e9-adf2-4a11-fb8a-08de257cfaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZFIYyULzhceYqGp1GSTscazmrRxb0KfxYqw8bMCO/5timJpJGNW3412qRm+b?=
 =?us-ascii?Q?I/N1KhY3bjY4u83uyGGJfb++DEKfgD3qs0Xbh6wmSa0/UpfswsYAz+vrGIpf?=
 =?us-ascii?Q?TNl3ShnNfYYC7mUUOIKXawI8BLVONN+8zmKctH9vVf+D0VyCcuztKIa3GdRi?=
 =?us-ascii?Q?JQFY4lVk8Uk83ZAqBmVOGS+0EW1LBYkepaZxDyvh2wdVLGXD8mJjCPv1CcZX?=
 =?us-ascii?Q?WYj/3ti86u1Jbhqv1z8KEBTP5gEl3SIXgYOljmp0si473RxSDOklnjwcpwXV?=
 =?us-ascii?Q?Mr+xaYIeIVzJccs54s+CeIL4h/pdBNNzRwJD5FH8ZJDF0b9v81LBBW4qU6kq?=
 =?us-ascii?Q?H3D68iDnYkcgnGvWoAgQT0NxAhTwVM2gdmFtf5urf6hRUdL7L2Mv8wMyA9Nd?=
 =?us-ascii?Q?k1nfCFxRGJBq3rdfa87Zzx+4KblEzOFkNIuReKDin7lwmw+o6N4pbjkCb++e?=
 =?us-ascii?Q?rIhGjGBOhjS6zVFMNwF0qS8cqynAO/f5LjWQ2JaT4igjBdHNda0lyjZ5Ir07?=
 =?us-ascii?Q?CmAJXQqV/i20fLCrRGZ401DYVDF/a4oZc+8OpTmTUYnxfo/NEHfFTZKCIXP7?=
 =?us-ascii?Q?xKS6375ks8+FVAK9I95Z8jl3U908SldvOkMQBBGhm0DT4RWWD9PBS1DCDvU3?=
 =?us-ascii?Q?6i/lcra0TopzcM/nogtiioh3rInaGR5H276XYksNLXoUZGmT5wjjVxvxHweM?=
 =?us-ascii?Q?MSaaBEOASym7Fm63o0hzdrZRpB+FHL1SsZ9GDaflGmdo7yHZMuJ+wz2OYLHZ?=
 =?us-ascii?Q?wygh90yF7OpbLZZR6B9iAyjPaQ5/fEUghjKMEjpU2suF3jNObIF7/2sO4d+X?=
 =?us-ascii?Q?ap7UhEnHTC6OnsuLl8Eyj5y069hEFRHr1Z45Qy+w9dSmizgcBfv30TovJD+G?=
 =?us-ascii?Q?f9IAV3nxwCgv2bTYWJhS8SSsC0LHHXIaf4MTbFsnGP2QLlX+mSeCjjEc8Ky0?=
 =?us-ascii?Q?7xWQbfIDqOsu9qoqB55QN4SoaUM7rhvMZEqy106XCp6d3EY6Dl80xmeC0giF?=
 =?us-ascii?Q?7PtaWOHspvn/qbLI/DKhNsbC8yvPj8SWpRep+wx9SZFpbYh8oJ3YIsFUHyse?=
 =?us-ascii?Q?XUATg5A1QDQGm85BepyBQKsO8onW2Hv6z4o5ReD1AhI8Re9iObAnMP1xVGqL?=
 =?us-ascii?Q?A14m5oSHvB5bDNH6ra2ZuU44F3kbBzDKdwyiwD0ZNmsZ4qhMNpv9kvLyITtX?=
 =?us-ascii?Q?/pioWuYtX/macCUA1lzeJLzh90lKk5n2c2U3IDA29YVY4gBLYe5TfiiaWrlW?=
 =?us-ascii?Q?D3YHLSqJght6hMIVeeKJgv3DaxdU4v5tVbRknFETsveGbvBt5nvyz8dstWs4?=
 =?us-ascii?Q?4TY1YUUz94wyIL+Ua6edITHcZIHmhAHgOOdhEsgVV6/6Jb3Wc2ZAvuReUFwb?=
 =?us-ascii?Q?Tx9JE+YljT5QDas32PLhZCmwfGEwxDolmfkvx06YhUN+oFHMJSJpEdz20nl2?=
 =?us-ascii?Q?eQzRvBSbvlDClbQh/cKr2Xjj7IyhRz8YbAEj4j6wDFpNdG8j+hIYUyA6snyB?=
 =?us-ascii?Q?Mqe8Qq0xLfeqcURayTfyP/vGYB6RmHGPs+bwJ/FBoPJFv2qTXqREOnvFdA7S?=
 =?us-ascii?Q?Ultjct+tJFqo3p399u0=3D?=
X-Forefront-Antispam-Report:
	CIP:222.71.101.198;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:smtprelay.cixcomputing.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1102;
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 01:59:44.7934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f4b3e9-adf2-4a11-fb8a-08de257cfaf2
X-MS-Exchange-CrossTenant-Id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0409f77a-e53d-4d23-943e-ccade7cb4811;Ip=[222.71.101.198];Helo=[smtprelay.cixcomputing.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66CD.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR06MB6469

The arm dma350 controller's hardware implementation varies: some
designs dedicate a separate interrupt line for each channel, while
others have all channels sharing a single interrupt.This patch adds
support for the hardware design where all DMA channels share a
single interrupt.

This series introduces the following enhancements for arm dma350
controller support on arm64 platforms:

Patch 1: Add a compatible string "cix,sky1-dma-350" for the cix
sky1 SoC.
Patch 2: Implement support for the shared interrupt design of the DMA
controller.
Patch 3: add DT nodes for DMA.

The patches have been tested on CIX SKY1 platform, the test steps are
as follows:
    % echo 2000 > /sys/module/dmatest/parameters/timeout
    % echo 1 > /sys/module/dmatest/parameters/iterations
    % echo " " > /sys/module/dmatest/parameters/channel
    % echo 1 > /sys/module/dmatest/parameters/run

Jun Guo (3):
  dt-bindings: dma: arm-dma350: update DT binding docs
  dma: arm-dma350: add support for shared interrupt mode
  arm64: dts: cix: add DT nodes for DMA

 .../devicetree/bindings/dma/arm,dma-350.yaml  |   6 +-
 arch/arm64/boot/dts/cix/sky1.dtsi             |   7 ++
 drivers/dma/arm-dma350.c                      | 115 ++++++++++++++++--
 3 files changed, 117 insertions(+), 11 deletions(-)

-- 
2.34.1


