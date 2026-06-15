Return-Path: <dmaengine+bounces-11535-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IzGmIusdMGrhNwUAu9opvQ
	(envelope-from <dmaengine+bounces-11535-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:44:43 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 490AC687D3E
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 17:44:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=mdMI3a8K;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11535-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11535-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B7493037C12
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 15:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5394640962F;
	Mon, 15 Jun 2026 15:41:42 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFCC40911C;
	Mon, 15 Jun 2026 15:41:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538102; cv=fail; b=EeSRhIkqbE2Fq+HdtWtKBCpXYrKgkEwyMmYClBilArjeg1+nMT9NnphOJB5TCQJDXi9rnH2bbx59IYlldGaKzSvpWZt/In1CNFWCyKt0jRsVbTP8gIsJH5rWTfP1VaoSvRP3f7BWevHmju3meRTBuix8dMEyX8TfBGKuU1lSOCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538102; c=relaxed/simple;
	bh=hagd5hSL5yoD3czSBtN5p8Ox2SE86AQMwYuPzGrnUsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OLw1vHeTxZt+3LYZWSwoS920QS5fKU7IVj7WxWwtoku34IMAMsUDZr2C8fnm594KHRlPTgcSFVJ/plJsuefD+i12VHFpIBiLV24yBCtxeg8PVS1YPCyLHu6Ux3W2Sawrv8SSvFTCy/EQ3FPfE9sI1QUpkcfVjYXJySIMXJeILP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mdMI3a8K; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FCY3myq3FUMWkLcaXUuj11G/vXkjnFRrQZgDTr//VcqJML9u+eY0T0RiUwXWUboVbBVK3xxEdvvaD/fdgKPYSpG8qX8vHux97Fgmxj+mH5Swz2ai9/w8YDdwMu+X+0y+47q6mVFcTSVAEO69BKJrOchHp29mDxhTKKze41DE7zeQOrtXAjw+aYwPj8j+2wjK0USCBr7wpVv80ZD4g2FGnE1Nx2DzlHi5hD/qNOxyKrebeBI6AKKVH+566SqiGIqYX45thAGeSETDGCqnW445MgCMjS4QuX5N6bcGnmMtpI5awAF/X0nIjbfGfOf2JeK3o/PKwzKS32XRh5lNR2uYmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbGJ2XUS37b/18GgSmS1ewX06Zk1+JDsVShq0Ktb5nA=;
 b=RxTviJlG13/jzjXcQqSgjLeFwSH78dyr6Ypp56UtoSlcQtPaTJdeKz/Mzvq4v+pAahwPSr2oMBVwbt2c1ChKwHC6IzmILy99qrpZT//+U6+MiKQvjrSrhnjDZjZgI7pRdVc6pHFK8XIn+G9JX7QuDruWc3C8oJCwsDxVCnAnpM6yUU4aYg4JVKuRbY4fbvXKuJdrjsem2VkbA+IDG/Bdv//nL8DQhAAVDEGoUGMnDyRcwcsInkgnUuGIERJ3cFTl2mrSKTTCVYpdFWx5TJI0UFbAYXot6dwx3M7ndZvggOEzcBXJcf//nmuy3eyXGbrlGmFQd4hPAyg+Vo8Jo3FlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbGJ2XUS37b/18GgSmS1ewX06Zk1+JDsVShq0Ktb5nA=;
 b=mdMI3a8KdjS9XYCND8PiJysjmLhvxjz5e2V3LdHMTBVdTBEWiq5U3HYx68T8MCze2ZisF/Q1BO4GuB7VszznGyYERF6TOuEYhh9Ii0pnre4k8OOIk2b59RHZoYTWgksqep9WavPnhVvKUeIPFT0iZlep2fJOx1mg3E08//A70dU=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY6P286MB7549.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:345::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:41:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:41:31 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 13/17] dmaengine: dw-edma: Dispatch DONE interrupts by channel request
Date: Tue, 16 Jun 2026 00:41:07 +0900
Message-ID: <20260615154111.2174161-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615154111.2174161-1-den@valinux.co.jp>
References: <20260615154111.2174161-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:405:3bc::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY6P286MB7549:EE_
X-MS-Office365-Filtering-Correlation-Id: 63423332-17c6-49a4-d705-08decaf492b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|921020|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	yMoEg2qdpwVVOx7KMyA2G+yjB5tiSn7sJQjuUJDYhghxbgMlmRUAXojT+kOTDCYnxmhplLKxlN4pINE80PPENB1DeFHVRFCFEdnkkCzSiEkxV/ypWLOKxxPVJERrHkHh/WMWjfxE52I1quISKTfc7b+xATgNs89q0lQGyAFuscw0rIFqkiZq78QTiQN3iJ3qn9/XCeIli+BtrdAbMpNbj7C98gs93bJYfsHkVhaFeQBY5nC9WQ0+zTTPDqm2Sz3qR7XjRZvB6xSXAzHTBaHud6nM+tMat7EpVE/0JY/5Vb+GCHzKzr98xNgU+COCV9LVYMS52zEExxxKflv2QVCuR9DlkptvjKB+/xE9OckuljFh1Fs1z4uyU8lYYhX37zWGUPNPUknj2FIF7MZod2Whflz6D6kuw2fWHf0VQA6rCa6lXfI42VjpEh9J/EOCOAm7nu6IDIekJoxfaJxXulGYeE/vTj4u8s0YEwvSAyMW+2yOu5lLVxtFaD6yGow6DcgvhgXx2NSBWAwoTy0EHte1i9au5y4CiqV7MLPoS0jq1U39i10cdfIQ0zIgGaU6pxHhc8Kz7IZ78vqTAOSWgLdNLNL56J6cjszk6Xe8NmB5BIzujntkazgdNH9Ym7bUasRSefOxN5biSufikiVDk7ilHezSVsUvDfHvu1w4+vfvof+xpQAeoyS+SJRyJ8a5A7CZaHEhgb8gINVipbanIcSnkUe2ykN0mqnjZQsEgZZMFfg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(921020)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?953X63sTKw7RfzechoXQI7uixKMFt9nHV73cUGRFFmYPl5bN+wcBZ0w7o2Ul?=
 =?us-ascii?Q?m/06EH53eLLtm1ymCWBXeVjHzC1SmhDIdwbvfJbA+er923hcSHVxM1LfR+kA?=
 =?us-ascii?Q?+/ekR64OVbO3jlXTjHPL+FyLG84CjZled4d+LmfD6CiIs5vrkB/dQjWCn2nB?=
 =?us-ascii?Q?O8iFCbCpPhI6Y8APWXgdWdBvgci6oOrUEqnhke/6561jc7nBKx/+rfVjToOM?=
 =?us-ascii?Q?L7nxbMhd+ChiQAeZ4PWT3rxXKJ11/h3Qti33l+Jhr/TuNWdg4kkbqIkrvuCX?=
 =?us-ascii?Q?6ndoGaeRpdcrjBzui9aoAK9qnYAfYTvRR7PF7yLpgblNA/TbdFY6eOXCztq1?=
 =?us-ascii?Q?hpBp/C44R5NlSIl53Op3rgXJ6OKTDXxwGek+jCY8Wq1H8SP1lx5n9Gu9SbKH?=
 =?us-ascii?Q?XqNdGMibw6o9lwSRrKG9vmsB8iIm8hWjfBMkSF0nVX37YhiqRydwlHIWsCA8?=
 =?us-ascii?Q?5xCR8U6an1GWgr+xM2csevLiTm/qQEooXXTkOPZpSh+CKqj00+N43851L2Uw?=
 =?us-ascii?Q?6ljIS79OcsstRVS0MZE5VNAjN0AFJ1lPMd8pu3HOM804uf4UwDB7kraGFnFq?=
 =?us-ascii?Q?lhVrcGQXdcVwEtK7JtsfNASTEjH18VEhYO+3I4oCEf4yW7Zd5OJDGzW61VE2?=
 =?us-ascii?Q?yBnlR2dADeUj/FJYXQ10n//rc5LMD9NyoBFZh9YU9GTfiGR7VSzFoS8f2XQP?=
 =?us-ascii?Q?24cph/EIQb8Z2lOB7rxVGj50fPFo+4pmWdbuy3KmImxbFL2bfXBc4w/dQlWm?=
 =?us-ascii?Q?f4uk+JEluqm+JwwpEa89ZaryQqQ/yvgdja1mGrxPgWr5TfswNh7UYU8QWalK?=
 =?us-ascii?Q?J4KZJs9PzoC3YY0X4nQmCy0RnIt1kGR3fkzVnkhoERA1CK5oOXQCzoO06tF0?=
 =?us-ascii?Q?doEOB6AvbAbWLA5skmnjcwSJc9eMN2Q0X8OG2csYhi5I9GyNkm3pId3PKBNJ?=
 =?us-ascii?Q?2s512H8GgBGDkiK2KPxunWMZ5OQvT5WtFuO2oGF1U4f7dtATsG/z4kwRS9Rb?=
 =?us-ascii?Q?2hY8Wa/l94uqiK+fHjYYNdCIjiBTeSSVtC0AROjxaKxYIfcAwO+bcbvMGcZ/?=
 =?us-ascii?Q?qpyrwEsRAYL8b+F60Ee5T6EnUIc+1EfNeXQP2WacwbPmGxCxiTTn6nIU485j?=
 =?us-ascii?Q?iCORx6PcR2zFfwcqC3wYxOw9SnDdxpbYE32C5uQ180+qRYEsoV7aa/55D9ky?=
 =?us-ascii?Q?JpF03siJ+QfVZxyhA3101pD7FG6ESaa4V6cX1vi0z1mluVO/FH0nyqSbnYmi?=
 =?us-ascii?Q?gL7eDHILdr/V6awUEvSJ6JnOKfIMKrFtr+S+3DHEqLLYhHTmqeeuzUGTZZZP?=
 =?us-ascii?Q?8kkr8BRIqlCi49YiNUZOFKWh4oh/vJFqK6wgL46UX8A/zb6Jc1Du+8m7G9Rc?=
 =?us-ascii?Q?qc/DHOWZKuOy5vd1O5pvHeaFt+riYGI0w8Q1OwXZcTGnOQqBuL9uKLmYeHlW?=
 =?us-ascii?Q?CxOCQ9TMabd1RuND9g5o7MqM9qdQ7YGSys9sXBsNbo08G4jhtvElvvbRE+7h?=
 =?us-ascii?Q?DH98yPRSw2zYuA7ODsNxF4butbkd7Eptkw0BTFWnKgLj/wtJWwfQxj2ng87c?=
 =?us-ascii?Q?uZcxpf+O6pcDOzP5G0i1vmVOMVJV9P7GBWhYh3ycmW559C7C8RWB+3R866Hc?=
 =?us-ascii?Q?hXoGJ4Wqs58PA3cXSPsvML7gTbMbBdVbivp5dY6csBawJ/MqVvyxN+I+9CsM?=
 =?us-ascii?Q?PpE/M/+MwLBTN8gM7ku7vjdNIjCtcNJSL3Ig0YglzEDIyyDbuOgGo6reJ+Il?=
 =?us-ascii?Q?8C7psdVcMWiGk+S6m/PsN1gmlmK9sjMgiHFju9PL/1Nx5DyagzRQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 63423332-17c6-49a4-d705-08decaf492b5
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:41:31.5848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcYGe8YjHIdEF/KBYvpQDsAD5U15tYxL5zOJEmu42CN+r9QmDhrG34FvLNCE/Ck74tjsryDjotmHTtlynAFrFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY6P286MB7549
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11535-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,valinux.co.jp:dkim,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 490AC687D3E

Handle the channel request first in the DONE interrupt path, then look
at the issued descriptor list only in the cases that need it.

This keeps the existing behavior, including the current STOP and PAUSE
handling when no issued descriptor is present.

No functional change intended.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Note: this patch only reshapes the code to make the next patch easier to
review.

 drivers/dma/dw-edma/dw-edma-core.c | 34 ++++++++++++++++++------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index e76d8e0c6fa8..ae38ff0a8b83 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -715,9 +715,10 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 	idx = dw_edma_core_ll_cur_idx(chan);
 	dw_edma_ll_recycle(chan, idx);
 	vd = vchan_next_desc(&chan->vc);
-	if (vd) {
-		switch (chan->request) {
-		case EDMA_REQ_NONE:
+
+	switch (chan->request) {
+	case EDMA_REQ_NONE:
+		if (vd) {
 			desc = vd2dw_edma_desc(vd);
 			if (desc->start_burst >= desc->nburst) {
 				dw_hdma_set_callback_result(vd,
@@ -730,26 +731,31 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 			/* Continue transferring if there are remaining chunks or issued requests.
 			 */
 			chan->status = dw_edma_start_transfer(chan) ? EDMA_ST_BUSY : EDMA_ST_IDLE;
-			break;
+		} else {
+			chan->status = dw_edma_ll_pending(chan) ?
+				       EDMA_ST_BUSY : EDMA_ST_IDLE;
+		}
+		break;
 
-		case EDMA_REQ_STOP:
+	case EDMA_REQ_STOP:
+		if (vd) {
 			dw_edma_terminate_all_descs(chan);
 			chan->request = EDMA_REQ_NONE;
 			chan->status = EDMA_ST_IDLE;
-			break;
+		}
+		break;
 
-		case EDMA_REQ_PAUSE:
+	case EDMA_REQ_PAUSE:
+		if (vd) {
 			chan->request = EDMA_REQ_NONE;
 			chan->status = EDMA_ST_PAUSE;
-			break;
-
-		default:
-			break;
 		}
-	} else if (chan->request == EDMA_REQ_NONE) {
-		chan->status = dw_edma_ll_pending(chan) ?
-			       EDMA_ST_BUSY : EDMA_ST_IDLE;
+		break;
+
+	default:
+		break;
 	}
+
 	spin_unlock_irqrestore(&chan->vc.lock, flags);
 }
 
-- 
2.51.0


