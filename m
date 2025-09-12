Return-Path: <dmaengine+bounces-6490-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F79B5534F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 17:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E38817B8B8F
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 15:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57101F8724;
	Fri, 12 Sep 2025 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Iagq9pLi"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6447928373;
	Fri, 12 Sep 2025 15:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690347; cv=fail; b=pOnQC+pL5vdiyjk11yk48TN4YLXSapHPeWVKc7RrFCkdQPI87YxZpeZYjLk+eQpB7jSuO5xDHQQL7IniliKuYpCbWTddXAvcmwBNC7D6c8mM5LXmHKi3/S1Uph30bR483OyB1zkVE6k543a/0UhmE+tH9AFN3ovoiHoLIfiwl7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690347; c=relaxed/simple;
	bh=XUThciHPGKe/ttzwDld4rL64akC6WZYpcm6KvaDfBZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MG7s0lyO0IBJe2HZOaOGULtIQKiztGyexET9QXMSEzxg5LaPGsFNqK+XEaBZGi1kJQOF/huzvAXJvy+tGWSCIbQobYcPOAlKzXqkM8wj9WOVNmiI3iM9pcMJqGjAozikDup5NfHrcL6tWQRxu5m8DJJ8AY1E/8admuGdAS4I5II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Iagq9pLi; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UeN1zZrIG4FTzvfW0wsAdFz07+2vne5DD0lJWZmEma1gSHziKsa0+ypTXblq0YZneNQ3dZFCA9zq12AaxJalEqOML88qpZhuqqDreo1e0WHNeJXIb8nHpJY+irPpxK2BYji299CNtrTQ7wnNtow8XJSMDjKXygW1XjPRrrBYIcHxAV38xTaIc2IMqhjcHHM0E1CkrxFgiqKGfLMDrZ+PonDJe7uPsSF9jwA90LhXDUhyOo6Xn+2BNrRPRB/Gs1nSiMKICF7M3ZuLa3vBNpgJuD1wMx3SBzC6K431Ov0oxyh7M+h4ocakpuxJS62KjYKvTn91ZTn3ixJQbysXAE/Byw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8AC7uKL9IcHeorP14y+4WuK1EWrv6DoaCGXHai1hcG4=;
 b=BNOW19Hz6lzFd3pkoQhmezV7vFAW8jjwuKzd6IDHsAdoP6j4ZbB4Fz0Nv6qLMLyUcpSYi0ebdrQr+a0iOESk4wBinCbdM2rJSfyItdK5X7+tjSX5ip5HMCXgCTldDIjfQPGThOA1FIK5e3DvQPYW3x3xU+ck5yT3/81Bi60Fsx971V+rKCkU6LDAAEc49C5P+4bnDvofuB/iBrzednDOzIoIIfJWskfLMSUP7UxCGsMjgIXLkWQYiZOKRCWpPU4IM7WnkoYZnAF7CTta6voCEE+PR3U93Y0nWuQFB1V8JebGm8OTyuM/sz+4xqqmHwmWcQseWmDzzkINokpfHn3O9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8AC7uKL9IcHeorP14y+4WuK1EWrv6DoaCGXHai1hcG4=;
 b=Iagq9pLizkz0Jy7NmL8FnlAu+4llm/YsJwIuBo9r5BlzuzDiQAhmLikgpueOq45DW9wljCXbtN1lse82ZVV5cCN7BUsGc/FslOxq4HTAdbTX0m3HBykGTBkQjw8rII8GySNubrdkUCj+ggwW6alhvxVCrL4btSRO1cfS1Dp7FN/6rmHd1gWKOxf1lRCXI7LAbPqds+qtuqIPi+t6qCXfFuhUUQhFSxV7kfc11KysZa89Fto9ImXxuBSjb3BgXPe6E7mgnXtEFBvZ9IQyl/tGFYMnQcnbvTrWXdtxXhbXQtiH+NyDEvxDn1J9k82yowPGRsq+lkuxV8rOpFWEpXZ2wQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by DU2PR04MB8741.eurprd04.prod.outlook.com (2603:10a6:10:2df::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.17; Fri, 12 Sep
 2025 15:19:02 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 15:19:02 +0000
Date: Fri, 12 Sep 2025 11:18:54 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] dmaengine: imx-sdma: fix spba-bus handling for
 i.MX8M
Message-ID: <aMQ53pZQD4tj+GvN@lizhi-Precision-Tower-5810>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-2-d315f56343b5@pengutronix.de>
X-ClientProxiedBy: BYAPR05CA0044.namprd05.prod.outlook.com
 (2603:10b6:a03:74::21) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|DU2PR04MB8741:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b045dca-cd4f-44b9-ab29-08ddf20fb49e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|366016|376014|7416014|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WyND5XyazZutq9i75F8I58GwgdIUtj/OPRSsXx10V7en4oVbyVsogeudwzH0?=
 =?us-ascii?Q?oLSeME+7h6xLw00D7eKvV1pnLe5bMPuQXRBVdPfbLvTOXn/N0TmYoHQEuDWQ?=
 =?us-ascii?Q?uwXLfHnfdaySF4THYZ3pehdNaPxy98CnXkYY+oNUrRRY2woe+LpO8tHxqngg?=
 =?us-ascii?Q?k8FPojMJBZg6rJJ0DgeXbp9gUm+46vweQ4nOvuMN8VtXWhA14SfLPk12s+8f?=
 =?us-ascii?Q?c+WjHkgSK5BMapWA8FSxWDsZ79hVtiIKqe1njU0gNNQO9nhjzyCPa1wz75ho?=
 =?us-ascii?Q?BzHZYV7lcAzr53sWaWnhUGKRO0twLYJiSC6KTHITfCBgKELm26ZYVViCmrLb?=
 =?us-ascii?Q?SLhiP8CtSvkYN9rBMgZZb1PaOqC5R8VduOZFOcDSCTwEx5Oourm9rFBA1ZSh?=
 =?us-ascii?Q?u59Vn9SoTbSNSAh4TpXeiflLpoBivEarW+yTJiwp/Iok3VOpSQBwoFKuEj1l?=
 =?us-ascii?Q?eVoRSil9BJUsiAhHab8DcJpPPI2IgmFEzGOdA3aAQsmiy7nzVh4YcWPIHV6R?=
 =?us-ascii?Q?geyd6BV/qQPbEXAs4f828g0YfiMPuu556Fc16IU45259h99AiOjzfJdMtmFe?=
 =?us-ascii?Q?K1gkq3TMk5Fk0bWNZjZ5NsQVmfBxowhXxqXJM8rQ2pNOFAlMrkTtLlLY9EYd?=
 =?us-ascii?Q?bSbaWnNmtAU5O/PanMYegh2RsSxLFybC/S0gcGOavuuHxpaDDvnS62hZ72Tq?=
 =?us-ascii?Q?trrFSpdCfrKb54m5OcZ1E82V9yVcltIQ67M5T/xUNbChfD/Qd/6n56MIy3br?=
 =?us-ascii?Q?HmAVBrDNU3AzgQHIGjLdXJ1Gvwnx1nsOs+edwxGVSipDdHw0gq0gECyM0wMk?=
 =?us-ascii?Q?7Uowsq6eCFsImBLby1YcYb7IdMNkPRJq7ksQxy+wlf1izkVA8sjtizlW+vhc?=
 =?us-ascii?Q?pK02COEU3dFRorcgzYOYDpOWFdIjPI1JqU/S0qsuZx67qTccwQBA+xyjO4zc?=
 =?us-ascii?Q?px43OaiqQcFI+UpPmpVMKbNGs0pb0Z2ia6iwU7EfWgIP7hUpmD9FFJ2fcozu?=
 =?us-ascii?Q?xph1eyKXNEdKTBMgiflQFI1CT3I3qLbgcHWBWxTDQZljamZMr79i1O809oPe?=
 =?us-ascii?Q?JwF+e6dw+/GIcGAoEf6dCDzrfOqmLX8lYwHRcMvW4a1dYJOIUBv3I8lAbmWv?=
 =?us-ascii?Q?okH+D6bLjrMyFMa+TexVXQIMfCnFDC13dtnK41160VkOHa1f2byfV/L+xgUX?=
 =?us-ascii?Q?lO6CDbQOqJrGNtJy2b27nLx9b9kMZGXzJqp/vq64XJ/7MOHr6f+W/7CFlRKq?=
 =?us-ascii?Q?Y12siWxxYO5KyzEECuPkveTpR7/eY1s8fHNJpL/lZgbsAlgCEOH5+gVWgP0r?=
 =?us-ascii?Q?sAEa4Hqq6muekdj0VwKZJdaJVoAaVlT2gWrBOlVYyG0d8eqI9Uu3HEQ/07hA?=
 =?us-ascii?Q?926j6yIkeAdgOmAKm45gi66AxZU6YK52rvrCX2hmImWQk+iq5IeuYPLm5AnM?=
 =?us-ascii?Q?UgGLoNls1SqhQyJA8b9UOmIMON0bajiLBbyZ1WMRyoOTnWh9PP+bSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(7416014)(19092799006)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F5DR2LeDDjLxuUC7WnxP16L0/qn3H8WKF/LFnFmaqY6TaOA0EJsFcgl2TIVP?=
 =?us-ascii?Q?5oGR60bASZMv7W4FDrttrJfz6ZcIzcijTUmqMJY2NFh5nzoUUGiAVF3Z4ITg?=
 =?us-ascii?Q?GLIWuSLQoLMkq0YfqLX+68HCSsMCEWoB52NN6CFCyIKPtrPDZzdq9QMWC7AE?=
 =?us-ascii?Q?JPUYgzPHTCRk9orpmqexT1sa2huyd+mcSIAegFsosU97yOaIX1jRXVczs63n?=
 =?us-ascii?Q?QT1BocaMPxcZMiZg2gdHIN/UDhnAEShfLvTc7iruTPwWiTi1fQIannm7ms5S?=
 =?us-ascii?Q?xlQfB+h/yjYujnd2SdUODxgi6ROwrEMuZ4eVUDxrArF38RvByl+jETxYbyaf?=
 =?us-ascii?Q?8W8uMSXrUc7XgVODpHxAwIdNfhWCLMlgA7FvgoCMUs/Kclg4IdVkYcIKqY/s?=
 =?us-ascii?Q?Q40MjQ+GDnMJw0x6JK4fxncGRHTyfz16fVHmA5HPrK8DQNvsrOB5BOpLFXJ2?=
 =?us-ascii?Q?UKsmp9Hmj1AAGF/k/faihDaqiCYj/1C2OhF1FUZTQ0AHlQp5sLFB7UdFd827?=
 =?us-ascii?Q?PyOw2jcmJ8iNVRhFZnncGoIuCUKj8Nm7byiJt/+pEQzdFJ8RctQ9cZvAVFq2?=
 =?us-ascii?Q?Rj5U4U6r6tVBgZZcVwYgCHINYYyD+mB9Hw1mJu1xCq71DztLYBENoZRowb2U?=
 =?us-ascii?Q?6jCmr5r8lmgTqCY/DG2xlNm6Ma/7XhS9U/1ogyCvGQ5HmpzYe2pVVpypdq0h?=
 =?us-ascii?Q?TNBru6XQXixOAMuhS7e/30iwPQhXvshN1XksQTNzmOiZV0H4qcF/r3WQ6tyX?=
 =?us-ascii?Q?we0xKEo/SvTnA24/sEbEC30VTtLGlpZ7K4vK4TXIy4xCpNGPA/JbuhbqvIDN?=
 =?us-ascii?Q?wrSvVsEqHUDnUMoptYjnbWbtNgRNkMNZaoBMf+ksKgzyDrjPGRYhvHD0MVDm?=
 =?us-ascii?Q?jfpvlpIKZYhoY2EnEE1SXUIA3eBJ+Yn7ksvO+AA5w1ILIxRa2Rb8dDgASHMX?=
 =?us-ascii?Q?93apHXm7esbF/9LwyLLj/Snj0H788U4TS2AB+M1SG0Ep/y9CIp4WWYXcn2Lw?=
 =?us-ascii?Q?+Qzq03HfB/W/czsCjVGi1eyW2Ro91WOQ9hTvnCksm982d54cRlPJnvtNVm2I?=
 =?us-ascii?Q?fvro6E1cBIcd9vfZRvQfnaYq62nuXIU4hvb74Tdoe0X+Cx+T3dC7Ja0Bx3M+?=
 =?us-ascii?Q?GThetBTgxwBgVf8vZEsFVr6ML2rrCM0YGLe+zz1By+cibxAS1Pa8qwUSRkQ9?=
 =?us-ascii?Q?kyjQVispAJzCJcpCrYXX5vhFjmGYdNMvbxWtspaF6Aki+2VTwr252fIl2nya?=
 =?us-ascii?Q?D1LIcWlZ0crqng2lnKnzltjdyM9UjrxUMtF2yu5Pa+00LUorlNDaIW4RlN3Y?=
 =?us-ascii?Q?x98CnkNazLKJs4gBF4+mg4/kHcquN6oRplCuh3JQfQRBHUFmz5HK/I3hR50J?=
 =?us-ascii?Q?PyToj77PxFgEkv86LMhCPdBKUir1oJymS421l5SSOG6YZvL/gY0jmVdrDwbA?=
 =?us-ascii?Q?NCwNhvL008BflfJDSlvRQU8qBD7ze4QY5AT1bwr2DapB5xPU4xhsg6S+3CFO?=
 =?us-ascii?Q?3b+yZMB5ymxbqsSzASUXJfdTrFoaMP/7PKgOhVtjvW4CdDdYrlfwoQYToT3V?=
 =?us-ascii?Q?BoFqwGdz74NQYOFytfwwSkJ4INOHISbvAeB7nzKq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b045dca-cd4f-44b9-ab29-08ddf20fb49e
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 15:19:02.6210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rxjhx3i7CXuAxzDbo+IfCZJdXEKpGt0CGvEtiWcLqhV3cNp4ub+LCJjBNlfiwnLTTdnCS7zyROEt3vlQD/8CDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8741

On Thu, Sep 11, 2025 at 11:56:43PM +0200, Marco Felsch wrote:
> Starting with i.MX8M* devices there are multiple spba-busses so we can't
> just search the whole DT for the first spba-bus match and take it.
> Instead we need to check for each device to which bus it belongs and
> setup the spba_{start,end}_addr accordingly per sdma_channel.
>
> While on it, don't ignore errors from of_address_to_resource() if they
> are valid.
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

I think the below method should be better.

of_translate_address(per_address) == OF_BAD_ADDR to check if belong spba-bus

aips3: bus@30800000 {
	...
        ranges = <0x30800000 0x30800000 0x400000>,
                 <0x8000000 0x8000000 0x10000000>;

                        spba1: spba-bus@30800000 {
                                compatible = "fsl,spba-bus", "simple-bus";
                                #address-cells = <1>;
                                #size-cells = <1>;
                                reg = <0x30800000 0x100000>;
                                ranges;

				...
				sdma1:

};

of_translate_address() will 1:1 map at spba-bus@30800000 spba1.
then
reach ranges = <0x30800000 0x30800000 0x400000> of aips3

if per_address is not in this range, it should return OF_BAD_ADDR. So
needn't parse reg of bus@30800000 at all.

Frank

> ---
>  drivers/dma/imx-sdma.c | 58 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 40 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 3ecb917214b1268b148a29df697b780bc462afa4..56daaeb7df03986850c9c74273d0816700581dc0 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -429,6 +429,8 @@ struct sdma_desc {
>   * @event_mask:		event mask used in p_2_p script
>   * @watermark_level:	value for gReg[7], some script will extend it from
>   *			basic watermark such as p_2_p
> + * @spba_start_addr:	SDMA controller SPBA bus start address
> + * @spba_end_addr:	SDMA controller SPBA bus end address
>   * @shp_addr:		value for gReg[6]
>   * @per_addr:		value for gReg[2]
>   * @status:		status of dma channel
> @@ -461,6 +463,8 @@ struct sdma_channel {
>  	dma_addr_t			per_address, per_address2;
>  	unsigned long			event_mask[2];
>  	unsigned long			watermark_level;
> +	u32				spba_start_addr;
> +	u32				spba_end_addr;
>  	u32				shp_addr, per_addr;
>  	enum dma_status			status;
>  	struct imx_dma_data		data;
> @@ -534,8 +538,6 @@ struct sdma_engine {
>  	u32				script_number;
>  	struct sdma_script_start_addrs	*script_addrs;
>  	const struct sdma_driver_data	*drvdata;
> -	u32				spba_start_addr;
> -	u32				spba_end_addr;
>  	unsigned int			irq;
>  	dma_addr_t			bd0_phys;
>  	struct sdma_buffer_descriptor	*bd0;
> @@ -1236,8 +1238,6 @@ static void sdma_channel_synchronize(struct dma_chan *chan)
>
>  static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
>  {
> -	struct sdma_engine *sdma = sdmac->sdma;
> -
>  	int lwml = sdmac->watermark_level & SDMA_WATERMARK_LEVEL_LWML;
>  	int hwml = (sdmac->watermark_level & SDMA_WATERMARK_LEVEL_HWML) >> 16;
>
> @@ -1263,12 +1263,12 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
>  		swap(sdmac->event_mask[0], sdmac->event_mask[1]);
>  	}
>
> -	if (sdmac->per_address2 >= sdma->spba_start_addr &&
> -			sdmac->per_address2 <= sdma->spba_end_addr)
> +	if (sdmac->per_address2 >= sdmac->spba_start_addr &&
> +			sdmac->per_address2 <= sdmac->spba_end_addr)
>  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SP;
>
> -	if (sdmac->per_address >= sdma->spba_start_addr &&
> -			sdmac->per_address <= sdma->spba_end_addr)
> +	if (sdmac->per_address >= sdmac->spba_start_addr &&
> +			sdmac->per_address <= sdmac->spba_end_addr)
>  		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
>
>  	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
> @@ -1447,6 +1447,31 @@ static void sdma_desc_free(struct virt_dma_desc *vd)
>  	kfree(desc);
>  }
>
> +static int sdma_config_spba_slave(struct dma_chan *chan)
> +{
> +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> +	struct device_node *spba_bus;
> +	struct resource spba_res;
> +	int ret;
> +
> +	spba_bus = of_get_parent(chan->slave->of_node);
> +	/* Device doesn't belong to the spba-bus */
> +	if (!of_device_is_compatible(spba_bus, "fsl,spba-bus"))
> +		return 0;
> +
> +	ret = of_address_to_resource(spba_bus, 0, &spba_res);
> +	of_node_put(spba_bus);
> +	if (ret) {
> +		dev_err(sdmac->sdma->dev, "Failed to get spba-bus resources\n");
> +		return -EINVAL;
> +	}
> +
> +	sdmac->spba_start_addr = spba_res.start;
> +	sdmac->spba_end_addr = spba_res.end;
> +
> +	return 0;
> +}
> +
>  static int sdma_alloc_chan_resources(struct dma_chan *chan)
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
> @@ -1527,6 +1552,8 @@ static void sdma_free_chan_resources(struct dma_chan *chan)
>
>  	sdmac->event_id0 = 0;
>  	sdmac->event_id1 = 0;
> +	sdmac->spba_start_addr = 0;
> +	sdmac->spba_end_addr = 0;
>
>  	sdma_set_channel_priority(sdmac, 0);
>
> @@ -1837,6 +1864,7 @@ static int sdma_config(struct dma_chan *chan,
>  {
>  	struct sdma_channel *sdmac = to_sdma_chan(chan);
>  	struct sdma_engine *sdma = sdmac->sdma;
> +	int ret;
>
>  	memcpy(&sdmac->slave_config, dmaengine_cfg, sizeof(*dmaengine_cfg));
>
> @@ -1867,6 +1895,10 @@ static int sdma_config(struct dma_chan *chan,
>  		sdma_event_enable(sdmac, sdmac->event_id1);
>  	}
>
> +	ret = sdma_config_spba_slave(chan);
> +	if (ret)
> +		return ret;
> +
>  	return 0;
>  }
>
> @@ -2235,11 +2267,9 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>  static int sdma_probe(struct platform_device *pdev)
>  {
>  	struct device_node *np = pdev->dev.of_node;
> -	struct device_node *spba_bus;
>  	const char *fw_name;
>  	int ret;
>  	int irq;
> -	struct resource spba_res;
>  	int i;
>  	struct sdma_engine *sdma;
>  	s32 *saddr_arr;
> @@ -2375,14 +2405,6 @@ static int sdma_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "failed to register controller\n");
>  			goto err_register;
>  		}
> -
> -		spba_bus = of_find_compatible_node(NULL, NULL, "fsl,spba-bus");
> -		ret = of_address_to_resource(spba_bus, 0, &spba_res);
> -		if (!ret) {
> -			sdma->spba_start_addr = spba_res.start;
> -			sdma->spba_end_addr = spba_res.end;
> -		}
> -		of_node_put(spba_bus);
>  	}
>
>  	/*
>
> --
> 2.47.3
>

