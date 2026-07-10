Return-Path: <dmaengine+bounces-12271-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AmOeOVCqUGpf3AIAu9opvQ
	(envelope-from <dmaengine+bounces-12271-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A432738562
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 10:16:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=valinux.co.jp header.s=selector1 header.b=wrtu7hWH;
	dmarc=pass (policy=none) header.from=valinux.co.jp;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12271-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12271-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62AE1306054F
	for <lists+dmaengine@lfdr.de>; Fri, 10 Jul 2026 08:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132703EBF02;
	Fri, 10 Jul 2026 08:09:21 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020075.outbound.protection.outlook.com [52.101.229.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077193E7BB6;
	Fri, 10 Jul 2026 08:09:17 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783670961; cv=fail; b=Tw6xxKrMLAXB6DWIOSDmUgqLKvT3QyBQqFptA5DGLAe+bFD1UXGxVtOAmQFML+bFIEJ2LMJW5MyyZl7XptXli2l8WZvEBJnuU2HsahInYhHz72o05jpCHJqSHZkMZmC63JZI2xirEORbbW46xEYZs4cuGpxa5Lcn7gMkfWQkD1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783670961; c=relaxed/simple;
	bh=JsEZQXKqWAEJktQtI5ErUHf+TAxz7DLzOrxnpvAwcrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIaj5uSCuYMbZsasZDELpirsPvxE7YM45uKBuSSKXImHJwjfa5ydDjzHYIuVmKTa+ZUHKbXSjzk0DjvJor/U2IHwxEZOwikUxzj/kR+SNn5MYrn52LN+AmfYgM+gWv/boPJuG6tWRbyCKQ+w2IDW4D4pHM/P8V8xT6k12I3h0Ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wrtu7hWH; arc=fail smtp.client-ip=52.101.229.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CVbYQAk2rXk4f5M1V8frSWOLs9V0RsAZ+wvMUawc74Ev5bKpdxrmytDPkRl1nCfb2N/TLiKU6co74tXscoFcDeIXGjtyH0TCLXTGRi/lP3R3CEel2BXbOuFoHdlrFPDtBp5CPzjEhz2sYotvaLd9yt2WpCMRRS2cf9kui1Fjbxe6XykZUA97LFpYqqnjgOFR7AGy6zQITD545iOP885S6+aBZCqYWl16vBV73kZ/8Jp3clLAQhdC/2y3UnD+v+Gy5WtKAtNVI9rxskcfkYpGifv0JXpG5FKrKG9GQPBae3vQZfNX9kptsFZ14si+9njg4g6qf3ZyyaJR0Qds9Syaeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN44N5sgwYpjX8s09akjVFtKRvtwRd6q7wZ5nyMdeck=;
 b=FzExeB5yCYEsDaGPiD1KvFAzhuOkdleprPklmByCpNAe2tYlu7pIrJJlIN1KiW4DvMcGnNR2LnYnq4oZ9/HVBLukDsKxo1AfFxq4JYVrFVXVUuS43fhMbQ2bfC5/dTCEMEc/NTTZEYFMTV+RaTz/5mZiZO4YPFg2ijWYysDtO5IiQUrgtNUIHl+dGgHYr3rKVRClTzT+UcAyxDzcM05GkbL1Nfetrn7BnhAT9KLTgV5eKP54lSKu/z9yfgIQG92SSH22H8n+BU6yd5kPb/Ibwt5Xh0Yle+eZuAQY9mFxOwtEBE9bvW6UM4Pl4grfQfk2sohpQCbyIpEYkbyPNIVNXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN44N5sgwYpjX8s09akjVFtKRvtwRd6q7wZ5nyMdeck=;
 b=wrtu7hWHJ/90mKiZcVqo0kt0hnpOfpq13J8sqVrDZ1AaH5TMOk1m3Z6rwgEsYOlxdy2iC32wpWJrxJSSWnZIyzYQQA77QbLBxpHoQ0at3cqkcwVYuSw2CkllW/jSrYM/sY1RcTOq4qdOv1BNkBP9eH2YUbQAfbSqnCDp7aOl9J4=
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6374.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 08:09:11 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0181.009; Fri, 10 Jul 2026
 08:09:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Manivannan Sadhasivam <mani@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Serge Semin <fancer.lancer@gmail.com>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc: Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] dmaengine: dw-edma: Terminate STOP requests without callbacks
Date: Fri, 10 Jul 2026 17:08:58 +0900
Message-ID: <20260710080903.2392888-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260710080903.2392888-1-den@valinux.co.jp>
References: <20260710080903.2392888-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0155.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 26c171a2-ac77-4b0e-d63a-08dede5a8637
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10070799003|5023799004|56012099006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HgqpnwzTIo0sBm0J+/oRN47Q2NbAk1dcF8+rw38hCDBb/wf3e6oBKSkIDRidpQ6kzqWFpKTRSZM+Gtp9s23dMOPSwScEOhxqA1gMail0hBUOXn0rQicx3R8/T6vmSYlhpzwQQGS9jWP/5k/rcq54kkDVMPHuk1eZcJCyakM1nDvv6XhKX5MGfxgGHns0WCBm6xfIDXpj+WYM2vQ+A1ko00V++EtZIyY1NbD6RPoYx4g9A+1hYyWuVgYozDnUFKRU66VTqWNJze7l+A3ODi9INlpQImgm9FgO+LDhSojn3XJMPDCSJng602lwgNBN2DrCabsBr+/FAcTrU3D9ax0B+nw/IhQgvDFGXa2v34fFI4jOpawxQDia9rey/+a7xN8kXWOf6B5CwrniklYks4A6/7WCkfGHuwI7x3o24xtzFFqbGplbOr+KaypSYXtqu8/B4foi7r5wR5/P0LUAY0lLzbIUCuKyApfX4TeafDjW7tnTWv7eIYro55TM5XaKhPsOpcKf8nOjqtqt29Msm+rkDKSSecSSx8zHG6WT7cbjRJq7JDAJU+DJsp8fSugkW5fXn5GdYftusBgmlCkV4VEYOY6Gp5aWNovUuY9KYjRO904Niciq1UDRH+8A6OlDx2ZurHO+LV9BYS3rRrg9qrbatV0tgz+sttqdepNJ4un3j+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10070799003)(5023799004)(56012099006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aF54AuJ8oV2H9BybHvGyWOMi2VCZZh+sg3YvL4ZccSM0pggsZ8v0YeXCSm2d?=
 =?us-ascii?Q?af7kOMhId0H0dt8ORk6SMiDDVppQnohJ/sCROkmmOoGZtQBUwU/jZ9x13+rC?=
 =?us-ascii?Q?EuBJ7kIH3iYK/r3/IgKf0re4DyZjFRzp337hV3xmlG0LDNDQnxR5Cnp/LbHs?=
 =?us-ascii?Q?vmEPADgqApRLxBO1KOcPNide+QcNhrLDB9CpeBZZndrDiprftnsJNCQ+gXkq?=
 =?us-ascii?Q?xDhpEDD78enbHPLIbVRgwS1gWEnDYydKH1Z5wIxogkZniZik5Lc1XVec0J2/?=
 =?us-ascii?Q?MTxsCXzeV28SgzP+2BpJJbUMHoHvykzyjY/u8paL+D6em3npAz2sv5fk+S96?=
 =?us-ascii?Q?6t7BC138/l9XVA0Y6vzUJjQebW076CA+IbVqwZ+Pz1FXcEi4iMO6w9L9+8PS?=
 =?us-ascii?Q?YLXBxIiofnRQch56t9wjn001wn6pfvvCluFOOe4h4gjkudepMUqRghGEewPY?=
 =?us-ascii?Q?tr3K28mpuwRYj707aBADowiy61UReXu7NGO4AyJyori3skPpvYfkbQI7JDR5?=
 =?us-ascii?Q?+81lCKepK5w8z+WchmzIivyMOOPf7c5vsaq4o2owWL756aTx++exQD/kyTE8?=
 =?us-ascii?Q?eLjrkAbQNVLU+3IWSQhtOK8RDrPxV07WILEnuwUFVz1Z+Nxo1RZobYErVahL?=
 =?us-ascii?Q?pLLFO8Whr5r/q2/UemV3kOmtVcgKlXUKwcdR6Nwa8fXToeqBkov/sMbP5cR7?=
 =?us-ascii?Q?lLnzYFOePKrp+CSJVSVsmHIh1/3v5AVcVo1oNcConQr4CRGsp7WQ/S9tgro/?=
 =?us-ascii?Q?rmVgEpaetb9NaSLvLAV1HLo6NaVuexMPm4olfsFlDnXhMWh+omKQjJsxSH/z?=
 =?us-ascii?Q?9KEQ3PokSSjo+FmXYKmx90U89Os8VjfW7dNN3cGfRFLuwx7RirNGGVRtPRVU?=
 =?us-ascii?Q?GWTgBrpVomltiWnErdmgyE8u+bHzejBp6Djl9U4ff4wkPe/ieT+J32REp1iE?=
 =?us-ascii?Q?Y8fIvEj1VxmptmBOo9ux1RnpR+dOMTfmaLhBEyZu1xj6Sn4eoznd6qeYKyL9?=
 =?us-ascii?Q?KXhYjKBtd9GQ86HEDmua8qzJA3U7noAgJskp57URAiUlf2uvfrC0Sbya0WAg?=
 =?us-ascii?Q?VqjjiwVOd58qhom2jEUZpbbKTQ8PsxG9jbjAIqbYgsDPITHKTJSK9Jbt+djh?=
 =?us-ascii?Q?xGuCOu1ToHBpAtWSAtLSIxGFO9FtOJsfMOBr4SuEgK9Fx6tDownwAOAMSZ7T?=
 =?us-ascii?Q?M1rw4y/yJJ8VeIBN43MAOxkuOmfytaWElamtOiifpKSXGL65sdFT5fJPzJ/r?=
 =?us-ascii?Q?rVLYvh/aLta89NL6dc14/lwrFM3jJFQXgBq1K51Vt2PkQJk1CQdKiO40yJYq?=
 =?us-ascii?Q?kfmivEjyCOcDhrY29zWrGDRffPOzJ7YRvms3PGiBKjrYf7uZ4edoep0LkCC6?=
 =?us-ascii?Q?Zb1k3+sXHjSbeOsWlu2ZIeIyEUgCYrDj8CDiF4r7dl584YHNHqetyzUZam7W?=
 =?us-ascii?Q?+Y+JUZoFKqpZ4r4GbaEFBPmgqH5L3NnOtcIQ7UYdz6OtxBWY1RmRTD6V5ws1?=
 =?us-ascii?Q?gWmrBDo0hlwrWe/7UEZEr8mRLc34O4IHqeYjfaKcdIicKJmdrRyYkcDcoakp?=
 =?us-ascii?Q?BWZBD9OWfqm4pR3O+h7TLwbwv9nxQni3hioVUND1g1CcM7CW+oO17a27jdqW?=
 =?us-ascii?Q?SNvLiVMXGwX9gNKfhaV5M4j86RwU55ULb7Jpp14IhvppfM9PMobVtti2WvI9?=
 =?us-ascii?Q?q2xGLK3q9yLcNj3nSuQ1BD77GApQMTwWaLnLct5U2Hx7IGknqoMNjfEy7YFv?=
 =?us-ascii?Q?DeSfAVTKZmZHvNSy7zHpRTwelv+n0BBFn1060twiA5AtJgrRXliE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 26c171a2-ac77-4b0e-d63a-08dede5a8637
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 08:09:11.4057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAyU2zV+3jdRGCQwUo0qNbVAoo145s0aSwSO63wtjdED4I2WOMYTje5xbyIgQxsTy1ch6bGoT5nb8Y8p6xoyvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linux.dev,gmail.com,synopsys.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12271-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:cai.huoqing@linux.dev,m:fancer.lancer@gmail.com,m:Gustavo.Pimentel@synopsys.com,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:from_mime,valinux.co.jp:email,valinux.co.jp:mid,valinux.co.jp:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A432738562

The STOP request path handles device_terminate_all(). The DMA Engine
client documentation says in the "Terminate APIs" section of
Documentation/driver-api/dmaengine/client.rst:

"No callback functions will be called for any incomplete transfers."

dw-edma used vchan_cookie_complete() for a stopped descriptor. This
queues the descriptor on the completed list and schedules its callback.
A late callback after dmaengine_terminate_sync() can dereference
callback state, such as a request object, that the client has already
freed.

Move the stopped descriptor to the terminated list. Complete the cookie
before doing so, so cookie polling observes that the transfer is no
longer in flight, but do not schedule the completion callback. Add a
synchronize callback so virt-dma can release terminated descriptors.

Fixes: e63d79d1ffcd ("dmaengine: Add Synopsys eDMA IP core driver")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Split out into this preparation series (was patch 03/17 of
    the dynamic LL appends v1).
  - No changes.

 drivers/dma/dw-edma/dw-edma-core.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 89a4c498a17b..4e0dc52397e2 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -201,6 +201,13 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	return 1;
 }
 
+static void dw_edma_terminate_vdesc(struct virt_dma_desc *vd)
+{
+	list_del(&vd->node);
+	dma_cookie_complete(&vd->tx);
+	vchan_terminate_vdesc(vd);
+}
+
 static void dw_edma_device_caps(struct dma_chan *dchan,
 				struct dma_slave_caps *caps)
 {
@@ -673,8 +680,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 			break;
 
 		case EDMA_REQ_STOP:
-			list_del(&vd->node);
-			vchan_cookie_complete(vd);
+			dw_edma_terminate_vdesc(vd);
 			chan->request = EDMA_REQ_NONE;
 			chan->status = EDMA_ST_IDLE;
 			break;
@@ -856,6 +862,13 @@ static int dw_edma_alloc_chan_resources(struct dma_chan *dchan)
 	return 0;
 }
 
+static void dw_edma_device_synchronize(struct dma_chan *dchan)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+
+	vchan_synchronize(&chan->vc);
+}
+
 static void dw_edma_free_chan_resources(struct dma_chan *dchan)
 {
 	unsigned long timeout = jiffies + msecs_to_jiffies(5000);
@@ -968,6 +981,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_pause = dw_edma_device_pause;
 	dma->device_resume = dw_edma_device_resume;
 	dma->device_terminate_all = dw_edma_device_terminate_all;
+	dma->device_synchronize = dw_edma_device_synchronize;
 	dma->device_issue_pending = dw_edma_device_issue_pending;
 	dma->device_tx_status = dw_edma_device_tx_status;
 	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
-- 
2.51.0


