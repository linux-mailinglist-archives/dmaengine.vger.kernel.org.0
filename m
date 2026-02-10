Return-Path: <dmaengine+bounces-8861-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMLMG8qPimnuLwAAu9opvQ
	(envelope-from <dmaengine+bounces-8861-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 02:54:18 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B8711616E
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 02:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 82BB1301AA8E
	for <lists+dmaengine@lfdr.de>; Tue, 10 Feb 2026 01:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50BE2868B5;
	Tue, 10 Feb 2026 01:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="A7w1IDxq"
X-Original-To: dmaengine@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021132.outbound.protection.outlook.com [52.101.125.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94735898;
	Tue, 10 Feb 2026 01:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770688455; cv=fail; b=cIG6STyL/D7iXSZO1iGdVQ16wh87G8U8UkWWsoC5zAdizN5ypdH+s8l4M74KUMwSOZ4/8GfvBJMLklCgBYeAXFKWQ94hjU/rmkj/cUbevXsmvKEm2OBhRAYYfEgSsSi2GBKWpioxKGU29oSuJIEAWwirRvJIqJIbF7Zdh5stN4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770688455; c=relaxed/simple;
	bh=/BfhdbTaoZAzJMPK3obLxCxq+6AKutSkQv78sazMVtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oFMOID1o2nyyRSZfbGUTVEmQlyBH37+NhslmGLPULEqepilDhaymxkkMYguz0xu3Y2GPlpVcC+/csObDDqnu3F9sQqCkLUDV2yiCB3yJB/Z41HCD0MXoTaf+/s3ZE8lRV0us+ZT5xa9OrA+A8M0r8Uo9zzvMzwV0p+0MrzqcaG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=A7w1IDxq; arc=fail smtp.client-ip=52.101.125.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FESXQb8WeZcNrsKjOIAlA6JvcDjNS7U7bo17TzJnA5omnH5V52ESUX8C5uO/CcVYGHlF7mj87iYUS7i/blMY1x/38yleVmAovzL45u7jgnMf8bHQUcwW8PL6cbORLstEBmPsEEEprJEZO9hb4cmRtxnIYC/AlGmtj6mR2WojCnWr9I5nvAUjcy3giVUm31gQB5n18K/kMOIhlL1PdYKqhfC/kzBNEAL5iHHhY7xA9pT9UreMVycgRLltnH247IHK0f55mchmQHrnCqnn9VSX/fY2VKg82c54XHyR9TJ1mZNfVPQagLeQF+hFgwZyKHqjtNQPRHPusiCEi/gheDY9TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MqAV/OSpIWBAfApAD7L5TbegQxQiDC6axPEdccYaHY=;
 b=cveSYqY4wIf/DrIhws6tq8Kuk0B37diikDk4bSMF84OeKnojDA9kQOZEeKl3ly5xQDJgHWFpV+Rfe0z/DjHz8es6eA7GxTeSmQwuyAqH4BLAI1KYhoyfNsFbweL+yMf409tV2rSKsDxRbAjDnPVbzdhr+zJKGORoU2bkx2sFiIvLPbsXUdNUhz1lcVBfY3v7JXYWLs5/LWP7+wD5jxabQXAeXbHZdYdS6mrqdKOvelJmM3B3belc0GsfpQVnN4rtmghwrUFItNuv1KjSjIF2q2OZAewbI/YSq/HIwSXhUIZORf/vUK3s7NVnSdCks02em7LVpAfi67RGvNuhfmqkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MqAV/OSpIWBAfApAD7L5TbegQxQiDC6axPEdccYaHY=;
 b=A7w1IDxqAGiNp5vkKw8N4fhkRdDQqGJGQzN7VCwwKCRdejv4EYaDM/3AXA+Tz4UNzVk3fcTX4aOMldDQkXfta4zWegJNTEBv035hagbqJcGSkG5PtKpJMQZ3ONPnora4Chff9639LxtQEjItza9mGzklGfKRkJHX5RmWP+wS3Sc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYRP286MB5164.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:112::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 01:54:10 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9587.017; Tue, 10 Feb 2026
 01:54:10 +0000
Date: Tue, 10 Feb 2026 10:54:09 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: vkoul@kernel.org, mani@kernel.org, cassel@kernel.org, 
	jingoohan1@gmail.com, lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, kishon@kernel.org, jdmason@kudzu.us, allenbh@gmail.com, 
	dmaengine@vger.kernel.org, linux-pci@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/8] PCI: endpoint: pci-epf-test: Don't free doorbell
 IRQ unless requested
Message-ID: <wmknyohclurvjq5y7ssuuivjqr7gpy6azttzgjvf2dmhnh3gck@5oeirc4cddtb>
References: <20260209125316.2132589-1-den@valinux.co.jp>
 <20260209125316.2132589-7-den@valinux.co.jp>
 <aYoD3V9X9H0sQpdY@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYoD3V9X9H0sQpdY@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCPR01CA0176.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYRP286MB5164:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ac94d0-588c-4d06-ff36-08de68474882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|10070799003|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dhuXn1H0XNUS6HQBXGOiOr/N93zeA9lYILV4zntfFpiaSe4eLFf14lHwYiJn?=
 =?us-ascii?Q?SPike1u7/QvYpCccIzBAkoJzLievHeKuoyA3znROUtlWfQhtpaKnRIwRISk7?=
 =?us-ascii?Q?ppzYQ+DctW4iUYkuel4FzII7HyXWiyNCWCDUU1v9fF8NO+DZNATuMSQdP1ya?=
 =?us-ascii?Q?pRYQOWMIdyJ5IIcghGNW2XMc6CqAVXO/1A/QIsE5f3Oz2mB+/lAoO0EKZnWR?=
 =?us-ascii?Q?kVv+0TWdYFtgpNO5o1D5OJfnm8/SUgckYWkbE3Nsm62kpqJF4emJeRWD5zhc?=
 =?us-ascii?Q?gnzfr63r72KkRRTD08hHmHldJVJoCDg6oPxg6Ku106AZYcHZF945ROuQJOl/?=
 =?us-ascii?Q?XSa+ko3lK91XeoXxPaLCEob1SCtEH9VN/p0Q+obriG3fNFFdnq3wcvAVB188?=
 =?us-ascii?Q?10pcduWwFXNHJIQwXvd8Qwdi3sh8ZUnjHzLu6VtrW5ZErwVUUBQWQFZpoQWP?=
 =?us-ascii?Q?nu97e2J6xQV/FT+SlfnRAsjuwfE4kp5AnsrUyWg5hA4XNzEmHfv7hLNVnQMM?=
 =?us-ascii?Q?OlZkzO0vw1plwc2X4an5XKHF9IplG2RfW0KgbBd1G+qr3n7OF9DOAm6xI9D4?=
 =?us-ascii?Q?NUnR4mTnpsJLCEaajZTzhcqNnUyKPsmmHL6WbhLPC5qJT2aUi5skQPmfKhr+?=
 =?us-ascii?Q?BEFj+PAKrfjCDRqujhuSCPYsWy11z/4tgQmYQpIw3TvYjUjZf0ugjvVa2he0?=
 =?us-ascii?Q?FExoncPRKIjNXMmH4LJryJ4HQoBXqfdeH0+SLv56e68dpoHScuuD6R7OKLsX?=
 =?us-ascii?Q?3KKSgDzfuRzDURtmGVYTRd3GyzFlHlKC0qB6Bz2MQfe8hrtFNX2PBWn1+yfi?=
 =?us-ascii?Q?eYXR0793PksU+rnRDDUbzbEOoH9cL1Cf22KHQN8mh8J/oP5XSu35HxrkvXfn?=
 =?us-ascii?Q?Ws5fIcphkg1e6SwIRmZd669pa6K9Xq6Rn+Xn3YFFAnSIgXPG/LTSoKF2hv4K?=
 =?us-ascii?Q?+rCjOgYC20g59G+18GSECDjdSs+M16wjqEQWkvUVSGtQOde51fvvDVsUKWxc?=
 =?us-ascii?Q?8ScQ9wY4wrF7yekeLzPL3C9PbVZ8dy+2gQnS+9EbiRwZoa9xwWBoYHjnqHBY?=
 =?us-ascii?Q?40iw0xgdwaHKiiI+w7/1zjkm1CNxOEfGFnpu+k5UrkM5QwzJ+Da/U1QV0mDz?=
 =?us-ascii?Q?IiIErRhFt6X53SeMlEt7L9T0WsRraryt2DOt8zl/hypoLJwyQ7bpNWX3Ak0A?=
 =?us-ascii?Q?2voPFQQVr1KZRomJmckrr2ZgmDo/VwzoRGhe8FagDPQIJuPeeSr8Pq6d5nSR?=
 =?us-ascii?Q?OE1kBSfLioXYncgLGYfz28Az8BjCSnSEGTyCkPnDTSsAd0YKCtaOy+WOYtIg?=
 =?us-ascii?Q?SZl4SiGTCJMKHpIi4pMXGxSzCGUQkoCy4fUwxVvrfsh9+LQZe1mb5LhXWVzN?=
 =?us-ascii?Q?38GEarmXKWAaggMshfC+l2lzRJRrpezM8ApCCEobEHUCdOkeGhKLcSl1ycfr?=
 =?us-ascii?Q?J9QzIOFyA47cuJsA4FVmaz4VKFg+j1ksF+hvUuQjlp5UhrDtsWobC+Pl6Tr6?=
 =?us-ascii?Q?PLDbqETRc73UXu8ycBXa7f3/5erQ6j5+bSN621/1rVeQx/HkTgDysyf+S/6l?=
 =?us-ascii?Q?B2r9zBnz9R+Yw3W4fyA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(10070799003)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7mQQJcIap1OA0oxcGQMn9Wwr+Y4KH44IJ2KKUL/OGbxuymB1Kc0251HRw1dH?=
 =?us-ascii?Q?Fk1bsx7M2dZMTvR7w1TSFcaMcmndwJ5gLYVvI8TZIHrobqR9+3FBm3yWKcIA?=
 =?us-ascii?Q?XkQwD/FfH0dB5qpIky1g83kULFSO9TUMFtdGyJp2xjZ7C3mOalIAPNku9WTc?=
 =?us-ascii?Q?HB+/L7t0aFo/JoAFK8G94AcKCNGb8Wk7sOWjtA3yZ2U9C3wLoyiPZum1ORAr?=
 =?us-ascii?Q?FMsHRVXHv6iF+s2p9yDnncGYcYUdXxVD4MEzrBWV895+5+lnbxOeQFIc026T?=
 =?us-ascii?Q?DDtO/mI61H9kVSQxPu81LmJ0WCxLM+MJcPa6eV6gWWjt6Y21CnP9DbcDX1vt?=
 =?us-ascii?Q?BPOxrzF6AsTbQCI326iewb7qTIHTYJU0rLj/lmj+CWr4QgY4sNXYIoOs4uS/?=
 =?us-ascii?Q?3g2HKa0NpYiMjl0tW01lOyfxSi88+D9GrCRwDUZLz3er3vxhajTLnjaVJq+C?=
 =?us-ascii?Q?F/SyPGsbfogIEq6L6+TIDT3RosuJz2R59rRN+zQy2PBmotfv2RKd6aSAMCac?=
 =?us-ascii?Q?EfXb1WBuCtwj656fHUXBwypfi/VEE+SVOBX5uxrxoMHuNw9uT0kaIEHqxfut?=
 =?us-ascii?Q?oVmGHlyUkUg9rRvA+Bv8qMfu1yN8uNYIOh7C+8bO8J0Kr6hmZ3TPd2ZJzjSW?=
 =?us-ascii?Q?TdZ+XVfgg+lTg5Z81q815vXrdMsHrQvE5AAdywVPov/iI6ITOBQErPcB4UbJ?=
 =?us-ascii?Q?xt50ku/jlE9iKH4/QpJ3ntgLI9HSZuRHuLTXWgWi/ee1drNKuKEpxMqxcFNx?=
 =?us-ascii?Q?CXHh3wOuzyR7i0c7EMLFldLIq1WcyDzmAgGLxVMQfpKfwWCzqE/I2UqJGb1G?=
 =?us-ascii?Q?StmfVAvYIUcT8dhAayhiIVlWkthOZ4BNLD5FG8J7OghsNJta1v5mdbG9pi84?=
 =?us-ascii?Q?bPCKWrB/UVK6YJv2uYDAQF1/WRd59y7Y7FqSjQpY+O4AfX5JHyf4M59wcCM3?=
 =?us-ascii?Q?mVnIbPuqGc9jg7UT1CkfZcCKfKEXk3Q2bI6dzIi/wcA0FTdoi01lr+MZeLYA?=
 =?us-ascii?Q?tZcFbsb3E4ka44IAJ7AZTXajqJvPhZ10FDX8saFRro9zybNmQoCwJvVmfyBS?=
 =?us-ascii?Q?a0dZ2+U5SGUJX77dL4TRL3JHBOMRLqba7gMLtsQhDqhbQUsQtkdswoB5yNgt?=
 =?us-ascii?Q?HNT4TvYyzhmCe1yCEMLO+EXqfGfSWibltsAITKTAnIqu6UWHimxG6zGGSecb?=
 =?us-ascii?Q?HjWvepXB5rNI1GHJkzw9gnFLpJc3KH9c7+FdaecytGyFZrbtCThl5OJeTInp?=
 =?us-ascii?Q?CnS9gb5nwHB4V05LRZfVBsndR5LyE4xTmNMwiQEwVNqi31FpOQMviWyJcO4L?=
 =?us-ascii?Q?iaWKh7a/fYSz+ECL8W2YKo1yEmbozw01WPoqQTkiVYb9l2tOoSiTbi4eDSHc?=
 =?us-ascii?Q?U7ShMMsqpk/FQ1zX5kjuqaE2V4qeSsaAna3P52+IelCoEW5R7BYRpLVrW/r4?=
 =?us-ascii?Q?tNWqolYc2fLZXVuGKoq3kjv7dFKslmtP9cy4WjXw3SqdLkaM9hxu9miUo4g/?=
 =?us-ascii?Q?njCqpJiCVBLz5h137BRpHvVL+kRWznNz42OQeyse2XO+i8wNqwto79OEIIDN?=
 =?us-ascii?Q?hJB27KnyhvXTsjQuSmGRkBPrWPFhSm2AMvkGolaYFFRocr+HKjixpL3zcaMg?=
 =?us-ascii?Q?GXd17Gzg6H0J1rS8abRF9qyDfV/yAkdqoMJg99I4TXpj3A+N0ZhJJ8KFGObC?=
 =?us-ascii?Q?JnrpAg3tfu5hFTOTEHfPMI56OuHzQPf9jZjxhw57pETC6M/eRjgxH69HnZzn?=
 =?us-ascii?Q?oPrTxPDlbf3upMGnXuAoQsVin6Vy03GWA0uaKkbklGQsdQqY7zRy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ac94d0-588c-4d06-ff36-08de68474882
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 01:54:10.2561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v543q8RxfOuI/x/2Zq1sDu8pwRKJqmMHApVC863gy8JsdMsn65REnld86MuHR6WjRSevhpN2FkFbTycCpAuAxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB5164
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[valinux.co.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[valinux.co.jp:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8861-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,google.com,kudzu.us,vger.kernel.org,lists.linux.dev];
	DKIM_TRACE(0.00)[valinux.co.jp:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[den@valinux.co.jp,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[valinux.co.jp:email,valinux.co.jp:dkim]
X-Rspamd-Queue-Id: C3B8711616E
X-Rspamd-Action: no action

On Mon, Feb 09, 2026 at 10:57:17AM -0500, Frank Li wrote:
> On Mon, Feb 09, 2026 at 09:53:14PM +0900, Koichiro Den wrote:
> > pci_epf_test_enable_doorbell() allocates a doorbell and then installs
> > the interrupt handler with request_threaded_irq(). On failures before
> > the IRQ is successfully requested (e.g. no free BAR,
> > request_threaded_irq() failure), the error path jumps to
> > err_doorbell_cleanup and calls pci_epf_test_doorbell_cleanup().
> >
> > pci_epf_test_doorbell_cleanup() unconditionally calls free_irq() for the
> > doorbell virq, which can trigger "Trying to free already-free IRQ"
> > warnings when the IRQ was never requested.
> >
> > Track whether the doorbell IRQ has been successfully requested and only
> > call free_irq() when it has.
> >
> > Fixes: eff0c286aa91 ("PCI: endpoint: pci-epf-test: Add doorbell test support")
> > Signed-off-by: Koichiro Den <den@valinux.co.jp>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 6952ee418622..23034f548c90 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -86,6 +86,7 @@ struct pci_epf_test {
> >  	bool			dma_private;
> >  	const struct pci_epc_features *epc_features;
> >  	struct pci_epf_bar	db_bar;
> > +	bool			db_irq_requested;
> 
> Prevous patch clean up epf->num_db = 0 at doorbell_free(). can you check
> epf->num_db ?

I don't think so. epf->num_db tracks how many dbs were allocated, but it
doesn't tell whether request_irq() actually succeeded. What I'm fixing here
is the case where the db allocation succeeeds (or was already done), but
the request_irq() fails. In that case we must not call free_irq(), even
though num_db is non-zero. That's why I introduced a separate
db_irq_requested flag.

Thanks for the review,
Koichiro

> 
> Frank
> 
> >  	size_t			bar_size[PCI_STD_NUM_BARS];
> >  };
> >
> > @@ -715,7 +716,10 @@ static void pci_epf_test_doorbell_cleanup(struct pci_epf_test *epf_test)
> >  	struct pci_epf_test_reg *reg = epf_test->reg[epf_test->test_reg_bar];
> >  	struct pci_epf *epf = epf_test->epf;
> >
> > -	free_irq(epf->db_msg[0].virq, epf_test);
> > +	if (epf_test->db_irq_requested && epf->db_msg) {
> > +		free_irq(epf->db_msg[0].virq, epf_test);
> > +		epf_test->db_irq_requested = false;
> > +	}
> >  	reg->doorbell_bar = cpu_to_le32(NO_BAR);
> >
> >  	pci_epf_free_doorbell(epf);
> > @@ -741,6 +745,8 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  	if (bar < BAR_0)
> >  		goto err_doorbell_cleanup;
> >
> > +	epf_test->db_irq_requested = false;
> > +
> >  	ret = request_threaded_irq(epf->db_msg[0].virq, NULL,
> >  				   pci_epf_test_doorbell_handler, IRQF_ONESHOT,
> >  				   "pci-ep-test-doorbell", epf_test);
> > @@ -751,6 +757,7 @@ static void pci_epf_test_enable_doorbell(struct pci_epf_test *epf_test,
> >  		goto err_doorbell_cleanup;
> >  	}
> >
> > +	epf_test->db_irq_requested = true;
> >  	reg->doorbell_data = cpu_to_le32(msg->data);
> >  	reg->doorbell_bar = cpu_to_le32(bar);
> >
> > --
> > 2.51.0
> >

