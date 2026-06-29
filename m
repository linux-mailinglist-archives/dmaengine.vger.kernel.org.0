Return-Path: <dmaengine+bounces-11867-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wS25EKqCQmpX8wkAu9opvQ
	(envelope-from <dmaengine+bounces-11867-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 16:35:22 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3B46DC1B7
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 16:35:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=XdbKjJuX;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11867-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11867-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1724130720F1
	for <lists+dmaengine@lfdr.de>; Mon, 29 Jun 2026 14:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B609738E8BA;
	Mon, 29 Jun 2026 14:21:16 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013003.outbound.protection.outlook.com [52.101.72.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4706830EF9B;
	Mon, 29 Jun 2026 14:21:15 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742876; cv=fail; b=FuaH/ueoXRQ3zN+1i5SVhI68h68DYNK75TirTcD5+McnY5Tr9fk4tm3g4Lo1DbT7S5t5/p6r4ByYLHBthg8wz7krJcTynNe0gsN4JDugbCFgtZ+kRnpNYulGItJpbGt0A+WJEeR1jls08eAI3gV9d+k/U0QWFwXRGf+zBfQbaZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742876; c=relaxed/simple;
	bh=YYMWSTnFumtXfvYPmmc2mLZVH4+FvGYlQKy6WZRuTHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qgKLM6L75Y4PrFfKIWPufFhgnnImsEMpIoc/EQEo23rf7gi1oJH+/aRMPqSoBOtNOq8zB5bANcWJV6ixhkvme8gK2iL8tlqg3M8l+6xv9W0DUcRkTQSodU+76Z9S1sqTTv+dDZTT7eaAgPIKxDNBJuaB+IUf+G+YMSBWMyWmecI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=XdbKjJuX; arc=fail smtp.client-ip=52.101.72.3
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tj4zE6GL8hv3D0+dNRH0YKMTnJx7z5+1r7YWEBfAOom1EVAW39VO4X+7hi3lEDqN3k++L/gZhIobr0hzr/rk7lmMYCq+cDmcH1G07gp4/rSj8MiInsVTWZdHwmlAPCbcUaor1vIS5kkazY5xU7/4ZBKANGnfmW7/7uOhdHlvjsWet+j3B1wgQYmem53TYCfSdK2inP6PNBquVFjLQyFkNFEFOx6F+/zpwCkH0A5lecTdww4y/kJPNmykdGcNmU8IJFDIrmoku7cNoiUPFdX52A8COFdp0NZBYg7pxzUCAC4+zKOZdP7KAznnp4EBc32KAKMYYHWbk8/F2AdazlIzIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usr7+DCW9LJclHkgepMVGJjT7Nqs4YnW3rYOaCc/0s0=;
 b=Dgxcc/Jfs/3qS4tOv0t0UJ0wbM1bM/KXMUzdBy+eqCO5rkLALTEd84KYZeV1pQ619GOOku+iwVjCJiBLOGi9uFCdqqCli1cE8fllTTIJvZSfhWcoTNFiDNSkZmNigKufGW5b3TawiumVdLvsvyjjwAAlQWf7i9xSZ0JWx6cj8hR+dSYfNYnZEEdOwyBMmpHWloBZiPceVMeXj0SI4OQPOx5O/B4XnHpt+lgZrPaRNacPb7zoKGKemofGE19HL9T4cRswLkbeP3gNlU47P3uyWdtYY9QkU0w/z80P/V2VIopwKDF0J7nQENnzdw6C/1BPhH4hbzYa9pd8jKuoRc7dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usr7+DCW9LJclHkgepMVGJjT7Nqs4YnW3rYOaCc/0s0=;
 b=XdbKjJuX22YUq1o9ribwjCLKbQYO9Bw19nK+YAdac17zoQ/9x9DtyJWJ26/1Aa52lMzzU74MQugSgtp/30ZACt0ezwOceGL5UnsBbdLew9eu3vkU+hE2l1lV1qCXuurYRieBpSO4+W0Ca9bj6oGrBQvoien2C4Klu/WiVbJDMIgU+qnnBz4nU+JY4RhHqBtH3Jq5dWy2zGBERKYWV9c7EuhsfuT+bu1wORp2gsgG9sfiUFuGDoWtxcJoBm9qfoOau/LWmL6049JsGq9cg/vcvLvVpxVOXLeycBAk8s5a8wKppo29E6zfqPl6+e/DmKfLRxM5TlVgZi14qPVjoE0oFg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DU7PR04MB11090.eurprd04.prod.outlook.com (2603:10a6:10:5b0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:21:07 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Mon, 29 Jun 2026
 14:21:06 +0000
Date: Mon, 29 Jun 2026 09:20:56 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] dmaengine: dw-edma: Implement device_synchronize()
 callback
Message-ID: <akJ_SH31xqs_AYCQ@SMW015318>
References: <20260629-mhi-ep-flush-v1-0-714e0d56e87c@oss.qualcomm.com>
 <20260629-mhi-ep-flush-v1-1-714e0d56e87c@oss.qualcomm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-mhi-ep-flush-v1-1-714e0d56e87c@oss.qualcomm.com>
X-ClientProxiedBy: SA1P222CA0062.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::13) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DU7PR04MB11090:EE_
X-MS-Office365-Filtering-Correlation-Id: e8cc90e2-75e6-4578-9bf0-08ded5e9a8a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|376014|19092799006|366016|1800799024|4143699003|18002099003|11063799006|5023799004|56012099006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	kBWbKpt+YC+BmBj74GnJLMNmBkSFfyujniTaOPUSrHyp6K0b0b0KMl4gLQR4ryaoa1f0g8rXFyEXs651DeQEymz42syZ2IhrGO0K/+oEmUcJUTn11i0+AcjdDVcRvdON86s5efnX8jpF40eXE4EcVXtCgJeTJFajwQonyJpWRQ23oZAjJtj4Tnk1b/f042ExrGHiNwnImuyUrF+4Oz/m7SaBCmS7IGqRex1NLieKG2jm9iiX648WJ2oTfnX5bxb22ws6hCpMvEGVzswkTw8rc3DHvgICuCjrR3DDWQ+NPGuljYYxpWJcBPNGGPHl/+vfpgbLPUztxKdvPGeqdtCDviHm/H5URiZ3fdqpG8bVYDbeEASQQr3do+uOyEcxiiirjOt34tWpHt8P9JNyOXIsQ3rkYLRc1poiT0FmFAz3TNL9X2Xe7K7nlFFIBNdL7ZMKLVTid51RmwwW91TIQByysTI1vCYMHk0mRH7GCphB++7C+fYZoCwkUL9QEIn55jtT+Rdw1sp1yDpNIncn+dBjz05kGUFNVRnC49G8NCmBWJbYleb+tBhX4VsUeQ6XbmhIwrBAFBEgbiFtEuoPFRHlF6MbG6uYFM/OSpIriPpgaBZsXy6KG6lRgDiCp7CuKvm5LFYZ1/drj2KQjPB0O6/P/4IUpFn9Ejhpb0lGLYRrS8c=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(19092799006)(366016)(1800799024)(4143699003)(18002099003)(11063799006)(5023799004)(56012099006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZOr+ivbrFk0FLnAwFB3dkVE+02vX8VjreMyAeiwDm4q2IdyyO+MrJq9l4U4W?=
 =?us-ascii?Q?2qXXEM/pd/HvM9jq9bkYSXGuHrcn11MQzUq9cmK1kr14swGDm58CXZm15jNY?=
 =?us-ascii?Q?JdAS/qBwuNiQw2zh6ifzyDYBtARgq6Ug4xSBK2agXFkd8BVTS6fjDGo4fjys?=
 =?us-ascii?Q?F6nWZv46JIUQwLH2OVdprS6IogiS/tMJTPtwFzwsj3Qj7HMbJ8URYPWdOsFd?=
 =?us-ascii?Q?XuQS+Dhc8yYVM1tEhtG9iBG3WmICyi434g+QYb8vTJ1ybQMRKM9pJz4tv3dP?=
 =?us-ascii?Q?9u3A3eF2iAlTJvulQS8qZLqiegC05qrevJRxpQhvXp6++yJZDYxQgSVVtOfU?=
 =?us-ascii?Q?2kn5wPjRCFrdSjIBytD5Nmkup+7ayp5kkAUPNAG3FX+QS9wmpxFIxNBhsBIM?=
 =?us-ascii?Q?wxZrZg1Tqm91FwbBZc6p961+lOPm2vCsRq3Iog40lcexenql0aX+H7BHBZ5i?=
 =?us-ascii?Q?LQyj+dd7di23Uo8SboJfxnpC9kZhTKFDpb4NGoQZYcJMiOFMEddNzZ35bsDP?=
 =?us-ascii?Q?4fb61yMcCIzexr8ajxSrd54NPcx9MTp4htD7ydnqLy/U8OMYnBMjKtkUwqqA?=
 =?us-ascii?Q?ohMsrEj87OAQEDbTd/nm504G2dDf/n6gy7/JdwkqU+wMUA8HQtS4yvfWH1yU?=
 =?us-ascii?Q?GZVeEmp1hcDgSsXzSXaNwAfXxKXBVo03qaQri8XtxiRjKSEnEXtiy4wj1vGz?=
 =?us-ascii?Q?g6f6rfxuAMAv4R9pi5tz4XejUgcXeshZvGhLV5PMKi5trujpJOvIqJt3a5lU?=
 =?us-ascii?Q?EPbKRPbPxEwdKMoMrFASvB1XNz/KoSAs5+vI5aify4y0xK4CoRR+IJMgs4j1?=
 =?us-ascii?Q?yPvtPsTlIdFSWV/T2fNmU0evj7Y94KkLhjtN3D0H583DzuBz56qRzksKVUIC?=
 =?us-ascii?Q?wKuUH4TQhZQVXl/NlHakzVvHUFqV+E4hXnvqlJopJRnKRd0n3WiJGPAiiX6k?=
 =?us-ascii?Q?n2KGv7c+5dG/SmNMJvbyC8vrRmktYsykGE8RMkxyc5H1AT/Xn0/s34bhfQ0N?=
 =?us-ascii?Q?0R8ZXCDauvuitloux+zLDxQBHRbhCgC2jiKAeLLi0hLQ9sNZuXZrhN9Xf17Z?=
 =?us-ascii?Q?PFMG6G093by24sqD6ySM5XyIUEgyzy/BPUQqipqOOCTOhzPh+QTarRerw0WN?=
 =?us-ascii?Q?hLGMauCmN8zt+q0o9FjOYBbQfMEqmpILVPvfr5i2zXPHtrXNnE1nlx6ixrcu?=
 =?us-ascii?Q?/vFK15pCDGO8VbnAWrtTJUBHAimc6nKwPLzTN47pyz2wMJZksETQtcIUKvZ6?=
 =?us-ascii?Q?X8A6pjyqeE6wKWhtmjfgfjM1o9f1yb34DYSqtETsjK+msstsplXqCYwTHm6o?=
 =?us-ascii?Q?KgBAe6AAfkNy+cIvz86vI/7srJjYRP97HS/iItQCSyv0wl94kyorTdq0987u?=
 =?us-ascii?Q?fi/1Yao8GXxJs7Dhyj3T7VJQqoTwzMz1JqrkEc7fTavSDzWtq2Hp/nE/qLMV?=
 =?us-ascii?Q?Os95y2SoLlzSnlFFWKBRwF3MqpPlzVqP+tSysCdtTrAR6eO6ipYslyd+GNtC?=
 =?us-ascii?Q?os+8eXtXXDqL7pO2uzMJtkxi2bUE9Q7UYEhOjk7IpY22/1eJ8e3ISO6ZMnaG?=
 =?us-ascii?Q?NCrm6WRE3h9U3wr0/6udcnVq9INDTofdICqGjgj7Q4FTPolAre2erGjQCnr7?=
 =?us-ascii?Q?NcAftg4JIvQujOT3f1MNxGhrrZWpyx1Tgd8cTXoTYFU7UHPZUoO1ij+BwH2V?=
 =?us-ascii?Q?GD+eNhx9KB47R2XsPrvqBJstzjghLOEMyjq2VfaecrZWKEK3+6jJsHJk+/I9?=
 =?us-ascii?Q?jdkOM4k/QNJJwPATkv46+aNvJFlyw086fAm9hT7oRHEg1qfKlnsS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8cc90e2-75e6-4578-9bf0-08ded5e9a8a2
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:21:06.8755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fadgYSVxwjmT38Z1jiug50Ygxgg3+9hGz47HlnB62VLGGwN4mcleHm6pOsgP6fQaTYssYoGRXZ+A+WPp7cMpc/H5oJ//ii7JqkIE9avEHVeSaVVYN9feZdB5zW5f8kn+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR04MB11090
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11867-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:manivannan.sadhasivam@oss.qualcomm.com,m:mani@kernel.org,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:kwilczynski@kernel.org,m:kishon@kernel.org,m:bhelgaas@google.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhi@lists.linux.dev,m:linux-arm-msm@vger.kernel.org,m:linux-pci@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,SMW015318:mid,NXP1.onmicrosoft.com:dkim,qualcomm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B3B46DC1B7

On Mon, Jun 29, 2026 at 10:45:15AM +0200, Manivannan Sadhasivam via B4 Relay wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>
> device_synchronize() callback is required by the client drivers to ensure
> all the DMA operations are completed so that they can free the memory
> associated with the complete callbacks.
>
> So implement this callback by first making sure that all the in-flight DMA
> operations are completed and then call vchan_synchronize() to drain the
> DMA tasklet.
>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/dma/dw-edma/dw-edma-core.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index c2feb3adc79f..7b12dfe8cfd3 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -331,6 +331,21 @@ static int dw_edma_device_terminate_all(struct dma_chan *dchan)
>         return err;
>  }
>
> +static void dw_edma_device_synchronize(struct dma_chan *dchan)
> +{
> +       struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +       unsigned long timeout = jiffies + msecs_to_jiffies(5000);
> +
> +       /*
> +        * Make sure all the in-flight DMA operations are completed before
> +        * draining the tasklet using vchan_synchronize().
> +        */
> +       while (chan->status == EDMA_ST_BUSY && time_before(jiffies, timeout))
> +               cpu_relax();

read_poll_timeout(...),  Does need READ_ONCE(chan->status)?

Frank

> +
> +       vchan_synchronize(&chan->vc);
> +}
> +
>  static void dw_edma_device_issue_pending(struct dma_chan *dchan)
>  {
>         struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> @@ -968,6 +983,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
>         dma->device_pause = dw_edma_device_pause;
>         dma->device_resume = dw_edma_device_resume;
>         dma->device_terminate_all = dw_edma_device_terminate_all;
> +       dma->device_synchronize = dw_edma_device_synchronize;
>         dma->device_issue_pending = dw_edma_device_issue_pending;
>         dma->device_tx_status = dw_edma_device_tx_status;
>         dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
>
> --
> 2.43.0
>
>

