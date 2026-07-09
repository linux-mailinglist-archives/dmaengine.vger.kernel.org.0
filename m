Return-Path: <dmaengine+bounces-12192-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jLHQEkivT2rsmgIAu9opvQ
	(envelope-from <dmaengine+bounces-12192-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:25:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAB073231A
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:25:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=GD9S0CEc;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12192-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-12192-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57AEC3173A25
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0A3434E32;
	Thu,  9 Jul 2026 13:59:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012048.outbound.protection.outlook.com [52.101.126.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E85430CCA;
	Thu,  9 Jul 2026 13:59:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605576; cv=fail; b=gWnLI0rBGPIyh4nf5lyQL141ODzanyEdbjO0H0cDgflWpbYVz7ExslIM5ngnrVrPxYxIRdBZ58uO33+kPd/tMB25C+GrDxYF2R2rt5/7GTieNZgR4MaDWT8fD/IVZD+dbL4rsc+KaSjL0Gk8vOgfsu/4aaNcyFhfZSCBWbfBlj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605576; c=relaxed/simple;
	bh=dsbwx6B3hWlXfHvoUTfc4Hph9whPUN2nmsu1k1zrEZk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fd+stycPUYntdOzXjauDch68COpIK9sb+i+YxBK9whAWcmfkGugGpVGV3pqQt4g49dkN4OwVIpUYiv/5CUhOZL6xwbrwzdv0m8lifMwtt/1GoHjI1pRa2VgPh20mbufWIA1f2votlN89nWpi27Su2422wvULCQWi++fKLkikW/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=GD9S0CEc; arc=fail smtp.client-ip=52.101.126.48
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOUMndIBue9WIkkNMOLWg44qIoppKS9w54cHnar3MYnT4F/SMKljzwOG+VJBDayMbHV/IYewHBmvtbWB2Hbn3bPt25g7EuoW0xlQKT9mS6JYlIvujKccLR8gX8XlMFc/9i6qk9uMPTneElQsq3lEdJoT0CSzkU2nJQiUJrwCYVwd6KmIZJZgpRcsVkE2N3YbWtvUdIlyyplPTYKmTENHMU1afE73l3rQd267epTU/jrA1xfHiFbdUI/tZh7pGdPU1lKdd4StXF0Mre7U2UY4G9SJhUMjkwQpfnVxPdRAmYGXyWn/kXSrExRpQZaf2HPo6eArtM5u0ssii1TgL0sxCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0IajV9m0RRVTTrS0Xgdfn6mDqRiFpfCUjMl7TQ2boOA=;
 b=NBMzH640bDE+1dRiby+dAUiUWEo07XqOhICsWQKMTClEDZGrVuAMWRyneAZTCYtXEQZQx8t40fHnX7tSPvrg4BKGnTX6D6dawh0bqs+5IbzZHKUQvR0HDGY7hdFeTSFLKKc1/KLjpPEh7YNXUB3EDORrpdDUnGEXToXcZ7CGDVzfAh+B/l+KhbMm0sCmjhOvQOw7ibtSql3uxHXd4DcryG0pnG4UpdMaRlyE8m6D7O1H6x2oOQp+SzpA8jddbxIPFjcYmL/zPtF/owRVY3kPLQSnpMi4UVTuct8SYLJMMg/wOmMDDq8sorAapwPxcg4bUWGOuFerlZjnClaMNj4nbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0IajV9m0RRVTTrS0Xgdfn6mDqRiFpfCUjMl7TQ2boOA=;
 b=GD9S0CEcZNq0M/YLEceMNmKA8TnO+mIzpV0TpDn9N3+AQJxwueXgciqau7llXnR8CM92u/PbY2WUuCtxewNAWYeOoZROrzxbxrvDYS6F3AWusY4BPqZnEeUScnEBzLCvYBeJmND0ZlUFYIlfXfC0vGVD4evefcNT+DvjxKGOE+mcomGKtjAo/ix0yQqzezRYrHwrT6cnpcz92Dlk9cXgHC5kgD1Mm1feQkjeEJ30S695Lz/YtpzdHO0GLbsT+EUgf91nSEF6ww9V5RBxqxSQvf1b/xmMxEx+nnFLlLBjm7lEE/WNWWoiOEzw522ERVzDF6psoAtV95z8IBBq+AumUA==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9093.apcprd06.prod.outlook.com (2603:1096:101:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:32 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:32 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Thomas Andreatta <thomasandreatta2000@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 14/26] dmaengine: sh-shdmac: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:18 +0800
Message-Id: <20260709135846.97972-15-panchuang@vivo.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709135846.97972-1-panchuang@vivo.com>
References: <20260709135846.97972-1-panchuang@vivo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::11) To SEZPR06MB5832.apcprd06.prod.outlook.com
 (2603:1096:101:c8::12)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SETPR06MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: f019b00a-5557-4409-60f3-08deddc24d1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|52116014|38350700014|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	YX3oO/KDmfFUyxZ47EcWHkK1eMRZIKNUY8EslZ1aBww6dVGTLBxwkPIvvWqkbpLZYQyHmjiU8mDTJwWnARx3gl/h5cGiBEIzW4v9KHXaa78N0jjDk88OZqPL8CdS4y4phKvePDqhObec0bUnvzR/3Zm6Zpdr82eHmDv7DpZ0uQHZYqbYh84YFntkJWxYLmCJ+GIrr0dlR1YcZnH7Gj/36v5eFXwax1CK/oYkwqWlwExod7ekSgvC3+qYg4n/z+hKHZvLowoHtmOUK9XDWlsq6BzaP9fsT4LZGRjwmIPq6q5ct4HUNYCrzQgOxNCW6hevxvhWVDJN4OvRf5UBpmH9e26vJ9cFh9KJRarZ82iJs/qb01kjF0+Gb4gccau31KrpGbt6tedsQDXQN5wJFfwg/P09ySTDrVVn6eni+RLWBXzQjtPLiwuX0XGhxz7t/rj/78AyyloQWil+sOPppZhCVvYSJZr/wiV3iRkA3ybcdgACr70PW0LvtbTPeRLBYjirvGnm30ztWqmXpCEf5bmNs5Ps08TkYlR6+gpqB+94GiEkN1MhElLzTQ8cXj7PTHX4IAPnoX2uN0005oTsAilGkOLUViQtnq6occu9m4wVkB0Qdr0T8XXFTSWKF2ZGmlAmR35pw9FM2ZQ5cnhX8fXGQ6GZW9S4KQMmd0GaEQceqJ8kBLm/kgr0vrny/8DlVII0keVw+cfiVRocbmtFDc6xkgASCAm0QIxDCHXIdHgZuuk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(52116014)(38350700014)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qWkDpX862tLSvIDSAoxYgVjWjdpDza9OPjrUipLnLu7qlHHmclJp9Sv0dh9m?=
 =?us-ascii?Q?3Akov7y3Ji1BhF1EysUbjTkx4FmORL8s/jTbuekadVYfDNsWSESwpMYQzX7V?=
 =?us-ascii?Q?vEwSRKRpEUeewrbMUHNbMEbYDS2+/tgCb0Fvb4hYlFFj6vGZ1PbLNWcoBts6?=
 =?us-ascii?Q?vkR5VIHIOVW+Tb4iHgfaDH/anXWi7uFCsIZNhN/Pi8pbVuvIWFXDZau79/DC?=
 =?us-ascii?Q?7mbR6OFZwhb2wn3o7KobyJlurK7lOk65I/yEBXg06ipvgNHG3CQ+tWnGfalK?=
 =?us-ascii?Q?shYx6hT+bNVP6dcIoNb0kRMXoSYOPCu2P3jcs9VVjJba+BkxZw3Dv3NQHzVY?=
 =?us-ascii?Q?dLuQfcYj0DypHf/a/GFywuWhnh0sDNBI3IWokn7OuigVEQtRTe8noN6OcXRq?=
 =?us-ascii?Q?OvdRayaVCYXCy1hmLByn65C495U+IxFtIMbz1om5wGM/yqIN8MX4R1Tppwk2?=
 =?us-ascii?Q?8g7Y1cRy0QOlrNU/GY2DzMCGLExxhQ1QEuM3Xf18hKE1IRvtcAMB0RtBbKT6?=
 =?us-ascii?Q?xDkhUs4WgqrJbOlfzYqyovPaulGHhRRB73mLG92f+OIGLNtJLVDnSibamff6?=
 =?us-ascii?Q?qTnub8FS0Zfys5+ZhkeUZLrDkJ84I+7nnDMsh15Nv+8HkE3iK+ftRD76/Wg2?=
 =?us-ascii?Q?UKnvk1ruPB5iaFZ+EGoz7MLmKgtVLzf40uhqvE/yM65pmG3kphNHLYzx0asv?=
 =?us-ascii?Q?T7GNK2rdqHH0tDGy/RwMNWVlmIjwjdgwRGU7ExCfdpcJbQe9vBqrz1PEEc70?=
 =?us-ascii?Q?lS37ybw0OPIzkToQQ1yQ1N+Okia59ZCrsKsG3DtML6mdOE/6eyfYGcqkP6Ib?=
 =?us-ascii?Q?6iaNrIYUmpV+FBz9NbzNS60FsoQI4G+qKN0C2kAyVVqZWvjEAKpxXLVTEylh?=
 =?us-ascii?Q?FFILkXIYdoeqVt0X1vSsquuxDeKtCCLAVQkaZ38UW4DKnSlpjpiMdnd7/zSJ?=
 =?us-ascii?Q?1hAy0agCZMdn2AJwmpy8+34C/nOS4zBvy8k4ZT4XzWTfr180AMOnsthyr3rW?=
 =?us-ascii?Q?JiQuiv0r7e9JHVDebP9DeEFC4N6N2sck5GDYFMIANRTpNNtGkd6DFC9JrUDW?=
 =?us-ascii?Q?m4qeWcnoYrbhCmAcX70vEQliz8Jzkt6L6zNQWUpLt5IM+GRlmwcn7c6TYslh?=
 =?us-ascii?Q?vucxzknHqC+xnbk3ELmpEsLsAg0f/2nQ9zhhQMTUQy+QfxIceAbfITXmkCU/?=
 =?us-ascii?Q?cQdN29jiKHmpNWf1/Rf2gMr7akiD5/dU7gIcuajqs8f3E4Jwy1DKrK1lowXQ?=
 =?us-ascii?Q?aGUfw/XJg/A+y3/hXyNFaDxveB2owSSKHYJyuYDtTMQgKrhPqCYLSt0wGZNT?=
 =?us-ascii?Q?XmBMQ01DhLzkWamxe1/tTOWSLSfgW0fl7PvDHmEEVQ+OAPqi2UkhZW7ooUv7?=
 =?us-ascii?Q?KBNjROCdRStj1IVOSUajjIXWeYPCo3rRFZO6MjFN3FzZH9hdbS6Xi/ZTpwA/?=
 =?us-ascii?Q?DBAFW34uCmPup3OEY3UG59SnikHoDNEIUzS/9pQ4CjLegtVjKjLap69YjvNw?=
 =?us-ascii?Q?PCwtDlRSphFPYP3Vib7Xyxg60+UFQBZShBUe3gg+QhW8T9jpJSKraice4HYz?=
 =?us-ascii?Q?UiU8hOX0U7mBFtU3J1b66v6vryyNUzbFyZTlhEjz8TdHRi8/IqI5l6P/OSUU?=
 =?us-ascii?Q?32/ObaXxqVAuETlvEARssLJpTY9uunQn7Lox664YAG1I5KFzho942X3sqXYi?=
 =?us-ascii?Q?nw2SBjSsDX4bXF2f1+J6h9A7UBiqnaBhRudnxgBZ3r9W0/L1pBJGzDNvr1sP?=
 =?us-ascii?Q?95uxADPSUw=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f019b00a-5557-4409-60f3-08deddc24d1d
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:32.1874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RqgUArsE8GhAkbr1xW9ny2seYusuB3UxjYYd2muhS56Ao+HBPksyC/BEgB8nOCknNnmiaxnI02dlqwaUzBxqPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12192-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:thomasandreatta2000@gmail.com,m:panchuang@vivo.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,vivo.com,vger.kernel.org];
	DKIM_TRACE(0.00)[vivo.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ABAB073231A

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/sh/shdmac.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 603e15102e45..e0391f72384d 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -800,12 +800,8 @@ static int sh_dmae_probe(struct platform_device *pdev)
 
 		err = devm_request_irq(&pdev->dev, errirq, sh_dmae_err,
 				       irqflags, "DMAC Address Error", shdev);
-		if (err) {
-			dev_err(&pdev->dev,
-				"DMA failed requesting irq #%d, error %d\n",
-				errirq, err);
+		if (err)
 			goto eirq_err;
-		}
 	} else {
 		chanirq_res = errirq_res;
 	}
-- 
2.34.1


