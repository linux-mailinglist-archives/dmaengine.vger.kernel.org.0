Return-Path: <dmaengine+bounces-2762-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5E942832
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2024 09:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E21285C7B
	for <lists+dmaengine@lfdr.de>; Wed, 31 Jul 2024 07:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EE1A76C1;
	Wed, 31 Jul 2024 07:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="R3TTmJxM"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2059.outbound.protection.outlook.com [40.92.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8D11A4B42;
	Wed, 31 Jul 2024 07:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722411512; cv=fail; b=U8grqTZZN8zi0gcAPSw7c/UbY7ns0VKPGDTs+akay24JCy8VuuTaawoWTDePu5UY0q9e6YTwudDfv0dqJufTgFyJKefisLqivFdLnaUsXJkwyH3aWsbxTkUgMfQbV2ZjHD11kXDmDwL+SHPHizjx2DTYKeSae/OTkvds5+2t9ms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722411512; c=relaxed/simple;
	bh=Nznlkopl0D4mwegbv9drdfN3NZminLjAiezf4aQPTEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ugo2egoT9y/BWiTJBPE6R7y5BOBW1dN1fLDHhYllgGSAXdYgdcLflnGGbTqaiDsBguuFtLtS2wNLQqnCRVZTgdJ0jSjsTBC0bbuwltHH5b4pvXVyoXntvjgwNgcZ9KceRHZ5tpGGsJO5IEgbS4Np6wPFbvb0L0OL0h8KMz0z8Bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=R3TTmJxM; arc=fail smtp.client-ip=40.92.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvbWzsmFWTaK8QjdRasI5iXvhSykMUXszCJ02o1qsViDNTc9GEXTF0lwEB+FXP+iLEWccXaQHOxj9yVd0grw4y4pRRpgeJuvG+WXqE07Zg5An34krIHVHZh4eEsipr4jpxY05996IIx3V6JQqiehIMYhZPwryQiqoYFIG4C66mNjBdXjbq0Hf2TLk1H9dIrRe+O+YRd3BHiECxtq3fe6UqH/hTbQsKlfjmFXzwuWttfIi5HHpUZgdgOzb2NI/bfsUhOBOWLHzedqiHiCwuA8N1c+t6aKVikj1F3EXJb5Id7ms2/jg8iAqvJlFSa+vluBuj4lNAu0OIBmeqVdyDUgaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NalX4TXUWYSzl8gTaxzC0fBIXNyflmqyq8Ofv8J63ZM=;
 b=xmvKOcEXt8MHhhXH7JypRdqeT/XAAyqy08ESVHHPGuSLitIILItOQOjpW9WWot+0WgZmpQYFwvPRKzOgUc5/I7aJMFSvymaK+hbabEbyGsrEOwZpJ9IwBjdF9OP+CX/Zrh+dJTaym8E5UfpyEagFCSTWl+QCcm2mxSd+oqOX3wDuUZJlEO+wUbJGQYC1LI0fa2ufA5K2mG3ueLy9riJvjruKe40jo8jGxeVb2f70tokTGltEIevPKKK4FLRtA8YdzDiXz3+2ullryp+PeqnO8FvPkIsdeqLpKvAiedf4otw+9rhq8uw/gprZ/B1y8d4mZ57uKt6hcHJScSeDQXFoNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NalX4TXUWYSzl8gTaxzC0fBIXNyflmqyq8Ofv8J63ZM=;
 b=R3TTmJxML83RXJFdCyfqKUPzWMvzGCVrUqZ2F4zKgTNTFop5TR9k7XyVlGwbYgEtpHVPW2rfiXo7+fVDdWJM9Ic+Qeo9z1lIE+e78GHrzN+23/ziFeg8tKZQtKubCiLnABjfhrS6gltssQhQb0K0RcdGuZUd0qnBBfk3NQZ2dz+RHjO2YINJx/r3CPZvKIA1NAMjwT63HYltCloJGGOpDgz6rm5zatX5Z5y5X3kAD5jfEYajcHm6h3ilZTfPAlMHGAFtkLjVABch9bWeDF8gAJszCA1J92LbIzpdaVL1gf6UE/cGLNJVa2crpdNZdaiBO/QHh42qSqo/CK91Hggi0A==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA0PR20MB6731.namprd20.prod.outlook.com (2603:10b6:208:486::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Wed, 31 Jul
 2024 07:38:27 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%5]) with mapi id 15.20.7807.026; Wed, 31 Jul 2024
 07:38:27 +0000
Date: Wed, 31 Jul 2024 15:37:57 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Markus Elfring <Markus.Elfring@web.de>, 
	Inochi Amaoto <inochiama@outlook.com>, dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, Jisheng Zhang <jszhang@kernel.org>, 
	Liu Gui <kenneth.liu@sophgo.com>, Yixun Lan <dlan@gentoo.org>
Subject: Re: [PATCH v8 3/3] dmaengine: add driver for Sophgo CV18XX/SG200X
 dmamux
Message-ID:
 <IA1PR20MB4953FE2F603D5D23175D724BBBB12@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953438ED600110E71F9D092BB042@IA1PR20MB4953.namprd20.prod.outlook.com>
 <633f5f40-481f-4063-ab5d-f383e981b0fe@web.de>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <633f5f40-481f-4063-ab5d-f383e981b0fe@web.de>
X-TMN: [HBNJbwWH7sZwW1kf1jqY65KG/P58I/gDljk3y+4lmpg=]
X-ClientProxiedBy: PS2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:300:2d::23) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <jga3rih33tsacrqnjzbpmrhvl3vjdseucp53fqbm633h34ozgz@rzmdfzavbo67>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA0PR20MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: f578b1a8-53eb-4573-6353-08dcb133c3fd
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|5072599009|8060799006|461199028|1602099012|4302099013|440099028|3412199025|1710799026;
X-Microsoft-Antispam-Message-Info:
	b+KLIE2uU6MjD7PgSi3YB7c8M/o82+Duhz5F+sMHJg41OvCVPopKtQhnUK4LFRung7QqhW1ffOdzgmYmtBGMmhcjgWcBdlXxP73Gp8ZAGw1b+Kpjft8nJSCcQrLKsTIxiq3agZzcJMOM0pVAFxRCLxODaUQg90QyHO41D/a2j6Ijm24pzldUjS7u67YotzF19CEFOBD6M5RMt59q6194ZxGy8NdSxGRX4S1u0ensCtu4lKrEezyOqG9LVT+KPZV1BdEEKvjdQ7dy9qMvEhkJ8N/3SvfeIjt09U+SioSNzCv8buBqL1URiA9tzxkgRtqzxs6p96KOVJ+DFf11asG4V7gGAcTFDoPfq+uXteb50EU7NxPYJYTLvFx5kGnvHIT7NZ2JqKpJnGpQQxySYTFWUs5OT0rJrkG+9xwlRbv+2xXmmkp6e/7NMN5EZa5UsC7vdiGDuYvlziF4Oizt/LUeLBQytlsafFn6Qk83k0gGy7bZNnq4wP7fPpcXQM+v4CLrH+8WJE0Z3oZIxeiUl1YI8sZhy7QgWZXENguU6ytPCDZ9NqhIV/I3Rj5PlHU6JN5C9uhEM4laPOwfNpHk1UxaYUTilGA/IXilDqtqYAMs4EIdnGx4HPXBwgMZW+bPg9ZXWql1SFp5AAHyEX/sUcZIAkw+m1iy7voU0if/sgeWq5HZrKWBEUuV+R3HtlfyWNzNVGX2aNg50Hj14VnNguBodf6KhyZuW+SlXl7GDlRNcGlrxj7nrYEs45h5VnYygGgcvstI5RnWd8mb3CBF6BTBIkL3me/Gl0DXQGJ4pw4XRPSuwfdK3XRz2n//nsgQ+zzu
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkI1dTMxR3FOckpPME5NUER0TmNVbXpEYkFpVVcrbWkzMndydEI1QjZCS1o3?=
 =?utf-8?B?S0pzbXBKWGRNWjB3ZENVbnRSNVZERGlEdkVrQ0JFZFVIb0tBK1pZZUxTUjlj?=
 =?utf-8?B?cDI1aGVGeTI2c2xGLzg0c3Q0K0pyU090c1c4NGtZb0o0WCthT005citqY0I3?=
 =?utf-8?B?WUN0bndTVjg0bWhwdWFLcm9iRDYrUThyeHA3UXZFVlRmK2oyWHVmN0dQd3pJ?=
 =?utf-8?B?V0VpWEgwdThxQTFoQ1hqL1lVbUlrZnZCQUNqRGp0MTJjaXowd2U2UHdtNDNT?=
 =?utf-8?B?WVJhVFJ5RjlMSzNRenR0Y3lQaVB2azNDbjU4d2RNYVNESXVFVXIvdU85b1BW?=
 =?utf-8?B?czJVc3BiN2hSVEZuNW9KQmtzbVBhS1J3MzB1ZmdSci9nV1NqaHR3MWNBOWJU?=
 =?utf-8?B?eEV0dmplWGtxSzJsbldqbTZRQzdXeEFhcmduc0E5NnM0N3pHTnlnYXQ5Tmhj?=
 =?utf-8?B?ZkNHM2gwczZuaFNCMTYrTGdBeEd2RFY0UW9Wa0hKc2ZITzJwRGhPd0I1Y3Q0?=
 =?utf-8?B?ajh0UVhQcmNTc045dFpqbEE5SDNvMUJob1RRNXlEUVQvaGZqQjB2MklKUDVj?=
 =?utf-8?B?NzBTZ0ZtNWpMeVMxaXlCc1laRkFseFoyQ3NsZ0tDcVJBcU1uWXVuMU5RVHVx?=
 =?utf-8?B?UHNvbG81aE9nN0pIUlF5L3JLcFREbSt6WmVubVJpYnN2MFVJUGZDUk5hSUox?=
 =?utf-8?B?Rm5HK2d1ZU45QnZNT3FoNFA2d0YwMDZJTVNXYnIrYTR3NnczNUR0VXBYb2sz?=
 =?utf-8?B?QVpudHZMMUwwZ2VEOUdMRG92blNMTWJuUFhmK2RvV0IraHZQbTBMUFJxa3pz?=
 =?utf-8?B?SWtIOFpqTTQ2aWEyU2ZpTWJ0OEpYM3hUMlJKL3NaWlpNREFOR3FMbXJhVEla?=
 =?utf-8?B?M1Z4ZXB1aTZxZnNSSXcxOFhoZVllMWFFYXJLZ2JicHJBSkNzWkhiVE84dFdS?=
 =?utf-8?B?TUh3WHBGWEd6dURYN0VYZDZpZkNMVkk5c040QncrVGdLU1NaemZRWWZuSW8y?=
 =?utf-8?B?dkFKNm9qYUI0MThCeXNHTmdXSnJEdTdhNFBvUkpSSk83bFUvdkNqSUhTTWZq?=
 =?utf-8?B?WVJubzZ4dVc3NVZONzJNNHJPYkRtNWdNcHZqWGtuZEgreUJuL3VJS091UmVS?=
 =?utf-8?B?M1VFSFBnVXdUY1hSVUFUaUdSMWQvUDIvTlFWSThMdVBaclZtdS8ya1ZrWEZi?=
 =?utf-8?B?cm53SU1LWDdKejdNcVdWQ0hON1pvMmJXeDYxODl6MS9YSVdSaEZrTXI3T1pR?=
 =?utf-8?B?azI5MTJNRk1FTXUxU3M0WUpXMjEyRlduNEVjZXlLNTQwV3h0Y0JNeEFYMmxn?=
 =?utf-8?B?bEZXVUtoUWR1cUQyVkFSVUl1dFQ5eGdhdFMzeTg4aUtWalBScmVFbTVtdS9q?=
 =?utf-8?B?eURhWlBDemV5Y0VPZytJRnFnQzh4SDR6UnpacGthK3JpdVlub3dlZ1ZMb09T?=
 =?utf-8?B?bWt4VzNEVVFaTUJDUjRXWCtkOUV1Mkl1UXRoZVNWWFZHV1VQQU5URnpLU2Ni?=
 =?utf-8?B?M0NOV042Vk1GZUwyN2NVcFhCZnRKWjF4bVg3Z1JrVUVGVUhRV1J2Y05hNVFa?=
 =?utf-8?B?MUR2K1plNy9KaDBsb2I5aGFpQ0RtTmdiSUJXbFExcHhkRWRqcksvMStDc3h3?=
 =?utf-8?B?aE1KN01ySjNqWFFURC9SM2ZTelJEMkdaT25JbEVndjczU0ZLZ0o3S0tSa1Ew?=
 =?utf-8?Q?9fPbEaWRHyRxbi+kNX4j?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f578b1a8-53eb-4573-6353-08dcb133c3fd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 07:38:27.1266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR20MB6731

On Mon, Jul 29, 2024 at 01:38:06PM GMT, Markus Elfring wrote:
> …
> > +++ b/drivers/dma/cv1800-dmamux.c
> > @@ -0,0 +1,259 @@
> …
> > +static void cv1800_dmamux_free(struct device *dev, void *route_data)
> > +{
> …
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&dmamux->lock, flags);
> …
> > +	spin_unlock_irqrestore(&dmamux->lock, flags);
> …
> 
> Under which circumstances would you become interested to apply a statement
> like “guard(spinlock_irqsave)(&dmamux->lock);”?
> https://elixir.bootlin.com/linux/v6.10.2/source/include/linux/spinlock.h#L574
> 
> Regards,
> Markus

This is very useful and I am pretty intersted, but I am not sure it
is suitable. Could you share some technical detail (or some documents)
about this method?

Regards,
Inochi

