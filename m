Return-Path: <dmaengine+bounces-70-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A014E7E7D36
	for <lists+dmaengine@lfdr.de>; Fri, 10 Nov 2023 15:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBFCA1C2099A
	for <lists+dmaengine@lfdr.de>; Fri, 10 Nov 2023 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3FDE1C2BB;
	Fri, 10 Nov 2023 14:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kY3d9902"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDB41C694;
	Fri, 10 Nov 2023 14:59:14 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2051.outbound.protection.outlook.com [40.107.6.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764F73A20E;
	Fri, 10 Nov 2023 06:59:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc+IMNeTYrel3FOICV+tHPPa32ENJs8l0QE5T1noRxGXXRLwfvkp2b+NiSmIoN25p9YFHHshlbuQpFCAUL4vITKboNOPbbUvnXdni6mNuC2EeyKWeuAC8vYKwVJvXCN3dyjGSPs7jlJWv3RcT8puqXywGQ6MtTUsVtdOrvAWE/QtEm3Lf6QjZH8PvkqUB9XnPWxky6k+GnGpzgq2WtKxzEiy0by014G8QrAGYbJQLrVPB/yf5gN6qi7Rbbkr+L1+cUoTAOBAadR46ylkUgsACJsdRAEVoc2F1xL2tBiM6ZeVdJ16ICnXbbVGNCQRf1gAemQ6Srde0da7oUMJNYKdQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kF4E8yiw3CLKfyWBsvzDUUOu0hXpHiVruycrkOmOgfM=;
 b=mH7mCBJZZtDquar2wi5evrOSkG3SVkm+GAx8h1O4WeBcY0Hbm11zrEa0unfp73+j5aQTu1j2VRoYZsGOMDkbwsGZDI23lzOJUaB7NEC1VKhcBGoVaEAv6qkMVUbtgX4XyagpE9bqb1GLWH6BHs0bxr1GR9Ley3/pun6u6rY0xAzErHX9vOfD1Q733VVQBW15Xd2wY0AW+MDi0NOgIDzf4OgFx4RLP+FSo9f9cQACL0U0VsW5C9tE7CtZCnjwXGTRpEVxDu1HS4kXtOZWKx5eB41J84KoaFx5JybHwnVHSxooja+te6K72KQrknqu8sGpaDQ7LGpGwPJp2VBRLkW3ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kF4E8yiw3CLKfyWBsvzDUUOu0hXpHiVruycrkOmOgfM=;
 b=kY3d9902Lov3MVcNnSDfXtq7SLX5U18rVyLqCh3RHWw4MN1kwJnrY4vI8ExlHM6YFXYtioC28uAew1ye3VtDxaKXIUCKKVPnDbMx5mjZuqJ6YFBhNis5/3OsWiW1jUB2jZY9GchKikDVLT4SWpWpXaBcH7wp00tXsIp/653gGBI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS5PR04MB10041.eurprd04.prod.outlook.com (2603:10a6:20b:67c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.15; Fri, 10 Nov
 2023 14:59:11 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::55e7:3fd0:68f4:8885%4]) with mapi id 15.20.6977.018; Fri, 10 Nov 2023
 14:59:11 +0000
Date: Fri, 10 Nov 2023 09:59:03 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
	imx@lists.linux.dev, joy.zou@nxp.com,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	peng.fan@nxp.com, robh+dt@kernel.org, shenwei.wang@nxp.com,
	vkoul@kernel.org
Subject: Re: [PATCH 4/4] dmaengine: fsl-edma: integrate TCD64 support for
 i.MX95
Message-ID: <ZU5FN1dECvzDIUHb@lizhi-Precision-Tower-5810>
References: <20231109212059.1894646-1-Frank.Li@nxp.com>
 <20231109212059.1894646-5-Frank.Li@nxp.com>
 <f095ba95-ce76-4821-87b7-083f4162fc63@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f095ba95-ce76-4821-87b7-083f4162fc63@linaro.org>
X-ClientProxiedBy: SJ0PR05CA0026.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::31) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS5PR04MB10041:EE_
X-MS-Office365-Filtering-Correlation-Id: 65b23300-ffca-4eb1-e592-08dbe1fd98cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ozvPZDX7mLMQJnwghMKFLy088pWgc+WTMrICDu18rcXjy+UFkVsfwRj9eECMNPWCGuMzUuaSfw/UgNZTdCOe6GJj3qYIs9GilopFtaj6jST286wbG7Cs6m95dXdmIwYtwjvFOiJ67TQoHVLApgb8OYenfP3I0RwHqy8Rre0HgDlqpSOglg9P4eClruKvVr3gBJmjEpLVyBjyFATKqOkpfbRHqrnYCIBsavuOV0SpuXLIT/9HcRR86ki27c3EQmgozlO3+DffT1LSNfIb7/KwKxx4RbRGAYg/mAWmgCEUrIEVfsTT00oAmrm6jIObJj3lphhNY1WA5uCoyirQd4Mwt/WXFy/xzbbVMPFq8iXRFXEG+sx1tGH/+8C+OKy2s/Cy+1M4GL38FFgiA5CuJvMaJhwg++5Q7f7W/vrQUTtfNKFJI9i5r5mRfs1TWbcMnpFNQqZyJPmGtCjEPGmmV+/EQtojoMecxfd+tKmuWmgQnn+fDaXHtIy438qqwlunMLWxH114b9Mzke8X/tOG9MSnEcNphWfTcnzo8hcOpbLQjvKzVR/ltWPGDdtuXGrrORj5liTrPyF6iQ6Yq1hI1EbF99jezXZSIoF86dya1eO1IGfsFr9XOkYx/EuoH8JqW81o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(6486002)(6506007)(52116002)(9686003)(6512007)(53546011)(6666004)(478600001)(83380400001)(26005)(66476007)(66946007)(66556008)(38100700002)(316002)(6916009)(8676002)(2906002)(8936002)(41300700001)(33716001)(4326008)(86362001)(5660300002)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?atg3f9hE2xnGxEgD9xsTdxNyKF8Pv/lxaWo74L4EmpnaCobK7WXq7C+x790h?=
 =?us-ascii?Q?b87duZwbvbPQoHKB6dE694p8P5sgGr7hV6irr72ijEunYPkVw5FYU1uXRdLB?=
 =?us-ascii?Q?naD7S3qCCxRCeouveW2MZF34K+n+7YpRn6wacMgFcidmwgdStd+Ay6kkRMzx?=
 =?us-ascii?Q?ExSPeEJH9Dw2mpTlJKeh40LsLk0xrANWhh1fLHcxbggWhLfSXGi6HOC7nQm1?=
 =?us-ascii?Q?vCWnuuVe+aNKb4dlO+bTz+itQgIiG60cP5bv+cFn3fk+6Lb03jqUQUAJbNF0?=
 =?us-ascii?Q?RItLPsPh0wVdhJ/ni8JYX+a7xPbT4PXOirbhGD/Waf7p0m4Tyn3VGRNOchkf?=
 =?us-ascii?Q?YtdTO4QwHrxv90gmq3jPOkn+LKSpj1OZ7ohs7rvJ2nlDgPdWrIia1gYQnrBq?=
 =?us-ascii?Q?XpfUfnsLirXfAHUNPb1GggRRC3mysgH+bNl16E7T2OrQtsbKIds8JLLVFbcp?=
 =?us-ascii?Q?bSwVKfB6YAUqjz8Ri4FeYl1OTEMx85mcQTG9wIQy/Pikyv5zyYBTLt3CdJyu?=
 =?us-ascii?Q?qQcRIBDB34Af94vxGlPpRsfxxcwLNGjjAtid3b78JT1dnZFMCZa+nKM+BylO?=
 =?us-ascii?Q?vmc5oMbSXv+VLLpw13RX6No0vknx4NV5yTwDpCVhXliAL0ZxxWqQp3bguug2?=
 =?us-ascii?Q?+1e1pB6liJNdLpZf5YpFuh2rBFc9p0IFwEYgaYzGORYDo3ZSDDHvSC0GX6TJ?=
 =?us-ascii?Q?xpw5Fi3qgJNgxtC3H8Y6vyVuPWPOefdqIZU9BYQ1kIcXYDQp6cxlUTlDJJW7?=
 =?us-ascii?Q?PmpiwWWeI6BQuSYHkhr5RohN/VmpkgxoF5ravqavEUnNF87gyewZgO53OV3j?=
 =?us-ascii?Q?9hfouCrMR4MP2AA6HHF1k+L/s6BcgOhgFi5ZtBpder2E6oshJVC5bqdJi4E9?=
 =?us-ascii?Q?DNFkXPkKjNYwevrqSlznxfOgkfRYmkPTh0AkxymqpmQepjO2fagNT7LTP+In?=
 =?us-ascii?Q?QYcBV6Su+U5+ucsPotSROzBYEfWQVr4MijUQ5Dw/yu1lCwkt32hu/E/kaHzW?=
 =?us-ascii?Q?+c2lOgz2ZW/3h45GvkwwPdqKlldiZOcF9etl4czr/gqIC5g6JP3TyXar+V3c?=
 =?us-ascii?Q?hBrDWkD+3ydsAKpO1Wo5TE6Y5tZPcHzJ+A6ZnvrLKm/koi2dPfXhT0UmPujm?=
 =?us-ascii?Q?l9s7ZL3nYgkq+ff4qrH12OWO6rNPgdKOGfstscEh5fE59+u6rE8C4cbMmdE4?=
 =?us-ascii?Q?XGXgzgQ6uBII/SBCGHh77Qs2Ga8fvYxNC4BPxwGfo232DG1h7+BH6ddkXBnk?=
 =?us-ascii?Q?aZW5ABHvcNqam5i3Wit/Tjd5WS/YfKRN2vqWS3D2hQF4L0l42m1cBOo/LGsy?=
 =?us-ascii?Q?SzHOyQRrzjh22NyeLmGnIVyMW+6gaJ50JOmDGX61Gq98WC40Xet6lIsIfkRb?=
 =?us-ascii?Q?qYIymq8LVBNfrCoC9IQ3r+9YszCSJTqgfIhZCL3K4Y8zVW7BFB+nHjf/FYSI?=
 =?us-ascii?Q?Wym60tCIqucNVMoe5RSmSsCs+Q6IHCAIdW/YCOnm/217xP0V2PW/HF4tdi92?=
 =?us-ascii?Q?Mg2U52EsPCAg3dDGTu8E/+FLqlwACysa5TuhgZRPncuzqQpEP04wT/HmxEQT?=
 =?us-ascii?Q?DYFj++W4iWUnymCh89c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b23300-ffca-4eb1-e592-08dbe1fd98cd
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 14:59:11.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bot/q5pJwlRrrDXruTW+/smkaRXMw3UXgaS+PZmcUN0bstKVTtSxNnQGt8oheZWuRvAGCzWBiOQxTVr8Dw8ooA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB10041

On Fri, Nov 10, 2023 at 03:50:18PM +0100, Krzysztof Kozlowski wrote:
> On 09/11/2023 22:20, Frank Li wrote:
> > In i.MX95's edma version 5, the TCD structure is extended to support 64-bit
> > addresses for fields like saddr and daddr. To prevent code duplication,
> > employ help macros to handle the fields, as the field names remain the same
> > between TCD and TCD64.
> > 
> > Change local variables related to TCD addresses from 'u32' to 'dma_addr_t'
> > to accept 64-bit DMA addresses.
> > 
> > Change 'vtcd' type to 'void *' to avoid direct use. Use helper macros to
> > access the TCD fields correctly.
> > 
> > Call 'dma_set_mask_and_coherent(64)' when TCD64 is supported.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> Three kbuild reports with build failures.
> 
> I have impression this was never build-tested and reviewed internally
> before posting. We had such talk ~month ago and I insisted on some
> internal review prior submitting to mailing list. I did not insist on
> internal building of patches, because it felt obvious, so please kindly
> thoroughly build, review and test your patches internally, before using
> the community for this. I am pretty sure NXP can build the code they send.

This build error happen at on special uncommon platform m6800. 
Patch is tested in imx95 arm64 platform.

I have not machine to cover all platform.

Frank

> 
> Thank you in advance.
> 
> Best regards,
> Krzysztof
> 

