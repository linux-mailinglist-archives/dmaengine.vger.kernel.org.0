Return-Path: <dmaengine+bounces-10412-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDUKCQRgBGpxHgIAu9opvQ
	(envelope-from <dmaengine+bounces-10412-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:27:00 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CBE53237E
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 13:26:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B724B313493B
	for <lists+dmaengine@lfdr.de>; Wed, 13 May 2026 11:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9503A6B74;
	Wed, 13 May 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lR5GakIk"
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012015.outbound.protection.outlook.com [52.101.66.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB8F3F9F56;
	Wed, 13 May 2026 11:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778671347; cv=fail; b=W/c4Aid8/e8VsOlz8NLAI3gGQxmyjSMW7BpN0gZy5adsFdiPoi8Wk8l8DIYKm35e4w3cBLI7mLrsEcO6Dw6hng4y2Xbn9rPNslFISmVcBoLU5KrKAaNzzSptoCumgtyMXQdIlSQC6dRzHV6DSdm+zSU21vrl7HVvhs/a7GrLnmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778671347; c=relaxed/simple;
	bh=PxTPufOt2A07YJaOWfvD1aFqQ0V02DJDbodtkwCtzEw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=pIfY4VJujC8/XP9pdU7+Hl4pX2x7OdH7Hhr0kWnLXI2EQV8hWNITohbnqMYEWjVImXiTlb+5saEvFDZlGhuQCcqWpw31dhWdzJvuAm6CTQ/omGLwbzAGpgi7/vbP6owb19EnpqfumC8grfU0K2J53s1OzNF5QR+gfQvYH3yGMRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lR5GakIk; arc=fail smtp.client-ip=52.101.66.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGjvBmYLVGHyeYcUSxseUTy1sQfz6cNc4qv20/UWphIExBs7Rw5gjIUk31bA6hevD57taUFQcBQlhBdftRCOVbJXtc/Id4attQIc7tviMF2pQNs1viIT96WQxyIlzTqImA/2c/RWIN9YU3Z4cmBeDFdWxYq+6QHVvNCk09g92UH+oRXD358kEoRDCcDuDRVf9X+t4G2npovFjenpI6DL5h0hZ71latrOYuLoXb6zWR9oVXasmlV46XGqdKS/yT64hqxtDS0RvGQH+pj0GxAVvoLBWGtHrXKnOGpS501HH+B4R6VvjXwQZqRi2GOdkG6TG6IRaBXjrlHa3+6RZIcmog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+97sjOmwO+yjD+1hN4P2jFkuJHy5ZZ2JDAB3u8qFsj0=;
 b=fgPP3xRxjdTBwQm9XIH2nfkPqV/y3KajLA0GStMQ2mEZGCzwpraLjeUwXbX2tAx2LNgU97x2Ead7NCK9fFG0As0uGKIjMjobMyRtiUyDCOlc3i+E4+Xg3yONTUZoqExgmiCLtcXuT52gskNTQpNmt6Qvd5CyTCP1gN3BRCPNPguBHADhZK8N0OLQE3LjX79ewCealsIM28DqJcIXi/LsR7kXfptVixUSUB4tcsjoX8g42Rc7ftjLTrPxpnwmucBfWUdRDUsgv7Gizy4ymgSVsyB1bYj+IiVAb9KbG6IhM9GP1n8/vXt1UBFF7eHpeGEz5FeDydL6m8188apDABgVmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+97sjOmwO+yjD+1hN4P2jFkuJHy5ZZ2JDAB3u8qFsj0=;
 b=lR5GakIkvgls8cn5AQ72ysbOl+a3yipVZzovVYkdtXKDD9DmEfJgNdSWzVcyvkDFjurc4Xiv8UN0sEqH6WQn4WPE/EIHu4wJrOz/YvrGgdy8ISxxvHLPMmCXWz75jF+RWAi/BlWVTet3zX8LjZ+nF9PFcWAPB0VeFOH6Evd18Sh5LroCgeQqMER1yEnQuVk7H5K/wsaPtqXB52E6YZZUx/frzgOLHA8uNNOaoZ1VigawINg9QfwtSRxnmkEVaGA4xivwzDYtC0J5lsH3FvINIX51bEN9NqjDi7QP9HNhy8EpyKkLhbY7LX0eMUdY4V78ntYgZMVYfkmctBJ55xHLbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
 by VI1PR04MB6797.eurprd04.prod.outlook.com (2603:10a6:803:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 11:22:09 +0000
Received: from AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69]) by AM6PR04MB5765.eurprd04.prod.outlook.com
 ([fe80::bc76:f507:9b83:9d69%5]) with mapi id 15.20.9891.021; Wed, 13 May 2026
 11:22:09 +0000
From: Joy Zou <joy.zou@nxp.com>
Date: Wed, 13 May 2026 19:23:49 +0800
Subject: [PATCH v5 3/4] dmaengine: fsl-edma: convert DMAMUX clock handling
 to bulk clock API
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-b4-b4-edma-runtime-opt-v5-3-1e595bfb8423@nxp.com>
References: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
In-Reply-To: <20260513-b4-b4-edma-runtime-opt-v5-0-1e595bfb8423@nxp.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, imx@lists.linux.dev, 
 dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joy Zou <joy.zou@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::15)
 To AM6PR04MB5765.eurprd04.prod.outlook.com (2603:10a6:20b:ae::26)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5765:EE_|VI1PR04MB6797:EE_
X-MS-Office365-Filtering-Correlation-Id: 590fb3ce-f9d8-4a02-3e4a-08deb0e1df5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|52116014|38350700014|11063799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	doyyGObzpUuvJnIivMOVEFqCmF3ujrvZhCkSKPYUvCyIB4LPx6QGpPf9bJlRyNzpnAF3fYArYv9DWie+xXDlCvczTz93ZRjrN1pjvw7tnQ/NCSEZq3WasOy2rXvDbzNkQLIdRrBUQR8c9TyEvavevozDUUQer5bFRtzBiqO7C4bqKzjrSxBAfYpSUX3d0H9XihGeSw7NMBTcH5PV4j/Vqfr8XXcRRBa5qEpF5TwAEHYfGGjbr2Gw7sfj1ypqJIR3iqoNJyLS4oH23S5DFpvIjIWYxwa2m8KKu+MRdbsgY2keEEY1EHVmXvUVCGcyTyq8vJbN5pLZ/lNGYaVUK0uxFL9t1vtxa2QHye+oY7N3qm9QXT1ReOLc4KFOadP2m6lcZU/4ULXW9XlLiHWs9BWBE/hiEYtF5RN3n+6+LUc0wG38QEUUWuSxUCZLmrdOtVUXFSClL6Zpzm2Y7icmh9V2ijXrhzYIML6CKPZagtac+6KjYxweDwz5YxYb/J4EnfMZsJMOQSVay1xAdvaxCGKu5Naqq+wqToEyiB/YD3GGfs5M4gPWpXd+/v7WGBiHYgLPx0eA6M/+gpSkfh9ITHn632OjpcSOj9erEoEPVDdE8aGQNsbZAuzAJ+vLCcYVEIb1xLK+nMUcfNVIUxAG22bLaQiqx7paX94NJf+RtATOa18u2zQWhU3tioBS4/WgSfG0vCWDoKm5Bqy4W4D/h7NI0VbEtzbkTAnLckiaR3QRDLbuIjTJAjnwu8Iml27/XbZy
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5765.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(52116014)(38350700014)(11063799003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3pHaXV0QWNZZk5xdVRCa1JxZTN5NmxlZERwY2ZvMWlBMFV3eWY2NTlwbVJ3?=
 =?utf-8?B?RjQyZGp0NTVob0JWOEJQeTl2bXIrMDh6V1UyREpNczkwWENDUlVlWmY4U0hu?=
 =?utf-8?B?d1EwRVh3dXB3dUdzUlBMU1ZPeTY3ajlITEJmWFFUTTlBWUhkY3RPN3ROcGN2?=
 =?utf-8?B?UXd0VDA4ajYvTEtCUkFkczZuK2VNdG1uYlg3dWtUbzBrWElqdGtpdEU0b29J?=
 =?utf-8?B?bVpWM25OVTE1bEtXdjZCNngwSThrM1MyakNLUjg1b0pMOHc5U2dhRkFnRGVu?=
 =?utf-8?B?L1h2Q2hQZUZuMkVYcTkwZFdIWG50WEhaS0cra24rL1Q0dUNDVFpMWnhoT3Js?=
 =?utf-8?B?bjdMWStFbGgyL2dYRjFZWmRFRmx3SUxPQWlvTHIvNXlzTXhsTzk4QXVJVE1k?=
 =?utf-8?B?ZGJ4ZERwK0tDdnk5OVJuczduZ1ZFY0VhbTFmSWVKbHNubTNjUjdhbHpOWG43?=
 =?utf-8?B?ZWFiOGIwWE5rVlltYWVpNk5wdFl2ZjM2Z1JQWmVWM25SYW9pTkI1OUFidlI2?=
 =?utf-8?B?eWJYUEF3V1pia0VRUEF4VUZ0R3VVS2cwMm9pNmtCU3BvMlN2YmZMT0xjYnhp?=
 =?utf-8?B?UUt5MEFnUUVLU3dDZnd5U2NWWEJJNWNoMHA4R3IyQ0dvUW9sRzVUVzJzNjNG?=
 =?utf-8?B?QWhLa1hldWdmNGNsMVl1RFBFTzBKSXRNQmlua1MyK0oxVzZJSHEwQjdlOGpJ?=
 =?utf-8?B?c0RxOU8yaHhVVkZzMkxoQXlFV3ZyRXlxQk5JS3JzSlJyVDNySHo1MEJWU3dW?=
 =?utf-8?B?SWhWT0xHbVFHWlV4REtJY1VwYjRueWZLUW1vcEJQbEErTkhIRmR0Y3MrQlA2?=
 =?utf-8?B?RkNOcDFOMXloaHFkVnNZdEx6SzBYZWRYQWU4MHVsbG95aVB3eXo3T3orU09V?=
 =?utf-8?B?bHFsOGVRN3JsRXBUYmo4RU5ubFRoMWRjYzgwcTErSGZaTHRWMENkcERUZkpu?=
 =?utf-8?B?dFFxZk5BV01Ec215amdRVnNNdXBpYUVYNFhQM0dubEVTNHhWRE5PdTNSZVcy?=
 =?utf-8?B?TWZ6cnU5WVFRajk0TDdWR1JTRzV0QnNOOE1mQkt5bTVQZysrTnl2TFk0Q2hX?=
 =?utf-8?B?MlZxYTdsMXFYREFtMHhaSHNVRmRvUUlpY3JVMlJDakF2UEI1TWlMRk0xWVJ1?=
 =?utf-8?B?ZTBVbzB3dG43MHRjNzJ4RkFRTSt1WlFvR3FJQTQ1N29WRlk5ZjQzQjF1bThL?=
 =?utf-8?B?WXhMU2lYRGhraWZSVkN6NFc0QjNLTnA1VFpaNklqNW9taitqS1pKRlMxUVcr?=
 =?utf-8?B?RGpkZzdhUmtWUkdRMUtkYUNVRmNEbjIrQWZzZUZKQ2E4bkRQakcrTjRMWGVN?=
 =?utf-8?B?ZjhRVm8rRldvczMrczV0SEE4YjNjN1R2TVkwMHFucHloK2M2OHNkN3pxMU82?=
 =?utf-8?B?bWVpOUsrMmdabXVlZUw0R2lVVDByTVRhYXpsdnFVYzd3OFdjdWlnYjFEY0RZ?=
 =?utf-8?B?T3JRWFljWGQrdzRXWDdHS0lBUjNZYlpJZ1B2OUxTUWY2U3ZJNW1vNWxGOHdD?=
 =?utf-8?B?UUJFU0dPc3l5WUExMm12Yng2RjNCYTMxcjBNRTRncS9GN09sTnV1RjlzTUVM?=
 =?utf-8?B?clJmclM2TEhQNEphZ2FDZWEzeVNvc0VBSE1Rd2Z0aFc0TEdoUkw0YlNtZzFs?=
 =?utf-8?B?Z1lTdWF2WGpwMlN5bjFMazVDTDZXQ2ZaUjRjckpVRFlKNnJIYnU1YkZkRVBn?=
 =?utf-8?B?T1FuRkNSZDZNcTVaT0lqaHZzaVVROC9GNktFZlFJVU9ua1dkdnFITEVEaEgw?=
 =?utf-8?B?MXZ1dXRuYk9pcVR2TUpZZitDUWhqNjNHRlp6VEJaRG0zQjZBbGxDMGdYZ0s3?=
 =?utf-8?B?R2ozbVFsQ3VvNGpvQm1FQzczMXdyZ1JaS1laVm4vSWdzNDc4V0EyVyt6aXZR?=
 =?utf-8?B?TWZzWElnZWk5MnpDRDRlM3MrQVpUakV3S2p2dHRCRWpxQTE0TVpYZU5SVTI5?=
 =?utf-8?B?cDlDc3VJL3VpRGY3K1hXNVR3TFRYMU9MdXpWUFJkWEdhTExVcG9IU2U1R0hI?=
 =?utf-8?B?QXA1UytsUU9TSWljTkw0bS9qbTAwa3A0dkM2QTBEbDM2SnJtYUhmenRoWUQ3?=
 =?utf-8?B?dkx4NlZYV1JDZW1xc2hMOXkvWEdMT1VhNkhnUUFjVDNFcUkzc2JybGh3RVpm?=
 =?utf-8?B?VWNqRDBxU29DaFNPMXRQQURWZy8xbVB6dTFlM3MxVmxtOTF4VkVWSjl3ODBB?=
 =?utf-8?B?eXpGZWxuYnJUbmVWejFzQ0loNWdic2F2UHFqN1lLVUpkcnFtRjJETmo1MmRo?=
 =?utf-8?B?RHRFYzJ4dk52NVdJSlBkTFl3L1RhN2c0OEhRcnU1RnVCY1hkTE5RcWdzMnFL?=
 =?utf-8?Q?q2acFRmQKX99GkGY3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590fb3ce-f9d8-4a02-3e4a-08deb0e1df5f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5765.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 11:22:09.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: het0uHdoSkbE0+8Yu6u61NpLvGhK6qhAL2HIXtAZhYGu0uelBHilL4gQyuChIyhG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6797
X-Rspamd-Queue-Id: 95CBE53237E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10412-lists,dmaengine=lfdr.de];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joy.zou@nxp.com,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim]
X-Rspamd-Action: no action

Convert the DMAMUX clock management from individual clock operations
to the bulk clock API to simplify the code.

Prepare to add edma engine runtime pm support.

Signed-off-by: Joy Zou <joy.zou@nxp.com>
---
 drivers/dma/fsl-edma-common.h |  2 +-
 drivers/dma/fsl-edma-main.c   | 43 ++++++++++++++++++++-----------------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
index 54128b3f45cb399e1c11d9f86d64adce5c65c102..824b7dd2b52618b826154e55fb96a82c27e846ee 100644
--- a/drivers/dma/fsl-edma-common.h
+++ b/drivers/dma/fsl-edma-common.h
@@ -253,7 +253,7 @@ struct fsl_edma_engine {
 	struct dma_device	dma_dev;
 	void __iomem		*membase;
 	void __iomem		*muxbase[DMAMUX_NR];
-	struct clk		*muxclk[DMAMUX_NR];
+	struct clk_bulk_data    *muxclk;
 	struct clk		*dmaclk;
 	struct mutex		fsl_edma_mutex;
 	const struct fsl_edma_drvdata *drvdata;
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index ecd14967bfbc07d373a74790e87f9aa36b60e6c9..c12126ea6552d51b773bdd61c018570dbd618602 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -526,14 +526,6 @@ static void fsl_edma_irq_exit(
 	}
 }
 
-static void fsl_disable_clocks(struct fsl_edma_engine *fsl_edma, int nr_clocks)
-{
-	int i;
-
-	for (i = 0; i < nr_clocks; i++)
-		clk_disable_unprepare(fsl_edma->muxclk[i]);
-}
-
 static struct fsl_edma_drvdata vf610_data = {
 	.dmamuxs = DMAMUX_NR,
 	.flags = FSL_EDMA_DRV_WRAP_IO,
@@ -747,23 +739,28 @@ static int fsl_edma_probe(struct platform_device *pdev)
 		fsl_edma->chan_masked |= chan_mask[0];
 	}
 
-	for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
-		char clkname[32];
-
-		fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev,
-								      1 + i);
-		if (IS_ERR(fsl_edma->muxbase[i])) {
-			/* on error: disable all previously enabled clks */
-			fsl_disable_clocks(fsl_edma, i);
-			return PTR_ERR(fsl_edma->muxbase[i]);
+	if (fsl_edma->drvdata->dmamuxs) {
+		fsl_edma->muxclk = devm_kcalloc(&pdev->dev, fsl_edma->drvdata->dmamuxs,
+						sizeof(*fsl_edma->muxclk), GFP_KERNEL);
+		if (!fsl_edma->muxclk)
+			return -ENOMEM;
+
+		for (i = 0; i < fsl_edma->drvdata->dmamuxs; i++) {
+			fsl_edma->muxbase[i] = devm_platform_ioremap_resource(pdev, 1 + i);
+			if (IS_ERR(fsl_edma->muxbase[i]))
+				return PTR_ERR(fsl_edma->muxbase[i]);
+
+			fsl_edma->muxclk[i].id = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+								"dmamux%d", i);
+			if (!fsl_edma->muxclk[i].id)
+				return -ENOMEM;
 		}
 
-		sprintf(clkname, "dmamux%d", i);
-		fsl_edma->muxclk[i] = devm_clk_get_enabled(&pdev->dev, clkname);
-		if (IS_ERR(fsl_edma->muxclk[i]))
-			return dev_err_probe(&pdev->dev,
-					     PTR_ERR(fsl_edma->muxclk[i]),
-					     "Missing DMAMUX block clock.\n");
+		ret = devm_clk_bulk_get_optional_enable(&pdev->dev, fsl_edma->drvdata->dmamuxs,
+							fsl_edma->muxclk);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "Failed to enable DMAMUX block clock.\n");
 	}
 
 	fsl_edma->big_endian = of_property_read_bool(np, "big-endian");

-- 
2.37.1


