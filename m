Return-Path: <dmaengine+bounces-1489-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F95D88B8FA
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 04:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D783B2C2DE5
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 03:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442FA129A7A;
	Tue, 26 Mar 2024 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="EDcQYzEt"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2037.outbound.protection.outlook.com [40.92.46.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C57128823;
	Tue, 26 Mar 2024 03:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711424955; cv=fail; b=A3MjRDvgzj2V7ND3as/NiHqpaNyLeEyC5I1IknDmNnVRDV5yoJxf9xbO5PQT/8P0S6tOXowA6xs25ZPxoinYNgRP6LY6XrB/4xb102WMHbOgB4v61O9i/es++TMxPXknFIDGdbjhztKdH2tiFXlzrBGYGvLIT60Dg5DpC/kIGPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711424955; c=relaxed/simple;
	bh=PzrvRShpMTXcWrwCB0dXqsinyj1PZ0cFCYuW2RmhQO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iyzrB9P6WopGfjebLGIaefN/ZWPS0W6ePeqQkrK6d6VXXubLar4FOFyfXuaoKy13upv61f2vkYfgIGzxHoOvKwklbapBCaxH3liDXKU0bfhCJ2glswFPwrh9w0AlvXNxPbzuQx1Mag08X85tLea9DVT1RHKIuVyf5i0KNKmwACs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=EDcQYzEt; arc=fail smtp.client-ip=40.92.46.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB0ulqcQZTT4mfmWEMhOwT0i6uBIiLN6rDdbiyxqBQchTCZnYrzBEdLpyat+8g/JIqchcfSpThj9zE/i4yOGx+7k95C5y4nH8DxE8lPg4RfBzYNiVV2GdqoOEE78/iexItQslICE5+lTuKpcTRwI/NnCFZ2hpEfNCKxyHhzMGzRuw+sDlOByrDd6ic7G7QhWLMimzgaaYkdKUnB8eoCTwMkCxRmjZG3vviy4UZ0LCos6nh6u3GKo8bfpllR7Lxu3GBwKDYZ3+TcOuVFyr17i7CQhM/dI2HUeD5XHNODWqxNpCh0kTliyY4m8+FAZiECyFTP/+X6uC8ErALd5wQBYrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p5YfOcxJCSWRwShjx3CXCGHIkjc/FH8KTY5PHD74Wjs=;
 b=dLiCM0bTe1rb9F7vpRjXpJXi1DuuPSsB0wKotfJzUdbEsucLsJfoJG03NI2oycRVwQ6xnVgJZbm0WXyyhaNldJwXn/KTmDR0SdoyjL+HNppmTKz2z1iYRbp5uRu1Ypz0c8IP5PzNZfkPHn0CsJL9KRtsOoh+uSUorZclEKjnUokC3gb9xuNGZDfd9OJD/yT2M1/1y7hSDuu0MrPCAYo6AtUf6Gu4xIjSKmD/BKlJKs6Th+sOfoy06Q+nW9MWMyvIJxzhQeEEcB5n2JehZQYINOoZBbg8tm5ot0EDUQFqfUUTcwKv7cF+wXs3pcRNPJP05QIdrI/Oi26xssPTAeA4Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p5YfOcxJCSWRwShjx3CXCGHIkjc/FH8KTY5PHD74Wjs=;
 b=EDcQYzEtE1P8W81vLU6JqRocCZMbk01FJc3F3OLzL1872oUS7nCtftgJlxEBrZcuKsKEGTPwjr7g7P2GdzfYrO2ptAcXJ9K0KcBAi5ona5z2ujMDSaVCUhXDgLFiR0muVjkO9kpFpchcfYmfe5xeOTfBRQ/hTlwQgr6Sc4e6QjV8aegEfZsCPGGqqaufAbiSrt9JtSvr58eV2+jPYAaEAPJx4eWDc+CYGpJ1XBCsB9sqhagTBEob+KbyCJsH5I0bVe+vSuty6BMau9s32s2u4uTdi+DKNeTPQ1GDRRURLEh6kAINhgEHzTgwq3ssLzPvpn5MlF4PXw2sV3dnv5vbbw==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ1PR20MB4883.namprd20.prod.outlook.com (2603:10b6:a03:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Tue, 26 Mar
 2024 03:49:10 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 03:49:10 +0000
Date: Tue, 26 Mar 2024 11:49:15 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Frank Li <Frank.li@nxp.com>, Inochi Amaoto <inochiama@outlook.com>
Cc: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, 
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: dmaengine: Add dmamux for
 CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB495309ACE73C4308F1329375BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <ZgJDCL+aq3ZTE6/1@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgJDCL+aq3ZTE6/1@lizhi-Precision-Tower-5810>
X-TMN: [mw9wSZjSZKgP+XZvTYYzxcyMX0qfkNAftMfEIDQXQmM=]
X-ClientProxiedBy: TYCP286CA0151.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:383::8) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <vyzqj6ykjjeb37bh3enxngsevrovixxsqgi22jezbk7pjniqii@x2i6p36zxfyr>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ1PR20MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da90dbf-aedd-4658-3caa-08dc4d47b179
X-MS-Exchange-SLBlob-MailProps:
	RlF2DIMZ1qXOkXGJ+Mozsa5bhT5ExeELhvMJURViLdTEECx7fx12iLB70y/l+lS7/0sRFhXvDucEYu/IphHy0Ac/eGgCywhG9zCrq9jg7L+B7foBdii8eKkdzkrFIfSzEa4kaCWGrULbs40V2JS0Wp3WXWC0xPZgvYCFe1ZB+6P3MBO64iFP43Qv7h9JqLA1Vx6+DuQtEJTFyOppM/GocyRiJYVk92Jyy5H2WyFyO61Ym+1FkGRrahpziSWMREcvs6mGzKOqAd41MkhDC1xJ1CViIH9CFbD35yv8Hw3gHH+kud3VfPpzVZ5mKH1OVGjPfBeToJXpZt+zCwPglxWU/zgEIo+CgIyXEBXatR2EbLgcxGU7OXtQyX5yQeF4nZ0rwf/Fh9JoZOksMws6+57FZmjeJCcUgz3w+KAgIYablQzthaAabKmUTGvANCec4+oK7jQvJpP/5ESIg5+Zhk4jvSLYUJ7quweCYgSwna6iSoZBKR92QLPpI1JDDkKRKLSfpfhtV5/da5d2iL82tJMwTds8l5pUkHVkJQ+hZWxP5F6bf71VMrLFsXNL2KDpjuV8py5mYm3+JKl4aNwECVQN9ecOewXJoQQOeo5yR52hEwENfhiCMQ0J1wxDo5Jrq3bBffxvvVEHaFeEliDZnqieDw45Eg8OgqSWc8KLDF3IwRp0lUfizR9INOOYLg0lVlUvubYV6iPrUAnGzjSSxHBe/dyPTiVkY4Vd/qWxqMha2ZDSnEbPZ6EbGxHERtqMyv7PzEhx9R8ok1spMfstl2YHHi2r4Cfrz92seP/czUTRaOI7/S8k74zFxgNxbT4ly3Jbra+uyzT2znXgq3IWPVJ82Ld3PdQ/ibq1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YOWzGq5yFGa9ikoUj3UlZJzqzfPPQStT4VWyN9CKab107sKEzM7c/0WezGNKPHBg9IxAPFkoPFVczmISfc+o0Oi2d7c9KJ6Z+3lBAyjOXcWuR769RnEVHYTpXgvUqhPcHnZBaU5BpNrToHwd86T4F4GMRDEINsEnFGO/1CU7L0v7FWeUcdjyPhwIV5Tkrfoeob+RypfkBRdkKZ8BXIkTWTpf17oFKzhitCtT7L2xe/ygRytqOppjFdZgVq06ptD4scQrKIKWwRVAyZl9Z6YZCKH2LIPvzl5CAohovKykROLV2Ti8KqXk0RzQ/kgMwLqfBWAGBbtQgF37s3KRH9AKMx/gtpdSckOOporwztdIoXSPEG+JIT++SzKuTS8F6oM7vt73B6I/c4UosNXJ2Gw5CBT41fq61jYxXYj1JYH/ngFPTbiV8emMBNmYQBjbHZUPiETTgTVnM0NkYuGUsYjoMmfzvRLyOcfgFQdOUITxqmcXG91C35l4rwDj0vEpTvWF+aBnSW95XyrL5Od5GkBXrq1IdtCCY8qgFSsCnrpMtNlQ7NK4aFUZOm2InzTvHJ1QWRgWRIdfUl/tnRTPewgGK/e5CupmZZyuIPNbG5X7AwVXw1HIfUDjGrL5XLCaPD5ljnwHlqoKP3WnxyePYlu7ti2v7Vror198684xYD8issJPZCoAIEnUvqe5RkQ9nZqeicVAdSDYqd/Vc7pZB5wrzQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JaWjRDIdofz+dsFB2KIOHCFWI5AACD54Tv5K29nndB87m/HvZsDzSpIVZhF+?=
 =?us-ascii?Q?RtLBAjpAy2HOcs31g/oaKv1RULFeFxvuUImfQYNOZHTvuDsGqUrp77T6f87/?=
 =?us-ascii?Q?ZNWW4BWfirm18AUvVdBCWIjby5RB2c0E/lbdXS79seHhszhaNygHHazLCJMA?=
 =?us-ascii?Q?b+2omgOPJa61eabPGGl7K+z4sbGnD7T+oRyd8sa/PiVyma8smvd7wg14N4Cm?=
 =?us-ascii?Q?w8RfnQ7r2iaQVJRUnJmj0Qoa2YozJ5yD5bY9DpAGREyZN7PkbWNe9Ejywxrf?=
 =?us-ascii?Q?2zhSoasBHxReBvvA4PMBry8ima70Sw5Jj1muhvGQlm5MSaVjDZcSS4kNncwF?=
 =?us-ascii?Q?151PbJ9LgHbgnBBWjirsZfogoQvvBROv3bI5kkFAZc9G88EOnYAlI2ZuIt5N?=
 =?us-ascii?Q?qcX/FtKb+56YprdEb5hUEmuMQ4fHjlsct5WxcLgXTsIFuf+XUfLnYIgkioEp?=
 =?us-ascii?Q?c16q3GtjWIhKcWJyXgmc4/mQPZs498of3T6i5LHwDSBf3a3fScL+t8swDgmP?=
 =?us-ascii?Q?7EdJRVByqG2l1tMEAmcwXVagsDN+Vsmc1h/v8F/E3ZvpZDraP/9wdXjYdh5x?=
 =?us-ascii?Q?Jrn7guaXcUN0oRia+ssS3wH4d4TnPg3fJtaAWu5YLQ+3L777icwiWIjWAErs?=
 =?us-ascii?Q?tUwQpAPSdhV3AnkJd9aUnMcKwH35FBDYu5gSfpd/nc97Z6cDtIJ3Z8c18gur?=
 =?us-ascii?Q?rn9S+fK38OstoRqPfoPmlfixghu0/voVNFiMtZW7N1KCOUFMjLko+KzQ0aZK?=
 =?us-ascii?Q?AgMUMG1QI50EEPlmlZE8Mmd+TUb/2Gb0n7NnYQTNZRDGHnI7SIiQfMM/xyOM?=
 =?us-ascii?Q?rebRBoNtn/qVfJNZ0rjxfqQV846tXx9dPltn8M2nrGdu9NsFhOw3ShjF1Psz?=
 =?us-ascii?Q?l3xTaAfqko78B4cjxXlRw6g4P0rUrDstjO01IsvLnuQUO7qCn9pczWhyLqsW?=
 =?us-ascii?Q?lnrJns+dYbd9p8RqJ+WWo4R7sMBmqBNrwyZQ2O0crqQSCJxYDbcpiW2yLdhF?=
 =?us-ascii?Q?PSfwri7vlDI1P/bBMId4tV/linCfAdNl+BG7nt5+o9JxlMjD8L3oWcODKsDk?=
 =?us-ascii?Q?FHNL2/nXhy+ciBssze0QcCIZkG0fhjE7u6NI9ICyfhNmE/QWahuJ88W8/FGy?=
 =?us-ascii?Q?EExjoQJvvIDdq+dz1XX+6ACpbJ1qAynLdfE62cUsu45GxkMSbirRHgMYsdcC?=
 =?us-ascii?Q?pnP9qgf8GUyC2aa3NxHVky77joC4bQNERsdLtq7bfc8PdEFbnYJNW9OXgKX/?=
 =?us-ascii?Q?FZnoh17+GfY/xQF9ffkz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da90dbf-aedd-4658-3caa-08dc4d47b179
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 03:49:09.8013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR20MB4883

On Mon, Mar 25, 2024 at 11:37:44PM -0400, Frank Li wrote:
> On Tue, Mar 26, 2024 at 09:47:03AM +0800, Inochi Amaoto wrote:
> > The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> > an additional channel remap register located in the top system control
> > area. The DMA channel is exclusive to each core.
> > 
> > Add the dmamux binding for CV18XX/SG200X series SoC
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 48 ++++++++++++++++
> >  include/dt-bindings/dma/cv1800-dma.h          | 55 +++++++++++++++++++
> 
> I remember checkpatch.pl require .h have seperate patch.
> 
> Frank

checkpatch.pl does not give warning like this.

> 
> >  2 files changed, 103 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> >  create mode 100644 include/dt-bindings/dma/cv1800-dma.h
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> > new file mode 100644
> > index 000000000000..d7256646ea26
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> > @@ -0,0 +1,48 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800/SG200 Series DMA mux
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +allOf:
> > +  - $ref: dma-router.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: sophgo,cv1800-dmamux
> > +
> > +  reg:
> > +    items:
> > +      - description: DMA channal remapping register
> > +      - description: DMA channel interrupt mapping register
> > +
> 
> Look like driver have not use it.
> 

The driver uses syscon offset to access the registers. This dmamux is
a subdevice of syscon.
And this properity, suggested by Rob, is just used to keep DT complete.

> Frank
> 
> > +  '#dma-cells':
> > +    const: 2
> > +    description:
> > +      The first cells is device id. The second one is the cpu id.
> > +
> > +  dma-masters:
> > +    maxItems: 1
> > +
> > +  dma-requests:
> > +    const: 8
> > +
> > +required:
> > +  - '#dma-cells'
> > +  - dma-masters
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    dma-router {
> > +      compatible = "sophgo,cv1800-dmamux";
> > +      #dma-cells = <2>;
> > +      dma-masters = <&dmac>;
> > +      dma-requests = <8>;
> > +    };
> > diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
> > new file mode 100644
> > index 000000000000..3ce9dac25259
> > --- /dev/null
> > +++ b/include/dt-bindings/dma/cv1800-dma.h
> > @@ -0,0 +1,55 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > +
> > +#ifndef __DT_BINDINGS_DMA_CV1800_H__
> > +#define __DT_BINDINGS_DMA_CV1800_H__
> > +
> > +#define DMA_I2S0_RX		0
> > +#define DMA_I2S0_TX		1
> > +#define DMA_I2S1_RX		2
> > +#define DMA_I2S1_TX		3
> > +#define DMA_I2S2_RX		4
> > +#define DMA_I2S2_TX		5
> > +#define DMA_I2S3_RX		6
> > +#define DMA_I2S3_TX		7
> > +#define DMA_UART0_RX		8
> > +#define DMA_UART0_TX		9
> > +#define DMA_UART1_RX		10
> > +#define DMA_UART1_TX		11
> > +#define DMA_UART2_RX		12
> > +#define DMA_UART2_TX		13
> > +#define DMA_UART3_RX		14
> > +#define DMA_UART3_TX		15
> > +#define DMA_SPI0_RX		16
> > +#define DMA_SPI0_TX		17
> > +#define DMA_SPI1_RX		18
> > +#define DMA_SPI1_TX		19
> > +#define DMA_SPI2_RX		20
> > +#define DMA_SPI2_TX		21
> > +#define DMA_SPI3_RX		22
> > +#define DMA_SPI3_TX		23
> > +#define DMA_I2C0_RX		24
> > +#define DMA_I2C0_TX		25
> > +#define DMA_I2C1_RX		26
> > +#define DMA_I2C1_TX		27
> > +#define DMA_I2C2_RX		28
> > +#define DMA_I2C2_TX		29
> > +#define DMA_I2C3_RX		30
> > +#define DMA_I2C3_TX		31
> > +#define DMA_I2C4_RX		32
> > +#define DMA_I2C4_TX		33
> > +#define DMA_TDM0_RX		34
> > +#define DMA_TDM0_TX		35
> > +#define DMA_TDM1_RX		36
> > +#define DMA_AUDSRC		37
> > +#define DMA_SPI_NAND		38
> > +#define DMA_SPI_NOR		39
> > +#define DMA_UART4_RX		40
> > +#define DMA_UART4_TX		41
> > +#define DMA_SPI_NOR1		42
> > +
> > +#define DMA_CPU_A53		0
> > +#define DMA_CPU_C906_0		1
> > +#define DMA_CPU_C906_1		2
> > +
> > +
> > +#endif // __DT_BINDINGS_DMA_CV1800_H__
> > --
> > 2.44.0
> > 

