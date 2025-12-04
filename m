Return-Path: <dmaengine+bounces-7502-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C2CCA4512
	for <lists+dmaengine@lfdr.de>; Thu, 04 Dec 2025 16:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 847B930145A1
	for <lists+dmaengine@lfdr.de>; Thu,  4 Dec 2025 15:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F092D8398;
	Thu,  4 Dec 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="gttJDUN0"
X-Original-To: dmaengine@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011070.outbound.protection.outlook.com [40.107.74.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697CA2D838C;
	Thu,  4 Dec 2025 15:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764862931; cv=fail; b=hq6ZlxGNSIntKlTX/HMLD28rqeMkXPjPIwXAthxNwErKbi4M7X9jizgz9N8MPrTOJMOJFGizBhnT1GVGWsDj3/dFtrr0UrUw+cGgeBB9WcT315MdWSbaPjyLiRwtardiYhOmyHfUjygQNsUt1EQjyqeNAUe/vDYqM/b6oX0RiF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764862931; c=relaxed/simple;
	bh=cFEz7oW68HQV1sYEl+zAXmjNI7lgoi3IDAkADPFKUQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GtbPb2xsNgqHvKd86xE6c1QH/QeMf/oOc4edNZfyJuL2rlmtBSTeNCWmbLadj8Sl5IOx/xuv/GiR4qg8Fw0n05QaXg/hgz+CSB/mnvwH6FmV9Yvl1/699tZY24KY2zhuQxoXiyakNjgNGhKXv91gm29JVWu9gCJNG5vJp0+w/NY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=gttJDUN0; arc=fail smtp.client-ip=40.107.74.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjiDbKlZBC72sxZ/GG/2fFgSDdJFarMO+cnITAhH2EII/40QDoupF3p5tg4hbNauCpqDp/wKN6bP6z73G+AQSkvSZtsd/JBQSBSonLhB91LLTVn3FUjYkD86hF02YO5EEUa9TpOiiXoXIpbGFiJIgvvG82ajDsSIPGyK9mpRD1j0vA4g4cGP8tFSSbFm6Lta9yCP+ceuKxQXdEYwe3ouo26uGcw/h5vK12fRMZxgbPuz/Ncxkm5Pfo92QHeLyIiDT1ZVUU27OxIzzIFTwHvvgtuhC6oCSQQCxtZ06fHDGyM3kwi9hS12XLJ17tS5nJttQyOFmxvCAxiw+3ng0kCzvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZYwlARrABQ2tL9c8ZElUnAATHhYrGTVgwHa6+mV278=;
 b=OHSO10MAPBrVHYQfa2rad6tPulfLQxLIeUJqegbc70K1llKhTrrkWmzEyIxfvZI7KuQ5fQM3Bqwh5FXOIjyugY2YCa26dS0jISZF3EM33MTAKRDzUAjN8ChCsipLoHQxHD/r6cn+LVmwzduCxMD21IhT3m765xE8ukwWb1B/dQJztgJlKsUBSb1wfJHqnm4QNyt8jo6dGHehNu/Dwsr0LBfS1b2Ea3crkXZcaPlpdQjdIsdK9BBIcJhXHS5e1KDHw+IinYXGR+yYPDa/q1dkDgiAxTIqsKcohWuUXXfV8rD/yoR5gDi2pn50heQEz5I+Ck7+ndUEh00LuizBwTsttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZYwlARrABQ2tL9c8ZElUnAATHhYrGTVgwHa6+mV278=;
 b=gttJDUN0P/DiOytsuXuM5Q3NksmwIbzRDTFXeK5dCWysdjB5YDnHo4hlfTqpyJRb0IG6DJkczAC5DWXG82eVPZNyGJW6kSOPV+3ZI71IwgdLzpzV4ufyxs/6l5RLRJ3sE7S9xGodXsh4W8RVxH/iUDU0+TG7jrVGEqRQTsOPntc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:24c::11)
 by TYXP286MB5603.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:29f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.19; Thu, 4 Dec
 2025 15:42:05 +0000
Received: from TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03]) by TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 ([fe80::fb7e:f4ed:a580:9d03%5]) with mapi id 15.20.9366.012; Thu, 4 Dec 2025
 15:42:05 +0000
Date: Fri, 5 Dec 2025 00:42:03 +0900
From: Koichiro Den <den@valinux.co.jp>
To: Frank Li <Frank.li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, mani@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, bhelgaas@google.com, corbet@lwn.net, 
	vkoul@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, 
	Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com, kurt.schwemmer@microsemi.com, 
	logang@deltatee.com, jingoohan1@gmail.com, lpieralisi@kernel.org, robh@kernel.org, 
	jbrunet@baylibre.com, fancer.lancer@gmail.com, arnd@arndb.de, pstanner@redhat.com, 
	elfring@users.sourceforge.net
Subject: Re: [RFC PATCH v2 20/27] NTB: ntb_transport: Introduce remote eDMA
 backed transport mode
Message-ID: <47ns4b4oskh5yukig7sr4okhw6gvqf4q5yin2ibrpue5zrcplp@ybozsroia2fk>
References: <20251129160405.2568284-1-den@valinux.co.jp>
 <20251129160405.2568284-21-den@valinux.co.jp>
 <aS4Lcb+BjjCDeJRz@lizhi-Precision-Tower-5810>
 <jiigiyxb2hllpeh3znbfy4octtubvkkrbxv7qfzzivimvz7ky2@i7b7a66peapf>
 <aS8I5e2UguQ2/+uU@lizhi-Precision-Tower-5810>
 <27mhsc7pksxyv62ro2m4u4xblednmlgsvzm6e2gx4iqt2plrl2@ewtuiycdq3vj>
 <aTBh86H5m6PpIxMk@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTBh86H5m6PpIxMk@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: TYCP286CA0139.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31b::7) To TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:24c::11)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYWP286MB2697:EE_|TYXP286MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 970a67f0-42ca-4607-a419-08de334bad13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lNy28tHHpmFwjN3eIc5pNwPTmXG7/XcYsieppCAAI8ga2Hylkm8bM1E9A59x?=
 =?us-ascii?Q?RnjM00DkQ5vj2PSMdWws/kJEOfupSTKdtlGAbrSYEK4LZY7zgbMJNRBjFCF3?=
 =?us-ascii?Q?hfNRrzovyFEMeaICmdQ8Sa/OxyMTfjb9rhw0HnlBDzYCmHw1qbesvrk/359M?=
 =?us-ascii?Q?wkjNnlnh/yViIMdFh09ATsO1auF+kAwRqfCz5v5706DJ5RLh50A/hEdVPyYA?=
 =?us-ascii?Q?C0LI8jvQ2SipadrLpxzxxeTAoGAeQwduzSbPb+uekdCxzNYB9m0bNHYq2HpA?=
 =?us-ascii?Q?qzWv7JuZ7VMDKsuzgXg+nT0ZwYRec3tmddEjAcQYsX/3R57eX3/N9J5GaZjT?=
 =?us-ascii?Q?0gRD/Gdfw05+jtty0GtJcJpLHA0njB1U59JhZozI8QP8Z9hRs9roVv/LCQu5?=
 =?us-ascii?Q?e6kp4vXXb68K0jMXc+v2IvFsHWvGg9Ol5CaqQmuaT/V8XD2WfWWJgmEeWUVx?=
 =?us-ascii?Q?mqsw/pvK9R+2djbUTT6kRMAIqOVgbSjYwCljKj30Pqa+UUcGIBTefA+HrQ2/?=
 =?us-ascii?Q?h3wC+0xPnQIE1KgjpCQwqrc+rSMnrsFxRMRWAYcxDTKb0R+cwnDttuWDpSLX?=
 =?us-ascii?Q?0wNjD+fHuGmGEAVo2VQahm+p7PDq/oPhDI+vMfZzGVmGkAjLRW6PipcqXNFq?=
 =?us-ascii?Q?BWtLFDM1CDMOuZPHyEyp08WOin8q0NTwDonftbNKi+h49zQZrW0gYFKln0X1?=
 =?us-ascii?Q?RglHWiVzvQp2xlgPF25vi3SSMERKNkAnrrOZb8R0i4nO9ZBORnoszNIkCWMA?=
 =?us-ascii?Q?3Rga3inI/shfV8ptxoqIcVHE5SjJK0SwhNA+2nvVya7jSWgJvTaK7edPdocf?=
 =?us-ascii?Q?oFKr7ZGF/v0MlkONY2RrY7QTFRJHwVXzWXcq7P3dCbi6j77G7fAOhH3E9qbr?=
 =?us-ascii?Q?AU806xno22KwAq0x7m7QKKsGryF3hk6sSmVYm4yRNp3U3x8gyks+K7VJqfNQ?=
 =?us-ascii?Q?dv08XGUIUR02txg6dJNhVrj7T490C1HbNjU8IXjgGrO7AeR5iEOYtNKExWhe?=
 =?us-ascii?Q?SZoe3U/9GPN598SAnwWvCcYllyOTsPTrzukFezU0BjyLUYxWQ5bXwBMFrI3p?=
 =?us-ascii?Q?RfHbGGMFWdK50NWI48QjYjsvFxiCBbJjnH+PGbU6sZxVLlUEtANOT1PFvb4A?=
 =?us-ascii?Q?DraSF6I3ydMv6u6J7PoVL7kIpHuZdcg44IPKYK3yPQJzrrESh1OQqpnKDbZC?=
 =?us-ascii?Q?fXZ0GsmUu/bJRO5vjLBwwvpefqsvFueRwG3Kp0vBSsZ/9DpJftzwV23f6HHN?=
 =?us-ascii?Q?kDr20UfahM7azM2pknov6Yd85ksZ0vjs6jRA6x8aMgbsM3AudzBCGPTUGtW/?=
 =?us-ascii?Q?tIbLQaXuBVqmVHe1+4jWPWtH3Q7oFynhhbdkpAAr0VfiIN6iepMh8yPXTPpl?=
 =?us-ascii?Q?xCW3zZBsp0bJpsuJ3xO3GJ+/MGAlQWu8jrc5D++4hY6U7LfxYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8TBN8B0Y0Ps9kSjDI8H+96FTat6D/dKkPsu6JKxcDkUIpXGurdIaVdrWMkDr?=
 =?us-ascii?Q?vyt2tsylKmsQ58Wb+Ytqag9oYyft+PiEHbkouRq2Wdz28y2YMXaCTyuF4boo?=
 =?us-ascii?Q?bbw0d5tAvjC+9OcJNju3HDxYjLeGSqDnER/cRpUuFlNscu8gEpBrvZi1WQ7G?=
 =?us-ascii?Q?w5b/aujCRWHiqgkiVStf6wG6x3lMJcW/C4JXKCb4EulOTkoe1dEqIwdOgSfM?=
 =?us-ascii?Q?Zjnba6RqxXPcfQJ66/+XZqxy5/CZuZjhgdCS6G9+4NNaqBhaI2QpU6X6mBhr?=
 =?us-ascii?Q?CrT/NB/uEDabI7wEYzI7dS7yaHoBEylsrB0eXgaXNcdjhBZGX96YUR9uL6wN?=
 =?us-ascii?Q?rvZmiAlZ8/pVqYXieLitXl8IpOJdHmbEZ/fjjoHGwxYusQLcG+H4ptKS+Rcm?=
 =?us-ascii?Q?iGX7BPPa0AKiNh8UuVEKoVlR5bqbLuDPVg35FTyXRVAePyf3anBbFikFqPPl?=
 =?us-ascii?Q?kauiLyYbmeifUB4XvBxUfW2X0FTG6e+D6uRpF3TmSBXhrifr7M/seQU6L4rp?=
 =?us-ascii?Q?7CftfQZq1tj42g+4Ne0nRnQlts6NPFApIlV2tS3X/Zm/aPKxnGE3PqYmJJTk?=
 =?us-ascii?Q?lX7EgnY+dEwApnadvBFaAMUlMvFNxLQC8GeYUnEC8Q7IkfCJBIk2AgqAHyyF?=
 =?us-ascii?Q?xFspa1VStvbEAQO8iluEwXm4W4dNAv+3EA9VUaIyL5/R9lfNaLoF8SYUriXd?=
 =?us-ascii?Q?XxfK4vzvzJxShmm8nSZ6xu8lEsp2seN1H1x0Xy2xR67mgKTkPWWv6Q7xn7GN?=
 =?us-ascii?Q?a/66FFQk8m/KqpF331GuLZPBedoG/NuBbtsC88QXARqAjFWvoZtjUpX1ORHX?=
 =?us-ascii?Q?reI4fczbT6DsGI+ZA8QEKjxUK9p4QfWRMtKeFYf8nWfvDmt4BnUWArM61fDm?=
 =?us-ascii?Q?s2huygkxQ/OV/sHgZGLf/pYIhnVakb4j8pftD2Y2m7V68WEPYw3Fn9zDdpsH?=
 =?us-ascii?Q?ygWQUK2R45MifbgcdJZu5DeJf3L7kW7MDwGh6MyT5UKfMKNCNP5nW9I/aqlS?=
 =?us-ascii?Q?kIOEjoW/BhuOFaoDXUM5d1uoebenU6iL++izU+MX5FPYulNkI/y/tOwFbstT?=
 =?us-ascii?Q?unRE2LwBs167jnlnHDt76A2fh0syBSSmSo39yokP52b8Qn/QVoeX2ZoMYTSf?=
 =?us-ascii?Q?jcjST3x1qj6khZnvP7C8ka7RZkSmUXJQerlgsXlSAvMAXxJUPKrqszukrju/?=
 =?us-ascii?Q?8FXlxJb9EsIn3waNT+DykScfuH9VkTDMpKa8SZ5RLQBSEV9yZEzECPMopjTo?=
 =?us-ascii?Q?CQejE050TOlcgASK2DU6DJEFgyjWAPU8A8jgKlxlI9xkzfe7UcE0Ke2tagCY?=
 =?us-ascii?Q?aezXFmzedb/hGG8s/Pa6HIZ4OFYCfQAjy7vEsUEc0nTLE/aO3UCSKXtwz3mD?=
 =?us-ascii?Q?2CiylwuAS33EE/x864t7AmpS48Xrm47r2cKxLNz0Nna91SnkHwRm1cC5jkQY?=
 =?us-ascii?Q?EvfaHMOPiw+ET/XCrd0yW39+4AoqGSCL238+QGTh5xAtK5U0S+1Z9YxYlalv?=
 =?us-ascii?Q?f9T3UIjca/pON24U2fm64dCkI15jc5oXNHKIV2C66UXAAaUjUA+WtNSU69rw?=
 =?us-ascii?Q?BgmwX84Ds2bErEbUj9qzZeRLC302wRfY/cOV8Jzi6GwiuHYLS0vDFZVYLAoz?=
 =?us-ascii?Q?kTyqO93RbIP3BaUIitXo3qA=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 970a67f0-42ca-4607-a419-08de334bad13
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2697.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 15:42:05.3980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 47RlU4QyqiASNINkJekBqvW2VBfQ5gWfwLlyPJS8Ty7C5HbCJxC8ZCaecJDC1Bgqe4Xb/RLtgiha53/7kqYDaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYXP286MB5603

On Wed, Dec 03, 2025 at 11:14:43AM -0500, Frank Li wrote:
> On Wed, Dec 03, 2025 at 05:53:03PM +0900, Koichiro Den wrote:
> > On Tue, Dec 02, 2025 at 10:42:29AM -0500, Frank Li wrote:
> > > On Tue, Dec 02, 2025 at 03:43:10PM +0900, Koichiro Den wrote:
> > > > On Mon, Dec 01, 2025 at 04:41:05PM -0500, Frank Li wrote:
> > > > > On Sun, Nov 30, 2025 at 01:03:58AM +0900, Koichiro Den wrote:
> > > > > > Add a new transport backend that uses a remote DesignWare eDMA engine
> > > > > > located on the NTB endpoint to move data between host and endpoint.
> > > > > >
> > > ...
> > > > > > +#include "ntb_edma.h"
> > > > > > +
> > > > > > +/*
> > > > > > + * The interrupt register offsets below are taken from the DesignWare
> > > > > > + * eDMA "unrolled" register map (EDMA_MF_EDMA_UNROLL). The remote eDMA
> > > > > > + * backend currently only supports this layout.
> > > > > > + */
> > > > > > +#define DMA_WRITE_INT_STATUS_OFF   0x4c
> > > > > > +#define DMA_WRITE_INT_MASK_OFF     0x54
> > > > > > +#define DMA_WRITE_INT_CLEAR_OFF    0x58
> > > > > > +#define DMA_READ_INT_STATUS_OFF    0xa0
> > > > > > +#define DMA_READ_INT_MASK_OFF      0xa8
> > > > > > +#define DMA_READ_INT_CLEAR_OFF     0xac
> > > > >
> > > > > Not sure why need access EDMA register because EMDA driver already export
> > > > > as dmaengine driver.
> > > >
> > > > These are intended for EP use. In my current design I intentionally don't
> > > > use the standard dw-edma dmaengine driver on the EP side.
> > >
> > > why not?
> >
> > Conceptually I agree that using the standard dw-edma driver on both sides
> > would be attractive for future extensibility and maintainability. However,
> > there are a couple of concerns for me, some of which might be alleviated by
> > your suggestion below, and some which are more generic safety concerns that
> > I tried to outline in my replies to your other comments.
> >
> > >
> > > >
> > > > >
> > > > > > +
> > > > > > +#define NTB_EDMA_NOTIFY_MAX_QP		64
> > > > > > +
> > > ...
> > > > > > +
> > > > > > +	virq = irq_create_fwspec_mapping(&fwspec);
> > > > > > +	of_node_put(parent);
> > > > > > +	return (virq > 0) ? virq : -EINVAL;
> > > > > > +}
> > > > > > +
> > > > > > +static irqreturn_t ntb_edma_isr(int irq, void *data)
> > > > > > +{
> > > > >
> > > > > Not sue why dw_edma_interrupt_write/read() does work for your case. Suppose
> > > > > just register callback for dmeengine.
> > > >
> > > > If we ran dw_edma_probe() on both the EP and RC sides and let the dmaengine
> > > > callbacks handle int_status/int_clear, I think we could hit races. One side
> > > > might clear a status bit before the other side has a chance to see it and
> > > > invoke its callback. Please correct me if I'm missing something here.
> > >
> > > You should use difference channel?
> >
> > Do you mean something like this:
> > - on EP side, dw_edma_probe() only set up a dedicated channel for notification,
> > - on RC side, do not set up that particular channel via dw_edma_channel_setup(),
> >   but do other remaining channels for DMA transfers.
> 
> Yes, it may be simple overall. Of course this will waste a channel.

So, on the EP side I see two possible approaches:

(a) Hide "dma" [1] as in [RFC PATCH v2 26/27] and call dw_edma_probe() with
    hand-crafted settings (chip->ll_rd_cnt = 1, chip->ll_wr_cnt = 0).
(b) Or, teach this special-purpose policy (i.e. configuring only a single
    notification channel) to the SoC glue driver's dw_pcie_ep_init_registers(),
    for example via Kconfig. I don't think DT is a good place to describe
    such a policy.

There is also another option, which do not necessarily run dw_edma_probe()
by ourselves:

(c) Leave the default initialization by the SoC glue as-is, and override the
    per-channel role via some new dw-edma interface, with the guarantee
    that all channels except the notification channel remain unused on its
    side afterwards. In this model, the EP side builds the LL locations
    for data transfers and the RC configures all channels, but it sets up
    the notification channel in a special manner.

[1] https://github.com/jonmason/ntb/blob/68113d260674/Documentation/devicetree/bindings/pci/snps%2Cdw-pcie-ep.yaml#L83

> 
> >
> > Also, is it generically safe to have dw_edma_probe() executed from both ends on
> > the same eDMA instance, as long as the channels are carefully partitioned
> > between them?
> 
> Channel register MMIO space is sperated. Some channel register shared
> into one 32bit register.
> 
> But the critical one, interrupt status is w1c. So only write BIT(channel)
> is safe.
> 
> Need careful handle irq enable/disable.

Yeah, I agree it is unavoidable in this model.

> 
> Or you can defer all actual DMA transfer to EP side, you can append
> MSI write at last item of link to notify RC side about DMA done. (actually
> RIE should do the same thing)
> 
> >
> > >
> > > >
> > > > To avoid that, in my current implementation, the RC side handles the
> > > > status/int_clear registers in the usual way, and the EP side only tries to
> > > > suppress needless edma_int as much as possible.
> > > >
> > > > That said, I'm now wondering if it would be better to set LIE=0/RIE=1 for
> > > > the DMA transfer channels and LIE=1/RIE=0 for the notification channel.
> > > > That would require some changes on dw-edma core.
> > >
> > > If dw-edma work as remote DMA, which should enable RIE. like
> > > dw-edma-pcie.c, but not one actually use it recently.
> > >
> > > Use EDMA as doorbell should be new case and I think it is quite useful.
> > >
> > > > >
> > > > > > +	struct ntb_edma_interrupt *v = data;
> > > > > > +	u32 mask = BIT(EDMA_RD_CH_NUM);
> > > > > > +	u32 i, val;
> > > > > > +
> > > ...
> > > > > > +	ret = dw_edma_probe(chip);
> > > > >
> > > > > I think dw_edma_probe() should be in ntb_hw_epf.c, which provide DMA
> > > > > dma engine support.
> > > > >
> > > > > EP side, suppose default dwc controller driver already setup edma engine,
> > > > > so use correct filter function, you should get dma chan.
> > > >
> > > > I intentionally hid edma for EP side in .dts patch in [RFC PATCH v2 26/27]
> > > > so that RC side only manages eDMA remotely and avoids the potential race
> > > > condition I mentioned above.
> > >
> > > Improve eDMA core to suppport some dma channel work at local, some for
> > > remote.
> >
> > Right, Firstly I experimented a bit more with different LIE/RIE settings and
> > ended up with the following observations:
> >
> > * LIE=0/RIE=1 does not seem to work at the hardware level. When I tried this for
> >   DMA transfer channels, the RC side never received any interrupt. The databook
> >   (5.40a, 8.2.2 "Interrupts and Error Handling") has a hint that says
> >   "If you want a remote interrupt and not a local interrupt then: Set LIE and
> >   RIE [...]", so I think this behaviour is expected.
> 
> Actually, you can append MSI write at last one of DMA descriptor link. So
> it will not depend on eDMA's IRQ at all.

For RC->EP interrupts on R-Car S4 in EP mode, using ITS_TRANSLATER as the
IB iATU target did not appear to work in practice. Indeed that was the
motivation for the RFC v1 series [2]. I have not tried using ITS_TRANSLATER
as the eDMA read transfer DAR.

But in any case, simply masking the local interrupt is sufficient here. I
mainly wanted to point out that my naive idea of LIE=0/RIE=1 is not
implementable with this hardware. This whole LIE/RIE topic is a bit
off-track, sorry for the noise.

[2] For the record, RFC v2 is conceptually orthogonal and introduces a
    broader concept ie. remote eDMA model, but I reused many of the
    preparatory commits from v1, which is why this is RFC v2 rather than a
    separate series.

> 
> > * LIE=1/RIE=0 does work at the hardware level, but is problematic for my current
> >   design, where the RC issues the DMA transfer for the notification via
> >   ntb_edma_notify_peer(). With RIE=0, the RC never calls
> >   dw_edma_core_handle_int() for that channel, which means that internal state
> >   such as dw_edma_chan.status is never managed correctly.
> 
> If you append on MSI write at DMA link, you needn't check status register,
> just check current LL pos to know which descrptor already done.
> 
> Or you also enable LIE and disable related IRQ line(without register
> irq handler), so Local IRQ will be ignore by GIC, you can safe handle at
> RC side.

What I was worried about here is that, with RIE=0 the current dw-edma
handling of struct dw_edma_chan::status field (not status register) would
not run for that channel, which could affect subsequent tx submissions. But
your suggestion also makes sense, thank you.

--8<--

So anyway the key point seems that we should avoid such hard-coded register
handling in [RFC PATCH v2 20/27] and rely only on the standard dw-edma
interfaces (possibly with some extensions to the dw-edma core). From your
feedback, I feel this is the essential direction.

From that perspective, I'm leaning toward (b) (which I wrote above in a
reply comment) with a Kconfig guard, i.e. in dw_pcie_ep_init_registers(),
if IS_ENABLED(CONFIG_DW_REMOTE_EDMA) we only configure the notification
channel. In practice, a DT-based variant of (b) (for example a new property
such as "dma-notification-channel = <N>;" and making
dw_pcie_ep_init_registers() honour it) would be very handy for users, but I
suspect putting this kind of policy into DT is not acceptable.

Assuming careful handling, (c) might actually be the simplest approach. I
may need to add a small hook for the notification channel in
dw_edma_done_interrupt(), via a new API such as
dw_edma_chan_register_notify().

Thank you for your time and review,
Koichiro

> 
> Frank
> >
> > >
> > > Frank
> > > >
> > > > Thanks for reviewing,
> > > > Koichiro
> > > >
> > > > >
> > > > > Frank
> > > > >
> > > > > > +	if (ret) {
> > > > > > +		dev_err(&ndev->dev, "dw_edma_probe failed: %d\n", ret);
> > > > > > +		return ret;
> > > > > > +	}
> > > > > > +
> > > > > > +	return 0;
> > > > > > +}
> > > > > > +
> > > ...
> > >
> > > > > > +{
> > > > > > +	spin_lock_init(&qp->ep_tx_lock);
> > > > > > +	spin_lock_init(&qp->ep_rx_lock);
> > > > > > +	spin_lock_init(&qp->rc_lock);
> > > > > > +}
> > > > > > +
> > > > > > +static const struct ntb_transport_backend_ops edma_backend_ops = {
> > > > > > +	.setup_qp_mw = ntb_transport_edma_setup_qp_mw,
> > > > > > +	.tx_free_entry = ntb_transport_edma_tx_free_entry,
> > > > > > +	.tx_enqueue = ntb_transport_edma_tx_enqueue,
> > > > > > +	.rx_enqueue = ntb_transport_edma_rx_enqueue,
> > > > > > +	.rx_poll = ntb_transport_edma_rx_poll,
> > > > > > +	.debugfs_stats_show = ntb_transport_edma_debugfs_stats_show,
> > > > > > +};
> > > > > > +#endif /* CONFIG_NTB_TRANSPORT_EDMA */
> > > > > > +
> > > > > >  /**
> > > > > >   * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
> > > > > >   * @qp: NTB transport layer queue to be enabled
> > > > > > --
> > > > > > 2.48.1
> > > > > >

