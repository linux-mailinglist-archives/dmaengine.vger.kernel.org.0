Return-Path: <dmaengine+bounces-599-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D8F81BA56
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 16:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 200871F22400
	for <lists+dmaengine@lfdr.de>; Thu, 21 Dec 2023 15:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C086541A85;
	Thu, 21 Dec 2023 15:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qite+Xp8"
X-Original-To: dmaengine@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2088.outbound.protection.outlook.com [40.107.14.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31957539E4;
	Thu, 21 Dec 2023 15:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVaxBpyjCE4mN3U7XPkLHdx/FQiEBlk/ypiRvk7ehJR3IgoEuaIZiroISNVMq/aTZczj39JFHNP5klv0zxtc/vbM5s/PDwt6pfa3hE+cBx1IYtcG8DLzB0xEue5hpchiCaaCg0DvnX+sB5UHbbvRml9OUQBYZFhZQjp+tUiJCHYoeaeRp0CaodqyNvf4dPUXQCsmjCpdKyF/AIKoaVbab8/WqX8jumUTuqnTa2e3fubxw/vg47C3VbXHDSjjZnokSbR6PkWS2vl7tR27MIVHcfL3BQBi9+chCzw7AWeEBJBcw/zoFvvnTBl7SHhyEQKKMhtAbpPYzQ3LLTQed4HxuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kyJaGYe/CRcrs+2pC5+M7st6A9DuQcDIFH+zra0srXg=;
 b=TVzrEkaCLGxg0DAEkjH1BbRbOLNgK3kb387pnAqwOcigAe7osYlAWtE76Yt3gIz4RPQW9KW5btbNL/dFEOof1N6zm1b4L/U2bWIPUucTIT7XEATLjVyPe2S4QaIOZhxEoDETmiF3RJYDpZrAhuNN6y0fxdOkbrJGi0WwRU4s0QVMfcpbpZIa3Pp4oOoILssvHdPOjRD274TYZuovQrDB3VJ1PIoN3QLOcDxHhupY1uWWsQxM3/zplA726PudxJFRvhNvzDl+1XL4eYfw02QD9+WEa8+WOJ6YFmGEv8enhSHzfbScIy2BuiunPGNDaB3NQ+H4ikTny8ni978NneAmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kyJaGYe/CRcrs+2pC5+M7st6A9DuQcDIFH+zra0srXg=;
 b=qite+Xp8SYUvfthzS+SjyFFrpSOUPWP2CBi0A1B/BDJnyAmFGWTQ3xLvA3XQFDqUzYZ9J/GdWAxIjCwh7MxRsetQzdf5VXxtpOusVN1qFgtkmlKYhElINT4xSiQh5bjnMyWip2Nx6h15OeCID2/cbpjZmevSyrF+LSpHw4t/xQ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7529.eurprd04.prod.outlook.com (2603:10a6:10:208::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 15:14:38 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 15:14:38 +0000
Date: Thu, 21 Dec 2023 10:14:31 -0500
From: Frank Li <Frank.li@nxp.com>
To: Joy Zou <joy.zou@nxp.com>
Cc: "vkoul@kernel.org" <vkoul@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Peng Fan <peng.fan@nxp.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Shenwei Wang <shenwei.wang@nxp.com>
Subject: Re: [PATCH v3 6/6] dmaengine: fsl-edma: integrate TCD64 support for
 i.MX95
Message-ID: <ZYRWV+tRXCrP7t0p@lizhi-Precision-Tower-5810>
References: <20231127225542.2744711-1-Frank.Li@nxp.com>
 <20231127225542.2744711-7-Frank.Li@nxp.com>
 <AM6PR04MB5925D78A39F3CF7F9273ECEBE195A@AM6PR04MB5925.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR04MB5925D78A39F3CF7F9273ECEBE195A@AM6PR04MB5925.eurprd04.prod.outlook.com>
X-ClientProxiedBy: SJ2PR07CA0005.namprd07.prod.outlook.com
 (2603:10b6:a03:505::29) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7529:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e514ea0-d460-4192-affe-08dc02378ca1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	16aqbn64E6IEl9wFsv7doDrVKvwO6nKPg06BTmQ17775+q9GaMESvoqjYZvdFkXlThcBoPjh+fDnGbHa2Mxlil/wCRXYc8QP82liaW07FgfnBHlleVcpNwhi9F6DwaduQ8dDKA+XKZR1bSDe6rBp10m+FYkBXFYflx8PH+bWUeBjHDnCP8BAxhetpT4stxVXJ8TFzoZjJsoPQGEFuL4QpbqM7NNobOMsNhCbN943/OHtITgF6f3pwiyoISqjOaN/zMXbFMMRTXnYCWbuS7K/6peaTizmd4qJThgOLFTAdwS/9leUBpxphB1z2LkSRHXzYFd2/gj05E/YmsLvF2Fs2YJew9fXR75BffjeeF8+BDt4PSUiEuE3Y9eJips5zIUDVl0OL4+axhAPAxJc5sxSChZb/EbuzUq1j5AwgpaTqW46Ebw7PRfe3UQnJhA0jxsO6YYiGMLXYeS+U1993CzfAffGWWYcTmm/dxu9h2GdhxLdvR9YOzO/h3s3FxJh0NkGp9GXoMFTXFycIErwC6tEB7OoaNunAWQZlQnbAAJUQYoYlINKnAd5zUGukzgalrrDLrRw7UmoJbrvetmQHZ+lsKlPbKeKqs5V8Icp3i8etAwgnGHPPTOIXKQG8LvVYwYjy61Ff6K5W2UfNHRrZwmglg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(136003)(346002)(396003)(366004)(39860400002)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(52116002)(53546011)(6512007)(9686003)(86362001)(6506007)(26005)(6666004)(478600001)(66946007)(54906003)(66556008)(66476007)(6636002)(6486002)(83380400001)(316002)(38100700002)(38350700005)(2906002)(8936002)(5660300002)(8676002)(6862004)(4326008)(33716001)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzU3SnBQWWcxeUkxTDhOZ0pRWjRhbStLaDZra3dldXBXZGQxU3pPYjdkY1JM?=
 =?utf-8?B?QVo1MjVCaVBBVkp5OU5NTGRHZ281SnZRblZZUi94UEI1akpGSHpQL29NN1Fs?=
 =?utf-8?B?VW5jcm83QWg3RHhXMFdsNm5mR25FRjEzc0hwZ3F1UW9KZERVYjhkb1o1MGlX?=
 =?utf-8?B?UjIwNkNlb296aGpIV21xeEJEUTgySlF1WUFicy8wcmU3T04za2J3SW1CdCs0?=
 =?utf-8?B?Q2FOQVo0dURIYTk4MkVyU1h1THVNeGNOcUt5KzRMM2tVZEJEekxVRFczQ0Mw?=
 =?utf-8?B?TFhrVG9BWEx0OU5QZnBPM3JUOXlLWllrOEtTK1pIekJTSzd2OUdaMlo4WFEw?=
 =?utf-8?B?eFcxY1pIZUswdWxOT21zN2F5RnVrM2JleitRWjJMZE1mSHhnYXd4S3Zzczd6?=
 =?utf-8?B?QzhYaE55Q3ZYVjZUeU8wVkczNk9lMHhoS1V6cHJBdTBLbW1wZTIzUVVyOG5h?=
 =?utf-8?B?ZXNPU2hWVGlxanF5TkJJSmJ5amYydk1pRy96eHkwK1cxODZGb3p0YlhGQzQv?=
 =?utf-8?B?L3BvVFkyY2hmWDZvZTk2SEdCbjhPT0ErSzlVY3AxVjdFYjBTWTZJSVFOSCtx?=
 =?utf-8?B?eEhNVGNic3k0YmdYS05jVTVlSnFBdHlQNktPM3J1dTloeFJDTVFLbXBHcVJS?=
 =?utf-8?B?cStNVzNBLzg0eGxTL3U3Y3VQNUhjd2kxbVN5YjVwSkZPUlBhRGl0T1BySnFY?=
 =?utf-8?B?NXErTm9NRjRqbWsrL1VkV2dlWGFwd3pnVnN5WjRaMU9Pb1F1M3JvdnVzcUcw?=
 =?utf-8?B?Y1piOFpjVWNNN25tM0NsRjdIcjBIdTU2dXNvNEM2ZEpkSTQ1NUNobHcrRjFk?=
 =?utf-8?B?dWJWa0dzZS9hbTJRZXhwdUIvbnU2N1I4d0RQV1d3YUVkb2FNM2NjOXZ5cDIz?=
 =?utf-8?B?TmR6RENtNlFmdGw2NDBUZDZlSS83SDFtVS9ISnlSdHkrQTB5SWdrMm8yaTFX?=
 =?utf-8?B?MTJrY0hjeWRuSW4vZFFNVXZqcUoyYnMyK2xpOTErY1R0RE0vMTkremZRQzFX?=
 =?utf-8?B?UjFBVS9oV1FvN0pXRE52c2EyYWNCaUVRbm9SdXBrWnJ1elNLczErUkp3ek9Q?=
 =?utf-8?B?SXlFZldNVG1SYmk5d1VyYmFpbkpGWWhzSzhkREpKQk4vS1JzYkFsUTJsY0Rs?=
 =?utf-8?B?N1hkWi9EaC9BaDliV21WWDlHZnMrTThwNkh1SVI3d2x1QnA1NHN6QllHRUhp?=
 =?utf-8?B?b29CQW5UdE5TQzNwRHg2elpMOTMvTURLN2hSSDNXeFBhVUJPVHM1aUxaaHRQ?=
 =?utf-8?B?c1RnbU0xUWswVFNYUVNvTDhnR3V4TnozakVVT0YzVHdySW11dVZqR3ZsYXhy?=
 =?utf-8?B?ejZaamlTRkloNGFDdnpqaVpkTThMdy95SmtlSlV4U3NScWlUL0l2M25tVzdD?=
 =?utf-8?B?NlU4U29DZ0FhK3FqQ1k5aHlMZTNlSWJ1SHlxdjhTZHg0c1Z2a2dSZ3Zjb2sy?=
 =?utf-8?B?TWtwbWU5WUpTU3Avd3RESWlsS2xXVHhGYmVwb2dqRThqWHlBWk5XTWt5alNQ?=
 =?utf-8?B?M29ZZlVuL0pDSEs4S2J3N3FjMjM5Z0hlckgwYW1wZGUzVGF6eGV2ZlZibGdt?=
 =?utf-8?B?UGRISmg5VW5zQmw2N2tjanBkQnEvTEFHclVEVERhWEM3ZFNrUTRlMUdGUUFJ?=
 =?utf-8?B?YWRJK1pJTWl2STVTVDMzT3hpL1B6OFhML2x0U2JzVVk3eXFBK00vZEJGTE1v?=
 =?utf-8?B?Vy9jN1NLSVZOOU5VVE5mTUF0bFlscjNuenh2dDI2MWdvanh5KzhUS2Q2TVZM?=
 =?utf-8?B?YWg4SFpJb2dDSzZ5Q25lMitzbHlrQlp3aTB4Mk1EZC9xcDB2SVlHdWgxV3JQ?=
 =?utf-8?B?QWJBcXRDT1ZhQkpDWmEzWFJOOVlYQXAxdStqRVJTTENBNG5DMGlyZGlXbzlr?=
 =?utf-8?B?cDRrWHF0eFcvMDhQRklTMS9zaWQ0VXJFSTRMU2oxd3k4OUZiUHFHcURucXho?=
 =?utf-8?B?eUxVZ3p1Tkhya2p4eVVGblBLVmVQZEpoclcxaDV5TGw3QThzLzJJb2w0RGd1?=
 =?utf-8?B?UWpYckxDZTdiUnlvMFdCcCszRHB0WVVJTlp2dzlZT0ZkemRUS3oyUTZ5NWRN?=
 =?utf-8?B?RVJuR1Y2ZU1jd3hWV0FaRHQwL0JPczlEUEtLc29Nb2hNUFIzMFM5UjloOW56?=
 =?utf-8?Q?7gYM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e514ea0-d460-4192-affe-08dc02378ca1
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 15:14:38.7020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFPFQ/UIl3glt98zXNK+8Ydnvo3RAAMm4R3zylcJQrJQsvh8/KoKTffEhf9nMm9aqUoX5SGYcAdgXHa1ZfZOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7529

On Thu, Dec 21, 2023 at 07:47:19AM +0000, Joy Zou wrote:
> Hi frank,
> > -----Original Message-----
> > From: Frank Li <frank.li@nxp.com>
> > Sent: 2023年11月28日 6:56
> > To: Frank Li <frank.li@nxp.com>; vkoul@kernel.org
> > Cc: devicetree@vger.kernel.org; dmaengine@vger.kernel.org;
> > imx@lists.linux.dev; Joy Zou <joy.zou@nxp.com>;
> > krzysztof.kozlowski+dt@linaro.org; linux-kernel@vger.kernel.org; Peng Fan
> > <peng.fan@nxp.com>; robh+dt@kernel.org; Shenwei Wang
> > <shenwei.wang@nxp.com>
> > Subject: [PATCH v3 6/6] dmaengine: fsl-edma: integrate TCD64 support for
> > i.MX95
> > 
> > In i.MX95's edma version 5, the TCD structure is extended to support 64-bit
> > addresses for fields like saddr and daddr. To prevent code duplication, employ
> > help macros to handle the fields, as the field names remain the same between
> > TCD and TCD64.
> > 
> > Change local variables related to TCD addresses from 'u32' to 'dma_addr_t'
> > to accept 64-bit DMA addresses.
> > 
> > Change 'vtcd' type to 'void *' to avoid direct use. Use helper macros to access
> > the TCD fields correctly.
> > 
> > Call 'dma_set_mask_and_coherent(64)' when TCD64 is supported.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/dma/fsl-edma-common.c |  34 ++++---
> > drivers/dma/fsl-edma-common.h | 165
> > +++++++++++++++++++++++++++-------
> >  drivers/dma/fsl-edma-main.c   |  14 +++
> >  3 files changed, 170 insertions(+), 43 deletions(-)
> > 
> > diff --git a/drivers/dma/fsl-edma-common.c
> > b/drivers/dma/fsl-edma-common.c index 65f466ab9d4da..c8acff09308fd
> > 100644
> > --- a/drivers/dma/fsl-edma-common.c
> > +++ b/drivers/dma/fsl-edma-common.c
> > @@ -351,7 +351,7 @@ static size_t fsl_edma_desc_residue(struct
> > fsl_edma_chan *fsl_chan,  {
> >  	struct fsl_edma_desc *edesc = fsl_chan->edesc;
> >  	enum dma_transfer_direction dir = edesc->dirn;
> > -	dma_addr_t cur_addr, dma_addr;
> > +	dma_addr_t cur_addr, dma_addr, old_addr;
> >  	size_t len, size;
> >  	u32 nbytes = 0;
> >  	int i;
> > @@ -367,10 +367,16 @@ static size_t fsl_edma_desc_residue(struct
> > fsl_edma_chan *fsl_chan,
> >  	if (!in_progress)
> >  		return len;
> > 
> > -	if (dir == DMA_MEM_TO_DEV)
> > -		cur_addr = edma_read_tcdreg(fsl_chan, saddr);
> > -	else
> > -		cur_addr = edma_read_tcdreg(fsl_chan, daddr);
> > +	/* 64bit read is not atomic, need read retry when high 32bit changed */
> > +	do {
> > +		if (dir == DMA_MEM_TO_DEV) {
> > +			old_addr = edma_read_tcdreg(fsl_chan, saddr);
> > +			cur_addr = edma_read_tcdreg(fsl_chan, saddr);
> > +		} else {
> > +			old_addr = edma_read_tcdreg(fsl_chan, daddr);
> > +			cur_addr = edma_read_tcdreg(fsl_chan, daddr);
> > +		}
> > +	} while (upper_32_bits(cur_addr) != upper_32_bits(old_addr));
> > 
> >  	/* figure out the finished and calculate the residue */
> >  	for (i = 0; i < fsl_chan->edesc->n_tcds; i++) { @@ -426,8 +432,7 @@
> > enum dma_status fsl_edma_tx_status(struct dma_chan *chan,
> >  	return fsl_chan->status;
> >  }
> > 
> > -static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan,
> > -				  struct fsl_edma_hw_tcd *tcd)
> > +static void fsl_edma_set_tcd_regs(struct fsl_edma_chan *fsl_chan, void
> > +*tcd)
> >  {
> >  	u16 csr = 0;
> > 
> > @@ -478,9 +483,9 @@ static void fsl_edma_set_tcd_regs(struct
> > fsl_edma_chan *fsl_chan,
> > 
> >  static inline
> >  void fsl_edma_fill_tcd(struct fsl_edma_chan *fsl_chan,
> > -		       struct fsl_edma_hw_tcd *tcd, u32 src, u32 dst,
> > -		       u16 attr, u16 soff, u32 nbytes, u32 slast, u16 citer,
> > -		       u16 biter, u16 doff, u32 dlast_sga, bool major_int,
> > +		       struct fsl_edma_hw_tcd *tcd, dma_addr_t src, dma_addr_t
> > dst,
> > +		       u16 attr, u16 soff, u32 nbytes, dma_addr_t slast, u16 citer,
> > +		       u16 biter, u16 doff, dma_addr_t dlast_sga, bool major_int,
> >  		       bool disable_req, bool enable_sg)  {
> >  	struct dma_slave_config *cfg = &fsl_chan->cfg; @@ -581,8 +586,9 @@
> > struct dma_async_tx_descriptor *fsl_edma_prep_dma_cyclic(
> >  	dma_addr_t dma_buf_next;
> >  	bool major_int = true;
> >  	int sg_len, i;
> > -	u32 src_addr, dst_addr, last_sg, nbytes;
> > +	dma_addr_t src_addr, dst_addr, last_sg;
> >  	u16 soff, doff, iter;
> > +	u32 nbytes;
> > 
> >  	if (!is_slave_direction(direction))
> >  		return NULL;
> > @@ -654,8 +660,9 @@ struct dma_async_tx_descriptor
> > *fsl_edma_prep_slave_sg(
> >  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> >  	struct fsl_edma_desc *fsl_desc;
> >  	struct scatterlist *sg;
> > -	u32 src_addr, dst_addr, last_sg, nbytes;
> > +	dma_addr_t src_addr, dst_addr, last_sg;
> >  	u16 soff, doff, iter;
> > +	u32 nbytes;
> >  	int i;
> > 
> >  	if (!is_slave_direction(direction))
> > @@ -804,7 +811,8 @@ int fsl_edma_alloc_chan_resources(struct dma_chan
> > *chan)
> >  	struct fsl_edma_chan *fsl_chan = to_fsl_edma_chan(chan);
> > 
> >  	fsl_chan->tcd_pool = dma_pool_create("tcd_pool", chan->device->dev,
> > -				sizeof(struct fsl_edma_hw_tcd),
> > +				fsl_edma_drvflags(fsl_chan) & FSL_EDMA_DRV_TCD64 ?
> > +				sizeof(struct fsl_edma_hw_tcd64) : sizeof(struct
> > fsl_edma_hw_tcd),
> >  				32, 0);
> >  	return 0;
> >  }
> > diff --git a/drivers/dma/fsl-edma-common.h
> > b/drivers/dma/fsl-edma-common.h index 4f39a548547a6..6afceb9fded1b
> > 100644
> > --- a/drivers/dma/fsl-edma-common.h
> > +++ b/drivers/dma/fsl-edma-common.h
> > @@ -87,6 +87,20 @@ struct fsl_edma_hw_tcd {
> >  	__le16	biter;
> >  };
> > 
> > +struct fsl_edma_hw_tcd64 {
> > +	__le64  saddr;
> > +	__le16  soff;
> > +	__le16  attr;
> > +	__le32  nbytes;
> > +	__le64  slast;
> > +	__le64  daddr;
> > +	__le64  dlast_sga;
> > +	__le16  doff;
> > +	__le16  citer;
> > +	__le16  csr;
> > +	__le16  biter;
> > +} __packed;
> > +
> >  struct fsl_edma3_ch_reg {
> >  	__le32	ch_csr;
> >  	__le32	ch_es;
> > @@ -96,7 +110,10 @@ struct fsl_edma3_ch_reg {
> >  	__le32	ch_mux;
> >  	__le32  ch_mattr; /* edma4, reserved for edma3 */
> >  	__le32  ch_reserved;
> > -	struct fsl_edma_hw_tcd tcd;
> > +	union {
> > +		struct fsl_edma_hw_tcd tcd;
> > +		struct fsl_edma_hw_tcd tcd64;
> > +	};
> >  } __packed; 
> The tcd64 should be fsl_edma_hw_tcd64?
> BR

With help macro, it is not imporant, only used to caculate ch_reg address
from tcd address.

Anyway, it should change to fsl_edma_hw_tcd64 for better maintaince. 

Frank

> Joy Zou 
> > 
> >  /*
> > @@ -125,7 +142,7 @@ struct edma_regs {
> > 
> >  struct fsl_edma_sw_tcd {
> >  	dma_addr_t			ptcd;
> > -	struct fsl_edma_hw_tcd		*vtcd;
> > +	void				*vtcd;
> 

