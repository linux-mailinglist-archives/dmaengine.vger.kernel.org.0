Return-Path: <dmaengine+bounces-10241-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H8iM0eS+2lJcwMAu9opvQ
	(envelope-from <dmaengine+bounces-10241-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 21:11:03 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF3B4DF9D6
	for <lists+dmaengine@lfdr.de>; Wed, 06 May 2026 21:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11F2C300DDD4
	for <lists+dmaengine@lfdr.de>; Wed,  6 May 2026 19:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D458307AC7;
	Wed,  6 May 2026 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dsmf4xn2"
X-Original-To: dmaengine@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010067.outbound.protection.outlook.com [52.101.84.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B42E1722;
	Wed,  6 May 2026 19:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094562; cv=fail; b=bEboMjcqCXZCHCHjSZ5fZMIFLdnWVJbNCf10Lb6FF1vVkRivJCjI3dk4L6UDiVNDpI+QeAqcIZ3A1FlkCi5TQVCQ7hcQgJDLoBB9n6K0T6U8zO/d8nYAmfrsZR0ISA6yjGVC0zvdVWGI6+Hp1VEnck872Bdzdv7MufwVk3iabiM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094562; c=relaxed/simple;
	bh=+Joa39exLNKFUTICgwx/jkSheKd2DDalHK23dzacwuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KbThyX0uVpzQdde7E7AjdnRhe0gRovHlZeE4YW6nUDU/r53XQwViCy8PWgCuS9oyGHsu+Ah2VTfyB9fJI0jMOHJxUz7RZ1E8cnpVPt25e6sSxaDQ1x+pkV9ucgvkhNzSG6866hyfvjL+/7e0/cDtUTOYDTQk+Ts3XsHeRuRfIIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dsmf4xn2; arc=fail smtp.client-ip=52.101.84.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EbCVGQU1mTww6kfvkKN8H78NefSrpyKgo6HufISiUYEbbhd80fTNF5rquYCM6U4SIzzQzgiGsm3UGVfaorBeeMPVgsfDhAZipf0b3iQlMTDgq7jxlUGpIuCz/ha/Uc5szKOm0XRAB/akT3/7vJFq5SdOhL5B6YJWya7ptHmTYoHNjxwR+V0QTUjNOtVYYOHZb6CrxoRWblrBHCIU3iSWgsSmniPIu1VEunw6SNBvy5lcleZie5FgCXLVls3VnNz2ckhvYnIJsGolc3Tp9iHP7fTV0MvW01OOT1Z7eEYI1ye1UfhXv4wrA1fJhFhKVOt81o19TUNncwU92cvCTnb4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nocNVfB1H7pe1b20OtkVMcaTAzmx+nhNzlfX44uyd1s=;
 b=Pa0hV9c62B8D4TXtpMerAYVEm8mqK2SXOIvf0xdD4j42rRld1DkQ/N+Hq/Gx/x5zeLiWzfEGiMqryUNipRMgC8Bon+wmMrD2pLU6sNmw0WvIOiBPtko0mGjRMLNX2YLDO6fbK4ZvWGFQjg+BFzZhGk42QFi/nZ1LCi4gKIKNAU/0QULGroHWMQPkLku5W5SuPDP5iKGQhEfsanxegABx98vZ0nwTK6Tq1m1eYvAhg1dMSQ9SKUNGgOnQmuJ7RWpXOGJ6mrs+SDfxZ6ywH9pOIkszMCL23hA7F3YivUWRaJXmPiqrZRXa+LunACm755xtQ4v/6iaA63+ziw8QcfFUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nocNVfB1H7pe1b20OtkVMcaTAzmx+nhNzlfX44uyd1s=;
 b=Dsmf4xn2ni7mib4DoxMj+50bkpT01GgppOQyekurVi9t6KZcnGPeZExGmW4dTTHrtaBtDO0PVpeWLXLVDOvBDjLJMiH6uqfTY5ujMFOYNIG8OouAPIBRd2PWkaoJlk7giMFQbnPqLbe6wRKNphi4abacQGi4+tSiFE7twNjZ6GExLYQuH6FO7bnNXDla3GOgntyWE4XBPElEJ6gdkzp/ILXswNKvQA6H4jjmVGXoqiNeRKVFicYL8WtYA4CXsm4vztpzONN75GSjqPhKk3EFBP9etvRshdmVoX6/jDKZCp2enpcU6VNNlpF/5pp40qr9sxPl4VkG/d5X6wAWkWx3/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com (2603:10a6:10:35b::7)
 by VI0PR04MB10879.eurprd04.prod.outlook.com (2603:10a6:800:25c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 19:09:17 +0000
Received: from DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4]) by DU0PR04MB9372.eurprd04.prod.outlook.com
 ([fe80::4f6:1e57:c3b9:62b4%4]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 19:09:17 +0000
Date: Wed, 6 May 2026 15:09:09 -0400
From: Frank Li <Frank.li@nxp.com>
To: Sheetal <sheetal@nvidia.com>
Cc: Jon Hunter <jonathanh@nvidia.com>, Vinod Koul <vkoul@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Frank Li <Frank.Li@kernel.org>, Mohan Kumar <mkumard@nvidia.com>,
	dmaengine@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] dmaengine: tegra210-adma: Add error logging on
 failure paths
Message-ID: <afuR1RqFyX_rx6pj@lizhi-Precision-Tower-5810>
References: <20260413064545.2157410-1-sheetal@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413064545.2157410-1-sheetal@nvidia.com>
X-ClientProxiedBy: SA0PR11CA0121.namprd11.prod.outlook.com
 (2603:10b6:806:131::6) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9372:EE_|VI0PR04MB10879:EE_
X-MS-Office365-Filtering-Correlation-Id: 890eb3a7-96b4-4afc-9b1d-08deaba2f841
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|52116014|7416014|1800799024|56012099003|18002099003|38350700014|22082099003;
X-Microsoft-Antispam-Message-Info:
	UI1zgCUio2EuZ7T+g3zo/elQir+yIpxoENRftuWx03G6HzSoD/hpeBrCst2YyjWSzzgliqLhtdhrYRvCtjA5PqIcijh1ZLJtN1dntr+VAS/rB2NNpSTfIzRR4XvgNU0S9UpN4bVL+WG3DMTorIImuUIDJNEg4kviZYbn2gle2/SJzK62H7hzWKyq0alJk82oxyYRXr1Ki3yTD+TM3D44Iet5S+F1rIqhnwXlhY0kqRTTWcqWlc+HvBfba3XpqACO+2C577wpHSyX2CdJfZrHVBCex/WyZOOGKuSo6fASNoWmUYNAXWjHYKHBNMtFZyLIVPZk5fU6fi7u7/l9Qp+/90KKxmMDjf7dwn12vuk841qZ/KCAydo5s8YRokU6jezd0AeFxK1itHImWdUP45fu3YYJ3bm4iVtGxGyS5AdWhM2o6JgVGz0Kn3CQ5w+mKPr0cbuQxKpqrDKCUY/EbpsIgegdNtzONbwzHPlBBg65pXwiJY4HsVstVlmcxu+t8pUfdDmDVrbWDtXNm7BTi/qxD9zYUUl/YRcGFXRKNv3+M9yO8wMOJTjeC34JeUO9KmxXg/3IsIa1r/KKQfT7V1xA8I0bF5W8LgbOcUQXr9qggENQweZGOoouw/NQAwpp77KJ0EIzjYCay1u7Rik1KJCw6ibqB9vlGvAXNk6cv6uxcqY4JvFeETVXxHNdnt822FbTqjjdCsS+Y77hEly9vnl+fI6yJr55NdP9qJJqLmfdLJvyRW4V/RnH+/PuFiatVVPD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9372.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(52116014)(7416014)(1800799024)(56012099003)(18002099003)(38350700014)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A+vPYSU7ffj0E7y/0rb9A8VSVSQmfU8syZnWthEGU+zJzIOq7hiXAFfSwOag?=
 =?us-ascii?Q?o5HY0wA2yeUwCUAPcxrBvKG5N1hRwM2ub0FJk3ZRom+6FRbA2EXQIOdaLrT7?=
 =?us-ascii?Q?X7odxsbfbopPUW5+JutLxy9e1WzGQfzRTX61FGnnrxCCu8lxuvFhPz7E8h5r?=
 =?us-ascii?Q?CFaDhC3TaRmGelvXTNBt/ksmaxM+7iFRJkOFrdFbTkzRHW1bqLWiIMFhAqSE?=
 =?us-ascii?Q?kipWiRFX5Obic60dBATCwB0+0FMD3Tztjm/dpG3kyjFfIVPFJ24/ACdorOdd?=
 =?us-ascii?Q?T+DJ/nXRm2/IR+18QHHkYZBx3KMfpnRyK46xWdBYOkJxpOty56E7aGPaWl6E?=
 =?us-ascii?Q?9ksJE93xa7MdTjjLG4YGFRVOYxT2pp5nC4hoZuCfP4RuF7w3Y0LAsgfpa0E5?=
 =?us-ascii?Q?2+e5G8T5O0K1Q0W5MNnJbLnustN5xnEgG9sR/zfS8KtrGocQhkx4sFJ5BvIJ?=
 =?us-ascii?Q?ek4WHHS5v0JIlPOjfc9fEDZSpocK0xS5uPHdtw3+LBuJoaBM61ZZM/tkljAX?=
 =?us-ascii?Q?mXWTF1rHLVcFk7SGM1by+qmndZTK2rQj/a0EcPhNH3GFTAWV92T9OZB37nzF?=
 =?us-ascii?Q?2x/fGc0V0s4CPjn2VwpShrJKUrfoiVQs0JkL73tx+1bM+imsR6IttF7hMWER?=
 =?us-ascii?Q?2JL4dIail3FniusNT7Of+H9BMQ4Mu4Hw43enLWvuOMPRoRHitkt4tWmg5auH?=
 =?us-ascii?Q?QkkOsKmw3ZC3XbXa0NqDi6rpFXFZoAhD4uyAfH1973OiQ5/cbJV/X9Mjw7Pi?=
 =?us-ascii?Q?OsiQrwBJb93WhIHSKq10ommmA6BR9KYrwtvX/ANW4MN0jkFRqFNWAXRa1JCE?=
 =?us-ascii?Q?h1Ot/D5lOD2QwZFmReQcx74TQ+PfjXGkr5BZKUEaYJt+qAU1BKJsQ0aej0DG?=
 =?us-ascii?Q?VGHqKBvX87Ep+uVIoFbeDnVGr8Lbqx5OgBXG6EWyfkCS68PfOanvZf9K9BVp?=
 =?us-ascii?Q?yZeYTPn44ZuurlIQv5o7AeIOI2+Q8MxS1fsRO9+ZgxHml3241ZvQ8qTl1yz0?=
 =?us-ascii?Q?yabDqUPQttY7BTPL6WPXppN1dsPV2ObzcrFiPnJ9h/tQRDOHVIXur9bLJdDo?=
 =?us-ascii?Q?bsKmCMVwmLzm2yhpmL8q7sHxe7BSLgHMBblbk3Yn0eiZ0zXGdLzzvSe9jkCW?=
 =?us-ascii?Q?QtwZ7JBHkI7hsW2jd0FQKwaXNl6nCU2akj9Fhu0pYwVBRtXq3bqV0PloS1F4?=
 =?us-ascii?Q?j/ihel9pt8BImdiqQDGZrw7b+MSnL+qTDllb3/FreNnr0dlPOlJHKCh26g2z?=
 =?us-ascii?Q?dkIbYVP7AlXOw012fyoXWCpeW54PZbfSY+dSDVdnnw6HTcbhNKh+bPQHZtRJ?=
 =?us-ascii?Q?nE8EhAbjPFbsHvbjRbuRSnF4t9eJop1TJSYQ3lQKOSBUlcpaySufUmKnc0qh?=
 =?us-ascii?Q?ANS7DKtWB7p4/+Z6wJ995w3t/AaZS+plYTnJnh6IuJgSXBKbFcN+gGki5xgu?=
 =?us-ascii?Q?fjf5Du2iSdoQylrbVDHGDy1EnYMyTu5mLMxSvuuT1EKyfnamc4IFlm7ltcW8?=
 =?us-ascii?Q?L/Vuuhk8Zk8TpAJo2HAjKZkO+oITvIValiJRd4ZBm5ZyZiMODmBaBhgd8CaJ?=
 =?us-ascii?Q?Ns3NYwx8+ft7zN6L41+RESpeonbvDXqXKQW+kd9CuJ7PiaLHqgoIOS8II3Rw?=
 =?us-ascii?Q?xiKUYmPPW0taYjRjw+EBofqk8Gwm5HtB5ekAQz7WiURFbGHBFGWbRnyzPl8u?=
 =?us-ascii?Q?T3KIjfp8sEx/39/PbngG03kp7qRcOrmGttEh5eD9tqLfUIaF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 890eb3a7-96b4-4afc-9b1d-08deaba2f841
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 19:09:17.2443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rBV4bYM8yNYceZXPYIQmq6V/Is0KpgpZH2c9XZoa8kygiJ0so/WYre6SmHdAg0zmUqnk4C33Wma1BO6vRyaV1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10879
X-Rspamd-Queue-Id: 2EF3B4DF9D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10241-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nxp.com:dkim,nvidia.com:email]

On Mon, Apr 13, 2026 at 06:45:45AM +0000, Sheetal wrote:
> Add dev_err/dev_err_probe logging across failure paths to improve
> debuggability of DMA errors during runtime and probe.
>
> Use return dev_err_probe() pattern consistently in the probe function,
> and dev_err in non-probe functions. Also convert existing dev_err calls
> in probe to dev_err_probe for consistency.
>
> Signed-off-by: Sheetal <sheetal@nvidia.com>
> ---

...
>
> @@ -1141,12 +1157,16 @@ static int tegra_adma_probe(struct platform_device *pdev)
>  	pm_runtime_enable(&pdev->dev);
>
>  	ret = pm_runtime_resume_and_get(&pdev->dev);

Change to use ACQUIRE(pm_runtime_active, pm), so rpm_disable can be removed

> -	if (ret < 0)
> +	if (ret < 0) {
> +		dev_err_probe(&pdev->dev, ret, "runtime PM resume failed\n");
>  		goto rpm_disable;
> +	}
>
>  	ret = tegra_adma_init(tdma);
> -	if (ret)
> +	if (ret) {
> +		dev_err_probe(&pdev->dev, ret, "failed to initialize ADMA\n");
>  		goto rpm_put;
> +	}
>
>  	dma_cap_set(DMA_SLAVE, tdma->dma_dev.cap_mask);
>  	dma_cap_set(DMA_PRIVATE, tdma->dma_dev.cap_mask);
> @@ -1172,14 +1192,14 @@ static int tegra_adma_probe(struct platform_device *pdev)
>
>  	ret = dma_async_device_register(&tdma->dma_dev);

the preferred pattern is
	return dev_err_probe();

Before do that, I suggest
change to use  dmaenginem_async_device_register(), so label dma_remove
can be removed.

Frank

>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "ADMA registration failed: %d\n", ret);
> +		dev_err_probe(&pdev->dev, ret, "ADMA registration failed\n");
>  		goto rpm_put;
>  	}
>
>  	ret = of_dma_controller_register(pdev->dev.of_node,
>  					 tegra_dma_of_xlate, tdma);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "ADMA OF registration failed %d\n", ret);
> +		dev_err_probe(&pdev->dev, ret, "ADMA OF registration failed\n");
>  		goto dma_remove;
>  	}
>
> --
> 2.17.1
>

