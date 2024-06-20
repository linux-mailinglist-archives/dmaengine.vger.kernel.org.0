Return-Path: <dmaengine+bounces-2445-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCA29108BC
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 16:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B89D0284957
	for <lists+dmaengine@lfdr.de>; Thu, 20 Jun 2024 14:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F3E176255;
	Thu, 20 Jun 2024 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="l212pI4q"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2076.outbound.protection.outlook.com [40.107.8.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2054C1E497
	for <dmaengine@vger.kernel.org>; Thu, 20 Jun 2024 14:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718894745; cv=fail; b=LaxOweRqlkY2j8PGX0P9tI5nQDQlBWHNXo6GsBST0p2oIBHdEHL5nxea7xqSzt2Jbz8zYFaeAH/I7k0dRswLtDPtRs/TjbPgZ5eLvCwnw1WmOKNVWzgh1Bcn+AWdBpRrhzMq0KeaKXMhIvvwDVJRdYJn2d+vbW1OsSjzssaZHKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718894745; c=relaxed/simple;
	bh=t5ImTLHU/gZlkTKSYki6Quq9tKZ98LnqfsRZa99gM7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gz/PcuNMukSimErKBx3ll5sVbQ7QLAZ/OWdMVJ2GRrPS9oFheKTN9eiJrmg3gWtcHM+lcE7v3OlW39ofgJ0HY8EaCSKdbS5uEMPJ+VIe0KZ5ypOZe3YK0829rdXviIMvYGRWWn/ue56ojtTFe8FqLx7ZROGgGoSU7oY2T3TUrpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=l212pI4q; arc=fail smtp.client-ip=40.107.8.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgJmuAg+xSEChXgKF/JRvkv+xmTJeSWfBqHXhfeQmZt8QhSfHEyrcNQJSKadVgSpuOUeD9xmS9sYlkrffBcxSrh5sdxj9gGwKfquCZQBAXVcw8RRij1Nb3VqDBcZXASpBIdrFF0Nqt6AoqAW+LOE/rVO+Fl5OKe7lfE1MjKEuqbX0o5yo+VFpsyJGgKwSklTMi4q5S19swvvB21yIrQ3ZaNSzxFesFfIGo5WVdjZY/qum6u0beh31+7mcyUL+/AN6oK/pnUAVItsGaKkO5QSCJsL2azuhpxCAcZrRZc9uREoXbqqOajXAVHMzd7aWiVntVTT8f/NCoAlE8k1wl7Gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWOM5nYdlVHjREWny9NB2+rOB+33O7WIQBniFrIryOs=;
 b=oP5lw/a+E4EC2B9mfOmKAdunm9HYdXiZNZgq01KL9bZd+gfvJS0NI+pO/F8BmkfdwxAsbi/4n7XEXnVm6il5pGIRoPjuDWC6QRHXvyjSNix0wiZgzzVRHGm4afC37uZQrat8Fo5eMHmkWKmF7i1uDU+rBjOEx3gOOrz/QRJr31eMWsLIthtQS3M8qVck5jJGbyIcj32dpJoNJbb47mdPBHiQFyqvVKv5XVGITxY+Vyxc506OceZu7OdZeXwCfl4rje17gk/uLHM2ppEPHALgogfWSVCIKP2/FhhoVgPzMXpwMQJdKBeAACZ87m69rJPwPBMb1L8vXs5/Q6Nha/nw3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWOM5nYdlVHjREWny9NB2+rOB+33O7WIQBniFrIryOs=;
 b=l212pI4qyeEfRQ4fnjgqr8wn789YaSJS8ss0AKTRef+lAu8PmI1b1/4jIlayb1pDjWikuYP5qpjZ8+CHsAmmAMDQBa3HY2BMqBzz/or+Mv3SAFlwSlj50oWQfSc0nnzB6TwhLu9xyLH4AhvfVclZKA/G4YNYxs2qOYk6NYf9mBs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7584.eurprd04.prod.outlook.com (2603:10a6:102:ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Thu, 20 Jun
 2024 14:45:40 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7698.020; Thu, 20 Jun 2024
 14:45:40 +0000
Date: Thu, 20 Jun 2024 10:45:32 -0400
From: Frank Li <Frank.li@nxp.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Peng Ma <peng.ma@nxp.com>, dmaengine@vger.kernel.org
Subject: Re: [bug report] dmaengine: fsl-qdma: Add qDMA controller driver for
 Layerscape SoCs
Message-ID: <ZnRAjOZYNleFrdMp@lizhi-Precision-Tower-5810>
References: <3356b622-d321-471f-ab29-2af9f9684f80@moroto.mountain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3356b622-d321-471f-ab29-2af9f9684f80@moroto.mountain>
X-ClientProxiedBy: SJ0PR13CA0190.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::15) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: aae321a6-a13b-4014-75a7-08dc9137a781
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|1800799021|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t4vkrNHFKq05/ImfjKNLUSgjQ79vuXxDw9nkbAhD2eHXdlNyoyYDlDERzlEu?=
 =?us-ascii?Q?b9mGiukLr+3RSfee5c4J4zTpn8KRhD/6P3RDw9tfPMsIGaHcPRHmAmbYvZYN?=
 =?us-ascii?Q?362N0rt2YOaWVEVUZLAj1XK69pqXAG9fgKeMoN21kpzkcERDMX+CRtWkEOfh?=
 =?us-ascii?Q?GWcqUyF/EUIrpQRJRAEsJw+utKJXW7714hRc61CCvYTEFQxjgMuKbQsV5WJO?=
 =?us-ascii?Q?hGoeYgw9AM81WPJcnpQNiBCJJHpIZUvjudZFphxgvOuRgGMWLLCkd46UMynO?=
 =?us-ascii?Q?gfKIwLNrKMx0UyZo/WpzoFMs84aakX+IMfOBWBbZj9C5A7QkT/taDNrahKN1?=
 =?us-ascii?Q?hlaBjZS3VEG5+19lhsoDC8R+ZREiQzZo2uvbaZPEO2poJXHPlJJh7IRAF0zD?=
 =?us-ascii?Q?+Ltn5Ae0CLvUpxKFCjjnXVEtGXZVfb/w06E2Tlcpv5gVTuERG3UMZB7XZ2cs?=
 =?us-ascii?Q?XDDlQrXQvHU/0w1QiK0hChfVWzKUxR4x51NwMxtryG0yhRbi++09nXd4M7e0?=
 =?us-ascii?Q?C27ZH93Ui9lsZt68WKCFN4A24Z5zil1rg2swa75R99+zXFREmRl5oZf06DTp?=
 =?us-ascii?Q?QfaD6NXV/uUTeOhLcV6DGtdhG/v5YxbJoYegdzr9qZlhbhuYDsmQd9oSkiac?=
 =?us-ascii?Q?Sa3BD+71WYZjjkopNOrDEP1xzzD+j/PWXpQZZsPFNUdljuUjM7/TcziNERaR?=
 =?us-ascii?Q?WaKV9xI6CpYmUDdMvOSXyEu5/fVt51xCx6W7CI+CMs1g1lfxLlmSfet3vUV0?=
 =?us-ascii?Q?PHLAcoZJh0LclI01H7DpBWflEIgQFKSsSwvi58G3GA8bVTm6FLAmadjqAl+c?=
 =?us-ascii?Q?HyUCS3WOB4vr8kNpE+ABGddlDcE2ZUsLfhEunfp2u12Mc/hyo+t/IgZvMsBj?=
 =?us-ascii?Q?iIwJidaCEhw/pbr1Rm6b9UHwuA6Qe2wGzQ6HD3FwEw4BQGnkQyylMRM8imGf?=
 =?us-ascii?Q?/WpxB0T3oPxxprxkFDHWTTzDcZZ8z5Onwfx+gstlk8n5KrGgAHEgfcTGhg3Z?=
 =?us-ascii?Q?6PRxd87cdMXdiJ7iXUbjf9qIFb2fnlWXHSB7G8t/8/wcdJ8iI0Vfjvku0nTp?=
 =?us-ascii?Q?FHHi4+Szbm3nziD/w+c35/qo2YHc1fQBbTFEvc++v7bEgmfFDFLC+mDqz2to?=
 =?us-ascii?Q?ZINW5LuP2mvwgeFIdHoqTixMFIhVk4XCCkPCJfwuNvSf3hLt+QHEKdFNYtvX?=
 =?us-ascii?Q?RBPZZS7fwzsm+YlJyZblTwrrJplqEbj95MbPS+erHN8QLhBLDBhcgYkqSbzA?=
 =?us-ascii?Q?wNyaglVPnJaQyB+jqwLdWhtj0VqvkMUsIVUWF50n5kuPY5hZyoW6lXXIe9az?=
 =?us-ascii?Q?AJpA5cc25CD4T7jKH8gM/Lm77IkPUh0N7ZC2ZxWMGVX6+MVyqsY7P9HJ0uGZ?=
 =?us-ascii?Q?crPcST0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(1800799021)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NQhx9fmLpmdnmBmYN4ozK2UuQzp3YMhtCNWPkD4G+7Y7mgHfcGNz+PJ3cqig?=
 =?us-ascii?Q?4gGwP75AABthYJq29a4oy/cmlh3P5cwIDUZ8tCyae/xjWmHSmv9bZv2UnSeA?=
 =?us-ascii?Q?KhDhkcPsNFiadfszqmhLBiW1LnfJtt7IGtr8wWP7a982PotWyY9YbOkJy7id?=
 =?us-ascii?Q?gJeJ30MnWLThZlkQ26UEMc+3rCYFllSJRGBc13YyG6MvFC10osAg6Abstz/B?=
 =?us-ascii?Q?ShL0prALEtjRzSdnPrWuV6dktzte5oIeU25WScbFUdksJZSodOk1OpaSy9HT?=
 =?us-ascii?Q?K+piejmi/HOM2ohywZ6uKa/80o5Ox3+10xqjRbdzhcFJXRiLAasTm6LqcdYD?=
 =?us-ascii?Q?apzUbLEd5ZOTxde3QnHCP/FbmyeVH+8ykjIBex8L0b7tqJjJCjROumtovjkP?=
 =?us-ascii?Q?foe14XIf32NLS6xHGAHqRJ3VdjiVuk0dupwUWys3PQSQnrWPO4aIFwuMovDk?=
 =?us-ascii?Q?DfqhL2uWTr7+bxzTNLhcw+FSYzT6ShznK/zKFd4BUGdmWKkgREbmUA0RA6nY?=
 =?us-ascii?Q?gbbuwCZDGZwqciSidMUGA3PJ/S72siy+EdXTMW+yS/wipX9hKei3e9F+rZBM?=
 =?us-ascii?Q?0kOiLZGxLP8qLMT0/+eyHSLNuiCD+1Wse1Zs24jyzPo2C+fURF59PsKV2fsk?=
 =?us-ascii?Q?EnJRaQRD7rzNd86iGtaD1iQF3mBRdLn/ZzenXXNm7X3qaoIkx/afA8bHYeG5?=
 =?us-ascii?Q?hCErkwZ/J97l3JIa4K7A84vFUmFyntc3lJOD1OXZ/XBtkq64c6R5It0Brgvm?=
 =?us-ascii?Q?mgrqG6MMl65WWCE9JIYQe/NGM7UFh7aaJQt/db3P4bxNr7DOXV75KZNhiDMV?=
 =?us-ascii?Q?PoSEF0O1jp72PKrmP/wK8tNxlNjbqrqgdQtFwmV19JT7VipydczHVX8NimAG?=
 =?us-ascii?Q?HySdzhn8ahRCm+Mq15u5cM1zhuENVIKWUD0HbKgtlA7c4vp256++TWdhHVYJ?=
 =?us-ascii?Q?M3aEoNGPzWELoHBvGDCSzujv6tDBmbMVNwL78Uso18KQh+MStadW1O0okmJj?=
 =?us-ascii?Q?s3LVnSei0bhsu0bo/BGG4uHMdrbmwvvoCEW4WTbh0WZe12NPF74mYeUxu77w?=
 =?us-ascii?Q?wkqS2SOA9oapUipExwnoMn8hkBWWXl3TRlQGsJAaNYqPaM6pTUYBvkcKk+wv?=
 =?us-ascii?Q?go5/Z8B6wVPAod5UNG15DdrQDnNxtQNxN7E8XX++u2QHe3wtcemmPTgkAKfn?=
 =?us-ascii?Q?pXIsGDOU/dXbCVV67z/L6HC5ZoxNGzltINwyBMcCP9dDCwUpcIG1vk86b7wH?=
 =?us-ascii?Q?qGDzG4/aOpgsn4p/vpWbjiGERG2KpeooUFgegpqAQzG3t1lDSuYU3wAAwRX+?=
 =?us-ascii?Q?lwIghN4Fhr1+N1gyibzoLzLhxAXIObBia9BiPbNJvF8hCAhyfYK4JRQKeHN6?=
 =?us-ascii?Q?ejOgdO7Lz+JoC915pLbLNz+ytUNvTOUCzOSdUJOb5HRbFs/tVgUmgWJNWOcu?=
 =?us-ascii?Q?igCF2nud9Hye9xzRtXTGXh4uceQ7oy2PWPTsm+zInJLEn6hAPPNtxhhTlkZr?=
 =?us-ascii?Q?+XGDyFweHNvyy3Eir+duGqzEXil/yM8+fnJv8SWP00S0MerBd6URo+0HKD04?=
 =?us-ascii?Q?akpbHR6wKfXi94sQDenmX+qCMTDjoaNdSIuPM8TT?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae321a6-a13b-4014-75a7-08dc9137a781
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:45:40.1953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPz7UUGUeMTF69QuTQz9ygJoghLCY2b6X747fDuhRKheoyHv1OysuM/TaD+RZHorJmZLIZLOVFHpVA9CUlBwXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7584

On Thu, Jun 13, 2024 at 05:37:58PM +0300, Dan Carpenter wrote:
> Hello Peng Ma,
> 
> Commit b092529e0aa0 ("dmaengine: fsl-qdma: Add qDMA controller driver
> for Layerscape SoCs") from Oct 30, 2018 (linux-next), leads to the
> following Smatch static checker warning:
> 
> 	drivers/dma/fsl-qdma.c:331 fsl_qdma_free_chan_resources()
> 	error: we previously assumed 'fsl_queue->comp_pool' could be null (see line 324)

Thank you for report.

This will never happen. fsl_qdma_alloc_chan_resource() will return failure
if one of comp_pool and desc_pool is NULL. then fsl_qdma_free_chan_resource()
will never be called.

I think it is false alarm by static checker tools. This check is not
necessary at all.

Frank
> 
> drivers/dma/fsl-qdma.c
>     309 static void fsl_qdma_free_chan_resources(struct dma_chan *chan)
>     310 {
>     311         struct fsl_qdma_chan *fsl_chan = to_fsl_qdma_chan(chan);
>     312         struct fsl_qdma_queue *fsl_queue = fsl_chan->queue;
>     313         struct fsl_qdma_engine *fsl_qdma = fsl_chan->qdma;
>     314         struct fsl_qdma_comp *comp_temp, *_comp_temp;
>     315         unsigned long flags;
>     316         LIST_HEAD(head);
>     317 
>     318         spin_lock_irqsave(&fsl_chan->vchan.lock, flags);
>     319         vchan_get_all_descriptors(&fsl_chan->vchan, &head);
>     320         spin_unlock_irqrestore(&fsl_chan->vchan.lock, flags);
>     321 
>     322         vchan_dma_desc_free_list(&fsl_chan->vchan, &head);
>     323 
>     324         if (!fsl_queue->comp_pool && !fsl_queue->desc_pool)
> 
> This should probably be || instead of &&.
> 
>     325                 return;
>     326 
>     327         list_for_each_entry_safe(comp_temp, _comp_temp,
>     328                                  &fsl_queue->comp_used,        list) {
>     329                 dma_pool_free(fsl_queue->comp_pool,
>                                       ^^^^^^^^^^^^^^^^^^^^
> If only one is free but not the other then it leads to an Oops.
> 
>     330                               comp_temp->virt_addr,
> --> 331                               comp_temp->bus_addr);
>     332                 dma_pool_free(fsl_queue->desc_pool,
>                                       ^^^^^^^^^^^^^^^^^^^^
> 
>     333                               comp_temp->desc_virt_addr,
>     334                               comp_temp->desc_bus_addr);
>     335                 list_del(&comp_temp->list);
>     336                 kfree(comp_temp);
>     337         }
> 
> regards,
> dan carpenter

