Return-Path: <dmaengine+bounces-9895-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6J7oF2t51GlduQcAu9opvQ
	(envelope-from <dmaengine+bounces-9895-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:26:35 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 074CF3A967F
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 05:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 708D430059B5
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 03:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644B4373C16;
	Tue,  7 Apr 2026 03:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gb+PHko7"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011004.outbound.protection.outlook.com [52.101.65.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FEA372EE3;
	Tue,  7 Apr 2026 03:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775532393; cv=fail; b=tZcm7zIpHy5ODUpZOR2fGKrZY9/L5F4E6Y7zrGotv7U6v/ydwHrvRayUAjPOBHoz2eMwBO/qB7fKSAttb07ZjSZmPOnwcDK0MsHyO+lQEUrgF2odrv7ZQD/cbfLzf4PLWuMtKAPF2omoXXs9XmnHemFr+pZ8nzMweYXaeTXoDAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775532393; c=relaxed/simple;
	bh=yLgSTRPYwY+i5ooudLwr+z1MhEplcIKjTo4iCSDMIAM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YuFb7A6oD2iMEt7SgEkXvG7TDPX0YpGl50WzxyQI65527v1kxUM0ci1PfYWY08bI6/u80KbZDUygX5pgoI40Tuwd83k2lzQMbJt04WK5GFzAcPp7auAah0XEFavlTlt5T8LvDqrZFUAcWmvnJWqTOIq9uuGYkV5dJQmHwhhrS64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gb+PHko7; arc=fail smtp.client-ip=52.101.65.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PIOpFC2RJ6GMgw/GttSBLl1tzNb+ecHBaDvA4/PYIv4PVPP9YkA5ydNjoe0c5RJZecKcB9HyCtUt8AtlyWNrM8YJptvaLqoi2Tn0hc9B1zcb5bHfaDesjgVgNaZEGrQPkhW45pLcgtTHZcuAFVU6VwrivhZ4t5WoSyINxg4JqIUH3YPIhdDOZxcss/OUYsdJ3skO8LK0V/acqi2gBpDfbQCwSghid6jdPXiD6I01y0KUCchEGqCL+AvTot+/ebzTXQI6C/IEtrj5mnlKFW+31rznC5acpQB2k6Xih7RZ5Z+IOJW2XMl9Qg0YzgamPjBNICmTDr+LD0KahI0Ab8OPEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbcz99kPo18RhdscLLgwH7q2owmV552y+EOEXPddVmU=;
 b=eG2GF4S+ksnLh6vN+QI3F6ETXXmWrqN2nEOa4KGjO53nP84J854czH3qZ26mV7XGR+1GEZi2MuhCh05pr70BxRA4BVWEaAhLa8E+cS9TX3cdHLNz00X1sNUJ2l2YZVAusxibFNKdtIKHAUG3wIWoPQwyS0BbmGnPh0vvvHWCFJY65V5jP1HBcTLDeX6tdVkqsiOZ8j4XaC0bif2G8X+Sr0NfLtmZubgP3ME9IoED74qfNWoyl2DwHcPRJeWhODxVkRpIPP6DqSuzvSF8GMW9C5ofzVB/eYDMv+kCiQMzsvf2QNXlv5fQzvwIqr33rYnr9JCUFkvq+irjMPd+v41mUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbcz99kPo18RhdscLLgwH7q2owmV552y+EOEXPddVmU=;
 b=Gb+PHko7oH98EXHlpKZBRCtVeKbGBlzR43phGATh0EbP1vdu+OlgOJdtdZEkyVaC0sGZsOqtGdKdWvoMWZtiKNPebb3zAXgc2TAEXBVXfhE2XqU5bYsLikmHzlCokk+dW72X8pBQ4ThHA9NzbNxNQ2CeDrgp0UMEldtFP4qkUBKCL7XtIlaw7RT/Cba+QmXjBDF76Qriirud3ZJWdNR8RI01ALWiH4T/DZts7sSdARCbll7s0wKRiInumBpUqZoRyDima9tqEX3EKi1wpo2QovysTM5Dyb4N+1u6GIjXNJoHIGLOOHi9LC58pCzIn6KUrkU4YyycTHWR9yWs0cBYNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
 by PAXPR04MB8237.eurprd04.prod.outlook.com (2603:10a6:102:1cc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 7 Apr
 2026 03:26:28 +0000
Received: from AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b]) by AM0PR04MB7044.eurprd04.prod.outlook.com
 ([fe80::bab2:d15c:fcf8:ef2b%4]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 03:26:28 +0000
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
Subject: [PATCH v2] dmaengine: imx-sdma: Refine spba bus searching in probe
Date: Tue,  7 Apr 2026 11:27:55 +0800
Message-Id: <20260407032755.2758049-1-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To AM0PR04MB7044.eurprd04.prod.outlook.com (2603:10a6:208:191::20)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB7044:EE_|PAXPR04MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f95e14e-6e4d-4caa-dc14-08de9455744d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7BSF8eJFa4CkExEmy+Xrdg5V2cv7CS2JXhNZAfkVbY2CkFW9Sa5jaPPlOBqfyqsmlzLp1UOji9dfX9/kr2vCqE0w6g1qUDz9LeJIVK2nEG2C4nju57Jj2hrYWT+z2biEMndzLOmpvrdceM6ZLbIcQa+FEIAovGM1ivYXw5M4WwtOhUGq7Bhsi8DdxcwRCUz/NJEfZvc1mxK+MsmQ7xPq8x8+mIMbgW8ESqZCtZwV8DznRsfRWGOfXYUSXr4E2PJAMwws397fja/HWeCttkEkPVtAHw6MhYl/bsWtvUvhEM52lkhYzso86WyVQzdyxy1chEMxCuL2G6kbVPXKFZIaVSx++6iJFm3H6Mv3SShCz1BQlO5ylpt1H1PFlezWLrkvGCj68Fy5VfYSY+pEKG6jWUvWEeYJD2dOkuxAegvm6N3f4pghLyh2iiw5SB1R/RjAZ8W8eA67Y8YWyeJI4RuSsI+uG4UXQmBAanMbyCkA5OcaR6zS0rlOedwybKt+R9iLkvRc5ic4RJIFmxL6RleV3AGbiIk8KVcG0dWOJWdZEGgqN2v18p9AmRLdvgoAtLaUVWeOUcZg3tYihp0um0XEovwkvV5gsP2LwGkEtZgfke8Qtw3PN+kUMFn9DUB2LCiHj1dDNSQyezppj9nS5cA6yDHjL0yJKE1HQFpbnGpC7K1bmEV+1FpGvlCQtke0Kawm+VBhdj07Zu1rGoNfxNb7s5LIe3P58qLhtPwRgo0YG7Du25ShuJvOwlI6FwEI+0R+ZGv8DOjTsl3GqahssNbEMQaY5dEAoiZTiWpX5SMr1II=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB7044.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GbbVosXniA+YKAchAs47/n573jS58tYtaL2JWBBtny9fq+UWzxLBc8Sz/Zjh?=
 =?us-ascii?Q?1+fYHN9/FVTbUlKUACMMInCiW2z/HZ5VN2HgH3MLdlXTUiA61stcIiLWeJMw?=
 =?us-ascii?Q?/XIWOBxbScT+g2yZRzM2zo78kDLmYWRoHjlKxGXaVAxFXGZd9O08wEB7mLQk?=
 =?us-ascii?Q?Ty6L+M5RR5Xlh5+lcHkO3pQrFL+Y9KS+7ybzakM6YNn/u8jlXolj8LltdAs8?=
 =?us-ascii?Q?bSE+4F6/p/BZgiXOXsKdEDL60GN/p8nK7PZy/IAogGoaezS5vR6RszzInGY2?=
 =?us-ascii?Q?3MnYZIMex3UUBgkrcSkDnO3Fs7IKvm5gEV+7WCdXtJqp/3GszUlI8zpgtDcH?=
 =?us-ascii?Q?N3iGtx2v8z/SiV7r4u0x5+XFsYB9pJWCaeuLhJox84Fy9bxIb7KmRk3Ee6Ur?=
 =?us-ascii?Q?zMDPl8W4oO6ROmtkE2Ejs32yILzi065gD6hF5cDo8QoQLqJ3f/qvL+Dtjo16?=
 =?us-ascii?Q?V3OJd9bttiOT8CFDBW6x4l403T5h2RzndfPJzEKKkQjqBcC6k1vbkXg9RshK?=
 =?us-ascii?Q?TQM4Q1c4r2DAiiswA27dtkPYSXlxOCFwhorbqiZC8o5rv+wamfsrjvAgkfDh?=
 =?us-ascii?Q?YE0K7SiRz3eo3FN64XKSrY8JWpQGgLI9b0GGGx9A+Q4wwKDyAsD1hgOItCHZ?=
 =?us-ascii?Q?7UQpyxYWr/16p3tg2oznzSGLi4ADNjSO/IL4LFC2KtwuuT0OPZLQ/H0Sb3YV?=
 =?us-ascii?Q?pF+MaPRwhfPD2kHjFgFHL/BwAxAfoI5ZbL5AKQxTbU6e85XaRfTgl9dWYywT?=
 =?us-ascii?Q?cb69VcWoXnxW66jJL1jbMIFFb9ywjoqAdf5Cjc4ZBAP+Geg8thnA2gSy0XXD?=
 =?us-ascii?Q?JVKJkDFJfLjwcClz7iPLxP9PUNIewA3nVrJOmnD5ElxK/BylYERmvs9AhIiO?=
 =?us-ascii?Q?/0VxsMNNAcUF2U5ezlxn/JQ+EghgGxqo6uEDGLPGcJ3iRZ0bXl9mAhrSJQaa?=
 =?us-ascii?Q?3UqN7Cx/VG/BR9AwBQZQhrHnEcjwbCfisKN8DeohRIpktCjdP4HGZidGKece?=
 =?us-ascii?Q?kqC9yLOM5oMnjeEmhJYTCILXY/gQuOuPoi5qw6kYl0IJigIuD6K5AIKrhscA?=
 =?us-ascii?Q?VJHshD0xe3WwrNpqwZ1dJjlLSGwKhLYJLaT5iHNURzasodiB21qDTf1KYqL+?=
 =?us-ascii?Q?yaWCGSsgASxXOszdO349wLuOtQAelqPwCxsWqbcINTzs+dB7SJBldpBPuEBT?=
 =?us-ascii?Q?aESkFxXzGmwa0dxqAq+j2lsCsFcYCkrmfv8dSfBw7QI7AAfuxbQB6WlGq/6/?=
 =?us-ascii?Q?61xtF7ntjY351ADKZBqJBF8Z3OTq31NosvtGsyOHU4X0+2URtvZUI6b2J4FC?=
 =?us-ascii?Q?kFtMDy5P9NeJUknGRF6d3t56So5FGy3QDtatswaBz9wyhwCDbB65gUhS+HnZ?=
 =?us-ascii?Q?sxtPegFBHh3CKEQypdmzfuchV5fsz+30dO8vzCdp9Q38IFURSmHwpGgL2VlJ?=
 =?us-ascii?Q?GWSC8gwDr+y/FYmD+80l8XEHBh+1qiLttluQQexP/3xm7EiM/q48ZOc2rjW4?=
 =?us-ascii?Q?CuVTI9/K7wmk/O1zsapwSCDbL3Vc6NoZm6KaZjF3r/xyzH6Ux9TwqTvl0M9F?=
 =?us-ascii?Q?TYmcdbWL2XKCapR/zDM9YCX1T/UaVYYQKWaVmu7UA+ODQZ1niJKfgFqzg+pe?=
 =?us-ascii?Q?7kenjb4SZhVFwZekajQ45Dvd9O/TK8WW2DFIRbehheNREwmS7r8txermWTGf?=
 =?us-ascii?Q?xpTjD1wkf+fbfMiueJEVEuJaCmfHqRPVgGpNa7DxEHVIi6BNNnVmAIwBQGic?=
 =?us-ascii?Q?OxKASOWGrw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f95e14e-6e4d-4caa-dc14-08de9455744d
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB7044.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 03:26:27.9792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XGBhbwiQgMSKf7wehHA0qMDdtGFOd8Tq44+O5XOpvPZs+e3hvynaoTekWOYpL3nS42qf2Y8vVUgWru2nY41qSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8237
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-9895-lists,dmaengine=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[shengjiu.wang@nxp.com,dmaengine@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,pengutronix.de,gmail.com,vger.kernel.org,lists.linux.dev,lists.infradead.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[dmaengine];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,nxp.com:mid]
X-Rspamd-Queue-Id: 074CF3A967F
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

Fixes: 8391ecf465ec ("dmaengine: imx-sdma: Add device to device support")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
changes in v2:
- add fixes tag
- use __free(device_node) for auto release.

 drivers/dma/imx-sdma.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 3d527883776b..36368835a845 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -2364,7 +2364,9 @@ static int sdma_probe(struct platform_device *pdev)
 			return dev_err_probe(&pdev->dev, ret,
 					     "failed to register controller\n");
 
-		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
+		struct device_node *sdma_parent_np __free(device_node) = of_get_parent(np);
+
+		spba_bus = of_get_compatible_child(sdma_parent_np, "fsl,spba-bus");
 		ret = of_address_to_resource(spba_bus, 0, &spba_res);
 		if (!ret) {
 			sdma->spba_start_addr = spba_res.start;
-- 
2.34.1


