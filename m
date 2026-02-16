Return-Path: <dmaengine+bounces-8909-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CQfLij4kmlx0gEAu9opvQ
	(envelope-from <dmaengine+bounces-8909-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 11:57:44 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E5142928
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 11:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E3B3030B26
	for <lists+dmaengine@lfdr.de>; Mon, 16 Feb 2026 10:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223493016EE;
	Mon, 16 Feb 2026 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NKkWAGnj"
X-Original-To: dmaengine@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010064.outbound.protection.outlook.com [40.93.198.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0593002BB;
	Mon, 16 Feb 2026 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771239362; cv=fail; b=SDY1aL33tOQvAfmBfV3a6ElHZ1g0xUyWpIZjTUSG7ysKdwfaUsVS6/knzJXXDcQP/kf8bNjBl5bLs39dUUjH18Y+VPoBGf/Jg1f5yL2MEUvw/KhnSdENqXYVApk+0Dwj3/8APEDJCZLzlvibAttF2TfQCDiDG2aWxXL2t0+Lj9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771239362; c=relaxed/simple;
	bh=C9cm2iXuak+Aiim5hcLXZr0m8FOy1/ZJERS0j7b0uS8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HG3pAikWgasz0HDyb1YUoJ6R0p+7qsK/W99oyKe/HlQs9tuOYLZMsbNMPBUraUh4Eezy1o4xP0c5XR4JSYaXAxDCmpSrN7+be4+XsKnYeUNX9GbZrnWG9jYhwwVpdZn9cEbpUFVdo2zIOTCl8Zao01TGQcZj7FEPnZm4STFpa5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NKkWAGnj; arc=fail smtp.client-ip=40.93.198.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YeJhBdQkF2Jzu9+1DwviOXuRGCKUtu0lpufflW+I9jVaPwKZQfUsgJSyI/GWZzRaMoQbCi52ylh57V9JYLN/WRFocxAP96jiliuUt8C1P1QcH0dxh+Oow1HqxmcxAcTXoPnMZyOSjzeLSKZnF8wERmlV82hw0nTBWzEb98RZJmByrvCs8Ih+BrEXYUPK0rooCVuaFVHdKWWrFM4zM7Vys3rSi8W5u3NnfHLmY0iUgTkaHOHV0leUPY7vT7rnhD+vlqmJ5qqSrPQVOEU/uyG7JFYPa7pXWBNYax1OwewPaLyCXkXimbbhqU/d3gnb64d+3bWciq3GoWYHRvca+CVrUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rPHK7Fy1oZvuFWiCpe6lxFZonKGxzvyYt3tnuKDna4=;
 b=j3wPfdtBFEA1x737ws4t28wz+xcwpW1rYZqYYhIntGlewkHZ9WTGdFv3/UYUCNtmdh1Bltv9Vt0Y7IuvrUEgoRiau+TOnza2ocLRhGtXeUcCPT0XaFURFyHVsO2uj8JNffXCQVCT506NSngCXzyYjey229in6+yuIcHM0bZK8nW0ASyHoe0CY1jQFUGWRKZqpD4sSoX6L5g0Z8ehbqK6pCOWijOq03sSQFqSDu8qyeZfRCrh1qndqp0KFMDSIzOON0h0d7RbbKw/a82ZpjYPjdq+AP79BWQnLAa3TyWry1hHunXbO/kQ9v8p1oMtDVvUMl6waQUiy8aeN+5WYVdLMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rPHK7Fy1oZvuFWiCpe6lxFZonKGxzvyYt3tnuKDna4=;
 b=NKkWAGnjc1uJgf8oBTW5U2fQxHCjAVzOuAGSM4U6U9ufxcMnmURULViMSCOBT1O/x5J7AjscleRSljVDCQPKiAWFXnZTPGOlkGnM6H5cxof+WKl1kiAfE5RzRcYol6nEw869ffJEEdRHLaZIHXJTQ57tdTmp2HzFGhCCsVWP7g4=
Received: from BYAPR06CA0023.namprd06.prod.outlook.com (2603:10b6:a03:d4::36)
 by IA1PR12MB6090.namprd12.prod.outlook.com (2603:10b6:208:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:55:54 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:d4:cafe::ff) by BYAPR06CA0023.outlook.office365.com
 (2603:10b6:a03:d4::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.16 via Frontend Transport; Mon,
 16 Feb 2026 10:55:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Mon, 16 Feb 2026 10:55:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Feb
 2026 04:55:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Feb
 2026 04:55:52 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Feb 2026 04:55:50 -0600
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH RESEND v10 1/2] dmaengine: dw-edma: Add AMD MDB Endpoint Support
Date: Mon, 16 Feb 2026 16:25:45 +0530
Message-ID: <20260216105547.13457-2-devendra.verma@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: devendra.verma@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA1PR12MB6090:EE_
X-MS-Office365-Filtering-Correlation-Id: cc96b723-17e4-457e-2678-08de6d49f4d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NLOMCjHKq2y1sbRtU81Pq9zqeA0hF0zd8LKFYvVTzWG0a75rnjKKu5au3eK3?=
 =?us-ascii?Q?UARH1M4BsM3vX5d86XoX/uvD5Vlb4CoQeJE9/R1xipbNhGxI74bPKC10mGZM?=
 =?us-ascii?Q?0W2TB7Pnqz3Ug+q+HQRoqwM0SP7rP7ZyQ7deLvvA9rWf4UWQrVJmzoXmXHzI?=
 =?us-ascii?Q?qEx9LFuHg6uyYHTj4L2WkJfYic1XPKQG9M9U2fV0YRYlharKL9cYKP18Dzsm?=
 =?us-ascii?Q?WEXAtmUCInv1Xv1+2j1gpDFWZJ1f64O9QNPQ6u/0DhP8hKib9D6l2E/z76aI?=
 =?us-ascii?Q?UtX97jUCTqpP9iuXw00ufcVEuX77oyL30rv9VhqxA29zFXV5r6iUyxOed7wo?=
 =?us-ascii?Q?mBo5JMFOFNQEu3ZYRSSKRlYhjD+oimd4RkuVAJeDcLReXR7iNOZcT9C7i0rr?=
 =?us-ascii?Q?lf7vK82ePmeKB2yv/cIHYKMcF/R8in0UERpKoTshEe+7hmrDHB7pVtCSPff0?=
 =?us-ascii?Q?bFWGsMFK5PTNSJ92cbkadfowovaH/Fuwwfw/oyRA/PQFqJ2GcFixG0W5H3qH?=
 =?us-ascii?Q?soPH7NFhAeItpaGYi/8VjMXMeX1Hly+PLldqT3r9aZ4xzJWon8RHVE3gc140?=
 =?us-ascii?Q?EGvgwOVREhw/H8Jv6w5RK+nfntx+doEsp9y+s6x6nXt5K7UP2jwjLccFSb6y?=
 =?us-ascii?Q?oXMCaECb/TR71NHQMdi4lxj2pYQ2r0ZCEN/APkX32Y2CW0CFm6tGK0dk8gmR?=
 =?us-ascii?Q?pSVDIlVyvuH67cf0WTe4jtczHCoBMLfumiy3q7QxiOYJspyAsKRKRBsNHkZj?=
 =?us-ascii?Q?xiaX8J3wBfL/GLk5FhUpTLd6S6TloIcit8hOulZiZg/+hAqcw6ftTjrdTvEL?=
 =?us-ascii?Q?lvGLciNLMprEwRs+jtYbEndcI0jnZi9y+fZD3i2RZTL1w1AIiOvhC3Ps0T5u?=
 =?us-ascii?Q?JI6JhQO0NK04drJXiHAz3da2V0gPRnl1ur4YC2gj34p3QinCstjACMkuBhk+?=
 =?us-ascii?Q?iyes+wy4O/LeFj4zpGOtEUTHWeF4JpeInqoznvziGicoBZQwO7LjgLyu8kKw?=
 =?us-ascii?Q?R/zcBUA7d4/meyv6dMzsGB9GkKMJpb/+olKi3qJtIUKn49LkuP5iZGM/CqaV?=
 =?us-ascii?Q?hl68w7g2Gu9hIkl2LLYdO+2SCUoRh7aLFKqYwSeyT+bg9+GvqGpCgl5d+qi/?=
 =?us-ascii?Q?7lhmOGFiWeWBI7XXhiXy+GjfT7LraJTaT1SvLRVBXDDtbPlEzrfUU5LvVFKC?=
 =?us-ascii?Q?X/RKYykU5qrxj/arfmFwwhwdChcltfU1dph+ZrAKhD1OiRvv3ntZP/NPu9/D?=
 =?us-ascii?Q?JQKezdg606yKKrmR1SpVkNeYqMwPa2f8yDUNRZx/Ocg+Vvan2vM8w2bm7NCQ?=
 =?us-ascii?Q?Wv0LZ1Ho6CvsDGHliAwpzhylXufC5Vx+EUUivqaJzV/8b6f7iRl4+eyq65Lu?=
 =?us-ascii?Q?uc8tkoMoBRSpFeB5SrKdegnzdXpLbvEa+gI2U9ueVPv2VUVWGb+xJI40Cymb?=
 =?us-ascii?Q?4IBuxZRftbeLcCL1FWOPTXdHVzTIOZyqVYg9EkI10xTpDvTBB8+ZLQkWMFW5?=
 =?us-ascii?Q?lS5HE6e5HG5XFSz6P+U48r3XyZECei7wIbgKi1iGLe4vr2LPRfdLDFFLsUaX?=
 =?us-ascii?Q?/Dvw+mBi1R7PPMd3Sgz0P6OVZtH07ySosbeRkxF9YiXENmotplar6wP/ahGk?=
 =?us-ascii?Q?Zjkz6sqzgdqs3QOb5IufvMyPXvtq+IhDTeVv8ml3fQy1dMrRckYavE4QHWoM?=
 =?us-ascii?Q?rlYxcw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	liw7jkvmU8ZnYSEfSqYxg+3eAQSj2VZ+4MviRWrhMzogO5JJKvcWuRJYhKGtFio+gS7eXvT2dWgdSHjoTYYyg+IWVhgqQS0thDfH1RHMigMPdxhteywjUb51rVQViAHg3YhJIOEaUmyyJuC3/mt3Jr0evr5W63epr1wcRBvrBiMVcwMe3U+3C0/hVDivPD9D/TvKBUO2ZUsc6RYzDeLRL8bKagXIIY5hCwss8PPmLCn5UpmmbMfcZAHRspyHjhxHhvhkudbw2AdgfFb0uiy+c8dQIn1oUxG4+s7rGDmf8qHNCARK07N4SPIrfhzJwfKlVaW4ede8momFhQLrM3jBu5bLiW572IDO6zTSdEiMCCduEr538U0wyr9MqYwy80wLYr+mngxH3ZaV8RcEolxPcJtP8Ya5ZogaJWPYG+PePLeDmw2i13zthJyHAhk7UHuT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:55:53.9374
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc96b723-17e4-457e-2678-08de6d49f4d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6090
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
	TAGGED_FROM(0.00)[bounces-8909-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: 395E5142928
X-Rspamd-Action: no action

AMD MDB PCIe endpoint support. For AMD specific support
added the following
  - AMD supported PCIe Device IDs and Vendor ID (Xilinx).
  - AMD MDB specific driver data
  - AMD MDB specific VSEC capability to retrieve the device DDR
    base address.

Signed-off-by: Devendra K Verma <devendra.verma@amd.com>
---
Changes in v10:
For Xilinx VSEC function kept only HDMA map format as
Xilinx only supports HDMA.

Changes in v9:
Moved Xilinx specific VSEC capability functions under
the vendor ID condition.

Changes in v8:
Changed the contant names to includer product vendor.
Moved the vendor specific code to vendor specific functions.

Changes in v7:
Introduced vendor specific functions to retrieve the
vsec data.

Changes in v6:
Included "sizes.h" header and used the appropriate
definitions instead of constants.

Changes in v5:
Added the definitions for Xilinx specific VSEC header id,
revision, and register offsets.
Corrected the error type when no physical offset found for
device side memory.
Corrected the order of variables.

Changes in v4:
Configured 8 read and 8 write channels for Xilinx vendor
Added checks to validate vendor ID for vendor
specific vsec id.
Added Xilinx specific vendor id for vsec specific to Xilinx
Added the LL and data region offsets, size as input params to
function dw_edma_set_chan_region_offset().
Moved the LL and data region offsets assignment to function
for Xilinx specific case.
Corrected comments.

Changes in v3:
Corrected a typo when assigning AMD (Xilinx) vsec id macro
and condition check.

Changes in v2:
Reverted the devmem_phys_off type to u64.
Renamed the function appropriately to suit the
functionality for setting the LL & data region offsets.

Changes in v1:
Removed the pci device id from pci_ids.h file.
Added the vendor id macro as per the suggested method.
Changed the type of the newly added devmem_phys_off variable.
Added to logic to assign offsets for LL and data region blocks
in case more number of channels are enabled than given in
amd_mdb_data struct.
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 190 ++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 3371e0a76d3c..3aefc48f8e0a 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -14,14 +14,35 @@
 #include <linux/pci-epf.h>
 #include <linux/msi.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 
 #include "dw-edma-core.h"
 
-#define DW_PCIE_VSEC_DMA_ID			0x6
-#define DW_PCIE_VSEC_DMA_BAR			GENMASK(10, 8)
-#define DW_PCIE_VSEC_DMA_MAP			GENMASK(2, 0)
-#define DW_PCIE_VSEC_DMA_WR_CH			GENMASK(9, 0)
-#define DW_PCIE_VSEC_DMA_RD_CH			GENMASK(25, 16)
+/* Synopsys */
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_ID		0x6
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_BAR		GENMASK(10, 8)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH		GENMASK(9, 0)
+#define DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH		GENMASK(25, 16)
+
+/* AMD MDB (Xilinx) specific defines */
+#define PCI_DEVICE_ID_XILINX_B054		0xb054
+
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_ID		0x6
+#define DW_PCIE_XILINX_MDB_VSEC_ID		0x20
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_BAR		GENMASK(10, 8)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_MAP		GENMASK(2, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH	GENMASK(9, 0)
+#define DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH	GENMASK(25, 16)
+
+#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH	0xc
+#define DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW	0x8
+#define DW_PCIE_XILINX_MDB_INVALID_ADDR		(~0ULL)
+
+#define DW_PCIE_XILINX_MDB_LL_OFF_GAP		0x200000
+#define DW_PCIE_XILINX_MDB_LL_SIZE		0x800
+#define DW_PCIE_XILINX_MDB_DT_OFF_GAP		0x100000
+#define DW_PCIE_XILINX_MDB_DT_SIZE		0x800
 
 #define DW_BLOCK(a, b, c) \
 	{ \
@@ -50,6 +71,7 @@ struct dw_edma_pcie_data {
 	u8				irqs;
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
+	u64				devmem_phys_off;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -90,6 +112,64 @@ static const struct dw_edma_pcie_data snps_edda_data = {
 	.rd_ch_cnt			= 2,
 };
 
+static const struct dw_edma_pcie_data xilinx_mdb_data = {
+	/* MDB registers location */
+	.rg.bar				= BAR_0,
+	.rg.off				= SZ_4K,	/*  4 Kbytes */
+	.rg.sz				= SZ_8K,	/*  8 Kbytes */
+
+	/* Other */
+	.mf				= EDMA_MF_HDMA_NATIVE,
+	.irqs				= 1,
+	.wr_ch_cnt			= 8,
+	.rd_ch_cnt			= 8,
+};
+
+static void dw_edma_set_chan_region_offset(struct dw_edma_pcie_data *pdata,
+					   enum pci_barno bar, off_t start_off,
+					   off_t ll_off_gap, size_t ll_size,
+					   off_t dt_off_gap, size_t dt_size)
+{
+	u16 wr_ch = pdata->wr_ch_cnt;
+	u16 rd_ch = pdata->rd_ch_cnt;
+	off_t off;
+	u16 i;
+
+	off = start_off;
+
+	/* Write channel LL region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->ll_wr[i].bar = bar;
+		pdata->ll_wr[i].off = off;
+		pdata->ll_wr[i].sz = ll_size;
+		off += ll_off_gap;
+	}
+
+	/* Read channel LL region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->ll_rd[i].bar = bar;
+		pdata->ll_rd[i].off = off;
+		pdata->ll_rd[i].sz = ll_size;
+		off += ll_off_gap;
+	}
+
+	/* Write channel data region */
+	for (i = 0; i < wr_ch; i++) {
+		pdata->dt_wr[i].bar = bar;
+		pdata->dt_wr[i].off = off;
+		pdata->dt_wr[i].sz = dt_size;
+		off += dt_off_gap;
+	}
+
+	/* Read channel data region */
+	for (i = 0; i < rd_ch; i++) {
+		pdata->dt_rd[i].bar = bar;
+		pdata->dt_rd[i].off = off;
+		pdata->dt_rd[i].sz = dt_size;
+		off += dt_off_gap;
+	}
+}
+
 static int dw_edma_pcie_irq_vector(struct device *dev, unsigned int nr)
 {
 	return pci_irq_vector(to_pci_dev(dev), nr);
@@ -114,15 +194,15 @@ static const struct dw_edma_plat_ops dw_edma_pcie_plat_ops = {
 	.pci_address = dw_edma_pcie_address,
 };
 
-static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
-					   struct dw_edma_pcie_data *pdata)
+static void dw_edma_pcie_get_synopsys_dma_data(struct pci_dev *pdev,
+					       struct dw_edma_pcie_data *pdata)
 {
 	u32 val, map;
 	u16 vsec;
 	u64 off;
 
 	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_SYNOPSYS,
-					DW_PCIE_VSEC_DMA_ID);
+					DW_PCIE_SYNOPSYS_VSEC_DMA_ID);
 	if (!vsec)
 		return;
 
@@ -131,9 +211,9 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	    PCI_VNDR_HEADER_LEN(val) != 0x18)
 		return;
 
-	pci_dbg(pdev, "Detected PCIe Vendor-Specific Extended Capability DMA\n");
+	pci_dbg(pdev, "Detected Synopsys PCIe Vendor-Specific Extended Capability DMA\n");
 	pci_read_config_dword(pdev, vsec + 0x8, &val);
-	map = FIELD_GET(DW_PCIE_VSEC_DMA_MAP, val);
+	map = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_MAP, val);
 	if (map != EDMA_MF_EDMA_LEGACY &&
 	    map != EDMA_MF_EDMA_UNROLL &&
 	    map != EDMA_MF_HDMA_COMPAT &&
@@ -141,13 +221,13 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 		return;
 
 	pdata->mf = map;
-	pdata->rg.bar = FIELD_GET(DW_PCIE_VSEC_DMA_BAR, val);
+	pdata->rg.bar = FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_BAR, val);
 
 	pci_read_config_dword(pdev, vsec + 0xc, &val);
 	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
-				 FIELD_GET(DW_PCIE_VSEC_DMA_WR_CH, val));
+				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_WR_CH, val));
 	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
-				 FIELD_GET(DW_PCIE_VSEC_DMA_RD_CH, val));
+				 FIELD_GET(DW_PCIE_SYNOPSYS_VSEC_DMA_RD_CH, val));
 
 	pci_read_config_dword(pdev, vsec + 0x14, &val);
 	off = val;
@@ -157,6 +237,64 @@ static void dw_edma_pcie_get_vsec_dma_data(struct pci_dev *pdev,
 	pdata->rg.off = off;
 }
 
+static void dw_edma_pcie_get_xilinx_dma_data(struct pci_dev *pdev,
+					     struct dw_edma_pcie_data *pdata)
+{
+	u32 val, map;
+	u16 vsec;
+	u64 off;
+
+	pdata->devmem_phys_off = DW_PCIE_XILINX_MDB_INVALID_ADDR;
+
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
+					DW_PCIE_XILINX_MDB_VSEC_DMA_ID);
+	if (!vsec)
+		return;
+
+	pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
+	if (PCI_VNDR_HEADER_REV(val) != 0x00 ||
+	    PCI_VNDR_HEADER_LEN(val) != 0x18)
+		return;
+
+	pci_dbg(pdev, "Detected Xilinx PCIe Vendor-Specific Extended Capability DMA\n");
+	pci_read_config_dword(pdev, vsec + 0x8, &val);
+	map = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_MAP, val);
+	if (map != EDMA_MF_HDMA_NATIVE)
+		return;
+
+	pdata->mf = map;
+	pdata->rg.bar = FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_BAR, val);
+
+	pci_read_config_dword(pdev, vsec + 0xc, &val);
+	pdata->wr_ch_cnt = min_t(u16, pdata->wr_ch_cnt,
+				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_WR_CH, val));
+	pdata->rd_ch_cnt = min_t(u16, pdata->rd_ch_cnt,
+				 FIELD_GET(DW_PCIE_XILINX_MDB_VSEC_DMA_RD_CH, val));
+
+	pci_read_config_dword(pdev, vsec + 0x14, &val);
+	off = val;
+	pci_read_config_dword(pdev, vsec + 0x10, &val);
+	off <<= 32;
+	off |= val;
+	pdata->rg.off = off;
+
+	vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_XILINX,
+					DW_PCIE_XILINX_MDB_VSEC_ID);
+	if (!vsec)
+		return;
+
+	pci_read_config_dword(pdev,
+			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_HIGH,
+			      &val);
+	off = val;
+	pci_read_config_dword(pdev,
+			      vsec + DW_PCIE_XILINX_MDB_DEVMEM_OFF_REG_LOW,
+			      &val);
+	off <<= 32;
+	off |= val;
+	pdata->devmem_phys_off = off;
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -184,7 +322,29 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	 * Tries to find if exists a PCIe Vendor-Specific Extended Capability
 	 * for the DMA, if one exists, then reconfigures it.
 	 */
-	dw_edma_pcie_get_vsec_dma_data(pdev, vsec_data);
+	dw_edma_pcie_get_synopsys_dma_data(pdev, vsec_data);
+
+	if (pdev->vendor == PCI_VENDOR_ID_XILINX) {
+		dw_edma_pcie_get_xilinx_dma_data(pdev, vsec_data);
+
+		/*
+		 * There is no valid address found for the LL memory
+		 * space on the device side.
+		 */
+		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
+			return -ENOMEM;
+
+		/*
+		 * Configure the channel LL and data blocks if number of
+		 * channels enabled in VSEC capability are more than the
+		 * channels configured in xilinx_mdb_data.
+		 */
+		dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
+					       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
+					       DW_PCIE_XILINX_MDB_LL_SIZE,
+					       DW_PCIE_XILINX_MDB_DT_OFF_GAP,
+					       DW_PCIE_XILINX_MDB_DT_SIZE);
+	}
 
 	/* Mapping PCI BAR regions */
 	mask = BIT(vsec_data->rg.bar);
@@ -367,6 +527,8 @@ static void dw_edma_pcie_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id dw_edma_pcie_id_table[] = {
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_VDEVICE(XILINX, PCI_DEVICE_ID_XILINX_B054),
+	  (kernel_ulong_t)&xilinx_mdb_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_edma_pcie_id_table);
-- 
2.43.0


