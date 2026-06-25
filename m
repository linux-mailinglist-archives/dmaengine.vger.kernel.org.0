Return-Path: <dmaengine+bounces-11785-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o682DBFDPWrh0QgAu9opvQ
	(envelope-from <dmaengine+bounces-11785-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:02:41 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3166C6E92
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:02:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=tUNy5R50;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11785-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11785-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13AEE304A916
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 15:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BE53E717F;
	Thu, 25 Jun 2026 15:01:36 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5563E7BCE;
	Thu, 25 Jun 2026 15:01:34 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399696; cv=fail; b=E/qokILzzNtQHo0hn8QznVxrbN8GQdkHyTPsspxucnwnNIMvlKLFUhaeaJ13UmICW7yTHJ+oddOFiZ105Sd1BpKpe4NZGzZb4FrTjM13dYWJTNUG1lPFUYxiO+MIDmXfHX5Lbfz50BjffufUYnPhgHzCFIESyu5zjchdzzXqBsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399696; c=relaxed/simple;
	bh=A7qo4DmC9m28GFYeiYZ/xacrvKS9t3PZA5ikYG9k81Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvx90UMiJ6EVoXR3TkzuPSnBYPnwhb3GZUkOpbMQVOC5UlqsvHRU+P4uko+D106u9w9mwQAZD7QhcJvhaV2GU9Xn2C4u7vMScAyIoLk9k1Krn0JPWljKFomvFlAinC+qRfyFg9iW0/m56uXmwNGbOgGHwExUC7P8FBkW5ZCSF0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=tUNy5R50; arc=fail smtp.client-ip=52.101.69.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHTgi/k6EMfj1kTF8oAe04wSYvKzmtfnIcfdWiZZtYrG4kVZ2bbbtzV+pkWzfxrk0uZMewvWehlC03ftUN6UFtkEpW/Nx7SEAJiVnas/P9t61bQXcK0xg+W2HbM+efckOmZA1621zylwNVR2i7LeJVPMIirn284uFI7I2+yll4HOQrQrPyY3zqnXS+In86Zlr4233Tmh0nj/2UjsUctuEIEFWaxrBZsuUhnzbC6F3OhHpwgQYIJuHJXHl9+g6KuW7IwzbD5jMo4R0zIUBmGl2qsxBbDBD/46RccIG9k4v3nnhVPNUy8zRdHmK4uOi46bq5Vp3iOTXkkB3IhygW3bHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XqOMZQwRamkCZXsgracaEUY67larGhekteWgPUX3M8=;
 b=qJyawvQ/b7UniacgZJiKmZtdu/HfZfwXr1mlE4/loWfow113s2H8Cvh5MrJYDcYHsuzl+NkJ87XbZpvkuY8wucnGbF1JgWhsgnvEFtY0KqyxICHml5EKHStWAWkfhz80rO2v9trRSQWq5W0UROXPkfXe1AuNNKsjDQV+My7+tO0SeLMxT140dDWShDKbDkVdx6LnQuspYbz6QTZC5YL4HZt0I/inuAEDq8dY4qT9XspBCVJ3u3nYYzWJdSeGUs88mYcIAGy2t6AzxdrbsZ9YkKSduQaMQB7gnaUm80ltRlAiNlkv4A9YRUXpJkPhePvvTcb71RSWOEMKXFv6anh0wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XqOMZQwRamkCZXsgracaEUY67larGhekteWgPUX3M8=;
 b=tUNy5R5070IW3P2nfgVrDTlHJmj70OMNDyrE7NPxYqqDi1cI61DGoQ8+vQsKEFIPxDz8XVtIOoac62go08qbxM/ACgC044hv9CiVWjVOlnRBG68kfQQGycUHNLZCKANJwPYmaCwzM87CUDI+AImhjWibZHyQKALARm42+wJhmZ9uTUqHiySv+tV0jfhIqGSyIT4bWt9yscJEWgLeBcCeraXVD5CVVnF0sQcHKno3LdISNPmR5BXS/w6wLadaRFqAwSH1iwdA9XU5IG6hKBgycC97QFqsjP5I6W9S0HrT5etpFLQ+Crzwt3IZ+eEFaeK4TO5Bk0NW7xaaw40FAF3cOw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS1PR04MB9262.eurprd04.prod.outlook.com (2603:10a6:20b:4c6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:01:31 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 15:01:31 +0000
Date: Thu, 25 Jun 2026 11:01:24 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Brian Masney <bmasney@redhat.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: qcom: gpi: correct channel name in error path
Message-ID: <aj1CxNMHtbd2SsDK@lizhi-Precision-Tower-5810>
References: <20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-qcom-gpi-err-fix-v1-1-5ca3f00fe2e3@redhat.com>
X-ClientProxiedBy: SA1P222CA0154.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS1PR04MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c101b6e-3758-4379-0374-08ded2caa3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	aKRuj6OyI2hnNtbPtA/iQJ06VbvfEFb2ptwtC2lRcSZdVM5JpNOLg0F7RztFu5VOYWpfJ4STtakeplcm3MfZnPXLdLtLEabDW8mhWsDgVmIkQjFtr+4Jo4VeKrL53xw+gVAPUVNLuj2CBBZyv9RtlCguO6msRqhSSMsiu1nLowlbPTiEdf9oV2fs8kJ1At3qXvAjm6rNUujcVxb12HU3sAqNRufvsH324ir+2em9suICi2eY6hziuVudgAXZsqCKwUr+ywsGlteQPLM4Ncs9NH5XsRwy95p/eaqBtajIKUJdClyc94j97GpvN56KgcKGAJXHYZjAicZmcp2ReU0KFcUidQsbSq+Pr0oXEK3czXkhmxZcXsEg7Bwj/189vKEQhIuTG4Alr1PHod8lusQAlk90A9GgdcBm5UI6eASCRengE688i29RJQMhZRQQmQXAnCIl4T6OYaOD21Fgi2nYGcHAsSG4OA3gbhJ2xCXs0y/lZI3q6Xpkfp3JuxWTZhgkAO2jeOhxIqSFv2ZbmqDob2ViWCAXPx/v7WD88cahIaccd7ICaOjHIh5ix9n0r9xWMFuqRBIol5tn2OKosfu+IXwmY15AJEVwwOu31wI7bKKgxL0pwyhdU1aIrTqra2lbfyPLZgQ40lrR5hk94YYtZrmw/CV5UteSWCniujgUyv0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ggh+OEmJSehuhHoR9tUWi3BRXFUuvwn/GcUpLhhpqjaRre/mikweC2bY5cSh?=
 =?us-ascii?Q?CjoOGAP7KLIi1a1XfckDwuZLyoLzfQolbKVz5YC+VtgzCajxToOMzu3NXfhk?=
 =?us-ascii?Q?R/ZVXJjTzEY8oME/YIgPTSt08Dz+uG5t8LhHKlSiHfhuR3tMQt0DmV6iB/JC?=
 =?us-ascii?Q?ENNsNFgOJodPNZinVr42LlvRztLQn0IQ2AwEfNb9EZhETonSqy3IFQWGqGq8?=
 =?us-ascii?Q?M4XgmSa+VoVY4sOasQV4U1Bp+jONYMkoPtt3jGuvb3tgaEPazBKXBuBR1KVK?=
 =?us-ascii?Q?4N3yh0Lmz0IPGHdNAeyLmHa5moX4NlDURhduL8Zr3/khvf2Jz5B61LlBtFOQ?=
 =?us-ascii?Q?oFvOQqE1WkWUUGQOxYaN9hN9S16BThzc2JPVH2pwlNP8aas7BqRB/w5p3y+J?=
 =?us-ascii?Q?QO1W2Cmkw8Gpd79kGG9pILnou7zi2pkGNX3K8qbCH0r4+pQHRYD8+A4xD6CQ?=
 =?us-ascii?Q?HmWkFufBnc6hmxJp8DQqM89OtIavA8WWTQicfWm3x2kc+EixG8+hKuHkC4QW?=
 =?us-ascii?Q?hOY+m52YPqlrTEULIKmhL/E4QgOIZ9/HVm1TfbQf+uH/FMsNCEMolNM4nKEe?=
 =?us-ascii?Q?dEryGjcIIcKOqOzJq3hUT3R6XBlqYsNnxqJucN+ZZxdLyJxDlHics/cv5jqo?=
 =?us-ascii?Q?gIBi7BQ5c1vWOhk7l7ZXTsNCxSAfT5zOsLOos9+D3ls5lHnDvvFkV2v1PyCV?=
 =?us-ascii?Q?EXRSxaUBL1b+H+9UguWdFbJ45NwgwRU1b0MuXB2193a80TEQFHH42yvjDR18?=
 =?us-ascii?Q?A1znhYEKPbX8Rlp7RMm71I4OI1eWu9XFwmYBA66s6Z+33gwg5RSZ53ebPZcs?=
 =?us-ascii?Q?/H2o31wmmhxFrFMQ8sH/sSQBiCHuWT1KT3iPAtENAlVbrYoDkOvNETWtPkiq?=
 =?us-ascii?Q?14lXt03qGd4WvxAbA9NhD/uVITNcu1oCCS9oJ0R972e5YKDBXZYlO660CPj6?=
 =?us-ascii?Q?tyuY4zshC1YkOoQr7fz/9AGhWCvBmxF44TEG/lSaa6SHLnmrHU0gHFujTGvT?=
 =?us-ascii?Q?MFmzNKp+YkAdaBOdPILaWEVUOikxqBq6ia/Z3ETu5MS7Dxw0YrvJfQcnX04R?=
 =?us-ascii?Q?zheGlXMte+JKjy50Ve2Gklq6qXmkqRFYJgvarc7bj/x7gU4XRn0yCerC0kEc?=
 =?us-ascii?Q?/bLL4q4THKhDyvMERVlulZ79HJWqAranQxDA9/fuikSxIxaeP+9i6yIjbtfi?=
 =?us-ascii?Q?x8pYsp+hSC7C8u3d1ewKhGZuM2WkslHAhrbs/fy/ZSH+GjA4Yjid/a+lOUcW?=
 =?us-ascii?Q?Bcoiq0No9TpcsELn18xbzs0By77pXEfYAbcxcaTm2QH7XxILmVZI+7E1EThg?=
 =?us-ascii?Q?bfU6tVZsgabQ7/LzTvVnGmo2OWr8phMwApkud1j6WHg7A0I+bBZMfZBH50yl?=
 =?us-ascii?Q?901bvPIFLRJNrphnWcKUwvRsam3KOdsokbH7XlDGLM3Fg+b0x2MPAC0lFgi7?=
 =?us-ascii?Q?IiY8QGyh7tcKEVLWlBTLAHQBfzaEGSe013ZM0dnrM+piR610GnvqBIrFaY7v?=
 =?us-ascii?Q?6yBB38FbbDEKyECAW0xYA2Hc87hL0FcqoVm4H/jJwgyiLK6z+WkVIDLBHhDD?=
 =?us-ascii?Q?qGX3xrFar1/VDl9tQUC91MUiTPbPzYdBwwhrTqYoihhs9ZJvhakdIqDOx1C5?=
 =?us-ascii?Q?YKUp3MyA/YiJva77KWeRUy03IMb+MN/g/KHsLb+204eE+AAWw/RFHaRKhwfC?=
 =?us-ascii?Q?fE+7BVkKUCTP1M9cxZhvihC3uViVC7FkbTrwse+KfyN9vT0C13e9Klg6Z51E?=
 =?us-ascii?Q?a1uFZL87zhcKJl6sj1GqYNVHpQBQ0qj/N9NgJmX0Qlm8du8LxjE3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c101b6e-3758-4379-0374-08ded2caa3d5
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:01:30.9756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rXEIbS1OBlA1Nf9xwTZDUOSjt3c6XGBcYIu4VFUUoid2Wb1JCXR9flMFYfobYE8zFXZwHv+rDkeVUPKRqIQnGrk06aw5Ajhmm4rdcHTWILxuOP1f08tGjxQjXkMct5fX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9262
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11785-lists,dmaengine=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bmasney@redhat.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:linux-arm-msm@vger.kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	RSPAMD_EMAILBL_FAIL(0.00)[dmaengine@vger.kernel.org:query timed out,frank.li@oss.nxp.com:query timed out];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lizhi-Precision-Tower-5810:mid,NXP1.onmicrosoft.com:dkim,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA3166C6E92

On Thu, Jun 25, 2026 at 10:21:36AM -0400, Brian Masney wrote:
> When attempting to start the Fedora graphical installer from a USB
> thumbdrive on the Lenovo Thinkpad x13s laptop, the following errors are
> shown in dmesg multiple times:
>
>     kernel: gpi 800000.dma-controller: cmd: CH START completion timeout:0
>     kernel: gpi 800000.dma-controller: Error with cmd:CH START ret:-5
>     kernel: gpi 800000.dma-controller: Error start chan:-5
>
> Looking through the error path, gpi_send_cmd() sends the wrong gchan to
> gpi_send_cmd() in gpi_ch_init()'s error path. Let's fix this by passing
> the correct gchan.

Fix this by passing the correct gchan in gpi_ch_init()'s error path of
gpi_send_cmd().

>
> Fixes: 5d0c3533a19f ("dmaengine: qcom: Add GPI dma driver")
> Signed-off-by: Brian Masney <bmasney@redhat.com>
> Assisted-by: Claude:claude-opus-4-6
> ---
> There's a separate issue with the graphical Fedora installer not
> working that I haven't had time to dig into further. I can work
> around it by using the text installer.
> ---
>  drivers/dma/qcom/gpi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
> index a5055a6273af..3f390b5821ab 100644
> --- a/drivers/dma/qcom/gpi.c
> +++ b/drivers/dma/qcom/gpi.c
> @@ -1965,12 +1965,12 @@ static int gpi_ch_init(struct gchan *gchan)
>  error_start_chan:
>  	for (i = i - 1; i >= 0; i--) {
>  		gpi_stop_chan(&gpii->gchan[i]);

Not related this patch, but code logic is strange, why init one specific
gchan failure, need stop previous all chans.

gchan should be one of gpii->gchan[i].

Frank
> -		gpi_send_cmd(gpii, gchan, GPI_CH_CMD_RESET);
> +		gpi_send_cmd(gpii, &gpii->gchan[i], GPI_CH_CMD_RESET);
>  	}
>  	i = 2;
>  error_alloc_chan:
>  	for (i = i - 1; i >= 0; i--)
> -		gpi_reset_chan(gchan, GPI_CH_CMD_DE_ALLOC);
> +		gpi_reset_chan(&gpii->gchan[i], GPI_CH_CMD_DE_ALLOC);
>  error_alloc_ev_ring:
>  	gpi_disable_interrupts(gpii);
>  error_config_int:
>
> ---
> base-commit: 6c94b38b83a04c43ea49004275f0391404051093
> change-id: 20260625-qcom-gpi-err-fix-06ef18453608
>
> Best regards,
> --
> Brian Masney <bmasney@redhat.com>
>

