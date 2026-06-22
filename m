Return-Path: <dmaengine+bounces-11727-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 10BLIEleOWrhrAcAu9opvQ
	(envelope-from <dmaengine+bounces-11727-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 18:09:45 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D47016B102C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 18:09:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=coNshAln;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11727-lists+dmaengine=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="dmaengine+bounces-11727-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 092DB3002B5C
	for <lists+dmaengine@lfdr.de>; Mon, 22 Jun 2026 16:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C133CB2F8;
	Mon, 22 Jun 2026 16:06:20 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011050.outbound.protection.outlook.com [52.101.65.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C83CB2E9;
	Mon, 22 Jun 2026 16:06:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144380; cv=fail; b=ZiMKg5Mnds2MGKaL1czHcKH+7NEC+vbzEDm4B7aW/z8fBOLKuwo/3Kd5AcGy/o3WiuDTw01IBd+26wm30BTLMsi7Jt1HIk8446Bd8AD3vOeRYHD+h1xqU5dotW4aEWeZRjggA+69YWjkIEjLzHrqHpEgIhPti+qaAkQXr/mSqjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144380; c=relaxed/simple;
	bh=zQlGTvFsDElXjxaEO1RskztZJ1MbtbLkieg+RckjmDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MUB15WVvBXb7FAzAhlQgQIUeimJ6b3t/GvEB7rJz/+sMZIwoDcHG0efFt0vO1Ith4e5ekkv0zjbWvkoxCDMKdb+kK+L97OGvhx8U/6yX1vb18l0uUjonlWIo9f4TEFXgML5i9JWNCjIclVgECVmTozfiy6gZHKwCg4VqPxzoiwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=coNshAln; arc=fail smtp.client-ip=52.101.65.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JX5Xx99yIrHaYJOyHKmnhrMkAd1JB+S8Yr9X2ssDgP6yfatCfFsAkb1eLCIQV4sCi3yx5fh4Gh43dt7uCdhQM4+4OxcQMceqf/IrPyB6CZ4k3QqKImxD01gqPlU7cVS7A0kh4/HzvCIyM3x+CF5aPc76MLWwfm62qj360DJvfU9d01JTkTK8hJUTNENC80CPq3RSxb3DSZtE4a2LRQFYRJBl+EqtDgReR/wUkmN0kJnpaKEm+1oYdhkHhYVAVdLJFbj5E4baJge0aQVuTKglgYPOGPXWOx4vBSpMyEM5vK8Tw/a3SSY1/atbrYeYlPKYJtCXoAqadKzBneglrPej8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZ3EWDTWDRtWDxWkbc7TyFY8IvkZTKrvuPOAuUzrEdM=;
 b=JkHpM+0O/4dIdxbscg5zo2396QI27fTAO/WDc0m9IBSRPShH/pNzPg2yBXqvbhBXUDiwyXP9PC2aYv0on7lcgRpf7K6XwaobW5uMa5OgIjfW5SQEG0WV99ZyAXibVDdFFlFE1ZFowNj61na2mU9rpoO+BIcRQ9ueJK8gPpzHhQqouZZ0ihHY4QnB/1YAM38k9Se74BJupu8IGTMwlOMBptcPDWJw0DuFLMCba395YEwvs/tQpdPoSU6FRb3rVWlUSHlFH9cJNpva2NRU67DuoHS2ZEo0lGpYRFPhu5U+UWqnFSbDvlAFjpdqMV2ezEsT8G9encl2UVG9axrxRssDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZ3EWDTWDRtWDxWkbc7TyFY8IvkZTKrvuPOAuUzrEdM=;
 b=coNshAlnqNueVrSx+21yWDItvRqCvRpWtrnDgxQexCzZnXAarhab94Qf3Yq97qkj+CnbZj431pCC8B9oGPgPgyZ0GpcfGh+NDha5aXOq3Bs8YNAb08TzpLEWfKbmHb8r66xGjPiEt/823wsTeH854wvdUg4dA9qD6A45TdL7fVnLXnFXP0q61KfyHkP/4S3Am2O/UT9HWa9Ry6kd1Uyr4n6tbraChewZPlrmsV7KGmHUQE1d7bTMlSa4VfK9QSMPHm2x+reogqYvmV9gMWxmhcP8kJdKysI0bozfhIG8pyK0BcYWg7sMDKnzs8U2uYqSLJK0xtdUUkhjKCWIPMvBVQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB9230.eurprd04.prod.outlook.com (2603:10a6:102:2bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 16:06:13 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 16:06:13 +0000
Date: Mon, 22 Jun 2026 11:06:03 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/13] dmaengine: dw-edma: Add delegated channel
 request helpers
Message-ID: <ajlda1gkqvXCPmrs@SMW015318>
References: <20260620170040.3756043-1-den@valinux.co.jp>
 <20260620170040.3756043-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620170040.3756043-4-den@valinux.co.jp>
X-ClientProxiedBy: PH8PR21CA0020.namprd21.prod.outlook.com
 (2603:10b6:510:2ce::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB9230:EE_
X-MS-Office365-Filtering-Correlation-Id: e0920fa4-616d-4fb9-35ba-08ded0782ead
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|19092799006|18002099003|22082099003|4143699003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	zcQFh5YqAQ3WfGUpiGFT5EItdKkqmc4hxq8Ny4rEnm+Ys6lTiUhvi+DCz1jBe8fqCutT8jSs3D6R33fSbn4pth01ofR7kR5sHZ4SIyR+OvFaKZFzjDykE800UVP3U9x0aCRqSmByI1G19TasD5+E+C95UHApZgVfCRh0wZ+S4kwTzfiP33pucgszTaQzoZkINcJvQZkvx+TAOYL7EPwS24LlvhcOKaKOWEo/lpQVRCHG3t1XiTFAlv6V6pVv0vt4s7k1neDl2yHhOb7J+25Ama+RiLSJff/eT4MTgsDQgVJwdwRdumSTyEJl027tXd+wVTlpbiFGO3nTs4Wjv0GA7g16fK5xm4ume9llvBkbhNhncfq2Ig0ITX8pwmyiPT41qaEU990QGn0C0Yf/IOI4SYGgy5JEwiMxzejSuIjX7D6Lfi6djkjLMQGDfCug6o7jyTd5G8NDyJ5+POZf/0zWK+xI3zv8oRSlhD0Y6/vFd3VGRnqAKabH6Op5eRp3XPaRm7KRK5DIwc0BBR/XoArniy9y7XpLQWCfN6J5OaB9puMf2EreN6VlOpWo3sKEK5IsOPBTO86s9tUGTePn541MWBPhqo04A/dmc/QFxvGz0bxG8UJspESjq9m1azGhlzblcMAxwTANKrOz3GYxjV3HDnE3PbTmvwuKcC8Tj+82BcI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(19092799006)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y9efh+8cmGWUFizjf41B5VTQ4Pmxv4pF6iiRiszG4/wrUgprCiOqIQy65HH9?=
 =?us-ascii?Q?7KuvOqVeBkB0AsZCiMwj8u3KJytBnxKCkdUanNs8mDviFlDqcUqyu7fayE/V?=
 =?us-ascii?Q?Di79dr8J4RoNS5Yvqg3gATjZp0XucvIGUSeEtWIiX+fMXx4Q+T2kUFpT66N1?=
 =?us-ascii?Q?DLABlQRQmwlKaIWf+J8Qw1RSwZk3g0zGqQQy4VZb7+cGa2z4uzk/AEgCvwVr?=
 =?us-ascii?Q?7hYX991FiX4+4CdATwUIwnTk6wa31QnriFOEpOCLKUakZhfhzA425IgM2xC5?=
 =?us-ascii?Q?5aoDgMJADUw//JWrduQ8yW7yheRBBUS01plynz0OxI5eafwcuHi1LXW9ya9i?=
 =?us-ascii?Q?Njc/X0Bm+GVBmhwiLRj5NiaLkW5cuWSGlSLSOmVgpqtXBUagoOl804leJ3sd?=
 =?us-ascii?Q?hx/vSIiyDbnSdEGrJaobWTq27S79VLP6rFMsCL6E9QHWS3lpf7Qijddz00or?=
 =?us-ascii?Q?GvnNdW3JPfFp5jrcNx0MpoSWKG21dTpX1d/nNfg/EwEf6DW+B+W4jvkL5v17?=
 =?us-ascii?Q?jGBzX4KUGr3fTG9vS1eBToHZqz1E2MfJncoU/UmGTp+zcbxDI8buPw4QW5YB?=
 =?us-ascii?Q?KE3I0C6nLvh5dBlMcXqKqz0xRJ64DWa9FnArkA8+Z/Q7USYe9mqYyOtl7T3I?=
 =?us-ascii?Q?HioncuarcgBvq4BcF+zQVLf5zoYTBk3OuJE/GE+TNf/98VgT/ueFyLMD4+Ep?=
 =?us-ascii?Q?0FCBU38HOyV3EE2ygvBH5TrIOyvC642Lzta0y/5rxaVvSyhZoR8wjfSmMWj1?=
 =?us-ascii?Q?InJ5+YLv0envCje3m8dsxk9JpJnLZHuVYiu/KOd+BxlLwHpOlx1c+lrPc03J?=
 =?us-ascii?Q?o2wLM6ixJ5O2sqJJKq8nCXYaVMqBKDH49k3D+JrSeEihJt3JwA9wRo3mqXlU?=
 =?us-ascii?Q?6wWNREO5E6h73JDilwCVz8s0YGgEU0hwP4HOGjogrWIEISHyMdls/QY7ybuY?=
 =?us-ascii?Q?uKmeT4Ho/TFjSoPhXmjnyDMoVnQ+SWHSRN0taOujErIxnSFmGfdmZYoIxFwm?=
 =?us-ascii?Q?sR4RvrHU+jOayiJUGVTELzSSRPx1iWtJtmsZ03yJTNoJXjNsKiqZqk2pisjU?=
 =?us-ascii?Q?qiq4wHaTZLMpnhruBhNiuyHTbZeAf2YEGilciAHcTpPURuH8CVQrJ2nrRla5?=
 =?us-ascii?Q?EwAcNUsyZp4QLGScEqMlpHC/cI/WcncEdQBwDW/+ENYyuTF0hj2m2suxygk+?=
 =?us-ascii?Q?7KrqPfWz9dBSi67oTz7s7bGIrN/VZl6KbluDeX566e6IhRbonfwOW6sGMK/9?=
 =?us-ascii?Q?cnMIJMRY9RCE3qBt9dzjfk9iZwnISvHxYI98iv8mMyg54mN2+STIP1Gt29ml?=
 =?us-ascii?Q?pznlO3c++sTx2D8ITfKtECd8CwLK8eB3+Wikz3eGtdqIBn53fqBVVUJi2bRx?=
 =?us-ascii?Q?JaMTe9DmtbW5VoAWd624DWc199uXvAXYUOBhz/FEX036ikIm+8hdQYDxSRF+?=
 =?us-ascii?Q?SSfV4y9BV9GJMzQnOfzHBXdiQLO2B7EHFjVu4/G5V4fQdS5/QoLQdjrNKQ6W?=
 =?us-ascii?Q?ENqT4hUWtkMoTj+iyZqMn7J92XzQp0+JsuQy3l5np/eOla8QwnlYbdBHuAbL?=
 =?us-ascii?Q?22/7cRomGK3FZQVN8HvGOprbtTDNAKZdvKSIzoaekYShUM9iXCi0KaUBkdFJ?=
 =?us-ascii?Q?AmvkJrTw9dCBjFAFyc/OZCRgF2wXf8ZWY905p6V0oDeJWe5oi/9A/M5dyLQg?=
 =?us-ascii?Q?tEW9OTFhiQlTK5RtXjCMnuDrug4uUrF0FjKcDF+AOaD6kBf/pxY+w6Cg3cgi?=
 =?us-ascii?Q?0C5mmUkNj9NHYb0xqff6K4sA9sOnTJtIDKYIIHOF6zWzsJSXvlX0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0920fa4-616d-4fb9-35ba-08ded0782ead
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 16:06:13.4120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oqi6a76kDEHCbLJI1ojFTPeNhceADP5wn0ErbT7VA9bEEWH7YkD9pIVmtmu1A9OXYs2fyPm8rpdQ13GA28bH1O0PCFlw0LLnET4zxKf4XFFFjSb8U/0bQI8wLKzsBhWX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9230
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-11727-lists,dmaengine=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,SMW015318:mid,synopsys.com:email,oss.nxp.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,valinux.co.jp:email,NXP1.onmicrosoft.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D47016B102C

On Sun, Jun 21, 2026 at 02:00:30AM +0900, Koichiro Den wrote:
> Endpoint functions that expose endpoint-local DesignWare eDMA channels
> to a remote host need to reserve exact hardware channels and hand
> interrupt ownership to the remote side before publishing the channels.
>
> Add DW eDMA-specific helpers that request a write/read hardware channel
> through DMAengine, keep the hardware-channel filter private to dw-edma,
> and switch the selected endpoint-local channel to remote interrupt
> routing after the channel has been successfully reserved. The matching
> release helper can quiesce the channel while it is still remote-routed,
> then restores the channel's default routing before releasing the
> DMAengine reservation. This lets callers skip quiesce when unwinding a
> reservation that was never exposed to host programming.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

I have not see any place to use this functions, can you move it patches
serise, which use it?

So get these patches land firstly.

Frank

> Changes in v3:
>   - New patch. Replace the public hardware-channel filter API with
>     delegated channel request helpers so the filter stays private to
>     dw-edma and delegated IRQ handoff is handled by dw-edma.
>   - Hide the hardware-channel filter inside dw-edma instead of exposing
>     it through public headers (Frank); add delegated-channel helpers
>     instead.
>   - Set endpoint-local delegated channels to remote IRQ routing after
>     dma_request_channel().
>   - Allow delegated-channel release to skip quiesce for reservations
>     that were never exposed to host programming.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 81 ++++++++++++++++++++++++++++++
>  include/linux/dma/edma.h           | 14 ++++++
>  2 files changed, 95 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index 7a24248b84e9..ca0504eac1fc 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -1192,6 +1192,87 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(dw_edma_remove);
>
> +struct dw_edma_delegated_chan_filter {
> +	struct device *dma_dev;
> +	bool write;
> +	u16 id;
> +};
> +
> +static bool dw_edma_delegated_chan_filter(struct dma_chan *dchan, void *param)
> +{
> +	struct dw_edma_delegated_chan_filter *filter = param;
> +	struct dw_edma_chan *chan;
> +
> +	if (!filter || dchan->device->dev != filter->dma_dev)
> +		return false;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +
> +	return chan->dir == (filter->write ? EDMA_DIR_WRITE : EDMA_DIR_READ) &&
> +	       chan->id == filter->id;
> +}
> +
> +static int dw_edma_delegate_chan(struct dma_chan *dchan)
> +{
> +	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
> +
> +	if (!(chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL))
> +		return -EINVAL;
> +	if (chan->configured || chan->status != EDMA_ST_IDLE ||
> +	    chan->request != EDMA_REQ_NONE)
> +		return -EBUSY;
> +
> +	chan->irq_mode = DW_EDMA_CH_IRQ_REMOTE;
> +
> +	return 0;
> +}
> +
> +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> +						bool write, u16 id)
> +{
> +	struct dw_edma_delegated_chan_filter filter = {
> +		.dma_dev = dma_dev,
> +		.write = write,
> +		.id = id,
> +	};
> +	struct dma_chan *dchan;
> +	dma_cap_mask_t mask;
> +
> +	if (!dma_dev)
> +		return NULL;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_SLAVE, mask);
> +
> +	dchan = dma_request_channel(mask, dw_edma_delegated_chan_filter,
> +				    &filter);
> +	if (!dchan)
> +		return NULL;
> +
> +	if (dw_edma_delegate_chan(dchan)) {
> +		dma_release_channel(dchan);
> +		return NULL;
> +	}
> +
> +	return dchan;
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_request_delegated_chan);
> +
> +void dw_edma_release_delegated_chan(struct dma_chan *dchan, bool quiesce)
> +{
> +	struct dw_edma_chan *chan;
> +
> +	if (!dchan)
> +		return;
> +
> +	chan = dchan2dw_edma_chan(dchan);
> +	if (quiesce)
> +		dw_edma_core_ch_quiesce(chan);
> +	chan->irq_mode = dw_edma_get_irq_mode(chan);
> +	dma_release_channel(dchan);
> +}
> +EXPORT_SYMBOL_GPL(dw_edma_release_delegated_chan);
> +
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("Synopsys DesignWare eDMA controller core driver");
>  MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index c0906221a7c7..0ba8a1143fb2 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -140,6 +140,9 @@ struct dw_edma_chip {
>  #if IS_REACHABLE(CONFIG_DW_EDMA)
>  int dw_edma_probe(struct dw_edma_chip *chip);
>  int dw_edma_remove(struct dw_edma_chip *chip);
> +struct dma_chan *dw_edma_request_delegated_chan(struct device *dma_dev,
> +						bool write, u16 id);
> +void dw_edma_release_delegated_chan(struct dma_chan *chan, bool quiesce);
>  #else
>  static inline int dw_edma_probe(struct dw_edma_chip *chip)
>  {
> @@ -150,6 +153,17 @@ static inline int dw_edma_remove(struct dw_edma_chip *chip)
>  {
>  	return 0;
>  }
> +
> +static inline struct dma_chan *
> +dw_edma_request_delegated_chan(struct device *dma_dev, bool write, u16 id)
> +{
> +	return NULL;
> +}
> +
> +static inline void dw_edma_release_delegated_chan(struct dma_chan *chan,
> +						  bool quiesce)
> +{
> +}
>  #endif /* CONFIG_DW_EDMA */
>
>  #endif /* _DW_EDMA_H */
> --
> 2.51.0
>

