Return-Path: <dmaengine+bounces-10606-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJRcEfWnDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10606-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:36:37 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9690959F7D9
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90B7F30470F8
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0661C39891F;
	Thu, 21 May 2026 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="sHMmRgod"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020087.outbound.protection.outlook.com [52.101.228.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADF1395AFB;
	Thu, 21 May 2026 06:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345093; cv=fail; b=WOeRT3ZV+4INg9rgNFr5SrwuV9QxsTvtf8OyB9NiJezNhwCslbK4rUadrqukG6PRay8V/gh5n+lOvAdtKNo5CW5ZaT3OkoRqkQwuWehTLgA83CFEvU+O6/FYbyTPzblYorIHP+2g1ED1EEL0ZHWd3/AGJeIIEtJNUSzBQnqNoZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345093; c=relaxed/simple;
	bh=4LnvNkcVJ+CYElxCYIVAkGZIDEyexpBhMyE0dX73Xf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oTbCRCc3rk4N9ggRFUP6Vc1YYwA1YvdvR1zzYNPucBOAUwOw0c0/7fb74LGVJWYCaWM6cuHB6wF19B8dfjPGhDnJj5zS+6ttof+MCH+JmEO92yWoEQ7hhXrXMbhUIq99rFaI8CnznQ99eTX249iD3VCjCz4/TlblL/MsBodn9h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=sHMmRgod; arc=fail smtp.client-ip=52.101.228.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iUkTD5zxNMLG/9HRgsoEsvQoDMh9RdDGESrl3qV/u1/KLhv9BysGVd6FYopv1P1tteLN+rvSSJTuEjJE8S+iT4BpiYJBXPJojaFfFWZknLWpoZI5/XkdIu6Fl0UcIXvzSrszcJl9HYzmFq/3gAdKHdNfvOAxEyMGokhoto1FxRYN01T0wk7L5n8PcJly+sxZeqBBZYxCSlmIdahBRW5J91WQGuWUqS5QnMDB1WMHDPKPsG8VWNEw6gek1LErCgK1hIjXVfo92W90KmNAMWn9XDFEi1lBzO5HvyvdZL64Y3lGzS57+adk73bRdBFVNBFKBKxon6tOcbvt0p7YUQ6XCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmnGxT8hcOuayYvFZ21Yr0EFoHoE8p/jb6JY7jK/9xE=;
 b=Xszo/mTbv8sHfJmivvRpUy0meut13V2waQnZ3CVG996JZlhJ/PTLKPD+LJixD9BrY0Pb0Ccn02t5MJH0nKIyPOAUP9gtPZgQkKAT3nVEx5vQY5R2VluoBS6gxTZNQZGJStoqNJB2fbDVlwYTlL12S3qQR4TUXFFMTdVzmq6LHjr+pgbwxGBuCHwiAFf4apTOsBMnp7QKvgcvLWKIA13gQLfUZuwaLFXKfWIX0+0neItoD0Aie/WY9sslsMFEmjQhf6gAKuf6t5rdar0rEhp9IffwX9B85eWPLw2CZGPzmyQAUXsULCxNKi+RcAybeKqZDTdO0wC3Z1pbwGvMlOwPxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmnGxT8hcOuayYvFZ21Yr0EFoHoE8p/jb6JY7jK/9xE=;
 b=sHMmRgodKQZvBaOQMCHcVniYDisNkEK2SXdACzNYVl0NEpzxEAazZvZciari0Z0WokhiY4q76Y8B4shT10ywYqPoACM/70P25pbyUmE5MbP5rkKVHaWSlssmpXlwydeODLqlXlB4O/vN5fls9BHXoAdIRlweywEEg7Wj8LvRAEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:27 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] dmaengine: dw-edma-pcie: Add register offset match flag
Date: Thu, 21 May 2026 15:31:12 +0900
Message-ID: <20260521063115.2842238-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0161.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: 624f2c49-b60a-4f24-33d3-08deb7029617
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	KhLnK5q0br3+7V6oDoNti2dwlaTYudrQ4Ggt6DjbY3R+fq3ho9eqgewatRaw6iUul5KnSY2JGoPZfC/mLtKN+rp2AB2/boQzkood7q1xYq5QUK7Ig53SqjDXY9VEj4L4Sv3by438AJv5GFIpmla+E4F7om17MRkGp4n4b55PBbK0UOynlRTsUMxBNFBwZtgi3K1JmZ550CfBiIhmOhvV0WWDsaxdg6Lgu8A/gN86eXGNJ5x33bgd2Ta2aPtGn1YTBcAW6QFv8/sm5saGFTGSFhKkaCep6OyzRQfXtp7bLMvYDnI7EptdOcBP6P9odmKMmMVWxxRGGqqgrJoWJBNUY76/aNZsbdaZHFkUdzS4GzsnQ7o/yepKKWXV62X6f7QZn+8vFPzFmtycqn1jWCIu9btDA475FVS6UVQAvLuMhianN3hixJm0Y6TgtigwYdlowgcAMcUZk9smLPW866xRlNPiHMDirzCxT1XEn1iCvU9yt4wiQMasuS+yBntSs+gDvATOVXtdW9dnKJGpqeBP1jMOIvRELqIUmPu4wyVs2tHxkxbi5t0KVN2Cd+o6bIA7cEOgylEgeZ0kRcNGV/Gl8yszealJ5nx1CRLpG5LUWIdPtHCeuInYTwlG2fM+NYOk3Z3ZyU5S6GVdp5TsXoxcKZyMY8L5KEZE9OhQqCgh0h37Bp0j7lddTiW9Pa9kVLug
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DeAJssneVIDR8ezSajHeK6bZRevJIwIQI35tnFH5TXAZ3GAoNij3I1gEUXUF?=
 =?us-ascii?Q?7QjZIwpcxlHOyTS93m7SnYvrz53ro62y/KqexGL78seaZixrUPB3Q9ZrTAsc?=
 =?us-ascii?Q?by4cLnKIjcoLOTwmhYSekmoHfxiQXNzBYamcHxm6JcXaOitAvcctxEERhnmK?=
 =?us-ascii?Q?ilNrY89x+5UzgIn2W/gQfOxMhEBCNFUXTy+qLqHgif3qDj6pskXG6mIUxy82?=
 =?us-ascii?Q?jPv5YqHLr4ea4+cvMoSuX3DxaODwPwg5AJY40Bx1R5uoFzkx6EdAuTPtWUg4?=
 =?us-ascii?Q?tSsOIOFSwsJfc65pGPo0JO9vUsXWVA61q+oJ7ZjGqZbU77uoAJe1waopNoSE?=
 =?us-ascii?Q?MTiWRsDf4GRL0yY+lHeOeCfwUKmldRPf8me64rRJaseoupbPXbVOMSm4g06s?=
 =?us-ascii?Q?iqME9QdeKewKm5hZOB5W6WSX2CkOS5RigamlHdB61VsGJYBBae7VBbnGliBG?=
 =?us-ascii?Q?QN6kug7v/NS7KI4gNL7cxv9Yl2opXEawcl9PRC7Fd9LJkCvH6X9bT0y75rPF?=
 =?us-ascii?Q?0gC6US0662sdYEsoUcDejwvQTERVjE2bzKdVtY61pn/UkKsUaRdZ9jhxfecI?=
 =?us-ascii?Q?qqhD0sy/sD4n0o6ZYlo9XIsVGzr2OWr+5fPqTUcKsUTdPrLvVOLEhU4LkiNm?=
 =?us-ascii?Q?QF7bPB0i44JSUdY+O9Co9KvlW0JKzWNPtCv3Jj+90wAbULn0FTP8QXNGsu5y?=
 =?us-ascii?Q?7lrQt3vOLwSvr4VZStH6ytVvSPcU3GQus4sjvvvh4eDHCpItoooUTTXASiaa?=
 =?us-ascii?Q?2G/8+i7Z+ddOFzCxlhiTuSIWVZfYVmFFcYf58UFJUjsH5JZuTwJC26omMYi+?=
 =?us-ascii?Q?p2xJ5j2SDnTOOrnM2mwiU/MsDniAkfJWXXdZlB/oVn8GIH2s6b/8N9koTGkc?=
 =?us-ascii?Q?A2ob6RWTmSVeuz4dkz4+IqkM6WO2cw+mcaxckbQaZCBD0hl41/X57fnqIK80?=
 =?us-ascii?Q?zvGAFngvUWrPGchc/vv2qduT+Wa2BF63UHBwp8Pq4f81YbVdUmGeEd8PCRYE?=
 =?us-ascii?Q?c7zeQRbemfHhqkPVZ019xElkMcKZi3hmsuZyUN8B2GDW8BIC2RSkYyIGMPFE?=
 =?us-ascii?Q?WOecBQLcQswKKpOkoz4tR/ySXzEMXlFSRiBy9pFvafEA/qro8varVbEvMhoo?=
 =?us-ascii?Q?080kLZkd3bYaScUA7y2d6d+Gt44i3tODu4mmU+jl4g9gewwRf8PXyJgmLtMJ?=
 =?us-ascii?Q?8TMh10FqHO7/7JaGhDSsanZmlcuedyScnX56/GohdJ7cRlL9tFx7g9Aq1iCP?=
 =?us-ascii?Q?hfd0MWhpcz8zU6N0biLmj2e52qs89HKIy2bo6EXcgg5kRvJQR4phVwdd23PL?=
 =?us-ascii?Q?rxS309CXz2Ej1qECeo3EB5pxfX0wjPaqNHyopYNf41Cj9MD9eiUfpS/TNC6d?=
 =?us-ascii?Q?bXo/r+kGbG/EnvI+8Cf118ztmL1U+G5dAZscDXH06j9r/w8GHMTMwPFoBhE5?=
 =?us-ascii?Q?19SyVCvMy2e8MLL/0WMbNHkn16Fv6C3WyzTcx1m3mFsH3/5csIaxPhGH/1Xq?=
 =?us-ascii?Q?RebU41lnQUTil3d1tUhT9lX/cRVEpjBdTf+tBp7rNSxpG674fH91Koo1IF8C?=
 =?us-ascii?Q?XwRA6OrVsqh47rT4kX1W2SWXiHYnq3N3ocnAuke6Tuc8kZLanFhxbZXcESHu?=
 =?us-ascii?Q?vIoIqHwRKAmamk+6n5G2Pk/M/TW4aX8OcfwquKoUh8/MZIvidD3dDqQ/cTlO?=
 =?us-ascii?Q?cbIWxCiWkfTmYotbRux1lvJsAm7dUdztoweu/3R7lbFAx/8mJ3B52UTZtqck?=
 =?us-ascii?Q?n9lS4EjWJ9a84qzJ4UrRBPFeSfCqN9qplSSKw0rtL6HuA8mACHzL?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 624f2c49-b60a-4f24-33d3-08deb7029617
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:26.9678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nqc/W++5KN6+Nwc9r+qNZu6LBC/V0R7BZDn68qraGJZL5iYp+zxk4R/N1vLkKahDCY/h59Pt9WfMMfYcU1rRrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10606-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 9690959F7D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a match-data flag for devices whose DMA register block starts at an
offset inside the mapped BAR. Existing Synopsys EDDA and AMD/Xilinx MDB
matches keep using the BAR mapping base directly.

No functional change intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 651269708cc5..6b375a58c550 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -88,6 +88,7 @@ struct dw_edma_pcie_match_data {
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
 #define DW_EDMA_PCIE_F_RAW_SLAVE_ADDR	BIT(1)
+#define DW_EDMA_PCIE_F_REG_OFFSET	BIT(2)
 
 static const struct dw_edma_pcie_data snps_edda_data = {
 	/* eDMA registers location */
@@ -450,6 +451,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->reg_base = pcim_iomap_table(pdev)[dma_data->rg.bar];
 	if (!chip->reg_base)
 		return -ENOMEM;
+	if (match->flags & DW_EDMA_PCIE_F_REG_OFFSET)
+		chip->reg_base += dma_data->rg.off;
 
 	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
-- 
2.51.0


