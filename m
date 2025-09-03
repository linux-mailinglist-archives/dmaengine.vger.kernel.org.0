Return-Path: <dmaengine+bounces-6367-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F487B4241C
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 16:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E465C7AE02D
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 14:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300D930C60D;
	Wed,  3 Sep 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="YVW/5d79"
X-Original-To: dmaengine@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011017.outbound.protection.outlook.com [52.101.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3237E220F5E;
	Wed,  3 Sep 2025 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911242; cv=fail; b=VT4K87WYIUgbQYMKXvqS88JDMz9gZG8zoxIjxbe7YlvSzco2GCwD9aAoHD5l45xkrkREzIX74tmi/kJX371qGszqQyfcfryo4uxSBWVJ99yyT3o9iQULEejSIIfPIccCcpUBE3niU+3aERZ5bsFm1+bpECBWK9OX6OZrx/yV2CA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911242; c=relaxed/simple;
	bh=l9WBE+ybbZGTg1GSdXIdp8SmtcNaQgPVrnEO4lLFZmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=feTkH/QjKbv8ql/bo21+xLF21nEFXJ8E2vsnV6Jq2fUqqVrl8ZMJ1kosz3RuzGMU88yVAP95k1wjAtYuGEdphu6nV3ZvxbkoxZI9fsG2G4FT2DQyELJtS4CIgdPxzdlkmZzoJWz8G46QReEVHZwU7NsYhSwZpB1YYkz8tiVYbYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=YVW/5d79; arc=fail smtp.client-ip=52.101.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r9GrxHh+qr/rctFa/yhpEP2ZtsPhpWNt9OYpBQhLEFoKfRjOvvcG/rzkyccN5V/ZPR46a6Xsr3mNPh9ZYucvRWJwTorcBqkqfYwKpUT2HwrY29UoUL+BG7qurclPz5WawB/DU5FKOe6C5LnTVPHBy7Ixo/q2T7aLrGJdrH3ehZybNrgYZGquw7KELAfmRIY7IxbLsi1J+G7LYn63pYuNQLKbUbUB3I/o3QeO2xqmqXNFWRgPYx24w7Wag9TPr/ANEBi2m7wZhIBjQL33k2uYEjAnrJDIwQJHsijNFcHDBfG5D6W8KYoZUW9FHP6f0jMGmFIbO1/gGJJ52syFRs6Xmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VR9dQ74jgUYiWfX4Bvhxb6gfZoXlFITbSeK8GJ6tnkk=;
 b=Tspxv2p9NObgUMcEeL6ZlcB98C0tU5Ff6p8YQ2Q3cFy03Oa5t3KAfEwpYwmq/SnWqzlFCbmGKfGBf/4Xp3D9MJgTQq5SjKJBIt3ToHIz+/0pbehXycAedDjXpAcL8BmDX6HUBgI34bXXIpP1Y0H36znugo3P5j9kOu652zo/29gqnVANDqAf1VuYqkWhfwT7coWLbcHMPuzfpUpJZijXNN6NjGINeoFRip/CiSwLkWU/l0zGAzvUg1q3/onTI3cnoICNr4RKkflEte+vNsMf8ozaBmljM/ACNPdNQceeHt05uPUUBYzPe/VVbYURUVJYex7Hz086qwXGWh0AA3UfnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VR9dQ74jgUYiWfX4Bvhxb6gfZoXlFITbSeK8GJ6tnkk=;
 b=YVW/5d79L8+PFr//ZG7mITivC+Zf5Kkl0PkD4y62i0gn5tghKeIAdD3KDh0ZQn/uzdkXCdMutlfIxKSiyua5vhTnBzAA7WTVWy04EsR/1k3a9ft8xJ8VbiX1dSolb+AFG08eKgaZt7SJ15EkUEcPQEDWoPfWFbNa9AVyLCtFEqwUNcZYzfExiRgtwea3JZOIor087inFx0SxhgtKa8g19bSicgFYihRtCyZ+zYk6+4oEhWw3WhusGetSm2oqt5ebpgsWyfIgbL5OY924qa9l8tPFm/ojor2CfEUs320vra+ODQtOwpZFzdnNfB6VVYUfVcn49piT3M6RRk0dIUR6TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DB9PR04MB8233.eurprd04.prod.outlook.com (2603:10a6:10:24b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:53:57 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:53:57 +0000
Date: Wed, 3 Sep 2025 10:53:48 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma_device
Message-ID: <aLhWfPjnZZpKr/w1@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-6-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-6-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: SJ0PR05CA0200.namprd05.prod.outlook.com
 (2603:10b6:a03:330::25) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DB9PR04MB8233:EE_
X-MS-Office365-Filtering-Correlation-Id: 443ef2cc-7147-470f-3f4a-08ddeaf9b56d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x7wNom7EaQrvo2IM/g33r94Byr3ODEqe17UI6cP8XGU2jnuudjAf9mVIkWtH?=
 =?us-ascii?Q?V7tacs3XIZUkhUDpeUfrNLPLOzDcLy+gYxF7bBVDIs8Sq2VyBPGcy9JRcJil?=
 =?us-ascii?Q?SwMYs+p7L+rSzhJdGOC2diZpuou45gOe+OQkAuUEP43TO4a2bX2auKNg4Tjw?=
 =?us-ascii?Q?gxfDqPhd1G33Aq0Y6sRwWsYuFHBHu6//Xlvx4qPxLeIAEYG3du1+xrHaEmjR?=
 =?us-ascii?Q?Su5eYjRWLtVQ788RNzIL0xJwp4wTTVE1TC8Q1YSr5cQ6/uTndoRNprBPOwUl?=
 =?us-ascii?Q?oqjzMug7UAXKjicwZHW3RWiP3IZwXMSMTpyybw50F0ZUE01MQQQ9MeTwN3pO?=
 =?us-ascii?Q?THUwGYaj6tylS8nMchDYW2jtt7PKiP+LiPgLiKQFIJCgjmf6cRs/xSP4be9F?=
 =?us-ascii?Q?Gzi0UmfH/IvaoGAxUom+/grgU5UcaK1vpxNDst2X7xzOTqy6lnDMHWm8dbKI?=
 =?us-ascii?Q?ETt2puOiD7fQdsMV85MJ3omOVgnz1ajGFkEn5mwsnnBoIpPweHdIDbbpdEan?=
 =?us-ascii?Q?FKUQ0otVgA+9CitpJeSuOT+HO63lPJaZL08puw8CeSQfIO5jB74swYL3ikkD?=
 =?us-ascii?Q?ijcyZGcM/u2knaYvkfokNA9BLsQAabjQI57EjdE5rpioeUAWaZhpjCkXsppA?=
 =?us-ascii?Q?Mbo5mK7tnWjN6sXLUxD22Y43xKhYz6tz4BXozewKGVEFyzzTibUeChyB9NEu?=
 =?us-ascii?Q?qQBAiIHd0Z77BCm4QNf+mxWmBHdXMt48bWlI7GWI9U1qBBg4yweuuUGyIAdi?=
 =?us-ascii?Q?V2wrXfSN9TQ70PN8pfGG57sv1RV4kxRnNyyd+58sXXrXoBFCcn41mSPdHB9m?=
 =?us-ascii?Q?SlO3kpH2y5ah0CNj/JLfInbTisoPEFNI6owesU2/47sK+j3iqLib6n8j59kM?=
 =?us-ascii?Q?3IQcHTukyuRViS3hKt6Qe0c63MzVLZp3lFmeZjOyvuN76Z3c0OYCGfd8yJ4P?=
 =?us-ascii?Q?H6Jel7yrOJeQPUQqePEJtPDzVuFbDn5i1+zLJ0OvIA8pjceBERtwYes9WDki?=
 =?us-ascii?Q?8dNbRmvhUx1XF5TSqtC+f/Iocb7E6Yfoh1OIHq+CahMsT3GBy1aW/3GEFEmM?=
 =?us-ascii?Q?uIOw7ROKpXvwxWbOfcR6HAn3adw+vlbSCcihJEyAhP6c27DBy5ZvN16+iFDK?=
 =?us-ascii?Q?ZFEp3PWnP+LrX1yTxB/7wOZPQXyxnUANTQo09Zr/17dh414bCQb1FRrZ4veP?=
 =?us-ascii?Q?HrvpPf0JikSNoH93+B7CnXqxev+vg4XcTDg8k9mPWXIDwoPEEptKek7nOffM?=
 =?us-ascii?Q?iEYojmoz+6fvViqtcAbw2IXYGhmm13Ov4DfxPjbdtcc0JzbTdDfy4RO+HPsb?=
 =?us-ascii?Q?5oD6nkoxTBg2/5V3+ng2/lQT82HBFJbLo4PILe9D9A1mDsYx+UaO3J+tIRmi?=
 =?us-ascii?Q?X0WHdt6NLOG10JLjzyLsDkzZh/wpmMoyYTWH3eQPsh4UIw/wuMKyreFwQ2Iw?=
 =?us-ascii?Q?olStzaZisvvWNZY5vBOi205zRWPcQjAC9Ebm16D1jlJW4bfcInBT6A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wkdakxeC1t8Qdmm9sciRWCsFkD2FZ44lNP7vZPluP35s64UHRwg2qk2INoFZ?=
 =?us-ascii?Q?6Rrsd2aWgAYFXXEBywhR157MMU1cCSmDDN+oS8davrkIDCvnvbP06cKiKFrp?=
 =?us-ascii?Q?aqoTdv8eUz8ylYZjTsVb5NE5tSjYcDFeflzfBIEVR87Rrd0H4isEEKtPXRS7?=
 =?us-ascii?Q?8apTVbTjJVN50hmDCeyGyhRoeSBYH/q4lQB2g1v6MA4JLj6RiIxQKrN9k2l6?=
 =?us-ascii?Q?MRFz5gbXbZTF96PjjFWnRhHCiDutkSJ2+jqTnPlXfFCWtqJzDAKFpgmvr+6q?=
 =?us-ascii?Q?vS5qV3S8evjBXO2xg92MTwwonM+GAedhaoL96NnpQ8ogt6wc/ph9RU0CvX21?=
 =?us-ascii?Q?Pbc9RsniU/al6zyKHiee0bJHHJQBjBRm4eDwBY+tIWMbEBIO7VZfyAZ8rPVr?=
 =?us-ascii?Q?lamJBZ+mLmyYr6W1yBzQfxcSiq/ajsCo/ziH98aYjVmgFS60RiIR+VywPrG2?=
 =?us-ascii?Q?PBUeR2EkZUq6CDbzZxEfq9P2a5HZKLjKNPDh5/eeNzujuy7/UTkwNVQrEp7v?=
 =?us-ascii?Q?LXKz2nfmT2WSN36tSz1FuoStrpA5NX37dfhHTVIsmqJuEn7eosCLWLoaCoB/?=
 =?us-ascii?Q?tY1rb3DRGCIu2pbWhf6cE3pZQ1CDF6dGV/dZgqIqqeOUnxCCEYCsrLFSQqbr?=
 =?us-ascii?Q?Q4a/PgF3U6l7bRg0dZFJ0HIEr8PoNkqu4yHCUgVOY2H/4DBBxDNg6hYtNTvQ?=
 =?us-ascii?Q?Nqmz4P1pozQCAPSjCw1rkInUn7xFf2ML3G3gxVj5FSr7cClZe8xkBxU39Fje?=
 =?us-ascii?Q?Zg9mMYjxii+b9C1ThOLPTGtBmhS1XOWbXaeplQq8UWmSP+uYAoYIerK2kXzW?=
 =?us-ascii?Q?IVXZoc81c1BzKdI9ipioA/xdXkE8SoTd5/TsweyI474ntoWGH2B+wXBD/5hG?=
 =?us-ascii?Q?wRvrYn07yRXzS8iJZjOkpF7Lo5ZYXV0WxLx9aEWcTQQBSmSk+jt0uToEITro?=
 =?us-ascii?Q?Wj7u9bKw0nOHjB1yf2h9b0VzX3DPglrBCyF3eJtcyUvx55cVKZkhpsevAnCU?=
 =?us-ascii?Q?fGQFYMUKqL8VL3zL5yC+CXpmgThs4jBri35xAxoQLsLa0cpDxKh87GpriKdp?=
 =?us-ascii?Q?y+NZghisjRze3dfqQHysFyzODb3EDTpF/CCN0SV6txoOEbbz7fWJKx1q4MUk?=
 =?us-ascii?Q?8HQ5lf7bP8BcH094T8HnGw1k6o4gEArTC+XGAWW3j1mKunqgwVsewTdbTckR?=
 =?us-ascii?Q?KuW8D9ZmjKUIKEMbG0nSiLXyRDlsicFhK0ogSmI1P+MN7WSyGKBACgnMqCEd?=
 =?us-ascii?Q?GX2kE2zJm/XjbIQMiwuIBUidjS2WWLrMsJhw3EEKhKTsWGhmROsE/eYNo8JV?=
 =?us-ascii?Q?B0t3Pi3H5gMTrjjNclEWarq5yR0XaxoZPi0iJoLSRx8lYUBNy5ono53MYDZS?=
 =?us-ascii?Q?syajuKkYCAiU4IHcwXl3jB6AwiXdJmVrxP9poin/LyJxkJ2HV2WdWa3pK+Gr?=
 =?us-ascii?Q?CCpmYTEZj5LzpBnLgryufYuoOV4dp9OcKi9L7tb8gSYgdxXUbeDHkljtnxjF?=
 =?us-ascii?Q?VYz3XMTXguG8VyxHmQr2UA9FIvvXI9ZFEu1LdqpseU5QquO8fhcC+QO7AYFN?=
 =?us-ascii?Q?OnW6u9fVPWGLveqL3Yo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443ef2cc-7147-470f-3f4a-08ddeaf9b56d
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:53:57.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5x1P7R7ieQ6hOqOOWEeT1wEb4yBjeDxMJNuEjiXJmq5AHFrunXB/zG+U3IBPxw/w5VVUkTATrhbpWSqQ34x4Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8233

On Wed, Sep 03, 2025 at 03:06:14PM +0200, Marco Felsch wrote:
> Make use of the devm_add_action_or_reset() to register a custom devm_
> release hook. This is required since we want to turn of the IRQs before

turn off?

> doing the dma_async_device_unregister().
>
> This removes the last goto error handling within the probe function and

Remove the last ..

> further trims the remove() function. Instead of freeing the irq, we can
> disable it and let the devm-irq do the job to free the irq, since the
> only purpose was to have the irqs disabled before calling
> dma_async_device_unregister().
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/dma/imx-sdma.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 5a571d3f33158813e0c56484600a49b19a6a72e2..f6bb2f88a62781c0431336c365fa30c46f1401ad 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2232,6 +2232,14 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>  				     ofdma->of_node);
>  }
>
> +static void sdma_dma_device_unregister_action(void *data)
> +{
> +	struct sdma_engine *sdma = data;
> +
> +	disable_irq(sdma->irq);
> +	dma_async_device_unregister(&sdma->dma_device);
> +}
> +
>  static int sdma_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -2358,10 +2366,12 @@ static int sdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
> +

need check return value.

Frank

>  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
>  	if (ret) {
>  		dev_err(dev, "failed to register controller\n");
> -		goto err_register;
> +		return ret;
>  	}
>
>  	spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> @@ -2388,11 +2398,6 @@ static int sdma_probe(struct platform_device *pdev)
>  	}
>
>  	return 0;
> -
> -err_register:
> -	dma_async_device_unregister(&sdma->dma_device);
> -
> -	return ret;
>  }
>
>  static void sdma_remove(struct platform_device *pdev)
> @@ -2400,8 +2405,6 @@ static void sdma_remove(struct platform_device *pdev)
>  	struct sdma_engine *sdma = platform_get_drvdata(pdev);
>  	int i;
>
> -	devm_free_irq(&pdev->dev, sdma->irq, sdma);
> -	dma_async_device_unregister(&sdma->dma_device);
>  	/* Kill the tasklet */
>  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
>  		struct sdma_channel *sdmac = &sdma->channel[i];
>
> --
> 2.47.2
>

