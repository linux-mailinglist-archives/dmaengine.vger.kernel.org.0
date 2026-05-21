Return-Path: <dmaengine+bounces-10665-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFH8BcgvD2pSHgYAu9opvQ
	(envelope-from <dmaengine+bounces-10665-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:16:08 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B3D5A90CF
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 18:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A4CA311B370
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 14:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10207402BB5;
	Thu, 21 May 2026 14:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UWIZBFUv"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999813CF668;
	Thu, 21 May 2026 14:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374436; cv=fail; b=pWP0Gd9s56I2DrjE78cu5sVXbSJUBCfw1+gRUq8z3yPebZrFfc1G3MvZzkb3Wx6fzdK+4uZaUIOEjSpgwNGaShqVDd/aSfWUPxQuXx2OQtYXJLXk3UMEsjeDRu6xuLBsi79yuloTAidfKJK27yWR7vro62OKkuN2QAnpuO7qXxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374436; c=relaxed/simple;
	bh=HASkjX2AxJnHAeXHcpnl2+qDNhYFz4mqQqFDi8rjJ4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pCCZQt72KtGBaFXBVDz0OdKVLXIC4o7ysZHspGEeeDijNxc/zF89kfVKN/ilLAPH2B9arG+PdipTekEmn1SsKTihx3xF7R5cf4aeDJuNSNZ/aJhQBZF/t4LTqGdwOx8XAxZ8/fBbsDqei3RknTs5aOdvV1WVeNxt9T5YGvgJ34Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UWIZBFUv; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQHbb63V7oeYh4oJz2VMHeT24QTgo3YR/IGypJRQeKQHzHKVSw1T2Pd54Csz28XWqq7vAVbwojWS5YzaV66Se2UqjzEWh9RmUoNY0+mXk+Au15SVYcmthFQIgD6Tt+YMlO/ZbF6UxZnV4UrJEqASTd//rpu7C24ePmyhHpp/pCB8BUPmhr/BOe147bQVOOTUD8AoEgGqXSa7xd9Wr5Oq59GHdiePt6yGRX3/5hTv3nWE4YwRkJXo8pbNllNyV7du8lWwclp+yKjvYSMATxHgLnQC5KBSkp7iqCz06Xo2YMYorSYW00UvM+tl7W5vEJueWqcOjlQN5ZpndJ6IKOUweA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6KicuBPfvwnoDsGhkixe6QBSePAQQ7NychjbSoAnXg=;
 b=CoH7AmojEq8OOZXEMx6tgCTDZ6J9W+d6LexVSGvz267/KYcrmxho8/qbmJTVz9tj4I68iOpAY4LJzLCbN+YS5cS5W+Lr5oT6Bf3WLQaJg9Cmf3nIprfQFl/GCIcD5Dwih6AwhS192PsaBav8Lo8TUcYBBxlM+cc5XZDvzsdOtznjl5A5hv6FCZxxd42a6nJ9TRMw4uS1e/phVGAPRnotv4WH2HFSN45l4hTS6vMHKj10ttdRnubSTPecxLsYNwiOVrAGqh28GYiFXO16WtUMIUFljmUCYbDB+uqviamkkrje+23tYNZvUFOPH++FhKGvTipfd6cok2R4p4fYKJuIpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6KicuBPfvwnoDsGhkixe6QBSePAQQ7NychjbSoAnXg=;
 b=UWIZBFUvtAMyZSddmJUEEoEFa6yejtN7D1UySXum1QwKlC9ZhBt6mzHu7YdDXvzai4LL4qZ2EIhfddRSks8Q7S3qNrVSLt8JrinZlHb9VALrEqjVALL+mV0gjIP4u6EryuSryn97RZ7ckZEQUyOrbS+PyjVmAXCICux0Y9c+9W/jw74GNxJ1mXtQKgrAVPfnECYJjijydYMeO52fwYaipk6zMGKaYflbnLq46JqF4rF6f7/S1++ROjstugOf9tRZdtujc9Vmvej7oSuuZZYc+IAJX7o3T2TKP5nieF13vcEFRdu8C2Aon0J6Rf03RD84V81L93/qj6jw2V8w0RE8Yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9253.eurprd04.prod.outlook.com (2603:10a6:102:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:40:32 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 14:40:32 +0000
Date: Thu, 21 May 2026 10:40:20 -0400
From: Frank Li <Frank.li@nxp.com>
To: Koichiro Den <den@valinux.co.jp>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] dmaengine: dw-edma-pcie: Reject devices without
 driver data
Message-ID: <ag8ZVGr5hSWWinjy@lizhi-Precision-Tower-5810>
References: <20260521142153.2957432-1-den@valinux.co.jp>
 <20260521142153.2957432-3-den@valinux.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521142153.2957432-3-den@valinux.co.jp>
X-ClientProxiedBy: SA1PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::25) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9253:EE_
X-MS-Office365-Filtering-Correlation-Id: 67fd2c39-e717-4659-d991-08deb746e922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|19092799006|366016|38350700014|18002099003|22082099003|56012099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	3dU9rNbmdB6zgvVAwHbm8MItFNUSkxwi7e5y2MExBDGTTIsphr2zQzBntx72EmpjfeGFuMQAp1m+B7tn/Xyph9Ff7aFTEuLo9OISBCt80LrQNShR78774f/IY818nDdmwSRGf9zA0GjykcZJFnZG37GgrCIxABohSbu0NkVTFmgENMU92EyEBgKLsAefeZrYyo8BpumJ9+rthDUWm4f+mI9ZHUV3DhcGqAXevpRZkQFRhnkS82IGPAchxlH0g3H+winyYkxxCLqS+YVOPtMmc9vqlYq1Ogy9MzhvjxUxaCsT//Dl8xNqIBbPplHrhZXVZgfRjsCIY6fROz0Bt0zN5bzHSLnhfAiOZJp1o4uC3oV03hMq7VtjWykBDpnuzhrZyv73WW690y8ucjuTVe0ULxiTZRTa8zdEUdZ+lR8NntCljZ81/SJgj2iHwXGiSeUGTLI0UPZN4u9+gy00XjKnJtcH0cx9drQqnE+CDVVw18SNpegfyEuvp1ENcd6Iki2oge0a56ZIYuunyVrubfiEt2eJnmIcUlmjHSoEYCIsGf1A8gw8HodoKIyC23rDBm1obnxj0EFU8jxtcI/tq1ccGrc1msFERVLhHgVTRh2VLSsK8sNEAVVbDrYw/aQII+6yTuENSQkwrOjV++2hRbfVjwMdoScyyZPd2NhVPp8HfSqHl1cSgYEeHkjDppC4PBJgKGuXzMdu5uAd2AcGP/9fitSW6ynEy7RJ++3UJxcjzjRH2Yu3Is9FiIg5JrwoxR/H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(19092799006)(366016)(38350700014)(18002099003)(22082099003)(56012099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m9Ta7LK7Nqc233/5kltfftl07joOKg1Olc0rTt0cPklUgWPCVp84Oi0XAQ25?=
 =?us-ascii?Q?3+UtqC1dg3pAweqjjDkUbch+98rGnk1dron4eWz/14XtZTYViXXsQyp3SJXc?=
 =?us-ascii?Q?CIHdXwFErnyzI0rl1jSmlvmoWoyBJAunR1m/YYADOQ4SL+CD657fqedxfd8v?=
 =?us-ascii?Q?iNjP4vA2ulmp/yvI0S1CZH09rzSaR8b49ZZoTlZMSlFgUF4pHc4UOj3lzuFR?=
 =?us-ascii?Q?QieVy1M/hDwWPygpJdVLuSIzJo7qY+J/u0m+YvcI77MH7L/eR/WxrpvehzFe?=
 =?us-ascii?Q?vnBAZqiLvVZLvv9pi/UociOHffsZTspWJTHF2wwGPthnBLkcmnGSpgvyDKj5?=
 =?us-ascii?Q?YCikmQsfxyBNuxgKCNUn4mQ6AkvoFmHDsL6B1wo9Aklz7FPiblJ7wSkJvUMV?=
 =?us-ascii?Q?PSXXnY9aR36QXw+tCs3/utEuzh0LfKCInL4N9ajhJnz5e5un6BjdUb9+n+Ql?=
 =?us-ascii?Q?bT0/BqRqZk/zXCshiArFnJKFjCQ8n0lUZhEBBJgyswgz2qbxShpl/0dojBQk?=
 =?us-ascii?Q?MxKM+qJwVpeHH7z3vgrWYI+CnNEX29yCTuiDGN8r62rxZFES5mbUPBZO5JSJ?=
 =?us-ascii?Q?pUa94Tegj4EL5xFb0SZ9SRRXNjjMbvLpErM6pvQ1N5LBA/RYHrqW1u7m5pJM?=
 =?us-ascii?Q?QrnnchtFiGD3CMbQl8gbRpPmKOZhb3XtCnoHe/u2I8yoygKGJ+uYJZMPNYpT?=
 =?us-ascii?Q?/yciKjcF9kTJn9TTSFwpkB1rRmA7+g0bktKlDywwKb4rkkxKMLf19fJdSXZk?=
 =?us-ascii?Q?LCkuCAydFxE7yTWJ+tnfhLREo2cqjDmzDtHczqETgkuupCJAge8Et6ZjirTU?=
 =?us-ascii?Q?R3sm2dulqGoG/Xb2TaBk/C/2+syU8ogQaF91hYB0yGbTvCcRiatDZD+01qj/?=
 =?us-ascii?Q?C9NPObYKinNGS1hBsHlauiqyhPEnLmvXXMUidiUu1w0yFDhsLF3Ge5TNSU28?=
 =?us-ascii?Q?CQJPU53IR80B4CYyAgbpBF+knXc0jQ6OtfyGiuFk7jDS1kfBnUCQ82XU5IUT?=
 =?us-ascii?Q?YH56+yfCk2KTw+luI6/ah5102XF6dcRWkp4IPFnduswspeEXmGcROhN7UsAR?=
 =?us-ascii?Q?s5VuCYd0Xtg/0pC8Ib89dUul7V+N0Ill3u2VYKqTWivlVqwbU3cOaYQfKqeY?=
 =?us-ascii?Q?HGty2v0374PsujnecPjoWImnJ8xBMWhmbmKdfs16mzEpv5UoBvorwpcQrI3W?=
 =?us-ascii?Q?JJGGLw3eMvw/+C5n81pESdinQvkkUbNldvUdSf93K4KKAESJGhKW5uVqdKRU?=
 =?us-ascii?Q?59ptinVJQMjjs8NLeW3n52wW63v/AQTOAmORuIPfsMdvn7vwpag4SDdpoE68?=
 =?us-ascii?Q?LUCdKeh3Wfpk3k3x6/P+nZD0PmRrICUU3FgcdiBKvnHqENg7FUwBrsgm1MpM?=
 =?us-ascii?Q?pArJ5rf+n5wje5JR33m3Fj0TaW6q7+rouqtsAlWrsJtXx8jWuy5fML52nG6N?=
 =?us-ascii?Q?vZHioQTsz/8wdc1XrVG4NEgRpHAbn/+IpbqybFzfxDtfztz0kj+36ftui4Ix?=
 =?us-ascii?Q?XIeCUygc9/yC9XqVNpxKjDgULNvTJW4/yZlS/ZWIM4OGMzabQkr47vgVOjLQ?=
 =?us-ascii?Q?i5cerJP4bfDt1yomOFNQ2rXL4LOIFNvUe7ZGfQKhBbfSpDPgV1Y95q/7s7cw?=
 =?us-ascii?Q?Rwalhvwohu3xRVwPGms3+l2nGPdvnDHg1r4uY2degWNXaziIhZnJbCTZVCi2?=
 =?us-ascii?Q?gmbDU29YoCjcPcYm8utz6eTtMLZnLC/88CbdEcwk7bXNcz7d?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67fd2c39-e717-4659-d991-08deb746e922
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:40:32.1310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PMEAPfCHVGUxbCItkDNpT1qQFTbuEoojF6QnBl2c9fkV6XPBsZJd9tn3gD/vWZIvyTHNu3tJTRwUz7zVpxxvPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9253
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10665-lists,dmaengine=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,nxp.com:dkim,valinux.co.jp:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 83B3D5A90CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 11:21:51PM +0900, Koichiro Den wrote:
> dw_edma_pcie_probe() treats the PCI device ID driver_data as the
> template for the controller layout and copies it unconditionally. A
> device bound dynamically via sysfs can match the driver without that
> data, which leads to a NULL pointer dereference.
>
> Reject such matches before enabling the device.
>
> Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---

Reviewed-by: Frank Li <Frank.Li@nxp.com>

>  drivers/dma/dw-edma/dw-edma-pcie.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> index 87c31d01fb10..c2024fa824e0 100644
> --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> @@ -314,6 +314,9 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
>  	int i, mask;
>  	bool non_ll = false;
>
> +	if (!pdata)
> +		return -ENODEV;
> +
>  	struct dw_edma_pcie_data *vsec_data __free(kfree) =
>  		kmalloc_obj(*vsec_data);
>  	if (!vsec_data)
> --
> 2.51.0
>

