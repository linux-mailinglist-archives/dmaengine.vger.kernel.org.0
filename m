Return-Path: <dmaengine+bounces-12232-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fBbrDN62T2q1nAIAu9opvQ
	(envelope-from <dmaengine+bounces-12232-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:57:34 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 791607328A7
	for <lists+dmaengine@lfdr.de>; Thu, 09 Jul 2026 16:57:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=NXP1.onmicrosoft.com header.s=selector1-NXP1-onmicrosoft-com header.b=hU5oegJJ;
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=nxp.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "dmaengine+bounces-12232-lists+dmaengine=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="dmaengine+bounces-12232-lists+dmaengine=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50EBA3187370
	for <lists+dmaengine@lfdr.de>; Thu,  9 Jul 2026 14:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A9337BA4;
	Thu,  9 Jul 2026 14:34:45 +0000 (UTC)
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013000.outbound.protection.outlook.com [52.101.72.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657D03358C4;
	Thu,  9 Jul 2026 14:34:44 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783607685; cv=fail; b=qiyLGxF64aCTTzDMGzkRSjyqRImnBjfjOIuuYKb62Qn2mEze/3FJZYNj2igJ8SMxQuBDCdWld8N1Pk/NBlROmTMDLVcxhQck03sgw78mfbm5t/5vrYhpn/HvAQolm1NgGgtTLFvirQYBcVhDD4UHI4nT8dgORn7pyxrdAMOxqMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783607685; c=relaxed/simple;
	bh=uqeCO/TebOYTGqCTeBtCxC2MES7cg/n0CKNKDRpOp6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TwIZduygFsWZ70XCvhzqDUF3kH/0lt/QfUHaCx3Q6241AAxBHBnoOzi2uVP53AApb9meXYE+EhL57tLa0gFiilGMLvtz6OIgz+9nuSq71lxOUg+8OH/sWyK/aF9NrbCjJbhzkmlFcgkCEYjWCya40zBOe9QhBp6ZqiYzmI7VO6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=hU5oegJJ; arc=fail smtp.client-ip=52.101.72.0
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMq6H553rwLmL2h0ox3stv/MclU1gHpq5VsHYthMmAw8doRioNvqLEiuFhmIpbKC8oojzO3MTbzdTYMPL5AxHRAao9y5psp3UAfhvBH0zJB2k6874lzP9DXrkV3JPeg8p6Hsqk0x4SeZ9FbLO09V2OwB3GVxca9HhMorcri90oNmWScIJZObty9W5lMlDNmwVjGH3kYjIUAatafRashRr59yrYatTCv/0M6lv7zgUZ3dDkso3FPUDo7rZIE/QjAOSBAxT5KQ9IMaFzHor2fASgguJV7jzV0nHnUlY7cVHnBLOTtDH0pBp0NnW0HlAKYF4Crl/dbbPU2Paf6Dx6Yijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfx+7VzEr9wfCLikRGvV7nOkOcQgy9VwbVKrkslcpzw=;
 b=kwhN9y1VFDV1Mz2Sfv2JLKZKDOMgo1ndWKJ+E2aocilNUdoepAK7dihwd9IWuxlDzrUwNb8ZYsYADNjt2b0XNYmcOsTqs0wIy+MZEjFTfxc9cK2/qCUvwWVfmaNCqCzobJttHC2crJpCno7N/DO62sEco0Vjfwn9lGEw2mqOJKl+5exaRFgktg3+D3ZjHbomML6gZaxYbEChChLGeKKsUMEJWpp5e0LgYbU37q8vRCV1a1DJwWVPOO/7gWD7LjiwxGmXp6VoBvCzwzGWMwhYs0eWdOqpgwNltJqEDWFGDnoisag3uC3Ho8/T4RvBYT/rIi5lD12o+fJJ+JXwPIotcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfx+7VzEr9wfCLikRGvV7nOkOcQgy9VwbVKrkslcpzw=;
 b=hU5oegJJ1o8QvEH9wzte81OTSO3DYe/pgRRhUih+zc2AKTFMsnkd/jFRkk7oj859X1HIRcR883wvOfgCJJoBvdODOXmqFhxNrdUtaUnAaVHxhmMclUSVIab8YSX4ev3pj8jOfmDDQFYuvbLQbfTxhABW+/+ZKHqeJehC+t/0velcg3dKMrwPrvSu8W4EJ7omIloUfA3y+t08D5WPBzuKEDz/Nruehh/C78Qvl8ydNAxNr+/WOzoAm9flL+qMKUYq159lmfonwha31/PnkINM4lmOS+9O6+M1aLHuoy1MXFWTX0YqtZPlaYGUdEOtrFdAZnCxE0QuJLHOVcjKOTaOSQ==
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AS8PR04MB8344.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 14:34:40 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%6]) with mapi id 15.21.0159.007; Thu, 9 Jul 2026
 14:34:40 +0000
Date: Thu, 9 Jul 2026 09:34:32 -0500
From: Frank Li <Frank.li@oss.nxp.com>
To: Pan Chuang <panchuang@vivo.com>
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	"open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/26] dmaengine: fsl-qdma: Remove redundant
 dev_err()/dev_err_probe()
Message-ID: <ak-xeIoA_tCCVbnT@SMW015318>
References: <20260709135846.97972-1-panchuang@vivo.com>
 <20260709135846.97972-3-panchuang@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709135846.97972-3-panchuang@vivo.com>
X-ClientProxiedBy: SN7PR04CA0048.namprd04.prod.outlook.com
 (2603:10b6:806:120::23) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AS8PR04MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 13e8d145-0e1b-4207-737a-08deddc7359a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|19092799006|1800799024|376014|366016|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	efyC6X29ZkK7qnhYq0yLbM9BBYCVyM7pV+yKQVjd0qSGDycs7oCl/JLM0eFTNrgyP9Rq0EiX2RSwslLdeXPprlyYXlFPuHRnl0obkU5kReCeduZmv0J8Zye35GVYY68AWE/xO753PcJ/Yl4VLTNPmoPRCErmNS7/UjvsNl7pIkET/+L8sLcxZGbBFj1f10upjPRRWdZCqyLWpbn9njtSg4XPTPBNQXGNTKmaRR89SZFgRx+LpIs2hqmR+fRY9Ckwl/oIpZ/w98gl9QBiKW3ZNcFmXNlSduRH9h9sTfThSunCdc8d+8xeoNU5dfPs0rDltszktW37oB2GovYkfivMgRMbN1JJ4Dug3qLcApvEHXIeFEoXUOkLgGGG5ioBwN/TQ0B1JCCLi41HVr+QATNC1xGb9ICyOWbfM+Q0BgjNlZP98t08HCRv1q2bkR3b1mH8Rl1VhVqZXliqpseIoDHNU+KBCWpfDkq01j1Ymm/ZtFzy0ntb79gzeGGaQBbODTySZVBKmrgAjXedmdN1ZUxMeEo8gYZjgvUMLVAPS+TNB1lV+ucQ7CcJqUJwCMu2h3YYm2fEjiGyydkiBWW9uOm2ZlfwhEWB8XZxC4gPx7h7hBiE6Yd3gBDnjJJMNZ4J5UzlZSMGgf8OmAfyi7Js/x0MaRYwUlIbB2qZX6kDQcoykxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(19092799006)(1800799024)(376014)(366016)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l/qFsy41yU6+PotjV6SM9RP7CZoK+Kie3v12SRRmoGAZxtdxMMCnxRCF0uzn?=
 =?us-ascii?Q?7qkaUyJN1M4/VT7XaGDl6LHFSZHNgdapIaFPN+fFIX7jJVAkBO/420KP1gR6?=
 =?us-ascii?Q?yx72B7divZtBNuCAScWxvSFlc7u6+5jNLxJY3QP7graNKqLTkl3+/NVuRgxe?=
 =?us-ascii?Q?Ka2neNQBNwbPCYmnj012eEVWz9gMOR1xg21bYEQOw6CQky70R3uOOmGWwytJ?=
 =?us-ascii?Q?IkKI6ugoeL6WQ6CUtCtGDPaoX2X3dADjhUIovH0hJXoPyTvuyLUHnZ/HefOa?=
 =?us-ascii?Q?DSMEJ8eua6EawAt4HMPbCrwx01Z9WYlqfkGpzL1jHLc21PMlgG362Ug+CBzb?=
 =?us-ascii?Q?eQK313qH97GC3BIF8mQq7ZFd18rmbUAcEH+xGKi6GoGQRr63KC+fHaZuBVRu?=
 =?us-ascii?Q?oQqjicQdgNwfV6YEqz/jQ6l6Q/WakajXlb3aSFuAzDcCAKzlWmo3PB+iDJsP?=
 =?us-ascii?Q?VFY0Z8R7HacnhUOVXTKzcFdh5OeZ0dBK11L4OTvUhF5LjZjQfwQkBGkMG7Ei?=
 =?us-ascii?Q?+O56+N6t4+57hU8HA0PD8s9X0y9C3QRuYZq8CGPPNki4r2Ii1GDRbFaHBMJB?=
 =?us-ascii?Q?Ij9WrJPU7wkipRJIMaTxP0YOeK49MkK9vNdy4rfM0E6acEyU2cklwj06w7kG?=
 =?us-ascii?Q?2BtDF/kXJs2M1YGNc6wFOuZSgX+gZ+QEMUTUUnOvlwWAgFxvyUMJOEvDSug+?=
 =?us-ascii?Q?lbRaDNA+ohog1w7Kwo5DLYgreusdZN38AQDYiwlqwVwTUvnoK383leXUO3MK?=
 =?us-ascii?Q?9scT98SusIathKXXl8ygAmCShsdgXtwBA7OAsFEAqUFe6XlnTeIqFRjD/tmU?=
 =?us-ascii?Q?rLtF09hd61G0zoFWHq7IpPqSUkuf1OeNbfrlqXeWDWXL8+M9yKFq/HSsQUf6?=
 =?us-ascii?Q?fPARwYUFR71+Sf0j5jv7YYPwUte06Hk/7fCL9L6ivTS9JzY0WdnUsTR+jCuY?=
 =?us-ascii?Q?Fa+NGsXQ44FyfvaMtsPtCC2jXaU7IfTVSFBP4iucOh4WNo4W3L9SxVIdht8O?=
 =?us-ascii?Q?j6LlNZs+xzU6xfXgkN1DyVR8/9qeaYF2yUsh2wvXShm+wRqD2fNXjAHnsheU?=
 =?us-ascii?Q?dUBj/2YTKvf89JTWi1taHzlv8U8SABbs2zKceZPMtUiYjV/8/FK8Oed9NbDA?=
 =?us-ascii?Q?fcRxMCFq33Jm2U4uSUH2x1Mz2iJ4JD2zLBwuv4YFYE4YpVHqLJI3MPj7Xp4V?=
 =?us-ascii?Q?2qzaWSEXgRscMtV7VhrtrbIjSHaynPWHo1nEULITg0rn40eBNEnLtyM6kFrH?=
 =?us-ascii?Q?Vp+kPiawJFXpblqwBoLUjRoq+PCvMvD4W8gpR81KB7xKe3oOFcQrytoojUVO?=
 =?us-ascii?Q?XJ4YWY5/uEnfNYiXkJlppeBBN2HYF1BKPq6rbdi0MIEDLsrphkdSlGrtcJss?=
 =?us-ascii?Q?CiFSs6AIr56DiQmUUI6OEMZTVQkFf4EK1D161MAxNnwG1Od8fm+1H0BGeU6Q?=
 =?us-ascii?Q?PJTPGK8Tsr16AjJBvuu3UmKbU3tnKl8GXfOBluzMQFcXl0smjzVgHgle5UfG?=
 =?us-ascii?Q?fRZuDnvCJdqP1Mxh7xXEr/PJLWf4nF+t49/Bc04BSVJ67nR648RzV8vgcKtL?=
 =?us-ascii?Q?wSg6r0I31J6AjHjZe9ZtxJOWJpAB3vtWsct1xe18Hs5Dd4oMnYmx/9vl5o1f?=
 =?us-ascii?Q?rxiusB2ePHlpdJtVwId9bh6hc2KxUkf9z9mYujjPhr5+RIx+wN5QJFGKkC8k?=
 =?us-ascii?Q?GkiTK+cZ/qdfoo/WiTarORP/JxiTJU4OP8C519x7WsQHoA8mbriaJgfnCdB+?=
 =?us-ascii?Q?GTpq7pe7EHoGEJ4LVvItRf7prfSmAIQaNhogEedhtk2estbI+juo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13e8d145-0e1b-4207-737a-08deddc7359a
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 14:34:40.4405
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9PsWtrmhfxeae/pxe44lPyfJK7HhUKZ15ZHImawXgh2i/TV2UzwLp/Mwtrafz1/+YnLNj3wWxRqJ2Qp26Ij6G4qdxUSoXOP8eMkHoIjUjBnXfWKg86W6nlkFIJs1xSg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8344
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:panchuang@vivo.com,m:vkoul@kernel.org,m:Frank.Li@kernel.org,m:dmaengine@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-12232-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@oss.nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[dmaengine];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,vger.kernel.org:from_smtp,oss.nxp.com:from_mime,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vivo.com:email,nxp.com:email,SMW015318:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 791607328A7

On Thu, Jul 09, 2026 at 09:58:06PM +0800, Pan Chuang wrote:
> The devm_request_irq() now automatically logs detailed error messages on
> failure. This eliminates the need for driver-specific dev_err() and
> dev_err_probe() calls that previously printed generic messages.
>
> Signed-off-by: Pan Chuang <panchuang@vivo.com>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/fsl-qdma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/dma/fsl-qdma.c b/drivers/dma/fsl-qdma.c
> index df843fad0ece..7f0d69b99289 100644
> --- a/drivers/dma/fsl-qdma.c
> +++ b/drivers/dma/fsl-qdma.c
> @@ -818,10 +818,8 @@ fsl_qdma_irq_init(struct platform_device *pdev,
>  	ret = devm_request_irq(&pdev->dev, fsl_qdma->error_irq,
>  			       fsl_qdma_error_handler, 0,
>  			       "qDMA error", fsl_qdma);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't register qDMA controller IRQ.\n");
> +	if (ret)
>  		return  ret;
> -	}
>
>  	for (i = 0; i < fsl_qdma->block_number; i++) {
>  		sprintf(irq_name, "qdma-queue%d", i);
> --
> 2.34.1
>

