Return-Path: <dmaengine+bounces-6366-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC56BB42407
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 16:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EB971894699
	for <lists+dmaengine@lfdr.de>; Wed,  3 Sep 2025 14:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED83E21FF4C;
	Wed,  3 Sep 2025 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Dr/b3eBB"
X-Original-To: dmaengine@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010017.outbound.protection.outlook.com [52.101.69.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBEF20A5DD;
	Wed,  3 Sep 2025 14:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756911029; cv=fail; b=uy6FxqzxGsQI8LZBhkLohrtZHkxZSeNxekkijcTbZvOlcCfd+ToHRMQosgxBhE0PeKjCn3taMo+5gZhrrno9YHD5tya4Z6G4Xfsp/sMr7S7sunTNyKdQSyHvb1dwtey69/l1IngEGfAAUDnFC6bB9K3r4aG8ecg9F1RqwAICwII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756911029; c=relaxed/simple;
	bh=1ks0EolOB7HmbzcD5L9ETQWZeeSvmlmdarVsb3EO8pM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YhebZ7gGmfjrZOl2DqsK7U8UYOwIuMybROve89o8FUwrqLDRfJpdZ/DDdN4+Y4UO0jvJTNVw3YQkuaYZBGz5/Yr63pqkQprYKtABYXLGD8bkVcmAQFJrJgTTt2REcV5CdlGpE72cUuE/vPiPDcrjbOAYJ84r+hjf/G5VOHmUzSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Dr/b3eBB; arc=fail smtp.client-ip=52.101.69.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PWmJfV74HPx7h2F7IWPD3GgodY9O07WotcCUKvba28NmSunnZrwiD03ubDvc8ieI7E9fkBUJqQczaU8m/tZ9++qEHl8oaXphgF8AM7sPjV4Ls7jL/plGWk/1XlZxWnZL21Wp06AJmO0P0p1pFGpmBBVodJkETV5owF2ZOl2FmRhqrLcMCFFiHG/SUFCiz73gX0zKZQ9nVGFHqGO3ynhOiLTev6MSRxvm+4x+MqxeEMzvo/8AWchG/YRiT0+vsrHrr09qsR9tYVSoi5OKJHKWmTuyQDbuCsXqeVEWVDtib9GMly3LQnXu+BMMx3OxYeGMAsn2/h+cWy3JM2bFrsXDcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfmvWaIixDi2q3/49/4wiYa+G8FpzcIwihG21GSRf5M=;
 b=lngBswZRgYtXZxUfuHpmWMuQaZX7ajiqYLyf4IQTyLTK55l6E18g2qReak+43Aci0RiYlw1xAYtXy3hMrjZ8zsMsFhWQenACnmp1BUvyvw3XVRdGzEIY32Aq86vTEvqDjnM/qu3DrPAmWNnOgqxk7P5AplSSdoilToDYETWdzf0lw7dPzolDjwP9oXXVEGZd/Jqfeltp19VyO0opkqoO/Ssek0KzfpNZsQUC+e91uC5t641yRsZfN1b64nEuIABdAs3nDo1yrlz+2sp8Mm4UD6qIAGCu9xJDBhZUVqnzd2tb9FHex8PqVM3eswczZRFttU+Q/noSbq9bmJSEzUL1hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfmvWaIixDi2q3/49/4wiYa+G8FpzcIwihG21GSRf5M=;
 b=Dr/b3eBBD9fabuVh30otNHUarj/QGFcXKvaG1QzxzY03nzmwEEqXQVpCTMn1tZkHl4h6vlmjSl3aYa7Em+Fmg4Qe2RXckG7YuXGjFBqXgtg3tSGeJShz7nFkWNZ+qUe0ADCmisgy4SLfH8dxurC1+cTUew/5bf6Lqt+ye3dfYXvWEkNq7/tieyxhCUXYHgW9FwCz6v/UtE6j7ran4U1u217JbK6SGdI+3HJywmst3E7fPk2Jq2l2dE9S+UarpAfVWt0krUE60vslRJJvx2W2FEBVzt4+0V44LBLIwOspV6xfL5g60qPdZHuM5gWLpCaIQAiWcRxaVXxin5le9e+OhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by AM9PR04MB8422.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Wed, 3 Sep
 2025 14:50:25 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%7]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 14:50:25 +0000
Date: Wed, 3 Sep 2025 10:50:17 -0400
From: Frank Li <Frank.li@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Vinod Koul <vkoul@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Jiada Wang <jiada_wang@mentor.com>, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] dmaengine: imx-sdma: sdma_remove minor cleanups
Message-ID: <aLhVqcLUgWU2gL07@lizhi-Precision-Tower-5810>
References: <20250903-v6-16-topic-sdma-v1-0-ac7bab629e8b@pengutronix.de>
 <20250903-v6-16-topic-sdma-v1-2-ac7bab629e8b@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250903-v6-16-topic-sdma-v1-2-ac7bab629e8b@pengutronix.de>
X-ClientProxiedBy: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|AM9PR04MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: f7a6efbd-8995-459f-ce32-08ddeaf93756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|7416014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lKtlkuU4T/aSrujQb/09eSUSoPAhtp5dpsVgff14K3QPs2dVveT04X75rxre?=
 =?us-ascii?Q?AhU3dJKpYlr60jdqVifzohnPrcdtyQ1HZpNY4VlxjA276RwE9l0GbMIAmFOM?=
 =?us-ascii?Q?AOh+dNLsLrBcj9Huj5KerQ7zowseOpGG7Wkjh/USspLhVeOCQ1UzvzrF9Rjx?=
 =?us-ascii?Q?FXkcZHnxyFjlDVrAFjjwlN9K4+wi60XQtzeXZTHlInfPUS5lxen149PuM/Q8?=
 =?us-ascii?Q?MdKc8cN0RIVFwubpnGqYsxGx7JdN/gFCa4ZXErZzj0DCPWI7RlYpsRFpGnIo?=
 =?us-ascii?Q?7KDnPJ0tILx2PsehH8IKrrsjN9MkDKWt9me90DqG7qBoZynuKNxQOI+6hrMp?=
 =?us-ascii?Q?0nHm0hnUkpqawbsRITAOvE6Y4r2hnMiIPdEvkf528EblxYR1QCQRjTedk5KN?=
 =?us-ascii?Q?vZq0xkKprAcawr2dunWYZOpi6sg5FeNDNSqYpsIwZx8DadzO7DVAzxGEieHZ?=
 =?us-ascii?Q?EJa3AZIF96A2ZBCM7PK6lMocSU03iGFuUFu6L01LrQUqT3CQUlP1Y3T8iq4+?=
 =?us-ascii?Q?sfo20rCokAXYq2+ZuVHBHceWYA5ehKJJvnmTn1yGF1Caole5EOIMWylqUHdL?=
 =?us-ascii?Q?eedve6w7JRyji1twBRvx1CzvXhKvAAcLFSnSu6Q85oigJ1+ttu7lbuxpmwnH?=
 =?us-ascii?Q?bH2HZMZ0Mos1LCKOLZuryetUPWCRo9eJX1eVaIu87BeyC2qdud1wZfIMfsvi?=
 =?us-ascii?Q?OwoRJ5dPnz6YF2vPjHexx7QGEtXMf5mFCC/zu1VMPGGdLYC9KqKoS9dHGhzu?=
 =?us-ascii?Q?2Sg+bgXCbhciHHbV922wpa5ckfmTZHOEKryqHftFOo+Z10rgChxa6Ozd3lZB?=
 =?us-ascii?Q?RrIkBW8kbATZsu6Yjq1SiICYY2j6vpZD8xjXLbBleIjxeB0/Afr0fAxEzmx/?=
 =?us-ascii?Q?SZuksDCAUWsgHqro0LCnhIP3O/15hH50IKoc/YipauK1zsam1d5d7m9WiRRT?=
 =?us-ascii?Q?pO6lkafUiZVVqSKa4F93qKRqFkIq90vNryiV9N+DcMj7Q5bCLQHXcQVuFKOh?=
 =?us-ascii?Q?xA1so34m5SmwVJseflBRm3fPo8ud9ywM/xF4awc84AY8aHl4AM1B1w9XFaNd?=
 =?us-ascii?Q?hfuiZoEoD9a/jerQP5tEZ0lD3lnANiShpGdU7YXDxcxBEypO1/8R74FBw4ia?=
 =?us-ascii?Q?0uSQ1OiPoS4hC637GULnM4K/bExcdOjyqiw7VbXuEjUDUXsv6Gfy2lB2Sdaf?=
 =?us-ascii?Q?iqI7FQiMnUS+qZ1NWhFESB4C3RPV55uLbg73twMJ7KT5OSTju1KPALd2yEmQ?=
 =?us-ascii?Q?wAf5V0eC7gbkDyGhu6BfHEMawdvtESyilcBT8D5yrXyic3suN4CZVWo38erE?=
 =?us-ascii?Q?1N78waIfblzfCCrdWRvm1xjR79YfEe/dBhW41HGF3bbeJcPNi/Tjl4ymdhVL?=
 =?us-ascii?Q?5qjI8uacpSAdT0LppIL+ijQMJov2zNipn9POLOjjHzZvZDfl7ZJOfyYKjFgc?=
 =?us-ascii?Q?GXv9yAuvDzVy3bsUjklrvaZOtGP4BGb6GQP25n92Y8y3KlSXpYqZjg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(7416014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ftz89owUsGlNXsnY1mq04EggMNjqkwOt3hzVthExm5SDYpe+ZXMhaxPFegQb?=
 =?us-ascii?Q?knHGeQ3p3p/4e4fs/Ulxs67gd10BrSk0lRje5NoD4QBEfTK6BDM5edlwF8cn?=
 =?us-ascii?Q?NuvxzY5uYixiNWUt/kKZ3d3r5HauF0vqDirHfP/kP5ACpe7yAsRdSmQkrZd6?=
 =?us-ascii?Q?bCQv4LEKU1ItVG1DH1FMAueMIGKaT0Y+BkIXt3PrD5ysUalyvwG+W0gC3XvD?=
 =?us-ascii?Q?iT3uEKNs8BS2WXG8+J4EM288mkukxUMrX0Ut4PRdoA1Dt/Gdfqllsbf70gIF?=
 =?us-ascii?Q?Ix+DzjjA/8W3T+iOxPF3jedtkWzHtGPhMV13+9THBv3cdogLu86cJseDS5kH?=
 =?us-ascii?Q?vE42T5/pTcKZ+t0eM/XhsJLMnEWqYFTPsE/w4R8VlG0OresGdLytSUHlxq5n?=
 =?us-ascii?Q?po90xZsXDaZwyhYJs639S+E77v4yOZsGKDQ0I2CHh9w300dydmujVbLdW8/J?=
 =?us-ascii?Q?O6lxxsSPw7IqVhKZ/+VWlE7bSz+r1SaxIjUDmiwnX447ORDVKKypwo9cxASQ?=
 =?us-ascii?Q?//Bnpx6mE+glhnuumqEYpI9wTJMudqMv5Ltf1jeDg9ivmmmFgDilTeuP/XgS?=
 =?us-ascii?Q?3wYKJ42y+BzbaCdl6eHNZuoSG7EXphQtagJ2s/uRoveaaj9dD6x/Go9k4r6B?=
 =?us-ascii?Q?LqFn3qMeMppKSFvfSqUpTnaJfmEBicN25rAxZxPMbN0zP983P04qvfruRIUp?=
 =?us-ascii?Q?LUlyxoBtAjF/4mGaynqKw87tWzUMEDQQWSMPs0vH3JYreKU8ZzTFIHSACRtJ?=
 =?us-ascii?Q?THKPKJm9xp9yKxgrwGoi64KhSPSWFw307/f/gW/QH3ZeqL4gQHpcYIHClBGv?=
 =?us-ascii?Q?f+7UJTCMnv7sNgdkr/15a1ho8ftquWtMzQ3e8VnNb2+aB9bwgWnmgWUx3kBP?=
 =?us-ascii?Q?FGnQGMOa/RNugOe8QVgP5TDnXdFLzxvvnrXbih1rH4h1OZ/jh2NatgrCGnwr?=
 =?us-ascii?Q?wi3nN4mju79e69qsHkHX469q0zN5z98o0FhnPucGENrxq45h/RA2wQOfJMzX?=
 =?us-ascii?Q?foVxCUB1UqsO2favFsject2yRMojYP3iAkXCnNSPA0RSR7qdrrzAOt+bcpSr?=
 =?us-ascii?Q?fbNiX179CmyTnXmwWkrrDXZprF/sg/pny2Mo5EPp43ccUWD6OMxHrytIPweN?=
 =?us-ascii?Q?laTRJVXv6S3eeC8+2pEvOV47kpJdQPgj4YRFN4ghIwqonp/jb9GXvXmxc867?=
 =?us-ascii?Q?uCn95Rsp0++PSjqsEGmP5MbLZEgaCBdGZb3GshOCiF1pPhmj6J+AhCx8hFcg?=
 =?us-ascii?Q?Y4o3i7WTKsVW2XA4zhcVFYGrPY+0Tm3RG+VRzL8dGOHVjyH5Y7SZoEuUXRQB?=
 =?us-ascii?Q?qc/FoN2mnLUpTFx1aVUnw++IP9F83+OLk9B4K8TRm1cPOJKKlhTU7Fg/sfPI?=
 =?us-ascii?Q?w/VfFmPRg01e0zuOulniAyRh5cTxmUOKY6vVDpXBRO7QJgFRZ/lwX4BmyBlI?=
 =?us-ascii?Q?I0Bf8ulK6F5qJOrcE4cIZbKK7ZVFVQ9kdo+A9H8hqnhL+0v+ei8GcEL48ijr?=
 =?us-ascii?Q?lsAJFV6oCDBi5xEKBhnjeiXSkOnbmjOsYIw1k0Ia6BFywDh4cL940JXqeR4z?=
 =?us-ascii?Q?W0Zpij56j92KGDRxlX8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a6efbd-8995-459f-ce32-08ddeaf93756
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 14:50:25.4762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmE/Wc4bF9dvXG2163SHVMotuqG4p15i3UWeRw+heAs0xF9w9dZW1DZJoClgzMAgaMWTDlyinmAxfDEHhr4Hsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8422

On Wed, Sep 03, 2025 at 03:06:10PM +0200, Marco Felsch wrote:
> We don't need to set the pdev driver data to NULL since the device will
> be freed anyways.
>
> Also drop the tasklet_kill() since this is done by the virt-dma driver
> during the vchan_synchronize().
>
> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>

Reviewed-by: Frank Li <Frank.Li@nxp.com>

> ---
>  drivers/dma/imx-sdma.c | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index 89b4b1266726a9c8a552dc48670825ae00717e1c..422086632d3445b2ce3f2e5df9b2130174a311e8 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -2423,11 +2423,8 @@ static void sdma_remove(struct platform_device *pdev)
>  	for (i = 0; i < MAX_DMA_CHANNELS; i++) {
>  		struct sdma_channel *sdmac = &sdma->channel[i];
>
> -		tasklet_kill(&sdmac->vc.task);
>  		sdma_free_chan_resources(&sdmac->vc.chan);
>  	}
> -
> -	platform_set_drvdata(pdev, NULL);
>  }
>
>  static struct platform_driver sdma_driver = {
>
> --
> 2.47.2
>

