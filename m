Return-Path: <dmaengine+bounces-74-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFC17E7D8C
	for <lists+dmaengine@lfdr.de>; Fri, 10 Nov 2023 17:08:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA02B280FE9
	for <lists+dmaengine@lfdr.de>; Fri, 10 Nov 2023 16:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36771DDC7;
	Fri, 10 Nov 2023 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PoP6fbs/"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A61DA43;
	Fri, 10 Nov 2023 16:08:46 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2066.outbound.protection.outlook.com [40.107.104.66])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 223123BF07;
	Fri, 10 Nov 2023 08:08:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J5gZuy1LRpTtNg30FEJTdSdK2TdL303yUn5s7kOolK7DQmeerZCre2XWjstfa9Ghi3CxfI8kawDZEgx6xcOiw5oitxpcjxy/6vup3+38QM63/VkH/ZNL8eObG3E3gwI025Pd5dMb6Ow4dTMJwll8se5bRK/6vU0G5O3MPTS7MpHs7RUXDJXMkadDDJpjDNxTmOTan4z9Y/r6ktzqyFKQt0bo08RqKzqDbIOO5KhVSrTj/LtdJCwZwEqQMHwE1MyzdkkI3d8KOuH58NsE3QE0mIasWTG865FKLAKvH94OS/5ZTudsnQFvf90JTX4LVlfWINq3Ce8U6ahv+mGZ1ebuEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fFvWhxWtdcreFiDXZqyQ8BhOIaGiS5ukKnvKI4VEuM=;
 b=jRudYe9oZcpQQXDV6Dj58yrAEJ27ZyzNYHbO/8OGS6NQLMjP8zlOwjit1aMVZj8yAEADSrdWral4Lfkyv3BGM6vTr4CoAJXyrIQvgwLkdS+nViV31TLA+g0W5l9i1DIUhE5OIooP+OEyNFpkttmvMH0YsUIeFvPqlMNbmM1G20AqDl4RzPYQsXiaL2UPJfKBKdYKLCTpk3ze/bFWP78r/p8fJnnwUh0RGazrqIVHtCMAED3dozr/tl7Y2hX1nu3Lh58GZF7zdNOwVr2aBheIDB8jvgr5gMVZLcqF1Kz8fV2EOsM8cdKYji9QrMp0Y8Yx3Qxxymu7hYqNVX/XNWE6kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7fFvWhxWtdcreFiDXZqyQ8BhOIaGiS5ukKnvKI4VEuM=;
 b=PoP6fbs/842HX2neadKdrdRuZNw7G8Oe/6dOig4aScMPErLFsBtPI9dtopnRkvfZatABtjvvyU99CPWWpwItaHExlNCNk9ywvRxEpb8KoCoOCH7fuMxQAk7Jk4FQDecFp4KKMa/QyGtRCqqOaWAiUj1741li1bw3j/3SK/evGLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by PAXPR04MB8944.eurprd04.prod.outlook.com (2603:10a6:102:20f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10; Fri, 10 Nov
 2023 16:08:41 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 16:08:40 +0000
Date: Fri, 10 Nov 2023 11:08:33 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: Re: [PATCH 4/4] dmaengine: fsl-edma: integrate TCD64 support for
 i.MX95
Message-ID: <ZU5VgY3EHU6STHVX@lizhi-Precision-Tower-5810>
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
 <20231109212059.1894646-5-Frank.Li@nxp.com>
 <f095ba95-ce76-4821-87b7-083f4162fc63@linaro.org>
 <ZU5FN1dECvzDIUHb@lizhi-Precision-Tower-5810>
 <93f1625f-ce01-4628-91e2-e3bfd024466c@linaro.org>
 <ZU5OC4FqQ9DQF+Co@lizhi-Precision-Tower-5810>
 <1cde698d-6655-4cce-9ed6-e852b3aac8d9@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1cde698d-6655-4cce-9ed6-e852b3aac8d9@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|PAXPR04MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 930c52ac-ea94-42cd-1153-08dbe2074e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D7Es0hpj49a0UU11lbjnl6A1STDMgV+fJdMtPQIKq0utC1h6qmNk/THs+AyaXmVddkPTFV3b/YdH8YLHuKYB8H7JekN/8fVqovNX8KpvygqgMxMCdRaATWIqn/DfHH37jsQg15sJuJh6s3aTNmG+sXy+3vTWAOh2VXlZ0ZV2qYCO0ADqO8uoihyIMKijL2bF+FQCqE/4xGcvHHbK8TsNR8OVkTAsN8qsadFjOVRQ1j3NXQiCL+pma0LY2iPHCxhaot5Sx2ba4R5UW0+uqdtP4x/X0+q5QLRQV3dkAjktqso11JULdWdTImZROl4KoCxU4vPkQlRXHyGkw3ZiJjJJ3CEpCJT4+xCmUpcAxH1ta1P7f7AEwRlPZcDE09bV9+VutA478/4ajMThxBer9XeAFgQal3XDHRwZWIPIjbcFGnj5Vl4R3PrB9RokjZCLuzMOUzrbZuyZAoNYvU5O9HXGsmSdIcct7dXyPCsCv4NCkS5Hi+7sZbd13wgQIT5jsrzDZNQ4NOKomVq7DkC632fYPULrx0YH8xBtwgSmwZM6nDNaelFF4SThPEunz0PSK/xt9AvbDpz5IU4ivwEIMlE8F8Ar+lbMA/XqWCFf+Bmu69HVs/O/5Bjc1iVFAXaVam1hS2Prw/fOVBAEAcrUBR1MEQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(366004)(376002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(86362001)(8676002)(4326008)(8936002)(6916009)(66556008)(66476007)(316002)(2906002)(66946007)(478600001)(5660300002)(9686003)(6512007)(6486002)(6666004)(52116002)(53546011)(6506007)(26005)(38350700005)(38100700002)(41300700001)(33716001)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gMGi90SzRUisMhxawdMwE3sEtj0Kt2aPP9prjj4KU7+886708aNlpRgN6AUO?=
 =?us-ascii?Q?QkjGI5KPcs8H93B/1POccdmzlMy2chaTlYIs0zKShAYLYko69DY/pvIl+93Y?=
 =?us-ascii?Q?NEdeimeIgWPWASr2yNyA6ZSYBAyDgZRM8ftELTe7cAvU+6wsnPjTVbOQ/t/S?=
 =?us-ascii?Q?GIwBeWD7kC69HIIsKVQZoOt3lPrHXqZraADsggq2dRk7N1xxw9wXOmXVKnjp?=
 =?us-ascii?Q?qtToyuG3Qm8DyjfA5TwPMbtqoKWfbizlh0WMIXVKTiqf5lvehykhu2sjl/AY?=
 =?us-ascii?Q?LXBCh8erJY2GOWN5+PQqW41cWqbrL9JIfUXpPrgimHwQKenTk35P/zfjQkhG?=
 =?us-ascii?Q?5lxP8WFgBZUVXay9x1cuAv0SbaB1TF0SdLR3QrRrZcx3escyvs3UlgEZGxFv?=
 =?us-ascii?Q?/d3L6BWeIzFmoeuoG7I1l677W19ImRdes/pOF+hMr50TGpl6Oh0tWSuwuvJK?=
 =?us-ascii?Q?P66igQhBRwLhURg3iBgTCJZQgYpNIGb4wvrNbV9T9c7IxVSLK0MrQzzacvCS?=
 =?us-ascii?Q?c0+tFX3YiKSen2R2W3ZMuR9js3URoRvw/GZ8zOI0ZOOKz6VSlB4D4KDgqmJN?=
 =?us-ascii?Q?ls1GBlonU5/PwpJ1AWjMDzE8vbMI0SiCFk8vzA9r+uhVsPgVl+A9b8/pInwy?=
 =?us-ascii?Q?df7ZeBhkRqFogcOd6S93Y4TSW9h9H7bIamVvekqkpYmrJCdqasZE5ZqC8sSs?=
 =?us-ascii?Q?OUpK1Inxx1mleLfMNepjssZrAHozjVvIQqV6eC+/zdllT1TU3oi/RtVTSfBv?=
 =?us-ascii?Q?7PzwAiiEoS/od0Z/7blrrGJY0pCLIkpyyyzo5aB5DzE1mhhFLVAG1g38vpKa?=
 =?us-ascii?Q?pYc2M/RtZdgvefVrqWLdCmsczpAPgzyL/EwGiHre0MhgH1XH7mgYRP/MWLT1?=
 =?us-ascii?Q?MS5dbuG5eeOuLd2VidvMqKxWz5TPbEt5zki51e+mmknIE/5VCO2KDK29e/oW?=
 =?us-ascii?Q?HhzhaV5UYEYJMSjaxqvURSOhoBz4d2Hx21oLhRcUGlry6IHov5G0fl/vWCP+?=
 =?us-ascii?Q?0Ipx4+dw6t8i5PSoe3CEacYDK/Vm/k9X876tXu7dnTa3fEHEkrQj5OnqfFf5?=
 =?us-ascii?Q?RGF3ie98/mJghuL/pat6lqGVcuMaJUaBVS4OMq/yAh05VPSHA3vkjU52zXyJ?=
 =?us-ascii?Q?ArgkoeAHkTR6oaiNGSrA4CFbT28W9aU2GBOP3G52DHjFdCBTRPBqrbRZtYxt?=
 =?us-ascii?Q?lAy0mA48/BigZXhr7y88dceYpkYQnmxA6VO41hH/Lh0c/umO4kww5uzBpDYc?=
 =?us-ascii?Q?NE5NSy32e4ppWFtFaaOT4uiHB/P4Xhyqg0bxBNjyhhyWwMmO9G6vwF1hj2ej?=
 =?us-ascii?Q?3unqo4RXah1dFxincOebS3JqDSVEwE3FK3IPA1nf+I0gEjiJ1V45O8JVyRTn?=
 =?us-ascii?Q?F8RceNEUPe5+/+qke+p4l3Yp5+TjR+hIQLFDyKho+98Ru0hZV6Gj0qimQMzL?=
 =?us-ascii?Q?jll2hRzI9oh7+VGmQ+St27XIGJjSD98LrjS06YTGw079N1KRVyzViif4pFlT?=
 =?us-ascii?Q?k3WLjehaPmqF9v87V0u7eHHP7IcKwTBnxoCgpbP1NjqxGTv1g1TTh/ih1ne2?=
 =?us-ascii?Q?Jphh0GOM5iXYbX8r9a6ok7vPllPPqZipPHd0x3pP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930c52ac-ea94-42cd-1153-08dbe2074e1a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 16:08:40.7642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zL6SOMnN4aydbCsJ7p8JAFSkqf7m5ipfsaegut1VU+IafcsktLfLAoIZLvOGWGYnwD9MlNaotCehMAyYbdqaxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8944

On Fri, Nov 10, 2023 at 04:52:49PM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2023 16:36, Frank Li wrote:
> > On Fri, Nov 10, 2023 at 04:10:46PM +0100, Krzysztof Kozlowski wrote:
> >> On 10/11/2023 15:59, Frank Li wrote:
> >>>>>
> >>>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>>>> ---
> >>>>
> >>>> Three kbuild reports with build failures.
> >>>>
> >>>> I have impression this was never build-tested and reviewed internally
> >>>> before posting. We had such talk ~month ago and I insisted on some
> >>>> internal review prior submitting to mailing list. I did not insist on
> >>>> internal building of patches, because it felt obvious, so please kindly
> >>>> thoroughly build, review and test your patches internally, before using
> >>>> the community for this. I am pretty sure NXP can build the code they send.
> >>>
> >>> This build error happen at on special uncommon platform m6800. 
> >>
> >> Indeed csky and alpha are special. Let's see if LKP will find other
> >> platforms as well.
> >>
> >>> Patch is tested in imx95 arm64 platform.
> >>
> >> That's not enough. It's trivial to build test on riscv, ppc, x86_64 and
> >> i386. Building on only one platform is not that much.
> >>
> >>>
> >>> I have not machine to cover all platform.
> >>
> >> I was able to do it as a hobbyist, on my poor laptop. What is exactly
> >> the problem that as hobbyist I can, but NXP cannot?
> > 
> > There are also difference configs. I think 'kernel test robot' is very good
> > tools. If there are guide to mirror it, we can try. It is not neccesary to
> > duplicate to develop a build test infrastrue.
> 
> Sorry, there is no build infrastructure here. I done it on my laptop.
> 
> > 
> > The issue is not that run build test. The key problem is how to know a
> > protential problem will be exist, and limited a build/config scrope.
> 
> These are all the trivial configs - allyes and allmod.

Thanks let me know about allyes and allmod.

> 
> > 
> > Even I have risc\ppc\x86_64 built before I submmit patch, still can't
> > capture build error if I missed just one platform mc6800.
> 
> So you did not read these build reports. This is not "mc6800" platform.
> This is allyes and allmod, the most obvious builds, after defconfig.

Sorry, I have not read it carefully. Just glance happen at mcf_xxx. I known
I missed test this platform.

Generally, I read carefully when I work on the fix patches.

> 
> > 
> > For `readq` error also depend on the configs.
> 
> Read again the build reports from LKP.
> 
> > 
> > Actually, we major focus on test edmav1, .... v5 at difference platforms
> > before submit patches. 
> 
> 
> Best regards,
> Krzysztof
> 

