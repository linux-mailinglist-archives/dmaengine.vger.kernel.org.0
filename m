Return-Path: <dmaengine+bounces-12202-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VP2ZErSvT2oHmwIAu9opvQ
	(envelope-from <dmaengine+bounces-12202-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:27:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C05673236F
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:26:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=vivo.com header.s=selector2 header.b=kPiWyhcj;
	dmarc=pass (policy=quarantine) header.from=vivo.com;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12202-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12202-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85BAE31A49F9
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F3F43C7A4;
	Thu,  9 Jul 2026 13:59:56 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012064.outbound.protection.outlook.com [40.107.75.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A5743C05B;
	Thu,  9 Jul 2026 13:59:55 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783605596; cv=fail; b=hRs/68KB6G8XI4+z0W3QQ/ZIjOF4b58+7NY9bJZWCYxcCqR9bBBCXvhe28Pe+9DCB32QWSu6vc+Z7lWjEaadP9xvNzn7AmF3WLTmavaj6c91XmTHWhHPUQ90mwhlQDevmeBrWOPvVp/SIhZHsmm9PiVJK6epfMfJewf+9s7M1ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783605596; c=relaxed/simple;
	bh=7AOnt6NYFXX6btJHLkJCbS8/N8/4x4FV9U0YM1hXuu8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OV/HmOX1ZiTF/7WSebOURRkwYqSmPwrw1939doxmYjGSLb39rwyGifS+nzqd2VSOkmSPfYZqbDif67a9QtqqcTSTyXeJ0PWX3Fj+pv3qjz9P2kl+fuvBMDhJNvTAtq3zWHD7Ul0zA2asvkpMr8pwhzouEB8HQStJKYRWGCqqXcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kPiWyhcj; arc=fail smtp.client-ip=40.107.75.64
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7X4qKFC7gtIboTu64LkWzAf0VUWWS8Qa4elyopji6jX7ZogZDUucZNgr2R5p07m5HyntOB0ZQ8nyr+4+D21o2DqfUFAvZcyJemUAu6meQvwHoITrUo/08mHNYMV0q8YUn7TllXIGjbIpZ+so0xBWIKGU05KWx2SlEfGfcLSwVf2Dg1rNXwcG0hOCPYCjLpEqp1ak83UiBtm4M39nQcEoHl2xY38a23ozk4bhzBpgsvp7yebPcVjLXxyr3DcypicjCDpnakhEDeQiAfvUUn0C+6bCx8ZNDPJLaKswO+caWXb82lg8PDdGpA51M6Q8eN6CBqENjcvaHVyyPIRh16R9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei/Perf9dE9/fwJQ6StXDuEa9XDmSfR/cYRM0CPJC5Q=;
 b=NULzwMqvifFMt6x5SiYKXhcj8StIT/zMUczZSjjG5g/D/bOmqXPJjiXl541fC3cDqZjIt+i8vUfjTZdygu6LTXs3l0LkZdhRY2mqUSMtxbWupncR2tURgH3QI6RtI8+zXx8FIFIGvhmVPwbpfFXrwm51ts5Q4WwqPQCxk1ogy3aCasUezwaP6XKwgBY7QEfoJ7DB7d9zs+Zb1t9cuoMHE81rqtScg6xuYaSEO63P6ysfvgLymRbe2KOUFA2lk9Eonx8s33SNt/sHRiN1Z2BXSukm6h7jHFQDuYoZP7s2ETAbourVB3KP7omwW9Vi8M/OyR8t8TPNBEndQfS+b73XgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei/Perf9dE9/fwJQ6StXDuEa9XDmSfR/cYRM0CPJC5Q=;
 b=kPiWyhcjIQIpfcCQ2QDDPffG7Z1mvZ3z6waSFz8pm2AU0idlNmk1HvUt4GFYZf06lLFW2VUnmHky0QkcZk3X49RPuXHbYyhyHQ0CG13x8IgaG4RW+D2NztBVjEyyR5f4e0VAgYILRJk83ykI6yf7mKOeBmOYo3Ez0eYSese0BujxWKpCHjiOXB/d9dZDrn8Ofh6fUqrpPvFLF4pHUph5wYsPa+X4z8+8MR99N1FGVmvq4dVJWEl0c/2PfKR8Y714fj1aGeyUjlrJsGMLSj+RjW/OQZiQ5iSsWBX1yqizmCU7r/zNNPngEQxChu4oqW+BPtHUTX9MfqGtF9WUyoShmw==
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com (2603:1096:101:c8::12)
 by SE2PPF271E4F3E3.apcprd06.prod.outlook.com (2603:1096:108:1::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 13:59:49 +0000
Received: from SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b]) by SEZPR06MB5832.apcprd06.prod.outlook.com
 ([fe80::f98:5e32:4ccb:d07b%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 13:59:49 +0000
From: Pan Chuang <panchuang@vivo.com>
To: Vignesh Raghavendra <vigneshr@ti.com>,
	Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	dmaengine@vger.kernel.org (open list:TEXAS INSTRUMENTS DMA DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Cc: Pan Chuang <panchuang@vivo.com>
Subject: [PATCH 24/26] dmaengine: ti-edma: Remove redundant dev_err()/dev_err_probe()
Date: Thu,  9 Jul 2026 21:58:28 +0800
Message-Id: <20260709135846.97972-25-panchuang@vivo.com>
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
X-MS-TrafficTypeDiagnostic: SEZPR06MB5832:EE_|SE2PPF271E4F3E3:EE_
X-MS-Office365-Filtering-Correlation-Id: 2143ef6d-ee26-4eed-23ce-08deddc25722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|52116014|38350700014|18002099003|11063799006|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	+LwTnFMHsqi6j/p1GhBfPOsVH/AzK59zv2m+fD9ycmOtUmXxbXWKim9JpkWQkut0XoAw1Lz1lZeMhoR6HZYplT9K/iLG8KOaAweO9H725GNT03zCXSHonVR/9otvyBoQ2oHuGIhMOf3bpvXZ4gpiPKrVAxL8qQroOX0+KmfpzBa+VSh/J5aJeJPDZ82Mm4atb5b+1XNNFDtuUlrGzlJyyHIpSvjRogVyUqKQKny6s92XD1N34HgxiweCVbaE29ss09/0xb7AQBJ1vGcOp+9sCOOPCw3czplYlH2Dvv9jAWsRIrN2QLftqAQm1VUU8xxGtNwrsHmdIRK47AlTDtA0jpjFIAPYnc8CSFSkjyXJ9Iz6od3V/U+QAxlQHS/Wj/B0fTB+qEsXAXo/SXphzr8G2Iki+LP1hRGybSvKej4WONSS/3mqyKIdVlw21EC9psFCAI8Kd8NuJaSkSUo+P79nr1eDW9exrbsJL3aOlkyFkmoPVig5jxp41fVmwYIKZjPnr+lf9ShKyYbqTjjmYFn3dlsrhocroXovme3FE9b1B9hA+jOKbsTBlO8H2APryX1YrdPu2X0uH3u8yMD790dET2JuOcaBCBGmARHOp6vpMBjJ6PFrEjcFsGoprzFGNIb9zdvOBSsGKCOMBSj9jpqsq+1sSqMUZse+QSTMbHEGxvA9P/tIR+tz3+kKE8qhFdnUuOWNsS8xubuTEDk8NnKFbJLUaqUzjnjOqO2LocdIaAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5832.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(52116014)(38350700014)(18002099003)(11063799006)(56012099006)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EablpxkYS534kun2xH+ZECgcjvXGJiwZLS8HRXXlkTFPvZGykTP6Zfp+D04Y?=
 =?us-ascii?Q?SCMsr+6yy60nY37zQCYnw5n+JBbV6E6pB1ZHfE0waHOU6oDvqkvUpl25Wtqn?=
 =?us-ascii?Q?cVsRGFZR12Ey2xpdkHZpo0C7kZhxRDqx6CtuE8syDkJgPcpyUwIAtiUQNY5f?=
 =?us-ascii?Q?5bvF2RCPn8imtbGQYs164iMNjw1k3MQFJAhpHs+jpeFwP+bjKqNm3LY5YeTh?=
 =?us-ascii?Q?5iBDmHbZTHWIkx3lEN8FYdjOv8By5+X8j9J0qVH3v9f8tHNdGwYn08Wia7BU?=
 =?us-ascii?Q?foVLCVMfAleCxjJvskoLHJHf5/LxBdWmknGFUqM1zTMZm9HmWGd/RN9Dyf7H?=
 =?us-ascii?Q?Axh00bySHRGkoyk3N/kPSipLlALadWhq6ivdXDiTeDgw/hdXl4UXC4CF5IIk?=
 =?us-ascii?Q?lGgJcyZ2ilO6K5NLZrf8hwJHehOozVwWoFsqK85ZswLpktX53gcZLHwigler?=
 =?us-ascii?Q?vU6rj+ToS2y+kIz9T6IEwweBBjlyu/9gPS5GvuMNhYQjvUXzIiUg5P3am7tU?=
 =?us-ascii?Q?V1kr4dFZ3k+hfCGXsd/gkCPOzX65FyCtj6RKBBTeRfxIdTeLneirdu5a5RK9?=
 =?us-ascii?Q?KbrwPVXcfQe8X1mTPzfl97sePQ9mhhyf0zmckiB4yld+1l3twQeWgvJQt0+N?=
 =?us-ascii?Q?ivQcX27bHVVTppQspB3wz9WAzWCxATpl2kx0hjMrN4TzSbtC5JmzvWBqeRmX?=
 =?us-ascii?Q?dy1pjVti6fOY/Xn6jrpygs3qeN46aivvOmeySb0MZYYJP503OKzutYOS15WE?=
 =?us-ascii?Q?cRL+UpqiKJ7zZ4hNLAUcdQVIkDl6oZIJ0arqRxFCf67epRy7ibzpff5VxkWr?=
 =?us-ascii?Q?A99Xw0AoBFyhBV6CWSuucgHYLh7LOQ8E8vuFIXbnsQQ2ErIRu7QH0xjVpsD+?=
 =?us-ascii?Q?O3Ds3qgj3Dnzawb/Yf+Y3qsb6iOs+gz8UHa8TNvSSIManUi7F8vVlF5HhkSx?=
 =?us-ascii?Q?ztfx3NV7fEdIhbwsIyDPK5yud0eux5ixMSd9x48Jozyo2ptZq2PBtwo/5us4?=
 =?us-ascii?Q?uxlIB6F85vPVfwMAEE/RMmWA+VeoBRgFds5aLzNQ2XatWGcbbHUna6QqMJQM?=
 =?us-ascii?Q?5JfuxYGzwZ2swIjjVSR8371ZglVm9op+jM66+b4DaAOp3eCKFpYDktdrYkxG?=
 =?us-ascii?Q?kEj8KxZGPZ91SjAkPHMb8FtMP5MX/bOjYnJOQtVAaOg3BWSn5j5l4dKd3M1t?=
 =?us-ascii?Q?XE+N4nvIL1PQwz+s144wzGm9kCUrvzwbBiBUj9aDpxfjTWDUk/sPmHHwnZWY?=
 =?us-ascii?Q?tZxb03gwisRmmhCczFhDb5tyrK45ZiGTtpT3GsPxDjYz4Zk3klFNjVWhYeIC?=
 =?us-ascii?Q?vqKVRPqSF995BgG0sG/6J8cuZvCtvbWd/mmk7DHfQQ59OpFQe+nNeLWgcRkm?=
 =?us-ascii?Q?hD0/SuKyX8IVpuRdYui6gHVhv3KUG5Db5DI+hUalKr5a6Sp0A2u+ttYjBGxa?=
 =?us-ascii?Q?v9j8DyWFEp3ZpEr3WukqroJfew6y0rrLPokH0i6KYQYF2yk4+QTS8V+9/Wxn?=
 =?us-ascii?Q?JffkoM5gXcIHuWA+aVO3aGGJGuX+EyxICkfggibJu4phgpROrUXJKfvnonId?=
 =?us-ascii?Q?RVKvJwrsRqVotoySU+UI8kbk1Ip7qs6PTd8gkt8Lynf8oizN5X3f7fx9HHK1?=
 =?us-ascii?Q?eJsMwHBJi+qmgFN+222tS2W1Unb3AX4Hz34BWZZiaL/B+OQWvO8LzmU9Ct/C?=
 =?us-ascii?Q?gWObh/islOFHMITnJ3XKmeNIYEPduUWZdOFFQ5xGLfClwsogfokoz4Vnmz+w?=
 =?us-ascii?Q?LRoNUqHb2Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2143ef6d-ee26-4eed-23ce-08deddc25722
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5832.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:59:48.9886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fznNqwH8SCHYb6q/kU4pz+Md+fNjxcFAPpgw/0Fv6LyqvWUTnDXzSPKX9kB6u/wKHohsXQKDMwQPiE/D1KTBnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF271E4F3E3
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
	TAGGED_FROM(0.00)[bounces-12202-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[panchuang@vivo.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:vigneshr@ti.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:panchuang@vivo.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vivo.com:from_mime,vivo.com:email,vivo.com:mid,vivo.com:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9C05673236F

The devm_request_irq() now automatically logs detailed error messages on
failure. This eliminates the need for driver-specific dev_err() and
dev_err_probe() calls that previously printed generic messages.

Signed-off-by: Pan Chuang <panchuang@vivo.com>
---
 drivers/dma/ti/edma.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index d97db5af3555..e023ca9640de 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2415,10 +2415,8 @@ static int edma_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
 				       ecc);
-		if (ret) {
-			dev_err(dev, "CCINT (%d) failed --> %d\n", irq, ret);
+		if (ret)
 			goto err_disable_pm;
-		}
 		ecc->ccint = irq;
 	}
 
@@ -2436,10 +2434,8 @@ static int edma_probe(struct platform_device *pdev)
 
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
 				       ecc);
-		if (ret) {
-			dev_err(dev, "CCERRINT (%d) failed --> %d\n", irq, ret);
+		if (ret)
 			goto err_disable_pm;
-		}
 		ecc->ccerrint = irq;
 	}
 
-- 
2.34.1


