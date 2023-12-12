Return-Path: <dmaengine+bounces-503-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DD480F249
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 17:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE0C1F217AB
	for <lists+dmaengine@lfdr.de>; Tue, 12 Dec 2023 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196E377F1E;
	Tue, 12 Dec 2023 16:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="g/kBGTHy"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1910ED3;
	Tue, 12 Dec 2023 08:19:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JldctLwq4NTWudRQq0g9x3kExrb3XW3ulqwk1KJB/X9QcJ02CVB3SHVtEObrOrIOux4FQD8pdq1jF7SZ4tjhlxjp3NSHFjNYjyPYgPoQtFGRdM3carxLenVOylXQaj+o4kgGOqylRBw2n+/NuYDwytvuaLN9tF/nI/4/wwmPqspqq/U5LNn44+WS8OlRQUsEeWINC5u7L8Euxwrnfct57ufg3eVJG1Peez5AyaqeMoTu9lnIsYi9Rcls22hm9GOunJWir7TQjjw6Hl+KQL9/vtNjwqwJRn5NtbPDNh33wxR/CzNGSZmLPvO+JRX9/Mpt+U0dxK8yGppQKGLlZs5pOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TLQ87kPb4QjTLo3Uzq+zy3Bj5yyPhpZLzrCGIC6r7c=;
 b=FvwwO5B9YddAD28hoN6Tl+d41Z4bFh7WzPZ/oRdq4g34o/7JypP5z9XO81620r7E4IYU0N283aA5wxD/EgxQt1t5QBaVJp/l0wXLQRbmD4TnNcEmK33XNUgTm7FwPQqltoV1cBUA/1XlDkokAm5LGGi0lFL6fgW+wW80n/4LU1CYyIt8KwHzxkMcPuKwZCfqN9NP+QajJqb9VQ/Db7prGij9GeaROST2SdOElud1R+4MYqQ0RfNlujbNg1uiuee/qD4dyrYOXZ65h0HItacbsynaft/zCxs4tJU/iuvG1f/Wf3Y+Sf99hkVZK/E1RGdvk3qVG7CzAKN1k8sFIDax2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TLQ87kPb4QjTLo3Uzq+zy3Bj5yyPhpZLzrCGIC6r7c=;
 b=g/kBGTHyhUuK67OhR5bZrcoY+K0aHB+660TqEgh7m6v8KNSMhc5YMOBsDntxCGPCihqWUzIixKEKaSyIcGaMfxu5kwUypWkkvCWS6lOKwd5pHjDayDg5A0ycrCA6zViaABYbxi9I/UWzZlPQUsGR2f30UqjI8i9xmI51aJXmnNk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8978.eurprd04.prod.outlook.com (2603:10a6:20b:42d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 16:19:40 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.033; Tue, 12 Dec 2023
 16:19:40 +0000
Date: Tue, 12 Dec 2023 11:19:32 -0500
From: Frank Li <Frank.li@nxp.com>
To: vkoul@kernel.org
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com
Subject: Re: [PATCH v3 0/6] dmaengine: fsl-edma: integrate TCD64 support for
 64bit physical address
Message-ID: <ZXiIFEhJLh/y8QqL@lizhi-Precision-Tower-5810>
References: <20231127225542.2744711-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127225542.2744711-1-Frank.Li@nxp.com>
X-ClientProxiedBy: BYAPR08CA0012.namprd08.prod.outlook.com
 (2603:10b6:a03:100::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8978:EE_
X-MS-Office365-Filtering-Correlation-Id: 69ed4690-f2c6-40a8-9f8a-08dbfb2e242d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PvqD9F7m2Yu5uAfgkYGgfFmHuLzld8YdFm0mOLs+sJe4rsUMmtZobWCE3IsZ+4qKeSw2PINrr/13vBrmZMCXnunER+krxsqpbmuTDUvUCk6gWq0hoRxuUyj1xt7OeBaOOn1c0x6SHii7Scn9aQVjhjVZBRSvGZcaVjhRxOENZXbF1aFXmYbmY1otwOGxCTjo1rrYFig9sobcJMyXFa2AM1Y+iaF8fkUhj0UJNwjtYQHPnxE4mrZUMf4eSRzcpjZLCTtqf15fLJeMq1IDY2xrm8XaoNT/NfN7CtGgcSV35DytTKLaoepGuS3+O7VWKVPo+TM+keHrCTKXewtVOlMNdyHrY2EqXHZVV1FRJoI7e0iOhaiWz21tVyr2SHVXXoS2Kl3gVYgSb8Q99m9FQ1si7W/N+djhJYpRA3kNh0fuh4oGHYpCk1DmcOFfzcd73RTvu5L5nhsIcp+RQypYsYN+5NG4ZQttxdacbtNAHKYrD+R/nSk7RGUF8XKuof8gKU7SgzRYjbfSwGcT42ijqmeaUd2A8aSRsPj1FzHrQYEhi/eucFwAXiXi0PYS1isR5fckyDITlr54uVcAwYAApnMDIStVq3pM71Fdepq3bTpEKijqzJ63sri9or6nwXzkatgawxzWeLvtzXnI70SP5bKwDCB6IkJmbJg2gR9SMhgnWxM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(136003)(396003)(346002)(376002)(230273577357003)(230922051799003)(230173577357003)(186009)(1800799012)(64100799003)(451199024)(478600001)(6512007)(6666004)(52116002)(26005)(6506007)(9686003)(6486002)(38350700005)(38100700002)(86362001)(33716001)(2906002)(66946007)(6916009)(66476007)(66556008)(41300700001)(5660300002)(83380400001)(316002)(4326008)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LOgSzdKzNfqW6QuFM//ohWCELdLb+XvTcu3yHAMYL4my3CJopEmmhoJhajwF?=
 =?us-ascii?Q?M1hclbALlwclCWqZAM5Qle89jCCuvDEjw+/qzisyKXzjXfpekRk1KkOzAXyq?=
 =?us-ascii?Q?e6i9PwXR058B4cLY86oGguM4Z20NhR64qSW8E8NeWaolvnHHD8CyzA78Yfkh?=
 =?us-ascii?Q?EfbdyH534L60gcCp9jZy2vhfh4f+olxmJSgBPhGGm5435tQkXN9Pt32yVThg?=
 =?us-ascii?Q?PC2L+T5wlRrziqxv7V81/U7eNBJBmFvo60HSUaXSSj3y87yle8BHCsbNq0NM?=
 =?us-ascii?Q?ewIzwjHi7SkOV5z05OigDK1BNBxoMRGpRSXaOYGxr5rlLjNQqPDhDtB6P2cm?=
 =?us-ascii?Q?uEUfGPTEudrHYoi2n9IbI5atQkLyZGN9Qhn7f8H0ol8mb2lSB9aaEltRLwYg?=
 =?us-ascii?Q?Cw9EwwPVMYgcHF3Wbvvm+nJ1o41OunLQhexPabiPQ1eI59TfOjzehGJpjqFb?=
 =?us-ascii?Q?9Xs5Sbrxr7QoGiDgQwk6CB3LAGzQezH3YBBJad2c0vMBuZfQKxpGv9M0SOU3?=
 =?us-ascii?Q?oaqeoFditMyGXWSQ5bJVlDgUSCFpt20K2YDlWsZ04/uQIrOB7xK5oz7+jxKS?=
 =?us-ascii?Q?UUdcWiV03X26CInxUQ7ghbYC0nN7iecATmrQ0RPfa2QQwEd2caLXog6HEkJj?=
 =?us-ascii?Q?YgjfXcy2uaZAVAucqXl0JMp3Ovh9M3DNrIfkfhF86AuOUnFOa28S9AcaWWk6?=
 =?us-ascii?Q?JPUbn/TVE7YfbaBfkbPp+o3cwAp3cp2GDaWpFnIVpqgueR1rS3A3ooN9FJak?=
 =?us-ascii?Q?q5PzEM2PiTktInOMZ1Z2lYLcSBbbT3LDYOegt7+VaQXSQvq//5r0sUmikVT6?=
 =?us-ascii?Q?MCqOEPRg461F95+3Q7yZns5oKsrEN44lJnN47FSgi3CI0gkA5zWhjsDU3yVp?=
 =?us-ascii?Q?1rF4Zekac8wFah1iixNl0p1SgWkHXswHOfbkTmgcBqiZj8NZJJ73Dc/KlykF?=
 =?us-ascii?Q?W/IEa9FbM/8oQzt/WSD9BHOqPTKHPObyMM+WsgYy6t8p9Tx3uLHFvs9jLnxI?=
 =?us-ascii?Q?rcKNQDiijMtvBlL2LMYksHtcvoRzbbs6PKKanD3+Ue8niZb+OIDK+6cl/ds5?=
 =?us-ascii?Q?uubB5FaRYXSB3hVSR0EmdeLp81ShXV2UHSWhh7SzWrpZwGQdgg/l3SzTxuPJ?=
 =?us-ascii?Q?QjeH8DWLpJNlgb20ndWlwm/rWrEQCeeVTx9zkTsd8lIIPQKxermcMHYaBXIz?=
 =?us-ascii?Q?3aLN20aerelMuKVpaVBLVv4Xu+cvH9pXyRnKMVAOhKlglleqe96NXUP2o2La?=
 =?us-ascii?Q?fF6MV7zQxwaogjar+BS80662zppcDiFdLK52PHTzuhtjzKOcG+i8rk96evls?=
 =?us-ascii?Q?2UbKHovmc6e8UUKTsAIX0dwbU988UHPOPzBR02qqIwkz7TGu5BQdakNanJOb?=
 =?us-ascii?Q?oCAvfHBJFjKbao8IyohUziVomCAJz+hsMn1i4X/G52H1MN0fWrP+5VAbvMAV?=
 =?us-ascii?Q?M3ikcc917X8l+dff+pLh0texU0vJFJCbjT5Ejr2sgYLhqHlG36Gwrw7wwzeE?=
 =?us-ascii?Q?vlIRgAEhuuACgT9NL6+VZiLb4QF89bQD/KHxIKyzKAY/Qd5GjcvaPW3swLO1?=
 =?us-ascii?Q?qxXzpWh5T0UiFAAYjxajMENBNNomtgK9JzvTr1AA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69ed4690-f2c6-40a8-9f8a-08dbfb2e242d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 16:19:40.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BiWL3tyXtNE7WJtMbHK/oS4YLv36gt45/uZHtIJtFPsdmWlBuroanc1oACBbnXhERloWTI1lZTzzeZhCixJ+dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8978

On Mon, Nov 27, 2023 at 05:55:36PM -0500, Frank Li wrote:
> Change from v2 to v3:
>  - fix sparse build warning
> 
> Change from v1 to v2:
> - fixed mcf-edma-main.c build error.
> - fixed readq build error. readq actually is not atomic read in imx95.
> So split to two ioread32\iowrite32.
>   It needs read at least twice to avoid lower 32 bit part wrap during read
> up 32bit part.
> 
> first 2 patch is prepare, No function change.
> 3rd patch is dt-bind doc
> 4rd patch is actuall support TCD64

@vnod:
	Do you have chance to look at these patches?

Frank

> 
> Frank Li (6):
>   dmaengine: fsl-edma: involve help macro fsl_edma_set(get)_tcd()
>   dmaengine: fsl-edma: fix spare build warning
>   dmaengine: fsl-edma: add address for channel mux register in
>     fsl_edma_chan
>   dmaengine: mcf-edma: utilize edma_write_tcdreg() macro for TCD Access
>   dt-bindings: fsl-dma: fsl-edma: add fsl,imx95-edma5 compatible string
>   dmaengine: fsl-edma: integrate TCD64 support for i.MX95
> 
>  .../devicetree/bindings/dma/fsl,edma.yaml     |   2 +
>  drivers/dma/fsl-edma-common.c                 | 101 ++++++-----
>  drivers/dma/fsl-edma-common.h                 | 161 ++++++++++++++++--
>  drivers/dma/fsl-edma-main.c                   |  19 ++-
>  drivers/dma/mcf-edma-main.c                   |   2 +-
>  5 files changed, 223 insertions(+), 62 deletions(-)
> 
> -- 
> 2.34.1
> 

