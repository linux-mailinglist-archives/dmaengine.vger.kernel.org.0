Return-Path: <dmaengine+bounces-11761-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 60FsA0dyO2rxXwgAu9opvQ
	(envelope-from <dmaengine+bounces-11761-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 07:59:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F2466BBA65
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 07:59:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=altera.com header.s=selector2 header.b=IdcnQK5U;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11761-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11761-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=altera.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB6FB30C588A
	for <lists+dmaengine@lfdr.de>; Wed, 24 Jun 2026 05:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B093290D1;
	Wed, 24 Jun 2026 05:54:58 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010033.outbound.protection.outlook.com [52.101.56.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F9032BF4B;
	Wed, 24 Jun 2026 05:54:56 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782280498; cv=fail; b=IM/tB+7tAHgGQ464VyrO7NK9pZa8QChEIFSDpX+/QvCINyPMmvqO7fBcpGnM3W9etYLkmdUoAM1uajwCTOmEQSzq3d6asR0vjBNS4RkLi2BTVOPnpgxtNKQFg+5rQ45yrbLi1QkMfnOj2ZsGAuogsgr9FT2hPqZUDq+y6kfofkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782280498; c=relaxed/simple;
	bh=YM5ry/fr/I29d83moAqXAW1LpjDNdl1zmrzXnvFyPao=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pjRL8wKW8KclWWwo2g/vhYzGAIEBtub6K1AucvCSnr2JdDV375DIvrJ7TAbI8+pi7F+mwYUQPFiZFbcopXo0e/7LKmi73EQWor+xrUmeOKk6qrtEpPE9ONKg/wuQdIJD5JYDsBaPwaUCjiCtuC9RIeBzogn3pEbBUuD6+PWhDNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=altera.com; spf=pass smtp.mailfrom=altera.com; dkim=pass (2048-bit key) header.d=altera.com header.i=@altera.com header.b=IdcnQK5U; arc=fail smtp.client-ip=52.101.56.33
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ywdAHOkjzJ6//poHD3IRek6JKYwvGy/JS55f7WerpBtELoUeeukTo9ywuid/IgXmmxrQNG/E7epDl2JmiMxFDMBWG2P7Kb+k0M3jWD7vGO02JGfYZyaJ967r4gtpe97y+mhKuGdHLnTwfrL76TrDdY0ieNZJHmOfx1UT8hxdylm5SP57ngHAty5gVQChJ5Vea3VGz9tVWL89IUfiNZjb3RHnBll72lnyDR07o1jJREvUWRAQHFVv6yuB3GzgxIXf4cp7JAQ/F4zKwUu0XFyQ787wArhyUzYCLQ40kGtnFzutGjBY6SkX6nqVU6UmqFyNlofbcDqR4sEmH1390Q75Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zNc9Gc9V/cQpX44A/Selq53F+CJ+Hdgm0MOWHSQJVE=;
 b=PhRSsbU3LDS258NyEKNGpAZAQxtx+Wkfn1QACqyUG0vKW3QVneJSELLMedYyqC1K8Hs9BC7LFqDUTW1fmgskmcuYN9xxsAHog1dACNHEr61RiOAGBxBbpqrWxT3Hhdf7y/P0LXlrBcpdighdwNQlEXLJISexqTO6Gi6ETQoiHdqMW57yOUUwSDpVXTWfmFkEBjOMHjyDsIsCX7FQ4Y2yBu4YXVAILaQzpcgD6K8eEMss1zfs7aWE1oXT38o7LlNRvwytpbTWZmZh0j3D8FSelzuS77rX2PDl55ulNdd6UUWtkGjLCWkxyLcnq9hsMf2qp/3Uw8hcFYFv1KTvmHbppg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zNc9Gc9V/cQpX44A/Selq53F+CJ+Hdgm0MOWHSQJVE=;
 b=IdcnQK5UeR3Bs0STh/B76QzlQ99UtyQ19qUvcQ+AsVSMRoHqMJabwfP8/ZJux/uMd/AbmjFboW0Q5BLwpaVJuG/RUXpIrTGOpYXqg8+UP4ZWf5zs+p8Lv3KjZvSG/njIbzIY9lCUZCUe/IGWkKu8Sxr5lMBZ5sxy6RTo1P3mF3q2vr5I64yVNDQJPtWDX2TYnSyDu9ubwPN8Gvz0aON26raDHU3oMet/IC20SHHdN0QkOkQcE1cJOVzPf4Koc+jwlY8w9OrpewXgWjl1172i78lvmspnCP276oNR/ivySBu4iPkVQCh6BNuLylEReX9EZFp0X4VVsGlxMtLfHuwHmw==
Received: from PH0PR03MB6235.namprd03.prod.outlook.com (2603:10b6:510:ed::16)
 by BN9PR03MB6153.namprd03.prod.outlook.com (2603:10b6:408:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 05:54:50 +0000
Received: from PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::c062:a298:c61e:5820]) by PH0PR03MB6235.namprd03.prod.outlook.com
 ([fe80::c062:a298:c61e:5820%4]) with mapi id 15.21.0139.018; Wed, 24 Jun 2026
 05:54:50 +0000
From: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
To: Olivier Dautricourt <olivierdautricourt@gmail.com>,
	Stefan Roese <sr@denx.de>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
Subject: [PATCH] MAINTAINERS: altera-msgdma: replace maintainer
Date: Wed, 24 Jun 2026 13:49:24 +0800
Message-ID: <065e447dc41ea149c900338e64f047575ca6c348.1782279704.git.adrian.ho.yin.ng@altera.com>
X-Mailer: git-send-email 2.49.GIT
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To PH0PR03MB6235.namprd03.prod.outlook.com
 (2603:10b6:510:ed::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR03MB6235:EE_|BN9PR03MB6153:EE_
X-MS-Office365-Filtering-Correlation-Id: 836540f8-6903-4a13-d996-08ded1b51a78
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|56012099006|11063799006|55112099003;
X-Microsoft-Antispam-Message-Info:
	r+pDI+TIaENpMVabkcx8jnOeSEvt4Xz0U/++kDg2mi6eJAn4kqAQ9SwWZTkkrZsRWeqkPaQVqQwpATgAYsROpu0+aaXNRKry2gExQ6n6naYjCW8itZCoEqjzi9y9d2XBrPGr8tsy7lzNi7dBeP0dyEdxOTj9+7s7u7Aieg3dZuCJB+Dsp028G5B6bd9G6VTsAKi+tbUIyJn1boEQ1zaXajCNaR7kWaBL4sDaLgz5iqdjluid3C2egfpSAIMz/mKE88YK/rxmlScZ9Mt+yQ2KPYt64lVqaZyvxBvqu7/UEKk0avoO859aIat2U/mQaKkUy9l8jqC5Q4R4SPUZg1ND6nmjQn2h+KrhovBViwNc+qMBKTIMtlhHE4AjOy9Kn3SgXeNhZCIm1vXI4gN95cUsliI6AHe/JzfEjvQuB+pQ5nSOcEFtJ+3sThAKl/27tVZSkP2HeGYYZvyfuCabKqa/0SayjapSJAUpPNbTOpCIAgHY7WLc9FL+V5rswzjEFYhlmPa4crQgdCt2S8SNGAV3EDt6J5Svt1TCv53gKuoqgedkijCb7EluqSnxSM2wUaTLNrjvuRils26SeMWAWAEN+LkYhBwFmhipb+OcPeKMwkMxKfh/60yMrtXGRROxoGZ8g9qUy5d5942mOrrC38FOIb7vQ+lptc75CLPTjdBr07k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6235.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(56012099006)(11063799006)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wEBokDeJQ+Iq/CxJpsfAbDjGTXNl3GgMAdHDelpFQ0MbpgNSXTh2C05AFBmC?=
 =?us-ascii?Q?0+YZP5ie/mk/XeVaUlWlSCI8UVKMZTse0JA5ZHTVkDWs6z9YqjjpFOs9vI/R?=
 =?us-ascii?Q?YO8YwSJCc+cXq6SkaFP1Ywe8aWrqcsHZ6BrHy9sRwu2XFXpvjpjbckrwNXS+?=
 =?us-ascii?Q?lTQxdmsAt7Yrg6moEWEFs41dmmNpACgakY2YefCLYsrdx7q8sacwZo35H8GR?=
 =?us-ascii?Q?VLBZe0UpGvZJ8y76aUZ93xMMkcYAyEcoU48q1+xiXYI8C51ytjlwgpYDiBH6?=
 =?us-ascii?Q?qAQDVLZATlcVa1wp3xtl1TiCwkf5Ywfm2O7aycfGbGek3kSkegv9VuiNxWpU?=
 =?us-ascii?Q?H+moh3xtwEzfpYkEKKk3OICGbNyC2sw7jBg70adCyPyt2+GKvfxWQ+AhzDjm?=
 =?us-ascii?Q?WuA0wqB8rvQ5dQhYmsxpZCoJADqxPegxeLe65/CBpa5umG5jPUAyCWzVsfmW?=
 =?us-ascii?Q?GCJHEX9lw/IV7r6ioz8IPTmqgwU9JMjLfYvSU6nYx4rfC9MG9OJeu+5wtrEQ?=
 =?us-ascii?Q?ANnBUEA0L9/0dHRFs9dK4zCkAkn4BJDk1rMORGOJyrwFfTXlGAgXUdycrhiG?=
 =?us-ascii?Q?V69GVwYFHcAW6YLoPYHrsQDiHW4y7u9F58heLmdBSoPGkapBv4iraARreROT?=
 =?us-ascii?Q?1ofU/JQmQpRzXdmGP2+qBSq8QoTaLpPluNorXHVlHDbftzrhBlzmQR3SHsPh?=
 =?us-ascii?Q?a4BM35Xm47NC6KKxP8sYpvKG+hWr2b4sEL2rQYVWRKK5jYRFvEBvIHqkBpv7?=
 =?us-ascii?Q?blVuWsDKBiGwU2PjeWz4K9xvVCxaAgtNSSkIBS7opI7xMBAuciFgNz0ZOeRB?=
 =?us-ascii?Q?bVqvQvKbewFz3nmIgY5bJeNTN0DrMDWxxZOrQzRv7HXB2ywU/1IgRWmrOQgZ?=
 =?us-ascii?Q?FjP4Kreu/1o9kGJtL7PSTf5omCBxzG0mhefP1bBA0Dta2IqEh9mMXSREsY8M?=
 =?us-ascii?Q?Kar98d7rNaeWREkg2cWXFvOiMJmO+6hWJl4gJVgHRUCwAgkRR0qpTk+LX/Td?=
 =?us-ascii?Q?Zmv+BIbGQzMeY/cG+cUFKEeXU6Nlgsw/t5JK1gW/VrrM8SxvfRCzIM5NyZ4v?=
 =?us-ascii?Q?8YBYmVkVa+Yp8GWL8h3agIIBnxxf+8bUEdrJBCu1f5Mnl+8qgEM16iBOnavH?=
 =?us-ascii?Q?iGOsnhMCxw2nMHNITrhwsAEU4052VTNb21urrQuebNRr4S3+qBHMi8CY6u49?=
 =?us-ascii?Q?uzo14PpqF/uVCZvoQDm1uUCEYelOc5TlTQntKuYtHSYgPER3ejqoO7brP1dI?=
 =?us-ascii?Q?C05+VEffRWdM9Dp/2N2Lejo+C7BvJFc8teFjwH22QG7MEqgAmoUAh/8hBB/r?=
 =?us-ascii?Q?g7pktpHx6dNzUKReF+a7ugQd7lKDPV6wfRNgMOCxvM40O13Ksxwqr7PnRecc?=
 =?us-ascii?Q?rqw9rY8sc7l63Kt8RF7J2n0LGrSH4lAtqqngWPe86glUiF8WUJfbcG9UKOgx?=
 =?us-ascii?Q?LAi9gmyRctNWYy67aXtFpMomduVpjRVVvk6vR3dR2fKBGE+ZFBdi6ntJLyXY?=
 =?us-ascii?Q?jr3cROwlTALqNYkqms2oLwRvAtN3kxX5etDDm5duD+AEGOyKgibr6yqvEZZE?=
 =?us-ascii?Q?DZVLQn4K35c2n4p5KJjMF6IkshttBnt+6sOdtGqrIjYzEpOJNC18qaklg+na?=
 =?us-ascii?Q?YFKYWNOK/NWRJ9biU6znfbHlb4hVo7/YFuU7SVMfe2esZsMYPgNPusnpkOLm?=
 =?us-ascii?Q?2d7pRjTwtSidCKLvILTFDnALDeiMlZfCKkzJsJoeVDF42IiP2zg/grJBoe58?=
 =?us-ascii?Q?T1/CkMC3W15IQSZ3dqnCwziQoC7Ixrk=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 836540f8-6903-4a13-d996-08ded1b51a78
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6235.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 05:54:50.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfzRf8+rD3YnfcvP5Fp9tNM35Y+cBNFdej8LxGO0dIBsTaYMuaEsNaiuu4aN8CP7ApkjGc6xuw3VEp7/5l82J7QIdWce/62dHCMYHW0q43o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6153
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[altera.com,reject];
	R_DKIM_ALLOW(-0.20)[altera.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11761-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[adrian.ho.yin.ng@altera.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,denx.de,kernel.org,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:olivierdautricourt@gmail.com,m:sr@denx.de,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:adrian.ho.yin.ng@altera.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[adrian.ho.yin.ng@altera.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[altera.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,altera.com:dkim,altera.com:email,altera.com:mid,altera.com:from_mime,denx.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F2466BBA65

Olivier Dautricourt has stepped down as maintainer of the Altera
msgDMA driver as he no longer has access to the hardware. Add
Adrian Ng Ho Yin as the new maintainer and update the status to
Maintained.

Signed-off-by: Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b787bc2855f..1f515256412b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -952,10 +952,10 @@ S:	Maintained
 F:	drivers/mailbox/mailbox-altera.c
 
 ALTERA MSGDMA IP CORE DRIVER
-M:	Olivier Dautricourt <olivierdautricourt@gmail.com>
+M:	Adrian Ng Ho Yin <adrian.ho.yin.ng@altera.com>
 R:	Stefan Roese <sr@denx.de>
 L:	dmaengine@vger.kernel.org
-S:	Odd Fixes
+S:	Maintained
 F:	Documentation/devicetree/bindings/dma/altr,msgdma.yaml
 F:	drivers/dma/altera-msgdma.c
 
-- 
2.49.GIT


