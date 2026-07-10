Return-Path: <dmaengine+bounces-12281-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2wRpAXuqUGpy3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12281-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:59 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CFB738590
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=tSpnaA5w;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12281-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-12281-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6000A30184E1
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12573EFD14;
	Fri, 10 Jul 2026 08:15:34 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021109.outbound.protection.outlook.com [52.101.125.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A633EF640;
	Fri, 10 Jul 2026 08:15:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671334; cv=fail; b=PJITzpJ3cRJrMkjSgba2ThduZcnGSpvboXHGUT2JPQdIG8cZ0hjaiob3tQGD1GsHrdVLfxg8E8KUmixVpKfDnReng/QudPFyoIFGeBvKtzJGvHazBjC2kn/nloqQaPppYV/kBOXssDy0VZrGZltr7nenKYJY+cW3ovHq4bX2lWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671334; c=relaxed/simple;
	bh=OOPlHPQP1fObd0eYNPRpT/wWhmXGA9mzDeaVEIE7lZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PTKWxqp6J72vfSLoCEEx3IKhGIExcNP0RccfARAdaAUs3Jb80A/Mo/qvRbWhIFDf0wO7noAdCfmwGVitBU31RgoPZJJlmKXkrbU9r1F2+roRz1cV18vt4NXmyBmYx79Cm2Eez5gDPXwOapI2kc8iiA4o+HKBDNXp/7XpsxuH/Kw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tSpnaA5w; arc=fail smtp.client-ip=52.101.125.109
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy9/JSDui4iOri9edShOaJMfoIf1Bj24xBJAKBKUGvEC9LavSP8+Ki6In6FU7nCiyFzne/MKE0uYSRwOGM/GcvSBO0w9k7jp5FeOclp1i84JzKZsygeQPdWr8ueOlxqb6uUlN9nN+4Rx3YumGB3vxo8B0rairxDyC2ntXezYttwN3unbIHKcZT/BwBtjsYpQqgTzDxKI/PhrWaSwHHRPrSESIfcfv1SKbfeb/TRy56YsEElzlXdnCYiOj9/86JhxO78o7HnFMMz9/FYsrp44wgmNZNn/pDq6vTGqJ255wwjS0wlnDEFre+0MkyX4MZXozQIiK2r6QAkdtUnRsjKGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zhom6lqtHa8GXDIUugC67Y2EAA6CJCcOr8PWx1abFSg=;
 b=SNnrhfZ8fZMr1qLaWBT8nvsppYQ47x+m92qQt6JvyLv59cyaVew5+LirCz9RoGNSO4C8+Fr0GO+YPP54JaDqP98J+amndHFUYS0qaH2KslUx7pCp2hD2OIEk3YaqlPv7CDXaIyPEsR8LbpQVp0vdmdpQOCOkmoJDYjYi79Vo+GX0F1iIuyeiAGSh4cok+dLsYY/b+RklADC202hmh1AQN1i2jk3nuWSEWyu040Jxa+ONmGYgs0a1/SmSnGRcfJkG5UMehsfC2K3Jt7FgXoKg3ZYDxGwDwNg5ejU7pHECxVPymKVoO/zTc60V9s4rLb7PERYSBoTXtAxbxSkEiyh3zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhom6lqtHa8GXDIUugC67Y2EAA6CJCcOr8PWx1abFSg=;
 b=tSpnaA5wSbz0WQ0HjV/U1AVygrHcx2fJQ6YONj/8uUm2AOG1ySD22mhnvkyJGuAQDkcLbw+qhfdY5ixu5y1ttIsKgb8RIBV9xhfz60R88WsDia4/bFe7vJAfABJtV3Gr0qIGYZzrnD52wAamPFWLp3Uf5AzDGxQiBdnOQS0Sb9U=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4074.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:15:30 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:30 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/14] dmaengine: dw-edma-pcie: Factor out descriptor block address lookup
Date: Fri, 10 Jul 2026 17:15:15 +0900
Message-ID: <20260710081518.2394357-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0124.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 4050788a-29d5-403f-0c90-08dede5b67e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|23010399003|366016|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qgrgH9NdILqdeBuIzrA0H6YXHwV8mAUoSUtpmp9by/t7XI9ptWNNbJ1g7faJFLONAw7zRzZAtOZgHmf+B++UQ74InYBOWJ1ofXcgeHquRiNLFgZfP4ebTkBCc4dMAg2heBV5oxwFEJlgq+Jyqwnbc3AFOfEVO2br7aeMjN6Wdu8O9ndBhwTzkNrhumP7yQXAqJGmHzPD8HHuHRBPwlfqNylozeZDp+QZU5v4tCYh7f3E3bJXwBecXAlsMYoiDT2qtufEUSCuesWq+Kko2gIm5zhv84cDmW0yu7Eqh6a9FCV/Oy2IDKaXBzsQLRvKqM3QqZOzLF2IzplzuvJmPCsRC7VG+62jIZ1XS5cKgpsb1MJ0BXa1H2qc2iIWufhxI2px5Fr3YD1qtrOvAW/qWuoW0TCJb+y04gUr4BobIFZtCBikbOJ+gUXEvPtLaqLrhx30JvQe0cK570bk9GW0VuubRbUzK4xiZGFprab/+WEUJN1wJXj6F0rmR1z8XbQ0LI9UbifEsqTUD80edUwDOPoOQOpHHx15+GA+DkAS+TKNuAz5hHS0DUpzzEYyfBdLQAUgLajYdXFuQNRK3KxuKTZDIhJxa4AKcvtZ44pIP4cBQjMSLWhgEXAOGuwVF2km43lOU6zfVh0tA95GF6RCHD58z2hDElDGfN+SoHuM4yaZ7UE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(366016)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5AzM8TzekulNUgEeRUtQZ6MzjzFprjmPqlN3PcErcJEwXA+wvGU5vv1Yr1Mj?=
 =?us-ascii?Q?k0ZnoatqjMT1eIue1nqRD6iM7zRgmU87UFw9yqWsf89KWNnOppfiWY7oXoZU?=
 =?us-ascii?Q?wJnAlzJm8GID+IsIXcotROOPZZty8yHyRi5JYAuRJ1PSkEtQKtbVxXDDKlTA?=
 =?us-ascii?Q?b1YHImaCZrKjjmHVWlY5ChTqh4rQAvVCYXKnGsAdYLjQkY6X0qTdUUZf4tTa?=
 =?us-ascii?Q?/MR+EsgiDfohWjj8VwvdwVvmtMNqlaTO4hKu9SwxczBCcVwXqWqg31rRyyBS?=
 =?us-ascii?Q?ncXIxC4NzF5BnfqkL+bbRLUXTAJAgCSV4Ebra/01NszucuPX4ekph6DLfLQE?=
 =?us-ascii?Q?bKD2ntnZ8NQrFx4IKsCWL+ybrgH9Dt1mloELPJ0HqaL5IzUcgpYCyhetReBb?=
 =?us-ascii?Q?b1JOse4nEKme8GgenvAWQWLfIO7DN6pgQeJ2MLlIvEHBYthuyCBf3Oot5o+f?=
 =?us-ascii?Q?pQHm+LsJieLzJVOufF2oMWdJ/NfFU3rTsQ9QJF1kWkkW0SL0Rgx6B+nFEpHz?=
 =?us-ascii?Q?PhYkdDZ1zltA91KQMZISp9lLINN9g8FBk9Nwkez3JInYMNmRc3A1fMu6LXl4?=
 =?us-ascii?Q?cPxBq7SiW99bCdqrT20qklr9Fm3wIZM0B6NGu4YgEX3QHxdQBUGbRda0t3kY?=
 =?us-ascii?Q?clzSyLbrS1VaueD9UYo6iD6s8OaUGZf3vO0nvIJbErOeZINbW6REaaB7DR/3?=
 =?us-ascii?Q?f3JBopM9dRy1c/xizGi5QKnaE3OjmszVPKIIwt19Bwe2RMrFOEBZGJ3KvzHe?=
 =?us-ascii?Q?s6+ipg/MjrXbGGHn3ARM4l9A4OhOC9aRrwHk8SccAW56esHJJ1bYoLPtdsG/?=
 =?us-ascii?Q?MgRsrJ+Q58+yAidEY/jpaxFd4K8Di7MaVYEk9dfqbmp40HpRwppJfy4xENcd?=
 =?us-ascii?Q?vS5dL8rvswNizPX9fNbxOvZV1LwNJlDbtI8Qv4ivLG9Koz6QoRSpu2NhHXEJ?=
 =?us-ascii?Q?pdOCW/KKwv6v1k4TFS8n0JPWoMk1g6bQxManMl9D66HoWkgEw5H+E2Vgb1TN?=
 =?us-ascii?Q?rxfpc6P1lXRCcKeI352rGeYpbuOcL4BqS/z4tfKVfPW9Gxu9lm3vWBWS7x6B?=
 =?us-ascii?Q?o/pRbT+MR3vvoxIWMs0vn8avRnN8a/dJsNYYg71QxQBLSK0QOp3AIvtZZZW8?=
 =?us-ascii?Q?4WSWjl7m+2x2x0aggvcKItYAFSFfajPXBOjZd69hFYDCA6VHY+SBxClAlWpv?=
 =?us-ascii?Q?3O18cvwM+c9nHQF8zY9CM5VUc/Wetx761tPhJUfZLT6M3w4048G2uH5Chxbh?=
 =?us-ascii?Q?Hy24QREWWrJZXyOO34fnERIEenXUnedQx4h1c5tVZ0fw3p8cTWCAh8gZf1b6?=
 =?us-ascii?Q?Pqq0HIaA1dZvxKikFbk1375S1ovPCuCuKoTCTwXYE4UM3lVmGhHr+yERH9ur?=
 =?us-ascii?Q?s7A0vlQ5fl/nxSLCLNZYxkZQ1KGXDy8dYV9aASzSOWklqJzVgQi0ZrnsMzmQ?=
 =?us-ascii?Q?L0UWwuLoq8zH3vlYAqQSv+vvGdhO6r1YNzKnqxaejInIEIcF0xpyLcWwe1bV?=
 =?us-ascii?Q?+i9+D4BrzVbNLw77YVcGOTMg5mek72MpJTTIInWzL3ReuHso/SAfh5xxsvsG?=
 =?us-ascii?Q?kQvnX14oI4uFelr6cFtaj71L5aXLLZ7aO1ixos9XCyxM2mM0LrdDn63GR0gN?=
 =?us-ascii?Q?Wz9t0nM8hvTxEjHe9+UDHzJ6yb1xBmF5v/Jt2cUrDzqYUnSEJYDe+fE2CzLd?=
 =?us-ascii?Q?Nwo7jCYtE0RaW+YJHanEVLsOYqB0Bqac26NE1vDNLBvgvt+2CyBZEyMM133I?=
 =?us-ascii?Q?nX/P4yHUEiB2TUPZpwnnYGfkXS7mdMhASp7NKyA2wipIig0/P3WJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4050788a-29d5-403f-0c90-08dede5b67e8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:30.0567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G+J99Td8zhKsEIBKjw8xF1fG8eadLDwhMdeHQGv4OFKBMCuweViEQcgax4IpbYmdhQwtmCBmHCy14LQhr2hK3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4074
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12281-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6CFB738590

Add an optional physical address override to struct dw_edma_block and
use a helper to compute descriptor block addresses.

No functional change intended. Existing Synopsys EDDA and AMD (Xilinx)
MDB/CPM6 block descriptors leave the override unset, so the helper still
returns the same values as before.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index a19282c15644..06c52819059f 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -55,6 +55,8 @@
 struct dw_edma_block {
 	enum pci_barno			bar;
 	off_t				off;
+	u64				paddr;
+	bool				paddr_valid;
 	size_t				sz;
 };
 
@@ -375,6 +377,18 @@ static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
 	return pci_bus_address(pdev, bar);
 }
 
+static u64 dw_edma_get_block_addr(struct pci_dev *pdev,
+				  const struct dw_edma_pcie_match_data *match,
+				  struct dw_edma_pcie_data *pdata,
+				  const struct dw_edma_block *block)
+{
+	if (block->paddr_valid)
+		return block->paddr;
+
+	return dw_edma_get_phys_addr(pdev, match, pdata, block->bar) +
+	       block->off;
+}
+
 static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			      const struct pci_device_id *pid)
 {
@@ -479,9 +493,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, ll_block->bar);
-		ll_region->paddr += ll_block->off;
+		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  ll_block);
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
@@ -489,9 +502,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, dt_block->bar);
-		dt_region->paddr += dt_block->off;
+		dt_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  dt_block);
 		dt_region->sz = dt_block->sz;
 	}
 
@@ -506,9 +518,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, ll_block->bar);
-		ll_region->paddr += ll_block->off;
+		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  ll_block);
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
@@ -516,9 +527,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, dt_block->bar);
-		dt_region->paddr += dt_block->off;
+		dt_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  dt_block);
 		dt_region->sz = dt_block->sz;
 	}
 
-- 
2.51.0


