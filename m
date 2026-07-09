Return-Path: <dmaengine+bounces-12179-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qqdNGgKrT2q4mQIAu9opvQ
	(envelope-from <dmaengine+bounces-12179-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:06:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC3BF731FB5
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:06:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=BzCcZjQX;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12179-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12179-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D929F30E30B5
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BE6416CE4;
	Thu,  9 Jul 2026 13:59:12 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012026.outbound.protection.outlook.com [40.107.75.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8092E411684;
	Thu,  9 Jul 2026 13:59:10 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605552; cv=fail; b=pUlsT6ZJxGsisoSsfn7Zt18kGNfheHIMcWqeU56JNUWRMpf0tshB+rIvlzozTgasCgZWW3q9INMkAS7vowmiZz6UU14N+n29AQ4aAfrjiqIcmruQU6bkelj5wP/nahaP2/XCIdxdN7pkmtN0H4N1Tf46h/hB1dCWJrP9gVv4QrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605552; c=relaxed/simple;
	bh=rViV2LLZzkyZCMpgPUo/BEIQlkiYql8IRgTowIulB4k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WsRzkD9X8Id4vlOv9CGicXPiJI1cUx40OOjWDimQ1W/o3HMiNBYXiyFBLpnhQOFk11yUQgRH78Es+pDPoDXEOW0gLlaszxMClhuOZ2x9dkmbDEUgd2Fv38206mEhP/FMcHKCUmo+JF9boxz1RrHQPkd2y6hAxOUQ/BpZsc9gRHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=BzCcZjQX; arc=fail smtp.client-ip=40.107.75.26
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQDgLBBxabNvgjBHjSndGArKlOBKKWUd+X6TkfEupzWsPZYCSg1j/u2OA6YqNAeY3WA4BXUzt9qTOa8TnWLlp6mEsaCeyxOy3YjQelMxrk6DC5BhPEhFlh+hGYSLnHtrwVzepo/0Ar1rAwmwDqqk/cT7CVJhy8Vrnjqquepiu8T5pP+Z+6pCXqBcqdIgUhJAU2HZtzuUQdStcuh0RguoKPQq2aAKUcxdDsQYFVLVDr95VIb4E+P7qS4IuqZD08O5mJURKwt2FMRSCMHHF1nvIOXO214yd1+dwwP3ZWA2I/9wFSevTZi7IWHlekRFamrH0owkZRJKfg5PK3+UEB/Udw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mY2zpSSRCONA5KRqwEoEKZ62IxBKkIRmx4MpTas9m/E=;
 b=O/oe5EJtRnUZhmrVplZkoaI3UCyBS3s93kmXa5LY7L4ScBJTEr6S9Y8Gm5d1dp3gAwify1w3nglwP0sluXjUD5cgUnjtHz5jed1DIuUXi/9c0UCet6zyAeky9Mn6hkR5FstLkYPDQPWAmxnicmGc/INecK92pwGh49+DgPuGV4MXTL1J+p85h1yRAwYhMZfAl5qUWESXXfU8spt4qdrGHCWfhjfvjnD/qTDsSRKBDefVoYDsZbdWbRskUX2IEq/zBnGTlMENf7a9/lj/JCATFqTyKkAclzrIgVUTod7+7pGph80oDNJodyjMyT/LI2wQ8aBGh+RK+MPDbLJhPuM/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mY2zpSSRCONA5KRqwEoEKZ62IxBKkIRmx4MpTas9m/E=;
 b=BzCcZjQXzCdkSfqbeNP04aQ5ZWSRMDL1s26Gmc+TwdFcAN7w2N69yB/wz2E2BbGY/9sPkGiHAqOVz93fyIDbSkQRPZYZ86rCAidkQvaPBRCv9OggF/d3Efb+GALXY1rlh7CC+cota14fn5qoitx+6NORYO1OiCfHDbuJgAFXy8qjE7N+Xex8Xcj4iYACBkBx/QONHB36OGPoFp6dKLQtDOQLNPxjeJHkJbU17VkHCDeshMZNxrK7SK0cxMt8Z3tm8qrSiimLMPYRgx1swNTpNGmgjoVZOW0hZtdN2OOYgh64ZMl7YzfMrETLQcEC5unaSyO4giztqCUiujDNPhAYJQ==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by PUZPR06MB5673.apcprd06.prod.outlook.com (2603:1096:301:fb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:05 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:05 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 02/26] dmaengine: fsl-qdma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:06 +0800
Message-Id: <20260709135846.97972-3-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|PUZPR06MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 55fb5fe5-d307-4fe0-d423-08deddc23ce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|23010399003|22082099003|18002099003|56012099006|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	qBDxpp5K7mH8NvLh8JMi06UopXYapghn7GRet4p+cCtY6WDzSB3kMLS0m6/OTLPKNWoF3hY15oSn4qf3N8GM5G+nA1CdF/1ctPWgrSx22EJjaKmGiWnxZA1OKjgYFCzbo5SyNxS0RNkzBVdyC5Zqes96FD0XonWnWHPR6c5aIwXgCzx7JO4EJBjY23TcLHpWg+bblyLWTBExxnb5k3a9L34wpm3io6rqOmK8S0zcPTrPm8cZna5cinFqrWooBR8FGy8HKOiNC2GKdFKq3epJ3Rf2yHqk/c/LDphVN+687u6bafKCiCud83coPf5mi1MmrS8SRhvTbGVZoQjd1pVcB7Acysj0cuOtNI/44rVB4sBXqJLLaJeVdEqLWaCTka62EHEpPhOTELk+fWBG52l5l6nGho8M42Cel0V1FRIpKgVYOf+vz0bJi0mIPd6omtsmioYGpfvIX7BL6Iw/wlii+7Ou7VpviJb3En6ouRr/dx25YJt+OuB7mv2njQVi8iyM2NhVQqv7Lwt2v3u+4mIFrRyEhKmiV7zW8Oq7y1HeuSi+NKnYFDLkJI6Fqas8V4Eyc3nhTX5wDMsSVxYHQ5Grl1u/rlOBN8h8mQwRnL+7l4kOpHhGZGY/BeTXtStsJVeJatI2FY/26DchMU8Pxl2KLaemwcQMJ7q30FWdOKxkVDqvBET+pCJfX2QXrXHmMcOFynsGwNQ58KvvdfygCQBR3VVW3QnhqV9HQa7/aW/GHzE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ewn2Rpd7cynywdKb72duV3pbwEKtj/EwNQpDKbQh4KKWS59UHJGlIuvLNhqq?=
 =?us-ascii?Q?2X7D+xgK3zTHjeS65sp4+atfeYi9fDiufPtQTiVcGQTQgIF/wimg1HCWDwkz?=
 =?us-ascii?Q?7O30Ym8xUHGtLcQurVUUbVwv1eHJqnhPQD00d4cTB1mG/hS8E3RBke+zawOy?=
 =?us-ascii?Q?OozBMgMdV3RKD1GAnJ3VU9EF7v0ZOmDwbhkPmtUQoKbXnsCnsg2qXvJbrsGr?=
 =?us-ascii?Q?n3V1jkyb4V4d8gX6m7IDRP3F+L1rYnrlwKiiN/PdIGkNN7bQnBLWl9ZYHgVr?=
 =?us-ascii?Q?XShr9zgk1e2tFLxz2h/1sbBO9h5PZ36P5jIlb7Zd9qXNQM52mF7ESAQOrBzD?=
 =?us-ascii?Q?gsxpdeobyFhT8Yb/GRrU0sMkmKTZFZMor2rEU6ZQBr4322VlqDp812vdA60c?=
 =?us-ascii?Q?57RB91Za1epin5s8a46w4V3dHjmjsvZANe0MNfhs82yBm4BHMg0O4XZqEMjn?=
 =?us-ascii?Q?pa9WeSOcjHpq6zo9pbbtbs1Q5bq+yRWZZMx4Eimu6VRgqi5wTRbXIbHBwyeM?=
 =?us-ascii?Q?jI6bKDWAHeS8DPfts0tZ1wEqmrBr1A3G+2KBpmVr1igJHPwGvUKTddWxHi1y?=
 =?us-ascii?Q?nrpFtwomRiVdL3UJIYaLFOMJ0GSykMmlOqnI0HL4s+O1K1mhLr6x0Ef4p08F?=
 =?us-ascii?Q?6dVat8BPj7vbRJrw27K7+nyBfogExerB3y0+tsVpnOyv2Zgk962xh5OsQdHG?=
 =?us-ascii?Q?wnaj0rW6okkE3L3YPhCEjdJcDLCkoFbO+IkcuFKFWadWhhZ8KS6y6DM1TmUp?=
 =?us-ascii?Q?Tt9I2XpxppU5cjWHnVvZ5Ivaz0rAn+KcYT62EyM89n0NIJPw0wIxvN9oNvXu?=
 =?us-ascii?Q?C4WmNHk5Rz1ZUwl6HsEHI29u1UKl331JrYhNuGCGw9KK9wRVIul/q5BHq3hA?=
 =?us-ascii?Q?HLdofrwoB1PbQrNEI0hLu/mMHAAcIBfsY0fUbw87rRacJwTEbftCqS+ZVBT5?=
 =?us-ascii?Q?KJlIYzeUFPfR9gvg0VAryzplR28z/yVjGS/MdUbtcFRIKLLvMghG/H1Jpjyj?=
 =?us-ascii?Q?D6aE8idVAD/+h5VFFxgT7DOFyntol2/iBgi8raJ9CA5JEseRScOfGLOkZNcY?=
 =?us-ascii?Q?fIG0EBVBaozX+as6qN/jJfeD48WXJ3Ecr3Ra4FTfRMWCSMzmQdZiZ0WGw+ao?=
 =?us-ascii?Q?+P7BmQvRtAaQ2k3+HtlZdRiDeeb02wc0wBDv2btd/9orZo7vdo1mJ8ibkaOu?=
 =?us-ascii?Q?1rlCFhFyQpY4esYBms2KKWrOjm35djzvz7Dq6Ns45Q1wGvG53uBZrBSWOA+K?=
 =?us-ascii?Q?rBwZ7QfhQ0eD115HRMYPcuC8CFvtiPTOMge5P1XUIjLvcFcMmhqJlh21dE1d?=
 =?us-ascii?Q?ziN85e4hXEiO1hrK5rvYUbmto3/UJsG9KNBi6SCw9dNHBPE5vpUF9hHfyYov?=
 =?us-ascii?Q?yamQrLmKeMo6Iq5Wn/Ex5ebF4APeWMt772f5EYgAeUyN/cleDldrIekWUq9w?=
 =?us-ascii?Q?VWnImdm459by1oMSQ4f76LNYAtXStRpLAw6cEmY7K1z4ppkBIPhwyUUhcE+S?=
 =?us-ascii?Q?rnmLsPH13IrfL1Mp3kneTGs5914lugSSDGsu+E8iIJ41iZFfU1sjWJOQfunG?=
 =?us-ascii?Q?VIftlMnsWaXqjsn9XJcqhqPOsaKzHGOfmWVxj3dY0Rh+YWcEAqs0vc9Ae4v+?=
 =?us-ascii?Q?3RHZe7n/V2FqSIPXThzVZNVRcpm88+tG2er8kxPj71FRym2u70N7ZVSFWZlK?=
 =?us-ascii?Q?0eJ/krElaRHAlRoEbaNs3k0Z7QUxfXu7UAhdv4JlSdral6DEHmEiPPHaLzAi?=
 =?us-ascii?Q?/SCQkXRvYQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55fb5fe5-d307-4fe0-d423-08deddc23ce5
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:05.0101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 87FbzQPymUBLY2fKgK2MgeXNX5CvD+0cLZ+k/iPdubaMQdawBd2UUX7Esp8wQA+1BotRFqvAFfFN+Tezrrhuow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB5673
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12179-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CC3BF731FB5

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/fsl-qdma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
index df843fad0ece..7f0d69b99289 100644
--- a/drivers/dma/fsl-qdma.c
+++ b/drivers/dma/fsl-qdma.c
@@ -818,10 +818,8 @@ fsl_qdma_irq_init(struct platform_device *pdev,
 	ret = devm_request_irq(&pdev->dev, fsl_qdma->error_irq,
 			       fsl_qdma_error_handler, 0,
 			       "qDMA error", fsl_qdma);
-	if (ret) {
-		dev_err(&pdev->dev, "Can't register qDMA controller IRQ.\n");
+	if (ret)
 		return  ret;
-	}
 
 	for (i = 0; i < fsl_qdma->block_number; i++) {
 		sprintf(irq_name, "qdma-queue%d", i);
-- 
2.34.1


