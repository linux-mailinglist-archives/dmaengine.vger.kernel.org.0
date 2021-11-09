Return-Path: <dmaengine-owner@vger.kernel.org>
X-Original-To: lists+dmaengine@lfdr.de
Delivered-To: lists+dmaengine@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0C044AEA7
	for <lists+dmaengine@lfdr.de>; Tue,  9 Nov 2021 14:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbhKINY5 (ORCPT <rfc822;lists+dmaengine@lfdr.de>);
        Tue, 9 Nov 2021 08:24:57 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:27210 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229917AbhKINY4 (ORCPT
        <rfc822;dmaengine@vger.kernel.org>); Tue, 9 Nov 2021 08:24:56 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A9DK56t017410;
        Tue, 9 Nov 2021 13:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=YLc6YnX1K12jfKU8G+QgwkKEN+XiwiMuj531a6gptEs=;
 b=m9AO4mgNMDwAa4s5w9AzBsp2ktRV9pgfx+7RPiF0qlQlqij4K9lX9R2DPKrNiTbax7Dg
 xFJ38trVemLEcoiK4B5VmwnuBUjS0w+FVhF2BSwBX5WqQZMKu4IeMhTmw8QPo47RNwZt
 M6vVMA6yVqwmnJkcI/f9KtFNr6S7rbnrn9RzpIvinGlL1LJyu2J9OZe66sH+2PF1WYc0
 k8iwO1bkdiKUBrpdIrDMMwBgdrveaj2GQBXYsZvYvwo5JDzIQdizSVxrWwqbVr+eyY3I
 Je1Q0lYjWq8mLS6tpEMjjpQZ2yw3npRipuP5fj3okBQDJOcZQvMquUwrKYkyypRxBRI9 Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c6uh4jsrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 13:22:01 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A9DBOd8112567;
        Tue, 9 Nov 2021 13:21:59 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by userp3030.oracle.com with ESMTP id 3c5etvm4xr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Nov 2021 13:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R2N4f2E4Wyjt0ZFh6fw8U/gFN0S/opLU7O4jE5goIdDGwtDlQ0kj/CggXqjeK3E86G7Z6LU+vZdF3kJmO0KcrdQ3TPd8fOKwRvYrSldR43mHDQ3aMd64OZr7ZDGV0sxBh1bW/RZqcU/FpWBiUTXX4kG5ozP7IoHsmPmWZbWHvsQtCtaCiRT3vEV6G4TlwEiyYm32rAUxrITK0+JPxAWXRtm+CkpgqlxUtNc9y3pHq58LGIuMOwHu0p5kV7r7cyWjWialn/Uam5tRvY7F6hCJKUo0s8IT/Rcre4JoBaw0hiSXErkzWi0NanCTqyaE1MKblgfnSC6lp7ru4Xjk9VIj5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mh6TuxE4+/2ACkb+zqqOUDistpsqSNbyOzeOPzBBHuY=;
 b=dgYr9bchXztU5wh92Zqiaekd4xGirUnzDQwHxp3WQoPHH7vjtADmOOSONlDEBW2jwIm3V8XGhk0ZXQuDQ/DkWi/nOm+sASzuogoj1n42cBIBGwRRg0XyRrLIQZ/h/YA6gkGGg3T75FuaL/tg9jyw1hPXz4PQkUDopwhMzipeD24PXN6uj4u6Nl9pXCJtON4ryUad4GmekAQG86Rv/NEaDNqMULiOfmLbSGBuA3oVzMSl8R/iW0hdlX60X7GqEJUlfOZrUjTc/oHGyzsN8NYyfQ+N+bksM7oEXoNqPy4KGm9Ya9Ez8cmhqhLBq/vroQMrGzVLoIsLRIGrAyRXYDDvew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mh6TuxE4+/2ACkb+zqqOUDistpsqSNbyOzeOPzBBHuY=;
 b=dT6rBFO5ea+RQMv0lXA3NSDYcHTqQYktGAuj0mX1gJxONtoWNW5LGpB0HYJQLu6MGv2VHWpqVIa9+G28R0QMBhjxzVdDgfC/pAdd63l67rCaQ/kgKXBtGTfS7qiqgOk1EN8moOEJpGroE2i5dIiGFcF/in6LTdQPJCJs6+K9gQE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4436.namprd10.prod.outlook.com
 (2603:10b6:303:91::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Tue, 9 Nov
 2021 13:21:56 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4690.015; Tue, 9 Nov 2021
 13:21:56 +0000
Date:   Tue, 9 Nov 2021 16:21:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Qing Wang <wangqing@vivo.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kernel Janitors <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH V2] dma: dw-edma-pcie: switch from 'pci_' to 'dma_' API
Message-ID: <20211109132137.GK2001@kadam>
References: <1632800660-108761-1-git-send-email-wangqing@vivo.com>
 <e30467d0-55e0-156c-4eba-2838c22fe030@wanadoo.fr>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e30467d0-55e0-156c-4eba-2838c22fe030@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend Transport; Tue, 9 Nov 2021 13:21:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0faafbe9-bd2d-4f4d-ac0f-08d9a383e6e7
X-MS-TrafficTypeDiagnostic: CO1PR10MB4436:
X-Microsoft-Antispam-PRVS: <CO1PR10MB443652EEC202463DB277ADBC8E929@CO1PR10MB4436.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1IZwzCRv4PdjQ/eOWtRr4+DmTsqsQk2bm/xXVDhk1AmBzq46FRgCzwqaeNj9tyfQ5wWYMAd87y5emxyONuCOJGIg0FBLVmo+7Rf4LyVOEv7TcfsoUdiAHNpY1t3eQ51kyYm/9Xtom7ZY0TyWkQNDY7IkCFf6EPSsUlD+G9NqbK0R1pnr9ncTA2gCm9jHYxbaXyN7fB40JWLRAOSbEI8j/nuaunUFuL/TxRu9+7xAkbhUlvh/cUhk7Pq+tjVgR1VpF15ZiaCTkmpXutLhQoTXrNWoCFHkwPXD0BzMQIxXmcaQOIQHNRwyR3nYW57ovsVz+dfFgysgi64bdfQzoUEUhileKEdy4sRQlBPerWtewGTFJpq/K1oGAZ9O0JGESdhQFGtFfUK35vlXvaRgo/8psKCc+m5q109Mm3yjgDF3XDiABQnhK4T6yroZ1wC6MiCE5i+A4kr9bbPNLhS0OWzpikSfOP9AtqVTElhY12OHDNZQSifLsi3wNiDKCUkh/ZcQwR5WYSyNc8IQ0NhPdCs3Alui3/XOENwKC7+7NBhYyoVkciVIjT7nFsK2WHl+kxvLsObyugRigFqBx2BxwI61uoOwDPMhTCCjY2AB8wJAsY/P2QF7vt6WHMS+hUL8O/VOIvQwGUvkWWHWCY8CRDPdUeEsRq9qIpsDaT35o+t1u3WQpYB7FJNBxinunf9Jtkfv8/czD38L9taPsuLYcojwCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(9686003)(6666004)(956004)(33716001)(66556008)(55016002)(54906003)(66946007)(1076003)(4326008)(2906002)(44832011)(38100700002)(186003)(508600001)(5660300002)(86362001)(9576002)(52116002)(83380400001)(6496006)(33656002)(6916009)(8936002)(8676002)(26005)(316002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?I4Nsc3t0asr5r+2m76/LrliGRVdNvyemxS2eb6yynOPpGGk5pnmd1lCdXj?=
 =?iso-8859-1?Q?DMRBOnWe/RtSQ3X1RKX6K9nUMSVuTYz58Ob9yb/klg7OzkN8iVbX9h3K5h?=
 =?iso-8859-1?Q?L1NOXBtjAfirKS98Pk6BrWqCwwGHluAywrquVPYespkWsDD6onUmKE7Qvw?=
 =?iso-8859-1?Q?f9wMNBPS5jkymn9mUxGg3fcG0uxR6uzlkMEEWsUnvHE3GwmtyK2K6bUIzI?=
 =?iso-8859-1?Q?AwUQ9V0RwIG0wBZw0Qvk/s36WHXZF1Ynjvk+SFqm+Zqa3JpyZsPmEIp4iV?=
 =?iso-8859-1?Q?Eq/AG665iWaR7v4ovAWTiVmixD4nHIXiV7qPsPVBeQ9oZHMXgqV7d/yhAI?=
 =?iso-8859-1?Q?LJbrL5QAwSY03JoxxVzvBpJuXTdU/S0Rm2yj7b7sSMy5hMxImx8jqu7nq4?=
 =?iso-8859-1?Q?kWpcoGzTkBs+tUMbqdrhKDuR2cjdCRmvBflqfv5AGQQBId39ZxIQIDNV+L?=
 =?iso-8859-1?Q?y/CdOtY5hjCgmGgP4iONldVugSCxirSNwWR0rbQImBPlch7BMakBMeKyFP?=
 =?iso-8859-1?Q?TB2jqAL17IZSyv9Gu9npZ9bKNMG7qJOIgocaleXJIP1o7MBDeFHc19wr1A?=
 =?iso-8859-1?Q?0b4fgz5km3LgVIq7XHh3NxlspVSBdZz1qGNhTeCQQCvGJYkfoEZmI4KQQZ?=
 =?iso-8859-1?Q?NyRXyH7EPyQrOGUSdHSqGwtRVg+unZmFqV8OXyXZaU0a4M416jEl3DZa+q?=
 =?iso-8859-1?Q?4KiwKVkyhgCBzDm2LrEf9WPgHB2MR0JT0wvCKditwZmHwKJ4y4OkvgVskT?=
 =?iso-8859-1?Q?6sPRdYtZz24XdV+GPud2BFhM/vNJrMtWCfK+iDWM24f/CZjat4l2vCAc2u?=
 =?iso-8859-1?Q?VLSbm89sULfl1IVLL2I04guCz1Y9NXWkulRGkV9iEgxYSw9OYNjuTbe2yd?=
 =?iso-8859-1?Q?pJzsUwme85S9m0k7IWPG8enmBoZ0qMcMoC3/IP2jfg2hh7JoUpVzvQrEHg?=
 =?iso-8859-1?Q?NSJBYtkbWmOQusJc6TH4QHvTXiN48x89ZClBH1kQNu9VJ6JoOf/E17HkL4?=
 =?iso-8859-1?Q?qP+2BRx8Z0uXCBHL12VJqaJc4nf8F9mUZOpyQkWApOfsB+oshAz4c3Ay/3?=
 =?iso-8859-1?Q?+qLnXrVw5D49V7GDG9Ivx+e8yL4L7lKypO9VGx3cnw/YhxmIOriWSouLn8?=
 =?iso-8859-1?Q?Xfd2Y0t0fAFhggJXl5DmGAN2tTfdPepbQ6pG7kw/14V3A3OoD/LtuCblFX?=
 =?iso-8859-1?Q?VfToxyhJ3xTyr6J0pUNDI47YB6v/Q7hfUgsqrrQh1SC5htgnFz9m1Fal07?=
 =?iso-8859-1?Q?CM7Uc4d1MlK9zrK5bbyZd8qNrkP9cmCUFyu8QDBunGkx8wU+AgLlNJBh/Z?=
 =?iso-8859-1?Q?5HfNWJ3/b4y8kmz662vfe5zQsn4b6DvAkkc8P6UU30f5NthtiErIEsGyps?=
 =?iso-8859-1?Q?4cVjWGIoAFfs3afg4uNQStvnLiFQr6ZRQT1MMyfVqGvbgSOpI4cbG5/7D+?=
 =?iso-8859-1?Q?/LLfMp4Envx2xqJ/ZhzJBScdwwyYNoeW8nlzYhcNA7ZEMwkt7sefBUHRxb?=
 =?iso-8859-1?Q?YcGsrFLxc8Y0v9RzNU5D3riV91tTvS32cJ5DJBUsQaRDwUYLhBJ0oMqRV2?=
 =?iso-8859-1?Q?RVAVNXIsSD4Lc68kdXgSBp1k3ml70T+c26A4kFzcEaobfPrVfXeMFrr/7m?=
 =?iso-8859-1?Q?NrcH/4ga+XSEd5y2r68K6ZfiJyHW/12Wx7+1YheRK4gBnGEZcEWNS2ay1f?=
 =?iso-8859-1?Q?tqgIO6Wh37FyXg4RC7Da6PtcPMHG17mYdYOTxAmrLvGmS4Vd+hC4eMGVuK?=
 =?iso-8859-1?Q?IdYB9QzHhmqBO4aU5mgaoRbJo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0faafbe9-bd2d-4f4d-ac0f-08d9a383e6e7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2021 13:21:56.6387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NR9C6THuz6EMu0/WhCI2pQlOpoiWiarTmPR/jGEici1/6flGDR65JxOhTcLJ7TwiwPF/0csunuATuhRdfu1r9wMZHT+87k6zVgIfQ4OSCKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10162 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2111090081
X-Proofpoint-ORIG-GUID: UQFzk68uYbkLdy3VA5Oq-dLgwhMUJcye
X-Proofpoint-GUID: UQFzk68uYbkLdy3VA5Oq-dLgwhMUJcye
Precedence: bulk
List-ID: <dmaengine.vger.kernel.org>
X-Mailing-List: dmaengine@vger.kernel.org

On Tue, Nov 02, 2021 at 08:05:53PM +0100, Christophe JAILLET wrote:
> Hi,
> 
> 
> Le 28/09/2021 à 05:44, Qing Wang a écrit :
> > From: Wang Qing <wangqing@vivo.com>
> > 
> > The wrappers in include/linux/pci-dma-compat.h should go away.
> > 
> > The patch has been generated with the coccinelle script below.
> > expression e1, e2;
> > @@
> > -    pci_set_dma_mask(e1, e2)
> > +    dma_set_mask(&e1->dev, e2)
> > 
> > @@
> > expression e1, e2;
> > @@
> > -    pci_set_consistent_dma_mask(e1, e2)
> > +    dma_set_coherent_mask(&e1->dev, e2)
> > 
> > While at it, some 'dma_set_mask()/dma_set_coherent_mask()' have been
> > updated to a much less verbose 'dma_set_mask_and_coherent()'.
> > 
> > Signed-off-by: Wang Qing <wangqing@vivo.com>
> > ---
> >   drivers/dma/dw-edma/dw-edma-pcie.c | 17 ++++-------------
> >   1 file changed, 4 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
> > index 44f6e09..198f6cd
> > --- a/drivers/dma/dw-edma/dw-edma-pcie.c
> > +++ b/drivers/dma/dw-edma/dw-edma-pcie.c
> > @@ -186,27 +186,18 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
> >   	pci_set_master(pdev);
> >   	/* DMA configuration */
> > -	err = pci_set_dma_mask(pdev, DMA_BIT_MASK(64));
> > +	err = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> >   	if (!err) {
> if err = 0, so if no error...
> 
> > -		err = pci_set_consistent_dma_mask(pdev, DMA_BIT_MASK(64));
> > -		if (err) {
> > -			pci_err(pdev, "consistent DMA mask 64 set failed\n");
> > -			return err;
> > -		}
> > +		pci_err(pdev, "DMA mask 64 set failed\n");
> > +		return err;
> ... we log an error, return success but don't perform the last steps of the
> probe.

I have an unpublished Smatch check for these:

drivers/dma/dw-edma/dw-edma-pcie.c:192 dw_edma_pcie_probe() info: return a literal instead of 'err'

The idea of the Smatch check is that it's pretty easy to get "if (!ret)"
and "if (ret)" transposed.  It would show up in testing, of course, but
the truth is that maintainers don't always have all the hardware they
maintain.

And the other idea is that "return 0;" is always more readable and
intentional than "return ret;" where ret is zero.

Anyway, is someone going to fix these?

regards,
dan carpenter

