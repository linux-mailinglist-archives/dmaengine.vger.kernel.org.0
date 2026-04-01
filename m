Return-Path: <dmaengine+bounces-9816-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGiuDhCgzWm9fQYAu9opvQ
	(envelope-from <dmaengine+bounces-9816-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 00:45:36 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A0E38117C
	for <lists+dmaengine@lfdr.de>; Thu, 02 Apr 2026 00:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 44E7D300460D
	for <lists+dmaengine@lfdr.de>; Wed,  1 Apr 2026 22:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1183EF679;
	Wed,  1 Apr 2026 22:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="aQgpDe/k"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F41F385535;
	Wed,  1 Apr 2026 22:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775083531; cv=fail; b=AJWfiM6VJZl6Z7F369k4MXh+YQ0tj1fQCNY2gG6QH3bTJkKtB0w7hVds3uo7Joxy865Ma6HiqFmb6W5EdsRzwbdC+ndUXLNx0UFDSU6cXwPW219UZS9aN+VqEdLyBDDUKCFU8TKY+o0QH/V76qNLj/nMTz3BoSxJp0JvvVz5IDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775083531; c=relaxed/simple;
	bh=0lHeypFDXWtVy4DMhQwx91LTAvkfH4pM0VeiVaMXUEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AdRJqeVtiQf0zaVh/zNFdykCZuLiPbH+4g2poRt7vecN9X/HWl2tgC45xb1uTFn4oVI+A4K13JbdHkNZAQtjrIblAhLs2av7xJlcTLeHzWxn3iQ63HV1bks3wJBke3FC8YXnPVUKHxSvyK+3m+q/L6TQTQbjKyA2/yyevRx5IHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=aQgpDe/k; arc=fail smtp.client-ip=52.101.83.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GNynOyzx6FpJFM6/YOI7yqniul3TGSPofCum44lvQICi0O6Mcfn7OThf7bZDOHd9RgM1Mki0n9xS0/hsQCovTYUXNPbvNFsJL47V5sLh3XMa3TaCvHcDrafeQTqW/XBunAlHztYkQXa9NW8Bai8h2r+FWaWQ6Ma33mMTm/aW3Qhj23WKX9HuZGh7o3CG4JEe3fCPHMYvEd+NWgs7eYAY/+wB21wWbGHvui6cvwbpk1OzcZJDtImlDn2L/oA1H5zoJwwQsF6BCEUYy+h4TOKAnzJBlU69EYtlqj4Kqt9XlMmmce5FVBn971kLGFXLRzM7b4FaCoQl8pGmHmNdkzK9NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kBNo02HE+cB6L+spzkDhAluBu18nzaLYJ5piMktZMpo=;
 b=ZE4CZgROIN4JxLrgkvGMk0OczDxiW/j0+4135xr4x4dePBch23aEhFRgfWhyF/GY6zM2hwvLQhKfZUXGS4kkbJKrLX/GbxydEct9IocD73X/7OqpQVK7aUbQn4niMfAdnCW8epxHzGEpLwmybABDrvBwBFXd2+g+iDbIbWqq5iqoD1ZuaAjZJz4O1xd5oLmqvsYSnRuImRPAlNUNa+bi/cvIClgkckAKJtSQ6pioeyIx0N6ftM93dRibVFG+NaEtOhTIu5lbwd/yqwEgMSodldk1filcb30it6J4wKFKpOMRgXLYXThggNcpysqG1AwEhhnIa/QxQC6gPJEjJCOSyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kBNo02HE+cB6L+spzkDhAluBu18nzaLYJ5piMktZMpo=;
 b=aQgpDe/kkIpQrrdFiYbSCxbgVZ6ZogNJ7IkxqzFUoQFJkCiyYlU91P/L9IER+tcXON5pjePx8uXGxxV2pyKbudnsNSZonihAGfAwE/k+N4gsriXoqbTYyxUmE0/BFHCnisN/Wz2zt3Pxd52ltjtG0U7iyQwXoQbxESjDtWOXRrZgSF5OhvXnMaRBEe4nkNiGjRdklbb+pJTTAmwQ64Ysm89eqJ94JuWy5wLA9x/s6doj7L94YH4kRPgpDr5g4PyBsP1g/eJnwTk54uSOpPzURCfpghTToWThypISavrFOiNGjluVTg8fFt+RdxWjNVNvMqqIINsgHFRuuSguN3TPEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by VI0PR04MB12234.eurprd04.prod.outlook.com (2603:10a6:800:332::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 22:45:20 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.016; Wed, 1 Apr 2026
 22:45:20 +0000
Date: Wed, 1 Apr 2026 18:45:12 -0400
From: Frank Li <Frank.li@nxp.com>
To: Alex Bereza <alex@bereza.email>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	Tony Lindgren <tony@atomide.com>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dmaengine: xilinx_dma: Fix CPU stall in
 xilinx_dma_poll_timeout
Message-ID: <ac2f-HV3cmNeQdBb@lizhi-Precision-Tower-5810>
References: <20260401-fix-atomic-poll-timeout-regression-v3-0-85508f0aedde@bereza.email>
 <20260401-fix-atomic-poll-timeout-regression-v3-1-85508f0aedde@bereza.email>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401-fix-atomic-poll-timeout-regression-v3-1-85508f0aedde@bereza.email>
X-ClientProxiedBy: SJ0PR13CA0138.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::23) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|VI0PR04MB12234:EE_
X-MS-Office365-Filtering-Correlation-Id: e292f762-d4ea-405b-bc1f-08de90405a5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|19092799006|7416014|52116014|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0Emf8DrmMQ74R9R3JV2wxSxD2V5Z5Ss1ZuKic/S6Mm0xeed+uZYwVI/lSO5HCWTEDLXMl8s5bRheEcgbuwmsLOzsGLTR4D6HMr+rTS+5a32LlXT39S8618lpDtuWtKSZ0+vn84Ziox1xkNKQ/mwdL6E3bw9c+9s05mp63wj3mDve77k8EMIhzwSsYB1vSpon2zd7JQN0ZuXSM2pBvAKLys1alGgInwCxQnkB/iLP18a/OZjlB1+I/0qWTr0qkzyxJNOLnRig04LzHJjNljJJwGIcFw7GkmphOK3/x1VV6hgVi7kcPCM3o9W1di7QH6kVPOrZzgCdnpyxn/phvY5jt28gW8BOhcIx8HWRIY0MRKRlh7JBYy6l+day3P8oAD6PgwHIPdfKeJfJQRgkPb8VtGS68bwdrbFfee3IMIluk2zzCGVROlmy0g8A1/cEbtQwNkVDAwKCqlkQz/l+meP8Ho5zV9JWKiTM+sJntdP0OFDSdjmrVyOUfLoAWr8yIbIBBdNy1dI7Mj+szDthrfU5ak5sXtKo5HUA4dJCV1TsqaD1NmlNpD/W5bshAskgXb48qL3eeqleF1WFjlIhkSuysZmrpfW6KKX9ySfDcEQsxfJo7U0A1UwzgUz1XLTqkmvOLA8gRPLvAJxQ6sT9wnue4t8dYopNEan3P4dZe5YOrZk51w5ZlBFl8EfbD+s2rkumkiqZtncBSRiI9myxqPWWLHBLddQUsQsRIL5M6ITV//WCKh2nOzNpr38lnJ/A/5PlKgCoNFjYhp4Yn01S54fnoM+VpYKZMJxWIQQbG2bquiQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(19092799006)(7416014)(52116014)(366016)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DXyUznHNkMLXLFA2KysToq855vQK6D+I2UDK2ZDhnLZ7FY/orKzLU7Zm6WQQ?=
 =?us-ascii?Q?JZZQuuwzoulJgg/soS0SXuK91WoRTD3bdZfitoqe3OIfuYDJBXW9j82/9ilE?=
 =?us-ascii?Q?i9FSsRTJUg2o+SrhVcANouk5p5tTwkJKl2tIbO9hOqwxqH6LBJdIqAtemGGC?=
 =?us-ascii?Q?vaMomT2IGOkWH5nz/KfDDO5jam8A6ewTmVA5Z1nktk5xWFj01Jtd6SBlQh+F?=
 =?us-ascii?Q?Xen7Qhs9/z9JsiyxlL+lKjjc/nJTnKsxxNrrIAMf2W5QtcvmellI+xp2EHsr?=
 =?us-ascii?Q?+i6StVqm/p6ZiTPL7Ji2UBb/9KgUKUqYrmhnKgtKknRm6yK7Yft3yPJSF+Ss?=
 =?us-ascii?Q?WrMZ4fYM+oR7twD2mC2KI8oJVvA+NPFyDjunG7pBdfkyW387ihQI1EMRDOEu?=
 =?us-ascii?Q?wafJKVzuE8gdaXg2RtMYxZJTGEOGOPwR+EjCpLKClkjOF1eWhRFlu/UZEpe/?=
 =?us-ascii?Q?TqrDZJM5DKEfxUAF960dBz8HhyzoyWpr5L0EoaARygc/pMTki0e2Aw1TX2ew?=
 =?us-ascii?Q?FHXcE8tvUYBxED7wxXvH8tMoBl3pCLhcdAhkp1W0QRIiabg8kh/MJQ9KFfjt?=
 =?us-ascii?Q?53OVBfoqpEH1MsBIchX17I99MWEit5XWtpdcweEPCU9xrv8tqgCwMcdYl64V?=
 =?us-ascii?Q?Vnmk7t5aTW74IbOUfHngnVNUmPRDMaezpmrJaz/+VsagfcngUE0dDupbcy33?=
 =?us-ascii?Q?kweOLdbqF5gzNX0mO1dRc+sOwNBqGt2eE0kejMqM4QvfK0R8YipPsX+0r72H?=
 =?us-ascii?Q?tVmDrFNrw66Xga3ljxGoAaP88avLgyaXs2ezV5+oH7cA3O7YHi0CwIqAZM9i?=
 =?us-ascii?Q?/eQ/Sw3rBjnhY6y4VTyTFQ0NlCxVUCVF7WsKvwp/fJ5RthStm1pPAz1bgaeQ?=
 =?us-ascii?Q?AtCLGnGwjBKnYaFFMtjTcVPDcbJEv5hYZJtA2nLP6Z+4ebphzvC2Q7nM1++a?=
 =?us-ascii?Q?xUqzYEZqy+ygKo3jPEQiRxuK++llNgJcg6FOeFiwKDfVZ4/giAC6SMWeh7ZG?=
 =?us-ascii?Q?xiWEhAh5Gg5lWCICbbu1mQDU7eACwuRfhXreofVzpQLNuUwgbGaeSfmlOLP5?=
 =?us-ascii?Q?TLZ1c42a0UtUdkGWFu3bd4mI+NHyUp6ZvYuIwHc7V97TROcIc7IZFInO88rW?=
 =?us-ascii?Q?kAqO4ApdsFQCEFDS6IjYe7nGpvQr8DwKKBDYUidfEEgCSxiERrbBNRiOgdUr?=
 =?us-ascii?Q?zYuNzRbqGtQMbj2DobTGANf8ByECsIlsamdci9vCOFN6QcJBnGj1UylLWP59?=
 =?us-ascii?Q?HEeN/0XT1M35gyKQhcOT9SQhxtNeKZspQ6qXAKZ5lbg4uvQ4L6vHVOpkzXuJ?=
 =?us-ascii?Q?CLIfskRmnXXYby2pcnLzbETe/+W+Tushw0wK1A+onric9lOoLS096Ieqzh6R?=
 =?us-ascii?Q?L1yXzoRcchanAcd15yVOfr4Y5lq+vLhnSNM40R4UA8Y/3JOdm2K+yi4jwF8+?=
 =?us-ascii?Q?TahSpgnNMFiZpdJep31pSgg+bih+LFXu9lozYUD3SVBf2rW5VIVprSzo8EUy?=
 =?us-ascii?Q?b386t6XG+jz7sjoiGJJy5Q42HImy8CrW+jhgvkDTB1K3WladBTdXlkYcAek3?=
 =?us-ascii?Q?izq+ELX+OaLS9UfmkOcnNIpZ8gbPqBdC5bOh3sR6O1MqPbGUc4YNapzKw1s+?=
 =?us-ascii?Q?D7w4PgF+Y632dAngpTjW09dijiZ6hP021DnfQbJ1B3BPWbJl/5BvMOrQpncW?=
 =?us-ascii?Q?r9rW0TOjWuvKgqJdmD7P6xbeb+mffzN6MgIGBqf8dhoByxB8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e292f762-d4ea-405b-bc1f-08de90405a5d
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 22:45:20.4510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz98cOvoQLDTzRk0GD0IJnFzWYOn+V4+7HyvvuI+ZvsypX0WAIjEivEisfcN9HBYvatHvQTf3z1LISiuV6VZEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12234
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9816-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nxp.com:email,bereza.email:email]
X-Rspamd-Queue-Id: 92A0E38117C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 01, 2026 at 12:56:32PM +0200, Alex Bereza wrote:
> Currently when calling xilinx_dma_poll_timeout with delay_us=0 and a
> condition that is never fulfilled, the CPU busy-waits for prolonged time
> and the timeout triggers only with a massive delay causing a CPU stall.
>
> This happens due to a huge underestimation of wall clock time in
> poll_timeout_us_atomic. Commit 7349a69cf312 ("iopoll: Do not use
> timekeeping in read_poll_timeout_atomic()") changed the behavior to no
> longer use ktime_get at the expense of underestimation of wall clock
> time which appears to be very large for delay_us=0. Instead of timing
> out after approximately XILINX_DMA_LOOP_COUNT microseconds, the timeout
> takes XILINX_DMA_LOOP_COUNT * 1000 * (time that the overhead of the for
> loop in poll_timeout_us_atomic takes) which is in the range of several
> minutes for XILINX_DMA_LOOP_COUNT=1000000. Fix this by using a non-zero
> value for delay_us. Use delay_us=10 to keep the delay in the hot path of
> starting DMA transfers minimal but still avoid CPU stalls in case of
> unexpected hardware failures.
>
> One-off measurement with delay_us=0 causes the cpu to busy wait around 7
> minutes in the timeout case. After applying this patch with delay_us=10
> the measured timeout was 1053428 microseconds which is roughly
> equivalent to the expected 1000000 microseconds specified in
> XILINX_DMA_LOOP_COUNT.
>
> Add a constant XILINX_DMA_POLL_DELAY_US for delay_us value.
>
> Fixes: 9495f2648287 ("dmaengine: xilinx_vdma: Use readl_poll_timeout instead of do while loop's")
> Fixes: 7349a69cf312 ("iopoll: Do not use timekeeping in read_poll_timeout_atomic()")
> Signed-off-by: Alex Bereza <alex@bereza.email>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/xilinx/xilinx_dma.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index 02a05f215614..345a738bab2c 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -167,6 +167,8 @@
>
>  /* Delay loop counter to prevent hardware failure */
>  #define XILINX_DMA_LOOP_COUNT		1000000
> +/* Delay between polls (avoid a delay of 0 to prevent CPU stalls) */
> +#define XILINX_DMA_POLL_DELAY_US	10
>
>  /* AXI DMA Specific Registers/Offsets */
>  #define XILINX_DMA_REG_SRCDSTADDR	0x18
> @@ -1332,7 +1334,8 @@ static int xilinx_dma_stop_transfer(struct xilinx_dma_chan *chan)
>
>  	/* Wait for the hardware to halt */
>  	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
> -				       val & XILINX_DMA_DMASR_HALTED, 0,
> +				       val & XILINX_DMA_DMASR_HALTED,
> +				       XILINX_DMA_POLL_DELAY_US,
>  				       XILINX_DMA_LOOP_COUNT);
>  }
>
> @@ -1347,7 +1350,8 @@ static int xilinx_cdma_stop_transfer(struct xilinx_dma_chan *chan)
>  	u32 val;
>
>  	return xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
> -				       val & XILINX_DMA_DMASR_IDLE, 0,
> +				       val & XILINX_DMA_DMASR_IDLE,
> +				       XILINX_DMA_POLL_DELAY_US,
>  				       XILINX_DMA_LOOP_COUNT);
>  }
>
> @@ -1364,7 +1368,8 @@ static void xilinx_dma_start(struct xilinx_dma_chan *chan)
>
>  	/* Wait for the hardware to start */
>  	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMASR, val,
> -				      !(val & XILINX_DMA_DMASR_HALTED), 0,
> +				      !(val & XILINX_DMA_DMASR_HALTED),
> +				      XILINX_DMA_POLL_DELAY_US,
>  				      XILINX_DMA_LOOP_COUNT);
>
>  	if (err) {
> @@ -1780,7 +1785,8 @@ static int xilinx_dma_reset(struct xilinx_dma_chan *chan)
>
>  	/* Wait for the hardware to finish reset */
>  	err = xilinx_dma_poll_timeout(chan, XILINX_DMA_REG_DMACR, tmp,
> -				      !(tmp & XILINX_DMA_DMACR_RESET), 0,
> +				      !(tmp & XILINX_DMA_DMACR_RESET),
> +				      XILINX_DMA_POLL_DELAY_US,
>  				      XILINX_DMA_LOOP_COUNT);
>
>  	if (err) {
>
> --
> 2.53.0
>

