Return-Path: <dmaengine+bounces-1513-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9E088C1E8
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 13:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 190E0B22F5B
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 12:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8313A7173E;
	Tue, 26 Mar 2024 12:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XUrXA0mq"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2072.outbound.protection.outlook.com [40.92.42.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA49D12B6C;
	Tue, 26 Mar 2024 12:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711455575; cv=fail; b=gWJC7Q4GfWNkbhuhaOPzPu6zWgd0sSgEhTMK0l27YOObS4ToB7FddH9xsTCKso1XWyi6IRgzgn35TW24zLpFbkQzdBsZ3YkMNIlmDB+c5GW429K6ZhvrnnS5P/9a8wklfBfZZlU1HspXTpG/wvuGv/X1N6Dh/SLoQzvol3pNyS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711455575; c=relaxed/simple;
	bh=PxAim2QaLcCXQyfNpTSmqD1eHs1hpaZf9fBc05g6Ya8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFzl1nvxe8Q/F6M1jz9EzJCB6rq+cp6+0qG1I/FDDTEMrLeXNtjXg9e6gdNaDeiQQGHmanrxa+bn/X19IqI34eU5VG1a/2zoS0hf7XHuq6bJOGNOuiu9rQpD0XrpMann28cjVobB28YNab5BhVExPTaNHG46mpxfRl1HA7iYdUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XUrXA0mq; arc=fail smtp.client-ip=40.92.42.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kn1ka+pX9uqIfvbMD9bwQzTLR54od1jYHPNrvjQN8pqZXcs3KrZ0mzgIK1qdvpitJT0WSX9hfdtO3hAUEy3zi+OO1oI1bLg3AJQJAjkyab55wNR0fNmoKwh+lUs1T2kNwi6vz1l4l1UOMZr3VO7R9lbm9dDNp3RWLgjRZXrP63wXWUEOqEVojbCKLaxLtLd7wXr8xvnRdn7NVkaAqxfgidadLdw21vYBaSAz/WAE+/RxP0T0z9Q5ildJ3Cy1CuIhQ4b3xjBNBwtN6RD0HTpQtTJ0uFDaihV4Xo6xa4A92fyFhkZ+0powZarE3bnuW4Ar1CzneD8I4kYY6AtscYZtUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5HI/TXtkzxyrTNjl/w1sO471kAPf6sbjK+USLwKu5n0=;
 b=cdSdqX57g1Ddh0MujrtbTBKtylXfG5kjXNC3l3FWCPHvFVC3b3eznr2PflQ6qVhng9Pj/kcU9Wcva0ZxinNVFqN5PFybmDr//NetdAPsD5qsnj+FkUq07SGM4POF84BKiGUajJaR4SDPMROSnWWuxo7K5hZMaC4CP6LZ1IIR3lH/1338XIT+zh2qZd5BV/dWLPJj+3v7lfo5T/xZwo5ISjpMF0NzjX6UXe/wrRl2jvIgsxHooEOW84Uhv6HVPHjX2WfU7cdpPBMn1p62sIHjKcxbLmomMwOZ1yqmRIR9l/hDeaiIBxjHDpWnZByJHz4gV53GUrd6cIS9A6U4W5wTZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5HI/TXtkzxyrTNjl/w1sO471kAPf6sbjK+USLwKu5n0=;
 b=XUrXA0mqEIM7EF+Lo5msrweyJkQl44PyVKwp94eIwsvntEN9h39UzbDNtq01Cl4M1mqDKgYQ+uGSzhBNDOpgXi1N+QbtwqwUxXHQrALMl3yD7jDqeD2D99IEzhwVwDSylAShen/pbF0qNGTqBVxA6H5t1jrxueF+HIJ/vO5OaqGAp2lw3kNKVipKI6ZhPqCsI5a4y84QR8hLD7YosFKZ2KOESAkvZh1Kgba0O0cPP07TRgPTtQZs6sZmgNLqNVL5yhYMDb8nkzUHqXZwSXr8zLMinRqpLCZsS/X68VZ7B+FPx3hhU0jBnDHlkB61ks7z79Lk9RWNaiBQonwl5cnMSQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by CY8PR20MB5428.namprd20.prod.outlook.com (2603:10b6:930:5b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 12:19:32 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 12:19:32 +0000
Date: Tue, 26 Mar 2024 20:19:37 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB495344ACA27E700ABEE61878BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
 <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <473528ac-dce2-41e3-a6d7-28f8c53a89ef@linaro.org>
 <IA1PR20MB4953517450F0E622A66E9A7DBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <cf42e020-9a5b-48bb-bc14-c0cc9498627b@linaro.org>
 <IA1PR20MB4953EA589A0FF36DC6FCF0E8BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <1525c377-af73-4204-8a2b-983c6d99316c@linaro.org>
 <IA1PR20MB4953D3A70237A5395E61C170BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <f7f6fcd8-5f49-4685-8488-9d51bb1210f5@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7f6fcd8-5f49-4685-8488-9d51bb1210f5@linaro.org>
X-TMN: [h3kPlE8Yhe/ufraP9jVEW5QRV6elytJSg13pIbnUvBk=]
X-ClientProxiedBy: TYCPR01CA0097.jpnprd01.prod.outlook.com
 (2603:1096:405:4::13) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <li22my3irbo6dsrpsgcnnc3c22wrnwpsopr5fxx6ec4tqns624@faofjpug6ofu>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|CY8PR20MB5428:EE_
X-MS-Office365-Filtering-Correlation-Id: 787b2348-173c-42ff-07d4-08dc4d8efdba
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3ghsXKwRy/t5h7NdWkXmzB0niMmniiG7D09qm7u3EBjVD9Ss2kFjN118O1TeSJ/L7Nm8bMSf381miSzr3+wXTNeeTiXkHXRbBPg6Itzw/GyPHL9K9g2OISzqt87eDk/dS3eWBJI8IGleh78EwHJ7hicnnBb46sJ/CMVkjPsEsM5C7ewEEtgnQLhLntMSqkR/jr71PLsGFZJqEXeHpnxnflpf2aWn5Rt2TeIc7HmErf/Tc1HlNo2dv3BIUVi0dM3NBRZ3fO57VUwoy6W+xdHuvnhbVAPXMxbXCuyww14dFWXvffjMHo2MKnSMTArD0I83U+P6JzRqV/eXvDMXlCMr9XcY+hFnKv3grqfihkoneDfksXvehcTI7VmM/RkgdcZWOF0yMZajNUBQKykMS3tqzsjJFyB804R+tkF1VBaVpZYRJddJRM98xM9ohduMO876d0CoVoylxp667uT2eagdFwn++Yh6wOZtEW+dWSzgpHrIBEPu+IW/zRmI3r25cXq0m7vReJreJEEfQl5P+O+7Q/WcuT2BK9IsxG+5awP7MILeKPEYVYM6vmPxgZ4nYsF4Q34RapCL3mqj9AHkdZrJezmDJH39JQuD9MDYgCaI4LsDqKPTo4sOFP4mWfXABRXLOhD+w920Q1C2hXXnd8+3BVDhn9dNO888GwFRV2wfmJigAU98SEJMyNmZRMPnUu0YZbuuvl7Lsn4UbWR8WAGHrXbuqQHho4o9NiTHdnSGvzUTC+GH2EHocs8hXZJDZ574yTOyaAuY5GdSZPP6kToD8GaCyHfYUpFvNk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5bHJIwpv571ugmCeA55X/1fjb8m9guxxkEo2yN5/dPiTjVlP1AFTa3exKA8i86Pk+KVzY8MePZv6bwYnOGvw5E4JbI+XuP3Kvpw9zZD72QdyXkr8AI+0etvz/2oVOFEIHjwzaMwOPvCdj0rXCz01tmNviSgm0ihS7vpBXPnBIix1KRSDATG6sI1scoVyuayLGc96EHoSARJSfVnfOq4wtVHT2NaB/CzQ2RomvZrjonp44wX57PhfjWHZWA54tgJB/4kcs3gcHioS2RLsh5/nRlsZaPqcG44sYHopMRhsdbEMj3hPxs9ABM0gWOrXbcZ+4gW9B18riANLINft5VWp95SsGpEk7Rjib2BP60kNmz9TAKc8ZaP5Rnc4SC4++INlvOorqhKF9oj9PDMsclYTVNZVA2Mi7UNVXpFvxe8XE+R1MBVr2Y4kf835ZwnvZANTsR75xHAM7U1p9rqA++5n7waWa1uq+B0omxS9vTa//2ok+WJiGf2muezNbc+Bq3JR0YxwP1rdGv+9keBogLGGqq1ePCswer9lMFjpxHN4b66lhSgiz9bUuyFKr7pYCfGlkaLwWARghlBzWp+KcjN3/62/DN+LAsag8NjmBCn05NfdE76UluOK2jNb3snS2qSa
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gpq0pi9EQZzzBEoH7olEmhj8YiIoijf/goZ5dneQnLsWB5bzUieHes9SrjxG?=
 =?us-ascii?Q?OrXP8J8aHMkVPJzaY8919VnSl+ol/KtwiCL67rH/IlX6GHTKZnJ12E6Iw0qO?=
 =?us-ascii?Q?9yP9vmApA1QNVrg8MkB8S4dS4uM7Pu5f3jY4b82sIrR9x0FP9Wr24g9Z0tqP?=
 =?us-ascii?Q?pIW6XClZZ9kUrhab5fA/VRXkhF3ATPNf/+QKX6ThtAMfqciJvorQYLLfL3lM?=
 =?us-ascii?Q?dDS7/WXCYm+4FGPwNkEWutv5rSMy3+s+0+0hj05vsh4QSQbY05J5GMz2AOIS?=
 =?us-ascii?Q?uRTVjH5bTWO7/IOCA1WlLp/xgMYWh/n1eifBhzzc9CZOsonKq3NUtj6JXEZq?=
 =?us-ascii?Q?7DeW7uxOQynIwmOMokWFSKp2E0eOH19YIRepr6vi5nMeErjKkcz0k86IVM33?=
 =?us-ascii?Q?aJYPmQs+zpUOL7Su6JBY36Xmbn3VY849Riwsn5OaXUgpU00Vpr24iGc4+sIF?=
 =?us-ascii?Q?OIAgn6hAZ4X3nSV+EZ8wVTMO4WriJ0ukH5H1HUaBtCadzDmFHoyRPZ49jJrK?=
 =?us-ascii?Q?8qq6lWBjLOh2LSqCC+yyjYZHB+TMjsI1z8etDCnaH33feA5mYD8U/9s8b1a/?=
 =?us-ascii?Q?2f7Ws1RdUKllZf9Ie7gdmyld1uJrrhm0cEuOLU5gtE6j5xRY0wPIZub6hL1f?=
 =?us-ascii?Q?o5h0OmXzjzT1sYH1hT7zgOsX6VLyvs87b007+MRVfzYaJe+YCDTMClJPNOXw?=
 =?us-ascii?Q?EiEWZxgGoCiLxKLB6sqOTTO3mPEG4chCPeuMDHfv65+0TIbuI/GGvpqT7o/q?=
 =?us-ascii?Q?NfatuPhMFSeujVxt9DGq7Rm8+XeUplYW9aHSv/RILLmm6xn4DAYdz97vSMet?=
 =?us-ascii?Q?66YhxA6nqoIdVngk1M9nU5lSsMnmK1V94ajaD2yTJG3VdvzKmv2Q//uqJFoS?=
 =?us-ascii?Q?tckJi8KYFg60SZwyBq1y1enQals1Na2zD6oc9CGivOzkTHm8WfOEL2e+dV20?=
 =?us-ascii?Q?IoMQwak6qVfCmPrr7jbri3dh9xAus4j6J73TdtmkFiRALTYIycfJVFvsaDGN?=
 =?us-ascii?Q?A/nfLz71VMYjCdBi9kePK/Aa/f25LU3oDyLpE55xKX05Ay4GEhZwp2NE1F+V?=
 =?us-ascii?Q?xyh988MobNiiqZ5jKMgeiR/653mh7GxpzcwWJ4fOCFdcpZDFW/ssd3iNO5/z?=
 =?us-ascii?Q?Xdd2b070r2j7Ea2E/qsML5yO5eGyvckczC61SQt71ACEVj+HNpVBekMrZU6q?=
 =?us-ascii?Q?c1aZjdRBSWf8tpyIXYe5ozzgdu+5nUJkvl5OcUWF5niTrWkWOgPASxCvDmSV?=
 =?us-ascii?Q?thi7N48f/KDimr2wgx/4?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787b2348-173c-42ff-07d4-08dc4d8efdba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 12:19:32.1146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR20MB5428

On Tue, Mar 26, 2024 at 01:14:12PM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 13:06, Inochi Amaoto wrote:
> e.
> >>>> +	regmap_set_bits(dmamux->regmap,
> >>>> +			DMAMUX_CH_REG(chid),
> >>>> +			DMAMUX_CH_SET(chid, devid));
> >>>> +
> >>>> +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> >>>> +			   DMAMUX_INT_CH_MASK(chid, cpuid),
> >>>> +			   DMAMUX_INT_CH_BIT(chid, cpuid));
> >>>
> >>> I think this is.
> >>
> >> So where exactly? I don't see any define being used here.
> >> CV1800_SDMA_DMA_INT_MUX is not in your header. DMAMUX_ is not in your
> >> header. So what are you pointing?
> >>
> >> I don't understand this communication. Are you mocking me here or what?
> >> It's waste of my time.
> >>
> > 
> > I apologize for my misunderstanding and your wasted time. I had 
> > previously thought that hardware constants is also binding. This 
> > leads to a weird communication between us. Since I agree and 
> > understand this file is not a binding, I will remove this file in
> > the next version. Anyway, thanks for your kindly explanation.
> 
> OK, no problem. When I asked where do you use header, it should make you
> think... remove the #include from the driver and everything still
> compiles, so obviously header is not being used.
> 
> Best regards,
> Krzysztof
> 

Thanks, I will think and do this for the future patch.

Regards,
Inochi

