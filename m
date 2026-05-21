Return-Path: <dmaengine+bounces-10597-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I5MEcWmDmr6AwYAu9opvQ
	(envelope-from <dmaengine+bounces-10597-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:31:33 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6F859F6AB
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 08:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 106C9304B7F9
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 06:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084A1392C46;
	Thu, 21 May 2026 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="VIZZHGsS"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020112.outbound.protection.outlook.com [52.101.228.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8D7221F20;
	Thu, 21 May 2026 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779345084; cv=fail; b=hww/EJBRdmcI/mmepSG8UujWX6779tLCFQniMvUlYEX/b/UtMLl+XZmvTfJ9Yz2vJ85rX3Z/A0tVFt6u2e2riIGW91EvrMK40Jrb4vvCvanK5BW/CKE5e1OablO7m+F9WFZP1wH+7Xv6z8ZJ9yxELt6Yn8/h1IeOTVAqgZ5wVrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779345084; c=relaxed/simple;
	bh=vTHijv+fJSrYE/fMkiV31DNWk0idPgD5wXy4v04fzs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Umj87/MusZ9buSIo+i1WKE2dA1NBpq/gnR9h7xUmp7UFqWeqvG0H24E0rJ/ZJtF4vgJgQDL5RzXgTamD+AoGlTmG18q0axFaeSd8MFpgxvzcoUkHqwhXfgvnAONiydQqSwK5uOApmhdntoUAtiOkNeGekDlHof2e3NAtK3N+HBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=VIZZHGsS; arc=fail smtp.client-ip=52.101.228.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BMhbSm2DLmAzg2KhfgDfAvlDfcuUF7mrvcaWIzJg1mUvS73bXoZJozRwK7+wE8UTixMFV9mE17gD+dQNBAn5BIXpXojDDtRExTcT57sS+9Ltah8grUBpeD2MzuIoWBS6AdukBNSLZIEQGZD0QR7PrEWgWw3A48nK85JZ33anCnE0qt6BDHVfygCMM9GLCrsL4sRPy2TAK9nqYgAFrjUEwD3Hjo/mnQ15jG5YwlfGNy46kQZMPCRQ2bfKPuxqVn4PD+tRGHyM+pMEe9A0suo7KlyWRmZdk75WmqeQRKLtx5ImmgadTVwPr6JD9K6140RxsKHepqMvVlXuNmQ+Nrz9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=++jx00ZKIblZ00Hh2P9I2CgzD6Ar5xocwGnmnrfFNBI=;
 b=cskmW1JmwY6jPhsOxu7uEY4Z7J+GT4deUr6aHYyLKRwmq9239tKGvtk7WatNfMM0WfOnU8386IJOj6/88ZJvt1U0Gg87TRR5vfAPaMa/o59xE6ar/RU4YTHf0rNtlYwNFizIXnolNxU9ZVARn9nfdfb/Cn3c9AqGrF4HhOU41OJxUlzMSEuY1gCKNGT83YHeXV25t0WYP0cQfVId/0lfgAMdbU5NThsOu2syNbuWBdX4YmT/PR1sUN5/77qKESB9IN+4XHEsMv3GtoGhzdK5UDxC8FKKIQD//nRErwp7rXGFmzQlerlDdASkCYT4jNGPKOTfZSjZpjBo5BLWbfU6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=++jx00ZKIblZ00Hh2P9I2CgzD6Ar5xocwGnmnrfFNBI=;
 b=VIZZHGsS3K3aFqZmrsf9eQO5DuIhDNgCRaZ0RoV9AVYJ8GoD5Z9rZuhYBb4/xHMmtW08pgKJaLmgOCJeLaAORoPjzY3cYT4tf6OsPPDc2gt/4O/p3tYGuqcYRS/dyJ6QZ345TYpJ46JMNFEFPL2+G2fFjcr8L5Qg4gQ+ybXSfkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7818.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:473::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 06:31:20 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.21.0048.016; Thu, 21 May 2026
 06:31:20 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] dmaengine: Make dma_get_slave_channel() public
Date: Thu, 21 May 2026 15:31:04 +0900
Message-ID: <20260521063115.2842238-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260521063115.2842238-1-den@valinux.co.jp>
References: <20260521063115.2842238-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0075.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7818:EE_
X-MS-Office365-Filtering-Correlation-Id: f4813c9f-5b3e-4dea-0299-08deb7029220
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	1nlrBel4rI00Bieo7qZvXpRXUHvGKS1MjL1m5GECHcudPJmPN7Q5WQiQflPLnmol/om9CSOMQnMkGkxlXahHk13DSzch4kaCoM8VcHD/PTb/gnXeK7b5zxl4bPPLpv3JyWTE6hqn9JkWiIJKS9LkK75rA+9e1E84xMl9otZivdkZSPIuWH7y3sfNOEDInVHQyo8eB1wXKHwqZq1X1zYvFt56qLwXv0SYMN+puh38OCMDaQVcKRBmW7l2Pfr+TaaMDlxNmZpKavUiUpD6GhD3frI0UFZuY1uvIxHYtfjGvUE+n3H66e+Mjyr5aAutdXinBAfZ4MqPjoZ7NJU0FswU8fWpcumx6Y81/a4hO6KNA36k4UhjZuBREtk8sDlTQRUYE7fXwQC3fx5X//QE6KxfF7KzGHE/shJBQv0ORoBsW16MLEN/Ilwe3EZdS9ZY9u75DaRZJEPZAVqmXLp9Z+II31dB5ffQa9G0v7Yf0OfA5y0HpeaFLsVoEVovC3GqMeY8mdXRYXbUjCBELzR0lymCjYjOPxB4Xvxn3IN7c1cKKk6clE3TPp3A13GAyybmQijpbg4j435/VKFyoW9JYTgDpibT04/vhKU4JeNSdb9KOUGln+TpwT2PKvtvRHwmvr+x+ruW3N1zwUL9XjckRUG1w50ojQsyr/UmBMwVRx/HFfKw7Tfrwi7zG4JmCIukcF3v
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u/Mtw+llirpfYQaMXWBOzoOYTv7taGVlJ4V3p+weakB9nk0jpWhFcaRF0t4Z?=
 =?us-ascii?Q?qObiZkiGRs5kQbo0eQ+qWtzDKgYPdSOEnOSem98aYkiWoOQ3ttmzP68+HNuP?=
 =?us-ascii?Q?s4XBxKjExBPGBrbwOv+mMFncshy5iDnHuZI3Q0B4aUn0MyLnZSCtZq0sYt1q?=
 =?us-ascii?Q?uQpDq/vFTtHDok1IwO5GOwbC92+sRaK++os5QtVAYmIElIGR29XCHBAH5Nb/?=
 =?us-ascii?Q?gKiAh84uDhtSyJLq4wSEKTo0DmTMGUOFCioueBHPILJo49CaHe2cneDz12Sc?=
 =?us-ascii?Q?FyIxNIl0JE3TxSGhOCzBhNzWYQgQ3yPfnBSB+t2ZI1vPaAsse88bg93sJCs9?=
 =?us-ascii?Q?FtJbXHms3nyRb3nHzkmddhsxnSxxLSk5EKKBvexFY8DMe1bIIDg3dOzFoG8Y?=
 =?us-ascii?Q?j409z1qRYGBbNQtIktxf6NxJgDVxc3sOBXWAd6mV1aFLby10A3mwU8DvMCOx?=
 =?us-ascii?Q?VrJCTZ0DkpdB4pNL4oRPcGTuDOMoxz1sv/9Xg0Cgiy8wzMevHs+VAXH8KiDm?=
 =?us-ascii?Q?4EKkopEoPfXjKv0+p69ufnC+luMfDVPgLW+RKUCM1eBZNDpeJ/K09GLPE0NQ?=
 =?us-ascii?Q?H2rDsKj3b9WKiX1XCobgK535pED0YAQTJGMnBK0VA+v+hqJbwKUM3KsDWbJi?=
 =?us-ascii?Q?MmWeQWYGQOnH/FaN94QlfzpJ2LKEKDWR1B4Yyhjv7S3kdI9ET4I7E+RbmMfC?=
 =?us-ascii?Q?KeyuE0i8wYNE/4AXQ6bRHG2CKW5kyng/LmLSkqKbXuwn/ya+ksP2S7EXuAoi?=
 =?us-ascii?Q?ZAPM6sz8m8SsuNb/5PE4JXzMeNllHWHdko3HFffEmYaKstpeOPMLjU5hq1KO?=
 =?us-ascii?Q?oN9rHgFZIld0RsQwmqSPwzWBb/k1Bz38/RoKHv4ge0R25dZEpDWZShZ3Btsw?=
 =?us-ascii?Q?suEXF1tIqimlZ56ey53JH9UIEymDpA+vUnyRxND1sTUkf60jFGBRke2wx8tt?=
 =?us-ascii?Q?hx4Ht0IDvwkTDGJtYkyaSGgcOi7HqeYBN0ZBVPDaWO87vAGa15nDtMwDfnsX?=
 =?us-ascii?Q?Im5D7g2TLzbC+MVjfVGk7VJKoFE0lWOH2kXK1VcbV7x2QdsFjQ/deLn9uIvB?=
 =?us-ascii?Q?eO6r2IARawwKyZsgiUbIApzgWXKtfkigOtrxlE/PHImdfW4h2vLFOqdNMJQo?=
 =?us-ascii?Q?dssEQS26MwBb8yMI86IE1MeCM3DxTZqXs8iO8S3FzdJk9tBs58lFTJKSngtS?=
 =?us-ascii?Q?JDifr9YCNPOhLQMRFm/gGwUUMfgGsN0R8F0Y5LzIDHIrCFUqKGMoYzU0TfRT?=
 =?us-ascii?Q?w5mCDnpNUhDCzfoLfeQnP/SYWgJGhuY07di9Uo1k0k+Fqk7VdmIYR3i7j4Pr?=
 =?us-ascii?Q?Z88l5+ME5mCIBXO8Qiw+z8DsLnoO/Ksp5HYvHn1fm+t8+BPkgcNgCvu0S1oo?=
 =?us-ascii?Q?lelbnr8M+HsKvoEU/cVYJEEneZGblovIQXhTyWbZhL6zBtDqhhJuadr5UM7N?=
 =?us-ascii?Q?+GCtJHNZWD1tGFDBwMtTT5VGoNcuEOZ3w/kspN0vYpZSxq/U2R5InwhOWVeu?=
 =?us-ascii?Q?nfB3JDD12PowjMHgCDkw0bArTlWLOP/Tqm+lcc3+cSond/b6pQPeJLjZWs9h?=
 =?us-ascii?Q?6K0s7nOlSAx1Fbp9CPFTZbXu/2HmF1KVjKWkVzs/c10OuCtSOHjvnBmR/ROk?=
 =?us-ascii?Q?KV6NsKGsZEzDujiO33k8cHcYuTj6Iqm3/raLozb19wp0jaUOCrzO740t5txR?=
 =?us-ascii?Q?RyIxNRXJn4n2GQoiYgh/4MRCdN1AX3FDuujqBcO4wkTp36fjkgCqbraE7aeG?=
 =?us-ascii?Q?HJhKJGrfSzBqXBBrvvr8EG7qS4wQEr0oPWkDoYXzb8X23+w1Tbeu?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f4813c9f-5b3e-4dea-0299-08deb7029220
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 06:31:20.3259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MxAUfVcfLrnAf2jsTzeCHYNM8VRkB5yLLxRfyaYh8P+8YIoo1nQHaVn9O+v0crI8pHWqSSJiobn4TDA/oAxQyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7818
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
	TAGGED_FROM(0.00)[bounces-10597-lists,dmaengine=lfdr.de];
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
X-Rspamd-Queue-Id: DE6F859F6AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit c3c431de99c06 ("dmaengine: Move dma_get_{,any_}slave_channel() to
private dmaengine.h") moved dma_get_slave_channel() to the private DMA
engine header because only DMA engine drivers used it at the time.

PCI endpoint DMA needs to reserve an exact channel from outside
drivers/dma. Restore dma_get_slave_channel() to the public header for
that use case while keeping dma_get_any_slave_channel() private.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dmaengine.h   | 1 -
 include/linux/dmaengine.h | 6 ++++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dmaengine.h b/drivers/dma/dmaengine.h
index 53f16d3f0029..bde5217ce2b5 100644
--- a/drivers/dma/dmaengine.h
+++ b/drivers/dma/dmaengine.h
@@ -179,7 +179,6 @@ dmaengine_desc_callback_valid(struct dmaengine_desc_callback *cb)
 	return cb->callback || cb->callback_result;
 }
 
-struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
 
 #ifdef CONFIG_DEBUG_FS
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index b3d251c9734e..59be52e74d5e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -1527,6 +1527,7 @@ struct dma_chan *dma_request_chan(struct device *dev, const char *name);
 struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
 struct dma_chan *devm_dma_request_chan(struct device *dev, const char *name);
 
+struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
 void dma_release_channel(struct dma_chan *chan);
 int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
 #else
@@ -1568,6 +1569,11 @@ static inline struct dma_chan *devm_dma_request_chan(struct device *dev, const c
 	return ERR_PTR(-ENODEV);
 }
 
+static inline struct dma_chan *dma_get_slave_channel(struct dma_chan *chan)
+{
+	return NULL;
+}
+
 static inline void dma_release_channel(struct dma_chan *chan)
 {
 }
-- 
2.51.0


