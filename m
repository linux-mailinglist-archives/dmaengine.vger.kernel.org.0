Return-Path: <dmaengine+bounces-3033-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 736859654B6
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 03:31:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 010531F2274D
	for <lists+dmaengine@lfdr.de>; Fri, 30 Aug 2024 01:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D32825569;
	Fri, 30 Aug 2024 01:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="oms0GFJG"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11olkn2051.outbound.protection.outlook.com [40.92.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2C2AE94;
	Fri, 30 Aug 2024 01:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724981494; cv=fail; b=BV49+gkBUK01U6YkyZHFuo9LMacGoG9CwKBJlhI5ic77bC2UPU3GfCiQ7N5HN61fbWyIWOXwONuMrqTzjvnhxijx1DLEE4FQKqU7ARO9rMdpArbJJeyAqHDDrZyZZsyrn5kHCAYFhtNntZL6rK3IAo1MaIAK61noLQuBfac1wuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724981494; c=relaxed/simple;
	bh=Ym3kapvaeKsQ3yXzwmvld68tDynyvaZFpu/fRyzBor0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y3VhVDnKeF7Kj1m+/+Xh5xNjq/URZq3X389ChJ6GRkADkcS4p++CjilHqH+cPRBN8h/07frKkCCEM+rDN9dj506cRcfyj48OCFtjYgqk8Q1ipo/oZtKeTHVTQfZXadz0cycm6JsYg+wtPSuK3/P3jPIFDVNLyscbG87Kp/4jp28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=oms0GFJG; arc=fail smtp.client-ip=40.92.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2MDjOM9dg10jJ28JYjEUB33W7YYZmiIhO1KW8xb360RMkNZd6i5Vq705sGjHVcTUyJlFy5KluDU9TRHUOc7BTyk9sBIrNSipy75ZGksoXNX/oMwAXjAstYirCvwuvx+QROrbADN+jCFwja3xbsBOQZ/gZrehP0wBy9+M7RCvHRjQoQ3W/AdLPDtd7yuGttjMaC3gdWGX/39jLv81Q6o8k+nwZdJpBb0GlQIF5gk/eOKg24leXZ2G8mnjwDYYUi83FfHIw9UOGUxb6SvVUERPAe/MiRxRGBcbigTCJag3N83YdLqAvjCdLdmGmCo9vXOeYaDg2U2YYDDCJKXCuZI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeWoEYtO7tFb6w3Snja8XTqlLIXcTAHH8dLMY0fcYew=;
 b=JBnnKfDVu3G6Wc8ZjG9Ae1DAqi6M3aST2ZBv20HDWx9IAPGTLK6bRsYGQpuX/rPBdZUgDhLMwtqUsz1z5r8i05ju8yeGcnPviZU3Xo6JqajfLPtarqm3rSnRYerDDgpkffI2HLvoTy7jQSp/2WoPeBoX9l1edcdAXPqBNyB5jt76QJagMQJprTmD+3vFjhRDXzxdvb73BdIwHvjQg9v9Y75zz1RkaGekWOSl99mMWCgfyfmpeAkIs0+vIHt/vUrmnEq/uXk6cCwOXQiHaj01n3I9yaeTxZKor3vOQlMGRzDiaGK1nRJQzKE+G5whj7r8CmSo9pem34mTyC8Qr230hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeWoEYtO7tFb6w3Snja8XTqlLIXcTAHH8dLMY0fcYew=;
 b=oms0GFJGx0Mi/9Y6j+qfzNODD6Au54Ey3fty+uCF0UNs0g3ocdqb7I90hWzN9lmgF3xkWZ7GlwzZBmNMrbV+PyknV3WpS9qIt3i3fx0mEjiNP1kkQBYMbfBuLPvSdi5g+5NRt6aRKj+9+3Mnvp6p9Hm15EeoZ20CoQxynx3oHctqpp8MzKACpnu4Yv7f2UtREdAmR23g1V+MVXqE/juuM7AcuErmSmGV6Wmfl8qVTHqtYYPpyJlA/QrX7CJxKREa40AsiiFK3WJsnor85Ry9lb80voXoGGSCVQme1pe5T+UeewIy+sOwSsVhr2kqX1hsfLkBPq3EXexrxSuji5bvNQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by PH0PR20MB4400.namprd20.prod.outlook.com (2603:10b6:510:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 01:31:28 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7897.021; Fri, 30 Aug 2024
 01:31:28 +0000
Date: Fri, 30 Aug 2024 09:30:24 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Vinod Koul <vkoul@kernel.org>, Inochi Amaoto <inochiama@outlook.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, dmaengine@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v12 2/3] soc/sophgo: add top sysctrl layout file for
 CV18XX/SG200X
Message-ID:
 <IA1PR20MB49538735A53766A62553FEF0BB972@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495396729244074C36E51E11BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E0D56CE4010C470E4A71BB942@IA1PR20MB4953.namprd20.prod.outlook.com>
 <Zs9kUAeapWeN/4GS@vaman>
 <IA1PR20MB4953572077286AF23A747507BB962@IA1PR20MB4953.namprd20.prod.outlook.com>
 <ZtCp346ucJq/V1kP@vaman>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCp346ucJq/V1kP@vaman>
X-TMN: [ojUOndy1afC197dNqMq5BCEK9y/qk79Qg/GqW+8u3kA=]
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <gyqb7qjjouxwmvxot5vnfvlxwyeslpvqebws2vn6vs6pqktf4m@5rmfblwmzcja>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|PH0PR20MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: ca19e1d0-9771-419a-341e-08dcc8937872
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|8060799006|6090799003|19110799003|461199028|15080799006|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	bCK1b2E/q8U+gr8tJpXmkUA1y/u7x+fADKBz9gued9z9BS+oE7U2PRdBNiv9pLH+gQEyN/S2CrT6wil43Mhf0bnAFUSD+3+TZFHoQCMYCOXehF5Cxs4VtnrVuHLXU3WkWQYKaTJLZ747tjdrmqLF4qxkj9wkeI0FXXClIxVn2AdkVSZU7enNs2sMRdgYv+rY+TCvjix0PPRZ0C/WG9kt8fIvYGsC2W7u4z1RYVM2YwluumrJXfQusAglmDOmpyjo++RTGHnSzC94+bzzOIHUDdpg9oKtfo+emv5TZ8pxmBXeDIAvhJDUBi5+V3sRC3qfj5lZ0+WBXFNpXcT8T8JfKkxEUhxHS0QR30nugLOmWt9iGoUx9irtgxSNX6hG0baUAQGdjpiW/Htq6KLI658djC9Zc+Xe5bYK1RIg6JR3Lz/51jTLnOZgbv9tFMVBkn65luVfyXLlkbzS6KhUVY5x33mpaPE4EfNtzB70y2qDqaPr3p3i5jUNqmK3eOUwGUVA3Jbwk1dmcze097fulPjtFLUOTOIpy2TVkjS6SYZ5AAyLg4lAo4as2BvO26TyirYLaT6Z7uiytAOLEIeM8H9lKJbQe/jajKPiUDPK9YqjRFw0Je1tsYqlAKhYpngJCZCjP6t2hDa8nvVa/IschMx/ppVq0pEMVM2WE8D4Nrar6D/Ua2qEWQjdL2j5B/MD8ESWxurepY/vAEbf/q1/weaSjsdoT9MfZSKXkw9XpYafSzC2uczwHKA7pd1i6sUrFA3bmQoP9RK77NZzRfuKbshYQA==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QopufakQf46LOfgq+Fgv9kxB1cGvq0opWXAujT7dOWfg4ODglqOhjtDe46SC?=
 =?us-ascii?Q?Z+KGcFMTt0CSaR51TFL5USg95+vnNPq+53HIQXT+PsQw/htCwyJkyVAP2fS0?=
 =?us-ascii?Q?Mm+ybMujP/C4eCZ6jMkH3Wuf3en2sNNJhxSfrcWIXNtIZwhvsNOQbNRnoIGy?=
 =?us-ascii?Q?8Yym3HeXHCXBxxhuX87CP6DahL1FeOlsc7Du6G6eCdRzfRE6xML/k5aZ9sCA?=
 =?us-ascii?Q?PEWSWIVy25+gn8sxmUzt2LkgT0XQA4xtrQFz814+CKTi1mMAubboewrwYT0Y?=
 =?us-ascii?Q?YymRrqZok6NtYOZMTNGLgVsmu2PSizMomcQGhiyG4ZRN/Ktp1SQ1Z/eqEkiT?=
 =?us-ascii?Q?EUkWI1xA5j2Liv4svpgVyctZFRtb7xXEXMmC9yKLsraWcqED+jCreKm6nYtA?=
 =?us-ascii?Q?4DcAsRAuOZsFT4pYkuuKK0FoMLgADet9Zk9eQv4Q2xe9FO+3nyueElcyjSKc?=
 =?us-ascii?Q?sZxSVQxHpVPTPdmBAxAZlrgonsXyBWGmxTGQY1QKiOw+t8iPUHw0WrTQNKKB?=
 =?us-ascii?Q?a2Undj2RwyjjgHHj8u2L1q1bYteOwp5Uks2RKr5QNZfWZF6RddTq1ZUAWX7a?=
 =?us-ascii?Q?HpDBkYoxafa40HZ8X3EvwCMhGGMkNA0JVkEuiUbnnvBAU74VtYdyzmWNrY52?=
 =?us-ascii?Q?+rvspKRZRBjRMM76F7bC4fRaQI5pW1eNKj13I6jBa0QD0fneGv/tut+BxBpc?=
 =?us-ascii?Q?wvb8RCfZHLrzqsU0wPnptEAYut80IJITq/mH2BhJ85C6WkHBzgRWMzhrEjI3?=
 =?us-ascii?Q?9GmkmmtBj9nR7yHgapTfNZvtPH88AcAwSKlTs+2i9XXSW48UXoO3M8Wi8r56?=
 =?us-ascii?Q?G7fLewURuvQZaNy4aXruoy5rfj7WrZ6rlqXFP5ERXYVP2ndO/0r9CkJEnBpQ?=
 =?us-ascii?Q?aLoR51Myx9Xqo/mjm7bZBGxNDZgaKSBdtwa9cL/cfO5KMM/YJoaWOuGfeLey?=
 =?us-ascii?Q?ZrXOITiOdVHqZCWfngfAsCbtWkTMrdUHFlNk0JbOXIgd6FKUZzcYSFMRYhC+?=
 =?us-ascii?Q?+n4FI5orC/VEkv3q/hWmsHdGOwZOR0gb4vABPBiO/QEsfl3DQK0C76xvpqem?=
 =?us-ascii?Q?vdOw7iIxgVelkr9Dne106ejzYXy1kYbB8gKQOcnRIblV1vjhrtRntr7nmD5x?=
 =?us-ascii?Q?Gps7q6yhx9UGYckNWIam7SotOKRrZBlXYBfEN6uN/rFiBXpEMsak4Zp9dM8k?=
 =?us-ascii?Q?ZVPdrQoivoUqlmM5kejD6FCcI7ZudVYBLJbWvfbJbwBzHDYByhdut5/MOdUm?=
 =?us-ascii?Q?FqatCetbqZRd6ediCW0Q?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca19e1d0-9771-419a-341e-08dcc8937872
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 01:31:28.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR20MB4400

On Thu, Aug 29, 2024 at 10:33:27PM GMT, Vinod Koul wrote:
> On 29-08-24, 09:38, Inochi Amaoto wrote:
> > On Wed, Aug 28, 2024 at 11:24:24PM GMT, Vinod Koul wrote:
> > > On 27-08-24, 14:49, Inochi Amaoto wrote:
> > > > The "top" system controller of CV18XX/SG200X exposes control
> > > > register access for various devices. Add soc header file to
> > > > describe it.
> > > 
> > > I dont think I am full onboard this idea, 
> > 
> > Feel free to share your idea. I just added this file for
> > convenience to access the offset of the syscon device. 
> > In fact, I am not sure whether it is better to use reg
> > offset. Using reg adds some unncessary complexity, but
> > can avoid use this offset file. If you prefer this way,
> > it is OK for me to change.
> 
> I would just add the offsets that I need in local driver header and move
> on...
> 

Yeah, this is a solution. I think I should take it.
After rechecking the headers in the include/soc/.
I think I may make a mistake.

Regards,
Inochi

