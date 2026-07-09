Return-Path: <dmaengine+bounces-12187-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iqu+AmK0T2onnAIAu9opvQ
	(envelope-from <dmaengine+bounces-12187-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:46:58 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD5073270B
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:46:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=NT8SNgBt;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12187-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12187-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 38AB730A3F21
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4145E42DA53;
	Thu,  9 Jul 2026 13:59:23 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012065.outbound.protection.outlook.com [52.101.126.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6FE42CAEC;
	Thu,  9 Jul 2026 13:59:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605563; cv=fail; b=az7dyPyi9SHRD+27z49ia97vnw2VPpjdUGN2kvTMdbbvVq8wyX2qpWn2jZySK3A1m5nzWsLo75Dl6GFG3WEC5LWx9nkxDkVSYWJehy3ztLf7Fco94GRcdmL20qlZh1w4xXsjdxSfmn5hghpl1+xyZCCYWLMwlIlTDSOgNkkflWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605563; c=relaxed/simple;
	bh=DIPi2pJs75csDIYnGRvBACEgAWNTOS8QFCsPYT3Qmys=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SHm+GyAQPUgcD5xVAHrDV0EI1K/7yVmhCSRo92pgRBsQA0OYXAGQ26cGHQr8YJjXhuFEnlLkS2aLYYgSbigjmeK/zdX+we9/78M1dmti+rYTvA9UCyVudZK++YOs4a4VDOG/3NDFSPKNtIbOmH7rnqq4H2J7jlApcRTC45VqmfU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=NT8SNgBt; arc=fail smtp.client-ip=52.101.126.65
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b5HukLOTQehalTj6N6X0xCabvPIoGAQINezGOVeynsoS2sELWuGBbJPhXLov7RVAfwdDQqqfqZ/FjcIev82F0JxTFi/dWZ2xJCEyzBXgTlf0zDmq+gSZgIhAWSI3hv3F+QI9jeKJwPRrIZsPFCsKtnrodY7DFMj9GAQzvw5KR8+1eMO65DWptjPjFVQMCSnF632vzk05drTJxaVu7uWD4LeBkt8hru7GNBPUdb4iFDU7pJyyJUOvboEBHcW1Fl+y9a9JAq6x3JtZzJ4MfwHs2OI59O0iRRVjloWJr/X1CWHkGiwWSbIGB7bv40Gx8rGYQyujBjnaNR7WK7AzX22+7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAcNGf/z2cxKbYBcCVqx7wMn/EuAI8Hi6NSI+gmvzSw=;
 b=sdx7Ip92Rqdo5gB474gOl6PKvbyvQXrQIALVsiYCl53dFWMjg4486FQZd01ETydshQ+lq+xkxtyuIZ35k08wYXAWwWkZ0fDYhcGLNOj5EGMbTybapYZIs/11GPImZOS27ME6RavNzSh5DVHs2rLub5I203/mIKPkrgdfQizk0ePjYto4DpNvrb2rcJRTx+Y1VIpBaRVW1EaOluWTy4qpfqPVWtUU3N5zrMuIHqhipW4RLctaiIEzsuyTv5KxhI+l36pNaNdJIXQUJCWEYUrJH+r5Uf7ZmtjxQqRbFn+jhsQdi9+P4BzBDWN7wPxbCggXrPLXcunkjXyzM9ApJ3ZzIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAcNGf/z2cxKbYBcCVqx7wMn/EuAI8Hi6NSI+gmvzSw=;
 b=NT8SNgBtpEr+td+BpiwGAhQJ+EruHG0t/RyJvv7PXEvBxw8ai5vhPOoR3/IxqedyMWY6eKDT1qqCBAWC77M2ZNS/K8618T9luoCrcqXSCPVY/lmoegdcCFcppGJreIDqanWqU0WBNXFWYAR/Wh8NWH3uJdeAO5n+8HsA44GBbm4tBHjR7HXR1mI/Lfy1YCE/2PUlOeVK7zLmtgvvGtB6lWN2cc9pyjXyJpP4l5KbJ8iUb2EIhcRwlP8N9bLxYpu89GSbBE2XMsVefSD39DTEyC6VYVPa+Qb5Ny8AUneUgRc33nl0tF914JfILEtZ0cQNnyU2JgWF0j4g1BxAcfB/YQ==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SETPR06MB9093.apcprd06.prod.outlook.com (2603:1096:101:318::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 13:59:19 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:18 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Jyothi Kumar Seerapu <quic_jseerapu@quicinc.com>,
	Kees Cook <kees@kernel.org>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Miaoqian Lin <linmq006@gmail.com>,
	Pan Chuang <panchuang@vivo.com>,
	linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM MAILING LIST),
	dmaengine@vger.kernel.org (open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/26] dmaengine: qcom-gpi: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:14 +0800
Message-Id: <20260709135846.97972-11-panchuang@vivo.com>
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
X-MS-Office365-Filtering-Correlation-Id: d36c7a0a-7b06-4d94-997b-08deddc24534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|52116014|38350700014|921020|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	49RacYwRx8QTv4u87duyyPkFt+aq7kS1K2T5kfNQympWJuteTyN/NuGhYRGCA2fqQlPr9XzBT1B5HWj/Raa+F4H5K4J4tO+npX+IBI98vyn7s1s4K8PoEyRwDroyO37wrLiICB7SRWm6F4c2eh2LcVAp9QeSnWWlIPYf+Jg6ugcf1GsQ2aLjMiL1JYO2vixiaMX9fG1DXlveO998CdS7NwDE/EBijKGzw/OzIGgfQzayNbz9hiCSdBOLs/+r3X60mCQFDYdAXrp7O4I9RUp05taEowGMjG1PEGigKkgLwTUrWTn42Zrs+SWfdtBEXlyNBZbYr2nikVWV8I+DwKBh3zOsQ46lmT/nE3/ClPnXeqs11tvcNIs8wAv3QL6GlqbvGf0cmqpXOqpo2V40HBzx5hkE2ZLQbIa7D584KZfz/9OBogEmLJ5i7G9eA3/McH4rwDjm8hj3OgKpx6JqN0ZlVS+I6twasDen6AXwR8sK7rhkFH8Ua3y5zKgH2kKDXIfr2cOZg1/VCT+RbDEIYmqdfFyH+QMDoIU3gtdRGMVTmqsNagZkVaim+Odl1K7sKrsv8o1gnp++0EstjWZqKrq7YAzGAHAHUXSeUP2iZA4VQeVJtE3gbQGcGtC9EiVrJifMcTS12sEyREOxD10HdC5cbXmNeYTfpLFWWEHub1m7eOtIY9+ut02jBgZED5Yt/faGb2vt3OPlrfZwWx6Zbq5YUjuYZEyOax+peA5kkoU447s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014)(921020)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SBst9yuJn0YDCMaiilllhyUZ1wUZU9ww2OhQfHlAYOHmtYwXCSXdxuQZIzdr?=
 =?us-ascii?Q?JB8VMZP5LqF9jvePXvJKcnqj9lWLBHcRNRTbH3N8uYmv0q8hpkHEg8dCdlDB?=
 =?us-ascii?Q?F/aSiD33QtI2y07lvrM/l1yVkJ/JVOZXBbKHhkNBB3JPyJGf1XWHyrPWK5DE?=
 =?us-ascii?Q?eCts8vm8PyjjBJzkzWgdqpyiBXAQQPJ38HLtWhbxY6mx6rXrWABa453BwGra?=
 =?us-ascii?Q?XisUy+Vqonu4xhF6jAjcArbctQoiZuFsa5jh3JKlVtvwVsmnrWEoep+HSZHm?=
 =?us-ascii?Q?3pVxAaUcSc85wTycNOwA8iP3IbHGCZE+tjxVEW/w3yYkth0et62/t3RLAdi/?=
 =?us-ascii?Q?KZ15PLBh1R6fD4cutfo9+Eor1amqXih6KwXftRkjmt/pcjxtHmM6g2KV701A?=
 =?us-ascii?Q?7PauhRiVJAsu/KgUpeyPPkaNeCjiQFGbqpjWZPAjj9nvbjNwjpqiz63q+a+s?=
 =?us-ascii?Q?74JtLYUGfPWNnpk11hC6KBFs7FOe+wkOm/JrW4kLRZcWnZRrOCgPSPsWRjGi?=
 =?us-ascii?Q?zvA38EYCEPoXLM43JIY7zoCKN4PFYjkA2ovU/e3Jb1aJrCzNiBiVBe3Kxwd9?=
 =?us-ascii?Q?w7kaHjJ3D+R1r1fcogWdUYnuzOzJP5Dz3AI3NwbvYTGLd0qkTLgHs67Y2xKz?=
 =?us-ascii?Q?UP2OjkXcCPwsKWnb0Ioimh4Fx/l0tOQ0h/I2p0KChqFDEyXVZTBVncEiybPI?=
 =?us-ascii?Q?FPtlfAOhKJSm0dF6YCcSBSr+zFvY8vy93d+ca8TpOD7s8rYaB/JP+JxE0Opz?=
 =?us-ascii?Q?Ue7imtKk9MuPbGauQBM8HGSZdbKK3CtqeTPvhJOdrxHo2JWLWj6ofXMTSHE1?=
 =?us-ascii?Q?yEo/3zW1HvgkHf6wjxAC6/mYk6XLptijJ+lefYR32ViZ+Oo23LF9wyDVOhA2?=
 =?us-ascii?Q?yIJyceHV+JDyf8B83PjX7egYz3qbiu9jA92IlW1xDS0PM79gA67denRSpnwf?=
 =?us-ascii?Q?2CCd1UuaH+Dn7uJ/KMSwdlPHCtifcXVGwZU+LgkirLZNAYvdBvyvIqBqmu1r?=
 =?us-ascii?Q?mVTSdvTQP2dC8TlEvkuOFAbxiLTck0LJe2eW7/SmlTR6wQ/6tHKyGFHHfuls?=
 =?us-ascii?Q?wi5XS3jBTywITf/r5q7vIm2UQPQU9evEAEwd43gGZZY5WPSDb4ZH0f/YLi8H?=
 =?us-ascii?Q?2C4uxp6Ue8NFzOonhqnbcs5kGOil5RmGgJC+B0REXejkQ4t74TaLPv31Bokf?=
 =?us-ascii?Q?XozYVozbGOiB4jlz1PC7wKLb6UFdfl8ynVAs1qkYZpuHDmkYlrE2vRPNyknN?=
 =?us-ascii?Q?t3d4zTal5S8tObYME/N1bHMxRJdj4F8vj1OS4mrtPlLAtks9roeTfojaKBlD?=
 =?us-ascii?Q?4uATe5Gmn7MNOIrK7E32drLQl6EMchkS/hy/hcqLslXbJUf7XqA8KBUQ1efQ?=
 =?us-ascii?Q?PUwto3qf00q2kW5NmcBikCxoEXk07YtkPjnufH99ydQ+pa4m6LM/R3yIcLKi?=
 =?us-ascii?Q?J36PuKxLXg7CCrHdxdvL2UUk6BthSDkKzwFHTePeBJ3tGiMGY+/n4GHsU8Wo?=
 =?us-ascii?Q?9ndyLsm1U18cqY8ksLFkf79GtFPBqiKVLR0VYmvWMc9yc/Nkmsit/ThE1FRa?=
 =?us-ascii?Q?VB6j9uvFuAhHxTT9yHNXhNfC5yXg8o7pjpJ0D0cr6aP7T0CK4dZe9DcwC9Ue?=
 =?us-ascii?Q?axbroAvCgsQ3iktK98RrWpnWwa/mD179jDSgJhXIGn4fmCQGEQ/dL4cWJY4g?=
 =?us-ascii?Q?nAEB/fHe3dO6qNe2K4FaBlVXLPLXhLGnjMDMV4XvE+JKYW4pBliHSVn/++hR?=
 =?us-ascii?Q?FSjc7fN61A=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d36c7a0a-7b06-4d94-997b-08deddc24534
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:18.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NLtRWSQLAYBhNP/nAlL2NOchH9fxeqpmRA1CbQcJGC7Wd2QXLp7v1ynUgO3+NXKNF9oYHItaHcXBWVHpayxN+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SETPR06MB9093
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[vivo.com,quarantine];
	R_DKIM_ALLOW(-0.20)[vivo.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12187-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,oss.qualcomm.com,quicinc.com,iscas.ac.cn,gmail.com,vivo.com,vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmitry.baryshkov@oss.qualcomm.com,m:quic_jseerapu@quicinc.com,m:kees@kernel.org,m:zhengxingda@iscas.ac.cn,m:linmq006@gmail.com,m:panchuang@vivo.com,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vivo.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAD5073270B

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/qcom/gpi.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..af824682e64c 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -617,11 +617,8 @@ static int gpi_config_interrupts(struct gpii *gpii, enum gpii_irq_settings setti
 		ret = devm_request_irq(gpii->gpi_dev->dev, gpii->irq,
 				       gpi_handle_irq, IRQF_TRIGGER_HIGH,
 				       "gpi-dma", gpii);
-		if (ret < 0) {
-			dev_err(gpii->gpi_dev->dev, "error request irq:%d ret:%d\n",
-				gpii->irq, ret);
+		if (ret < 0)
 			return ret;
-		}
 	}
 
 	if (settings == MASK_IEOB_SETTINGS) {
-- 
2.34.1


