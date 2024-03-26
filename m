Return-Path: <dmaengine+bounces-1511-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41E88C18A
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 13:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAB031C22115
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 12:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A6E6F08E;
	Tue, 26 Mar 2024 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="SdRcJvja"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2074.outbound.protection.outlook.com [40.92.21.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA9E1848;
	Tue, 26 Mar 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711454768; cv=fail; b=dA5Ce/3q2LnEa7zwRFTxJmeygM2jQ0uEBtAPl5nU/yVihX1/hvmKuANqUz9XEft+gjzobwpVkpGBUCHmsEUmrPjKqvTzOU8Vb8EV02jMeFsf6Fwgbk6j4DqX6dM6jAKDZqj5tplPP9IzLfdEpYMjV9DOHLBcUS1SaY9oSJd7w1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711454768; c=relaxed/simple;
	bh=o8B/mco+PkIg7+WTgJVsUMAybUkleTA+My+C8sr53X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Os3kU9HAwPssipibbuph9f33lHtiJESsp0mrdI+vsM0Bml94Em8HuprwCflqzpTr2AWhTeYwklFjLwz89UEKq0lhx6lURpo8nU9l4tIiiy659jePtuMRZ4R+Wfy0nM0yHmstRvX5eQWHiIqY7eb3kkKxhUbsxozH8cprVqmA/Bw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=SdRcJvja; arc=fail smtp.client-ip=40.92.21.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4/F5mfaMQMf7o7MLtHGvTyTBFlDdtD5QI34LGN6drrrcPLAwasHFW34prMuVieMbI7dnZWbonUDGjZShcUn1QaadXMO1Gk+RBq8qKDNwLecV6KGs7qmyf6pyMdsI6oyPzXOK9SXsqcN8Qes8XN1SulRqogqk4lHWEqeiqB1hzM70Kw5UcOpQhuWYHaXcnjzFcjCN+JcZ95E6BRY1pvL3hHAd4MDmAoZWyVSwLjYrZiGpxyLzAi1dlKWjlIa/9IYIp3wAVI/nSS0/nERE/urkFb6eDByyXKYjM4DE8SJF8morqy+1y9N6hGM4++xVWI1TK7D2nO/1PfIckfc3QsYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m8MjLV2RD2CEFVlLWzBWw3UDTamddTj2ysPmGoxbuVg=;
 b=JJ6anHOApZyaIdjgNKk05hBIQu38LnGTvgLOnk2RFx8t9MQJkc+H3IND/jhThTeF7039Cn0+UAYGg0lO9lxrKhUXzipXZuXJhVfypotNv7f0NJtVUGEAgyTAYnrrIUDdvt/5qOT+hc9HxIUpE9L7SPpXlGFrCBXhV/eHZ3ApTGTEYnsIaeSEZxvSA9XDVheUVfEjI4t2SQBMSYzGtW05GAea5+GFjvbRdA62LkxdDVoGeJmiCeBbsaaXxwYsnD6iZPXe0NQQ+3+qfVHLa3DAinK9x7qP97VZfj/k6Fnx4Y0d+aDcHokLrHo8m3Z3I9EdJg2pcZIrgEnTa+8WTbf2Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m8MjLV2RD2CEFVlLWzBWw3UDTamddTj2ysPmGoxbuVg=;
 b=SdRcJvjaVDuGR8zDU3WcZJCcbuu5WkN3wTWMIsZWzqwoNX8zMM4ekqbCNmI9z3zxgGCT+wgC6jF9Bmk1boxB1BHb63dnCVg0iq++HCZanT02K+5tmzA5TnwGDtV0vwX8MyB9xtESSq/U5xE2wiNkmjhC2vhofwECam+IEyWGLeioeKV1eHe3f16z9i3eD8qstfljXZQjwKiX48qPzQRQesHPWZpdLmIOYz8z2Sb3QZM16Zh1QZLTk35aGkAiQWDA4L7g8SVJ5sti5XiBaAij0XoJ4qL+WE1h8FVJ2FeAvuLWXROSaRNpkcGZW25TS+92SemQ8vOQPVJ8Vf0PI6DYyg==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SN7PR20MB5333.namprd20.prod.outlook.com (2603:10b6:806:263::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 12:06:03 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 12:06:03 +0000
Date: Tue, 26 Mar 2024 20:06:07 +0800
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
 <IA1PR20MB4953D3A70237A5395E61C170BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
 <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <473528ac-dce2-41e3-a6d7-28f8c53a89ef@linaro.org>
 <IA1PR20MB4953517450F0E622A66E9A7DBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <cf42e020-9a5b-48bb-bc14-c0cc9498627b@linaro.org>
 <IA1PR20MB4953EA589A0FF36DC6FCF0E8BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <1525c377-af73-4204-8a2b-983c6d99316c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525c377-af73-4204-8a2b-983c6d99316c@linaro.org>
X-TMN: [/+OK59/+CA5pRuHNzqemM7YEYCcC/WtyP2ly/6X3mdA=]
X-ClientProxiedBy: TYCPR01CA0079.jpnprd01.prod.outlook.com
 (2603:1096:405:3::19) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <54awpeee64aegsmhphyt75p4sfpnfvwoaltdbtgxwny7ci4z6a@c5xlksr6rppd>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SN7PR20MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 3eda1fd5-2e3a-42cd-d787-08dc4d8d1c01
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3ghsXKwRy/t5h7NdWkXmzB01n4ERQjVCrnMrF3lC7sLOUTUl5g1XfBzp4nkSpelPpo0vIEG2qVHF8ctqw3viGV5SGz1Ntze7kphhSimCnfIFPTmEoshNibUBIV4evNkLysJ/nq16g1QwpN29dya5BHkawEnuNA6ovjrzfJtAl5FNDAlaLDPrwEkk+uT03ZJeq01yN/hobdlkRQklVc98O8hdacHKZ5qO4QC4eIgg89e7BdSnC/QlWw7S/xBYCqxRPpqS2553fpLKr739ijP5tCIm3/3e+8FGowA9AjNjFmPyP19EhNCkGIszhHuu9hoINsSOj32Ew3uvuzKvVSrQE/PDlw2Pbvb2KVCiKJC6Honswq9xIzBPIEg1P6ilALcPrBiEtElSObVSRg4RL+RBm+0CMresCYWT6Rc6wBQ1n6urALVja1HuEuDH1fwYJsJ18B320I/r+PPaXLREJ1tRjEVfgxgnL1tLOObt4sS1tprCUw28lzqYIAMcBhk0uF4Fwk+jIE+VFwvKHlVIWnWQ4xKqzbXEtjTOFbOe8NdOGMnkijj2AxXMi233rXvcNycz9zPJyvJhnEx/uRDBnPUCMB+vkf7EC82fnPILPIB5lBkiQAKmbyYvePvnb/IogNsOD/gkIX4NeWX4/43vEOWLM25+uHZahMiVSDRcBtkMXmgBoKbXrLxBetTxmXIgW9Z63CeLx/iHLPv0g1KkKxICWt78VoZGCm1nkFLe0WqIsJI94E6z3HjJgHOXYtWCwMxVrJk0Og+FoPN4L5v3c6rQVCOzwsL3v8oL/U=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+HmbKyKaCbCgpjWJWiMk7gVcea/j4JbHcuRP1k4hyuoQcob7cC4OBWxXn59WZrLFzhGaQH72v8sytWywoQ7JQH5VesOm8oUDmI3OuX9engBAWNzurXzNJvFkIc3e0f174KWNOl+whElDd3acJXm2uqvFLchAZbFxnVGe3qe+BIGRs8hlhVeib/SOkZj4oQXJ/MTNE+ZPDFiRgdZlmxToLNCqcDrzC5HY+wIorB4UfJjv8Uqcp9o088dbiBlwkv/UjM8wx5RkfSa9CweyVIOG2SQPTPqRlH75b3hb1c+9KGqxBxVZ5ihJ8k1TuMdcdWJMIjHUbcHKldhRg8kUDxvsK2MWT5tst0A4D7SStIEKg4lZW5I8ao2GgnOpmocVluEdJhD0yDya1TGcbT+BQGCDVXf5W8Lc4r7TriIRVC2DjpiyjHIExJCj+UkR0JjPLrZQ/cvEXw5lmJYndZn15uMtCZrHnAaWxWsEtFRaJoErEbDjfQwVBWUnJQosFzl5oxHy8HfyPJzQxkt5/vMW+gPO1DtEkByCTQwXl9y56l67kr7QjHJI8Qu4ZypAnaOWxRwl5RnlpnIQz/j/fbAq/dJHgNyZdK14PzGZbJhw0g6HojQRsPDWNy1x16+tkfq7RCOc
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8/mpCsJ+bQzWyDIj+ZD5iTTAbNT9qZCn92MB72d5LVdht0+H+5VF5c42dUKW?=
 =?us-ascii?Q?4J7hXbhaWf0vT62480Z86vl/BGYpW2ogHIGbtVeYIlku5muAz8YWX2UDe7OY?=
 =?us-ascii?Q?yvrc6H+mdbxd/3fBKckbeEQU7DOzyRBZkowsAja13YQp7jJ4CCGA795mTkT2?=
 =?us-ascii?Q?W68t/ZpTrvTM7vMOub4TrAIq5VOa/pWO2jww9qi6AIvhv4IqDw4oazfofiIX?=
 =?us-ascii?Q?n9mUQQmy77KHztTWLKhSYPh4ajHmtwj18PvoOke6LVOGpdqIvmQnJC6hqk9C?=
 =?us-ascii?Q?XiJVntJklPWV6rsB4+2kbP9DSd8DJkC63md40eLmr5jpNM1pJAzZ3eSBTnH0?=
 =?us-ascii?Q?MTcxOow0obb0dGNE/6YJhnvik8wFF6lL/LPbb3DNd0ZJv5DKKv7wG2apWPm3?=
 =?us-ascii?Q?WKwvKpW+zqA671Yz4ZHVA3sS4PMOotW2hKgSk0SdPEPeYhK1AoAJrRQUbU0k?=
 =?us-ascii?Q?BUYstJVZO9BZOtkRVLiaR3+yreBOJOx+r/f4pSyRgXq4YWBumNreQZln1LOP?=
 =?us-ascii?Q?7gy0eSYlAh+KqxmvK6sP5NANf2UsviujvubQXReL6cz8bDcUBNSHw76ZkyH7?=
 =?us-ascii?Q?0o2dMTlda0OUlZkhw3mNYeGuQWRPoYFmGbgSdmr9LA2ZepZapVtPyJhaaM+D?=
 =?us-ascii?Q?0iIQGMGcwbAcBJedxg8g9hHGZFUC9zH1fBkwLhDYdu8QI7kactlnzx300BKG?=
 =?us-ascii?Q?mpCyjCCXYlwJ+uta1VxQcXR9VHefvlKgDARq3bKED2gJJ9Ej1cHOTJbzDrLA?=
 =?us-ascii?Q?ANJ8HKusc2XPjnzmCW3kRWYEVkzko0veMWO9R6rKE70H6pFpafw0u/iJsK3l?=
 =?us-ascii?Q?FaFa8zUjttWcXO1P8au4gwqPMZSGbEOUzaGwnq4CDJzsIImNu6HcDX+v8nJ7?=
 =?us-ascii?Q?I6iTrcsafrxRyhWRyKFdIw/kzlBgTq/03q2CW1CFN6WgsMdx4i2Gd7XlGoxF?=
 =?us-ascii?Q?bHlLrRjWYdfky+eUe9SUZhT65AEI+Mo/kifjXwfmqd/7JbSuDL4R49O54AHn?=
 =?us-ascii?Q?ffo5+JATO3PF5SBtFrT6bGYnqR2J/i+ZTD5467Xb295hysbTcZileA3SEDXs?=
 =?us-ascii?Q?VghJ3GvWHrWFBYBfd39jNUzeX9qANRXJR2bK28egb5Ptukl/fVfZFKY4CuZn?=
 =?us-ascii?Q?zGT7/DAgOCixf2m9h3Uk6Nay8J1uFnwojAjfobisIFa+qH0Q4BZ5MSM8hlY6?=
 =?us-ascii?Q?phXZxUbgbcoECbRyPDdANYXGMgGoomXeRPlw92QqE72FY2Mu2BA5gmAKachM?=
 =?us-ascii?Q?SQ+tYXsVmClmYFIhaZVr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eda1fd5-2e3a-42cd-d787-08dc4d8d1c01
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 12:06:03.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR20MB5333

On Tue, Mar 26, 2024 at 12:50:33PM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 12:41, Inochi Amaoto wrote:
> >>>
> >>> The driver does use this file.
> >>
> >> I checked and could not find. Please point me to specific parts of the code.
> >>
> > 
> > In cv1800_dmamux_route_allocate.
> >> +	regmap_set_bits(dmamux->regmap,
> >> +			DMAMUX_CH_REG(chid),
> >> +			DMAMUX_CH_SET(chid, devid));
> >> +
> >> +	regmap_update_bits(dmamux->regmap, CV1800_SDMA_DMA_INT_MUX,
> >> +			   DMAMUX_INT_CH_MASK(chid, cpuid),
> >> +			   DMAMUX_INT_CH_BIT(chid, cpuid));
> > 
> > I think this is.
> 
> So where exactly? I don't see any define being used here.
> CV1800_SDMA_DMA_INT_MUX is not in your header. DMAMUX_ is not in your
> header. So what are you pointing?
> 
> I don't understand this communication. Are you mocking me here or what?
> It's waste of my time.
> 

I apologize for my misunderstanding and your wasted time. I had 
previously thought that hardware constants is also binding. This 
leads to a weird communication between us. Since I agree and 
understand this file is not a binding, I will remove this file in
the next version. Anyway, thanks for your kindly explanation.

Regards,
Inochi.

> > 
> >>>
> >>>>> And considering the limitation of this dmamux, maybe only devices that 
> >>>>> require dma as a must can have the dma assigned. 
> >>>>> Due to the fact, I think it may be a long time to wait for this header
> >>>>> to be used as the binding header.
> >>>>
> >>>> I don't understand. You did not provide a single reason why this is a
> >>>> binding. Reason is: mapping IDs between DTS and driver. Where is this
> >>>> reason?
> >>>>
> >>>
> >>> It seems like that I misunderstood something. This file provides one-one
> >>> mapping between the dma device id and cpuid, which is both used in the
> >>> dts and driver. For dts, it provides device id and cpu id mapping. And
> >>> for driver, it is used as the directive to tell how to write the mapping
> >>> register.
> >>
> >> So where is it? I looked for DMA_TDM0_RX - nothing. Then DMA_I2C1_RX -
> >> nothing. Then any "DMA_" - also looks nothing.
> >>
> > 
> > It is just the value writed, so I say it is just a one-one mapping.
> > Maybe I misunderstand the binding meaning? Is the binding a mapping 
> > between the dts and something defind in the driver (not the real 
> > device)?
> 
> Binding headers contains IDs which are used by the driver and DTS code.
> Hardware constants are not bindings. Register values, addresses,
> whatever hardware is using is not a binding.
> 
> 
> Best regards,
> Krzysztof
> 

