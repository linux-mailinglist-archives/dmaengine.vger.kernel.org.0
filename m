Return-Path: <dmaengine+bounces-11930-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aJ25FAIqRWpe8AoAu9opvQ
	(envelope-from <dmaengine+bounces-11930-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 16:53:54 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E45EA6EF046
	for <lists+dmaengine@lfdr.de>; Wed, 01 Jul 2026 16:53:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("body hash did not verify") header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=Rt84e3xm;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11930-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="dmaengine+bounces-11930-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2423E304AB73
	for <lists+dmaengine@lfdr.de>; Wed,  1 Jul 2026 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF0535E1B6;
	Wed,  1 Jul 2026 14:51:14 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013005.outbound.protection.outlook.com [52.101.83.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9516255F2C
	for <dmaengine@vger.kernel.org>; Wed,  1 Jul 2026 14:51:12 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782917474; cv=fail; b=S/BaEYLvK0Gk0tjxt6A3NnpCgzKveqwQCXM1cq2zSwlA1pDxkAuAl5SCku0buVhpEovp296Nz9breWt7CQxw9SH/IuZArOF7bZmdJd7KbVRUzgJG1hM2ufvLS2g294q85WJn7rRMTKwfzo1jU5Ws65F0ksC3PM9jKwpIH564GBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782917474; c=relaxed/simple;
	bh=g7E3FxHOkBesorwVx4R63/1ZCovN1HZtexYYS7XD31A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lFGfb2xXLvAwqlDxc9S8skb793ttLnwUiNb0acmmSMfm1Em/KfF7gdPqf5LagDNFE7yjn+uhMFGOxElwRl+D6o3f5xidtLqjMer/WcAxtuQkVYCMQ7kxuge2lMdiQMt2LHy9rTyU2+A0UUr7o65sjLbm9Xyp3OQaNr0I6pyLFRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=fail (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Rt84e3xm reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD8u9n4XQLr4I4rXz7R9gXWYwn0QOcoG3Zg9Jw88Tg1SG+uHy0nZ8+ERECzVJFCY7J2fMHKG7nmln2NYofqDvNUnvECQNlOjI3g3bB2i9LnyFzoW+jFStf2mdd0ZrW8U+Vxt+wQQm4WTBZI0scE3qyv49kZVmWZWd26FGerNlQixUoolKEdy3xOmimiEwyl6kjR4MJAgTc1xuL99wXDtsBEvl4ojNuoT98rjSr/+0JrIQuxABi4wSgMaGdYOTLoFqAuVyNC0hBoV9MUHJLU3gt/OccFv4PwIQt/E8MSxkZXNGjxioPwfkfHGQ44fLlyE+8ON97AQ5O/MMWiYtL/5aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iEF9lcbKwIPG05dDcneMC9rWj7PltjNahUfNCD+/Ids=;
 b=vt2XagpPZqy6txkdtlr7ECM3RBD4Xbi3tuGDKfOlJA9Rf6lPY4FwXkDY3y5GfQm/wroNqGc2b3u3KbuxhiJ0UYTxB+nx3OkKXC4DZtTpHz6VY+rD41SjuoxO2izMWB09xQPqbMWXcuTpYX3/i5hW+Thbq/uL46z7ibM37y9ziIXV5X8AsF+1E2yty5NoUxsEC5fiKLGL1aWBrqSMku1DodUp+EOJ9DlV04IicElmqnE0PwbaAROE31REdHnvC7q2Xo39pkth0imh8lQ9Kqw5lKR6s6ZNKQSdPhNU5Q10mPpjFnnl72X0WLEwHe7k2Re/oYgNs0igwQtL6mJyeudjXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iEF9lcbKwIPG05dDcneMC9rWj7PltjNahUfNCD+/Ids=;
 b=Rt84e3xmfND6S9/bRMQGUqeeQW/UVN4uF+90zp0xVlmoTMw77zqCdZUUFDjAbLeKdZmXLQkGEI9TL2TaxyUUy1lqZeMxBcJshXXCmeivQ6kfsSeT59fQQAYMdY969+ePlrXj0ZG6lOyS/ZwgYtSgtQ1PaTajQjtAlq7oCBly4Q8gRiAve6Rt5RufRwq/I9U3fyJNG2BnrptnCgt1ADB6spLUWJTmrMayzo92urB04rQVZQ7utghTKMaHj8znoSyV3Um/qwlnNpMWMgtbBxCR5JHiPQdz6okqqculOJQ2JpXq6MTNCYUTafw49Kxqe0dH7l7RtdxUMfiM06ZWyvHjPA==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS4PR04MB9435.eurprd04.prod.outlook.com (2603:10a6:20b:4eb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 14:50:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Wed, 1 Jul 2026
 14:50:44 +0000
Date: Wed, 1 Jul 2026 09:50:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: joy.zou@oss.nxp.com, Frank.Li@kernel.org, imx@lists.linux.dev,
	vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v6 4/5] dmaengine: fsl-edma: add runtime suspend/resume
 support
Message-ID: <akUpOso_-leCZeJu@SMW015318>
References: <20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com>
 <20260701-b4-edma-runtime-opt-v6-4-354ff4229c00@oss.nxp.com>
 <20260701094312.B0EE61F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260701094312.B0EE61F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA0PR11CA0051.namprd11.prod.outlook.com
 (2603:10b6:806:d0::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS4PR04MB9435:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ed846c-874e-4559-36ee-08ded7802101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|19092799006|1800799024|22082099003|18002099003|5023799004|11063799006|4143699003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	OhXOpCVj5lVVjrDwCFosDzy/8fsA5PDRw4M3TFqO2THyw2Tl8KaIN0BVRr1buaroXRTlrFWpQ4/6Usv11jO0YdFX+0+L96z7cCTznKEvTzTzdeq83/tLJjrBSTyUHFjnOj5P2HearysEzBd0vSAt/2ZVJYZg0UNXdUDhO36KOdzgPwC4Luq/RSW83Z98cWZzYhEijd6q/HqnKyD+aAAWxvFf+mnACIFwupC0VE150x+hifuErKkOwIklszfB6pL1qXgvzlRGXmqJKbXCDPAqEURq3S3RgSr52xdX22VYo1Vt3+cD4Vqo/oGicYlobMC35qoLqmik+qxel0w/oVaKKRXR1PPOFZk7TXzC+bHMlTFXdqgvfXcvcmr3QRO28xCjTAE0rsi0JUKXY22e2Sfzz4dVWXH5eWcFpBdmoHl+DD+3jd5yDUPAQ5t1hhHXk6GrWuBPQkkIgAGgEz66RIsJU9huQzd0KmWUeddIpKZkzSbYGgdnHgciwaQfZJgVRG6C+GHHXJv2gNCmYJI0TSlzti2h2BNcmOO+KHtC9W0FTctjpeu80azkIfsY7yiLcX22AyH8h1WZMV4Ocku18tfRTkynYcxSiBGvVDbC3/ACM8k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(19092799006)(1800799024)(22082099003)(18002099003)(5023799004)(11063799006)(4143699003)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?JjSZ8oW/ry61nNvSbRDEEnhVQA/CEC2ZOtLBewTrkNVUJvXcaIc81HESqX?=
 =?iso-8859-1?Q?Mccsox/1C26SEFRithKQOWzWibU4QQGFmK8QlDwCqq23Y+ZCOuU/EZQ9M9?=
 =?iso-8859-1?Q?AC+/Hsgn9hw6CWknH7zjZABOUOxqVrJL5J6bUlp6crtSTnrfxt+u/4MKhu?=
 =?iso-8859-1?Q?UTzbNhModlLu8PXWpkoax7uINOU4j2yjyZzkcNufaVgnCfYygNAR+OHEeB?=
 =?iso-8859-1?Q?xrwwCjUrGqEdGXt7WHZOufdHblbcQ/RuqDdT4Uu+1FKdvHVdUq00dwIs9F?=
 =?iso-8859-1?Q?wTgSBmRO78aU/83RvIpojogvvmtT0WzEqv9MsbBZhL979vLuMFIHjpaKTR?=
 =?iso-8859-1?Q?0vCBQ1A6XY98j2vPnED1RWy3E5JxrZ7yteDUx9fa/2j61UjshDUwkNsVk+?=
 =?iso-8859-1?Q?Y3/5CU4Quj6cRO8upYZZf49ex0pn7kbtwd1zw7VrOh6Lg8yNrf+jdJW+rY?=
 =?iso-8859-1?Q?ZSnhvNHghi4GcpoxEDkE7Fo2KXPhD3JGbAuQtpHNfNQdKsdRolQQnRupWA?=
 =?iso-8859-1?Q?FI8JypZVB+II8P1JTGeMLemQaNKzmXUQOxk9XdmVUUf+qfhYS9XgT9lSnf?=
 =?iso-8859-1?Q?dnibgwAyTEBQLGzmCkufX+lsQv/F2Z8ij8Ar5IgstuhtrK0R0CYgQ22OeF?=
 =?iso-8859-1?Q?GAmVkOL0yG0PfOQKhwmpi5qjieEoid1z2SayOfYp+3I1OVH2B976FNDxHT?=
 =?iso-8859-1?Q?X40FOo+FN3rfttrIxW11I1yrf54W+eqCkUoAf+J3zw0Zh/x+YCqxVi16nZ?=
 =?iso-8859-1?Q?oAsdxhFV0f48tt/DJ0WJgw59pHbDWGc8kxkcxM1J5uMi6NiJEjWgXMC4bU?=
 =?iso-8859-1?Q?sDIgmI60PGS2HKsOe491mjfmhwjbzq2rRmYePT9l/9KeF2rsBswss8qpSa?=
 =?iso-8859-1?Q?stdenQ5PaWudwDMAVwhEHWRrAJE+Wma/fbZF8tiW7kzXV1RytJNIGq8L7L?=
 =?iso-8859-1?Q?Nx/xZ/WjeI4cYJ0iZsZN1vDmAsgonUZ5ehqE60t9U2Oool75sJgRmf4TrK?=
 =?iso-8859-1?Q?IxkSI8F41hVW9BQzLsxX07frLMUs7isw0/CplTx1eDK5FMtlOW+aDMI6aY?=
 =?iso-8859-1?Q?HS+cHeScKqHQtFArpg8jYabU54hFhkiYkDk7YZ88hzqtqwJMUc99UsuHMR?=
 =?iso-8859-1?Q?i3zfo15eXu+vU/1bqt5Y2Pg2XqLQJizP+AvU5/LCc1gdpmZgnnJ70R2Ynt?=
 =?iso-8859-1?Q?3j15i/Y40i3HsINKMXJAYNUetnlgcuBxu9CvbShLf/jYfb+HyHdEgsHUD4?=
 =?iso-8859-1?Q?djVD/AyQ5rGm6FiHel/nEiIKaYLyhqlbwCkU9VZIw9gA4OOThUnPQiYdbi?=
 =?iso-8859-1?Q?FBRoYgqo8HHgCcXDAfkI7UsI+68IjeMEsZS7z8LRwZv4IJWJPdYqocHdNA?=
 =?iso-8859-1?Q?lo11/DHX7NR4eF/apWaFlMZ92Na3DK1ARy/S5zeYE+vowxzuW2QITBke6f?=
 =?iso-8859-1?Q?aVmEqHFBj7w3ZIwBTCUWzLKPv/JAihCkrAeU5SRw3yNV2FJd+tNecpcUzi?=
 =?iso-8859-1?Q?m/vjS1+ONnZfBtY4f8m6MGuwe4WIPjyEnLPQ8al3yR+d7pW78Ri05R997x?=
 =?iso-8859-1?Q?ACVBLkMZFlAMbFOmTtyXb3pzugXl72nn1TZvJYizyPstfp/dYp48QyH/tT?=
 =?iso-8859-1?Q?YOgmGI6Kf5em7GtbHd1w98Tpz02U/flWBVSiQB//DcBEI5VCjbWzIZMJAh?=
 =?iso-8859-1?Q?tdldiCjDrjw/tcBxgcZhTB5ARQojLvXXhK56kvjwvu2Kd88enFJ6pRkOUF?=
 =?iso-8859-1?Q?x99NZrqypg2gT4nnYDa9DMevzDyGaD47NQyCRXorTo34jmW/llHRyRtjgL?=
 =?iso-8859-1?Q?MgUcvc2yZdxzAX7I23eNl+AhLlsSe1EJUyBD4bfKlme+92OFimFI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ed846c-874e-4559-36ee-08ded7802101
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 14:50:44.6058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hYKgCgjxNKF3tNboKpCsXwYOgyG0aZ1+G8ueshgTx9r2CIigHEM8mVCC8+J02SaUfa16UzVs7bcUSfXr8DFGkzDVV4YumbqY/y0ZdNTg/VIx31I9+tVou9DQdP9h6bAj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9435
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11930-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sashiko-reviews@lists.linux.dev,m:joy.zou@oss.nxp.com,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,nxp.com:email,vger.kernel.org:from_smtp,sashiko.dev:url,SMW015318:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E45EA6EF046

On Wed, Jul 01, 2026 at 09:43:12AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [High] Skipping hardware interrupt acknowledgment for inactive PM channels leads to an unrecoverable infinite IRQ storm.
> - [High] The channel runtime suspend callback calls `synchronize_irq()` with a negative error code and fails to synchronize actual per-channel shared IRQs.
> - [High] Accessing a freed `device_link` in `fsl_edma3_detach_pd()` due to devres teardown order inversion.
> - [Medium] The DMA engine and its channels are exposed to clients before their IRQs and runtime PM domains are fully initialized.
> - [Medium] Runtime PM usage counters for the engine device and channel power domains are permanently leaked on multiple error paths during probe.
> --
>
> commit a5800ff547600d938eb443a21684d6291b4658d1
> Author: Joy Zou <joy.zou@nxp.com>
>
> dmaengine: fsl-edma: add runtime suspend/resume support
>
> Introduce runtime suspend and resume support for FSL eDMA. Enable
> per-channel power domain management to facilitate runtime suspend and
> resume operations.
>
> > diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
> > index fe02b68d75fd3..3518dfb4292d2 100644
> > --- a/drivers/dma/fsl-edma-main.c
> > +++ b/drivers/dma/fsl-edma-main.c
> > @@ -37,15 +37,27 @@ static irqreturn_t fsl_edma_tx_handler(int irq, void *dev_id)
> >  	unsigned int intr, ch;
> >  	struct edma_regs *regs = &fsl_edma->regs;
> >
> > +	if (pm_runtime_get_if_active(fsl_edma->dma_dev.dev) <= 0)
> > +		return IRQ_NONE;
> > +
> >  	intr = edma_readl(fsl_edma, regs->intl);
> > -	if (!intr)
> > +	if (!intr) {
> > +		pm_runtime_put(fsl_edma->dma_dev.dev);
> >  		return IRQ_NONE;
> > +	}
> >
> > +	pm_runtime_put(fsl_edma->dma_dev.dev);
> >  	for (ch = 0; ch < fsl_edma->n_chans; ch++) {
> > +		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[ch];
> > +
> > +		if (pm_runtime_get_if_active(&fsl_chan->vchan.chan.dev->device) <= 0)
> > +			continue;
> > +
> >  		if (intr & (0x1 << ch)) {
> >  			edma_writeb(fsl_edma, EDMA_CINT_CINT(ch), regs->cint);
> >  			fsl_edma_tx_chan_handler(&fsl_edma->chans[ch]);
> >  		}
> > +		pm_runtime_put(&fsl_chan->vchan.chan.dev->device);
> >  	}
> >  	return IRQ_HANDLED;
> >  }
>
> [Severity: High]
> If a channel is runtime suspended (e.g., due to a hardware race or a spurious
> interrupt), the interrupt bit is never cleared because the loop evaluates
> pm_runtime_get_if_active() <= 0 and continues to the next iteration.

Make sense, please check other AI result

Frank

>
> However, the function ultimately returns IRQ_HANDLED unconditionally.
> Could returning IRQ_HANDLED without clearing the hardware interrupt flag
> trick the interrupt controller into thinking the event was serviced,
> potentially leading to an infinite IRQ storm?
>
> This same pattern appears in fsl_edma_err_handler() and
> fsl_edma3_or_err_handler().
>
> [ ... ]
>
> > @@ -691,6 +711,36 @@ static int fsl_edma3_attach_pd(struct platform_device *pdev, struct fsl_edma_eng
> >  	return -EINVAL;
> >  }
> >
> > +/* Per channel dma power domain */
> > +static int fsl_edma_chan_runtime_suspend(struct device *dev)
> > +{
> > +	struct fsl_edma_chan *fsl_chan = dev_get_drvdata(dev);
> > +	struct fsl_edma_engine *fsl_edma = fsl_chan->edma;
> > +
> > +	if (fsl_edma->txirq)
> > +		synchronize_irq(fsl_edma->txirq);
> > +
> > +	if (fsl_edma->errirq)
> > +		synchronize_irq(fsl_edma->errirq);
> > +
> > +	clk_disable_unprepare(fsl_chan->clk);
> > +
> > +	return 0;
> > +}
>
> [Severity: High]
> Are we synchronizing the correct IRQs before disabling the channel clock?
>
> During probe, global IRQs like fsl_edma->txirq are initialized to -EINVAL
> for SoCs using per-channel IRQs. This check evaluates to true because -EINVAL
> is non-zero, causing a negative error code to be passed to synchronize_irq().
>
> Additionally, this code doesn't synchronize the channel-specific shared
> IRQ (fsl_chan->txirq). Could this allow a shared IRQ handler to execute
> and access hardware after the clock is disabled?
>
> [ ... ]
>
> > @@ -891,6 +917,64 @@ static int fsl_edma_probe(struct platform_device *pdev)
> >  		return dev_err_probe(&pdev->dev, ret,
> >  				     "Can't register Freescale eDMA engine.\n");
> >
> > +	ret = devm_pm_runtime_enable(&pdev->dev);
> > +	if (ret)
> > +		return dev_err_probe(&pdev->dev, ret, "Can't enable eDMA engine PM runtime!\n");
> > +
> > +	ret = pm_runtime_resume_and_get(&pdev->dev);
> > +	if (ret < 0)
> > +		return dev_err_probe(&pdev->dev, ret, "Failed to resume eDMA engine!\n");
> > +
> > +	ret = fsl_edma->drvdata->setup_irq(pdev, fsl_edma);
> > +	if (ret)
> > +		return ret;
>
> [Severity: Medium]
> By calling dmaenginem_async_device_register() just prior to enabling
> runtime PM and setting up IRQs, do we expose the channels to clients
> prematurely?
>
> If a client allocates a channel concurrently before runtime PM is enabled,
> fsl_edma_alloc_chan_resources() will invoke pm_runtime_resume_and_get(),
> which could fail with -EINVAL.
>
> [Severity: Medium]
> If fsl_edma->drvdata->setup_irq() fails here, we return the error code
> directly. Does this leave the pdev->dev usage counter permanently
> incremented from the pm_runtime_resume_and_get() call just above?
>
> > +	for (i = 0; i < fsl_edma->n_chans; i++) {
> > +		struct fsl_edma_chan *fsl_chan = &fsl_edma->chans[i];
> > +		struct device *chan_dev;
> > +
> > +		if (fsl_edma->chan_masked & BIT(i))
> > +			continue;
> > +
> > +		chan_dev = &fsl_chan->vchan.chan.dev->device;
> > +		dev_set_drvdata(chan_dev, fsl_chan);
> > +		dev_pm_domain_set(chan_dev, &fsl_edma_chan_pm_domain);
> > +
> > +		if (fsl_chan->pd_dev) {
> > +			fsl_chan->pd_dev_link = device_link_add(chan_dev, fsl_chan->pd_dev,
> > +								DL_FLAG_STATELESS |
> > +								DL_FLAG_PM_RUNTIME);
> > +			if (!fsl_chan->pd_dev_link) {
> > +				return dev_err_probe(&pdev->dev, -EINVAL,
> > +						     "Failed to add device_link to %d!\n", i);
> > +			}
> > +		}
>
> [Severity: High]
> Could the teardown order of these stateless device links result in a
> use-after-free on probe failure or driver unbind?
>
> Earlier in probe, devm_fsl_edma3_detach_pd is registered as a devres
> cleanup action before the DMA engine is registered.
>
> However, the stateless device link is added here with the channel device
> (chan_dev) as the consumer. On unbind or probe failure, devres actions
> execute in reverse order:
>
> 1. The DMA engine unregisters, destroying chan_dev.
> 2. The driver core automatically purges and frees all device links attached
>    to the deleted device.
> 3. devm_fsl_edma3_detach_pd executes and calls device_link_del() on the
>    now-freed fsl_chan->pd_dev_link.
>
> > +		ret = devm_pm_runtime_enable(chan_dev);
> > +		if (ret)
> > +			return dev_err_probe(&pdev->dev, ret,
> > +					     "Can't enable eDMA channel PM runtime!\n");
> > +
> > +		if (fsl_chan->pd_dev) {
> > +			ret = pm_runtime_resume_and_get(fsl_chan->pd_dev);
> > +			if (ret)
> > +				return dev_err_probe(&pdev->dev, ret,
> > +						     "Failed to power on eDMA channel %d!\n",
> > +						     fsl_chan->vchan.chan.chan_id);
> > +		}
> > +
> > +		ret = pm_runtime_resume_and_get(chan_dev);
> > +		if (ret < 0) {
> > +			return dev_err_probe(&pdev->dev, ret,
> > +					     "Failed to resume eDMA channel %d!\n",
> > +					     fsl_chan->vchan.chan.chan_id);
> > +		}
>
> [Severity: Medium]
> If pm_runtime_resume_and_get(chan_dev) fails here, we return directly.
> Does this leak both the engine's usage counter (pdev->dev) and the channel
> power domain's usage counter (fsl_chan->pd_dev) acquired earlier in this
> function?
>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260701-b4-edma-runtime-opt-v6-0-354ff4229c00@oss.nxp.com?part=4

