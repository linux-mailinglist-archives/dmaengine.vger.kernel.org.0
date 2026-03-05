Return-Path: <dmaengine+bounces-9282-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPBpIRatqWn+CAEAu9opvQ
	(envelope-from <dmaengine+bounces-9282-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 17:19:34 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 933E921553F
	for <lists+dmaengine@lfdr.de>; Thu, 05 Mar 2026 17:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CFCF83008D22
	for <lists+dmaengine@lfdr.de>; Thu,  5 Mar 2026 16:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F7A3CF662;
	Thu,  5 Mar 2026 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UoTgnlRZ"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011003.outbound.protection.outlook.com [52.101.65.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282323CE4A5;
	Thu,  5 Mar 2026 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772727414; cv=fail; b=VkNWEleJ+HNuJ+/2dGae53+75y1Z5Nch4nmFTJwdr3+Tl2UAh/inWiatJHXXI6rxZZ2Ku1DH/qoBIn5gtPgXpIKH6xixGR3mQMoR1PgU1L3pbBx03ggx45Ex6QVxmDZMAVv2KbpJL9ZKDFpnLOdf0u6njwkZd5tXVUAXfjri8hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772727414; c=relaxed/simple;
	bh=7naslfmRV7xzD3JaAazZ1Yb3Eiq8lC/iGJYclng0F74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P+878rHRs9mngj9/pZ//KdhxinTEVHHq/XodzIlViz8PxdUHelzAGKaqgnrm6SSHfOSJ7qPxOIWtrU57jGOyk/6/3nhKJwBheJ0aEP56YZlnFFCtwb+VBdCT+Arb/H/AcGrG9yA2/e3G0fKRyCPxIHvTVswCsx2OIAahueeX3NI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UoTgnlRZ; arc=fail smtp.client-ip=52.101.65.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CrBYkNCRNDx7qwe9KeD7D1uw0TvZ7ZTG+86SIgZx8WpclB4EQJlst+Q0HHvJCugCWO/5vYvJPqpFNpWIRRiDpHUzu5/p1HD+LLxoP3poXvJbMSG7rOCecLaxMAoxvz263j88Jn4sGL0ehryxkIQpUyS5NjG9dKExzGQOKSkYs3wE/O+BI2cmgVKCOLfxwJBjeAk4waPyPOysHx1P0Cqg/XSTVLtj910Qc/0w0gjLifrocfWjR7taAZYFm0Hs7fgtXj1l0tU5myLlR6St4m6W99GJKGb3COhxqpVqoRWirFnIthQ7ctvFlzlgP2d54B3YxiRChkI2Bl5eLsbAvHMoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UguG3F9WbH0cTZLDlKuoeL5LnyqjqyOWFgujgljKLmU=;
 b=opq/34vFqRqAemNMbA554bolbCvg/5pBEmennsh4WmDTQuJCZhg8q1d9Z27uhDqDgh5WodS3L1HyNEcWvUWPb6HJ9UoyEPYCtoQHcR32UlLwk8c2KJOq90RvtRPMRuI/sm8efWxlpNJcxankyzsoZvr+KjrPcfBr9AsN2KxXONyoI+qqqPaWckL+EVQfWv3jzqnajUs9qB39Xrx+lxyJV7NZKASV03pOiowsit/7IZJMswC+3Mj9PBNN5AHcPanup6l/VcUjaTVdlESx26GJXS4Oh7eMckzVzcV+cu+69xvg3+N7FRr3cjL01viP6kzOuWzSohPZJ0ofgHV3WOxiyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UguG3F9WbH0cTZLDlKuoeL5LnyqjqyOWFgujgljKLmU=;
 b=UoTgnlRZ3TxZjYfHfNqK+SAPRNGtoWHJULcXv6eRv6mqjiykHnjgxUD+fB0vmdSoeMWDoJXJC1uY+GFmhy5e2/iAYelTIPLGeo4a6NdXZSfSV6wkHyxM0rWvrAUGogywCYHxrmizRz7AOGTVrGHAV4fjzOdvvxOWc69ri0qHXBOGq2bMB/2t8QUfROQ7luul5HOcnC+X25D6sPhNhX7UxhMFi/07TXxB06l5h93B6yQF/A/GO2lTOFbv8oqtEz9DDBOcMc5Ck+1CCsEqEmKu5oAGuI0s26fZe7tIh1R8m29a1/WksEQjFglOA5iFCXju0X5dhN+0d2qiFKP1ZCTabQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DBBPR04MB7722.eurprd04.prod.outlook.com (2603:10a6:10:207::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 16:16:50 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9654.020; Thu, 5 Mar 2026
 16:16:50 +0000
Date: Thu, 5 Mar 2026 11:16:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-amlogic@lists.infradead.org, dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH v5 2/3] dmaengine: amlogic: Add general DMA driver for A9
Message-ID: <aamsa9Dj6I2kas6H@lizhi-Precision-Tower-5810>
References: <20260304-amlogic-dma-v5-0-aa453d14fd43@amlogic.com>
 <20260304-amlogic-dma-v5-2-aa453d14fd43@amlogic.com>
 <aahUTp3T6QWbZiaz@lizhi-Precision-Tower-5810>
 <501fe36e-a3b1-475d-ad79-8b6523fe95e7@amlogic.com>
 <aakDyNdKhXdh-bnH@lizhi-Precision-Tower-5810>
 <7ee33032-586f-4b6c-8bd8-d55a18ed923e@amlogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ee33032-586f-4b6c-8bd8-d55a18ed923e@amlogic.com>
X-ClientProxiedBy: SA9P223CA0020.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:806:26::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DBBPR04MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ebb776e-e360-473c-22af-08de7ad29b76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|52116014|7416014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	oSbuEaDyQ+ZpLJ4uIAIiDBNw/IzXeGd2vc2Y99mLRp/ReFvjpuZifOYvpvgoxvN4SHLi6tQSeOLQMz+9HXUMMY0v0U/Al1koTxK3lDbS8+Bxmq/WewEwktvBCLFEPAPq8zMzuFCvJpK9/Ow31NJpNfZ/EGgFNA9Tu0DQ2XzltJv3/V5eSw0DvcKZCSnGy9B6aObJ7DAevvcG0aEqcoe9fEkTzX/tvNfkp6xqz0F+2Q9lCHXwsMupTNah+YH0PwJ50pwiqALyzko5FO9hDMh9lRLZdRK+rUCsxao1z3z5isTfmWFxuAKMviJiSGtaw6sivgJcG2VUkVhWSMCpjpJmokp4eKOQbI0Ebt5Tr6sqjIobsY43Xc4ovcO8wyoiDGRbBKrXB0TYG4QVqz71OQU8IECgSB5H5+RGynye4DcaBCEVhQj6PHQKgdFbKYWyKT2dNdZlsbxefnq6WOciLgWLk4T4LbwSW6/7zDooRzKFQQelXLQMfVHv/D8nsPJ4uPq6GGhnFLlU4N0y7AYFwxB6F/kVsiPsGZurGT/pA18HHYR/rtn29CausJw/8s2TbVFKFlT5XeHTpuPj69B0pazQ9/CXR2c8CqMomxfp78HeKYOcxHYDwEylRfP66OJ13wMml85xUgpb/E60mVDaKI1HF5BQ2Tgx/PAJuGahPVaT27VOv9yUFY+0ILi4P5TDzzNlzGurOx6QGnPjqEuLpC6TfznX6Szyo2NDdAGgjPqapcEAeNCL/W0yVJjhT4geeoparSpne5vRT2wQCp69X8H/AlwkiAH7R42F/v4tVGTpcJE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(52116014)(7416014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IQ8VivVBJmTMG0x6kpwSY99ctKFmUbVZnEUjqwfEm+URziF8c0AYbA3CchIl?=
 =?us-ascii?Q?PvnsGuuin8+Q+zXcV5KXF3hQkVPLMXBeHkidhMZouOMJa1p0746GQ0qa0RAx?=
 =?us-ascii?Q?5V8LMCsgRBTBX7TKE6snMwjBanWGiL47z+Pt4sI7ZPWIQtj/qZPAaVS7vnhD?=
 =?us-ascii?Q?KJljBtTOY13Z8+L5aql5c+YgIOgrWgNVqPK2W00H+mgOdpyeaXO/A4fUtpkK?=
 =?us-ascii?Q?l4vO1uAwQtINPejCjh3jclJCiXDVwFae2kYzSftVrGMdIYMNwGROG5kE+B7i?=
 =?us-ascii?Q?xTQ+Wf3ifQ8pi0776Zgj4twCNWafO37n2Uk3p3QFfi6iyb02OdIzYbHgsXgy?=
 =?us-ascii?Q?6NfOrHkbB/NjKmuH7GSqArajoHSh7MQNPHP39EI9bG67OrYViiJPYl9dlKuz?=
 =?us-ascii?Q?+Jg16dT1xMq+019Ic9XgDe5MRbgQ0L/aucO7hrBKVC4PxMnoH43cybKSyXSO?=
 =?us-ascii?Q?loFsjDD68eIMXOeVKkGQoC56Blfpfe+itnLOMYLWLT6kdLZSn7laFtE+rwUz?=
 =?us-ascii?Q?hNAtT1h7ea21FfCcWqs1xMXSdMaE6rhf9lqzv/wbobBkZcN9gaVkELLmpIX9?=
 =?us-ascii?Q?BoXMm0cZVX4KjmLZ444gq4z2XCzkIBmEoMFA2C0xHxg9RdK2XiPwSAyzxguT?=
 =?us-ascii?Q?jUQpqEOy5AUsh3mX8V/pVEH1Qi22idp1Q6UiVtf1wvvkXnlzOpltZwbh8NGf?=
 =?us-ascii?Q?nwyxSIcT4n7h5gOLNz01gYzABjmFXTnaj9JJwosrXNUmy0TrQTja4fBTiERT?=
 =?us-ascii?Q?4/M0dgvVhEoh1yc7dQ9BFFWAsDBiyX2jjCy/yi6kps0zQtzyJ0o+eTLoH1z7?=
 =?us-ascii?Q?i+fY+NJD/QGYkjd8zQv2ZUnf6abULxLQFlBJjuVACi9lntyO0DCNDV7timGT?=
 =?us-ascii?Q?nRP8tYAauiBsGd1jpzFHBzmRU3fQHxfHeX9wKxBiAtYwIu2D21OZtN/b/9x8?=
 =?us-ascii?Q?8w2gWakc9iFAjjeese/n1vJgeurQ6qT43dD2RI45IZU5HmgPDukBhuJj6P3T?=
 =?us-ascii?Q?sZn1tRTlt0A1GRnaZbAUo3vxGQM6Zqm4s3nD1NDe3mQlT4AtB87otrp6JAeb?=
 =?us-ascii?Q?sz33xbthctxGnMOxRm/SN5qZWR4LoXYIJ39xT17ad5h6cLxKLqRZVFAdeAmk?=
 =?us-ascii?Q?CDak+D34olHwLbRD5t6SXLkQWoWcicIF2zJxOP4EvEHlzM9V+lCjA9pnl200?=
 =?us-ascii?Q?x7/TU7+A830l6e61J3pWS28tIyrbupj8S8+px614Xxjif0pvO2T6KOiPvdyZ?=
 =?us-ascii?Q?jRnKCu/8KuIAKL4WuImq6fvYS7UFt6wsrGlmRvIB5nHctAo7ieZIGBqmTmG0?=
 =?us-ascii?Q?bio5bWAvHI1t/H3efL5FBvkO09VQaaYtjfO8diJByseA7vYyjv5WHeLF/byZ?=
 =?us-ascii?Q?s1iTepl+0JCI9T0dHHKVJaIGXMomksW6/gUg5PLF5Axurfiup9joe6URT1Mc?=
 =?us-ascii?Q?swcMsIocpeZ9RXVwpxewIOOdIUtSJ3BnjL8Ljc2X50duF/f7TqHcwNvoyNeG?=
 =?us-ascii?Q?dnnfZOcnid+5xqqjcZRqghc3DQkvLymB+kHxs1hbtQUD/oxhtD9asEewSda5?=
 =?us-ascii?Q?AobpGstPmD86TvdLVIN4bqhMlOOJ1HhrJiPY22e0QcSOg9B2lSShl3VRt5F0?=
 =?us-ascii?Q?jzy8O5XgNpH7pGIFzTQajDhJLYHnfKXyJCHnt+9ROqT2g5DiGFelxbN+fEHR?=
 =?us-ascii?Q?OwPorXhvn9v0vTPPnudj09fIDQSF4N0OKd0x/L+qGOqnKUbM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebb776e-e360-473c-22af-08de7ad29b76
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2026 16:16:50.5001
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q+ya11xoxYVmV17GfbPZ9EEPLhGIT8AQKXvV2Phy77kPmBEGedQSgJ9T9E0UTc3B4ChYyE08qwIBUfVr2jCUVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7722
X-Rspamd-Queue-Id: 933E921553F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9282-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 01:21:27PM +0800, Xianwei Zhao wrote:
>
>
> On 2026/3/5 12:17, Frank Li wrote:
> > On Thu, Mar 05, 2026 at 11:35:15AM +0800, Xianwei Zhao wrote:
> > > Hi Frank,
> > >     Thanks for your review.
> > >
> > > On 2026/3/4 23:48, Frank Li wrote:
> > > > On Wed, Mar 04, 2026 at 06:14:13AM +0000, Xianwei Zhao wrote:
> > > > > Amlogic A9 SoCs include a general-purpose DMA controller that can be used
> > > > > by multiple peripherals, such as I2C PIO and I3C. Each peripheral group
> > > > > is associated with a dedicated DMA channel in hardware.
> > > > >
> > > > > Signed-off-by: Xianwei Zhao<xianwei.zhao@amlogic.com>
> > > > > ---
> > > > >    drivers/dma/Kconfig       |   9 +
> > > > >    drivers/dma/Makefile      |   1 +
> > > > >    drivers/dma/amlogic-dma.c | 585 ++++++++++++++++++++++++++++++++++++++++++++++
> > > > >    3 files changed, 595 insertions(+)
> > > > >
> > > > ...
> > > > > +
> > > > > +static int aml_dma_alloc_chan_resources(struct dma_chan *chan)
> > > > > +{
> > > > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > > > +     size_t size = size_mul(sizeof(struct aml_dma_sg_link), DMA_MAX_LINK);
> > > > > +
> > > > > +     aml_chan->sg_link = dma_alloc_coherent(aml_dma->dma_device.dev, size,
> > > > > +                                            &aml_chan->sg_link_phys, GFP_KERNEL);
> > > > > +     if (!aml_chan->sg_link)
> > > > > +             return  -ENOMEM;
> > > > > +
> > > > > +     /* offset is the same RCH_CFG and WCH_CFG */
> > > > > +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, CFG_CLEAR);
> > > > regmap_set_bits()
> > > >
> > > > > +     aml_chan->status = DMA_COMPLETE;
> > > > > +     dma_async_tx_descriptor_init(&aml_chan->desc, chan);
> > > > > +     aml_chan->desc.tx_submit = aml_dma_tx_submit;
> > > > > +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_CLEAR, 0);
> > > > regmap_clear_bits();
> > > >
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > > +static void aml_dma_free_chan_resources(struct dma_chan *chan)
> > > > > +{
> > > > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > > > +
> > > > > +     aml_chan->status = DMA_COMPLETE;
> > > > > +     dma_free_coherent(aml_dma->dma_device.dev,
> > > > > +                       sizeof(struct aml_dma_sg_link) * DMA_MAX_LINK,
> > > > > +                       aml_chan->sg_link, aml_chan->sg_link_phys);
> > > > > +}
> > > > > +
> > > > ...
> > > > > +
> > > > > +static struct dma_async_tx_descriptor *aml_dma_prep_slave_sg
> > > > > +             (struct dma_chan *chan, struct scatterlist *sgl,
> > > > > +             unsigned int sg_len, enum dma_transfer_direction direction,
> > > > > +             unsigned long flags, void *context)
> > > > > +{
> > > > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > > > +     struct aml_dma_sg_link *sg_link;
> > > > > +     struct scatterlist *sg;
> > > > > +     int idx = 0;
> > > > > +     u64 paddr;
> > > > > +     u32 reg, link_count, avail, chan_id;
> > > > > +     u32 i;
> > > > > +
> > > > > +     if (aml_chan->direction != direction) {
> > > > > +             dev_err(aml_dma->dma_device.dev, "direction not support\n");
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     switch (aml_chan->status) {
> > > > > +     case DMA_IN_PROGRESS:
> > > > > +             dev_err(aml_dma->dma_device.dev, "not support multi tx_desciptor\n");
> > > > > +             return NULL;
> > > > > +
> > > > > +     case DMA_COMPLETE:
> > > > > +             aml_chan->data_len = 0;
> > > > > +             chan_id = aml_chan->chan_id;
> > > > > +             reg = (direction == DMA_DEV_TO_MEM) ? WCH_INT_MASK : RCH_INT_MASK;
> > > > > +             regmap_update_bits(aml_dma->regmap, reg, BIT(chan_id), BIT(chan_id));
> > > > > +
> > > > > +             break;
> > > > > +     default:
> > > > > +             dev_err(aml_dma->dma_device.dev, "status error\n");
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     link_count = sg_nents_for_dma(sgl, sg_len, SG_MAX_LEN);
> > > > > +
> > > > > +     if (link_count > DMA_MAX_LINK) {
> > > > > +             dev_err(aml_dma->dma_device.dev,
> > > > > +                     "maximum number of sg exceeded: %d > %d\n",
> > > > > +                     sg_len, DMA_MAX_LINK);
> > > > > +             aml_chan->status = DMA_ERROR;
> > > > > +             return NULL;
> > > > > +     }
> > > > > +
> > > > > +     aml_chan->status = DMA_IN_PROGRESS;
> > > > > +
> > > > > +     for_each_sg(sgl, sg, sg_len, i) {
> > > > > +             avail = sg_dma_len(sg);
> > > > > +             paddr = sg->dma_address;
> > > > > +             while (avail > SG_MAX_LEN) {
> > > > > +                     sg_link = &aml_chan->sg_link[idx++];
> > > > > +                     /* set dma address and len  to sglink*/
> > > > > +                     sg_link->address = paddr;
> > > > > +                     sg_link->ctl = FIELD_PREP(LINK_LEN, SG_MAX_LEN);
> > > > > +                     paddr = paddr + SG_MAX_LEN;
> > > > > +                     avail = avail - SG_MAX_LEN;
> > > > > +             }
> > > > > +             sg_link = &aml_chan->sg_link[idx++];
> > > > > +             /* set dma address and len  to sglink*/
> > > > > +             sg_link->address = paddr;
> > > > Support here dma_wmb() to make previous write complete before update
> > > > OWNER BIT.
> > > >
> > > > Where update OWNER bit to tall DMA engine sg_link ready?
> > > >
> > > This DMA hardware does not have OWNER BIT.
> > >
> > > DMA working steps:
> > > The first step is to prepare the corresponding link memory.
> > > (This is what the aml_dma_prep_slave_sg work involves.)
> > >
> > > The second step is to write link phy address into the control register, and
> > > data length into the control register. THis will trigger DMA work.
> > Is data length total transfer size?
> >
>
> Yes.
>
> > then DMA decrease when process one item in link?
>
> Yes. When the link with the LINK_EOC flag is processed, the DMA  will stop,
> and rasie a interrupt.

Okay, so dma_wmb() is not necessary for your case, you can omit this one.

Frank
>
> >
> > Frank
> >
> > > For the memory-to-device channel, an additional register needs to be written
> > > to trigger the transfer
> > > (This part is implemented in aml_enable_dma_channel function.)
> > >
> > > In v1 and v2 I placed dma_wmb() at the beginning of aml_enable_dma_channel.
> > > You said it was okay not to use it, so I drop it.
> > >
> > > > > +             sg_link->ctl = FIELD_PREP(LINK_LEN, avail);
> > > > > +
> > > > > +             aml_chan->data_len += sg_dma_len(sg);
> > > > > +     }
> > > > > +     aml_chan->sg_link_cnt = idx;
> > > > > +
> > > > > +     return &aml_chan->desc;
> > > > > +}
> > > > > +
> > > > > +static int aml_dma_pause_chan(struct dma_chan *chan)
> > > > > +{
> > > > > +     struct aml_dma_chan *aml_chan = to_aml_dma_chan(chan);
> > > > > +     struct aml_dma_dev *aml_dma = aml_chan->aml_dma;
> > > > > +
> > > > > +     regmap_update_bits(aml_dma->regmap, aml_chan->reg_offs + RCH_CFG, CFG_PAUSE, CFG_PAUSE);
> > > > regmap_set_bits(), check others
> > > >
> > > > > +     aml_chan->pre_status = aml_chan->status;
> > > > > +     aml_chan->status = DMA_PAUSED;
> > > > > +
> > > > > +     return 0;
> > > > > +}
> > > > > +
> > > > ...
> > > > > +
> > > > > +     dma_set_max_seg_size(dma_dev->dev, SG_MAX_LEN);
> > > > > +
> > > > > +     dma_cap_set(DMA_SLAVE, dma_dev->cap_mask);
> > > > > +     dma_dev->device_alloc_chan_resources = aml_dma_alloc_chan_resources;
> > > > > +     dma_dev->device_free_chan_resources = aml_dma_free_chan_resources;
> > > > > +     dma_dev->device_tx_status = aml_dma_tx_status;
> > > > > +     dma_dev->device_prep_slave_sg = aml_dma_prep_slave_sg;
> > > > > +
> > > > > +     dma_dev->device_pause = aml_dma_pause_chan;
> > > > > +     dma_dev->device_resume = aml_dma_resume_chan;
> > > > align callback name, aml_dma_chan_resume()
> > > >
> > > > > +     dma_dev->device_terminate_all = aml_dma_terminate_all;
> > > > > +     dma_dev->device_issue_pending = aml_dma_enable_chan;
> > > > aml_dma_issue_pending()
> > > >
> > > > Frank
> > > > > +     /* PIO 4 bytes and I2C 1 byte */
> > > > > +     dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) | BIT(DMA_SLAVE_BUSWIDTH_1_BYTE);
> > > > > +     dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
> > > > > +     dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_BURST;
> > > > > +
> > > > ...
> > > > > --
> > > > > 2.52.0

