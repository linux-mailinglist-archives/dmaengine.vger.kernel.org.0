Return-Path: <dmaengine+bounces-10809-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MZuITTrE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10809-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:24:52 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD685C65D8
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FCDD30071C9
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD8339D6FC;
	Mon, 25 May 2026 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F1Nk4PfK"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021139.outbound.protection.outlook.com [52.101.125.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5712639AD51;
	Mon, 25 May 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690280; cv=fail; b=ZzwEq82UPeXXxDVxFG5f1mTQQ1hJEExoqcqWQChR8PP78Mymvxt6emxEPbqgR45MvsI2zbcGQdeK8Q0HAsdEie5IHhLdNxJe/uf7h5CdtDcW5M45Aee6cIIg72DTklRakwMTzMrAomutKITLn6LmVru8Xhc7PlA93oaAQl9SCq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690280; c=relaxed/simple;
	bh=aEzJUU5qqmOdnnGHT7yfOOaIMKdecQh6SOws1eP9YSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gRrbt/su8xkV4IlSjMUrubOMovcfp/7ztRrS/kjhhnaPYxDoPjktLJTtcQNKu1OyP648ybd1vY77ZB14DLYtlwsuQYScRwrkn1tJyDR4yaLsF8hFTWls/CkocX3HCkLdDq1hIjxSZu4g3iLRvpQon/8ONIPpg3Mow6jHeXAwZIo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F1Nk4PfK; arc=fail smtp.client-ip=52.101.125.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gK2r1UEEaLrg84W9gfAqPUSsOn71mDWNTdQl/3oJfPIbQMl+B0f6Cp2q5Z+PKJKfbDlASBoEeArxH3QMRiY2WXKl3vEdMSmfbnNSI0u23C/a3XD/1pBap8kr1jyMCw6A5g8WTaPn2E3k0TXDUtRyuhs6jrsHxgRKAENoHqvc5bKdWfYt17ymy3cKOTjE+U0tZ8nHV6VDAtyMNRtlp+LQLQE5gUiGwG+zOOVG82YnzGFIcZhn/W8LaPbZIMPtcgmMo1FDbfngWe+kouc/rpib19gGe/qmHAz0CvZdOajtPx0a5ktfxtmmWoXfmyqpXfYoPK64MgFiNv2SuWL1x09ugw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KddqGTnPnZoICr9X6RRjrjjWV2weoLREqdWZM3t8rYs=;
 b=iBG1Pae7ct0rfycO2sDEm4McadMV331TJsFbFdQXWawG7wjy5jiaNDno5YABQL3xmE+Ky6RQ59K6qc6VoALLQjChuJkeGBbF3vYzB6C2K6HBc1oOu5EplHBbYTPZ2tTvanAP11Zpi3JpNVXX6DhSyElpFTldiGnbDXz/Yx9jgt5zuAECgo7JbM4AHbvwAykaSA2mykodhu7u8WsNZwQCMGO41w/5bU82fAW67ZV49j+bKSx1O2J57ubvuzLw1l9cCK/vd0ectQpxsx1cAkBy/TvEyrfQyMh30faQ6foN52UTs1SGp79VC6Sjjz6Kqm/Dep66j/VGQyyqYSQ9XprA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KddqGTnPnZoICr9X6RRjrjjWV2weoLREqdWZM3t8rYs=;
 b=F1Nk4PfK4wIplJNsGCMyvDkLBa6Pn00uxl7r8U1udH9SKYr/BbHznHgLjO0HztSONux0rZG5vVxQgln7m+/RU3BkF2i9zabXfbG5Zi0gZcSn/WCNwkASC7GN/MmByqHkBcdjTG5zDluk4jD3+fifMdC6Gn5plD9+06s+VQvOY9g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7796.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:441::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:36 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:36 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/12] dmaengine: dw-edma-pcie: Track non-LL mode in DMA data
Date: Mon, 25 May 2026 15:24:12 +0900
Message-ID: <20260525062420.3315904-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0086.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: b9993feb-0de9-4e49-f7d4-08deba264b3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|376014|366016|22082099003|56012099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	XfA/BcHnJPBMd4pJfTAhr1YfR+F0++19ZBF6LbZb8dRc9vNb1fXPZulGeg8RTsHAtMn6N/lCdkTEIoa0srl+BnqDYKZ8qdnnrmGr5q57aVxGZ9YcCfSmJbQ7cNsJhljLRh7CqTHYVHmaqeM6nB8ZSOYtZF9iNt9FSlCai1xHSSR6UKV1NalqC0+kIxs8x+nyZ1FTcH7LYQkzzFTrslNgKaOMn6v114Yid67HZm/X6sbD2fB+KvzISzl0ig3Z8E8YLqItTlglw4ikKwDNjjCOPfnMRmuxoW0T42muMcSAgGJ4kciuuYRs7lHCLz4YCDTSOAQjKdvkRaDwRCAZ9mwNSP+s+I2pA8i+kkKoKTIAV2us/J+8tSo2h0+VXXPhxDtaEk1l+o3VY4X+BQvuevEZCChLVZ0JHMcrZFDNbhD+Dl+lft7K916JtA2Jwkt5716oay7HBI848XrNlCn7J2dU4MkyIEw/Q+GukMsRuJfpG/80b2k3QOS7LbD65g9O/vMuzZZy4yDX+m5SWHWsYnnhqQKymb3BRiGXl5CG4iO1ebS1bE8yEKjL4UyICZZlF54pyweXEzkLQINEurum7DHQVH3G4mBedORueLE0N1dr6roBQrMvgcwmcbh3mSF9CYSjaTUG2de7EKQFVHxxlTCH0Mn/kzY/u2nmjQckIOBw5EpqL95JsiWDYVFpQqPDGxg0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(366016)(22082099003)(56012099003)(18002099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pFTt4fa+Fex3V0Bd7OD+bEPe1npUJFPzDc30WQGRODW0zi2EHpdU9+FjrkkM?=
 =?us-ascii?Q?jTxFRKptT4Fk3QQmIovB+pMgPhbbnuWIsxvLBPkdHIRU9/2iRF3mBremCcjL?=
 =?us-ascii?Q?2sdV/nIwvpTBs0qg/4RExZhFLIRmCgX4CHrye9YHnOqQu4aR6fSSfbFrWW4R?=
 =?us-ascii?Q?MvdaPEbDHjdcz1q8m2wjcqluxQmsG5fg7xjkp7c38M8ZCuuBkPPBWZ+6eHqH?=
 =?us-ascii?Q?GCKnMqlIsXFY2Y9hdOMbMraDCTmDG78X9TNv5w+CronyMv6EkUxn+iT+5cxS?=
 =?us-ascii?Q?Kiot4o/FmfhKyM1yK9V2rIw8o9iIv2vl2DYlu1LCpT5dPZfDDWAAFJNnUS7H?=
 =?us-ascii?Q?pqXvSiNr6l5PUIdNbD9Ww5aYThsrVO9Qjl1XrSBLFsUqLmjM/8YJ33c0ofbC?=
 =?us-ascii?Q?DbBbmzvrvk+YaCvA3mclCJ+GTH/aUOdXIaEUw3dSThLmDgl2Bun6PdHR+YJH?=
 =?us-ascii?Q?BJK3r0NVbwPoh86gGqEzIYKXrNgnsBhwmBgSpzFMBcohZu9135q0F//uvAk5?=
 =?us-ascii?Q?U40cM9oFezpPyxtT7Kq8cOvQ3ectPXXxCKiz18mkTKrGKiAVQ5BB14eNDLOx?=
 =?us-ascii?Q?ehD0SvvLxOtkncn/evFvyH1izkeyS3UVkg4+TO12Diljo9QWgTHsV2P8TFqS?=
 =?us-ascii?Q?kMvNp8HfxmRyh+3MU62J7Z2Rsjje14tiuG67VoEGWBrSa8FvSLwB2x2Jbvqv?=
 =?us-ascii?Q?SAXm3BDKOysE9Z+/TN20Mbsov1V1rPev5fZ+ZF/rjaMRLPKkzY/1EcNUHNtn?=
 =?us-ascii?Q?Js0u+21jjzknm6F6sRX+rLD6BoJcSdom9Yr43CaAv0hDea53uS8PAiKZ81gN?=
 =?us-ascii?Q?EnEgj/kr/Rsv/XB9WHua4/oDAS/jHVJ4nXbcLvoEOeuZUJ9hBEAJpTZxW7lZ?=
 =?us-ascii?Q?Sq/tejr2EX84kvPnbyvvAtAhnj/6P++qkKlBuzSgycbq/ScDOpalB1KbOCOY?=
 =?us-ascii?Q?FvGOo2mRMtUDQw9gZpt3FfUyb6VJeSplvIS0KmDcapcMkMjXfMGUnx6r1cTB?=
 =?us-ascii?Q?iw/XkHCMeiSi0Rvgsljz7YY9u0IdRbST4rtQGs4A9IDD/BmUqz56HrFyjjnq?=
 =?us-ascii?Q?BIuIWaJ32uVRpQoWkLbRml4u50PUsNns0AbkWV8InuOHHQMfh0IjHgirHLDI?=
 =?us-ascii?Q?zxTJr3aN3t6XCSV9gcwRKsFVPJu21JnKryLk6XOgVDH8S7trjw8olh0JWcig?=
 =?us-ascii?Q?qnqJUbi+6UWjMLyal5cJOGGZen9FDTAFNy3k1XdcWGO7lhWqtHijMh9lJCww?=
 =?us-ascii?Q?H8ILvTjQU3u/hIdXRDmprKe6JwQwZP1V+AcUOKAqDkcmSxVZ8hwUSbobbcDY?=
 =?us-ascii?Q?ooHcazjOucwHJnjeoyQjghN+Y4VT+BHx0ndbEVlXcv5OkhUvEiKwbQJaSJFi?=
 =?us-ascii?Q?a3ReXc2qJ6XXzqtCo82lN98mW/AATcPTudY39ZHYMA53NJ7zddAlqZa4CmUG?=
 =?us-ascii?Q?ELjXl3PExFLWSaFfLOvu6Ya/zaJ20LH1+06vgjCk6m8Tw21tWmDz0zzTIKpw?=
 =?us-ascii?Q?5IHqNF6ed34mRSFr8cvZqR7wKbgKiE3ff80xDeVcQOfETGKwNDWUhuXrUIA7?=
 =?us-ascii?Q?4xGSpOySZN//5jbnauBQdMzyMiApo1mPmN9HVqH5Rp0BdRJXtcjG/rz1/SfL?=
 =?us-ascii?Q?hA0XQmxjd8Xcszbw9aKjtlymPZUXapU0FQiiBTkbomAk2oSwTJOz4pC1DIew?=
 =?us-ascii?Q?vxTy7RtWVaTCahwlgddF08J5Bn7KpCXd8dVhMrxA+fAXYYco+KZYibmcBQ5K?=
 =?us-ascii?Q?/stQnpj3ujIXPmh6LQkWu3N+b7CnhH+llxl0BWhxfXJwawKPPtyF?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b9993feb-0de9-4e49-f7d4-08deba264b3d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:36.7722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRJfzBVw1waQSJdPuCi3ErnYqc6jszCSDCIoklGxKPC2yyhRx9rsrUe+6g38T1kZ/0HYvTSyWdYMTIMmC9k9fQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7796
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10809-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DD685C65D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The dw-edma-pcie driver copies static template data into a mutable
dw_edma_pcie_data instance before applying capability-derived updates.
Keep the derived non-LL mode in that copy as well, instead of only
tracking it in a local variable in dw_edma_pcie_probe().

This prepares for keeping capability parsing behind match data without a
separate non-LL output parameter.

No functional change intended.

Suggested-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch, per Frank's feedback.

 drivers/dma/dw-edma/dw-edma-pcie.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 0b30ce138503..e92ff5dc6f67 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -72,6 +72,7 @@ struct dw_edma_pcie_data {
 	u16				wr_ch_cnt;
 	u16				rd_ch_cnt;
 	u64				devmem_phys_off;
+	bool				cfg_non_ll;
 };
 
 static const struct dw_edma_pcie_data snps_edda_data = {
@@ -312,7 +313,6 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	struct dw_edma_chip *chip;
 	int err, nr_irqs;
 	int i, mask;
-	bool non_ll = false;
 
 	struct dw_edma_pcie_data *vsec_data __free(kfree) =
 		kmalloc_obj(*vsec_data);
@@ -344,14 +344,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		 * the HDMA IP.
 		 */
 		if (vsec_data->devmem_phys_off == DW_PCIE_XILINX_MDB_INVALID_ADDR)
-			non_ll = true;
+			vsec_data->cfg_non_ll = true;
 
 		/*
 		 * Configure the channel LL and data blocks if number of
 		 * channels enabled in VSEC capability are more than the
 		 * channels configured in xilinx_mdb_data.
 		 */
-		if (!non_ll)
+		if (!vsec_data->cfg_non_ll)
 			dw_edma_set_chan_region_offset(vsec_data, BAR_2, 0,
 						       DW_PCIE_XILINX_MDB_LL_OFF_GAP,
 						       DW_PCIE_XILINX_MDB_LL_SIZE,
@@ -404,7 +404,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->mf = vsec_data->mf;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = &dw_edma_pcie_plat_ops;
-	chip->cfg_non_ll = non_ll;
+	chip->cfg_non_ll = vsec_data->cfg_non_ll;
 
 	chip->ll_wr_cnt = vsec_data->wr_ch_cnt;
 	chip->ll_rd_cnt = vsec_data->rd_ch_cnt;
@@ -413,7 +413,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	if (!chip->reg_base)
 		return -ENOMEM;
 
-	for (i = 0; i < chip->ll_wr_cnt && !non_ll; i++) {
+	for (i = 0; i < chip->ll_wr_cnt && !vsec_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_wr[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_wr[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_wr[i];
@@ -440,7 +440,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 		dt_region->sz = dt_block->sz;
 	}
 
-	for (i = 0; i < chip->ll_rd_cnt && !non_ll; i++) {
+	for (i = 0; i < chip->ll_rd_cnt && !vsec_data->cfg_non_ll; i++) {
 		struct dw_edma_region *ll_region = &chip->ll_region_rd[i];
 		struct dw_edma_region *dt_region = &chip->dt_region_rd[i];
 		struct dw_edma_block *ll_block = &vsec_data->ll_rd[i];
-- 
2.51.0


