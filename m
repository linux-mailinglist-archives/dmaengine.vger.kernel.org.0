Return-Path: <dmaengine+bounces-1506-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9323C88C059
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 12:15:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 481442C2878
	for <lists+dmaengine@lfdr.de>; Tue, 26 Mar 2024 11:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B13B481DE;
	Tue, 26 Mar 2024 11:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="vUBx7pvj"
X-Original-To: dmaengine@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2103.outbound.protection.outlook.com [40.92.41.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA5D134A8;
	Tue, 26 Mar 2024 11:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711451725; cv=fail; b=npJA4GZzZsVVK50yr5IsKUxfVzWSimrV5G7CjxZKhZUwUz6YOlXorcDq695Y5cG/73oMg/NPGqafGIA2rCFDfjBFzEpjrrtsvYJYE/8G0MdtXmdXR0os+eLXiQQ8c6jb/swAkPqjjaPU7zQhdQA3uWekmsVmnaKcr2dqx0RurVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711451725; c=relaxed/simple;
	bh=4sP89Up/LbN7mbiltFXO/1aO3SAbtuPEAhaWh3q0L6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jv3DaSfAAiGSoHZ9rvRydm7R3VD4VZHQ9+k/59v0iO2h41W0NxFUTcP+qttpstPEctgSyAsqOJPwDvE96pxnbv4MjBgNHb0crccXAJIxcHP3WUjDM0U6vn9aOl+E+aLBNiiVZ98yZMD/ef6e2snmhUmUDNyd95TBiS32vVpx6qo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=vUBx7pvj; arc=fail smtp.client-ip=40.92.41.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1k9+W/5zHLS4v9shYgKeJa6wIIjKO1KlLJ+a6QBrx5J5z6PoyqXWjVPs7Aon7LIxg5ehHge7D71Jdcr2buggHzBSvkr3aj/iYlqnCoE12vPO8rQCQpNxA6EdGfeBv+PHVuaGwH0b0kHOt81PksTKwunrKG3sUm2MdqHf3wHLGNWDsmGUbzEJpQ+AkWcHNfbRazBNvz2HkmBxNIclyjeOGlokUkimQymYpsE255W403M4suz0HTbB7A6PGXC5onFPC2USnrNr2wCK1yKO3WW3Zb32bTplPqbfKLxit8t8f3dnkm7XKV26o9R8DtP6rYcYhV55abpXPBEeZNmuDVf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2e2/J1tA3SO8V8DrfUQCwCMSa81uHzIgCogBnX/vf0=;
 b=W3V9sQZ6ITelghWIo5Ny+n9L+XDVjudrMCFc0dwuNvxoAP3d76M1k8f79Z2ogJ1oNgZVHx9DAqFQEWwsWtFe4DCFOeRGNi5R9b+ovf9aGTqGlNG/gddlCREUxEi1Nvrxdh8V7SVX6WfJePy62hiSOpM6lG+QikdSxSeGH0+qzFJ5EIwOdudmyOWgxdWs0yEJ1q43XB2KYYPP1nTnvNDhSFhwyCxscprWleKD2jCDU+HWak0PdhrgGxB7fnzetKb+qIMn9VZoyMhh2Hcm/8WYVg5k4J6esbVx+AGCGW8MWuds/X+WSDZKm//DinhDXlzU8awhk26Bcsv0e0qo0jbEgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2e2/J1tA3SO8V8DrfUQCwCMSa81uHzIgCogBnX/vf0=;
 b=vUBx7pvjlBblXYxJUvNesQn+4jLmbPyIPwA4utW67Saytbmb21GT576ts44uZtBYRsFsb3OZpxM/foWZOH1kOadpIczmLRpoxRpZaal5LuXPvvmyGyeYFMlKi+A+cijOrNRtMtprUWb6gwi6ZhKqdcG9jVpZu1lJ80MojaoRoznn4pGj5C1uGIpGa34Ww4yFewLuaWv0yelEbnN131J8V1UPMC16ur5pUDUvE9SGp52JWYL/2aDx8/LDe3YZkTmGhPZjSCGSsudbdFb2hEPed179QT9GjMvH4rhmZIA/4cvNYzgp6bqb3hQ+vhZ2geZGVAQaOwR9p+3b0G7eoNg3TA==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB4980.namprd20.prod.outlook.com (2603:10b6:208:3ac::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 11:15:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 11:15:19 +0000
Date: Tue, 26 Mar 2024 19:15:24 +0800
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
 <IA1PR20MB4953517450F0E622A66E9A7DBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953B500D7451964EE37DA4CBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <IA1PR20MB4953E2937788D9D92C91ABBBBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <57398ee0-212c-4c82-bfed-bf38f4faa111@linaro.org>
 <IA1PR20MB4953EDEEFC3128741F8E152EBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
 <473528ac-dce2-41e3-a6d7-28f8c53a89ef@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <473528ac-dce2-41e3-a6d7-28f8c53a89ef@linaro.org>
X-TMN: [wng88awa0ejj6Ev7blQZD/f17lPEDdoRIqZ9mjpPbcg=]
X-ClientProxiedBy: PUZP153CA0011.APCP153.PROD.OUTLOOK.COM
 (2603:1096:301:c2::7) To IA1PR20MB4953.namprd20.prod.outlook.com
 (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <7eqqiaqysirvz5x6diz5iwrfusqf6p4tgvysmrop6dm72uilps@lmxnk55rukhb>
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB4980:EE_
X-MS-Office365-Filtering-Correlation-Id: 3330ced3-aaff-4b22-cd7e-08dc4d86059f
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3ghsXKwRy/t5h7NdWkXmzB01n4ERQjVCrlGAsjKPQkJVwtOWCYIoC8ZNXIl5C+s9ATMVQT7m8mxcL+Lxx6GaMy7aTHlNvjbx5VMzWD777jmGCBbBslgDGc70Amxj6j6shGq2JnkPMid4focnrg3Uy+knUIfCt6VSBsKYqkwTK9aqS9v1DyToVgzO5Z3Z42n5ULebZHmBWkMF9zI6FOhBo3H7KP3m1vXB4a+QTjfb2gl5YSjeLuQaT4CbA5TaAW8Kd4ya6Y5OZDe6Ga/RAGqdIIP+Pongo2TRzs/53IvwSK9xoRz3Ctt4n0a6pKqo4ND/Pfac4NS+xTsVK+QQFKypkj9/5saUilN1AXgs70olS7LK5kV5H7m/2xqmUuOmmDzcfaEC+RLHvK762hoKjP2vlmVJCyA3GAIQzDp150zai5VtpPm6Fw3PIP9FSHG6Pnysiv60u2ZQkPZ1Fb6LIuc8JdvV7gmQ/WzuVEKaAjoGTEqVfiIRNiTX5VK9NM7Pvo84Y7hJrACRzbFqVBBl5KzZE1Hk8kUdkiOXoa4WFvXkM4/TO6rNXtIGtcP4ezpZImC2jkve2DwvB8w//uh6LoX1Dcf3YixGoHFCF0G80PmW5sqJ4kMNqQXI6V1ohJ0lZhybupY3Pe0XH1PHYbxwutdqLi/xQth6Qf4Cstw0ww3w46Np7lO1FeUDWV1hx2eYTx0DKwuTgQnpE8jpuD9kdlQOubPtY4lNe7937UE0O0HghlaigVVUKWijiDKQdv37zXHR1myIxQivhwo7eO443d45UFPKetJWqB4jFQ=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WCVJyDmrh+ZZ2OB2//pBiUsayymGb+PHau8GvdWBLqDwAWciD8fwye+22R8+3y51Gc2Jfq076OurLDSYrjlFJWuaaHEARYV6dqGn9NVVkJqSxmnU0EP0Ttg0LDlqjtfGupkGrrJx8bRMKV0wsF43PE67TjXYiBn6HZN336N0uP/tw40bsUw5vvPIFjjIVjC7ynLolkKxUclIIYMBLz7KnJ1sopLrAzJjGBFnT3Feshf0n4IabAKge3Gz6LQttOF+WRG2hVM0uLFhAg6ZeVYj/mGDFBp5BTUJj2U+cMCHSbxZXvv7Tk9DpWI6GlIpZ6q8+CZETdtG6fIknxF3NstfiaWEZsXWX28KojZZKCcbtrCEZ37GMXs5wni6HyOxKfbc363g6MaYrvDrlZcuU54sSShdAuW89qmk8RjZYsyIuYZB51gWI78JA//q5FXl/Jui8rZkn0+MDaVN89Dp58AUTMfOYGACZY5uxKC2oBGfN8Wvvq891aUb4sVmiKR+BZjAmswYkgmibdKju5qRE7+j0E4F6xk20d5xannpau3rO0q0zFnIFh+Z/bXizM7mSIhHIOxx+yS56mCHMacQT6u9Z3rhMzwg+3K0VCHfKNOLOSzsLGtNg1Fyi1/IgKWr2ilH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ur0rVeuGKiUw5FOusDBCtv8fbZ9GW09HH3qXFKPIYuUM2uyL19O+e/Yycr/W?=
 =?us-ascii?Q?wvvUCOeModASjx/uuRiDSI7/upIsXvucUteub0HGLwd1FnSvlwtOfSfatli9?=
 =?us-ascii?Q?pwzpZfjWlI8SDEx7ckmKhSvMSAAWSUuK4V9Ok9XUmZkfmYlVz5CaO5hBR1vx?=
 =?us-ascii?Q?fZubzB4hnQqMEnBfUxQ6n9cYrnXD0vgXT9f3bdhMbFiK55ukApq6SZbNjc0u?=
 =?us-ascii?Q?nlKVvgR1YTD+hfj5hZVEZtPh9kZKheRMa/VtzxCNOQq4rF7tDj0/oFWlMNuj?=
 =?us-ascii?Q?+ToN7h5IdPa720q/Wfm/+0bOjIa77sC8i3eDbZ7Kw3Nw+fmB/N7NGIoe4FbB?=
 =?us-ascii?Q?rg7GC8SvKncIExytlhec1H11xdt3iuzAnfcgxoGhmqLESdVEw+3iMMz47emw?=
 =?us-ascii?Q?f5p9w209iUXvwNxyOm8mfAfI7M4uuSsJMZM/zeuJ6BU66FUprAKsIFtue8+R?=
 =?us-ascii?Q?4WvxVPdAXbPYJK5zjBAhdBsaOHvNnDfXUG1Glvx3sSQjjJRoA3A8ZiYNShWG?=
 =?us-ascii?Q?2/bqMsmDpCUU4oVLtaRkwX6UU20SRNWovKanJnaXvTSfXoPAAqHitzyNQrlP?=
 =?us-ascii?Q?h5r+1zKS2Us8Dynw3jWA30JC0emYprWTX0aNdwtdhMmuJrklPTYqUo4d1u41?=
 =?us-ascii?Q?UI8xDYKOfGPNzOQOOi2HFATLY/mOZz61FaXwdNomhn/uaV6DnRjVmTn9Kh+6?=
 =?us-ascii?Q?f1MVPvTRCFY/BAIW+f6gvDXSShTalA+emGZFOFv8tJ2ybyWZ+gbGkwqUe7K2?=
 =?us-ascii?Q?n0LawnEuZ8/UbrnyD5oNeu+0zsnbSxZOcKSzD3XSSN81J7em48GxSQsZ389w?=
 =?us-ascii?Q?vkwwaaRC8V4bUocgV3hzut2zM6jBOgz6KIfGt0/eo5ppTbQgZ03kTEIy93iV?=
 =?us-ascii?Q?vw5MPuMePYZtG7QiQgq0f4jcDjP8NvPA5rfS0pErPA3G0YdeKteAo5r1+ug6?=
 =?us-ascii?Q?/OuHNqxeuikToiwyhnETXpBKit9OrrXQqOHyAx9/tZ9XCZH9rPuOc7vSxbxF?=
 =?us-ascii?Q?8TAQLoUizFXwAU1k3QH81sWsPXDJygKc940NMg4nYZ6p5L5N7oO3fp1Gcaz5?=
 =?us-ascii?Q?lxlBsbxC1H2LG47BeltKNk3qpWNnO5fv2E8SxxK6ydny5YiNnlPU9vyzj2/o?=
 =?us-ascii?Q?A7mGA+FOV/8vq+olUGJG5cLwo6Sl+jW9AuXtDoVhkV6xHvPXP6qf/j0uujwC?=
 =?us-ascii?Q?R0EyKvYDqDDyaU+dsqsVb+nn/nYPqhKZP7hCW5hqXWnJsVvcL1uvbMvZ5lak?=
 =?us-ascii?Q?hBdsGe3/v0z7oKyQ/aSU?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3330ced3-aaff-4b22-cd7e-08dc4d86059f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 11:15:19.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB4980

On Tue, Mar 26, 2024 at 09:53:09AM +0100, Krzysztof Kozlowski wrote:
> On 26/03/2024 08:35, Inochi Amaoto wrote:
> >>> +
> >>> +required:
> >>> +  - '#dma-cells'
> >>> +  - dma-masters
> >>> +
> >>
> >>
> >> I don't understand what happened here. Previously you had a child and I
> >> proposed to properly describe it with $ref.
> >>
> >> Now, all children are gone. Binding is supposed to be complete. Based on
> >> your cover letter, this is not complete, but why? What is missing and
> >> why it cannot be added?
> >>
> > 
> > The binding of syscon is removed due to a usb phy subdevices, which needs 
> > sometime to figure out the actual property. This is why the syscon binding 
> > is removed.
> > 
> > I think it is better to use the origianl syscon series to evolve after
> > the usb phy binding is submitted. The subdevices of syscon may need
> > much reverse engineering to know its parameters. So at least for now,
> > the syscon binding is hard to be complete.
> 
> Some explanation why dma-router is gone would be useful, but fine.
> 

OK, I will add some comments on the why it is gone.

> > 
> >>
> >>> +additionalProperties: false
> >>> +
> >>> +examples:
> >>> +  - |
> >>> +    dma-router {
> >>> +      compatible = "sophgo,cv1800-dmamux";
> >>> +      #dma-cells = <2>;
> >>> +      dma-masters = <&dmac>;
> >>> +      dma-requests = <8>;
> >>> +    };
> >>> diff --git a/include/dt-bindings/dma/cv1800-dma.h b/include/dt-bindings/dma/cv1800-dma.h
> >>> new file mode 100644
> >>> index 000000000000..3ce9dac25259
> >>> --- /dev/null
> >>> +++ b/include/dt-bindings/dma/cv1800-dma.h
> >>
> >> Filename should match bindings filename.
> >>
> > 
> > Thanks.
> > 
> >>
> >> Anyway, the problem is that it is a dead header. I don't see it being
> >> used, so it is not a binding.
> >>
> > 
> > This header is not used because the dmamux node is not defined at now.
> 
> In the driver? The binding header is supposed to be used in the driver,
> otherwise it is not a binding.
> 

The driver does use this file.

> > And considering the limitation of this dmamux, maybe only devices that 
> > require dma as a must can have the dma assigned. 
> > Due to the fact, I think it may be a long time to wait for this header
> > to be used as the binding header.
> 
> I don't understand. You did not provide a single reason why this is a
> binding. Reason is: mapping IDs between DTS and driver. Where is this
> reason?
> 

It seems like that I misunderstood something. This file provides one-one
mapping between the dma device id and cpuid, which is both used in the
dts and driver. For dts, it provides device id and cpu id mapping. And
for driver, it is used as the directive to tell how to write the mapping
register.

Regards,
Inochi

