Return-Path: <dmaengine+bounces-11661-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IMC+I9rHNmoqEwcAu9opvQ
	(envelope-from <dmaengine+bounces-11661-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:03:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBFD6A9491
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 19:03:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=jeRgqBY9;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11661-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11661-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E56E30344FA
	for <lists+dmaengine@lfdr.de>; Sat, 20 Jun 2026 17:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E7726CE1E;
	Sat, 20 Jun 2026 17:01:22 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4189D25B0A0;
	Sat, 20 Jun 2026 17:01:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781974882; cv=fail; b=kJU+2QnLZzSswfdQIo5V7vXlDCoqqC3UE7IuaHh9I83e41ZBoJVPY+bOiDbXXAM8d2ujlOYXf9m3CtsINLuj1pSTNAqEerSi5UMPZjln20eUScELQfguVqpvd9Q2xxUyC41qgwRaiKlOzIpnVIhI4+0Jg92hSQI8n6mwKapv20M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781974882; c=relaxed/simple;
	bh=tK8WDxGX2PoNE+3msx1JnLUui0ms+UVzu4bK+LwGuQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUvhm9Zv0esUUGBqXc1dkWfLWpX4CY9lzECB2msAY1goT8hCdNl8y/uI9U3tUg92cFwRcUe9tgCbV2VzjVCZah34hKBvL6gbaXKchD8OY5ionmkLIK44Wdp1a3GzhmhsLFUisS1ZrPvSVLJ8eWBjlsHjpEk6mk3BGFsd9Ebefm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jeRgqBY9; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4YBfMYFTwVCOL0oTI5CRJGvgftXvIGNAd+FfDaXl6Z+g2NmlO5nuwDyHQdjFU56+Ko9w9ckYO+M7YB4HMXFCBYfe/ZmpRunaw4H03xh9FjNM8BuMBXbSIiObpHjXqFhCJCVAyeZXCCyOcBYQR2gh/KcJeddNtFpEfxFuQ4veIALAJpQ/bG5JOlNGKMfZhPDtMb4UApJIfI8L2+WVWiBzrsIvSAWao74p0cr9CB9XrwboY9PX3QimB7y0KIQehiZgQvwyxJ4MMGt6gZ2Genl3OuExK8Ddy/U/LiYaHhTJCUpr8hajA/i+2bswI0UZCl4Bv18ZkAcrCfl5Tr6rRWpnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhJhYPs238znTh8HTPqWTTe2Ulx6lBcJOgV68DQ3JGk=;
 b=cLefW74gNd2tL40yVOdGXW84dfmNh7pTR+XVcD9D28HTw7F8ir6ey4w6vzlXlK7t918ySXSYuUGRP955+yZROCd7dZlmWqLrVh/CcDJAdJoAvjfQ7031bScuH0ledPCmY9g/OPew7H3Opb5W+BHMAWpl6EdxiDZktn90r4MJHNijBo4ee42kMpARjl6bJN91nW89Yun/DnnI5Zmdquv0yILR3MnEQpf2TMRl5iS/gAzKdmv+G4XUv/5FXDsz9bpxSP7qfc3SjljQy90/zh84dl0NWuxIpFkL+fzEBiyvp4bMX8bmg0yq520so1RE2rpzYa2eWZ6WmTMJN5btZ7z8DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhJhYPs238znTh8HTPqWTTe2Ulx6lBcJOgV68DQ3JGk=;
 b=jeRgqBY9RgNkYCYRttIWvwKy4e7vPgBH8irPx4qdTf0Wxud+MDD9KP57T9sysXnFQL7r/zdutpzwuOAnJS3rthka9oz2wasE8I1kkL9FFJAAKoPXDRJAshNsP5bJ8xbFEZG92S2JGjBx89CvfVDxtjnbP+/zPjCLOkIZXxXzM90=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY3P286MB2673.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:254::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Sat, 20 Jun
 2026 17:01:02 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0139.009; Sat, 20 Jun 2026
 17:01:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/13] dmaengine: dw-edma-pcie: Factor out descriptor block address lookup
Date: Sun, 21 Jun 2026 02:00:38 +0900
Message-ID: <20260620170040.3756043-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260620170040.3756043-1-den@valinux.co.jp>
References: <20260620170040.3756043-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0036.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY3P286MB2673:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f4b477d-a777-4762-1038-08deceed8223
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|10070799003|3023799007|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	2I5k+X7zchvPvYjXQ3ec64KU1rNiP0qCuYybltGIcSMMWDvqpf3NctQ+MOd5OXHkqtihs2lFcuTOnOXrHR/8uKH2FqLU2mL6OkeAaYDg6yFZyVfHwGRbOljG+njQxa+RnXkNVf8dFNNx8pnzzFULpqcLnitBzkNoT3MlLsn7qcJRojWkYgvZkrqIMbqjV2SPXhKdjUANzAFJ2/uOcYgwc98qRikSTjPriKASicGCFGZEH3wVnu7zA9yuliKwKcfaSIX9ov9gzAg+vIOXZnBwCCmQ1i3wgWRkdECoOUHxmH8a54x64A5hFfzW4I8IjJwx33a0X1iV+XnBFzx0fmSHn4K1RVHp8xwwUqbARzao9oGQ2Z0anifvnAqZeQo1MivLiYSvm6l9/EZjMW/YJQpJb/VB9Ge4B6PYTKhGB0TGig9wuNkIqT8JvNaq4dLfhks40Ui8Z0pScOMKmg3JG5AHudEEWO5mVys/WsLamhxFb24r48flq54fxuL6SkTLsKuO9JwGaBlnSeS0+rGVbyi3UoBG+6emnWHwucPzZGmRFy2SPvs7ZiwFi6LpK+G9FOYibt/s1oP+3vka4d/j3aU+pKjZSvcDS+lwlK9AOIVzRKntTXyeeOPafTJtunFYYnjojeOooS5hXEcm8YRhQuOuSMVx2f3U53YyXHWHG5u7OfQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(10070799003)(3023799007)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v930f8V+Dvi/TDnrWEBdZS9U3gkwklteI7zW+ZV5xlpMrZxci2Q8uPj0rCg7?=
 =?us-ascii?Q?8qTEH0J81l3Bx+/gmcDbKoSQkjcOOb5CmYngtjZVx9VhLDzCcIwJfdZ123F5?=
 =?us-ascii?Q?k6R9x5UAW3xYNQ9aGHon1GpWIQBg6u4QAUEIq3lCtTmA3VXSolIRTiylYdlj?=
 =?us-ascii?Q?C62vY+BmI0X3sk6520/Q3qynGuvG0GBkPlgSSwSuSYkhWO6+Od8gpHzlueqG?=
 =?us-ascii?Q?Nzno9VaFWKkwPXDHfza8SQlW/QexKFhllp03QStx/730ANeJz0cky7Fy/8yi?=
 =?us-ascii?Q?vmF5t6riCoYIW7b02PYIJTHrFYalvJlQ1gDHeMRf8H2peN14ExH4q5tDspEk?=
 =?us-ascii?Q?JR8gnQwTk8RBTMdkuykLlCdizt8YUtznV76EWpfhN/yb8nvkK9uicQAJc23B?=
 =?us-ascii?Q?UJIBWs/bSr3BlZJ81ZhbEzJrTKVW4WB2r47hERaiysaGB0j/+QzCaplFp7LH?=
 =?us-ascii?Q?WSlXWAYunN45GuzIWmNV1krLy2b1Tue99Oo6iTtAbYtG6UqB7EnbG32W4np/?=
 =?us-ascii?Q?UJAgtTfP8bMfPrgjiRcpP3ZvTQRxOJbBxrRk6xaTodgf62KhOudHK+5ugI2K?=
 =?us-ascii?Q?cLOUfBBuYYDZInj9Vz/BGkWb0UBUBwhNqIqExJdrHb9oEsGnksP2TlkcN+eN?=
 =?us-ascii?Q?YCrssQfjqzgKSQUS54HnlOtjLbHLOPa3t2RgA1+x0d6sf940k7GqdVdSkdZM?=
 =?us-ascii?Q?eaGQzN/G+PnWXPm87D2goX2A3Z/P7qHQqWJtgnpOs/3r8BfsaPR0QjnpgR3D?=
 =?us-ascii?Q?VEX1Sf/Mqgc3x8aJhEewSZaP8nV4YkXEcRxhfHSVJaERJC9d83GeiaRnMvU4?=
 =?us-ascii?Q?oGVi55ZOdxLuVa6VCRhKPc6HvI7eHejkTQc/935yGKNaUa8Pj6XEigBnDxJH?=
 =?us-ascii?Q?3gA95HrXU3bof9ShJ0IsqQrGCAMbmfoPj8Nkqq7Eo3NERPeia872hvWkZHon?=
 =?us-ascii?Q?+6hNzjKiMlIm+CbuK6/0ZPgBz7oENPZnkypJZFafSiB0c83RscfIyAsZ+yOI?=
 =?us-ascii?Q?9mtTdDGnlGGU5KYmO/blcpkr9mkhKL3/V4V22D9DW3BCQKD8jQ866Y5vgqho?=
 =?us-ascii?Q?a1JyZhFpGpyhVQmSjqduiPlEFHFFTappEuCZM886Zbs1fi+3BAtPKlu9YtNz?=
 =?us-ascii?Q?rVQgsXGyrGJJ/+htqO4EyWGWopS3aJDYHjhOu/qUKhGhP8FDohUAZu2E0TBV?=
 =?us-ascii?Q?kOuv0Eq2tKDcFeS56eUpzMrKV12tZ1yUj+xN/uuwgNsHNVqwE+vBBjx4bIrq?=
 =?us-ascii?Q?SbW1CG+Tn+KAxkFL+jsYUULDdigeTM7IIegDKEtZYt/8x1PHo0FSOHejA8gR?=
 =?us-ascii?Q?j536d3ohKiBj4M2ft1poslOb69ricLxA15oKhjDsmUOx1imy3xbcnGc8bU6j?=
 =?us-ascii?Q?plNdU8s3h8Mag6zA2nt7RyT4/TD4FqjqFQBcS+GjdPy4c92rz3xfjej674eo?=
 =?us-ascii?Q?Vulkm1sI2nu5lBdJCJPlAQiL0/q3ojYC6VsSoUKk2uKxTFIKiq6ioRLA5W/B?=
 =?us-ascii?Q?M2PkG/Q+H0uk/KvOOpsPotHiI8htaGM5RV2rQEjp6q72qQzvdDIKkgH/dG6/?=
 =?us-ascii?Q?p5nefxFHfXzPdhLlUTpc8bLysShD2SLk4YFgphamwQI/zKfE9SHCuRYwUnAR?=
 =?us-ascii?Q?BmPbfbGr0Q02z+GzDBLGHGv7pHohgPVkp1+Ku3NFQ2J1+vZVppUINmeYVbrT?=
 =?us-ascii?Q?uVLBtH3N+Zqxk7CgfYHMllaOL+ZOuEvzhfrkKL3xjVtrrQT729mMiGZjh25d?=
 =?us-ascii?Q?8UGyD7OuhEoG9yERh1u9t5zoAMrHM5I6RWZNTTUednIcQGUHqYn6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4b477d-a777-4762-1038-08deceed8223
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2026 17:01:01.9474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U7hfd5XADs8exObsTRJqrcOmIh1235CPYbRpNsD8dcXXLBwPaYc4CUK+Ufdz5d38XT/h18KPntjvIfoh4u1umw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3P286MB2673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11661-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EFBFD6A9491

Add an optional physical address override to struct dw_edma_block and
use a helper to compute descriptor block addresses.

No functional change intended. Existing Synopsys EDDA and AMD (Xilinx)
MDB/CPM6 block descriptors leave the override unset, so the helper still
returns the same values as before.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Update commit message and describe the AMD (Xilinx) CPM6 match
    present in the new base.

 drivers/dma/dw-edma/dw-edma-pcie.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index caf7c05b0631..62740c8c3f93 100644
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
@@ -480,9 +494,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, ll_block->bar);
-		ll_region->paddr += ll_block->off;
+		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  ll_block);
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
@@ -490,9 +503,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, dt_block->bar);
-		dt_region->paddr += dt_block->off;
+		dt_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  dt_block);
 		dt_region->sz = dt_block->sz;
 	}
 
@@ -507,9 +519,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, ll_block->bar);
-		ll_region->paddr += ll_block->off;
+		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  ll_block);
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
@@ -517,9 +528,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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


