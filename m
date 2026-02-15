Return-Path: <dmaengine+bounces-8904-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ma/wCbnkkWnWngEAu9opvQ
	(envelope-from <dmaengine+bounces-8904-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 16:22:33 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 398EB13F083
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 16:22:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F1A830028F5
	for <lists+dmaengine@lfdr.de>; Sun, 15 Feb 2026 15:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CAA225397;
	Sun, 15 Feb 2026 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="NCrv89P/"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021095.outbound.protection.outlook.com [40.107.74.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA8415B971;
	Sun, 15 Feb 2026 15:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771168947; cv=fail; b=pIiJlS8mo/DHVCHZUwFA80qSagtCWG0axtpginqoCUyme5ijwUJc1qhaUILI3tyXVchrna64OzR7Lo6bPI2jkDNfRifFDSaI63wFrF5Knb4Re+AhOrQHufuBfg5x9aXb3Djneovx4vpZyygS1uvo4pM34OZUmJqaa3tRslUCxkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771168947; c=relaxed/simple;
	bh=bTARL1AMnq1pAy3Y2Gu3w5JMSA4m5yONM7OePDIAbf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pIH5Ui84eZV517D4UmWeg4pydptKrBrul1osq2BBp/2cw0dSE+PqsUnQJDSv1uCvPI5LqeQUoehxumY5Z7A6kaz+xEQLxbDQYFkpqPnQAXdClXx3RYu3siHF6LVe5v+pFTvWR6x2zxH2bhmtuvNmLyTaa40GAfQjwnQ2sy2+TBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=NCrv89P/; arc=fail smtp.client-ip=40.107.74.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2OL+TyzuP0XJ0guDpsVHu5oF/qZPqQZR4urfAYqtedZzt1CVjuuEL+5tSpvLyY5cVeP7WhB5HqkeFiHc2H6PulbQetrsftnUFxtp7vi54nwUm4A3+pkq4dy7Yajn0QlL3DXI/HftczqZlFfllSkkRZYGrGn3xqh8el1sa/duQHZw+Kl+yyTlILul7w95u7WnslRijBsd3w+Ii+3v1iPdUxVNz6QHVShb4gtp8DPTQNElEsB1ZaOvAvTy6jZ/QuQ274A2zWtpyTwPiS1n7Ai/GIsdlQytY+xhMmfxSJ4W0ooa5eIjOOX46PsNMa2IFM8LgijSP+2OtfmmebojeWiqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ta70QuzTjI7uIOdIjLxq8byIVKUZyve1TN8qJ9TI50=;
 b=UBkuOjxpXvHDoe4Z4cErVPveyDjcyVuYZkgZChDpWFMQc3xNUS77ZG+C7kB8CYU+mYX325gH0vL/FE42+uBjlGxNEV7vTd9//zysvEwOiQGfO+xC1iGF2vKrQlJnwrqdycqwcOpd0EM2QgDC0AikJ+JsaHQv8wRzhTucU8vArA17t+txtFoUJ8VKVLZ5I+EMOHZA4NjmMtnT4mVeRbRayvkM+/a8JCG6koENeTvbayiU5JLn0Ud1PkaQS+kzuxgFPB7uvH09hg/G2w5kkbzp/E5bWdlOuLU2LEAp3KnzsX6HNIz7Fe2uuEzrbWjHbwCxh7nxjoPpZg0GhO8EewCpZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ta70QuzTjI7uIOdIjLxq8byIVKUZyve1TN8qJ9TI50=;
 b=NCrv89P/p7dhqUn4GGzig5CyBm3ULdaWIhl4LIbCXHj0GSKVv0Il7Sn5sNVBWN8+FQloAGvpiy7vCjCRAv4QBd6dIM98g9rsraMnExLalqMq2YkPvoYFE/lljenkhTT7pPCgiR/uSOrkJpMy8/e3gWRB+9yBAoy606irR7i8BNE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2340.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:169::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Sun, 15 Feb
 2026 15:22:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9611.013; Sun, 15 Feb 2026
 15:22:22 +0000
From: Koichiro Den <den@valinux.co.jp>
To: mani@kernel.org,
	vkoul@kernel.org,
	Frank.Li@kernel.org
Cc: dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dmaengine: dw-edma: Add interrupt-emulation hooks
Date: Mon, 16 Feb 2026 00:22:15 +0900
Message-ID: <20260215152216.3393561-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260215152216.3393561-1-den@valinux.co.jp>
References: <20260215152216.3393561-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0319.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2340:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb0a749-189a-4236-5569-08de6ca6041e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6slVGgoZUghjSBhu/MI/pbrhHuvZowXy9Gb6WQ2w4mGhmGMs8mxMPVwQnTtZ?=
 =?us-ascii?Q?QBDNPE1uOMnNa/9bRGY0BHY3MLkHfqH+PevkEChlNKZooZcMRcKwCQ5JC5YD?=
 =?us-ascii?Q?ZLUZ9ry40eaiul4ajybq69588NaTaA0XX5Qcl8ReIu+cY4KW5OhS7Wooo9ic?=
 =?us-ascii?Q?Gur+wYgmDhP3nIwwHuvnDSRlKt0gJGx+CKR+4jGK74qZdb3Lq9YoLefuSSnk?=
 =?us-ascii?Q?ssUrNS9xH2TdJjyBP/3M+s8/dGq2Sgo6lUu1TjiaCj65eXL8ux2OrYTE9WmP?=
 =?us-ascii?Q?b+n0Y6U+fNFoa4LJwu5+NzeZdDGqXhWKQFB7s0o0iRuUpkutbGnLQwCcdsHz?=
 =?us-ascii?Q?W4dRQ+p4Yja/T1c2LmN5wvzrXj/9rrM595Kzr44uM+F5bXC0cXw+iWl0SSur?=
 =?us-ascii?Q?1QO0OhIxl4v1HKV8dCCbtAKGNnU770k/IMaVQf9w673s1rmz91B+15YRP9DP?=
 =?us-ascii?Q?Y3u1i3jtgRwbNViNeHHQ1QizW1dveW9j1u1eqfpOLfgsdL75XMyavIUo+/Ik?=
 =?us-ascii?Q?fU9FOiUKk3tVHbXpbhFF7cDd6bvuAI9NkAt6nNxW6ZKwtHcATDyWQrw0lUgX?=
 =?us-ascii?Q?8IdDucvjPaSwyDfp7yuyCZ/BrwXrgsHqY2CVmspxcJTqlhADSt6MfSY/2uSi?=
 =?us-ascii?Q?hh4QlzZAsZqO5Mgo0BO77RKuhwqcegS7GsILqo3rlXDpdiVJG098FWECloN0?=
 =?us-ascii?Q?smn8lhULz9Er2JXAo5uvC4VDA8NMf1/9DfcFhSdP+A9btJ3uNABiO2S4X7lP?=
 =?us-ascii?Q?/aa5ddE5HzNjcxQcx9yVyV9pmdMNBsZpN/V7COWh/sO/CgOiviFUNO9VTLbu?=
 =?us-ascii?Q?wFoN3Ojweq+TI5UPXY5OEtFxocFxRpA9kt1lMYTuJqqZke4lFXn6BoJkG8NG?=
 =?us-ascii?Q?sRG/zT8Y19mXQm4+lxtMozif1sv63eXuODKFTeaRnHzN1lkP7z76zAAOCIWi?=
 =?us-ascii?Q?bZbFXOft7iUdu4VNjh7ys2Sk3YN/AzqvDNLyxbDZZVGrYIWPKPWvMPlGBY28?=
 =?us-ascii?Q?OttFZmtTUTLUqWwm0cItJIXzfdI/NCDOqudUKbbTvga2VD7h/gtPMaF1aUGb?=
 =?us-ascii?Q?FsIS8G1sD/sD1o4kHQXgycFsJGSLXSEqNmld08z9Vkkq1MfyyGHIcdRVWZjG?=
 =?us-ascii?Q?D2r+hGVbEl297QB2WvyzrvYMT4YXUJ6mJPYpGhN/tRwi7hxc5jtTQV7lJCj0?=
 =?us-ascii?Q?xF5DbEDYQAfD0Q45fDCYLOsgh8WI7rlbWZuOW74/gn25mkhXUK0NdlriaNy2?=
 =?us-ascii?Q?UdqOKfbA0/vwE9vxUqmGxOXBkY8pCwoBZQur2R6X0dv6j4MF1/F8Z+5iD1Lp?=
 =?us-ascii?Q?l8QafXmyFBWCNdhcEDeDHw3jYxEVGQRxFuHUYxVcZtS0jHydwP+Q+4KZOu/I?=
 =?us-ascii?Q?wPnxbXVNKigNZ48AyXtXdWQfXcD3b8ZpZNB6qlXDvt9mZuIfGxYw05il4fsu?=
 =?us-ascii?Q?fSRJwOkuhUvzRmkEBJAlT4o+0bvxD6lG7Qh0fFE9OkFMPQC3Ljco3zIeh1ic?=
 =?us-ascii?Q?YaEEgTQdYSTM8ie0hStWVc9mKRRulfPfmOZv6yEoY7Dkf3cbIyI8GqdmKin3?=
 =?us-ascii?Q?LH2vNVKSekAedXpg4q0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?57VqcxWUBqUy0m9C0atVsTl0I0ptXuhBNkvDKA2KS8N34SJzal/tTTENEGGA?=
 =?us-ascii?Q?vuf5ZPYbf1nnm3og/vlDN+yH1bvPn4I7KztLK1V55Vq7fih1KzBFQZXmuLpY?=
 =?us-ascii?Q?PxGs+h6L7m5XIHjNdABHGPp6tPF6WeWQNkxrvavoMmoc2ESDd+6ICWHmGK/R?=
 =?us-ascii?Q?/jJjHuXc8gWquFDogu3MDlpVh9OtwLYqglmbXsOrw8vv0jIU0W3qud8P5mAw?=
 =?us-ascii?Q?4XQtvx1A0Bspzbq+/DAtULQsHqd3qFYXETtiwFxJYrF86CO14AJNBn8z/o4r?=
 =?us-ascii?Q?OVsH/C4Qr3WNMJWUWESWyoNFKNGfJ5Z9N9y4kftpAWNhluHDK/zs9s1PUiz4?=
 =?us-ascii?Q?sPgjWJYb8XPA3B1Ye+AWlr7voJe+oVGkJm4S9sSiQ6yEGH9OyreUvNlIQbxn?=
 =?us-ascii?Q?R26xGtNQKHRjXZTtgC6O4eww2caaMj6Vsmamozk9ErSN41f3wvxqGrvqk/7d?=
 =?us-ascii?Q?mfovJcgIjhERXHonlQ5xQtc2d+JcIuGw3kn0fPn+duvl+mSle2APNTnsV6MZ?=
 =?us-ascii?Q?sHLeY4tySzY0zXjFGjcaUD9VqmlXo3ZpPNdt3A5vVWtRd6QhBvHmfXZoLScN?=
 =?us-ascii?Q?O4mMJjA1HDuiwG9nOA6DLIouvzD8TvAOVzI5IN0lDifUzHNx3h94XcLXSMRG?=
 =?us-ascii?Q?NEgMe1t9CS4foQzvLN8daY+fWg/2tGqVMPULYXonAo5urkfIZuq95j8+KQO/?=
 =?us-ascii?Q?QKNh0ahSHmfJnWLGsi5EMziyNqor2DKkzLi11wlv2DPC1NmtJC/VEHurakBt?=
 =?us-ascii?Q?yTbGprXhnJuxc0AbKfXsfFV0Tm0oEYP8glCCVh/i9/F8cxqlErJ8NSrdNwPx?=
 =?us-ascii?Q?Tx45QBYUHJEEQzEZDQkkJKPVZjms/NnUyhZAP8uJ1t+XEuQRfPrl72xGRTRg?=
 =?us-ascii?Q?DTDERu6sBKAtPh8xDzCAdW/tW3NMQyXBHaqy3F767YMW+43DVHjz3/b9vGm7?=
 =?us-ascii?Q?YdFvRipKV8na8B1cUxlPEfvz+DwruDps8umbnjwVeryJKkZW5rUt+vcs2oky?=
 =?us-ascii?Q?NZdv4HZo915qiVj3Li5nosSLIVpM4hfJrOItp3QbbntrrjR9ibb5bORan03H?=
 =?us-ascii?Q?uJGlNPh5t2hDX8Bmc7QupaWGjkDiBqFFPSWqGbR+gpO2sfcXQo95Z1ZrXs7q?=
 =?us-ascii?Q?sJj235xiLPgPtxQQX7cOW16iizXJxutWyQRJAXcxtkA3szNRjzJiAV1maDVp?=
 =?us-ascii?Q?aeZskavGqA+/WRp9ae4g1CJfUVdVPqnEk3FgQeK06IEW8c03OfcOZdqjP+RK?=
 =?us-ascii?Q?qEzJi2BZnm4G96idFOcSK32qp7XVcRZ4K9mePG16jYxNx0q3KteOZjK1/tvX?=
 =?us-ascii?Q?zsr3wEYR7ZZJhCbsGmlzJOB1jecVlzoxG6JvNa3li7V7V1fj09V3thjtVOMD?=
 =?us-ascii?Q?1+L6994H4ZfODCf4kj5qzzLQDjaWfIIrVsdfjCS+HwKMcA/7FCh8yuPhrJzv?=
 =?us-ascii?Q?l7yMm2c+Gny5FTxer22CDScUdjG0QGdXOYgPiVtCCIeFI0/Sb2WL+lLIpAS9?=
 =?us-ascii?Q?9DS1hcAaYlcjPyRcUFp6WJchxpaFFh9SNdqYeqIuBJDCWyu86fumXvzf9BrN?=
 =?us-ascii?Q?JWkmpDVhAOeUip5MG5FxyGpzNHN8akipMni6Hp4rUwax/1SCnjCoeJyF0tNm?=
 =?us-ascii?Q?tn7Za76aGFa3sH4fqQSfbby5OhyANfd6Xr2amdimXwmCY6C4NAv2QmIGbRq6?=
 =?us-ascii?Q?detVotC4t3Z6BSB8hMWKdpBj0QNjVzgDNUTPL2K4yJjAWohvcWFNaiH9wUyC?=
 =?us-ascii?Q?9qXlPxN4SJWdM3wFff76NwDOQhxGmJBYvU0GbFLSMC3oupYjqPYn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb0a749-189a-4236-5569-08de6ca6041e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 15:22:22.3057
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AA7HrDLIOidOwybHw16y3h2mxjDasTlP90XmtGwtQjG+5qYa+nJXnnC0BrOaSE+/lf0iUB36V/jRPSnW7VH9cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2340
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-8904-lists,dmaengine=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[valinux.co.jp:+]
X-Rspamd-Queue-Id: 398EB13F083
X-Rspamd-Action: no action

DesignWare eDMA instances support "interrupt emulation", where a
software write can assert the IRQ line without setting the normal
DONE/ABORT status bits.

Introduce core callbacks needed to support this feature:

  - .ack_emulated_irq(): core-specific sequence to deassert an emulated
    IRQ
  - .db_offset(): offset from the DMA register base that is suitable as a
    host-writable doorbell target for interrupt emulation

Implement both hooks for the v0 register map. For dw-hdma-v0, provide a
stub .db_offset() returning ~0 until the correct offset is known.

The next patch wires these hooks into the dw-edma IRQ path and exports
the doorbell resources to platform users.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/dma/dw-edma/dw-edma-core.h    | 17 +++++++++++++++++
 drivers/dma/dw-edma/dw-edma-v0-core.c | 21 +++++++++++++++++++++
 drivers/dma/dw-edma/dw-hdma-v0-core.c |  7 +++++++
 3 files changed, 45 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..59b24973fa7d 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -126,6 +126,8 @@ struct dw_edma_core_ops {
 	void (*start)(struct dw_edma_chunk *chunk, bool first);
 	void (*ch_config)(struct dw_edma_chan *chan);
 	void (*debugfs_on)(struct dw_edma *dw);
+	void (*ack_emulated_irq)(struct dw_edma *dw);
+	resource_size_t (*db_offset)(struct dw_edma *dw);
 };
 
 struct dw_edma_sg {
@@ -206,4 +208,19 @@ void dw_edma_core_debugfs_on(struct dw_edma *dw)
 	dw->core->debugfs_on(dw);
 }
 
+static inline int dw_edma_core_ack_emulated_irq(struct dw_edma *dw)
+{
+	if (!dw->core->ack_emulated_irq)
+		return -EOPNOTSUPP;
+
+	dw->core->ack_emulated_irq(dw);
+	return 0;
+}
+
+static inline resource_size_t
+dw_edma_core_db_offset(struct dw_edma *dw)
+{
+	return dw->core->db_offset(dw);
+}
+
 #endif /* _DW_EDMA_CORE_H */
diff --git a/drivers/dma/dw-edma/dw-edma-v0-core.c b/drivers/dma/dw-edma/dw-edma-v0-core.c
index b75fdaffad9a..69e8279adec8 100644
--- a/drivers/dma/dw-edma/dw-edma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-edma-v0-core.c
@@ -509,6 +509,25 @@ static void dw_edma_v0_core_debugfs_on(struct dw_edma *dw)
 	dw_edma_v0_debugfs_on(dw);
 }
 
+static void dw_edma_v0_core_ack_emulated_irq(struct dw_edma *dw)
+{
+	/*
+	 * Interrupt emulation may assert the IRQ without setting
+	 * DONE/ABORT status bits. A zero write to INT_CLEAR deasserts the
+	 * emulated IRQ, while being a no-op for real interrupts.
+	 */
+	SET_BOTH_32(dw, int_clear, 0);
+}
+
+static resource_size_t dw_edma_v0_core_db_offset(struct dw_edma *dw)
+{
+	/*
+	 * rd_int_status is chosen arbitrarily, but wr_int_status would be
+	 * equally suitable.
+	 */
+	return offsetof(struct dw_edma_v0_regs, rd_int_status);
+}
+
 static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.off = dw_edma_v0_core_off,
 	.ch_count = dw_edma_v0_core_ch_count,
@@ -517,6 +536,8 @@ static const struct dw_edma_core_ops dw_edma_v0_core = {
 	.start = dw_edma_v0_core_start,
 	.ch_config = dw_edma_v0_core_ch_config,
 	.debugfs_on = dw_edma_v0_core_debugfs_on,
+	.ack_emulated_irq = dw_edma_v0_core_ack_emulated_irq,
+	.db_offset = dw_edma_v0_core_db_offset,
 };
 
 void dw_edma_v0_core_register(struct dw_edma *dw)
diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index e3f8db4fe909..1ae8e44f0a67 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -283,6 +283,12 @@ static void dw_hdma_v0_core_debugfs_on(struct dw_edma *dw)
 	dw_hdma_v0_debugfs_on(dw);
 }
 
+static resource_size_t dw_hdma_v0_core_db_offset(struct dw_edma *dw)
+{
+	/* Implement once the correct offset is known. */
+	return ~0;
+}
+
 static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.off = dw_hdma_v0_core_off,
 	.ch_count = dw_hdma_v0_core_ch_count,
@@ -291,6 +297,7 @@ static const struct dw_edma_core_ops dw_hdma_v0_core = {
 	.start = dw_hdma_v0_core_start,
 	.ch_config = dw_hdma_v0_core_ch_config,
 	.debugfs_on = dw_hdma_v0_core_debugfs_on,
+	.db_offset = dw_hdma_v0_core_db_offset,
 };
 
 void dw_hdma_v0_core_register(struct dw_edma *dw)
-- 
2.51.0


