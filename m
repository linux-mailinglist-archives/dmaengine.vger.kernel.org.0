Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DB1495F1C
	for <lists+dmaengine@lfdr.de>; Fri, 21 Jan 2022 13:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbiAUMlE (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Fri, 21 Jan 2022 07:41:04 -0500
Received: from mail-eopbgr30071.outbound.protection.outlook.com ([40.107.3.71]:1147
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245692AbiAUMlD (ORCPT <rfc822;dmaengine@vger.kernel.org>);
        Fri, 21 Jan 2022 07:41:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cR4O7HeS7nT/nqfSftfpFi5Tgd9xezauKT+ElfxpZT3HYMOs/lAw/e5ulEC0p2uVqnxFfDsuNFfyVsG3wnbqjuwB2YEEkuZZMyz69UhSNs5uJv0fnoa4D8uN0m3nVOVMVZHtFvlXxO0wEvD40E5dzjfBzSEsSjVFM21PUBhSMCZW9ASmGhV8nuxiU3rFfwM2We14UeAQljtQsaI9nVXSwc5zrddgck3qhnlY46O7/dujtgU1BcpganhhSv60PqweZgRPvHTyA405oh0EcEmYH9tDFBuSJNZYAYp9A0CrYcPrZTC6Uy2knwSnBLvFnwHNk8IFkp75bUHG8ik1M5esCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKVOQjsuj7n+T55JItu+NBWD5KT1hXcoVEShR9iZxCQ=;
 b=DmmH93TNUJJuyNFHaGkSX3+lEewGli2mkQKhAk24hPM03nDjcty7ewvYhpRavqhK3dbulsbBDlYU7tPiVcRkQx+SNxAj6Yc2Zg4iw/EGq2+LgvSedg8GBrrBGs0dGdohEefFh1Z2DkgEnFRiET7fJ9graE0N+hXR5Ww5AE0Mf0MleEe3dqtZeWAbVyiT9Zxj1ZbQK0QXQHWeCeiMR/z9QRzN0+H13xvaBYZm0MmPVd82yo+YU9WeD9n5nEZQUDrLlQ57ofzRGX+0ZIDMXUtll/wnZYKd0SnVv28X+cSyvxjiVCxjbNL0QxFAt2ri9tslDDPnwu+A/jzXBxc/YrJLqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=orolia.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKVOQjsuj7n+T55JItu+NBWD5KT1hXcoVEShR9iZxCQ=;
 b=dTV/LuLup3Viu2kbY+C46DdloA/Xhg7j6704EU7n61i2VpyhM2D+XSn7Hyo8ZXm6Ge0HsXeBProCbbrq+/C66f+l6M6rCeg9E/AKYZN3G9V/6rEpcLTrRROCkxySAfHUGPpbGNfDy33WBCabGW1vMOqC0ib4/WHK08vwBhd8fW8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=orolia.com;
Received: from PAXP251MB0319.EURP251.PROD.OUTLOOK.COM (2603:10a6:102:209::12)
 by AM9P251MB0206.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:3dc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.11; Fri, 21 Jan
 2022 12:41:01 +0000
Received: from PAXP251MB0319.EURP251.PROD.OUTLOOK.COM
 ([fe80::3c56:fcc7:ac2e:9c76]) by PAXP251MB0319.EURP251.PROD.OUTLOOK.COM
 ([fe80::3c56:fcc7:ac2e:9c76%6]) with mapi id 15.20.4909.008; Fri, 21 Jan 2022
 12:41:01 +0000
Date:   Fri, 21 Jan 2022 13:40:55 +0100
From:   Olivier Dautricourt <olivier.dautricourt@orolia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Stefan Roese <sr@denx.de>, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dmaengine@vger.kernel.org
Subject: Re: [PATCH] dmaengine: altera-msgdma: Remove useless DMA-32 fallback
 configuration
Message-ID: <YeqiPomFySvcl+FL@orolia.com>
References: <01058ada3a0dea207212182ca7525060a204f1e1.1642232423.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01058ada3a0dea207212182ca7525060a204f1e1.1642232423.git.christophe.jaillet@wanadoo.fr>
X-ClientProxiedBy: LO2P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::30) To PAXP251MB0319.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:102:209::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4bbc6d8e-ce67-4c36-0e52-08d9dcdb47bc
X-MS-TrafficTypeDiagnostic: AM9P251MB0206:EE_
X-Microsoft-Antispam-PRVS: <AM9P251MB0206481EE38C34F2DC5C6C998F5B9@AM9P251MB0206.EURP251.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YoJvRsvYXDhnETo1nOdxJyzZT+3mB1g+ysV+xiw7zNn8Y4J8PfBU/L7LsTdTIJXy63zEj/Y/kecAUAmTuCqFKq0clJo/o1bz4KyUQeq73dSVy/R1pBLnT5PNNglisMp03mZVJB18/oh344kH4Ixv3oZ6MBOqqWby28i8WRytwr6BMC/qlC+cZDhKKIdreyAaJ+XsnYFBz8kBoQyxElNwPHo7JAEfPOfIrgJGzhNhzF92Pb+L+18ziQN/Ukvkb/z/QOl17P6Cfsd7RLthe4MxH66F56TxIpDFQMneyyM0cQv9+d8TusF8Yv5sJZxBjpIx9MlrkfETdMaVt+HXXTsnHZojbhqdbfNway6fc7llKQ9OPJ1N45A3TbEOMtf01067SdIWna8f2M4f+ZcJUM9SyaKcgAYbAaN6AkXWK+3NMIQJ6tXKvquCliybHApeIQXMVpVjVYPVUQxHhIyOUDy45F8aEFd/67e5dem1G3O/BHTlmZ1mvSTE2okVDArB6dirc9MxQzYV+zzSXJExwEi372BAzpgT4CQv8EIUgIAzHUR0sgctXvIz4BEVLF0z+eU8DXwRFiRQczZKbIUoNkE+DUMX5trfFWWzBTXiKwlSeyLjnyvqj+4dRKeccoiGYmQtSYKaKyNR2sO+MmVCxIxt7qe6xzCTTr5umULCMU0mL2HdirLjMi4eZmCElaJbqwRI+j8MyViX5QThMbOoLtnKw3GnHqCGuZaYw50r9cINSbnAn+drXWcil5+w68100EjiDgGjJ/1QsBlkJURgkRXuIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXP251MB0319.EURP251.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(52116002)(66946007)(6506007)(508600001)(83380400001)(38100700002)(316002)(36756003)(966005)(4326008)(6666004)(66476007)(2616005)(54906003)(66556008)(6486002)(8676002)(6916009)(186003)(86362001)(2906002)(5660300002)(6512007)(8936002)(44832011)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QrJtIeadhbQbDvi7fLQ8nbPn2L2Ca/GrrL06/BqERhjO/Rw8T/X1Swh+/Qr9?=
 =?us-ascii?Q?u6/93T3C6AwjmkHPmVYqrtKOt5OZ59OMpFbTIWikg6t2GpgIpdz+Gt8QizVf?=
 =?us-ascii?Q?MoHv+w8qlB2B1Fx5Jndd9yF1F/ti2kRBSBLxJ3M3UYkGCfF3d2MQqjsROYDz?=
 =?us-ascii?Q?P9TNzB2R6j5VLnsDAnPa7GGHhI8NsBxviCyjONGCltGsGDIg7ED9AS04FzCD?=
 =?us-ascii?Q?Fd7VUmSqHVMtOBcr2ZnrNDaaHQQEvfXURTX/aunAmhrzFqXQJm4TH6+JZGso?=
 =?us-ascii?Q?Pj1lrWig5zPWzS9Zqh55PkBuPnZZrxELeBIPCUhgrepsnD6VFj262nRovbhT?=
 =?us-ascii?Q?NpKdr4cyANI1ej3VATpoBkSvyj6bakvG6Y2HeXGVdW/EhZRVR34RwBLzrMy2?=
 =?us-ascii?Q?ao1dGfVtw/u9/yNuq9NbDtQu/tFVGdSaQAdr//RbuHReSqNdv5uVdB1JvLG8?=
 =?us-ascii?Q?dZsQkgozfmajhU+Q9rocz1slvmQC4L7oq5jnFBpDNtsY4dJOrFVtI9K/nKSe?=
 =?us-ascii?Q?0cnOKRklta6AkoihVh0aRkkiu572EDQLbBIerHuGziB/MVfdgZCOG0ZGWdIF?=
 =?us-ascii?Q?8NClJdZp+oelEjFJERGFPoUPQDjAWtMWewBUElUwIFBuEHRXGK6GZ4FANnQa?=
 =?us-ascii?Q?AuKNt0fGHcqDq79GKihGxiDxYTQdOYrsWCQZD05tRIDfGTDsrZxB0CGH5/DH?=
 =?us-ascii?Q?HgkNAPT3bWhBirsRRfpdhpk548nXpbyqglkyOzjR2FJDQ6Ts4hwRckQ/KB+G?=
 =?us-ascii?Q?IKzv5lVc/gGA7q7bzmrts6A+odnbB8WD17BrmEJZOdaT/JEFnUgTcbEz2WDu?=
 =?us-ascii?Q?pe7nr19LXaw7BIY5fuhnO0sc89MG6IZXMUJ59uRRYJ+gq+35S2hrD4i3YHRa?=
 =?us-ascii?Q?lkf5OK8lsjCjH//KoqmgDjvwTPtvUCb67Lj0x/dUkpiyv7k9OrwbAuyp32lC?=
 =?us-ascii?Q?w6tQKyja6ZIcUgdFJdqo8hgo3CK+O7gTassQaFy/O7/Qv3iuWIeGa1k+0zU4?=
 =?us-ascii?Q?w/38qjFuqIQ6Vb0Ih63l6N0kt8NX+hiUxsvcV7r4YUP++9JYHs6wI8lI1ug+?=
 =?us-ascii?Q?Hs0Y26BI2NH5TbeU54bz1QrqfOGwx2uFBrYnhyPBGQTRk2PMeLqzOnvFIGxk?=
 =?us-ascii?Q?qvETsc/PvjFqVz1lwDPxlAB5AohzWhhobG1w2+vBK8YYsovgd3k9u/czVDP5?=
 =?us-ascii?Q?HJHna6K2d7TD6Vyyg4RTkfu63soN2u/i7dafvVsRmlR+oWiJl7WyK28GZ5fe?=
 =?us-ascii?Q?Q5oXKd5WXioTW8kQvkuXgvDn9zdvZhbcl0sf7ydhGemdqK/6wUBb+NlRe1Qf?=
 =?us-ascii?Q?jiI/dVk/LFvmMRBggCqMZXOHaya/nJ1WGA/+5eIK70/iZ5phxzKKQYcLJctn?=
 =?us-ascii?Q?P9JweXbCc8rOixSLHulg2Nnr5VLTR1upBYTToS6Xk5HKjcFhlVwMOHbX4Ng1?=
 =?us-ascii?Q?TNmq6K9By48ibm9WDJV3rQ88UuE8FeVnNPuwHD2pRF6dmoZ8fuCwlcfu09Hb?=
 =?us-ascii?Q?Gs0B/SM9kmKnreov+sSiVMpLDU92GT5KDMsDtbO6paMc6CxysdIJXsmEtPmo?=
 =?us-ascii?Q?OgaRbpPd+VzSaYLClG0zMScJusb56oFaaCSGLN9fDbJ0OFOCvcADIWMA+DPF?=
 =?us-ascii?Q?CxMpbvrUMXGM9Wxl2IjeHnIpAMl3ysOo5EoAjpX3TlsAZvjFzeagPn7r8vpu?=
 =?us-ascii?Q?atFPFRoHQXhwV1Tuq+SsxHy4H2B4GA8LoChBRJP9cNZyykDnOEMaXvRRROja?=
 =?us-ascii?Q?DBUpbwwfxg=3D=3D?=
X-OriginatorOrg: orolia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bbc6d8e-ce67-4c36-0e52-08d9dcdb47bc
X-MS-Exchange-CrossTenant-AuthSource: PAXP251MB0319.EURP251.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2022 12:41:01.0496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a263030c-9c1b-421f-9471-1dec0b29c664
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns7iyQ2+WsE2gIF8/fCbINDQgqhGuOOH32+FQjOvU7t7UrIGRoY8PCiDmWCYoIn8GWqfhH+8wPpkRPNqJdZv55D3mCvNr87WLTOcciZRvIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P251MB0206
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

The 01/15/2022 08:40, Christophe JAILLET wrote:
> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
> 
> Simplify code and remove some dead code accordingly.
> 
> [1]: https://lore.kernel.org/linux-kernel/YL3vSPK5DXTNvgdx@infradead.org/#t
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Olivier Dautricourt <olivier.dautricourt@orolia.com>

> ---
>  drivers/dma/altera-msgdma.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/altera-msgdma.c b/drivers/dma/altera-msgdma.c
> index f5b885d69cd3..6f56dfd375e3 100644
> --- a/drivers/dma/altera-msgdma.c
> +++ b/drivers/dma/altera-msgdma.c
> @@ -891,9 +891,7 @@ static int msgdma_probe(struct platform_device *pdev)
>         ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
>         if (ret) {
>                 dev_warn(&pdev->dev, "unable to set coherent mask to 64");
> -               ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -               if (ret)
> -                       goto fail;
> +               goto fail;
>         }
> 
>         msgdma_reset(mdev);
> --
> 2.32.0
> 

