Return-Path: <dmaengine+bounces-9951-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIV9Lrpo2GkhdAgAu9opvQ
	(envelope-from <dmaengine+bounces-9951-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 05:04:26 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 339F13D1A76
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 05:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E08930048F4
	for <lists+dmaengine@lfdr.de>; Fri, 10 Apr 2026 03:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE92F28C854;
	Fri, 10 Apr 2026 03:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dN2t8uRz"
X-Original-To: dmaengine@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013042.outbound.protection.outlook.com [52.101.83.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1D3230BE9;
	Fri, 10 Apr 2026 03:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790225; cv=fail; b=Ax96eiUYKPA9A1XM+XapGXOWEM52/K9ZuizGkTpSE0O+CexDoO3oSLbcUmuAkt78zu3xWCN+PUUW2DmGvNij0e5NROv2ZehzpBkLoLjEt+wU8fldF00R1+1zqEsPhTb6VI5yM3cjEZroGcyZaM5a/Xh4TcMZSbsxnH5RTi7Hqn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790225; c=relaxed/simple;
	bh=Mkcz/KVvk8SRAjVpfimyciKeqkSVBp2f7DFOiRrj1iQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ccnW1nCOucEAVAipXY2Y9ZbJH8C0gVHi5pDcFkb90P0UChwuWi5TVw/vqzQWMA/lq6/DoT92Ge0r1qAU293WRWMIfv4g/+bG8cs5NvCoevOKPFsP+AzYq+72PUYcjHg6s4t7vTiOmiI4AcCYML4U2wQ31U429D2lFUj5g+Anqsk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dN2t8uRz reason="signature verification failed"; arc=fail smtp.client-ip=52.101.83.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k5afJaU+FKklnbCVAfAPTpJ328+7DD420tFiJW+NGUUOKNUwnl4vss748xmgqilvdopLdskIlTk2Sk6+VAV8v+yNoe8rXuu0SIuJQfUN8vrlWs41HOz5uQjamNbnVmWmU7Y7iJj3zTmBUzuWvj0IBpXWDUEzZiyPHu8bFP37j7cKdJn5onFFWToOnQaV+fFzgqWaOasW1xEO/MEmHQIeZm5vCl8bcVQqkq6dLC47kAMgfdSQiKTcc1VVXTHjDNf6uCXwRlS3PHDTGOKDcJjwrhmQBiTYTC19zhAuiWtnHGL+2PMBXvKBRd1/T0rlg/yyncR3VT5SDNqP6HNl5NyGDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCRRhB8siVv4jhxXLjqC6yHBE0yJvTmmcT68g0wiJ5I=;
 b=zLd5vTXjLioSyJCQYwFMc8UscLnslHK/dgsC48OVt8oBf+RmWEQRKqFGhnsHQ9WQ5NRNLPB1jOh2nuQPtNuHT3NwfKq3xVgieVT4yWVEUCNgotR9zeVWtjWql83BfiwBO6wlEo0kmC52YVodf3Hvr4u6FWsgdKE86Jw7MRNZS/KjGvZhUgM+A4h5EtttE34/2wCC8LgsL8b5wY2lFJTPsVLWrkFjtxOsy061WZ3kpKPzoq1OyMSq/wG33RkCqvHvtwyOGo8b/H5BKQX8DRB8v14rXjEIFqukvNh+SVRMaLWTqpzyzDUD66WJq4kTdgP5FVKQEXpdrI1ZaFLCS02m5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCRRhB8siVv4jhxXLjqC6yHBE0yJvTmmcT68g0wiJ5I=;
 b=dN2t8uRzMSKtTA4vSH3cRzbkER7pPaz23GF3BrldGHJT3t+/g3KLTsfDULeYZP1QvXEQxMpqRzwiW5qQ2Kj3dzmULnvEqPbH9JvtSNFyXwgmtEuQnE9UxjfbreBrHK4FjMUIAfOyZzPthsxzgvnaLGSkpzPdqUmYvSnAo7LDwyMfbRbTAu4DjqevzgBCrUd8rRJb7vBdRd/pb/Qyl2QA4xJdL2RBfS3v+VNYWg4vNmp4pdKikCupWORBR3a2SqqdM3eoNuc/tEQblvz8xHvej91Ligohcvl8bIlWD2KAOqMK/+VP0F+AbuOobOMe/qyU0DZ1Fjdtvtpya943nNcLhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by GV1PR04MB10128.eurprd04.prod.outlook.com (2603:10a6:150:1af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Fri, 10 Apr
 2026 03:03:41 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9769.018; Fri, 10 Apr 2026
 03:03:41 +0000
Date: Thu, 9 Apr 2026 23:03:35 -0400
From: Frank Li <Frank.li@nxp.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>
Subject: Re: [PATCH v3 3/4] dmaengine: dma-axi-dmac: Drop struct clk from
 main struct
Message-ID: <adhoh6evdWtTyjG-@lizhi-Precision-Tower-5810>
References: <20260408-dma-dmac-handle-vunmap-v3-0-2456ad292154@analog.com>
 <20260408-dma-dmac-handle-vunmap-v3-3-2456ad292154@analog.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260408-dma-dmac-handle-vunmap-v3-3-2456ad292154@analog.com>
X-ClientProxiedBy: SN6PR05CA0022.namprd05.prod.outlook.com
 (2603:10b6:805:de::35) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|GV1PR04MB10128:EE_
X-MS-Office365-Filtering-Correlation-Id: ef136bdf-1fb7-42a5-5071-08de96adc521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|1800799024|376014|52116014|38350700014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	uJ7v8kpXdNUX9UpyLWH3dM7SkPiMDlLWhAIIKcTDDLQRhTTzSFu9V2Xszyyw6PJ+zXy+qvfS1w5oPJzZ1ohD85b34iemMJFx6qNrq/TVJQv8xGH9RUiUIqYYFc+FujvtCsSII2eJtHjfCET6+0tN9flSyGvhHlFHmb7CwZy4CeeIqOs8XMCrGhJAIi63M+MqQnEr8w4JzHHXu8hoCL6VvZMjugFt3fUBH6gkRfrMJ94BNoKNYROYpBkI1+MZjn2askv4GVcM9GyWNmqzTDvzzaSj13+Nv8my2FgkhtHVQDLTOeuqZb9M+SOcta5891ibyzeUI4doG/iskvmwet6TshgFbcSPuTX1wB4Aifsthf/GLP9T2GRD2lW5mhFWbtH45+aY4TxTCkmjhu5shel8jOLxD+UzNdP7jJrZoZCGw/0rLniy9vxqtrOMfe5GOgq9kOq7IqfI8tKYifMsR7i8/7nIGxifQYZxH/2RUrZwav6KMx4x9bF7AbAL+CBTLirh9uxCqyGhkxtxQz973OCGW0KP8IqxJAtoVZplmTJuW7mHqh4ft4YGWIGhyU8UQz4LBi39VS+ibcad8xD8IifWKHR1q+tIFJcmIIQM9fw5XW9FmpkDMkt/q/RIBYPhyKOwG2CSiHjW1j5QMRgo0dCRCk/BjUq/08ThqQHcy/5aCDR7tpXyJEbzCdgdvdWANJXLoG+wQjDCxAerLq4rWnRi0CnBt9ErRGk1O/cbi2JZNOhNO5P+3ggSgBnXFCPrgmGaAaCy7zh14ijfyhmYO2xCB0rfrQnjTDd/m40w2RdtZX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(1800799024)(376014)(52116014)(38350700014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?qMKjdd2JTzGFE7VoPg2dabbU9mJV+I2pH8R/stvgYbWTexQFAqRMAtwUcq?=
 =?iso-8859-1?Q?ddJMQ7+bkMpCxNuaHWv5xafu9hxHFGqOAASly/04EzHGITrgrolFAozjFn?=
 =?iso-8859-1?Q?K14HeK8ktzLnFvzGE02vY42kktgi5+bkCwQPz8dPkoZ4MZxM0BaOpNrBGJ?=
 =?iso-8859-1?Q?uvOvTbV8uRABZBGNTdKJTeSISyRV1IZIPjtEWiAY7ZJE+rmjq7x64tZWL0?=
 =?iso-8859-1?Q?wYxCHbnhRoDbvafHB/nuqbc+Bjnp221hFnjOtJoDZ0EQ7MIVIvCxwZxZPG?=
 =?iso-8859-1?Q?dNy6TO7hZQVZg679XucOnss55i13ZVbOL+TJfV+c53rxuQ7QAqKJlfQYRG?=
 =?iso-8859-1?Q?o4ZGrqdLbb07O0ty5oju+W7Y4lopYhPXKoV6pZ5pnKhzDoF0zbzkGrS35v?=
 =?iso-8859-1?Q?smxt/WzM5Uj4dvdoWZ72FtHeIEEhoawvoqVfBqUCwoJcIvg7s2EpXzLWs4?=
 =?iso-8859-1?Q?+dPxbH0Sqslyre8+a0eGaDFNOIuFcymouTTOGSp0YDlyTWMjmt5IorvcSy?=
 =?iso-8859-1?Q?A+b5Dp6E2iio1P4BZpbq7wlcqm23+LX0e/hb7K6LXNLjQKxcNDtuGn2baM?=
 =?iso-8859-1?Q?wMYalsIpxRo0xkqvbqxvFb5R0u7Z1vTaxllGpIA6oxiPGs1E+S4cckKizn?=
 =?iso-8859-1?Q?V9714kl4bO04rUduaFKM5k1SLMYmdEFY3E93oVtXHCrtq7rdLbSMNuON1r?=
 =?iso-8859-1?Q?qJy2vN4cCNjAjOmawSRpvN+nAOSWJSHjnfsJygJgo7jP1U9ArDB8dHMzDJ?=
 =?iso-8859-1?Q?4CEZP/4+d+0iuEPx2THQVnQdhPuutpupF9fcMD6dTxSyUqK0kmKQEltwNO?=
 =?iso-8859-1?Q?wHEo3x9o/OsftpgO3u9P5moyTGaXEpDYL41lnU9EqLBbBL+zenlr29caHB?=
 =?iso-8859-1?Q?SaayDbbMjKjL5OQVgHGk3aY/J3Uq03HEaM+81YIqsQQr7vOrLbp3cFNa+t?=
 =?iso-8859-1?Q?u+LezGunCWSb4Zu/jwxcttUIBSDAV4YFHkhJJsvsAIPiWVZjIXHCzchK5d?=
 =?iso-8859-1?Q?mn5E1bAMBEQG08Jqqg2yBEOBUHnJa0BPk7fhUUbjfQ1uKvdJhBib1FdzRP?=
 =?iso-8859-1?Q?VqC5Rh4RiQ0ejhORk3elUvr5oLFpdFhSajVjlwph1vPfB8sdSzPVDdTffN?=
 =?iso-8859-1?Q?BV3/C7fOdZHSS+IR1R+BGwmIrJJRHGE8trPVUj7XSR2xH5evqdLv4JEYXn?=
 =?iso-8859-1?Q?Mw4YVLZLVh8MbQFCz5O9PxkJ9dED2W8hEijVDSCx/OSwPQZ+K2T3U7pu2k?=
 =?iso-8859-1?Q?fCwsZAfwr3wKG/3RZcktSmLDwTJNr67r50+U1WD0S/Bu84WlYNElPOvpdc?=
 =?iso-8859-1?Q?qYSPyIi+xQrTPEUb26B8HT+Xo0wT6mDth+3LAwLUxP/Kd+hNBokJ8r+kyy?=
 =?iso-8859-1?Q?lCpXpQHEm+9PKqPBZToP1p6MT26vKneikpRi9Ppcu20TYzBzxjMrYkiUku?=
 =?iso-8859-1?Q?E8T2cHgKn/WVFi1F87aQwDaeb1tKzuupWVC/ZVyKRtjkr2sAo7OVPGWO8R?=
 =?iso-8859-1?Q?jgcDs5N2piBXMA3p7T0sjaSiymCLUzu8oZx8rYttvJID3ZbLx6ykAgVJNJ?=
 =?iso-8859-1?Q?DY6022IGuszZDxg0JmIuIl2CrtN2obJSGcJANsDbkoYuYcpAh1tHCRqdS0?=
 =?iso-8859-1?Q?Xv6OWfvXbKVf2UdFJZ3VwdReBuLbQIkXOkUZVQBWM2Aobujq6+p9RJYFFT?=
 =?iso-8859-1?Q?ojCoC02m/2dnl1IoaRcjaeS6T290TdRjo65bFMTfCzt05ixF4qTktyAs9H?=
 =?iso-8859-1?Q?h7O9m4KM41CAyffymLRmHI5GdRt3yPxxzCdEWMssxpMh1v?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef136bdf-1fb7-42a5-5071-08de96adc521
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 03:03:41.5465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: drwH136Hu15miB07Mf5Fo2TpED702QluSTYwh4tt8zsVakH5UKR23Mr3TyrzGL6KIliEFbn0hDTIE+epXp0RMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10128
X-Spamd-Result: default: False [2.14 / 15.00];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9951-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	NEURAL_HAM(-0.00)[-0.994];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:email]
X-Rspamd-Queue-Id: 339F13D1A76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 08, 2026 at 01:42:42PM +0100, Nuno Sá wrote:
> There's no reason to keep struct clk in struct axi_dmac. Hence, use a
> local clk variable in .probe() and be done with it.

... and drop it from struct axi_dmac.

Frank

>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  drivers/dma/dma-axi-dmac.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
> index 127c3cf80a0e..41898d594be7 100644
> --- a/drivers/dma/dma-axi-dmac.c
> +++ b/drivers/dma/dma-axi-dmac.c
> @@ -170,8 +170,6 @@ struct axi_dmac {
>  	void __iomem *base;
>  	int irq;
>
> -	struct clk *clk;
> -
>  	struct dma_device dma_dev;
>  	struct axi_dmac_chan chan;
>  };
> @@ -1198,6 +1196,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  {
>  	struct dma_device *dma_dev;
>  	struct axi_dmac *dmac;
> +	struct clk *clk;
>  	struct regmap *regmap;
>  	unsigned int version;
>  	u32 irq_mask = 0;
> @@ -1217,9 +1216,9 @@ static int axi_dmac_probe(struct platform_device *pdev)
>  	if (IS_ERR(dmac->base))
>  		return PTR_ERR(dmac->base);
>
> -	dmac->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> -	if (IS_ERR(dmac->clk))
> -		return PTR_ERR(dmac->clk);
> +	clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
>
>  	version = axi_dmac_read(dmac, ADI_AXI_REG_VERSION);
>
>
> --
> 2.53.0
>

