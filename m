Return-Path: <dmaengine+bounces-11660-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NDpbMYfHNmoaEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11660-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C47B6A945C
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:01:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=jeWpT5jS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11660-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11660-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CA3C33006456
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A042690D5;
	Sat, 20 Jun 2026 17:01:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A7D254B18;
	Sat, 20 Jun 2026 17:01:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974881; cv=fail; b=OJhJMXhLyECDV3Tzek51QsRqsIR++qhr9T+2VbFP9lnHIFNjrl9SloK9baeWevuDaPDpI3b/m4BRUy9fg7Vyq1VLdZ8MvMvsaML7pZhvcb3C1lmIj60JHinyuC/vIR6NcFyGgPJauM+MxPqh4I2qjhiuhSzVfA5ZQR9QLn7/RBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974881; c=relaxed/simple;
	bh=wKa4fRnieVi1xvWm9ggxGSUz6JMMgv5KPooC5Le8OQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y7britwReF65fPTET3yEkAzbCFig4Pi+xNieUMxxFRvzgHSYU+NXkFcqKhbhFjZMyFC1nZl3K0cBJMYIofuZxJ20ReJW8+quWmnaGRYyKrqU3cyrhBNHbLBJy8axk+PIJ99mJ1zLSG0pep2qmXgZG0ejJszPYL5VUHD0iiw6K2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jeWpT5jS; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLE3uuahO2EgFNfkjluCzE4vuKX3GRWx4W/uuKk8aRzPgRgA09c3guQL+sCRiVXU1uxNNclo97LRlIXZWfkCEmvztfU7JmizMlbbLeF9uLelH7Dfw//C2jsOh/IWwyR5dNS8dCMdXNSHZrF86rr8Ngmt9tApRnxadtS4qHuNwaDThZfbKlBSNO5lBvn5wKZOCD4la1QAkUpzHmK1NXMxkU8PXC1Lt4NtYAxQta+HEkxpApf42xC0T6/Xt28G+K2Y4O3eRXJQOP/oNobFuJtBEUYfdF4Uq+ghvySekhWNs+CAnjr/Vuxq83egkLjMvOqa+rmbnB/joBKCaBZUE1orSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6JCR2oph5YqN7qt+4oonnRn0Y8XI17j1iYdGGwr/GY=;
 b=gFmc0YO+PXty6W4KOBJoLt/B4HkZ574U7Z33M5Lx3IlIKbG50rI5r28J9fws53u94S1MOJ10LmV2K2xvpZBTqRTjMjg61/2EQV7N58mi+OWm0fFdGKAcUFeeeEEgiTg4hMEQMkoLb+T2tEH+Y8hWLbyPW0twd7A0MKSfcODQRmA5CRxPlV0xcwgwzUB1ge3Yvil8k+akePwDhhu0tWhnWXgJNogLfDMv4tEtfQVR2Vfb5MpCLIEZETm5GKHicdV+GNlhqHU2/zjwErpcCBt7LY5SfFcXxarLqefVu079t08bNNOdmy/YNjNDqH7DAdPQzw1WzAY7LT4MN2kMkWSlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6JCR2oph5YqN7qt+4oonnRn0Y8XI17j1iYdGGwr/GY=;
 b=jeWpT5jSWd3EZM1ZAwMz/cTf3VF/8Qt7N8DeeOwEErQ1mj/4qcQHi2BTuDlfB0hHFJPXhuUM6utObPLhHVUMaVg/XSclpaZgO3nzXb/8+cvVNuu96JRwCyOxQ/LBlbylWq0siYoodVM96Ym4yld05rxCmjU/tstNnDeH/HcXDeU=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:01:03 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:01:03 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 13/13] dmaengine: dw-edma-pcie: Add chip flags to match data
Date: Sun, 21 Jun 2026 02:00:40 +0900
Message-ID: <20260620170040.3756043-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0042.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: b08f200b-dbf5-4984-679b-08deceed82fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lWrHmb4ZdYX9lctvZliUCPaimtxWiua4AnSQ4lOL5UlNqc5YNdbOIQEQO+XeHxqJalV3C7YpeSQ2/h+aMysOM1lYmkBgemHIUk7bzBi1kRVmCFN0Ep2kSKVUoIFOvUHU4e8XEh1oeYtne2QxL3ZXyV2Czb//aNDOK5apki36wdwBZ+5O8P3VPtnyj0P1gquG2gizSUjYbDAPI2H6X0yxoLtk9rDlGzpTp6CxXWdDok7ExWmaui+Ab7fsuy0apZkDb5A97Q34tlFvaXgaW3AfMpOJx4AEzErC97Xi6uKXLukC7ZfeQbaAmK6dLx+I+ZiR/t/ZEp967ScJoeCDPn78DPaESEmsyLaeu7HSas7LHehFtvA/K85DEfWx33rWIiJVJaXqnThuVlHQpjf+Chcv+ec+lyrUsuJYeNh7E689jxywqi9DX11DVeFbeg9H7AZEOaU+BzufOLwtglBTPUqhIAxLrFiu+pkIjWA+puECTB97+rI0mqaS8CbME/ExRsXoVvNiPMUPTAl6jSpIBbyQS1UxTuHn/UZwTEU/Q64sd2zFs/v2N7bMfNHzn8YBsNzAnGZHg/irVx2TsIGcHEjDT+GTrsDvRmi7WRFRGnZO8kS/PF2UAi+ZeJu9Nm+6BqhR7pmatcpqiv+M6VYdllRtLk5xyMOwP/cY0bQvduhDvvQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?osLGlfQwWs8LLbHOV0rPvbfr1doxBAEmtb4h2Q0j2i7To9zOVZvKkdfR/no1?=
 =?us-ascii?Q?j/TGBXsyTKbiR9rLY0ZMNFZfro18WBoQGYrtWByycu+KeAtcDc7g67KKkFPM?=
 =?us-ascii?Q?5dIzMdwpy3PICOhboimo4BNf9Fiaay+mujHZ3K1Xc/ni/lw1w4fYWE8wOeE5?=
 =?us-ascii?Q?OMR0irLX8f8ykgL4R2Kq0Df1Lxh5QvU94RgjAPKx1iwOWAfzpbcehit4lk8k?=
 =?us-ascii?Q?Vk3989Oi+U/c0TcnSmXstBWM7EpQH2oT9kVvDXw7xR3PV7JJI7nd5PfHVJtx?=
 =?us-ascii?Q?L5amMKKE1LQN5tYgZIVf3UyQeJ57oABMftQ/rPMxhxXUHd1yEhcA/VlWi8QX?=
 =?us-ascii?Q?1hy3UaQuoPErQgf5GXrrl/2r/6Pd8Utvc2kBPgpEAhqji9+g66VKe5NqBVO0?=
 =?us-ascii?Q?o+7AbOiwAqhXNpuJvpwfPTU4YlKLB5l2BUOq2H28acd6mjLMkdddnzgcbrwQ?=
 =?us-ascii?Q?zjDTOwxbBgAYlENMsTr0QotKD/+9Lfl/g6wVIS0kaZmpZ1AlT5/p75qlNXMa?=
 =?us-ascii?Q?0Gx5kUuncRk7a5g3scc5oWAMMcQ5g/3YKOzZ9ua2HxN6ZQ2u/P6NwLJXbN22?=
 =?us-ascii?Q?YJE3IdH3bsQm/d89ez/l+9FiiyN4G0lqNQsUy7TeoxMvFMJUCqNVVCUmiKXS?=
 =?us-ascii?Q?FKYrMd3toPKYpjvrKfhygvn191FMhA3WD5w2dRPKJs6zVnxnRhHQp6ZEhNFu?=
 =?us-ascii?Q?PAQ43wxHkMIoe22tgf7KAuHundVOQ4UJnoPhAAbPTWIEtWjv5/p03wbRk58O?=
 =?us-ascii?Q?FMMnHgYRPFvMZe+edO1uzc9vHAi/cFJnCvrEIvwqfUSMX7AUd5yvnC90rqqk?=
 =?us-ascii?Q?uNJyL9aQnBuRcaF2xbiZC+EFDoUHJ6WuLTyvWI3BTBToNfwe7fs2gUzpDA0g?=
 =?us-ascii?Q?7HjMjoblsumgiizpDKqTOQsHZHSQy+gALv1xDg756NMET9a8RqQiJyt26e+6?=
 =?us-ascii?Q?DaMQCG8LFNeH26fNQB1yyB052OHj8HGxBrhjpimcSAPH43OionM+QUOKlrDA?=
 =?us-ascii?Q?yywVnb0aD+pCjrxwkmmGqSqO3HaRoqYzfq3xzQZwxrtelrN1baAtcT7+Gjil?=
 =?us-ascii?Q?f6GHLst30LtyvqQ8T4XoH+z1X909Sy2p3K8mRLAcOJcmq/0MzEO8+BExQKpY?=
 =?us-ascii?Q?B0z55ywQW4BtUcYRe7XkEPlo7S0d5+61iaMJ8d4gSIgviezbMs97ZxhhcK59?=
 =?us-ascii?Q?C18BQaUOGMTO8TAOhYlvU3+LJvtFs8FBj5LSjr4/Iumcwto0EDRJQh4EZMLM?=
 =?us-ascii?Q?3mAnFEuE8VlDUVrEWtnX8QrNOuGU52LabaxxHNj4tVhQqa3cLA3n2LLbG8B8?=
 =?us-ascii?Q?zMWxwpeVpUjZe/SpP+fZUEMkRa7czchwLILTb+0D8+tQ9aIvG0M99CkFP3f6?=
 =?us-ascii?Q?eP1FUgVokojJ5De+6N4n8ykh2f8WqxLKEaUgXL6EZx4/URKhdJfDkHiheZA4?=
 =?us-ascii?Q?QRJC0kYM27bhDz9x0JvUD9HovJfyige2A0Ekvat5QU5/33IO9QVf9nSpZPMG?=
 =?us-ascii?Q?jaoygbSei7MzOwh+Zajjc2nIyIp/55m/VZDdcmPcb4O+W5+8vMXSL6/oasGI?=
 =?us-ascii?Q?upJ9sB0gYvxNKg1/ASZ2n2TDGBa0S2PIWhPHCfiUB909IwZJpRM/7+2MS81J?=
 =?us-ascii?Q?+sYSkhHGHCUXP6V08EegjCaDoKRzJrPHKnUeFcC8TH9wXLLZkTekBC4QRKxz?=
 =?us-ascii?Q?theSv2mIjjOL/ycgLrqRhXuk1F95sowarDJM83K5FdVci0B+CusqZA3UHKMS?=
 =?us-ascii?Q?bjE/SBRMSYJGLam4UNbRC2e+cgUSpG3Tx5mAyAS9b9gjYmu626F+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b08f200b-dbf5-4984-679b-08deceed82fb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:01:03.3715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vSZI1WTuqa7UnXZY8p8YYtmd0rkG/xEtZGbZqdQu9tZbr+FmJuli9D4ydFA+jzuhqBDCmLGWWtxxCyNGeFW+2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11660-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C47B6A945C

Allow PCI ID match data to pass dw_edma_chip flags into dw_edma_probe().
This keeps per-device policy in the match data instead of open-coding it
in probe().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - No changes since v2.

 drivers/dma/dw-edma/dw-edma-pcie.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 622ec974a521..1e75fefae9b8 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -88,6 +88,7 @@ struct dw_edma_pcie_match_data {
 	int (*parse_caps)(struct pci_dev *pdev,
 			  struct dw_edma_pcie_data *pdata);
 	unsigned long flags;
+	u32 chip_flags;
 };
 
 #define DW_EDMA_PCIE_F_DEVMEM_PHYS_OFF	BIT(0)
@@ -471,6 +472,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	chip->dev = dev;
 
 	chip->mf = dma_data->mf;
+	chip->flags = match->chip_flags;
 	chip->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
 	chip->nr_irqs = nr_irqs;
 	chip->ops = match->plat_ops;
-- 
2.51.0


