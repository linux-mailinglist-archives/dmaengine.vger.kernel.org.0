Return-Path: <dmaengine+bounces-9099-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGVkGe85n2m5ZQQAu9opvQ
	(envelope-from <dmaengine+bounces-9099-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 19:05:35 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 779CA19BFD7
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 19:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3CF6030131C8
	for <lists+dmaengine@lfdr.de>; Wed, 25 Feb 2026 18:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37B2E54D3;
	Wed, 25 Feb 2026 18:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mv7ow8PZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CEE2D7DDC;
	Wed, 25 Feb 2026 18:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772042729; cv=fail; b=RBMK/HA2NnAH2NU5rM+E5b/76lo7vSgyF0Zq4mQfqBp0jItu93CifTbZU15H5JTMhtWNqJnZKuo/t2Y2RvecD6AdHc/0DbMEmbUO9IhaMo2FGKoSMdSoTWJL0dsYmWUpx2LsG79On7cRgsLCpu6VvEiy3a4lLuuUS6hXxgxaHCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772042729; c=relaxed/simple;
	bh=H9SQ9fna5bpYNYAj01tW3MlN/HjgllsHpqmjw3VCC+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XZFrPsNSJRC/J1Qj8V5pprTz44h9vXfnI0Yp9aBu5Swov0ctcNLTJ/K3L7pvEMxVAw6X7e5JCOiUXJDKlYLHFbUyq8SJc15LUtuS6xbS2CH+RhOdyiVefQbj+zDTtnJfxh9cJ8m2R+hUE+GJSJaP90WxNE8IFfxapsqmxhGlwhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Mv7ow8PZ; arc=fail smtp.client-ip=52.101.70.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=td5IlewGQtyU6fQdbUFOW9kwUuga4UFrUGRGN+VwsN66cutBTBhcpEb5NJmhBEx1AC1SmDZBwM1X/hxLgUX46dSgDg1MkvuQxwaWyPauG6KfaCKlmGyxGmSRrwte/fipoNiljML0F+v239+eqXIWd4GfFYifXo+iXNglnsk/Q0cwpWTqvYi7f9MmMqPZ1oa8KzXj5AbCfLRxVLZguMKZQbuU/jNuc9UP24PLr+NtSrDNGvMv/6Kil+aLmgKIThrAIjTOSt/nj6Gu/XDtAcOXuPwq5IDpp3cQMeqq+N/sD3fCWhzLBTnAkWCjh9gpTQeb8/bvKvzFY7z/xtL/Ahje4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTk8r0ycdP433geRo1y/iibbqoZkdFvv5/w5a/vIjtE=;
 b=zLXwQSNETCfptBdH2aQ4Vmagg3cMehBhA8AHPTj09+kHJ5uuQvhZbNpVormTax9oaZZQrhA0PUsgey6BNuPXblD4swc21/cIaDHNJp6QyPpsoYI8MlfA+CGMlzRNyw6+n83eLX/Y0dkAibUhXHFPXfeLGETm3/jbjf+BEXfne4uQ7L0Mbt9LGDI2YhJ//XP9jzcdnuXtlrZdGUMGYEFboEesAQeoiSqN3ph9nHBIFCRIGcvQyOJFm6phXc/SraEbfoZ5rkd1WRGI0eKPlhomeIqPgS4/OG742r6VlxQJi/JZKNi6RHXPTwfLXC1jezWTIkpWvXmpOQcR2AP60sDcDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTk8r0ycdP433geRo1y/iibbqoZkdFvv5/w5a/vIjtE=;
 b=Mv7ow8PZKkjPMrQmJT/odGrc44mvTJu3GFy7GgT1fmTAmN4luvD2+iX6nbNx7woSgKh+LFCDCzI5DTTCoOooJAp+EuLy0sFYU7Lr5RINBY4+p+B+EKpchT7Ukbz63hC2BzR8b2rc4WWCnu06XjKQdzr1gt/GoVkV2p/uvXczud/Sf1Z1EK7uKFGdq7KcbaztJJ91+pXtqYMN42C5rnIzMG4vS108mTv5kysuhUCdyIgwoVddMUL9kLF0MpT7D5BjJ/9JDYJVI0CXkpDnURs1kHkNWaN3TCMkrGVmS8Y/kXoe7BBcW6KnPR+xXi/Q2afWK4VDXvmOxWyjagZBUAVFKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 25 Feb
 2026 18:05:23 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 18:05:23 +0000
Date: Wed, 25 Feb 2026 13:05:16 -0500
From: Frank Li <Frank.li@nxp.com>
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
	Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
	devicetree@vger.kernel.org, Keguang Zhang <keguang.zhang@gmail.com>,
	linux-mips@vger.kernel.org
Subject: Re: [PATCH v3 3/6] dmaengine: loongson: loongson2-apb: Convert to
 devm_clk_get_enabled()
Message-ID: <aZ853H35spfxnb00@lizhi-Precision-Tower-5810>
References: <cover.1771989595.git.zhoubinbin@loongson.cn>
 <8c45d9ed1b5bede8488207c88ec3a80ed0bdbcd0.1771989596.git.zhoubinbin@loongson.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c45d9ed1b5bede8488207c88ec3a80ed0bdbcd0.1771989596.git.zhoubinbin@loongson.cn>
X-ClientProxiedBy: SN7PR04CA0151.namprd04.prod.outlook.com
 (2603:10b6:806:125::6) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|AM7PR04MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7c2086-3239-431a-79bd-08de74987237
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	4p9SpvV7STV21sqU04toiK04vshyE8aPJD0QDVIxxBzSpYH7zoCRqKdLOtt9KRcGpc+y3OZvLIryD5Cii0Pog0aWn30So8gZuyEaaL1vqOr8fxGU7nJGyiltR0jXqXDeBZA+MwL4Fw8CQBTpCr8svSaVBQ3kyy3lfqejFPCVMJuUR7p2wRGrRcWyFDHBY9Pl+evUlOLfxmu98ClueptatGQ6qEFyYKUGChxw2lfVqDU8epE9AHZWWXcFp8I3AslzmeOKXLhU1ogXB5YEvzlLk04AWx933F2nESfllv108lVNFoOH0i16rHLQtlKrHpJyk6X5eyuWr2+QP81DKG/XI3tOgTI2UjY43pL76K65MGXHWBdHfPM3z2q3Gk/Gh+XSKGXr7LJpI7lf5PH9B0iFRgFeE6AuglTvFkbWraY9oE5Mgd+XnVwKo7Ox3I2H37DnQWxiAFeDahMQtwdXwtFTDJ8dKGb+/Kr+p9u3CNk0Ta+JeWRMec7+IKPu7gsrl4ZJSqAuVBc40Fe2Pb0ZSP+lIf5bPb9wNqB6ii+gm8LTI6qLSw4RnJ2DhXlfEEKRGUpeQpUJiDjOfYK8crwe7B/7nRpcB8vG7c3Qv1LODQqfTA3zL1VFAwGSodNCa/EE1DQ5yQN0BFVqquguix+WBc6MK8db8w8EIEjchIgWRuxy7dODl/0cOdwTXR+kzGWVUopH+vwFQfGYohpZtqPMumlUTbWA1fwZR3dQbQGUXkBYPtKDNRFW2FF6KhjdJEmrZsHIBSh/BUUFCftiYVl3Z3O/twC5GyDbqxBBQGNdCVzvby8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kGNVYNdgiYWPIlq4p68Dr4LyPf+qrR0Wdr+bMkEoX1wkrPQYo4rLQs7qCaz1?=
 =?us-ascii?Q?HGaq5zfD01JYKqC7Cz8khmn33i0MVhyDBU7bp7XrmKMjixV9FlWgutRcQ0mP?=
 =?us-ascii?Q?Ox+4CI++3xcBdOo+wluSBn9/2VN77P0Mk6ckXrb66qA/cIUKG94cizrQdGW7?=
 =?us-ascii?Q?Af5dW3maK+PbGY77jRoFF5ypgT2DHXTITuTe09WdxbXNvO0uAnXSZuRPbeHk?=
 =?us-ascii?Q?nSGYSif2y9a4HY5B+2dqg1f7dyab1canzywdLfbhUPB0WQhA4amFw9kwB5Fo?=
 =?us-ascii?Q?AvU+jVzsoDs4UHvcZLZjXc3HqJ0JUj0V7FWd8mwOBPmv8oQRg8w4qbRSaKK7?=
 =?us-ascii?Q?jgY/C67owd8R1DHJc+1QFB1iXMXpIJhKtkbpgy595iAWkKdjT3ixf2LGzAhp?=
 =?us-ascii?Q?Svp9VNrXgEDw/FjgN/jCwMiQ6Cz/L7ym5TivJW8ePUFz9XgB8ziDCM6vuR2S?=
 =?us-ascii?Q?+feRtloG20FlJiAQCAvB6IL4Ue9GfrZ6nVIb/G99rwfBvFZ65CpLL6j90730?=
 =?us-ascii?Q?7FJLyWA6eL1lJjVgVPUyE5NQMrSdIbXUBuJjippkABRHYrgb4cHATzG+TAs+?=
 =?us-ascii?Q?it3n+N5GyJKysK5k1jdVcx8oS06/8nEJiwVExrdvY+g25m91j7aguSt4j5Oq?=
 =?us-ascii?Q?a/wEJwzYTRrGsH9dhf+oWJTZbdVceW4UnuIGBwIiEjG04uSFffznFkTBLd4s?=
 =?us-ascii?Q?BhOGcHLr64QWpbCkLvnofRkyNpM1mO/t0OFuGrCvqv70SPt9yEFshMICYPrZ?=
 =?us-ascii?Q?gJ2QHmEogPHkIS7PZB2AaFJcy/nhs1qthq9cOJen/KZD5qmFbqg9UDJUVTVs?=
 =?us-ascii?Q?RlSDgT/hGdwxitbBh8VykxUD/mv7C44b4Ye0nNR+Fkoi5czu2Ptdk2ykc2PT?=
 =?us-ascii?Q?gqxgKfNiNp1epsf0QK/XISBYCPFjY/N5bmOnUgiDIqfm8gQMisVzhGaQ9ptq?=
 =?us-ascii?Q?vJ/nB2DPiteMMuPfr/7i65OqldqHmEya1Eg3EqyC1PZw1qMcK2EOv0rKHZ6E?=
 =?us-ascii?Q?aRzI11n7UmbNA+oJDoVYcPQkQetXfp68VIaZuZlctPDAWX5J9izdeFZ9homB?=
 =?us-ascii?Q?zTCPBKZ0wpkrma98YlCIlxmA2DgnJCGaUSdGeRovijL3brLLUR9NqB1PC5Ig?=
 =?us-ascii?Q?1jkxS81z6+fvjALDnu6YGChfIwjeltiWXSAH5ckM+vph4LJf87uAkLr5VpSG?=
 =?us-ascii?Q?837qYgfhp4g5O0dBS3gyhFIK+cQSuiNz6+JnSwHamMP1E9ew1tDEcwpjA/0F?=
 =?us-ascii?Q?rdxZxP07cSIyZk5BUljSV48v/zB79lFjTIRLIKgAacAasBylU1JPgRY/dzRQ?=
 =?us-ascii?Q?gpMvCbpcbTGn4espgkP6HZh2GZUvPGPwMWIHm2MTa33KfWXTWsm7bdc/wbVA?=
 =?us-ascii?Q?d3dpH6fFfqlzts9Rhyc+67iFtmyOxufD8XzP+8Q6yIJqqcuhqWfejUAONGE7?=
 =?us-ascii?Q?J8kq97Dslgb1xqKm9YLllrqT2qh2SRI5YyJ6+sFZYNkQWekOho0vfwjbxcxu?=
 =?us-ascii?Q?qX8sByxdUxh0r6WIHkrtcxdUEFvD7PAylOPvM6quy0aWx+XmFEppnOOSOh2Z?=
 =?us-ascii?Q?JCTL4MG/GhuAaYgOoF55Y0VbrpQTcqfFFjDj5mG7xq3FZKGavz1uxkCB+x/p?=
 =?us-ascii?Q?6KF13lkcYy0BpEelx6HFB0/lEfPIUq1Hcig2oWr793ztFqnxdnLs2NgJlBih?=
 =?us-ascii?Q?kHJVhpr4Qf9iDRvzXbNuwxwLpwHbfG/BC0H6EJAvj/Ca+3Q8uAzUluugOA6u?=
 =?us-ascii?Q?L33DY7eR+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7c2086-3239-431a-79bd-08de74987237
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 18:05:23.5400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nP86uNFkDpsgAF0fET5/I1AvTH+lb9Sc81NB/ltLFzjOuCsdRvnNHzd0R/DDi7xUw8/TSTve5ChGTAKh9BXYIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6821
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9099-lists,dmaengine=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[gmail.com,loongson.cn,kernel.org,vger.kernel.org,xen0n.name,lists.linux.dev];
	DKIM_TRACE(0.00)[nxp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,loongson.cn:email]
X-Rspamd-Queue-Id: 779CA19BFD7
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 03:40:41PM +0800, Binbin Zhou wrote:
> Use the devm_clk_get_enabled() helper function to simplify the probe
> routine.
>
> Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
> ---
Reviewed-by: Frank Li <Frank.Li@nxp.com>
>  drivers/dma/loongson/loongson2-apb-dma.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/dma/loongson/loongson2-apb-dma.c b/drivers/dma/loongson/loongson2-apb-dma.c
> index 2d16842e1658..adddfafc2f1c 100644
> --- a/drivers/dma/loongson/loongson2-apb-dma.c
> +++ b/drivers/dma/loongson/loongson2-apb-dma.c
> @@ -616,17 +616,13 @@ static int ls2x_dma_probe(struct platform_device *pdev)
>  		return dev_err_probe(dev, PTR_ERR(priv->regs),
>  				     "devm_platform_ioremap_resource failed.\n");
>
> -	priv->dma_clk = devm_clk_get(&pdev->dev, NULL);
> +	priv->dma_clk = devm_clk_get_enabled(dev, NULL);
>  	if (IS_ERR(priv->dma_clk))
> -		return dev_err_probe(dev, PTR_ERR(priv->dma_clk), "devm_clk_get failed.\n");
> -
> -	ret = clk_prepare_enable(priv->dma_clk);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "clk_prepare_enable failed.\n");
> +		return dev_err_probe(dev, PTR_ERR(priv->dma_clk), "Couldn't start the clock.\n");
>
>  	ret = ls2x_dma_chan_init(pdev, priv);
>  	if (ret)
> -		goto disable_clk;
> +		return ret;
>
>  	ddev = &priv->ddev;
>  	ddev->dev = dev;
> @@ -652,21 +648,16 @@ static int ls2x_dma_probe(struct platform_device *pdev)
>
>  	ret = dmaenginem_async_device_register(&priv->ddev);
>  	if (ret < 0)
> -		goto disable_clk;
> +		return dev_err_probe(dev, ret, "Failed to register DMA engine device.\n");
>
>  	ret = of_dma_controller_register(dev->of_node, of_dma_xlate_by_chan_id, priv);
>  	if (ret < 0)
> -		goto disable_clk;
> +		return dev_err_probe(dev, ret, "Failed to register dma controller.\n");
>
>  	platform_set_drvdata(pdev, priv);
>
>  	dev_info(dev, "Loongson LS2X APB DMA driver registered successfully.\n");
>  	return 0;
> -
> -disable_clk:
> -	clk_disable_unprepare(priv->dma_clk);
> -
> -	return ret;
>  }
>
>  /*
> @@ -675,10 +666,7 @@ static int ls2x_dma_probe(struct platform_device *pdev)
>   */
>  static void ls2x_dma_remove(struct platform_device *pdev)
>  {
> -	struct ls2x_dma_priv *priv = platform_get_drvdata(pdev);
> -
>  	of_dma_controller_free(pdev->dev.of_node);
> -	clk_disable_unprepare(priv->dma_clk);
>  }
>
>  static const struct of_device_id ls2x_dma_of_match_table[] = {
> --
> 2.52.0
>

