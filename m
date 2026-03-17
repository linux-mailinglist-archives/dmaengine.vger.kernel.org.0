Return-Path: <dmaengine+bounces-9494-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LVBGlBhuWlsCwIAu9opvQ
	(envelope-from <dmaengine+bounces-9494-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:12:32 +0100
X-Original-To: lists+dmaengine@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CD72AB8DD
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 15:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E37D304D911
	for <lists+dmaengine@lfdr.de>; Tue, 17 Mar 2026 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E80A3E1CE7;
	Tue, 17 Mar 2026 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CyA9qqqj"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013065.outbound.protection.outlook.com [52.101.72.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AEF24A047;
	Tue, 17 Mar 2026 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773756313; cv=fail; b=oDwS4paxVd3lFQeQrKsdJQ9wx910Yj0omi79u5pkRjtFawXcuyhiGiIswjiWd2k2b8FqbgdCtGVRPems1XWiA89BdewE5D1RU9io86w4MMAyOr2p12ej6bxokxnMeK2AWuvHwJRRx/7ZJl3AFVXvsn37HHP7a8Mk5Ky1eGPk1Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773756313; c=relaxed/simple;
	bh=NiQTpk4nEsw5Sp3wzH9kctZwRFj7V4mm+B2Z27+fAi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=H4EWj/KSVGt0GtIdVe9Qwx6ZQccyn1TDZ0f++nzMLbQFoR929+jo5bKsxjj1XgRem0TzeKulmU8GfIX9kaISEUAv0uzKjYuLiDtaO2shd0X/r+ikmEkdZk3UMVYPb0fBDmH6zoxvoLgjoUuoW3C4o0oPPMUHVgpgt/Qffaz8vvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CyA9qqqj; arc=fail smtp.client-ip=52.101.72.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZCYrMT1ZxWGNokFK7beSbrH5WTce35wbm3WWH68JE5JCVlIxBHjnjAXvbMmZ7ujN6s4yplILOocTjtAi20LAhluRf1QNTo5/7qre6e6pQVg6HfylUZakl29yvI+j5B11Pu+t0tbac5pO74bZIqrOgDrdmvZCfibX+S/UDb1X2sQFrK4EEMHeIbaMwnB6k5X0gZivmudIf+EyXryFeaEYOOwdNf2zrRxcMQ8Ue8XVFKMiU3CULcKt1+SxmUom7NTiGb+NssbtFsXMYWy3ns+brgMfApo3UD6zJpIQLrDnbCJxDg9vO53F2dd3zyODAqQScmUxD3wzKrJRQdMJZfczA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5E1jnAvRkpbf9bKT7biVSPm7SGFmeN1VqXkjsSOq1o=;
 b=r2aRxAoIPwdZJpZfbdPifnyIyB7bJGSOeOkbtOLUAqHKgw1UGT7X+QbpAd7IwXOnUIkQTSqrNmqOPz8oHTBi7L/vIauNESTqa2YdD4BNVEY/3jELMXAQLnk34BtsfjN2l3kDmjk8DIJNnnQyNs987k42yyflBsoevu5UKcSeBkcGDFDGRkFOjJiTSRoNt6acK0wHMP5V/tpNbDBblKq1dffI20M2sFBloVo33p+6yPZ2aEU8LItt2eP891YfWFkNuvaljvRZn3tt+VZA1Ena2vn7CDvcDLOP9jnMHvkGd2pD0NBANr3ktNKOzODTO0G3LNx2+NX+xViSQl/xOBHOWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J5E1jnAvRkpbf9bKT7biVSPm7SGFmeN1VqXkjsSOq1o=;
 b=CyA9qqqjEGCi7pm/FptW+lPNBoc421LtWAmgvfVsolzjapQdbMUXcDmfj/8qKpkRHFX3t7EZ8bFkTftHmfyaesQS2yqfhq3w+JIg7Ae6wnkUaXvqlY3wOTDmfYLZ5GosC+EtmwBXv1nTeyhLN4wgKBMRKO154CM9EvscupiQrEQ94lGAM70OxdJ9dbq1fW76v069F0g9Scwa1qJXvil6eBqhFnKhIR14tiIS5CLv0GBX89UyJY0vOnUn1X9/FEicqWDmCZDM8Wdu5Pvo8rZANv3OdUhk0RHcwXDRiqBu/7cGJrbfe/DdW8HPTe2B4MQzsnRhjdhyVBti7GhNgSIJaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by OSKPR04MB11439.eurprd04.prod.outlook.com (2603:10a6:e10:9d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.21; Tue, 17 Mar
 2026 14:05:07 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%6]) with mapi id 15.20.9700.021; Tue, 17 Mar 2026
 14:04:59 +0000
Date: Tue, 17 Mar 2026 10:04:59 -0400
From: Frank Li <Frank.li@nxp.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v2 1/8] dmaengine: Add API to combine configuration and
 preparation (sg and single)
Message-ID: <ablfi0XHifttil3w@lizhi-Precision-Tower-5810>
References: <20251218-dma_prep_config-v2-0-c07079836128@nxp.com>
 <20251218-dma_prep_config-v2-1-c07079836128@nxp.com>
 <aa6pW-zpxnrZnfPn@vaman>
 <aa7cbL-B5sbjZr_l@lizhi-Precision-Tower-5810>
 <abku9bXxkZWUwOhE@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abku9bXxkZWUwOhE@vaman>
X-ClientProxiedBy: SN7PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:806:126::13) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|OSKPR04MB11439:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d2e412c-8629-4b48-5687-08de842e2ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|19092799006|52116014|376014|366016|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	FrWoeLlwLu05t9qgSGf2OSe64Qxw9kmUL6RNoD3E/kfi/FxEboXFLEqYBfD9xS8cf4jQmcGlmW/s495L2TnuuuUeTMZOStSRFdOoC8VqvR9p5PW9J6Ik/6doq+wXjspvvzKmvuiAQ2BJu0K8aTcuLR5gLdyqC5cd0RaTc/NnIEgVMkbfU2tr79oLfx6mWVYeVEd2W6y/Cgl2pWcOc+GYGoV7CjKao8pvShMThUUhFISrntLWUJDGxVdNsVBpcSJtkfYydKV5OuVS9RG3kegMJMQyR08BtWKBsBTHhB55FGPgkVr2Qqq1ThQMGJJYoR8wMcxWxDzD7NU+eGU5k2mhnHnv5d0rH9YjGgm3cC5zOPyOo/8i4xKywgi5xuerV2kaEB2MFlTofZQ5VzsYotYkZwGX+Hq5OXJGmlOnmmgc7fcAppVa3ioxZ00FkuAtFwUO6UcpQRS2UMdAl/inir0iaRKdoa4uefWJw+frrLYu5nd9SWirx21umBt9O4a3H0Vc7NqUt96VeQhSEqimG65kFjxF1D2p4oqD9BdhA7CqGhiqHC6VkmyB8Q9PMQp0HZMdHMxHQ0S+rUuogqi5VnmcmA+wYMjQBvGp3WJH8QvfvWe/12VqsLnyTVnx/RaEu96CWIS5D9MaMW3rYGpAQSwLuad0g/n66j5QowPypDtW7i3PLz+UwnN7JdTjSqocphrCgCLc+emTRjY590Sptz2HU3FNC7w6nfSbb1SCub7OgOItf0YbdLuzitxmA3/x+oZjwQe4/puwOfYlZtvEqtgV6OycnMrkgG+Q30dsGvK/iK0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(19092799006)(52116014)(376014)(366016)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V/oKvD+7vTssZw5ZwUx+b7y3WeDl6jWhJedIQG6E1H+SCopGBv0ehZZlzcp0?=
 =?us-ascii?Q?mhEgTGPD56fTu9R814i2YVtPwa/+Df5uvT8+Pz7xi1ppUq8X5Ce7Zs6Ae+Ml?=
 =?us-ascii?Q?fEet36krQrzKY3vizxSkD+V4fUd8yWc7kYNEEdBJq9vU6z0V9cUNHxqJI9ES?=
 =?us-ascii?Q?6xR147oNrF5UzXS2ZD9Zl9KUNOTQX3+POR3vWL6zfa2gYKMdwTRLI/0lW8Pg?=
 =?us-ascii?Q?hPVowSq1lGY3zaVIv0yUwVA+jrzZX+l5WvcBxL6CTIUsD49aqaS2P/Hr+9GT?=
 =?us-ascii?Q?Vc2zRfmGy8b29iRE3Ge3+0vIy7nditd9vwkyApAaebu4PhQG7FmS+9u/c0xX?=
 =?us-ascii?Q?/qKvnK1z5XIqOra2/+8AkIuR0TGS32qvDOLRFJ7PaKNNaGLwotlZ6lyGA4KM?=
 =?us-ascii?Q?pkn6aC86odhRvU1TmusN3HTg5wcDiG+abODfqLSWQuZ8S68CRbzwhUklNOxr?=
 =?us-ascii?Q?086AM0BbuJTS1Fx3IuP/ceKMsJlN0nidObe2zSWiboG/UZkwiTcQ2fOtuOzN?=
 =?us-ascii?Q?kEcH8NNQQxbXVjereuBKC5U5TZtkZ9Yu5R4eXHdQ32y2ZAz0B/e8ykQ2gP1H?=
 =?us-ascii?Q?rCfQX2dpj6djaQyRZbmMXkCYPZmudm/0btXnACIJTgfOW/fceUBo7rpIuGLW?=
 =?us-ascii?Q?U1wIyroOT4Lac7/ElZwaLSoELpl2jdgVRMFC+DWuMt2gK4OAKI/xzpIGfbhB?=
 =?us-ascii?Q?7vK2MPh3YL2e4yTWC68o9vgIfS8VIvMrAmwwUGblP8SCXYpImcVE9dc8YoWZ?=
 =?us-ascii?Q?K7N1g45AVPtmKnimJBVsqv3nk5AREQswSDf+mLUqKx5R7Q2Ct/5FTgZXF7pu?=
 =?us-ascii?Q?QA+BmJgmQkFLMg28RQZtnXbA/JrpDi/9SSTVn5yQ9V0i9dpkXM8J4eyzlNwV?=
 =?us-ascii?Q?XTzftnJ/7bJUOLWUnv/GaP88RfBMKqZLdFsi6+GXVSrtdZHZm06MMY4E0XOX?=
 =?us-ascii?Q?3zR7aU3C7aonk9Tz0BpqhTeIK+6fzKJwtgTVpZtga4xZXxN+HVZWlciHlENz?=
 =?us-ascii?Q?rpQPbXfzeZzzT6gIQjQHo8RMK8Cy+sVwDISGDY1FzfrSeDYu+I8phrVIzB1T?=
 =?us-ascii?Q?yNDRI1nkNVu8KtBnu3qZZhKhwUULB0QKREILBYCANYDo0AvuWGbUskKW1Bgu?=
 =?us-ascii?Q?jlP3+00oFT4A3BJ8Qvx/hIOPoxtqDwGRXmUeLEEeRNPoLEbjMr910gQYuye2?=
 =?us-ascii?Q?iosgOTZftBnolg08KANWV1NqfBhTP9URk2n447Qd57bNJdPVio9bjo78mtMw?=
 =?us-ascii?Q?F3qxGPbIjYC7m2yDSo618sqOslNdUaSQMZPzBp9Lt74NzpnoTXxw0SqboYD0?=
 =?us-ascii?Q?Wrj8UOkvZzLqrzKVmjL3lHCeGXVk5C+NkudLAILMUG2lTz6Gb9+IlVkb234R?=
 =?us-ascii?Q?J5/k47cizOVQG+d1eEGG2t7fXHiCm53twr5jM1X/iZqD9BjdBFppCg1R84Q7?=
 =?us-ascii?Q?VZaW0PYRKWZa25KY0eVCm721PFFt3uxlM9ZXLFLChmYzbLAcFT21OS1lajSk?=
 =?us-ascii?Q?aMHaXH+5pjZytKlAOjUFE1DZdzpuh2+idnZCHU6GUb0L4l06z5kTow4uS17b?=
 =?us-ascii?Q?vmBuQ2kyZZFxx9cw1pfYYIng61qBM+FUnvCBdpYekqvo2qkszy9klQXGbBpA?=
 =?us-ascii?Q?F3x9Zmz82h84Ppx0MA8dej1/chQ7nLAfxcKaZlGj/Z5e6fujFmKSwz87Gtd1?=
 =?us-ascii?Q?eshs9fm9SINgyu56qpbznvj835vkw851NObAQz9ykWR0B1Z6?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d2e412c-8629-4b48-5687-08de842e2ced
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 14:04:59.1716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: djQIC/EVqri4kl/CpJ/ZA0yraFmki59yiESA+LC58SN6abdB46/QnYPwS8BL18SQH7OTveZdRRzwV3qHnEnQFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSKPR04MB11439
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9494-lists,dmaengine=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[24];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[dmaengine];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:dkim]
X-Rspamd-Queue-Id: 22CD72AB8DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:07:41PM +0530, Vinod Koul wrote:
> On 09-03-26, 10:42, Frank Li wrote:
> > On Mon, Mar 09, 2026 at 12:04:59PM +0100, Vinod Koul wrote:
> > > On 18-12-25, 10:56, Frank Li wrote:
> > > > Previously, configuration and preparation required two separate calls. This
> > > > works well when configuration is done only once during initialization.
> > > >
> > > > However, in cases where the burst length or source/destination address must
> > > > be adjusted for each transfer, calling two functions is verbose and
> > > > requires additional locking to ensure both steps complete atomically.
> > > >
> > > > Add a new API dmaengine_prep_config_single() and dmaengine_prep_config_sg()
> > > > and callback device_prep_config_sg() that combines configuration and
> > > > preparation into a single operation. If the configuration argument is
> > > > passed as NULL, fall back to the existing implementation.
> > > >
> > > > Add a new API dmaengine_prep_config_single_safe() and
> > > > dmaengine_prep_config_sg_safe() for re-entrancy, which require driver
> > > > implement callback device_prep_config_sg().
> > >
> > > Okay to add API
> > >
> > > > +	struct dma_async_tx_descriptor *(*device_prep_config_sg)(
> > > > +		struct dma_chan *chan, struct scatterlist *sgl,
> > > > +		unsigned int sg_len, enum dma_transfer_direction direction,
> > > > +		unsigned long flags, struct dma_slave_config *config,
> > > > +		void *context);
> > >
> > > Do we want to have drivers implement one more callback. It does not make
> > > sense to me. Why not handle this in framework and have it call the
> > > respective lower level APIs.
> >
> > To avoid use addtional lock! suppose each API is re-entriable.
> >
> > thread 1:  call dmaengine_prep_config_sg_safe()
> > thread 2:  call dmaengine_prep_config_sg_safe()
> >
> > If DMA engine driver implement device_prep_config_sg, thread 1 and thread 2
> > can run parallel.
> >
> > If driver have not implement this callback, it have to use mutex make sure
> > config and prep atomic.
> >
> > https://lore.kernel.org/dmaengine/20260109-edma_dymatic-v1-0-9a98c9c98536@nxp.com/
> > show finial opitimziation result, which depend on this. If can't call
> > prep() function parallel, which will kill performace.
>
> Which seems to be 10% in your case.
>
> > > Drivers should implement simple apis and collectively the functionality
> > > can come from the framework.
> > >
> > > Would you consider revising as such. Bonus all existing drivers can
> > > start using this API, no change required for drivers in that case'
> >
> > Not that simple, some devices just call config at probe, especial fix
> > FIFO address and burst length.
> >
> > Call config and prep only need for the case, which need adjust src/dst
> > address, burst length or other parameter for each transfer.
>
> Correct. In the cases where config is done once they can invoke with
> NULL config. I would like the middle layer to handle complexities and
> drivers should be simpler

This patches already implement these.

If you don't like add new callback, how about change existing callback
by add config * and update all drivers.

Frank

>
> >
> > Frank
> >
> > >
> > >
> > > --
> > > ~Vinod
>
> --
> ~Vinod

