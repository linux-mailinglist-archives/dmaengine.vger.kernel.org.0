Return-Path: <dmaengine+bounces-72-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC7BE7E7D7A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Nov 2023 16:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DBAE280DAA
	for <lists+dmaengine@lfdr.de>; Fri, 10 Nov 2023 15:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E941D549;
	Fri, 10 Nov 2023 15:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jC1ujoes"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560F11D540;
	Fri, 10 Nov 2023 15:36:54 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199FA3AE3D;
	Fri, 10 Nov 2023 07:36:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNSFRIqUj9wuZhNpIuoSfjS6UmDkj6brNV2y7+TN2nTqa/lfGLrG+6PROxQRZNWTFhAFB75oQyYERGdOQ2wN1LmCFfwBcZ2f8BjGxY4PSkBWwQzOQtQkpzIelZq3noB1x73oz0vyXNyF/k6o71Md+CwdwXSqM7XXQXNA63gZLyym1I8kjNnmI7Q1Tt8UgUnetDtDW1fmkGm5Ckff539x7STCue1Wo22hxkvrJl6bipOrBhnQE/7SiOc9z4C9MKKo8XWpoMrxWBkpYEgcF5eyiru+P9hJirF65f3/iWnpcsyuA+dZoKAbrT1AjRCxyglAdlQkS5fBnB8rGvj2F1Okyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3znICEULwDOmgOPhI57f8Q0snBcjBQHEFLGeQ9Zlw2Y=;
 b=ff7w7J7nuCAMzf6ezz8lit6EF6P56wVBmnC/BV2Sl885AhRKKmADnyT5gTfnTCWUSzSMSd/I0h4JtuIjatOii6zyjsaWBi8pnLqniB9hP5U6oH07onXj+N57E4M0KDGQBskdm4tn80W98uiqvt7jl5EIXT5ps+SnEQJoitgtlIltt2/OdWCZ0nS9kbKBXq4VTryPfYXrNilR9dQSCrZoM1iQsyNqr/HUCAmtJ8swotpUPtErx9l31dztUm6g/Bb46EmBRr/G4PiGyYwF6jefPnDJF150IBciVuMd18qfU2SGuTC7C1Xqtfwhfor59N1pUrLJqq+/9SaxPdwa6e2ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3znICEULwDOmgOPhI57f8Q0snBcjBQHEFLGeQ9Zlw2Y=;
 b=jC1ujoestyI4FNfCOiPdSA2o+PAwIOLJH5sn2oW5eeb4MnPJfCbhbDP/C8lQHtKMszNr0L7rd4H+i2CeXro1g7x/MtC9PTWmZaFlCfggZxxtO2jq4aYerH89Tcz8F3WZzgiMn5gg+To3vo7kChZMBDSJPOTgxJ2shw99PX2zKXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB9703.eurprd04.prod.outlook.com (2603:10a6:10:302::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.10; Fri, 10 Nov
 2023 15:36:49 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 15:36:49 +0000
Date: Fri, 10 Nov 2023 10:36:43 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: Re: [PATCH 4/4] dmaengine: fsl-edma: integrate TCD64 support for
 i.MX95
Message-ID: <ZU5OC4FqQ9DQF+Co@lizhi-Precision-Tower-5810>
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
 <20231109212059.1894646-5-Frank.Li@nxp.com>
 <f095ba95-ce76-4821-87b7-083f4162fc63@linaro.org>
 <ZU5FN1dECvzDIUHb@lizhi-Precision-Tower-5810>
 <93f1625f-ce01-4628-91e2-e3bfd024466c@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f1625f-ce01-4628-91e2-e3bfd024466c@linaro.org>
X-ClientProxiedBy: PH8PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:510:2d0::23) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB9703:EE_
X-MS-Office365-Filtering-Correlation-Id: 901a05b7-4eb8-4f9b-bd97-08dbe202db14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sn9kv/3q3lQQ7obVKolIfkzJR5pAe331i7oy5s6hMTuTV8Ax5gjz1YYGEJejSDjDVfUfbY7NDvSb+f+qDEPtAB4eZADeYcemXEasu+PbA3zHqcLEy4tT7WniputNvtS0N8TlTLyU7b7j4YN1J4f2a2kN1UjuDeqKqowRZu5MtXBLtC5mpCcLLaXC14qP5bgYX4LvA5+iJxYt6UliYdiIFeXbfvzHbKuIYl7vruJC9UIuVYl//3y5qeQdnNhiG5ZopNhTZObIbR1xlPy48nAKIsGXJODBef4PtBvxQhZw9OvPBwMtgx5AvluA8r2WR7KBpzoNWIVxCzYJNjOjan7lRmnEYcyTvH77FpwMDljTCOziMRjVEAN/Ov7+hfPvoTjJjcjIsIBGKbJifLank1ADUNv1aQYo/s4IDmSNdbooKoIni6I6ly0B197xo5sHdqTKN+uCqpNa3Zrw45KIV6N9PIVXKApcy8URBm8lKwF2uzrGj1raFXKKfBDmN8m8Kaf++7phXJgyiPgX1gSOBGaH7zEHh371uUtKv8EjxMGAvmcl5XVDEeWO2bf+6FsWCVfW+69vYOXwAyRAwuVQdT7KHjSIWpnsVJXioNq6J0hcXucTzwNEtLcAnUMYjmc0OsKhggkbg7visFx9gaoakjm9tg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(396003)(366004)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(52116002)(9686003)(26005)(6512007)(86362001)(38350700005)(38100700002)(478600001)(83380400001)(2906002)(5660300002)(6506007)(53546011)(6666004)(8936002)(4326008)(8676002)(66476007)(66946007)(66556008)(316002)(6916009)(41300700001)(33716001)(6486002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E6s/JytFLpEM+iQ+QHdXR/4VtLPUHDIgJbq6ZaPNKR5B+QSvy9Qs3Hz0xjBO?=
 =?us-ascii?Q?k2WBMATQJlWesbNJDgWnujCeqw9CMkAAZMM7t5Dkm4rTOo6HMIocph2QNS5y?=
 =?us-ascii?Q?vuwjydlt4CnWi0Y4rxjmUwhGdagFfQB2jHWItRpmPxznYexQdvu7TPrkpLCb?=
 =?us-ascii?Q?J9Dvv9bY5iTxJvPTU9dWqMNdw7PJVuqe+/bAKFskwgBiKmnSmbvH2lH81awX?=
 =?us-ascii?Q?tkWtrwKOtLcx0OclIp6zH8xes9tDnTre+JxBH/hO69izzSlAU0pJ8KeIPvf3?=
 =?us-ascii?Q?K0kIu0ia4qlByslt0bDPQzqRFAtnM/QaGurvPlNRRZLNmH7fMeejxgPfHA3v?=
 =?us-ascii?Q?SVhyWHl9av6Wu0/8tdcK1z+sj330R+neU74D3LxKr+E3Eb7yMl3YiNOUMT9Q?=
 =?us-ascii?Q?UVNNXM8Q5DeMGpVVFzRD8c6oLyjDuSBYr8k+hVV/4BH78NsxxLBlmWaw7pVO?=
 =?us-ascii?Q?qvTgIhpgI5TcwwvFxkSvvTRAMXFW27fhlcXn/7qUTLxeBnD6/6RFWiHl0bQT?=
 =?us-ascii?Q?EQe7hX8W5ZuoN62GnN55Na//oEn1l1E4Vb35tHpvbS4FwraB93Zeu4ixU4VE?=
 =?us-ascii?Q?lSrx6nk4mmL/6GribDh4jiDFJkm+Mgiqy8F8EMeFQ16yLXm24hrIsSf7zjEx?=
 =?us-ascii?Q?n3zm1tqyHrX5cyFKvBrhK01DGfWpKgQ5JRREjJj1zgvDOa60siuGkXPY+cRQ?=
 =?us-ascii?Q?MyCSo28ioKdw/mhSh8zhah2WbGkHqYVgvvCrB6HH1cm7eo+61RuEJWCZVPpq?=
 =?us-ascii?Q?sd60aDd7wp/a608bMHAuecfANeg8qSo/jyo9D7KcTsck0kif+9CxJyOFWr8T?=
 =?us-ascii?Q?jkWI3mWY9l1iLJQhKPb/Qt8qrNiqB8Y1wgxZWnd3Sb4HYKXHAXW0Se4B7mMn?=
 =?us-ascii?Q?4S4nYXAsS+v46FgT+3zeIBzVhG5cH1MkWUzxdUEv00mV/T4V+AvxNAYkOnXU?=
 =?us-ascii?Q?famhWictx28B7YMeUDTeFggVDUgHoayweWCUPnDqDxweWT0LMz0B/n9+68bz?=
 =?us-ascii?Q?UrGJGlA88FrNQD1xuIwUi4XxOJjlEoNKuT2ehGzG2xeKIZhO5M5rUd7FYv17?=
 =?us-ascii?Q?kOusSlx+vX6oxd3BZBQ0vQmrfnJfBtFJhCKwM1dIkAfdjcKoCHSQCNqH3FI6?=
 =?us-ascii?Q?skz6SfOYWDW0qWXzvW/TxxIPYeWulSSyp6Yu5iIXlyVBpbV5wMKL0x9BrU0x?=
 =?us-ascii?Q?MiNerhvNZL01CVd/0j+jZ2EzAL+Q4zE24SftbbBP6fmNi3elxdL9oN/vjt+A?=
 =?us-ascii?Q?1Zcn65hLyN0+TeDiX9EkZv7kO3LsVQVD8IHqU3KrMlLqG3jcGHute825fBPj?=
 =?us-ascii?Q?LydKOd1Oe6HIAPvlvZUOlk0klLar5hcjURbqGXS/BE4kuaw2Lwrcn9OBDTlT?=
 =?us-ascii?Q?QsErX4y1SyPziIXy6EPNd9qeD3EAZbHrIqRO+z7fuszZwzf+fz8LR6rD3zTg?=
 =?us-ascii?Q?sFAa0QhlSbHTpLLkSf7VcwK09X2o45LRDyGTtqUEbS10S3QTW3SVS5nELAmr?=
 =?us-ascii?Q?v2o7x2l82x9p/sER5lCKjhY3zcXFt+AFVVDcXxapMbiKFnR6HZ3aqZgtKRrx?=
 =?us-ascii?Q?bsjBUudFMGQYjuydOaQeRGuEI7Rgi+razKTCdzZ7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901a05b7-4eb8-4f9b-bd97-08dbe202db14
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 15:36:49.7742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6r96sL0ZwH9jPdCRn7mthxvr9XEU5dnnEAvpINs1uBjE6/5gESfehexgucG3TqazraOp0Nw2wVzm0ivl2aXcaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9703

On Fri, Nov 10, 2023 at 04:10:46PM +0100, Krzysztof Kozlowski wrote:
> On 10/11/2023 15:59, Frank Li wrote:
> >>>
> >>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> >>> ---
> >>
> >> Three kbuild reports with build failures.
> >>
> >> I have impression this was never build-tested and reviewed internally
> >> before posting. We had such talk ~month ago and I insisted on some
> >> internal review prior submitting to mailing list. I did not insist on
> >> internal building of patches, because it felt obvious, so please kindly
> >> thoroughly build, review and test your patches internally, before using
> >> the community for this. I am pretty sure NXP can build the code they send.
> > 
> > This build error happen at on special uncommon platform m6800. 
> 
> Indeed csky and alpha are special. Let's see if LKP will find other
> platforms as well.
> 
> > Patch is tested in imx95 arm64 platform.
> 
> That's not enough. It's trivial to build test on riscv, ppc, x86_64 and
> i386. Building on only one platform is not that much.
> 
> > 
> > I have not machine to cover all platform.
> 
> I was able to do it as a hobbyist, on my poor laptop. What is exactly
> the problem that as hobbyist I can, but NXP cannot?

There are also difference configs. I think 'kernel test robot' is very good
tools. If there are guide to mirror it, we can try. It is not neccesary to
duplicate to develop a build test infrastrue.

The issue is not that run build test. The key problem is how to know a
protential problem will be exist, and limited a build/config scrope.

Even I have risc\ppc\x86_64 built before I submmit patch, still can't
capture build error if I missed just one platform mc6800.

For `readq` error also depend on the configs.

Actually, we major focus on test edmav1, .... v5 at difference platforms
before submit patches. 

> 
> Best regards,
> Krzysztof
> 

