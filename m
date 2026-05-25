Return-Path: <dmaengine+bounces-10810-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKc/EEzrE2qoHQcAu9opvQ
	(envelope-from <dmaengine+bounces-10810-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:25:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA385C65FB
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 08:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C513302013A
	for <lists+dmaengine@lfdr.de>; Mon, 25 May 2026 06:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F7CB3A0EA6;
	Mon, 25 May 2026 06:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mTRo/Gf/"
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020141.outbound.protection.outlook.com [52.101.229.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01FF39B943;
	Mon, 25 May 2026 06:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779690281; cv=fail; b=HvHR2o7IDjeb5JmnLN2VqkHUHv38pEYmaOMsg5fAD9zJ5D3opqEVJSjnLv1bUug4Em+EoRZyzxXm85w7nO4+JWGIWHSU9QIoxdul422Z5Bcbp/lcWbwx3fZCpspC3oYuewXnv+WWMWw494rHzS2UiWCTNR+7yjrEa+pkHpi3X94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779690281; c=relaxed/simple;
	bh=nmGkacwsYuV8N8ogXcftyywaGTD4Jfj2SzHIgjvB1Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qfD4+JuZjCl1IMhOT/Zeqlw4Bp0MJZ3LyMfLp3ugyeM8HYJGu7E1qvaYCxf1e+dOakpagWVuOmumxuoEmldXSTvXu17ZY+1ldnbqTK9TMdb6JZMKPrkA1+lgOHen7wFYqI74jBCvoqYJk8nWejSBigl1898d5qp0JcG8N6iW/nA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mTRo/Gf/; arc=fail smtp.client-ip=52.101.229.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xz5m8Vt9kZLrI6MLCHNw7in3pIFnwFF1vAHuDPj2Fjv+ZpD0uurH1C5NOjGH82PbdCLaLOayAYPK4Me5YxWKL31WPoNcmN5ie1NZ3naRchTDeoS8Qs7KJUkNljNab/tk608QybwOx8tE8mg71nGb8AzJCESiPv+ilXFu+K8DRCDo3+G52WQbNLNA47GiBYiCbuz+rhoMmx6ZGvmFO8tH0qXia86mSk+OsPUax0CvOZegGMWodQUAoWHx/vwnFr2vb4Muv3d9kGw2L48E6k84aX09aDfVv0UhxgcYIqCaWkgJIxPUklPne/nR4e8FcU/M6CI0ughTFDWZgX6Ayd48Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dXyeSVOej2DUIW4wXN6Z7jUDUr7+fJzE0pJrvGDMYM=;
 b=f2YSMrHsNnpAdHnke82kVwE05Ugi6O0/kdDqPYz8ZSz/COXnt+gmLZj8KUe6nMpswSC0jWqHAKYNegp17433UHCeS2wegU4MI+CKaKidPXWRz093ws44mcBR4FBDtOTElT/c5Zi+6VSUQa6O73qcebNgUY3xiCskQGybNcuHWlPPIkdOiHESX4Ob98ZrsntEy4+75BJZha8NxikaWPNyEn3Nqk6xnHrJCBcKsEYisx41GPt5T1HUFt5/PZuslmglhxYfT5LQUzvwqaeiV0BXPbB1GAqbx47tM4YUXObjn77QDae9KrxjHI0p/k/ZB2JMyHRi80TF4RM1EFAguu+5RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dXyeSVOej2DUIW4wXN6Z7jUDUr7+fJzE0pJrvGDMYM=;
 b=mTRo/Gf/2HKommR28hegujP9hqi5RNcJdqbmu4zjpqHswsaj4ODaMQw7D8BpZ3Kz7teywhm2rw4pS2D/1lZicc20hO+35WMGfdYNgQ9+wgpIx0WyvCv7tClptnAPS1J5Gxc1nns3VgWXo7rEakUKkAQZC0R03JewhlK2Ghb7exI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4655.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2fd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 06:24:35 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:24:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/12] dmaengine: dw-edma: Add per-channel interrupt routing control
Date: Mon, 25 May 2026 15:24:10 +0900
Message-ID: <20260525062420.3315904-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260525062420.3315904-1-den@valinux.co.jp>
References: <20260525062420.3315904-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0333.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38e::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4655:EE_
X-MS-Office365-Filtering-Correlation-Id: fcc89798-91d0-42cd-ab21-08deba264a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|6133799003|3023799007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uMvO9GY4xFQl7Y115V+3XRF1ZrnXS1sZbELLXcg3rif8lBn8i1St2muNlcnq7PqDNS7mvaVy6ESFwWM36StilusA9AKodu4fnQyLPa67DDA1aG/nEZAqEcyLD3bPTLEftAi7PnZvkG694kHhV0LoR/B/IsnYIfaJHDC2I4MO7hA5/tlwT0LR/Uvw6mGYFDpkPAtfy43TJeNFtnzowQnvYxputT5Fy9yhsBPLpppH6JvUIGQnqTta6d1Eh/puz2lHa9ANMfUqvDLAdKkxXTGLsJQrbq9IFtyZvmcPchf4a/yyukymgtdI8w9tg/cNmgwqEXs7ZfGtc51tlaiHtoAtBOQ6b/vJaoJACZ2ytr6qNLU5sXJQroVrEOGYUIe0kw0dyriPHY55fPordOWv8wVTpVPDAjLDWXVfN/XHv9v90tTCfKZ8FI0ekRNTgFRODETR2uwmsxPszLWnJow1kzn4uy5mchkK5/+zzDKQeAGqtxD980UaaJbJF0pL2zPllQAD6nrBNvAnUZiSr6Hcs8OF28LZHod1XiEJwEEyVBr/Zqub/IC4IMFrMsVdMKRpoK09VWKJtHx2r4bx1L4qo66dzODLIJ+ms2bwb3UbD8tETLTEqFrLkH0XfZuVTLnN4znCyekNIcAfU+tlaQUsozeqILEs1iOANuS4Rg5Cu1bqKb/K2BMh5RrQ8tFWW0Y+jliL
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(6133799003)(3023799007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QNgGWFH/pJXflN/SKxI5jceylxT1s8DJxsqrnEJPD7VPlquvtxoh4R7zhq3O?=
 =?us-ascii?Q?pJn4BSVCPXlV85HUdFFwfp4GE7cjlJtPWQ26JVqgtQwaPLevlL7CqcZ32Cks?=
 =?us-ascii?Q?jXVF4jEILIDspuz1gWs/xPndo5BrnOUcjhUBohKTcm+1qcFANajyzPyB6ASY?=
 =?us-ascii?Q?KwFvDXKXVGPrVGqcrA2Ln78THYspYcBBoA7tnZ6xcIs/AbUfIB6hxpzqldHx?=
 =?us-ascii?Q?iHqnmj03XqN1NFVUZU1kzSqPwHsiJE/Zqai93GFLocqrjej9q/1+Ycv8THZ4?=
 =?us-ascii?Q?nu+2QVptMOl8SG10nPRNF2/t0OioGFutT34AZYhVh7j9wvTaGnBMU41BdFrq?=
 =?us-ascii?Q?kAEmtMBMlwl3Sb9Mlb4vhHbASHhV/yzYvO06gsX+MeyfWWcgYtNp65Z189rT?=
 =?us-ascii?Q?bI11JQK0NE5uqn9URH5uXd0Vs61/e8KDNnNbf4v7U8KUmN9p0F75LbMF43Hn?=
 =?us-ascii?Q?ARV20G+9rHetNSKRmrXu9FOfyUlSPWhCIYC3unrwM4SeZp5IgceMzHgzrZdo?=
 =?us-ascii?Q?7hinhPUo+fZcREK2w6lj3EXVW8M3hyZ0JkhrTF2LPBE36C1qKeMhA70MIPtD?=
 =?us-ascii?Q?f/mRIs7psoqoEdNdxjyoZZAfpvtbpiaXfxAW+PghDrKfNMDhq/IaAliSNCrK?=
 =?us-ascii?Q?pF6bbiNQJnZbCCHuKpqnTiztuguRc4DmILy2yrNkH7fKLxVaggjFuoGgCeEK?=
 =?us-ascii?Q?MUciKX9+rUBwyypW1YuYfCVWosQ+FXmhNUfBY9FTkqXB9oAqdXbEulI8/pYn?=
 =?us-ascii?Q?HrzDQwBmGw2WdlWEVSuJq8BzhyCeShO9m4fmvBqswMz4ttsqWAOfj0OdyPUF?=
 =?us-ascii?Q?7F4UQtZFoKf76poJvdgFlWWcFV0E70Ow+8c1ZmdPW+oY0+qwHANCe+Zw6DpY?=
 =?us-ascii?Q?XHX/7NvfZnZot1UCKFzoDelad+S0PohxonGT2cYoQIdM3zSJH4gWlnYqlpN5?=
 =?us-ascii?Q?PHVZhQKihkqocdc9WwAc3GsXHEvo02vLSOEnnIvTHY6WuFYXHxInN8pg8kdf?=
 =?us-ascii?Q?oyDWcB4kv/PAanj2q0oLFzjij50D66PqhdDBqAX0RppDWN4T+OSjTSpCW3+2?=
 =?us-ascii?Q?BZw7+nfOGDolpb8K6pj2QbTWApVDYsTs6Le3HZDzTRFJgdULcVaJWcDkf1zn?=
 =?us-ascii?Q?FF+dFd142ngBTqpfTtqjQvyoHj1TD5tnMqSIGY8MycFgjMDXuo8bq/C0KmGB?=
 =?us-ascii?Q?F6mmm28lAIo6QHvRsst1fJ9wkivPJDXXi+mRlFjsoKBW6xieZD35Qej24rTY?=
 =?us-ascii?Q?mRssoUGcHSqqDw/49hW6VrFO6Zxr2Wetjqp1OVxtxQAhA+pVVR3rbT66W836?=
 =?us-ascii?Q?nBmvVT26IZaJeTKAbASx+fDiQ3JKk5NCsm4xdUfjpuGLDUEop5Xlj3PEuNnP?=
 =?us-ascii?Q?U4MsfavpVL8u144EjDTu3u8sCw+BHyYzTIlA/3SJA8nGEcNEsa0eJdIF6mac?=
 =?us-ascii?Q?wC/kWBE62bvKzimO5Pg6dDe0WGAwYHn+0rNaVuD2TKqL9ZO+5DtXPK7UxQJG?=
 =?us-ascii?Q?/tNxFpRy633OuSX99IpviTQFmygp/FtgJ+2WmS62AenkEmbJ2NIzBElJsU6W?=
 =?us-ascii?Q?UwNaw4CGNvoajeAkIGVDkbTiWDIxafjC1MGZ4gS0PmYGZ25a9r7JBItBQVOk?=
 =?us-ascii?Q?3VfsL8mviD2Lv6FGxS8sMHb5Q3oYnwsKDho3CYwTECiIyz/qZuFKZ6MJlRcD?=
 =?us-ascii?Q?FGeRKlYjK4ztbmBhkTySQx7+ByBOM16kz6G1SITiDuVJxWYS+O1uwabAly0V?=
 =?us-ascii?Q?9UTxtRS3BFgKk0fezm41Nw6BqeBbBz8qCxo7D5+jtM0wSqlJRNRI?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fcc89798-91d0-42cd-ab21-08deba264a26
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 06:24:34.9502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D14VIBxHCEpiRg2ApFWqPjE0ncwxpTSzsywbjAGmlE//Is4W1gP9c1q90+ItdmNUWs8WUGeSgJLh3/pxL7usNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4655
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10810-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: EFA385C65FB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DesignWare eDMA can signal completion locally through edma_int[] and
remotely through IMWr/MSI. When channels are delegated to a remote
frontend, the local endpoint side and the remote host side must not both
service the same DONE/ABORT status.

Add dw_edma_irq_config, carried through dma_slave_config, so a frontend
can choose default, local, or remote IRQ handling per channel. Update the
v0 path so linked-list interrupt generation and DONE/ABORT masking follow
the selected mode. If a frontend does not supply the config, keep the
existing behavior.

HDMA native already uses dma_slave_config.peripheral_config as an int for
non-LL mode selection. Keep that interface unchanged and reject the new
IRQ config there until an IRQ routing model is implemented and validated.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Rename dw_edma_peripheral_config to dw_edma_irq_config.
  - Keep the IRQ config distinct from HDMA native's int config.
  - Reject remote-only IRQ mode on local instances.
  - Report IRQ_HANDLED only after servicing non-ignored status.
  - Drop the lockless irq_mode reset in free_chan_resources().
  - Revise the commit message.
  - Drop Frank's Reviewed-by due to the above changes.

 drivers/dma/dw-edma/dw-edma-core.c    | 66 +++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h    | 13 ++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 22 ++++++---
 include/linux/dma/edma.h              | 40 ++++++++++++++++
 4 files changed, 131 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 80b4a168225b..a70e0640d082 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -219,12 +219,66 @@ static void dw_edma_device_caps(struct dma_chan *dchan,
 	}
 }
 
+static enum dw_edma_ch_irq_mode
+dw_edma_get_default_irq_mode(struct dw_edma_chan *chan)
+{
+	switch (chan->dw->chip->default_irq_mode) {
+	case DW_EDMA_CH_IRQ_DEFAULT:
+	case DW_EDMA_CH_IRQ_LOCAL:
+		return chan->dw->chip->default_irq_mode;
+	case DW_EDMA_CH_IRQ_REMOTE:
+		if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			return DW_EDMA_CH_IRQ_REMOTE;
+		return DW_EDMA_CH_IRQ_DEFAULT;
+	default:
+		return DW_EDMA_CH_IRQ_DEFAULT;
+	}
+}
+
+static int dw_edma_parse_irq_mode(struct dw_edma_chan *chan,
+				  const struct dma_slave_config *config,
+				  enum dw_edma_ch_irq_mode *mode)
+{
+	const struct dw_edma_irq_config *pcfg;
+
+	/* peripheral_config is optional, fall back to the frontend default. */
+	*mode = dw_edma_get_default_irq_mode(chan);
+	if (!config || !config->peripheral_config)
+		return 0;
+
+	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE)
+		return -EOPNOTSUPP;
+
+	if (config->peripheral_size != sizeof(*pcfg))
+		return -EINVAL;
+
+	pcfg = config->peripheral_config;
+	if (pcfg->reserved)
+		return -EINVAL;
+
+	switch (pcfg->irq_mode) {
+	case DW_EDMA_CH_IRQ_DEFAULT:
+	case DW_EDMA_CH_IRQ_LOCAL:
+		*mode = pcfg->irq_mode;
+		return 0;
+	case DW_EDMA_CH_IRQ_REMOTE:
+		if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+			return -EINVAL;
+		*mode = DW_EDMA_CH_IRQ_REMOTE;
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
 static int dw_edma_device_config(struct dma_chan *dchan,
 				 struct dma_slave_config *config)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dw_edma_ch_irq_mode mode;
 	bool cfg_non_ll;
 	int non_ll = 0;
+	int ret;
 
 	chan->non_ll = false;
 	if (chan->dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
@@ -255,10 +309,11 @@ static int dw_edma_device_config(struct dma_chan *dchan,
 
 		if (cfg_non_ll || non_ll)
 			chan->non_ll = true;
-	} else if (config->peripheral_config) {
-		dev_err(dchan->device->dev,
-			"peripheral config param applicable only for HDMA\n");
-		return -EINVAL;
+	} else {
+		ret = dw_edma_parse_irq_mode(chan, config, &mode);
+		if (ret)
+			return ret;
+		chan->irq_mode = mode;
 	}
 
 	memcpy(&chan->config, config, sizeof(*config));
@@ -853,6 +908,8 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	if (chan->status != EDMA_ST_IDLE)
 		return -EBUSY;
 
+	chan->irq_mode = dw_edma_get_default_irq_mode(chan);
+
 	return 0;
 }
 
@@ -904,6 +961,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 		chan->configured = false;
 		chan->request = EDMA_REQ_NONE;
 		chan->status = EDMA_ST_IDLE;
+		chan->irq_mode = dw_edma_get_default_irq_mode(chan);
 
 		if (chan->dir == EDMA_DIR_WRITE)
 			chan->ll_max = (chip->ll_region_wr[chan->id].sz / EDMA_LL_SZ);
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 902574b1ba86..e2aadf0109b6 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -81,6 +81,8 @@ struct dw_edma_chan {
 
 	struct msi_msg			msi;
 
+	enum dw_edma_ch_irq_mode	irq_mode;
+
 	enum dw_edma_request		request;
 	enum dw_edma_status		status;
 	u8				configured;
@@ -224,4 +226,15 @@ dw_edma_core_db_offset(struct dw_edma *dw)
 	return dw->core->db_offset(dw);
 }
 
+static inline bool
+dw_edma_core_ch_ignore_irq(struct dw_edma_chan *chan)
+{
+	struct dw_edma *dw = chan->dw;
+
+	if (dw->chip->flags & DW_EDMA_CHIP_LOCAL)
+		return chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE;
+	else
+		return chan->irq_mode == DW_EDMA_CH_IRQ_LOCAL;
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 69e8279adec8..08ec2bd7856e 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -256,9 +256,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
+		if (dw_edma_core_ch_ignore_irq(chan))
+			continue;
+
 		dw_edma_v0_core_clear_done_int(chan);
 		done(chan);
-
 		ret = IRQ_HANDLED;
 	}
 
@@ -267,9 +269,11 @@ dw_edma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
 	for_each_set_bit(pos, &val, total) {
 		chan = &dw->chan[pos + off];
 
+		if (dw_edma_core_ch_ignore_irq(chan))
+			continue;
+
 		dw_edma_v0_core_clear_abort_int(chan);
 		abort(chan);
-
 		ret = IRQ_HANDLED;
 	}
 
@@ -331,7 +335,8 @@ static void dw_edma_v0_core_write_chunk(struct dw_edma_chunk *chunk)
 		j--;
 		if (!j) {
 			control |= DW_EDMA_V0_LIE;
-			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) &&
+			    chan->irq_mode != DW_EDMA_CH_IRQ_LOCAL)
 				control |= DW_EDMA_V0_RIE;
 		}
 
@@ -407,10 +412,15 @@ static void dw_edma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 				break;
 			}
 		}
-		/* Interrupt unmask - done, abort */
+		/* Interrupt mask/unmask - done, abort */
 		tmp = GET_RW_32(dw, chan->dir, int_mask);
-		tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
-		tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		if (chan->irq_mode == DW_EDMA_CH_IRQ_REMOTE) {
+			tmp |= FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp |= FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		} else {
+			tmp &= ~FIELD_PREP(EDMA_V0_DONE_INT_MASK, BIT(chan->id));
+			tmp &= ~FIELD_PREP(EDMA_V0_ABORT_INT_MASK, BIT(chan->id));
+		}
 		SET_RW_32(dw, chan->dir, int_mask, tmp);
 		/* Linked list error */
 		tmp = GET_RW_32(dw, chan->dir, linked_list_err_en);
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 3e15cf83b784..2bf2298711e1 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -60,6 +60,43 @@ enum dw_edma_chip_flags {
 	DW_EDMA_CHIP_LOCAL	= BIT(0),
 };
 
+/**
+ * enum dw_edma_ch_irq_mode - per-channel interrupt routing control
+ * @DW_EDMA_CH_IRQ_DEFAULT:   keep legacy behavior
+ * @DW_EDMA_CH_IRQ_LOCAL:     local interrupt only (edma_int[])
+ * @DW_EDMA_CH_IRQ_REMOTE:    remote interrupt only (IMWr/MSI),
+ *                            while masking local DONE/ABORT output.
+ *
+ * DesignWare EP eDMA can signal interrupts locally through the edma_int[]
+ * bus, and remotely using posted memory writes (IMWr) that may be
+ * interpreted as MSI/MSI-X by the RC.
+ *
+ * For the v0 eDMA programming path, DMA_*_INT_MASK gates the local edma_int[]
+ * assertion, while there is no dedicated per-channel mask for IMWr generation.
+ * To request a remote-only interrupt, Synopsys recommends setting both LIE and
+ * RIE, and masking the local interrupt in DMA_*_INT_MASK (rather than relying
+ * on LIE=0/RIE=1). See the DesignWare endpoint databook 5.40a, Non Linked
+ * List Mode interrupt handling ("Hint").
+ */
+enum dw_edma_ch_irq_mode {
+	DW_EDMA_CH_IRQ_DEFAULT	= 0,
+	DW_EDMA_CH_IRQ_LOCAL,
+	DW_EDMA_CH_IRQ_REMOTE,
+};
+
+/**
+ * struct dw_edma_irq_config - dw-edma interrupt routing configuration
+ * @irq_mode: per-channel interrupt routing control.
+ * @reserved: must be zero.
+ *
+ * Pass this structure via dma_slave_config.peripheral_config and
+ * dma_slave_config.peripheral_size.
+ */
+struct dw_edma_irq_config {
+	enum dw_edma_ch_irq_mode irq_mode;
+	u32 reserved;
+};
+
 /**
  * struct dw_edma_chip - representation of DesignWare eDMA controller hardware
  * @dev:		 struct device of the eDMA controller
@@ -76,6 +113,8 @@ enum dw_edma_chip_flags {
  * @db_irq:		 Virtual IRQ dedicated to interrupt emulation
  * @db_offset:		 Offset from DMA register base
  * @mf:			 DMA register map format
+ * @default_irq_mode:	 default per-channel interrupt routing when client
+ *			 does not supply dw_edma_irq_config
  * @dw:			 struct dw_edma that is filled by dw_edma_probe()
  */
 struct dw_edma_chip {
@@ -101,6 +140,7 @@ struct dw_edma_chip {
 	resource_size_t		db_offset;
 
 	enum dw_edma_map_format	mf;
+	enum dw_edma_ch_irq_mode	default_irq_mode;
 
 	struct dw_edma		*dw;
 	bool			cfg_non_ll;
-- 
2.51.0


