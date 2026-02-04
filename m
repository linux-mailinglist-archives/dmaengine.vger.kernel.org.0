Return-Path: <dmaengine+bounces-8712-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPJAH30kg2nWhwMAu9opvQ
	(envelope-from <dmaengine+bounces-8712-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 11:50:37 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E54E4C77
	for <lists+dmaengine@lfdr.de>; Wed, 04 Feb 2026 11:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DC1302F271
	for <lists+dmaengine@lfdr.de>; Wed,  4 Feb 2026 10:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B923B961C;
	Wed,  4 Feb 2026 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xL58ZYch"
X-Original-To: dmaengine@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012023.outbound.protection.outlook.com [40.107.209.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF99396D38;
	Wed,  4 Feb 2026 10:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770202192; cv=fail; b=WQrkGxqwnyyWTH2nL08fCd5NKo5klAoEhn/s+iSu5zPU3duI+cmoxN8XDeBd1G8lbuVzX/5hkUVVZabrgGc/vt3qc0iPFwB+V0cB6ldzIB85rTkknbJZhGLQ5tmLNDuhZ8Z4yiqKmYTGpxEhLO+ees49ryr5+Ck/T2hpUIrgdyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770202192; c=relaxed/simple;
	bh=cVBy2T2l/CYFXcuiALH39gtIvId9XDuEfxcEAx/Nf4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n61H0LHunyenC5MZx164/5QiMEaNGPtoxaczwPwnyJCqtMk5yZmpZLQysHlZZddTRvytnv8KaY1rJDiqKqgGm376cDyySA7h/QfOIaG/bmJ14P7sTR4jawCg9A8Jrc9Y9GADr/ike+sp+iFBDqa45BjSzz7fqR4r926MlqT7vAg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xL58ZYch; arc=fail smtp.client-ip=40.107.209.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGs//ES08PugqmLMrPN/ktna2bYmKATxMwjRVhk1K0T2OZzBGTE62jcFjkwjQrnhLwPLR9qme/qGRmYHu5Ou1GrMZBRcFqHTGR91pT2yBkG/+fwuYS/1UI+mysWV4mMRJezqzsy3NmbtnmDc1JuhweOJp9TpcrN8xKIAF6PE36kxtSk34c9QjlpqfH878oxTiFunTk6IsBuCsAPaHkEmXrbeSdFUF/dc9kkj2yMH2ZGcYKH3n6As6ALP++zGphBR5VKMyP9D5Hx0QfRe3h7q91g91aDTnOHLARot7DiB7iAxASxJ0Bz1r3G2Ow9TizYkulD38Avf7TmoPxAVtMCBZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAHifbdgUf11x7ADrBrBtfxXXcDrXcJ2MCbbaRQNO/g=;
 b=UaUN/nv3gmX70oiDCBQWAeiHnR7HXuWL+2TIoK/inFB56q2mPVKRSCMsuJV8sS79IKFw9SlMtELnZS7mHHXoNARpGBIjO/fbkNDX/AbrMVU8PG9vREcTHEizGkxmjIuqLtlswubG8ayl5qYGRtACOs4GVCXQCvkM8uqViRapc50Unky9Wk8Bw+ifX8D9AkoBuAHYRxq/w5NAwkvHKUO9VbHb86Fnq8QSx5qDNr0Lp1zB9ivu56GEi1FkBhtrTEzWbNfTVXlatLsY2InrLQaePNbJ8fi7zhRASZVOX7seYQyionmCWGksOYmiuWCUped0nrnOTXzSBUq820Hv3h2N+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAHifbdgUf11x7ADrBrBtfxXXcDrXcJ2MCbbaRQNO/g=;
 b=xL58ZYchnN2RZHp2j87noehzDPvyW+qcwkdTilGHyMmzb4NYTCheZA1oeWhg8R9OeT4sP/ySmGULkzy1s8uDBzJx9wlfuZoQ2J8kXFXUV4CmUPJh8OlAt0gyDcCidio6u89tkZorY6JAlUi9ewK2dNUf6ynbZTnwHs8FkS8nYf8=
Received: from SJ0PR05CA0164.namprd05.prod.outlook.com (2603:10b6:a03:339::19)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Wed, 4 Feb
 2026 10:49:47 +0000
Received: from CO1PEPF00012E7F.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::11) by SJ0PR05CA0164.outlook.office365.com
 (2603:10b6:a03:339::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Wed,
 4 Feb 2026 10:49:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E7F.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Wed, 4 Feb 2026 10:49:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 4 Feb
 2026 04:49:46 -0600
Received: from xhdapps-pcie2.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 4 Feb 2026 02:49:44 -0800
From: Devendra K Verma <devendra.verma@amd.com>
To: <bhelgaas@google.com>, <mani@kernel.org>, <vkoul@kernel.org>
CC: <dmaengine@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <michal.simek@amd.com>,
	<Devendra.Verma@amd.com>
Subject: [PATCH v10 2/2] dmaengine: dw-edma: Add non-LL mode
Date: Wed, 4 Feb 2026 16:19:33 +0530
Message-ID: <20260204104933.33179-3-devendra.verma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204104933.33179-1-devendra.verma@amd.com>
References: <20260204104933.33179-1-devendra.verma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7F:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: f64d8e55-118a-4561-d1ad-08de63db1d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AGpHU2K3XBgJZ05xWh21ZEK/NTcXZD8xD3LJee239/mk89NW+OyH4gO+kipY?=
 =?us-ascii?Q?oycexrG0eXeHfnuqXL29LcaG/bTGTUCbLM4ywqqutbmSG9MI2uUBsLRIwWn0?=
 =?us-ascii?Q?+MWTyANblp5YOgtn5g4agcXflXlH/7R8pqYuZ9Y1mXmHm9Tkpkn7pT4ig3So?=
 =?us-ascii?Q?Y3dx7ah8TLB+zdrXL1YflaBvXOyX/oFN6tCbEnzYAlahKOAebOKqxxAmeaIw?=
 =?us-ascii?Q?vKsGFIauY2gQc4GZiGRPmBiwyDd7+8XE5fNHUFOdkBuqQOQW/kqpkr7YclM1?=
 =?us-ascii?Q?sOOW721k2gHZ1NQhXoiHP3+mRjIXD6jVxRYEz1y28900/Q49EYElC9z0mqaP?=
 =?us-ascii?Q?cOJWMyaQivlCgDhIF1di+3lOJl6SIWcpfnCXTAMgSisEu9Dwokk9Qk3TCMkG?=
 =?us-ascii?Q?5/pPIBSN7uBiZ9llB4luoSe51Vz8HbaLyMHL9e4ZhVbrK8N15grdWBHJIoLT?=
 =?us-ascii?Q?6wWYkn0GIh1fiASY3MsabGnecp65saXeAqM4Jb8JCBvnn3N2tcceHXolcr59?=
 =?us-ascii?Q?ykWL8O2w7Y/RJ4W95AM0SUsxszSitTl8XPiNN/pEknZL4wgViGFOTrADo80F?=
 =?us-ascii?Q?ftwz/lCiKzQs5s0jWgKoWqTVAC8CqyXcN/egD1/KDKgEuu6TvAivwYR+PxVA?=
 =?us-ascii?Q?fkdNb4s5L8oHkNU1GFYkukQvsBnvIxhmCq5B7Jjr+adZRnyVF+U5hNyHZGuZ?=
 =?us-ascii?Q?jflevLQEVCR58RtiqDmuk5r2gdu0mSSCNd1++a3f1KaUkZIkf6NMAZGdLmK0?=
 =?us-ascii?Q?VKAo83M/nsy7MDFwk8G0cF8i+G0ptcQXtrfUpeafEAwStSvDXqoLebknZrPA?=
 =?us-ascii?Q?d7Na0OQAlVVTRxSiTbf+OKYtm5lrqeJHciRlcp3ew8hj0BgXOHseYzfDvSzQ?=
 =?us-ascii?Q?hXvV+XbU5TSROXMV2JBW6ll9gbKfzH+1voa3ZRp0KHeSuOIkVyK5sVtc0LNJ?=
 =?us-ascii?Q?IY03YSdOm1ZU+oYdLErb+R+12j/PFoQyQ/jDN2wYe6TpxA+Cysq9uygvqVzP?=
 =?us-ascii?Q?MDFH1GnfsuWDjSUuEZiY7McopbFGkfjU51+4eO2s7owZlIP1nl929jIc273G?=
 =?us-ascii?Q?wMuho3S0jAs7xlbVQcUGNtBVf/uXXyLPN3L85d1SMsVBZ/vq8xqFlw0rx2pv?=
 =?us-ascii?Q?rtasnAVBEiW2I2qv+Hl/UXmJ1F3f4XRjHpHpvMm9I9GF6FMfnKAxB5ZnOWhl?=
 =?us-ascii?Q?IocAYHMNRJyyZIi4sajymnvoaKOp/OlryLBrz2c45P41f/9q0BOqsPQQg7FC?=
 =?us-ascii?Q?mVePBnKuFx4TTPvH3xHIpHBZYFMQ74gLYoWyzoipKaZhqLFqJOu4PwPOYk0L?=
 =?us-ascii?Q?3PmUijs27Q54FfcluZI526gv2y7B0LSlX4ao2qeDevmDXkPJluXaJDxaDlR3?=
 =?us-ascii?Q?66uLpvd7CLGjk4MEIOh5zeqY2URBrE7lFRer6HDINdgqE4aPg315DQRhYJF1?=
 =?us-ascii?Q?FNNEXt+japSg80Xj9xMIsCTbOb5X9CJBkeBcF/ovRNfmaVi02VLEJGz2qgRm?=
 =?us-ascii?Q?o3yMogoJy9hMXi+yjhFvtPJ3wysMkOFXHpRSfCrHhuyXXN9nbbmrlMoXTGLs?=
 =?us-ascii?Q?T6/qUI+XG9Vne7Oi7AcQ8MVtbQ/lCS8hxi3Zlz+vWVq+1gOHoheS2OJfu8pJ?=
 =?us-ascii?Q?4PFYuShwOY1JwBwI/RbCAKkclvpUP02jd4TkJXb7S4dJTc+GDntXazRMxO21?=
 =?us-ascii?Q?V/SeXA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DF59NAsSw+y23ara2RP4d93w3vMCl2NMNf0j7iRJ1awuf/CfnOEcS+NjVMjAPT0QaqvonU8vXdNG/jfeXfABr+zo1ynBcNurhMH9DUJMuW3S8ccaXMREB/l/NohOyr3/pJBLwRL8h39C5EcIVHstG4+NwC8blCde9DI8c0uV3AS9B2PuEXVIAplDV3RvLSrjoeyGgjz4z4luZhJ1hrx+sBUDGmatiH0ei1r+4SAZjk/azskpruVQ5x35GMsgj7U8OsaCPwFv9a/+IqD9FworvCuE/mYkeqCBfFfIShw7uJoMSeqBKPiTxVAzD55wKXQisD+On/iiaq7GAtnAtF5Gwrt9fA2xrwXWXUAv6rxukZZ0jyPvMF6ITFX6upiNnRMs4oELxFs1g0YOTKzIee+UJyq5wMj569/oFzExgZ9cy+a4wlFK/XCNG/uuasHoiBcI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 10:49:46.9886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f64d8e55-118a-4561-d1ad-08de63db1d1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E7F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-8712-lists,dmaengine=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,amd.com:dkim,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devendra.verma@amd.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[dmaengine];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: D1E54E4C77
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


