Return-Path: <dmaengine+bounces-8910-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLxuDS74kmlx0gEAu9opvQ
	(envelope-from <dmaengine+bounces-8910-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 11:57:50 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AC314292F
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 11:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 649E7303FDE9
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72C73019D9;
	Mon, 16 Feb 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1pzYMcIv"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010051.outbound.protection.outlook.com [40.93.198.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054102DB7A9;
	Mon, 16 Feb 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239362; cv=fail; b=B4sRn2DWYYaAGao1M8K6mT0jiZkrwyFmtnuwFMDP1Uwjw/LLdYkBy4r5hIKr0yCtVvwi8whWCWD89eB2pPDZ7fv85DGkJDO3a9H7zCrW6Ul2UzZOv9qSMXM5+jGGDKB1mAFP+9O9JvTekRUAqn9E++jl2itHIhXwHNMfQIPueLM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239362; c=relaxed/simple;
	bh=cVBy2T2l/CYFXcuiALH39gtIvId9XDuEfxcEAx/Nf4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BPK4kKfRoU6/ikYStC3vcqcQY2zNdU+8IdQr4faqWlPkDQHCErl0o1mIgPyrE7TTcDc4iFrFhd5rPP99408/CZaJrrLT0/kNXHh58zdBFr7jcLTK6jfXO+37eRpqoyp2hHwJSqD1KWBKGnMWv+gK+BZFGXKKZX7/FjPqdut1vcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1pzYMcIv; arc=fail smtp.client-ip=40.93.198.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=COls8BmFxNi9IssU+sG8cDvimCRH9M2aU+QkHb9WZxaC+zDja5gco0qmY1bQ621EHhyWQp75Yg11pgCmaeWWITqkDv/zNMIEuxVbhO7Zurx5Tr4GFjPvzBBMfGQXRhN+VkFTptPwZsMD0AFS1V5SPQz2j/6zKd0HwkWml1fNOAmmLadHFY2QtG8Wekw3ZAazgh77/8/ut5Z7CwDb78hs5jrFgAJoAP8la1ZIWLQRsG1+hEko3OCcG1MSKkmymKnkir2PoL5+vssRHosb/CjmTc6pQXGSN46T3FKJ/F5N4b35ecgg98UH78/AJ4aCinCImJ1/z5gf5w2yJCZHRc8vEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAHifbdgUf11x7ADrBrBtfxXXcDrXcJ2MCbbaRQNO/g=;
 b=oaTLZuz40iqdMyYaJBkLMAF3gU8m6oEfQ4nTPBNalj8JVy6pNMGvOQABnK9zIEkRuro1VqRJoEiDQuTtYmDPjj/Y92BPjY1kdEXajbLXBcyh0dUXaIfJfBPhBis4QROzoc8JbzgknPxIy93/DzveeOjylmwNjHQnj/aZDKe9JV8+wvQ8b5fm82qQN5m1QQDCV7l1xSVGaMzg7d4t6wYB1nth128Jy1eWA0i05ndLSDru681JHS/SZZWDC0s0cOua2ABQ9A8r4fMdMS1Qkbgw9jxxmTgpGNjeEDYAqbT4U3Tgt9yKYdc1ExHhhea7VfU6LgELegoH5MK3fd3mFceNKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAHifbdgUf11x7ADrBrBtfxXXcDrXcJ2MCbbaRQNO/g=;
 b=1pzYMcIvyMQJixWAhqYzR22Tu/kJjAYj+FhHAV5wEFUAHbKMxj5VOo7o4TrPk057P/xJj0j7wMFwWC2Gn2VzhokppqlE37ngIIOIqNzyS1ysrz9LcPhWbv5P9++ctVrcPxqjItdSz6PcGZQWq4x5vwr02Rq7S5ZYB4oTxuTLmPo=
Received: from BN9PR03CA0072.namprd03.prod.outlook.com (2603:10b6:408:fc::17)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.14; Mon, 16 Feb
 2026 10:55:56 +0000
Received: from BN2PEPF00004FBC.namprd04.prod.outlook.com
 (2603:10b6:408:fc:cafe::b1) by BN9PR03CA0072.outlook.office365.com
 (2603:10b6:408:fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBC.mail.protection.outlook.com (10.167.243.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:55:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 04:55:55 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Feb
 2026 04:55:55 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 04:55:52 -0600
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH RESEND v10 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Mon, 16 Feb 2026 16:25:46 +0530
Message-ID: <20260216105547.13457-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260216105547.13457-1-devendra.verma@amd.com>
References: <20260216105547.13457-1-devendra.verma@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBC:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 74849087-365b-412c-edc4-08de6d49f5d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yJxUiLgfH6cZJtAvjM7iFrO4ROrMVMZOxgbSqE4o+kKxB0UCJYuP6w5Dkl1d?=
 =?us-ascii?Q?/Dn9+SoRNJCNjt4EpsqQY/s/rLSP90FYKaYcumBDs1TscoMvHHoTbsi+u17w?=
 =?us-ascii?Q?zWfCt7HNHUusRPGNYRNedc59gGYFh6HqrJggJzxcdM9Q9yi05dLXnZqAAr6f?=
 =?us-ascii?Q?LvjW1GMENYF+fLZRvnC6WvC0fkCYGwMcEFFEVP+hH5kPbFQM+/sK9y73Raww?=
 =?us-ascii?Q?6sQ6kWGEeyCxylwy5bmGCuWPi2FB1zQE2yuirEY3yBOBrS2zQDprzp+hq2lV?=
 =?us-ascii?Q?pWNOxbfcOX70J4LUAabZgXblf1PqZ+EAumjOvWzopXVvLdSsMH75/4ims7S3?=
 =?us-ascii?Q?PHnII9n4IrjqzQjevevjD/aac2XRnBkPmrY9l8va+zPzOPd/Vd91GK/MCv8B?=
 =?us-ascii?Q?zAwoyBhrXlIRmtmJBN+qdbqmVnmkW882aXJ0ptIQdJ5dTavRsAWBg4+7H5Uw?=
 =?us-ascii?Q?eBdKtVyd0S0yJormM/3Y0PrR0kj9Rtlj974T3sb7ewJ6p+zUXNQCnFSNX/Gs?=
 =?us-ascii?Q?X+ddUaBSyMytx1wCMGyAhhRNNT9eqdZiF8f0P/UhrYiCdwElcKq0j+gpDPR4?=
 =?us-ascii?Q?CSSjlvDm8X/WffX7g9tLcvi878zsEFxP5DDkRt/DS7bcAA4mx8JRcR8urxOK?=
 =?us-ascii?Q?Tb2lXoC5uF0gj7DuOspv9FXnWOWv5pGCV2ne7vNYAHrB/UtIGPJd0oesDJas?=
 =?us-ascii?Q?MrosMvMvrqMVR9ZhmPi6i2FeepsICufq+Tf1oNyZypTUPFgN0KydDpyqDc23?=
 =?us-ascii?Q?JlKWnkK2ZLdO/8lQEsxkTmhLxZrSJtKMa1rs3ffB0AaUvjw6SVXjVYje49aG?=
 =?us-ascii?Q?duTa2vXne0Fwr9td1fG17d2c+isOc3mg5wOKfMTFjJhtvc4CHtdlesX7lnSs?=
 =?us-ascii?Q?+4VNhRaK8+D+QsLjL28eCFHtNRJphq+rv6KQy+E88CCqjdrcnPc+4eICe6uF?=
 =?us-ascii?Q?XZHBSNKLGI1mukKc1joMB056qqdQo/i7W2GiueEe/Yyfd7/KtKT7ppLhXcmY?=
 =?us-ascii?Q?2y68Tot3BPnVV2Kii0HeCAEAh+wjaNhv8VHj7kX3y37OFUqKAuRI/IKuELr3?=
 =?us-ascii?Q?S1BF3OxQsnBQrjIyvY8xBGqJi/S6mBCGTb1MQLHiKft1A1xVWEAnMa21P5e6?=
 =?us-ascii?Q?xD3ArEVFX98iAs2+lpnr91RhCV73wZzDD/l6+QfoNWyteZO3yGYlfZBUtoQ+?=
 =?us-ascii?Q?i/P6VLCd3CxeLE2f+C6ks8tpc5BPBr8jWM7AQNK7gKvbWaRJYgsEzpj75BPu?=
 =?us-ascii?Q?p8JlOtfhoB97cOm6bBBjqhvE4q9aNos0VWvJcO7II4DGirD7J0T0SG6J2jFz?=
 =?us-ascii?Q?8v4ivW4W3Oynw6XkLw7tSpsh9ErvoYGbHMNCpD2DO5k6Wm6555XTroplsOlh?=
 =?us-ascii?Q?JcolFokAekABqU0P5SdePnAsdKfWZwoh53HsA6IUA7hgdVEc+oEudJzi39R2?=
 =?us-ascii?Q?7pawd/5AYTm3DGWRAX4kwVwxNXJProYVKa8sa0hE0aPVAs4Wz20ZifBvUbVx?=
 =?us-ascii?Q?alVo6mzuN4LQOSdQ/zfWOFYDWEsRJEqDtrTMDJQaBfALtsjtPxLkm7wrWHV3?=
 =?us-ascii?Q?cjeVrN27XinPJlB69kSiIjPjlOtrPOWgj2rg3oWF6od8qM/Hat9bA6fUMCWw?=
 =?us-ascii?Q?K/CNyP4QCfcTjANT951Rb0Jbg5f/eoUmSBrDuD9GaL8pD2+SJWW62kiV8Z6+?=
 =?us-ascii?Q?OZRuCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zYbINgRLr3nSQAnhGKcjkv3205EZDDhdn+mmKF1IDIXNaK4fopkPK3cW7vjCm3MOO3UWSovwhsLXPT0/8CX/uz75WezqxeNj8laSiOiV/HrArWQGQ23HJ9G4+S60Hf7IZyTF6nfIIerqRYTKVsidmpwk4RoQ11bRLmLaq1gornl6CnpLbSvbRPP+yhU5ob3M8S1RwFFRldv+UlHOOuVu39V2ryqP4HZW/x0Oo0UzZXGc7d+glGnHewSaiZJ+DAD+eZH+tr3xL2Aftb5LUfQIa5X0L1OeDDUr2w5pca4v/TWG3obV8cf2qtpxzu9aLyVhBCf85ipJvsGVXWEKUvZEZgYkZR5WZyHk4uGaHcXycaJKOsG1kUcimE1CVDShJLNKl4zlqYLSDvN9BULFEZS0F6CWxMiIE8okGNoyKLzdHfvYNFByCE6oAhjUHRVdfuOU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:55:55.6979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74849087-365b-412c-edc4-08de6d49f5d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-8910-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:email];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: C5AC314292F
X-Rspamd-Action: no action

AMD MDB IP supports Linked List (LL) mode as well as non-LL mode.
The current code does not have the mechanisms to enable the
DMA transactions using the non-LL mode. The following two cases
are added with this patch:
- For the AMD (Xilinx) only, when a valid physical base address of
  the device side DDR is not configured, then the IP can still be
  used in non-LL mode. For all the channels DMA transactions will
  be using the non-LL mode only. This, the default non-LL mode,
  is not applicable for Synopsys IP with the current code addition.

- If the default mode is LL-mode, for both AMD (Xilinx) and Synosys,
  and if user wants to use non-LL mode then user can do so via
  configuring the peripheral_config param of dma_slave_config.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v10
  Added the peripheral_config check only for HDMA IP in
  dw_edma_device_config().
  Replaced the loop with single entry retrieval for non-LL
  mode.
  Addressed review comments and handled the burst allocation
  by defining 'bursts_max' as per suggestions.

Changes in v9
  Fixed compilation errors related to macro name mismatch.

Changes in v8
  Cosmetic change related to comment and code.

Changes in v7
  No change

Changes in v6
  Gave definition to bits used for channel configuration.
  Removed the comment related to doorbell.

Changes in v5
  Variable name 'nollp' changed to 'non_ll'.
  In the dw_edma_device_config() WARN_ON replaced with dev_err().
  Comments follow the 80-column guideline.

Changes in v4
  No change

Changes in v3
  No change

Changes in v2
  Reverted the function return type to u64 for
  dw_edma_get_phys_addr().

Changes in v1
  Changed the function return type for dw_edma_get_phys_addr().
  Corrected the typo raised in review.
---
 drivers/dma/dw-edma/dw-edma-core.c    | 35 ++++++++++++++-
 drivers/dma/dw-edma/dw-edma-core.h    |  1 +
 drivers/dma/dw-edma/dw-edma-pcie.c    | 44 ++++++++++++------
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 65 ++++++++++++++++++++++++++-
 drivers/dma/dw-edma/dw-hdma-v0-regs.h |  1 +
 include/linux/dma/edma.h              |  1 +
 6 files changed, 132 insertions(+), 15 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index b43255f914f3..ef3d79a9f88d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -223,6 +223,31 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	int non_ll = 0;
+
+	chan->non_ll = false;
+	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
+		if (config->peripheral_config &&
+		    config->peripheral_size != sizeof(int)) {
+			dev_err(dchan->device->dev,
+				"config param peripheral size mismatch\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * When there is no valid LLP base address available then the
+		 * default DMA ops will use the non-LL mode.
+		 *
+		 * Cases where LL mode is enabled and client wants to use the
+		 * non-LL mode then also client can do so via providing the
+		 * peripheral_config param.
+		 */
+		if (config->peripheral_config)
+			non_ll = *(int *)config->peripheral_config;
+
+		if (chan->dw->chip->non_ll || (!chan->dw->chip->non_ll && non_ll))
+			chan->non_ll = true;
+	}
 
 	memcpy(&chan->config, config, sizeof(*config));
 	chan->configured = true;
@@ -358,6 +383,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	struct dw_edma_desc *desc;
 	u64 src_addr, dst_addr;
 	size_t fsz = 0;
+	u32 bursts_max;
 	u32 cnt = 0;
 	int i;
 
@@ -415,6 +441,13 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		return NULL;
 	}
 
+	/*
+	 * For non-LL mode, only a single burst can be handled
+	 * in a single chunk unlike LL mode where multiple bursts
+	 * can be configured in a single chunk.
+	 */
+	bursts_max = chan->non_ll ? 1 : chan->ll_max;
+
 	desc = dw_edma_alloc_desc(chan);
 	if (unlikely(!desc))
 		goto err_alloc;
@@ -450,7 +483,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		if (xfer->type == EDMA_XFER_SCATTER_GATHER && !sg)
 			break;
 
-		if (chunk->bursts_alloc == chan->ll_max) {
+		if (chunk->bursts_alloc == bursts_max) {
 			chunk = dw_edma_alloc_chunk(desc);
 			if (unlikely(!chunk))
 				goto err_alloc;
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..c8e3d196a549 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -86,6 +86,7 @@ struct dw_edma_chan {
 	u8				configured;
 
 	struct dma_slave_config		config;
+	bool				non_ll;
 };
 
 struct dw_edma_irq {
diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3aefc48f8e0a..94621b0f87df 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -295,6 +295,15 @@ static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
 	pdata->devmem_phys_off = off;
 }
 
+static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
+				 struct dw_edma_pcie_data *pdata,
+				 enum pci_barno bar)
+{
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX)
+		return pdata->devmem_phys_off;
+	return pci_bus_address(pdev, bar);
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -304,6 +313,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
+	bool non_ll = false;
 
 	vsec_data = kmalloc(sizeof(*vsec_data), GFP_KERNEL);
 	if (!vsec_data)
@@ -329,21 +339,24 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 
 		/*
 		 * There is no valid address found for the LL memory
-		 * space on the device side.
+		 * space on the device side. In the absence of LL base
+		 * address use the non-LL mode or simple mode supported by
+		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			return -ENOMEM;
+			non_ll = true;
 
 		/*
 		 * Configure the channel LL and data blocks if number of
 		 * channels enabled in VSEC capability are more than the
 		 * channels configured in xilinx_mdb_data.
 		 */
-		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
-					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
-					       DW_PCIE_XILINX_MDB_LL_SIZE,
-					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
-					       DW_PCIE_XILINX_MDB_DT_SIZE);
+		if (!non_ll)
+			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+						       DW_PCIE_XILINX_MDB_LL_SIZE,
+						       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+						       DW_PCIE_XILINX_MDB_DT_SIZE);
 	}
 
 	/* Mapping PCI BAR regions */
@@ -391,6 +404,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
+	chip->non_ll = non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -399,7 +413,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -410,7 +424,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -419,12 +434,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
@@ -435,7 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
+		ll_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -444,7 +461,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
+		dt_region->paddr = dw_edma_get_phys_addr(pdev, vsec_data,
+							 dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909..a1b04fec6310 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -225,7 +225,7 @@ static void dw_hdma_v0_sync_ll_data(struct dw_edma_chunk *chunk)
 		readl(chunk->ll_region.vaddr.io);
 }
 
-static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+static void dw_hdma_v0_core_ll_start(struct dw_edma_chunk *chunk, bool first)
 {
 	struct dw_edma_chan *chan = chunk->chan;
 	struct dw_edma *dw = chan->dw;
@@ -263,6 +263,69 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 	SET_CH_32(dw, chan->dir, chan->id, doorbell, HDMA_V0_DOORBELL_START);
 }
 
+static void dw_hdma_v0_core_non_ll_start(struct dw_edma_chunk *chunk)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+	struct dw_edma *dw = chan->dw;
+	struct dw_edma_burst *child;
+	u32 val;
+
+	child = list_first_entry_or_null(&chunk->burst->list,
+					 struct dw_edma_burst, list);
+	if (!child)
+		return;
+
+	SET_CH_32(dw, chan->dir, chan->id, ch_en, HDMA_V0_CH_EN);
+
+	/* Source address */
+	SET_CH_32(dw, chan->dir, chan->id, sar.lsb,
+		  lower_32_bits(child->sar));
+	SET_CH_32(dw, chan->dir, chan->id, sar.msb,
+		  upper_32_bits(child->sar));
+
+	/* Destination address */
+	SET_CH_32(dw, chan->dir, chan->id, dar.lsb,
+		  lower_32_bits(child->dar));
+	SET_CH_32(dw, chan->dir, chan->id, dar.msb,
+		  upper_32_bits(child->dar));
+
+	/* Transfer size */
+	SET_CH_32(dw, chan->dir, chan->id, transfer_size, child->sz);
+
+	/* Interrupt setup */
+	val = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
+			HDMA_V0_STOP_INT_MASK |
+			HDMA_V0_ABORT_INT_MASK |
+			HDMA_V0_LOCAL_STOP_INT_EN |
+			HDMA_V0_LOCAL_ABORT_INT_EN;
+
+	if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL)) {
+		val |= HDMA_V0_REMOTE_STOP_INT_EN |
+		       HDMA_V0_REMOTE_ABORT_INT_EN;
+	}
+
+	SET_CH_32(dw, chan->dir, chan->id, int_setup, val);
+
+	/* Channel control setup */
+	val = GET_CH_32(dw, chan->dir, chan->id, control1);
+	val &= ~HDMA_V0_LINKLIST_EN;
+	SET_CH_32(dw, chan->dir, chan->id, control1, val);
+
+	SET_CH_32(dw, chan->dir, chan->id, doorbell,
+		  HDMA_V0_DOORBELL_START);
+	
+}
+
+static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
+{
+	struct dw_edma_chan *chan = chunk->chan;
+
+	if (chan->non_ll)
+		dw_hdma_v0_core_non_ll_start(chunk);
+	else
+		dw_hdma_v0_core_ll_start(chunk, first);
+}
+
 static void dw_hdma_v0_core_ch_config(struct dw_edma_chan *chan)
 {
 	struct dw_edma *dw = chan->dw;
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-regs.h b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
index eab5fd7177e5..7759ba9b4850 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-regs.h
+++ b/drivers/dma/dw-edma/dw-hdma-v0-regs.h
@@ -12,6 +12,7 @@
 #include <linux/dmaengine.h>
 
 #define HDMA_V0_MAX_NR_CH			8
+#define HDMA_V0_CH_EN				BIT(0)
 #define HDMA_V0_LOCAL_ABORT_INT_EN		BIT(6)
 #define HDMA_V0_REMOTE_ABORT_INT_EN		BIT(5)
 #define HDMA_V0_LOCAL_STOP_INT_EN		BIT(4)
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3080747689f6..78ce31b049ae 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -99,6 +99,7 @@ struct dw_edma_chip {
 	enum dw_edma_map_format	mf;
 
 	struct dw_edma		*dw;
+	bool			non_ll;
 };
 
 /* Export to the platform drivers */
-- 
2.43.0


