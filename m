Return-Path: <dmaengine+bounces-11170-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ALhhLqHfIWo1QAEAu9opvQ
	(envelope-from <dmaengine+bounces-11170-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:27:13 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 592DB6434F1
	for <lists+dmaengine@lfdr.de>; Thu, 04 Jun 2026 22:27:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=nxp.com header.s=selector1 header.b=TbW9sUcu;
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-11170-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-11170-lists+dmaengine=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=nxp.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2FAA130A5041
	for <lists+dmaengine@lfdr.de>; Thu,  4 Jun 2026 20:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F5930F54B;
	Thu,  4 Jun 2026 20:24:33 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010010.outbound.protection.outlook.com [52.101.69.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 146633093B8;
	Thu,  4 Jun 2026 20:24:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780604673; cv=fail; b=FduX6+xz/z0izM//a94hW0vmiAwgAqL7qhVv2NPYWfJcTEX4ZcdzsGUDtuzZ/zv2V8C61mlUV8CVlYmCkss69JUe+QLeDFhNazOCsalRsMSH0cztQ5gHsBANwx2GxukTwfoPq+/p5lbKZNc1Gm7S6MOkAgxSvrpptiitYJB1zxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780604673; c=relaxed/simple;
	bh=yVd6YvzrnFt+U0L6JYJjqaS5U1PcBlldFyCjWmRvi7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uXLPNMqwfssoG5g++rF0zuJ6072k97wWSB3MeQf+5OOn32FiQ49KKnNHwP92pSbVd7RXDewM9fju4ksXT1SQxLiI9bdRpBkPOwm2RqmDu6OpZps7dMErQQ+T7OvRdm+XF2zo/mXOCcMMyQurUovww9mDEuZrYN86ydISCiRIak4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TbW9sUcu; arc=fail smtp.client-ip=52.101.69.10
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLEZ3VEkIZoUJPOGxIqH0VJo/3pvz4FrPW8vlPfmsoLMZx1ApSCfXY6N53uA/bXuz+UwtYRVbU9EMdlQ6Wkt0AmEn2mo36qRB1oTEnkqCGkiQ+0Ddb9BPEKTWHH8OMTjttE2TGs6K09o8kduuIE1mhgwcX5jszP83ABV7bmK6EcWQepTB+ggDs+yTh8avEcd61uwPmQzQ3L4d9yGbqeytS15mLoKKHmQ6ZlN90IaQ8AqBb/wMDnSDbk6xH8uHtrvHLjR38I1MS7WhxvZQI5d6S5qin3uwNNGmy2DGON9uEUveF6qezk2w0+U76bsslXOLoDZPdmEgudBtylrJwmoPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JI0xi8SOMZVAyOpowH4k/tP5g+s3q+WK3idLEHCFjo=;
 b=RadTyugAUmAIv0fVl08lfbrhMwUMh+lTGvLmFYgX2Oi9e/RrPtU0jIJKNScJxso/gZ6VmbS9gYe0OLqry3XWpt81yVCQ3UN+qSiuZJ9GX2Yy4UEDDq5ijOXEkL+e28Ka4Sx9eu8npBpvi+BFc9DShEll85fyaJbM0F5BQQnkpClkUzZIEW1jiyCgKiZqhhczYqnVepGQpSy5KNoH3O5LuF4YPJXaMZ7J7/YmkhS9/oDXdg7fblJIc5WPQZHQO9f+bTBu6YwAXJfJooK6ZRFxGhGVsOrhI35NGph7Fpkjpy3zwCKNapziTQoVPulQPD3Snta36KTO/8FFPp6yUZe1kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JI0xi8SOMZVAyOpowH4k/tP5g+s3q+WK3idLEHCFjo=;
 b=TbW9sUcue9AQLJFlj0Ex5rjEDq5FGcuwH68T9uLcsrpzfnPginM67MkCKtjcXSAkCZkJT9sD+oDvhjLEMfPNTALwqMnIqQ0frZ4ehLy1kSpHX5LP2cFfpxi/6ayAqSH577ck/eAJz6oophx74XEHzA/HsM426BazeV0+O0v+naIpNMdQZELfiFbWCQkcrg1cOWyBM912jhTpyJktWmPLDRcDnqx0bOBFzrVh1e3rgIMNGZ28auehVNmn+V5NFolhcAnxo+WkjVUZyuSmrx3ZDW8zLHQvjrKuHZ0pwhB+X/aWqb3e+uwoF0R5JJB94kvT0T89vlhyif/e91fqhw7t/w==
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB8973.eurprd04.prod.outlook.com (2603:10a6:102:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Thu, 4 Jun
 2026 20:24:28 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 20:24:27 +0000
Date: Thu, 4 Jun 2026 16:24:21 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/12] dmaengine: dw-edma: Add partial channel
 ownership mode
Message-ID: <aiHe9UG3FwIACC8B@lizhi-Precision-Tower-5810>
References: <20260525062420.3315904-1-den@valinux.co.jp>
 <20260525062420.3315904-4-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525062420.3315904-4-den@valinux.co.jp>
X-ClientProxiedBy: PH3PEPF000040A8.namprd05.prod.outlook.com
 (2603:10b6:518:1::4a) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB8973:EE_
X-MS-Office365-Filtering-Correlation-Id: 3401e8fd-112b-49bc-417a-08dec27746b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|52116014|22082099003|38350700014|56012099006|18002099003|6133799003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Jie4SduYkdQ7cNJ7tNB3emeuBY9+2QDakwsY9gC56zk65p+c1TQ6BQCyRzvU2EYNmMjtvHBNqD0PKlhV5/iJzfEva0+8CfiD2y7CGsOSgqFu+AEBWiCktoTnEf43RUqebPM0aSZJukoDSWPeCGtOM3E4qBtyDxh31Z0fa1Y2BbLYk4j/XGdRYned5U9caJKHLAa5lDaS1Lu5rVMz5p37QymBD7vdrpyEe4e80r4/MdkOgGWhRdgtj/jVd4Ju7H4PSAM6i2dULsAtrnnAY5jBPvTp+BO4Ax3P31kdpwcP/lQ+Vp6k3JaoOkzEKLOBYg82XizUjaxwxBSQuqq0khk0+UGtlxOhvUruUvChWdwCjo+rPHNoHPhPZp0IwI6JON6CxPJ/LK9/WKvxRbi/vqsEThUeSX1umpg+2/8fg2P4mNQJ5kGL40vU07y8VgNnG+OK8isoJzQkruyb4BUBmKHSrkWerqta9/LoD+Uohmd/Y5B4h81NFz6KWPME/qnZoYQef5ULQ3/mgPtTwBg5s1nZsaS+BpiMKTDY0FR4NPAQDY/VDNILfyI4bpns/VjVUDapV3vK3G6Y7Hc0gWPzKAh+v+lqJLyW00Yfa5TEoRdcPSl7HtDkLCd2FXYWCNAUoNGR5H57nnU3mtdIHHfSuC3Vqq4kYlmjLCOjDzaj/M5RxKuWyh7ZvEs3IFlCsVO6mg2LhCdsdzLprxPAvdwhBLUpZB985EmFFfUR3uzrJgPJWSI39Oi5sJiTUtwN/67xeGK0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(52116014)(22082099003)(38350700014)(56012099006)(18002099003)(6133799003)(3023799007)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aV/McSx2YbfPBgP8GwGTIsInNUsGsKPdsMqYsV5KfFar9CBgc/wEISilbGpd?=
 =?us-ascii?Q?CisInK1jiNylAOg2OuV9tptRthieZ6bSK6zZPwkhxr839ozHpQwis35Pb2O1?=
 =?us-ascii?Q?c6Tldla3jRvs+S38n7QTw6GQ7LGSxdlIq4Q+N5PkCuISG667cKVcKOCwe3kP?=
 =?us-ascii?Q?AA4kf6Hiww7lOuFT7KRJRe28I/1yoLG80XimQZn1LO/v+FsC0dhz4eRKE0DN?=
 =?us-ascii?Q?cxgOfB5DPoj/MzTbwu5s/ofFKxtZcYrRU1BYwMlglocfYmsl+wdvbblKyq2p?=
 =?us-ascii?Q?mXEJIwTxdrd/AB4IhrgFe9Bkn7LSIGYL9mVy32SpIYXl5/F9hXAzYr1ULKSf?=
 =?us-ascii?Q?guMUmsB92iEFHeowUXjz4S7lH1n6lU9CpWy2PPB8qxhg79uo1sTqsPr3CliO?=
 =?us-ascii?Q?HSQfbKWF2PgDAdLdFDxuLdgoW8sKOrNNGpd4h2E7G3gnMNiSFSEuBrB2Zwxk?=
 =?us-ascii?Q?6U5eTu65WcgDnJqv3fVAAeDUaeDSgpq55AJHPFjmyR4IRK8Zf/t4DCl7lOR0?=
 =?us-ascii?Q?e9mJGJ6STRZPlNNw+dNa5LVoHWWHgfR9WczWtyp5aA9DNJTCmm5FtyS+DHSX?=
 =?us-ascii?Q?//NtokOMPHR8uieuCO6+DRbo2Uv+M8TVnHldw2H31qmCqVrWTPSCfZy6U3h/?=
 =?us-ascii?Q?UuCFKobnJ/vDT4Con8eIaaUwcA70k/9cQNOZ//iJNAL5wWiAPG2saZgMPzQi?=
 =?us-ascii?Q?ql5geTh6aIaobaDMpw3uOAkKXz3wJrnEb9eFQAZUIIRlZVcMiULXJNeN8BYK?=
 =?us-ascii?Q?qDVb3GVOgVj8ea7R8xYlcj0nn8/Y8wE6bc5kvDnbcJjycdPEdcR190TXMFxj?=
 =?us-ascii?Q?lMuTtYdllq6OxJ1p6/8R+g00jPE9igbF/Ejxo1uZy03QuG45UXkHZLPdHkEh?=
 =?us-ascii?Q?QKkKK3uYrRxIjkSf0mZIw2c8xBKmXGQsZvri9S88nwFUv3RD/D+fPa89hv87?=
 =?us-ascii?Q?GcVfswTcz38tY5+RaZx90lsGzekN6npzieo2iaUYHTJSbvQymqAN3EcnS3be?=
 =?us-ascii?Q?yMrhQEkpE16ofmDU8UuY8+9Xkvf9XUoMYf8bq1LMJVbasSTWuNmYp4HnngDy?=
 =?us-ascii?Q?wsBuHfDD7pUHSv+kZVzRKQrN8y1HWI3oVTPuPdkugY6hRdVIMxWPLiR9tTnk?=
 =?us-ascii?Q?WEsFQ0CKK17thJTcNlzd8jHyFLLhHy08f4l2I7ueE6KSQgz/oVUho2CNbum0?=
 =?us-ascii?Q?a+/mRqXznABxsskCXSmioyXl0kaiehPgvPxw/X2WzqD2Jfz4UZjazf0XXnfp?=
 =?us-ascii?Q?OKb5VFuKjszDgWNvco3Zc+qSihO+mFzzKGK55rE2yXMOqrkiZPN95A6Htkoj?=
 =?us-ascii?Q?ybCpW9gMIG6JZX7+HHj7CQ1kozVPIIO3ssmRAYyx9mSGXOT3/064jc+WMuyM?=
 =?us-ascii?Q?6qYsCNKt0yU6uvE2HAwvhbfwal2wh8u8BRMUVofIHULPHbkGAXrLDyym3cOe?=
 =?us-ascii?Q?xEAk9rVLZq9dkZ4n56DAq19wj9KLmuYQWq6tig1fWsbwcifX+WqpUHAItvP7?=
 =?us-ascii?Q?eJ4aSDYKpZcsMdx1JCFX+dvt0QHDj0BYWWwNeO4uyuZPluj4Qh3vAeywZOJ9?=
 =?us-ascii?Q?aUwDiOQmR8Fp6+Gmv9DAfVnvY9F0Pb2jwz9QIXA348wHS1B43aeD6NI5mUoy?=
 =?us-ascii?Q?X8gDO8rLt5pWKaq3vIlFuFhpLshhnUD8asZpwPuip7Qru04ZZXX3c8GYdFq3?=
 =?us-ascii?Q?AwvVeqfsT2giFgEEyR5hWSQjp/7nAK6+5ErIZRrdFM8btg5Yzym0Han0Bs5L?=
 =?us-ascii?Q?6MkyiuMnEA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3401e8fd-112b-49bc-417a-08dec27746b6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 20:24:27.7278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UPYPMtr6PH8CwS4e5+T2Ol/6erFfXZ0JjJyoWJvC6iR9yXjs58o3WCHA23PsXMQLARCcEBetgkNCk5jsMuFxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8973
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:den@valinux.co.jp,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:mani@kernel.org,m:marek.vasut+renesas@mailbox.org,m:yoshihiro.shimoda.uh@renesas.com,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marek.vasut@mailbox.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11170-lists,dmaengine=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,valinux.co.jp:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lizhi-Precision-Tower-5810:mid,nxp.com:from_mime,nxp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 592DB6434F1

On Mon, May 25, 2026 at 03:24:11PM +0900, Koichiro Den wrote:
> Some endpoint DMA frontends expose only a subset of a controller that is
> also initialized by the endpoint-side OS. Add a partial ownership flag
> so dw-edma does not reset controller-wide state in probe() or remove().
>
> Keep the mode conservative. Do not enable interrupt-emulation doorbells,
> and reject partial instances for map formats that this driver cannot safely
> share. For EDMA_MF_EDMA_UNROLL and EDMA_MF_HDMA_COMPAT, require ownership
> of all channels in each exposed direction. The driver updates registers
> shared by all channels in a direction, such as interrupt masks and
> linked-list error enables, so two independent OS instances cannot safely
> split one direction without a shared locking protocol, which is
> unrealistic.
>
> The frontend must still quiesce delegated channels before removing a
> partial instance. The flag only keeps probe() and remove() from
> resetting controller-wide state that may belong to a peer OS instance.
>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v2:
>   - Reject partial ownership for unsupported map formats up front,
>     keep direction-granularity validation limited to supported formats.
>   - Revise the commit message accordingly.
>
>  drivers/dma/dw-edma/dw-edma-core.c | 47 +++++++++++++++++++++++-------
>  include/linux/dma/edma.h           |  6 ++++
>  2 files changed, 43 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
> index a70e0640d082..fcef9a27b6ce 100644
> --- a/drivers/dma/dw-edma/dw-edma-core.c
> +++ b/drivers/dma/dw-edma/dw-edma-core.c
> @@ -794,6 +794,9 @@ static int dw_edma_emul_irq_alloc(struct dw_edma *dw)
>  	chip->db_irq = 0;
>  	chip->db_offset = ~0;
>
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL)
> +		return 0;
> +
>  	/*
>  	 * Only meaningful when the core provides the deassert sequence
>  	 * for interrupt emulation.
> @@ -1135,6 +1138,8 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  {
>  	struct device *dev;
>  	struct dw_edma *dw;
> +	u16 hw_wr_ch_cnt;
> +	u16 hw_rd_ch_cnt;
>  	u32 wr_alloc = 0;
>  	u32 rd_alloc = 0;
>  	int i, err;
> @@ -1146,6 +1151,16 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	if (!dev || !chip->ops)
>  		return -EINVAL;
>
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> +		switch (chip->mf) {
> +		case EDMA_MF_EDMA_UNROLL:
> +		case EDMA_MF_HDMA_COMPAT:
> +			break;
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +	}
> +
>  	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
>  	if (!dw)
>  		return -ENOMEM;
> @@ -1159,13 +1174,23 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>
>  	raw_spin_lock_init(&dw->lock);
>
> -	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_WRITE));
> -	dw->wr_ch_cnt = min_t(u16, dw->wr_ch_cnt, EDMA_MAX_WR_CH);
> +	hw_wr_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_WRITE),
> +			     EDMA_MAX_WR_CH);
> +	hw_rd_ch_cnt = min_t(u16, dw_edma_core_ch_count(dw, EDMA_DIR_READ),
> +			     EDMA_MAX_RD_CH);
> +
> +	if (chip->flags & DW_EDMA_CHIP_PARTIAL) {
> +		/*
> +		 * Direction-wide registers are shared by all channels in that
> +		 * direction, so a direction must have a single owner.
> +		 */
> +		if ((chip->ll_wr_cnt && chip->ll_wr_cnt != hw_wr_ch_cnt) ||
> +		    (chip->ll_rd_cnt && chip->ll_rd_cnt != hw_rd_ch_cnt))
> +			return -EOPNOTSUPP;
> +	}
>
> -	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt,
> -			      dw_edma_core_ch_count(dw, EDMA_DIR_READ));
> -	dw->rd_ch_cnt = min_t(u16, dw->rd_ch_cnt, EDMA_MAX_RD_CH);
> +	dw->wr_ch_cnt = min_t(u16, chip->ll_wr_cnt, hw_wr_ch_cnt);
> +	dw->rd_ch_cnt = min_t(u16, chip->ll_rd_cnt, hw_rd_ch_cnt);
>
>  	if (!dw->wr_ch_cnt && !dw->rd_ch_cnt)
>  		return -EINVAL;
> @@ -1182,8 +1207,10 @@ int dw_edma_probe(struct dw_edma_chip *chip)
>  	snprintf(dw->name, sizeof(dw->name), "dw-edma-core:%s",
>  		 dev_name(chip->dev));
>
> -	/* Disable eDMA, only to establish the ideal initial conditions */
> -	dw_edma_core_off(dw);
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL)) {
> +		/* Disable eDMA only when this instance owns the controller. */
> +		dw_edma_core_off(dw);
> +	}
>
>  	/* Request IRQs */
>  	err = dw_edma_irq_request(dw, &wr_alloc, &rd_alloc);
> @@ -1227,8 +1254,8 @@ int dw_edma_remove(struct dw_edma_chip *chip)
>  	if (!dw)
>  		return -ENODEV;
>
> -	/* Disable eDMA */
> -	dw_edma_core_off(dw);
> +	if (!(chip->flags & DW_EDMA_CHIP_PARTIAL))
> +		dw_edma_core_off(dw);

Can we simplely prevent dma driver remove? If attached to pci host,
remove edma driver always be risk because RC may write data at any time.

And it doesn't make sense to remove EP and EDMA driver after linkup.

Frank

>
>  	/* Free irqs */
>  	for (i = (dw->nr_irqs - 1); i >= 0; i--)
> diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
> index 2bf2298711e1..84f0e728d300 100644
> --- a/include/linux/dma/edma.h
> +++ b/include/linux/dma/edma.h
> @@ -55,9 +55,15 @@ enum dw_edma_map_format {
>  /**
>   * enum dw_edma_chip_flags - Flags specific to an eDMA chip
>   * @DW_EDMA_CHIP_LOCAL:		eDMA is used locally by an endpoint
> + * @DW_EDMA_CHIP_PARTIAL:	Only channels described by this instance are
> + *				owned by this driver. Controller-wide state
> + *				must be preserved, and layouts with shared
> + *				direction-wide registers must only be shared at
> + *				direction granularity.
>   */
>  enum dw_edma_chip_flags {
>  	DW_EDMA_CHIP_LOCAL	= BIT(0),
> +	DW_EDMA_CHIP_PARTIAL	= BIT(1),
>  };
>
>  /**
> --
> 2.51.0
>

