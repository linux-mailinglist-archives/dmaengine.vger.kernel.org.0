Return-Path: <dmaengine+bounces-39-lists+dmaengine=lfdr.de@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 981417DDE3B
	for <lists+dmaengine@lfdr.de>; Wed,  1 Nov 2023 10:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AAEE1C20C05
	for <lists+dmaengine@lfdr.de>; Wed,  1 Nov 2023 09:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB732746B;
	Wed,  1 Nov 2023 09:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BLkvlL+F"
X-Original-To: dmaengine@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94E23D4
	for <dmaengine@vger.kernel.org>; Wed,  1 Nov 2023 09:17:49 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF627C2;
	Wed,  1 Nov 2023 02:17:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4kVKZYp60pBot6oqIUzBsEfYWSQik9KOjW9SpXcpKmJojTH4JUFhZ4a7gyxgwVn03GzRimHaTGgroY/t7W18vWrlw7yjhNd4i2bqF9e9Tt6NBcETT8U7yAd+n4r4oQOX9lJZeiTBzTlHOzH+fhzeO+u4TOQbboYUa3Pp28C3Z+zamCZ88aCvdPcrJBHrR8vUN0EVkFXgs7iKgCop+LuocWjWCwOmdt7iFvAFKnWHnCdjuKa5wycd2KtbTbKjieb3F8QKBFmqr/UVrKApdXxtjNINF2C1H/125c0bvA/iUhUO6bPWw6u6uAqD3KQ68L6UsmYa564p1Ed/1TWXlW4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q+An+i+JKrrW6J416yvb/08K1+W+KNaEUXnyof+hN8I=;
 b=bp1OWRn8Im2QPf8o4jR/vujMRBYsIomhw0uYfH8Ujx2L1W3M4NsfofOoIVzqDxLBsDAnZ2+Hjq8Q9vjRuhuup4XyHxMRCGzJ8G5+bZ/C3pil9UnACB3eTPVWsvfYq1lrq4SFDCAlvhZ3X1tpIwdG/khg0DMDHuS5VWe2JEJFC6jPaKC5XG7PutOVzUL0zHg4KeQYdA+bk04iwDN4SIqALAH0axYKkjcS24GIdEaIgqm++oM4N38hiX/wso8QOaDQW4LxIENDDfRTxAinfvNEz+aigYSY1ttHQBBjluJk9OfQXzQfpzFlXf+QMx4XrydeD5D9RB5KsdqghrI6RPzd+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+An+i+JKrrW6J416yvb/08K1+W+KNaEUXnyof+hN8I=;
 b=BLkvlL+FErryfaAxPfrxJC60BZPFEsHRs53ZPiH95JU7EZj7UQ0Ahx5JkLH59WhT9krI02tazGvtXsrkWjroilIAJkaDa9a6zs4bFi8+e8+PKkiQdJwH42zLL8EwH+cGx/mbu2WLafBmjjGLN4Z0Q3UPbsgjyUTbJsBFlzRqvB4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com (2603:10a6:10:2e1::21)
 by AS1PR04MB9406.eurprd04.prod.outlook.com (2603:10a6:20b:4da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 09:17:41 +0000
Received: from DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::9053:40a1:dffb:5169]) by DU2PR04MB8774.eurprd04.prod.outlook.com
 ([fe80::9053:40a1:dffb:5169%4]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 09:17:41 +0000
Message-ID: <ea03144c-f3c1-656a-3b99-062a00850c58@nxp.com>
Date: Wed, 1 Nov 2023 11:17:38 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] dmaengine: imx-sdma: support dual fifo for DEV_TO_DEV
To: Shengjiu Wang <shengjiu.wang@nxp.com>, "vkoul@kernel.org"
 <vkoul@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "shengjiu.wang@gmail.com" <shengjiu.wang@gmail.com>,
 dl-linux-imx <linux-imx@nxp.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1698824426-16111-1-git-send-email-shengjiu.wang@nxp.com>
Content-Language: en-US
From: Iuliana Prodan <iuliana.prodan@nxp.com>
In-Reply-To: <1698824426-16111-1-git-send-email-shengjiu.wang@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P250CA0011.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::13) To DU2PR04MB8774.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::21)
Precedence: bulk
X-Mailing-List: dmaengine@vger.kernel.org
List-Id: <dmaengine.vger.kernel.org>
List-Subscribe: <mailto:dmaengine+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:dmaengine+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8774:EE_|AS1PR04MB9406:EE_
X-MS-Office365-Filtering-Correlation-Id: edc2e013-52ee-4620-ad81-08dbdabb6633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iCe8y+ZRch246bg0ZxueVKd0Tviu1f9CAWe4dOVwNjUhy2B613wgDTC0WRHV+AN/foHrbyAz1RobOy4QwV5PqP8ivajv5LV79X9BLi0u8pB3YvbnwdqxR+CtHNjefSEL+R8Kg0HZ6jPCgCXT9HPOw9QPmdv6KjRoRJ7lHPz+3myog5dhFd0MVyuPshA9PC6Ve4mrfzcwb8K+P6Ftw8CKOtrl7cg43LYnY2OlCr2QmeWaF2zrW4kt6fnXH5SDfqj+8gYlkfq/mdtOpZxK6TBX6bFL5DgBZW5YT/PoLMc8FRlqdOeOEuepjqBhwC3by9WcFrpOcvvbgUPvkqfNQePdqqHheMYRLaSNsDVHCP6+VjSUFKagxakvMBFS0pkKzxiA3Qb0GYzBJF/tVs2J9MnTxXSiMsdw8rFaV33O1IiWzmP/Qg+yS/2iGWXZ8/pu2CVsUmLOMVRwuV3LiYDRKUI1XgKRFd1tgNCOo2u8WYGr4dk97BpwNdLpYgdNBYD232CBcp4ovefRDvz1PAbubC99rFEPjlPXQFRy7NDOkVZN5EV88u/Ug+JOuvX03f/pi+MnFZGu7c09+XBWa5VEP3yuCNxMVQBV850NMHUPBQ5Vw2i9AFUA7RMTKuuJ0G7j4g/2zOfRIJ0PCLRlxNPPix9DXA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8774.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(2906002)(41300700001)(31686004)(4326008)(5660300002)(8676002)(44832011)(8936002)(2616005)(26005)(83380400001)(54906003)(66946007)(36756003)(478600001)(110136005)(66556008)(6512007)(316002)(66476007)(6666004)(6506007)(31696002)(86362001)(53546011)(38100700002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGJRd1FYM0REUlp0TTRZQU1acHVoV2pLZ2lmSTdQUGpiN1ViYnV0UHBSSFRa?=
 =?utf-8?B?MHdFaW5DeG5tbkRRUnRld21rd3R6VktuTUZPRFU5WDZ3NFFFd2diSm1LZzRq?=
 =?utf-8?B?cTdUaXRrU2xibFNRM3RKdjRjSVdoc0R1MnJPelpLV3Uyd1lnSmU3VmRpNzZO?=
 =?utf-8?B?Y1AzZDNmcS9NQmdTNDhTMWdkUDdrK3I3TWRiM0xHc1VGazg2L3Yrb2c4dXY0?=
 =?utf-8?B?SkFmRVRJVVlVSHB2RnhnOWtRZkdZSEF1dmphdFF5VDdoZVowZG16NEt0MDQ0?=
 =?utf-8?B?Q290VnkyUnZzWjdMZFBGK0N0cGk1L0N3d0F2OGtlMFdVcVUvSHhrL1RZRnN2?=
 =?utf-8?B?STlJVWNiK0F4MW1Da0g5TDRWRUhyTzFLemNBNlBCelYxU2ZtV1R4czU1NzBZ?=
 =?utf-8?B?bHNuZWRrVTQvWndDSG1WRDlCcFpGeDkzbzBQNGRLY0F6WHF2cWRLbDZyMkRj?=
 =?utf-8?B?YkVJNWpUMmlxMmtBTU1hUzJwbm9GSzR4OXZYOUEwdEdOTTRNam9QUlkvMkkz?=
 =?utf-8?B?RkFnbEs0c3ZERkRoN05ld3NieE1XUGcxeFdPdmtjUkVMRHR2L01abVlFRndN?=
 =?utf-8?B?ZmNieWZVSHZkSTdpd2Z0N3o1bWVzODQxT1krZXF4ZjNnQU9qaGdqY0k0dWxl?=
 =?utf-8?B?aXovTWZJSE5jdzJVQnNUUUtwWlJ6TzdjS05KMHdWdnJBa1QvWm9hY2l0Z1ZO?=
 =?utf-8?B?MEZoQU81bit0SkZURStUR2VnMnRBNnBXWVMvVEN2UXUrOWUwc095ejQxdTBk?=
 =?utf-8?B?bW5kTnVrVGhkbjd6aE5jc0VXRW5nblhaOWQ0SnNwTHJHenVDVGJoZi9zdHZy?=
 =?utf-8?B?ZEtzeHZObkY5QnUvbmJHY0VOSjBpMXo1blM1S2ZpZHpPMmtrZlh3dkVwQlla?=
 =?utf-8?B?dzh6NGJHKzFmNVgrclEzOEk3NUNZbzF4OG91VHQ4ajYrbDVBdVhWalhNWTF6?=
 =?utf-8?B?WjJlSTVqem1YTk1OaWRQVDN5L3Y5U0F3TVMyWGZyQk1zZXZkQjczUnM4bDhB?=
 =?utf-8?B?L29GbWN2K2Q4TmVDdFFrMXFscVpJTmhRenlGTlh3WFU3anFqZVdVeTdlRWNZ?=
 =?utf-8?B?TUFNc3hLOE5YOXdCeVZYV1NIMlNMc3BSaElWV0FQN3l6RWdQemlHUXp4TUQz?=
 =?utf-8?B?NkdQTHBSaUZ0UTIwY1BHT3psUXU4L2R6VjgvdDJhT0RmRTlnY1hZTEpLSWRj?=
 =?utf-8?B?eW1hOFNhVGZvZmRUZTNnSkhPbnNKSVlBeGdDRHJGVGtGd0phYUpWTFl6bTBm?=
 =?utf-8?B?aTRTQ2RkYU9JbzFiNEpXdVZWK2hyeFRiTG1temw1eHdieFNIMWdWSEVVZ1Zt?=
 =?utf-8?B?K0RGTkRjZndweHAvcmpsaFV6WHI2MXVCeUpFTm5OM0hMMVBUU29LN3hTamlE?=
 =?utf-8?B?T1NEd2ZPYnBuOWRvbTNMeGwyK29sNW9na2ZwWjRYcWo0U251cmZHVzFoS2lS?=
 =?utf-8?B?cVdHRk1pdE9HNTdFRkFQYlhKUW04Znd1OEl4NmcwRWVIRkRoenFTTzkzR1VX?=
 =?utf-8?B?bHJFOXFmVmIxUlh2Nkw1ZDFRUDhNRTBPenE0N2lKUXVHV0V5Ylh3VjRXTzNa?=
 =?utf-8?B?bCtFNWJtUVV1SWc1NGhtQ0dyYUlWcnREUlduQ1NZb3hJcHcwRUxnVWgzdHhM?=
 =?utf-8?B?TDBmaktOeE1jYTYyMURXbXFqcmZZK0tVK0FGRUU1M3lhakd2K0svWDdZUGhE?=
 =?utf-8?B?YmtZTnVPZXczOGg5b2IxNE5PeHFDTldXVUhXd2lxNTh5RGVXYTBoRGI4N3FT?=
 =?utf-8?B?S2lTMVlPRDVpcE8yc3g2ekFHRllGTUNiSDJnZURWazdRVGN5SkQwOE9tNFpB?=
 =?utf-8?B?cE44QURlbjhUVjRiSDBoVUh5U0VaeFp5QW42aHFhd0RCNlBKU1pPVlowSnJY?=
 =?utf-8?B?ZWlPV2dUUFN0R1BGWUM3bzN3ZXBnZDNRMXZnQkErS2tKVWZlY3RLQ21ERGZW?=
 =?utf-8?B?UTljRFlvVEdvVUN3L2ZMWkpRWmd0RytHeGE4cDFsck5jdUhNN0NpSjRsbGdv?=
 =?utf-8?B?OFJGeU5wWVVES1NTZU84N0FwVnpzTWdOYkdFdStjVUNpaW9WQ1RHRzJJdkxG?=
 =?utf-8?B?K25IdG85TkE3Ym5wYUZpZlBlb2tqMk5SMlBYMXBCb3NaYXMvdjBuNkFBS2Jl?=
 =?utf-8?Q?yFIfdcpsA/HXswLWvvdYIqnTp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc2e013-52ee-4620-ad81-08dbdabb6633
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8774.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 09:17:41.2994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/UVm3Sl05FiAEW1EMUqGVOE3qq9I9CqFpGaHspDPJqTn0OldN2SaIXQMd7t0Ot0SZ4m2P3ZjP8UFdnGt+iQ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9406

On 11/1/2023 9:40 AM, Shengjiu Wang wrote:
> SSI and SPDIF are dual fifo interface, when support ASRC P2P
> with SSI and SPDIF, the src fifo or dst fifo number can be
> two.
>
> The p2p watermark level bit 13 and 14 are designed for
> these use case. This patch is to complete this function
> in driver.
>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> Signed-off-by: Joy Zou <joy.zou@nxp.com>

Acked-by: Iuliana Prodan <iuliana.prodan@nxp.com>

Thanks,
Iulia

> ---
>   drivers/dma/imx-sdma.c | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index f81ecf5863e8..892e23cc0ce8 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -137,7 +137,11 @@
>    *						0: Source on AIPS
>    *	12		Destination Bit(DP)	1: Destination on SPBA
>    *						0: Destination on AIPS
> - *	13-15		---------		MUST BE 0
> + *	13		Source FIFO		1: Source is dual FIFO
> + *						0: Source is single FIFO
> + *	14		Destination FIFO	1: Destination is dual FIFO
> + *						0: Destination is single FIFO
> + *	15		---------		MUST BE 0
>    *	16-23		Higher WML		HWML
>    *	24-27		N			Total number of samples after
>    *						which Pad adding/Swallowing
> @@ -168,6 +172,8 @@
>   #define SDMA_WATERMARK_LEVEL_SPDIF	BIT(10)
>   #define SDMA_WATERMARK_LEVEL_SP		BIT(11)
>   #define SDMA_WATERMARK_LEVEL_DP		BIT(12)
> +#define SDMA_WATERMARK_LEVEL_SD		BIT(13)
> +#define SDMA_WATERMARK_LEVEL_DD		BIT(14)
>   #define SDMA_WATERMARK_LEVEL_HWML	(0xFF << 16)
>   #define SDMA_WATERMARK_LEVEL_LWE	BIT(28)
>   #define SDMA_WATERMARK_LEVEL_HWE	BIT(29)
> @@ -1259,6 +1265,16 @@ static void sdma_set_watermarklevel_for_p2p(struct sdma_channel *sdmac)
>   		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DP;
>   
>   	sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_CONT;
> +
> +	/*
> +	 * Limitation: The p2p script support dual fifos in maximum,
> +	 * So when fifo number is larger than 1, force enable dual
> +	 * fifos.
> +	 */
> +	if (sdmac->n_fifos_src > 1)
> +		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_SD;
> +	if (sdmac->n_fifos_dst > 1)
> +		sdmac->watermark_level |= SDMA_WATERMARK_LEVEL_DD;
>   }
>   
>   static void sdma_set_watermarklevel_for_sais(struct sdma_channel *sdmac)

