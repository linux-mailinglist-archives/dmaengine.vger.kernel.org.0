Return-Path: <dmaengine+bounces-2840-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1C9294E007
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 07:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693AD1F21580
	for <lists+dmaengine@lfdr.de>; Sun, 11 Aug 2024 05:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0900171BB;
	Sun, 11 Aug 2024 05:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Pc7rJxXP"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2034.outbound.protection.outlook.com [40.92.19.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A533DF;
	Sun, 11 Aug 2024 05:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723353355; cv=fail; b=SPIud0tRbJ59k85RWw1+z+krMYtb37WmHDEGGO7beRHb7Qy5zk7mLYlgtb5NwQyOFDHq8T49cSMhaPN0zPfsUCY6sOgygZBT0kcirCwfJQ5PxQyf10/ELEKQhCLhHklfkRLg51BboA0Uyoa+1odLY/RxQ3IKzLJt4qfWgO0nSow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723353355; c=relaxed/simple;
	bh=K3g6eYJfiXK+fLaQ+uU0cOmM6DJSocZcRcK7lSIlNMA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T+sxAOJb7nbEwAVlCl2oT9Krvq6vuOWX0PsE28xE1/HTUY8oWHveT3SEcBE/ZeW0pYUT2w8jf9XuMyoSgrRxpS44u48s43C6VAmqPL0GL7kQI+BV2uqdEwcgrRFoH2nmHu+5RJCoF6ioBwxIzvEdy8ZMqK4aouCZpnpZdj0QA1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Pc7rJxXP; arc=fail smtp.client-ip=40.92.19.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hwfb4XjLh6pOCBEQ2QIUAKUoW8tqfSNmYrniKdCr0XEEWMEjhXQO8N7FH8s4JnLgi3mnwD+tBlO0NtE8/t4e855V36yqOXlw791/ltRLn4JWn5jz8eiiXIIIpxGWW0ZS9HchfqIWag18iMPYfOn7D+iSdCd7SzXM1dWkpOOb04hsnw/XSgT9uMqJEVZScHmcfPCPwnPigLSauGejmpxRKnnGNfCfR0rAS+AhFiB1qvCKe2yZCQF9Ca91+UcYOI6lXuHA8L7YydWQuImPdg77+l/w7+B5LE5hOF3WIHEPze0PFK2sjeEoClQTJuhNHuOBtLWoeTegkcntUEjospCFvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icOt4tsRJK9J9NKd0DSGC7pzGRv3vmFOlvHKh1sXzTI=;
 b=zLKJHbIsNDOUtT1ulK7edsQaiaOsRWyF7hIdr5spVTlfoCD8Q/FNZXZeV+KWAVv6esIv03tZCCSqqup/U61QFma5Xqo5WzkIf1nrnDK71elN6gi+wvqIa3pIsEnUs0PhIbbsdpgT8ydxH80lMYEM6/9iNUgqVG7Z6OyreAj0enpYkBsy3QpoaXDBzIuwOAP4S4Rp8llYcHEJjtzNaRKSGAdvL+DtbEQBvCNIwUys+dpdYdF6X5L6RF7J7BB6lFF0/0OHAWLEJX6gtjBEt2q3pQQdAbuRz7fsGsBo6sNAzuX/LezqJQh3ho/2MU0IARt9mlbYskdcDt1gm3x675Bqhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icOt4tsRJK9J9NKd0DSGC7pzGRv3vmFOlvHKh1sXzTI=;
 b=Pc7rJxXPXVhqI1dP5/DGUoZbhRjZgXBIC//KrkesImo+s9p/+5vNPeATHIjTif1hsocZYJ/5Ue92FVlRltxMn3710DYiOg78DP+PqJf+NusiQiitL5jMxTIuLosuWROQXVwoHE+GCbWipdw3ruFoTnjtrlUK5BrOpozt4niZU6p2QSDaZJ52BlVamN3eyTxYIGZ4Zbik8I77lNrEF2Kf+5IZjoyN0AbujfFlBbXsI9uVh1TO0d6TkDlgArrfrucAbw75DjwCcuvgz9p0L11o712aj0mRyDziG1OHIx4X4cXURmy9av/lOJHq4OpTjUVzE0TyIeRkXLVQoy86QoO+oQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by SJ0PR20MB5255.namprd20.prod.outlook.com (2603:10b6:a03:47d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.17; Sun, 11 Aug
 2024 05:15:49 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::ab0b:c0d3:1f91:d149%4]) with mapi id 15.20.7849.018; Sun, 11 Aug 2024
 05:15:48 +0000
Date: Sun, 11 Aug 2024 13:15:06 +0800
From: Inochi Amaoto <inochiama@outlook.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
	Inochi Amaoto <inochiama@outlook.com>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chen Wang <unicorn_wang@outlook.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: dmaengine@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v9 1/3] dt-bindings: dmaengine: Add dma multiplexer for
 CV18XX/SG200X series SoC
Message-ID:
 <IA1PR20MB49531EAFC7868178634ECEB3BB842@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495332ACF71E3E8D631508B2BBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB495360B076BE4DA4E66B48BABBB32@IA1PR20MB4953.namprd20.prod.outlook.com>
 <e0f7ee39-69e4-4a03-9908-96e383586800@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0f7ee39-69e4-4a03-9908-96e383586800@kernel.org>
X-TMN: [wGwZobE4hEnaHJCHEUcICrg+VTmdeFPtruYu11y646Y=]
X-ClientProxiedBy: TYAPR01CA0067.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::31) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <chkfysbie44qxhz3vcx3dbuxshl3xlesrw36yymqr6zj6v3pxi@jd767fbv2x2q>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|SJ0PR20MB5255:EE_
X-MS-Office365-Filtering-Correlation-Id: 187329d3-44a6-41d5-5db1-08dcb9c4a8bc
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199028|5072599009|15080799003|8060799006|19110799003|3412199025|440099028|4302099013|1602099012|1710799026;
X-Microsoft-Antispam-Message-Info:
	KuFw7jvIfy8ckaah1G60dSQDZW2mV1AgLL9EnxTTibjbk4v0wbc7dIMXL4vzcQakbC40/Gesx0762uoiuHSSPWzuxi69xsXMC2Wl9hms7vnPmCdXpZApa3jcHGJ9XPhWUhx4QU2jFLYsR3zhftlRAoiREnzbiefSUUJQkqEJM+zstbFGrYxAgOVW4b/GnNG5P+3KW8kWYNpLBdjVU+TRpJb6cDZ2SnS5HWSPSsDASbhSWoG+BRbJ8GTgKDBtzvlHk7mpbQ8sSlJIWwYJzcWnS5qoDRrG3qLgTLPgyQxlnIxLT+QrydkGQBL0t6JVkd8OYj95BcSVCpEiFc0J+vXyefHfzxKWF2t4IqHLd7ROyRk1bFllHNYJpIy1nA5L8m2nNOFCQqo5ezoFLiDuael5cMy/CH7Y+V9iOCS9caUY1g98HsdvUe+Vp1AGwIkgcQhB2tpvmdF0Z3WshKRvuXfGu1s5nenXHPMOeumYFAyT1A19WAAv5UfnC39Mp/LBkMMk3HiVjbspmhNkQFylKlwk2Mxn5ShtskroVAVWK8fnVr4xmDmtwagc8YnEhLArPqL9DbqTtCHKrAtMl6pgBGJEiFsQUoCD0wpgIpT8vCh6869m0gvdI4UQe2RqERvZ4hUx4zOTu36tnK3lEjd+Xj3uIEK4Eaf49qxm5nlFvkdY90xXYC+edpZkuNCE+mYivO+wdEMrqXSDdWHebo8B8RKSyv2e0Vsq6DFLpc+Gid2gA5S+Yw3vJagYcHW1EHcGvVCxJQpUrgqZydKEdufgp+2Cp2YlPoKBwBcXdMJ1o4VX2XQR3MJYqJibYKBFbvUTj9qNmtwpg+FLfffm2XtoXwNu5ubeQVx+qQd/upvJfYrfu6Y=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WLtgcz/mN2fKIY3IGZ81feO74YbZ4QlCBgt4jrSr3CXRXc/dIBSzeRiauCjK?=
 =?us-ascii?Q?kPyH3bB19Smcebc6ut02R3YtQ1YPWGAsn3aWMzK9cJhEX1of4+4CWYTRcUzE?=
 =?us-ascii?Q?A/9/VWR+FfHQU3lflbGkwIpnDZilGGaPHw3lRdzq0uail4wpHseI6vQO8lEB?=
 =?us-ascii?Q?yUK3Ojy6P+Svq40b9oUqDag5zJ5uZLsxhenLoaG4LszwDmWAJhqw4cU9MdlB?=
 =?us-ascii?Q?zi+qHWkcSUOcTQQWToqrPC0ghhPTdms7jqfEHB4wlfSpRGuVajXgU2vMUEej?=
 =?us-ascii?Q?F9+uNRpahKmkkGOL5UK92SmyAr/JnsbqH22iwApxkO6Nutnmh8NIgobFGJF2?=
 =?us-ascii?Q?6PUmwNtpZAjvZj6CV9pqpvQ0Py10L8iUGl88swzoUbk9ccyzsW7AIUsMuwSZ?=
 =?us-ascii?Q?DgczFtLXDZFRv4/1pOlqvbPeG2mqM3sCKgZu+jyTPZGXwG3psW4PXGQJxUzf?=
 =?us-ascii?Q?7kCocUfBGDIAuaYy6ArhkoKXVcJv/zLZPtxrO7mSfeRdoLefI93q9Q1hhj4I?=
 =?us-ascii?Q?mtAKJd0bT7fvz/46CMsbxQ59lDOz7Wgfms7hi5fZH0NY/fWfueOiHF/Uo2v2?=
 =?us-ascii?Q?DlO3A7YMGg6+uIJJrYHVCIFBk5HAbvf1I80BsGcPIxjPMnpj3W1Jcf/3qO4j?=
 =?us-ascii?Q?vOWpBBjB7bfY2GGeABtcIgnpqWGjskB4FiOoD7B1ub3DuEfvEj5djRImg4uO?=
 =?us-ascii?Q?K4kzdlCemu4n6SuYUOojzu9xBri1fkYuieksAJArnR+H3kCrmKZc1qOp5eGO?=
 =?us-ascii?Q?jeo4UYqdmwEBoIYf87sNEmnWCMaLwk6ZSBEL9D8jxPGQOFqGDDLl6/T63ZKD?=
 =?us-ascii?Q?Zu4JWqMLmuHQQxDFhp+UlXklREaWWDQH9ujHKa1uQG/YDivOD2vfq5fpIuax?=
 =?us-ascii?Q?jFYqxkZMkqmcHMoELw27VkaHtxmuviwBVhpYv+NhzYrr2L0SQdmu93PZXQjB?=
 =?us-ascii?Q?Z9V9wftmsC2SjOWbfULCziwQNdLf2+qz4pGjrDEvl1FK/QKmdngqu6hhmbRs?=
 =?us-ascii?Q?I1/Q8WiH7WLUvRP1vVm9mBADLSY4vSoAn1sdL+O3suDoiOwY5nm/mhE0Gypt?=
 =?us-ascii?Q?SZTzdhvTaMJLba/KgqDK+1xRb7kvPciRsNjMHXJqDa1kD14sfZPw4mZv4b4o?=
 =?us-ascii?Q?As+ahS7YS+MF4y3HEFW1ljf0ZoHDmww2GQsJV0D7HnZTVDqogld7ufFZ3JUm?=
 =?us-ascii?Q?+nPjqMeUeKkEaYqOsLy3xvkwlhGTJ9ySHTGeM3/5awlj/YeBFKq9qaM17kpK?=
 =?us-ascii?Q?dnd9zSm9kILyUJb9GBxr?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 187329d3-44a6-41d5-5db1-08dcb9c4a8bc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2024 05:15:47.9410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR20MB5255

On Mon, Aug 05, 2024 at 07:32:17PM GMT, Krzysztof Kozlowski wrote:
> On 02/08/2024 10:32, Inochi Amaoto wrote:
> > The DMA IP of Sophgo CV18XX/SG200X is based on a DW AXI CORE, with
> > an additional channel remap register located in the top system control
> > area. The DMA channel is exclusive to each core.
> > 
> > In addition, the DMA multiplexer is a subdevice of system controller,
> > so this binding only contains necessary properties for the multiplexer
> > itself.
> > 
> > Add the dmamux binding for CV18XX/SG200X series SoC.
> > 
> > Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> > ---
> >  .../bindings/dma/sophgo,cv1800-dmamux.yaml    | 51 +++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> 
> Filename should match compatible.
> 
> > 
> > diff --git a/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> > new file mode 100644
> > index 000000000000..11a098ed138a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/dma/sophgo,cv1800-dmamux.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/dma/sophgo,cv1800-dmamux.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Sophgo CV1800/SG200 Series DMA multiplexer
> > +
> > +maintainers:
> > +  - Inochi Amaoto <inochiama@outlook.com>
> > +
> > +description: |
> 
> Do not need '|' unless you need to preserve formatting.
> 
> > +  The DMA multiplexer of CV1800 is a subdevice of the system
> > +  controller. It support mapping 8 channels, but each channel
> > +  can be mapped only once.
> > +
> 
> 
> 
> Best regards,
> Krzysztof
> 

Thanks

Regard,
Inochi

