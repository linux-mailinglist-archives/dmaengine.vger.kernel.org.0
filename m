Return-Path: <dmaengine+bounces-8919-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0q+KNwGnlGkRGQIAu9opvQ
	(envelope-from <dmaengine+bounces-8919-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:36:01 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8E714EA00
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 18:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC8A301ABAE
	for <lists+dmaengine@lfdr.de>; Tue, 17 Feb 2026 17:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0170436EA96;
	Tue, 17 Feb 2026 17:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ob1muG77"
X-Original-To: dmaengine@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DD27F18F;
	Tue, 17 Feb 2026 17:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771349758; cv=fail; b=hJtDT4mEsgFjVWSZ/PBAyacB2oz6NNjL1zPpUhML7msVF7B67U9hszsy09b7K0uMBnYYTBkunE0cCoCRDZ8Q77dqvQ7hmbM372ITNd5vkAWn/FsOdl1Ydq4Ah2i53teczRJFj7ZaElafEbq0LlWWELbH8SBH445psXdhosiVrlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771349758; c=relaxed/simple;
	bh=ylxuwekHkGY5mtnrhu30KeJ49FGGRnOXbcRoMINpnhQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qj2gwugNiYbe4nQBVjCxQSC5t9mhLxHnIv7BnK8UiDiUvh0VjE45PdbzqOlSJ1ADHNs2oNmUITz3qrPj3sFCnl7gYjGn/IbWoMLmRhUQP6qvoSN4Uj4sQ+wg6mCbEIQYvMOUDBfkNUE5PSsyB+UHinjNEW/ivOgcndA1993Jomo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ob1muG77; arc=fail smtp.client-ip=52.101.48.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ULYaNuWA+seC9r4668cwywF0H7w1CBMrf+57DaI9SvR9RYzHA8A5SIuNXWlngXEilxqvdOc9FDggT5Qjuhj1sSnCs940EMN2kGk1ymhzKduDiB7O59GDjbLc5O+6PtVgZTwtH+icg2qw9e0aNpoIuTN1gbU3s0nMjTSnHtXME7UUeOe6HuPcqjZMS+kNHxNTisBa+LI/kUknoak4vSf1Sxbkn6uhSNm9n7a1+mQfxzeaKmNZx1HGRV9Yr92TncHI4Z7ymbqxm9cpfXbjr0nyL7KnhPcgJPgQiUWOD0hSA0AtfVJiQOFnxpan1DNDR2bvpC1YARDGTVReRzw+sFSwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RoVjqro+6Jka35I50Y2K7FGxnBiLVahJDvaSapfys6g=;
 b=xi4E/yZ+AWgc29zNdkhs6vx5OO56hkguPouTJ35g5S/p+jCybkBcGckfOmP9A0mXf69USZhf3a3JoPxGVSWM0Raya+Uob5W6eh3RObiNRHA6xE9AA/P68uigx4xceaMAZEp919DnFTD1R1kE51YyCNb+y6LtnNwy5nkGltnAur6+X8ePZPy/E0Uo69iSmx9Bc7dgN+ZurbrzWV455MYvflMAYU2WbBawPHxIkf8r4FP4J905a1NOsh1lT/9/DpR4donQvdcGB+c8Ze75zC33GZXJn0iOSA74hZ3b83ykUSt7NIfYXUvL+zGjUh87hian9G+skM8i4ol0J4FSAY04uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RoVjqro+6Jka35I50Y2K7FGxnBiLVahJDvaSapfys6g=;
 b=ob1muG77ZXMUFFd/JThmKjqm+WwVA2Tg7g2rBTGA/hxHg0xoL5+vI5OK6SIRfH40rmqGCL+jKlg+zjEd8YksYjs6+uz7/BqeQ2mLhmBdEtJqlpSVkbKM3zzsweVYr9YdJheBAdq7d3kLrTuyA9VC7DpIBzK7prj7Xy7x7Ysr1dFsaLToScLYry3kaiygrTSzwuwMkQZJEtJV2sDzBosCQJx28RiVUbsOstG7mvixXwu/im2o3McjNShkYjjdyIrsbLyctTtW01KQGacyjYvx2pF9DxL+RH/OHhWVkhTJCBr1QLuZC//Wmkx5z1jeiVHRsmAFRJ9iw9kLcNFhTglgjw==
Received: from MN0P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::27)
 by MW4PR12MB6804.namprd12.prod.outlook.com (2603:10b6:303:20d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Tue, 17 Feb
 2026 17:35:54 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:531:cafe::b7) by MN0P222CA0023.outlook.office365.com
 (2603:10b6:208:531::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 17:35:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 17:35:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 09:35:27 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 17 Feb 2026 09:35:26 -0800
Received: from BUILDSERVER-IO-L4T.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 09:35:23 -0800
From: Akhil R <akhilrajeev@nvidia.com>
To: <dmaengine@vger.kernel.org>, <linux-tegra@vger.kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<vkoul@kernel.org>, <Frank.Li@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <thierry.reding@gmail.com>,
	<jonathanh@nvidia.com>, <p.zabel@pengutronix.de>, Akhil R
	<akhilrajeev@nvidia.com>
Subject: [PATCH 0/8] Add GPCDMA support in Tegra264
Date: Tue, 17 Feb 2026 23:04:49 +0530
Message-ID: <20260217173457.18628-1-akhilrajeev@nvidia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|MW4PR12MB6804:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae839b9-cebc-4f67-fa17-08de6e4b0022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Cv/sShP+yER3a68OGpWmtbsc7dbfbZrsu1QDy6lZh9m9OAeWTGuuYiW8sgd/?=
 =?us-ascii?Q?8lZbWthdCCzW/S0dxQ8zBPEIhkRq4ZuQxe18h0yYM9opBg42f1nUHTAI+aWE?=
 =?us-ascii?Q?bmcnGKprYSBFFBKK4g091sk0xAHi2uFzD/Ez4R+MdfnuS05Ivc0esUnn5RUj?=
 =?us-ascii?Q?dwaxWAhP/YMYBkr1BIwYjEZK9aakUXrFlTpzdqoJtoImCuA0wCeU5zt7ikD/?=
 =?us-ascii?Q?Fq8f3YpIbWBHMUlbqxpq8Lp7PRG7v6Ge5mLJJboC9MQzlk8JHP35f5o77KEu?=
 =?us-ascii?Q?g5ik/KyKfpNZBb4CUzN2kAKNvLONSWWK4KqzIGVIX7YM7HD7iq+rm0rmgznx?=
 =?us-ascii?Q?MYEz3hgaaA1DOrPU/bfJbOStneM2Dq/cotR0t+7k6KNXqUMyLIwJjxBBFPim?=
 =?us-ascii?Q?ixVe0HYIDHayD+N6/IWFLF0Fd354cOI7PFH2Kg5oeswqnfeTvCjfUiVn2J5Z?=
 =?us-ascii?Q?wfFDoCUYH5gSo9+tL0mrihjvvMNjnWgVxNzzSlwz4qS5M8Vh1vJZmbbK0GXH?=
 =?us-ascii?Q?dXe1wFnQH7MhcA+fDL2nVgSNUUbT+4Xz7ZUXKHmCiHa7D4iM5RC4wXTpieKn?=
 =?us-ascii?Q?D5XqoYNC+s31VHxtMH0LwJf6gvzC0zYHmx0zruH2JJg0vwDMbACaWRjuOZOp?=
 =?us-ascii?Q?WmGwG3u4LIMKifCv+B/0qY+f44D/JqGdrxkzSyN0fb9s3ZVIbpUbwQo3jBSg?=
 =?us-ascii?Q?aRjSMOGPBztZJyahncUmPK1T65ZWHITsXa5/q8a8TbbV0k3wZuhxOxxBm88o?=
 =?us-ascii?Q?Y4p8ZD255sDJVFcaIQwFGXZZhJp2sqTdp4VCDhXfenBfpkERTuqb8s0IgAKi?=
 =?us-ascii?Q?mt782Gi5bVj62KUYMbrv05mtyUk+jEfMexYiXkHY63r9qysDKfKzP971JqJr?=
 =?us-ascii?Q?Uc88NaZQDQ5JT7lIP7O+TMyDobzX/h80PIHEmS6gV0ZOzeoxRfIYWMVPcWCy?=
 =?us-ascii?Q?6RzKz5+2Z4TKunluljAtBUeLb+xIJEepb92lCg+W5mJCq0B1DxHzQKP+ypgp?=
 =?us-ascii?Q?sn9uXw8fNbwTr/atCckDleL5Kxi4X6214BwPN7M3sYNr4kBGfnmVm5qdA7kh?=
 =?us-ascii?Q?qPnYP+/+yKoheZFCBv9MnDCejiWvr84NHNVvPI8TOPtMT8+nqRmHG1udkRAv?=
 =?us-ascii?Q?B+er4apCr4AqrDRmeiVcKWuVRe5lllySfXDwQHBn1j1QTm0G7tlF06Q5CwTZ?=
 =?us-ascii?Q?Lb3nVNTAb2jQI1/2LHZG8u4u258qkXq+qV9k3Z3c288tU+lUHKsPzkWtBMaV?=
 =?us-ascii?Q?RMGoa28T2Cnfhk4eaB1TUnsoEffvE3Um1M8JME8pqAGWN3ZgnxiOd7ZxTW+S?=
 =?us-ascii?Q?gQHlwwXQ2As5e0PF/7UdctGnCm7irARGfzBQ/66vQx1Kq/SAgszIMM3nPzYb?=
 =?us-ascii?Q?dt7PikxJmjKgBu9prxAmaY2SCy40Kt1xWJSkI4dXkG3bCbuh5shE4tH/8KLo?=
 =?us-ascii?Q?nfgWry6nS0qVk6SoKTebjNyQBo3oleTGOEM+P0rDkCeeCGM3CDuy/J9XBDTO?=
 =?us-ascii?Q?4f2r0JbkR9INVCi2Yg/rr/Ez72H3lHc1OxCSEiUwBvNH6aPkvHvQRJu9Qg2n?=
 =?us-ascii?Q?/L5wXALYwpVn+AhHXmmIs72wdLBEtrOxKtmPvspgzVfWOukXQ5nIQJZVQZ6b?=
 =?us-ascii?Q?46hmE2rvGdtx6QuwN5XVDV/6+gD8bv+zRG7hFq72MP1ZNa/N1Kp+Ocs8o8Wv?=
 =?us-ascii?Q?HtEPxQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/5kKESJaR9hrSsxjodkjGkr370Nrvcw9cp1bC90hxFGgDNYd+emOq6OH5Ce04Ruj4EbmDCSGDXi0pPdnXvbrMInZLzJtYQWO3zYbVbjPQuvXxnGfqWmV/ySOw811cOp0AOLkKHVS/yvITDTbpceDph7rrK0OsEYsrEGrH5jZKmvXc2bIheRVVB03PxPqrgWqq9BFwKdh+9SZZj5vv66eTbd3+xNPnkeVTE05aP67RulH792so8fIbiVraw8XZiyE1vaquHmpOYd55YcuGfhD2GSUAy5v83cY6GG3pu8GW+mZwQ7Q8hgESRtaT/ORL5dTCAAT+IgePitNccB8XX3x4yppkAJFy3Gtsom6qQrgPWRDyCwrSgaksEGImrM+XOz4u3nrE/qlD4ZoZAWTqZTtapF244EvY/0pntMjpsGcRxcolXDMBo6KWfIrhWhTa1td
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 17:35:53.5805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae839b9-cebc-4f67-fa17-08de6e4b0022
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6804
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,nvidia.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8919-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[akhilrajeev@nvidia.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:mid,Nvidia.com:dkim];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 3A8E714EA00
X-Rspamd-Action: no action

This series adds support for GPCDMA in Tegra264 with an additional
support for separate stream ID for each channel. Tegra264 GPCDMA
controller has changes in the register offset and uses 41 bit
addressing for memory. Add changes in the tegra186-gpc-dma driver
to support these.

Akhil R (8):
  dt-bindings: dma: nvidia,tegra186-gpc-dma: Add iommu-map property
  dt-bindings: dma: nvidia,tegra186-gpc-dma: Make reset optional
  dmaengine: tegra: Make reset control optional
  dmaengine: tegra: Use struct for register offsets
  dmaengine: tegra: Support address width > 40 bits
  dmaengine: tegra: Use iommu-map for stream ID
  dmaengine: tegra: Add Tegra264 support
  arm64: tegra: Add iommu-map and enable GPCDMA in Tegra264

 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml |  27 +-
 .../arm64/boot/dts/nvidia/tegra264-p3834.dtsi |   4 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi      |  33 +-
 drivers/dma/tegra186-gpc-dma.c                | 441 +++++++++++-------
 4 files changed, 337 insertions(+), 168 deletions(-)

-- 
2.50.1


