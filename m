Return-Path: <dmaengine+bounces-10676-lists+dmaengine=lfdr.de@vger.kernel.org>
Delivered-To: lists+dmaengine@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLNHDsI7D2rQIAYAu9opvQ
	(envelope-from <dmaengine+bounces-10676-lists+dmaengine=lfdr.de@vger.kernel.org>)
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:07:14 +0200
X-Original-To: lists+dmaengine@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D25A9E0D
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 19:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8CDFF3168CCC
	for <lists+dmaengine@lfdr.de>; Thu, 21 May 2026 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 335D13115A5;
	Thu, 21 May 2026 15:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D5z92dsg"
X-Original-To: dmaengine@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013066.outbound.protection.outlook.com [40.107.162.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9537B320CAD;
	Thu, 21 May 2026 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779376274; cv=fail; b=LJ9Bg3iPQBsK7dLWaRFaPM9RJp4CxNvan3Xzg1LlgUWhrH3Idk4k60H0jG1hWgalQnI6T10vcUaEzljnXWWJ5K8sTfMT6pQBa01/nbdxsXAQmywwg9qJ7nh4ECP/aUQfx99EqtvqEdCIbC6+EvphtPMrXDJI0wmBeQVaCjJWF1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779376274; c=relaxed/simple;
	bh=n3NDNRzBOq4e0kbVfDTqw5xPFGORhMRBxEl4pbddbOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S0nEYbLxFGnwSqwLSajIgSdrASx/Kvgu/AQUnc6E2YtAXaww6y9ds7EDEu4ipCA+8VEI2X3cTMEPIao/49gQUJPbELt2StlPgDlDKp5Z3BJwqfGzuzKzXxFJkhvedmdaw2jBq5Shn0jZ+ewFaLWMrxjl64BhSvtiEo+YhcppOAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D5z92dsg reason="signature verification failed"; arc=fail smtp.client-ip=40.107.162.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYntiF5RENbItv6tP0pKpuzcwiL86SlCX17YHjG6gLSpM9MoXAk9CnMQjceHzYxILuj/McgJYv29NNsTldvpch/Xvj4AYTh3qXDwDzRFa0o+UxyPyp1u0lcNGjN1JpLzB9qiIgsOme1BaO9aJtjGHpN6TodA6fvaAAabMyd5rRIV5abdjNzj+Ar1f71qGHK28XPwOaMdC5i7ItLhkugIevaTKs3Gn0lz0NuXMJ6y3pRn1PlywRo24tzyQjKulHVziXNLWsHFgkAFvVLViLJDLrianMd7k9BubGcJ7SCCODiB8OrobBQksSGTkobmIpgwai/UPmndJ+OGA60h234kFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMrJwuDcbXQQunj4NRwV8jTucCFDgKc5p6TnflPNW3E=;
 b=hhV/+UU+a5ipuWRFe8dwhQcZtMJu26o0x14FqGOUztRXie71uiqtGfHinUyVNv67PHE0r3OLxKMSgsB69kmJOJxJ6eejTbV0G0fGleDTz/EPA8HzBo+UxNuNippfxx8KeDIF2yL8K3K7RNezCR4CFZy4JXQX3zXByTUTa3S81+Ae/eCM7NtgZBhbBrIfTez1YTEybG25OUDkAD1su1vMOsZE/hTLIOLhKWqZcdPBW2IknOxfqOIa6o2pESqqF3K5v9dTW/+CSANVlv4mq9QGYY6q+cn3XmNy4dFoJPgvEJjaCF4qfJL79/ecsy86dpPR+j/3zMbKQs14F1Lx2Ll0rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMrJwuDcbXQQunj4NRwV8jTucCFDgKc5p6TnflPNW3E=;
 b=D5z92dsgSgO9vJVxYZ2PxycGS74rSLQ8Ai+gBkPpLLZiP4b1nB0DUR8yLUte3HUZeIp3LAbXBF011HLkX+d3qZTlLhFLUnRTeNfd7YET0tQ6FQdrbGQY34MNfCMQ3jyFj/kw6I+fizE3m8NBPif2mrVYp2meQ9VTcvKXor5j6o9e/cwV/fIeovKJAoH9FWL+cx7U9tbOROGxfLL5I7txuyp8CevbTCrXX1kB/2PYBUUPJXBHa/EbnzKNL7qQSJZSitM5k4POwO8yJOKdnLBjrsr5VZzc802iOvV0J96CqiSRyXmXmFFhg7ZH1DloUZGWxhv1kG+++vPXqkrBjUZRcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by DU0PR04MB9394.eurprd04.prod.outlook.com (2603:10a6:10:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 15:11:06 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 15:11:06 +0000
Date: Thu, 21 May 2026 11:11:00 -0400
From: Frank Li <Frank.li@nxp.com>
To: sashiko-reviews@lists.linux.dev
Cc: Frank.Li@oss.nxp.com, dmaengine@vger.kernel.org, vkoul@kernel.org,
	Frank.Li@kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v6 9/9] crypto: atmel: Use dmaengine_prep_config_sg() API
Message-ID: <ag8ghPgZWFYyTG_M@lizhi-Precision-Tower-5810>
References: <20260520-dma_prep_config-v6-9-06e49b7acb38@nxp.com>
 <20260521023302.7B64D1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260521023302.7B64D1F000E9@smtp.kernel.org>
X-ClientProxiedBy: SA1P222CA0077.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::24) To PA4PR04MB9366.eurprd04.prod.outlook.com
 (2603:10a6:102:2a9::8)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|DU0PR04MB9394:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bce9ebe-595c-4c5b-817e-08deb74b2e83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|376014|1800799024|3023799007|11063799006|18002099003|56012099003|6133799003|22082099003|38350700014|4143699003;
X-Microsoft-Antispam-Message-Info:
	ckfLgBONpMB62KUjEvNa4kS4t3apfQXx6e87Zg+tjtJKzvFKYY0X4sJqOzYpjHAVagqyXNtV1HyvwERZqbKY4PnUtFXfwn3y0WdAj70W+h3C6tU5Hk1WDU0uRPCn20u9bE3gtKKZFUTZszGAmukjx8Hj8D9WTs6l3q1Ul8qvP7aeafQsYP5mMt/emz0mSsaC0ziCiO0IRBWLjDz8+uCnJQbF3j/3dk3XUqkI2MuUq9u+GbCnraG9BjCbmPVvOrutw3NQF+FmMSu/b9eMKF1rHm+0bm2SeAlX7diLGKFM4vSNDK38sgHbSYRx/9RTMiBWgGPK9rEf/bUO97cqRhI4v0dA6Y0fxzxam3qERZfmeDZ62iXnZhulV7Zf2Rj7Y0EwLDB/if25R3rLrzfQYFcXouDXiMg677MQaX0yC/Ql8UjhvDYu9L8QPWWU0SoNdWcrx9xoGNb9GIpDhXesotnX/nmIm4a82otxkQhaKUA03nlJZsscvTVjadETVSIhvbJZV4iZFvVC2u4amEDIM7SxhgwNbaD3bT8T+4Pz43sOiH0z/rwmFM9orX3kdZU3d/Ssv3zAre2/So4MWqrggItk2mnVq2LEdTK+mhuu83W4LM55Kq+9Z6sCnY4W8VLNuhJKv1sFk8K1SDt3OUrC9g5JzWQ4dPBUPCKFssxf5YmML4PvFXpHQusOViXmJ2UfkJv4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(3023799007)(11063799006)(18002099003)(56012099003)(6133799003)(22082099003)(38350700014)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?uNozzBzDvtJYXBjVf4uJYvNakP9nqha6ijIQHCK0APJ5fCFWJANmfCvRjM?=
 =?iso-8859-1?Q?+e4o3BjtVIRlTDGE6VLoPV+GALqXqCqvZIxYpot9/YVPs3qi6w7N/LOc00?=
 =?iso-8859-1?Q?9hvHamBidDbW3Yh2MU6ZEib2dZBFDQd6Ngq9edQDbtadl3TzXXJaw3yiE0?=
 =?iso-8859-1?Q?QD9Ok9GgXvHWrOhYb9dcie49ZSx1c/CJPO9ZWUQMkr2/A0nKWC1eHnZXmp?=
 =?iso-8859-1?Q?79sTyTZoGxWS0beHcbOfbw8q2YpmmtDnq1trCQK9zOiJnZcADwW/bUjXs2?=
 =?iso-8859-1?Q?f4qnWVIXxfrcUxK6itnD2l7Yl/2FvrPxS1fsedtUhgBH12b7SJqOAMizMy?=
 =?iso-8859-1?Q?egi22XxwUM9Az4tGCanRixiLJkVPpFLxe8exAiXK8ncPKNijs4vzeJsyiT?=
 =?iso-8859-1?Q?IeVNF/Iv7FGCAsZKjIUjkTZkC1yXmfCYrY8aPEknXT6OWJpK0hpcczVJVC?=
 =?iso-8859-1?Q?+Y6xlnnwv/LSdvJ9/9SZRnr7ry15HCT5fLXyf8BD9RCM/9jtHODzkO6Z+g?=
 =?iso-8859-1?Q?AZxfYmt9aobsVdz3DnLd1gpvyBfpFjzuE6jNJQwzGWnw+jMkXaT1GEgxDw?=
 =?iso-8859-1?Q?S21c/BBuksfy4BJNupn17BBgvRQz9q0RCfR9kX9veyP1SMNcThZn+hMr+L?=
 =?iso-8859-1?Q?Z5UjDOaea5VsGdRk04zJfelTVTeRpAQp2nPpvomm2EaK2oGa0uYsSLBN7S?=
 =?iso-8859-1?Q?uykRT1fy4xl+JXp5iWpRdbZQE1TM94ZzGIhKIHxYmeenFpH9FyMKslPR8w?=
 =?iso-8859-1?Q?xybDmafQeE2h0R2LCPQQmNEaGoTSdKrxxiPaR5dWfP5/WFCDMg7gSO43Nm?=
 =?iso-8859-1?Q?jMBznujn/Y3x9Sb1QMSt/SUk7RTGBqB4ZZWBD/m06mqhOU1CZTXPFZkQ2k?=
 =?iso-8859-1?Q?d5Qc/PW+ADIcqY+sro35bvaX9H2ZkF3EXzjfuM80MBC1PkEnq/nc1F2gwm?=
 =?iso-8859-1?Q?OKkDixbLqMbXz5rRX3DKxk2uKNesZdMTWgKjFQMLVCemCtITeUAjayLHbN?=
 =?iso-8859-1?Q?4/dOEqJCv9gpB/rtZej2Vi1D3h+I02s7hlKkLpe+Q9Ed8hj97Qw8ud08tv?=
 =?iso-8859-1?Q?8yd7b0e/vmqi1xq5vfPvFhR+E4JJeSU9WJTWnK3h5omywM0hHpJi52wZFA?=
 =?iso-8859-1?Q?5B0AAGVkvkV7rUBg3VViKDydsENAvD2AjsDgekvR2OMu7sC+KxiyWLtmVM?=
 =?iso-8859-1?Q?ZYTOgagNSkdkx6ESCK8X1r28uYXR3QJwOQT0pt5kz2NGBN3ndIMTOQKpSc?=
 =?iso-8859-1?Q?D6VhdYjUzcOI4/gqq7pNBAbHpFjAItIF6Jl1tWjjv4STbJwWP8qJKHnJpf?=
 =?iso-8859-1?Q?7sG6s0h0O1dfzb6JppK27JX4XA1t8FCU7rRBJq4O7fgqpzoVBSHNvnXK8Z?=
 =?iso-8859-1?Q?LbqWk+U6aVax1GZlh4Lad6t96tNcJlgpjN9R3QNHNC08mt3/Z3RHT+LTXw?=
 =?iso-8859-1?Q?n8Ky2cOS67rspK9c10AjFlCMlCqgQCSiBQHFlQ8rBtsNfqylxvDg4EJenU?=
 =?iso-8859-1?Q?fFPIEY5GF8oZr1tCk6KFiBKkvYcL+h92Flfw0pee5d0litUMqntwCvKEK9?=
 =?iso-8859-1?Q?qKiFGZH5vzGMYaBUg1BJIxFMmFivwhlqrLsl+4NG3P699jVlW9D5yJklyt?=
 =?iso-8859-1?Q?1uLlfNRf6ZAAcMa6LW2edypd0AwGmg2oap6uuWtWVIeQ5B261H/6Wuo7q2?=
 =?iso-8859-1?Q?ZkLx9/Akurfi1p5Vx7BdepQkgBm5Pf5S0TDWvjlpuMM8Lh1tGHArtMs0nQ?=
 =?iso-8859-1?Q?bq2odLPWo8KWkNzllu7MuV9rYrH2hfD2+gqh5vUUSw4KSu0Ksm/Fp6lFUK?=
 =?iso-8859-1?Q?xKh4IAkVuA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bce9ebe-595c-4c5b-817e-08deb74b2e83
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 15:11:06.5250
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Vm4IJUMh3Y80bCh1bN8TD3kCjri83G7ua+QDt7gktXu8w8zktT23fT0wMut7/SAaxpdFDX3ZHnX2MKRsTtqaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9394
X-Spamd-Result: default: False [2.14 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_DKIM_REJECT(1.00)[nxp.com:s=selector1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10676-lists,dmaengine=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[Frank.li@nxp.com,dmaengine@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.992];
	TAGGED_RCPT(0.00)[dmaengine];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,nxp.com:email]
X-Rspamd-Queue-Id: 3A3D25A9E0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 02:33:02AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
>
> Pre-existing issues:
> - [High] Tasklets can be rescheduled after they are killed during device removal, leading to a Use-After-Free.
> - [High] The device unbind path does not wait for active crypto transforms (TFMs) to be freed, leading to a Use-After-Free.
> - [High] Pending requests in the crypto queue are not completed or flushed during device removal.
> - [High] Calling `dmaengine_terminate_sync()` from atomic context (tasklet/softirq) in the error path.
> --
>
> commit 8fb292764f2c30a42b59a7ee1bce9dcae3cc201f
> Author: Frank Li <Frank.Li@nxp.com>
>
> crypto: atmel: Use dmaengine_prep_config_sg() API
>
> This commit simplifies the driver by replacing dmaengine_slave_config()
> and dmaengine_prep_slave_sg() with the combined dmaengine_prep_config_sg()
> API. It converts both configuration and descriptor preparation failures to
> return -ENOMEM.
>
> > diff --git a/drivers/crypto/atmel-aes.c b/drivers/crypto/atmel-aes.c
> > index b393689400b4c..d890b5a277b9c 100644
> > --- a/drivers/crypto/atmel-aes.c
> > +++ b/drivers/crypto/atmel-aes.c
> > @@ -795,7 +795,6 @@ static int atmel_aes_dma_transfer_start(struct atmel_aes_dev *dd,
> [ ... ]
> > -	err = dmaengine_slave_config(dma->chan, &config);
> > -	if (err)
> > -		return err;
> > -
> > -	desc = dmaengine_prep_slave_sg(dma->chan, dma->sg, dma->sg_len, dir,
> > -				       DMA_PREP_INTERRUPT | DMA_CTRL_ACK);
> > +	desc = dmaengine_prep_config_sg(dma->chan, dma->sg, dma->sg_len, dir,
> > +					DMA_PREP_INTERRUPT | DMA_CTRL_ACK,
> > +					&config);
> >  	if (!desc)
> >  		return -ENOMEM;
>
> [Severity: High]
> This is a pre-existing issue, but can this error path lead to a kernel BUG
> by sleeping in an atomic context?
>
> If dmaengine_prep_config_sg() fails and returns NULL, it seems the failure
> propagates up to atmel_aes_dma_start() which might jump to an error label
> and call dmaengine_terminate_sync().
>
> Since the crypto request queue is processed via atmel_aes_queue_task()
> (a tasklet running in softirq context), wouldn't calling
> dmaengine_terminate_sync() (which uses might_sleep()) from this atomic
> context cause issues?
>
> [Severity: High]
> This is a pre-existing issue, but does device removal have a use-after-free
> vulnerability if a DMA transfer completes concurrently?
>
> In atmel_aes_remove(), tasklet_kill() is called before
> atmel_aes_dma_cleanup(). If a DMA transfer completes immediately after
> tasklet_kill(), the interrupt callback (atmel_aes_dma_callback()) could
> execute and schedule the queue_task tasklet again via tasklet_schedule().
>
> Since the aes_dd driver data structure is managed via devm_kzalloc() and
> freed upon return from atmel_aes_remove(), would the tasklet subsequently
> access freed memory when it runs?
>
> [Severity: High]
> This is a pre-existing issue, but does the unbind path properly wait for
> active crypto transforms (TFMs) to be freed?
>
> In atmel_aes_remove(), the driver unregisters its algorithms using
> crypto_unregister_algs(). This prevents new TFMs from being instantiated,
> but it doesn't appear to revoke or wait for active TFMs to be freed.
>
> Because aes_dd is allocated using devm_kzalloc() and freed once
> atmel_aes_remove() completes, could subsequent crypto operations triggered
> by userspace via remaining TFMs dereference the freed aes_dd structure?
>
> [Severity: High]
> This is a pre-existing issue, but are pending requests in the crypto queue
> completed or flushed during device removal?
>
> During device unbind and atmel_aes_remove(), it appears the driver never
> purges, aborts, or flushes the crypto requests currently waiting in
> aes_dd->queue.
>
> When the device structure is freed by devres, wouldn't all queued
> asynchronous requests be lost without invoking their completion callbacks,
> causing callers waiting on wait_for_completion() to hang indefinitely?

All is exiting problem.

Frank

>
> --
> Sashiko AI review · https://sashiko.dev/#/patchset/20260520-dma_prep_config-v6-0-06e49b7acb38@nxp.com?part=9

