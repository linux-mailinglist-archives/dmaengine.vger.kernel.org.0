Return-Path: <dmaengine+bounces-1335-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AC48779DE
	for <lists+dmaengine@lfdr.de>; Mon, 11 Mar 2024 03:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC531C208A7
	for <lists+dmaengine@lfdr.de>; Mon, 11 Mar 2024 02:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC49010FA;
	Mon, 11 Mar 2024 02:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="S26B6Uzk"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE83B7E8;
	Mon, 11 Mar 2024 02:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124737; cv=fail; b=oF4r4MQfte+QKfJoKcQz8vQr3pzXYyRmW45m4MofCLtTiiLUxn+oBn58ht1va/RTsjB353D/kEl4tKRVtYPX+beHxDHffFLoHK82X+Rz1qIUpl6d2okSAteuq50R6IEGVcfFd/ABx6p5BuhYpUQH/46WnA0XgIMu0nUTux6dr64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124737; c=relaxed/simple;
	bh=UWWU2CEkbqLMLdSB7VzwqUDejdYCU8UecqmoIwoyu+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AR4YuNFUhKLIGaZGGDvSu9jzs8EzeW5xNtf+j4B44x/tFK+97tVNRoEEcvhlVA3w5I0mBnvM9iaLVylew6ZS5TrKvtwwtxdteqarHzEZchpKqdlBABmbw7A4pcm/yTIeEDdkeTIqgecsrD0dThehADFoUoWkqPbCRlWbS0vBja4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=S26B6Uzk; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fp1GLTD4yCiU01/J0N7rbNefw6r7t+7tXOoUCWDCPskmfuzTDsldUYJNOwoxUI238kZd7pPnnF1chWbV1Jm7MRvBqXiGmQ7xT4vlA/jbzO9HCW501K1TIKYlH++2oYzW1buAy58SUXClL33KscAG4NYqm8LSYOHxsU/JZWxizFpP7giKT34zkbZWo0S8K7KyihMTOfKC0+bRIcSz10DuDB0OEE8yw45SY/KY2KmL6ZUQK1oC0eEtLTJ6g4/FCz17LKsvaK7lpW7iOJsAyoeYPtrY4hUqHHYeMFvjQHkjODj98DApHxG9oE5WFuF0CHC4qX8O/+XirZKQNGyaTK4c1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFSQvQS/Fe3RKPGd++D3VMYVbxQfM78TxosUSZN1LDs=;
 b=cRP5RphwbIeFj76lznoZqVkUKkuT1hTzh/QJluPUfDCpSU0azA6A0PX3d2CIsH0tu44YwDkoneZbEucyHnoUm/DQB6by4ICjRB7eEiI+OSYoEB0kkn4iFbQB05DNb8VXWBErUJwGVq2FTMqNm0xVcF9w5YCnvoV8HNGivnsZc7U0ehN/Z0hQpU0S7Jahq9kptKLm/0NgIJwYyiQCWoxVO2ZQmvYeF4iXsdINOcGEkHiEYJNJlsUX0poDuHaWDtniFFfNkOBPx463AGwvGuHc8+5QwDeRZ37ltx4PW67y5yCxntMeUUH0K/RnpVoC/jcCFBGmw74iDDOVZessQrjfkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFSQvQS/Fe3RKPGd++D3VMYVbxQfM78TxosUSZN1LDs=;
 b=S26B6Uzkce102ApQcZC8/3wLUwu/xJ9K/OaF4JF1vK0kHYA44ufJoT/HIjnxVlfdQvhE/cH3fY9LChKKdWVtTId0RbPIjYQgcRn1GzR1r3HdNjim3o4xmMo8RYck2Kqr8K8bK6GQww0phks0UDcL6fkFjM1XIYdHGW1aQDVeDvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9978.eurprd04.prod.outlook.com (2603:10a6:800:1d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.34; Mon, 11 Mar
 2024 02:38:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7362.031; Mon, 11 Mar 2024
 02:38:51 +0000
Date: Sun, 10 Mar 2024 22:38:42 -0400
From: Frank Li <Frank.li@nxp.com>
To: Rob Herring <robh@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Peng Fan <peng.fan@nxp.com>,
	imx@lists.linux.dev, dmaengine@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Joy Zou <joy.zou@nxp.com>
Subject: Re: [PATCH v2 4/5] dt-bindings: dma: fsl-edma: add fsl,imx8ulp-edma
 compatible string
Message-ID: <Ze5ustkOPNYpXubj@lizhi-Precision-Tower-5810>
References: <20240229-8ulp_edma-v2-0-9d12f883c8f7@nxp.com>
 <20240229-8ulp_edma-v2-4-9d12f883c8f7@nxp.com>
 <20240304164423.GA626742-robh@kernel.org>
 <ZeZZyTU8FWACW9aj@lizhi-Precision-Tower-5810>
 <CAL_JsqKU=Qay75i1zaasaNHCV2jkseX94fzfe-4AwrV093NOLA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKU=Qay75i1zaasaNHCV2jkseX94fzfe-4AwrV093NOLA@mail.gmail.com>
X-ClientProxiedBy: SJ0PR13CA0087.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9978:EE_
X-MS-Office365-Filtering-Correlation-Id: eb0562cd-1012-428d-d085-08dc4174630b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OsHW6rKGSL4vWE2rmZyfIkmjzKM3osa7UQRFgfVzCd3xGp867+FlDB+7MtOyLxgfxHqe7fQFje2jBDadZAwYmMu2SCrf4Hy+4aPxDreHqvhVzZ3JZD1r1OwY/fgut47BG8pphZbL3MIDuvciAYAn3fOrz4nNzyXavy3Ey5oNsHfFeR/vNAHIJo6BxpWs9k3zQLbX+y3UARX0WCfPfRx+8x+yd3jZbJ6sBC9AmNeXWaBuWarsG8u/PwKjHEMhq3znU2gn/jUmmolnTprHqQx/3K4r0HcuvCstkqradF0Tr9lUDAkk2oTTXHbwUL7H/aijxWNAFX5va0xABYX7k2LhSLkTNgMeN0h7ODHp8Yrg9agPWcGFepxK0221Kpfun+bra7p/2H1uaqM8yoZ65yQb+Zg330AvfPX3hwMqmTMroxqkKuH3HUCnbeZ9+dwmmoNNWsW6t9gzZsdc8gCJQ6rrV75lsTwqnxx2WaMPElwI7H24ZDVh1DeEy2sAmQzxiOBCFNdy4nfrb35TJ8fq/8tOSWtq+wudiUiRwdZCAhU7xRDlLeBPUzIuwg2dm2PWsHrUabNwN0MiD8SVSF5xM25HqHG8ZgKZ8KzwmthdmDjp4eLvTyfnMsZNEFn+QfRwhQ1ESI7DegrKpH9mVfqnUeee48twQzBBut3FvXGHfLQuoR3+Id121Lrkqs7tLIJ9iBWp5qODuZpZQ2aEPW85KgGz+GzOdcPMaM3ppekRd2bRB80=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3p2d2ZTcGZ6endSWk5VZk50N1VEV05SR3NLK3J3K2V2TnB6dmhjWmpicHhS?=
 =?utf-8?B?NTBBd3hxRk9VcG9NRDNjUGhzb283QWp2RTI0ekZsKzhvekpHaklsdVlaS0xy?=
 =?utf-8?B?RU1pQzJXQ1BFT285Ynd6SzRGYWY4WVFheTdBSStFWVFyc0pycWFrY3N2Mkkr?=
 =?utf-8?B?QzdxUFpUb3VQaVI3TyttL3VUaWZHcWx6d21oaG1mSUNIRlFIODExNDNObHQy?=
 =?utf-8?B?bVRHdkp4Wmg0S05JUVhBMWYzM1lITzVJdjhCNmVZOUN1WE9YY3BXc0o4ZnBi?=
 =?utf-8?B?S1ptbDdYMXVVL2VnSURORTJ6bFJnNmMrRWVUOHFHNnQrYWFVTWsrSVdWMzNI?=
 =?utf-8?B?Zng5ZVRmZ2dMM0paRjEvYVZ5S3BZT3dDck51Wkw4aktLOHh6NnFNbi94d3hi?=
 =?utf-8?B?Z1o1Z2tNcGs3b0YvcDJzV2VnOXFuVU9rSWxtcG1qdFpmckVwN0hRT0h2N2di?=
 =?utf-8?B?bENJWU93Qks0aDA5Mkl1Vmc1OG9VZW9iZ29JOHZ2TmVhQlFHNkdZV1E3c1c0?=
 =?utf-8?B?Wm5oTWRtV2x4NTl4cm0zamNSQXFmbFd0a3JhVTM5SExiS0NIeGhGQ29OTHZh?=
 =?utf-8?B?OE0rRFIrbnE2VHJRTjVadms5T3NvNG1VQXBiczNxWEJ5VkF6UGxORktBNGVQ?=
 =?utf-8?B?YzZRbDh2VjVHNTg0SVFDQ3Byb3lWMjlXOXFlTVNMQzNtUlNyUm5nL1hrL2h5?=
 =?utf-8?B?TlRUSGJ4d2JEcTBDSWFkWTQ2VG9ZWUZwb0gwVnFzSTJ1OFc2bnNDanBqejlM?=
 =?utf-8?B?Q0dFVENFWVQ0YmJzYlk0ZmFLZUtESHlvbW1HaVp0TFBhOThmTVVHN3FkeXJi?=
 =?utf-8?B?SlZQM3VXWUdNMVF1R0FIUHZGY3laZnVLeGVLdm9ieTRoQ09MWlJzRU84eXlo?=
 =?utf-8?B?cllqazIyaHlSMzBpSUZ3M1hqOE5KZHJ0OUd0RVhzV3M5OG9yOHF1ZkwvZVl3?=
 =?utf-8?B?Rk5adXUzRWQ1NjlPWmQ0RGRWUUZkRnBGUjdQbitZRmhyNk93MTFTVCsyMGdY?=
 =?utf-8?B?MitrZ1kzeWJqS1NhT1l1bFBzcm5UWmJ6bm56MUpUb1JNWm1BekF4cGZlWHAx?=
 =?utf-8?B?RUpmTUhyVlA3cGtIS3UvQWR4MDdZTTZrMzZtSXZUMm1GZFRsZGppcXZpRER1?=
 =?utf-8?B?UVJ6YlpLR1k2a3laSS9sR1pONFVCdjBuL3NNejk0d21seXFJUHpqRm03RGxi?=
 =?utf-8?B?R0ZTc2lrcFhONGs3SHZBTDdXSE9pa0pEWkUrbEZnUWNXdW4wY3NwZWQwSzdD?=
 =?utf-8?B?b3VjVnBTS0p0NDZaZXVKYi9qRk5Nc0hLelFDbEtBYzFtdmpwTHNwNndoNU4r?=
 =?utf-8?B?VkQrUDVKYS95US9aclI0Z1FReWlEemVoaFQ3bzJFYUtYMEZYMEU3YW8zYWtY?=
 =?utf-8?B?eGw0YW9hT2pSRk5mRWFVdFovdHNvNU5YcFpuOEYvTXZuUmhPR1I5a2RmZTJh?=
 =?utf-8?B?L1JWRlZUZVhZYTdDSVRhYW9jZW9QZW5Dc0JodERFaWJyQjdnZStZVVB2bEdP?=
 =?utf-8?B?Yit1ckVQVENKZzVqSEtlOVZkU2c0U1NtVkMrR0RHRFhlN2gyL1ZJY0djZWZp?=
 =?utf-8?B?eXluSTNkTHpLNDluVlhQemttbHJ2eGtKUDVhUmQwOXRabjc0dDJlczZrMWxz?=
 =?utf-8?B?dXRxaUtCRWJuMVR5SFp4SFptRWFPS1dKVU1QUUpjR2ZqRkljVXdJWituMGt0?=
 =?utf-8?B?V3ZVbGgxdHJncUZ2aWZuM2JlS3ZkSEhNVjNPS1pWdUNmbUhVTDVPckhrNWYx?=
 =?utf-8?B?WitCRWxCS0dGVytuWFNzcFBjdWdvWEYrRjFDdmlCVE40SWU5aFJzMm56RC9W?=
 =?utf-8?B?UkV0c3ZmYjR4MzhDUGs3Mkt2K2ViQit5cGdTVGEwbTRRM2pxVXBVYnZhdC85?=
 =?utf-8?B?V1pROUt4Y05mZWRmQVhzYVVwTWZhYzF1RXdwdVJORHNVa2VMS3RPRXdjelVQ?=
 =?utf-8?B?T05hU21EaHN3cU4wQWRYQzY5N1M4L01UU201Y1NsNnpCK1d6NTJuQzVCaWp6?=
 =?utf-8?B?RFRwR0Jrenh3L2ZVd0ljRnBRdVlxeVo5M0g3QXdJdmQ0U2oyeXEzZEpMTnI3?=
 =?utf-8?B?RmtFZFVMVFBjT1RFR3pPenNodTNqOE9uOEV3S1p1cElXakVDSWc4clhxR3pn?=
 =?utf-8?Q?zzGk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0562cd-1012-428d-d085-08dc4174630b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 02:38:51.5235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nCGoM0c8V80Jj2QOSTclmsjDPC+Z3HC2+z8C7/Hs3hKb/V9VavzQv5vDU3YAUZ9Y22lkV/7BGxsnBMqhcCWYhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9978

On Wed, Mar 06, 2024 at 02:40:23PM -0600, Rob Herring wrote:
> On Mon, Mar 4, 2024 at 5:31 PM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Mon, Mar 04, 2024 at 10:44:23AM -0600, Rob Herring wrote:
> > > On Thu, Feb 29, 2024 at 03:58:10PM -0500, Frank Li wrote:
> > > > From: Joy Zou <joy.zou@nxp.com>
> > > >
> > > > Introduce the compatible string 'fsl,imx8ulp-edma' to enable support for
> > > > the i.MX8ULP's eDMA, alongside adjusting the clock numbering. The i.MX8ULP
> > > > eDMA architecture features one clock for each DMA channel and an additional
> > > > clock for the core controller. Given a maximum of 32 DMA channels, the
> > > > maximum clock number consequently increases to 33.
> > > >
> > > > Signed-off-by: Joy Zou <joy.zou@nxp.com>
> > > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > > ---
> > > >  .../devicetree/bindings/dma/fsl,edma.yaml          | 26 ++++++++++++++++++++--
> > > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/dma/fsl,edma.yaml b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > index aa51d278cb67b..55cce79c759f8 100644
> > > > --- a/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > +++ b/Documentation/devicetree/bindings/dma/fsl,edma.yaml
> > > > @@ -23,6 +23,7 @@ properties:
> > > >            - fsl,imx7ulp-edma
> > > >            - fsl,imx8qm-adma
> > > >            - fsl,imx8qm-edma
> > > > +          - fsl,imx8ulp-edma
> > > >            - fsl,imx93-edma3
> > > >            - fsl,imx93-edma4
> > > >            - fsl,imx95-edma5
> > > > @@ -53,11 +54,11 @@ properties:
> > > >
> > > >    clocks:
> > > >      minItems: 1
> > > > -    maxItems: 2
> > > > +    maxItems: 33
> > > >
> > > >    clock-names:
> > > >      minItems: 1
> > > > -    maxItems: 2
> > > > +    maxItems: 33
> > > >
> > > >    big-endian:
> > > >      description: |
> > > > @@ -108,6 +109,7 @@ allOf:
> > > >        properties:
> > > >          clocks:
> > > >            minItems: 2
> > > > +          maxItems: 2
> > > >          clock-names:
> > > >            items:
> > > >              - const: dmamux0
> > > > @@ -136,6 +138,7 @@ allOf:
> > > >        properties:
> > > >          clock:
> > > >            minItems: 2
> > > > +          maxItems: 2
> > > >          clock-names:
> > > >            items:
> > > >              - const: dma
> > > > @@ -151,6 +154,25 @@ allOf:
> > > >          dma-channels:
> > > >            const: 32
> > > >
> > > > +  - if:
> > > > +      properties:
> > > > +        compatible:
> > > > +          contains:
> > > > +            const: fsl,imx8ulp-edma
> > > > +    then:
> > > > +      properties:
> > > > +        clock:
> > >
> > > clocks
> > >
> > > > +          maxItems: 33
> > >
> > > That is already the max. I think you want 'minItems: 33' here.
> > >
> > > > +        clock-names:
> > > > +          items:
> > > > +            - const: dma
> > > > +            - pattern: "^CH[0-31]-clk$"
> > >
> > > '-clk' is redundant. [0-31] is not how you do a range of numbers with
> > > regex.
> > >
> > > This doesn't cover clocks 3-33. Not a great way to express in
> > > json-schema, but this should do it:
> > >
> > > allOf:
> > >   - items:
> > >       - const: dma
> > >   - items:
> > >       oneOf:
> > >         - const: dma
> > >         - pattern: "^ch([0-9]|[1-2][0-9]|[3[01])$"
> >
> > I understand pattern is wrong. But I don't understand why need 'allOf'.
> 
> The first 'items' says the 1st entry must be 'dma'. (It might need a
> 'maxItems: 33' too now that I look at it.) The 2nd 'items' says all
> entries must be either 'dma' or the CHn pattern.

After dig into dt_scheme and json scheme, I start understand what your
means.

"clock-names": {                                   
    "minItems": 33,                                
    "allOf": [                                     
         {                                          
            "items": [                             
                 {                                  
                     "const": "dma"                 
                 }                                  
            ],                                     
            "maxItems": 33, 
            ^^^^^^^^
      Here need a maxItem 33 and make sure first item is "dma" and total
array is 33.                       

            "type": "array",                       
            "minItems": 1                          
         },                                         
         {                                          
            "items": {                             
            "oneOf": [                         
                 {                              
                      "const": "dma"             
                 },                             
                 {                              
                       "pattern": "^ch(0[0-9]|[1-2][0-9]|3[01])$"
                 }                              
                 ]                                  
            },                                     
            "type": "array"                        
         }                                          
    ]                                              
}

The yaml source is

          allOf:                                                           
            - items:                                                       
                - const: dma                                               
              maxItems: 33                                                 
            - items:                                                       
                oneOf:                                                     
                  - const: dma                                             
                  - pattern: "^ch(0[0-9]|[1-2][0-9]|3[01])$"


But unfortunately, 

dtschema/meta-schemas/items.yaml

    type: object                                                         
      properties:                                                          
        items:                                                             
          type: array                                                      
        additionalItems: false                                             
      required:                                                            
        - items                                                            
        - maxItems                                                         
    then:                                                                  
      description: '"maxItems" is not needed with an "items" list'         
      not:                                                                 
        required:                                                          
          - maxItem


dt_binding check will complain
	'"maxItems" is not needed with an "items" list'


I am not sure how to go futher. Maybe below 'stupid' method is less impact.

items
  - const: dma
  - const: ch00
  ...
  - const: ch31
	  

Frank

> 
> > 8ulp need clock 'dma" and "ch*". I think
> >
> > items:
> >     - const: dma
> >     - pattern: "^CH[0-31]-clk$"
> >
> > should be enough.
> 
> If it was, then I would not have said anything. If you don't believe
> me see if this passes validation:
> 
> clock-names = "dma", "CH0", "foobar";
> 
> > If you means put on top allOf, other platform use clock name such as
> > 'dmamux0'.
> 
> What? It's under an if/then schema.
> 
> Rob

