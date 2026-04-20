Return-Path: <dmaengine+bounces-10037-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eN5qNDLV5WnWoQEAu9opvQ
	(envelope-from <dmaengine+bounces-10037-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:26:42 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B08D427B9D
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 09:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B047300A8D9
	for <lists+dmaengine@lfdr.de>; Mon, 20 Apr 2026 07:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08678384221;
	Mon, 20 Apr 2026 07:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="URE1szC4"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5642DDCD;
	Mon, 20 Apr 2026 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669971; cv=fail; b=sOV1zue6zOLrJedxSiupNdu5Hxs+uuOL8Ubtc9+XZC7VcRRqClFfVSxaEuUrka1DsCC7UvpQFTiqcxH199ExSnRwDERR89Oy0kIzFNO1WkIK2RP3krkb/k3d/jM4pDCeCQaYrKMObYLAuMxMuFp1N8XuWalZ6hYOTNDIQOFAIyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669971; c=relaxed/simple;
	bh=7ssSiRb/H3kSa/WDGn5s3njjUR76CIOJKYdbMzjthuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XYrr8AQKPLoPu4HOJRUJzPoeNVeugL7nUISkxonvWhkpsORuoGXwh7y5qSKIReHlyBNagGgNINRCX6Wm5J4LMooBhuY4+D63Ie9omEX8CBnbXbpBLINfYTgTHSnOccTYpQvajM1BXdRe3a+4bchACkxUitUSlaSc6iCuxNcvLwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=URE1szC4; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SG0012yephRx4CWB/mops/L4u+IGaDMis3FoDp2igKqvoqPBPieCF5HiidBCNWRLQ58cMalSYe5FotwWJ6d2kxZyHjouitA7oMxHaX1WtLTOd4Dzm8zmz3zbYHP127rJg6luU8yNGfsJkKT9Q3x2PInclZfAl64HmFshkh7fk0imNLX8ldPUU0ASqfYafVPFArVGCWO/tb1qTGY1n+P4FLlNFnLA09hbUDOmQgHPfj+ha1+8NzSUuF8M046HYAUXxfxELxBpHtsiKKhhFFbYyVsjrG5mWIpDB72O+D6a7ed54YqdqESevsH3p3qHdH8j41Dmr2PzdF/csuVzhvU/OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ssSiRb/H3kSa/WDGn5s3njjUR76CIOJKYdbMzjthuY=;
 b=KjYSJEdGDEW09F/mD1e/Qb6+BTzYVSZ//Mk17pCAN9CeNltDWvv7D7W4O5dXaYzXU0LtH1skfb5IVwAMcCFqR2JNntobXtIKk7ehFsWjWjIwHzRU2uPFOIPV2poqTNlwycRhPuj3rIT1pIvR8dQ4X15sBIijX5dDocil+vp5Hlsrq3BVI7jhm5nxuP5J409XTjXtWUZ68q8FHvn5QnNyrlPxGCJ137cc0wQHq3mC7+g49rV0LDInhrXylduGNFw7j4jhmeNYgpzpcOHVguO9bVQFp5kuBAQf5mXmCra6/lp75wejG9PDCbOZExVPLwi8cQL/R8yXpx/3EnIUwFbEHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ssSiRb/H3kSa/WDGn5s3njjUR76CIOJKYdbMzjthuY=;
 b=URE1szC4UL893gOglTSzUgreyxnDtPlUJfG+hEt1oAZCyqwBvQaNIi/gBnd+CA8dDGBGAuBjbH4PTilFWTuav31OnUaR5me/zkahp8rD3r7Rc/GK5HrCUoLo47zZSYgOkA8Zm9hEuOPgnoF1Ck2mOO7AI4MPyUfq6Eakv1rT7ivAqNi9isAfZNUpalabG0qjTlnurwdQ5Xcx5jC2cKzbYvvphur/twU+b0cyxIdVekTE+yqSz/oc/85rvqu3QDDwBILnMYddZwGIWW+yggUkXJdqMxgZdPqnnQNXS7Jzt5xlm+CUvL++Usc61hF13qA7LZSmXw5lAhMoajzsWkcRig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB10651.eurprd04.prod.outlook.com (2603:10a6:102:483::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 07:26:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9818.032; Mon, 20 Apr 2026
 07:26:07 +0000
Date: Mon, 20 Apr 2026 03:25:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Rosen Penev <rosenp@gmail.com>, dmaengine@vger.kernel.org,
	Andy Shevchenko <andy@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	"open list:INTEL MID (Mobile Internet Device) PLATFORM" <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv4] dmaengine: hsu: use kzalloc_flex()
Message-ID: <aeXVByacaoBGK9sX@lizhi-Precision-Tower-5810>
References: <20260415032753.6006-1-rosenp@gmail.com>
 <aeXEIDgjTExt_hgs@lizhi-Precision-Tower-5810>
 <CAHp75Vfp=Wvtq5EFM2vOZUfkGDcq_m_zpK_px0BKTFiiR8EwwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vfp=Wvtq5EFM2vOZUfkGDcq_m_zpK_px0BKTFiiR8EwwA@mail.gmail.com>
X-ClientProxiedBy: PH8P221CA0066.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:349::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB10651:EE_
X-MS-Office365-Filtering-Correlation-Id: ba42f79a-a850-45a3-efe4-08de9eae165c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|19092799006|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IbM8Za1cesqNItWr2Pds0Zul1iZdFHybBAZu7gUBQ34DJsHWxjofhulGDPBW0hAWlSE3TL2ae1XSBK0jYwbG7VnI3eOb2fEtaqoH4RZ7f4d/uH6FkQVphCxMsKO7Jqv6e5V5vKYJ9mCPWJBgkFY7Im5tSReDpHSUDyuGY/neuWNIUKyHkPA98YuJZ6GYFRPt8aQrc4L3InWay7ErfvU1JYlv6GSxRRRd9K/Miz/2dBNIGzRFqP0zoeUEbHqaBNoddF00dDcuvrqkUvSl7gIGnoxQOxsKhy8WUW3m7pxeAg9NnxHuQBcbl8antBv2himHmVjIiX9EY4CAGZExXakUXzXY93vI4Q8t4DuJb8VY3gjbiHu0AvQKGEBSn7wsRQ3tKhKFkcCCaelxFJY5wjQ+A7+qEgEZXUn2LAAcH/u+b4ePP62TSya8q5tYJSZUdm52AsIudMGCYpTt5d2r8ZiYaW7I6t1HEwkQtJdKKqfLQhYsfNf639gMXvTqq+XQ/X6WQaDlHU0oNqS3al+QoA4+fbeDIM+A8u1cv+7kCU+DzhS1fFKc/2wdm3HpEaah2poH38a8s9wY5OPcOmJB2eSlcH9aGcVB23QRwyEV+SBHcR9MUPFVEWL42gMY2LVjrtglnDFlaD5FsFrGYNhj8cJuBaRj578A/V3/MmdgHLCuPzP+aXLG44rD3GNwjxFIpiqwPQTKZ8G8PNNXqO3oaso/X6AAQq6DRKjI0LphBkpktP3Hy/TB/76Qax0MQeYY3OYomuhMuWaZzz/g1oawMYRXybOYGWUnXSVeZc6VU5W+H1Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MXBEMHFUcittODRla2hCOHVad0ZtditRSlAxNzRqbllKSjRReEErVEd3RW5H?=
 =?utf-8?B?ZUVtNW9IaTNTWVlmQTdUUjhEY2x2eUgrL1lsMnQ1eEZHU1h1TnBzakNrQ1VZ?=
 =?utf-8?B?eHBkMnF3Q1UrckQrWldzTDVyYU9CTWlDa01MdzcvL2s3T2xrQzB4QVk2ZlJT?=
 =?utf-8?B?bnlCb2tWTGk2N3BaV2ZSQ3loMWFDelplSEhqS2xENWFKMHdFdzBIRHRjZWVW?=
 =?utf-8?B?OFV3K21jRjlHYmxYMEZCK3BFTTdFbm0yVnNaSE5WMVh4SG9RbEtFTCtWbW82?=
 =?utf-8?B?bGR5dU9sUFBSU1BKa0dyVzRsVGhubEl0SGdKZStsRE5Sb2NNZHFrTmFrWU1v?=
 =?utf-8?B?YzRsdnQ5c2cxT3NzM0phY1FOU2xNR2ZyNEdqSEJaVkF5ZEFtT0prR05wckU0?=
 =?utf-8?B?NEpwa3VPaDlMN1dET2hZQmFneU03L3M5MkJISWVFVGRrV0NHbHk4dkg3dkNR?=
 =?utf-8?B?Tkw5YmJKcExHdVBzTENHeTVSalEyVGZrRHFvWGdMK3h5alVNTG9TdVRrckxV?=
 =?utf-8?B?QS9WR3J2MEVRSXFHNXRzL1J2S2JweEcwZmI3ek8vZmhWLzlNMVQ4NmszT2pX?=
 =?utf-8?B?ckxaKzJhbGREN0pES2ovcTVCYnpXanlWZ1p1aytnS2Jjdk5abzNmRE9NaXl1?=
 =?utf-8?B?eENJQlhQNVZyYWd2ZFhuamVVS2Njb0huOGxETjBUVWo4UlVqeDVFUzF4eEsv?=
 =?utf-8?B?MDdlaXRQc3o2cTFqSzluNUdra1VLUDM3bTNBd1lSVFBHYzFiMVpRRElIRWxw?=
 =?utf-8?B?emdRN1JpQ0pWTHNKdTZwcStSWjZIbWxFTWVxNWk1Wks0bFVlT0pCcjNtMm1q?=
 =?utf-8?B?Z1NzVjdPRWxaWGxNRDd5MU1QbzU3N0k3ajhkVEd5aGVXRzRzMENjOXVSV3Bl?=
 =?utf-8?B?Q0VXR2hMeWxVRG1VRm5WaEhRcTJ6V0JQREJYY0haY1d2c3F1VHFvejVHbitZ?=
 =?utf-8?B?V29JZnpFZlFQWjNwSC9nWDBOb1RRVTArMlVOcHZZc256MGVOSWovc2ZpM1V6?=
 =?utf-8?B?UE5HcFpzUVlDNDR0a2dMN2pqb0J1ZG1RTmNZeTZ6RDI3ejZGRUVubDFTZEJo?=
 =?utf-8?B?VHJNblVhRHVnYlFjR01qTXJXYXBreUV1RUd4ZkJpU2NFcWNxWlNDYS9Xa2Fz?=
 =?utf-8?B?TWZ5TjZ1RWRYTnJaQnFSVnY5cHpTY2hFOWtlWXJYb2NsbzBmeEwvUGhzRk1i?=
 =?utf-8?B?elFWMkxnZzlJa1MxQVorSkZ1dVFHeGxpKzVDWVpxcmlNeEFVTDV2NkFpZ3Vl?=
 =?utf-8?B?c2VLSXJlR3AzSFZYRGhPZjFtWFBWUkRMaitiWnN2VGYvSlNyYllkc3hIbWNu?=
 =?utf-8?B?T29HQjdabTRubEFYUXJkUzNwbmdTRW8ybGFxT25CdDNiQ1FuV0ZBQ1RReW84?=
 =?utf-8?B?c0ErSEJpWjZzeE9lUGZuSjNjM3cyVTdHUU5YV2I1WUtRMCtocVpFYmNyQ2Fq?=
 =?utf-8?B?UVBET0srVEI1U1Frb2swdzk1bFpLWmcycG9kQWtNa0ZjUTBOVCt5K1BOci9I?=
 =?utf-8?B?Vlo4c1JOQUN3TTU1NmpFMTVIV3EzRGxVRnBYR1ZLRE0yVkVwTXJSTCs4VU1L?=
 =?utf-8?B?T1kvRzZLRndUQnhuMFB6YVYzalVIemRRUlBsRVVGYUZQYU9PM2dPODM1aTZI?=
 =?utf-8?B?anFwQWowWkZVdXFpaldVZzFNQzRZcE9OTDBVRW1FSTJ3UzJSdWJYVUtJZlQz?=
 =?utf-8?B?amJTcUlEWHBPKzF1QlJYdElKV0V5Zmphd3lPcVQ2RjJDMEJsbVF4QjY2elBq?=
 =?utf-8?B?d0NLdWdBUHBwOTg2dVFWeC95U2h2dHMzVlBJNmtyMG5WZjdXVVJZb1NFcSs1?=
 =?utf-8?B?NmlTTnpwRzBlM1ZUUHh0eHpaRXBpdWNsVHdMRURjcnpnWVBOaTlYOGhmcGpU?=
 =?utf-8?B?MGk3V0NVVElRU0RUTmk0T05IdE9COXllMXRKcUZzOXZiNzZKbEpmVzVUaFNH?=
 =?utf-8?B?Y0c4dHFaWVFxZ09mTWtNaTJwTHJ6RkEwQmpYUG9VbEUxZlNnWXJGSTVjbisz?=
 =?utf-8?B?b2NwczZtM0gyRWJUVlZlZllnb1BlOG5Pdy9ZbTA0bU9wSGI4RHVjR2JCWUpW?=
 =?utf-8?B?M1V1OU9EL21OSEpjdzdUbzJnL05WdGUybkZtbUdPWjRqV3ZsU0NoUDhKNDA3?=
 =?utf-8?B?N3ZDVWxzSi9zYmtOU3V3WnVlUG1QYmpjOFpld1ozM3ZrQzlJRmhGdjRZVjYz?=
 =?utf-8?B?VEhCWEtpVGplVjloNzVzWk1YL1kvbnFQcUZBNUJlUXVjOXo1YzJNb1Q4N21F?=
 =?utf-8?B?SUNWZTloSWxuZnVLZlZGVW9zL0NyV0xuUlNNK0FZakExSjhUM1NEQVhuR2FI?=
 =?utf-8?Q?WT7lQArTkZXtWKRuJu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba42f79a-a850-45a3-efe4-08de9eae165c
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2026 07:26:07.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzBTAsKpLwz35sjbhc23B+5RSjqgcrQNIqODQPVrlnQm7xeUa6zg+UiCsoy6tpqy5CC+mI8alwTEbxRv4qttKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10651
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10037-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B08D427B9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 09:49:48AM +0300, Andy Shevchenko wrote:
> On Mon, Apr 20, 2026 at 9:14 AM Frank Li <Frank.li@nxp.com> wrote:
> >
> > Subject
> >
> > dmaengine: hsu: use kzalloc_flex() to simplify code
>
> Not really. The main point is to have source fortification being enabled.

Okay, but need know purpose in subject

use kzalloc_flex() to ....

Frank

>
>
> --
> With Best Regards,
> Andy Shevchenko

