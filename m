Return-Path: <dmaengine+bounces-9894-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sB0HAwxo1GnptgcAu9opvQ
	(envelope-from <dmaengine+bounces-9894-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 04:12:28 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7A13A8EA3
	for <lists+dmaengine@lfdr.de>; Tue, 07 Apr 2026 04:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C66BB300610D
	for <lists+dmaengine@lfdr.de>; Tue,  7 Apr 2026 02:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F7D2874E6;
	Tue,  7 Apr 2026 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="C0LRdsoV"
X-Original-To: dmaengine@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013006.outbound.protection.outlook.com [40.107.159.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363AA282F32;
	Tue,  7 Apr 2026 02:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527944; cv=fail; b=LKq5iQ05gjedAfE7jKCi0vT7HGEa3vmMDgCmCVK8cX2qoAtd5DBoq7j8PVvcitzDWHBY9shjIjjfHwO802A4m/VZU7rn3XnaaNrjAhkFLekvOZV2LQxIZuXtw5C7T6Za1d5RAQTwYpXG01aMjoDLxLAaqbgNKJ+Gn71TVd8uPNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527944; c=relaxed/simple;
	bh=bxqeuGs9QUFxlUyU+QEYMftfNV+2mqlw9tFP8svSbcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AlGRQXWcUM/9Fs3dR2cuGJ/reXJKYxTjhWy/EjDvs8iASj9ZS/+/UuFdnVted5axS1V0WEo+cPYWuUNDxwyJC6baxB+Ld8PYSleL41mC4OuV3pYs8d4BBbJQL5pZtMIMrCbJzHY7pPdZT+yCeAYoB+6lkp/QaZdcFHOCWToKWa8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=C0LRdsoV; arc=fail smtp.client-ip=40.107.159.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ljhid3rCUDrOTA9JiYd3lGjCtQw77GQUCi6HNuTFKONefYu8VucJTBrgkchUhoBiuA/S5+nlWzrRgIS5xytdfvmaptVD1RBiEyGcddPFlk05OUkozWQaOtHYuvGNsIfcMe5GmCVEvRKVyQ+oF71XedJckiQCm5udlXvUWofBm8JUFDF69VRZRoDdilUsdkar+oyniMtnWalvKbemDyruJDmCb1O38AVwzQYxxzES3RELH0RqzBPNWNwKdrqieOZPKzMm6EZGCS2jlZj2D0OEbYl4P4r0noz2m0bG6F8ixnKMglRi03aeOfEb8oqfcGXqNvYvIy+PK0TSYDZersAPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQpt+5fJcLIfuLbo/s3Sk9BF0yjddoMYGODlT4uvOXA=;
 b=h10w/qY0Q0atu9VeoybRnKqoAHEWm7VI0p1QGAKGCODICXN6c/Gds2K3tU8o2ttg4btQDYOTyqwqkAfkIFgMKpvari8ZkTmSxw3x7/q5t4XvabyA8+LOe9lQoUD4/fgUsuJmk1HSqWYvjBdEIY4WAqx58BnISJNT1t4Y+Rb0+zqunMRDnun1gcTGdZ3CaoVMU/9RQjK19464qS246QNAVot5psfJDV0vJybzH4/VAZU2Xy7GNdeseZiiBVRc6UfTMzJ3pLRVY3K1H9emjLNsPLX6H65AkuBXLyffZX+WYwy8cbQP7l62a8sEa+rII4oA6bpufRuxS4gk5gRbIUETdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQpt+5fJcLIfuLbo/s3Sk9BF0yjddoMYGODlT4uvOXA=;
 b=C0LRdsoVj4S0r8finkHMw4NHUhIkDsRkWhglE0MZXSfK8unfZR76PFZUh4EzZfFQZc/11GE2I5wZaIrim/iY/2t6MfXY3KTZKlS8rNT6ZbEIPSJbAvMHxgzQ3go8Fai6YD2+OtOcKIdXP7f1kiG4/2dceL6nboPueHSAl1uoEASWjoyVFCccg/Cgayl8L9p5NAxBEc06Jdq//SX3jzf2aPyRBxYsNxviIbGlYajkK05OrvcUWKBjV2xh4WxRWm/1UT2nAJf+AdszymhfnqA7RhtSCPQ+HgHx71laOdUEnPEe8oyhz/kAuE1nAO4921OIfspKrGYerk1SO26BVmfyeQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PA1PR04MB11505.eurprd04.prod.outlook.com (2603:10a6:102:4e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 02:12:19 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 02:12:19 +0000
Date: Mon, 6 Apr 2026 22:12:13 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: dmaengine@vger.kernel.org,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:KERNEL HARDENING (not covered by other areas):Keyword:b__counted_by(_le|_be)?b" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCHv2] dmaengine: dw-axi-dmac: simplify allocation
Message-ID: <adRn_ewqVVOTLg_1@lizhi-Precision-Tower-5810>
References: <20260406194424.13365-1-rosenp@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406194424.13365-1-rosenp@gmail.com>
X-ClientProxiedBy: SA0PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:806:d3::28) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PA1PR04MB11505:EE_
X-MS-Office365-Filtering-Correlation-Id: 687ebddc-0586-4612-7b5d-08de944b18b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|52116014|366016|376014|38350700014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	IFpkTOB6r2IfOCyfDdSvakQCUmb0OlCs7fHN9dKnDuotfDg+Scu5J0JQTmL/FWLL8AcaGqdByuzeL+6blveo7E37/NbeJKPY30MC8ob0s0FBG4M6NHIS0EUEvXk8Hex3ACYUWd5mm/GeAgdDKVC+QzA/oVcYwXWCqDIlfV2eEVAWNzJ3nu1vsDfMsNKTAcW3qUc+nKnoSmdu35Wm0WZs7hUGnDVVzsollqLCqneM/B9zFyRSkLT28ymEFhoRlGZH29qDCtuM3CVYK6CHJuaCj2BPTRxW4xUZhgUhlZGEZAJjd9nNU6g0UYLBSkO43wpF2DXLZwq7pD5dfzo4HeijzvR7wD7sjgctmS2iMzSO2TiSwA2ags1rSjSe1meB3ko4kvOFFUZJs+s8b5aet0QxhKUd93u3NsB2w4GnGhyheZS/v1xf+nq74e6/VKoIjAThLnfNRq8t5KWwwkTc8dExgYrLSiKgC6EeLBvt3ppSJSgIUXpKsdQLLRs17lSk9ZWXt8ZbXU3V/NkVJQn021xTcpOxgojTpw+twmzLNBT8zFpU//jRmoCQKmVBeeHAciebKtdDJN3xrUTege97F2NTr2HJgqEEeDUBEKHyKkaW3CPInbXirgSBzwzRyGX8w0FQv/SEDFKnnYWAH+ciLhU8dw9ZLwGxaOUSDXr1+atMXmb5WE7k7qc3frdoIOLCnylMPF0AyjYPbEvW70Hr/gpK/0eTofIs3x/+3Pl/0mXFLIEsysNlt89BltFajwp2VeKqppiJCiZF35M6zEi9l5b7eQizLyoHFDItlewL0phQ+to=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(52116014)(366016)(376014)(38350700014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tVhKdKjdRoGcFC8P87KSqpf2vdwNuBVKWYCXkbc4cyOqZMZgy34vFbYbFEX2?=
 =?us-ascii?Q?wixPGHonHGmZ+FAACbBWScgWi15so//5Km0T+iwcIvQ3eexcNT0a/ksKLoC6?=
 =?us-ascii?Q?ACohLs7hEUmS4XWPm+dt+q8mPkTZ8JLUPh9UvaXgHY42otNJSzkK2M3dcxGn?=
 =?us-ascii?Q?9Jm5W9R+3cB1cOxhH0fsjHNirShZ95nMLEz5DXj/h84SUK7CF8aH5Tlcw18F?=
 =?us-ascii?Q?KPjAzPv4UChe4apv/5hOQutWqCquccUZWTJJp97TY/Sgi9f7ES7UwadXqX/1?=
 =?us-ascii?Q?IsSLMiPR7i6tFSJpiOmFSSMZ/MyEWIuVYz6XykesvUe1+VvgBzeV2B3QuLJA?=
 =?us-ascii?Q?pfZfWgsvnGoUForVNNkO0m1oLNU7PyDD9XCtysHHWEIyY4f+pH/tC/5gd5qR?=
 =?us-ascii?Q?muSW7ViI41Lme2LK+ZCJX91lIZwuEyC8y5MCt2oTT7nBrr9q7JOEtrlg7nB+?=
 =?us-ascii?Q?fQkLcWatero8wGDOYF4xHTJ/B6TK2Bo8J8FxPEtxCXPf/G/wszHoiAJitSPx?=
 =?us-ascii?Q?L4H+6TBcykH93HqXLC1qMkXXIB+GjG/cZYX0S9hr7qOpI+zelYjEcNGEvXBd?=
 =?us-ascii?Q?I5xFJO80pfO1m+eilLmxjYh/KaXGCkwfL3gGm5Vgy3DqFWRbCv8qdxgwvbAJ?=
 =?us-ascii?Q?Zo+MuaBMpNYSAG0J1a+NdO6Mc5TOrkgbIEd4OR9g9c5NBZWzLfUHcy5Fwc2l?=
 =?us-ascii?Q?kw7OHS7iVVg0V5/c0pUr7wfU2MKlcc5DLAcQorw2dXwi6NPa0sW/yWqxOC5C?=
 =?us-ascii?Q?6fbIO2b2QJpioIpZZsieuTsruDdGHJhOuBArmAznZVlOFquSn8n6zYZwbfw4?=
 =?us-ascii?Q?3AoVyucH9/9yHv0ZFXQoDlithmzLYIL8YLKUjQjon3ojXiyljngn+qnWoZaU?=
 =?us-ascii?Q?vKde8q3BukAIa9duw6kgHJ1qwpn/L4nMe7zCOMMmh00TZxH/nsMoD4J2mD/e?=
 =?us-ascii?Q?HboUj9pg+5V2y+s6e9bAD64KxpDaYXxw+wmEvowSg5fqxWuKiAaPmsX526C7?=
 =?us-ascii?Q?UodhvirtCrMMIFTz9TfqsBkSv5Fi5ZOV9QBB3M1hY+VmjSayuVIlmAs8l7cd?=
 =?us-ascii?Q?ZbiRGTHpo3eDYrw5LWQTnIgTAiXnHiTZjWv9BQvNLbsAdrHksIB2HscOJSS1?=
 =?us-ascii?Q?JCNTAUEGvV8/4C63jzMCEW3MwW7Om6c3v1og3AfqrjQ7wK/nFl1G/lzg+sTo?=
 =?us-ascii?Q?jGDwcXj6ieo8rdt02r4GXSHspwMDDDUk8WwuLmynLBTrhwT7kgtyiRsxqua+?=
 =?us-ascii?Q?/KfgZrsWDQ7oeuCFXbP7cG/YVbtM3eZY++/XrbAWxD7Ma1l6crc/lzqJltqd?=
 =?us-ascii?Q?bQI4T82fCv8Uo2eMdvcdrYq6M+4dPEahuoWjNga4+8KzgGeq1/RkHgSADy19?=
 =?us-ascii?Q?18UdJdf/IpJjzjCtzRGx7ysHxMoXJL239kJHvP1hyMUH/kbuvyDz1N6Tpr41?=
 =?us-ascii?Q?lge739f1m1AjQyldaS83nRRSiwkUt1UxLKypDD3cxLFdn1pk2yrokxI0wPkE?=
 =?us-ascii?Q?ltq249RUvI1Uft5Fe7sBD1sl+yQur5/4uvXr0pbRROE1cWjdEZsIe7hDDUyU?=
 =?us-ascii?Q?KHtIRmQcnFvhXRBjuEw5zgj4aa8mqD3HvP6P/sEsJbKHUNMrwsXNvloTRvnv?=
 =?us-ascii?Q?tjZmn1VzttJOUgc3K2RYJofGHskZCrBZKBHPFgagvOilsT6/UfNncGhHzh0i?=
 =?us-ascii?Q?m/YwhnBGcry2Ir8TfEBfYM78fdN35cU+ZBGKQIKLMzsZUmWs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 687ebddc-0586-4612-7b5d-08de944b18b2
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 02:12:19.2430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6nBpD0syS60JfNQWHqCBqxrf9wIWKo1kLZNSQIf5Vg7rrabRGl7aSCB7rfZpEbTwcVeiYUY8Cn5Z8dPSSc3kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11505
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9894-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[nxp.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[dmaengine];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F7A13A8EA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 06, 2026 at 12:44:24PM -0700, Rosen Penev wrote:

Subject need update to

"Use kzalloc_flex() to simplify allocation"

Frank

> Use a flexible array member with kzalloc_flex() to combine allocations.
>
> Add __counted_by for extra runtime analysis.
>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: use () for kzalloc_flex in description.
>  drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c | 8 +-------
>  drivers/dma/dw-axi-dmac/dw-axi-dmac.h          | 4 ++--
>  2 files changed, 3 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> index 4d53f077e9d2..d3ca202dc478 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac-platform.c
> @@ -294,15 +294,10 @@ static struct axi_dma_desc *axi_desc_alloc(u32 num)
>  {
>  	struct axi_dma_desc *desc;
>
> -	desc = kzalloc_obj(*desc, GFP_NOWAIT);
> +	desc = kzalloc_flex(*desc, hw_desc, num, GFP_NOWAIT);
>  	if (!desc)
>  		return NULL;
>
> -	desc->hw_desc = kzalloc_objs(*desc->hw_desc, num, GFP_NOWAIT);
> -	if (!desc->hw_desc) {
> -		kfree(desc);
> -		return NULL;
> -	}
>  	desc->nr_hw_descs = num;
>
>  	return desc;
> @@ -339,7 +334,6 @@ static void axi_desc_put(struct axi_dma_desc *desc)
>  		dma_pool_free(chan->desc_pool, hw_desc->lli, hw_desc->llp);
>  	}
>
> -	kfree(desc->hw_desc);
>  	kfree(desc);
>  	atomic_sub(descs_put, &chan->descs_allocated);
>  	dev_vdbg(chan2dev(chan), "%s: %d descs put, %d still allocated\n",
> diff --git a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> index 67cc199e24d1..a04a4e03eb3d 100644
> --- a/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> +++ b/drivers/dma/dw-axi-dmac/dw-axi-dmac.h
> @@ -98,14 +98,14 @@ struct axi_dma_hw_desc {
>  };
>
>  struct axi_dma_desc {
> -	struct axi_dma_hw_desc	*hw_desc;
> -
>  	struct virt_dma_desc		vd;
>  	struct axi_dma_chan		*chan;
>  	u32				completed_blocks;
>  	u32				length;
>  	u32				period_len;
>  	u32				nr_hw_descs;
> +
> +	struct axi_dma_hw_desc		hw_desc[] __counted_by(nr_hw_descs);
>  };
>
>  struct axi_dma_chan_config {
> --
> 2.53.0
>

