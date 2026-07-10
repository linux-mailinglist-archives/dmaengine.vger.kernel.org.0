Return-Path: <dmaengine+bounces-12283-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id C65+HlmqUGpi3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12283-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:25 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1DA738570
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=MlncsMwr;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12283-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12283-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA17A300909C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618B43D45F4;
	Fri, 10 Jul 2026 08:15:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021109.outbound.protection.outlook.com [52.101.125.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5763EFD15;
	Fri, 10 Jul 2026 08:15:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783671336; cv=fail; b=mGFgUUfKSvrLcOOegw+g4bXyijsXh7hjLTZFKGHDeMObCnSbXcicEORu5SzOaEsG/UfaYLnoqrClogCRsG8ekj6Du+TH/8j8/XjcEHNHELHhZ9QiuXJZN+Fk7nRwTjJCLNtPmYf302No/rLJKDcIMFm1TdmP0PBA1dnL/pepDb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783671336; c=relaxed/simple;
	bh=bDvple806ASGqGthIE7SO12nJ/Sxn4mAjZgZ2e9Qd1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WMQ4N8bAQwCLL3awND9c847jsHpLDPyWKaVxhJ2fO4CIvcToIEVOZbZmsV8BBfEAYwnKXKn+H3DzD0IFlehBXcp5pReeIcmd0PvqOXaEu7AoxJs1k+gM60eEBOTYGV6CFVIgoK6iulthhOX6A+O5F2dvQ3XdmfhmG6bcCEIut/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MlncsMwr; arc=fail smtp.client-ip=52.101.125.109
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnpFCSpo1ODfPtJZs94I/nOpQH5Re6KAWWCLUcibsD5uBMNJJmieGiPSaZr/tL4x81WSSOClbPxLcBSOK11FgurLmjdMZOUwNqTIk6KQUlo63LHf43r35Mw5Z0qYsUARrdP4Kxuq5o9sP7fsbMzf8YBoCKLmRNQo5VOSX3ofpAkAmI4cCHg4M1OXYuOdX2iFTaNbE+zU+13bOz7wdEFtRKkrM/LNLxu/hhP4F2JIo7q1i8NA8Mb3KSiJ5RXXwoMCRuJd30taNF0IhE/sO/EfbiIOqR7r0jkNKicS+ZiFHkLLRR069fVuRkSBHLfIb9VniP1KlBsbk1bu8IhYq71L7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8y2Qb2uRIA4aEB/DZvrhUqf1j72RpHu29giNqQUg8Y=;
 b=p0PxZ66SJXYco3dn4B3TJgSWkfdYOhPwk1nDrx89InjTuav0sHHKX+Qzz1rTJHBEqiVRC7lCiQSJwKO3w5wHLMR5h1HWbrfafvKr9mDo14Lq/BorGh4/zWiMPVp68pUKyvWNfnw6sVBzHlEclhupB5nQj8e7MUdsvfrqqq+/98CWQr4+qz6giAvpavtWdDDX8+oleZXcOjPyPyKDxN6Fy+Gw2nxGrADrayyqLo9sNT9IE4aJSisz3FZ1iMazIKw6pTsXymfyJov0ForZQtuQoGB2v7m8AOVTX9BnNHsoCZ5B7V0mYgEAJBbFbh2g5/tY3n6HOPvlWaTcfsNXmUpdlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8y2Qb2uRIA4aEB/DZvrhUqf1j72RpHu29giNqQUg8Y=;
 b=MlncsMwrWTWviZFO6ha7poYJF8TYD+VbgANExAsu7Zl4OzFOY/ztOsH/f4uWIO1of1FU21mWoHoBQv8q+tzLG2KJMVgHYeH88HViZ4G40BaaYMvCbdpalIvK1YuhnPtxgTVpTJumNteA8BZZmVqJWvh6hmoCFCZX8TUpYuouQhI=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB4074.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:2cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:15:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:15:31 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 12/14] dmaengine: dw-edma-pcie: Handle optional data blocks
Date: Fri, 10 Jul 2026 17:15:16 +0900
Message-ID: <20260710081518.2394357-13-den@valinux.co.jp>
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
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: 39a16159-4661-4471-a0b9-08dede5b6877
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|10070799003|23010399003|366016|3023799007|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xJEc3AQ8RK2ZNawNlJ/OBsMWciXgtwFNc9p7cpyGdpVLlu6bfQbrRx2AL/eomXwYbqvIz9HbubJuEXjCXYWlkNH3uktqj7C6a/970FYfXBHVXjjg7uI8o6KWlf9J5deQyvNvMW4NHiIl/GtXffUiX9d1OgFPoEGu0YPn/kR782kJ62Z47y/b5+xkSCmQodyOyQ0a2SjsCzs52HC//wBqkUMK8Noe9Xb+y+wqHrFgSkFz1RMiVNt56AIxqlE10SuatZlZSjDsqweiZ4mXBw+5NcRol9e2dF7mawCbt7HFMuNX2ODeua8OZzDwjkxv26SYi46vUWUOImHvUJiGz19h/ybl627yN16ce3Ea4RVeaWTzKad0itgsug9iSNAENAm+olCg1GMFuX1MLuU8a0W7kXi1VQjMwn8OMgH4mMIVzqUqp53Xx68nq3S8jPJhk/1n1Mcan25VGj69QopRZaJU3Kbg+zkZr1j0LpJ/M0kuCadsky0w44LmJ0o7Ql1nTDdu/VhQzVNC1pbESZl3ROLlQgUGHrd++7eUBsuNuw4bc2yJP20GfYgm7s3WNV+ZPhzCyoYisSaL5l6v+Rbm/SSHpxEzkwkcxgwSYD+ho5ZY8kjDh+HttN15bq3loc00N/2TXOpim8/rCQkzKlaXpKqGI/iFHoaoGLCG/Gg0T6RrDsk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(10070799003)(23010399003)(366016)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uKeC46UolobSzNOM3iHy51BAuKaMHqJGNcHLcU4FhgsRObNFVn5KU4axLUSh?=
 =?us-ascii?Q?t7bW+30v8saG0z1xt3ZkGXo6QKBamHd4sGch4293lmPgjYAgUZUMJIrl2WZf?=
 =?us-ascii?Q?SB9JnWOAvxSihqF+TrMjRwVTCBZv2oKAm79ZZIQMIZYWMbB1XK4+uUI7eKCc?=
 =?us-ascii?Q?DFhjK8cL1JZFSng/bo+2jbkhU5jvNfLK/CU/dbAE4oghSYYmgEbcY1Q5+rac?=
 =?us-ascii?Q?EIESONQ9FVCGSh/45H86uWM2gGQ2BYc8FWNlBG38Vo08O1pjbLRh9oWLe3B/?=
 =?us-ascii?Q?EJjTWSXIOdx8+myXXXaMw8TkeVpBjOezoQReBzKET+UE6cvo6F3C5BEon3Pk?=
 =?us-ascii?Q?pEPC/LZSfSTaHojcB3dVnLdHyekWxdGWpJYB527tNZTS18eU4aON1k446c3O?=
 =?us-ascii?Q?oV7+b/i4iu8ZIeMuJz6a4LR3h+s5oxfsptKDJBszDRvJFe4R+7d1XgOc9fRe?=
 =?us-ascii?Q?6bAIIwQ71RkpNz+AU2XsCydiufEXIj3S8ctj0xtYnCxK12luTWHVKf+QWo/h?=
 =?us-ascii?Q?qo9ZkPC+pbIhHmmYMvqWxOGVpP9qTFONzMwpEr+lSfJGNi+BYM0YaljY5RND?=
 =?us-ascii?Q?VBvyVjME1LnFr2QY9wo/hrf6jyYdUn8I/hxhT4LX/TEncNWZTlBn52MSHMyN?=
 =?us-ascii?Q?vxKoUcF8RdwnO7RuuNDysgBJFgxoasgcZ/YaMfhqagEOzgg9CMsy0Be8EnCq?=
 =?us-ascii?Q?+5z78PaHSEjNzP2/V4EixD/vN5uzSGFQj4huPbEm7JDidbGn7P9bSV0Cc2jk?=
 =?us-ascii?Q?edGEymFOBlb/up51g1jZ0vP9kHR0lqFYZxr7GitWsu3apA5pcDT4epWQkEjJ?=
 =?us-ascii?Q?Y0i1/X1zfex6FdFICdYR5iGGW1lMWW7bIAPYedAtdmzSDIUJizRuZ58wXsmB?=
 =?us-ascii?Q?cRQi/w2UUcQLFMS6ytur3+XgqC/bkeiL4x6cY4JoP3GYwkq7U+kopfdJ8znI?=
 =?us-ascii?Q?1lJwiESD4q13ZJJOBjJUHqwXdYltCHPvBG+PnpN954PKrALwb//1QwfllEPv?=
 =?us-ascii?Q?jyUBHcakbvAhhHNTXmpq8fCxMPN5o5jF1ERVPl56ytJEFABPp6mLJ4X6KbMn?=
 =?us-ascii?Q?dPqSlab9lHTXkpeQNfKP3vI6NX4LuV+qlLWbrSwEoNJo+1LmeMsdEDGcMsKs?=
 =?us-ascii?Q?4DluUkoC2F1wcMhuib/LVf1BDmK08V682ZJreP6S9sfu0zsow732S4yvg0wo?=
 =?us-ascii?Q?BhuJCZ0PopSDw373OynNhUoUykDjZRFz6vV5kQNDh7/xU4uoQC9ILvdPF08Y?=
 =?us-ascii?Q?i6U6Pv6AquSgbcGEfCOx/En1z1BHIsmTrNdoxMDc2jO4zwvB07UaQxVh+eXu?=
 =?us-ascii?Q?m+Z8UxAeA0ydzFio87aJBkBt2shvj8cXCg4y/pH2xtHRwJR6yqALvEtBqv/l?=
 =?us-ascii?Q?c0N4ZJBjv4+P/Qz5asWZv1Yqsw0voiRo5GP4B+J3A1eJsY8xPWIwBnxL+dmZ?=
 =?us-ascii?Q?uSwVUaJYgTsHzObyTQxg1liFeQn8+FxXdUQlOUZKL0mhMjP8rEVKhjelVG7z?=
 =?us-ascii?Q?QZ9D09ufHmavGeGr16XhHq0mrc3uQAu4hKPyPH7vATVoQTQw4pJSoSr+f1AQ?=
 =?us-ascii?Q?uKiLdxT/wgWe+7bTygRsXyvWDOwSnUF3poBLdAs4kFSxmFqUeWGpN1T8VSwK?=
 =?us-ascii?Q?xjt9MZW3wg8ZK/QBmQqslQyynjiCgIubt3oheiL3Zj3W6CiV3gGmXWY0lU5G?=
 =?us-ascii?Q?Ct4QWoi7o5cvU3Mvhg/LpBCRFNpg9dz6/1T3kJ5YD0p76Nz4YA40k1XNSOgi?=
 =?us-ascii?Q?lk8pX49MGFAhMJkVb8YapI7+CatrjDQ6HJ/Po4vRRzDvbFuqEVo4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 39a16159-4661-4471-a0b9-08dede5b6877
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:15:30.9950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqExaBtzFha3qwoIQ0wQ/bSFqI74P9z0Mp8mYI6vr03eavQesCNGnDMWwL6aY0luTosRrleEK3OJGvaGOcY1YQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB4074
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
	TAGGED_FROM(0.00)[bounces-12283-lists,dmaengine=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,vger.kernel.org:from_smtp,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DC1DA738570

Skip data block BAR mapping and debug output when a channel has no data
block size. This lets future providers describe channels that only need
descriptor memory exposed.

No functional change intended for existing Synopsys EDDA and
AMD (Xilinx) MDB/CPM6 devices. Their static channel descriptions still
provide data block sizes where data block windows are used. A zero-sized
data block now means "not present" for future metadata providers.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/dma/dw-edma/dw-edma-pcie.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index 06c52819059f..d72c0a19c604 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -430,11 +430,13 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 	mask = BIT(dma_data->rg.bar);
 	for (i = 0; i < dma_data->wr_ch_cnt; i++) {
 		mask |= BIT(dma_data->ll_wr[i].bar);
-		mask |= BIT(dma_data->dt_wr[i].bar);
+		if (dma_data->dt_wr[i].sz)
+			mask |= BIT(dma_data->dt_wr[i].bar);
 	}
 	for (i = 0; i < dma_data->rd_ch_cnt; i++) {
 		mask |= BIT(dma_data->ll_rd[i].bar);
-		mask |= BIT(dma_data->dt_rd[i].bar);
+		if (dma_data->dt_rd[i].sz)
+			mask |= BIT(dma_data->dt_rd[i].bar);
 	}
 	err = pcim_iomap_regions(pdev, mask, pci_name(pdev));
 	if (err) {
@@ -497,6 +499,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 							  ll_block);
 		ll_region->sz = ll_block->sz;
 
+		if (!dt_block->sz)
+			continue;
+
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
 		if (!dt_region->vaddr.io)
 			return -ENOMEM;
@@ -522,6 +527,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 							  ll_block);
 		ll_region->sz = ll_block->sz;
 
+		if (!dt_block->sz)
+			continue;
+
 		dt_region->vaddr.io = pcim_iomap_table(pdev)[dt_block->bar];
 		if (!dt_region->vaddr.io)
 			return -ENOMEM;
@@ -555,10 +563,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			dma_data->ll_wr[i].off, chip->ll_region_wr[i].sz,
 			chip->ll_region_wr[i].vaddr.io, &chip->ll_region_wr[i].paddr);
 
+		if (!dma_data->dt_wr[i].sz)
+			continue;
+
 		pci_dbg(pdev, "Data:\tWRITE CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, dma_data->dt_wr[i].bar,
 			dma_data->dt_wr[i].off, chip->dt_region_wr[i].sz,
-			chip->dt_region_wr[i].vaddr.io, &chip->dt_region_wr[i].paddr);
+			chip->dt_region_wr[i].vaddr.io,
+			&chip->dt_region_wr[i].paddr);
 	}
 
 	for (i = 0; i < chip->ll_rd_cnt; i++) {
@@ -567,10 +579,14 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			dma_data->ll_rd[i].off, chip->ll_region_rd[i].sz,
 			chip->ll_region_rd[i].vaddr.io, &chip->ll_region_rd[i].paddr);
 
+		if (!dma_data->dt_rd[i].sz)
+			continue;
+
 		pci_dbg(pdev, "Data:\tREAD CH%.2u, BAR=%u, off=0x%.8lx, sz=0x%zx bytes, addr(v=%p, p=%pa)\n",
 			i, dma_data->dt_rd[i].bar,
 			dma_data->dt_rd[i].off, chip->dt_region_rd[i].sz,
-			chip->dt_region_rd[i].vaddr.io, &chip->dt_region_rd[i].paddr);
+			chip->dt_region_rd[i].vaddr.io,
+			&chip->dt_region_rd[i].paddr);
 	}
 
 	pci_dbg(pdev, "Nr. IRQs:\t%u\n", chip->nr_irqs);
-- 
2.51.0


