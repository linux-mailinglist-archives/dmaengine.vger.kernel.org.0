Return-Path: <dmaengine+bounces-12282-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 9eRbFFKqUGph3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12282-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:18 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E121E738568
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b="JIgiQJb/";
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12282-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12282-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9B3A302734D
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E333EFFA8;
	Fri, 10 Jul 2026 08:15:35 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020113.outbound.protection.outlook.com [52.101.229.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971B3EF0A0;
	Fri, 10 Jul 2026 08:15:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671335; cv=fail; b=LwthneXSkIiQgUTlOAagmKfAzSQdcbgzaMovUtQFZm4y166If5c+8rDKrcBHmRVFcDEEgTQt7f215UappLJaSreH43pTikXvGvo2hrWf0udh4OZFbHkvOYrsW+I8Fyaz4UCuGYc4JjSbpIL5LSXsfR3475afnkEOkn1lxyQxpok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671335; c=relaxed/simple;
	bh=VVFnefC23ht7ed5Z8EvWeMmABltwyziozoQ91nmPUq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HWDMmH/wRR+rkeXHuIvYMDXenhuozqueDv5GU/GWuJIiaUMwuBA2PMQF5C+SFiO6qPHIYAuxJVXMS5rM0vas6VWnNLXBkYYpiLq5drzxlffqmrnYikuitC9SCCOjK9juhXStEGt93h1kUCMWOv0G+3ZlrtDKJIaB47wseZEOCws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JIgiQJb/; arc=fail smtp.client-ip=52.101.229.113
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mh8krzVRmGBhuQBlFFUrRnilHVPztbbb6e21ZoLdoBS2suRiCKhgElJJVsnLnIiWmkbqrlsyBkTjsSlJ9uBVXlVZHg1o5Bkv9CfRvVZmLqgNiO4S9p1kbWX3Pw/gmPrZA61yXo9a+SqHJ0lz+AxaD8cd5ugFX/4g8AqVybNQd1DmjpeYH3CT2I1Eed05ZNRpDA4fXudQmsrf5J5FfxW2u9g6ldIX9IneASBnkwaJLEMCw1I+7zOfp0lBAcEmA8zK/Dm05Z7/7nEkuLvziRDknEjbWTeOMOySGp1G37cW8DAJ9dym4KvR2bYA9NnRQZ7zzeRP4bkhgA1XEFRoZv0+jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jU7ei+6EImx6Vqpqc26AiUBf6tlF0kgTb/Ebs/4LaQ=;
 b=ccyVB/A7s5vCYtfIH51ww95FxXorFG3yxJ3kYhby9u131WfVgUZPXVK018fI+UkoyZjnB2/a/kQg+z46mH5zycNo0JdOlCHnV0y5sjJMREB9wFITi9H7OFjMa//PRhS4yKHkFaYclPR+wzIJJ58kCYpvWo2LH8XMNs/UW98EXhyZ8LPFV4SJ9BOHUDkiAcABt8g6PN+IxUigGYv807OHaIowzQmgdfZHMS7irzm3/JTRDJoREChp20wqqgJdiSCk5EBpNvDr2gqZYNMg6yVNdjPlE69xDaxZkxKNeGetnZdJ4TaXsPR1GiexRVFIZClALVsxyODGiSd1NWcKJR8/bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jU7ei+6EImx6Vqpqc26AiUBf6tlF0kgTb/Ebs/4LaQ=;
 b=JIgiQJb/x5ac3/XO1/00mNybem8pf4/oNTKc/NumK8O0AmMCFtxW/U2PuUuREiOwpsesdhEJZp+YZPwoc6ouTcmmPz2/ojcS8i6KWwMbyS/Q+a2rEB0XzM2VY8rIC3G2jNWXK113d2KpfEqsfg1urQKMqcEi5mRTGfKRC2fmFzM=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB6307.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:409::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Fri, 10 Jul
 2026 08:15:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:23 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 03/14] dmaengine: dw-edma: Add core quiesce operations
Date: Fri, 10 Jul 2026 17:15:07 +0900
Message-ID: <20260710081518.2394357-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710081518.2394357-1-den@valinux.co.jp>
References: <20260710081518.2394357-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:405:37d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB6307:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bdc1ac-5810-4443-8a9c-08dede5b63c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|23010399003|376014|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	dkC60PmsZ1JeR0ogk+PXU9U6D4SXHgwGMJJ25YVZ6fqoHXY5S2+k34Int2OYpI0kRy0XnUqMllkQgz5kj8Tqh3DBtsUEm3U/HHLOLJGXrCstxTI7Zd/oli/PviPXFgz5ab+Mqabd06j+CNv6S+j1TJKFXdvOWhLQ8UgEoOV+qFBBDXZEk3/oXPVqqembWhqogCTMRrFa0YZskKNiY1jtKlPXj52P96/HsJjQkJ8h7lgSKz+H24ZiNlH2edOo9mOpQ+VKy48e8tdUUzVz+lAVY7nKGW4Xc+98VzW/49E/0ny/HPqdC4L3DkG9Ku307TAzGQG+ZwJTXd7B/7v3qVsHuECjJgqj9M00QinTrmaLco/p/kRMZyWoj8oz29obMnAG35jcNdgKLuTiFNSzhpoNSo5IvKxbOhWCItPweNjNliJKekc6f+jThax+PaQ/qWcG5Va4EK0nVNK+T/iZCwtl+HPhIw30FGqRbHTFj0UrYrlVcAE9U/1FOScx4goToyPhrHWWooVRvBeL1l/N1WTWFHYNzwC+WltYo98Op5y/dw00YV05IEtLaZ3pSj0zxuUOqxhMZ4kBZ5JyK32+FkkLQNxhPzQKBmNBkLv6UKX3l4eQK9mt16sdl89gxEQLHzoTfwCmYezcsyKNidVrA1o53kCRDKjuYRX8pp+QeohfJz0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(376014)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFFoP2GzzyAG7TZv6vwHcIpVtukazjzkKbR3s9M/NIDm4BaXuCewcZOVWDvd?=
 =?us-ascii?Q?D+fObYu0ZGLyhxF1qDBZ+Yc+7Tn2tGW1T8n9kPiql7xfHweZq6ob/LG1pmIy?=
 =?us-ascii?Q?nA6AqWT9/9lybFHx/JkqmVDupo9xZZuWG9qyrOF7JsnrMsQ9kcL7DuTyPdSx?=
 =?us-ascii?Q?7LSXMN+W191BSsXOxwDdisc+3JB7boaZj7ofmZjPWhL8oaB9uoaExb50frYH?=
 =?us-ascii?Q?MDMwFXozBoJI+5kzyDU/ytrp2zVPxxvHUfCpFIdVBboao18MZjRsxfItOckN?=
 =?us-ascii?Q?oz+ifmpYSOsJeOn+STvayLP67U+4pWTQi23LY4qNqyocbxg1gD7l3+mgWKzA?=
 =?us-ascii?Q?xL7+MRQGG9XtE/d+AFU7ficFSyeW9bg4PtNwToZ4oZ91+CVJlfoSfKOzVNSr?=
 =?us-ascii?Q?ItTbhwEx1ZlVJlDaMlQAhxPfL0AFhD91XxoTATbXXa6KM3TjE4r/JSQhNoqC?=
 =?us-ascii?Q?bUUo2Es9VNG54nHbtJPLXJ3P+GKRwnY25WTYG+cIO5EnPwU87nUnqVM9ETJ/?=
 =?us-ascii?Q?JZeQQ2kLlHfhc2dkpUjyyvoiDXyIZWD7pVoGUMxvsz6Xra3NBTDlcNhatnOu?=
 =?us-ascii?Q?68I0QUMI3I5gJco8vxJN23C5/4PJ0RuuWdt0Y5SvbteQpUNFULdjyisz5GLn?=
 =?us-ascii?Q?/5/ZFgIOgSZiin55DPXYrHbo6mZiHB5+PAfR05RdineXQfnQWMpzivHgprCO?=
 =?us-ascii?Q?bbpF3rP73vBOS+vteNYstJu7XZvLWmMaI1spzxDog5y2zA9Ufz9jo1ktWFu1?=
 =?us-ascii?Q?kJ5IC1I0D9Erv/H2TuSuFNHdF355ehpfj0ZJnWRowjrLOkQeovbvHcLwVC/F?=
 =?us-ascii?Q?5ToWhjP83RYNKCXnJC5cz0LnMIMtWJc6vaBNP5tf9v1EqYc1vxnCfmhsi/6c?=
 =?us-ascii?Q?0pnwje9tdkg4fnGiNpTR5GAj0lc4oQaxIB1VM98kO4+3Qcr5x4KWkRECMGM6?=
 =?us-ascii?Q?GnvVTEddElGRDaxHB4+OBNRKr70sBMvKg6yBOoa4gl6EZWEBeSp9J1fwAJD6?=
 =?us-ascii?Q?aOMrJOwHjJu5Wl1E1sWgb7uFH+E0rddCP7wCePmfEPWhELnjkR1txVoY36bq?=
 =?us-ascii?Q?iyb345ACL+DCpjXr8wwFNdZlNOmYoefXaZjAHgaHX/jhBR+H+sEw6nEWy6fJ?=
 =?us-ascii?Q?mf9lIc5QgqbSdJWZdK7Ow757A21SnVJXHuVXrACDe1djUq1/okov7RK8simo?=
 =?us-ascii?Q?hzEdTiDlGFGrOFpwg/zk5hdLYbr94rpO3pg9IGw4irMmbZiZSSkJ/8wQS5EV?=
 =?us-ascii?Q?bqi2732JbwCk0KhmNY++nQSLDdUIvhtMbuKp9mmmALzP4iINwKDvdTzwJaLg?=
 =?us-ascii?Q?lcX2Ci4HckRydW0nPGzvPGc8V3ASWfZzOsRRPIWTxHJOBORoIzl/dvmxD5Ip?=
 =?us-ascii?Q?oPXtNytN9+MVrm9dcWqbAzhInFswNqDoerZ1ZwAyzoYbfeKNEC9ewI+c985c?=
 =?us-ascii?Q?HL7mhed3ORb9zulDdqVUP7ijiSpQLekR9sGO7sJeCPocdtq28NxKvwwJV3gK?=
 =?us-ascii?Q?s8d9ACrol9vrUEwvlO7Dra4Vi9WOp1HQ29oKEY/RPDK9adkvXReV5yUulZ+k?=
 =?us-ascii?Q?OoxEDKc2AlzRRaDC/hPed7W+61aSsxzR4Yy21mFhzjtMA0KZHeap1ir1ul9+?=
 =?us-ascii?Q?WBOxvS6H5JUneN/wJh9xRdvWW1Q3CT9+L38kKEXy+eueMmQYEonREsD74QQ3?=
 =?us-ascii?Q?7GuvaR6V7nc8ddpbrVlmRnfvx4/U3Xo0aQKfnus9gabzejmilFAnmXa3ljlH?=
 =?us-ascii?Q?Np2VqhQEg95DE9SeBc0f5k5qJHliXqPIk275+XaYacWrV/f74vu0?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bdc1ac-5810-4443-8a9c-08dede5b63c4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:23.1017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ywrf49FK9KiV1eaQx6tz7cMRA6oDCoQvkCYFxDUnNPr66Y203BDhHpaq1RC8xDrr1J3zBG1Ra4ILY5zk1UuLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB6307
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
	TAGGED_FROM(0.00)[bounces-12282-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E121E738568

Add core operations that quiesce only the resources represented by a
dw-edma instance, separate from the existing full controller off path.

For v0 eDMA and HDMA compatible register layouts, quiescing one channel
must quiesce the whole direction because the enable and interrupt
mask/clear registers are direction-wide. For HDMA native, the operation
can quiesce the represented per-channel registers directly.

No caller is added yet, so this is a no-functional-change preparation
for delegated channel reclaim and partial-owned remove paths.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Mask and disable v0 eDMA/HDMA channels before clearing interrupt
    status, so quiesce drains status raised during disable and avoids
    stale DONE/ABORT/STOP bits firing on a later re-enable.
  - Drop R-b tag due to the change. @Frank, please take another look.
  - Document at the v0 ch_quiesce() implementation that quiescing is
    direction-wide and callers must own the whole direction.

 drivers/dma/dw-edma/dw-edma-core.h    | 14 +++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 34 +++++++++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 28 ++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 3ea384706b1b..8657275d2484 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -134,6 +134,8 @@ typedef void (*dw_edma_handler_t)(struct dw_edma_chan *);
 
 struct dw_edma_core_ops {
 	void (*off)(struct dw_edma *dw);
+	void (*quiesce)(struct dw_edma *dw);
+	void (*ch_quiesce)(struct dw_edma_chan *chan);
 	u16 (*ch_count)(struct dw_edma *dw, enum dw_edma_dir dir);
 	enum dma_status (*ch_status)(struct dw_edma_chan *chan);
 	irqreturn_t (*handle_int)(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
@@ -186,6 +188,18 @@ void dw_edma_core_off(struct dw_edma *dw)
 	dw->core->off(dw);
 }
 
+static inline
+void dw_edma_core_quiesce(struct dw_edma *dw)
+{
+	dw->core->quiesce(dw);
+}
+
+static inline
+void dw_edma_core_ch_quiesce(struct dw_edma_chan *chan)
+{
+	chan->dw->core->ch_quiesce(chan);
+}
+
 static inline
 u16 dw_edma_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index 14700ac42fa8..32df5d13ba8b 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -160,6 +160,20 @@ static inline u32 readl_ch(struct dw_edma *dw, enum dw_edma_dir dir, u16 ch,
 	readl_ch(dw, dir, ch, &(__dw_ch_regs(dw, dir, ch)->name))
 
 /* eDMA management callbacks */
+static void dw_edma_v0_core_dir_off(struct dw_edma *dw, enum dw_edma_dir dir)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&dw->lock, flags);
+	SET_RW_32(dw, dir, int_mask,
+		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
+	raw_spin_unlock_irqrestore(&dw->lock, flags);
+
+	SET_RW_32(dw, dir, engine_en, 0);
+	SET_RW_32(dw, dir, int_clear,
+		  EDMA_V0_DONE_INT_MASK | EDMA_V0_ABORT_INT_MASK);
+}
+
 static void dw_edma_v0_core_off(struct dw_edma *dw)
 {
 	SET_BOTH_32(dw, int_mask,
@@ -169,6 +183,24 @@ static void dw_edma_v0_core_off(struct dw_edma *dw)
 	SET_BOTH_32(dw, engine_en, 0);
 }
 
+static void dw_edma_v0_core_quiesce(struct dw_edma *dw)
+{
+	if (dw->wr_ch_cnt)
+		dw_edma_v0_core_dir_off(dw, EDMA_DIR_WRITE);
+	if (dw->rd_ch_cnt)
+		dw_edma_v0_core_dir_off(dw, EDMA_DIR_READ);
+}
+
+/*
+ * The v0 register layout shares interrupt control per direction, so the
+ * whole direction is quiesced. Callers must own the direction entirely;
+ * partial ownership mode validates direction granularity for this layout.
+ */
+static void dw_edma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
+{
+	dw_edma_v0_core_dir_off(chan->dw, chan->dir);
+}
+
 static u16 dw_edma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
 	u32 num_ch;
@@ -554,6 +586,8 @@ static resource_size_t dw_edma_v0_core_db_offset(struct dw_edma *dw)
 
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
+	.quiesce = dw_edma_v0_core_quiesce,
+	.ch_quiesce = dw_edma_v0_core_ch_quiesce,
 	.ch_count = dw_edma_v0_core_ch_count,
 	.ch_status = dw_edma_v0_core_ch_status,
 	.handle_int = dw_edma_v0_core_handle_int,
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index cc908ca24061..be22f9f811ca 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -73,6 +73,17 @@ static u32 dw_hdma_v0_core_int_setup(struct dw_edma_chan *chan, u32 val)
 		     HDMA_V0_LOCAL_STOP_INT_EN;
 }
 
+/* HDMA management callbacks */
+static void dw_hdma_v0_core_ch_off(struct dw_edma *dw, enum dw_edma_dir dir,
+				   u16 id)
+{
+	SET_CH_32(dw, dir, id, int_setup,
+		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+	SET_CH_32(dw, dir, id, ch_en, 0);
+	SET_CH_32(dw, dir, id, int_clear,
+		  HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK);
+}
+
 static void dw_hdma_v0_core_off(struct dw_edma *dw)
 {
 	int id;
@@ -86,6 +97,21 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 	}
 }
 
+static void dw_hdma_v0_core_quiesce(struct dw_edma *dw)
+{
+	int id;
+
+	for (id = 0; id < dw->wr_ch_cnt; id++)
+		dw_hdma_v0_core_ch_off(dw, EDMA_DIR_WRITE, id);
+	for (id = 0; id < dw->rd_ch_cnt; id++)
+		dw_hdma_v0_core_ch_off(dw, EDMA_DIR_READ, id);
+}
+
+static void dw_hdma_v0_core_ch_quiesce(struct dw_edma_chan *chan)
+{
+	dw_hdma_v0_core_ch_off(chan->dw, chan->dir, chan->id);
+}
+
 static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
 	/*
@@ -365,6 +391,8 @@ static resource_size_t dw_hdma_v0_core_db_offset(struct dw_edma *dw)
 
 static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.off = dw_hdma_v0_core_off,
+	.quiesce = dw_hdma_v0_core_quiesce,
+	.ch_quiesce = dw_hdma_v0_core_ch_quiesce,
 	.ch_count = dw_hdma_v0_core_ch_count,
 	.ch_status = dw_hdma_v0_core_ch_status,
 	.handle_int = dw_hdma_v0_core_handle_int,
-- 
2.51.0


