Return-Path: <dmaengine+bounces-11407-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5UkwEX6hKWrnawMAu9opvQ
	(envelope-from <dmaengine+bounces-11407-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 19:40:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDA066C038
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 19:40:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bp.renesas.com header.s=selector1 header.b=whLOBlwS;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11407-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11407-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=renesas.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 503BB302A1BA
	for <lists+dmaengine@lfdr.de>; Wed, 10 Jun 2026 17:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF0F33F38A;
	Wed, 10 Jun 2026 17:40:11 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010008.outbound.protection.outlook.com [52.101.228.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADB8145355;
	Wed, 10 Jun 2026 17:40:09 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113211; cv=fail; b=iOU8b079uFt2DsAvWmcTiENzVRcj3ocAUG4QdNDtY5hCCK7ifBSR8q9HTN/m9uqYWLEtqYhyP6P91hkOrldGnYUmu9kcZjMOnSQB0NUQ6BeP21yfbRtmvXqodgyDOU2jBkTUPqBWyfXYvAE+vowlz+WZq1Jt9SYhfR092XGM/7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113211; c=relaxed/simple;
	bh=KyfnT0h89CRRNGM6Zr1HCgdB2VhuPZy0VSM2O+D7tpM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pVl6sHS4o2EKD1mvpgZECAz/qGu+KIsGxZrTaCgpxSHw14FsVriLX376coTDoUGCcKgNvIZmFeK/f6bIVGJJO8mMlHjHLV+ZPm1uSQI2PYEr0MtVop82hNHAK8swyGbv4dFZE0tdiopxkvALi0PVULt+/j3KwwL38bMoGJaNaas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=whLOBlwS; arc=fail smtp.client-ip=52.101.228.8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RtKwePiylOsKGSmQkloPCzTeFwHrzQf61cr1pEfH9XXCUKuscSjQF6a2A7Z4kLpY+5puJrxk9iHpq6Dos2s7yJCWSrSzdWwr+iIgiyt6Y1pzCc6DmKLa++BsbUJBhMgW/FeZ1eoVyhBU0k/1qQ6WILsxZavugCQzaXNH2pBfcASQaivD5enPFi+MWcyAujjWomw2406Wm+1c3yCT5AXtA4+Us9nfn6tni/3QStbDCJyjE9gXFFyDzRFRqfN42GVIEtBG79yzndM9zL+XASxnBvWrtkWKRVoBdSlUW5OoqBwByF4DF2SbXLWwF6sxOrAXveIjNvsRlGCmPPZk+vhDTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98CM61Q/TgRi6Z4vkxD2TWqKCltIZx8zrksfAbpJ1E0=;
 b=qKT5A8QSOcayPRhOMfyHmz5RsUZ1vw5JqYpUFNc/wqLKm6OQwPQJvbAUcVf2WLVCSxAz4YNx5yS4dga2P8Zgkz/RYzW+We2Uppl3FFzGUfOwF8YYPUfaHjKCBd10+b9ZHNvhJJRf/AyXqtyO/4Fa/o7VYUJC4vd6Sr3QocB2pAnN67wD3XigqfynGeaZHdM/YOejA0sj50d/j/1qn45vduz+BRHUfQ6XKy5D6ZOcV0S7B4ASBuaq/bTMkwFqwNcgpsR6lkZ4+NedLJOHua2n+gZjTmcb4rT/N2A9xDCDhJVYhGaNWm4SxY8faLESoFJwfdWfAHYx0w/PTs+g6bcN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98CM61Q/TgRi6Z4vkxD2TWqKCltIZx8zrksfAbpJ1E0=;
 b=whLOBlwSj6iJNoR9KseeUadxsfCJpXfemxN2Vr30kQcV6BPGVy1W141XP/KN8Sz1dJSdztbtPZg5Z38jSFrkuvcmtgmXw3H4LKkgnO6ew8JGiwTL5/yp79xBruQlgkmCqfhHzZ0y0Ox68bXVlhDYcyE6S0s/B2/OtzAr01vJvOA=
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com (2603:1096:405:35b::6)
 by OS9PR01MB12340.jpnprd01.prod.outlook.com (2603:1096:604:2e5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 17:40:07 +0000
Received: from TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3]) by TY6PR01MB17377.jpnprd01.prod.outlook.com
 ([fe80::f373:26d6:86c4:6aa3%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 17:40:07 +0000
From: John Madieu <john.madieu.xa@bp.renesas.com>
To: vkoul@kernel.org
Cc: Frank.Li@kernel.org,
	claudiu.beznea.uj@bp.renesas.com,
	geert+renesas@glider.be,
	biju.das.jz@bp.renesas.com,
	john.madieu.xa@bp.renesas.com,
	cosmin-gabriel.tanislav.xa@renesas.com,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	john.madieu@gmail.com
Subject: [PATCH] dmaengine: sh: rz-dmac: Set DMA_PRIVATE to avoid channel stealing by async_tx
Date: Wed, 10 Jun 2026 17:39:38 +0000
Message-Id: <20260610173938.2239053-1-john.madieu.xa@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P195CA0014.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:102:b6::19) To TY6PR01MB17377.jpnprd01.prod.outlook.com
 (2603:1096:405:35b::6)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY6PR01MB17377:EE_|OS9PR01MB12340:EE_
X-MS-Office365-Filtering-Correlation-Id: eddf14f4-3674-4f69-74f8-08dec7174fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|23010399003|38350700014|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	vvH+EyXN4W7O7U6/Tt4Ba0M2dqI4Kjz2RYzwTQlCPCcJ59DMfRs7EpNayL4/W5k4wHIi6j7hgJbrxK2veyuZRJ4CB3fmzE7FFR0u7Uy3G0B7bjwTgCrlUE/J5T2xRp9ZHaEjdVtesvH8RfVtcw0koVzN2t8eFi7fZqIlNumbCZ9U2ONZlqv7acYDMRSWU4HBGrFPvu8jQiJGUEGHr2+Y+eOhbIrEsgwn+th5ga2Na0U+5ehkItkfgE8D7J6Bj0vvFCzWiE0oHrw5RS/RLyKQVCszZZtRUR1bwrVQ2o/PA+/4r+ZlgSm37szJqDF0zXu4vSVrBQPHhgmQbF5mW+Tuifi1dumR97+d98Hn1ggxtyTpKWd0OQHAcTPHnMoVo4iRjsH8Ml2jjFinawLKls8P++vLGHfgxkxPYMOPRwEDomQSXx5lc0PcsjtkzszlaQyf/1M7xk9+VJyi1SS+i16dHUOw5EbwmQ5Seadf1qhTc+Ux/wcEDz2tjgAHA6UfJieWR2G1vgsWWmd2024Dxo8762bO2vvXvWn1OGz0uoa/g5xe65+dKeoRAST6+rGiCx9rThU4PB1bbKEkR2aFlgSLaLdLJzc6FnJLcDBbdNZ30gRSj6opAD1gc5u5ha0pp9I4UP0yzWc4mSn3AHeC6olW5saEodiPxPQ1yiFN9nXURb8isoTpB6l3RejuEO6aKGFTjKlhoPwiRXENhdWBLQ/gR95wwN8t965wQ0eaajVAUmDiH50jTTwfSM4yxBTk0JxV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY6PR01MB17377.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(23010399003)(38350700014)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pwUKlVRIGAphKUVWO1rEC3J0X7cfTB/HRAfa29PkDvR5geccoA9wSRM0d+/j?=
 =?us-ascii?Q?FL3GJYBk8U76UmPfa4EFGkKDyXqu63dI3ZJENUIk0KDHEA1Ne+UEYDlCDCre?=
 =?us-ascii?Q?2cqfPIFu6O4pOhdVTm0uVaUfTR88M44NpI4FYbzac3Klpw1v1sT5dwm6yXLz?=
 =?us-ascii?Q?IpAzPKPh5MtU4pO64kGPWokibt6SgzVehna85P/BtJJ1k9xTsZBKelvc2Zhk?=
 =?us-ascii?Q?p8XY0MepeYCOPwMGq9NnshfQEidLeJHKXjJKyWIA5AglZRVbSqOjeTNFTFrR?=
 =?us-ascii?Q?sg2HaVU9bYEcJyC6+dC9rpiYTBnxIQlWRuB+iVWW2TJ9UFRW3kTlirKQ/SXL?=
 =?us-ascii?Q?Z0+WC9by/dztIaDsXtbf1b875Dm3CpAK7g/oJQaIgpgkiTD3dUcyueyAPMgl?=
 =?us-ascii?Q?dURL1opXQcfStShIcqXAgq6rC118P3s/vB2+Y189HW/CbP5Ox1tUf1IC+0oq?=
 =?us-ascii?Q?D5NgdoCUgNfoXd3P9ViBt9ZoYbMiI2u8Yn5wndVzj/DAPCgmGFXEY8QiNk9g?=
 =?us-ascii?Q?bBWPHsYYyFg9XCnpS4u04G0ogfbV/mY+e5+jQv3cWsrFLyDaLGNWr8Pmdlcl?=
 =?us-ascii?Q?OCJl6/qtYedI01v2aQCMwN8EAj9Pmb2kRetxmc8SzJvgEbLQz1HpCDVvbjwl?=
 =?us-ascii?Q?uyiAKwOytdDn4LXyatT1pMVh4sUnO26ZKLKAdW++5x30fvu6lHt2E7GL48dB?=
 =?us-ascii?Q?i13RhGryQpCvqoprIh+KF7MYMbfVy40Km2IihJrDQiq+68yDN1Ci5nheuPPm?=
 =?us-ascii?Q?a7OccaCq1FviBXkW9M/+Ld/sYqcddm2OQ/jV3l+z2kZu86OZDKYh05jqh4qe?=
 =?us-ascii?Q?8kwOjo6MsjcUF0NeLd+ne+GfvWJ/w5p/OmWy5tX0mEV6WQ3idQZBoMnNEOzJ?=
 =?us-ascii?Q?IGbw0LUYu6xLVihDZSNTLYyyYtWl+w1iixByIYjgaIDtEn436RBL+vlNCBkM?=
 =?us-ascii?Q?eGWY107pynjUJ8LmrYi4uaS7Ui7jQAfqsGrMMn5AegSjPwvh8SUncBnDwOaO?=
 =?us-ascii?Q?Sw4UdE/H7CmgdnSP6JbeBZU55b/9Td2C9ozFqxYWdkqDpHwypLeZGnoC/9kn?=
 =?us-ascii?Q?8OVsiyYEaOOTLUWtMfGVVmcIEwsUjrRw494moZEilnhiWMFir+pHTgPe1LNf?=
 =?us-ascii?Q?IN4OeQWOf0AMpA88V4kUMbuiSv/k12YMH7JJMDLPE2TdItWzmdDPFMoebXNi?=
 =?us-ascii?Q?eiXeCjr0Eh+U2FhmslBtDSQNwoXJwvVr2RfZqiVEdF+dgpLpA3fOiXULVpdw?=
 =?us-ascii?Q?aDu1dekcEozCsI9wD7/ZiSXa+7LENC2wc0oYCxvSEO7JeGwATSLg9uNB4XSB?=
 =?us-ascii?Q?dcrakKuN7VrGgzz1JcIp0ujxbvDGYNF8t8ifYuSttVkpH2WIzrRtsZuIORSE?=
 =?us-ascii?Q?ibBvmDyK0r5/10hqhtKBpzGcDF5ZccZM7D78wzHAp1KfvN7y34Gh/qP8KBWJ?=
 =?us-ascii?Q?LuFHl5J7vB2FG9jt+Jvce/UyksvSU7Fo1JMhpcnVS9JsW7UCBHWc6AH8edgW?=
 =?us-ascii?Q?PtkZWT/B+TghP239+RuOdAnefKKjVwve+ftVWZS7ue0MbxxwrD9sIpvBUOi4?=
 =?us-ascii?Q?+nZwWc1lzcXYZ+DIfsT018GIcDafObPPEta7tZ1K0grlr6dg22A9y+CUC2aB?=
 =?us-ascii?Q?kiFAEHVCkdGYkGxzdOoAfLwOVkeFCSNz938FkKwa8FhlyQt9y2gR5eU/V2ft?=
 =?us-ascii?Q?eiDAKGD7XU4h5FXYkA2yT5mNX4lGkX+q/b5ZZt/OtCWOZq1Nk/SBkfvM8wQ9?=
 =?us-ascii?Q?J3q/c2tnhW89Syb6LV6jFIRGGcVPDxA=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eddf14f4-3674-4f69-74f8-08dec7174fea
X-MS-Exchange-CrossTenant-AuthSource: TY6PR01MB17377.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 17:40:07.5463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IjU5XVkoT1zLcLC0t89zvlPGdzcTto72eSlXGzwwXB3yPqngkh/T62VnGU4viy6q3WaiPgkr+IMxadDdrxsaOLAQi7YywoA+z5ijh7trDdY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB12340
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,bp.renesas.com,glider.be,renesas.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:geert+renesas@glider.be,m:biju.das.jz@bp.renesas.com,m:john.madieu.xa@bp.renesas.com,m:cosmin-gabriel.tanislav.xa@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:john.madieu@gmail.com,m:geert@glider.be,m:johnmadieu@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11407-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[john.madieu.xa@bp.renesas.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,renesas.com:email,bp.renesas.com:dkim,bp.renesas.com:mid,bp.renesas.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DDA066C038

When CONFIG_ASYNC_TX_DMA is enabled, the async_tx framework calls
dmaengine_get() at boot, which walks dma_channel_rebalance() ->
min_chan() to populate its per-CPU channel table with channels usable
for memory offload operations. These public pool paths only skip
devices that have DMA_PRIVATE set in their capability mask.

The rz-dmac driver advertises DMA_MEMCPY but does not set DMA_PRIVATE,
so async_tx claims its channels at boot. When a peripheral driver later
requests its dedicated channel through the DT-based path
(dma_request_chan()), the channel has already been taken and the
request fails. This is observed with the sound driver on the RZ/G3E
SMARC EVK, where audio DMA channel allocation fails, but any rz-dmac
consumer can be affected.

Set DMA_PRIVATE in the capability mask to keep rz-dmac channels out of
the public pool. Legitimate consumer paths are unaffected: the DT path
(of_dma_request_slave_channel() -> dma_get_slave_channel()) does not
reject DMA_PRIVATE devices (it sets the flag and increments privatecnt
itself), and the filter-based path (dma_request_channel() ->
private_candidate()), used for instance by dmatest, does not filter
them out either.

Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
---
 drivers/dma/sh/rz-dmac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dma/sh/rz-dmac.c b/drivers/dma/sh/rz-dmac.c
index ca76f1bb45c4..4acf6463a5f6 100644
--- a/drivers/dma/sh/rz-dmac.c
+++ b/drivers/dma/sh/rz-dmac.c
@@ -1488,6 +1488,7 @@ static int rz_dmac_probe(struct platform_device *pdev)
 	dma_cap_set(DMA_SLAVE, engine->cap_mask);
 	dma_cap_set(DMA_MEMCPY, engine->cap_mask);
 	dma_cap_set(DMA_CYCLIC, engine->cap_mask);
+	dma_cap_set(DMA_PRIVATE, engine->cap_mask);
 	engine->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	engine->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
 	rz_dmac_writel(dmac, DCTRL_DEFAULT, CHANNEL_0_7_COMMON_BASE + DCTRL);
-- 
2.25.1


