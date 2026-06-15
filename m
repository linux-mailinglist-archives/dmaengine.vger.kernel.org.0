Return-Path: <dmaengine+bounces-11541-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nXPEASxFMGqBQgUAu9opvQ
	(envelope-from <dmaengine+bounces-11541-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:32:12 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8A36892E3
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 20:32:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=VNVCVIE7;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11541-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="dmaengine+bounces-11541-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23EA9301E7CD
	for <lists+dmaengine@lfdr.de>; Mon, 15 Jun 2026 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398BB34CFAE;
	Mon, 15 Jun 2026 18:32:09 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013031.outbound.protection.outlook.com [40.107.162.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1710358D37;
	Mon, 15 Jun 2026 18:32:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548329; cv=fail; b=etsjs/ZVu3wpRuWOtcQPLiaN+wu6Mpyq60QWYY4GAI+t9BBkaMa0ZpNtlFajme7S1zD6ATfWU2KHxRBRshKOT0vJDWtSvbNLCkowiVVqYi0nby5T6CRFGP3ph087kib8M1gr23Xch01AsA30ueuOP6XHk+/FPjSUsyFu3wC/2v0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548329; c=relaxed/simple;
	bh=EPzIdL2JxVfOr70H7LQ4gt/FUO0gBwnibSdIbheP8tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cXC5gnFeEpGyg+N4TLUz/F8v2lDnXJBWKxB4iDEdxOVvakQCvDe3sSoPyXk723bFnH8hbQs73mdKd8MTRufFEPK1/CLymQcpikgRIBFfshSRBbZfOd7gEIO+NC5IBF9/QwpQw1qAfiAdvGmd6v8ZqxcjjVo4FLbZBo67LV5RVyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=VNVCVIE7; arc=fail smtp.client-ip=40.107.162.31
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJeQ86P7K6gHvKSFATz2VnIHAyrxaR0EdqIs3Su7UYZLkWRrBbQCBGQn9g5pd9Qyz0AAf17+iHSsRl10YJRpbiDYfblfQ5wIDarLJbHBeqaj9rDkDYZiFUNwK0vhzjBQZJgAnmSnIjLKpZweBL4Vdo+e6e7elGuCd8GvLwyIetAOzKjZJ+uEfYWBXAVqQbQNI99JQjC7TNCyLJGLKjcEZdmjAjyjsLgflOIUhJaWx8cgf/+DZ0JWhzcOp0pd0cEO8HQnN+knNmC3aWG/l9SA31/B1/mZNMh94Mu5r6CxC+cDPZ3pEAVHTNAhZZJRyA6QD4+i+h3+NgZEbygHKNWP5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hprtYBVPIjLwB/lIzeQm1IxI0XxzFqbWZnr5xXUNs/w=;
 b=AgOgk0EcQ2xqRo9xTZflX4JvFa2dsAHCPqoWz73uY9gGB15wwSLEB7eauA2j7AGpdrH+1K0hDoFWvfYdIyRfVVY0cG1mmNa7YsKcJ38R9Y5jr7dKWAdrU6PZKz4VfrU77OLcVlWA8J5I4o60Oh2rkOces9nE/M9psT0tE2t+gC0GoPeThSLic7cV3wj7IrHpNKPJ5YJkUUppTqP0Gkt9q1rYIlC/WdfGndG9qqX8RL8ukUrpuuFsOSaTMfoYZXR8UslgYdBGIMumCRs6y6zSa4RauSywurvUpUP3VgnhCk/gibMIA6sWym69xiGl2K7QQ7r3A0U3auQA8I3MkB/Fog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hprtYBVPIjLwB/lIzeQm1IxI0XxzFqbWZnr5xXUNs/w=;
 b=VNVCVIE7rENtDLWgNPTSvzReE7f5bTePVrFD6x5P6hdZyXggan5ftYTWhuvaz0nIBgJj4KcRgiB3NBDRe4mIvEhOXOUWU0HztE7afguAORrb2As/oAQ0usSmMEJMuyQl0m7i2gmVFnaJzgVmZl5VIm4ICRuMFw7xipZC/fFvF0lQLhi/nVeyzQSp2fxaSvRryCke7ekKvkJowiK34mq4stu6FmuKFVOUXgaRs6NNKAQ79KXkc+Dv1s96OhsMDD3azo5FvJ7DdG66Sn0BcUGRUoVHsrXH2oyzatReP2Z5ldn79J0u0Jp/Fg7CcM/EFd+rSkR549W/V2X99aHmDhLpdg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PA1PR04MB11508.eurprd04.prod.outlook.com (2603:10a6:102:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 18:32:04 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 18:32:04 +0000
Date: Mon, 15 Jun 2026 13:31:53 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	Kees Cook <kees@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Serge Semin <fancer.lancer@gmail.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Niklas Cassel <cassel@kernel.org>,
	Devendra K Verma <devendra.verma@amd.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/17] dmaengine: dw-edma: Fix HDMA channel status
 register access
Message-ID: <ajBFGaF1TcQzhLkb@SMW015318>
References: <20260615154111.2174161-1-den@valinux.co.jp>
 <20260615154111.2174161-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615154111.2174161-3-den@valinux.co.jp>
X-ClientProxiedBy: SA1P222CA0089.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:35e::19) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PA1PR04MB11508:EE_
X-MS-Office365-Filtering-Correlation-Id: 18982be4-5d33-41ad-6d8a-08decb0c659b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|7416014|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	X4wRJYBz8UyYrlLCXiZ9LKQVSTG8tzmA4bIKRZB6hA1+EJU5nf2jMoGZSwkPz3VWLai0/RG44f9i5noLqsReNEsLic8d5CYIBauwFX8xPRMMjrXtDCzCrAKVHtvEsHBSQ3//F5R0wQ1lRJZrelcJC7/rVIFiT2IMyvY7UVq+KSfHxsM8SYqbUncJ7bvz2qjYSSfCDz46i1nxDtoi2cuwTFRlJDzsDMh0vgaMQDEeJXnIwIUPpSL5c/EyHb2yU4GlPeAhUgEkVPIPxV4LhCgzBj+jtDH7mjhU0dL+mUb5c7bwOW2FKWmEHreT7i4kCip9KMsSQP6ve3WyiLslvIQDkYaxuI5e00vGIpLEFXnhnlKOmeA7v+Bnycw4D3SfK5jyW+IHvHGJI5askipqvRGPGB+LRqluxLdYF8/52208nn0VbxlmMfMiNOfiZ5WwulQuXZ+LC5gc+DX1CVWGeX1TY0SdTbiLVH3w3wCeZ4a9IGjkz1yZCLxt1I1pBAX8vBtDnmVMahcW4ALiBGLusTqmDW1fyLl4FM4aTyP8zJsdbVO9cmJopWsgrWpZP/JxdMGfPlM/AamxNT3WPduYt5CS7aUV3cpBeM101G1bEFniFTz7MpOaS1hWDsafTBfdo8hSH0rpis9iy9KBoYA6Slb+YiCYH4kIATIx0crKDITk/PaBwDbrDTvoFu3ORnm8TxN1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9y08VNBIGYRS5zn9+Od967x3in2SMhyjRhfUfDeK+YE45kc40Ss5bzYhJPIh?=
 =?us-ascii?Q?kjH6oXq8kLkTC9w203AqYI9aDuY8d/wb3ow3aEKQS6OK3FdOQaHfX70/BZiz?=
 =?us-ascii?Q?oSsLtuvRuzvcQiQsARpr4CkJ+jFa12Rxb8D2IT4Sb+Vc8E3+ug8KLRXun8UT?=
 =?us-ascii?Q?/K/fu+lvESt4lvSVunWH+w1j4sZkZL1k1SINC/Q57P3/wWuvz+kdrQRB4bgd?=
 =?us-ascii?Q?Mdb70/yYSCRPL5irgIpthThEsMNoAwFhFwGrrNcZqlU5bB+q3DGyy0B+0vMX?=
 =?us-ascii?Q?4WiC1rxCNrOcB8QMITn41gmP8nYyQBdW48yXov6nXLFSAU15PMAqAipeaNJm?=
 =?us-ascii?Q?bskk04ok7jFZQX6XzbcPcyueKyq7Cc1UhcH2Apn/OVH7EErkbg5Oc+zio8Xs?=
 =?us-ascii?Q?xSQWfPpCiZnmh8Fx+NuTxB7i2Layp3AO3PeNp7wfvnj1V1q/vhfchtDFQLSc?=
 =?us-ascii?Q?Vk2hl7taOQyGrppdaF3PZ5jbeKeU7ooA1IbCVru7yYyuUirUkabwfmCOllcI?=
 =?us-ascii?Q?trSlTbg/yX16tQZ4CajKQkR/lznwBBIgYWQpwkgnD2VLTTX0jHDOWR9v1tvz?=
 =?us-ascii?Q?mpAP8OPeOJ9eazfuw46fj1mM/2EAc1tteZyMKclleDmoYhYH9DoZVYVYf2KF?=
 =?us-ascii?Q?VgAbBHiV2yZiUyVgAmfndzbx436sRMzA4DZ0zbxbZNDImpKvPyoKSIgufAtZ?=
 =?us-ascii?Q?AK6rX7zutypKhPUDCJxdd0Se78xQXLQ7KHaw9i/baMVLjD62m+WEK6BsmHJI?=
 =?us-ascii?Q?ncOYTGb9A1ZUu3ifp0DhF4+UydW2SlnVy/KkCt0AvUiGpld3JPY10avEbUQ1?=
 =?us-ascii?Q?e9SfqOSPim6nSngVzPETlarvcP5MyYYi3NSWqqeH6rRKLo93SkIQ8aEkraDz?=
 =?us-ascii?Q?/+t82OPtkDh0kHsPucTytdih6n2A5lS7+q1QSj+kQ8YcBbTYBjxh71GqLvzU?=
 =?us-ascii?Q?ZDuGyu+XDT/MGb7bjWiHPwBnkZMIe/fev5uqLgMP+oM44r2vO/jXKkS6G2LV?=
 =?us-ascii?Q?EoJl8ud9ikngUnlYRX79DlubZYWZ6yHaMUQNFoj1v2qOSF5FUD5XLK5+oKhw?=
 =?us-ascii?Q?FsbblBDeJOPX5iYXFbQSYnhlsgrOO5YIRjBKsWCBFtQzpXHnuZ4+PAnoPXG+?=
 =?us-ascii?Q?fdwnmpEifkhP1NUkJkLG5Gn+/V4l0Kimn3yp+C/O8Qgvh75nwRv8z7khrg7N?=
 =?us-ascii?Q?djvXH055PZ5e0iFWx1pq3gmD/+tkABibg+pZQ258o6I46CASwR/aDv9RKfBT?=
 =?us-ascii?Q?kc5piBE9713e0SpOksE1TAah0k6idRWPjhFJiWZR05HwTPcY4LEo9QZX9ijd?=
 =?us-ascii?Q?NVx/hCeEAyTi/xf/syZHvL3WlhXCS0xbmtiEjyl4BRRKSPw3xxk7SjMnSFLg?=
 =?us-ascii?Q?ASsMgIfD5VGC8FkzdYjSFEZLJzufuJL6pwodNQqS5GxWX7GUJDV3ZDEJLGPj?=
 =?us-ascii?Q?4mxI2nRgXiFYhCRF/BaIJlWycMc+jUuU0kbPxlQzM4fYDXhkxtZY+7aoeN+N?=
 =?us-ascii?Q?5N62h0dnXrwOAI8hItPg7EH5RF97Sckv3kANQgWMQjlicMas2nygxjtGxhlD?=
 =?us-ascii?Q?NVDH7uelsDhHpovFuH5OEQZVVQ9tA3ELJ66JGJRJwp+WE3OZebnoCaUoFwqd?=
 =?us-ascii?Q?C5ZPxF21DrqSt8+LuCBKIVtKNzkIPv/N2BHIYeKnnvjv4As6WBC7OB8eqAwZ?=
 =?us-ascii?Q?LyrO9d3o+3WW4NU1+FmoRVv+mJgacTzgBEVHrLXriDURsYVN7OoI63nINfVY?=
 =?us-ascii?Q?mnlZK1J948sYx4iBsShmJ0bELqLlcAclOtQ+9VgkaJheixmxqmfy?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18982be4-5d33-41ad-6d8a-08decb0c659b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 18:32:04.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUaJzUygowFgzL6h6gwoa4pRp7UA+zSQ/xLQixdDzyV1kHSt1DAnqrzXz4nmFVfZzYfCVK+Lklr9FeTggZnlqOpXEvluT6St7GryDK+Qn80ePyRVMpD/J9twQ9v5GmM9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11508
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11541-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:Gustavo.Pimentel@synopsys.com,m:kees@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:hch@lst.de,m:fancer.lancer@gmail.com,m:cai.huoqing@linux.dev,m:cassel@kernel.org,m:devendra.verma@amd.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:fancerlancer@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,synopsys.com,google.com,lst.de,gmail.com,linux.dev,amd.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nxp.com:email,SMW015318:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6D8A36892E3

On Tue, Jun 16, 2026 at 12:40:56AM +0900, Koichiro Den wrote:
> GET_CH_32() takes the direction before the channel ID, but
> dw_hdma_v0_core_ch_status() passed them in the opposite order. This can
> make the status callback read another HDMA channel status register.
>
> Use the same argument order as the other HDMA register accesses.
>
> Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Given Devendra's comment on
> a28adc76-044b-4666-bda0-d7f9a8d52a63@amd.com,
> I expect he will soon submit a very similar patch. If so, please prefer
> his patch over this one if it works. I included this fix here since the
> rest of this series makes this pre-existing bug easier to hit.

I provide review-by here, so vnod can be free pick any one.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
>  drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> index 7f9fe3a6edd9..862375c8e4ba 100644
> --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> @@ -79,7 +79,7 @@ static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)
>  	u32 tmp;
>
>  	tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> -			GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> +			GET_CH_32(dw, chan->dir, chan->id, ch_stat));
>
>  	if (tmp == 1)
>  		return DMA_IN_PROGRESS;
> --
> 2.51.0
>

