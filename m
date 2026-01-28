Return-Path: <dmaengine+bounces-8555-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCYSIw46eml+4gEAu9opvQ
	(envelope-from <dmaengine+bounces-8555-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 17:32:14 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EAD7A5C3F
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 17:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DE9B30A8442
	for <lists+dmaengine@lfdr.de>; Wed, 28 Jan 2026 16:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968D830EF7B;
	Wed, 28 Jan 2026 16:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="vpuJn7Gq"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021122.outbound.protection.outlook.com [40.107.74.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E6B17D6;
	Wed, 28 Jan 2026 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769617537; cv=fail; b=EtDgAGd7+s1ipwaOZjTv/vsWXpVRTcbZe7Cd1SIt7U8uO3FCjsO0TxG/kbSSg5zHApH+cWmu2g2YZ8QV7xNEBD2BhqHrOYZKlU795j9BhTNN2T0TICsgkzEFXQq4lyUB1smxpqhF8OrXLUZXHWoBg3shNcbSK9EDeXc+BVRHK2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769617537; c=relaxed/simple;
	bh=ifWosHz/K0MgZ7OVmLnxiYfz1mT/yEqGKFH7tVjQPSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X9tnPDyLC6CMeSXjkn7zvtyHmGMKLecJG2wPHEPtK5XAwaEMfoYE3QBtXtSgtTMJAs8ab9NlCU5oHm31c9Ma3gwa659t6hlL150tEAP0KRNE+WDwI6TQlPkqkhUxV0i1BB0XtBoJp0scanU5HqeRbPiL65y1WWg03rvdr8DHLM8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=vpuJn7Gq; arc=fail smtp.client-ip=40.107.74.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lYkhjUHoK8zrsskF6SKNKlenebSSgQKGSN5u1Q5lvycScPMgotDSjjoxHGYnDUjPFXT57xQ1DqrvKMEiszJ0ph/ILTcWz9WgEMD617saEUN7TDxdodQ+pY6TYd65eJpwWev+ZWYKKaiYAaOReyVdup9AKybsDPNu5jhugjkfdTNpWyx1yDaf0brkiykCRhbUpwjJp02tbKcxfb0XfSqjT+U9IdaEKFXPtH5OHupBP8CXTsJzYONtm3ZwF2breSxRVFwh5wcYir1zsBiHY8ydp7Wl6+wMdB67WW1zT+yEhRwHVCh3NRW4Cp71EV0xy8+V57KpcMIiuSW+Hmt+Jrf5Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtN8m7DgFoHvYIDhbItioHg2Y8gzZOr0ByVnLNIKyVo=;
 b=IgFFMtZmJI0auqjm7N9jxmzx58R+sUiKU8OleGrNE44uKfmWifyaF4kS0NNB8nVcnJ/sNCYXCc77rPVyCInirZC9DQQwtd65Z1dc9fx4UHvFAFULmmZENIk8n4tcSa/t0mtAWrUit2z4hjt8VvifJKcvKSbs4ss82mLdsm/LbXA//3mk24JuJb2hwBpUfi9UCY7BDMSivEhW2cbfMiyeRmpmVB6WysR+X4bo6JYjigigriG87KT9U9g0eToP4FIhp8eUT4Urx9ISpE3DjMsJ3o0bOg/mAI6eStP56POf/8UA5AtkfjGEI59dzJc+I3LcUz4bwv+vrJfeM/0prk2Zjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtN8m7DgFoHvYIDhbItioHg2Y8gzZOr0ByVnLNIKyVo=;
 b=vpuJn7GqgtSNf+cCm/wvR0yJHMoI9MY4QB5FR3Mge6FgWu6nK8gUtdk20cW0BIm9UPXH7YCHqIKstM2tCZ0oqsaChIQt7AwDeDo/3QNt0F8witUeVGaQK3n+BRugScMLh0rPkp6aG04+84VpCbusUSXwWHpOat3zM3WqDtJZH90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB7099.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Wed, 28 Jan
 2026 16:25:32 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 16:25:32 +0000
Date: Thu, 29 Jan 2026 01:25:30 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>, mani@kernel.org
Cc: vkoul@kernel.org, jingoohan1@gmail.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, dmaengine@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 7/7] PCI: dwc: Add helper to query integrated dw-edma
 linked-list region
Message-ID: <dpx4s35dqvhp54sloixxsn3qcf3g2k745wieaefdc2svgkbtr6@4vuqgp46czi7>
References: <20260127033420.3460579-1-den@valinux.co.jp>
 <20260127033420.3460579-8-den@valinux.co.jp>
 <aXovtOcilRrkA0Ot@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXovtOcilRrkA0Ot@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0193.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:382::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: 106e4cef-8197-40be-08c6-08de5e89db81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9uX9DVuWurH9iXgZAZh0rVwOCwWXM0jbQ7HeGKlU+2irMysOhF0pMcNRBet9?=
 =?us-ascii?Q?F8W0yvsWHZzExUVAXg7wPtGFL5C17LoVE8AD19GddAiUtDQOlEp2AOQunUSE?=
 =?us-ascii?Q?0V2+shS+yA5+F54UcJ7V5DVv/8EELmlXQy46f76ljKnY45+lbRQSoB7lqONf?=
 =?us-ascii?Q?hrhVMOM4PwvBy4WNTBBocDFDq+BbBBZ+9XAGV6VOnlx/xjrwwM5pUQX6VxRV?=
 =?us-ascii?Q?qBSTmQeU0Bl1a8WOcrPfqyiCADVX/5W66gaKcnKlwp4SsrOfh1l5S7JZG0Lw?=
 =?us-ascii?Q?FMpGZxVhCX30S7IqPlijTXdp1kr1PA9JY/sxRqF/qRw6IobUUyPRvQebV921?=
 =?us-ascii?Q?9jZzEEfrHl/FSYDMvfpApYFUXX29b+xnjN9eHeSb8eiI6dgGWr7oZzvL4jNM?=
 =?us-ascii?Q?yhW73iKsj5mJZ2uXfQ3l2rJCCp2taYu8DT9Ui2UIJfpQyH7nLyOslFD+uCEI?=
 =?us-ascii?Q?O60JlOv+j0z42q67ZVHa2LJxpF8bEpRV0IDIc09L4+4R+Ehihr0OjkHo/1y/?=
 =?us-ascii?Q?gVWuuNoX8owVFkvLUm9tKsf0kLstp4TYbz7FmqeBnliZTsRrgr5tK49e3h2F?=
 =?us-ascii?Q?B2+SriJwGpIXNxxdIuY7IvZCvi30kiyEC1u6pUUDFeiITgay/+5cvweAdIiJ?=
 =?us-ascii?Q?LMdXy9U+6+OaoDgAuXTJ6Yeq8X1MTs5mXANkIaW9kun4uO2YDAB8dZKQ0lQr?=
 =?us-ascii?Q?Adygm5I3C/VWrGcYo4BYt4FZIzoWpBrMj1uDkqG8jWaQwboh0Yfqf3r0C1pV?=
 =?us-ascii?Q?Z025Vft6ur1pKrn9tumDKyDxoUSy6sps8BOZ41MjYMrOgRmfD7OfCx5mXKBU?=
 =?us-ascii?Q?aNe8YTJQ8/wouQtyyodmPyyRgheMFfSttGliVjabVSFFFnEuvoO/knb2m9ss?=
 =?us-ascii?Q?czYBV4eJijDvubWQg3UFjDJM4+fzIMqJBGsij7wRv2j75zMXp9hb5fUIJbSa?=
 =?us-ascii?Q?fXaqcV8ORFSyEeFoaDwOQKNtxNnTWsfZWhXbvTUxlPHiM2/3MUnJVvx60do1?=
 =?us-ascii?Q?0pd6Yfo4oYha2/RoA1bigHCzFvW51ibSWJgi8d4G08KRu6cHtPc401Gr9dM1?=
 =?us-ascii?Q?jGkIBz2QW55zUVESxPSYZNj0waXplIS1oGnQI4DvaTuv2TjQuBcUD2jZVWm2?=
 =?us-ascii?Q?Tapx9lb0bEkL5Kq94Xv8CbxACYnKnSRl3Wlwgg5rPCjQ2DxG+cWUnjlo5gvk?=
 =?us-ascii?Q?HIQBue41jyDS83gvxxjxM/Me7KgUxoYfZMs603tvu6O0siJeVBogSF7iXTpn?=
 =?us-ascii?Q?OCD1kz3LRM5XfBvl9LtxYvFEcoBoBQfAgokBdlxGVmj3spBRwvwWZQz6amO7?=
 =?us-ascii?Q?beKdDqptSgyfyOJS5SofZoSgl3jV/bnmJ/Ge+6ms7D2Z56C92RYST/OFJzZl?=
 =?us-ascii?Q?Uwt878BNODgnSsgjEXYnlx6xQMPSQW0cbBXYcSE4W/xB6hQ2BWeubboO+est?=
 =?us-ascii?Q?kX3Teb7bEG/hnxhg94lgqaaHSl+8JOrtMAbsTpXZQlPqp/CaJKwCGwlUAgKC?=
 =?us-ascii?Q?HcNjVtaxaPHHDE5/cqR1i1L1wrCdDrckCxFNZg1n+yf5rYPGTTQK7CNq9kWV?=
 =?us-ascii?Q?l2ntQ6PCj8I3yzHMTcs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kH8Oj3Pw3FFfgAnvQJtAcIJEDkdkJUi1trfTZxMnJ3tACWCQvyuKzkG7dJuz?=
 =?us-ascii?Q?7ksXLh3NB0Nh8hyj3QmRSjdZwapZD2poaAxuXBYlUt6EzVpZXMhMMlZ7Vdbs?=
 =?us-ascii?Q?lAG3jiWQy1/xkYw5yJwDApX7uW/e0GX0YJVkfySDaFF35ymDl22l5ZTh4oU9?=
 =?us-ascii?Q?rtsEtECwdM/n0n6yILMIP87HafxCcoLBeZgQcygRHzjDZCqMjo0ub4CaR4bB?=
 =?us-ascii?Q?vMo+yKmCEs44YwCOrGu2tluYIw4f6XwX7Bt2pDthvA5dQXY+RkuMS7P8dSJe?=
 =?us-ascii?Q?okJjeDteSQtpTJr9wQxmMmczyWXHHHNLMW9GutGxXzUer6yBMY2UHCFR8GB+?=
 =?us-ascii?Q?lIZ1nhNHskZr1VAO+5Kh5cBA0Be0OeZXu+1EC/PXr6/vqJXe9YVi22ac9VpD?=
 =?us-ascii?Q?fAN7lwBOZJUomEYxM70HjyhMzJllOsjsc2zBYYslvR/mt1CV3WTGI5pMgCYl?=
 =?us-ascii?Q?Y3ywjpTgfEFyM7ux+VB03SHdVJcliNRUYFPhKg4Y762MXrwAuiiwqliPl16V?=
 =?us-ascii?Q?B1kHQtaJVi5jsAG8O+YNGLGghJy8JN/Zr3+ddj6fApvDmXmVyvGaTr65mxVE?=
 =?us-ascii?Q?xSClDw3Ma3vsm86lOka0c2Tvhuz7WqMw5SoHi2fDKXmm3tacgSkV5GW8PKWD?=
 =?us-ascii?Q?S0TDUawuemnR8z+5BKHD9NyUtjjkeFNOPsyjn8ZpOjHCeZl8obYCYUNspS4K?=
 =?us-ascii?Q?S0Lc0KOD4iPey7jD6X7YXlH1EkRMnY5SRGbSYkM/Kf/C4pwv40l1KhUOPmHA?=
 =?us-ascii?Q?IPmpsLIo1fObfPcJVTyUbIiUxzJZmSOLrvuudKRpqJUDgdgA4wAQYs5uy3dK?=
 =?us-ascii?Q?4/fAsfZ/8wK/AonJnM4hVaqQ0pBJgvaZ7uYkVSVX27bkE+sr8VSP4tcXT4mA?=
 =?us-ascii?Q?ed/lkF9euN07HPz4zWNYEKSY24DuvwVD8He7XcxnoPykZsJi8EbBCXleAfjQ?=
 =?us-ascii?Q?CTmrDIKluPXhwPGZUIxd8KHgBk3cNEl5AIRI3YdOQd84ESE65/By9MFAdm/3?=
 =?us-ascii?Q?kMlTtGGf1j2e58S9RGlYkJgjzA30F66406cWxEj6KIF9AxLfykuAn0C+3nTx?=
 =?us-ascii?Q?d+6M8avdSB8265k/ODbrAPMz558JaOHiVI/+MI4tm3k1t0c1b1ces4TYerRL?=
 =?us-ascii?Q?xOqHh2CKludGGRbNiJlFSTn2pnEL1jzbLYDN92iXRj10HhdeH+G/m+Uscv1Y?=
 =?us-ascii?Q?J5SC7wPKa6y1wJADnCCFIRII7b1M7ORkSab7rtbsLPY5bhQrPYG9Rg1VNfKi?=
 =?us-ascii?Q?lOFNvh46xdMBESbHtAmY5q6wpAv1vmHXTBPCx9Z5fNEHh980ZjJz9HC1iDZE?=
 =?us-ascii?Q?OEUFyExDtbOew9DGTdFOdam6o0mixV/m3lhaex6Pw5rQ4v+hoXVG0hAyenCq?=
 =?us-ascii?Q?yEV1h/SSmmfUf/NSjwuzkp1Mpsn6Nwtto0AZ2qT1kcu7GkMCqJFHCII8OOR+?=
 =?us-ascii?Q?91qJxxtICDN9csZ+BnyfnpyOQ+iJgB6A5dtvc2OfCf2irLjxTgRpkxKQsEug?=
 =?us-ascii?Q?hMxcgNu2iJ/8noViULVmc5SpQ0pAqeDIvaOHJdxhMIOovmIrPNSCwV1pYzNA?=
 =?us-ascii?Q?bhCCAk2R1kZ2f18cy1C0hx0f0xqImWEvn2dRc8pHFCSOKzjBCqKS/qGOsipB?=
 =?us-ascii?Q?rDUJM0lcXyiZ3xXr13sK2LDe4r2r162bKwyQ8C6EtXtcgkOckwL6xFrd5UQ/?=
 =?us-ascii?Q?xqyfIY5X6QUhVyjN4t4JDx/R3FhTf92SNe2PS92zFMmnCBUCHTWoIGN9rGkB?=
 =?us-ascii?Q?huv4z1HuTgwVN8qaQ96rg0Rjze5TFzhp3J6PbmUDQImWKI1wYOmx?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 106e4cef-8197-40be-08c6-08de5e89db81
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 16:25:32.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zlut6+DjT3kWVkGWksUbUidJZc8EJt0INZaseWTlFNb9PFlUENHouGjkzSzXo5K+ji87UkpQj+OMj6QsTviEww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB7099
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8555-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dw_edma_chan.id:url,valinux.co.jp:email,valinux.co.jp:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0EAD7A5C3F
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 10:48:04AM -0500, Frank Li wrote:
> On Tue, Jan 27, 2026 at 12:34:20PM +0900, Koichiro Den wrote:
> > Some DesignWare PCIe endpoint controllers integrate a DesignWare eDMA
> > instance and allocate per-channel linked-list (LL) regions. Remote eDMA
> > providers may need to expose those LL regions to the host so it can
> > build descriptors against the remote view.
> >
> > Export dwc_pcie_edma_get_ll_region() to allow higher-level code to query
> > the LL region (base/size) for a given EPC, transfer direction
> > (DMA_DEV_TO_MEM / DMA_MEM_TO_DEV) and hardware channel identifier. The
> > helper maps the request to the appropriate read/write LL region
> > depending on whether the integrated eDMA is the local or the remote
> > view.
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/controller/dwc/pcie-designware.c | 45 ++++++++++++++++++++
> >  include/linux/pcie-dwc-edma.h                | 33 ++++++++++++++
> >  2 files changed, 78 insertions(+)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> > index bbaeecce199a..e8617873e832 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware.c
> > @@ -1369,3 +1369,48 @@ int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_reg_window);
> > +
> > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > +				enum dma_transfer_direction dir, int hw_id,
> > +				struct dw_edma_region *region)
> 
> These APIs need an user, A simple method is that add one test case in
> pci-epf-test.

Thanks for the feedback.

I'm unsure whether adding DesignWare-specific coverage to pci-epf-test
would be acceptable. I'd appreciate your guidance on the preferred
approach.

One possible direction I had in mind is to keep pci-epf-test.c generic and
add an optional DesignWare-specific extension, selected via Kconfig, to
exercise these helpers. Likewise on the host side
(drivers/misc/pci_endpoint_test.c and kselftest pci_endpoint_test.c).

Koichiro

> 
> Frank
> 
> > +{
> > +	struct dw_edma_chip *chip;
> > +	struct dw_pcie_ep *ep;
> > +	struct dw_pcie *pci;
> > +	bool dir_read;
> > +
> > +	if (!epc || !region)
> > +		return -EINVAL;
> > +	if (dir != DMA_DEV_TO_MEM && dir != DMA_MEM_TO_DEV)
> > +		return -EINVAL;
> > +	if (hw_id < 0)
> > +		return -EINVAL;
> > +
> > +	ep = epc_get_drvdata(epc);
> > +	if (!ep)
> > +		return -ENODEV;
> > +
> > +	pci = to_dw_pcie_from_ep(ep);
> > +	chip = &pci->edma;
> > +
> > +	if (!chip->dev)
> > +		return -ENODEV;
> > +
> > +	if (chip->flags & DW_EDMA_CHIP_LOCAL)
> > +		dir_read = (dir == DMA_DEV_TO_MEM);
> > +	else
> > +		dir_read = (dir == DMA_MEM_TO_DEV);
> > +
> > +	if (dir_read) {
> > +		if (hw_id >= chip->ll_rd_cnt)
> > +			return -EINVAL;
> > +		*region = chip->ll_region_rd[hw_id];
> > +	} else {
> > +		if (hw_id >= chip->ll_wr_cnt)
> > +			return -EINVAL;
> > +		*region = chip->ll_region_wr[hw_id];
> > +	}
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dwc_pcie_edma_get_ll_region);
> > diff --git a/include/linux/pcie-dwc-edma.h b/include/linux/pcie-dwc-edma.h
> > index a5b0595603f4..36afb4df1998 100644
> > --- a/include/linux/pcie-dwc-edma.h
> > +++ b/include/linux/pcie-dwc-edma.h
> > @@ -6,6 +6,8 @@
> >  #ifndef LINUX_PCIE_DWC_EDMA_H
> >  #define LINUX_PCIE_DWC_EDMA_H
> >
> > +#include <linux/dma/edma.h>
> > +#include <linux/dmaengine.h>
> >  #include <linux/errno.h>
> >  #include <linux/kconfig.h>
> >  #include <linux/pci-epc.h>
> > @@ -27,6 +29,29 @@
> >   */
> >  int dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> >  				 resource_size_t *sz);
> > +
> > +/**
> > + * dwc_pcie_edma_get_ll_region() - get linked-list (LL) region for a HW channel
> > + * @epc:    EPC device associated with the integrated eDMA instance
> > + * @dir:    DMA transfer direction (%DMA_DEV_TO_MEM or %DMA_MEM_TO_DEV)
> > + * @hw_id:  hardware channel identifier (equals to dw_edma_chan.id)
> > + * @region: pointer to a region descriptor to fill in
> > + *
> > + * Some integrated DesignWare eDMA instances allocate per-channel linked-list
> > + * (LL) regions for descriptor storage. This helper returns the LL region
> > + * corresponding to @dir and @hw_id.
> > + *
> > + * The mapping between @dir and the underlying eDMA read/write LL region
> > + * depends on whether the integrated eDMA instance represents a local or a
> > + * remote view.
> > + *
> > + * Return: 0 on success, -EINVAL on invalid arguments (including out-of-range
> > + *         @hw_id), or -ENODEV if the integrated eDMA instance is not present
> > + *         or not initialized.
> > + */
> > +int dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > +				enum dma_transfer_direction dir, int hw_id,
> > +				struct dw_edma_region *region);
> >  #else
> >  static inline int
> >  dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> > @@ -34,6 +59,14 @@ dwc_pcie_edma_get_reg_window(struct pci_epc *epc, phys_addr_t *phys,
> >  {
> >  	return -ENODEV;
> >  }
> > +
> > +static inline int
> > +dwc_pcie_edma_get_ll_region(struct pci_epc *epc,
> > +			    enum dma_transfer_direction dir, int hw_id,
> > +			    struct dw_edma_region *region)
> > +{
> > +	return -ENODEV;
> > +}
> >  #endif /* CONFIG_PCIE_DW */
> >
> >  #endif /* LINUX_PCIE_DWC_EDMA_H */
> > --
> > 2.51.0
> >

