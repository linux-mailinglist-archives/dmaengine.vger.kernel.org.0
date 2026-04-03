Return-Path: <dmaengine+bounces-9877-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA8HMAx8z2kKwwYAu9opvQ
	(envelope-from <dmaengine+bounces-9877-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 03 Apr 2026 10:36:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF0392255
	for <lists+dmaengine@lfdr.de>; Fri, 03 Apr 2026 10:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0FE8C3021980
	for <lists+dmaengine@lfdr.de>; Fri,  3 Apr 2026 08:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487F837B416;
	Fri,  3 Apr 2026 08:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fd0KOtGG"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012071.outbound.protection.outlook.com [52.101.66.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E218319D07E;
	Fri,  3 Apr 2026 08:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775205286; cv=fail; b=OIOG1WG3Ty++Cqyi6I+hbp8Px/ZzphH2AkdnCdMTmElcXeCL4hFXmiJlFcF5L0Znckt0I5B63Lk1uuMxSqrvfypUvOUoCsxD9TIFj30Qocu6y3TzRroj2HEJFCMLYX3/y68JUtn/QfDWZNg+1aAiNkqIQjR4ah4SFbh9xK1WKeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775205286; c=relaxed/simple;
	bh=BnABhRC84HeKNBcvKTFMj926Xf4g56ZcY3WQ/qHfhXI=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tJk/vY6Dvlxh987V1BtU+Rjvn/EBIcfQfxEVJGqf1sB/FlQX/pKS+KP4HDz9myNw3tRogIwK+q0TQhdbv4xJ2jHW/rKFsbNvc9uMlrhAJxCd4sKolYfs7cYxWzMtP3sLygimSCDY5A+29lDrhjqeadehulxEmK/S4hiee7cjVls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fd0KOtGG; arc=fail smtp.client-ip=52.101.66.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnk+A6n9DE15YwJSAZ5cvo25c3xqFC277ofzDLyoyY8qiKby6D4XuKMQNc/cF7BFJLMKzfDFespeW+69jZWlQrmBh+sEzfHQCOCtdYH87GKxf7+Vkdv4xH76urZ/E2xH8eMdtnAQWZ7aFx8nGHi8DhyF/gDkB9xJ4jPpArXHszTymmHlmlCPZyODMHPde9giwxpDXMHKL+HP7UWTV9vgvRw0137UM2P7sqFQiWZQwxr+70T/Qvxc53eiYbww/E4XV9HdzNmnRaAV0Y1NUyf/EOOD5B+NwqvxN9uQ31aVEgLrkg45ZrGI/T0olD8siGYyIowk7fMyOfOp694lfZjbCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EDhQ3rrhU918zgSlkj5HKTpmjN5n1mYpVd3OA9YGh0=;
 b=puZMLUiDYXSozXbFJZASyp0LFounFjRV5sfzIcs0aL/pFFXK/Cpvy5LK+a6s+9Pa0Wqxu/I0bCxkJVISTHzGJhlpJLHo2udQtvaxPo6M3Plevk5rv/Ek/aqHEOHQMJxbpRXtH+cE8s5JhtIehSemGuP4U2zbzi8QN99kPZ2dpuh/j2sk+SIlFvma+QCVtd+w4/Q7r1WnUtAVOqw7c2I3QwmDdXMnIdLlxZNKwmH8RvUrYIg3n2SXYVKBXhiN/r+y7fVuQxolw5G8qZLOo/ODe2CFMkDEdWId28AfAIDG0Zgd9jHoEOV2MuViATWZ4OIn59sOkPF89GwJmLUOhxihDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EDhQ3rrhU918zgSlkj5HKTpmjN5n1mYpVd3OA9YGh0=;
 b=fd0KOtGGYwEvloqKGiMyb8nVqR7rW6t22Yztub70NxTaTH0Ogxq/oitjYTHaVNe+ma6TWasfVQ79yUvuwV/0AG8T7t9NUW/qzH9teF9m+BcaZP5VTfJjU35ip+/C0yJDX370L5N83/a+pjOd/1d3XYo3c2rLsODCf3P19KlYhmtp0ML+QM/FTBR3gof97Fr+FzhHl3dU+R9zZQ+6kGCBLM+kqs6rhoO0ofgZY5r1sT2CS2bXPWzg6J9z8veDGIzrn2nqacUUwdQ/KSip2snyEnPYjTyYL54iSgctHMRHKeo8lGW3/yKEqPiSpoJezl/kNKuXLe/Y7YzaH0ru6SXMeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by GVXPR04MB10383.eurprd04.prod.outlook.com (2603:10a6:150:1df::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 3 Apr
 2026 08:34:41 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Fri, 3 Apr 2026
 08:34:41 +0000
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: vkoul@kernel.org,
	Frank.Li@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	dmaengine@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dmaengine: imx-sdma: Refine spba bus searching in probe
Date: Fri,  3 Apr 2026 16:33:13 +0800
Message-Id: <20260403083313.1172292-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0121.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a7::10) To AM0PR04MB7044.eurprd04.prod.outlook.com
 (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|GVXPR04MB10383:EE_
X-MS-Office365-Filtering-Correlation-Id: 52aa927a-fb85-4d60-1450-08de915bd9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|52116014|19092799006|38350700014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5t0gV56SZ8r4Wo/zMCobCBUfGfP+GHrf0sJKuUv90fJ+7fHM9GEhM7qwD2LtK3x3X0BNrZ/yJqaRVDICitebfi9v5RWY6MRMrXvtR26iPvjOjGIaXSebL8RE/48UZsUA9BPKxeHfcta75QbwrDHJbQ66Fe7UQJlLfCWdH64ERuE9QTNjAQ5/8vw+6S+cdEF2HviFEZupRjjoJ98WJQ1Mk5wr3eh7eguTGfBoXkgo/grtcW7Q7p6zk+oTQgpkzBBfVbetm/svUPlTXn/bKTIQ4RknyWolfKXHSAvJaMR5TXCFCnn/x4mZVMWnEc6eFJN7o2ozG6xJIE2lYOK5k8LaNcmivCZt41He8R1fY2e6PopREh+IRCsehOWrifsGDoSL81vYVxMmKXBKGRHsVBPn20/ms/RSy/p/8/K99wDWX4MOwncjdS80LvxNK7JVeZfxmD8lB7NjKPjkZ3S8jMt6/g5HLF+RAsCyfRnk2/Mup2abFOT/wEvxGo3NicGldLcN++54ab15NAeO6QmrDqQlk5tL8v1BsCc7ffzjuBHry81cAZyXdfYhJhxJPfj2C61UN10NGCaUe4e2e15+TdcqEb28o4BWCGNP/Ggtxdx6w5qCFGY4Kw8DDEntIxiQnpupBlmRPRGaCr37DCWkt7ClfqNzwCZzDh4X7mX74K0fDi6yxKrxme7hHh5JIiLnZLu0igveA1dOVLrommKPTgq7QU0jinLZSmiT4CIOWgPxz8YeU6NNWHjU2hFpCiAfFGXhL9WOFRGTIqHUzVHIjmDexN+OIMK3qwaDZeugkMMQEk4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(52116014)(19092799006)(38350700014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f8Owl3DNs+fKvhP3l4qWZOYDlgZovLUcMyf1i4/zb7vFAtmYTGqmSUj6jZEk?=
 =?us-ascii?Q?zmUkcLp20pVBT5Rp37mZuVVNoaCmhgbKzQ0SL7Bb8Auw/nHZrgQf0zq1iIrY?=
 =?us-ascii?Q?na9mQZb3g8OBJGPW8wsJiaIfFAHph+NSpkjNUzciNt1s+8oJpVk1yqop0R4C?=
 =?us-ascii?Q?bsXEYBvDDnzfb2yt/f8oUipRNHy6cO+GFZcDvAz39/Z37JeX/YpP+5uRJfMp?=
 =?us-ascii?Q?5xqJQU0+TCm+YOvc6Z/fZCMLX5+l5AMIYolzW2UeS05pK3lmzas7gxhP/Cyf?=
 =?us-ascii?Q?3cI4HBIN2zjx9ksZLOAhbNyk+DKPW8DWUSzHUj9Hl4Uqg6ZW8ThZJaaKIN70?=
 =?us-ascii?Q?e4hFe2z5VAR3tk1CdiA/YX5QxPL3U2qP6QyD5rwf6ZOEn+RkuqKtVbgTaJMn?=
 =?us-ascii?Q?YhU8u8q/PeOhQhx1+3IVCR3QU+WUAWIHkkIjieuHp8HJCKdk8sAXzrL5xjn8?=
 =?us-ascii?Q?l4RXiVB4rbRwHUfOICo6GuZjorltUBIY4De6Bqv3AId7YTJHkwtYHDaESJ0T?=
 =?us-ascii?Q?eLMhasn1ndfOjOfYfeOoLb8TTvnEHRWEQAOkwHHHBOj8ZZQvIAbZIfC+maMw?=
 =?us-ascii?Q?P7u3WhHi+zS5rEHC2hDwTK/w/sQOdUsvOaiDgZ7ahurQhms/oF0YTkCEDzUX?=
 =?us-ascii?Q?bMU1Zq/oBFuB7f0aTiXU/O88FgLQdjZILiY7W4h6z/W+sHqLOWcoDANa6V0p?=
 =?us-ascii?Q?tr448rn4otut11M1EaeggL83QdeMjj0UQEVTcv67+fy6N2EJ7u9HpfNuX6Li?=
 =?us-ascii?Q?DejwLe6cJPjrsaqRSzQZVb+cIAslJcb4Ms7/+zIL+hL1qJzK5aZ0eAwDO0yg?=
 =?us-ascii?Q?m/PnBGzIdy8M9iaL56oXy1W8J3dpnkOzVVYzRG5jUX9mpjKsLxPiKy7JqBu1?=
 =?us-ascii?Q?yK/6YJGROQP7eSGy+dKNoKTGtWwDIOlS6ylGHSlMiY74xKgsqlRFgzT2p8Ip?=
 =?us-ascii?Q?53CZLJ0VD4ho0t5UmqpueB6tZwYzSlLK8LkCQvR6nbtj4hygvJkfUq/+PzgM?=
 =?us-ascii?Q?h9D0D0+Gye/TkdcVuKGLYRMi1SXv84mSW97QAk+KB2GvkvgRQNEkVJsVZFDn?=
 =?us-ascii?Q?wNzV3Lp4klgp3CeEVhxmIP38PkMUyCS+KQppBFhmkL7MuQrdSmpdm5Go8KFg?=
 =?us-ascii?Q?xVeKK3iS0OLQ+HP1SeTp2iR8WfOR4G1si2xqsmmsGTGCzlQyNX+i8Ejx7j6E?=
 =?us-ascii?Q?MgvrEF/IKd7B2pOgsGoU4tJ5QRxwJnNdfJnYeZzuuOzZOdrvIc3Uur3cbCep?=
 =?us-ascii?Q?6glolkq4FH/hmW7dqe1+pdCS5GX5fA+bgGjL5bAhQVLRGNxR1RfyHQZiXyvY?=
 =?us-ascii?Q?None5MzBr/SSx78vEO54Ng8c5saUcu+r9q/pOKmX7a77ycbwwBjWUC83I6UW?=
 =?us-ascii?Q?RTpcRTGQ9q0goOZqNY1s18aCHoGCWq/o0T3wZPPpdDxGOxLeKInnIMYpSzH/?=
 =?us-ascii?Q?GyNzeJuBPXV5LFnDlQqK9XM95T2lzHTmexFDTaq/1uimcsO2aVVvZw/dRCYq?=
 =?us-ascii?Q?0iCWKqFzxNsM/UvYpH9EYtOBtReWIqfrijFsQV37BeBDZYC2IEN5twxS9eny?=
 =?us-ascii?Q?hZehgWY22mhJwuVbnN/ThVoAMrSJYBat12QezCcID9RdvoQlmnQB9MNAd962?=
 =?us-ascii?Q?9W15HRr7hpVOcD+Et9z8bA2vLEu/aq82xOEpmEwFscEp2CYpaSHqHwtWi7+u?=
 =?us-ascii?Q?S42/1PHJAN0SYzKv9rdRHrCAmfjsj7R7inAumf1JFiQLfsfHJZMXgcrmbYLR?=
 =?us-ascii?Q?lXVCgLqkaA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52aa927a-fb85-4d60-1450-08de915bd9e8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2026 08:34:41.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zerV8QkbAaf4iDMIUyeljX4JsROIhyXF7ku+10NQV2XoiCVp4sHQSj4o5eKsZKCkrWKvipf6cY4vbxSToPh72w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10383
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9877-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shengjiu.wang@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3EBF0392255
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There are multi spba-busses for i.MX8M* platforms, if only search for
the first spba-bus in DT, the found spba-bus may not the real bus of
audio devices, which cause issue for sdma p2p case, as the sdma p2p
script presently does not deal with the transactions involving two devices
connected to the AIPS bus.

Search the SDMA parent node first, which should be the AIPS bus, then
search the child node whose compatible string is spba-bus under that AIPS
bus for the above multi spba-busses case.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 drivers/dma/imx-sdma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3d527883776b..be2fb87b7a89 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2364,13 +2364,16 @@ static int sdma_probe(struct platform_device *pdev)
 			return dev_err_probe(&pdev->dev, ret,
 					     "failed to register controller\n");
 
-		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
+		struct device_node *sdma_parent_np = of_get_parent(np);
+
+		spba_bus = of_get_compatible_child(sdma_parent_np, "fsl,spba-bus");
 		ret = of_address_to_resource(spba_bus, 0, &spba_res);
 		if (!ret) {
 			sdma->spba_start_addr = spba_res.start;
 			sdma->spba_end_addr = spba_res.end;
 		}
 		of_node_put(spba_bus);
+		of_node_put(sdma_parent_np);
 	}
 
 	/*
-- 
2.34.1


