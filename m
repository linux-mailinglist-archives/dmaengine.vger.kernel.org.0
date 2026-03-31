Return-Path: <dmaengine+bounces-9778-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNJ1MGzXy2mILwYAu9opvQ
	(envelope-from <dmaengine+bounces-9778-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:17:16 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE5336ACC9
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 16:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8578A308E494
	for <lists+dmaengine@lfdr.de>; Tue, 31 Mar 2026 14:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D803F9F59;
	Tue, 31 Mar 2026 14:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="d7ulp888"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013065.outbound.protection.outlook.com [52.101.83.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEA73E9282;
	Tue, 31 Mar 2026 14:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966349; cv=fail; b=WE4GO+17tOHT3gzUFuSO3wPIbzmXg6DnFpq0jXYvY5/DUm+sfzQqTrdZJLRRSAFBdRxxbuoYHeURBFIu7ygLSKV/oSHaIy5XHGGu1hCjLyKDHDdaasxJbQF3V9pgSqGxy/hlT6s/lnYTNUmgRWsgprcjL4RovTpnTmXAGy/gLEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966349; c=relaxed/simple;
	bh=MFj/mIrtBL/97rkNrh7bk+3T4F9iIs2s3tGyNWn6lcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HD5LjraVWJq92/F1HLErCiR/iOSkvo9Ish8euDhUjw4X3nhFNFnCB32UtVBjfolW/OuNBjxDR4QfGEn9/tgi6JJ0CeCU9U+/oiMWGSUcpsfuqr7f0/U1jiY/oWuqj8f4U8R8F1dhRuTsPCyAcGOY7wbunzOg//WJXHIDx3jidMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=d7ulp888; arc=fail smtp.client-ip=52.101.83.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yf1fWP24Ot2xVgPvwzKOLDeNevyghKnws2tPYTTA2EIEP3qjy9VslK2cxQtTTpoJdqlHkjmdz2UQGfvV8tCVAi05uVDWS5UYjyHwWcgxl8sZo1wr99o//7m3+E17azuSWOzj1mQkcEzpnPTRQG9dUiiSNusRHRjhFNYX1V6gQUDSQ/6Azzjk3pq+FbKI3jQ6WHG/GaXWYu1UR23dr82g3cT8vU2UPyvEDdx3RyYl94tOyJiVwg95nZ2tE67Gf9EhlGycA92L+vN4rc5bB6+laM9ELTXOjavHEJn2ax57/NQwOIBQn9HTxUEn8JlHXX0x8ZKdg2EkweR3fTtela6sEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvZKgM9z9wMsoW8LduVDcW/H1ETBs8FFAzq3d5MNZ3c=;
 b=I+HDJ/fRudfLO15lU3HEQKvt3yut+tKKCJKobnnKCPdVGJQq0s9BflRfvxgBe67803woaHjOXEvWrnS+gpP67/G2KmNH5Wj+c4VtcHL9i+Jnht9I4GCj88q7qD/RgT5y8xAQ7R5AjrSzbdHXb35ZvzsEcZGr/IDNt9jP8atH6+rmF99ra7fgQ/8LlcigOq0Afvf0tsResc2TYSHjFjCnxQmMevn/RnNT688sMMDiQ7ylTWU0cb4pyLcsdhtv2iPksmy4o/WkJ3qBHN4aW/Fs/HNy9hH/0autIuxWyncXMQoCxiekjCFnwq1FvbHX6vMoOOGicbJ9FeG8CopU3DJBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvZKgM9z9wMsoW8LduVDcW/H1ETBs8FFAzq3d5MNZ3c=;
 b=d7ulp888F9XmB3LbgQRwD+RA+VusCwb64yLRCjyxIMRJxJc9E5gZrqvbd5WjGQiwVPvjUOpzSbwG844ysYcuXH63x/25sIPXojIuY2fKVCvqG9QD6V2UaKEleato4eGR+w6e3QAXXZrxGFPzuklJWHiYD1wkaavKWnKudrj8ErSwe4R0DMSV3+l3RJQfGsRPucJProWeB7vUfgd6jN2Gp+Nk3NcoHAV3wWJiXDa0zdr+FoxPiMaWAgpAS8xa+7+khLnMNra0GGHxh8sVqlQsxEUr7VXtSdD0kn9WKb2A1X3Q7YK6uinUmLXnFdPcdLgXbFfPjW1sghDLgvtDD1qEkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by BESPR04MB12563.eurprd04.prod.outlook.com (2603:10a6:b10:ff::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 14:12:24 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 14:12:24 +0000
Date: Tue, 31 Mar 2026 10:12:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Akhil R <akhilrajeev@nvidia.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Philipp Zabel <p.zabel@pengutronix.de>, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/10] dmaengine: tegra: Use iommu-map for stream ID
Message-ID: <acvWQa-bJB5EYjLH@lizhi-Precision-Tower-5810>
References: <20260331102303.33181-1-akhilrajeev@nvidia.com>
 <20260331102303.33181-9-akhilrajeev@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331102303.33181-9-akhilrajeev@nvidia.com>
X-ClientProxiedBy: SN6PR16CA0045.namprd16.prod.outlook.com
 (2603:10b6:805:ca::22) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|BESPR04MB12563:EE_
X-MS-Office365-Filtering-Correlation-Id: daf1f144-06ba-4de9-8b53-08de8f2f8838
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|7416014|1800799024|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	khproBywJN4MHNdTWbICQXGJWAYSXusnUD3hDxHs1lQdx4PJTXpSCdnzOBbLUUQeSsqSkgOKxsb49T8+wDpUs33wZNv6NLmzdGB/BvIkO68Sw38u9Lo1dB/sC/84Jd92d796dmWTGaXznkx3keJ0EBWpbvcO9aDVFcitDock5GMHYFw+SpOABWxnNlaa+pgz6VdLN0Jhge8+d+W9g3tLGng62qQN/i7+M86Z2KPStmvIQHbdPyMkvCtGKBpZcxr/DJ0vdMZA4vyxYjGYSTwF2NGNAC6IRf37bqkYbMlkbVpMB7DcA/Jt5IDWPa6yeozvaXuhlATkgXKBkAhOMTUJutN246uOBC8/HvAOBi1flxDekOGGFfaymZIRBx+NyHHjqiDLmOpi0AOg6hfe+jCfZc91BMLKCWlVNZww0hJXhHA99nRHUFbP9st9EAE4iJ9RXsjqO8GdsVABlRE6JxsFdNfYMt67AQSl0rINMvYSBKDOwo/Fq57yeeQ+S4D52JkQEvDeXUEgBPjNdEYeEur//IIpzrlyptugT8/BOdJi+whR2uO36hcacm9Vtwyddf52pYIeUV0jE4mPqZHLgTrmbq8y9L1myDUMYtSicgA2U7jfOtxISdhxXFQNapXTgo0jFoDyUtQYxVDGZBRtD69MegAYiN6ipdaVe5obUW9QYbcl96mHxy+5EXJbU5BDOdR3jWSipTYb3hB5jAjDoiLGORl4qkvdVFlyZYjPHsu6VNv6LgMsloBx9fPBE5MiNK9TXrhgy73Qm8wa6rb726b10YoWFFORV1V8UjuKe00xNYs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bSIsSX0VJB0FkFysB2/IrrHO6WWvR03X7zUkznzk0IHEHsvkae/IMOX6RtXb?=
 =?us-ascii?Q?sl0eEMQJj/2B6exXiBiQ9xkmyf3foTV1HZdQ0PpkIgsBRdUUB3+ejs+bDXuz?=
 =?us-ascii?Q?k40ntvgTSdOerTo8XS0VpQYrGglBCkmNDmqpnVaoxroQYxI0aHwNGzUCtLsT?=
 =?us-ascii?Q?eOgzHPWfjV18tnTsP3H5zhLyrZ5zkYvUpDwYinARhQ4SOdHhAedgsDGSQnvv?=
 =?us-ascii?Q?3o84ow4OKsWt98ECG1zpugAermW9zgJhmEUMhNEkpGQNwoE9Qehz3/tmhkey?=
 =?us-ascii?Q?r9Djev0GHvGRm0ulD599dbvJ0AOrOeWGomRGAjLAIY8ytpl2lTptZ7lyTK3X?=
 =?us-ascii?Q?AgQttuEvm0b5mqvCxKOfuUvP1ImqvT1Bpf/I3ByqL+HfhAOWP3GRCO28ZZpf?=
 =?us-ascii?Q?1D+1EVQ4eu2qcswg+r1T466IU0dSAvLe3XJyKERafn10QOUmGdqjhskp4fpW?=
 =?us-ascii?Q?3Wy8GqbIdAK9WyPiQuqvPgHmzeTllKGE0Wlzd2C5Cc/seCdL9tRStrelrSde?=
 =?us-ascii?Q?sE5C/uAj7BdzmK1P119g2QpC6aaRs2H1I0hPTJdNeIrLlgL6pyCj3oUTSpCO?=
 =?us-ascii?Q?e/9ufHneLQ3qZdcnatl+lDOiewijcSvWC3xGV1JV5hcKFwEt4WZbLXnNOvOO?=
 =?us-ascii?Q?ya+uylk2aaNvc1BFuftrkgmcqqT5c6tL1JcltndO/uGW0CeHjOmMEKY+ApYd?=
 =?us-ascii?Q?gNyWkqdg7HcNIPb6qI5TpQhoRfhzjQPA8c4sk9LiVkN/4vJ9BTS0JRBhgyin?=
 =?us-ascii?Q?ioVxWnSWnTHY+BlWnfnf0KGyjT3GemZWWtCMddC3S5j//POHClpGYkvdUMZJ?=
 =?us-ascii?Q?3msjJwXAxT5eiMF7aqTMmljObEaCWDgfXwFdENdcnRH7kGdEBDxMfFXQCwoV?=
 =?us-ascii?Q?XHestlkWxow+k8It72R+jjhf9xxJo0EohyildMt8fn7902H9+D/8JOguDRwo?=
 =?us-ascii?Q?BcUvUfQzWBk/IiZhy85qrZVFpiDQAzTiT8ls5/OYdYAlRCEMeFfwhggkudve?=
 =?us-ascii?Q?P2mwB/THsiI5+djMVV/v3BiUBVAYgzwZV1yua6MRnCFAsoKF4lsQtO5WTssz?=
 =?us-ascii?Q?xUhDnBGukEpl7WJFNKdDD0ZwZopUE/K9ZThBJghWR97kSYOuUk/wmXeuMbGS?=
 =?us-ascii?Q?C3mTOAEWtyfyZ9UiC6ZRQ9ld3ts5u3tYE9X4ZFh+o6LHg3W1Q48m5fW0Cx2+?=
 =?us-ascii?Q?Z68ldOuZfPB359/ir6qlCLhS/OnQiKYVlAUT9U+iUDt+HXfPJPDcffblRvnO?=
 =?us-ascii?Q?h/R7QLzeozRexfgvn9lVVnP+YdFc14QHA2zCJVOoPuxgldmL8rJdc7pK0FzL?=
 =?us-ascii?Q?A1C/GmRyLjIwPkSXo+y0o4mpnOKQQQCiVff/H4seCuCN8uj20rZIzCaRAs0i?=
 =?us-ascii?Q?4wkOYTwH38a8ufyTlLyZi+O87mFSHRu98fqvr1IXDJNR2/wLWMH9B1M6hOry?=
 =?us-ascii?Q?wmdKMsNCXhtNU71l6HQa9t10w5NMc6xi3hbNSiK+yAnOMZCIkKOv2ODe/UTM?=
 =?us-ascii?Q?WvYrTRD5Jqi5W25qQJH2fHR51N2XGZyOBW2ABpwF+bVs0Cnk0/ZaMdH/gMJV?=
 =?us-ascii?Q?EV6y8mEXQe0R8FZGMunEBPQYQCE20MLMGs6LLBTzz689gefdd/CnUUUGt34M?=
 =?us-ascii?Q?HjIGHGA6uaVnXHl4KlUdnOi1NaMS2WDg5IOzoQc55/e4ChyfrsuOyfdczUhN?=
 =?us-ascii?Q?jRkQ5azSV7w251urFfgGD24BwUdM2FOg34lbtfmWYACxmneJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daf1f144-06ba-4de9-8b53-08de8f2f8838
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 14:12:24.7736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cG5yJWEMKIQ/xYD7PzEA9YRXbpKPEfjU6n20WHQSzZv1kbiMMQblV+RPz+izH+iAF9UNkIqlrJAcFc3lt+uo5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR04MB12563
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9778-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,nvidia.com,pengutronix.de,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,nxp.com:dkim,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EE5336ACC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 03:53:01PM +0530, Akhil R wrote:
> Use 'iommu-map', when provided, to get the stream ID to be programmed
> for each channel. Iterate over the channels registered and configure
> each channel device separately using of_dma_configure_id() to allow
> it to use a separate IOMMU domain for the transfer. However, do this
> in a second loop since the first loop populates the DMA device channels
> list and async_device_register() registers the channels. Both are
> prerequisites for using the channel device in the next loop.
>
> Channels will continue to use the same global stream ID if the
> 'iommu-map' property is not present in the device tree.
>
> Signed-off-by: Akhil R <akhilrajeev@nvidia.com>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/tegra186-gpc-dma.c | 53 ++++++++++++++++++++++++++++------
>  1 file changed, 44 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/tegra186-gpc-dma.c b/drivers/dma/tegra186-gpc-dma.c
> index 9bea2ffb3b9e..cd480d047204 100644
> --- a/drivers/dma/tegra186-gpc-dma.c
> +++ b/drivers/dma/tegra186-gpc-dma.c
> @@ -15,6 +15,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_dma.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/slab.h>
> @@ -1380,9 +1381,13 @@ static int tegra_dma_program_sid(struct tegra_dma_channel *tdc, int stream_id)
>  static int tegra_dma_probe(struct platform_device *pdev)
>  {
>  	const struct tegra_dma_chip_data *cdata = NULL;
> +	struct tegra_dma_channel *tdc;
> +	struct tegra_dma *tdma;
> +	struct dma_chan *chan;
> +	struct device *chdev;
> +	bool use_iommu_map = false;
>  	unsigned int i;
>  	u32 stream_id;
> -	struct tegra_dma *tdma;
>  	int ret;
>
>  	cdata = of_device_get_match_data(&pdev->dev);
> @@ -1410,9 +1415,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>
>  	tdma->dma_dev.dev = &pdev->dev;
>
> -	if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id)) {
> -		dev_err(&pdev->dev, "Missing iommu stream-id\n");
> -		return -EINVAL;
> +	use_iommu_map = of_property_present(pdev->dev.of_node, "iommu-map");
> +	if (!use_iommu_map) {
> +		if (!tegra_dev_iommu_get_stream_id(&pdev->dev, &stream_id))
> +			return dev_err_probe(&pdev->dev, -EINVAL, "Missing iommu stream-id\n");
>  	}
>
>  	ret = device_property_read_u32(&pdev->dev, "dma-channel-mask",
> @@ -1424,9 +1430,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		tdma->chan_mask = TEGRA_GPCDMA_DEFAULT_CHANNEL_MASK;
>  	}
>
> +	/* Initialize vchan for each channel and populate the channels list */
>  	INIT_LIST_HEAD(&tdma->dma_dev.channels);
>  	for (i = 0; i < cdata->nr_channels; i++) {
> -		struct tegra_dma_channel *tdc = &tdma->channels[i];
> +		tdc = &tdma->channels[i];
>
>  		/* Check for channel mask */
>  		if (!(tdma->chan_mask & BIT(i)))
> @@ -1446,10 +1453,6 @@ static int tegra_dma_probe(struct platform_device *pdev)
>
>  		vchan_init(&tdc->vc, &tdma->dma_dev);
>  		tdc->vc.desc_free = tegra_dma_desc_free;
> -
> -		/* program stream-id for this channel */
> -		tegra_dma_program_sid(tdc, stream_id);
> -		tdc->stream_id = stream_id;
>  	}
>
>  	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(cdata->addr_bits));
> @@ -1483,6 +1486,7 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  	tdma->dma_dev.device_synchronize = tegra_dma_chan_synchronize;
>  	tdma->dma_dev.residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
>
> +	/* Register the DMA device and the channels */
>  	ret = dmaenginem_async_device_register(&tdma->dma_dev);
>  	if (ret < 0) {
>  		dev_err_probe(&pdev->dev, ret,
> @@ -1490,6 +1494,37 @@ static int tegra_dma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	/*
> +	 * Configure stream ID for each channel from the channels registered
> +	 * above. This is done in a separate iteration to ensure that only
> +	 * the channels available and registered for the DMA device are used.
> +	 */
> +	list_for_each_entry(chan, &tdma->dma_dev.channels, device_node) {
> +		chdev = &chan->dev->device;
> +		tdc = to_tegra_dma_chan(chan);
> +
> +		if (use_iommu_map) {
> +			chdev->bus = pdev->dev.bus;
> +			dma_coerce_mask_and_coherent(chdev, DMA_BIT_MASK(cdata->addr_bits));
> +
> +			ret = of_dma_configure_id(chdev, pdev->dev.of_node,
> +						  true, &tdc->id);
> +			if (ret)
> +				return dev_err_probe(chdev, ret,
> +					   "Failed to configure IOMMU for channel %d\n", tdc->id);
> +
> +			if (!tegra_dev_iommu_get_stream_id(chdev, &stream_id))
> +				return dev_err_probe(chdev, -EINVAL,
> +					   "Failed to get stream ID for channel %d\n", tdc->id);
> +
> +			chan->dev->chan_dma_dev = true;
> +		}
> +
> +		/* program stream-id for this channel */
> +		tegra_dma_program_sid(tdc, stream_id);
> +		tdc->stream_id = stream_id;
> +	}
> +
>  	ret = devm_of_dma_controller_register(&pdev->dev, pdev->dev.of_node,
>  					      tegra_dma_of_xlate, tdma);
>  	if (ret < 0) {
> --
> 2.50.1
>

