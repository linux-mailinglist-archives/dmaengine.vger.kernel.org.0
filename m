Return-Path: <dmaengine+bounces-10608-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPTwN+WnDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10608-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:36:21 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A1D59F7D1
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3376630D3C34
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30DB39A7F7;
	Thu, 21 May 2026 06:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="GL903VQ2"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E678E1B142D;
	Thu, 21 May 2026 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345095; cv=fail; b=Ic/ooPBoJgXeDIEk+Gah2Y6Tuh7MXUVHBQ5kMbAk3HvQvSQTUhyiAQxCV0AXmXbhWp8yFOC0wjr4ku98NOBeOkVnnARF1T43Sci8PLkJBwQVToY/QTBcPfA6GLx0HL2F/b1cBC+n70Mhr7Ebh5Tbf3+aFRnVVE74JKGyxJ2vq/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345095; c=relaxed/simple;
	bh=eLDUe3L7yCrKADv6SGZDQTJDaLzMpPaPXYjz8Qainjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YjSv+Ie23lO0dvAnMyxPO8Eg16iKCkmvjZMElurGVcsstJSYnbi2g/mlGdSt9EGHJn4mUc5eHHKiYisXKS95JU6neegncmf0b7IuB1OKCZje0qRG1UnSuk3oZTAty5jVkiHn11KJpPB3BYGtHyMfPrRT7PC6cd0sngRB7BOzSg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=GL903VQ2; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gSM/Lfo8y+C1KgClxHuiIhIezRm7inbv+70BHcxDke01twFnuXKg5luYOWtMFq7Io8zUtkK7k1XbRaZCUcdy6abyBw6XTzKF+QWknluQzSGDOmuQ9NmJeeoVJBnd3Ggbv0BS6mGgfxCu0AXBSmxk3qsPeqAiU26pdBw5d/G/AQCMLGNWtrrFX10ffbY2rUR0Iy8lDVputsrlQIpodFuY109giU0LVK8gFamKRvV3hufMlrPzHIm4bO6rYZS+09BQN01fYNKgJPHt2v4VGQ/J4iuKk9WYqtFyxqqCYMO87v/5fc4Z5SMTVw/XlyDlxwgGlYDpRs9KFPi6gvBXHucIAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1swTebOBibyUDONu1zA6JAMuNFEks/SLFN4Wr8kuGb0=;
 b=WlgV8cgSD8PpKqqICJtF5Jx4hmvnCNMcPAvsLoUdImMq1fgJJQZVFgJXQWhwQ2OmKtY8DJgxMIF4sMsmXlp9JskeyHC6/RM3GHwkX4pjpU6tKut/SuX32FHviL7PLw6SOKHe3gw9k1QA/P7dIlPkgg2JKnD8uBaMXp0mFYJ/eLRgESo/yF2ee6y7iPLgLGLWr7vdmGeJFdSDA3eBmjEOOK7Fgo2cX2L75T4pUhPGg7YvxgK2FuSR/CxADrHH1mJxQaLpGbr/tz7mjy2wmTXh106UkXVqjyFgJ58gY2Qp6U2a1jiGWYJvrVzekDuWK+i1x+eDIwWgpSPBjejOYQ05Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1swTebOBibyUDONu1zA6JAMuNFEks/SLFN4Wr8kuGb0=;
 b=GL903VQ2Qfi59nuXusXY69gUpYuhvvRM2LRaq0fs7jwjR7yFp16X1bXq4wwT6mJImnpuIBHuSpPQMvB7VtPyYTh3FMJSWVmK6tmoFBsCdYkCi4EMWiVkhqjmujNMcBDouz+ODWuEyBZEAP4kW57brhyWDZIUd4Q3NzCYKgj0Naw=
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
Subject: [PATCH 10/12] dmaengine: dw-edma-pcie: Factor descriptor block addresses
Date: Thu, 21 May 2026 15:31:13 +0900
Message-ID: <20260521063115.2842238-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0076.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: b0561395-0037-4c17-f234-08deb7029693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	RjyK/urbvUeylm5NNGj5r958cIs/hDt9Xw7dxaWVaPJBhMKNu/lSeENjMyD4Ll4fBCxpFX7DZfY32gKORFVDbK90JByrcA5kVJ0tHEytNsno6fQXmkAXa7DFBjfAyTOjBv4Mh7sf7NPz0ZX9d709UZ3wp5mRmNMp/tj6eJwxYZJbjJBeoZ677tn+r0RCLotJejYjbS9M4OYvhVOzIx7NJJuPPgOqUo4h6FCJ4Aqk5wlXYYyeMtQS/IZhRCfhuD/2V1An16l5ycgeHFySwah3A9z3mP6z3sGpvCigFkmM6W4I4vIIoEFv57jkI1uty+tMZLFwmN1YNHI7zwh2XjxKNND3fYqeLH0WlQIptgWWi0tUnwK8Snm1YznfV4mofnlPpy68hVwKkpuLA37PgPRJz9+4azas5JVY1PlbnKHtpPx+A5zZKNi2SFKeaV7BGg9LDD88yPNq/NQldt9ABqeUYvTR9lhKEuPwQ2nO3/dX5jn0+J+GlIt2S5ZWBCSa2M6KR8CQvcVWzlDRzGYYX4uBfHKL9uGZHFgIlulx04K3LflO0Lw7ZHByoDZYnsuNrMJZi4U62mSXBsIhf3OJM8Sg4QsG9UH/d5qQXFShzxUfH/KpS9PzYitaD4BnMArofDfFDDBmb205SsdBlkF8A7fmXN1a28c4bYLXQVD7gx+3886csXvojKxemgLde48gWSTV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003)(3023799007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?foA2BbOCirFbcdozKHYKZQLGf7MBYvxWlO3u0QCxfPEfE7yuooOm2uhdv9B5?=
 =?us-ascii?Q?IcdGP18kRUw5PkjKPhZH4jxVAXyNXDr4mEFB+OyZu05NM32QpgrLCka9fVWb?=
 =?us-ascii?Q?NIRV14lRhkZ8fMgPqZVtx+Papb9JIFAqvOQuid+lewZ5C4Dcm0K5pkWpw6cB?=
 =?us-ascii?Q?zclZcNEr4mEa36hn1CUPwby8fROXTFjDrMMgTQZH2tjCs9IhYHTspZUpAUp3?=
 =?us-ascii?Q?QSctkUc5nOWMskpQQmCKz423/6qOO6rUrKa2xUu7++tVUPdltrh6cVMzc4sb?=
 =?us-ascii?Q?sC9eFTny9y5MgeUb1Qg3GchoQa+/QvYtDrEbtRfg/CsoIo2cGhZ5NrdWGGe2?=
 =?us-ascii?Q?DHcOhCQOnKPW1uIHl2wugX594lTMg/MpaClitcpiRC2CymG9QoWvlbqHe6BX?=
 =?us-ascii?Q?KycNYi+9Do7L2duOOCDy70OSIQuv6sDwsxCpp5W89I2vYWjUZTjumoe8fP82?=
 =?us-ascii?Q?HXdIgburK+UDbwUY1MJTLRkQWWhHT2rwdLltFS5CH4pUxi4cJ3Bmmoc2mcJR?=
 =?us-ascii?Q?Pz9wJuETsq318DqC/jG5agQ2ms5EhD36nDiOMwvBuqjswvpwFttZRgdKihBC?=
 =?us-ascii?Q?eUmLRLS3d/DN4Zri1JddCpqYL1G/+UnOAEXTlZxFXFo+IEkN8qAksb7YQfYf?=
 =?us-ascii?Q?Tuuok+BJzbRd4CB9Br7sZWThi3x1bx6QhJ0DqmcbNZbJ9O5tZkCLWclJ3F8Q?=
 =?us-ascii?Q?q6Up+pjphiyvA9Jeo/WmS9Feu0n0FHftBlQlF8yKo6E8nawraugfTMpkUI1y?=
 =?us-ascii?Q?z/mywpGMB1KsbTbiCbYprNSLYxEQtSJeg6olh/O5LoHtzwu0/r4WcKZIqN6p?=
 =?us-ascii?Q?fQcgFcqHO3pUb+NY9oAnIFdt6Jdokl+ISaTW1DFBY2nv4m0R3QGUwz161ulq?=
 =?us-ascii?Q?nJXVvZGBTnSPbttRFOr602qo3fIdsp+HkPVTPih+CN+BHifRHuGv9zUaKefq?=
 =?us-ascii?Q?lNC/jY1+s3t2eTqMfN40N3V6iyGyLDVhuJqVQNnaAc6OPw6hPRicR/ej1w4l?=
 =?us-ascii?Q?xl0oJ831dX4afxDII7ZjickoZMenCvei4g58AekvHu/ewJPW1rGaNvQD8rTG?=
 =?us-ascii?Q?+ViiVymJBlZTIPyoJczzpPG4GUYEj7ncTlQ8jYsYB8pJymmuzqyP7+T+Cqfc?=
 =?us-ascii?Q?nFM3tb1W+Lv3Pz1oPSe7LSqVfWk7cSfAm6nUAOEW1ySFEfzYkKPnYxs1AmXx?=
 =?us-ascii?Q?fHEVpbZIZLXCRxRvb8hjHd67v3Z4Vd8Q7KI3iuqvjNYXmR0YcDl8bISZHTsE?=
 =?us-ascii?Q?9eUZBaFN3KL+8r/ZLKcywTAkjO4KSgu59noHjrfymXNdE1fgqtGfBYmB6XiU?=
 =?us-ascii?Q?dm07ptwSsvl/gRmTUh1qNfGEAOc4ZeWW5YBOyOSpOixmfMiHL8nrnoEeIjB8?=
 =?us-ascii?Q?9wMlaWPHcjQ4g+SS8lKooxOTXSF5wqK2oerGbh3462e0oMAvLGNZuMLbcpz1?=
 =?us-ascii?Q?68jucTUYB4A3XFnSuSGhPTO6p7PcGJZED9B/BX514iY/d3jqsimrnW41REh/?=
 =?us-ascii?Q?SXaikR6DwDvo7Jtyu5GGYzgJuw7S0Zr0EApEtd0p2pKReBLPTpcXIVxxNkgK?=
 =?us-ascii?Q?HNZyplrM3wLIBQfA+KFpP38jGcXJZhwPFnw+O9feW5awNC8yetAjm7KPewUs?=
 =?us-ascii?Q?MP55lqPe/HBNZwiDefzq/6gvfnwLSRqp4Vs7EYYoV39tAj/r95NxeJPUJwkN?=
 =?us-ascii?Q?WhWk0GVfWXiqShDuo9VFUnJ+ACxoRY41uMa+Ma6qAk0iAdfa93ffpWgYCW9z?=
 =?us-ascii?Q?eAszFsQbzhmdx4PSLsztpM61f+ujzNzM2Hz/AAErelIrm+eFdntq?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b0561395-0037-4c17-f234-08deb7029693
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:27.7908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brp+YXu8E8W9s66agHhutu4EnGlYKyJ/7nMZenCqiVYImyo59jWynRKJlm0wBqZ8tjQJM/n2d0E67nlac/LiJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10608-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: 54A1D59F7D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add an optional physical address override to struct dw_edma_block and
use a helper to compute descriptor block addresses.

No functional change intended. Existing EDDA and MDB block descriptors
leave the override unset, so the helper still returns the same
pci_bus_address() plus block offset value.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 34 +++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 6b375a58c550..2a95fb9d5fc3 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -54,6 +54,8 @@
 struct dw_edma_block {
 	enum pci_barno			bar;
 	off_t				off;
+	u64				paddr;
+	bool				paddr_valid;
 	size_t				sz;
 };
 
@@ -365,6 +367,18 @@ static u64 dw_edma_get_phys_addr(struct pci_dev *pdev,
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
@@ -465,9 +479,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, ll_block->bar);
-		ll_region->paddr += ll_block->off;
+		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  ll_block);
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
@@ -475,9 +488,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr.io += dt_block->off;
-		dt_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, dt_block->bar);
-		dt_region->paddr += dt_block->off;
+		dt_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  dt_block);
 		dt_region->sz = dt_block->sz;
 	}
 
@@ -492,9 +504,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr.io += ll_block->off;
-		ll_region->paddr = dw_edma_get_phys_addr(pdev, match,
-							 dma_data, ll_block->bar);
-		ll_region->paddr += ll_block->off;
+		ll_region->paddr = dw_edma_get_block_addr(pdev, match, dma_data,
+							  ll_block);
 		ll_region->sz = ll_block->sz;
 
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
@@ -502,9 +513,8 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
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


