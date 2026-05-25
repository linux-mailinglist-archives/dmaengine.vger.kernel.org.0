Return-Path: <dmaengine+bounces-10816-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHj2IvfrE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10816-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:28:07 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 065405C66A5
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32D833041BB0
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952723AA4E8;
	Mon, 25 May 2026 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AXLd672u"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A1239E184;
	Mon, 25 May 2026 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690289; cv=fail; b=RCwIYytjuVc2AVOsL8F8ZDP11Ru8E1LwG5RFrsbTxtcEaim3YL8lFEgCeFedJdqkblWkYK0wa+0fERHjCpwXrR6glOUT6MttpaFOBl1tU6DQqMZbIYVIS8GQ/EwEtBPSj/IAwDy+dS+nKpe0ngxJIW96EAJc/9kf5SG6VPry7uU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690289; c=relaxed/simple;
	bh=aNh2gUSYGcqYj5AEvANPJzA1Xju8eQPeojHq/SPquBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dTnZItDnDhasVa4G48SDK1soiXeqaTTHKs2KGpmU6dcSVojDLit+rH0nLyhVEZBFbh0HuziZNKZoYOSsusEN4ish83lxhMHgSLHw6JKDV9E2HYKwIuqJXHeFbOrxxLYXsbLFFL2C73KAXgO3TeszYfuNGEuSDKvpU0kCUMW+uXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AXLd672u; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XaALXjZg1QYcHEmZBnSizs0rKmj0BHb8S22s7pn7OPrnc6ywTgF4oz9+IzTrXh0+KdS1IIfgJjJ/F5B5r5Q08IVAWxkR2g0jvm4UYfSLQ9V8TVTE7lYA9DK4lM1DZOAiS6UoSmkM0LMchHmjMGjlse1BcX+nmjuuDtFBXq6a5GDD/XmYBcRYSbp/qcDF962yyPQO3Hl0EV6iNKUyBlI3t4cNiJMNJegAKMEpn5OjKRc0lnCMGUGXITnZSY+/pKNFrn1nCaQxXse3F3ujMIyzGhtcfOZxa80JTuV88HerP5APRSmDU227BSMhokTRg/li0nVPaUKmYMv0JKpywR1nCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fIOmihF7eWEPiJAHLKrVtafUTWJZK8OdQbJiOUwCdY=;
 b=LHRuhyaZUuWDLRrwuKNfjY346QPBVnP5QMMC5nqAYGGdnbMGGttvFozNoiK/5+JnfO7hqjeIjnJA35hXk+RixGCT/d+hD215UqnRU2U+WtaashhdHAPWAj7tRT5378aDIwekZkDQE7ow7gTgA786dKVi+q8sICUSCfQH+cdYbp0iZQJ77/n9MlXUeLdSCJGfgIfYCuxIA1t+dnwfr6yYDCCkqMOj40JwKovRnUl0krtbHaHcMdCp+eMfG42mggX0T2zu/PRmDYdYUcjlF92tgmgty293zNf5zJOPbg8rmQI6R/j5CGTi0jjBdzpM4d+YXsZ/9XsjZ3fVrfZfGyv0aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fIOmihF7eWEPiJAHLKrVtafUTWJZK8OdQbJiOUwCdY=;
 b=AXLd672uMAgY7DFEcTKPKdBxqSgtKA/8lNChpEa6tOMtVNXYJZKO80uop04fV3SxYvkanEne1VBaGfCv9mKv3xKkedDY9GqRyokIY2idZNWTMXUlP9YZ72O6ImvgGr4ApBOs0lVlU5ixz0gx64XROXuxC2pvu68rdRO/wGD44As=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/12] dmaengine: dw-edma-pcie: Add register offset match flag
Date: Mon, 25 May 2026 15:24:17 +0900
Message-ID: <20260525062420.3315904-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0331.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f80dbf2-c62b-451c-caae-08deba264de3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	SJUEiVOzsyAM4SGmo1wd7NA1I4MTq47NID7cLcI3UUVhr0mzt2LeCyhT9nLZrrTsDKRiKVOAY/QpsVruNYckXAhC3TDPgxsCX9hV1CTvnBlZBIccvk2SfCClLtCX0oY1PYOiuZlrv53tTB64yVosgXZIWras36i9cnfbv0+xcSw7lJeUEpFHnLOQAlQYpMsA/0a8HAohyz1Fw33M4BFbOlhWGaP8HEUIG3MLOloZPs3vtYtQ+/7EihjVN/DwoJnNzG7r2jLkWvI/MJA4Vr6MYU5Ltxmk3t8SVStjmlnvzt31EI/yvDO7CA0hVN8svp3fO36C3pEOBbWJiz96pB9+5wIMcLuafNCCSRzU/sUgfM8gCH+Rqdam2D9yvWer3qkVhrPHzKs6BlXQqPr6nt/Ad71n0Ievxvnwu6MKIfeTsjONgaDveAXXDKl1vwQSmKweKyh81c7uEPocEoURh2VCp7VCkSQmHHpZbD0zTBZDuhM0VzrIH1CO06E35/7oikPW5WTxKPG/VNcPSrJPiG8X5YW/8Y6mMZaxmVP/7iH0lB1d1JzXaLqGx6ZTP0SKFSpBPTCmHS0LXwdYqEmHQzA/zigWWn+xndCAXVXngDxVX+gexZK5h+eHgruu7nDg20FSwW3xsF2VMLo6T79bNyWn34fSFK5vbzVFvbAZA8GSfYgjf4Ue0SNgQZJs3oRwLI1S
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Skg+u/+mhPTCwTiXjtt6rNACbocYnsLKs7E/yqhBPo39IYn1IYRkH5orVcau?=
 =?us-ascii?Q?oSISvrfv2sNjIM/PUsQKxD8G5krAzXiEPt6ESyjhr109EHzr11cdupKV+YWE?=
 =?us-ascii?Q?QpdwcPwlPLGJUc06+KjcCb2Ng0JLKPmUraS//lU1toH364HUGY/QEMRmn2Yc?=
 =?us-ascii?Q?U2kTzBdYtOaUBAwfSZ1tYO+Dzwtv/QfJT+zhAwwSw3otYhpfCLM4oTdnv34q?=
 =?us-ascii?Q?W2KkNha2FHrj3lMNWVQO9IMqLsOMZBykf70V+T9N3IIPfqNRbMx9uHSxJICK?=
 =?us-ascii?Q?s6GuOnDjGelPCi9RQcuBu8NtIPmRb5f3xR6dP11YFs2nNoLrtQ7hA7FbKyu2?=
 =?us-ascii?Q?IBFgLHuS9pVFZLss+c0sWdezJ8F7Pkicb/X/Qas0X5hmNsSdHsRsU6Juoruh?=
 =?us-ascii?Q?IYCCq7Zj/kK0fv/DJS6bcZ8wxmYrsPI12OLHfczC2LOV1U5eeTdMFUzrXM1j?=
 =?us-ascii?Q?7sf36YtTbzmuwRtot54R6VUeIwTuPBTph3Hgqr/aoXkxuwrauxGgPQIEncyk?=
 =?us-ascii?Q?rDR+n9cqcIriHljieSzt1vQq8GMQmTxnnI8WolMspBuW2AR9wran+s0Bccu7?=
 =?us-ascii?Q?Pa5esPjPioI4wF9sKs6vlF+Lqr3CPhedQlfaI4uoMArXRMvdOC9narvAN/TX?=
 =?us-ascii?Q?P7JKfHmeoEb5ZEwSb1cROJLVeIZ6Yh1ZewrooVQew3ptFa2/UA8DoH2TS41H?=
 =?us-ascii?Q?tzh8qcfGmICe6lkmkZ/yNFaIzWpZIp6Zs5DNLRq56+YUugakSgMsUgVJefmg?=
 =?us-ascii?Q?1lN96tSynsXFDyXLM1qfxAr9FCUdJ7aipRkibV6cFy0LniiildZqqckDZQir?=
 =?us-ascii?Q?NuZk8bedJ48e/6OgHBd86Ud8s79AkJUAMtMz0AB9OcnGLk3LgVCY0Mde6PGI?=
 =?us-ascii?Q?w4atTnKpbAKLn5GblgHHnPhR5bh/48ofzKyDcisnqBKFFtqvCYy+MAKF3ncZ?=
 =?us-ascii?Q?c/uWgGcSFlivzT+bKGKG7o3Rj2O7gDkf06CzMaRd8vMWj21YLOiLTAMq7eAZ?=
 =?us-ascii?Q?4E+taU6JF7/p8buErCxcbtlTdqabg06rpwAA4HVhoZ+Lz+7MKIHd5Trpmt8A?=
 =?us-ascii?Q?BX9X2qZdr9yP2I2XeKo89ipliyk2mupP2n+G2w8rttvuxnIO56MSRiLG1g6M?=
 =?us-ascii?Q?0XCowWUHlywLwLaIx+Dzo5wG/iQfw44uxBH4DiRtRr+501gCALj745w2IY23?=
 =?us-ascii?Q?CbWVCQWven3dVNn6ie5BK4Kpw3sgAb26HNpCg+zyg9d42ixn0/IJOmpglk7b?=
 =?us-ascii?Q?mnD4Wj+JYzN35oxHLlQEQw+6FF9cEp0iSmUyElDuMiqoonixr0pcdu4/eAAv?=
 =?us-ascii?Q?rNW36ZSJCLn25259z2UHpsld1JiGSigowq72jhIiPks70LLUrfLL5wXpj5AC?=
 =?us-ascii?Q?qlEfIx5rbiJD57ZyXjxYVYxTHjguEk9tR+vrzZgiphChxtUXI0sFSRyczDDR?=
 =?us-ascii?Q?I4WOPcn+06yW5jrA4VH09uS8Z8lb5ARCo/Z/dcm3LK0h5QMGQJxAraTUQDRY?=
 =?us-ascii?Q?qNHQH5taBEo8u9JoBWONbnSm4fPkPtuh3AsU7IZjrZ/Lc61u1Bg+FUbKFs4J?=
 =?us-ascii?Q?0jqgWirEu8U/wy+w6nNyldbV5GyX04bDAQ6X4SbBgCZr5Huncp1F85nEQBOZ?=
 =?us-ascii?Q?tvWLhToMMmRa6hCj4d5P/NaNNrJCATIXa1ZZqLvyUZPmUCSdiuZ92hxWPsbo?=
 =?us-ascii?Q?/jR/QhiqoVD2/6KdMt9T9yHQ/R56J+30hrQmpxOzTr/9+Dze4xbAonLOiG0E?=
 =?us-ascii?Q?lYQg+z1yvZKRNtr4WaItL22XLnSgJi+sjKHLgInQZ0kh8nijc2K+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f80dbf2-c62b-451c-caae-08deba264de3
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:41.2446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hw7QFaZcifIhW2zhs6KBnufj1fIdV3Rw3TzG7ZO49mVkcdiFZ0n1xFOZ40zK5yZnpkLBUrBs5uaP+hwxuus2Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10816-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 065405C66A5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a match-data flag for devices whose DMA register block starts at an
offset inside the mapped BAR. Existing Synopsys EDDA and AMD/Xilinx MDB
matches keep using the BAR mapping base directly.

No functional change intended.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 1d63b07723f9..8ba2b3917f05 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -89,6 +89,7 @@ struct dw_edma_pcie_match_data {
 };
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
+#define DW_EDMA_PCIE_F_REG_OFFSET	BIT(1)
 
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
@@ -445,6 +446,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
+	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
+		chip->reg_base += dma_data->rg.off;
 
 	for (i = 0; i < chip->ll_wr_cnt && !dma_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
-- 
2.51.0


