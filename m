Return-Path: <dmaengine+bounces-5754-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72428AFFED5
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 12:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B3683BD5DD
	for <lists+dmaengine@lfdr.de>; Thu, 10 Jul 2025 10:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DAB2D6617;
	Thu, 10 Jul 2025 10:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5t9v51hI"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64BC2D6612;
	Thu, 10 Jul 2025 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752142366; cv=fail; b=N9jzf52Yj6btf7zIgdaIaqvqNv/xXopkPF+U+A+wIywYg5n3/Gc3BMR2x35IP4n2K9UDl+cDIFuks55Rwacjw+Gmi5RH0kYTYNwfTzMDzfy8tZEFfiFhI4i1e5SA16nmZCCPcNKla8PCW9BcADs35GOZKJKBZgRS/c30zCWResg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752142366; c=relaxed/simple;
	bh=nb4vSaQ+L/QZEZBXLnDUog0TAYBMYLdX1LgGg8R/Ryg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eo2Q1zRNusIWPVeDJoiVl54NzSbwEYGGo9vYy+uTNukUrvyrqfWzPz0J4ljq1CHOvqMegQ0OWfiWWLUcCg/o5ARcfxxE6xacG/Isag193ezeLPwWyLLkWXWNRL51k8/3RZ91XUg6rz+vLkp/mXyv9+f0By7zHNtnBNsZ2/usq2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5t9v51hI; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8sVXOWgz+SAuGXTVSg6Ti2A+4uy7ua81udTxr39vA3INnkbYClR6HqnHaJDK5WXBCExX3rONxZxtX77KQX129OA+hlwlo7Y3kHbWz/3vFOKOgnHQD0bAriF7TI01nSIfpr4xCMoZynd8Jm+kZr/A7QsolkKvqtDCLi3KZSXt3RtJrIcFpyz9IN9exNX15nrZL9vO6DGo/t1XeqdHxBWc8aw7/FfSh2kdBGvb7qSRP0Yiq+p5eFd9/f42bf8XgFE4+RdseqGV2RIvIw6jgd4MbrOqmBwPLd9tDbi/2yB1AdUOsYISe+4Bag6mNu7ekp2P1LGWrMn/i4miNwSPHk9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caB6il4exItnqlVYj9Fp/M/FQOJVmcd8pkpGOmiOTuU=;
 b=yuEkDojChjgAl9Zl6hx6qNKQpDu6J1e/oD/5zN/Pn9Nk9yxPOSY5ldoM7vMRduR0D235ySKYLiMs7m3YsjcxMJYicaKmjQWJ6/GfQxp4MeVeA77CchXWq82E2Mv5IVolwcPKZst+WBBDIi1VdkQAeIWm50yFAelhnGnHiedw85DZRg/3tD+FUCoDBbCl6uCd5H2FTXUe7OZHMaWlud9oeFnWDMatzDddGHhLVtg2EGacRcu0to93/uV9kPHQCBWTDYtQCkMdTZiER6Yd3bweupyLRKmH1P0qhLkUpmvCqbjJnAq7ue/LgqD19qr9P7BnXnrNHs5Qsw8QvVWhzC5pkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caB6il4exItnqlVYj9Fp/M/FQOJVmcd8pkpGOmiOTuU=;
 b=5t9v51hI4/U6c+ftzp6W+nunqEeEdLm7VuVPPbl4StPlqd2mscF8LSHtm11oDO05ktXBXDvJnJtJ4WK+EFvyk2Vuv5+o7yEctnUUUvNUfYSAgAvIHo/6ZoyX49CEDwKWizJijUM/+Ua2hzjMMGif48bGLm0TjCe2mwn8MucXrVk=
Received: from DS7PR03CA0334.namprd03.prod.outlook.com (2603:10b6:8:55::11) by
 SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.24; Thu, 10 Jul
 2025 10:12:37 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::af) by DS7PR03CA0334.outlook.office365.com
 (2603:10b6:8:55::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Thu,
 10 Jul 2025 10:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Thu, 10 Jul 2025 10:12:37 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Jul
 2025 05:12:36 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Jul 2025 05:12:33 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <vkoul@kernel.org>,
	<radhey.shyam.pandey@amd.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<harini.katakam@amd.com>
Subject: [PATCH V2 1/4] dmaengine: Add support to configure and read IRQ coalescing parameters
Date: Thu, 10 Jul 2025 15:42:26 +0530
Message-ID: <20250710101229.804183-2-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710101229.804183-1-suraj.gupta2@amd.com>
References: <20250710101229.804183-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e6dac1-eaa9-4b6b-c0c0-08ddbf9a4bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DrAxGw+IQOJPzrpdfpS3lMkspunPqqWoAt5NIyTH4TL2YyqxasxFcABpd0kx?=
 =?us-ascii?Q?dy1arjkZSspduzj2eugk/1cj5dobwSZsXSvxeeUn1+IEiu8RrNf1/hWW96Iq?=
 =?us-ascii?Q?VnZpIiDrDahPietqw+LF/aNFSu6I+PCYLEW9CUTxVFjiX+k659ZBCS8rFV5N?=
 =?us-ascii?Q?yNzMsF+e1kwhpO9MVuj0fnndY0b+VACuzIs1qXhlJ+l19KHMVd5hrmGI9ho3?=
 =?us-ascii?Q?awgnI8j1GtjB1NivliXrZebMu3UjYnB2rVH4jcT0RIHPx5Ky5Wiz0W5gsioa?=
 =?us-ascii?Q?3jPUHobRUu+cLopLFB6BaBAEzUznRiFsZyE96RU8cPeSyrBeCJuKKEkQ9K1F?=
 =?us-ascii?Q?bthlED3jgHEcOu1S3gfxXtfQFZntmPT7uOp4oXicCMuoLQHWmWsc+URftHVN?=
 =?us-ascii?Q?nokAQNfJCnMdQZI3/u0RNC9VvIClKBzVON9CPN27Ma9aORAHjgOma6WdYvA5?=
 =?us-ascii?Q?JThxPJDMvGpAzlII063maoewID6Xof7J04XwdrhGXnm2vflqfNKpMAsmovj0?=
 =?us-ascii?Q?ZINi8KzQZmsDVIVqaKiSrQXbDOqbFuZPTNh2CoaQKltgeqXWwexk4u75DjGj?=
 =?us-ascii?Q?5Dml9e/jqmHYBRkW8NWLOA6WIHmIHSavyMxuXR4EM/2K/PjEuC1fWeeilMEN?=
 =?us-ascii?Q?bYNqbid/1JNb2+TR0ybmeSoLMYMykjPbSZXb6dCF5CmsaIkSBl4+uvzK/rKH?=
 =?us-ascii?Q?3bgvVzkE7f9gHXxIx5mKo/7cfxE2OlcsfddNqi2t7aRTwSEF4B7w47d01qWS?=
 =?us-ascii?Q?PSUB3hjwZVURvEWplslsAzlFOaz8+H4idh3uGvCXo4gFz5irXMKf7Dgp37IX?=
 =?us-ascii?Q?swtyVv3jK8s2xRNhjyvyiFTsN7uY/m4ACQLZzTvMoJ0kCUBp31XoB8beT5D8?=
 =?us-ascii?Q?j7ZeAnjAZj4N/o5VqyrW5dBXZmc3Qs99cjhzjKm5EJMrC9pYdDKPsmYmEGX1?=
 =?us-ascii?Q?uMiY1RXFB9siMnMtVZrUSpQ2UjMDiZQqkzHbZr/fXsCWPkAxNqEEupxPMw4P?=
 =?us-ascii?Q?W7Weglv0kZ8LGFAyiUkxbNCwvRqLFiaOBnl37KXcVwsNW00ScPmHC89NZWeX?=
 =?us-ascii?Q?Ow7TnLQ93JDNOg01xsOfLZnIcPWGb5W5c6KzueYC5vnLrAk5+1dSNzooy4VY?=
 =?us-ascii?Q?LDfew4WuVu4woHjXWKMzQ60pOn5ImdYAyitaDkl6IC0Ln2sBJPaUvpexAM7l?=
 =?us-ascii?Q?9HsaDDExtZ/yff/JlPHYxUMH5QCx0MGBlNghgXfNRjOoo9PsE2apSQbmljo5?=
 =?us-ascii?Q?LWERlle90o4Xuf1dfnAQo+UWqkzN5m4Pv4x28r92AaoVLbFy+PA2UQ9RCrD8?=
 =?us-ascii?Q?Ys/uJ4z29SzJoWJRxn+kTpvouqsQjSedDYTelNT8ZTwPMtt8gcBCBJaJvcz3?=
 =?us-ascii?Q?dl1n8JPww7HyGqTCyg59bVPbhKbtonO/p2c6pbtjuILtk9/SlNCg3dpGhqf0?=
 =?us-ascii?Q?jGaSiw1SUUDtPBGlFAFA7kjB0U+LTixUddknU45NsTnmCsly3IuQ6TRT6jAA?=
 =?us-ascii?Q?EBZ/BdcFJBfB0us2nvyBXmPqlmyZ1ymsWfvR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2025 10:12:37.1940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e6dac1-eaa9-4b6b-c0c0-08ddbf9a4bb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925

Interrupt coalescing is a mechanism to reduce the number of hardware
interrupts triggered ether until a certain amount of work is pending,
or a timeout timer triggers. Tuning the interrupt coalesce settings
involves adjusting the amount of work and timeout delay.
Many DMA controllers support to configure coalesce count and delay.
Add support to configure them via dma_slave_config and read
using dma_slave_caps.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 include/linux/dmaengine.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index bb146c5ac3e4..c7c1adb8e571 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -431,6 +431,9 @@ enum dma_slave_buswidth {
  * @peripheral_config: peripheral configuration for programming peripheral
  * for dmaengine transfer
  * @peripheral_size: peripheral configuration buffer size
+ * @coalesce_cnt: Maximum number of transfers before receiving an interrupt.
+ * @coalesce_usecs: How many usecs to delay an interrupt after a transfer
+ * is completed.
  *
  * This struct is passed in as configuration data to a DMA engine
  * in order to set up a certain channel for DMA transport at runtime.
@@ -457,6 +460,8 @@ struct dma_slave_config {
 	bool device_fc;
 	void *peripheral_config;
 	size_t peripheral_size;
+	u32 coalesce_cnt;
+	u32 coalesce_usecs;
 };
 
 /**
@@ -507,6 +512,9 @@ enum dma_residue_granularity {
  * @residue_granularity: granularity of the reported transfer residue
  * @descriptor_reuse: if a descriptor can be reused by client and
  * resubmitted multiple times
+ * @coalesce_cnt: Maximum number of transfers before receiving an interrupt.
+ * @coalesce_usecs: How many usecs to delay an interrupt after a transfer
+ * is completed.
  */
 struct dma_slave_caps {
 	u32 src_addr_widths;
@@ -520,6 +528,8 @@ struct dma_slave_caps {
 	bool cmd_terminate;
 	enum dma_residue_granularity residue_granularity;
 	bool descriptor_reuse;
+	u32 coalesce_cnt;
+	u32 coalesce_usecs;
 };
 
 static inline const char *dma_chan_name(struct dma_chan *chan)
-- 
2.25.1


