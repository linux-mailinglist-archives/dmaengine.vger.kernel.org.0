Return-Path: <dmaengine+bounces-6487-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72077B5523D
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 16:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25E53165BA2
	for <lists+dmaengine@lfdr.de>; Fri, 12 Sep 2025 14:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B171ADC7E;
	Fri, 12 Sep 2025 14:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BknV3wzz"
X-Original-To: dmaengine@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011038.outbound.protection.outlook.com [40.107.130.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4319D065;
	Fri, 12 Sep 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688585; cv=fail; b=DJ4bxVwJK01N0jyB+RdR4C1pzcmCgSVPLALyc1q9PUMidkpMgQtg7miH+62aICakVeTch976U783ZVv5x/wbSZ9Z+ovDNMDe7S3cPZfMNmoiitW/3/mjEUNEMwngokhvKTuu4Jv3SV+vo9mi8GRwCE+YTRUwhBwpStl6ksPgnNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688585; c=relaxed/simple;
	bh=/XyZROd7/NuAKnos8/eHhqHIbRi/k2hpmikaHBlEI9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iGKvcaePheXHRDW8MGapYRirEzUmFQBGBH0o84nVAxypuuJNhCLU4y3OB/ZaTrIOk7Q1sPpbSuT2j0uKhuXDaMaErPBfTndQ5NQxXsNTZ5HoftgxKFV8H1xD28uJ5dBPWGMvZZLszrGnTWu/BPoFDv8/Md+9LkICoCOfEJLb58w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BknV3wzz; arc=fail smtp.client-ip=40.107.130.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aDg9LgfiuAUbu0bd1WvJrCwu1VI6c/aM38NpMup9HtoH2AuZjMYRdhN9Y08a6NTfa8i9Lxcfnrmj0mLFXxHqDRH/0wIk510h6OtSaG5FiAhEcuCSWJwZUomKmVyLil3P+wm8kl7HCGEyzFgL8mSeWVGEWFc0NXCSHrCFFZZf6Pubps1TLkQevUuKoZTYuXiEvKkkpwLAQCIhRVHzF3zoulRmektsB0RXruGDmb3vOqnNvZRuBteYyhd2CPKW+Rs+amL7ef7gnopZbinHYLCCEEhTbgPjq9JKDA8+f8O0jiBh4a3t7BbSS9ttnN7q8c4USUBeXU1fnFi3e/mlBuUGew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jVnJENHKbgQ1J0mueH4vHl2j195vVwZ/hWwP5jD0u3o=;
 b=Be7WxZ0vLJ9w8wtwdPuI1el2GpBh3yDfxwtkh62K8S2ieKBJeCv7x8mOwyuWJ0AGEx+YNHWDfE2nCr0TuZ2ezljBn1N4dz/uSkOaRx+LxO1UWpsxiPprdAq5LYulzfVlsNzfN61bNDejVdYfiGFEwyumgtEekBurYXP7Waf0JIiegY+CxZmdS3z66MqeUVx67LKMsm9taHYm9aDuesIAFJSzcFOvDtHX8WAXbFMCW+lCv3YG3msL6L5uB8oBOyxQ2/ObalFkzxBHc4KqOFcKm/oaLMd/8aGmJMCZ8JIS683BeO2DFjXQUhd0FoGVWnDSYBuaOxEz7IPWsIWG5feyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jVnJENHKbgQ1J0mueH4vHl2j195vVwZ/hWwP5jD0u3o=;
 b=BknV3wzzphHK5mndb84tKdLEtd97x2zemzayqJd5JeyDwmOniNdRgZ9oEQkRCRuGctsOqS7OQl//71y42zpHkjivdb2b3HjVEWqoNr17eE3ocIKkP+V92D4ncReDbkoDMDY+/70xlhbZTiLcojCVgfXiQ2qQHlh7vBxtp+D33zyONWajoKT3j+CmiT8BwNvl2uT7TmCgLTG/Nvb6CwBcBWteER4ci2+GWU8Buz2fOY89pT8cTgcaSkgiBI0zyJux0LW4hnSUALd9vU4BKdgcRp4yL5N6RLXP8GncQTnyv8hoXUADJ/Fx2QCMEXOYTuZkM/2r9MSvfy4ic6xFBkGzNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AS8PR04MB8834.eurprd04.prod.outlook.com (2603:10a6:20b:42d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 14:49:35 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9115.015; Fri, 12 Sep 2025
 14:49:35 +0000
Date: Fri, 12 Sep 2025 10:49:28 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/10] dmaengine: imx-sdma: make use of
 devm_add_action_or_reset to unregiser the dma_device
Message-ID: <aMQy+Ocs+UWq7WoR@lizhi-Precision-Tower-5810>
References: <20250911-v6-16-topic-sdma-v2-0-d315f56343b5@pengutronix.de>
 <20250911-v6-16-topic-sdma-v2-8-d315f56343b5@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911-v6-16-topic-sdma-v2-8-d315f56343b5@pengutronix.de>
X-ClientProxiedBy: BYAPR08CA0066.namprd08.prod.outlook.com
 (2603:10b6:a03:117::43) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AS8PR04MB8834:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a07812-d7f9-4434-c6fe-08ddf20b9778
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|52116014|7416014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?McWfViZUsKCpXW1J7RAIIyATO+TDXFygmpLEWU1YcO9PbNjlMOEpJwFNFPc1?=
 =?us-ascii?Q?ZUJkb92BWMr8SZNfhLhFpM2wU7nHMty6HLTFDNBOiTFbgWsyvPJ10TJqRG4S?=
 =?us-ascii?Q?fccXp+dXWROjjMW+rIkixdEUzkKOC1jS8jHf6ZMPu9X4r3m38N5RBQO21qFi?=
 =?us-ascii?Q?A+GOq5fmV+x5rmaKQEcrHmn5ZiXMXXjKhw6CD6w/9ADD3DLG73K7SoTyH08q?=
 =?us-ascii?Q?VmHTNUur5ZOuPUeY5S1thaT7fMkLaJqB66YdHp78GX3nFjcQjkHgwG+8eDms?=
 =?us-ascii?Q?f68/IO1mXseBlazrnJBwAFUotWvj4YSX1gxWFeH7Km/ur14hc2HVKRRH9q64?=
 =?us-ascii?Q?hp15oZPpPQL9faaDyWWr56j8UFWd3zItoIqar42OMNx51tl9Oy3FnfqYS07I?=
 =?us-ascii?Q?28pamAutYVJEFcT7Sb138j/jNpaKFczYyzoJM9rH9VIT95awg/MYaAOBTWJF?=
 =?us-ascii?Q?LU+FrREGQ+S0+c4tozOvab75u6yYzbBxHYeC0ihecAOz9euUIqU0tU/PEbsC?=
 =?us-ascii?Q?fJrT9m2q/MPuSVmtNIuOOXHlBoTeXh/4QtQJnIHFo+3uBSSldf0YF/u0KBZX?=
 =?us-ascii?Q?X7AHrHBYjLdWeNANDCcKbhbAgLs+dx0/xuawjfsiXadxVkErtV9Pt7qWpldH?=
 =?us-ascii?Q?chqANSIC9/6YWk/w+KcQ/RGNrhIGSXYglnlDS6wnXSpP696kr0+Sgwdy+c29?=
 =?us-ascii?Q?zs8lwQmUmnCRXlpaDuqRxT29Vx9llKRiJk5lTkezO4upWw6Xw5BMHDKJGauk?=
 =?us-ascii?Q?P6RnSy03d/wXNvyMcZSbTR0A5iWxaUq7nJqrRo+sxGSos1LYcbPc9xVQqUpM?=
 =?us-ascii?Q?jlETlXj16j+Ic2N1C3iMWH2ZCJBKS+fMxEMbjjLskQPf3fbrWEDTp0tUmfnS?=
 =?us-ascii?Q?+dhDO+Dl4eSlbv4CICKqd3VxncD/mont5KY99FmG1nEQoKaOkYmFczc6ZKo5?=
 =?us-ascii?Q?YakGg5wWc5VmqrZNGcA0AhmSO2flR368Cxb07uUqOCTv/PdDhgzY0SBLaoBl?=
 =?us-ascii?Q?EnjoxxvwwQm5Z+DVW4m5spVRNePqRnJmdnONFl82gETkRrGB1SjbtxmNmEOl?=
 =?us-ascii?Q?A4WAZo5b3zg6oosHOFcQhSqv2bcCMQPUSTnLJn5HtgZWE6ATajop9wizL/Cm?=
 =?us-ascii?Q?nIVDmB99y6z3qtAJpBF4XA+WcMKu/iHM1PHnEdEwxu8aCipxnYwPTjHK7XQs?=
 =?us-ascii?Q?TY3qDBuWGas3wUyKljivP5VyQNVVoxNtU/PUCCAkz5KuIkqv001COmBEthDx?=
 =?us-ascii?Q?EFES1JmvqR/PFRuGUrKuXv/l/SRzwEF09m73DpqI8NIOcJTf/kLJWZ4trB1k?=
 =?us-ascii?Q?WDf/1wKOBx4sBdCOUA6T1w9msyftD6VcZGD5NWKNSOHacJUYLYFbuNd2RFUx?=
 =?us-ascii?Q?vpg2UGd+GxYYx2NOvY/3SOPd6/sDLZvCvsMrZ6yqIxyuR+e7LkjESyLeJ8o6?=
 =?us-ascii?Q?DOGDKDoXRuuYqDaxxFnhSntDGN4wrQc7xcTLQnijbJaMLVWanAFxCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(52116014)(7416014)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BuLlMQ33N5UsZEzzU1/Z8x2AbvXrCDgqWhjPBiy+ak1c4dmmS6cAulcKYjhU?=
 =?us-ascii?Q?vtfDou4s5fQORvOMIcmBRGIU9Ap5kesY0oSRxp1xoURWhUoSPH4Jmp4WAZYu?=
 =?us-ascii?Q?v50Opvm8n4MP3R8EmGbeIBEPWc6E7A2awKog7mRDU7b/JBy9MDa/OP6cdqVO?=
 =?us-ascii?Q?1DM6cCvY9uqL0b3ys82v1u6DWOuveUNmER/gRL57Hs29wESPNkW5gdSlLezm?=
 =?us-ascii?Q?XqWCsVQueyRX8YGYxR4IfLKh88FqMQc4jZQpg+kxVIs+BBMag6hmz6TUlIk3?=
 =?us-ascii?Q?P0H6Psm1novqTLHnrFrCSgccydILGkLd82pTPZJqopoxRUuR2RZzBT87JenZ?=
 =?us-ascii?Q?FliLOp4aaG7AmBTIsZ0kONNEVr/wChXOSQ3kOlyd6lAQeGniiatrpiU0NEaI?=
 =?us-ascii?Q?KSW63lJNNcN2Q3Givdo42tse47gC9sSD3yuViaCkbLsm31F/aHE1w812pDqc?=
 =?us-ascii?Q?YdSrPcU+ePKttWzeiP3Y4DXIdbrnT808WroY5tG6MUAKRCOEdmNhQBx5ULp3?=
 =?us-ascii?Q?coOctm0YRvOYQUHfP1u70h2EGmW7XzxnICHkcV5bcXncwugJ80QMX0O2SSmm?=
 =?us-ascii?Q?NlUvtboSa1RFuWDwHirMaPjNvDBjjTBK/F/UCki5t7quttLQ5tg4cyAbSf0g?=
 =?us-ascii?Q?yTQjWQo42JwmZJRwOzebPqqr223rQKQ4VvQlDeXXRsR3VcjBsMnS6vRo4ePZ?=
 =?us-ascii?Q?qRSLL/tQr0zYygz9zrYkAgRCx12YEAKL7++lb2RQVn0GKUKJYdW2FauLDfqL?=
 =?us-ascii?Q?6VDnoWyNCTydEmY3VgMuPskDCDau3ojOHT4WAQb3p1Q9Lx9ayJF006NNB07Z?=
 =?us-ascii?Q?MJvFnt78pIi2AycsvklnRurBiV0ttH135SgeGu8rLP/ewwiqzWxalk/jQ5xw?=
 =?us-ascii?Q?uhPpP0urUnuN6TwB35sMC0qWhe1MHTgmK46ACpP3Qxz5GcwBY7PJ5zMEQfuQ?=
 =?us-ascii?Q?DBpZLzqqnmnf+Ia1316L5srGLrW61BFrz2t3vTznfkheiosnAtpHp5hFvme7?=
 =?us-ascii?Q?7VdsHDZ5JnS6qeFcqnXRWbDpAMrAIv574ihEdC7AMt2eYoenm30vN8/3DLdT?=
 =?us-ascii?Q?h0EIjJ/ygeVKo1oVS52ehOtWzlfUzLQ02AROwmTB3OJHPL+ZgfJxQcSgvq8W?=
 =?us-ascii?Q?72U3VnObS0DFNJ51YiOYuQ9bISWRkiObQZx6LoPQvmXcu12g4LzPWW6DWmS3?=
 =?us-ascii?Q?XCzcCOPDTAiwMKWV9Rvy2+Ih3Uph9OeI1R3P9bUUBmxadPV8xdMdOs3AKxTl?=
 =?us-ascii?Q?TTYSB7b7F3S+ROqw311YSzbdC4aYNMa8akdoSfnWaAflzLrf5opMS+lFYekS?=
 =?us-ascii?Q?XOfc1oLWdDXd9vf3Q0ZEkkQwzHI4P0kjROwO5IyfLRqAXjbpUoZTAJsG6jZK?=
 =?us-ascii?Q?+yTCaXEJl+29LtdJ8DwBaAhURr6gs3Gp+V+Il2jmXBbLFfXqa9qKesgW/cM+?=
 =?us-ascii?Q?Mk+4ASCs6s1B0dmyYVEBW15QayC1dAqy6ivLU6591Q9tPet+vbBRrShk6Ftx?=
 =?us-ascii?Q?eQEPn5dZD2m0ktsH+JoffneuHR+EvzXhZlO+X/dfBsJmLYmXHM0bKBLIKcLQ?=
 =?us-ascii?Q?JtAdnQSeUn4SRZgQsEEC/2hnMIA5EEZF/UtNgAfO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a07812-d7f9-4434-c6fe-08ddf20b9778
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:49:35.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PVcuIPeNDzVMUM7UCaZeQZcG9RHPXN7CkrjfiYeNdoJpitJic/PZMc00JR3urd5pCN1eSHa6GfHO+/n9nyQDYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8834

On Thu, Sep 11, 2025 at 11:56:49PM +0200, Marco Felsch wrote:
> Make use of the devm_add_action_or_reset() to register a custom devm_
> release hook. This is required to turn off the IRQs before calling
> dma_async_device_unregister().
>
> Furthermore it removes the last goto error handling within probe() and
> trims the remove().
>
> Make use of disable_irq() and let the devm-irq do the job to free the
> IRQ, because the only purpose of using devm_free_irq() was to disable
> the IRQ before calling dma_async_device_unregister().
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> ---
>  drivers/dma/imx-sdma.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index d39589c20c4b2a26d0239feb86cce8d5a0f5acdd..d6d0d4300f540268a3ab4a6b14af685f7b93275a 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2264,6 +2264,14 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
>  				     ofdma->of_node);
>  }
>
> +static void sdma_dma_device_unregister_action(void *data)
> +{
> +	struct sdma_engine *sdma = data;
> +
> +	disable_irq(sdma->irq);

May not related this cleanup patch, I am just curious why not mask sdma irq
request.

> +	dma_async_device_unregister(&sdma->dma_device);
> +}
> +
>  static int sdma_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -2388,10 +2396,16 @@ static int sdma_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>
> +	ret = devm_add_action_or_reset(dev, sdma_dma_device_unregister_action, sdma);
> +	if (ret) {
> +		dev_err(dev, "Unable to register release hook\n");
> +		return ret;
> +	}

why not use dev_err_probe() her?

> +
>  	ret = of_dma_controller_register(np, sdma_xlate, sdma);
>  	if (ret) {
>  		dev_err(dev, "failed to register controller\n");
> -		goto err_register;
> +		return ret;

the same here.

Frank
>  	}
>
>  	/*
> @@ -2410,11 +2424,6 @@ static int sdma_probe(struct platform_device *pdev)
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
> @@ -2423,8 +2432,6 @@ static void sdma_remove(struct platform_device *pdev)
>  	int i;
>
>  	of_dma_controller_free(sdma->dev->of_node);
> -	devm_free_irq(&pdev->dev, sdma->irq, sdma);
> -	dma_async_device_unregister(&sdma->dma_device);
>  	/* Kill the tasklet */
>  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
>  		struct sdma_channel *sdmac = &sdma->channel[i];
>
> --
> 2.47.3
>

