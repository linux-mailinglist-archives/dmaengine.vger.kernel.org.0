Return-Path: <dmaengine+bounces-8412-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKSuKGQucGniWwAAu9opvQ
	(envelope-from <dmaengine+bounces-8412-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:39:48 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 242464F34C
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 02:39:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6AA4AACF8DC
	for <lists+dmaengine@lfdr.de>; Wed, 21 Jan 2026 01:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF5730F7E2;
	Wed, 21 Jan 2026 01:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ilArfXMP"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021121.outbound.protection.outlook.com [52.101.125.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A0030EF67;
	Wed, 21 Jan 2026 01:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959550; cv=fail; b=TtRv4+xDER/WPLzDJ92piJ237BRq3qbI3Lw5BBxWmoGnQGY0vEMuy8SyDUyu4f8/MrTmXTS9cumkhed+w+xj4pPKp74oLH7L4JHbel79OS8pcf8/t9e3aVyvXdXLjP9YUAXwgHjIHwZgASKeENYpTSp7kDJgzZXlIgKDTcKUlnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959550; c=relaxed/simple;
	bh=aN6yMqNU2gOx2tEVqm4KwNEwNOTzxr1Hx+WTqjskRI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NuEJtB9oUw5fZPWNnT/pyDQuWfdzcfeLQNk2bniJq+EHTM3K/+cu5zGfuIom0yJuE/81/0TumkwIufTMXkWHoKIREkCvrdUeq3M7EnvVQhNhRX057cP2cvYIIqH60ICePc1EaLW7oXR6FN0TCYw0iVWQySORoUZNK5/ww6XrLNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ilArfXMP; arc=fail smtp.client-ip=52.101.125.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3yfHD9kl9//ybCWCbzsatJ9tAn6f4PR46KxHKsz77COItVkAu0N4YGlJhoLjvvN4dMtGQ80Oxd0yvfCAWwh5xPNYnWoJnIWlUpXzcbW9R/x/g54mF87VkKMnz6ZvtwmRgY7S8hqTWxY4gM05AY4+yiC7QnZsDo/1o/uHnSqt0vATvmD/ZG82QIof14Bk/YEt1V2pHMsp1yslvHj50wGVvfgmmjip1Ps5eBEuDJV06bC93BWJbiKM+a/nwg2nghFoxNnvt4HNv20bqj2Mo4r5OvNk+ZWcjsN6v+2Vb6i5ntIUHI2znWQkatXGmXxiE5Yl0jeM3h92RXF5t8WNTWvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KVs3lE5uxOnxpa2P564KJhIMeXnXt5yfmklvfTU8M8=;
 b=x0xUTR3BQ8Rh3F5Sd63sTjGp+mFMj615ZIgW8sK5wFn7WoH26mBj6qjxtYCiEeu7dRPNZ2qsDREp7TZoBIFiXRy5ecbe2ATKQlclJmS+vHabVluqkuUd8opGpedHrUdC62XN2gGNZ4BzsHcOvG+0aguX7I8asUMcxGlbCOQMxgrGOal5goZNzem8BM3KhoKVh7rmsIgLQwAVqb1kHWy7EnOjUKrpqylsa2u4/01pc+3gxKnRBGxSIgtD21V+UFvopRtXQLGNExK9NViByj+vZRljVRAdrGPsM7X6KvmUEhonqGY87yE0nMumYQ5al486mTCHYBCw5sB0Cssh4HbFWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4KVs3lE5uxOnxpa2P564KJhIMeXnXt5yfmklvfTU8M8=;
 b=ilArfXMPzaQR8b3E5Jp0I2ZmAU3UPLOME3dIPFRlCBFJ5qENAnwIRN93bZQQmN1GWAnx25kgHsvZYbX/ff7uGJJFlAU+Wv8/vf+fRxAjBsBE/Zb8Bd/6lGyBXH1+QzIuTTKkCm+FbGNs3Ho7WijVctUn8Hd9oAjGdYGT0adHoWk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB6416.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 01:38:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 01:38:53 +0000
Date: Wed, 21 Jan 2026 10:38:52 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: dave.jiang@intel.com, cassel@kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, geert+renesas@glider.be, 
	robh@kernel.org, vkoul@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, linux-pci@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, dmaengine@vger.kernel.org, iommu@lists.linux.dev, 
	ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	arnd@arndb.de, gregkh@linuxfoundation.org, joro@8bytes.org, will@kernel.org, 
	robin.murphy@arm.com, magnus.damm@gmail.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	corbet@lwn.net, skhan@linuxfoundation.org, andriy.shevchenko@linux.intel.com, 
	jbrunet@baylibre.com, utkarsh02t@gmail.com
Subject: Re: [RFC PATCH v4 05/38] dmaengine: dw-edma: Add a helper to query
 linked-list region
Message-ID: <e4y664ylum35wvj4endwprzpp4cvfaggklik5mxvdkgmakuqyj@lgevmhllem72>
References: <20260118135440.1958279-1-den@valinux.co.jp>
 <20260118135440.1958279-6-den@valinux.co.jp>
 <aW0S60D2uALBXdtQ@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW0S60D2uALBXdtQ@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB6416:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f2278f-88d2-4b11-9fdd-08de588dd5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GyJLnoMKKJEAnwLCXMyQhJxNeURmN+qgqoDAyydiA9FJ3juGY/uPxpRkHEdS?=
 =?us-ascii?Q?kL/lue9bO5CxvUx3Ef7YMmTBI0n4mFbVwQueqwpyeXBeTl8ap8CgRQtAJ7WV?=
 =?us-ascii?Q?Drv72HuIcNhRrD/vxlPSd2Cbrh2xP5QbqacSv6cE1hq5iNY05TGjUNekPUC3?=
 =?us-ascii?Q?TgIanWC2mtKRh4wx9MKeTWUpFmLnWWrDtOeR6yzmrj+cgRixpjmO+H+00/Qh?=
 =?us-ascii?Q?Ycc1fJ5OR7vBQgGSGusLrw1ibiis8cDUfEF9X6kM/8tcXl7oBPuDYUbxfmjX?=
 =?us-ascii?Q?81HjfD9zt9Gx/xPjrGpnvExrHKHLoxwSbyjPzwaw9NFuspWLN3PvgjfqE3eS?=
 =?us-ascii?Q?BwU+TN4vrkPt62eGqJY29TETAKVKl2YctXNJ+QNqpdOKvTvWZtZ6+Du5on8S?=
 =?us-ascii?Q?KKuxUTKsZ5oLTqNzPD69Llfm+VMwL4hYpvpNvE3OiaVdL38x/TJyV0vI2w7Q?=
 =?us-ascii?Q?uRydjZSilLuXExgo9hdMA/vASeWd+jOjRK9hKGWAfoYq2eda5CTxgVADDOLh?=
 =?us-ascii?Q?NF38CD7H3pmzfplUhZAyqosL5Uerl/3pUiGv/jGXjcNecajj5sJNQHqdA7uo?=
 =?us-ascii?Q?RLViIedz3xIwicJcGftVdLM1KVK8mN/vVCQi7DrYHi5vDOJDGxrij5UnwSbY?=
 =?us-ascii?Q?kHVc4fTfLbKtM92bgtLWoafTwi8KWepYJt+sssWnnQ6OKShMXL9ROaMcRRUt?=
 =?us-ascii?Q?cqNs4Gyrj4YZ7GDGw5eVgbC3KPItEkoVFwe39YPG5l14lLDgL7YhglUOuOCU?=
 =?us-ascii?Q?vByfk9f0TK5nT/rwYip7t3/uCMtPaCoEghe9kUs2kAEKI/lopkH4mg9o3K55?=
 =?us-ascii?Q?562k4WKV/hvVmUcDVR7SuoJZ9QIwkHSsyPGefp4yETmWhfjKyrUgH+JJV4Hk?=
 =?us-ascii?Q?4f2NRvjBQSbUV+siWZ1vlIFXorzJbkY/oegvfYRdFkdgedd9n0J+7e8zsOgV?=
 =?us-ascii?Q?fIL/5tyOvWCFvgF0AIZzpV7ZPzAKFBIZwh/YHGv2JWXj0Zsd+pHU+tXpdhhA?=
 =?us-ascii?Q?DX2fXQuwrup5ucU9qXR1z/aYfSskSiFN2Cd9VRXKcwPrjXzBNrJz/I0QHwaf?=
 =?us-ascii?Q?i8d2AhoyDeG9GbVkKw32tdnxvuldYXIi9cdTKc8P4zyQZhYw8lqocTeM5yWO?=
 =?us-ascii?Q?gdzIGlg3sz9/soyo33h30hOR2OWhxv0go9emc0nXFa39eOEru39EnrPbo/I8?=
 =?us-ascii?Q?KXtMpQgu7+tUcKb8/gkUVZ3gtkt+eO9BseBBb5uEWhy3hJ+7p9XUNfGPpyxe?=
 =?us-ascii?Q?yncRLKpm7Lh82BMaCxSl6UWQKvAQggBOIquLJDIWXKo57b5rKs17A11YeYzH?=
 =?us-ascii?Q?KUSbVDaLPKwa77z0I8MWNQQDWS8GooX3BZSK04hclU1c+doYnsuoACWDVn2y?=
 =?us-ascii?Q?ZZDm3kkONLv96O6Yto/3LrBP6j4yQjoqEjHTdYYdcElJf/mdSQJmxqsHCsAt?=
 =?us-ascii?Q?zNzzKBzRDYF1/yyCQ4WpSRwqODaM0S+LZ5M7gOZfioPEge1f5IWoo/AM6tlH?=
 =?us-ascii?Q?FZAO4s4/4lhBLBvjOQ7f4AKSoE7XylAgvv0Ewi906gOCXBrNm9anUzfoSZDv?=
 =?us-ascii?Q?XgLS1CyajNAxzA3Hgus=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hm+vQO7wVkxmml8cvAx7lQUD7lEjP38SGLgA92ftn9QBfZUkmTHqkhayWKIT?=
 =?us-ascii?Q?muqzvkCMmyTM02qE8NcmSIkM5Gu+uJaWuGp/4usir7Ygk1gn/UD3f9sSi1KE?=
 =?us-ascii?Q?vXL2FHFtiu/Ye/LBYrvnytZ6yUBpfdJWxRX1s9oJ2Elb31aq5tLQcPD/1BP4?=
 =?us-ascii?Q?bxPXZ7P312F4zXrw9aPkq53g10bGsiZP+4CJnrcqRLXXSjnlRl0bQRgEMFP3?=
 =?us-ascii?Q?f12Oxw9NC8fWCnxQqCKftBUzXjE9wO/jX1nyrbYq5JqhCDtlzqa7GktObZoU?=
 =?us-ascii?Q?xHI4xU7iVF/YdLMX1MxFUFRZ/RJxWMqW9NTzacZVdThZgrg4WMWzv4V+AEy0?=
 =?us-ascii?Q?jq/lXnQwkkbLbBTBmpBdkpGqSixST2ORd2Q1268z2UgleKweqmm2ClXwtVsG?=
 =?us-ascii?Q?G2OTCbhIn6b8nmwQc4A+pwsRyuNn8pv8vm+YUowpMWCkN2+7ZqedvtqzsRJb?=
 =?us-ascii?Q?9y8Ik/vXKdKc3PilkDz3ECWV/agmUBQGAlzMftckO0/Se2qLYDxTfl68C+Vr?=
 =?us-ascii?Q?6Q2WOHgQNVsR6cGO8+Ut2Jt43bWt8xOBB0H15Trn7PRmHJGXCo0rSilIOS3c?=
 =?us-ascii?Q?xTasdQ9+mKkfseIzAMPWIq39DBaInnp2VPEQUivp96DAbw891Ea8nf/wthMT?=
 =?us-ascii?Q?RpBH16k1P2hKHCctTxBDLkfjEsOImztTMPHiJQBhqkM0fkDyAjizv8wRvd8u?=
 =?us-ascii?Q?0eTFipJPvnIAt5fYSPIsKxH1BJeCLNakgm1iIsEhOt4bf3Qupy+08Boxglgz?=
 =?us-ascii?Q?QHlPRARXdv3WK3YRRJ46zDxDx8kV5+MbP9hy7nKU1+hR8JtRNlB9o1biodTZ?=
 =?us-ascii?Q?E8H/11OXVC6vXpDOsMJLPYhBY/NYaOULB3EhwENYqrwqQ/hdCkpe79ss3Tmc?=
 =?us-ascii?Q?qBJ7NT1eBqDgVCe6b/MQSwVBFiNhdSxOydxW5j3iYE7qNl4O+b/EsWL7EpEt?=
 =?us-ascii?Q?8i7k4fpWe8F1eCgmADHODvD6BvBY4HOSPtEzAn7fQsrOtzrPYJJA3Mpj02ke?=
 =?us-ascii?Q?nIIwBHqYpVFboh5qSdWFJFbqyJKtHGPc7VeLqptz9U4Zgws3evWuhFP0zWkX?=
 =?us-ascii?Q?ACsuo9cjewXGmT2gYuc/G+EZ+UNvk9XZXyW/vIWlMVRUYJUezfAdKTaR9s2A?=
 =?us-ascii?Q?9M4FHGxV+ZrKzX8lA1Sp3/xy3C3ZIU05+ah01WdyVFfDmAg0d9PbJM4PDnyM?=
 =?us-ascii?Q?brURm+mibaee4N5HDfOfqJ85VzgROX8k6G/X9ANgAeBB2pKCj/uO+0dRugB1?=
 =?us-ascii?Q?Poy+nC0paqSahpZPXpLJKtneZWZHzruKup7T1XcebBsud0aKNCO2pS+NV/iZ?=
 =?us-ascii?Q?ghu7KmInG1StG/2SGzyoykK4vJZzJ+SS8CvB20k7cDiknvRgOiBBvce7xxmD?=
 =?us-ascii?Q?ovjuEH9Ikn2+Mk4/gVlKICPiZVnUea4lBKmpQsCSvMG+Z4Q0r953mnz36V95?=
 =?us-ascii?Q?nMD+RZYut3UtYdFMw9pR+up9BgDADuSvhssi/okkQESCGJvIyyhgdr5Cu8MT?=
 =?us-ascii?Q?CpSE/mKq49r9Y7DlJ8zE/6uCK20YDRJKrPQ7PeuOE3IGj+OQNOlgB0rc96Dr?=
 =?us-ascii?Q?xtpavfwoK37PeOlTo/0FiaivyE5fw4txg51Na4lFhuQXTsyyBq7trPKfny5d?=
 =?us-ascii?Q?IQbelPSxBeAxjYN6h1afVcsJYupnXxwhWLYbIlrh/FY2Yb6d/REGqms6H8vu?=
 =?us-ascii?Q?RGpv1AjR2hEFZ0sFMAYCGN91/BFlFFZN7EjUNz130Eq/WsV9eg3b2A54TxAf?=
 =?us-ascii?Q?BMTpcg6VrCG2ShXV/m6AC6QJ41Erm3vUW2383A5rwpBKyCWT4H63?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f2278f-88d2-4b11-9fdd-08de588dd5ee
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 01:38:53.7309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2oHdW80p2vtFqISk3cZ/sCOO4xgFboUR0/rfN9cTJ1geN10we1UNgyK+SsxdCJndYCvx5AWEIDtzTKTRkvDuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB6416
X-Spamd-Result: default: False [2.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8412-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	FREEMAIL_CC(0.00)[intel.com,kernel.org,google.com,glider.be,kudzu.us,gmail.com,vger.kernel.org,lists.linux.dev,arndb.de,linuxfoundation.org,8bytes.org,arm.com,lwn.net,linux.intel.com,baylibre.com];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[valinux.co.jp,none];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[dmaengine,renesas,dt];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 242464F34C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Jan 18, 2026 at 12:05:47PM -0500, Frank Li wrote:
> On Sun, Jan 18, 2026 at 10:54:07PM +0900, Koichiro Den wrote:
> > A remote eDMA provider may need to expose the linked-list (LL) memory
> > region that was configured by platform glue (typically at boot), so the
> > peer (host) can map it and operate the remote view of the controller.
> >
> > Export dw_edma_chan_get_ll_region() to return the LL region associated
> > with a given dma_chan.
> 
> This informaiton passed from dwc epc driver. Is it possible to get it from
> EPC driver.

That makes sense, from an API cleanness perspective, thanks.
I'll add a helper function dw_pcie_edma_get_ll_region() in
drivers/pci/controller/dwc/pcie-designware.c, instead of the current
dw_edma_chan_get_ll_region() in dw-edma-core.c.

Thanks for the review,
Koichiro

> 
> Frank
> >
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/dma/dw-edma/dw-edma-core.c | 26 ++++++++++++++++++++++++++
> >  include/linux/dma/edma.h           | 14 ++++++++++++++
> >  2 files changed, 40 insertions(+)
> >
> > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > index 0eb8fc1dcc34..c4fb66a9b5f5 100644
> > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > @@ -1209,6 +1209,32 @@ int dw_edma_chan_register_notify(struct dma_chan *dchan,
> >  }
> >  EXPORT_SYMBOL_GPL(dw_edma_chan_register_notify);
> >
> > +int dw_edma_chan_get_ll_region(struct dma_chan *dchan,
> > +			       struct dw_edma_region *region)
> > +{
> > +	struct dw_edma_chip *chip;
> > +	struct dw_edma_chan *chan;
> > +
> > +	if (!dchan || !region || !dchan->device)
> > +		return -ENODEV;
> > +
> > +	chan = dchan2dw_edma_chan(dchan);
> > +	if (!chan)
> > +		return -ENODEV;
> > +
> > +	chip = chan->dw->chip;
> > +	if (!(chip->flags & DW_EDMA_CHIP_LOCAL))
> > +		return -EINVAL;
> > +
> > +	if (chan->dir == EDMA_DIR_WRITE)
> > +		*region = chip->ll_region_wr[chan->id];
> > +	else
> > +		*region = chip->ll_region_rd[chan->id];
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(dw_edma_chan_get_ll_region);
> > +
> >  MODULE_LICENSE("GPL v2");
> >  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
> >  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > index 3c538246de07..c9ec426e27ec 100644
> > --- a/include/linux/dma/edma.h
> > +++ b/include/linux/dma/edma.h
> > @@ -153,6 +153,14 @@ bool dw_edma_chan_ignore_irq(struct dma_chan *chan);
> >  int dw_edma_chan_register_notify(struct dma_chan *chan,
> >  				 void (*cb)(struct dma_chan *chan, void *user),
> >  				 void *user);
> > +
> > +/**
> > + * dw_edma_chan_get_ll_region - get linked list (LL) memory for a dma_chan
> > + * @chan: the target DMA channel
> > + * @region: output parameter returning the corresponding LL region
> > + */
> > +int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > +			       struct dw_edma_region *region);
> >  #else
> >  static inline int dw_edma_probe(struct dw_edma_chip *chip)
> >  {
> > @@ -182,6 +190,12 @@ static inline int dw_edma_chan_register_notify(struct dma_chan *chan,
> >  {
> >  	return -ENODEV;
> >  }
> > +
> > +static inline int dw_edma_chan_get_ll_region(struct dma_chan *chan,
> > +					     struct dw_edma_region *region)
> > +{
> > +	return -EINVAL;
> > +}
> >  #endif /* CONFIG_DW_EDMA */
> >
> >  struct pci_epc;
> > --
> > 2.51.0
> >

