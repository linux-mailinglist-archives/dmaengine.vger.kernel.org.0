Return-Path: <dmaengine+bounces-11820-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 07uDGDiiPmqMJQkAu9opvQ
	(envelope-from <dmaengine+bounces-11820-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 18:00:56 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E73286CEBDF
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 18:00:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=SZ8DYibr;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11820-lists+dmaengine=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="dmaengine+bounces-11820-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0EC6C3000B9F
	for <lists+dmaengine@lfdr.de>; Fri, 26 Jun 2026 16:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36121EB19B;
	Fri, 26 Jun 2026 16:00:49 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB339D6EC
	for <dmaengine@vger.kernel.org>; Fri, 26 Jun 2026 16:00:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489649; cv=fail; b=E8pAEJOQlY/BoLCHsU/r5hYbzWNreP4X6bD/6oK+n+Tts/Nfd5mlpAqE1VQh+buFOBYUtGJ5jH6sRPc0fjL7trGaI4nnXyW2Co+NsFXhf4+esuVYleiHgz/js2eC0UvgwHTk2scsPEM4yiiSZzCcRH0BjpfeixGeUJqZZgwNmL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489649; c=relaxed/simple;
	bh=NBm5NeQ3ddH6MOU8fw7wFSypy5YW/8AVLjG/M3y8Nfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Q+pCZiZmMqQAkp4y9jpJTNwmrAN/5npwF17U9C9VR5hcSrhkaJHTF6hGZeqFonxMqvJzL+IzaX44w3db4NU2CjhpGi580R5Ts4LTzEa7zcEepBC+SF6IDf7bRaY/1osw44AgD//l8mPQq3lSHlFw4bruetoQS8VkrcYF69ZFiHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=SZ8DYibr; arc=fail smtp.client-ip=40.107.159.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qe2Lwt9Aqd03OxloZ7MPPZad8inl/N/aXT08QfQEq2XecTeFSeuA1aSBgSqKCdMxIKeJWBj3yrS7V3LO8+foDKCg/JNiHHlsjbXaUN9p5nRxaH4BKCgCGCfMzeSa4KRjz/BVmlivU3kRZIXGVisK/hRrgB3ZlfLmZUxC2FyP0rB+Pdw1+acU9NCfdFwAWnmIPDCYq5K2DEP18oxO4V+MM7tTGk7FZiHHojwbMLD68UDRZBrEkpzW+iwHk17qPHUbyMtpc25EX2KPefwUjcDwRN/8AX/jlOuHwvq8G1q4OUE3DXuz2g46sNfcoSx7GkuiGhFcqYihtx5pceP3rFU9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIPuyTJthoo2f18tWe8hYfurTNdhvLBzuqbESON8zyg=;
 b=yue28og4bjH7Q+l+sOOlwXAnjDvu4ohTDtP263kOaBqiYcvoObFJ5zA5cQaej8GK5q4svCySY6DdT5Mu4pwxr5qqNRPs/++qDiLO8ftxrCfP1ZjfwDbFT6NkmRJ5q0TlK8UNcqDqEDMb7i/opliELeBX887gWCKWtPJdDR1M2C6VxsrzcAKdZ+4l+ofovjtF6EFnSRsRlglU6ptgofYzt+648pNpIjy0rGIUKi3inJDckk0hUCbOm72QFdcn2d9t7O7ow+ZFthRcALIGRvTdSyTbGIvXVU7LT0LE5OoaiXFJZsTRmHPPkZXLxESQoRjBN0HRkYFyX6cBIDFVD3CxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iIPuyTJthoo2f18tWe8hYfurTNdhvLBzuqbESON8zyg=;
 b=SZ8DYibrUFr7t4di446OjSmx2nScJC2/blNJHmMZlNjy3wsMMhjJLAOND5AuwVH1EJZZUVsPTIr/l18OJxu1V9OUIUDmyBY2sHuosHYhIE3PVm4tiTPQyxqDXSzVNmFLQegZBZoMdP9h/kb2h4jvgj6GgmBFs2HPZeNYXEQLxgaSOZewrMZnJoR1iyMDe1FM8/48IZLVLH5EceiKdJpjK7hTaRwY65imKlkz9v+OavogHuCylefIq6rOOuHNxwZFooFGdlff8BNIsmM342j3Ao2AGWouueRz8u677eZYmimBoLRAKmji41Or+sbfQ+0i0t1VBUQpclA4w47PXfFKRg==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by OSKPR04MB11416.eurprd04.prod.outlook.com (2603:10a6:e10:9b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Fri, 26 Jun
 2026 16:00:44 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Fri, 26 Jun 2026
 16:00:44 +0000
Date: Fri, 26 Jun 2026 11:00:34 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: "Verma, Devendra" <devverma@amd.com>
Cc: sashiko-reviews@lists.linux.dev,
	Devendra K Verma <devendra.verma@amd.com>, Frank.Li@kernel.org,
	vkoul@kernel.org, dmaengine@vger.kernel.org
Subject: Re: [PATCH v5] dmaengine: dw-edma: Enable HDMA 64R/W Channels
Message-ID: <aj6iIr61LI9Sm10h@SMW015318>
References: <20260626132151.1875965-1-devendra.verma@amd.com>
 <20260626134641.87D161F000E9@smtp.kernel.org>
 <3ac6b44c-febb-4c20-a737-aba34de5c208@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ac6b44c-febb-4c20-a737-aba34de5c208@amd.com>
X-ClientProxiedBy: PH0PR07CA0058.namprd07.prod.outlook.com
 (2603:10b6:510:e::33) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|OSKPR04MB11416:EE_
X-MS-Office365-Filtering-Correlation-Id: 504ea85a-b15e-4368-cd1d-08ded39c144b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|19092799006|22082099003|18002099003|6133799003|11063799006|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	b9NiyemLqjwXJwDYz/m5xBmS0Wdw75wN6Y48cBebzxdlDZg936l3zWGcw80IfmQ6IdHw1cqUt2pFDSpRb03brPcaNyLfKNWAwrC9yEYERIWreC9oaFioa+qn8WdtjCloSKZ2U4UPeR566n0uafF+bw18OZ2JOJW1CvDj4LHbl3kJo4NzPGHVMGVGdkl5WswWg9R3p1/dcUTIMETmkAsMpdpafDPA9QL61Z8hXoAdfDZTJQE94e24fn/9J4hn3/XAZCm4P2ITnhz4bNHaYXx17QhikKVOeg4IZSiKGSG/omrnDGOsM5vEUUpjNvFIfqthyHLSvorXvhcFXLIGUdI+FKfz5PigsqFFHZdooZIj1RCkycqihOK1BhAT1TbPO4tldpgVno4K4YeNVPR/iFBRTCwCQSWT5TfaDo6Ud7q7mAzOBZpFwM/5z2giZUNH/J6duKs+3LEXR1OR2Xc2j3L3xfdW6phvVuMburUKFyt0iFN58HyUGiYufvSYhNr7WamO8qUk3TF9vlplYr/PO6w8nCrYyDzGc54/76HpHIpZklkEB+A+ccKxEiAHupMwgs+mNitedh9VWoPk6KlUhDi/wM6sivh4qegnKCEBfAwg7/r4vp5tFOE/hx2QrMCfi7qqlKXj8R2nq+PMBvuKvZJQcX8Zxr9SXj/IUxo8jkbPSTY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(19092799006)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?N1BjqAJDJTsg3DYGhoih6K0bq3IhviLl+50XSVTsh4dHmtc7iHqijNbtgaS+?=
 =?us-ascii?Q?ebdnPMChe8iVGl3zN4XpbMPRw2Je1OfUw9r7vaNacOrj/Xl6AluvBPQ//LvC?=
 =?us-ascii?Q?9H6bqzFlQ6KdlhKFiJdM8FnQ6u+KCyIIxA4PQrgEdBKPGevkFcAxhfFmwJ3f?=
 =?us-ascii?Q?x1151PxQj+2v/VsHAbJ3sj0QgfksVKMpkJCy2yIUEObr5FXhzrKdrvSqBnSp?=
 =?us-ascii?Q?j5Id6l7QJQl00I/0HkwSLKjtwqoQ10aB0bhY8jSrUg1m3QY7wB18a1xHrPHE?=
 =?us-ascii?Q?y0vTqLn/2fatqpELWOooEMX/2kScSSLtF/nVuTOAFEOq86ENzyXRsabDPenI?=
 =?us-ascii?Q?aVJtFScDrNGEd8K7CmIL8HaHx5xxyTaBThXf0t9BbzbH5K9KHdYNtVp3Ealp?=
 =?us-ascii?Q?3GKeuhzXvOoWeON4iMazWU5vKHcD21KFikFst2X7kda1MbG2O955MeeqgHGz?=
 =?us-ascii?Q?4A52UAvfgT8jkI8cKarUtPYhwGxu1RtAy6SGkKDQVnuEqbtkShPMI4fsu1Dz?=
 =?us-ascii?Q?nI5/D8vnounNiR7+akOnMoZ0BCWaVTdSwDEA+xyyvUDVQW+EC2x+mWquvmXn?=
 =?us-ascii?Q?oLdK4Iq2TbhtHbQyFcXLOANY/0GbB9seDYivNkbgwBw7i1bzvyv7YdAlib+j?=
 =?us-ascii?Q?QYBhpijQt3mKy9rjajUOGyDb2YYl9m05Mdch9EDnbiDMo2jp9h9o1TwIYRJT?=
 =?us-ascii?Q?I579/ttnAGqcakRUKWwYrsUSgVHP6trslxFAnw+OyRgSgovZAV/iehyXPXe7?=
 =?us-ascii?Q?5RpTzlgrasN1riEPyLSflfWcn1stZd8j/XYZ3lO2S+450AzyH4Ly56S2B3Od?=
 =?us-ascii?Q?LW1eyPlUxGL4RFZ46pX8O+jzO0mb7zduQOV6OQtymkGLGs3utGeysWChjUnq?=
 =?us-ascii?Q?1uF+tjqU7iq7JVwLsyH3PcJI9SOz1hC9s8fmRC3BZL3TiJWHIKq7D5ORV1OA?=
 =?us-ascii?Q?Ak3bf1xcOOYo4qM3PZaMN+Ww/j/c/AkrvGEzhSagUUL1TaRSLqUB3RQMwWdK?=
 =?us-ascii?Q?EZbjCfBazUVXd4eD5ruRXBVCCnNkRAqzeI+7f6ngtCiZMmjDmF77TGT4/IGo?=
 =?us-ascii?Q?kWeaVX/spDzFFVMcW67GzOy0cju+meYSAPEGs7jmBU55Kz4Is7uxA7eG8GO7?=
 =?us-ascii?Q?qdyOsy2f4BObjFPKQcb/fYsK5alVg+4CWZ9Ab+fYc6Og1nEZnWacMGvrq21q?=
 =?us-ascii?Q?TlLW9/UrHli6rKSypFzWxTo6KGQIq/98KDjKglmhBMIV/T9ErGWaERrKRxHO?=
 =?us-ascii?Q?H8G5dmwk6CA4+iIjlFFT56FC6RU/UsOZgyHySJgJcnAECUO+QhpgX4SXllvh?=
 =?us-ascii?Q?vfFIxd1k9jWk5V7Lsn5gjRtekJv8PCEewxTpQyGUHq/7Fl/1AYPh1Mgy2eef?=
 =?us-ascii?Q?IXZhD5oTeLvg1z1rFT3AcMZAzrz+Mxort5corDBJdqbwjyuCVdDX3eEeKWcQ?=
 =?us-ascii?Q?WZMsQqtOxvavD6AnV/rrFTqZ2fpFcKc6zlNYgmm8hizro93KD7OL6hiNB1fz?=
 =?us-ascii?Q?Fy5AQPYhNdJtQ84GFC+PYAbZisQiCo4l9krBK1YkkT1PjU8Ltn6CieAkaydb?=
 =?us-ascii?Q?7XNc9NAk1+kWaSwtBO7hVTKjCjTnqV6ANYphw+r2XKnhtfjw3/euNq6E92Lb?=
 =?us-ascii?Q?zMeSm/0e35yzx7l6Oht73MMU17QW1aeO9+FjLXRAL4ZI8qZ331h76L44Lc+v?=
 =?us-ascii?Q?xTLhcvT/gh4UZUqnDhskkYrjXnQT2q+KPXW7tlLE3QzQHDmQibjLFo67YkDc?=
 =?us-ascii?Q?o8MH3UA7MN13v2sBtgasZ9Tf3H5Y9/7BxNXzWLmhPMRQ9s687TJ1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 504ea85a-b15e-4368-cd1d-08ded39c144b
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 16:00:44.5724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YfB31yqtWyVddMIC376CJwFZkzRUKfQDmKDeAkY/24eitIk4/u93DwIAAK3RpGS8IgvZ2lypAKqzZm/5gzUWQOVom3r94a1dTfISxEwD+s4DjGm4hZeohBbg1rmLBDD2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11416
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:devverma@amd.com,m:sashiko-reviews@lists.linux.dev,m:devendra.verma@amd.com,m:Frank.Li@kernel.org,m:vkoul@kernel.org,m:dmaengine@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11820-lists,dmaengine=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
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
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,amd.com:email,vger.kernel.org:from_smtp,SMW015318:mid,oss.nxp.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E73286CEBDF

On Fri, Jun 26, 2026 at 08:56:35PM +0530, Verma, Devendra wrote:
> Hi Frank, Vinod
>
> Do you have any suggestion about handling of the repeated comments from
> AI?
> On every version of this patch the similar issues have been raised and
> I am replying with the same answers as many version-times.
> Please suggest so that multiple replies to the same queries by AI bot
> can be managed.

You can omit pre-existing. Only reply once when patch close to land. I hope
there are tool, which can help identified comments and pull your previous
reply.

On method may help:

After I provided review-by, you can reply you already checked AI's results,
so It help vnod offload his checking work.

AI is quite new for us. we are looking for efficent flow to handle it.

Frank

>
> regards,
> Devendra
>
> On 26-Jun-26 19:16, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> >
> > New issues:
> > - [High] The DesignWare PCIe controller integration rejects eDMA initialization for HDMA platforms with more than 8 channels because `dw_pcie_edma_find_channels` and `dw_pcie_edma_irq_vector` unconditionally enforce the old 8-channel limit.
> >
> > Pre-existing issues:
> > - [High] The arguments `dir` and `ch` are swapped when calling `GET_CH_32` in `dw_hdma_v0_core_ch_status`, causing it to read the wrong hardware registers.
> > - [High] The driver requests shared IRQs before the interrupt context data is fully initialized, exposing a NULL pointer dereference window if an interrupt fires early.
> > --
> >
> > commit cc43ddee72586cbf9f93d80ae20f2b0a9e539a31
> > Author: Devendra K Verma <devendra.verma@amd.com>
> >
> > dmaengine: dw-edma: Enable HDMA 64R/W Channels
> >
> > This commit updates the DesignWare eDMA driver to support up to 64 read and
> > write channels for HDMA. It introduces HDMA-specific macros, adjusts channel
> > counts in device structures, and switches bitmasks to 64-bit to accommodate
> > the higher channel counts.
> >
> > > diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> > > index c2feb3adc79fa..adf1b3939f96c 100644
> > > --- a/drivers/dma/dw-edma/dw-edma-core.c
> > > +++ b/drivers/dma/dw-edma/dw-edma-core.c
> > [ ... ]
> > > @@ -1079,6 +1079,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> > >   	struct dw_edma *dw;
> > >   	u32 wr_alloc = 0;
> > >   	u32 rd_alloc = 0;
> > > +	u16 max_wr_cnt;
> > > +	u16 max_rd_cnt;
> > >   	int i, err;
> > >   	if (!chip)
> > > @@ -1094,20 +1096,25 @@ int dw_edma_probe(struct dw_edma_chip *chip)
> > >   	dw->chip = chip;
> > > -	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE)
> > > +	if (dw->chip->mf == EDMA_MF_HDMA_NATIVE) {
> > >   		dw_hdma_v0_core_register(dw);
> > > -	else
> > > +		max_wr_cnt = HDMA_MAX_WR_CH;
> > > +		max_rd_cnt = HDMA_MAX_RD_CH;
> > > +	} else {
> > >   		dw_edma_v0_core_register(dw);
> > > +		max_wr_cnt = EDMA_MAX_WR_CH;
> > > +		max_rd_cnt = EDMA_MAX_RD_CH;
> > > +	}
> > >   	raw_spin_lock_init(&dw->lock);
> > >   	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> > >   			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> > > -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> > > +	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, max_wr_cnt);
> > >   	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> > >   			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> > > -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> > > +	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, max_rd_cnt);
> > >   	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
> > >   		return -EINVAL;
> >
> > [Severity: High]
> > This is a pre-existing issue, but does the current probe sequence expose a
> > window for a NULL pointer dereference if an early interrupt fires?
> >
> > In dw_edma_probe(), we call dw_edma_irq_request() which registers a shared
> > IRQ handler:
> >
> >      err = request_irq(irq, dw_edma_interrupt_common,
> >                        IRQF_SHARED, dw->name, &dw->irq[0]);
> >
> > However, the interrupt context data (irq->dw) isn't populated until the later
> > call to dw_edma_channel_setup():
> >
> >      irq->dw = dw;
> >
> > If another device sharing the same IRQ line triggers an interrupt before
> > dw_edma_channel_setup() completes, could the handler dereference a NULL
> > dw_irq->dw pointer?
> >
> > [ ... ]
>
> As this is pre-existing issue, it shall be taken in a separate patch
> series.
>
> > > diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > index 632abb8b481cf..61064de293b85 100644
> > > --- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > > +++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
> > [ ... ]
> > > @@ -118,19 +129,20 @@ dw_hdma_v0_core_handle_int(struct dw_edma_irq *dw_irq, enum dw_edma_dir dir,
> > >   	unsigned long total, pos, val;
> > >   	irqreturn_t ret = IRQ_NONE;
> > >   	struct dw_edma_chan *chan;
> > > -	unsigned long off, mask;
> > > +	DECLARE_BITMAP(mask, 64);
> > > +	unsigned long off;
> > >   	if (dir == EDMA_DIR_WRITE) {
> > >   		total = dw->wr_ch_cnt;
> > >   		off = 0;
> > > -		mask = dw_irq->wr_mask;
> > > +		bitmap_from_u64(mask, dw_irq->wr_mask);
> > >   	} else {
> > >   		total = dw->rd_ch_cnt;
> > >   		off = dw->wr_ch_cnt;
> > > -		mask = dw_irq->rd_mask;
> > > +		bitmap_from_u64(mask, dw_irq->rd_mask);
> > >   	}
> > > -	for_each_set_bit(pos, &mask, total) {
> > > +	for_each_set_bit(pos, mask, total) {
> > >   		chan = &dw->chan[pos + off];
> > >   		val = dw_hdma_v0_core_status_int(chan);
> >
> > [Severity: High]
> > This is a pre-existing issue, but is it possible that
> > dw_hdma_v0_core_ch_status() reads from the wrong hardware register by
> > swapping its arguments?
> >
> > When checking the status, the GET_CH_32 macro expects the direction first,
> > then the channel:
> >
> >      GET_CH_32(dw, dir, ch, name)
> >
> > However, dw_hdma_v0_core_ch_status() passes chan->id before chan->dir:
> >
> >      tmp = FIELD_GET(HDMA_V0_CH_STATUS_MASK,
> >                      GET_CH_32(dw, chan->id, chan->dir, ch_stat));
> >
> > Could this lead to incorrect channel status checks?
> >
> > [ ... ]
>
> This issue shall be taken in a separate patch series.
>
> > > diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> > > index 1fafd5b0e3153..da7a5cc93ad43 100644
> > > --- a/include/linux/dma/edma.h
> > > +++ b/include/linux/dma/edma.h
> > > @@ -14,6 +14,8 @@
> > >   #define EDMA_MAX_WR_CH                                  8
> > >   #define EDMA_MAX_RD_CH                                  8
> > > +#define HDMA_MAX_WR_CH                                  64
> > > +#define HDMA_MAX_RD_CH                                  64
> > >   struct dw_edma;
> >
> > [Severity: High]
> > With the expansion to 64 channels, will the DesignWare PCIe controller
> > integration reject valid HDMA configurations?
> >
> > In dw_pcie_edma_find_channels(), the code unconditionally enforces the old
> > EDMA_MAX_WR_CH (8) limits:
> >
> >      if (!pci->edma.ll_wr_cnt || pci->edma.ll_wr_cnt > EDMA_MAX_WR_CH ||
> >          !pci->edma.ll_rd_cnt || pci->edma.ll_rd_cnt > EDMA_MAX_RD_CH)
> >          return -EINVAL;
> >
>
> This particular function targets non-HDMA platforms which suggests that
> increasing the channel limit will not affect anything here.
> This code shall be retained as is. It is not affected by increase in
> limit for HDMA channels.
>
> > Similarly, dw_pcie_edma_irq_vector() enforces a maximum of 16 vectors:
> >
> >      if (nr >= EDMA_MAX_WR_CH + EDMA_MAX_RD_CH)
> >          return -EINVAL;
> >
> > Do these bounding checks in the PCIe controller driver also need to be
> > updated to handle the new HDMA_MAX_WR_CH and HDMA_MAX_RD_CH limits, to
> > prevent the device probe from completely failing?
> >
>
> This shall not affect the working of IP, with minimum interrupt count of
> 1 also IP should work. If required, it shall be taken in a separate
> patch series.
>

