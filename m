Return-Path: <dmaengine+bounces-1383-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0830287B676
	for <lists+dmaengine@lfdr.de>; Thu, 14 Mar 2024 03:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A988F284B85
	for <lists+dmaengine@lfdr.de>; Thu, 14 Mar 2024 02:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEF11841;
	Thu, 14 Mar 2024 02:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AldDp34J"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2045.outbound.protection.outlook.com [40.107.22.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E37A55;
	Thu, 14 Mar 2024 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383969; cv=fail; b=sRYtureSTh80kMNO+q4/O7m1pAlAjXR/vgNuF6gBODF2IKz4t2sRFhFJrTnKRYqwi5eYDfm34wn5XPJcdiAEdMwT1CP0sPjMRo2cosSFJFx7d1AClgD43LoKAdKvGksvs2XF5ZjsOg3gbYv38I4nwZdvDQsZoZCDP59BUs5kFbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383969; c=relaxed/simple;
	bh=7WIRNpVM7zjR8odoDx9pOMyyqv4MunbRLwMld90VtxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IjuCHkX9Scj2YqQIl4TGdtwMnFuvubupHTK1jJVtDFkBiz8/4J9wBoUbanEmNia68VSPxcX/OBNR0wnKaZKrYwcluu9pvnIpKgpuvPKvUj8ZA1MWcbI9+D7uBHqc2RHPI8JfT18j0tQ8J9hQSslfGWL4D5BBgX8LPCFnfwzBmPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AldDp34J; arc=fail smtp.client-ip=40.107.22.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ro/sPoQidjNIESJuInLqNDScjpVETfk+sSx2yU6WVmmUnAm/LQivPU08oDdPhYXy77rqKozRE3DiozwZgDpQbAWURcTJwg6iHKrFz0slSLkXVS8vfNCFGGFCKAXD6qQoZyqLaX3rxzKar/JzitXRgnm7gDYuB7RGc+KI1HMIQhOeIsdQAtvT3PUBlqF75CohHOh4HD0DZdl/k2WA/ZrJqzciim3YCKniADW7IXZSYvmyhVAoQ4nrbrfoAoJYOBo03mO4BiI6GaWeEhaL+HowNWoBaf85+9/VWK5NMSN+daC0fvSIaCi2lwiczPCjQ5GjsjXwZ7gTFrQpS3dIbECu0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64iAqNmlBU+Vnz+qzRcMFrEcgDa2NjRH9SpJQPfQ/sc=;
 b=GeCnxSO65pCW9XO5Z2JDUHbtZzgbNP68cwIsRaL5D6XwyTf/EgCdUDHmDj34nYNVIXnYa0+r4JxUSlx3JG7a/wA3p9CeyiexMgVtwPm5KYqZI+hN+QID+GwxAyR0wRcTPFuBEAeFMIO6bY2ci5oiYwRNlAf5NTUHw/GKS7xaODTvhJDwMASgohx9L+79nPMDDHrl0eBgAdjtmnWlos/yRRkSc/OtqOBKw261CyrTzVEwp1e/pQzIDh4itOqGyw+rWOencj7FnFY7Olbuo+m/ZyVfs0eM6s7JSuCWQIXw3NX/+jbdR3znVBtbV9rQO5NgKQ/CBJoOVjSpwgpGPQEIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64iAqNmlBU+Vnz+qzRcMFrEcgDa2NjRH9SpJQPfQ/sc=;
 b=AldDp34JKU2ah0VETNwL5dPb3OqeShPQsWinttlJGZzSpLWKD+BdEIm3Crem5RGI49Qwoyh2CvLaMo61FFqn6aGEn0dyB4r3IixR8RtL0veB+RYFYjvrjN6NO3zGcx6P3s0uoRfxNzsk+c6JSPPlPdMPGV147qt47MlptRqHLK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8143.eurprd04.prod.outlook.com (2603:10a6:102:1c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 02:39:24 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.035; Thu, 14 Mar 2024
 02:39:24 +0000
Date: Wed, 13 Mar 2024 22:39:15 -0400
From: Frank Li <Frank.li@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>, dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, Robin Gong <yibin.gong@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Joy Zou <joy.zou@nxp.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: Re: [PATCH v2 4/4] dmaengine: imx-sdma: Add i2c dma support
Message-ID: <ZfJjUzWv2WOs/CFt@lizhi-Precision-Tower-5810>
References: <20240307-sdma_upstream-v2-0-e97305a43cf5@nxp.com>
 <20240307-sdma_upstream-v2-4-e97305a43cf5@nxp.com>
 <CAOMZO5ARM2pS93jLjpYZRfLU-tohuDXUZxDrWFjvVBGtH2t_aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOMZO5ARM2pS93jLjpYZRfLU-tohuDXUZxDrWFjvVBGtH2t_aQ@mail.gmail.com>
X-ClientProxiedBy: BY3PR04CA0022.namprd04.prod.outlook.com
 (2603:10b6:a03:217::27) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: 33f490d4-e653-4cf5-988d-08dc43cff602
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	b2VOLU7oXzii+4sqeoRGPZBb2Y4G9+dlGzpRESPNbSkwQfo/U/InhYWNQHHkp0Ov9yS+cMJV4wiwCO57wqyTeY3EJZ4h0Fc2pi8qG3CKiRzB6wb7B2EjvVO4LVqR6J1P4vt+Cg4DOfSPnMqe0W7x0iEwMOBGf/XzdBlMKzsSy3wddD9cu2FMsok4ypK8b4lp6jhAfosLHX9WRkeZj2FL9xMPhS9EekgMzAE4eVgKlJ/Lt5ghy6KNH7NeHc7Xlydzh0N457j8dLFtCtLFjXapzwxIVTzNOTlpAMwbutsQP35XBCKGBle7+lW8zkhPUhvu2SckhWj+XhfIDiXDtSPsJLDIh88hQe8IbDAo8IaiA6VOaq4GHHu7GvdGjlcqZKD1bDIFKSwEW0qxB0bv28RUOwQM7QtrFY3hjAr7Fse/8pMKPdfxGIliCPgx0h4uawiizYw2NPwUHYdWgQrVVP4/OpHr56a6kUyuSBKuWzoUCrin+TPATKL4MkLn8NqJU2aabUbJ78rxFIwGHVl63ezQ1Z12L+ctuvJ6FS8vnM74H+FanaqGjkgv6LRWK1QIhG1DAbMbPkQ24gsjAuXNEVFHogSpvJGqmxCf58ZggRAuEQwWPyGE5zW6UttNN7i1ZL20zEmy6ZAkYfW/AVY0yfquGPYGHzskdLr/ZSC+CrRihGI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VFhtV3J6QXJPMmVqZDZ5K3poTnd3Q0hrL2krUjNVMVpDaVN6OGhTcU5tSHpT?=
 =?utf-8?B?c210K0tkeWRGa1BSdjZwRDBDcXhDcWUyWWtKNkNpc3lqTVcxL2w3LzlUTG1o?=
 =?utf-8?B?ZTZvTFNnaytIYjYvYkZqVDZTUHFjajFtRFVjOVlGaWVOM1Y5VHBEK3A4ZzZK?=
 =?utf-8?B?d1BEemhzSEs0SGxaaDdEU2xnVHlMaHhOMWJwSk9TZXQ5Tko1VkI0Vyt1OSt5?=
 =?utf-8?B?cUxWM3BQNVkzYnFiZ203SnFiVnNFM1hxellqSU1qY0FTNlUyNGJQMDlVdm9J?=
 =?utf-8?B?Y0owajBtQW9QMUk0ZzlnOHpHSnkwWWJvbzNlWjlRclBxMjVKTTE0OGxTZCtm?=
 =?utf-8?B?U0NpQzU1UnFlMmljSmVZYnJmR2RHTjh0bk9kWVMvU1hsNnNIc1gwTExJZThB?=
 =?utf-8?B?ajIwSmNWNHZNbFhWWEF5MXpMV0NsNmNWNXRDOVVEc2VIWUR3OEhSZDc4L2hO?=
 =?utf-8?B?NS9MZXBvbCs2MEY2ckczcDlQOGJhYTlYTEhrSVM5cHl6UzF0ZmRFRjZ1YVZX?=
 =?utf-8?B?VC92ZVRDUVRLanNSa0lJT01NbGt1M0VvUE1UTlJobmNDdEVEMWgyL21kWEhB?=
 =?utf-8?B?TUg3clRqdE02Ni9xY3FPQytQRjhFZGhKRjcyR1VzaDRVUW9LaCtyTlEveVhW?=
 =?utf-8?B?b2x4NG9pcDhwbXZ2NTNWQlBmV291aTRBR1IrOWQ5ditNOGh2VE1maGxtaEFI?=
 =?utf-8?B?SWxUa1pHWUtZLzFldFdLcjRnREs1Y3ZydktrY2RQRVVEUHI4L2lqY0piaUhH?=
 =?utf-8?B?U0duWFUwVkVKdC9zTU1LTm5RMXJBaUZQYVBJbzF5TjRrMDF6SUpjQVRsYkRu?=
 =?utf-8?B?OEp5S2d0bXBOTXI2Yll0TUpSOUFhNXQ1OG1wSlc0WFcvc2p6bmRlUlBwandj?=
 =?utf-8?B?RVhRWUlJeTFVVm84ais3RnFTalJVZFZaWDF5L0l0ajhPZkp1b3BPekE4aDk0?=
 =?utf-8?B?UXpNb3pRelgyRzJuK2laM05kdXR5NHRxZlp4VklrVHkzM1JKY2dPSDFYTlNj?=
 =?utf-8?B?djBVa2J5ckxBTG9wRlVKZHhDS0pXaWR2dHVWL0hEcUhYM3d2VkU1NVJCdGVE?=
 =?utf-8?B?Q25RZ2JIZkc4cVRpRGUrdUJNZVhEOGQvbnU4U3V4TXlIYjR0STdTdmEyRXA2?=
 =?utf-8?B?R3NQdGtEYmRGK2lXMGRoMVUyeXhReGlFeUhJOVorc2lZWCtucmdmMkdGeVlj?=
 =?utf-8?B?UEZMVWpWUndGWUN6QXdOYmc1RmRvWGYwSENsdFBRYzFZQ1ppQ2JORGpYeXNz?=
 =?utf-8?B?V3hRV3BDQXRQWld2aUlLTHBHeTZ1dmdpTDhpcHp0YjQvUk0xWmMxQ1lreHJ2?=
 =?utf-8?B?VzNnbDkvTk94QzIycFdUMENCRGNOUng5ZCtwRUlJOVQ4dlFvdlhtdmF2eGJ0?=
 =?utf-8?B?SVQxVGFyUTNXbm1NazE4QzBQR3NrSXpmUmI5cUpBaVRKY0dHc2VtY2hvU21S?=
 =?utf-8?B?bzZaU2doNzRLZ0trN2xkM1EwMkFQQXFpK3lldkZOMkVoaUIzQ2JuTnFqaGlT?=
 =?utf-8?B?SjErUndHMTRTSkFYWm0rQVh6czhQWWg1ekdJMDZLNlBnV1Zac1dhYmpGRzZN?=
 =?utf-8?B?NmxOTUtiSmNMWmZOOWdvMFNXUnJjQXB5dDFrbVc3ejlRRm0xaWxyeURkeFFE?=
 =?utf-8?B?UXJ4ckt4bTJRTVk4Ujl3eW0vbkRYU0w1S1EzeWJzSFZ2WUxGR0RPbjdtVDBt?=
 =?utf-8?B?R3NMM296UDd3MXFlZGwyUnhzdkxBMHpoVmdZcW9uS2QyeFFGeWF3MTBEeVlv?=
 =?utf-8?B?TVFjUkNjd0pyNzd6Vm5DTFJyQ2RkZ2pPb09xRzIrRS9ISC8rSG5IeUhGZE9I?=
 =?utf-8?B?bm0vWThJTDBFa0JrckwxdnBJRllQaENaaERacEF0WXlFSVNZMVRkMCsyVFZU?=
 =?utf-8?B?K1ZzcTRaWGFmVFFiaTNnVGxvNHlwTEE4dktZaFYwZ2dteDVrV2ltK3grQzN6?=
 =?utf-8?B?bEtRRjNLMndCM1pBbEpWVWVqZ0VYb3BaNVZzYjZ2MVVOUFhPYjFmUkFndVk3?=
 =?utf-8?B?ZTk3cExkTzdFaXJOMks0QUxJUzZESVZMcjM3QmZ3NWlBQW92Wk1lZENHTklq?=
 =?utf-8?B?b202ckYwNTFndHB3bHlUWkR6ajRuaHpaVStXcVBPVlIxSHdoNFhEdnpUNG9D?=
 =?utf-8?Q?I6+COHsKJ8tzQZLMehVBAbEC9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f490d4-e653-4cf5-988d-08dc43cff602
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 02:39:24.5513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O3lsYi3diKurYxmToFj86neLupkGE4cukTN1Iqm7h5O5k2RbvvmziYeFbN4rAL00jjlS/pv88cfn5TJmxKf6DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8143

On Wed, Mar 13, 2024 at 07:15:04AM -0300, Fabio Estevam wrote:
> On Thu, Mar 7, 2024 at 2:33 PM Frank Li <Frank.Li@nxp.com> wrote:
> >
> > From: Robin Gong <yibin.gong@nxp.com>
> >
> > New sdma script (sdma-6q: v3.5, sdma-7d: v4.5) support i2c at imx8mp and
> 
> v3.5/ v4.5 is from 2019, so not "new".
> https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/imx/sdma/sdma-imx6q.bin?id=55edf5202154de59ee1c6a5b6b6ba6fa54571515
> 
> I think you meant  v3.6/v4.6 that Joy Zou has just submitted:
> 
> https://lore.kernel.org/linux-firmware/20240313071332.1784885-1-joy.zou@nxp.com/T/#u

Thank you point it out. Previous an internal git commit miss lead it. After
confirm with joy zou, it should be v3.6/v4.6. Will update next version.

Frank

