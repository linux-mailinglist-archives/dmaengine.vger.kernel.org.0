Return-Path: <dmaengine+bounces-10194-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AhFFr5E8mlnpQEAu9opvQ
	(envelope-from <dmaengine+bounces-10194-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 19:49:50 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0844984A9
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD9A33013FF6
	for <lists+dmaengine@lfdr.de>; Wed, 29 Apr 2026 17:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665AA3A961B;
	Wed, 29 Apr 2026 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="n3OXKl+4"
X-Original-To: dmaengine@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9833F390;
	Wed, 29 Apr 2026 17:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777484970; cv=fail; b=kJQylwEleBbqs7ijAf+O1EsKEunMij18a6swI6mMbSLNU1oekToZ3txcAL0CvW1w05lQmtjVdS0icGg8wSx61EdRkeqDK06Zgxoo6Papt38dxaH0vtLziK9yBCaNT/9T9ofEkRT2XLSQmy/sQ5CygRGLTRpngPhDnyYUX/NTy7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777484970; c=relaxed/simple;
	bh=w+uy3N2qspJoI3xzC+UF4tC96UcMVruc4Qbb8k4qyQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J3AfDENmMin768bqKNlch3byOxauNhwdNFvdpSMU2LPkSnrwfQ0wlMoiEDGU/AVkhs5fufJnQVIWDyU7U7xphgAY1NB5wHyv+GdY1U3P/BmqxHq/N2FdRIdrdrtlBh2hSyXCI3TGr3juHk3KK67naK54m5mYUdVEzmt0bvhxlaU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=n3OXKl+4; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xqf7F/+OTrQ7uILLs8U9c2Lx/vkG/S2FNybSPqvVHKUumQSfU3GRy/UzBhDtsSqWW9NW4wGKPpmBwB6muNxfAwfKr7Vnbz09JYRQ3knbbqkWGlmqIQoPJaRUhQcannMo2gH/IdnBPPtblMY3ddG5M50j7ZsM5D4aMc9vZFPDRs5RV4WXARo0GxKhYPM+l0FxWPcNlz6dXYXxLShVJZYZ6/t+NV4Y9af+KuYbfdYG6gfcijhmPIOl+Q2CxRNB6a/nYMylwBXkbQk6laUoBhxgdkxowNEza3aZpevF3aMskSuVihdII3Isy//+e5PHWxDOgSA7xHX26zJsa7f+u3SVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oeWG4bCWLga1dOI922z+/mD0YDUsTgj2a/lAPWwP7ns=;
 b=jWSkdQV0VCdnE4oxwsy5Vo2F3qh6xgoS3gC4N3pkaXnABtgap1+NVRr9dl5Y02jeIkzKl7Xf8ISsodNxruxWaitCMnePJTFsuiO7lY2GE0IBeKUYVvR2TiH5StM99Kw5IeiZEG6SGgb9wdoB5lD4a8yY7U3lYd3PQW/c4If2QnhklHPr4YnJdCYCW0rQN+tEESWfNerkmR0eqodkg+yHmIJaSkUqe9WyRG/lZNSxYMXoh9v4+hQijuV4ruoQeREx3ROu/O0GcbmZ2s8bPqEFjc3TiDFVomT233rebVlwsik3/YJ7t0QURMJ6psuF+E/1xdQHf9VWYI2BBwgvfxPEkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oeWG4bCWLga1dOI922z+/mD0YDUsTgj2a/lAPWwP7ns=;
 b=n3OXKl+4A36OugLsNDNfchT0d077vQYDqsalzvvyfklAyb4crsLSm7L1x35tl9vWnmux16bm/15h8eUc1/n8vLwAD5aeNjBWZC19e6gebzpBWQbzuz8Y8KM5Q9o+3sfY2FuzjzTPWWBzfe1494a4l53ULvKr6oqbOszOwZVCkcU=
Received: from BN9PR03CA0261.namprd03.prod.outlook.com (2603:10b6:408:ff::26)
 by SA2PR10MB4588.namprd10.prod.outlook.com (2603:10b6:806:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Wed, 29 Apr
 2026 17:49:25 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::53) by BN9PR03CA0261.outlook.office365.com
 (2603:10b6:408:ff::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 17:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 17:49:23 +0000
Received: from DFLE214.ent.ti.com (10.64.6.72) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 12:49:17 -0500
Received: from DFLE206.ent.ti.com (10.64.6.64) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 12:49:16 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 12:49:16 -0500
Received: from uda1253387.dhcp.ti.com (uda1253387.dhcp.ti.com [172.24.233.12])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 63THnDDF3822334;
	Wed, 29 Apr 2026 12:49:13 -0500
From: Rahul Sharma <r-sharma3@ti.com>
To: <peter.ujfalusi@gmail.com>, <vkoul@kernel.org>, <Frank.Li@kernel.org>,
	<nm@ti.com>, <kristo@kernel.org>, <ssantosh@kernel.org>, <tglx@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <dmaengine@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] Add runtime PM support to K3 UDMA and K3 INTA
Date: Wed, 29 Apr 2026 23:19:02 +0530
Message-ID: <20260429174904.4049243-1-r-sharma3@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|SA2PR10MB4588:EE_
X-MS-Office365-Filtering-Correlation-Id: fba7e621-f23b-41fe-5170-08dea617a656
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	D4RjQgqPWfNMjWikCZ7sTb4kJd6EOp/FA+bD3zCy+VpF8/p/n+Ze9zHDEAiemqDOVsom1bd7Qg8l9zN29TXvn931kznrM1LJc816hjuuTNm0lOsS2Sy4MIXRoLN/otYjfayTidnKQtvSqca4WAYa7BWdSAg1vEfXgsYP6QieMNfIH+WwUJnXyWrztaK3Q+pMao4IVsA2ZXQW4BJo2784MAg+kYqmOcdesBbNMkIgg+UOZUQhmVFj/dkW7rPpjonQPu1XUEQhn0OEBWBamCfITAyUAFPhLVOo4YtQbJ4e8rtgi8+eKz6Nj+S8VXqPzbIt1r0jdDovaLhblZz00z/96w9J6L+hW5+3/a0esvMluubu+5YNeVoB/xay7J4KdYkcvtyddIm8Qr6jRP9fewmhZ6bc2UdVDEh2jawBayYffjwekkA/Mz7u0PGvSZ8mMJW/i+kZBu8w6Kt8qICcl5E0cD7XVo6wxORkN6huaEPGZOC2ZgEdmw4irZnYg+EMir4V0Jag2U9ZD9xfZRakzNhZubI8RMEwPFm+5CXVA2U30nkbIJpbo3gVvNzV6AAvSBkYs+4xBfQv5OIMuypP5kRi99fOLXZlNFKWjyom+tr6zisG2qOvFVN99MiSOMdRxJ73o5XtZEIWILrZr62/voq0OkFNdv1Lka1wTKta1U66SE+CI7gOCzA0kB0L6n7Fd7dMBBjXxkv0aRc8qHdD5onXtPY07mVmZOl1UPIbueI7PUPk0d+RxcEmBtKhBN/x1B3Y+fpugTwOoqHdcZpdRZOpGA==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	yWAbQgUDLUOMPwK7oz8TVt4O2cVfwSXxQrFyzGqdiY5JQwq5l2dlu6RnMBsKJhCyjfHrd1JrxvkC4gsVzRC7FTZ1OlujxVQZh/E3aHfkc+QvkEAStybKfub1fIQYUTwIKT5QLW2w8rA/Mfp7IjkPQMWCvTJcZ/iH5EgjyOynQ2PeNSrAj2L5K1GVRAxELA1Sx9/kWm3nHqgDB7AIzia5+TXqLw9OGZtV2T9nfylVf3E1DTAM3O8K7aj9nEvGWmsPpTLyAz+kVlq3P0DstdaoDMAnZMMU8yGq38riAULljnFf4B/OpkzO4LiyMs0o2OTnvhyt4GdjjyQ0eMMXXpK78uCT+JYRxnW+JXthitD5MuwajQPqyNtnum1yG0qckohBG6rFSSqekJWPyPakRTglonwO+681+YU6wO9kKNIC7dS1Snmvf0I6SYgBWGEclfGl
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 17:49:23.7149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fba7e621-f23b-41fe-5170-08dea617a656
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4588
X-Rspamd-Queue-Id: 4E0844984A9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10194-lists,dmaengine=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,ti.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[r-sharma3@ti.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[10]

This series adds runtime PM support to the TI K3 UDMA DMA engine driver
and the TI SCI Interrupt Aggregator (INTA) irqchip driver on K3 SoCs.

Runtime PM callbacks are registered via SET_RUNTIME_PM_OPS and enabled
in probe via devm_pm_runtime_enable(). System sleep is handled by
delegating to pm_runtime_force_suspend/resume as late/early sleep ops,
keeping the PM runtime state machine consistent across system sleep
transitions and ensuring correct sequencing with power domain restoration
by genpd.

Rahul Sharma (2):
  dma: ti: k3-udma: enable runtime PM support
  irqchip: ti-sci-inta: add runtime PM and system sleep support

 drivers/dma/ti/k3-udma.c          | 46 ++++++++++++++++++++++-------
 drivers/irqchip/irq-ti-sci-inta.c | 49 +++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 10 deletions(-)

-- 
2.34.1


