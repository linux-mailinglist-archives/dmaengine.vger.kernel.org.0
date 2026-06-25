Return-Path: <dmaengine+bounces-11790-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dl9rHHZKPWqA0wgAu9opvQ
	(envelope-from <dmaengine+bounces-11790-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:34:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF7B6C7185
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 17:34:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b="J/1MPROc";
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11790-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11790-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C409B3012777
	for <lists+dmaengine@lfdr.de>; Thu, 25 Jun 2026 15:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F4427603A;
	Thu, 25 Jun 2026 15:34:08 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012050.outbound.protection.outlook.com [52.101.66.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609F626CE05;
	Thu, 25 Jun 2026 15:34:07 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782401648; cv=fail; b=Y0m8NjQDT34VuYI57gdS4u1IrBF/ygYD1f8uCMSC27IYKLfk0GTjcxh/cowhrrsrZNURCkuxT11LVnEhTkEMIYGHDa3hQyIbfCHz1R28A4uJH170u33g0J0Joc4ZC5nmayozJuZzgWOzdVzb/ufeXxNrWRdUxE8ol2dDvdhVPP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782401648; c=relaxed/simple;
	bh=OIyo6IJ4eiy1lAyrjTUWFn5nR/1OwAZLRkrX/CAsFDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u7WF75lgOPvVSfkKiEH2W6Up9KD3Hq7Dp91/tp2lcym3+5HTTMs+0KUGVsfddv0s68P9wrmiRm/JQk4G3Ykhx6PeoC0eeSowmlnAgrya12nDAuuiA5Sry77gI3THAJubS4QpbdYKBK9PXdKtXEUPryg9CPBhGrDWxE6gopNm6g0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=J/1MPROc; arc=fail smtp.client-ip=52.101.66.50
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZhicsZU7FZr3HcVsSM83t088Mbe3bfkV+uMNIgte3NJEeOUI/x7glpzy67tHSedis99ccdAS/5dnNtn0qB/YFMg6Wk3YAIRBDpdPSyC9sX8GkV7dq5f4j8VzwHdHANzNw9YLw+o7kP1EADXslVh0/Ds2VrUfGOlhv5Dg25EitdaEGbD+p9YOwxI2Cbpuzd0ra0aEMJzjnrDpc1Gohdy6lD2tcO1AFFzg8Gn82u4TSZsxd6cdf227UvvsTLo2T2ums9lLAerJoZfPldMR6X32iNqtH2bBzYZ0P/QQMhJGK1gH6ZBh5B/zCmi3pWeQG5M99SGW7mi4PwF2tJY3kbqVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9LXHvrSVBGc0cJSq9LGxBpj1A/r6mpdgl3HG99Quio=;
 b=SKTSXeaMSa95lUeiWRzZegwvYkvIjgZ6K79zeyHdrHv1GbM15seVi0cg8s4zB61glW0jM9MR2ifMh6JWwwDCf/7T+z4o77bfvLhHstGJOiPdOjT82F6jfm1cnLGNfp4HQjmrmrv8mN2rD6na2y4+VdTOwAxq0zARoCB1mhgb9Ndvs2WfzPHYdmv7zvL3vO2Xi6eH1HJQWpQn6mYEQow9WBs+37WxEsKfcIPHAzOSIYp9iJVYev5L26gpsz9pxmvsIRUP+zfJD7zXZJyVmYKG3jDCbmS+E3nJWjU7rqIJAdvydBVd1KFh2xkmJCP8SLOe2uDoP6zSs7pgBQ7p7qyyng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9LXHvrSVBGc0cJSq9LGxBpj1A/r6mpdgl3HG99Quio=;
 b=J/1MPROcvfDnVxmOiXldQt6nD7LLYlm3HN+q5wyobhvmkQZtMi5LnXLRnBPRhA806DKqWPUchM8beDwIlXdqOjUEtcPfwiK7xFnp5+3LZpfmBMc8N3nay3/tI0UsZ/1K+q5slvshjteh4lfgFK4PnnUpWSSStDMXDSaIW9vhDdhJD59oa84aZzX1hX7uF4VAxir7Aj78FK/nbbe/Zj3AGCof0/+Bm9IJ5QLyUYBLgS1MEkJG0sZRuLRCldp439Slcd3Ynjrd0D7rf5fNn6S1uUUNmd1kzka7YkuQrUN5SfIb0gZ97lu/yYw5Di70vfnYZPaKgG/nhwxJxhOGM8eCYw==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by PAXPR04MB8271.eurprd04.prod.outlook.com (2603:10a6:102:1ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 15:34:03 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 25 Jun 2026
 15:34:03 +0000
Date: Thu, 25 Jun 2026 11:33:56 -0400
From: Frank Li <Frank.li@oss.nxp.com>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Angelo Dureghello <angelo@sysam.it>, Frank Li <Frank.Li@kernel.org>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/5] dmaengine: fsl-edma: Move error handler out of
 header file
Message-ID: <aj1KZGnsOFaorhRA@lizhi-Precision-Tower-5810>
References: <20260625-b4-edma-dmaengine-v3-0-44be00ace37d@yoseli.org>
 <20260625-b4-edma-dmaengine-v3-1-44be00ace37d@yoseli.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625-b4-edma-dmaengine-v3-1-44be00ace37d@yoseli.org>
X-ClientProxiedBy: SN7PR04CA0096.namprd04.prod.outlook.com
 (2603:10b6:806:122::11) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|PAXPR04MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4e615b-a16c-4d17-84df-08ded2cf2f7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|366016|376014|23010399003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ZeeBNbyXAJNsV0p4ZQKKQm19jsIk+LOAdfg6RClsbsQOrSMMc9AEOEMeESntiA7XDfQsPdWjtGipLzLUZNQtBJzdILszTKmOer1t8o3QYuIt6mv8TPUP90bkJiJwqA7xxfdg2b9bv53DRPZkv+45S7TS/W/fFGM3GfqjEmY6B0T9Zx8ZhrIK2Fk+aDDEb3lPUlbfQqqgbpT+5XBmir8sjH7ypBeFJ282X099M76Q2lti+YvwLwyjYLj1/25h7aprqE67BTNAXbQZJVPD6UAWbkfbXzjWqfEYHLKmkva5I7qWQhYecIDHTftDDagb7BQTBNVh9qXwOAt91+TluArEEXhw69yBZCjognO/bMnY3fs41L6KeDIKwAWolbNFO/1noFxiv1nIC/ORC+QYWLObXOrAlkbwQXWSOQ3RvkoEGKb2Pz+BN65roxRtzv+gnUMSZBORHzv1a1AdACbAAIvOrDMRN7mqlXKfN/of2byBVcJelx+LniBEyy1HYTurMZW12iqKD2TkJyws1NDS0+fxmHsbkiJEr5VyO+/DfnwNrUr9SoIKG8g9AsszviUwpIGaZG8GSbbxT27+ygIAxIlwMRwXVXyd6//mXYPLJlIwIgHbsdYDUpmbF+eyL6fD78NxGyJHmFu5pOzn1RT8mlLurDTwxb9VCiIzbR95OUkL3jM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UDLRpmBdCEnEm57ynGhpxDYFQM/3BlIjwqfwjjupMHjaWVvBB5UPmljmJbV1?=
 =?us-ascii?Q?D8/7vPuNO/+HI+zYV+RpILW4BGGVLPLCuweMAO4P8A+8o6fAfW5ahJTnuLLj?=
 =?us-ascii?Q?201SACmnDm4dMX2gttUsBel0+qzs/9tSFX2IzSfwEzFOy1FoY/Kzyqdv3h9J?=
 =?us-ascii?Q?pQzf2igumSwhB5z0+Y7uVh8hy9w0WPzpS3TpKe9TMRP/aYGpyFZ0vUqJ4G2f?=
 =?us-ascii?Q?I03EXvhIIfX8yU1iD2FQv/ua9LFzgo8+M+Dl8pAfwWDYqvJpDsPZZwizqPbH?=
 =?us-ascii?Q?XUb+H61CiaVkn/4Yw+08tV/cS+tQzNXtG0PZjX98xJY+9zgi0u0ZXvvnG3Fi?=
 =?us-ascii?Q?Fmjee3+XlCsjRFnnStMzZYy+lWBDGQo9kMEVPrh8djn3sqH7uomdOZRSDhB+?=
 =?us-ascii?Q?zqKcdyJhlfB51yOs0MrTdcPcrPiIMQ4xG/tfhTi6n0l06/HqiatZlKBNL7Sc?=
 =?us-ascii?Q?ovFHx4ZZo3Lh1hDSMa9p/ncoUugElp5mIVHHNFsqtPNOumK3FlQg0eDHVYWk?=
 =?us-ascii?Q?TpnE8Qv2AqkvRIAg9gW4CMy1q4sM6tDvVMffYzPnsdIrccjQH60NdQXv0jzx?=
 =?us-ascii?Q?Wav2elPqkxNBdHk23qamcS0jQAXrE0nx26q2p7gYPfueSShFXxra9ARC4O9D?=
 =?us-ascii?Q?ziRXEy+CFupciXgEmVceUa6urHVHeEVZ4lwbuaVNdGdFysRw9us1fLzt/Bpr?=
 =?us-ascii?Q?iN7qhA7d0d3KlhU1S9YezGfmZ/av/2WbkIGc5fhXldRyem3pSaoNrcoPSdbo?=
 =?us-ascii?Q?w5HDvuJKC9AwxkmyMltfhev9rlWdVOD7Xsu3WPk/SVD6Rw8z87SekybPtxCe?=
 =?us-ascii?Q?4KduadLg2Nq2SoaU++5pwuv0pOQRVxoAZL+zYSUsdW+6NLjf5BmJ76jO6/fM?=
 =?us-ascii?Q?1BrT8chACwQPDZ9lONMTIDOEe379HHytugViwUlgUkyaKmjDMoYs9XyYZFyE?=
 =?us-ascii?Q?Umskv5d31CvTvkkolzmf0a8QVZXZdioPavLDduEgYEGtxxN3GIXdHkHRm+QP?=
 =?us-ascii?Q?0gatGv24IgkEdeS986yHObfo5zvos05eq+x632rETX2qsVfzAOhskGKlWqSB?=
 =?us-ascii?Q?dHg1eY2hvcpLn8BH4nP9itKT8Zhxyo3akNyfYX36DckxpYTWYwwT5VrLyITZ?=
 =?us-ascii?Q?0cAyPT9a6ThjBjBw2vi0hnWs9CZPQMRIhmn7XAx2064SLbMmnh/Z3IEE6b8N?=
 =?us-ascii?Q?jeeg2ytCVI1lkEHrhlhElb57aReHYJpdeRgsxSPSGLdxbsfAu7WsJ5XYUZ6j?=
 =?us-ascii?Q?LAUKPf2zmdc/LXVMta+41iDuAIxGEojFnw7J1ZchYsXRvNeLY1/LQqDekq+M?=
 =?us-ascii?Q?hf9C3ZzaWM9grzefv+PwH5/2FRJcwvt3ij+Ex1PMljXcuvUxG7XyKtN+i+jI?=
 =?us-ascii?Q?HQl33qxfIl9/5BtXquJqDQozv+NWALArMXRhoj0pcsroAZZd1vvV2EvCvIO+?=
 =?us-ascii?Q?OH8Fx5F8Wxz+inEgMSzIoVlH8NxtsjxB9qE3xEX3etn+5vrSOgwWJ9MAt/ME?=
 =?us-ascii?Q?EcCrSh/lA6hfQlXBBbFEXNJIw8H0Olr7I42pw9y452qfVWrdSh4LZYAg4Kq+?=
 =?us-ascii?Q?+0QqPlmjW5Kbgq1pUzCAd/DariUNq4Jap/qyV6K+5+rwQZbO/f0JvrHRpcpO?=
 =?us-ascii?Q?d/0Yf1Ysafsakv6D31228wlJdFxrHdbuoUzOZLp5zCve3PEDTlW7Dk8Nefex?=
 =?us-ascii?Q?4vEQFGjblSeWdkBUBgWRInndzb8HLmvQ+iI4+U8oCqk5u6xt9i3qZ1QFzVWf?=
 =?us-ascii?Q?444+UKDM34lFy626v69iB3S/glHnVTth8Cd4hGpN0WZsDX+H6Y9r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4e615b-a16c-4d17-84df-08ded2cf2f7c
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 15:34:03.1294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9twKsPtLf9k6dHP/SwvH9dZxLfl8DvR4VACpk9876xUni2WQV0g2GwfRcsLoL4LMGo/ArHLmqor9isOyTNPz+GOnjGu2tBtUp1JZbn7XF7pZAweivttlmFmK7BCgvF1w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8271
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11790-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jeanmichel.hautbois@yoseli.org,m:Frank.Li@nxp.com,m:vkoul@kernel.org,m:angelo@sysam.it,m:Frank.Li@kernel.org,m:imx@lists.linux.dev,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6CF7B6C7185

On Thu, Jun 25, 2026 at 10:59:37AM +0200, Jean-Michel Hautbois wrote:
> Move fsl_edma_err_chan_handler from an inline function in the header
> to a proper function in fsl-edma-common.c. This prepares for MCF
> ColdFire eDMA support where the error handler needs to be called from
> the MCF-specific error interrupt handler.

why need this move? not difference between call inline function and extern
function

Frank
>
> No functional change for existing users.
>
> Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
> ---
>  drivers/dma/fsl-edma-common.c | 5 +++++
>  drivers/dma/fsl-edma-common.h | 6 +-----
>  2 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/fsl-edma-common.c b/drivers/dma/fsl-edma-common.c
> index bb7531c456df..1b1a0496b5e6 100644
> --- a/drivers/dma/fsl-edma-common.c
> +++ b/drivers/dma/fsl-edma-common.c
> @@ -44,6 +44,11 @@
>  #define EDMA64_ERRH		0x28
>  #define EDMA64_ERRL		0x2c
>
> +void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
> +{
> +	fsl_chan->status = DMA_ERROR;
> +}
> +
>  void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan)
>  {
>  	spin_lock(&fsl_chan->vchan.lock);
> diff --git a/drivers/dma/fsl-edma-common.h b/drivers/dma/fsl-edma-common.h
> index 205a96489094..abc8f7805515 100644
> --- a/drivers/dma/fsl-edma-common.h
> +++ b/drivers/dma/fsl-edma-common.h
> @@ -475,11 +475,7 @@ static inline struct fsl_edma_desc *to_fsl_edma_desc(struct virt_dma_desc *vd)
>  	return container_of(vd, struct fsl_edma_desc, vdesc);
>  }
>
> -static inline void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan)
> -{
> -	fsl_chan->status = DMA_ERROR;
> -}
> -
> +void fsl_edma_err_chan_handler(struct fsl_edma_chan *fsl_chan);
>  void fsl_edma_tx_chan_handler(struct fsl_edma_chan *fsl_chan);
>  void fsl_edma_disable_request(struct fsl_edma_chan *fsl_chan);
>  void fsl_edma_chan_mux(struct fsl_edma_chan *fsl_chan,
>
> --
> 2.39.5
>

